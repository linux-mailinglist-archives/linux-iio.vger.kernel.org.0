Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3685D44EB13
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 17:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhKLQMo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 12 Nov 2021 11:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232458AbhKLQMo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Nov 2021 11:12:44 -0500
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9D560F5B;
        Fri, 12 Nov 2021 16:09:52 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:14:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] LTC2688 support
Message-ID: <20211112161437.60dbc872@jic23-huawei>
In-Reply-To: <20211111110043.101891-1-nuno.sa@analog.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Nov 2021 12:00:42 +0100
Nuno Sá <nuno.sa@analog.com> wrote:

Hi Nuno,

> The reason why this is a RFC is because I'm still waiting for proper HW
> to test this thing. The reason why I'm sending this already is because
> there's some non usual features which might require extra ABI. Hence,
> while waiting I thought we could already speed up the process in regards
> with the ABI.

Wise move as this is an unusual beast :)

> 
> I still pushed the driver but the intent here is not really to review it.
> Naturally, if someone already wants to give some feedback, that's very
> much appreciated :)

> 
> Now, there are three main interfaces depending on the channel mode:
>  1) default (no new ABI)
>  2) toggle mode
>  3) dither mode
> 
> The channel mode will be a devicetree property as it does not really
> make much sense to change between modes at runtime even more because the
> piece of HW we might want to control with a channel might be different
> depending on the selected mode (I'm fairly sure on this between toggle
> and other modes but not so sure between dither and default mode).

I agree on toggle vs dither definitely being different, but normal you
could implement either as software toggle, or dither with a 0 magnitude
sine wave.  So might not be worth implementing default mode at all.
No harm in doing so though if there are advantages to having it.

> 
> toggle mode special ABI:
> 
>  * Toggle operation enables fast switching of a DAC output between two
> different DAC codes without any SPI transaction. Two codes are set in
> input_a and input_b and then the output switches according to an input
> signal (input_a -> clk high; input_b -> clk low).
> 
> out_voltageY_input_register
>  - selects between input_a and input_b. After selecting one register, we
>    can write the dac code in out_voltageY_raw.
> out_voltageY_toggle_en
>  - Disable/Enable toggle mode. The reason why I think this one is
>    important is because if we wanna change the 2 codes, we should first
>    disable this, set the codes and only then enable the mode back...
>    As I'm writing this, It kind of came to me that we can probably
>    achieve this with out_voltageY_powerdown attr (maybe takes a bit more
>    time to see the outputs but...)

Hmm. These corner cases always take a bit of figuring out.  What you have
here is a bit 'device specific' for my liking.

So there is precedence for ABI in this area, on the frequency devices but only
for devices we still haven't moved out of staging.  For those we needed a means
to define selectable phases for PSK - where the selection was either software or,
much like here, a selection pin.
 
out_altvotage0_phase0 etc

so I guess the equivalent here would be
out_voltageY_raw0
out_voltageY_raw1
and the selection would be via something like
out_voltageY_symbol (0 or 1 in this case). - note this is only
relevant if you have the software toggle. Any enable needed for setting
can be done as part of the write sequence for the  raw0 / raw1 and should
ideally not be exposed to userspace (controls that require manual sequencing
tend to be hard to use / document).

However, I'm not 100% sure it really maps to this case.  What do you think?

I'm not sure if whether a channel is in toggle mode is a circuit thing or not..
(and hence DT or userspace control?)
Can see that even in a case where you did want to use external controls to
pick the values, you might also want to override from software...
Given there is a software toggle I guess we can use that as override.
Actually that raises the question of what the point in having normal mode is?
Can we just implement that as a software toggle toggle mode? One less thing to
worry about if we can.

There is also the question of whether selection of which toggle pin is used
should be a dt thing or a userspace control...

> 
> dither mode special ABI:
> 
>  * Dither operation adds a small sinusoidal wave to the digital DAC
> signal path. Dithering is a signal processing technique that involves
> the injection of ac noise to the signal path to reduce system
> nonlinearities.
> 

This is a complex feature to describe as (if I read it correctly) we have
a dither clocked from an external pin, or in theory from software. That clock
frequency must match the dither.  Realistically that means it is a clock
in our control or we have to match the period below to the frequency of that
clock.

> out_voltage0_dither_en
>  - Same as in toggle mode.
> out_voltage0_dither_period
> out_voltage0_dither_phase
>  - Period and phase of the signal. Only some values are valid so there's
>    also *_available files for these. I'm not sure if we can use the more
>    generic IIO_CHAN_INFO_PHASE and IIO_CHAN_INFO_FREQUENCY here as these
>    parameters don't really apply to the channel output signal..

Possibly not helpful to do so, but you could describe the channel as an
out_altvoltage channel that happens to have a significant offset (the DC
level) and phase, frequency etc as for a normal altvoltage channel.

That would hide the intention here though so perhaps not a good plan
even if it ensures we end up with standard ABI.

> out_voltage0_input_register
>  - Same as in toggle mode. However in this mode the code set in the
>    input_b register has a special meaning. It's the amplitude of the
>    dither signal.
Don't do that - provide a direct attribute representing the value of
register_b and when it is written implicitly switch to the right register.
Any ABI that requires a sequence of events is hard to use.


> 
> One special mention to the dac scale. In this part this is something
> that can be purely controlled by SW so that I'm allowing userspace to
> change it rather then having it in dts. The available scales are:
> 
> * [0 5V] -> offset 0
> * [0 10V] -> offset 0
> * [-5 5V] -> offset -32678
> * [-10 10V] -> offset -32768
> * [-15 15V] -> offset -32768
> 
> With the above, we also need to have the offset configurable and right
> now I'm going to some trouble to make sure the scale + offset is
> something valid. Honestly, I think I'm overdoing it because things can
> still go wrong with [0 10V] and [-5 5V] as the scales are the same
> here. Furthermore, there's no real arm that can be done to the HW. Is
> just that the readings won't match with what someone might be expecting.
> My plan is to just remove those checks and assume is up to userspace to
> make it right and not have [-10 10V] scale with 0 offset for example.

So this is something we've debated a few times in the past.
There is a fairly strong argument for output devices that the range is
a characteristic of the circuit.  At the very least it makes sense to
restrict it in DT even if we allow safe forms of tweaking in the driver.
For an initial driver, I'd just have it in DT.

Jonathan


> 
> I know that I'm taking a shortcut here :) so if you prefer to only
> discuss this in the __real__ series, I totally get it.

It's a fine short cut to take - I send out RFCs all the time for similar
open questions!

Jonathan

> 
> https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2688.pdf
> 
> - Nuno Sá
> 
> Nuno Sá (1):
>   iio: dac: add support for ltc2688
> 
>  drivers/iio/dac/ltc2688.c | 995 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 995 insertions(+)
>  create mode 100644 drivers/iio/dac/ltc2688.c
> 

