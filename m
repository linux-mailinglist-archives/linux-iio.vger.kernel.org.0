Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A4A1CCA3D
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgEJK1B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 06:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgEJK1B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 06:27:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC48207DD;
        Sun, 10 May 2020 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589106420;
        bh=urU6F1TBHkSNN02EKwiuZy8kD2gzWuSCDonD58+tgGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTuUB5VfKKza8dgsAh7vP5hD7KxFZTdRSSRw1CcKzqexnh1QKiMHBV2cctTm195cg
         BHg41LIXP5JPp7bsTffh9oRuqr+84OwIha84tZOo3m5arsBmYGffBHZbnWr4J4gVjt
         feoJDHjUjoTg3amPXqsZdaWkstsHl202sHeHvTpM=
Date:   Sun, 10 May 2020 11:26:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: ltr501: Constify structs
Message-ID: <20200510112656.4337abe4@archlinux>
In-Reply-To: <20200502174010.77c89dd2@archlinux>
References: <20200502095237.71429-1-rikard.falkeborn@gmail.com>
        <20200502174010.77c89dd2@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2 May 2020 17:40:10 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat,  2 May 2020 11:52:37 +0200
> Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:
> 
> > Constify some data structs that are never changed. In order to do so,
> > also update a couple of functions that now need to accept pointers to
> > const struct instead of struct. While at it, update a few more functions
> > to accept pointers to const struct instead of pointers.
> > 
> > This allows the compiler to put more data in the code segment instead of
> > the data segment, as seen by the output of the file command:
> > 
> > Before:
> >    text    data     bss     dec     hex filename
> >   27080    8144     192   35416    8a58 drivers/iio/light/ltr501.o
> > 
> > After:
> >    text    data     bss     dec     hex filename
> >   27688    7536     192   35416    8a58 drivers/iio/light/ltr501.o
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>  
> 
> Looks sensible to me.  Will leave it a few days to get Peter time to
> sanity check if he wants to.

Applied to the togreg branch of iio.git and pushed out as testing or the
autobuilders to play with it.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/ltr501.c | 39 +++++++++++++++++++-------------------
> >  1 file changed, 20 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > index 0626927251bb..5a3fcb127cd2 100644
> > --- a/drivers/iio/light/ltr501.c
> > +++ b/drivers/iio/light/ltr501.c
> > @@ -101,12 +101,12 @@ struct ltr501_gain {
> >  	int uscale;
> >  };
> >  
> > -static struct ltr501_gain ltr501_als_gain_tbl[] = {
> > +static const struct ltr501_gain ltr501_als_gain_tbl[] = {
> >  	{1, 0},
> >  	{0, 5000},
> >  };
> >  
> > -static struct ltr501_gain ltr559_als_gain_tbl[] = {
> > +static const struct ltr501_gain ltr559_als_gain_tbl[] = {
> >  	{1, 0},
> >  	{0, 500000},
> >  	{0, 250000},
> > @@ -117,14 +117,14 @@ static struct ltr501_gain ltr559_als_gain_tbl[] = {
> >  	{0, 10000},
> >  };
> >  
> > -static struct ltr501_gain ltr501_ps_gain_tbl[] = {
> > +static const struct ltr501_gain ltr501_ps_gain_tbl[] = {
> >  	{1, 0},
> >  	{0, 250000},
> >  	{0, 125000},
> >  	{0, 62500},
> >  };
> >  
> > -static struct ltr501_gain ltr559_ps_gain_tbl[] = {
> > +static const struct ltr501_gain ltr559_ps_gain_tbl[] = {
> >  	{0, 62500}, /* x16 gain */
> >  	{0, 31250}, /* x32 gain */
> >  	{0, 15625}, /* bits X1 are for x64 gain */
> > @@ -133,9 +133,9 @@ static struct ltr501_gain ltr559_ps_gain_tbl[] = {
> >  
> >  struct ltr501_chip_info {
> >  	u8 partid;
> > -	struct ltr501_gain *als_gain;
> > +	const struct ltr501_gain *als_gain;
> >  	int als_gain_tbl_size;
> > -	struct ltr501_gain *ps_gain;
> > +	const struct ltr501_gain *ps_gain;
> >  	int ps_gain_tbl_size;
> >  	u8 als_mode_active;
> >  	u8 als_gain_mask;
> > @@ -192,7 +192,7 @@ static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
> >  	return -EINVAL;
> >  }
> >  
> > -static int ltr501_als_read_samp_freq(struct ltr501_data *data,
> > +static int ltr501_als_read_samp_freq(const struct ltr501_data *data,
> >  				     int *val, int *val2)
> >  {
> >  	int ret, i;
> > @@ -210,7 +210,7 @@ static int ltr501_als_read_samp_freq(struct ltr501_data *data,
> >  	return IIO_VAL_INT_PLUS_MICRO;
> >  }
> >  
> > -static int ltr501_ps_read_samp_freq(struct ltr501_data *data,
> > +static int ltr501_ps_read_samp_freq(const struct ltr501_data *data,
> >  				    int *val, int *val2)
> >  {
> >  	int ret, i;
> > @@ -266,7 +266,7 @@ static int ltr501_ps_write_samp_freq(struct ltr501_data *data,
> >  	return ret;
> >  }
> >  
> > -static int ltr501_als_read_samp_period(struct ltr501_data *data, int *val)
> > +static int ltr501_als_read_samp_period(const struct ltr501_data *data, int *val)
> >  {
> >  	int ret, i;
> >  
> > @@ -282,7 +282,7 @@ static int ltr501_als_read_samp_period(struct ltr501_data *data, int *val)
> >  	return IIO_VAL_INT;
> >  }
> >  
> > -static int ltr501_ps_read_samp_period(struct ltr501_data *data, int *val)
> > +static int ltr501_ps_read_samp_period(const struct ltr501_data *data, int *val)
> >  {
> >  	int ret, i;
> >  
> > @@ -321,7 +321,7 @@ static unsigned long ltr501_calculate_lux(u16 vis_data, u16 ir_data)
> >  	return lux / 1000;
> >  }
> >  
> > -static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
> > +static int ltr501_drdy(const struct ltr501_data *data, u8 drdy_mask)
> >  {
> >  	int tries = 100;
> >  	int ret, status;
> > @@ -373,7 +373,8 @@ static int ltr501_set_it_time(struct ltr501_data *data, int it)
> >  }
> >  
> >  /* read int time in micro seconds */
> > -static int ltr501_read_it_time(struct ltr501_data *data, int *val, int *val2)
> > +static int ltr501_read_it_time(const struct ltr501_data *data,
> > +			       int *val, int *val2)
> >  {
> >  	int ret, index;
> >  
> > @@ -391,7 +392,7 @@ static int ltr501_read_it_time(struct ltr501_data *data, int *val, int *val2)
> >  	return IIO_VAL_INT_PLUS_MICRO;
> >  }
> >  
> > -static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
> > +static int ltr501_read_als(const struct ltr501_data *data, __le16 buf[2])
> >  {
> >  	int ret;
> >  
> > @@ -403,7 +404,7 @@ static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
> >  				buf, 2 * sizeof(__le16));
> >  }
> >  
> > -static int ltr501_read_ps(struct ltr501_data *data)
> > +static int ltr501_read_ps(const struct ltr501_data *data)
> >  {
> >  	int ret, status;
> >  
> > @@ -419,7 +420,7 @@ static int ltr501_read_ps(struct ltr501_data *data)
> >  	return status;
> >  }
> >  
> > -static int ltr501_read_intr_prst(struct ltr501_data *data,
> > +static int ltr501_read_intr_prst(const struct ltr501_data *data,
> >  				 enum iio_chan_type type,
> >  				 int *val2)
> >  {
> > @@ -716,7 +717,7 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> >  
> > -static int ltr501_get_gain_index(struct ltr501_gain *gain, int size,
> > +static int ltr501_get_gain_index(const struct ltr501_gain *gain, int size,
> >  				 int val, int val2)
> >  {
> >  	int i;
> > @@ -848,14 +849,14 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
> >  	return ret;
> >  }
> >  
> > -static int ltr501_read_thresh(struct iio_dev *indio_dev,
> > +static int ltr501_read_thresh(const struct iio_dev *indio_dev,
> >  			      const struct iio_chan_spec *chan,
> >  			      enum iio_event_type type,
> >  			      enum iio_event_direction dir,
> >  			      enum iio_event_info info,
> >  			      int *val, int *val2)
> >  {
> > -	struct ltr501_data *data = iio_priv(indio_dev);
> > +	const struct ltr501_data *data = iio_priv(indio_dev);
> >  	int ret, thresh_data;
> >  
> >  	switch (chan->type) {
> > @@ -1359,7 +1360,7 @@ static bool ltr501_is_volatile_reg(struct device *dev, unsigned int reg)
> >  	}
> >  }
> >  
> > -static struct regmap_config ltr501_regmap_config = {
> > +static const struct regmap_config ltr501_regmap_config = {
> >  	.name =  LTR501_REGMAP_NAME,
> >  	.reg_bits = 8,
> >  	.val_bits = 8,  
> 

