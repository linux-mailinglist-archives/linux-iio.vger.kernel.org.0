Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C613CB926
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jul 2021 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbhGPO45 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Jul 2021 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbhGPO44 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Jul 2021 10:56:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2E5C06175F;
        Fri, 16 Jul 2021 07:54:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id o4so5577736pgs.6;
        Fri, 16 Jul 2021 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDFHDauT3RJ9MLsKNJdQMhfJiWSb2KAxAbOMS927HhU=;
        b=KpBBrYJ3ymii565DyMrXFfKsQTCqKhgJ+ot1+aN4qxdxBK1RgZcyUNeEKf5HYAq/gM
         7ckGW5Le4rwCAqb9JS/DyU3laIhdKGc8RpRopxtxsEx1QRr3Q60nKFyRmtBKZJzuOsK7
         ZZ/EBmSEdAo9YiXW33WGXCJWp83mN/BCwOZsHK9E0ZIwIXTu+XpymmS8+6tkpwmGn3SR
         /Rk4gCDCHw4hdQdTZCF4KXc9JfzUPEpdH7u5YzGlYocJ3Jmx1B5466LEmMl1UTgLqRWK
         s3J2Z16zq4PqMAPv5aOjj7cpGfsog+c5BHrZWUihbAk8Ai37KdJ6ZAfysU5AkWCbQCSc
         5HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDFHDauT3RJ9MLsKNJdQMhfJiWSb2KAxAbOMS927HhU=;
        b=mxmMu4OyymU4hE0NOaEXh6YqmVBt8+y2hFcqucxBMD6KT4nNrpUGXWpJjYtHlmZ0BP
         2j6Lhegrtzr+nP4jAmvPQxVPDUr7d8SzY6rto9NZ/FDPlKLsXM+LtwVJ4e++ju7FLO7d
         vRCWeIYenQvmjQwG3OUMA/KDwMAU9txIarijXs91/QRKIth9rKwHI6AbwL0xM/SzfwXy
         /IVwWpNTLf1qC83KhjeNU3oOPMqgLYMw8sUWxyJCUrE+xIb/zJ4tqOcS8ErH9pzwnpJZ
         yOoMpP6eBVAnOdnt5BevLQTc/IIB5pw+6dHSGM5/nqX0BRfcUJwq7y2sDvSFkXRUjqjF
         EuNw==
X-Gm-Message-State: AOAM530HOpiiV6+0n5wA/OYPysGxsaJVrBuZ8ArrRZPT9YS26OcINrJu
        sRIqnnuKZ0CWHu4KCQEXBFyJ/fvj/ClIZnFveUo=
X-Google-Smtp-Source: ABdhPJwrnQLDM3CmbO7oL7frLjtutRJ3EBFjW/GxP0M9L+KriSV2r931SlxV2mYrZkeBvx+vwLNZJ/TaszKF41ugmNs=
X-Received: by 2002:a65:434a:: with SMTP id k10mr10456163pgq.4.1626447241433;
 Fri, 16 Jul 2021 07:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
In-Reply-To: <20210716114210.141560-1-antoniu.miclaus@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Jul 2021 17:53:22 +0300
Message-ID: <CAHp75VcNhJrp4YGZQu1ZB2J4ARtuT2T2p-72H1qn4F+KtZDVoQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] iio: frequency: adrf6780: add support for ADRF6780
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 16, 2021 at 2:43 PM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> microwave upconverter optimized for point to point microwave
> radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> range.

> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADRF6780.pdf

Is it one line? If not, please put on one line and drop below the
blank line so it will go as a tag.

>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

First question is why not to use the regmap API (I have heard it has
gained support of 17 bit)?

...

> +        depends on COMMON_CLK

Is it mandatory for any function inside the device?

...

> +static int adrf6780_spi_read(struct adrf6780_dev *dev, unsigned int reg,
> +                             unsigned int *val)
> +{
> +       int ret;
> +       struct spi_transfer t = {0};

> +       dev->data[0] = 0x80 | (reg << 1);

This 0x80 I guess is pretty much standard and regmap SPI supports it.

> +       dev->data[1] = 0x0;
> +       dev->data[2] = 0x0;
> +
> +       t.rx_buf = &dev->data[0];
> +       t.tx_buf = &dev->data[0];
> +       t.len = 3;
> +
> +       ret = spi_sync_transfer(dev->spi, &t, 1);
> +       if (ret)
> +               return ret;
> +
> +       *val = (get_unaligned_be24(&dev->data[0]) >> 1) & GENMASK(15, 0);
> +
> +       return ret;
> +}

...

> +       usleep_range(200, 250);

Needs a comment.

-- 
With Best Regards,
Andy Shevchenko
