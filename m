Return-Path: <linux-iio+bounces-23778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68364B4594F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F001C81FB0
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69A3570AA;
	Fri,  5 Sep 2025 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGT+3Pxa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7335690A;
	Fri,  5 Sep 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079586; cv=none; b=aUziD3ur6LRFX8xS7WVOTJmBnnPezUTrLENXvGGtSq3IxgcuECfOj6p5/n0a/4rq97jlPU222LLSRt+/8yZgrgPc8RyDuu9nqtJWBLMcTiK4nXpe67FXBde1OVC1+67bMJQOQddlbhe7pPfcV8GCygQ97NWukEu4JOzdxGYsnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079586; c=relaxed/simple;
	bh=vx2kCaHAa3+46zkf1gF5gTvLik0KcTAA2xzJVsF3BLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdjtzMKiz+IhgW9hG9gWr5BtDo8isGlw4RaS/JEA9czPVpHk8t3VKpIY2PziB+jIttx2c1D/XHcTssoTM0GqUOsLqqLcN7B5Rsx7qpz7kl/VFWEpWiicRp7HCoojhGlIzd4N7orS6UWCyzECDP9Bd/ywYOv4EJH1ZRFYx/J6Ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGT+3Pxa; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b042ec947e4so292003166b.0;
        Fri, 05 Sep 2025 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757079583; x=1757684383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcBwWlHZB5a2uZGoWcZFaGIFJ/aB0IZuklQOtG7SMIs=;
        b=ZGT+3PxaSUZUpOWZ5JxrvW1bBRqN96tqo+ct81Rad+wkyvjCN6xpc20JvMcRU3apdD
         kFPdlKxE2jiYNfGWlcCYkPD34FMZxwWpErNYW7ibQZOmxG9ck9bcgNmdMAh2+aaFEhfE
         lGZ4wTifd6wHV71R4Bdxdn/BhcfvsMI9Q6QRVrmTaH3BCYc9DdR3D3elh7iivolviQlr
         52dj3M8CDM/zyCWgCiokV4iKH94YhWainypxMxIESkPlS6phjBhILxOWfMhe9sVzy+tx
         9CEIAzhijO/TGVmGJ9Gs5e0lE+J1uZS/o70azE4U7VyPCZqC3WnXru5pAlM/E0VU0DmD
         xpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079583; x=1757684383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcBwWlHZB5a2uZGoWcZFaGIFJ/aB0IZuklQOtG7SMIs=;
        b=Fe81wayuoLzidji4vYY6QZQ2NEOpVx0HxHOL4K2i6dT+6GmkVFsT/1Hm9IduTouFAO
         PUvBmBSKKXvphWfvVIhWr1l8O4aXil8C1jJ0Kc7lCGeBK5q0rMGGNPWs3XCflEx8Mphm
         Api91dzDNd+XIw7h3yGBKdf0dmxTC5XZ64b+37fuaCjgNgPOOQFUSYsBZU4AZc1PKqmn
         +YfFih/fQRjCfw3jQlj8jKO4T6vc38rvp86ntWFMTJJRM7lO7uKRKilFdkwtY4iO+D7P
         XX8Kt4dCgN6fijs7juQJ3e9TXTeNHmAlgaLL76f1kBF+XDYVCm/MxAIhPJE6NVaScuCo
         gz4w==
X-Forwarded-Encrypted: i=1; AJvYcCUxsBWnApSTCLIENw+zhgKqDEOfZzV0y3YX3HeCRnXw/Ic/hK3Rejz9wrW9CF71BLNL+h4VyJR7otKwNJOu@vger.kernel.org, AJvYcCWfQKHlAVyEE/XqK/OBvUAS2jF9ZPEj+JqnOWrAgWm8dupAmpyTta/iOEM1ZpZygp5tGLzF5nRBnYpx@vger.kernel.org, AJvYcCXSJDCpsketTqWEOPLWPaz7FfSwjq90MgRNDzTMbaMDTJwg8vv/ccfUrVY6CdUkWlwp8JTd6IG8hNXQhCY=@vger.kernel.org, AJvYcCXtolWt9qxITBoea87ukGdIh61NdFiBKqiSG+DMfpD3ZIGmv+RwR262L37gOvBr1l5sMYvpfp205quL@vger.kernel.org
X-Gm-Message-State: AOJu0YzodTwfVaJQh5c65+HT85DCAGCK3MO8W68LE2cumItN/1RxK7AN
	AZT+jmcIuLCMtKGuMOGYVY+ktDvqeaCvX5FwNFVOPDT51uGXR7ljSzFZoQZlHsJgPWTAGNTp4oO
	cMOGNe9OHfuh3LMx3ckD69Uu45cTpJXM=
X-Gm-Gg: ASbGncsOwOddAjuldUeYjqY5PE0cWqKFUPN1+5KHCeYSdLLfm0KDzDKhF1tr2bcfJC+
	gkMCguD3NufwEW11SI/LE1cBcFjCJ6kGOdCsG4uSoAehSWRag1xJIWm7h0oUlrPY+sJbhC54STU
	s+zveiHRWgt5vZByzSPuhnQmqMhHtDFecLbrA/ygWuKvH4nGVM+FhW5GBsP0GjE541FVY5QSzWV
	wgE/DYilhEaaAfwAFnp
X-Google-Smtp-Source: AGHT+IE+5+0V34pgQChWQaQfEdYgH1kutkm+wEpWLjqg5Kc4kXcPbb7Glfuj8Fu2iyCt8sHQUcgaZkstmrrmQRzXtdE=
X-Received: by 2002:a17:907:948a:b0:afe:b2be:6109 with SMTP id
 a640c23a62f3a-b01f20cc03emr2012717966b.59.1757079582723; Fri, 05 Sep 2025
 06:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905-88pm886-gpadc-v3-0-4601ad9ccb51@dujemihanovic.xyz> <20250905-88pm886-gpadc-v3-2-4601ad9ccb51@dujemihanovic.xyz>
In-Reply-To: <20250905-88pm886-gpadc-v3-2-4601ad9ccb51@dujemihanovic.xyz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 5 Sep 2025 16:39:05 +0300
X-Gm-Features: Ac12FXxrKIZYXKtYgH3JI0EqCq4jorFjsWgU2LlwYrGTdm8tQwoMyi-wjVbijSY
Message-ID: <CAHp75VewzAN+tcJ9GrWESY38Uq+qeA4QH=qeaEV8g35H67GcMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:01=E2=80=AFPM Duje Mihanovi=C4=87 <duje@dujemihano=
vic.xyz> wrote:
>
> Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
> monitoring various system voltages and temperatures. Add the relevant
> register definitions to the MFD header and a driver for the ADC.

Jonathan et al. The Q here is do we want to somehow make values
spelling (in the comments and documentation) be unified with the
Scientific Style [1]? Personally I find the article very useful and
one style for the whole subsystem would be good to enforce (in my
humble opinion). Thoughts?

[1]: https://poynton.ca/notes/units/

...

> +static int gpadc_get_raw(struct iio_dev *iio, enum pm886_gpadc_channel c=
han)
> +{
> +       struct pm886_gpadc *gpadc =3D iio_priv(iio);
> +       __be16 buf;
> +       int ret;
> +
> +       ret =3D regmap_bulk_read(gpadc->map, pm886_gpadc_regs[chan], &buf=
, sizeof(buf));
> +       if (ret)
> +               return ret;
> +
> +       return be16_to_cpu(buf) >> 4;

+ asm/byteorder.h (after linux/* but before linux/iio/*)

> +}

...

> +               /*
> +                * Vendor kernel errors out above 1.25V, but testing show=
s that

1.25 V

> +                * the resistance of the battery detection channel (GPADC=
2 on
> +                * coreprimevelte) reaches about 1.4Mohm when the battery=
 is

1.4 MOhm or even 1.4 M=CE=A9


> +                * removed, which can't be measured with such a low upper
> +                * limit. Therefore, to be able to detect the battery wit=
hout
> +                * ugly externs as used in the vendor fuelgauge driver,

fuel gauge

> +                * increase this limit a bit.
> +                */
> +               if (WARN_ON(*raw_uV > 1500 * (MICRO / MILLI)))

+ bug.h

> +                       return -EIO;

...

> +               /*
> +                * Vendor kernel errors out under 300mV, but for the same

300 mV

> +                * reason as above (except the channel hovers around 3.5k=
ohm

3.5 kOhm / 3.5 k=CE=A9

> +                * with battery present) reduce this limit.
> +                */
> +               if (*raw_uV < 200 * (MICRO / MILLI)) {
> +                       dev_dbg(&iio->dev, "bad bias for chan %d: %duA @ =
%duV\n", chan->channel,

Also add spaces before units.

> +                               *raw_uA, *raw_uV);
> +                       continue;
> +               }
> +
> +               dev_dbg(&iio->dev, "good bias for chan %d: %duA @ %duV\n"=
, chan->channel,
> +                       *raw_uA, *raw_uV);

Ditto.

> +               return 0;
> +       }
> +
> +       dev_err(&iio->dev, "failed to find good bias for chan %d\n", chan=
->channel);
> +       return -EINVAL;
> +}

...

> +       ret =3D DIV_ROUND_CLOSEST(raw_uV, raw_uA);

+ math.h

...

> +       page =3D devm_i2c_new_dummy_device(dev, client->adapter,
> +                                        client->addr + PM886_PAGE_OFFSET=
_GPADC);
> +       if (IS_ERR(page))

+ err.h

> +               return dev_err_probe(dev, PTR_ERR(page), "Failed to initi=
alize GPADC page\n");


--=20
With Best Regards,
Andy Shevchenko

