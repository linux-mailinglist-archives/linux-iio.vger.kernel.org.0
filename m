Return-Path: <linux-iio+bounces-13267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319199E8820
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 22:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B89163E5A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 21:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11906191F75;
	Sun,  8 Dec 2024 21:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7Jk3Gh7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C11DA23;
	Sun,  8 Dec 2024 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733693778; cv=none; b=LeJzLnHM9/GGh2QI1nrfMByWPKBH4H8+NDlLF2CaGpcIZG652ce1c3T+lLlM/E0FQdv+/qa2qkrUtRGDMlSbeF/4FKVexdEVZXHJGmcPbumchL94bobydH4LDDIAT0QV0KIxd7OBptABOyMkKdJTxu7uofl6QzUfj23PWy5BQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733693778; c=relaxed/simple;
	bh=9pVA9WOuYnFsgbESCnSlf+R0EmB4xmD9+WiiUvtgJh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKy+L/JJDCAzinvHDMNJz9evHzcpxeW0oqlG+AIa374X5U3uO4XcQoykRSdR9D1Y+RIyNPjHVqOB4ZCQO3XrW76G1IUJCgkdfz7/PUiPP/YP4k4yAIgtohYuXRWMj7xIpAny9+8DL9Xj6zRno+yxcucB8c5TKtMgOJKyVjtfft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7Jk3Gh7; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-85b95896cefso701341241.2;
        Sun, 08 Dec 2024 13:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733693776; x=1734298576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiCkakQWqIBf09dONNb85NToTD/BUIER2ZS+n3sEdS8=;
        b=L7Jk3Gh79KC2z27Aubi+LUG0+dX4F3U4WaBX5LSg7JPo0xvVpfrssBvu2I4h9TU5l2
         UDyYtrDzXUMT9pzK5E8PpBosjR8SiWw+h/cIhUXPZtTd3JYJq9fWaD1YgxsDKRY8/4Xl
         z2t+0gMVUr9hwPt3QuC6vjco9HZKCTaEprMeXjao1ngDwyuq8wkEGJ/PA4jyB+2dclIg
         ltFWrln+dyo7dBYVCgFE5OZsFXQGqpmedgdyTqjedoyiP+mTE5BvC03aU3/e4ZY9Eiib
         VasOxVJMVQ4kukVFcg3zjhXT/kr4mRMyV4mG8zpr5gh47iYRtBTwXomczcWufK+ZDCYh
         3XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733693776; x=1734298576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiCkakQWqIBf09dONNb85NToTD/BUIER2ZS+n3sEdS8=;
        b=F/Wkv9TQCxMCDou36Exaci6xW5/hL/1vAqe2i1xbwoXnlzISg7ClRfcLpXnkUx+0Dp
         M9I7hjwEUewuvuAwewdkJmvGyflD71J5tUgZdIXQdJwCAB5P6mE0uPkHlzY+TrVemLwy
         fE7DM9jdb0d3631x6PyELBeZPdtNiC/9jHVhpq7MUM+LBxjT3iEycvjWNGyPxZir2mdF
         HR7cvShpqAM4p6zbL5qcKAcRV5JnAM4IqSKjS++eglu0lCetc0SpwonWZwU4BQcnqtc+
         4J31mPkWWD1PhIGuVcvlNaEiHys9vJzCdaDR6v8K7iOBrqCHpT67DuKk/2l325I6Z5EB
         eScw==
X-Forwarded-Encrypted: i=1; AJvYcCU7E3LbQ0WlD/KIGQy29B2XliSKW6fmUqVQxkzH4KbM8O3q3y++yR1fnUdT5MkD0Nvra+Y1FUyQC1tSPkhkxCNKMzg=@vger.kernel.org, AJvYcCVa0z1MJsQTena8pqTX9kDPbW/gnF+ouOaLhEPesBYeX5ctajTFF1zWd0dXrRDnU/z6oqN5oiA8Fx5m9Jkq@vger.kernel.org, AJvYcCVbnSJJo5JjKHUvRLGCZmMCpF9635j+vpMRlaS5nTZPAAWZ4ykuSEFvtJB+8uzOJC7mKhTjfbbpTBs6@vger.kernel.org, AJvYcCVnqbNYAuwD9S+IpDS8zphRMNjxYa7rbIZIbmoj9O3YEu+oo9Z3rauxeFPbDw8z29WbAHiK0iP5Te39@vger.kernel.org, AJvYcCXS6Xigb/dEUnRN/fX/gi1GJb+9UXkp0gnC5YdbYtAQbBs9RgFGKFq+Nhg1nEEVbIei8JCHJb7UWA7Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwL1rhgRW0D/7PexZBqu0gYN39QEFgfyAmrwAZWZx/9mVJGWlW7
	Ly+902Zb1S4uMj8jQpSx1IRKjPrJtegM6yyTCz3beZjJt521zv61uTJGXhGd7vBCFTQyWNNuD53
	fsieRg4yaiw2ymTdrdpvZIDdcCc4=
X-Gm-Gg: ASbGnctW5FKvRKDBy9sEmaAtm1y6sQPnpVPMWbQ/j8ePlaVCNaysJksPpJeyaQ9ui+V
	B1ST2SwpPrmYswcU09nQqmXr1KbKc+mpE
X-Google-Smtp-Source: AGHT+IEuRFUxxnKiMRjUikQDSTAAVTMrFs9uHL9UmppnkCZPo+jjdxm0+Y/FUv2KQkfIor84awR/Jn0Kv+1RwP6hpWY=
X-Received: by 2002:a05:6122:1c0b:b0:515:c769:9d32 with SMTP id
 71dfb90a1353d-515fca18638mr10363003e0c.4.1733693776090; Sun, 08 Dec 2024
 13:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-12-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-12-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 21:35:50 +0000
Message-ID: <CA+V-a8vHovd7L2bcY61n_Ox_hKvTvhUZMZPKgHFtd5DHQeZNMw@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] iio: adc: rzg2l_adc: Add suspend/resume support
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

On Fri, Dec 6, 2024 at 11:16=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC features a power-saving mode where power to most o=
f
> the SoC components is turned off, including the ADC IP.
>
> Suspend/resume support has been added to the rzg2l_adc driver to restore
> functionality after resuming from this power-saving mode. During suspend,
> the ADC resets are asserted, and the ADC is powered down. On resume, the
> ADC resets are de-asserted, the hardware is re-initialized, and the ADC
> power is restored using the runtime PM APIs.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - none
>
>  drivers/iio/adc/rzg2l_adc.c | 70 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index e8dbc5dfbea1..2a911269a358 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -88,6 +88,7 @@ struct rzg2l_adc {
>         struct completion completion;
>         struct mutex lock;
>         u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> +       bool was_rpm_active;
>  };
>
>  /**
> @@ -527,8 +528,77 @@ static int rzg2l_adc_pm_runtime_resume(struct device=
 *dev)
>         return 0;
>  }
>
> +static int rzg2l_adc_suspend(struct device *dev)
> +{
> +       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +       struct rzg2l_adc *adc =3D iio_priv(indio_dev);
> +       struct reset_control_bulk_data resets[] =3D {
> +               { .rstc =3D adc->presetn },
> +               { .rstc =3D adc->adrstn },
> +       };
> +       int ret;
> +
> +       if (pm_runtime_suspended(dev)) {
> +               adc->was_rpm_active =3D false;
> +       } else {
> +               ret =3D pm_runtime_force_suspend(dev);
> +               if (ret)
> +                       return ret;
> +               adc->was_rpm_active =3D true;
> +       }
> +
> +       ret =3D reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
> +       if (ret)
> +               goto rpm_restore;
> +
> +       return 0;
> +
> +rpm_restore:
> +       if (adc->was_rpm_active)
> +               pm_runtime_force_resume(dev);
> +
> +       return ret;
> +}
> +
> +static int rzg2l_adc_resume(struct device *dev)
> +{
> +       struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +       struct rzg2l_adc *adc =3D iio_priv(indio_dev);
> +       struct reset_control_bulk_data resets[] =3D {
> +               { .rstc =3D adc->adrstn },
> +               { .rstc =3D adc->presetn },
> +       };
> +       int ret;
> +
> +       ret =3D reset_control_bulk_deassert(ARRAY_SIZE(resets), resets);
> +       if (ret)
> +               return ret;
> +
> +       if (adc->was_rpm_active) {
> +               ret =3D pm_runtime_force_resume(dev);
> +               if (ret)
> +                       goto resets_restore;
> +       }
> +
> +       ret =3D rzg2l_adc_hw_init(dev, adc);
> +       if (ret)
> +               goto rpm_restore;
> +
> +       return 0;
> +
> +rpm_restore:
> +       if (adc->was_rpm_active) {
> +               pm_runtime_mark_last_busy(dev);
> +               pm_runtime_put_autosuspend(dev);
> +       }
> +resets_restore:
> +       reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
> +       return ret;
> +}
> +
>  static const struct dev_pm_ops rzg2l_adc_pm_ops =3D {
>         RUNTIME_PM_OPS(rzg2l_adc_pm_runtime_suspend, rzg2l_adc_pm_runtime=
_resume, NULL)
> +       SYSTEM_SLEEP_PM_OPS(rzg2l_adc_suspend, rzg2l_adc_resume)
>  };
>
>  static struct platform_driver rzg2l_adc_driver =3D {
> --
> 2.39.2
>
>

