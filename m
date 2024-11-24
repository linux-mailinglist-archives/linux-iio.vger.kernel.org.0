Return-Path: <linux-iio+bounces-12566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51179D6EDE
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C966162CC1
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259918C93C;
	Sun, 24 Nov 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhCWp8+Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9B18C92F;
	Sun, 24 Nov 2024 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452207; cv=none; b=WA/aMa+XY+2mDC/IOrQsxwttiAns4y8JRRehasADFHghLw0UQ4oKzS/pHscFoiuht6Pthg0m20Wdaf1jxtqs8MJhutNbKpDfmxZX7zveYKa31be7p3LAvUxaxe/O1tfXC7IHXPMOZhB1N+DjJKRcKEW04jWacXsj4BLfGsD3Ha4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452207; c=relaxed/simple;
	bh=/Q111bk9ppM7RAlVGQNEPtozwwO/NImA489FG/ufEWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az1UKvto4NP71UV5zgHtvOQR07cWd5P022oFaZ5swqNAg+fWMQhWzm9566cPez0EtsfsEK4EA6SNPHZ6SZG7AEQS89MHyrHGrSoUiayMjioJO+LmHIp09J9EyXUvV2HYi6hho0SlIIHYB2UMVSzwg1T3hfjbcmi9RN7n7R8OXJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhCWp8+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36628C4CECC;
	Sun, 24 Nov 2024 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452207;
	bh=/Q111bk9ppM7RAlVGQNEPtozwwO/NImA489FG/ufEWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bhCWp8+YLKtwoDZkzIoFCPk08DgXl16+QzWcAb/eM2vwBdvW5qqVFA9TcpFxgaIqp
	 bpxuJuewT851JU4AUA7kKfeWdzpTM6ZQyBnwYC6pUzTNsKXEgqVvgML/bg7i1cAsMM
	 PQFZBBHSgL4maMbQ/h6txERjVKwdBWYwUXbb/fajWCOI31iOYoPq/tRXCUPwVKgJlE
	 LFv6lJMeMTIPSg08jiybBKARY6EKssf0u+9OKRh+7MxIugU7gg3PaebIbanpoa6cWd
	 z2McDjaTGcyoE5YDgtJ/YKOvoZ80W2xT5Um4RcMEivQR85tIRJNm50eJVdgTGDXz6M
	 FshTsbKBKWRtw==
Date: Sun, 24 Nov 2024 12:43:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: veml6030: add support for triggered
 buffer
Message-ID: <20241124124320.4237c67e@jic23-huawei>
In-Reply-To: <1f5d62d0-42af-4eda-846d-cd0d57b5c6d5@gmail.com>
References: <20241110-veml6030_triggered_buffer-v2-1-ecda3b6ed77f@gmail.com>
	<20241123151634.303aa860@jic23-huawei>
	<1f5d62d0-42af-4eda-846d-cd0d57b5c6d5@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Nov 2024 22:15:11 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 23/11/2024 16:16, Jonathan Cameron wrote:
> > On Sun, 10 Nov 2024 18:49:05 +0100
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> All devices supported by this driver (currently veml6030, veml6035
> >> and veml7700) have two 16-bit channels, and can profit for the same
> >> configuration to support data access via triggered buffers.
> >>
> >> The measurements are stored in two 16-bit consecutive registers
> >> (addresses 0x04 and 0x05) as little endian, unsigned data.
> >>
> >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> > Hi Javier,
> > 
> > We have to be a little careful with pushing data from the stack.
> > Need to makes sure holes are zero filled.
> > 
> > Jonathan
> >   
> >> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> >> index ccb43dfd5cf7..ce9af9a0e933 100644
> >> --- a/drivers/iio/light/veml6030.c
> >> +++ b/drivers/iio/light/veml6030.c  
> >   
> >>  
> >>  static const struct regmap_config veml6030_regmap_config = {
> >> @@ -889,6 +928,35 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
> >>  	return IRQ_HANDLED;
> >>  }
> >>  
> >> +static irqreturn_t veml6030_trigger_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *iio = pf->indio_dev;
> >> +	struct veml6030_data *data = iio_priv(iio);
> >> +	unsigned int reg;
> >> +	int ch, ret, i = 0;
> >> +	struct {
> >> +		u16 chans[2];  
> > There is a hole here...   
> >> +		aligned_s64 timestamp;
> >> +	} scan;
> >> +
> >> +	iio_for_each_active_channel(iio, ch) {
> >> +		ret = regmap_read(data->regmap, VEML6030_REG_DATA(ch),
> >> +				  &reg);
> >> +		if (ret)
> >> +			goto done;
> >> +
> >> +		scan.chans[i++] = reg;  
> > This fills in at least 1 channel, but maybe not the second.  
> >> +	}
> >> +  
> > So this leaks random stack data I think.
> > 
> > Upshot, when holes are involved or not all the channels are set, need
> > memset(&scan, 0, sizeof(scan));
> > for the structure on the stack which will zero the holes as well as
> > both channels.
> > 
> > Ancient article on this: https://lwn.net/Articles/417989/
> > 
> > We get away with it when they are in the iio_priv space because they are
> > kzalloc + if we do leak data due to changes in configured channels it's
> > just old sensor data which is (I think) never a security problem!
> >   
> >> +	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
> >> +
> >> +done:
> >> +	iio_trigger_notify_done(iio->trig);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >>  static int veml6030_set_info(struct iio_dev *indio_dev)
> >>  {
> >>  	struct veml6030_data *data = iio_priv(indio_dev);
> >> @@ -1077,6 +1145,12 @@ static int veml6030_probe(struct i2c_client *client)
> >>  	if (ret < 0)
> >>  		return ret;
> >>  
> >> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> >> +					      veml6030_trigger_handler, NULL);
> >> +	if (ret)
> >> +		return dev_err_probe(&client->dev, ret,
> >> +				     "Failed to register triggered buffer");
> >> +
> >>  	return devm_iio_device_register(&client->dev, indio_dev);
> >>  }
> >>  
> >>
> >> ---
> >> base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
> >> change-id: 20241106-veml6030_triggered_buffer-a38886ca4cce
> >>
> >> Best regards,  
> >   
> 
> 
> Hi Jonathan,
> 
> thanks a lot for your explanation and the link, it makes perfect sense.
> By the way, when I moved this struct from the iio_priv to the function,
> I took a look at some existing code, and a couple of them might have the
> same issue:
> 
> - temperature/tmp006.c: it also has a hole between the two 16-bit
> channels and the timestamp (aligned(8)), but it is not set to zero.
> 
> - adc/ti-ads1119.c: the scan consists of an unsigned int and the
> timestamp (aligned(8)). I believe there is a hole there as well.
> 
> I did not go over all drivers (most of them store the scan struct in the
> iio_priv space anyway), but at least those two look suspicious.
> 
> Should I fix (e.g. memset) those two I mentioned?

Please do.  Thanks!

Jonathan


> 
> Best regards,
> Javier Carrasco
> 


