Return-Path: <linux-iio+bounces-5747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AE08FB0FA
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 13:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFF91F232FB
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6651459F7;
	Tue,  4 Jun 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX2Kh/Tc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA0144D3A;
	Tue,  4 Jun 2024 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500086; cv=none; b=agCebmFVZqVVykjZdBjHdoECnJHF00+WYjGfmHdwOS0MppyeRbR4HDyJZRyqsdOUkA+RVAMoCevxbU5nFsVsxn7mrgNyTu9G4f1RR6v0mb4HmfMwggq4686ZVS/MLFKEAiKOp0Wudepe61BtYVN+lvckYYIAGyS46sWxwr2htOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500086; c=relaxed/simple;
	bh=rHoXvNrwjIP2WzxwsgTovVhjxeyV5A1kiJuhbsHCv/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1vAiwF9S7zFjF8o5K4pf9xX/qFYY1yyDzmxihp5lqPbWLU2g4V60fF9Lx4Hh9RQNtroG12ZfbI+Da5Kx7ai3xvEeam+/o2noQuDkTGhsjUUQpxjk8QaBcl82q+TCD0Aa7x/WlZCDFuixKCKrTNHYkXauQO+YracHB2Pz8IYogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX2Kh/Tc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68c5524086so88086666b.3;
        Tue, 04 Jun 2024 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717500082; x=1718104882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLLl70Z79LCpLtPtJ575VgA7J6GLp1vLgjnBpq24JHU=;
        b=KX2Kh/TcqIYTT0S94fuRq7vNc8qBfmLedz6GFvNo6H3wIBVKpQA3rZnSTcDy1r/SBH
         S3PHT87kUtAMDQLq+4v67spLdPLwYui8+mKXAiAO8IwwC3Uh5Vzodub0/ClZrFphSrzC
         BR8jbOqdLvPFrcZK3Yi8oqVC3C2xWiFvQWbjX703S3xSvnzsB65dV8m2+sDFywLuxpmI
         wUYh6sSYnQ+66LVoydaplw+Q35Q213XqsgdH5ReJ34ZtsxkelcFIUJzkYviL2z/E4wgx
         QBBCV7thTcqGpwvL3gEcQOa7P1qEj6OYK9Sc8I9g1dAXbyB3fL7Ws50lDyF41tOAa7Ib
         0YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717500082; x=1718104882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLLl70Z79LCpLtPtJ575VgA7J6GLp1vLgjnBpq24JHU=;
        b=Wu+5ec/RPqvWTDkXP9nWvDTqumbyQB+7vekrZLs65TDIa0WmBiRZIX7jICE1cVFouC
         TbC6BgpWX/RMuPOVcTAFzji7vcPyvAv1OGrQnUnlYraoZGcy6eRrY1/IMlgaQxpG0usB
         Q/jOhyww6FiOpayZSXUMleaTe9tJXMbtvRo0Z+clVV2hPHTTPN74Ut257qVc7KzgnQ/v
         Vgl/0n8IBkzLoZeK0yOcLCUES1mE4ppEn4Lg8YaGXcKqi92t53Q5TjSCDmjl/JskanQI
         LHF1QgR0Esse3RaQHaCY9rOxvJTRngW8V4BT33KdYx5tutDATHAlBB7ywO0WN6VC1OGG
         xUYg==
X-Forwarded-Encrypted: i=1; AJvYcCXyzfJyFiBS8WWNDYpqOArdLS7EE73XaUsXpZ85S4xnBhKUH2C6cfqHD/xdc5cF3644r0DrBZ8YIrC1+x24sEzasRlrMXGl1X/diAMGjvd5ty/0NzgGuEMZvf6HIGdMai6kgcTOGtnE+CIWwZ6rpkinyqeZTTNpA5urgpnNcm/GfvM5ZQ==
X-Gm-Message-State: AOJu0Yz4zNoGIstfiIkAFWKlzhU5q8TIKsIOEHsVsSo0n+mzFJDXMqLk
	RCGlaDl+VO+SUbhFv0gcYJjpGSLFWhlgYQWM76NtroYkh53qFXbsoMMdvcCInvsUfmZdtB5TQoY
	4X0AorklfAM2flXC7s5Aa5k6amds=
X-Google-Smtp-Source: AGHT+IGC27OT+Zq/I/Lv8Mjaw8iKiBSCJHrirdp6dMLOxtJiM85gRnwSXrr6BrqJ3fjj0DmaEcJRImuGGlsGaqRBY/g=
X-Received: by 2002:a17:907:6d02:b0:a68:ed0b:8924 with SMTP id
 a640c23a62f3a-a68ed0b89b4mr502547266b.16.1717500082083; Tue, 04 Jun 2024
 04:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
 <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
 <20240602111141.0058f39e@jic23-huawei> <60e55919-2a8c-4d83-89a1-6e4ae156d34d@collabora.com>
 <CAHp75Vf5a8VVyOXQRt9P1QnM6GHZ3rLuvnBF63H_83QBHOTJ9w@mail.gmail.com>
In-Reply-To: <CAHp75Vf5a8VVyOXQRt9P1QnM6GHZ3rLuvnBF63H_83QBHOTJ9w@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jun 2024 14:20:44 +0300
Message-ID: <CAHp75VdJRCnxEQDXsEi3yRcPvX9-JLUVkbm_Fd6YFnrHWYb1VQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9
 Auxiliary ADC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com, 
	marius.cristea@microchip.com, marcelo.schmitt@analog.com, fr0st61te@gmail.com, 
	mitrutzceclan@gmail.com, mike.looijmans@topic.nl, marcus.folkesson@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 1:55=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 4, 2024 at 12:42=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> > Il 02/06/24 12:11, Jonathan Cameron ha scritto:
> > > On Thu, 30 May 2024 11:34:08 +0200
> > > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =
wrote:

...

> > > What are IMP channels?
> >
> > Honestly? Well, it's called like that. I don't have any clear descripti=
on of that
> > and not even datasheets are unrolling the meaning of "IMP". So.. I don'=
t know.
> >
> > What I know is what I wrote in the driver, and this is:
> > * IMP has IBAT and VBAT ADCs
> > * It needs different handling from the other ADCs, as shown.
> >
> > ...and nothing else :-(
>
> I could speculate with confidence that this means IMPedance (since it's A=
DC).
>
> From MTK6329  datasheet:

The datasheet for MTK6359 I found on
https://ebin.pub/qdownload/mt6359-pmic-datasheet-15nbsped.html
also has the same wording in "3.2.7 Fuel Gauge".

> "The hardware also includes necessary modes to allow for simultaneous
> current and voltage measurement
> which can be utilized to estimate the battery impedance."
> And googling vendor trees also suggests the same.

--=20
With Best Regards,
Andy Shevchenko

