Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5AA320A3F
	for <lists+linux-iio@lfdr.de>; Sun, 21 Feb 2021 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhBUM1e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Feb 2021 07:27:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUM1e (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Feb 2021 07:27:34 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BB264EB2;
        Sun, 21 Feb 2021 12:26:51 +0000 (UTC)
Date:   Sun, 21 Feb 2021 12:26:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Ekin =?UTF-8?B?QsO2a2U=?= <ekin_boke@arcelik.com>,
        linux-iio@vger.kernel.org
Subject: Re: Control Register device tree binding request for Opt3001
Message-ID: <20210221122647.5bbbe19c@archlinux>
In-Reply-To: <4e0b8e47a2644d304b2d1e6b2e087136@kernel.wtf>
References: <AM9PR08MB6083269425D1057113B212709B859@AM9PR08MB6083.eurprd08.prod.outlook.com>
        <CA+U=DspfyuxyhPfPrGDaU5nDQVaO5p3ha-5hwpzVX69p1P60WA@mail.gmail.com>
        <20210218121502.00002014@Huawei.com>
        <4e0b8e47a2644d304b2d1e6b2e087136@kernel.wtf>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Feb 2021 15:38:15 +0300
Cengiz Can <cengiz@kernel.wtf> wrote:

> Hello Jonathan, Alexandru and Ekin
> 
> On 2021-02-18 15:15, Jonathan Cameron wrote:
> > 
> > As described, what you want to control here is policy, not a 
> > characteristic
> > of the hardware.   Normally we don't use DT to make such decisions, as 
> > it should
> > be controlled at runtime.  
> 
> I'm by no means an expert on sensors and I don't fully understand the 
> distinction
> of policy vs characteristic in this context.
> 
> Can you clarify a bit?

It's a slightly blurred boundary, but to give some examples:

Characterstics - dependent on device, not where the device is
being used and mostly even what it is being used for.
- Wiring things - power supplies etc.
- Voltage limits etc (stuff that can damage hardware).
- Calibration parameter reflecting thing like plastic on top of a sensor.
- Proximity limits on devices intended to detect if a person is
  near enough to a wifi antenna that we should reduce the power output.
  (this one is an edge condition as it is assuming a 'usecase' but it
   the value is based on the physical device).

Policy - stuff dependent on what sensor is being used for at a particular
point in time.
* Sensitivity levels / integration times etc - if you are in a dark environment
  then these would ideally be set different to an outdoor usecase. Same device
  may well move between these places.
* Thresholds that aren't a 'physical thing'.  So stuff you'd expect to have
  a userspace control for.

> 
> For example, many TFT drivers allow maximum-minimum brightness values in 
> devicetree
> and even set a default brightness value. Totally within the specs of 
> vendor of course.

I'd guess they would have some connection to what actually makes sense
for a given physical device incorporating the TFT?  Perhaps above the
max brightness screen always unreadable under all lighting conditions.

Also note that for DT bindings a lot of stuff was added back before there
was particularly good review or tight control of what was acceptable and
what was not.  As we have to support bindings that are already in
the field, we can't rip that stuff out.  We can avoid adding more though.

> 
> Since this is just a hardware register that can be changed, and possibly 
> never to be
> modified (depending on the use case of course) during runtime, I would 
> like to be able
> to set it once during initialization and forget about it.

It's that question of usecase.  There may well be devices that are only
ever used outside for example and hence need only one of the settings, but
it definitely isn't a common situation.

Whilst the amount of code needed to support this is small, there is
still a maintenance burden and a userspace script should be sufficient.

> 
> Currently I have a oneshot systemd unit that echo's my desired 
> integration value and
> I think that's a bit late for my application. (even with all the 
> priority and orderings set).

I'm not sure I understand how doing it in systemd is too late?
It should be possible to ensure that it happens early enough
to support any userspace application.

Jonathan

> 
> > 
> > So basically what Alex said :)
> > 
> > Jonathan
> >   
> 
> Thank you
> 

