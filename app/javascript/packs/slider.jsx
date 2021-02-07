// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { ReactCompareSlider, ReactCompareSliderImage } from 'react-compare-slider';

import img_before from "../stylesheets/images/before.jpg";
import img_after from "../stylesheets/images/after.jpg";

const Slider = props => (
  <div className="container mx-auto flex flex-col px-5 py-24 justify-center items-center">
    <ReactCompareSlider
    itemOne={<ReactCompareSliderImage src={detection_frame.dataset.before || img_before} alt="Image one" />}
    itemTwo={<ReactCompareSliderImage src={detection_frame.dataset.after ||img_after}  alt="Image two" />}
    />
  </div>
)

Slider.defaultProps = {
  img_before: img_before,
  img_after: img_after
}

document.addEventListener('DOMContentLoaded', () => {
  const detection_frame = document.querySelector('#detection_frame')
  ReactDOM.render(<Slider />, detection_frame)
})
