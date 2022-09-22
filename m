Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96B5E7057
	for <lists+linux-iio@lfdr.de>; Fri, 23 Sep 2022 01:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIVXvA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 19:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIVXu7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 19:50:59 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85477107596
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 16:50:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o7so7302756qkj.10
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Kb05J3BT/GlBgSDEkFzLEBt6C1xktin5vKGv6080wGs=;
        b=XIcDCtsgskXHpXPOpvN2AhiijHgPlBZitXP4GZAqOw5nh7Lz/1gz1PHjRU+9UgyBWW
         Bf+/FjyN+ESyd56vp1Z5Zbjy8Cv7We8xy5iEkx9O1pqCWbC9GLdR1KtLDWf4eRvceZUg
         9yyh3i8jcPgwRrYv1m3DeA/jdsrWnGNHqnDos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Kb05J3BT/GlBgSDEkFzLEBt6C1xktin5vKGv6080wGs=;
        b=UAfNLo0blqdzE99pZjJ+F6TNsdlFMKCgrWNd5gDRATsdLC4k8YCKqn0uZ3+3+BZ8lE
         +u3NqmRC2WeVwqBriFHEchVqlOpaFq7A0GCEj4L+uto7hWCtMVTK0IukoeNphcOb9Zc5
         c9PqGkPvIZpKjOx53dRa5YKMJdP6ScURV8kep1Mr69SW49YQ3gfwxh+qxFAIH3aRkoTf
         GXYAkdRdumUjBfspRDTBaluiZUQSshQclM/JSm9+QU7QIOM9rO/aSOOHycWbYgvLoGRT
         IlFUvdiswcX8XQ0Rk8YsW4BDoiXu791GDicAXjToGibJlkgaEAOpMX9c84eMpelqPgwX
         AvMg==
X-Gm-Message-State: ACrzQf0VKFKtAt607aYbmmQl9px8l+b0BWLBKE0LJc+TRzzqIkzY3sln
        Rl/IsqTlzRIWSS6l1re+yQG0wBnFCTf+XHqxuoihz/y7xZEvQA==
X-Google-Smtp-Source: AMsMyM5W5H2oYVzUjvkPAy1iIsPH1PZQAyUbGvqf9vUXI/2Jsoh3XK30Co0KSixkCgYdlSh7O5B43G8CePhVkcGukCA=
X-Received: by 2002:a37:a17:0:b0:6cd:dbef:1e83 with SMTP id
 23-20020a370a17000000b006cddbef1e83mr3993458qkk.624.1663890657742; Thu, 22
 Sep 2022 16:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220922225012.1709173-1-floridsleeves@gmail.com>
In-Reply-To: <20220922225012.1709173-1-floridsleeves@gmail.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Thu, 22 Sep 2022 16:50:47 -0700
Message-ID: <CAJCx=gkhj9ZmVOe37rGyyjF+3b9Tgb2-bjDQc5kgO3Tt4NmD9A@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/magnetometer/ak8975: check the return value of ak8975_set_mode
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     linux-iio@vger.kernel.org, zheyuma97@gmail.com, nathan@kernel.org,
        paul@crapouillou.net, lars@metafoo.de, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 22, 2022 at 3:50 PM Li Zhong <floridsleeves@gmail.com> wrote:
>
> Check the return value of ak8975_set_mode(). When it fails to write the
> register, the error should at least be propagated to the caller.
> Currently function ak8975_remove() returns the success value 0
> no matter the execution fails or not, which will silently leave the
> error unhandled.
>
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 2432e697150c..e08f10fe16d0 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -1022,16 +1022,17 @@ static int ak8975_remove(struct i2c_client *client)
>  {
>         struct iio_dev *indio_dev = i2c_get_clientdata(client);
>         struct ak8975_data *data = iio_priv(indio_dev);
> +       int err = 0;

Not needed to initialize to zero since it will get set below.

>
>         pm_runtime_get_sync(&client->dev);
>         pm_runtime_put_noidle(&client->dev);
>         pm_runtime_disable(&client->dev);
>         iio_device_unregister(indio_dev);
>         iio_triggered_buffer_cleanup(indio_dev);
> -       ak8975_set_mode(data, POWER_DOWN);
> +       err = ak8975_set_mode(data, POWER_DOWN);

I am not convinced there is a real reason to report this failure from
.remove() since
device is still unregistered and at the worst case it isn't in low-power mode.

Could you explain if this is an issue that actually happens? If it is,
this should be a warning
that is displayed and not a failure to remove the driver.

- Matt

>         ak8975_power_off(data);
>
> -       return 0;
> +       return err;
>  }
>
>  static int ak8975_runtime_suspend(struct device *dev)
> --
> 2.25.1
>
