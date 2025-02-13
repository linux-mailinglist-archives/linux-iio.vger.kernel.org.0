Return-Path: <linux-iio+bounces-15490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37419A34544
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 16:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFAC189ACA4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C93200B89;
	Thu, 13 Feb 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE0xrHhI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7870200105;
	Thu, 13 Feb 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459023; cv=none; b=MvxuxyRhb3t8KKCsCSt7DWhogvoM0/UBDaoC2X1PqDLwHUIuvnofVNQnAa6ghg/wIeMvXvk4ndVV60az71USd12OYI+0+fsrNqmePr+JoVqG917sC7qv4vLntbnzXKwADZUpHE+EK1c2ZD3pvK4P3H4iEHBYIEcE2BFycaz9lRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459023; c=relaxed/simple;
	bh=bKy2/Khn0wBJ7ch0tZ8a2XFADxRpJkeSdk6pKJhI8Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3RVgsrir+4UslHS/gKR7+8sVx9T28w/7aUxLrxgOVFVfP674bbkqBJBLRl9goWI2TqvcSSXPA6YtKNokPlQ/ygo2Brp2+Gu9UJyn/3RxGlKseHKBmnAi0HOaWkfOO6YLA8o9uSoBi0He2hDIGQGKprUesYiGjyIjMn04UnRjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE0xrHhI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f286b5281so317332f8f.1;
        Thu, 13 Feb 2025 07:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739459020; x=1740063820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il270moocRQxXWx9sDop2wPY9i++i0FF/XAOD2V/4TY=;
        b=XE0xrHhIPMVYgfiT98LnTbdlMBtl849KMxHmRlaVogSu1mGZiCdYq7NxrfY7QF4jJx
         ZoM7HvkxGt+v76DYAe0XiSNaVRrR9KOcDzJv+M1mO0xEMle+a9fhvvkde2XNYbXEwLOe
         4z7uEXoTUh4/osy3Qjz2fAtmKklQvkx1PAyd89DdwK/Zy4C3CQTAJ8RFPtz7dC54v/8a
         Tu4xs3xwGQH0qctVUyYIR15/+9dKIUrM16XB/GiWFrIV3P/9Z5SdkEfi/o5PFE3mf4BI
         5tfXWRiYdP9pr0HlXSKxI6y6XrBa2u2EhElUabTBnzSqbQf4xNee2XTbDEm+dhnk/r+M
         LRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739459020; x=1740063820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il270moocRQxXWx9sDop2wPY9i++i0FF/XAOD2V/4TY=;
        b=pxPOthir2Y0bz1QvBwnz5U3PJejJWbtiFU1hSeL5aqwFLjOdxV/wc7ER+0dex/KlPC
         a7Y+KfjlPGt0pi3+M5b4qIBOsF7WpFbyo6vSQBCml7cT9sfIx/zvQUmwHLUkW2KfwffZ
         b5jZQZnPWc/IAvOfd6vaMFNO+t44M5anfIQ1lIGun/3ACckgWRfOJAWhhnm04qxnx8ZM
         QK1FX42iwT86V389eSQcJ7S6s2mBLi5RskP6Yh07bl++pmfnrl+f7T7Bbw17w16llXh9
         o/CaEOj+oyMKY931gBP7SfWpiSD5GTNnRbOEnqnRY8X6dIR0bUb+sOpBK5mHfTjcuSVq
         VaGw==
X-Forwarded-Encrypted: i=1; AJvYcCUi5tsB4Ql0H+NnqDug6DiNpT2B6ZSD6mNIveljugGwqZtIUgT9udMowQeuT6Gi0RermXwruFHT4cFTKg==@vger.kernel.org, AJvYcCX5Ssoc7K2/3fo9qx8glCxWoRctYJaTXfg97jlWzd1fR+vHqcflLhQ2nwRa0KXweheUtTQDFO5JqybP@vger.kernel.org, AJvYcCX6kDLLqXIjX9ieaOTtwbhAQLFvjTZn4CneTKR7PmrYVQUeghvojg9lO2SXe9bHl7PmU2g2P5l2lDqxLbQ=@vger.kernel.org, AJvYcCXGwBweVBsck9LBLy60nsZ1sxXhab+qy1DNWHnndM3F+5ggzXmhrJEQ4/33Ipr2v4ZIIYqhRKYG7HyC@vger.kernel.org, AJvYcCXcgl0w1G6/pd6kaWVkscwjWhyYqca2VqGpVFgFBg3GS1ywDPlWUZgyoYv4P7eKZcyLAESEE8QY5W1fMLlg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy43WRFMxfsB7v6im4xWlR1mZejggVBxsEqoPnSN3gEkwBD1blX
	IprDNU1McppeMiCbg/wS3zXRKZCPexfoYAEiGf8iGpPY2tK0CUClhtIGvzdh3v8joQcjwZEWNmE
	/tTBrOw0DAacY8i03dc1c2hVftIA=
X-Gm-Gg: ASbGncuVckvyGSl9C24EEK8/MbLitFO1irg6hFxH8DJeX4gZv8ltYavNA/fuUZ178vA
	H62MGVQuy36/VWBcn2/5AU0rGusa4xU9QQM0Mb/9LfeLJg958OYTxVZKMqQmWOnTF+sd921tDGQ
	==
X-Google-Smtp-Source: AGHT+IE8DKcyHRlcVZTAi4KF6Sh5KbjMdfB2KDTubvGG7HEDVbAuM4dGu6BtK52l5l2xucBK9g38u/USqfRqqkbnJB4=
X-Received: by 2002:a05:6000:184b:b0:38d:b113:eb8 with SMTP id
 ffacd0b85a97d-38dea26ecebmr7135274f8f.20.1739459019532; Thu, 13 Feb 2025
 07:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212075845.11338-1-clamor95@gmail.com> <20250212075845.11338-3-clamor95@gmail.com>
 <Z64IPpW5Uhad4HjU@smile.fi.intel.com>
In-Reply-To: <Z64IPpW5Uhad4HjU@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 13 Feb 2025 17:03:27 +0200
X-Gm-Features: AWEUYZmUj-krca9nu8UVllaTPCZQMTjt3IELvxYIQkmFcH7UwZphBSmDpexxcjA
Message-ID: <CAPVz0n3TTrkfARQNWfhgJd0sNnUTTdX8vx8hnHDZMq+p9aK_wA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: lm3533: convert to use OF
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

=D1=87=D1=82, 13 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:57 Andy=
 Shevchenko
<andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 12, 2025 at 09:58:42AM +0200, Svyatoslav Ryhel wrote:
> > Add ability to fill pdata from device tree. Common stuff is
> > filled from core driver and then pdata is filled per-device
> > since all cells are optional.
>
> ...
>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/mfd/core.h>
>
> > +#include <linux/of.h>
>
> Is it used? In any case, please no OF-centric APIs in a new (feature) cod=
e.
>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
>
> ...
>
> > +static int lm3533_pass_of_node(struct platform_device *pdev,
>
> pass_of_node sounds a bit awkward.
> Perhaps you thought about parse_fwnode ?
>
> > +                            struct lm3533_als_platform_data *pdata)
> > +{
> > +     struct device *parent_dev =3D pdev->dev.parent;
> > +     struct device *dev =3D &pdev->dev;
> > +     struct fwnode_handle *node;
> > +     const char *label;
> > +     int val, ret;
> > +
> > +     device_for_each_child_node(parent_dev, node) {
> > +             fwnode_property_read_string(node, "compatible", &label);
> > +
> > +             if (!strcmp(label, pdev->name)) {
>
> This is a bit strange. Why one need to compare platform device instance (=
!)
> name with compatible which is part of ABI. This looks really wrong approa=
ch.
> Needs a very good explanation on what's going on here.
>
> Besides that the label is usually filled by LEDS core, why do we need to =
handle
> it in a special way?
>
> > +                     ret =3D fwnode_property_read_u32(node, "reg", &va=
l);
> > +                     if (ret) {
> > +                             dev_err(dev, "reg property is missing: re=
t %d\n", ret);
> > +                             return ret;
> > +                     }
> > +
> > +                     if (val =3D=3D pdev->id) {
>
> > +                             dev->fwnode =3D node;
> > +                             dev->of_node =3D to_of_node(node);
>
> No direct access to fwnode in struct device, please use device_set_node()=
.
>
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
>
> ...
>
> >       pdata =3D dev_get_platdata(&pdev->dev);
> >       if (!pdata) {
> > -             dev_err(&pdev->dev, "no platform data\n");
> > -             return -EINVAL;
> > +             pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KE=
RNEL);
> > +             if (!pdata)
> > +                     return -ENOMEM;
> > +
> > +             ret =3D lm3533_pass_of_node(pdev, pdata);
> > +             if (ret)
> > +                     return dev_err_probe(&pdev->dev, ret,
> > +                                          "failed to get als device no=
de\n");
>
> With
>
>         struct device *dev =3D &pdev->dev;
>
> at the top of the function will help a lot in making the code neater and =
easier
> to read.
>
> > +             lm3533_parse_als(pdev, pdata);
> >       }
>
> ...
>
> >  #include <linux/leds.h>
> >  #include <linux/mfd/core.h>
> >  #include <linux/mutex.h>
>
> > +#include <linux/of.h>
>
> Cargo cult? "Proxy" header? Please follow IWYU principle.
>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
>
> ...
>
> > +static void lm3533_parse_led(struct platform_device *pdev,
> > +                          struct lm3533_led_platform_data *pdata)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     int val, ret;
> > +
> > +     ret =3D device_property_read_string(dev, "default-trigger",
> > +                                       &pdata->default_trigger);
> > +     if (ret)
> > +             pdata->default_trigger =3D "none";
>
> Isn't this done already in LEDS core?
>
> > +     /* 5000 - 29800 uA (800 uA step) */
> > +     ret =3D device_property_read_u32(dev, "max-current-microamp", &va=
l);
> > +     if (ret)
> > +             val =3D 5000;
> > +     pdata->max_current =3D val;
> > +
> > +     /* 0 - 0x3f */
> > +     ret =3D device_property_read_u32(dev, "pwm", &val);
> > +     if (ret)
> > +             val =3D 0;
> > +     pdata->pwm =3D val;
> > +}
>
> ...
>
> > +static int lm3533_pass_of_node(struct platform_device *pdev,
> > +                            struct lm3533_led_platform_data *pdata)
>
> I think I already saw exactly the same piece of code. Please make sure
> you have no duplications.
>
> > +}
>
> ...
>
> >       pdata =3D dev_get_platdata(&pdev->dev);
> >       if (!pdata) {
> > -             dev_err(&pdev->dev, "no platform data\n");
> > -             return -EINVAL;
> > +             pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KE=
RNEL);
> > +             if (!pdata)
> > +                     return -ENOMEM;
> > +
> > +             ret =3D lm3533_pass_of_node(pdev, pdata);
> > +             if (ret)
> > +                     return dev_err_probe(&pdev->dev, ret,
> > +                                          "failed to get led device no=
de\n");
> > +
> > +             lm3533_parse_led(pdev, pdata);
>
> Ditto.
>
> >       }
>
> ...
>
> > -     led->cdev.name =3D pdata->name;
> > +     led->cdev.name =3D dev_name(&pdev->dev);
>
> Are you sure it's a good idea?
>
> ...
>
> > -     if (!pdata->als)
> > +     if (!pdata->num_als)
> >               return 0;
> >
> > -     lm3533_als_devs[0].platform_data =3D pdata->als;
> > -     lm3533_als_devs[0].pdata_size =3D sizeof(*pdata->als);
> > +     if (pdata->num_als > ARRAY_SIZE(lm3533_als_devs))
> > +             pdata->num_als =3D ARRAY_SIZE(lm3533_als_devs);
>
> Looks like you want
>
>         pdata->num_als =3D clamp(pdata->num_als, 0, ARRAY_SIZE(lm3533_als=
_devs));
>         if (!pdata->num_als)
>                 return 0;
>
> instead of the above. You would need minmax.h for that.
>
> ...
>
> > +     if (pdata->leds) {
>
> This is strange. I would expect num_leds =3D=3D 0 in this case
>
> > +             for (i =3D 0; i < pdata->num_leds; ++i) {
> > +                     lm3533_led_devs[i].platform_data =3D &pdata->leds=
[i];
> > +                     lm3533_led_devs[i].pdata_size =3D sizeof(pdata->l=
eds[i]);
> > +             }
> >       }
>
> ...
>
> > +static void lm3533_parse_nodes(struct lm3533 *lm3533,
> > +                            struct lm3533_platform_data *pdata)
> > +{
> > +     struct fwnode_handle *node;
> > +     const char *label;
> > +
> > +     device_for_each_child_node(lm3533->dev, node) {
> > +             fwnode_property_read_string(node, "compatible", &label);
> > +
> > +             if (!strcmp(label, lm3533_bl_devs[pdata->num_backlights].=
name))
> > +                     pdata->num_backlights++;
> > +
> > +             if (!strcmp(label, lm3533_led_devs[pdata->num_leds].name)=
)
> > +                     pdata->num_leds++;
> > +
> > +             if (!strcmp(label, lm3533_als_devs[pdata->num_als].name))
> > +                     pdata->num_als++;
> > +     }
> > +}
>
> Oh, I don't like this approach. If you have compatible, you have driver_d=
ata
> available, all this is not needed as it may be hard coded.
>
> ...
>
> >       if (!pdata) {
>
> I would expect actually that legacy platform data support will be simply =
killed
> by this patch(es). Do we have in-kernel users? If so, they can be easily
> converted to use software nodes, otherwise we even don't need to care.
>
> > -             dev_err(lm3533->dev, "no platform data\n");
> > -             return -EINVAL;
> > +             pdata =3D devm_kzalloc(lm3533->dev, sizeof(*pdata), GFP_K=
ERNEL);
> > +             if (!pdata)
> > +                     return -ENOMEM;
> > +
> > +             ret =3D device_property_read_u32(lm3533->dev,
> > +                                            "ti,boost-ovp",
> > +                                            &pdata->boost_ovp);
> > +             if (ret)
> > +                     pdata->boost_ovp =3D LM3533_BOOST_OVP_16V;
> > +
> > +             ret =3D device_property_read_u32(lm3533->dev,
> > +                                            "ti,boost-freq",
> > +                                            &pdata->boost_freq);
> > +             if (ret)
> > +                     pdata->boost_freq =3D LM3533_BOOST_FREQ_500KHZ;
> > +
> > +             lm3533_parse_nodes(lm3533, pdata);
> > +
> > +             lm3533->dev->platform_data =3D pdata;
> >       }
>
> ...
>
> > +static const struct of_device_id lm3533_match_table[] =3D {
> > +     { .compatible =3D "ti,lm3533" },
> > +     { },
>
> No comma in the terminator entry.
>
> > +};
>
> ...
>
> > +static void lm3533_parse_backlight(struct platform_device *pdev,
>
> pdev is not actually used, just pass struct device *dev directly.
> Same comment to other functions in this change. It will make code more
> bus independent and reusable.
>
> > +                                struct lm3533_bl_platform_data *pdata)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     int val, ret;
> > +
> > +     /* 5000 - 29800 uA (800 uA step) */
> > +     ret =3D device_property_read_u32(dev, "max-current-microamp", &va=
l);
> > +     if (ret)
> > +             val =3D 5000;
> > +     pdata->max_current =3D val;
>
> > +     /* 0 - 255 */
> > +     ret =3D device_property_read_u32(dev, "default-brightness", &val)=
;
> > +     if (ret)
> > +             val =3D LM3533_BL_MAX_BRIGHTNESS;
> > +     pdata->default_brightness =3D val;
>
> Isn't handled by LEDS core?
>
> > +     /* 0 - 0x3f */
> > +     ret =3D device_property_read_u32(dev, "pwm", &val);
> > +     if (ret)
> > +             val =3D 0;
> > +     pdata->pwm =3D val;
> > +}
>
> ...
>
> > +static int lm3533_pass_of_node(struct platform_device *pdev,
> > +                            struct lm3533_bl_platform_data *pdata)
> > +{
>
> 3rd dup?
>
> > +}
>
> ...
>
> >       pdata =3D dev_get_platdata(&pdev->dev);
> >       if (!pdata) {
> > -             dev_err(&pdev->dev, "no platform data\n");
> > -             return -EINVAL;
> > +             pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KE=
RNEL);
> > +             if (!pdata)
> > +                     return -ENOMEM;
> > +
> > +             ret =3D lm3533_pass_of_node(pdev, pdata);
> > +             if (ret)
> > +                     return dev_err_probe(&pdev->dev, ret,
> > +                                          "failed to get backlight dev=
ice node\n");
> > +
> > +             lm3533_parse_backlight(pdev, pdata);
> >       }
>
> Ditto.
>
> > -     bd =3D devm_backlight_device_register(&pdev->dev, pdata->name,
> > -                                     pdev->dev.parent, bl, &lm3533_bl_=
ops,
> > -                                     &props);
> > +     bd =3D devm_backlight_device_register(&pdev->dev, dev_name(&pdev-=
>dev),
>
> I'm not sure the dev_name() is a good idea. We usually try to rely on the
> predictable outcome, something like what "%pfw" prints against a certain =
fwnode.
>
> > +                                         pdev->dev.parent, bl,
> > +                                         &lm3533_bl_ops, &props);
>
> ...
>
> Also I feel that this change may be split to a few separate logical chang=
es.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Acknowledged, thank you.

