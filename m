Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5FB66AD06
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jan 2023 18:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjANRUg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Jan 2023 12:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjANRUf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2023 12:20:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06819B762
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 09:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84B7660B4D
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 17:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F41C433D2;
        Sat, 14 Jan 2023 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673716832;
        bh=8GcIJARxMme6qs1iqwWTKAvG1UI8WRpMJm/cu8LHEkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cGEctlzPrl8ALrqwTPQDBkQ886gH+65zn5FM4R8SOig2MK0U/g0DmzzXJul7mSnjK
         5URd9Gg7sr2Kk6FlHr4uSVRFNqGYb26zvmgU3irYyFQw2nePjoynfPoY1B3HCpm0pI
         b+7JWbDuhHc6P2TqFlrb3nqGBO7diD6AoULs5MLd7Uyj8nU1wnlcwLaTbuSS9ULMiR
         nMAAtlZAwE2OB+P+gkP6+5kuOodWkjzT9cR4ROaFU74sJtxjrOGOs/88NFbGsuvWF0
         hogqID6zEiaBVGy3lQN2lkUdnfavwI2MdpQTHxYWBJifmdAkWuuYQNQTPvyTqmoGhg
         XfGhmJDHiCumQ==
Date:   Sat, 14 Jan 2023 17:34:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Carlos Song <carlos.song@nxp.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        Bough Chen <haibo.chen@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v4 1/4] iio: imu: fxos8700: fix incorrect ODR
 mode readback
Message-ID: <20230114173409.145c0549@jic23-huawei>
In-Reply-To: <VI1PR04MB500569F6060A544F87899C5BE8FF9@VI1PR04MB5005.eurprd04.prod.outlook.com>
References: <20221228093941.270046-1-carlos.song@nxp.com>
        <20221228093941.270046-2-carlos.song@nxp.com>
        <20221231145115.7d9414e5@jic23-huawei>
        <VI1PR04MB500569F6060A544F87899C5BE8FF9@VI1PR04MB5005.eurprd04.prod.outlook.com>
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

On Tue, 10 Jan 2023 07:44:20 +0000
Carlos Song <carlos.song@nxp.com> wrote:

> Hi, Jonathan. I have some doubts about how to use regmap_write() and regmap_updata_bits() appropriately
> and faced difficult decisions. I propose different modifications as follows and I would like to get some suggestions
> from you. Thanks!
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, December 31, 2022 10:51 PM
> > To: Carlos Song <carlos.song@nxp.com>
> > Cc: lars@metafoo.de; rjones@gateworks.com;
> > Jonathan.Cameron@huawei.com; Bough Chen <haibo.chen@nxp.com>;
> > dl-linux-imx <linux-imx@nxp.com>; linux-iio@vger.kernel.org
> > Subject: [EXT] Re: [PATCH v4 1/4] iio: imu: fxos8700: fix incorrect ODR mode
> > readback
> > 
> > Caution: EXT Email
> > 
> > On Wed, 28 Dec 2022 17:39:38 +0800
> > carlos.song@nxp.com wrote:
> >   
> > > From: Carlos Song <carlos.song@nxp.com>
> > >
> > > The absence of a correct offset leads an incorrect ODR mode readback
> > > after use a hexadecimal number to mark the value from
> > > FXOS8700_CTRL_REG1.
> > >
> > > Get ODR mode by field mask and FIELD_GET clearly and conveniently.
> > > And attach other additional fix for keeping the original code logic
> > > and a good readability.
> > >
> > > Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> > > Signed-off-by: Carlos Song <carlos.song@nxp.com>  
> > Hi Carlos,
> > 
> > I'm fairly sure the new code doesn't quite work correctly. See inline.
> > 
> > Jonathan
> >   
> > > ---
> > > Changes for V4:
> > > - Use ODR_MSK in the first place that merged the first two patches
> > >   in V3 into this patch.
> > > - Rework commit log
> > > Changes for V3:
> > > - Remove FXOS8700_CTRL_ODR_GENMSK and set  
> > FXOS8700_CTRL_ODR_MSK a  
> > >   field mask
> > > - Legal use of filed mask and FIELD_PREP() to select ODR mode
> > > - Rework commit log
> > > ---
> > >  drivers/iio/imu/fxos8700_core.c | 11 +++++------
> > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iio/imu/fxos8700_core.c
> > > b/drivers/iio/imu/fxos8700_core.c index 773f62203bf0..a1af5d0fde5d
> > > 100644
> > > --- a/drivers/iio/imu/fxos8700_core.c
> > > +++ b/drivers/iio/imu/fxos8700_core.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/acpi.h>
> > >  #include <linux/bitops.h>
> > > +#include <linux/bitfield.h>
> > >
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > > @@ -144,9 +145,9 @@
> > >  #define FXOS8700_NVM_DATA_BNK0      0xa7
> > >
> > >  /* Bit definitions for FXOS8700_CTRL_REG1 */
> > > -#define FXOS8700_CTRL_ODR_MSK       0x38
> > >  #define FXOS8700_CTRL_ODR_MAX       0x00
> > >  #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
> > > +#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)
> > >
> > >  /* Bit definitions for FXOS8700_M_CTRL_REG1 */
> > >  #define FXOS8700_HMS_MASK           GENMASK(1, 0)
> > > @@ -508,10 +509,8 @@ static int fxos8700_set_odr(struct fxos8700_data  
> > *data, enum fxos8700_sensor t,  
> > >       if (i >= odr_num)
> > >               return -EINVAL;
> > >
> > > -     return regmap_update_bits(data->regmap,
> > > -                               FXOS8700_CTRL_REG1,
> > > -                               FXOS8700_CTRL_ODR_MSK +  
> > FXOS8700_ACTIVE,  
> > > -                               fxos8700_odr[i].bits << 3 |  
> > active_mode);  
> > > +     val = val | FIELD_PREP(FXOS8700_CTRL_ODR_MSK,
> > > + fxos8700_odr[i].bits) | active_mode;  
> > 
> > val |= would be neater.
> > 
> > Also, if I read the existing code correctly, val hasn't been masked, so if
> > active_mode was set in val, it still will be, hence no need to or it in again.
> > You also haven't masked out _CTRL_ODR_MSK so as a result of this call you will
> > get the bitwise or of whatever ODR value you are trying to set and whatever it
> > was set to before.
> > 
> >   
> > > +     return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
> > >  }
> > >  
> 
> I am so sorry that I don't use the FIELD_PREP correctly due to my rustiness.
> Firstly I fix the issue I haven't masked out _CTRL_ODR_MSK. But activating the device
> is required after that so I or FXOS8700_ACTIVE instead or active_mode. Then I want to
> discuss about the appropriate usage scenarios about regmap_write and regmap_update_bits.
> 
> In source code, regmap_write use _regmap_write only while regmap_update_bits encapsulates 
> _regmap_read, modify mask bits and _regmap write. So when need to see what the previous values
> or the value has been already got before and is used at other place, it is better to use regmap_write.
> We just renew the value and use regmap_write to write it to the register. If we just need modify
> the register bits but there is no need to see what the previous values were, it is better to use
> regmap_update_bits. It is a simple and direct means and can avoid using regmap_read to get a value
> and perform bit operations.
> To sum up, if the value of the register has been read by regmap_read or other methods, then use
> regmap_write correspondingly to renew the value. If no value has been obtained from the register,
> modifying the register using regmap_update_bits is the preferred method. I'm not sure if that's the
> right understanding.
> 
> So based on it, there are two reasons that I choose regmap_write to replace regmap_update_bits:
> 1. There is a val which has been get by regmap_read and is used, so just use regmap_write and FIELD_PREP
> to renew the val. 
> 2. The code block used regmap_read and regmap_write to renew the value, uniform use of regmap_write
> can have a good readability.
> 
> So I think the using regmap_write than regmap_update_bits is more reasonable.
> @@ -508,10 +509,9 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>         if (i >= odr_num)
>                 return -EINVAL;
> 
> -       return regmap_update_bits(data->regmap,
> -                                 FXOS8700_CTRL_REG1,
> -                                 FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
> -                                 fxos8700_odr[i].bits << 3 | active_mode);
> +       val &= ~FXOS8700_CTRL_ODR_MSK;
> +       val |= FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits) | FXOS8700_ACTIVE;
> +       return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
>  }
> 
> However there is a minimal fix, the patch looks more graceful:
> @@ -511,7 +512,8 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>         return regmap_update_bits(data->regmap,
>                                   FXOS8700_CTRL_REG1,
>                                   FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
| not + for combining masks. 
> -                                 fxos8700_odr[i].bits << 3 | active_mode);
> +                                 FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits) |
> +                                 FXOS8700_ACTIVE);
>  }
> 
> Which is better? In next patch I also faced a difficult decision about it.

I would go with the regmap_write() choice - though in cases like this I think
most important concern is readability.  Sometimes that means regmap_update_bits()
is a better choice even if we already have the read value available.
I think that's not true here so regmap_write() is better option.

> > >  static int fxos8700_get_odr(struct fxos8700_data *data, enum
> > > fxos8700_sensor t, @@ -524,7 +523,7 @@ static int  
> > fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,  
> > >       if (ret)
> > >               return ret;
> > >
> > > -     val &= FXOS8700_CTRL_ODR_MSK;
> > > +     val = FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
> > >
> > >       for (i = 0; i < odr_num; i++)
> > >               if (val == fxos8700_odr[i].bits)  
> 

