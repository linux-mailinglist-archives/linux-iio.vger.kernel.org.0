Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D855636F7A5
	for <lists+linux-iio@lfdr.de>; Fri, 30 Apr 2021 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhD3JQD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Apr 2021 05:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3JQC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Apr 2021 05:16:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A3C06174A;
        Fri, 30 Apr 2021 02:15:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id y30so3859760pgl.7;
        Fri, 30 Apr 2021 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odFquSkZkEYnzN5QXrnzra+3Uu24KSIbK3o19Um7C3M=;
        b=aXHI415P7aenNqjEYlrkQmDpRtJNDcKX3vRMx1OgbQeadNK8lLmKKaUvPSRaGPc/Pj
         kOdaHo3wHEdvQv2IXXleo7tTXnRQQsG6sds0eIKz9yiR6xsG0MYsguK1GNCFvY0rAbXC
         tOML3ugzJK4iJyDzfk7lQYPoJTsQwoBWPY6XgbmTSngO5QrGo/iADjH12tBmb5vcHBP7
         OST5F7L+2sfqMIrwIjLHi+zf86amGHXO4oL7ON9k2LVujC791sjyqJrFEkQMDV3Tk4Tg
         GYsmlwOAXyQ3yrAw1Y3CkWOcBiB/I147s+9Nlg06CzvrLvLA7znnJHvmJM+uTE87GqKR
         rPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odFquSkZkEYnzN5QXrnzra+3Uu24KSIbK3o19Um7C3M=;
        b=gs02Wi+iNDaQz7L//blLvW1/ivHrnfh7N5l9DDdcQS8AySGNBpm7cwFI3MBa9y7HmX
         4NLbfo4SdACmlQnC+H/qhJti1TrDDXBSKkh2I/4Y1ukKHFyFP8NEP7bzYcVr2hQaIF9E
         D9CTXCujX73WpaKG+p30SqtHvMrpcYCr6PEDHig8RaNho7K81PuqS+lUnAPGBi/F9ajd
         Uf97V0VdvtUpx0U6iv4sdwYVN0GdZ6krQ+ZRFaKje1J1NQlctlJwVs1yXPE7keEYo/+8
         UE9RBMJz9wqbKfwKwib2TQFvuBNA/6stmfekeKbGZq3kuY25/heh+CWSmGFVj1ULZ9xQ
         MLSQ==
X-Gm-Message-State: AOAM533x+4ePlyYehwBgDsVpcw7zSU6CVGIcPE6rQWDx4K3oJn7aE/zl
        qZtKdcacKUuhi5qtzbvVIHhIEs1EydyVFWMzSAY=
X-Google-Smtp-Source: ABdhPJwbjUnQTDeseSftAAm1ijrV3IAlPjabUj21Eyr7zp9p7lpSajQ2Ya2ZGHixVk0ZInRqqvW+OI0JHyjCrl9awGw=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr3804058pgs.4.1619774114336;
 Fri, 30 Apr 2021 02:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210429122806.3814330-1-sean@geanix.com> <20210429122806.3814330-6-sean@geanix.com>
In-Reply-To: <20210429122806.3814330-6-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Apr 2021 12:14:58 +0300
Message-ID: <CAHp75VcLusrQ0+4DcXf4o0sS=Jc031LDJT4ReMOhVt0U0-jMWQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] iio: accel: fxls8962af: fix errata bug E3 - I2C
 burst reads
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?B?TnVubyBTw6E=?= <Nuno.Sa@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 29, 2021 at 3:28 PM Sean Nyekjaer <sean@geanix.com> wrote:
>
> When flushing the hw fifo there is a bug in the I2C that prevents burst
> reads of more than one sample pair.

...

> -       ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
> -                             total_length);
> +       if (i2c_verify_client(dev)) {
> +               /*
> +                * Due to errata bug:
> +                * E3: FIFO burst read operation error using I2C interface
> +                * We have to avoid burst reads on I2C..
> +                */
> +               for (i = 0; i < samples; i++) {
> +                       ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB,
> +                                             &buffer[i],
> +                                             sample_length);
> +                       if (ret < 0)
> +                               goto out;
> +               }

Can you rather create a separate function called
fxls8962af_i2c_raw_read_errata3() and use it here by simply

  if (i2c)
    ret = fxls8962af_i2c_raw_read_errata3();
  else
    ret = regmap_raw_read();

?

> +       } else {
> +               ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
> +                                     total_length);
> +       }


-- 
With Best Regards,
Andy Shevchenko
