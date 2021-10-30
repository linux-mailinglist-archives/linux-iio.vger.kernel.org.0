Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EC5440A09
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhJ3PwM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 11:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231995AbhJ3PwM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Oct 2021 11:52:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAB1260E8C;
        Sat, 30 Oct 2021 15:49:38 +0000 (UTC)
Date:   Sat, 30 Oct 2021 16:54:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: addac: add AD74413R driver
Message-ID: <20211030165406.149b9036@jic23-huawei>
In-Reply-To: <CAA+onPPObFeXQwJ450M=5Ue3uE6Cui0M0X49qgn_U1D6su=BcA@mail.gmail.com>
References: <20211028134849.3664969-1-demonsingur@gmail.com>
        <20211028134849.3664969-3-demonsingur@gmail.com>
        <20211028165847.4baa8566@jic23-huawei>
        <CAA+onPPObFeXQwJ450M=5Ue3uE6Cui0M0X49qgn_U1D6su=BcA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

@Linus, some gpio related discussion below...

On Fri, 29 Oct 2021 00:38:31 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

Too much context removed. I had to go back and look earlier in the thread
to work out what was being discussed.  Particularly as I think these aren't
even in order!

> > Often these are 1/(N**2) rather than 1/(N**2 - 1) as here.
> > Noise level is probably high enough this doesn't really matter though.
> > Data sheets are never entirely clear if ranges are inclusive or not...  
> 
> My max values are defined as being inclusive.
> On a 13bit DAC, raw values are in the range of 0 to 2**13 - 1, inclusive.
> 
OK

> > Rule it out in the dt binding and enforce it at probe time not here which  
> is far too late.
> > As below, this should be prevented at probe time not runtime.  
> 
> This is done so that the GPIO indices are kept the same as the hardware
> channels, 0, 1, 2, 3.
> Depending on their mode, some GPIOs can only be read and some of them can
> only be written to.
> I'm not sure how you would want to do this at probe time?

I'm not totally following, but took more a look at the datasheet.

Device has 4 GPO pins whch is fine.  Those are simple output only pins. For
those, if they are in a mode where you are controlling them then you can
cache the value - if they are in comparator mode then they aren't really
acting as GPIO pins at all the value you are reading is reflecting the
input on the other side of the device on a different pin. So in that
case don't register these with the GPIO subsystem at all.
Instead you are registering channels selected from A,B,C,D 

> 
> Logic parallel mode is reserved for set_multiple, when the GPIO is in logic
> mode.
So, it took me a while to understand what we would loose by 'only' providing
the logic parallel mode.  If we only had logic high / logic low as the options
then a sensible driver option would be to map any GPO configuration to the
logic parallel mode.  It enables more functionality.  However, that got me thinking
for why we had high impedance and 100kOhms as options.

These allow you to implement shared buses over these pins.  Which incidentally
should probably be mapped through to the various gpio subsystem controls
to reflect these options.

So the state combinations you might well have would be...

Logic low / logic high
100kOhm pull down / logic high (something like an i2c bus would use this)
tristate so logic low / logic high / high impedance.(don't care or off)

Other than the first one, these require you to not be in the GPO mode.

However, this is all stuff that depends on what these are wired to - so the
dts should reflect that rather than simply setting the mode to one of

+          0 - GPO_CONFIG_100K_PULL_DOWN
+          1 - GPO_CONFIG_LOGIC
+          3 - GPO_CONFIG_DEBOUNCED_COMPARATOR
+          4 - GPO_CONFIG_HIGH_IMPEDANCE

The only exception being the debounce comparator. So the question is where
would that be wired to?

> GPIOs are referred to as GPO in the datasheet, so I used this name in the
> driver too.

Sort of... As above, the output pins are GPO, the input pins are the ones
the comparator is running on - whilst there value is relected on the outputs
when in the right mode (and that's the only one you can read them in) they
are not the same channel.  I'm not sure they should map to the same index...

> 
> > Error out of this function is fine, but why not just leave this channel  
> disabled
> rather than failing to probe which I think is what will currently happen?
> 
> Sure, I could make invalid channel and gpo functions fallback to default
> function.
> But why tolerate errors in the dts configuration?

I don't think it is an error but rather a function you haven't enabled yet
in a specific driver.  dts is for the hardware, not your particular driver.

Mind you, I think the binding around this needs to change entirely anyway
so this will probably not end up relevant.

Jonathan


