Return-Path: <linux-iio+bounces-16069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0808FA44DBF
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 21:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255231897903
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E320FAA2;
	Tue, 25 Feb 2025 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBsDKwfC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2E20E70C;
	Tue, 25 Feb 2025 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515838; cv=none; b=cPhZ52pnm3NHeD8LdKvgIQXRQ9l9vGT9pfKfiddHluy+dNb97WLOc1Q4fswzWA5LjxJiFGxUZSeWZBW5xq/uEoKyst36FaLZT22Wb5qzjBfgbhDhoyHEvczeArERD58roH3U8xihQsIkVjnwycFUt+Ire0nB52C64UCKlB1aGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515838; c=relaxed/simple;
	bh=QD5JiDDyXsPHqrw0/A3B2UFGdqNGf7bGZM6WRv9bwQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hm90jFdMpvFiiWnIMPLw4GzaW8nn5kGTlXt7rWFIafX2w/S+aNf/T+085gHrhgg0LXGJepfSPU6l2Ex6ocLK8yaHyjcO2NBaR1jYEgE1+ZCHZcNrGlkosicAUOqEFu6eSCUgmR01zDMfDNgo+wXm2iBZd9Q5Ya3/YHxmpE531uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBsDKwfC; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5209437e773so1646571e0c.3;
        Tue, 25 Feb 2025 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515836; x=1741120636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eH8MpmM78j+iib/pM9nd1FTI7DaYEcTE4LGOHyCUfsY=;
        b=mBsDKwfC77RWqYvaYIbYq7luOt4S5oUoqg9fdp2U4zVo6x1K3Mbm1xaOHvBow8cKjs
         Ro7eP2IA3Sp189N7s26DntoGxLYkCWMKOCqflzqkSe5Pl7JUdadDCCre0txrpo1sZra5
         q6ZzxC4xALML0mKxUx4h7aTgSwWxFiuWl21BHxJcQAU12+g9RoNnJj+hdZp2Fll6j29v
         OYYZkwFpABWYccak8R/CUDte414LXVAcmBzCQMUg4Ek0b+kqeoLwuWcdrQIFCiSUakvl
         k5PALkQNIO0o4JXOWXXfSfnwpUn6/Yt8jNHDRRc01fKBV83lkSi65MottPMMBDDnYw7w
         Iv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515836; x=1741120636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eH8MpmM78j+iib/pM9nd1FTI7DaYEcTE4LGOHyCUfsY=;
        b=YpWrhhm52gISY3HlygDckYz6Ye2tfRyYML783lozWwIjD7a8S1HMXKqJqGA8HenGg0
         fEOZYY7jmMh7xIQRJTNCgYJwZNf6nDGHLxSWBfH3y1w44kbP2Jq6Izwinwv42ER2MZc1
         lL9mIWXCVbd84Qgt6Tbccn5/iRH8JZvLDL97Kea5NzipgS/hq5MQiDXeZ+gePPjJvCbc
         VniSg6aLxQV8DSYk3DtyqlVKdhPTmDwAcjPH1u4uJcRLhUZkW2wOvP3PU2bQdUaxSyi5
         9lZ9fra6e9J2fGbKr0a15Q2x/BuJ4GMScTaaMot5VPKEQ7q8GL3piz8G97iGkQU5Azh3
         eLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUudAHilp0oi0wCP/pF84z2bvFLv8VmKMNcOO2ikECFOTtNXfawIRhOyX6+Bf0ogANk4yDewBT3HnE2p9Dl@vger.kernel.org, AJvYcCUzNTHi5/rc9s2qNy4aJtsD1wvlrkXmwUuNmGOj4BNFACQgZHkox/loV7ipvuBw8OR87GaSX/zPuqsonNXSYfBfQJs=@vger.kernel.org, AJvYcCXcSmIwEcM/vcV3W08UB9JN5M5uvZ1qD+WcGq9RXfge23u6griJXW9J2thtwAtWreC81YbGxFA/olU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmgZVDdwMs5H//2wqi66mkxg6ahDQ7/AVd62CWnsipYDIUOEo
	5VXUIHqGv/03jPjxg+BIEtiU2IDghygP5F8omZPT4gEix/7LF9HNYTGHiwgV/nM+o4EeAlqip4+
	eo6FRLXVIa7jEHWnpEa/L5cWz6h4=
X-Gm-Gg: ASbGnctzHKG6WpcbMUQbUOC37a4ICpCqKJ/zbXrnj3YSNFtKguxyKVntWU0qCOEWt/C
	H6bOvEbLfVtOf8DyYY2qLCM3CdIGf3BcpenVabSqnMzi7BrMOF9bikpV6J/Uc9P53wraMbecp/W
	p+UY46/GM=
X-Google-Smtp-Source: AGHT+IExQMHoNBfnz0e2JCdwvItc8XUqO/8OGgYYcvgIbrZjWdNKg/L+r67NJOf17hkUCcV4QvFDyQBa5luny6opYVk=
X-Received: by 2002:a05:6122:330e:b0:520:652b:ce18 with SMTP id
 71dfb90a1353d-5224ca44a91mr655026e0c.0.1740515836053; Tue, 25 Feb 2025
 12:37:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com> <20250224120608.1769039-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250224120608.1769039-3-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 25 Feb 2025 20:36:50 +0000
X-Gm-Features: AQ5f1Jo4yBcvY2RYMCiCO9Kb3cXMgLq2iq8E_Nnn-p4EJnAoTwHoukq4lOnKFcc
Message-ID: <CA+V-a8uF+y-SuVNs=iBpgitnGgDzVGzc9YK8KBnxfVHtp+swUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: rzg2l: Cleanup suspend/resume path
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:13=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
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
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - collected tags
>
> Changes in v2:
> - none
>
>  drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 7db04416e1cf..5236ca0da167 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -89,7 +89,6 @@ struct rzg2l_adc {
>         struct completion completion;
>         struct mutex lock;
>         u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> -       bool was_rpm_active;
>  };
>
>  /**
> @@ -594,14 +593,9 @@ static int rzg2l_adc_suspend(struct device *dev)
>         };
>         int ret;
>
> -       if (pm_runtime_suspended(dev)) {
> -               adc->was_rpm_active =3D false;
> -       } else {
> -               ret =3D pm_runtime_force_suspend(dev);
> -               if (ret)
> -                       return ret;
> -               adc->was_rpm_active =3D true;
> -       }
> +       ret =3D pm_runtime_force_suspend(dev);
> +       if (ret)
> +               return ret;
>
>         ret =3D reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
>         if (ret)
> @@ -610,9 +604,7 @@ static int rzg2l_adc_suspend(struct device *dev)
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
> @@ -630,11 +622,9 @@ static int rzg2l_adc_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       if (adc->was_rpm_active) {
> -               ret =3D pm_runtime_force_resume(dev);
> -               if (ret)
> -                       goto resets_restore;
> -       }
> +       ret =3D pm_runtime_force_resume(dev);
> +       if (ret)
> +               goto resets_restore;
>
>         ret =3D rzg2l_adc_hw_init(dev, adc);
>         if (ret)
> @@ -643,10 +633,7 @@ static int rzg2l_adc_resume(struct device *dev)
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
>

