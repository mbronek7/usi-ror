// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import ImageSlider from "react-image-comparison-slider";

const Slider = props => (
  <div style={{ width: 700, height: 450 }}>
    <ImageSlider
      image1={props.img_before}
      image2={props.img_after}
      sliderWidth={3}
      sliderColor="green"
      handleColor="green"
      handleBackgroundColor="white"
    />
  </div>
)

Slider.defaultProps = {
  img_before: 'https://images.unsplash.com/photo-1448375240586-882707db888b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2550&q=80',
  img_after: 'https://images.unsplash.com/photo-1448375240586-882707db888b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2550&q=80'
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Slider />,
    document.body.appendChild(document.createElement('div')),
  )
})
