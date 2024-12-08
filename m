Return-Path: <linux-iio+bounces-13262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC6C9E87EE
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 21:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA822807BC
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7753191F74;
	Sun,  8 Dec 2024 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2ny9//U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8DC22C6F7;
	Sun,  8 Dec 2024 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733691243; cv=none; b=e5UZutHE8KZ2cu73y2AoFF9Ft09H41U3vLU8Nz/RVyV21bdko1ZzZJYiCnE3mqNOX7MAn1mFhP4UPNM5wNXVMmDfz1F23848hUeNz+1g2R63Njb+OwTsc1Nvr0H3dpA2A6eTLw/VQ/LvJsDtJwBJJugoAuCZ/y9b2j2fzRc1OZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733691243; c=relaxed/simple;
	bh=m569ykunseRlQ9K516LnE610ulAPC6atwrwMdIJIbbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=og95A6Pyq5isDmuOpnMNI9b2PhSEsjM9k0yYX4KpJ4aT0ikSOxrxQR2B7Slwc1pao2Yhom7SjKBz3P4ucIluF2aVxWVRr3uYLr4QHM8pay6EY7/t1LpmQusAZw04eN4sNyfoaC5VD/Iy7OC63TnU4vNReLJrKnGp4i9O8gxOeA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2ny9//U; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-515fee56bf8so642259e0c.2;
        Sun, 08 Dec 2024 12:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733691240; x=1734296040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtInOLRZf5JjoutNm4VQJG2YkTufsK5zn3LVlLVAPqg=;
        b=e2ny9//UpWamjstnC8Zu+2g5l4URjM5QXiuCry1mLbDMuEC5rgY6bxcdzgD0+BhCqO
         PVwfFZYgC5ktRivm0FFk80BmcVT5QBpwCob31wpSTVQ976JpBTPOTC6x5w3fFKVy/Zs3
         tu1pir3LMONDk0gmClzlycRNpc5rod2DFOTJF8ixhhdWgiX7Oqtltx+nXqBBPag52WOw
         e9U6k23WGkkJEpstR0lOv5scl/8OLaHgYrZMLEuSNPDpGDgQtfAYl+6gPtC4r9jLFc7g
         spPTQyFDGLAiNBLmai/3UWRq78loylXduZxv8F8wScmOfB+xpg1o3CCFPtAbMdA/KpIk
         J+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733691240; x=1734296040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtInOLRZf5JjoutNm4VQJG2YkTufsK5zn3LVlLVAPqg=;
        b=LMOhu1gGdr8k7Or8tFzDd2EdbV1dX6pYxJfwuWQJQBWOvu7dinjgiLp6L8HVutMjEE
         mEmx8NsqnlitTD6dszBPU28uS9TAtQBUqbunnZSW/7kHp8nZSzZuBx+cyLl/Pr2bhZIo
         64qT9oqVbzgfzaJaJ+sk0QMg0Zq6ZQShaucZy/b57PT8Nrf8BTqoQmXR12ol22so14eo
         aNwuU25AAhDuU+VKtATp7jPZ5NEDDrLrSgiozneJ5qOs6skRp2/QlwShcQVj5Tu+nHHp
         RFZcSEASxM0hVnHKF+eOirq1tMnPvoRC5lZ0Dtc+RcdfRLg654eYzRu8dYPFLrYizldx
         t9ig==
X-Forwarded-Encrypted: i=1; AJvYcCUUkelra5NKA175ll32szpreHT9idQOWEy5/sbcuvh15N0L1SWYpSv1DAYA/lBunu6Zms40weSrMuCSIOsY@vger.kernel.org, AJvYcCUjMGQjSaxTz50hi2thj56GiOQ2KljkYEF5j9h0S+nJyah3nPAdT7OUDQa0G1aFtreqDgu0a2qS1HPaXhflIejwd64=@vger.kernel.org, AJvYcCWqSKMMBhAMa3BP/fi+wDbdMxxfhXoeIRIRIsbpupsIpXCMgohUWM6Fe6pdylybKkDKBeXFmX9AhkSR@vger.kernel.org, AJvYcCXZpOdDeZ5WWRjCogm575+HscSx03O/1jIkXVQygkLVOoeQ4Uqrl1A/4rG/9vYiKrFqEnW0xgIgWIMF@vger.kernel.org, AJvYcCXzEL/ql3FpwSAdjraQjoMwziJNghpb9N8SBhiPD9xBKnAW0qA58OzSPUx6C00YrQ2f4Xnt1tL3RgUA@vger.kernel.org
X-Gm-Message-State: AOJu0YzzIuVTGg19PDHS5yuFsz3GRIrwdelVUXdyZmqRZZbWyrMU3UeN
	ok+mhOh56VmIojEEMv0972oY9tMEeRPCQjFsaqig9rYUr8EglqaRlcpy90oBUmKZxBwgixsQg5s
	B2WekdwEDYYOUw1Fzczd+5gXMRCaTSAaQp5g=
X-Gm-Gg: ASbGnctFpzNB+XbW9QgKPxJtzHa0zviwyr5llEVrt4fxSP3o257cjekh0d3NAQ1QGuA
	OMGGheCEOzSwbqx/wP9ELbTchBkhL141K
X-Google-Smtp-Source: AGHT+IHKqpIfLIPmQSk8T1KvdbRBwgq1GprXFctDGVRIsYb4XHDXfjvnTnqagvsjONOsjjI1Oyj1706zUrs25hrzxzs=
X-Received: by 2002:a05:6122:3220:b0:515:d0b3:2520 with SMTP id
 71dfb90a1353d-515fc84f957mr9787564e0c.0.1733691240611; Sun, 08 Dec 2024
 12:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-7-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 20:53:34 +0000
Message-ID: <CA+V-a8tiOBW5yic7usddbPZnmTpaFcgvQuF6oPiT9+tPmrY2pg@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] iio: adc: rzg2l_adc: Use read_poll_timeout()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:15=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Replace the driver-specific implementation with the read_poll_timeout()
> function. This change simplifies the code and improves maintainability by
> leveraging the standardized helper.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - none
>
>  drivers/iio/adc/rzg2l_adc.c | 29 ++++++++++-------------------
>  1 file changed, 10 insertions(+), 19 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 482da6dcf174..38d4fb014847 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -13,6 +13,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -112,7 +113,7 @@ static void rzg2l_adc_pwr(struct rzg2l_adc *adc, bool=
 on)
>
>  static void rzg2l_adc_start_stop(struct rzg2l_adc *adc, bool start)
>  {
> -       int timeout =3D 5;
> +       int ret;
>         u32 reg;
>
>         reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(0));
> @@ -125,15 +126,10 @@ static void rzg2l_adc_start_stop(struct rzg2l_adc *=
adc, bool start)
>         if (start)
>                 return;
>
> -       do {
> -               usleep_range(100, 200);
> -               reg =3D rzg2l_adc_readl(adc, RZG2L_ADM(0));
> -               timeout--;
> -               if (!timeout) {
> -                       pr_err("%s stopping ADC timed out\n", __func__);
> -                       break;
> -               }
> -       } while (((reg & RZG2L_ADM0_ADBSY) || (reg & RZG2L_ADM0_ADCE)));
> +       ret =3D read_poll_timeout(rzg2l_adc_readl, reg, !(reg & (RZG2L_AD=
M0_ADBSY | RZG2L_ADM0_ADCE)),
> +                               200, 1000, true, adc, RZG2L_ADM(0));
> +       if (ret)
> +               pr_err("%s stopping ADC timed out\n", __func__);
>  }
>
>  static void rzg2l_set_trigger(struct rzg2l_adc *adc)
> @@ -338,7 +334,6 @@ static int rzg2l_adc_parse_properties(struct platform=
_device *pdev, struct rzg2l
>
>  static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
>  {
> -       int timeout =3D 5;
>         u32 reg;
>         int ret;
>
> @@ -351,14 +346,10 @@ static int rzg2l_adc_hw_init(struct device *dev, st=
ruct rzg2l_adc *adc)
>         reg |=3D RZG2L_ADM0_SRESB;
>         rzg2l_adc_writel(adc, RZG2L_ADM(0), reg);
>
> -       while (!(rzg2l_adc_readl(adc, RZG2L_ADM(0)) & RZG2L_ADM0_SRESB)) =
{
> -               if (!timeout) {
> -                       ret =3D -EBUSY;
> -                       goto exit_hw_init;
> -               }
> -               timeout--;
> -               usleep_range(100, 200);
> -       }
> +       ret =3D read_poll_timeout(rzg2l_adc_readl, reg, reg & RZG2L_ADM0_=
SRESB,
> +                               200, 1000, false, adc, RZG2L_ADM(0));
> +       if (ret)
> +               goto exit_hw_init;
>
>         /* Only division by 4 can be set */
>         reg =3D rzg2l_adc_readl(adc, RZG2L_ADIVC);
> --
> 2.39.2
>
>

