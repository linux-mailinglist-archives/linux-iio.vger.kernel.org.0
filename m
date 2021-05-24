Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7BC38E229
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 10:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhEXILH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 04:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhEXILH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 04:11:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781B6C061574;
        Mon, 24 May 2021 01:09:33 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ml1-20020a17090b3601b029015f9b1ebce0so1485124pjb.5;
        Mon, 24 May 2021 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mnD4LZr5vh+XK9rOEnNIl7niFIb137sw/yseGObE7Qo=;
        b=HOQOAvWtX5lC19tOGny/nwjg4Fbx5t7ovxswRTbeG/BljGJt23qiDkrBtUrrm0ej0R
         njjEm+CWtj7BARm1yVyr4Lf6eYYaLeb9f1oVVERu9TFdSB9VfGq9PoqqUoVDYaHvNJde
         OUavGU1jOowQA0gD/JneY8A9msxwytL1XhNU7JLyeCAMK3icf7wtsNhDWxGJM75weVIi
         n0r10MV1LGI7BSU5UhJs3M7K5yluUHrWwgRvk5gwqhzg+Ubqsq8nJM8ybdCJN0TZLEvy
         Q4LUGESNxq+rIs8AJq71lvFQvXBRmm99Z4OPUj1Y8s9ZQBY6kt859NLc8d+rHc/8Iwnt
         KWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnD4LZr5vh+XK9rOEnNIl7niFIb137sw/yseGObE7Qo=;
        b=Z3dN26eqC1FvDQoUiOWBYx1m+svBqcx8QdPPy/dkX7MYRqlrmMAGz98mOvgCvg31a6
         9LKUNR72MwQBXzJxxt6a88ZASCsz9Dmilxr7tTGKSp2139kz7mdcokRHmc49q3wKx6PE
         3b5Q3W8pAV334EEyd6V7PuZTMF6PlwvlynklAMdxveXi51NYJryzguQAtkqb97MjCWhc
         v8n1kmo7buQh/9Bu3tfE3Bo4r2+pxcivyg2pRAtNEmOj679Pnl7f8rHw6apJNHc1a+B0
         0H5zzZiFsL+OOoBAHNlC1C12WB0Ul5pNWeVdS3g94br8Q0UQyuOD0EaXKsDu5j9ITnyn
         /aqA==
X-Gm-Message-State: AOAM531YMX+ZPykDuJ4E3G/5B7OWS1TNiKD1hcgapxfTFr2l+9dG37zV
        9lZ8bR+jazY0vAJnjCMuPAMq6m2ffXeERTe06jg=
X-Google-Smtp-Source: ABdhPJzLIrL7B36432y+EKVC3r0wTFrpaP48sylTGFqBNMWAhj+uLC+MeuMNBGI/VK+cekzOtXJhnj/OTnTU0F90jEY=
X-Received: by 2002:a17:902:e00e:b029:ef:5f1c:18a8 with SMTP id
 o14-20020a170902e00eb02900ef5f1c18a8mr24599956plo.38.1621843772829; Mon, 24
 May 2021 01:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621786036.git.lucas.p.stankus@gmail.com> <b637a5ecde4e5f9f927a5b104332378d4721c91d.1621786036.git.lucas.p.stankus@gmail.com>
In-Reply-To: <b637a5ecde4e5f9f927a5b104332378d4721c91d.1621786036.git.lucas.p.stankus@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 24 May 2021 11:09:21 +0300
Message-ID: <CA+U=DsqD+g5LDP0Je5WAsrKheYog--OcXNRbLZNxVJ1J6u66XA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] staging: iio: cdc: ad7746: extract capac setup to
 own function
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 23, 2021 at 8:13 PM Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> Refactor the capac register write logic to own function.

Minor typo 'capac' -> 'capdac'

Other than that:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

>
> Also fixes the following checkpatch warning:
> CHECK: Alignment should match open parenthesis
>
> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7746.c | 36 ++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 367a5990ae35..4221312f0a32 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -209,6 +209,19 @@ static const unsigned char ad7746_cap_filter_rate_table[][2] = {
>         {16, 62 + 1}, {13, 77 + 1}, {11, 92 + 1}, {9, 110 + 1},
>  };
>
> +static int ad7746_set_capdac(struct ad7746_chip_info *chip, int channel)
> +{
> +       int ret = i2c_smbus_write_byte_data(chip->client,
> +                                           AD7746_REG_CAPDACA,
> +                                           chip->capdac[channel][0]);
> +       if (ret < 0)
> +               return ret;
> +
> +       return i2c_smbus_write_byte_data(chip->client,
> +                                         AD7746_REG_CAPDACB,
> +                                         chip->capdac[channel][1]);
> +}
> +
>  static int ad7746_select_channel(struct iio_dev *indio_dev,
>                                  struct iio_chan_spec const *chan)
>  {
> @@ -224,17 +237,11 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>                         AD7746_CONF_CAPFS_SHIFT;
>                 delay = ad7746_cap_filter_rate_table[idx][1];
>
> +               ret = ad7746_set_capdac(chip, chan->channel);
> +               if (ret < 0)
> +                       return ret;
> +
>                 if (chip->capdac_set != chan->channel) {
> -                       ret = i2c_smbus_write_byte_data(chip->client,
> -                               AD7746_REG_CAPDACA,
> -                               chip->capdac[chan->channel][0]);
> -                       if (ret < 0)
> -                               return ret;
> -                       ret = i2c_smbus_write_byte_data(chip->client,
> -                               AD7746_REG_CAPDACB,
> -                               chip->capdac[chan->channel][1]);
> -                       if (ret < 0)
> -                               return ret;
>
>                         chip->capdac_set = chan->channel;
>                 }
> @@ -478,14 +485,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>                 chip->capdac[chan->channel][chan->differential] = val > 0 ?
>                         AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0;
>
> -               ret = i2c_smbus_write_byte_data(chip->client,
> -                                               AD7746_REG_CAPDACA,
> -                                               chip->capdac[chan->channel][0]);
> -               if (ret < 0)
> -                       goto out;
> -               ret = i2c_smbus_write_byte_data(chip->client,
> -                                               AD7746_REG_CAPDACB,
> -                                               chip->capdac[chan->channel][1]);
> +               ret = ad7746_set_capdac(chip, chan->channel);
>                 if (ret < 0)
>                         goto out;
>
> --
> 2.31.1
>
