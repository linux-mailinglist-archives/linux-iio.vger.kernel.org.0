Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69947386E6C
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 02:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbhERAoq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 20:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbhERAop (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 20:44:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638CAC061573;
        Mon, 17 May 2021 17:43:28 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id 1so6346474qtb.0;
        Mon, 17 May 2021 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tZsE7qYxd3nDHuwaSmlREMeLJi8XLtPn+ZY7CZp+dNk=;
        b=UQZSSkeWbHZDNvk2f8IjSvBZlOQHBiIvTvG/hW0LSNNM77hdKZDTT9KHswNHhjiqj6
         CHRyLaCh/goaB2rSac0wTdrbLTUM6UmWDmjz+gfzn5djiCTHeBLJaX66dm/HHqXVBsC/
         QT5UZgrsy6XiIJU9AoI0cTNdVVS0ZJsFiG+f9D6UdmFTsmsmh0k9l6sAqXbZgANisJzy
         NMGN6vA/FomJuRUHH5hGP/b2ajF2ww3V6KnWbMX+FnG9zUahyi/z0h2BVFJEJpAe/jVL
         vjakngRDzhJhRCV0dlyiQTbQDew5urgN0kkdfbSsNWKwSp08YPCbqRDKXcAe2m4xnYke
         L7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tZsE7qYxd3nDHuwaSmlREMeLJi8XLtPn+ZY7CZp+dNk=;
        b=G0jTwYRLkeCUOLFn8sE0/2XGUEETvmxpd5J6MMXSHqiA9KoYZB8cJcSYeWLKIYREx8
         4axvAlolAg+t8MgCtyB2hDiErhRhxGE1PZpGvrBFGcz4l46+wa3pu5w2THqLjpwiJcsW
         c1aYxkS8OSrYMD64Wor6Oh6rYeP4UGgJ+fJciyj29OMAtrBZV0wNIhp23lkn0CEJyMM3
         BlFD7O10Kwo/JtPuP57TA5LUXIhJ+wWC0pMoNJUkqvs1w+3SluttKpXK54slGCjayXtV
         v5TZgZ8dYybBDY39lvQEbB3/+OAfn19eHoLBVy65HsPgDc5hPc7f6sR7Xuth079OOGRb
         ctBA==
X-Gm-Message-State: AOAM530+lYoRtprnaJNSJJS4Iw3R4z3FOkpxvDk1eYRx0qA2HHUupRel
        GoNyhKrgNvO6BK2D+54JiqaQ+1TrP4CuoneK
X-Google-Smtp-Source: ABdhPJzh5NIvcXxTVpqZq5wFTPuzISxrj1qLS+Do69icnKYn1m/uBsWdwNds+75pJ49OmY40u80JWQ==
X-Received: by 2002:ac8:6c22:: with SMTP id k2mr2162942qtu.303.1621298607295;
        Mon, 17 May 2021 17:43:27 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1002])
        by smtp.gmail.com with ESMTPSA id q192sm11858060qke.89.2021.05.17.17.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 17:43:26 -0700 (PDT)
Date:   Mon, 17 May 2021 21:43:22 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        fabioaiuto83@gmail.com
Subject: Re: [PATCH 1/2] staging: iio: cdc: ad7746: clean up driver comments
 and probe return
Message-ID: <20210518004322.v2hshj2xzj37vgmg@smtp.gmail.com>
References: <cover.1620766020.git.lucas.p.stankus@gmail.com>
 <687a1923add71303da13e3a838e97a6ffc7dcda7.1620766020.git.lucas.p.stankus@gmail.com>
 <20210513170012.78326bfa@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210513170012.78326bfa@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 13, 2021 at 12:59 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 11 May 2021 17:54:01 -0300
> Lucas Stankus <lucas.p.stankus@gmail.com> wrote:
>
> > Remove vague comments, align temperature comment with indent block and
> > simplify probe return on device register.
> >
> > Also fix the following checkpatch warning:
> > CHECK: Alignment should match open parenthesis
> >
> > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
>
> As Fabio pointed out, finer grained patches with one type of change per
> patch would be good.

Thank you both for the review and sorry for the radio silence, I'll split
the patch in the v2.

>
> > ---
> >  drivers/staging/iio/cdc/ad7746.c | 31 ++++++++++---------------------
> >  1 file changed, 10 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > index dfd71e99e872..e03d010b2f4c 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -84,10 +84,6 @@
> >  #define AD7746_CAPDAC_DACEN          BIT(7)
> >  #define AD7746_CAPDAC_DACP(x)                ((x) & 0x7F)
> >
> > -/*
> > - * struct ad7746_chip_info - chip specific information
> > - */
> > -
> >  struct ad7746_chip_info {
> >       struct i2c_client *client;
> >       struct mutex lock; /* protect sensor state */
> > @@ -232,13 +228,14 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
> >
> >               if (chip->capdac_set != chan->channel) {
> >                       ret = i2c_smbus_write_byte_data(chip->client,
> > -                             AD7746_REG_CAPDACA,
> > -                             chip->capdac[chan->channel][0]);
> > +                                                     AD7746_REG_CAPDACA,
> > +                                                     chip->capdac[chan->channel][0]);
> >                       if (ret < 0)
> >                               return ret;
> > +                       ret = i2c_smbus_write_byte_data(chip->client,
> > -                             AD7746_REG_CAPDACB,
> > -                             chip->capdac[chan->channel][1]);
> > +                                                     AD7746_REG_CAPDACB,
> > +                                                     chip->capdac[chan->channel][1]);
> >                       if (ret < 0)
> >                               return ret;
>
> I wondered if it might be sensible to factor this code out to reduce the indent
> and make things more readable.  Having taken a look it seems there is another
> place with exactly the same call sequence.  From how it's used there, I'm
> assuming this is updating the offsets.  As such, I would introduce an
>
> ad7746_offsets_set(struct iio_dev *indio_dev, int channel)
>
> or similar.
>

Makes sense, I'll do that in the v2 as well.

>
> >
> > @@ -564,10 +561,10 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
> >
> >               switch (chan->type) {
> >               case IIO_TEMP:
> > -             /*
> > -              * temperature in milli degrees Celsius
> > -              * T = ((*val / 2048) - 4096) * 1000
> > -              */
> > +                     /*
> > +                      * temperature in milli degrees Celsius
> > +                      * T = ((*val / 2048) - 4096) * 1000
> > +                      */
> >                       *val = (*val * 125) / 256;
> >                       break;
> >               case IIO_VOLTAGE:
> > @@ -669,10 +666,6 @@ static const struct iio_info ad7746_info = {
> >       .write_raw = ad7746_write_raw,
> >  };
> >
> > -/*
> > - * device probe and remove
> > - */
> > -
> >  static int ad7746_probe(struct i2c_client *client,
> >                       const struct i2c_device_id *id)
> >  {
> > @@ -730,11 +723,7 @@ static int ad7746_probe(struct i2c_client *client,
> >       if (ret < 0)
> >               return ret;
> >
> > -     ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> > -     if (ret)
> > -             return ret;
> > -
> > -     return 0;
> > +     return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> >  }
> >
> >  static const struct i2c_device_id ad7746_id[] = {
>
