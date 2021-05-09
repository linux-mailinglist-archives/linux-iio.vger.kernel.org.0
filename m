Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9263777C7
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhEIR1l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhEIR1l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 13:27:41 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD26C061573
        for <linux-iio@vger.kernel.org>; Sun,  9 May 2021 10:26:38 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z6so14189753wrm.4
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:subject:from
         :to:cc:references:in-reply-to;
        bh=AERuuXJeCMDAEmKQz1U7heVv2Js4WHBCt6/Zut8OB2Q=;
        b=FgWpl4eqcZe0vJcmPQzYgemLcQQcjd9lnyekr2dxG292+B9BVYQwM12ILyJ2Pjv0eh
         tnhSJfLp7wsd/FvgtC1LiYwVIlWaGgg6j8+PBxJ9g0yJ/teSF6ZvFPYjt7O+YeGrEw2n
         77IJL+HHF2Hbvnzewfd0P/pydFeT73jQQKyMaMVl7NsuGB6PchClHh7ixwQ5Wa+hB6dp
         Yee5M6YclzAYmDa361KOQDQchq4cOhbi06D22m8jzwOknWXTlJNjV11t29yBC+Ta4tDs
         Z1zaKgwHNVpIH+VKcvHDzTVxX+XG3Gh4RSy5xTIzU6WQRcincf6qFb5tR3P4q6+tiqSI
         LFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:subject:from:to:cc:references:in-reply-to;
        bh=AERuuXJeCMDAEmKQz1U7heVv2Js4WHBCt6/Zut8OB2Q=;
        b=DWUM3vTzWbCXzOqZRRdeUUGaxCYZiwvLXteM0FlgnefeIj819/bY5imZOvmyuGSNIg
         hIwvojvbCABQGQgjQcCvZuqeVPfDF01EKaH6V0QgHh0DEtCuCLNjhhb2T+yft41qAS6f
         xHBhDgB7iuwK1UGCp0imZ9XKjZMnxKCTiJSVWvtTUtr69sYYEReeCJrB5Q/y6YjINIG3
         LA0Hsut00r5EddLmv+psr0iwktNiTTlxCP+g0g73wTYGQXgE/8+7p+1/Ve7vCpbJOmSK
         94OeiEOlyUyHiml+8Zq+qM8f27HJODH3i+etq3OSrumrszmzbwfX4zHECrR5jIhq66UI
         T6Rg==
X-Gm-Message-State: AOAM533O85ywPyqDMyMwi0/CIvyht0QoJpsKemAUXjMVrBIBnyAdhpC+
        iI9oUuNxzq5G4mT44BpBknRNT8nd8NvP0w==
X-Google-Smtp-Source: ABdhPJyMI3yglo2LV4CgKRoq9IYWzsbVtVBwZRoWY58KXLwitvUZuXBXpp3j66I3FS5dUB2SzBFORQ==
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr26785903wrz.105.1620581196898;
        Sun, 09 May 2021 10:26:36 -0700 (PDT)
Received: from localhost (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id n10sm19331893wrw.37.2021.05.09.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 10:26:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 09 May 2021 18:26:35 +0100
Message-Id: <CB8W37F6P01Y.1OXBUYVJ2AKOS@arch-thunder>
Subject: Re: [PATCH 01/28] iio: gyro: fxa210002c: Balance runtime pm + use
 pm_runtime_resume_and_get().
From:   "Rui Miguel Silva" <rui.silva@linaro.org>
To:     "Jonathan Cameron" <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Cc:     "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Julia Lawall" <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
References: <20210509113354.660190-1-jic23@kernel.org>
 <20210509113354.660190-2-jic23@kernel.org>
In-Reply-To: <20210509113354.660190-2-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,
thanks for the patch.

On Sun May 9, 2021 at 12:33 PM WEST, Jonathan Cameron wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> In both the probe() error path and remove() pm_runtime_put_noidle()
> is called which will decrement the runtime pm reference count.
> However, there is no matching function to have raised the reference count=
.
> Not this isn't a fix as the runtime pm core will stop the reference count
> going negative anyway.
>
> An alternative would have been to raise the count in these paths, but
> it is not clear why that would be necessary.
>
> Whilst we are here replace some boilerplate with pm_runtime_resume_and_ge=
t()
> Found using coccicheck script under review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.=
fr/
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>

With s/fxa210002c:/fxa21002c:/ in the patch subject:

Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
   Rui

> ---
>  drivers/iio/gyro/fxas21002c_core.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21=
002c_core.c
> index 5af7b48ff01a..539585b0d300 100644
> --- a/drivers/iio/gyro/fxas21002c_core.c
> +++ b/drivers/iio/gyro/fxas21002c_core.c
> @@ -366,14 +366,7 @@ static int fxas21002c_write(struct fxas21002c_data *=
data,
> =20
>  static int  fxas21002c_pm_get(struct fxas21002c_data *data)
>  {
> -	struct device *dev =3D regmap_get_device(data->regmap);
> -	int ret;
> -
> -	ret =3D pm_runtime_get_sync(dev);
> -	if (ret < 0)
> -		pm_runtime_put_noidle(dev);
> -
> -	return ret;
> +	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
>  }
> =20
>  static int  fxas21002c_pm_put(struct fxas21002c_data *data)
> @@ -1002,7 +995,6 @@ int fxas21002c_core_probe(struct device *dev, struct=
 regmap *regmap, int irq,
>  pm_disable:
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
> -	pm_runtime_put_noidle(dev);
> =20
>  	return ret;
>  }
> @@ -1016,7 +1008,6 @@ void fxas21002c_core_remove(struct device *dev)
> =20
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
> -	pm_runtime_put_noidle(dev);
>  }
>  EXPORT_SYMBOL_GPL(fxas21002c_core_remove);
> =20
> --=20
> 2.31.1



