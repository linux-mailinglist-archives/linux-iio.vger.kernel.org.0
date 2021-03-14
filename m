Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515D333A72D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 18:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCNRqo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 13:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231205AbhCNRqm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 13:46:42 -0400
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A738B64DF3;
        Sun, 14 Mar 2021 17:46:40 +0000 (UTC)
Date:   Sun, 14 Mar 2021 17:46:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 15/24] staging:iio:cdc:ad7150: Tidy up local variable
 positioning.
Message-ID: <20210314174637.3dfb4a57@archlinux>
In-Reply-To: <7beef56608a54546ab88b8c76e8f4487@hisilicon.com>
References: <20210207154623.433442-1-jic23@kernel.org>
        <20210207154623.433442-16-jic23@kernel.org>
        <7beef56608a54546ab88b8c76e8f4487@hisilicon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Feb 2021 07:54:59 +0000
"Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > Sent: Monday, February 8, 2021 4:46 AM
> > To: linux-iio@vger.kernel.org
> > Cc: Lars-Peter Clausen <lars@metafoo.de>; Michael Hennerich
> > <Michael.Hennerich@analog.com>; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>; robh+dt@kernel.org; Jonathan Cameron
> > <jonathan.cameron@huawei.com>
> > Subject: [PATCH 15/24] staging:iio:cdc:ad7150: Tidy up local variable
> > positioning.
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Where there is no other basis on which to order declarations
> > let us prefer reverse xmas tree.  Also reduce scope where
> > sensible.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
This needed tweaking due to the earlier variable name change.

Applied with adaptive renamed to fixed and sense flipped.

Thanks,

Jonathan

> 
> > ---
> >  drivers/staging/iio/cdc/ad7150.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/cdc/ad7150.c
> > b/drivers/staging/iio/cdc/ad7150.c
> > index 9e88e774752f..d530b467d1b2 100644
> > --- a/drivers/staging/iio/cdc/ad7150.c
> > +++ b/drivers/staging/iio/cdc/ad7150.c
> > @@ -108,9 +108,9 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
> >  			   int *val2,
> >  			   long mask)
> >  {
> > -	int ret;
> >  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> >  	int channel = chan->channel;
> > +	int ret;
> > 
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > @@ -143,10 +143,10 @@ static int ad7150_read_event_config(struct iio_dev
> > *indio_dev,
> >  				    enum iio_event_type type,
> >  				    enum iio_event_direction dir)
> >  {
> > -	int ret;
> > +	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> >  	u8 threshtype;
> >  	bool thrfixed;
> > -	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> > +	int ret;
> > 
> >  	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG_REG);
> >  	if (ret < 0)
> > @@ -227,10 +227,8 @@ static int ad7150_write_event_config(struct iio_dev
> > *indio_dev,
> >  				     enum iio_event_type type,
> >  				     enum iio_event_direction dir, int state)
> >  {
> > -	u8 thresh_type, cfg, adaptive;
> > -	int ret;
> >  	struct ad7150_chip_info *chip = iio_priv(indio_dev);
> > -	int rising = (dir == IIO_EV_DIR_RISING);
> > +	int ret;
> > 
> >  	/*
> >  	 * There is only a single shared control and no on chip
> > @@ -251,6 +249,8 @@ static int ad7150_write_event_config(struct iio_dev
> > *indio_dev,
> > 
> >  	mutex_lock(&chip->state_lock);
> >  	if ((type != chip->type) || (dir != chip->dir)) {
> > +		int rising = (dir == IIO_EV_DIR_RISING);
> > +		u8 thresh_type, cfg, adaptive;
> > 
> >  		/*
> >  		 * Need to temporarily disable both interrupts if
> > @@ -533,9 +533,9 @@ static const struct iio_info ad7150_info_no_irq = {
> >  static int ad7150_probe(struct i2c_client *client,
> >  			const struct i2c_device_id *id)
> >  {
> > -	int ret;
> >  	struct ad7150_chip_info *chip;
> >  	struct iio_dev *indio_dev;
> > +	int ret;
> > 
> >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> >  	if (!indio_dev)
> > --
> > 2.30.0  
> 

