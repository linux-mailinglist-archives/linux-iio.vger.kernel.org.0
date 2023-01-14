Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B917A66AD09
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jan 2023 18:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjANRWR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Jan 2023 12:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjANRWM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2023 12:22:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903CBB94
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 09:22:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FF9DB80938
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D94C433EF;
        Sat, 14 Jan 2023 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673716926;
        bh=1HRWYmFzAT5/ShMZK0IQmQTvJYxhKS9k4XatFAKgGVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k+m45caSdCO+g7NoDeuJX/8UTg8KN4XT/SMvfwdrm14HmXBuvYPU3t6qL3oLdk/0e
         RyLDiXeKO2Mxub9eUMBkj68TLQ3UR3UroOwICnckSHFT00q3qtHpD4pipOoSTA2QnL
         EUgRE2nRz/kzjVHuc01NRDp3NBFwDcJhuz7ySB2z1yDclVtXj5D8fiyROxZJuX1udS
         OevuCndWk7D1rETiH9RnfWqdyWTWO/CrjSKcFDQcS3t1tu7psRwINb4WwAhZoiPdBn
         34UD8pMutYOocuASTmfiRRuP4akrdEW72/J1A3wbuT2XCyy2mPf1MXoo9ZIr4+6a/9
         WAPdHd8f4uvqA==
Date:   Sat, 14 Jan 2023 17:35:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Carlos Song <carlos.song@nxp.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        Bough Chen <haibo.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v4 2/4] iio: imu: fxos8700: fix failed
 initialization ODR mode assignment
Message-ID: <20230114173543.2be0818e@jic23-huawei>
In-Reply-To: <VI1PR04MB50057136A46A6FA64DBDDC5CE8FF9@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
        <20221228093941.270046-3-carlos.song@nxp.com>
        <20221231145439.08564db1@jic23-huawei>
        <VI1PR04MB50057136A46A6FA64DBDDC5CE8FF9@VI1PR04MB5005.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Jan 2023 07:44:23 +0000
Carlos Song <carlos.song@nxp.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, December 31, 2022 10:55 PM
> > To: Carlos Song <carlos.song@nxp.com>
> > Cc: lars@metafoo.de; rjones@gateworks.com;
> > Jonathan.Cameron@huawei.com; Bough Chen <haibo.chen@nxp.com>;
> > dl-linux-imx <linux-imx@nxp.com>; linux-iio@vger.kernel.org
> > Subject: [EXT] Re: [PATCH v4 2/4] iio: imu: fxos8700: fix failed initialization
> > ODR mode assignment
> > 
> > Caution: EXT Email
> > 
> > On Wed, 28 Dec 2022 17:39:39 +0800
> > carlos.song@nxp.com wrote:
> >   
> > > From: Carlos Song <carlos.song@nxp.com>
> > >
> > > The absence of correct offset leads a failed initialization ODR mode
> > > assignment.
> > >
> > > Select MAX ODR mode as the initialization ODR mode by field mask and
> > > FIELD_PREP.
> > >
> > > Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > ---
> > > Changes for V4:
> > > - None
> > > Changes for V3:
> > > - Legal use of FIELD_PREP() and field mask to select initialization
> > >   ODR mode
> > > - Rework commit log
> > > ---
> > >  drivers/iio/imu/fxos8700_core.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/imu/fxos8700_core.c
> > > b/drivers/iio/imu/fxos8700_core.c index a1af5d0fde5d..de4ced979226
> > > 100644
> > > --- a/drivers/iio/imu/fxos8700_core.c
> > > +++ b/drivers/iio/imu/fxos8700_core.c
> > > @@ -611,6 +611,7 @@ static const struct iio_info fxos8700_info = {
> > > static int fxos8700_chip_init(struct fxos8700_data *data, bool
> > > use_spi)  {
> > >       int ret;
> > > +     int reg;
> > >       unsigned int val;
> > >       struct device *dev = regmap_get_device(data->regmap);
> > >
> > > @@ -663,8 +664,11 @@ static int fxos8700_chip_init(struct fxos8700_data  
> > *data, bool use_spi)  
> > >               return ret;
> > >
> > >       /* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> > > -     return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> > > -                        FXOS8700_CTRL_ODR_MAX |  
> > FXOS8700_ACTIVE);  
> > > +     ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &reg);
> > > +     if (ret)
> > > +             return ret;
> > > +     reg = reg | FIELD_PREP(FXOS8700_CTRL_ODR_MSK,
> > > + FXOS8700_CTRL_ODR_MAX) | FXOS8700_ACTIVE;  
> > reg |= will work here. However, like in previous patch I'd expect to see the
> > _CTRL_ODR_MSK used in
> >         reg &= ~FXOS8700_CTRL_ODR_MASK;
> >         reg |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK,
> > FXOS8700_CTRL_ODR_MAX) | FXOS8700_ACTIVE;
> > 
> > This is a good place to use regmap_update_bits() as there is no need to see
> > what the previous values were (unlike in previous patch).
> >   
> > > +     return regmap_write(data->regmap, FXOS8700_CTRL_REG1, reg);
> > >  }
> > >
> > >  static void fxos8700_chip_uninit(void *data)  
> 
> This is a good place to use regmap_update_bits(), because I don't need using the regmap_read to
> get the value and perform bit operations:
> @@ -666,8 +666,10 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>                 return ret;
> 
>         /* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> -       return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> -                          FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> +       return regmap_update_bits(data->regmap, FXOS8700_CTRL_REG1,
> +                               FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
> +                               FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX) |
> +                               FXOS8700_ACTIVE);
>  }
> 
> 
>  static void fxos8700_chip_uninit(void *data)
> 
> Here I also faced a difficult decision:
> most code block of the entire driver code uses regmap_read and regmap_write to modify registers,
> only my two patches use regmap_update_bits. I admit that this is indeed a good place to
> use regmap_update_bits, but do I need to consider the uniformity of the entire driver code
> style when proposing a patch? When using regmap_read and regmap_write, although the
> patch is a bit lengthy and jumbled, it is very uniform in terms of the overall code style.
> Like this:
> 
> @@ -663,8 +664,11 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>                 return ret;
> 
>         /* Max ODR (800Hz individual or 400Hz hybrid), active mode */
> -       return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> -                          FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> +       ret = regmap_read(data->regmap, FXOS8700_CTRL_REG1, &reg);
> +       if (ret)
> +               return ret;
> +       reg &= ~FXOS8700_CTRL_ODR_MASK;
> +       reg |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK, FXOS8700_CTRL_ODR_MAX) |
> + FXOS8700_ACTIVE;
> +       return regmap_write(data->regmap, FXOS8700_CTRL_REG1, reg);
>  }
> 
>  static void fxos8700_chip_uninit(void *data)
> 
> How should I weigh them?

If code is simpler / more readable with regmap_update_bits() then that is the better
option.  If there are other places in the driver where it is appropriate to change
to this function then it would be great to make that improvement as well (I haven't
looked!)

Jonathan


