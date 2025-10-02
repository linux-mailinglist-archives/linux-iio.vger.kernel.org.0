Return-Path: <linux-iio+bounces-24666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1359BB4811
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 18:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799BE165BC0
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518D258CFF;
	Thu,  2 Oct 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J53OGMWk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51351253F39
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421995; cv=none; b=dpV9FsATLHcBWfjptegTHZQLUmok0FRuD8dBTcGHLugimdfYuBaHyq/qoeuQujsX4XA2lies6VqcK3S23sWvWVXibLZeB3zIb5gPD9rZwDkNonE5m6OW2NT7Uag6R5+GMwlwr0SKK9+icgE1omhN8Xg/4yc5D2Rn6U+cb7gnuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421995; c=relaxed/simple;
	bh=Lr0irlvhfvHdwzVt5sqkWNyNfM8w5CssLQBlywqWjhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVgcm7Kg0Oa1xlxOa+PVCimLauhNYxx1BWc759rJvd/DxjlsQXO6w2OiZmo9a2U/9Zma0PXjPyQhRmmrtHsaP5IFHGA3H/8u6gpVIzaTtzviItJNdmfJRKelz8PpONquVEMDtTrNyxt5Qa4phwpI6Jayxsi6/m8GbFxC8+MK28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J53OGMWk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1374074a91.1
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421993; x=1760026793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZZ5d24XDIxkk+JwavCHmACQ+MmvpDMF7i8UGLWVc1U=;
        b=J53OGMWktO4WrOY4qas/5obLCi3RSlyddNPze7pi971NqYdkqDNi4PDwV7ZncxI248
         vjHmk/2no52jeBSiIx8+vflVEdketiz57qB7W6GQqZkCInAth/v6A7hX+yIYE9S7AfNF
         bZ+zWXLwmW0iHfxMVrvwHTm+6K59VrcLKkk7kfgO2So1Gcm5MJXfHKa4D3FhyO5OB7TB
         0vuxWtd1655w9USfJiSj3+cS8bEReEiBBfHhfKj9Lo4YCSKvD9wmfG7fAbG9X++A+FzD
         qCFeXbaKSCYEUQYDdiNqngpYdvES1VjO99AN0j3ngeHteGjiex4HpxOM3Rq9pqDWH4nS
         Y/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421993; x=1760026793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZZ5d24XDIxkk+JwavCHmACQ+MmvpDMF7i8UGLWVc1U=;
        b=e5agdOBYfKmrQuEfSYjF4HtuBTlF/9Hd019Ye0qgWGZvQwY5z+fExl8GlytAI33TIS
         ipeCivoiqSdbwKawDdRjFChIAW6gY4vFhplUhqtw5XQHq09qBPx14rxW4hFLZKOifzGO
         f+leob6hxKBmRIOCS3fAKFFp/CeXahqu3IT4Yo418+YxiS0VATRd+znqoHGR+bzrbBe0
         LORwSdB2q/xNkh8H3j8cXw9l45bXF5ef7S0etvTFpggdy/ry2bq/ppyYofGNU4t6at0K
         Dt9bnsbK+n0w8yIXLWB6FyyTbUDzeBl2SLoSOIRGpAR1+5MSZ0HbT/cKtYlW6l9rORlq
         wO5g==
X-Forwarded-Encrypted: i=1; AJvYcCWaxV1w/2ZwgSRM3sVJKeX2pjrSYFjflHyonOYuwQ3M2as4yG+Vs0jnQmwJHoREmmjlKPBdWqZUqvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJbX4Aurw42wK7v1I+pgmI6U1rhNSE9FB2H5cCbpe5TrPvy+E
	OfDXmAj8BCApgnFPomYyyXMPysNCotHFYqdYzOd1VC3pnpQlFVF8ei2Hxa0XRZENp2BUskGyMkO
	p0CYZdYioqqvwnfYVDBMjDThhXps0u8Y=
X-Gm-Gg: ASbGncs1n0MMc/lUj1mAVSNH7pftAeSbR2SHSQuD4khR6PZZ56nCdnP6xkKBhHWMZS7
	2Sv2pyrCc6RISw+o5ufphvTWknX/w/bwPCjx3ng7kwmVutYDHbp81EpIsbJjeQpZoBxTH3XRiFJ
	FcDZzQlIqxw+f4Gef7WHNc0pEQPDYaaZyGRTKQPE7hmprkJ6+Qnj50RA6jgziX+AFlZYBIWpQRs
	flmp9xCrYWEiVceomzZwh3PlO7MjT0=
X-Google-Smtp-Source: AGHT+IGDpezXRZoKRUAmvsGEGRKGV3Cca8QMZMZ4Xe0LAt5a7sDWIZ6cqn+OuFMFCBuqxZGgIpVxUstpBqxpNK7ovio=
X-Received: by 2002:a17:90b:3145:b0:32b:ca6f:1245 with SMTP id
 98e67ed59e1d1-339a6e6329fmr8873915a91.5.1759421993437; Thu, 02 Oct 2025
 09:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com> <20250822-enomam_logs-v1-9-db87f2974552@gmail.com>
In-Reply-To: <20250822-enomam_logs-v1-9-db87f2974552@gmail.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:24:49 -0400
X-Gm-Features: AS18NWAkW_WGgw7RLjcHXntiCLOoMqdr7Jd-sVtGc97imtAcuufyjRqKmj5BmR0
Message-ID: <CALC8CXdUzp=sKeOaPnwJ3GWg8=qrXrZKNsKg6XeXxvutty-U-w@mail.gmail.com>
Subject: Re: [PATCH 09/10] iio: proximity: Drop unnecessary -ENOMEM messages
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Support Opensource <support.opensource@diasemi.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andreas Klinger <ak@it-klinger.de>, 
	Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yeah, dicks it.

On Thu, Aug 21, 2025 at 11:53=E2=80=AFPM Dixit Parmar <dixitparmar19@gmail.=
com> wrote:
>
> The drivers do not require their own error messages for error
> -ENOMEM, memory allocation failures. So remove the dev_err
> messages from the probe().
>
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
>  drivers/iio/proximity/ping.c  | 4 +---
>  drivers/iio/proximity/srf04.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
> index c5b4e1378b7d..e3487094d7be 100644
> --- a/drivers/iio/proximity/ping.c
> +++ b/drivers/iio/proximity/ping.c
> @@ -280,10 +280,8 @@ static int ping_probe(struct platform_device *pdev)
>         struct iio_dev *indio_dev;
>
>         indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct ping_data)=
);
> -       if (!indio_dev) {
> -               dev_err(dev, "failed to allocate IIO device\n");
> +       if (!indio_dev)
>                 return -ENOMEM;
> -       }
>
>         data =3D iio_priv(indio_dev);
>         data->dev =3D dev;
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.=
c
> index b059bac1078b..f9d32f9aba1f 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -253,10 +253,8 @@ static int srf04_probe(struct platform_device *pdev)
>         int ret;
>
>         indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct srf04_data=
));
> -       if (!indio_dev) {
> -               dev_err(dev, "failed to allocate IIO device\n");
> +       if (!indio_dev)
>                 return -ENOMEM;
> -       }
>
>         data =3D iio_priv(indio_dev);
>         data->dev =3D dev;
>
> --
> 2.43.0
>
>

