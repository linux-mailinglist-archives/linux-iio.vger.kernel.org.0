Return-Path: <linux-iio+bounces-13257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C29E8789
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 20:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1993C1885394
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB0189B8F;
	Sun,  8 Dec 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtKu3txB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60F22318;
	Sun,  8 Dec 2024 19:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733687020; cv=none; b=LvqRSQjui557SjYm0gEAPacz7NdXq6yVITiwFQopgZz3JVjS92QUWNTp0vrdamXkuWwirV+Ahfz+DEhzykBQSDllVLKcWoJXD7dfeGfgS1PlwaBSbiunKmg3nqZbb/l/lE3jePd2/YN6xhUm/Hm+Dv1Se8ZQRcCy13jjhQuFDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733687020; c=relaxed/simple;
	bh=FcOvuT1rF0X8UhHr7DWimk+Ef5ijlFywizJx1JvpUS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgP/wIEHYM+VP3jppt0J7CerfBwjNS8s5M23xMY32BVp8sNxVt7as/o8XYL/ZchzK1/eiEHYOuto2FAYQQZWraOmylv2kWDqLxgfmpwmPCvyGaTzb/HHR4UXz1YsJHkOVH0iZfnlPZw5BszcFY1mEDhJos7M+RetxzICdnDEJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtKu3txB; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-51529df6202so1050669e0c.3;
        Sun, 08 Dec 2024 11:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733687018; x=1734291818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdeL2d5hRixTaiyWUB2vCqjajpatj6WPtXQKIjMhZfI=;
        b=ZtKu3txBL/pntad+t3nfrkDzW0QG7+8HONHxqUXNaSKuWrAmsC9Qp57119N+rDOQBJ
         9E+WFAOUuOAIDKVWTfdqCCIwadc7bzBlpUVqdPGGZkVqtkJXGsh3N5aXDpTwte41qVUU
         u2F7p92EX0mqT4IOjWvB6ikcnfl5ZCIis5ptdQCKTqNkZFJQhqSKBohN7/Jbw3aez+XJ
         2v6khDQ8PISu0l4VczN4MvRQVlOuJeUrp61rp0sWyO/UpfCInXhUCb0BDhZyhuxcKcGM
         tjg+hbbThUEQ2R5kOzYxJiSQ9Xf5mwGSIT9Ch/eEmf/MaBwiQHQTmuKKqGPqUKinoP1j
         XUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733687018; x=1734291818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdeL2d5hRixTaiyWUB2vCqjajpatj6WPtXQKIjMhZfI=;
        b=Oj/E+Us5LSLmN36yCrnkSqGOqZm00Q5Adg6bft3NJq/RldqPoF1UF1UIhFv2/hC6HK
         J/vnowR/3YwqKeziQm0zuSjNfuzGrmLNZBOudtIPs2SL/qD/+e09hPlP7RAIrEeSpWzo
         RWo2fHpTJieaHpEhX9u1Fim8vsO6/F6JaW1hsjXNAQGmWUcsRAbONjn6XuWVBsvtKpo7
         bh2MFFXFw5qMffw5hXjfIWC+3MlmBoRpPcivxo8kXNIJ11C8TC1nNkKhRQF+TAmDctNB
         /drgHKz8juq82ycPaj/LCR3PPwbLnXGlyiWN5v5GMZrRmFbbhvooJzJBBz853S2WREIG
         DTmw==
X-Forwarded-Encrypted: i=1; AJvYcCVI8+pomSeLW+wbrpv3r+xc5CC9AmJyt7UsRK5H/RG4RUj0dekJlz/nJVCK4wuPYaRscOcGbLzkc0gX@vger.kernel.org, AJvYcCX3rkOaSw26kAK99Ewa1872d2U27UZOxVlpaWR/yY8t5o90aUULacvhlJPuLeZ1tAPlVwYvh8g6taGZEfEe67MbWSU=@vger.kernel.org, AJvYcCX7rW80bvExKcOozVPLks5NAPoAXFXffFLFhJvZJYTMa3Jhp/8xrmdS24Lcgb6giqAC3dcdWMh6qVFFMCGW@vger.kernel.org, AJvYcCX8NPijNXVAFJ5TkGsI4IB3eceqKjGhrH3iNUOw/ARU13ICUGmc4zTYQJ1l54NPll3Ae8IgR8lgdztG@vger.kernel.org, AJvYcCXJn+h4oFiUnjJRId/SJFCKUgd3Y35CpLD4UzdfLHt2rocmK0VfdWQlfRXykoqYsN3UPm7ts4Cc+VJu@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeYTSfYw1n7XOpHZhhKjoJKL3iKJLNbui6iKtXmYJ5ct5pBvM
	puanX3AHyEfVsZTFEcpFKjeFT2oPnMKsQccRjSXZyZzltR8f3Pp0AoiFSvvHAL7PrwZPmQMpH1z
	kwk2Wiqfn9zNgkZZ9QhCmYm5a/Z8=
X-Gm-Gg: ASbGnctOEnx4/qRCt8c8QIXujzd956wtSPZ9Xn960UtanH9dO2bdCqipYmOE+MP2q9s
	wJHH8Dm8wdmL0t/KOi5SZ9uCPSopYrN2Y
X-Google-Smtp-Source: AGHT+IH2gTlwGalGk9UrOxUML5l9qnnmnmQDbuvrXcjSNCVazTTlXlV+2/JEeauMOkvOkhs6ecq7Ao9H3UR6J/BJkFY=
X-Received: by 2002:a05:6122:a04:b0:517:167a:5cc6 with SMTP id
 71dfb90a1353d-517167a7947mr1684522e0c.6.1733687017655; Sun, 08 Dec 2024
 11:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-3-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 19:43:11 +0000
Message-ID: <CA+V-a8svFFi9ipGeBz6b-5cv9LvBrxz=hjoycGV9b-LrSvKaTg@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] iio: adc: rzg2l_adc: Convert dev_err() to dev_err_probe()
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

On Fri, Dec 6, 2024 at 11:14=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Convert all occurrences of dev_err() in the probe path to dev_err_probe()=
.
> This improves readability and simplifies the code.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - none, this patch is new
>
>  drivers/iio/adc/rzg2l_adc.c | 64 +++++++++++++------------------------
>  1 file changed, 22 insertions(+), 42 deletions(-)
>
With comments fixed from Jonathan,

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index cd3a7e46ea53..8a804f81c04b 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -313,15 +313,11 @@ static int rzg2l_adc_parse_properties(struct platfo=
rm_device *pdev, struct rzg2l
>                 return -ENOMEM;
>
>         num_channels =3D device_get_child_node_count(&pdev->dev);
> -       if (!num_channels) {
> -               dev_err(&pdev->dev, "no channel children\n");
> -               return -ENODEV;
> -       }
> +       if (!num_channels)
> +               return dev_err_probe(&pdev->dev, -ENODEV, "no channel chi=
ldren\n");
>
> -       if (num_channels > RZG2L_ADC_MAX_CHANNELS) {
> -               dev_err(&pdev->dev, "num of channel children out of range=
\n");
> -               return -EINVAL;
> -       }
> +       if (num_channels > RZG2L_ADC_MAX_CHANNELS)
> +               return dev_err_probe(&pdev->dev, -EINVAL, "num of channel=
 children out of range\n");
>
>         chan_array =3D devm_kcalloc(&pdev->dev, num_channels, sizeof(*cha=
n_array),
>                                   GFP_KERNEL);
> @@ -445,62 +441,46 @@ static int rzg2l_adc_probe(struct platform_device *=
pdev)
>                 return PTR_ERR(adc->base);
>
>         adc->pclk =3D devm_clk_get(dev, "pclk");
> -       if (IS_ERR(adc->pclk)) {
> -               dev_err(dev, "Failed to get pclk");
> -               return PTR_ERR(adc->pclk);
> -       }
> +       if (IS_ERR(adc->pclk))
> +               return dev_err_probe(dev, PTR_ERR(adc->pclk), "Failed to =
get pclk");
>
>         adc->adclk =3D devm_clk_get(dev, "adclk");
> -       if (IS_ERR(adc->adclk)) {
> -               dev_err(dev, "Failed to get adclk");
> -               return PTR_ERR(adc->adclk);
> -       }
> +       if (IS_ERR(adc->adclk))
> +               return dev_err_probe(dev, PTR_ERR(adc->adclk), "Failed to=
 get adclk");
>
>         adc->adrstn =3D devm_reset_control_get_exclusive(dev, "adrst-n");
> -       if (IS_ERR(adc->adrstn)) {
> -               dev_err(dev, "failed to get adrstn\n");
> -               return PTR_ERR(adc->adrstn);
> -       }
> +       if (IS_ERR(adc->adrstn))
> +               return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed t=
o get adrstn\n");
>
>         adc->presetn =3D devm_reset_control_get_exclusive(dev, "presetn")=
;
> -       if (IS_ERR(adc->presetn)) {
> -               dev_err(dev, "failed to get presetn\n");
> -               return PTR_ERR(adc->presetn);
> -       }
> +       if (IS_ERR(adc->presetn))
> +               return dev_err_probe(dev, PTR_ERR(adc->presetn), "failed =
to get presetn\n");
>
>         ret =3D reset_control_deassert(adc->adrstn);
> -       if (ret) {
> -               dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n"=
, ret);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "failed to deassert=
 adrstn pin, %d\n", ret);
>
>         ret =3D devm_add_action_or_reset(&pdev->dev,
>                                        rzg2l_adc_reset_assert, adc->adrst=
n);
>         if (ret) {
> -               dev_err(&pdev->dev, "failed to register adrstn assert dev=
m action, %d\n",
> -                       ret);
> -               return ret;
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "failed to register adrstn assert de=
vm action, %d\n", ret);
>         }
>
>         ret =3D reset_control_deassert(adc->presetn);
> -       if (ret) {
> -               dev_err(&pdev->dev, "failed to deassert presetn pin, %d\n=
", ret);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "failed to deassert=
 presetn pin, %d\n", ret);
>
>         ret =3D devm_add_action_or_reset(&pdev->dev,
>                                        rzg2l_adc_reset_assert, adc->prese=
tn);
>         if (ret) {
> -               dev_err(&pdev->dev, "failed to register presetn assert de=
vm action, %d\n",
> -                       ret);
> -               return ret;
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "failed to register presetn assert d=
evm action, %d\n", ret);
>         }
>
>         ret =3D rzg2l_adc_hw_init(adc);
> -       if (ret) {
> -               dev_err(&pdev->dev, "failed to initialize ADC HW, %d\n", =
ret);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "failed to initiali=
ze ADC HW, %d\n", ret);
>
>         irq =3D platform_get_irq(pdev, 0);
>         if (irq < 0)
> --
> 2.39.2
>
>

