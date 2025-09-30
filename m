Return-Path: <linux-iio+bounces-24599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3BABAE4F6
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 20:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57664322A0B
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4422777E0;
	Tue, 30 Sep 2025 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMLaSrmS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3D23D7FC;
	Tue, 30 Sep 2025 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256816; cv=none; b=MFPmZ/RwxrQYpMaV2cp+r7eQLEI6sAB0+TQYCVGkJvqoI9oIHGcpF2hZQM0ze5Oy2qEok23dGYaH5G4+J5XSrYZ7lAcbKhHty0mS6mMK1YFx42i73DhT6yuuEJB4eZvr68cpgGRXuzytpQBicX4R22M2o1BzyE++aAkTxI37aTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256816; c=relaxed/simple;
	bh=E/QqzLM1dJKl3TqhG6oibfqFGBbJ6iFctfatXWQEwvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKK+Y1+GjT8X4OlgRabiQIW9XBzziQifFh3E9WKeywlnekqBVYBKvZehwHFZWWJHzHuq3zKrMYRQSCg5rUSInz53ZTQnKLm0MtxJYAzePxY+nkNKJIoDTiF2vB6iApgBpOHLihV2JEFhScjUBWwpxVhKCHSOoOSKvyt00ZhAnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMLaSrmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D986AC4CEF0;
	Tue, 30 Sep 2025 18:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759256816;
	bh=E/QqzLM1dJKl3TqhG6oibfqFGBbJ6iFctfatXWQEwvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMLaSrmSlO2kX7lNz2UpdN/hn5XHGhQsK3yuZWYb2dzTxRehqgX5Gj/jv7OmZagjB
	 548pwmvPIbGDRmB6LEoLBt7gEkS/9lrinOpfwngWBhKj/dp0BChpHObZvEi639aD1K
	 RyzRu044YmCOpcM4Zpp83lLvr/hktxqJqcNzLYGD3M08VrwWySbCXUPpqVohiTOQNi
	 awS5EhFtnv1cJWSEK/VYQ52FSRBrM38iBuLbxDfJcTWG1MGRv/2T8B6hCuhO+bZaCd
	 rPs3n1q9CiPWIARZ9JlsKkhLWC/c/kt90cFInetUAD4p28NmfuLhPxUVURHJw+mvNr
	 FY4h9C/ehKV5g==
Date: Tue, 30 Sep 2025 13:26:49 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	marcelo.schmitt1@gmail.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20250930182649.GA3340740-robh@kernel.org>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
 <5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
 <20250928111955.175680cb@jic23-huawei>
 <20250929143132.GA4099970-robh@kernel.org>
 <CAMknhBHzXLjkbKAjkgRwEps=0YrOgUcdvRpuPRrcPkwfwWo88w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBHzXLjkbKAjkgRwEps=0YrOgUcdvRpuPRrcPkwfwWo88w@mail.gmail.com>

On Mon, Sep 29, 2025 at 06:16:10PM +0200, David Lechner wrote:
> On Mon, Sep 29, 2025 at 4:31 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Sep 28, 2025 at 11:19:55AM +0100, Jonathan Cameron wrote:
> > > On Fri, 26 Sep 2025 17:40:47 -0300
> > > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> > >
> > > > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> > > > PGA (programmable gain amplifier) that scales the input signal prior to it
> > > > reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> > > > and A1) that set one of four possible signal gain configurations.
> > > >
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > ---
> > > > Change log v2 -> v3
> > > > - PGA gain now described in decibels.
> > > >
> > > > The PGA gain is not going to fit well as a channel property because it may
> > > > affect more than one channel as in AD7191.
> > > > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> > > >
> > > > I consulted a very trustworthy source [1, 2] and learned that describing signal
> > > > gains in decibels is a common practice. I now think it would be ideal to describe
> > > > these PGA and PGA-like gains with properties in decibel units and this patch
> > > > is an attempt of doing so. The only problem with this approach is that we end up
> > > > with negative values when the gain is lower than 1 (the signal is attenuated)
> > > > and device tree specification doesn't support signed integer types. As the
> > > > docs being proposed fail dt_binding_check, I guess I have to nack the patch myself.
> > > > Any chance of dt specification eventually support signed integers?
> > > > Any suggestions appreciated.
> > > >
> > > > [1] https://en.wikipedia.org/wiki/Decibel
> > > > [2] https://en.wikipedia.org/wiki/Gain_(electronics)
> > >
> > > I still wonder if the better way to describe this is to ignore that it
> > > has anything to do with PGA as such and instead describe the pin strapping.
> > >
> > > DT folk, is there an existing way to do that? My grep skills are failing to
> > > spot one.
> > >
> > > We've papered over this for a long time in various IIO drivers by controlling
> > > directly what the pin strap controls with weird and wonderful device specific
> > > bindings. I wonder if we can't have a gpio driver + binding that rejects all
> > > config and just lets us check the current state of an output pin.  Kind of a
> > > fixed mode regulator equivalent for gpios.
> >
> > If these are connected to GPIOs, isn't it possible that someone will
> > want to change their value?
> >
> > Other than some generic 'pinstrap-gpios' property, I don't see what we'd
> > do here? I don't feel like pin strapping GPIOs is something that we see
> > all that often.
> >
> > Rob
> 
> I think the idea is that it is not actually a GPIO, just a hard-wired
> connection. We would want to have a "fixed-gpios" to describe these
> hard-wired connections as GPIOs so that we don't have to write complex
> binding for chip config GPIOs. I've seen configuration pins like on at
> least half a dozed of the ADCs I've been working on/reviewing over the
> last two years (since I got involved in IIO again).

Until I read the example, I totally missed what you want here...

Can you point me to some existing bindings?

IIRC, Linus has expressed not caring for cases of using GPIO API on 
things that are not GPIOs. That was more like registers which can 
read the state of signals. Better let him weigh in before we go too far 
down this path.

> 
> For example, there might be 4 mode pins, so we would like to just have
> a mode-gpios property. So this could be all 4 connected to GPIOs, all
> 4 hard-wired, or a mix.
> 
> (The actual bindings would need more thought, but this should give the
> general idea)
> 
> fixed_gpio: hard-wires {
>     compatible = "fixed-gpios";
>     gpio-controller;
>     #gpio-cells = <1>;
> };
> 
> gpio0: gpio-controller@4000000 {
>     compatible = "vendor,soc-gpios";
>     gpio-controller;
>     #gpio-cells = <2>;
> };
> 
> spi {
>     adc@0 {
>         compatible = "vendor,adc";
>         /* All gpios */
>         mode-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>,
>                      <&gpio0 1 GPIO_ACTIVE_HIGH>,
>                      <&gpio0 2 GPIO_ACTIVE_HIGH>,
>                      <&gpio0 3 GPIO_ACTIVE_HIGH>;
>          /* or all hard-wired */
>         mode-gpios = <&fixed_gpio 0 GPIO_FIXED_HIGH>,
>                      <&fixed_gpio GPIO_FIXED_HIGH>,
>                      <&fixed_gpio GPIO_FIXED_LOW>,
>                      <&fixed_gpio GPIO_FIXED_LOW>;
>          /* or mixed */
>         mode-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>,
>                      <&gpio0 1 GPIO_ACTIVE_HIGH>,
>                      <&fixed_gpio GPIO_FIXED_LOW>,
>                      <&fixed_gpio GPIO_FIXED_LOW>;

The above seems reasonable to me.

Just to throw out an alternative, phandle values of 0 and -1 are 
generally reserved. Historically that means just skip the entry. 
However, you could use that and do something like this:

mode-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>,
             <&gpio0 1 GPIO_ACTIVE_HIGH>,
             <0>,
             <0xffffffff>;

So 0 means low and ~0 means high. The only advantage I see with it is 
you don't need a "fixed-gpios" driver. Also, I'm not sure how that would 
work with requesting GPIOs given you've essentially defined only 2 GPIO 
lines (high and low). Though Bartosz is doing some work on non-exclusive 
GPIOs.

Rob


