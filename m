Return-Path: <linux-iio+bounces-14589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04511A1D292
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 09:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD2C1665E2
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630B1FCCE3;
	Mon, 27 Jan 2025 08:55:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775E523A;
	Mon, 27 Jan 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968100; cv=none; b=aY/6D9SoWPchZSrNIxoNj2jUJwCfRhCirDHL3/PpH+0/5wdChw2fo1AqF4amMq8Uh9xLvWi5xH/R9XI2TTibE0JWHg4Myhw+tECGd+sALTIisqu1E/FF5iwtqeGVMJ4i8WXXLrcwx+B4y5tpTUzF+1SQPFxMrR6EB7XBFbT2YKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968100; c=relaxed/simple;
	bh=w7D5N8qaPxjCUDBB//DcNVFc8bi7mUOcdRtWpJ74uBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGGlhEfX1nfMqmSSXNaJW8+S2iyJozGUEaWubiO9l/99g3/vX4Tzy+uDvnoIVC9ZGu7gD2kjaGr+6ScZXrlR6IlODyN6eIfVvm1FeIu15aE6BmX15zRdxqWylfx0UbjUW5TyzHwOTBTRfjRrnHAqebe5l0yIOq9uIg3iMMp04T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4b24bc0cc65so2600649137.2;
        Mon, 27 Jan 2025 00:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737968095; x=1738572895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9F+TxAK59NeECzWaCSq6LsZiiaeXm1m0Z32HekzxZw=;
        b=MhqnSRfo8YD8ZqvgnERDoAPVsv/qrk0HT2kvAw8xI/xfRYKQAKg4FqofKcoL9QJ96W
         AA490Vql6ZYfJyYjrvmFt07OYokAFMpMraITPtv45lhF+c6Vg0dXnTuphzXp/7mOgYkC
         X+TkyAypIXSSYohUuB542m18KohvdtmJ542xFZBLRWnJstpOh6oMGmQfX+14BuJWEbcZ
         3V5KjDRmY6xuouQNRDpVAewo7FPBaqY9shfr0rRIzf6RAJs8PwTSw1ubuq82UOnXT13q
         +NB17k9uqw8kvEbHRqho+JI5cbAfKqbHoGpffk/3H2ek5/3Yz4nc9ZPS/s+wZ1OAV3EZ
         3c1w==
X-Forwarded-Encrypted: i=1; AJvYcCUhBwDEQJyMUOU4h2GFZoUvoYvOOQM8ZwGpCEdnsEGln4AsVtxb0uaZg70mUN1G6UY5P6IZHUawC5AbLYDsTZbXRCQ=@vger.kernel.org, AJvYcCVXh8sIisUbj1QnkEsTpWjHVIBCHdiVv5/UOqisbhz27yB3so3CfVRZQHTHjxJec4br7WXr2ukTVNA=@vger.kernel.org, AJvYcCW9mulWj73ipMKKxLzkJ16cUSi7RHLVMPv4gAZj0wNu9OCyCwmSYq5b5cS2qy8dd7lTVClQd724T/Jy@vger.kernel.org, AJvYcCWWFYaTidJ7H3xqUfs0CheMgttphx15ZLXNhSl5ecVNRZWLDMf/dRmhJYBOJGG6dqhGYF5RQvHo2+VE6DSy@vger.kernel.org, AJvYcCWtVodnshkpoV/e38SFTGBRLko5cdCbjNrk76ykFbQ/WN0s4zmGxdUFjuT8FCsJcqQJJV+6p/rUwjfF@vger.kernel.org, AJvYcCXRN96L/ARi0POF4VG/q6m/0yPj0C28t5/2kpL+VmhoSkocXVqi7iwANaCs4cRdKPfI5Ke9UVpFWObB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/sz6AFXZXeofxylVuRr9oh+yG4dFMLf/D+LabNLDWsL5TuUCl
	Sa1IOENtPoNmsG33wf2sLdXe59fHzqPKG9R0FTYQNplhWjxMMWSMAu7/beqG
X-Gm-Gg: ASbGncvhHp7SmphAIEe8oZIjX36ybu7N0aC9pA54PnIqKvQAjVS0yPXYF5WHYcom+tj
	SQEZHDqaoHFANvzCaJkidHRw5s5nLIHfTxxtyPm7/mbTHMcw6H+fohmqEgNYnFhYJbaEZVjHLJ5
	xeE7+Vi3ZAkSNPuyWXEy4uHTd9UHNFmGe2IPfBabL/ad4bGbmURNNEw0wzmdg9V2YYD6iAafEDh
	oP0SNqkLOqDzMp395bbsFag8BuFyzVEjWhlJ2ouwVv21aAU0JjLu/oZzvh4iH1m6iGcCanBKj8t
	7kctGUcIvFgy+DQGduKgXaNSnISCAwFacJJximH7tvk=
X-Google-Smtp-Source: AGHT+IEmXWPr1mWdfyYO+NB7t6TU7PQv0Krx+fA/Np1pNPvgxvxulgCCPayjeS8XFqMBahVip4Mdiw==
X-Received: by 2002:a05:6102:5712:b0:4b6:1ce1:30a3 with SMTP id ada2fe7eead31-4b690b7b9b4mr31161394137.4.1737968095081;
        Mon, 27 Jan 2025 00:54:55 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-864a9c17e26sm1797648241.26.2025.01.27.00.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 00:54:54 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4b24bc0cc65so2600625137.2;
        Mon, 27 Jan 2025 00:54:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXqch0ZBl5bLDQm3KqbPCb/DQ2mNET+XAd+DxCaWLMN9z3DspPEZi3C7dcRv8vUa9eBfPJRjLgDZbB@vger.kernel.org, AJvYcCW7bCFD6MYDAiStxYxCCx9PKO3sMuxhTHTlu7y9P9UpHJD3MHVLZ1RIcMp5aJtqT/Nlqo8yKCfIMlpgx3HW@vger.kernel.org, AJvYcCWb4+4gYEWzZ6ivK6RNIu4vkh1Ar/vjDMEXQRaoRdYB9LJO5xJz/lpNybvRu9rSNs+TtF1TCdHdQgnwfLCvATAdbjU=@vger.kernel.org, AJvYcCWujaGS0/jQDBMvHnxTD4LL0DuxmlM3EECqFhszzBCP605XiyLrK3k3Y59X+yoJWbJNhgOoHBDLuqOl@vger.kernel.org, AJvYcCX3Od/75zhUVSsRhddK6eLj+F4h/82j4SF9BJN7BLH9M5pgkuktzXUYsX6HHmhD8AYL9dQI6eHJLR5S@vger.kernel.org, AJvYcCXk0AlBi8HcgBHoATm2BxVF/WG7pClt1hjKJI5tw33Vhk6p2vbCevHcejHyjhXAO+boRAwtQkMKiFE=@vger.kernel.org
X-Received: by 2002:a05:6102:cc7:b0:4af:f8b9:bea3 with SMTP id
 ada2fe7eead31-4b690c133femr33227684137.15.1737968094127; Mon, 27 Jan 2025
 00:54:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103163805.1775705-1-claudiu.beznea.uj@bp.renesas.com>
 <20250103163805.1775705-5-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdUDKFRsZWsZG9DY4PHdxQEDoPqzfeRx8MNTreOpxdLvpw@mail.gmail.com>
 <20250125121826.6abbe7de@jic23-huawei> <3c7f5a92-254c-4ce1-9813-80c98c1f549e@tuxon.dev>
In-Reply-To: <3c7f5a92-254c-4ce1-9813-80c98c1f549e@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Jan 2025 09:54:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUPPTyuJuWDEuHFT8EQCTVpy5=UtDh9GajdWUvZBNqy0g@mail.gmail.com>
X-Gm-Features: AWEUYZlBCMBeiGGvD1sWSlFCz6506_HlXAlHnEL_mbLHnwjAY1mMPTgOEuwKsRo
Message-ID: <CAMuHMdUPPTyuJuWDEuHFT8EQCTVpy5=UtDh9GajdWUvZBNqy0g@mail.gmail.com>
Subject: Re: [PATCH 4/6] thermal: renesas: rzg3s: Add thermal driver for the
 Renesas RZ/G3S SoC
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Jonathan Cameron <jic23@kernel.org>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, ulf.hansson@linaro.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Mon, 27 Jan 2025 at 09:33, Claudiu Beznea <claudiu.beznea@tuxon.dev> wro=
te:
> On 25.01.2025 14:18, Jonathan Cameron wrote:
> > On Wed, 22 Jan 2025 11:29:19 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> On Fri, Jan 3, 2025 at 5:38=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.d=
ev> wrote:
> >>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> The Renesas RZ/G3S SoC features a Thermal Sensor Unit (TSU) that repo=
rts
> >>> the junction temperature. The temperature is reported through a dedic=
ated
> >>> ADC channel. Add a driver for the Renesas RZ/G3S TSU.
> >>>
> >>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Thanks for your patch!
> >>
> >>> --- /dev/null
> >>> +++ b/drivers/thermal/renesas/rzg3s_thermal.c
> >>
> >>> +static int rzg3s_thermal_probe(struct platform_device *pdev)
> >>> +{
> >>> +       struct rzg3s_thermal_priv *priv;
> >>> +       struct device *dev =3D &pdev->dev;
> >>> +       int ret;
> >>> +
> >>> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >>> +       if (!priv)
> >>> +               return -ENOMEM;
> >>> +
> >>> +       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> >>> +       if (IS_ERR(priv->base))
> >>> +               return PTR_ERR(priv->base);
> >>> +
> >>> +       priv->channel =3D devm_iio_channel_get(dev, "tsu");
> >>
> >> Given there's only a single IIO channel, you could pass NULL instead
> >> of the name, and drop "io-channel-names" from the DT bindings.
> >> I don't know what's the IIO policy w.r.t. unnamed channels, though.
> >
> > It's supported, so fine as long as no future additional names show up.
> > Will just fallback to index 0 I think.
>
> If everyone agrees, I would keep the name, too, to avoid complications in
> case this IP variant will be extended on future SoCs.

Fine for me.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

