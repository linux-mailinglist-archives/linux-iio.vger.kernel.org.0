Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0DA1E98BC
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgEaQH0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 12:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQHY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 May 2020 12:07:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53807C061A0E;
        Sun, 31 May 2020 09:07:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t18so9039799wru.6;
        Sun, 31 May 2020 09:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CapCgV2d1NhfCbTsaerBgABIVhriquurUVOB7tln1bE=;
        b=KbyogYbBVkVVnBSfemSzcInJA586nTECQHMzcraM0avbirJ3uEYPTe/z24nIEjHCj0
         DqP2P572K5zvO7ZLxayE5PSUle3ozdGIWVoBKYWu45GFW/bF9l9u0hVPRH9iAzOcGQBD
         e+26q1fNBFqObO1hWxoJMud/VXY0XLXht579Uj/BrXmNopN0+iY0ubmpWYZCeAUmwbp3
         LfV+gKpEEGHxNt/n+j/cVU+MIaueGZ3V4/5KRdqEWa0dx54aHD8Ok5lpbuj+TmYv6aKq
         KJJBcvuAI37QO3eWaWDv7IH3r7d8WSZ4ekrs9CIRcbPNC5KThtHvZQXMQlb3UXfGrzgo
         6XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CapCgV2d1NhfCbTsaerBgABIVhriquurUVOB7tln1bE=;
        b=GIt2DAuFovH6OlhxxdXXgqzYPudrhFHYoOOhr0EqYahX+lektD56rOJkqmAKMVfAfF
         2lE/YeI7v8dJG6tS4JgHzxffjuMnEIigvGC/Q61kpcnYnn3riignzrNgMgH4loqbhCYY
         p1FZbkCb9ECeCQBvZytD9Fx8g3xz6itPHPfdE8r20anIdqnhEtUq2D67ojuzgAFFkvtS
         ktCWGwjNr+mTlL2ewRCCrQKd5jjo0SqcoJRNVu2ig1VhWdh53TPjKmmOVdzhJf98i/Of
         Nejhc51kNctBcpz2nzxJyTRgUYj2n461119TvqQCRqArj89IogR5HSmQmnDFadCorEZX
         EC4w==
X-Gm-Message-State: AOAM531bj/pIdfKzEEKGrVk4g+x0zgC++Z8wdw5hpD4mYzNLcVR5F4hU
        mg9DZLMIMAkH0eA8A1wVeaw=
X-Google-Smtp-Source: ABdhPJy48omdtNwC30dug5asQ1sEOcuySKSi4OIT7l8izh4UcyVNkpDADbpkNJMDk9nO6CSGNJ5RgQ==
X-Received: by 2002:adf:82d0:: with SMTP id 74mr16964161wrc.138.1590941242781;
        Sun, 31 May 2020 09:07:22 -0700 (PDT)
Received: from jonathan-N53SV ([151.81.100.29])
        by smtp.gmail.com with ESMTPSA id 1sm8593355wmz.13.2020.05.31.09.07.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 May 2020 09:07:22 -0700 (PDT)
Date:   Sun, 31 May 2020 18:07:19 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v7 5/5] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200531160719.GB19272@jonathan-N53SV>
References: <20200528150106.12022-1-jonathan.albrieux@gmail.com>
 <20200531120230.27093a41@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531120230.27093a41@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 31, 2020 at 12:02:30PM +0100, Jonathan Cameron wrote:
> On Thu, 28 May 2020 17:01:05 +0200
> Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:
> 
> > According to AK09911 datasheet, if reset gpio is provided then
> > deassert reset on ak8975_power_on() and assert reset on ak8975_power_off().
> > 
> > Without reset's deassertion during ak8975_power_on(), driver's probe fails
> > on ak8975_who_i_am() while checking for device identity for AK09911 chip.
> > 
> > AK09911 has an active low reset gpio to handle register's reset.
> > AK09911 datasheet says that, if not used, reset pin should be connected
> > to VID. This patch emulates this situation.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Applied.  Thanks,
> 
> Jonathan
>

Thank you!

Best regards,
Jonathan Albrieux
 
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
> 
