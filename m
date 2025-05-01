Return-Path: <linux-iio+bounces-18923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96095AA58E9
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 02:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390039E6FCD
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 00:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AD211C;
	Thu,  1 May 2025 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXuq7cKE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5416D134BD;
	Thu,  1 May 2025 00:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746057840; cv=none; b=VV+O+c5HxdREbOLpeBAukVw06lsrr4lqvmsgwZkUtjOT/kDU9dzKsbk9XJq1GNUFqhmtvKGimrizBvEBA0Ml4j3+2sFuP30MYG1Ix0fxwUmTb0aCDx/Xa0kh+P63wdbo5GcAOmIB3O8Peyzix0PFM0kxFLjqam68DY6pHEYvR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746057840; c=relaxed/simple;
	bh=M10xuiOCECXNReIlFGalx02n10//HYeZ4fFlOkCVJko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qixks6BhOCLFERA9uM10we9lYd9JqooiihGzv5NLLWFtNi0nHBXbaRm/NjFUvaP2CQSFDTvw1UCDWNx+Z2iTDVi+g3yh9tVI3mdGhEUi2pieO+yQMdutm7kqwbLwTUipsAqEd4qtReIOwbyRJvsQZ39uLZqPKHLb46F+ptfRijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXuq7cKE; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476a2b5dffcso792361cf.3;
        Wed, 30 Apr 2025 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746057836; x=1746662636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UeGfTw1gt4xDthSATw6PmxbO4fBAFGEO3J6t3pVQfv4=;
        b=KXuq7cKE075KktVwQvsDXuRR5uVrZXP8vMxaza+OtvOYNemBedkNAZ+rP6xQ9wo9Mu
         YU3X/9IuSYPGR08Inc8tGQeunqjboMK2lfzFx2Mp6ObR7+FTq3P5z0iEFWcFFh2nAyQC
         XRB2u4VPfaLTS7ZbvLCNCqK8gPoeRNj2NpJatVfAWzg3ZYxvcDzQN8e1NU6FweomPzHN
         TX7SkdmNGLjUJRqLWfk7euEFkPLuZzZXhE5RtpoANnA+uzK/V21QXAN74/DdlM6VJ9PV
         pV2QBfdpQg1XRCX6aAaHU0Q+FzpvLoFrmkcbEvLdp+3+4vyvizHeC6eOTribn//NllU7
         U/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746057836; x=1746662636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeGfTw1gt4xDthSATw6PmxbO4fBAFGEO3J6t3pVQfv4=;
        b=V9jIxEoysWFGNs8cMR/Tz24GLCPkq18Svp88DHDKEs6hD+7oxgd4T4pEpnDPk0Rs9z
         AdU+51zlj5+ZtLi5JXg4fG+4qL2HHWUQ6ge67pEZjBaXGA3KkTQYigW93JRTvC1YnIVJ
         DIauKfcOkHQco4UyzWbWEM8tb5zfs1f1yACwo2kH4ke/ZY1ip47l7TaIpzcgNOMfTa+0
         MsGglAU674EmEAZP4kPlxIC1MkYzHsUolLv1tzmr9wxkgBhJ2gv6hb7iuMaGDqqiWGIs
         pVi0iTGt+574+nQeLU4qQNUjswSgvxyPLH4cEuUY5AO2BOZu0g8ELyQSQPa5jlbRfcv0
         zdMw==
X-Forwarded-Encrypted: i=1; AJvYcCU8uwm/eVFbwTPKwzuIm/Cq+MHr8bkE0atFLqxT1QYrYeq+BaUNhvPxJk5rlFkAY+DTJigA3eOxU3cYag==@vger.kernel.org, AJvYcCVb/1pW1ex04VVSdAasVjU3QuN3/MJFK7W9JPeGq3aioK2W159XD/Bd19WoY+C2pbvVPvuSCfdc2Tao@vger.kernel.org, AJvYcCXYtWvwx8uX7xwypurXryUMUcVPnXuDXhQ1Jlj5jegIujDYitxigfOTWnthndBN2SOXdxwgRVEDVS910jAV@vger.kernel.org, AJvYcCXeTuQKLefNj4A5ZGsCRuWaICJTk0hYPMYW8G2UuNrynYCdR3QnlNsB2fPHCx9DPatOL6yp4OS37E0U@vger.kernel.org
X-Gm-Message-State: AOJu0YznBDnU+A/xgWo3zngSUF5WFFYy3Dtu+Q4Uox9dHDj8aaE80LPW
	vuyfocyG115N/tzi5CLzTOHmvgChrE/zbIQbah5gA+vKAaBblhnE
X-Gm-Gg: ASbGnctpYMkZS6FqVLpNBR88w6j+4Od0hefh4glIl7ap129N0GFa8A7lbEqC2fI4rYJ
	Y5dMbHcn5h1x4d9uzk5JF6kElAgTDpoLgHmp2ucXZvacbmIrqPgqrWgeMzoeCgsjwBVrGUmr8AD
	/YlA0aKHSP16hRWyjPybtdxsuA0O36LNoTx+3vPwxTxdZEbHm2lKLIe1GjA8MWBfFcCpfelSbLr
	VTldR4LnD4fsMSHhRzPtfEEoc6aAAw2ygcRSydqO/6Rylgo+KGZJK4juDQJchBtKhqluslLPx/x
	+hqeO65ZDk0Cn1siiJbFlxtT+qxeIBwFdhGDXT2vVTiNggl2tpSaPiOWQLnVeA==
X-Google-Smtp-Source: AGHT+IFe0FzdLQIprF16C52vp9PvPRKmvD0jPHOEB8bQQ72ps0/+8ln3yZP5Af1ifzhS+7suBE0emQ==
X-Received: by 2002:a05:6214:5183:b0:6e8:9351:77f8 with SMTP id 6a1803df08f44-6f4ff5eac65mr23049506d6.7.1746057835921;
        Wed, 30 Apr 2025 17:03:55 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4fe6ad5efsm14469276d6.11.2025.04.30.17.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 17:03:55 -0700 (PDT)
Date: Wed, 30 Apr 2025 21:03:50 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v6 08/11] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <aBK6Zlx71Aeihue/@JSANTO12-L01.ad.analog.com>
Reply-To: CAHp75VdNymzseF7Dt9kL8GBPLM0MGBQg-YQabKUKxEryM8nxOQ@mail.gmail.com
References: <cover.1745605382.git.Jonathan.Santos@analog.com>
 <c5a5376a6ffbb571d7874218494b04fd20015ee9.1745605382.git.Jonathan.Santos@analog.com>
 <CAHp75VdNymzseF7Dt9kL8GBPLM0MGBQg-YQabKUKxEryM8nxOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdNymzseF7Dt9kL8GBPLM0MGBQg-YQabKUKxEryM8nxOQ@mail.gmail.com>

On 04/28, Andy Shevchenko wrote:
> On Mon, Apr 28, 2025 at 3:14 AM Jonathan Santos
> <Jonathan.Santos@analog.com> wrote:
> >
> > The synchronization method using GPIO requires the generated pulse to be
> > truly synchronous with the base MCLK signal. When it is not possible to
> > do that in hardware, the datasheet recommends using synchronization over
> > SPI, where the generated pulse is already synchronous with MCLK. This
> > requires the SYNC_OUT pin to be connected to SYNC_IN pin.
> 
> to the SYNC_IN
> 
> > Use trigger-sources property to enable device synchronization over SPI
> > and multi-device synchronization, as an alternative to adi,sync-in-gpios
> > property.
> 
> ...
> 
> > +static int ad7768_send_sync_pulse(struct ad7768_state *st)
> > +{
> > +       if (st->en_spi_sync)
> > +               return regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x00);
> 
> > +       if (st->gpio_sync_in) {
> 
> Dup check, the following have already it.
> 
> > +               gpiod_set_value_cansleep(st->gpio_sync_in, 1);
> 
> Yes, I see the original code, but still the Q is why no delay. Perhaps
> a comment explaining that the GPIO op is slow enough (?) to add.
> 

Datasheet specifies a minimum of 1.5*Tmclk pulse width. For the
recommended mclk of 16.384 MHz, it usually takes 4 times the minimum
pulse width. If it can be less than that for other plataforms I can add
this delay.

> > +               gpiod_set_value_cansleep(st->gpio_sync_in, 0);
> > +       }
> > +
> > +       return 0;
> > +}
> 
> ...
> 
> > +static struct gpio_desc *ad7768_trigger_source_get_gpio(struct device *dev,
> > +                                                       struct fwnode_handle *fwnode)
> > +{
> > +       const char *value;
> > +       int ret;
> > +
> > +       ret = fwnode_property_read_string(fwnode, "compatible", &value);
> > +       if (ret)
> > +               return ERR_PTR(ret);
> > +
> > +       if (strcmp("gpio-trigger", value))
> > +               return ERR_PTR(-EINVAL);
> 
> Reinvention of fwnode_device_is_compatible().
> 

Thanks!

> > +       return devm_fwnode_gpiod_get_index(dev, fwnode, NULL, 0,
> > +                                          GPIOD_OUT_LOW, "sync-in");
> > +}
> 
> ...
> 
> > +static int ad7768_trigger_sources_get_sync(struct device *dev,
> > +                                          struct ad7768_state *st)
> > +{
> > +       struct fwnode_reference_args args;
> > +       struct fwnode_handle *fwnode = NULL;
> 
> Redundant assignment AFAICS.
> 
> > +       int ret;
> > +
> > +       /*
> > +        * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> > +        * to synchronize one or more devices:
> > +        * 1. Using an external GPIO.
> > +        * 2. Using a SPI command, where the SYNC_OUT pin generates a
> > +        *    synchronization pulse that drives the SYNC_IN pin.
> > +        */
> > +       if (!device_property_present(dev, "trigger-sources")) {
> > +               /*
> > +                * In the absence of trigger-sources property, enable self
> > +                * synchronization over SPI (SYNC_OUT).
> > +                */
> > +               st->en_spi_sync = true;
> > +               return 0;
> > +       }
> > +
> > +       ret = fwnode_property_get_reference_args(dev_fwnode(dev),
> 
> In this case the above is better to be also fwnode_property_present().
> You save a double call to dev_fwnode().
> 
> > +                                                "trigger-sources",
> > +                                                "#trigger-source-cells",
> > +                                                0,
> > +                                                AD7768_TRIGGER_SOURCE_SYNC_IDX,
> > +                                                &args);
> > +       if (ret)
> > +               return ret;
> > +
> > +       fwnode = args.fwnode;
> > +       /*
> > +        * First, try getting the GPIO trigger source and fallback to
> > +        * synchronization over SPI in case of failure.
> > +        */
> > +       st->gpio_sync_in = ad7768_trigger_source_get_gpio(dev, fwnode);
> > +       if (IS_ERR(st->gpio_sync_in)) {
> > +               /*
> > +                * For this case, it requires one argument, which indicates the
> > +                * output pin referenced.
> > +                */
> > +               if (args.nargs < 1)
> > +                       goto err_not_supp;
> > +
> > +               if (args.args[0] != AD7768_TRIGGER_SOURCE_SYNC_OUT)
> > +                       goto err_not_supp;
> > +
> > +               /*
> > +                * Only self trigger is supported for now, i.e.,
> > +                * external SYNC_OUT is not allowed.
> > +                */
> > +               if (fwnode->dev == dev) {
> 
> ?!?! What is this?!
> 
> For the reference:
> https://elixir.bootlin.com/linux/v6.15-rc3/source/include/linux/fwnode.h#L51
> 

I see, my bad. I will follow David's suggestion, so we will avoid this.

> > +                       st->en_spi_sync = true;
> > +                       goto out_put_node;
> > +               }
> > +
> > +               goto err_not_supp;
> > +       }
> > +
> > +       goto out_put_node;
> > +
> > +err_not_supp:
> > +       ret = dev_err_probe(dev, -EOPNOTSUPP,
> > +                           "Invalid synchronization trigger source");
> 
> Missing \n, and can be one line anyway (we don't complain about long
> strings ending with string literals for ages, way before the 100
> character limit).
> 
> > +out_put_node:
> > +       fwnode_handle_put(args.fwnode);
> > +       return ret;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko

