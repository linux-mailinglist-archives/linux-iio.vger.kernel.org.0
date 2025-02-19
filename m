Return-Path: <linux-iio+bounces-15791-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53592A3C247
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08B27A6A21
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50671F2B87;
	Wed, 19 Feb 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO/R78U9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36FC1EEA5A;
	Wed, 19 Feb 2025 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975813; cv=none; b=NP85ohBv8gSq1v+iS4OG/gd9TYIFXzyGKvRKzMAapkAvb/Xsx81ywiCWMY3y8OQHo6aXs6+ItFs06FWVI2AFG8yGVOZArP9m5aLgL59o4LNF4iOBO71AYS/dHSBa81xekXfQ0AzTHnOXfLt4KYzwv5nsCbJLjJSmYfho70NCrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975813; c=relaxed/simple;
	bh=owahyn3Hxz73SFk6tozaZ6nyv4UuwSojGk+W3MEIRvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aimwyx8gRVvkh0nHzUvBOxpmrZFLm3Mr6C2yP2YGL9gdjtnqGo9McTiZaaLALlS1D8vYFKY22Ht94O4c0ZPJWu43jhWdMc7WY3JEDerpG51dCB9IFB6iOpKOHzPm0xK0ML7RpODs6U3wr88/1rNaXTQf62X+TGrH/RXNfxUFnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO/R78U9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so22929055e9.1;
        Wed, 19 Feb 2025 06:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739975810; x=1740580610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QTXbtvB5WqPCPZqBXLo7Idaw2Yrfijp1ad/HqmeWbs=;
        b=WO/R78U951O1KgrQtrQh++lM12lBYvwAUCYywMN5tikvEuivqaNeoXpQVXkMpAb3OR
         FXz9o4//7TfPp7Gx3oTPBBb+irGgesbKKuGaqVK+o5V0aK8LEPci6yyeBdmYr8Gt8u1q
         s4fuhokQibHdEibRI2wiW4xUvVSdixFDJltpo2j0ZEKuEzU7HbSw/b3laJN0UufDlPR5
         BEUs9nZLAPDAxIUQxjHE+VY695oPq0GW/LPXhIVvsqApBy0c7rom0nTjsIYs2Sfubpm7
         AJ7+CrpSMyO0bzGqF6X44UwO7C9XINp8oO60j0qbEy73lQmqHBroAusQxjiKkcpWqPSV
         pPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975810; x=1740580610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QTXbtvB5WqPCPZqBXLo7Idaw2Yrfijp1ad/HqmeWbs=;
        b=fAouuuf3SxbnAAwRbWVmk65KVQDG5ysyroMjRFyVixXcERYTokGz/SNUmdlJcHFgRO
         Gspt9MONQF0Tam5/Lzh0XsT3YC0A5NC7OqDI2eQ9y4FkEGnd+MVJvOQ5HUjeBMg/0bQ6
         XSKXtr3uupF68f+u9vPrtQ6Mzz6QvBu0sMxhy/3Nzx1rMCu9YXwIVdJ3NtHt7SYVHW7V
         5KMRAJ7AUCRYX2AsgrH0iJyn5Rf5Pf9rZ/2WP1ef//XkJpPrnwaUk74dlb33uXfxZzgc
         qNSdjkE9r4bXiNHqBjy2MlotbD25ib7pFmTbxo6uXhe/TEnLU5AxZ3d1p9Y4JT6NjcwE
         D3ow==
X-Forwarded-Encrypted: i=1; AJvYcCVARYvpvQvo6py/jHd72X5GSFIYk+CYhrafGB+tXowY+O47LenhvFYFXj7MYeukMh4DCvUytfR4x3qB@vger.kernel.org, AJvYcCVEy2AUgYCZlFIWxBzoXOTG3JlqU3ECmNT2ydwawraTPb1U8soGcWmZZBbSqvCvGj0YKwLoPqSBa1sBVskN@vger.kernel.org, AJvYcCWASgCq+KHPZWRaM+c7P7RPl6jcbGaGcXGwg97WtAswjOxIpEeHGeN4txG6SDNMgBfs1L2Xdfh1ZWh5AOA=@vger.kernel.org, AJvYcCWwDPAlfp+aJgiLwhtnCqsHehiVX/hi0PUMKOZpACNrKZaoUuKrhyq9GKO1DaFG18iubx+ULGTV0pgl@vger.kernel.org, AJvYcCXKejCskenoU3zmGZH/gddnicTUfEL4+wR5HAmfMvgAYr/NQF8puQWxv/b7llmfHXPWG+pvKeuj+24aag==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDT/yxoJ+VXBSydqzgIPVllhDGcFY0huiXh8dB0z4keh3IA8M8
	BjmV8P5R+6OFMk7JEOfyuZW0FZ20lFS7kw7UZ0+bF5dkaCTnwqpiBb5IfVxp7PF/nhd63cwVse6
	uaQrYH55u1MGDRa2IwUyV/YoRMuU=
X-Gm-Gg: ASbGncuAolZIVCy6cXP8TkKveIuSkAuYx+DovQ9ehjcuoIZcL70cRJYXmskjTtz1ZXs
	rM+Ya8Gyifi7cpc9q1Jupan0+Ruk55JDPUP2JC581RZrSTPcZY0Oj3E95MUhyqd7I811Ch0kY3g
	==
X-Google-Smtp-Source: AGHT+IGuUdWXrb/mtz3pDeb/kKeAwZ1uQIcWAmTUWKnQyPJtlEcB5Mz3/TO0x0WLmRb/T6h6Ir38NTvppeBJI0eHa/0=
X-Received: by 2002:a05:600c:4750:b0:439:9828:c425 with SMTP id
 5b1f17b1804b1-4399828c633mr54172835e9.7.1739975809915; Wed, 19 Feb 2025
 06:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218132702.114669-1-clamor95@gmail.com> <20250218132702.114669-3-clamor95@gmail.com>
 <Z7XqKcOUt5niXzpv@smile.fi.intel.com>
In-Reply-To: <Z7XqKcOUt5niXzpv@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 19 Feb 2025 16:36:38 +0200
X-Gm-Features: AWEUYZnnp1prjZiOv4DEGghz-JiQuuNsDsxtsmrRfSqxZJkzyQuhOgT8aOgjbHE
Message-ID: <CAPVz0n1_WQyOHhtEVAh53uhEUhZvqqZSEJh6XALtSrVfkMSLYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: lm3533: convert to use OF
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 19 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:27 Andy=
 Shevchenko
<andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 18, 2025 at 03:27:00PM +0200, Svyatoslav Ryhel wrote:
> > Remove platform data and fully relay on OF and device tree
> > parsing and binding devices.
>
> Thanks for following the advice, but the problem with this change as it d=
oes
> too much at once. It should be split to a few simpler ones.
> On top of that, this removes MFD participation from the driver but leaves=
 it
> under MFD realm. Moreover, looking briefly at the code it looks like it o=
pen
> codes the parts of MFD. The latter needs a very goo justification which c=
ommit
> message is missing.
>

Splitting this into a set of commits would be nearly impossible,
original driver does not relay on OF, it relays on platform data.
Ripping out platform data will leave behind a broken useless driver.
So it has to be done simultaneously.

MFD part is removed since MFD cells binding is unconditional, while
the device supports any amount of children grater then one. For
example, my  device uses only backlight at bank A, while all other
subdevices are not present and used. This patch switches to dynamic
bind of children.

> ...
>
> > +static const struct of_device_id lm3533_als_match_table[] =3D {
> > +     { .compatible =3D "ti,lm3533-als" },
> > +     { },
>
> No comma for the terminator entry. I think I already pointed that out ear=
lier.
>
> > +};
>
> ...
>
> > +     device_property_read_string(&pdev->dev, "linux,default-trigger",
> > +                                 &led->cdev.default_trigger);
>
> One prerequisite patch you probably want is an introduction of
>
>         struct device *dev =3D &pdev->dev;
>
> in the respective ->probe() implementations. This, in particular, makes t=
he
> above lines shorter and fit one line.
>

This is not a scope of this patchset. Original driver uses &pdev->dev

> ...
>
> > +static const struct of_device_id lm3533_led_match_table[] =3D {
> > +     { .compatible =3D "ti,lm3533-leds" },
> > +     { },
>
> As per above.
>
> > +};
>
> ...
>
> > +             if (!strcmp(comatible, "ti,lm3533-als"))
> > +                     lm3533->have_als =3D 1;
>
> If you end up having this, it's not the best what we can do. OF ID tables=
 have
> a driver_data field exactly for the cases like this.
>

This is required by core driver to handle some attributes and is here
solely not to touch those in this patch.

> ...
>
> > +             if (!strcmp(comatible, "ti,lm3533-backlight"))
> > +                     lm3533->have_backlights =3D 1;
>
> Ditto.
>
> ...
>
> > +             if (!strcmp(comatible, "ti,lm3533-leds"))
> > +                     lm3533->have_leds =3D 1;
>
> Ditto.
>
> ...
>
> > +             ret =3D lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_=
BCONF,
> > +                                 1 << (2 * id + 1), 1 << (2 * id + 1))=
;
>
> BIT() and better to use a temporary variable for this calculation.
>
> > +             if (ret)
> > +                     return ret;
>
> ...
>
> > +             ret =3D lm3533_update(bl->lm3533, LM3533_REG_OUTPUT_CONF1=
,
> > +                                 id | id << 1, BIT(0) | BIT(1));
>
>                 mask =3D GENMASK();
>                 ..., id ? mask : 0, mask);
>
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> ...
>
> > +     bd =3D devm_backlight_device_register(&pdev->dev, pdev->name, pde=
v->dev.parent,
> > +                                         bl, &lm3533_bl_ops, &props);
>
>
> With the advice from above:
>
>         bd =3D devm_backlight_device_register(dev, pdev->name, dev->paren=
t, bl, &lm3533_bl_ops,
>                                             &props);
>
>
> >       if (IS_ERR(bd)) {
> >               dev_err(&pdev->dev, "failed to register backlight device\=
n");
> >               return PTR_ERR(bd);
>
> Consider another prerequisite patch (which should come before the firstly
> proposed one):
>
>         struct device *dev =3D &pdev->dev; // yes, this can go in this ch=
ange
>         ...
>
>         if (IS_ERR(bd))
>                 return dev_err_probe(dev, PTR_ERR(bd), "failed to registe=
r backlight device\n");
>
> ...
>
> > +static const struct of_device_id lm3533_bl_match_table[] =3D {
> > +     { .compatible =3D "ti,lm3533-backlight" },
> > +     { },
>
> As per above.
>
> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

