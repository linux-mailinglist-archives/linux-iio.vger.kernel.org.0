Return-Path: <linux-iio+bounces-13264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9879E87FD
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 22:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470411641F5
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487E19067C;
	Sun,  8 Dec 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGgBSO2i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74141381AF;
	Sun,  8 Dec 2024 21:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733691644; cv=none; b=Cm2r85seo/j0AdYVZovs+3C22nPj/ANg+B672e8E6CkUi9U28y1fTUbM+xCmVmHp9f5xfUQ0bAc/U0n6ZFVuZo6FA2GMFgSoYo8gudUy7BGWeTSj5QxV6MZhl47j8xLLP9eLZpKqNC43rHIUfipffwfkO0z0SIecAtOPkKi1TlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733691644; c=relaxed/simple;
	bh=LawY7VTjy82qN493yKus///aoZ7ktjvzOczCxEn3lpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5PF2o//6R5x58eBr6L4GkIldiXVmTF25KqclmymqANAwmRA2dvO+NOB13HHVu+x1ptI6UXBMA+a6drR2i0L++vGZkZnysWfpnLvJ+EYVGUOsmx+5IILEw4fLN3qxkO4ozwov1z/mz2IboZ6u2N1rdy9jkCMrr86GyaPvoZAGUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGgBSO2i; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5174f298e18so138705e0c.2;
        Sun, 08 Dec 2024 13:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733691641; x=1734296441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBR9I2LLhBavM6gWwf84IgxYEkAh7/X1Nrbt2CbmDUw=;
        b=EGgBSO2iUT0TQKCOoDKYzpSN3ZK9yKEtcltdBBkZDtRq5L/YMx6283R9rQ/7gDaPLC
         uEfkhoKJZ3YPuiLIYkJVoVJnTrwmKnhWZrcTo5sd6+6CjsKL4Uu2Bz/PQEznHK2yeQOo
         Mv+Pq1kXQSA3XYxb6SiFzi74NIovq0roSfaHYvM1HLB6IRjncYeKP08q4swAKIZe4SCS
         KPkFBMQ87JtBSeMzKh+4WFFqeTpOzofsFfyNTIcEq8lXbtwk5U5R5I87/V1mVQIOoJyL
         O/VBMq6YJqJZOU1LqstAyGgqFNJ+g+PslG7xrwH+y8TogeHowxsfBJLnxrFOmJXoKBPa
         vb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733691641; x=1734296441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBR9I2LLhBavM6gWwf84IgxYEkAh7/X1Nrbt2CbmDUw=;
        b=vN2XofGYvw3D9YBA8gn4HXt4DaiWxVZabNHyF1ly0NFBYw7AI5F8hrBRy0NRCdouwN
         i2rUMLueoI0UmR5V5OaYDj5igDxlx0+FRrmGjNNyMOTMs6RDz+KxN5y5YmiVhjAJUfbP
         9dX/aRbRoxtrlcwyO6/3MS96NeA76xFWsI0L/UndKzKp2Ivl/Hbwl/7tPGLhFjYMDviH
         SJt8c8bzuAJsuHAPIqfThEHtiQBLZ1QdcdHhuN+VLrovlTeNcKQ5onF+pAiuD663UAAD
         NVYQ2ZsKdpxku2hdQQMrOilf8F066P/gC9J7XlYu+v3xNz+9MoEV2kWqn5pLrfQTz4aG
         QGeg==
X-Forwarded-Encrypted: i=1; AJvYcCUNf5f6dT0rEXQxX2B1y3r1FwAVv1sQ5OQQZ2Xj5uHkPdPf6tpEfGETPPJYaFY/s63zl7a7Vng1csEU@vger.kernel.org, AJvYcCV6Jf4URG5IpT5FxSgtnhZ+Qir/2LnqFzKPdgs9luvVRECHCPGK6DEaNAIsDt6Hc14JDVyeUQfaPm5G8cRv@vger.kernel.org, AJvYcCV7I6S4sHQXuqmq+TDmrdho5XHetw74XxLE/nJFGWVP8xgrNwFl+3Vft96t6WMZm3ZJ3Hlh5WTiS2SA@vger.kernel.org, AJvYcCWK1l33jhoM62QLKPAQowa8Rks+2jpOlZvQeCUqtf6UREJughItxGiVOMRs92pmUwJR8eHLGc+TpncxJRvpwP8sdWM=@vger.kernel.org, AJvYcCXZv7cw4WuN+xZUjBQoNVUxdscsXbpzkTsjJSHDNrQ4A43WxLN6n0m9+8WAK6Tdi27kdfMqElLJhZRu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9P+Bj83r+1rpyW0IceW0EoCDha5zoZg8/fYRvvPuKv4TpOozM
	ldRQBxk872c4QzOwxdkxUBXQ2NP1DOoKjjgCVGUHL4OvGctlIdUUWdt89AdtcjOsIQvIkaQXYYu
	2a5GujlLnHyiSed2CL395szW2YyQ=
X-Gm-Gg: ASbGncurWyFVm9Y2HokCu6gdLZz1IvfNe2WhADkPRutrjRXQS8g22vWBFLnsWFSnur4
	R8EiD0veHgKTDZpObiKg8qNm2WyRhEoil
X-Google-Smtp-Source: AGHT+IGpnxDhXmjY2S4D3kLPcdkIeaMYrjUsg569Wz8kssTuWnjsE1CnVC3Y/PgByzL01WhnKftreTu8Qf0/L8dWb/Y=
X-Received: by 2002:a05:6122:8603:b0:518:791a:3462 with SMTP id
 71dfb90a1353d-518791a4b33mr638595e0c.9.1733691641319; Sun, 08 Dec 2024
 13:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com> <20241206111337.726244-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241206111337.726244-9-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sun, 8 Dec 2024 21:00:15 +0000
Message-ID: <CA+V-a8sPLhKF-76xMDqiOj0AUcGtcf-=ZVJZK9wvg13T-ZMfBg@mail.gmail.com>
Subject: Re: [PATCH v2 08/15] iio: adc: rzg2l_adc: Enable runtime PM
 autosuspend support
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
> Enable runtime PM autosuspend support for the rzg2l_adc driver. With this
> change, consecutive conversion requests will no longer cause the device t=
o
> be runtime-enabled/disabled after each request. Instead, the device will
> transition based on the delay configured by the user.
>
> This approach reduces the frequency of hardware register access during
> runtime PM suspend/resume cycles, thereby saving CPU cycles.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - used a non-zero default autosusped delay
> - adjusted the patch description to reflect that the default autosuspend
>   delay has been changed
>
>  drivers/iio/adc/rzg2l_adc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 953511191eac..c3f9f95cdbba 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -208,7 +208,8 @@ static int rzg2l_adc_conversion(struct iio_dev *indio=
_dev, struct rzg2l_adc *adc
>         rzg2l_adc_start_stop(adc, false);
>
>  rpm_put:
> -       pm_runtime_put_sync(dev);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);
>         return ret;
>  }
>
> @@ -372,7 +373,8 @@ static int rzg2l_adc_hw_init(struct device *dev, stru=
ct rzg2l_adc *adc)
>         rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>
>  exit_hw_init:
> -       pm_runtime_put_sync(dev);
> +       pm_runtime_mark_last_busy(dev);
> +       pm_runtime_put_autosuspend(dev);
>         return ret;
>  }
>
> @@ -410,6 +412,8 @@ static int rzg2l_adc_probe(struct platform_device *pd=
ev)
>                                      "failed to get/deassert presetn\n");
>         }
>
> +       pm_runtime_set_autosuspend_delay(dev, 300);
> +       pm_runtime_use_autosuspend(dev);
>         ret =3D devm_pm_runtime_enable(dev);
>         if (ret)
>                 return ret;
> --
> 2.39.2
>
>

