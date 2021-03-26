Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6222C34A663
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 12:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCZLVl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 07:21:41 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:44258 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCZLVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 07:21:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 5C2409E0088;
        Fri, 26 Mar 2021 11:21:12 +0000 (GMT)
Date:   Fri, 26 Mar 2021 11:21:17 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Mugil Raj <dmugil2000@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, dragos.bogdan@analog.com
Subject: Re: [RFC] GSoC'21 IIO project: Mugil
Message-ID: <20210326112056.50950fb6@jic23-huawei>
In-Reply-To: <CAOgtOjMw0UDhOgXU=HY=+kUhVU+Ya_N=Mvxj-cA_gvj-r9HwuQ@mail.gmail.com>
References: <CAOgtOjMw0UDhOgXU=HY=+kUhVU+Ya_N=Mvxj-cA_gvj-r9HwuQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021 15:20:52 +0530
Mugil Raj <dmugil2000@gmail.com> wrote:

> Hello All,
> 
> [Dragos here you have a quick intro about me if you want,
> https://lore.kernel.org/linux-iio/CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com/]
> 
> For GSoC'21 IIO project I would like to choose  AD4695/AD4696 device
> for implementing the driver.
> I referred Analog Device, Inc.'s page that lists all drivers and
> their kernel tree, but there is no existence of any compatible drivers
> for this component.
> 
> About AD4695:
> - 16-Channel, 16-bit 500 kSPS SAR ADC
> - "Recommended for New Designs" phase
> - SPI digital output
> - Datasheet in [1]
> - Product overview in [2]
> 
> Is there any other factor I should consider before choosing a component
> to make a driver for? Do I go ahead with AD4695  in my
> proposal? 

Obviously Dragos and others may have other opinions / knowledge of this part, but
form a quick look at the datasheet it seems like a good balance of complexity
vs simplicity of device.  Easy to start with basic operation then work
towards enabling some of the fancy features later :)

> If yes, are there any recommendations/suggestions you'd like
> to provide for a beginner indulging in making a kernel driver for such a
> component?

See if you can find another driver that looks fairly similar. Whist there
check other ADI drivers to make sure it's not so similar that you should
just add the part to some other driver.

Make sure you understand how SPI works in general + how the kernel
subsystem works.  Make a plan for which features you will implement in
each stage.  Whilst I'm more than happy to receive really quite complex
drivers in one go, for someone starting out it is much better to do
it step by step.  Obviously review etc takes time, so you can be well
into step 2 whilst step 1 is under reviews, but that's better than discovering
there was a problem in step 1 when you are on step 10!

Also once you get started, get very familiar with git and how to use
it to keep coherent patch sets at all times. That means getting familiar
with interactive rebasing, editing the history etc + if you like
them the various somewhat visual tools (I'm a great fan if tig but that
might be because a lot of the time my only connection to dev machines
is via an ssh terminal ;).
Those tricks make it a lot easier to update earlier parts of your work and
just have the newer stuff carry on working.  It's a vital part of working in the
mainline kernel as reviews / discussions can be 'slow'. I for one mostly
catch up with outstanding review at weekends as I never find a long enough
quiet period during the week (too many meeting :(

Good luck and keep asking questions if you get stuck.

Jonathan
> 
> Thanks,
> Mugil
> 
> [1] https://www.analog.com/media/en/technical-documentation/data-sheets/ad4695_4696.pdf
> [2] https://www.analog.com/en/products/ad4695.html#product-overview

