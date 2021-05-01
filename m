Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C44037087F
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhEASw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhEASwZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 14:52:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A9C06174A;
        Sat,  1 May 2021 11:51:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g24so10623pji.4;
        Sat, 01 May 2021 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9QmVXfLkTw1zNNMQStYuhz9Zt843wMdfp/E3JE6lM/o=;
        b=KdvBNvPEtgiZoRZVJrk++uLbmvN8h5v3fMKm7x5485sesCJkYFjTF/O4prtArEN6OQ
         167Y3hnjPdPvKtXr7RXYkgQ6YgOxvb3Tgpje8/ItBIJx3V3xTj1UjL91iFjff9h/f5rT
         /GA22hsykC3RMTL9+M0zqOFb0IJ8cG8p6F/hYyNFy75GAjinFxjg4v5P636nzjsJob4F
         PqwmdRZVwhzt1sVOzfTsiCtnQ80LaEp+KKqhpkSvq1gPJsNBej/xpAc+FznzFByQICc5
         SdoSC9qrOFl1KmA78gYkVW172masDLv7dPxT5WSgxzaVhe6TapcB/VPC65WoV7hUF7Qq
         A9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QmVXfLkTw1zNNMQStYuhz9Zt843wMdfp/E3JE6lM/o=;
        b=NCDhBHrJs78DOVoUw0tD7rVYOW4jYXvQruy/+i9EhhAISuBVWLn5lgFWniTZNfyE67
         Ftreqnc5hwSgfoK2AvlCS6PTt1lyOSmGRp62+tZkDA9GOwOglvKcsTMoitMrPySdGzPU
         1rjovjIkHXT1RR8jyi4QwHFVsdzGCVzNOjn5QYPKQlZQcYd6/TIP2CHb0w87JBZQYD/Y
         pZQFRV3tVEgS+MVT9cFwsyfMgqwv4sqRGvYG5RTfMsucWbqy3u1O4ayypU3/gCPz6MgP
         JfOemWgZc2cezDW98BpyDyEl/s+A9Fv6QdWLigj2GShReGHCkQGyqOwVgLbhtHDES5/H
         5OLA==
X-Gm-Message-State: AOAM5303OGQn6DQcupNKUI9gSDGNTe836bzuFAbYnV/8wI+s7oQuSRGw
        e0lLpUCcjzc2pq0V/o5sWXJiSbu5y39toCT6kXtHyrDdn1MImQ==
X-Google-Smtp-Source: ABdhPJwXVzm57ZrGTj9oA8/HyNnsThW1//wNG3jpAoONpvR/k1vG0Y5f0EYECUM9RmSAlwXIq65vAALfHDdISho7Dco=
X-Received: by 2002:a17:902:ecc6:b029:ee:af8f:899e with SMTP id
 a6-20020a170902ecc6b02900eeaf8f899emr5599000plh.21.1619895092758; Sat, 01 May
 2021 11:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210430152419.261757-1-i.mikhaylov@yadro.com> <20210430152419.261757-3-i.mikhaylov@yadro.com>
In-Reply-To: <20210430152419.261757-3-i.mikhaylov@yadro.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 1 May 2021 21:51:15 +0300
Message-ID: <CAHp75VeRpEgpFe2J0epjJQsBS346B+vDJ+74fFumFCN2Sy6FCA@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: proximity: vcnl3020: add threshold options
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 30, 2021 at 6:16 PM Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:
>
> Add the low/high threshold options.

...

> +                       rc = regmap_bulk_read(data->regmap, VCNL_PS_HI_THR_HI,
> +                                             &res, 2);

sizeof(res)

> +                       *val = be16_to_cpu(res);

So, the rule of thumb is not putting anything to the output, until you
know that there is no error.

> +                       if (rc < 0)
> +                               return rc;

...

> +                       rc = regmap_bulk_read(data->regmap, VCNL_PS_LO_THR_HI,
> +                                             &res, 2);
> +                       *val = be16_to_cpu(res);
> +                       if (rc < 0)
> +                               return rc;

As per above.

...

> +                       rc = regmap_bulk_write(data->regmap, VCNL_PS_HI_THR_HI,
> +                                              &buf, 2);

sizeof(buf) ?

...

> +                       rc = regmap_bulk_write(data->regmap, VCNL_PS_LO_THR_HI,
> +                                              &buf, 2);

Ditto.

...

> +end:

out_release_direct_mode:

> +       iio_device_release_direct_mode(indio_dev);
> +       return rc;

-- 
With Best Regards,
Andy Shevchenko
