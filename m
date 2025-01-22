Return-Path: <linux-iio+bounces-14527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250EA18FBD
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 11:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21449168830
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 10:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B89D211499;
	Wed, 22 Jan 2025 10:29:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD121129B;
	Wed, 22 Jan 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541775; cv=none; b=pjePbeRiU462UVTeK+XGkRmFcABurBEOcql9s0P9ebjausvdcfAL3+XA02IKLd9d9n7vBBldACMek3puvRadioThbQFp3BZDcBp3XxRKQFJ5TC+hG/z4ojsdEkBNUO/RDbLSZxXYRWhEpS+EqEnR9hXiwrvGwJm7UAjdAvJQpJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541775; c=relaxed/simple;
	bh=TXOwZazcEhIFM7pPZJa/kJoekfsRA/+vx6rpt9Apmjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNCuuDkIRLNkhRVMiYLSkEnCz/8TJUJdYXnqOPvWJBJqGxj1Uf+aho9c8g5itG7z98epUthNFsR/IDECIXGkYjRZ/Rp4ImBK7KPU6VTFCVKw4V/0ikeX3+6oTkantt1/Ptgd3sZ2gO6oa48EPH3KIkDEjptaaWgFvRM/FOBZudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4affab62589so1902446137.1;
        Wed, 22 Jan 2025 02:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737541771; x=1738146571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVxMUkk0amVJCc0EMm757pTzTOt048b6a2IjjsuaC3w=;
        b=ZvxrO/uEaNbiGqlLDiotEN98T5no/M6soa7SRs+EAgow9g8fo5UCKbgAskmkM1cdX4
         /DI73P0I/GvLcPoqZUmjLUTNw7yEtQ9RInnkLViQLxssj9MUvhfnhrfxRLgvu2TheTM6
         hJ4qo2I6cKDEyD7TLWEzmqipaLn9zG6h5Kcu+ypN0dS63HM0LDaHdncTArihRrBifn80
         YH+S8CyBVdtqyCiYF70U/g2+ccKhKKM7nZ+6poFliF3AqUXpeRqbM3bBlcIqCgM592Rs
         KP3OQGh3e7IBR5U3GbgCI+PqUFhL8TSrmYmitxjk1KiJiHrcTeev2KnJQpLNm45q87WC
         edZA==
X-Forwarded-Encrypted: i=1; AJvYcCV3gQBOoFZF/ctBq82vxO3nFK/W/4vt62Tis0tGhhmNiuSj/SwEXF+AwZ7s5a5c0OP5gus7+Vaizz8d06uMaYViZk0=@vger.kernel.org, AJvYcCWDYAu2emc4rNw46gvYpd5c0e9+uBnrdh6anoo5+x9+ww17xGbf98EKiTkcDWJ110rSQ0eMcG3Ai5mS@vger.kernel.org, AJvYcCWdA9wh7a+UBU6Gud2NUauziwJD4MXGsebTGptA7nyqa3LRh/0WGT+M8NamuRp5gNMZJ1sVDrRmnsB4@vger.kernel.org, AJvYcCWjSLvQB3twXIhMh8wLxyS+PCj9Ky/RY/shBISaPh+BhDwCxl9qXcKPWiWA/XyAz0v+k8qvyTkt9RnZ5MIY@vger.kernel.org, AJvYcCX0bULNRTrpNqNYAzAdsscXA4dt9O6JenoUbMJS+CHFDPzHpsA5CsqJ++1Se9dEucs7u7+wH2Zg3ao=@vger.kernel.org, AJvYcCXf2B+638g1gBOT+IbFPaR6p7Ihhq8srdQj2H8xA1NqurHGKICkAQVhkPOxJxke8aLK5NuRMEslf+iA@vger.kernel.org
X-Gm-Message-State: AOJu0YykC5VzXOeBcX6C5umMpyMNEIVMgu8U1AT1MGwU9aW026+tDusI
	/AhVOCA5oBslpBOx2tPex9Q8PQk9fao9zAozVBHwSDP8y1q0NFsLTcJNQk2h
X-Gm-Gg: ASbGncs3EsehvLhJWwBob4/LEOrHQaMC3va52lR+KAYhsSh3Aqfdq/U0RIadgkLbyWS
	FCu9a4aYxBFWOP+ig2P14rJhuomeQc4pi+pjKvQ/U/vQoaq0kHHUWXP46XwUQ6cnwwkVoFaT2zl
	mEERrsTG0Hc/63MFGAr4KwMkE/ftcChdeRzxqOmb7U/ravFxCiMok7sxLOC+Vfp02hbOoBj3heU
	SKyKwCPHAj6qMipKdW0quyYMN2IHTfm8e/jUILZzWmrmQALz+zsp5QLujP/2ynYZrNyNVol3Z1n
	lDk6rgr1dhFAyUW1iaU75XyKBrdujxnN
X-Google-Smtp-Source: AGHT+IEIzvbV18Y9GvDdc3JwF3ybkJJI1npsZ00wLAADbIN8fOFgE+2139WVGpI03nh9GryI194M6w==
X-Received: by 2002:a05:6102:c52:b0:4b4:27dc:ffef with SMTP id ada2fe7eead31-4b690be5835mr14951156137.14.1737541771590;
        Wed, 22 Jan 2025 02:29:31 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8642cb09838sm2976478241.16.2025.01.22.02.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 02:29:31 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4afed7b7d1bso1938117137.2;
        Wed, 22 Jan 2025 02:29:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9XF61tl96hwJB6wgofh0B2m9dgctd9v2Lg/E6wTv6dRgpaGnfTNo2x07z0oYVHLLbJ/iGFbHf/MDw@vger.kernel.org, AJvYcCVxIt3aeLEqBYxgK6yH6rDznVKAyWbKad2e65rIThIEC7UMls4Zwa8xfwYVHg9DrpcsTmRhlGbSni6NHuEu8V/y7+Y=@vger.kernel.org, AJvYcCWK18gDDD06Bkgh4CnXUNMfX/TckgH+O+suK3Z9lvjPCICr9JPM7fE8XizlXjcDozFDhLzUO1MuWPItI8eH@vger.kernel.org, AJvYcCWNYmUPgqbx8SnwLAjMHshmGKiOxBUPthVdNXmHyY+L3yBDhb2SOJSgqMdcOaFmH2igpkxalMElSB0=@vger.kernel.org, AJvYcCWRjEzonJlyxZyGQQ6HagiWxPZ+6cjL8GHwvPV3pYUkfsKl1/PE0GNDEMWlOopBiiup36ERcf6GOl7+@vger.kernel.org, AJvYcCX4lGrF4hY80EQn7gLmF9t19/WtXHsdiCTgZ+vyqBPZrxXpkU0aMqXaeQ+AaMRDTSY5WIvV675Qk7IX@vger.kernel.org
X-Received: by 2002:a05:6102:50a7:b0:4b2:af6e:5fef with SMTP id
 ada2fe7eead31-4b690babad2mr16700673137.9.1737541770986; Wed, 22 Jan 2025
 02:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com> <20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Jan 2025 11:29:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
X-Gm-Features: AWEUYZnD9dEO21kjbX8q_1wcIS_Gmpp7OlV_wqcigMRQXtVoeDic2BsiIeJXlvQ
Message-ID: <CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
Subject: Re: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the
 Renesas RZ/G3S SoC
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

CC iio

On Fri, Jan 3, 2025 at 5:38=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that reports
> the junction temperature. The temperature is reported through a dedicated
> ADC channel. Add a driver for the Renesas RZ/G3S TSU.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/thermal/renesas/rzg3s_thermal.c

> +static int rzg3s_thermal_probe(struct platform_device *pdev)
> +{
> +       struct rzg3s_thermal_priv *priv;
> +       struct device *dev =3D &pdev->dev;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       priv->channel =3D devm_iio_channel_get(dev, "tsu");

Given there's only a single IIO channel, you could pass NULL instead
of the name, and drop "io-channel-names" from the DT bindings.
I don't know what's the IIO policy w.r.t. unnamed channels, though.

> +       if (IS_ERR(priv->channel))
> +               return dev_err_probe(dev, PTR_ERR(priv->channel), "Failed=
 to get IIO channel!\n");
> +
> +       priv->rstc =3D devm_reset_control_get_exclusive_deasserted(dev, N=
ULL);
> +       if (IS_ERR(priv->rstc))
> +               return dev_err_probe(dev, PTR_ERR(priv->rstc), "Failed to=
 get reset!\n");
> +
> +       priv->dev =3D dev;
> +       priv->mode =3D THERMAL_DEVICE_DISABLED;
> +       platform_set_drvdata(pdev, priv);
> +
> +       pm_runtime_set_autosuspend_delay(dev, 300);
> +       pm_runtime_use_autosuspend(dev);
> +       pm_runtime_enable(dev);
> +
> +       ret =3D rzg3s_thermal_read_calib(priv);
> +       if (ret) {
> +               dev_err_probe(dev, ret, "Failed to read calibration data!=
\n");
> +               goto rpm_disable;
> +       }
> +
> +       priv->tz =3D thermal_of_zone_register(dev->of_node, 0, priv, &rzg=
3s_tz_of_ops);
> +       if (IS_ERR(priv->tz)) {
> +               dev_err_probe(dev, PTR_ERR(priv->tz), "Failed to register=
 thermal zone!\n");
> +               goto rpm_disable;
> +       }
> +
> +       ret =3D thermal_add_hwmon_sysfs(priv->tz);
> +       if (ret) {
> +               dev_err_probe(dev, ret, "Failed to add hwmon sysfs!\n");
> +               goto tz_unregister;
> +       }
> +
> +       return 0;
> +
> +tz_unregister:
> +       thermal_of_zone_unregister(priv->tz);
> +rpm_disable:
> +       pm_runtime_disable(dev);
> +       pm_runtime_dont_use_autosuspend(dev);
> +       return ret;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

