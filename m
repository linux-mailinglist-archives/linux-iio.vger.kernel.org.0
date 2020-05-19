Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD6A1D9910
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgESOKo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESOKn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 10:10:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607B3C08C5C0;
        Tue, 19 May 2020 07:10:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z4so3226042wmi.2;
        Tue, 19 May 2020 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/vBiI8HSYFghhdNbWQeuQjoMgCPNyaEsWTxbMy9JazA=;
        b=UaFH1PZrTHTNtl22w3CpD5YcdegG908dyzoB8HeUqEsmee8OaZP4ln7Rh+eG28umiB
         k0rshqwhsaNTC60gmMvUCYHaiBKuqdlMLLeRbY+bm9FMT+ZhuZM7fgudkyKSvvFu/b2e
         NWjdHulKAIjQJLkGiRIdkbXE/du+5G13bx24+gXk+virFEQ3L3mKjI+7zDsAwUVX5S5A
         K6yEmCSNQf6qPjSPlOY97LG9dKBxiTCWcNHNAPwU0Kkb8IaJdnLI02AjkxPn6RWF6BBg
         WOmgfTRq3eXcm//mMSGpIakULWMtxpsK7E9uCyXAwPHtmMSZfnuP19nJp4f7Gbt80m+I
         qnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/vBiI8HSYFghhdNbWQeuQjoMgCPNyaEsWTxbMy9JazA=;
        b=CZbY7jCKo7pwfxQVspj3ErUwtRRNOeComtefbPniDwPg12vDvRsdF9O6JZd0vuf69q
         1C8pMS28GPvPXZPP45qiyV+oNFcrEg26rMx93yfrLao20LfQzBjvs3FYTcBHr3MS4vBO
         bEPl6fKEHxXdcWHf4cg1qD4vBxvGJZD2nIKs1ao52IdO2vDUs1yDVWzbN5p7wemqmeZx
         SpvplZAWPdtQtJOwdOaaWeUKEUX2wsvnbBlDalp5kgBgcttQSgcnGOkZ7256ioPQSqJy
         dlLodNbSCdQJbajte1QmQ//Hpunsc/dumhYKLXGDVUUKX18qysc4Grwy+Bm6znu34ZKE
         y4yA==
X-Gm-Message-State: AOAM5338ww1VVOZeUcsJ+ylzRDkWGuc10oIQ9We6cWWBmSxzdYcfHZtu
        BtWC2R/BtEhbvvXGNlY6c0g=
X-Google-Smtp-Source: ABdhPJw68Iaq3pKI7k2MLFKJ2+F/WVBsAbMnziGJ/0VWd6onxmBUtZZmQEwHiwEWOQDSB1bNMlqSKw==
X-Received: by 2002:a1c:a102:: with SMTP id k2mr5967856wme.39.1589897440972;
        Tue, 19 May 2020 07:10:40 -0700 (PDT)
Received: from ict14-OptiPlex-980 ([178.23.248.46])
        by smtp.gmail.com with ESMTPSA id 18sm3908165wmj.19.2020.05.19.07.10.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 07:10:40 -0700 (PDT)
Date:   Tue, 19 May 2020 16:10:37 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200519141037.GD30573@ict14-OptiPlex-980>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-5-jonathan.albrieux@gmail.com>
 <20200519132512.GC4623@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519132512.GC4623@gerhold.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 03:25:12PM +0200, Stephan Gerhold wrote:
> On Tue, May 19, 2020 at 02:43:54PM +0200, Jonathan Albrieux wrote:
> > According to AK09911 datasheet, if reset gpio is provided then
> > deassert reset on ak8975_power_on() and assert reset on ak8975_power_off().
> > 
> > Without reset's deassertion during ak8975_power_on(), driver's probe fails
> > on ak8975_who_i_am while() checking for device identity for AK09911 chip.
> > 
> > AK09911 has an active low reset gpio to handle register's reset.
> > AK09911 datasheed says that, if not used, reset pin should be connected
> 
> Another minor typo: datasheed -> datasheet
> 
> In any case, FWIW:
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> 
> > to VID. This patch emulates this situation.
> > 
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

Thank you, will fix that typo too,

Best regards,
Jonathan Albrieux
