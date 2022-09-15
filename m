Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325565B9D72
	for <lists+linux-iio@lfdr.de>; Thu, 15 Sep 2022 16:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiIOOiG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Sep 2022 10:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIOOhb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2022 10:37:31 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8769E6B4
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 07:36:10 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-127f5411b9cso47765034fac.4
        for <linux-iio@vger.kernel.org>; Thu, 15 Sep 2022 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Zr0MOjMyJ6WGRsERkhoXjTXWIw4oT4dBi2Wz+SVWe98=;
        b=MWwj6VeFoHgj5/3eit/oxW6bAWnNYIjrRgjtLUhPpVWH4i3gh6+Kdhwe6G9kKWK7Y+
         Wtyll+uKUfso51oiIxfuu6OByixdV1/4tYlDoL1yyBnNtmILX50Gx0qd727qrXPdbrl1
         +/DGmiBGNF34sz6OOO+++bJw1FrDKV2SCcG5CWCULCt6WP+CWo4BiOAb7aH9fudiZLx2
         ioigFbhWdhcm+5WOvNC1odH68jQ1aYOd8wAK0NOcND5NmlSSRJE80R+WDS+bMX5rQUsT
         ryzgwTe68xOmq3LvDm6UvlHDLNxZoQAw0cFW7LwbDK/iZnBWMuUm47LH8ZsDno9B82Cm
         sqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Zr0MOjMyJ6WGRsERkhoXjTXWIw4oT4dBi2Wz+SVWe98=;
        b=MFlAaI0PqXHoYnw6hEnoahzh3z8pJWvv/YRVrSV7AejSz0Yxeq+Y7MD34Qm4kYSC50
         ScHi5TVyRzOuZzPf6D6Ld4T9NRPNJ1Ty6ahXSq+d6iHPrMXgKRpwuMdMoCQ1QRjJonnx
         W+W3XYkHYWDJ6EbBnAfmGekFA7wIfoSWeRMJuZc5jUrPZdXhykXoIA/7KTjdfU8G5TZN
         +ymq9TLLd704fCnQjNQDf7hFCBzHpP7HxyWw0Fu6olEVz/NcUEp4IbprsPLnv2o7ubyj
         oVF0usMTtWiS/gAe7DPdwI18MSf9U1k2O9JKFo9ozblG+hSpgSbNuEiZfbh2Opxd6vBM
         0PUw==
X-Gm-Message-State: ACgBeo2ApKM9S/CJp//j9f6SdW2J4HLdDbYVUC/fG+hWGZNf0u9fJotH
        urkKnQenGS8H2qj+8CVapUJxaKNg/XFoutP7cpbLeNz7w7o=
X-Google-Smtp-Source: AA6agR5lghRRXWw0R59Hhnd0mNw6jUREHggPbSqfDKsiOlYodoP3EA7gazsus1vkNSFxYZ70kYfDIkkwjmQvgqlsmzQ=
X-Received: by 2002:a05:6870:4586:b0:10d:2ec7:be6 with SMTP id
 y6-20020a056870458600b0010d2ec70be6mr5732908oao.7.1663252569231; Thu, 15 Sep
 2022 07:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
 <20220915150752.643a3e7d@jic23-huawei>
In-Reply-To: <20220915150752.643a3e7d@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Thu, 15 Sep 2022 16:35:33 +0200
Message-ID: <CAKv63utO6_vPtuCZKSa5MFFKbSYPQbrAGytiiqT+CZ402rO9fA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > +     pm_runtime_get_sync(dev);
> So, this isn't quite enough.
>
> Take a look at what devm_pm_runtime_enable()
> does as the documentation for
> pm_runtime_use_autosuspend()
>
> I'd suggest using devm_pm_runtime_enable() and
> an additional callback to turn the device on that
> is registered after devm_pm_runtime_enable()
> (so will maintain the ordering you have here).
>
>
>
I copied this from pressure/bmp280-core driver. I had devm_pm
originally, but was asked to replace it.

> > +     pm_runtime_put_noidle(dev);
> > +     pm_runtime_disable(dev);
> > +}
> > +
> >  static int mlx90632_probe(struct i2c_client *client,
> >                         const struct i2c_device_id *id)
> >  {
> > @@ -902,6 +1132,7 @@ static int mlx90632_probe(struct i2c_client *client,
> >       mlx90632->client = client;
> >       mlx90632->regmap = regmap;
> >       mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
> > +     mlx90632->powerstatus = MLX90632_PWR_STATUS_HALT;
> >
> >       mutex_init(&mlx90632->lock);
> >       indio_dev->name = id->name;
> > @@ -961,16 +1192,25 @@ static int mlx90632_probe(struct i2c_client *client,
> >
> >       mlx90632->emissivity = 1000;
> >       mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
> > +     mlx90632->interaction_ts = jiffies; /* Set initial value */
> >
> > -     pm_runtime_disable(&client->dev);
> > +     pm_runtime_get_noresume(&client->dev);
> >       ret = pm_runtime_set_active(&client->dev);
> >       if (ret < 0) {
> >               mlx90632_sleep(mlx90632);
> >               return ret;
> >       }
> > +
> >       pm_runtime_enable(&client->dev);
> >       pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
> >       pm_runtime_use_autosuspend(&client->dev);
> > +     pm_runtime_put_autosuspend(&client->dev);
> > +
> > +     ret = devm_add_action_or_reset(&client->dev, mlx90632_pm_disable, &client->dev);
>
> Having moved those over to devm you need to also have dropped the calls in remove()
> (I only noticed this whilst trying to fix the autosuspend issue above.)

So in remove, there should be no pm calls, because mlx90632_pm_disable
function handle all of it? I still keep the sleep call, so that it
also puts the sensor in lowest state, or I rather keep it only in
regulator_disable (which should also be called at removal)?

> > +     if (ret) {
> > +             mlx90632_sleep(mlx90632);
> > +             return ret;
> > +     }
> >
> >       return iio_device_register(indio_dev);
> >  }
>
