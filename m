Return-Path: <linux-iio+bounces-25834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC53C2B000
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 11:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6AFF1884B8A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18A32FD7C3;
	Mon,  3 Nov 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JER0xask"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79292E62A2
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165198; cv=none; b=lzonSwddo4He+ai1z1RLB+SCBhnr9tx5X97MY05ymrotPQTIdtmyCUeBGLqYW+q7T0SqmLAgCUhn2aARytmLxHf7ZkQ04JX6ib/WWjjJvi8dFeVF40ROcjVMV8eVngeyHm0gQi9tFl9vRv0FmO+0YV26CevgPGXazY+iJnxkRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165198; c=relaxed/simple;
	bh=Wf8STBfHE0J+NlBplrg4R1B7QWjmStwS584DhC+bjTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKo4iXKaEaXj+7tTFESLkNwhgsSfrJUMHFOInrFpBI08ncGNOxql8ZJgIGdFjjnljOz4YPzxdLJo8Oywn2JVKKUo/H6R+EEEkhQTamGFEp11GwHKZrxDq2ZjgoVwX+/rh3jQMn0npBuePjbH3wRA+g9hP8vng0d1572MeT8zyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JER0xask; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so7123368a12.3
        for <linux-iio@vger.kernel.org>; Mon, 03 Nov 2025 02:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762165194; x=1762769994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GsT5oIN0IsxJt31wWSSeO6UUH61mEwUZvtvJIlXOG5Y=;
        b=JER0xasknWyIIMyXLZ/7MfBTD0Q+oK98SQ8OfmLDzCiB+YKe9qKE5vg8KxB7ErcWjq
         qH0uRC9oRWvj0E/cuctwl9gBurVfKejphnewYXVGdUBkpvYxtaKxkzHa0S1qoa5foErT
         5CK3mjNLfowJri/hCpeST5wKAZQkxlv9dLXcCL4bVTNkAFtAG5Y2dtPHqLkc/y8cQBOU
         G1buPUQ1B/VsTTTOFT/AauH+hFbWpQPMf9XxcCLsKsRLrdeOAsJbYjo1Tiq9/cKQU8Ya
         SO8xXWKBg3++STgpObLCsYHgxZ+cby5r1WzbZbSrWavOTYicD1kq1fNaFnaVc9LH2ODm
         uCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165194; x=1762769994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsT5oIN0IsxJt31wWSSeO6UUH61mEwUZvtvJIlXOG5Y=;
        b=WN21BhqcQ9ys3/K27jj1BAl/Ym3aTkGQMtd9rWkwl0JRXrAawN+IuSS7LKMBhMNhU0
         vFXNP159xItBRlo8rJMGrfAWGQ+9LxYCHv5ap8qcGCwtYM7cA5Gcxtgi6C2W/mmABt/9
         QQv65xHyjpu4BDLl2jfH3+IrUx6RcsB6Q0iAh/MFv791uvQ8ZaYPtaRJbTugE74eJfzz
         qD0FszUvLJOnk7a4sMjbBVqsxcVx62yahXO7Ltv7iruDr+f0+n1Al40Q1hdNCRNGiIvQ
         x9RiLt76ohEA1fbx6pvucPT+YHyhHr12mASiEuU0/t0OXW4Is2c0fa5AXAhpkW5bGmPS
         cg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU93m6EyeQYe5UOgzjT6mhQ26dWQNoQ5+95QSZF+1uA5EddaeQKxii4ojqvY9ReLvz010z97V2Qn8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRgrgERFl2E0IDB44eIgHODkryP7RmkN+GVrbOxDlvPYVTAyE
	ah71PJVhX227vFtN61jzMm9EhlMk7vQk4oZQ4PAm9IoznMb5h2QRuvTF
X-Gm-Gg: ASbGnctWH/wkcsLcYXQrWmMab1MapR2wYFfjWp/yezLse5BhxLEHnekecEKrmNMLgFj
	4zEwgSVU4DRsbjtmy8PHjaD+RJtPEpweCby8uc29QJi0g47Wkc4Z7e7BWft75razkh9fbU1Qz1E
	d6+cKb+mxz/NFiJh0yr1f2nIOGpecQF/fdfMoKjEGeyvPMypfxz3W42gDpQVi3lvIZrTftjp/SS
	T8VmiPQgkHagqPK//Ody+ohcNKJcO8evQA38SLoxR4nhDTu7SA5284PiV4Xv0TMxuZJC5kSch2x
	3K72GHqgvB+VNLlAVnSigJMMcpR0JS4NZrM5nFpG0o2G2/msY3oc0W9Op6h/dg8ni/jERKK/z4I
	KqEZ8Scqg9azHelEU1yKmzitqfMD0S3BRI/FOvpPKuzrFQFkZ90j+Q8g5M0Wi0m6lJw5D0aL42K
	OZVAzjTL2TLblh4kgOEyvxjRVUaNXsK5rZ8C52fPbn6K6P9TPvFD3PZvSktw==
X-Google-Smtp-Source: AGHT+IHW8TVfhDD9H9SKiNPijSWOxisr60SHomuOVeq9GVIqU5LeyEg3fnM+15Xzt8icYA3gvS38JA==
X-Received: by 2002:a05:6402:848:b0:640:c062:8bca with SMTP id 4fb4d7f45d1cf-640c0628f7cmr2158653a12.18.1762165193950;
        Mon, 03 Nov 2025 02:19:53 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3033:267:fba0:684c:28ec:7a00:209c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b392d5dsm9426455a12.15.2025.11.03.02.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:19:53 -0800 (PST)
Date: Mon, 3 Nov 2025 11:19:50 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/7] docs: iio: New docs for ad4062 driver
Message-ID: <6zxwgpdz6zz3owrr5h277otv4b3gbbc47amgatkyatjdv2ruqv@kgsekg6utqqc>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-2-0f8ce7fef50c@analog.com>
 <20251018162113.002d92f7@jic23-huawei>
 <skcjf6tdo7bktdx4g2bm42gkzd5vdtckxsxzgu7s6dwmiwfdpw@hxhol4g4adcs>
 <20251102123727.0aa4c031@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102123727.0aa4c031@jic23-huawei>

On Sun, Nov 02, 2025 at 12:37:27PM +0000, Jonathan Cameron wrote:
> On Tue, 28 Oct 2025 16:31:46 +0100
> Jorge Marques <gastmaier@gmail.com> wrote:
> 
> > On Sat, Oct 18, 2025 at 04:21:13PM +0100, Jonathan Cameron wrote:
> > > On Mon, 13 Oct 2025 09:28:00 +0200
> > > Jorge Marques <jorge.marques@analog.com> wrote:
> > >   
> > > > This adds a new page to document how to use the ad4062 ADC driver.
> > > > 
> > > > Signed-off-by: Jorge Marques <jorge.marques@analog.com>  
> > > Hi Jorge,
> > > 
> > > Various comments inline.
> > > 
> > > Thanks,
> > > 
> > > Jonathan
> > >   
> > 
> > Hi Jonathan,
> > 
> > > > ---
> > > >  Documentation/iio/ad4062.rst | 89 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  MAINTAINERS                  |  1 +
> > > >  2 files changed, 90 insertions(+)
> > > > 
> > > > diff --git a/Documentation/iio/ad4062.rst b/Documentation/iio/ad4062.rst
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..b486d7fe1916d2963c94581be3696cf58d51ca48
> > > > --- /dev/null
> > > > +++ b/Documentation/iio/ad4062.rst
> > > > @@ -0,0 +1,89 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0-only
> > > > +
> > > > +=============
> > > > +AD4062 driver
> > > > +=============
> > > > +
> > > > +ADC driver for Analog Devices Inc. AD4060/AD4062 devices. The module name is
> > > > +``ad4062``.
> > > > +
> > > > +Supported devices
> > > > +=================
> > > > +
> > > > +The following chips are supported by this driver:
> > > > +
> > > > +* `AD4060 <https://www.analog.com/AD4060>`_
> > > > +* `AD4062 <https://www.analog.com/AD4062>`_
> > > > +
> > > > +Wiring modes
> > > > +============
> > > > +
> > > > +The ADC is interfaced through an I3C bus, and contains two programmable GPIOs.  
> > > This raises a question on whether it makes sense for the binding to support providing
> > > gpios from the start (as alternative to interrupts).  Seems like the two pins
> > > are completely interchangeable so one might well be 'left' for use by some other
> > > device that needs a gpio pin.
> > > 
> > > I don't mind that much if we want to leave the binding support for that for later
> > > but in the ideal case we'd have it from the start (even if the driver doesn't
> > > support it until we have a user).  
> > 
> > Yep, they are almost interchangeable except GP0 cannot be DEV_DRY (device is
> > ready to accept serial interface communications). The question is how to
> > represent that in the devicetree.
> > 
> > I am ok with adding `gpio-controller` as an optional property. If
> > present, and if the gp0/1 is not taken by the interrupt-names property,
> > it fallback to expose as a gpo0 (they cannot be set as gpi).
> > 
> > For the other roles, based on
> > https://elixir.bootlin.com/linux/v6.18-rc3/source/Documentation/devicetree/bindings/hwmon/adi,ltc4282.yaml#L109
> > We would have
> > 
> >   adi,gp0-mode = "dev-en";
> >   adi,gp1-mode = "rdy";
> > 
> > Some examples:
> > 
> >   // gp0: threshold-either (default), gp1: data ready (default)
> >   adc@0,2ee007c0000 {
> >       reg = <0x0 0x2ee 0x7c0000>;
> >       vdd-supply = <&vdd>;
> >       vio-supply = <&vio>;
> >       ref-supply = <&ref>;
> > 
> >       interrupt-parent = <&gpio>;
> >       interrupts = <0 0 IRQ_TYPE_EDGE_RISING>,
> >                    <0 1 IRQ_TYPE_EDGE_FALLING>;
> >       interrupt-names = "gp0", "gp1";
> >   };
> > 
> >   // gp0: user GPO, gp1: data ready
> >   adc@0,2ee007c0000 {
> >       reg = <0x0 0x2ee 0x7c0000>;
> >       vdd-supply = <&vdd>;
> >       vio-supply = <&vio>;
> >       ref-supply = <&ref>;
> > 
> >       gpio-controller;
> > 
> >       interrupt-parent = <&gpio>;
> >       interrupts = <0 1 IRQ_TYPE_EDGE_FALLING>;
> >       interrupt-names = "gp1";
> >   };
> > 
> >   // gp0: threshold crossed high value, g1: unused
> >   adc@0,2ee007c0000 {
> >       reg = <0x0 0x2ee 0x7c0000>;
> >       vdd-supply = <&vdd>;
> >       vio-supply = <&vio>;
> >       ref-supply = <&ref>;
> > 
> >       interrupt-parent = <&gpio>;
> >       interrupts = <0 0 IRQ_TYPE_EDGE_FALLING>;
> >       interrupt-names = "gp0";
> > 
> >       adi,gp0-mode = "thresh-high"
> >   };
> > 
> > 
> > And the driver constraints the valid configurations.
> 

Hi Jonathan,

A comment on the gpio modes and sampling frequency.
Ack on `raw * _scale`.

> More or less looks good  We have other drivers effectively doing this.
> Whether we actively handle the final case or not in driver probably doesn't matter.
> Wtihout the gpio-controller specified nothing can use the gpios anyway so
> if we support them they simply won't get used.
> 
> I'm not sure on the gpi0-mode though.  Why is that useful? That feels like
> a choice the driver should make dependent on what is available to it.
> So if we've specified it is in interrupt, only the modes that might be
> an interrupt are available to the driver.
> 
> The only case I can see being useful is dev_en as that's a specifically timed
> control signal for the analog front end.
> 
> So a specific flag for that probably makes sense - I'm not sure if we'd
> ever have an AFE where it would make sense to drive it from a hardware
> signal on the ADC like this one AND from a gpio, so I don't think we need
> to support binding this as a gpio in that case.
> 

So, by default gp0 is set threshold-either, and gp1 data ready.
The `adi,gp*-mode` would be useful to invert for example, have gp0 as
data ready and gp1 as threshold-either.

On the threshold, there are 3 different crossings:
* either: the reading crosses either the upper or lower boundary.
* max: crosses the upper boundary.
* min: crosses the lower boundary.

To not make the `adi,gp*-mode` attribute necessary I can:
* make the driver set either, max, min roles based on the
  values written to the IIO attributes, e.g. writing -1 for
  IIO_EV_INFO_HYSTERESIS, or a max/min value high/low enough?
* dev_en use case is to shutdown/turn-on an AFE, amplifiers,
  but I wouldn't support in this series.

So, I believe the solution for the dt-binding is add the optional
`gpio-controller`, and if set, expose the unused (not in the
interrupts-names) as GPOutput. And not support inversion gp0<->gp1 of
the mode, the specific threshold crossing (max, min, either), nor the
dev_en use case.

This then doesn't change the series much, just appends a commit adding
the gpio-controller support.

> > 
> > >   
> > > > +
> > > > +The ADC convert-start happens on the SDA rising edge of the I3C stop (P) bit
> > > > +at the end of the read command.
> > > > +
> > > > +The two programmable GPIOS are optional and have a role assigned if present in
> > > > +the devicetree:
> > > > +
> > > > +- GP1: Is assigned the role of Data Ready signal.  
> > > 
> > > I assume that's only the case if GP1 is provided?  If GP0 is the only one
> > > we should allow use that for data ready.  As long as the DT allows that it is
> > > permissible for the driver to not do so for now.
> > >   
> > 
> > Suggested `adi,gp*-mode` should solve.
> > 
> > > > +
> > > > +Device attributes
> > > > +=================
> > > > +
> > > > +The ADC contains only one channel with following attributes:
> > > > +
> > > > +.. list-table:: Channel attributes
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Attribute
> > > > +     - Description
> > > > +   * - ``in_voltage_calibscale``
> > > > +     - Sets the scale factor to multiply the raw value.  
> > > That's confusing.  This should be hardware 'tweak' to compensate for
> > > calibration or similar.  The text doesn't make it clear where that multiply
> > > is happening. Sounds too much like _scale.  
> > 
> > The user does raw * _scale * _calibscale to get the value in volts.
> 
> That's not ABI compliant so no general purpose user space is going to do that.
> So a hard no for this being what userspace needs to apply.
> 
> I'm not particularly keen on calibscale for things other than tweaking so
> that raw * _scale is in milivolts.
> 
> Normally if we have other forms of controllable scaling it's a question
> of wrapping up any such scan factors into a writeable _scale.
> 

Ack, will update to raw * _scale, embedding the _calibscale into the
_scale value.

> > 
> > _calibscale is 1 by default and serves two purposes:
> > 
> > * small hw corrections (matches ABI); or 
> > * an arbitrary user set scale, ideally also for corrections, but not
> >   constrained.
> > 
> > For the prior, the device does support computing the appropriate
> > _calibscale value, but it is not implemented.
> > 
> > If it was implemented, it would occur once during driver initialization
> > and then _calibscale default value would be approximately 1, (e.g.,
> > 0.997).
> > 
> > >   
> > > > +   * - ``in_voltage_oversampling_ratio``
> > > > +     - Sets device's burst averaging mode to over sample using the
> > > > +       internal sample rate. Value 1 disable the burst averaging mode.
> > > > +   * - ``in_voltage_oversampling_ratio_available``
> > > > +     - List of available oversampling values.
> > > > +   * - ``in_voltage_raw``
> > > > +     - Returns the raw ADC voltage value.
> > > > +   * - ``in_voltage_scale``
> > > > +     - Returs the channel scale in reference to the reference voltage  
> > > 
> > > Spell check needed.  Also this describes why it might take different values
> > > but not the bit users care about which is the standard ABI thing of
> > > Real value in mV = _raw * _scale 
> > >   
> > Ack, will describe
> > 
> >  raw * _scale * _calibscale
> 
> As above, no to this.  It must be just raw * _scale.
> 

Ack.

> > 
> > > > +       ``ref-supply``.
> > > > +
> > > > +Also contain the following device attributes:
> > > > +
> > > > +.. list-table:: Device attributes
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Attribute
> > > > +     - Description
> > > > +   * - ``samling_frequency``  
> > > 
> > > Check these.. sampling_frequency.
> > >   
> > > > +     - Sets the sets the device internal sample rate, used in the burst
> > > > +       averaging mode.  
> > > 
> > > It's not use otherwise?  That's unusual ABI.  I'd expect it to give
> > > the right value at least when burst mode isn't used. Or is burst mode
> > > the only way we do buffered capture?
> > >   
> > 
> > It is not used otherwise, the device internal sample rate is used only
> > to evenly distribute readings used in the burst averaging mode.
> > There is no sampling trigger to evenly space the adc conversion reading,
> 
> In event of no internal trigger, sampling_frequency is normally
> 1/duration of a single scan (or sample if a per channel attribute).
> 
> 

The duration of a single scan (duration between the convert-start high
edge until RDY falling edge), would be ((n_avg - 1) / fosc + tconv)
(datasheet fig.56, p.31) , where fosc is the internal timer frequency
directly exposed in this series. I can make the driver use this formula,
just setting it will be less straight forward, since currently a clear
enum of the values the register supports is returned by the
sampling_frequency_available attribute. Instead, it will scale based on
the number of samples per burst (averaging ratio/n_avg). tconv is typ
270ns and max 320ns.

> > e.g.,:
> > 
> >   Oversampling 4, sampling ratio 2Hz
> >   Sampling trigger |        |        |        |        |
> >   ADC conversion   ++++     ++++     ++++     ++++     ++++
> >   ADC data ready      *        *        *        *        *
> > 
> >   Oversampling 4, sampling ratio 1Hz
> >   Sampling trigger |        |        |        |        |
> >   ADC conversion   + + + +  + + + +  + + + +  + + + +  + + + +
> >   ADC data ready         *        *        *        *        *
> > 
> > For this driver, the sampling trigger is a register access (the stop bit
> > of the i3c transfer to be exact), so in buffer mode it reads as fast as
> > possible.
> > 
> > > > +   * - ``sampling_frequency_available``
> > > > +     - Lists the available device internal sample rates.
> > > > +
> > > > +Interrupts
> > > > +==========
> > > > +
> > > > +The interrupts are mapped through the ``interrupt-names`` and ``interrupts``
> > > > +properties.
> > > > +
> > > > +The ``interrupt-names`` ``gp1`` entry sets the role of Data Ready signal.
> > > > +If it is not present, the driver fallback to enabling the same role as an
> > > > +I3C IBI.  
> > > 
> > > It feels like it should be easy to use the other GPO pin in this case if that
> > > is present. 
> > >   
> > adi-gp0-mode should solve.
> > 
> > I wouldn't auto-set the mode by the position in the interrupt-names
> > array, but let me know your opinion.
> 
> Mode when multiple are equally valid (for a given device wiring)
> is purely down to what the driver wants to do. There is no benefit in
> encoding that in dt.
> Thanks,
> 
> Jonathan
> 

Best Regards,
Jorge

