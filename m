Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6933562E9
	for <lists+linux-iio@lfdr.de>; Wed,  7 Apr 2021 07:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbhDGFNk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Apr 2021 01:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhDGFNj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Apr 2021 01:13:39 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED8BC06174A;
        Tue,  6 Apr 2021 22:13:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y1so19096211ljm.10;
        Tue, 06 Apr 2021 22:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODqZnnD2EEay1SllWXm37iJmFhlL6e0CZyIcJ3pNyrA=;
        b=X0GuxvoH74m6tfZhWB7OeOGuHlbs6pl4rkMgCIpO7YiEB1msDw75dbeMS2LFBdcMek
         s7zidhBzF527bef6+xItUmTBC3Ipee+Euc4ATumelPLYN1h661ZnnB6rb9YnS9VIdMKs
         CkVgOdQGRnoIbJbgksrUSg/to8IEXrDJhFJAlIgctrRPoX3mJtQGKaZm9OiSxdnk0aW1
         4YgINIuu/bMEtKUsSilDcYD42Y83EkMzjZrKTOtqRTgDcC8kndRylNx8LZrLJWCzSVyP
         jO7bCHBw8gr09z2ABMGMckpO+DYkXFMR3OTk/4vkL7qixvl2E64hE7SKenXTO6ME4Vju
         WLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODqZnnD2EEay1SllWXm37iJmFhlL6e0CZyIcJ3pNyrA=;
        b=URucd4IYXH4Yv/p0dx8HhZkSmLhhOU9Wqj07s9RB4tv9cEIlgDDL+nDeSyxjx0ijKn
         aeusYTM/iesJSXA/8GneEMdnyIZa25OMfRwLB/o1r9pdCAJBlqq8kZpdgC8I9RdPimwn
         RQMOCGmmnjCsf+PevsxzaawBqac42hSTgzSKB1g1ocN8vGmbBNlbZ3Pt90J5skRH2jQV
         NYGGCfQ+S58LJf23mGweVv7bVcrJBqTVokpY+i9SjuQ1uJTmIBKLuyYmfpAEBnUL/83U
         JhBMXJKs8DD5WjPdR0NORqq01DfadvOlZjEza96jWvbp9v39eZxxsWoLMU1v6ikMXOyG
         XVvQ==
X-Gm-Message-State: AOAM530vzuOUFpMOAT4rlSNWTphNztaEGJbPVAtd6KjectxgzlpeQKHT
        96DUYVyY9ZM92mrvV2MCr+kQICK3hY2ZcHp9rk4=
X-Google-Smtp-Source: ABdhPJxE9idQPq6DN473Lea7pF/dCU6/HVLho/BwkJv4DZAgkBE/XxvaQg+GZBJMmwbIYqHwODvtgnbHq3xwqrxKGUs=
X-Received: by 2002:a2e:5c47:: with SMTP id q68mr1005136ljb.314.1617772408480;
 Tue, 06 Apr 2021 22:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210406182852.263605-1-puranjay12@gmail.com> <20210406182852.263605-3-puranjay12@gmail.com>
 <3d840334-2c26-5748-8370-54cef6262e02@metafoo.de>
In-Reply-To: <3d840334-2c26-5748-8370-54cef6262e02@metafoo.de>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Wed, 7 Apr 2021 10:43:15 +0530
Message-ID: <CANk7y0gK-ObGY_u+W_15i7Lo0CjBc1+-XMaVorhJZFJW0YaVrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: temperature: add driver support for ti tmp117
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     alexandru.ardelean@analog.com, Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 7, 2021 at 10:26 AM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 4/6/21 8:28 PM, Puranjay Mohan wrote:
> > +
> > +static int tmp117_write_raw(struct iio_dev *indio_dev,
> > +             struct iio_chan_spec const *channel, int val,
> > +             int val2, long mask)
> > +{
> > +     struct tmp117_data *data = iio_priv(indio_dev);
> > +     s16 off;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_CALIBBIAS:
> > +             off = clamp(val, -32768, 32767);
> > +             if (off == data->calibbias)
>
> data->calibbias is only set in probe() and always 0. I'm not sure we
> need to cache the value. Reading it back from the device seems fine.
I forgot to update it, thanks for finding the bug.
Actually, I wanted to update the calibbias register only if a
different value is being written.
If the same value is written to the device repeatedly then we can save
some I2C writes using this.

and while reading the calibbias, it is read from the device only.
I will fix the bug in the next revision.

>
> > +                     return 0;
> > +             return i2c_smbus_write_word_swapped(data->client,
> > +                                             TMP117_REG_TEMP_OFFSET, off);
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
>


-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
