Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9864AB0BC
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiBFQyi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 11:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiBFQyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 11:54:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2AC06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 08:54:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E1B61159
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 16:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CD9C340E9;
        Sun,  6 Feb 2022 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644166475;
        bh=NYF4qadFFdyoJz+sbeYc0niAZ1xECSrR5hXGWvVDSYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nLbNH6XsXZmzh8ZGrGgc6Cv9B3jVfKg4sZvf6qnAtvftjqtAoDqGlEwR4fjYiVI5d
         8NmPq0LY3aj8wJCheoLBjJbACFYYrK9aqTcm/nZZst1cOFzUYmjVSBmXkTbqyQfx5N
         AEi5vRf35d124d2W7tKUst4dflIQ2lzv4EIg2XWqfQVL2eNFYPUg+OdBGDJemtJUXq
         OOXpgx+M5y7ldGwlHrGTjtLrNJkT7cedFqrcRPvBG3tMbpZeoSTtialkqwXbJMSRpr
         60lGKI9MxLS6jutO+YwwLwhtHdcUG1QY+hPZ5eMWMWtJRYeCVy4DP0tDwVAR1ua3z2
         Yao/PY/KbqRVg==
Date:   Sun, 6 Feb 2022 17:01:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        lars@metafoo.de, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 02/17] staging:iio:adc:ad7280a: Register define
 cleanup.
Message-ID: <20220206170106.69146c7a@jic23-huawei>
In-Reply-To: <Ybc/bh8Xhm6+EcBC@marsc.168.1.7>
References: <20211205202710.2847005-1-jic23@kernel.org>
        <20211205202710.2847005-3-jic23@kernel.org>
        <Ybc/bh8Xhm6+EcBC@marsc.168.1.7>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Dec 2021 09:41:18 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Looks overall good.
> A few comments inline.
> 
> On 12/05, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > 1. Postfix register addresses with _REG to distinguish them from
> >    fields within the registers
> > 2. Switch to using FIELD_PREP and masks to aid readability.
> > 3. Shorten a few defines to make the lines remain a sensible length.
> > 4. Fix an issue whether where an CTRL_LB field is set in CTRL_HB.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7280a.c | 299 ++++++++++++++++--------------
> >  1 file changed, 161 insertions(+), 138 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> > index 20183b2ea127..d169c8a7b5f1 100644
> > --- a/drivers/staging/iio/adc/ad7280a.c
> > +++ b/drivers/staging/iio/adc/ad7280a.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/spi/spi.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/err.h>
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> > @@ -23,78 +24,86 @@
> >  #include "ad7280a.h"
> >  
..


> > -/* Bits and Masks */
> > -#define AD7280A_CTRL_HB_CONV_INPUT_ALL			0
> > -#define AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_4	BIT(6)
> > -#define AD7280A_CTRL_HB_CONV_INPUT_6CELL		BIT(7)
> > -#define AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		(BIT(7) | BIT(6))
> > -#define AD7280A_CTRL_HB_CONV_RES_READ_ALL		0
> > -#define AD7280A_CTRL_HB_CONV_RES_READ_6CELL_AUX1_3_4	BIT(4)
...

> > +#define   AD7280A_CTRL_HB_CONV_INPUT_MSK		GENMASK(7, 6)
> > +#define     AD7280A_CTRL_HB_CONV_INPUT_ALL			0
> > +#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_4		1  
> typo, guess you meant
> #define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_5		1

That interesting. Was wrong in original code too..
Fixed and added a note to the patch description on this.  Doesn't seem
worth a separate patch as it's not used yet...

Excellent spot.

> 
> > +#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL			2
> > +#define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		3
> > +#define   AD7280A_CTRL_HB_CONV_RREAD_MSK		GENMASK(5, 4)
> > +#define     AD7280A_CTRL_HB_CONV_RREAD_ALL			0
> > +#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_4		1  
> Same here
> #define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_5		1
> 

...

> > @@ -781,17 +805,19 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> >  		goto out;
> >  
> >  	for (i = 0; i < st->scan_cnt; i++) {
> > -		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
> > -			if (((channels[i] >> 11) & 0xFFF) >=
> > -			    st->cell_threshhigh) {
> > +		unsigned int val;
> > +
> > +		val = FIELD_GET(AD7280A_TRANS_READ_CONV_DATA_MSK, channels[i]);  
> AD7280A_TRANS_READ_CONV_DATA_MSK is defined in patch 5.
> Guess its simpler to delay this change to patch 5.

Good find.  I just hit this whilst applying the patch to current kernel
and it not building. oops. Guess I didn't test build at this point in the
series! Indeed make sense to delay this until patch 5.

> 
> > +		if (FIELD_GET(AD7280A_TRANS_READ_CONV_CHANADDR_MSK, channels[i])  
> Same for AD7280A_TRANS_READ_CONV_CHANADDR_MSK.
> 
> > +			<= AD7280A_CELL_VOLTAGE_6_REG) {
> > +			if (val >= st->cell_threshhigh) {  
> These uses of val would also be delayed to patch 5
> 
> >  				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> >  							 IIO_EV_DIR_RISING,
> >  							 IIO_EV_TYPE_THRESH,
> >  							 0, 0, 0);
> >  				iio_push_event(indio_dev, tmp,
> >  					       iio_get_time_ns(indio_dev));
> > -			} else if (((channels[i] >> 11) & 0xFFF) <=
> > -				   st->cell_threshlow) {
> > +			} else if (val <= st->cell_threshlow) {
> >  				u64 tmp = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
> >  							 IIO_EV_DIR_FALLING,
> >  							 IIO_EV_TYPE_THRESH,
> > @@ -800,15 +826,13 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
> >  					       iio_get_time_ns(indio_dev));
> >  			}
> >  		} else {
> > -			if (((channels[i] >> 11) & 0xFFF) >=
> > -			    st->aux_threshhigh) {
> > +			if (val >= st->aux_threshhigh) {
> >  				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> >  							IIO_EV_TYPE_THRESH,
> >  							IIO_EV_DIR_RISING);
> >  				iio_push_event(indio_dev, tmp,
> >  					       iio_get_time_ns(indio_dev));
> > -			} else if (((channels[i] >> 11) & 0xFFF) <=
> > -				st->aux_threshlow) {
> > +			} else if (val <= st->aux_threshlow) {
> >  				u64 tmp = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> >  							IIO_EV_TYPE_THRESH,
> >  							IIO_EV_DIR_FALLING);

...
> > @@ -942,10 +966,9 @@ static int ad7280_probe(struct spi_device *spi)
> >  	st->spi->mode = SPI_MODE_1;
> >  	spi_setup(st->spi);
> >  
> > -	st->ctrl_lb = AD7280A_CTRL_LB_ACQ_TIME(pdata->acquisition_time & 0x3);
> > -	st->ctrl_hb = AD7280A_CTRL_HB_CONV_AVG(pdata->conversion_averaging
> > -			& 0x3) | (pdata->thermistor_term_en ?
> > -			AD7280A_CTRL_LB_THERMISTOR_EN : 0);
> > +	st->ctrl_lb = FIELD_PREP(AD7280A_CTRL_LB_ACQ_TIME_MSK, pdata->acquisition_time) |
> > +		FIELD_PREP(AD7280A_CTRL_LB_THERMISTOR_MSK, pdata->thermistor_term_en);  
> Writes to the CTRL_LB_REG already set it, but could also set the must_set bit here if want
> FIELD_PREP(AD7280A_CTRL_LB_MUST_SET, 1)

Good point though if we do this it shouldn't really be in this patch
as it's not related to the define cleanup.  Probably one for the todo list rather than
something I'll include in this series.

Thanks,

Jonathan
