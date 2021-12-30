Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9DA481D92
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 16:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhL3PIO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 30 Dec 2021 10:08:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52054 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhL3PIO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 10:08:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E40BC61693;
        Thu, 30 Dec 2021 15:08:13 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A56F9C36AE9;
        Thu, 30 Dec 2021 15:08:10 +0000 (UTC)
Date:   Thu, 30 Dec 2021 15:13:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 0/3] Add support for LTC2688
Message-ID: <20211230151357.6c7dea0d@jic23-huawei>
In-Reply-To: <20211214165608.7903-1-nuno.sa@analog.com>
References: <20211214165608.7903-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 14 Dec 2021 17:56:05 +0100
Nuno Sá <nuno.sa@analog.com> wrote:

> The ABI defined for this driver has some subtleties that were previously
> discussed in this RFC [1]. This might not be the final state but,
> hopefully, we are close to it:
> 
> toggle mode channels:
> 
>  * out_voltageY_toggle_en
>  * out_voltageY_raw1
>  * out_voltageY_symbol
> 
> dither mode channels:
> 
>  * out_voltageY_dither_en
>  * out_voltageY_dither_raw
>  * out_voltageY_dither_raw_available
>  * out_voltageY_dither_frequency
>  * out_voltageY_dither_frequency_available
>  * out_voltageY_dither_phase
>  * out_voltageY_dither_phase_available
> 
> Default channels won't have any of the above ABIs. A channel is toggle
> capable if the devicetree 'adi,toggle-mode' flag is set. For dither, the
> assumption is more silent. If 'adi,toggle-mode' is not given and a
> channel is associated with a TGPx pin through 'adi,toggle-dither-input',
> then the channel is assumed to be dither capable (there's no point in
> having a dither capable channel without an input clock).
> 
> There are some stuff where I'm still not 100% convinced though:
> 
> 1. out_voltageY_dither_raw refers to the dither amplitude. There are some
> differences but in essence, the same scale as the raw attr applies. That
> is not true for the offset as it's always 0. This is stated in the ABI
> file and being an amplitude is more or less obvious. However, I'm not
> sure if it's still valuable to have an ut_voltageY_dither_offset?

I think if we have out_voltageY_offset then we should have
out_voltageY_dither_offset to avoid any potential confusion + appropriate
ABI docs text to make it clear that that the more specific _offset takes
precedence.  I have some vague recollection we had a debate about a similar
case in the past where we had
in_voltageX_offset that covered lots of channels and in_voltage99_offset
(number made up) that just happened to be different.  Not sure any
driver takes advantage of ABI perhaps allowing (not sure it's written down)
a more specific attribute to override a generic one...

> 
> 2. For now, if 'adi,toggle-dither-input' is given, a correspondent clock
> as to be given as well. While this makes sense for dither channels, I'm
> not so sure for toggle ones. I can easily see a toggled channel being
> controlled by, for example, an host GPIO.

I agree.  But I think we can relax this when needed rather than it being
necessary to allow for more complex toggle conditions from the start.
Generating a clock driven set of voltages is probably a common usecase
for toggle mode so fine to just support that one until another usecase
comes along.

> 
> 3. Dither capable channels are being silently "assumed" by the driver.
> Not sure if an "adi,mode" dt property would make sense. Having this
> explicitly could make it easier to express some dependencies in the
> bindings file.

I kind of like the assumed default of toggle if the pin is wired up, but
if you prefer an explicit control it becomes a question of whether
Rob (and maybe others) think the binding is sane or not.

> 
> 4. For now the clocks property is not part of the channels object.
> The reason for this is that we only have 3 possible clocks for 16
> channels so I wanted to avoid getting and enabling the same clock more
> than once. But that is not really an issue and together with 3) it
> could, again, make it easier to express some dependencies in the bindings
> file. That said, I'm pending in doing this property a channel one (as it
> truly is) unless I get feedback otherwise.

Interesting question on how to do this.  Maybe a questions where Rob's
input would be particularly useful.  Likely to be similar cases somewhere
else from a dt-binding point of view.

Jonathan

> 
> [1]: https://marc.info/?l=linux-iio&m=163662843603265&w=2
> 
> Nuno Sá (3):
>   iio: dac: add support for ltc2688
>   iio: ABI: add ABI file for the LTC2688 DAC
>   dt-bindings: iio: Add ltc2688 documentation
> 
>  .../ABI/testing/sysfs-bus-iio-dac-ltc2688     |   67 +
>  .../bindings/iio/dac/adi,ltc2688.yaml         |  146 +++
>  MAINTAINERS                                   |    9 +
>  drivers/iio/dac/Kconfig                       |   11 +
>  drivers/iio/dac/Makefile                      |    1 +
>  drivers/iio/dac/ltc2688.c                     | 1081 +++++++++++++++++
>  6 files changed, 1315 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
>  create mode 100644 drivers/iio/dac/ltc2688.c
> 

