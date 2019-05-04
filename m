Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 900E013958
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2019 12:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfEDKnr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 May 2019 06:43:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40936 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfEDKnr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 May 2019 06:43:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id y64so6322633oia.7;
        Sat, 04 May 2019 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jP4HbLDkknhP4A9EDJa5u2q42TL/gPI6IzJv6fDFbOE=;
        b=QxVjpKX4PVr06tzfYCHVDnwasOj8Lay1fQHuq7MDHynAVFS1ghYDIn9Epz8T7hksdl
         +Sn6K4p1MCxfb0Sjol0zvoAqsv0sYvL/8kBiHCdOyHmHRM2lwgZCJwf7VgcENDcgrR+2
         /V3yVEVrmHPz1xsXnCWkShf0F/Uk6Xrd3RUK0PKCW5D1AotrYrTMbKPLosAww7GsY7yY
         wJmmWdsdevwn3IDuJcYjWu5fEGgwfWxBjv22eUzl3xgfE0GUtuDBW7sYqjj04XmIYath
         /xX1t1eVkuxSVLnC0Pfq/6ZwtaCuMGDzETzGUrd17jjbamU8lnQzgSRxhQCobguc0J26
         uzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jP4HbLDkknhP4A9EDJa5u2q42TL/gPI6IzJv6fDFbOE=;
        b=qr7T5D5XCOCRevjhcinKh//epQ/L7VLcnZ4awEg6yn790ZdW4JFpQqNRWQ5F+MvsYU
         wldtq3TjiRYlPo0PJmpwFbzhpyMjX4DoeFaQ3CifT+bytgeVSawknGYamNkC3s98UQ4Q
         V74Hpr6vh60AlJOUFk0EUyfML4rP315BIOERQrrZFkvyMlYkYt2/LaYJShdhzgS7gLXi
         OZMgJI8C5LdSZWtkTs2bTgr7hJFSUBuyjGymYqwq9jKZndxhPC+SxM8ohjt+mDHjepS6
         kX8vJiE1B5PYuYUGK00KhTgK6p2505Y3QbXgeqb4fCtn7UCgOYIORchsIUsYwp1iq7MH
         7vjA==
X-Gm-Message-State: APjAAAXG6BEYiCvGBJKBICJNKbdTsxmU8/j2LRMLsFRKdioFmzzrIMhI
        YQgmBRFV/Tz+RD9CLd2rCf0dJawqTTbznVpN1Lg=
X-Google-Smtp-Source: APXvYqwCrRtjDLEJreXyuy076r7vAv19fwipMMdtgaVutPfe+ZBelYYYdLgoyxQ3nllr1qxbJe0rltNF0vUGorWhUNA=
X-Received: by 2002:aca:305:: with SMTP id 5mr2011759oid.117.1556966626650;
 Sat, 04 May 2019 03:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556919363.git.melissa.srw@gmail.com> <7f7d36348bca1de25bd70350b7c665be6441250f.1556919363.git.melissa.srw@gmail.com>
In-Reply-To: <7f7d36348bca1de25bd70350b7c665be6441250f.1556919363.git.melissa.srw@gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sat, 4 May 2019 13:43:34 +0300
Message-ID: <CA+U=Dso6zSLzhhdiZcc+P4-2zcabxnoMd2539HmofTXrtYoKDQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] staging: iio: ad7150: use FIELD_GET and GENMASK
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-usp@googlegroups.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 4, 2019 at 1:25 AM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> Use the bitfield macro FIELD_GET, and GENMASK to do the shift and mask in
> one go. This makes the code more readable than explicit masking followed
> by a shift.
>

This looks neat.
I'd have to remember to ack it from my work email.

One minor comment inline, which would be the object of a new patch.

> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  drivers/staging/iio/cdc/ad7150.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 24601ba7db88..4ba46fb6ac02 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -5,6 +5,7 @@
>   * Copyright 2010-2011 Analog Devices Inc.
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -44,6 +45,9 @@
>  #define AD7150_SN0_REG                         0x16
>  #define AD7150_ID_REG                          0x17
>
> +/* AD7150 masks */
> +#define AD7150_THRESHTYPE_MSK                  GENMASK(6, 5)
> +
>  /**
>   * struct ad7150_chip_info - instance specific chip data
>   * @client: i2c client for this device
> @@ -136,7 +140,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
>         if (ret < 0)
>                 return ret;
>
> -       threshtype = (ret >> 5) & 0x03;
> +       threshtype = FIELD_GET(AD7150_THRESHTYPE_MSK, ret);
>         adaptive = !!(ret & 0x80);

Why not also do something similar for the `adaptive` value ?

>
>         switch (type) {
> --
> 2.20.1
>
