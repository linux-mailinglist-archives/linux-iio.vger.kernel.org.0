Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87F323FDFA
	for <lists+linux-iio@lfdr.de>; Sun,  9 Aug 2020 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgHILpZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Aug 2020 07:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgHILpU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Aug 2020 07:45:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80EAC206B5;
        Sun,  9 Aug 2020 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596973515;
        bh=1YIbCBZK/Y0Mjt606XUCPPOgQOOOn6ahNm79Y8dzYTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o4648atjHYuRQ6aeC4teRuamJ7qIAfQXyuasN/oZDPy95Uc+vAASsR7yclVui2TYe
         YXpDKSsam3ZwMtyUCdGQgzm0ZDLsOPsVomLAS/d/mBr3jvBKUhVKcUIjQgupnFLaUG
         bQdyn2EqcavZXpkxsxAxUO2v2dZ55dCKT3ejG7ts=
Date:   Sun, 9 Aug 2020 12:45:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, kernel@axis.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: dac5571: Support powerdown for multi-channel
Message-ID: <20200809124511.33e124d2@archlinux>
In-Reply-To: <9648e22b-6f46-1a61-9928-965a8d047827@geanix.com>
References: <20200804093138.2114-1-vincent.whitchurch@axis.com>
        <9648e22b-6f46-1a61-9928-965a8d047827@geanix.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 Aug 2020 10:34:15 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 04/08/2020 11.31, Vincent Whitchurch wrote:
> > The driver currently only allows channel 0 to be powered down but the
> > multi-channel variants of the hardware allow each channel to be powered
> > down separately and with separate power down modes.  Add support for
> > this.
> >
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>  
> Acked-by: Sean Nyekjaer <sean@geanix.com>
Applied.

Thanks,

Jonathan

> > ---
> >   drivers/iio/dac/ti-dac5571.c | 29 +++++++++++++++--------------
> >   1 file changed, 15 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> > index 3a2bb0efe50d..ce8c3d646fb1 100644
> > --- a/drivers/iio/dac/ti-dac5571.c
> > +++ b/drivers/iio/dac/ti-dac5571.c
> > @@ -47,8 +47,8 @@ struct dac5571_data {
> >   	struct mutex lock;
> >   	struct regulator *vref;
> >   	u16 val[4];
> > -	bool powerdown;
> > -	u8 powerdown_mode;
> > +	bool powerdown[4];
> > +	u8 powerdown_mode[4];
> >   	struct dac5571_spec const *spec;
> >   	int (*dac5571_cmd)(struct dac5571_data *data, int channel, u16 val);
> >   	int (*dac5571_pwrdwn)(struct dac5571_data *data, int channel, u8 pwrdwn);
> > @@ -125,7 +125,7 @@ static int dac5571_get_powerdown_mode(struct iio_dev *indio_dev,
> >   {
> >   	struct dac5571_data *data = iio_priv(indio_dev);
> >   
> > -	return data->powerdown_mode;
> > +	return data->powerdown_mode[chan->channel];
> >   }
> >   
> >   static int dac5571_set_powerdown_mode(struct iio_dev *indio_dev,
> > @@ -135,17 +135,17 @@ static int dac5571_set_powerdown_mode(struct iio_dev *indio_dev,
> >   	struct dac5571_data *data = iio_priv(indio_dev);
> >   	int ret = 0;
> >   
> > -	if (data->powerdown_mode == mode)
> > +	if (data->powerdown_mode[chan->channel] == mode)
> >   		return 0;
> >   
> >   	mutex_lock(&data->lock);
> > -	if (data->powerdown) {
> > +	if (data->powerdown[chan->channel]) {
> >   		ret = data->dac5571_pwrdwn(data, chan->channel,
> >   					   DAC5571_POWERDOWN(mode));
> >   		if (ret)
> >   			goto out;
> >   	}
> > -	data->powerdown_mode = mode;
> > +	data->powerdown_mode[chan->channel] = mode;
> >   
> >    out:
> >   	mutex_unlock(&data->lock);
> > @@ -167,7 +167,7 @@ static ssize_t dac5571_read_powerdown(struct iio_dev *indio_dev,
> >   {
> >   	struct dac5571_data *data = iio_priv(indio_dev);
> >   
> > -	return sprintf(buf, "%d\n", data->powerdown);
> > +	return sprintf(buf, "%d\n", data->powerdown[chan->channel]);
> >   }
> >   
> >   static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
> > @@ -183,19 +183,20 @@ static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
> >   	if (ret)
> >   		return ret;
> >   
> > -	if (data->powerdown == powerdown)
> > +	if (data->powerdown[chan->channel] == powerdown)
> >   		return len;
> >   
> >   	mutex_lock(&data->lock);
> >   	if (powerdown)
> >   		ret = data->dac5571_pwrdwn(data, chan->channel,
> > -			    DAC5571_POWERDOWN(data->powerdown_mode));
> > +			    DAC5571_POWERDOWN(data->powerdown_mode[chan->channel]));
> >   	else
> > -		ret = data->dac5571_cmd(data, chan->channel, data->val[0]);
> > +		ret = data->dac5571_cmd(data, chan->channel,
> > +				data->val[chan->channel]);
> >   	if (ret)
> >   		goto out;
> >   
> > -	data->powerdown = powerdown;
> > +	data->powerdown[chan->channel] = powerdown;
> >   
> >    out:
> >   	mutex_unlock(&data->lock);
> > @@ -209,9 +210,9 @@ static const struct iio_chan_spec_ext_info dac5571_ext_info[] = {
> >   		.name	   = "powerdown",
> >   		.read	   = dac5571_read_powerdown,
> >   		.write	   = dac5571_write_powerdown,
> > -		.shared	   = IIO_SHARED_BY_TYPE,
> > +		.shared	   = IIO_SEPARATE,
> >   	},
> > -	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &dac5571_powerdown_mode),
> > +	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &dac5571_powerdown_mode),
> >   	IIO_ENUM_AVAILABLE("powerdown_mode", &dac5571_powerdown_mode),
> >   	{},
> >   };
> > @@ -276,7 +277,7 @@ static int dac5571_write_raw(struct iio_dev *indio_dev,
> >   		if (val >= (1 << data->spec->resolution) || val < 0)
> >   			return -EINVAL;
> >   
> > -		if (data->powerdown)
> > +		if (data->powerdown[chan->channel])
> >   			return -EBUSY;
> >   
> >   		mutex_lock(&data->lock);  
> 

