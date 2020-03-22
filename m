Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0618ED49
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 00:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCVXcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 19:32:48 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52468 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVXcr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 19:32:47 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so5266684pjb.2;
        Sun, 22 Mar 2020 16:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IENbMcSGhaQb3ITcGtt42TlCIbqArf7b4nbOoZQxr/0=;
        b=gJZRw8Ghj+uFJGManDNJaEh5tGVtq4ar68g3APlfcnTC/UM62G1dZTEZC9EiOu8x8T
         EK2Lhb7fOV+nIz8/awxFr3MC6r18K4e/v7mi+9CdZi0d9dsTV7JpA2feKrTgAQ3zSF0e
         ceB3BcqEO8fMAUdF9bHFlB9wB0nD0uuNeF55tueTktjXIRPtF1crMVSIUmmXbjimo+kX
         AhZ3ol2geIqX+akPCkQRDT4uFeXHZjfGu2h9E94KPOnSvXuwuqcyuerFu7VfiLWBuCTZ
         GUkXMilftwjvOnXY7haQAu9G4nVpi6H5ZClCl0D9mPR1H8d3tWvEqj5+4MlinWmCeFLO
         B/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IENbMcSGhaQb3ITcGtt42TlCIbqArf7b4nbOoZQxr/0=;
        b=iwiWMRcWB7OF+abAMsi8/lKFtD7OslBLP7qWx2WUoVuCnvGdXtbMKhZqe6z2QAqHgi
         14otWl2qniNSYdDlDQ4rZIjo78URa/cVoBmAk9GgM+/PGN+yq/JMyJ2SpMz1EpQg1nOA
         ydb82BEkM5HSNR2CXQGOJfmdQfeG3Hg2/XnCAM0l1EftJLaHnlMIBInubJbsChjPY6pt
         8CbhqzYVLbEYxGEIEq5C12LNJei2YSuoa1M7yV+Rsxfna0SE7WVV/5hsGmlebfcbJAJH
         GNZGbGZskyQK3asGWzQk4gCrtXGQLe4bngaM2onpNNqCO1ftUFJjKth11bUcnaAqFCyX
         4BNw==
X-Gm-Message-State: ANhLgQ2yFCVLTaYOvpxKYjAYOMsHYRgheY8DhCnaApE6DhyfEMv4OBbS
        RDltNvyhD21hIbQkJuPgWni2N9bhMBvoMp/SbP4=
X-Google-Smtp-Source: ADFU+vuyqy9m3tLnY58woPs/kX8vqXYEvKneO8AtOopyiDKNngQaUcp7XOIiUNm7Ftps1erHsZgDeNLhPXRe7SK387E=
X-Received: by 2002:a17:90a:3602:: with SMTP id s2mr763542pjb.143.1584919965895;
 Sun, 22 Mar 2020 16:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200322224626.13160-1-sravanhome@gmail.com> <20200322224626.13160-4-sravanhome@gmail.com>
In-Reply-To: <20200322224626.13160-4-sravanhome@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Mar 2020 01:32:34 +0200
Message-ID: <CAHp75VfauHuAv1Wr=7ga=G+6JOYXuop_oyXiwmQgKeB2e_z=tQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] iio: adc: mp2629: Add support for mp2629 ADC driver
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 12:47 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>
> Add support for 8-bit resolution ADC readings for input power
> supply and battery charging measurement. Provides voltage, current
> readings to mp2629 power supply driver.

...

> +#include <linux/platform_device.h>

> +#include <linux/of_device.h>

Don't see users of it.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>

> +#include <linux/sysfs.h>

Any users?

> +#include <linux/regmap.h>

Perhaps ordered?

> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>

+ blank line?

> +#include <linux/mfd/mp2629.h>

...

> +static int mp2629_read_raw(struct iio_dev *indio_dev,
> +                       struct iio_chan_spec const *chan,
> +                       int *val, int *val2, long mask)
> +{
> +       struct mp2629_adc *info = iio_priv(indio_dev);
> +       unsigned int rval;
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret = regmap_read(info->regmap, chan->address, &rval);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (chan->address == MP2629_INPUT_VOLT)

> +                       rval &= 0x7f;

GENMASK() ?

> +               *val = rval;
> +               return IIO_VAL_INT;

> +       return 0;
> +}

...

> +       void **pdata = pdev->dev.platform_data;

Same Qs as per other patch.

...

> +       indio_dev->dev.of_node = pdev->dev.of_node;

Jonathan, doesn't IIO core do this for all?

-- 
With Best Regards,
Andy Shevchenko
