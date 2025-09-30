Return-Path: <linux-iio+bounces-24585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80258BAD40D
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AF9482593
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C84306496;
	Tue, 30 Sep 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGKwN4Wq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B8304BB2
	for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243595; cv=none; b=a2T6hxkox5ib4lmP0B6UDdd5i+MV/wDQklxpCjnlwjjOToaLgDI3LWlxPEUZEaSF+KQj6Es7QXt5CvmvHckvVu8qAt93sVaybVRBvCJIQhgaAY48PnFb/wXLmYoR9bTCUauNIjY6Z7Omt3gaEkhL5JM2KmqRx3+7zFatTMYRNr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243595; c=relaxed/simple;
	bh=O3iw2GxXiVKzNYOYE/ZVyGls0+ofp0SaOBPPWCbl0uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqegOeE2L7BEJNxMRhw8yaBc/0r8TQi5Z93RNThJMkt0ydOD0nDU3bugS8kSVYz0TDfqaM+2snl0D9dyz1XW0d98q0BReiUg3LnIyzWmW7y9TSEBLnbQd+svEirYa47T4EXXUISil28ItMQB6e4/qQ6WGdJ4BwJhutrUxos7PqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGKwN4Wq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3306eb96da1so4931164a91.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2025 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759243593; x=1759848393; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gtl9s1x2Ex8u74sVxDhnBYLads9LLhbmtzGZjSOpUpQ=;
        b=jGKwN4Wqr04Uw3I/UPpwk2A6wvL/X4rgbF4N+0eT9v8tTV2rXSRLKKyvAr2Opx+Tmf
         Go+jxVBArXWirMiKTsK/THViLlbZrSPd9mgGT+IR2M1pNqz9pdSobv3jVB265vlRnlcD
         /bYYTtV7rEIDn0Tu8o5m7gAOarMTs94ggrQhiQmDCOScO9U5nuzwCibbwAWhM/9lWyvV
         vgwzIt2/sP4S8T9JVsrne3J0KC6bGCOW2G7/hQ0ZhIoCFy0q4d1DQdEzrUQxT1a2WJDU
         36o39lVvpCvfkPNhEydtYt17ePNplFALyQpOe6lbDtBVIwviikaT2PRlaR769tmaMUap
         Uq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243593; x=1759848393;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtl9s1x2Ex8u74sVxDhnBYLads9LLhbmtzGZjSOpUpQ=;
        b=XfGXK0VJ+G3qDqrzezQrljMGiiQbo4bnkYo4jdfQrkxPZ2giDfqxIFGyWbxUsfNZ+K
         t9KHxeTJPjzB33Z5ICsIczitmJyn7c9qs6z+0uEZ/pA7EIGOCFUbP49WgRN9raxrMbcz
         37Lnu2cVv+bbd9PbAWALRX019sjY0nuvUdso3mTVC0TdY59OVtjFlww5NP5Z/WX+VqvU
         BFFTg6+87dD0JQdra5zO1ytYGxc5yu+Nh10yekWS1uYNHSLTjclnHKkuYjQ2eS+tkIXG
         3XBPrxUmETfi+KRUxSOFrq5KPHsa1idyPg4uYC7olqutBwwFOa6gI7iNw0E20o5SryF1
         nM/w==
X-Forwarded-Encrypted: i=1; AJvYcCU7zvLM/Gj0IODE082aVvzVdqDSCjQ9FMil1mwMJV5Zej8Nk+ZTb/Nb60ri5rtaR1nsIsfR0k04nAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8u02QUi1oHQRGvQR0VOlQ8U5Wq2CntTJybED87nm8CqH+QXe
	a8K3lAB2Omdpiu57SQx2wcGZdEUzvaJf6SYY75BQwz2VbK/OEDMQL74Q
X-Gm-Gg: ASbGncs4NZXWOSMrIRlTH50ZWUOQ6zXjWS1aTFqXxCHEJ0U4Rgv/zmdm9lOJzMLrHYO
	DrKIgopQQnuey7FdOfdGiEwPurZ/a9fFcPM1DoTyC3y8bUvLg1Yw6rtSeDv7G0jLC5YACrO95t5
	hKcMiM9tEyshKu4FdDVOxJcR8mTmpEhJk0/I6QVvEGWjH90Sf9CxoqOTTMdIqokU+FjRAv9j3Tp
	+KorF6ZVhs4gmkf57lxQXAalOSXKgme+T+6lpEIOYiKCnKZOaxwuYCA2GwDrWwCG8GrPNtKbiWy
	VS4g2RX95n0TXIbFMPg5CDYM6Yl6bVl85ILc0JsQI8um+MAQYafkWElLv8tXcBIDj2uFW/ffa1k
	uxyjYMM8Lg/ezcHXqLxWjbQwGE9JiUcBAjbfNehJ5BO3ttis4xPteLZU=
X-Google-Smtp-Source: AGHT+IE4hgKlPjRv6CQsulSHO7uaJxWorIuNklCjzaMiGW9OXkndROA3boKX4qKvwUjuv370Yq7hzQ==
X-Received: by 2002:a17:90b:1647:b0:330:7a32:3290 with SMTP id 98e67ed59e1d1-3342a3471ccmr24460323a91.37.1759243592943;
        Tue, 30 Sep 2025 07:46:32 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3341bd90367sm20311444a91.5.2025.09.30.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:46:31 -0700 (PDT)
Date: Tue, 30 Sep 2025 11:47:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <aNvtfPh2JLdLarE5@debian-BULLSEYE-live-builder-AMD64>
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

On 09/29, David Lechner wrote:
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

Yes, the alternative to having GPIOs would be to have pins hard-wired set to a
specific logic level. And the connection don't need to be to GPIOs. The gain
pins on the ADC chip can be connected to anything that keeps a constant logic
level while we capture data from the ADC.

> 
> For example, there might be 4 mode pins, so we would like to just have
> a mode-gpios property. So this could be all 4 connected to GPIOs, all
> 4 hard-wired, or a mix.

Having some pins hard-wired and some connected to GPIOs is possible, but that
would make things even more complex as each pin on the ADC chip sets a different
portion of the gain. IMHO, mixed GPIO/hard-wired configuration starts looking
like over engineering and I haven't been requested for so much configuration
flexibility. Having either all hard-wired or all connected to GPIOs should be ok.

I'm not familiar with pinctrl dt-bindings, but I was wondering if we could get
to something similar with pinctrl. Based on some pinctrl bindings, I think
fixed-level GPIOs could look like the following (for the 4 pin-mode example).

pinctrl0: pincontroller@0 {
    compatible = "vendor,model-pinctrl";

    all-low-state: some-gpio-pins {
        pins = "gpio0", "gpio1", "gpio2", "gpio3";
        function = "gpio";
        output-low;
    };
    all-high-state: some-gpio-pins {
        pins = "gpio0", "gpio1", "gpio2", "gpio3";
        function = "gpio";
        output-high;
    };
    most-high-state: some-gpio-pins {
        pins1 { 
            pins = "gpio0", "gpio1", "gpio2";
            function = "gpio";
            output-high;
        };
        pins2 { 
            pins = "gpio3";
            function = "gpio";
            output-low;
        };
    };
};
spi {
    adc@0 {
        compatible = "vendor,adc";
        /* All gpios */
        pga-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>,
                    <&gpio0 1 GPIO_ACTIVE_HIGH>,
                    <&gpio0 2 GPIO_ACTIVE_HIGH>,
                    <&gpio0 3 GPIO_ACTIVE_HIGH>;
         /* or all hard-wired */
		pinctrl-names = "minimum-gain", "moderate-gain", "maximum-gain";
		pinctrl-0 = <&all-low-state>, <&most-high-state>, <&all-high-state>;
    };
};

Though, the above is still relying on GPIOs which is not a requirement from
ADC peripheral perspective. Also, if GPIOs are available, one can just provide
them through pga-gpios and have full control over the signal gain with the IIO
driver. It boils down to just telling software what are the logical levels at
two pins on the ADC chip when GPIOs are not provided.

Thanks,
Marcelo

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
>     };
> };

