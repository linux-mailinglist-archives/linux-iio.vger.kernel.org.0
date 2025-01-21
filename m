Return-Path: <linux-iio+bounces-14515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47198A17C46
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 11:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F2B3A7EC0
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D81F12FC;
	Tue, 21 Jan 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fq7Gwu4c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04111F12E9
	for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456665; cv=none; b=JYk7JO9GUqC93bI3pcOMb+4Ftn+KIeCnwux7g5BQzRwxOHpOoOruoW3DZI+lUoBacm+YI2s4NjM9uT8uhluv4qJcUsCwQyaj/0VJbP+AI07rRcGd3p3lCNX0AUCjrfuqGo6SckUKp109A8Zm5AavpM3kts6YO62xtJ0Sptpskvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456665; c=relaxed/simple;
	bh=7tB2FaSScP2xqqZiiRXe0Lm+SJSWIKu2VWPSu3LPJiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAm7SCZFLu+ZYOLR9tgjNSWuJsCSczXRylLcf6w8rYx7w/Fja22s6cY/5axtELvosJDvXSJTcG3PZa/0itOHU2m+X38lbxo2eWuWJHXQg0iGyNTlwJ6/9mblEg6vUJ1y0QwPphv+bxh2eDbYkzBMhFUXk5Khl+7g5GAg0oZJT/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fq7Gwu4c; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53537d8feeso7822088276.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 02:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737456662; x=1738061462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQylcc7EHn45Ei0TT7oe5G1WMHdSl2xFTZL0U5ka/Rs=;
        b=Fq7Gwu4c/RfLkyBPZXtQZeAExLdxK89JnXY0+W9RwC+cj5KKf2R64qNTNtmecRiopY
         JYkuZWhsJ80XgvKh2qt+yzXmTE3mVDDJsRQDE5P+NM2MrRdh+rSuTK/n9rp+j9hOX9NN
         tYZp4jvCV7plT6KCkoNN9BRPiqx0+GW1Q9UZ4keONT6WUoiFnSVZtIUbBhfKbnp0Vmqw
         6m1G6rqI6Tq4A+y9twjfP35JY0OHwGC+2QcaygIDmQhuItEGyMjGU3/8wu6PW4JoRAKh
         rBvY6Rp1ClcEMqH6EyVCUstCr1fsPw+98w+bvWpByOldXG3drEzmqSjHJshooSbwCPl3
         j7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737456662; x=1738061462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQylcc7EHn45Ei0TT7oe5G1WMHdSl2xFTZL0U5ka/Rs=;
        b=YHpJgIFG+JH46tOPdj/MZajYKs8oqQBItbGsrJ7/O28E7tmpsvSkZLAfV9cQO41xx4
         5Fbl1K6rRWb1uJINWaXW4rtpvZs/25Grw+SAG1J70yY0zP/hFXE8j74e/ar2TK5X/gbl
         RQqYne7OB5eZCw7nbep4odogTmvz6hhjVUesjqAY06TXfN53ZMNf8mmMVvKQZQG3H0zD
         9JAQSUXGHy9OyN9J88UObZZMxFYQf2NdXNu/49ZAwo70zChRlqlyNV3XXw4yXNJRVecG
         uLFqve0uEddYMs0hi+9tLyJOolx9D5LKL6ZE+dKqCZO91iQnpY86oPrhN8N91k4TS3Zy
         z+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHL/zQpfAntxoGwEpTX4InSW/9HOtdTnOmY5tEyvaARXAJo+c9eUfqt26NqEb/u7YoiH1VSvWM3ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fIHXU6qx8y4AI0cZ18kItW23QDWO66QwNNi5uLP+xjWWpHQL
	dAxZNr73R54B7PgfykSnR1D4iSambRdReuEka8dSss1fvmvyQAUl1CB3YnR2c46cnky7rnyGNuf
	CxHNtwacUoMCGyL69UjB2MNHawQjHYN2NIljgog==
X-Gm-Gg: ASbGncs72sy9C7lQOHjBiGvg0up8J3V+eikfup+ifagl+roUKpZ/T6ZLDhDH5mkQPNk
	16F5TgTZHAu9+2aVutbuCnTfs9b7d8grJLnYx2jzvKiCmguiHcWA=
X-Google-Smtp-Source: AGHT+IF2cscsfGQxN1lssa0+dH8DCzGrkKISmjtzU9j8NXZXN0ll4brwaod51LVKLJrVChosUyW4SEHY/lUnTDkqc5k=
X-Received: by 2002:a05:6902:1207:b0:e57:2f23:84f1 with SMTP id
 3f1490d57ef6-e57b105a67amr15277073276.20.1737456662555; Tue, 21 Jan 2025
 02:51:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117114540.289248-1-claudiu.beznea.uj@bp.renesas.com> <20250117114540.289248-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250117114540.289248-3-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Jan 2025 11:50:26 +0100
X-Gm-Features: AbW1kvbB9PHQ2-wP6G5Z-n3bSEjpIlaHyZGQzMnv5vB256VmG5eH16B66891zao
Message-ID: <CAPDyKFomKOuX9zic9j78d9cW4TaZd7km+tEcUEKQ_eCeBbWQWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: rzg2l: Cleanup suspend/resume path
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 12:45, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> There is no need to manually track the runtime PM status in the driver.
> The pm_runtime_force_suspend() and pm_runtime_force_resume() functions
> already call pm_runtime_status_suspended() to check the runtime PM state.
>
> Additionally, avoid calling pm_runtime_put_autosuspend() during the
> suspend/resume path, as this would decrease the usage counter of a
> potential user that had the ADC open before the suspend/resume cycle.
>
> Fixes: cb164d7c1526 ("iio: adc: rzg2l_adc: Add suspend/resume support")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Changes in v2:
> - none
>
>  drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 4742a727a80c..99cb73347b18 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -89,7 +89,6 @@ struct rzg2l_adc {
>         struct mutex lock;
>         int irq;
>         u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> -       bool was_rpm_active;
>  };
>
>  /**
> @@ -580,14 +579,9 @@ static int rzg2l_adc_suspend(struct device *dev)
>         };
>         int ret;
>
> -       if (pm_runtime_suspended(dev)) {
> -               adc->was_rpm_active = false;
> -       } else {
> -               ret = pm_runtime_force_suspend(dev);
> -               if (ret)
> -                       return ret;
> -               adc->was_rpm_active = true;
> -       }
> +       ret = pm_runtime_force_suspend(dev);
> +       if (ret)
> +               return ret;
>
>         ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
>         if (ret)
> @@ -596,9 +590,7 @@ static int rzg2l_adc_suspend(struct device *dev)
>         return 0;
>
>  rpm_restore:
> -       if (adc->was_rpm_active)
> -               pm_runtime_force_resume(dev);
> -
> +       pm_runtime_force_resume(dev);
>         return ret;
>  }
>
> @@ -616,11 +608,9 @@ static int rzg2l_adc_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       if (adc->was_rpm_active) {
> -               ret = pm_runtime_force_resume(dev);
> -               if (ret)
> -                       goto resets_restore;
> -       }
> +       ret = pm_runtime_force_resume(dev);
> +       if (ret)
> +               goto resets_restore;
>
>         ret = rzg2l_adc_hw_init(dev, adc);
>         if (ret)
> @@ -629,10 +619,7 @@ static int rzg2l_adc_resume(struct device *dev)
>         return 0;
>
>  rpm_restore:
> -       if (adc->was_rpm_active) {
> -               pm_runtime_mark_last_busy(dev);
> -               pm_runtime_put_autosuspend(dev);
> -       }
> +       pm_runtime_force_suspend(dev);
>  resets_restore:
>         reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
>         return ret;
> --
> 2.43.0
>

