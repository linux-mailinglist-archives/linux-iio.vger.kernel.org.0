Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097B51B8E31
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 11:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDZJZE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 05:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgDZJZD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Apr 2020 05:25:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD8C62071C;
        Sun, 26 Apr 2020 09:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587893102;
        bh=vwWrS+F2vR1/Yb++bTK7d2fnjWVZse9eyfCNAFo6btw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXC7plH3nsqld8xWbU3inOs/rpTzwn6viuKkLhMBQW6/aoBQeycBeLJoh3DoY8G5n
         PS5jADt+14X/I45r5Y1wwxqbHOLDgKl5yIPEVKHmhN4KQU4B8qN6zLiU03zAdZSXOX
         LoMU3T+cb6H+zb01gShtd9AJHQ1cmLbb8jNCY8w4=
Date:   Sun, 26 Apr 2020 10:24:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] iio: vcnl4000: Factorize data reading and
 writing.
Message-ID: <20200426102458.24ae84d7@archlinux>
In-Reply-To: <20200426095831.1472fbc9@archlinux>
References: <20200422130856.1722-1-m.othacehe@gmail.com>
        <20200422130856.1722-2-m.othacehe@gmail.com>
        <20200426095831.1472fbc9@archlinux>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Apr 2020 09:58:31 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 22 Apr 2020 15:08:53 +0200
> Mathieu Othacehe <m.othacehe@gmail.com> wrote:
> 
> > Factorize data reading in vcnl4000_measure into a vcnl4000_read_data
> > function. Also add a vcnl4000_write_data function.
> > 
> > Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>

Gah. I'm clearly blind but thankfully sparse gave a warning on a __be16
cast that got me to look more closely at the code.  As it turns out, the
existing code won't work on be16 platforms...

> > ---
> >  drivers/iio/light/vcnl4000.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > index 58e97462e803..695a81e95d8d 100644
> > --- a/drivers/iio/light/vcnl4000.c
> > +++ b/drivers/iio/light/vcnl4000.c
> > @@ -215,11 +215,34 @@ static int vcnl4200_init(struct vcnl4000_data *data)
> >  	return 0;
> >  };
> >  
> > +static int vcnl4000_read_data(struct vcnl4000_data *data, u8 data_reg, int *val)
> > +{
> > +	s32 ret;
> > +
> > +	ret = i2c_smbus_read_word_data(data->client, data_reg);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val = be16_to_cpu(ret);
This is wrong.  I2C has a defined byte order and the i2 master will return
the bytes in that order for i2c_smbus_read_word_data calls.

Now, not all i2c devices actually obey the specification from Philips so
sometimes it's necessary to swap the bytes to reflect that.  However, you
have to do it unconditionally because if you have a be16 platform the wire
order will still be assumed to be le16 and an incorrect swap will have been
applied (so we have to swap back again).

Anyhow, this is common enough that we have i2c_smbus_read_word_swapped
to deal with it.  Also similar for the write equivalent.

Interesting to note that the driver is currently broken so we should
do this fix as a precursor patch so we can backport to stable.

Jonathan

> > +	return 0;
> > +}
> > +
> > +static int vcnl4000_write_data(struct vcnl4000_data *data, u8 data_reg, int val)
> > +{
> > +	__be16 be_val;
> > +
> > +	if (val > U16_MAX)
> > +		return -ERANGE;
> > +
> > +	be_val = cpu_to_be16(val);
> > +	return i2c_smbus_write_word_data(data->client, data_reg, be_val);
> > +}
> > +
> > +  
> 
> Nitpick: One line is plenty.  I can tidy this up whilst applying if
> we don't go to v6 for other reasons.
> 
> Otherwise this looks fine.
> 
> Jonathan
> 
> 
> >  static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> >  				u8 rdy_mask, u8 data_reg, int *val)
> >  {
> >  	int tries = 20;
> > -	__be16 buf;
> >  	int ret;
> >  
> >  	mutex_lock(&data->vcnl4000_lock);
> > @@ -246,13 +269,11 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> >  		goto fail;
> >  	}
> >  
> > -	ret = i2c_smbus_read_i2c_block_data(data->client,
> > -		data_reg, sizeof(buf), (u8 *) &buf);
> > +	ret = vcnl4000_read_data(data, data_reg, val);
> >  	if (ret < 0)
> >  		goto fail;
> >  
> >  	mutex_unlock(&data->vcnl4000_lock);
> > -	*val = be16_to_cpu(buf);
> >  
> >  	return 0;
> >    
> 

