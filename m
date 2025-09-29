Return-Path: <linux-iio+bounces-24556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F24B5BA995F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF6D7A2A3F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5AA309DB1;
	Mon, 29 Sep 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybofpbcx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A91DD543;
	Mon, 29 Sep 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156294; cv=none; b=C3TwVRyJgwxMlFHzahc3NO3DPE1DBCH9zhO/whpeSw0XxKEzE/1bitNigQpBgukinygeevNvaPm+OtToXO7EJSAn0ALRvE5XNVMUH5nMiKFO8N8mS5bRBNaKOX38ge2z2oDghZ/g+zWgkh6Yp/kUwO1QzLwDgjN4nApZSq6XWC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156294; c=relaxed/simple;
	bh=sKuqKNpE5dhMtZf1zaC2ZqjURpyd3C7l8Ef/qH3un8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/WpLQQAY2VhIgq05GZw/Y5gWPTcD50VG9tKgVWCj9VSMe47LRQ4pPcHW7qa+Ymgbzt0AeqeqnysAAevuinVnpYfLSO5ovUaLudG3N+dsCkGTdx4yLYa4b58I73iZgL6lduSgbMgnROmvHM62Am3hddILF/UFsJMpIwp4REagP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ybofpbcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AE4C4CEF4;
	Mon, 29 Sep 2025 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759156293;
	bh=sKuqKNpE5dhMtZf1zaC2ZqjURpyd3C7l8Ef/qH3un8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ybofpbcx+ejkNvAv75607kTZIE8CUsY9qhrXc/yrJ9X2bu9eV4OnGXQ3TNrOD/y2P
	 ZTx2iK+hamBmIKKHDaVWhoOTCftImvcznOCK+7AEffOegIkND9rMYBhjXJdQX1r1ZL
	 0JZPrZuBsBi3OkjiTPDsLn7YSdXtt3i13qbb2sqBLpmyWZ+oVdhkzjg1wkMuDpihUy
	 6H4hKACxj53QRJs6VTVZG6utz4nyFWuKrwYhNjvjyPwNTkosbGPUWq/6n6pcvlANgh
	 fQ2kDFeXinDxHted7Q2+zz5VDaq8aUMue0z6xZZqc8r3t6Teq5PIR23t0f4AHQZWzI
	 MmqWDPc+OcTRw==
Date: Mon, 29 Sep 2025 09:31:32 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	marcelo.schmitt1@gmail.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20250929143132.GA4099970-robh@kernel.org>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
 <5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
 <20250928111955.175680cb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928111955.175680cb@jic23-huawei>

On Sun, Sep 28, 2025 at 11:19:55AM +0100, Jonathan Cameron wrote:
> On Fri, 26 Sep 2025 17:40:47 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> > PGA (programmable gain amplifier) that scales the input signal prior to it
> > reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> > and A1) that set one of four possible signal gain configurations.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Change log v2 -> v3
> > - PGA gain now described in decibels.
> > 
> > The PGA gain is not going to fit well as a channel property because it may
> > affect more than one channel as in AD7191.
> > https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> > 
> > I consulted a very trustworthy source [1, 2] and learned that describing signal
> > gains in decibels is a common practice. I now think it would be ideal to describe
> > these PGA and PGA-like gains with properties in decibel units and this patch
> > is an attempt of doing so. The only problem with this approach is that we end up
> > with negative values when the gain is lower than 1 (the signal is attenuated)
> > and device tree specification doesn't support signed integer types. As the
> > docs being proposed fail dt_binding_check, I guess I have to nack the patch myself.
> > Any chance of dt specification eventually support signed integers?
> > Any suggestions appreciated.
> > 
> > [1] https://en.wikipedia.org/wiki/Decibel
> > [2] https://en.wikipedia.org/wiki/Gain_(electronics)
> 
> I still wonder if the better way to describe this is to ignore that it
> has anything to do with PGA as such and instead describe the pin strapping.
> 
> DT folk, is there an existing way to do that? My grep skills are failing to
> spot one.
> 
> We've papered over this for a long time in various IIO drivers by controlling
> directly what the pin strap controls with weird and wonderful device specific
> bindings. I wonder if we can't have a gpio driver + binding that rejects all
> config and just lets us check the current state of an output pin.  Kind of a
> fixed mode regulator equivalent for gpios.

If these are connected to GPIOs, isn't it possible that someone will 
want to change their value?

Other than some generic 'pinstrap-gpios' property, I don't see what we'd 
do here? I don't feel like pin strapping GPIOs is something that we see 
all that often.

Rob

