Return-Path: <linux-iio+bounces-20520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3BBAD662B
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 05:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C36417C11A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674161DED64;
	Thu, 12 Jun 2025 03:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnSEJMY+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676381DED42;
	Thu, 12 Jun 2025 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698932; cv=none; b=Ly2WlX6TIOSSkayOwyYx1MNgAsBB9Zw2BCN/6NlthHLqZoJy2W6D+oX3GhDH+ysISwIBNp2GV2poUQpBYmswB1apsgDwZSoZWbHPa77pVj1rvMB2KhfAybAOHkxW8TQRpQlwtznwJlwR41W0dVqCCjfZW2wa5y/a4Bb22aU1wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698932; c=relaxed/simple;
	bh=HBghfBJYWUhZWbDde60jhzZBBosP3QHIXZ8TKLYqHpQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=u1pxfX6nF21orzA6cUkA6ztdsIjcebuIGLZNvSgyNamEOgX50OVgj8YfK3zxBVbbAW2/vsRQfZIEKXnPL7BxWcD0KgoJBdA0iaRVGbf3AgsGrsbYqTIwfjZ3wx5GolP7Xa6YYxrNymnCYHunFeekUjc9mPre24sR/idjLVVn3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnSEJMY+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553a4f3ae42so374786e87.3;
        Wed, 11 Jun 2025 20:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749698928; x=1750303728; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py2x/3nEfcl/m+IfkfLCFYgC9n67Yc5sv7N0ha3Enew=;
        b=jnSEJMY+UYZIj2k5+VRdpuCy7IxcqUKFPxs4fmDYHNDXMFkcSBGHCmF291uUXW4dGm
         f75kPOsJL7ys5g8QLDZh/CnU9y1Gah1mD1TwTJ4ocdxvkNoGi9/PL2y9CjvMRoAcHpp9
         3Z6gDaeGQMlRwY6vCV0PAxvX45IMjUIa9jeB5lBFH+z6Kevvb/VA+2QvAr5SLWkBPHuP
         2BrcW1e2NHYCaHSrrKUMnbNAIL98qx28m6yJg09meWTX1Blz0Bw2qbFnWBMNDe4RpjUS
         1mIFki+UMxDC28CGxIZrWdr2q8m7KW8ZvRSpCvv9Ox517uLPhOSI0hR0B4EdiPZ+IgeZ
         6/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749698928; x=1750303728;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=py2x/3nEfcl/m+IfkfLCFYgC9n67Yc5sv7N0ha3Enew=;
        b=ZHI25SlpzfTZm4811iGSzjO0+5WOvGHNnI4t+WQNDh3mV2DjNby108nNOkS8S1rZDD
         gPiJRfyRYieo/ZcWFxsOVUhXibCo2GaZF6PbP2ukgQTkZIHvyRuy3QMlwrjiydskugk+
         Zl2107351C0mKE3dCL1kBO3PvZFJbkbgt/C8IoUZMPGUwvKs6Mmt17+iafFCgieciapE
         qMCrRKUhQxXLLBlDRbGZiMhZgzZ3F2CU0Og5Tn/+lPNVrs+eijTILExCdbyktc7zjtHg
         3jhGfschj0hxGaPjT0bu2hyRn45Z4lrKa5Kx6B8lEnEtn6H5VLrqjRQT/grbxsbz/Iw8
         3u/g==
X-Forwarded-Encrypted: i=1; AJvYcCUGRcPQhFDnUGM5+KMmiFDqNxgOC7SotxGQp4rA6ExyHQpYZvwAgdNqVse5nX4XKmCHYFXFmAHAYsneGfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwumWVYVFRx4++0HGLc1PgClynn2ovlwsYpEeU5KqewmGQ/hlT
	hIbFzxszQSQtn+wb/IA1SlfhjpA2Phyd0YL2Dpy1cGKJ1WYDiHbvXje+
X-Gm-Gg: ASbGncu8M0EqQk/SYJ3LnklShwDk3k+mUzRZbAns3HAizBUaRikXHYA56WBshe5gOc3
	83NOwhwZRhgn/N26ElPMC9EclOIEKWdWwEh6meD8scNfFQchHRQnlBCXjfHR6Fpe/OFbYekbGGj
	EiFFGTU9iJjZfygBXDnvvMvRdsZl+9hHH1vSNj6DID3eS8e2HK2nbwFd6f61j4rqBoo8yJwoF0c
	yB3Ri0bEtV7MnQ9GpdceN8Kda+IE+CINZYcY4PSDbJz1Z6X7s26tE2cs/TRM7c8adaRwfEZFqmq
	6Hw2JV4AdE6GjgWMOE7D1+AG+QVPdyAtHdg+M6JNgU0u2UTZl1OWeCobjFUD2fCZ/BKOFUBC
X-Google-Smtp-Source: AGHT+IFzDApZL1pHjb5MwmdwMyKHvI7xFwnWpTu5M5Pu8keW8CYw7rmotHQw4lDjGUz6wII2O1nwJA==
X-Received: by 2002:a05:6512:1047:b0:553:25b2:357d with SMTP id 2adb3069b0e04-5539c269200mr1758603e87.52.1749698927857;
        Wed, 11 Jun 2025 20:28:47 -0700 (PDT)
Received: from localhost ([62.89.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553a7003ee4sm87044e87.123.2025.06.11.20.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 20:28:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Jun 2025 08:28:21 +0500
Message-Id: <DAK8HUY0VT5Y.1YRMH2LOHDY8X@gmail.com>
Subject: Re: [PATCH 21/28] iio: light: veml6030: use = { } instead of
 memset()
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
 <linux-stm32@st-md-mailman.stormreply.com>
To: "David Lechner" <dlechner@baylibre.com>, "Michael Hennerich"
 <michael.hennerich@analog.com>, "Lars-Peter Clausen" <lars@metafoo.de>,
 "Jonathan Cameron" <jic23@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Heiko Stuebner"
 <heiko@sntech.de>, "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Francesco Dolcini"
 <francesco@dolcini.it>, =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, =?utf-8?q?Leonard_G=C3=B6hrs?=
 <l.goehrs@pengutronix.de>, <kernel@pengutronix.de>, "Oleksij Rempel"
 <o.rempel@pengutronix.de>, "Roan van Dijk" <roan@protonic.nl>, "Tomasz
 Duszynski" <tomasz.duszynski@octakon.com>, "Jacopo Mondi"
 <jacopo@jmondi.org>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>, "Mudit Sharma"
 <muditsharma.info@gmail.com>, =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 "Andreas Klinger" <ak@it-klinger.de>, "Petre Rodan"
 <petre.rodan@subdimension.ro>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.20.1-4-g02324e9d9cab
References: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-0-ebb2d0a24302@baylibre.com> <20250611-iio-zero-init-stack-with-instead-of-memset-v1-21-ebb2d0a24302@baylibre.com>
In-Reply-To: <20250611-iio-zero-init-stack-with-instead-of-memset-v1-21-ebb2d0a24302@baylibre.com>

On Thu Jun 12, 2025 at 3:39 AM +05, David Lechner wrote:
> Use { } instead of memset() to zero-initialize stack memory to simplify
> the code.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/light/veml6030.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 473a9c3e32a3a53f373595a5113b47e795f5366c..0945f146bedbda79511e70415=
8122acaac5e60c1 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -892,9 +892,7 @@ static irqreturn_t veml6030_trigger_handler(int irq, =
void *p)
>  	struct {
>  		u16 chans[2];
>  		aligned_s64 timestamp;
> -	} scan;
> -
> -	memset(&scan, 0, sizeof(scan));
> +	} scan =3D { };
> =20
>  	iio_for_each_active_channel(iio, ch) {
>  		ret =3D regmap_read(data->regmap, VEML6030_REG_DATA(ch),

Thank you for the patch, it looks cleaner and simpler :) I trust the
sources you provided, but I tested it with real hardware just in case.

Tested-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

