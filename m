Return-Path: <linux-iio+bounces-13260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E459E87AD
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 21:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B707F2813C7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B1189BB8;
	Sun,  8 Dec 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsffhlAO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B077F22C6F7;
	Sun,  8 Dec 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733689427; cv=none; b=q5ZzsrR4Fz3qQH4b7YOpg8P+jDQVqTGYH0RBzBOAxYDrAZ0Vhhn0l1FugAn2hzCqsNB28ofP6VDKTeRD8YXAkk93F0oiyxJCBZNFh4y6qSrAzylXN+9fhQ1+PHKqwdklKqFDPoxJsX86pSZyaf6wCgaDDiO7AY5+J7ajtGoED4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733689427; c=relaxed/simple;
	bh=VNMED/1HHBxsGwmelvSwZPl520PM+oEtTdphUsU5CJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgQXfE7ymCCh1v4cfzLE57RDRo8+ApqviauV1yaYQiijRxnce1a7MayBqbe6+AMSQK6JFSvuiHt7Uyq0XSDIp+8Hx7tE20rtXh+ULfBVtuOU+BsjpKEGNzVXixa6kjCodHHVwnQFURJ3CL/tx/gGdl+CNA4Ojk3w9+W27SZIJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsffhlAO; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51623968932so305230e0c.1;
        Sun, 08 Dec 2024 12:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733689424; x=1734294224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHNbFtvSxURJSntgGeKQ/+5l2Y1/YzXPePAcL9wIcI4=;
        b=LsffhlAO6sGwASuswEw/M1/JD54WYz85R04Hrl7GikrVMnHWDRPr0jnw7YjXjfZ+i4
         ZfKR9yLCtMqN8ajzh5fU7beuUN3bhYLKAH1IYT9aixmF6Sw5wEZcL0t8E3Dql9/LTjEB
         shzXiP2XEd3L7uOaOx7A7iUoNLLXEkVaI46c7h7GZTGFyHTIFPvPF69U5ZGwrrWxlCyF
         mgmJnaCmwPSuBtH5RVF8LwE37G2kzdxqcgje2x7wdtE2grmaX61gpxL0nziE9/WFH6VB
         mil0zOmGMWWXG4wB1/ZB093NBhKAfgCmukZTyMn1An0899Zo87HLxLHaVDg28Xvu1qlF
         p6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733689424; x=1734294224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHNbFtvSxURJSntgGeKQ/+5l2Y1/YzXPePAcL9wIcI4=;
        b=g6Yb8jwyUK2612ZsrvYzRzXHrAgYbTflbt4jGHqoV0Fh8kgc93e+kPoyBPdLLdqa/X
         YyVPcXjd51Jw0BQ20tZrRVqS7DmP/pG8+GBNcMYzlAGBQ2l+s7+vFPFsvAiAsRK4P8ZX
         /FVRMGhlXT4iF3BA4SMfD87AGMCRyTMxWBVvgPtZJlaJG49JJc2O/8AqmyzLbTD4dd99
         gROhQr7cMj80+cTHwtRkq2K+yKnomhv3N+edPJRQweJWvZfpqrNcY4aUQbodLkMP41f4
         GrjmOSkaEXcJDDwCNQFIEpPCGtJRPjJQsmi/nssUmEE9qi7jJ8jRzy4J4epLnC0djFDg
         wF6g==
X-Forwarded-Encrypted: i=1; AJvYcCUhVdZj+4ShjdkJn/MOu2UpKVBe0fQmtel0JH0bkvJjSscQYXinHBa/nC6ubZgLmmod0k10holiYUZg@vger.kernel.org, AJvYcCVUS0/Cr5wkUrZejmPcAxHkKbWacJVyoj9NY4RnBcai/cXkrYi27sDv48pACvDV95MX1EGS+1iagIA4@vger.kernel.org, AJvYcCVeB5VGwfEQOxSKGiN2paz58Rwujr3vpXcztMkuAk8xN+MpVf0lIjnKzUChfY6eex5g4oM1bcOrniBAQZb8@vger.kernel.org, AJvYcCVrmP/tpE3+JMLZhehNL/aCiADeEcvgn8RJaqB4zQEYHWWt/Cx4udxrus1IZO2zcLzEiqv6PYIMfWpR@vger.kernel.org, AJvYcCWvG1DD7vVzsC6ybVuepAFbHLXfxPoV0P7DVq3FaUOO1Iuxd5LQDr1vNvVsFopl5a4r/mtBsxryePPotPCiPtNqWjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvX+cAsoEuTld4f4t3BzLATJiHkoDw1qVR9q4qPKWzrwwbIkwB
	S+HtS2QcgDzXka3YK618U4iPPODQeo3bxPtiDYJsPbzrkPFPwB/eIJk4YzOy0PkFXuAUibsHIhr
	hHiYKJh3IrtvJ6BFeTWZvHoQRGqk=
X-Gm-Gg: ASbGncueH/GGIoiPp9kmSCtl+MylbhrzJeRkuWfZhQFABuqksQRyYkaKOpS05JANNmR
	8KnY9oC0Ax5kUNOTqTqnhPMPv8tt/l7H2
X-Google-Smtp-Source: AGHT+IEYWnOhGl+PbNKxsZ8rtD86iQvQXnpcL43yIw5jF/VLUI9i4fGYwGp3t7LqcInqJxzYgLS6r86urrOTrTTk2Po=
X-Received: by 2002:a05:6122:c81:b0:50d:35d9:ad5a with SMTP id
 71dfb90a1353d-515fca33f1fmr9201341e0c.5.1733689424463; Sun, 08 Dec 2024
 12:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-5-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 20:23:18 +0000
Message-ID: <CA+V-a8sH0LtjZsiV2NM-h71M9KDZCoR1Wq_HxAg_ahXEyMuuaA@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] iio: adc: rzg2l_adc: Simplify the runtime PM code
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
> All Renesas SoCs using the rzg2l_adc driver manage ADC clocks through PM
> domains. Calling pm_runtime_{resume_and_get, put_sync}() implicitly sets
> the state of the clocks. As a result, the code in the rzg2l_adc driver th=
at
> explicitly manages ADC clocks can be removed, leading to simpler and
> cleaner implementation.
>
> Additionally, replace the use of rzg2l_adc_set_power() with direct PM
> runtime API calls to further simplify and clean up the code.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - rebased on top of patch 02/15 from this version
>
>  drivers/iio/adc/rzg2l_adc.c | 96 ++++++++-----------------------------
>  1 file changed, 20 insertions(+), 76 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index c0c13e99aa92..780cb927eab1 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -8,7 +8,6 @@
>   */
>
>  #include <linux/bitfield.h>
> -#include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
> @@ -69,8 +68,6 @@ struct rzg2l_adc_data {
>
>  struct rzg2l_adc {
>         void __iomem *base;
> -       struct clk *pclk;
> -       struct clk *adclk;
>         struct reset_control *presetn;
>         struct reset_control *adrstn;
>         struct completion completion;
> @@ -188,29 +185,18 @@ static int rzg2l_adc_conversion_setup(struct rzg2l_=
adc *adc, u8 ch)
>         return 0;
>  }
>
> -static int rzg2l_adc_set_power(struct iio_dev *indio_dev, bool on)
> -{
> -       struct device *dev =3D indio_dev->dev.parent;
> -
> -       if (on)
> -               return pm_runtime_resume_and_get(dev);
> -
> -       return pm_runtime_put_sync(dev);
> -}
> -
>  static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_=
adc *adc, u8 ch)
>  {
> +       struct device *dev =3D indio_dev->dev.parent;
>         int ret;
>
> -       ret =3D rzg2l_adc_set_power(indio_dev, true);
> +       ret =3D pm_runtime_resume_and_get(dev);
>         if (ret)
>                 return ret;
>
>         ret =3D rzg2l_adc_conversion_setup(adc, ch);
> -       if (ret) {
> -               rzg2l_adc_set_power(indio_dev, false);
> -               return ret;
> -       }
> +       if (ret)
> +               goto rpm_put;
>
>         reinit_completion(&adc->completion);
>
> @@ -219,12 +205,14 @@ static int rzg2l_adc_conversion(struct iio_dev *ind=
io_dev, struct rzg2l_adc *adc
>         if (!wait_for_completion_timeout(&adc->completion, RZG2L_ADC_TIME=
OUT)) {
>                 rzg2l_adc_writel(adc, RZG2L_ADINT,
>                                  rzg2l_adc_readl(adc, RZG2L_ADINT) & ~RZG=
2L_ADINT_INTEN_MASK);
> -               rzg2l_adc_start_stop(adc, false);
> -               rzg2l_adc_set_power(indio_dev, false);
> -               return -ETIMEDOUT;
> +               ret =3D -ETIMEDOUT;
>         }
>
> -       return rzg2l_adc_set_power(indio_dev, false);
> +       rzg2l_adc_start_stop(adc, false);
> +
> +rpm_put:
> +       pm_runtime_put_sync(dev);
> +       return ret;
>  }
>
>  static int rzg2l_adc_read_raw(struct iio_dev *indio_dev,
> @@ -348,13 +336,13 @@ static int rzg2l_adc_parse_properties(struct platfo=
rm_device *pdev, struct rzg2l
>         return 0;
>  }
>
> -static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
> +static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
>  {
>         int timeout =3D 5;
>         u32 reg;
>         int ret;
>
> -       ret =3D clk_prepare_enable(adc->pclk);
> +       ret =3D pm_runtime_resume_and_get(dev);
>         if (ret)
>                 return ret;
>
> @@ -392,25 +380,10 @@ static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
>         rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>
>  exit_hw_init:
> -       clk_disable_unprepare(adc->pclk);
> -
> +       pm_runtime_put_sync(dev);
>         return ret;
>  }
>
> -static void rzg2l_adc_pm_runtime_disable(void *data)
> -{
> -       struct device *dev =3D data;
> -
> -       pm_runtime_disable(dev->parent);
> -}
> -
> -static void rzg2l_adc_pm_runtime_set_suspended(void *data)
> -{
> -       struct device *dev =3D data;
> -
> -       pm_runtime_set_suspended(dev->parent);
> -}
> -
>  static int rzg2l_adc_probe(struct platform_device *pdev)
>  {
>         struct device *dev =3D &pdev->dev;
> @@ -435,14 +408,6 @@ static int rzg2l_adc_probe(struct platform_device *p=
dev)
>         if (IS_ERR(adc->base))
>                 return PTR_ERR(adc->base);
>
> -       adc->pclk =3D devm_clk_get(dev, "pclk");
> -       if (IS_ERR(adc->pclk))
> -               return dev_err_probe(dev, PTR_ERR(adc->pclk), "Failed to =
get pclk");
> -
> -       adc->adclk =3D devm_clk_get(dev, "adclk");
> -       if (IS_ERR(adc->adclk))
> -               return dev_err_probe(dev, PTR_ERR(adc->adclk), "Failed to=
 get adclk");
> -
>         adc->adrstn =3D devm_reset_control_get_exclusive_deasserted(dev, =
"adrst-n");
>         if (IS_ERR(adc->adrstn))
>                 return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed t=
o get/deassert adrst-n\n");
> @@ -453,7 +418,13 @@ static int rzg2l_adc_probe(struct platform_device *p=
dev)
>                                      "failed to get/deassert presetn\n");
>         }
>
> -       ret =3D rzg2l_adc_hw_init(adc);
> +       ret =3D devm_pm_runtime_enable(dev);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, indio_dev);
> +
> +       ret =3D rzg2l_adc_hw_init(dev, adc);
>         if (ret)
>                 return dev_err_probe(&pdev->dev, ret, "failed to initiali=
ze ADC HW, %d\n", ret);
>
> @@ -468,26 +439,12 @@ static int rzg2l_adc_probe(struct platform_device *=
pdev)
>
>         init_completion(&adc->completion);
>
> -       platform_set_drvdata(pdev, indio_dev);
> -
>         indio_dev->name =3D DRIVER_NAME;
>         indio_dev->info =3D &rzg2l_adc_iio_info;
>         indio_dev->modes =3D INDIO_DIRECT_MODE;
>         indio_dev->channels =3D adc->data->channels;
>         indio_dev->num_channels =3D adc->data->num_channels;
>
> -       pm_runtime_set_suspended(dev);
> -       ret =3D devm_add_action_or_reset(&pdev->dev,
> -                                      rzg2l_adc_pm_runtime_set_suspended=
, &indio_dev->dev);
> -       if (ret)
> -               return ret;
> -
> -       pm_runtime_enable(dev);
> -       ret =3D devm_add_action_or_reset(&pdev->dev,
> -                                      rzg2l_adc_pm_runtime_disable, &ind=
io_dev->dev);
> -       if (ret)
> -               return ret;
> -
>         return devm_iio_device_register(dev, indio_dev);
>  }
>
> @@ -503,8 +460,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_suspen=
d(struct device *dev)
>         struct rzg2l_adc *adc =3D iio_priv(indio_dev);
>
>         rzg2l_adc_pwr(adc, false);
> -       clk_disable_unprepare(adc->adclk);
> -       clk_disable_unprepare(adc->pclk);
>
>         return 0;
>  }
> @@ -513,17 +468,6 @@ static int __maybe_unused rzg2l_adc_pm_runtime_resum=
e(struct device *dev)
>  {
>         struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>         struct rzg2l_adc *adc =3D iio_priv(indio_dev);
> -       int ret;
> -
> -       ret =3D clk_prepare_enable(adc->pclk);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D clk_prepare_enable(adc->adclk);
> -       if (ret) {
> -               clk_disable_unprepare(adc->pclk);
> -               return ret;
> -       }
>
>         rzg2l_adc_pwr(adc, true);
>
> --
> 2.39.2
>
>

