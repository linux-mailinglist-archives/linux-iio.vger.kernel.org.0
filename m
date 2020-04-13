Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330751A6AD8
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbgDMREp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732349AbgDMREo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 13:04:44 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8C02063A;
        Mon, 13 Apr 2020 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586797483;
        bh=ISb9wr/yPKrfewUQACkHyT9WS5iqliM2PiGjRAwlLmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qaOBvA8AKlyeNCbkd4Zs0mpBeGdTHZabxXBQs1uXf5W57T4mBhXl81I56EcXMKufU
         RMDpB+1ENeCyLMExQMPcol4CbLOh4UreDPiRFxNw3dE+MpLumWWbj8UmEymGp9rC+P
         ec/gCH95x5UgjGxHzr9Xgm7Z1j4RfIH4vYXP8jBk=
Date:   Mon, 13 Apr 2020 18:04:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: light: isl29125: fix
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20200413180439.61cbf7b6@archlinux>
In-Reply-To: <5ced40e32260e5e99ca37dcf8ecdc77b25eb5153.camel@analog.com>
References: <20200304082425.18600-1-alexandru.ardelean@analog.com>
        <5ced40e32260e5e99ca37dcf8ecdc77b25eb5153.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Mar 2020 11:42:31 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2020-03-04 at 10:24 +0200, Alexandru Ardelean wrote:
> > The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> > the poll functions.
> > 
> > For the predisable hook, the disable code should occur before detaching
> > the poll func, and for the postenable hook, the poll func should be
> > attached before the enable code.
> > 
> > This change reworks the predisable/postenable hooks so that the pollfunc is
> > attached/detached in the correct position.
> > It also balances the calls a bit, by grouping the preenable and the
> > iio_triggered_buffer_postenable() into a single
> > isl29125_buffer_postenable() function.  
> 
> ping on this patch

Long enough.  Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/light/isl29125.c | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> > index e37894f0ae0b..95611f5eff01 100644
> > --- a/drivers/iio/light/isl29125.c
> > +++ b/drivers/iio/light/isl29125.c
> > @@ -213,13 +213,24 @@ static const struct iio_info isl29125_info = {
> >  	.attrs = &isl29125_attribute_group,
> >  };
> >  
> > -static int isl29125_buffer_preenable(struct iio_dev *indio_dev)
> > +static int isl29125_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> >  	struct isl29125_data *data = iio_priv(indio_dev);
> > +	int err;
> > +
> > +	err = iio_triggered_buffer_postenable(indio_dev);
> > +	if (err)
> > +		return err;
> >  
> >  	data->conf1 |= ISL29125_MODE_RGB;
> > -	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
> > +	err = i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
> >  		data->conf1);
> > +	if (err) {
> > +		iio_triggered_buffer_predisable(indio_dev);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> >  }
> >  
> >  static int isl29125_buffer_predisable(struct iio_dev *indio_dev)
> > @@ -227,19 +238,18 @@ static int isl29125_buffer_predisable(struct iio_dev
> > *indio_dev)
> >  	struct isl29125_data *data = iio_priv(indio_dev);
> >  	int ret;
> >  
> > -	ret = iio_triggered_buffer_predisable(indio_dev);
> > -	if (ret < 0)
> > -		return ret;
> > -
> >  	data->conf1 &= ~ISL29125_MODE_MASK;
> >  	data->conf1 |= ISL29125_MODE_PD;
> > -	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
> > +	ret = i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
> >  		data->conf1);
> > +
> > +	iio_triggered_buffer_predisable(indio_dev);
> > +
> > +	return ret;
> >  }
> >  
> >  static const struct iio_buffer_setup_ops isl29125_buffer_setup_ops = {
> > -	.preenable = isl29125_buffer_preenable,
> > -	.postenable = &iio_triggered_buffer_postenable,
> > +	.postenable = isl29125_buffer_postenable,
> >  	.predisable = isl29125_buffer_predisable,
> >  };
> >    

