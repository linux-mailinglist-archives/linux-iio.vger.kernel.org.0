Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16081D970A
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 15:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgESNEC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 09:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgESNEB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 09:04:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A53C08C5C6;
        Tue, 19 May 2020 06:04:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so15893287wru.0;
        Tue, 19 May 2020 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MSQgZfzN1EOgpi1rolFm8O7a7AGg5E5FcP9uK+1/dtU=;
        b=pAjN6JYTHwQXICdoTL6xF71+mcn5qeFjRW9VbT65q+Nd/zfF0zNwOSpffyYLU6NR6W
         bXN+8hyfaPh/iL2Vc+OnFFZMB+orlZZeCu66eBT319Y1RCemerMW7jyVHqDNQI+7XgjB
         dTa9X1eBzwc9ylXSKSxzqyX2N224ORhplOtKPAR6JnmWwgKAfsKk7ScIvPypjWTSCMsw
         0pjMsy0MOFRpMsoQV8yoj5FNjnzuAtjJyJjMpTnqngZD5q5T/JZcdER+m+w/Fy97Ju+M
         IzWuUFHSmMNX5a4pHF+3G3ZFFJvCwzqycYIr7QelDgJc2CDaYb32TCTgN09lxFbKRg07
         vm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MSQgZfzN1EOgpi1rolFm8O7a7AGg5E5FcP9uK+1/dtU=;
        b=aIsG3ehuYcpQkwVdxkOCzPwqGWTJWqtJ6mhTT3imQjNYF1aSn9py+F5fHaDdFY321u
         XzpRi6sbxgr7IvjPsbZYtIMhvHI0dfNK6b6GED3ND+T96zUIrYwwobj/9qvLj9OcKRdL
         zYRzN5HiUVqXCT6o35EP20xGGeE62gj989y/bJAPHiIXMimfGPi1tQy95SI16V4U3B0R
         uqXlWxOPYqDrpvaD07cdvvLUuyiMJULUghzGRfpTAvcAVtWwK+YCPsvY6I9S6Av0VHGo
         n9Xnv16LO2m3CMMFgXn+eRm1sDvrHqK0bnngJQX+Ixt0qMtaslHp9cwSc2zC2O9FRobJ
         oSSQ==
X-Gm-Message-State: AOAM533XWYpV1W6tU7a2Q5ZjwYOvbCyZ94whuZfoeHnnMcUC0w70H711
        EMtfhI/+z1DqKlzWbUVuMBQ=
X-Google-Smtp-Source: ABdhPJwcVvydfqwzIzdy+iGT+m9LpCim1x1QOadls17v2SDAn6uQqjJD2yJW+n0TB3wSpvtLswA4Zg==
X-Received: by 2002:adf:f446:: with SMTP id f6mr25174511wrp.75.1589893439903;
        Tue, 19 May 2020 06:03:59 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id u65sm3900406wmg.8.2020.05.19.06.03.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 06:03:58 -0700 (PDT)
Date:   Tue, 19 May 2020 15:03:50 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v3 4/4] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200519130350.GA30573@ict14-OptiPlex-980>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-5-jonathan.albrieux@gmail.com>
 <20200519125713.GI1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519125713.GI1634618@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 03:57:13PM +0300, Andy Shevchenko wrote:
> On Tue, May 19, 2020 at 02:43:54PM +0200, Jonathan Albrieux wrote:
> > According to AK09911 datasheet, if reset gpio is provided then
> > deassert reset on ak8975_power_on() and assert reset on ak8975_power_off().
> > 
> > Without reset's deassertion during ak8975_power_on(), driver's probe fails
> > on ak8975_who_i_am while() checking for device identity for AK09911 chip.
> 
> Wrong position of (), but hold on, this is so minor, no need to send a new
> version because of this.
>

Ops, if this represents a problem I can fix it, there's absolutely no problem!
 
> > AK09911 has an active low reset gpio to handle register's reset.
> > AK09911 datasheed says that, if not used, reset pin should be connected
> > to VID. This patch emulates this situation.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> > index fd368455cd7b..a23422aad97d 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -358,6 +358,7 @@ struct ak8975_data {
> >  	u8			asa[3];
> >  	long			raw_to_gauss[3];
> >  	struct gpio_desc	*eoc_gpiod;
> > +	struct gpio_desc	*reset_gpiod;
> >  	int			eoc_irq;
> >  	wait_queue_head_t	data_ready_queue;
> >  	unsigned long		flags;
> > @@ -384,6 +385,9 @@ static int ak8975_power_on(const struct ak8975_data *data)
> >  			 "Failed to enable specified Vid supply\n");
> >  		return ret;
> >  	}
> > +
> > +	gpiod_set_value_cansleep(data->reset_gpiod, 0);
> > +
> >  	/*
> >  	 * According to the datasheet the power supply rise time is 200us
> >  	 * and the minimum wait time before mode setting is 100us, in
> > @@ -396,6 +400,8 @@ static int ak8975_power_on(const struct ak8975_data *data)
> >  /* Disable attached power regulator if any. */
> >  static void ak8975_power_off(const struct ak8975_data *data)
> >  {
> > +	gpiod_set_value_cansleep(data->reset_gpiod, 1);
> > +
> >  	regulator_disable(data->vid);
> >  	regulator_disable(data->vdd);
> >  }
> > @@ -839,6 +845,7 @@ static int ak8975_probe(struct i2c_client *client,
> >  	struct ak8975_data *data;
> >  	struct iio_dev *indio_dev;
> >  	struct gpio_desc *eoc_gpiod;
> > +	struct gpio_desc *reset_gpiod;
> >  	const void *match;
> >  	unsigned int i;
> >  	int err;
> > @@ -856,6 +863,16 @@ static int ak8975_probe(struct i2c_client *client,
> >  	if (eoc_gpiod)
> >  		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
> >  
> > +	/*
> > +	 * According to AK09911 datasheet, if reset GPIO is provided then
> > +	 * deassert reset on ak8975_power_on() and assert reset on
> > +	 * ak8975_power_off().
> > +	 */
> > +	reset_gpiod = devm_gpiod_get_optional(&client->dev,
> > +					      "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(reset_gpiod))
> > +		return PTR_ERR(reset_gpiod);
> > +
> >  	/* Register with IIO */
> >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> >  	if (indio_dev == NULL)
> > @@ -866,6 +883,7 @@ static int ak8975_probe(struct i2c_client *client,
> >  
> >  	data->client = client;
> >  	data->eoc_gpiod = eoc_gpiod;
> > +	data->reset_gpiod = reset_gpiod;
> >  	data->eoc_irq = 0;
> >  
> >  	err = iio_read_mount_matrix(&client->dev, "mount-matrix", &data->orientation);
> > -- 
> > 2.17.1
> > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Best regards,
Jonathan Albrieux
