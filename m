Return-Path: <linux-iio+bounces-13258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019F9E878E
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 20:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C4718854C2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701CD1917D9;
	Sun,  8 Dec 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoKhYpWu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7522318;
	Sun,  8 Dec 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733687089; cv=none; b=TZLhf36tuc61Nos4uN1lkjZFvy+iDh7b+G3l3CG1T1jOlcd/XQJ2B5dXUxOfkPj24PeP38/jtMuR9roY8WLnkMkFRG3x0ul7TdCy0eDE/pkHm5xM5Zj+uh/m0KoHkHlB7zZwAQAl9jbZwah8vhKSyG1//8ZtGTlq72IRflzCsAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733687089; c=relaxed/simple;
	bh=z/IlomK55kX1UvpgapgR+FiMtG/I30tIqY2zgcbnGR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aM5S6G+wPHHHDFCPlUq8KXXT5517a/CIu/pLrm5DUcJgJtrQiJVHZGwNpVwonuq+J2vmdGaBXa0H1EumHo82sjxiCaeikaVfgUr/kmZVwf1S9OoEbs9ckvVhe9alghekeSVGNK6DteBzAzwBx3TnKziPB6K6XzKccVbexVLJhMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoKhYpWu; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-515e1d6b63bso508132e0c.3;
        Sun, 08 Dec 2024 11:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733687086; x=1734291886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdyuGF53U9Pxx7HiAC4Y+SZv631LLYf9Lao16e8i3TM=;
        b=MoKhYpWuzQpkhTb/1d3nR/fesdH8iqRhAaRnEhGwcp17ZN1BPoY4tSQtHP/r0LBXhF
         usTdUZyg4UZaeMcAU1lzvzyFxdkHRnGg+mRnKFf+gTfhlkOQi/Oj3EgrEG0wxIC13EKQ
         RdEnQOI0Gq4kRKltKrbABYZrX1YxhfjiC1uWiAb86obW0oVbH//Cp0GzJhY9vUMTQaDZ
         MprxOAz5/h2w2A2u2YFyJl6bSvopeAaoFvel22hkgNO0n/oIMT26JgTPyu94XvZeKDSW
         9eB+gdCCKl6q2c5zVwwgo76OzSdaFByzO+Sd/Wvgt7B9fwpGRF3lKPXJMbra8t+IjHvO
         Hogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733687086; x=1734291886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdyuGF53U9Pxx7HiAC4Y+SZv631LLYf9Lao16e8i3TM=;
        b=Sz8/gtUxiYcI2G/nlO2AEy0H53jhHatl+4PPB10Ag1ZiQgNegbzFAP2ts8fYoD93eo
         yeQHIK5y6F4B6lQ0/7HUd9ofmvJ0I0Yg2YwosHYC8LkLrWJDOffpQtG03hT24wqb9EYI
         fwZOL74Ryp8iyx3M8hVT7CcQMD72FU2SXaTvgbxf4Ya4jj0hY1peOHBAhGKaAdmSfMLQ
         0TW6FZNAlF6E4XHrFRJFS3zBV0COF7Qp19J1hoIxKdS1Y159OmkpfqfMr4oHBtmgjblf
         S/dUT+CmWQYsDcXTUXXuXuv7dX8+fEQfAq2U2JxdA1TEXiCIovonsgt65IOpHHi+M3QW
         6r/g==
X-Forwarded-Encrypted: i=1; AJvYcCWAMVu0u9Rh37gHFukrA2XpRpASfUjKUJSq6aJWadFk6ju7scVrxg7LwY2W7CiH6hWdO3tnnuTmzqEBwafbWQWm+rc=@vger.kernel.org, AJvYcCWXeezdL/q3UZhpPQNVfSKhlHQJUhLK1lq835nlBHYP4E6xW2RqtAIOw21nwKbGRefO3pgcMhTTfUqF@vger.kernel.org, AJvYcCWufaMrLFf+j07Nz/HoOGUQT8Re9GSqoEuAiVwrqHspmaSp6aAY1LXlf5XwNTK34WwsBURZXKwuh6BVd5vE@vger.kernel.org, AJvYcCXfPvFfnXP9gARI+Kq0STH6NEyn5duLS71vjnMNxQkskdDuCx7FHGKV+uqKK2h9lIxm0V/n5svsTtqk@vger.kernel.org, AJvYcCXsnvYC6xCcf/oSXDQOBCARPcTmxe2qxzgzgL2OTf3HolmzpgMBXaYh0jAkuf5aDBdXH2T9EvHmfT8d@vger.kernel.org
X-Gm-Message-State: AOJu0Yyexc47h7EMH8PDHac6Hb8RsolTpNut8FS/6L71jddC/AoJFyFt
	CuaYqVX9htPg3rg+wPjX+4Cow9tK91ntwUbSwbTKp4JZ290deaF5qhQvrZNVE6JQOk8OyeP6isG
	gQGJuSoqOEsody5xhHv4JQEgGbEQ=
X-Gm-Gg: ASbGncuFh38lwRXYjylkPUviUq9Kkx1Sa1U6Cw1gJNF3elyhRkbgdI+kYWxFdIS//h3
	xlNiUr5QkuTs8+aFmvwXmldTtlnUruqOG
X-Google-Smtp-Source: AGHT+IE5XUpx8X/w7gTzb7U+uEjAHF2vr9LujcPw8JJel5KRlP2ogm+Loanw+eE1FdlGchVtfgfHgnDuFcId0On9bgI=
X-Received: by 2002:a05:6122:1805:b0:518:7c13:d191 with SMTP id
 71dfb90a1353d-5187c13f229mr69409e0c.8.1733687086496; Sun, 08 Dec 2024
 11:44:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-4-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 19:44:20 +0000
Message-ID: <CA+V-a8vvDYwzgQ51rTiYBoRkcy0pQvM-mNW3QCitnfROrTDUYQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] iio: adc: rzg2l_adc: Use devres helpers to
 request pre-deasserted reset controls
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
> Starting with commit d872bed85036 ("reset: Add devres helpers to request
> pre-deasserted reset controls"), devres helpers are available to simplify
> the process of requesting pre-deasserted reset controls. Update the
> rzg2l_adc driver to utilize these helpers, reducing complexity in this
> way.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - rebased on top of patch 2/15 from this version
> - used "failed to get/deassert" failure messages
>
>  drivers/iio/adc/rzg2l_adc.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 8a804f81c04b..c0c13e99aa92 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -411,11 +411,6 @@ static void rzg2l_adc_pm_runtime_set_suspended(void =
*data)
>         pm_runtime_set_suspended(dev->parent);
>  }
>
> -static void rzg2l_adc_reset_assert(void *data)
> -{
> -       reset_control_assert(data);
> -}
> -
>  static int rzg2l_adc_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -448,34 +443,14 @@ static int rzg2l_adc_probe(struct platform_device *=
pdev)
>         if (IS_ERR(adc->adclk))
>                 return dev_err_probe(dev, PTR_ERR(adc->adclk), "Failed to=
 get adclk");
>
> -       adc->adrstn =3D devm_reset_control_get_exclusive(dev, "adrst-n");
> +       adc->adrstn =3D devm_reset_control_get_exclusive_deasserted(dev, =
"adrst-n");
>         if (IS_ERR(adc->adrstn))
> -               return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed t=
o get adrstn\n");
> -
> -       adc->presetn =3D devm_reset_control_get_exclusive(dev, "presetn")=
;
> -       if (IS_ERR(adc->presetn))
> -               return dev_err_probe(dev, PTR_ERR(adc->presetn), "failed =
to get presetn\n");
> -
> -       ret =3D reset_control_deassert(adc->adrstn);
> -       if (ret)
> -               return dev_err_probe(&pdev->dev, ret, "failed to deassert=
 adrstn pin, %d\n", ret);
> -
> -       ret =3D devm_add_action_or_reset(&pdev->dev,
> -                                      rzg2l_adc_reset_assert, adc->adrst=
n);
> -       if (ret) {
> -               return dev_err_probe(&pdev->dev, ret,
> -                                    "failed to register adrstn assert de=
vm action, %d\n", ret);
> -       }
> +               return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed t=
o get/deassert adrst-n\n");
>
> -       ret =3D reset_control_deassert(adc->presetn);
> -       if (ret)
> -               return dev_err_probe(&pdev->dev, ret, "failed to deassert=
 presetn pin, %d\n", ret);
> -
> -       ret =3D devm_add_action_or_reset(&pdev->dev,
> -                                      rzg2l_adc_reset_assert, adc->prese=
tn);
> -       if (ret) {
> -               return dev_err_probe(&pdev->dev, ret,
> -                                    "failed to register presetn assert d=
evm action, %d\n", ret);
> +       adc->presetn =3D devm_reset_control_get_exclusive_deasserted(dev,=
 "presetn");
> +       if (IS_ERR(adc->presetn)) {
> +               return dev_err_probe(dev, PTR_ERR(adc->presetn),
> +                                    "failed to get/deassert presetn\n");
>         }
>
>         ret =3D rzg2l_adc_hw_init(adc);
> --
> 2.39.2
>
>

