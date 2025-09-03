Return-Path: <linux-iio+bounces-23670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F61DB41613
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 09:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B595E3A2A96
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438D2D94AD;
	Wed,  3 Sep 2025 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEMcb31V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66C14A4CC;
	Wed,  3 Sep 2025 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883872; cv=none; b=UN0da6LIHgnQ9kYnUt12QX5LHRd+/A5rUlPw+QcsK1nYqlNKV3+0P0ogzCwLJHtv3X1y+QfYlDMdcfNq3tRZjUPvMDermDHKL0oHPBiNtaxEQv57U+r0ZMF2+PN+0hBshzTqerJ7iCvDmw5yam85YgSNFb2NFNg18Nulolld2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883872; c=relaxed/simple;
	bh=u6bxksWlZkHuVrMRO61cijopoFxXYFiA9ZplYoQtu+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WobDAXtRC3W2n8/tXTEGmZpBU6N4rphgP9Ubx8BrJqB4SYXhoGQKaZJQE2HTaK3lff7tCIH30yurKlTsZ7zTKAOdXEnIrDPFla9cBNDVAcq6LrOVnnH8pjm2rwZvoy9w7Yaly9xbV+XHizk/khyTfN/fun5F5ZGppItjx1Uj8oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEMcb31V; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5608bfae95eso382278e87.1;
        Wed, 03 Sep 2025 00:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756883869; x=1757488669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWxPpaLx0J/YfEhBVTAYuBnzyRIXlZ7eGFcy0EoWGcM=;
        b=IEMcb31VswLwFajrhHhydWLpQ03giAdEcTX+ejxlZeo1eUSDCw/fZWnCVIgxSaHeQb
         v3bFO1ZeAbdfQlZR1Ub0K/MQSsqpsawezXQn6QPTPDkxyL8Km6vd+Vv+byS8Cm+JXUkR
         qZrJYcD4VM1KAcfpWt7J3J5iQVwpo2+/ZceUpFkeYci/p5o0uUO0bbYr5rxCqOOpX2n3
         JTa86HmxHz/izuYYD4X+rKtUMXqjUf/ReWUUUmbQRdg3uayzhNQy9ZJdkjAlq2it21ui
         R8n5xQ0gvNcxSK1PBjwpQ3fLEx1WZljMoZP7c/1IXljmzex9ecOYLfcgZE7nYH67IDyr
         yW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756883869; x=1757488669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWxPpaLx0J/YfEhBVTAYuBnzyRIXlZ7eGFcy0EoWGcM=;
        b=OGYBixCpRqM6QWioFHNZ47QGOioHH1njHuab+r/6ukG591qHZjqcaXmlr9Xsg/ShpN
         iXnLvmiojF+9BL1Z2oyYArxtmR8rNEwiKId39Ngh1+0DFY+2S9RhWXYAuFGmguNn30ys
         MHblS2QywvzTO4mxsbKmSU1sQNco4d7M2Ik56ljRrYc1Wbkm7pFAg3ekOkfDg7cvMBbQ
         6zOx3yQ1fRbcsbWgrHTpu8PjkftqJmpVk+SyKfAlALdc786aAyoJxF4jB8+sAFfgC74q
         TnSEjaP0BuFxGjA5evgEacgJmeryW0EyrHZe+MXeaeJRybnTidVjRTSexv6Cv+vl36vm
         4fBg==
X-Forwarded-Encrypted: i=1; AJvYcCUGP5rXIGGHFKl5ETfkDHhyg/VXpM1GtPU9bwdTMi3XURG+2PsPZ1w6lMICLCfGqZkHwsr9N7wNT1ka@vger.kernel.org, AJvYcCUGoogIzblTuIh+QKInw6cepR+WmQgTOPBl27QQBfwayyUjTsgYmjQ12t3MImxfncN2JziuEdLCICbHLA==@vger.kernel.org, AJvYcCUPsmRZswtqKkOXUskNmw+5vGuGeYNwrbLQdxAIvhso0EOrNs1Ybu5aL4o6mQ62sklMo0fJqTA+m3++JTkx@vger.kernel.org, AJvYcCXpe97F4mjInzT+129bU4sFBcKlSzdkpj/gF5BNpAmZRBHE4oGLJcOVtlV0nm8TuDkilfrd/FWCg9yx@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ8PqGRCphiha9DcLTuJbiTV2sbboPxeeVSj7VAkErz++12+KV
	3lncevf58HsFAvpBueBfrBOM3+8pS59xIWaMFzHZ6Q+sLYPeQ325zDeC
X-Gm-Gg: ASbGncviqbE4Rhsdx/jSHMQZAZC8LqCAIRR3rh+8Q8TOjkVG7EeoOUi7x4Ek/KNHF6u
	aDqX3xoGl8nz1pdsdHYxDQuu9KXJbkG5t0FRUdW8GLTmurY8ankkAx+L75fxtD6t8bGqR6+dRLR
	1jvPNu3Rr0GBgtiA7PMk0qEstkzUttEWmmTYkQH0xi87i09DlJpDASMn6q8nU5sDK2WrcpGZ39X
	GeeIOZ2tVGrAuZzdeIlQ0xm3w1yT7eP+dIG1/34hf85RSCXiay9ObpP0CzyZ6IhS1DnJYRQXdMM
	npMDpPOdGGh2OiLMHixT0kFP+O6XscMQTB5vpAWBnjFtDKz3XRXr3XYk50VWtfDN2SkDPeFFlo9
	SDMswdKQGvtpL4mvjfrWmRJ+ahElDq/mXmlQtaDFgmlp68lQMVDqjSgYVNCDz6LD52HqK4POg6V
	Ukmemv
X-Google-Smtp-Source: AGHT+IFAUvpDlqrd73+gSPy/DJZGAyv6LD8NzfTbSUejz7bsNE7BQ8F2lTaZmlnFw0cCQGe5WEBiOQ==
X-Received: by 2002:a05:6512:2513:b0:55f:6a72:5679 with SMTP id 2adb3069b0e04-55f70906104mr4156539e87.34.1756883868657;
        Wed, 03 Sep 2025 00:17:48 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfc267sm323830e87.100.2025.09.03.00.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 00:17:48 -0700 (PDT)
Message-ID: <9f69e164-5e63-44c1-9354-90b8de2ca27c@gmail.com>
Date: Wed, 3 Sep 2025 10:17:47 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Linus Walleij <linus.walleij@linaro.org>,
 Michael Walle <mwalle@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Hans de Goede <hansg@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <CACRpkdbOhm4PawYZUxU1SMi8WGr-LxhR1jhSVPDvPh3TTp8SWQ@mail.gmail.com>
 <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
 <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/09/2025 09:47, Linus Walleij wrote:
> On Wed, Sep 3, 2025 at 7:23 AM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Anyways, fast-forward to this day, I don't see it handling valid_mask. I
>> think it is a must for this device/driver, where pins can be either
>> GPIOs or ADC inputs.
> 
> Why not just add a .init_valid_mask() to
> struct gpio_regmap_config so it can just pass that
> down to its gpio_chip?

Sigh. I suppose that would technically make sense. (So would allowing 
other IC-specific callbacks... ;) ).

> OK I don't want to load you with too much extra work for
> the driver, but it seems such a small thing for a blocker,
> and Michael who wrote the library is really helpful
> with extending the code, so consider it!

I suppose I can see how that works out. I am not a fan of maintaining 
the extra code. Thanks for the suggestion.

Yours,
	-- Matti

