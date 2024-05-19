Return-Path: <linux-iio+bounces-5138-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED38C96A1
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 23:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0FD1F21132
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8D62E400;
	Sun, 19 May 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KckkAQnu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E7B107A0;
	Sun, 19 May 2024 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716152443; cv=none; b=ngxc6WzC1iIVC0J28STIgWVI6/yZ2bQUyTyfPJ9J9hdRw+AznJS4HwhcBJQRrhNlcpfN3Tg9zaR1HWJ6v8HoGGsg+fqQMJNWNAWBRUnlRKkwoI58c4kwr/YQrctFqXkZwdHigCmm0VV6HvPaJ4s+FUrps2JgHK3W7AO3UzeyOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716152443; c=relaxed/simple;
	bh=HKsKEE04lqD9lwxRQOxh6rDWRF+jH5UtsyXxnj9VJX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMrOOCfD5kYXLqhTJhaAwf76FOZRKMG0p35OqT1ytbOutprAx3iANFY12nHNnqEXN1hOidtV1kImwt2xHNZCpbd1EZtPOeIRyy/wQErzIAdzFIJB+y7NQGQzF9vgzWuzH/GbUz8YXUXs3W1Id4+LKlAO0J6nA7Ak/iodNiCmCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KckkAQnu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420104e5336so9624215e9.1;
        Sun, 19 May 2024 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716152439; x=1716757239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VtH++phnGxBGBZvf5FHKnM6CrPspSskrj8AXC2vCWPg=;
        b=KckkAQnuLs4bhzsFeqwvXe35PYgPLaftvsahTMEJ7rLt0zsRwAsBL7H0XXCfat2O5Z
         MM+PIljPUwubXQmEbwwxJY29oiRyw3NKk5iSQHq6bGom2TU47hxf/bDiXmQkDLTwj7PC
         svB8mIptxNj5zFrzy5CodM8tl+2gVyCJbOPruzR9JaXbnL4QntNup7Z/S2GoCAfm7FRY
         iHm/qbh1tTZAJ7Ho3bqqalOp+bW0WZLppamSm3kUJa31zeUACttbYsNyR477CmAfsPx6
         PBVSOmPOvsoygQMZvJl0jIprvGKO+lKuFJuHPN2d7zd/0CWvosk0BVvE7w2DMw+Ii53B
         yUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716152439; x=1716757239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtH++phnGxBGBZvf5FHKnM6CrPspSskrj8AXC2vCWPg=;
        b=J/CuQ9aAWp97UPizgP6UTsh3CdC5XvV9tQmi9bybn1NETIcqGOhowBrqcXJP3K1LtP
         38pWFQfbomdSpHgYYpO2FEywPFQO+c1aD9kPyf/EfTezJlZVbPtxB9xNM08cdoQoe61Q
         MgF/CLDV8N1Z0S8pRKXL1GWzulQ34JrM5MvgzUgWqaIlxC42KqO9B6aN3HZ7BWolLDIp
         jOisQbgbMqErmDoAwf02uE3Wr1elF7IZmrcd8+SQJlYdssI9I3r6UfGA4Wy5EcLE5tiP
         LQaL04Y+l1CI5+WTAYaW19q8gU4knatx2+LrmxvviAZsS5S/jUPN/lbXUbL9qnKyy+NY
         ro4A==
X-Forwarded-Encrypted: i=1; AJvYcCXsXaeGUMJ8FH12wgvhoTeEP/WkQXQpVNHXBqewY91CALzBx+gH8h1mDOnGTutTADpod91olTYWAYjFqq1o9gHAnk6hUbC3DpgK5YWUdsBqMro11I9A9WYfNt8rVoLaa0STIZcE+e7A
X-Gm-Message-State: AOJu0YyRhWU69ReVzqE4WLcICLOi9QYGA6buYiePyjGpp0YFur8Jdj3h
	dhsm6EaiMPBdXgaOKOGJu4VXe63NoAElV1z0EM2naeHGCYUDPpVG
X-Google-Smtp-Source: AGHT+IHELGo3hN9bfT5JvlUs7aLAXgdR8dA6Jl3Y9v0RlFhUmAK8oR9ui0Hzy7q+73ySRW8vc5iXnQ==
X-Received: by 2002:a05:600c:1d1f:b0:415:ff48:59fc with SMTP id 5b1f17b1804b1-420e19e45eemr34984575e9.8.1716152439059;
        Sun, 19 May 2024 14:00:39 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe15b6sm383770955e9.47.2024.05.19.14.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 14:00:38 -0700 (PDT)
Date: Sun, 19 May 2024 23:00:36 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <20240519210036.GB10322@debian>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
 <20240517081050.168698-3-dima.fedrau@gmail.com>
 <20240519174248.69f00448@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240519174248.69f00448@jic23-huawei>

Am Sun, May 19, 2024 at 05:42:48PM +0100 schrieb Jonathan Cameron:
> On Fri, 17 May 2024 10:10:50 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > The device has four programmable temperature alert outputs which can be
> > used to monitor hot or cold-junction temperatures and detect falling and
> > rising temperatures. It supports up to 255 degree celsius programmable
> > hysteresis. Each alert can be individually configured by setting following
> > options in the associated alert configuration register:
> > - monitor hot or cold junction temperature
> > - monitor rising or falling temperature
> > - set comparator or interrupt mode
> > - set output polarity
> > - enable alert
> > 
> > This patch binds alert outputs to iio events:
> > - alert1: hot junction, rising temperature
> > - alert2: hot junction, falling temperature
> > - alert3: cold junction, rising temperature
> > - alert4: cold junction, falling temperature
> > 
> > All outputs are set in comparator mode and polarity depends on interrupt
> > configuration.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> Hi Dmitri

Hi Jonathan,

> Please make sure to address all questions in earlier reviews, either by
> changing the code, or directly answering the question.
>
I did, see: https://lore.kernel.org/linux-iio/20240509204559.GB3614@debian/T/#u
or did I miss anything ? I'm a little bit confused.

> The hysteresis handling in here is completely different from normal
> and the diagrams in figure 5-10 suggest it should not be.
> 
> Your thresholds should not include hysteresis at all as it has nothing to
> do with event triggering. The hysteresis is presented to userspace so it
> knows when a 'reset' of event detection logic occurs. It is expressed
> as an offset (in the obvious direction) from the current threshold.
> 
> It is always positive as negative hysteresis would be very odd. It's just
> magnitude of how far back beyond the threshold the signal must go for
> a reset of the signal detection logic to occur, allowing new transitions etc.
> 
> As long as you are using an edge interrupt that just means you won't get
> another interrupt until getting well away from what triggered the interrupt
> last time.
> 
You are right. Thanks a lot for your explanation. I just didn't know it,
assumed the hysteresis is represented same way as the threshold.

> Jonathan
> 
> > ---
> >  drivers/iio/temperature/mcp9600.c | 389 ++++++++++++++++++++++++++++++
> >  1 file changed, 389 insertions(+)
> > 
> > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > index 22451d1d9e1f..91d811fe9371 100644
> > --- a/drivers/iio/temperature/mcp9600.c
> > +++ b/drivers/iio/temperature/mcp9600.c
> > @@ -6,12 +6,21 @@
> >   * Author: <andrew.hepp@ahepp.dev>
> >   */
> >  
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/bits.h>
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/math.h>
> > +#include <linux/minmax.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> >  
> > +#include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  
> >  #define MCP9600_CHAN_HOT_JUNCTION	0
> > @@ -20,11 +29,65 @@
> >  /* MCP9600 registers */
> >  #define MCP9600_HOT_JUNCTION 0x0
> >  #define MCP9600_COLD_JUNCTION 0x2
> > +#define MCP9600_STATUS			0x4
> > +#define MCP9600_STATUS_ALERT(x)		BIT(x)
> > +#define MCP9600_ALERT_CFG1		0x8
> > +#define MCP9600_ALERT_CFG(x)		(MCP9600_ALERT_CFG1 + (x - 1))
> > +#define MCP9600_ALERT_CFG_ENABLE	BIT(0)
> > +#define MCP9600_ALERT_CFG_ACTIVE_HIGH	BIT(2)
> > +#define MCP9600_ALERT_CFG_FALLING	BIT(3)
> > +#define MCP9600_ALERT_CFG_COLD_JUNCTION	BIT(4)
> > +#define MCP9600_ALERT_HYSTERESIS1	0xc
> > +#define MCP9600_ALERT_HYSTERESIS(x)	(MCP9600_ALERT_HYSTERESIS1 + (x - 1))
> > +#define MCP9600_ALERT_LIMIT1		0x10
> > +#define MCP9600_ALERT_LIMIT(x)		(MCP9600_ALERT_LIMIT1 + (x - 1))
> > +#define MCP9600_ALERT_LIMIT_MASK	GENMASK(15, 2)
> >  #define MCP9600_DEVICE_ID 0x20
> >  
> >  /* MCP9600 device id value */
> >  #define MCP9600_DEVICE_ID_MCP9600 0x40
> >  
> > +#define MCP9600_ALERT_COUNT		4
> > +
> > +#define MCP9600_TEMP_SCALE_NUM		1000000
> 
> MICRO or just use that inline.
> 
> > +
> > +#define MCP9600_MIN_TEMP_HOT_JUNCTION	-200
> > +#define MCP9600_MAX_TEMP_HOT_JUNCTION	1800
> Give these units in the naming and  you can include the * MICRO here.
> e.g.
> #define MCP9600_MIN_TEMP_HOT_JUNC_MICROCELCIUS -200 * MICRO
> etc
> 
Ok.

> 
> > +
> > +static int mcp9600_read_thresh(struct iio_dev *indio_dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       enum iio_event_type type,
> > +			       enum iio_event_direction dir,
> > +			       enum iio_event_info info, int *val, int *val2)
> > +{
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	s32 ret;
> > +	int i;
> > +
> > +	i = mcp9600_get_alert_index(chan->channel, dir);
> > +	guard(mutex)(&data->lock);
> > +	ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * Temperature is stored in two’s complement format in bits(15:2),
> > +	 * LSB is 0.25 degree celsius.
> > +	 */
> > +	*val = sign_extend32(FIELD_GET(MCP9600_ALERT_LIMIT_MASK, ret), 13);
> > +	*val2 = 4;
> > +	if (info == IIO_EV_INFO_VALUE)
> > +		return IIO_VAL_FRACTIONAL;
> > +
> > +	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_HYSTERESIS(i + 1));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * Hysteresis is stored as unsigned offset from threshold. The alert
> > +	 * direction bit in the alert configuration register defines whether the
> > +	 * value is below or above the corresponding threshold.
> 
> I'm still very very confused by this.  I raised a question in the first review
> and you didn't provide more information.
> This is not how hysteresis is normally defined.  It should not affect the
> threshold at all, but instead affect when a reset occurs of the threshold detection
> logic. It also does not correspond to the diagrams in Figure 5-10 which look
> exactly like normal hysteresis controls.
> 
You are right. I got it wrong here. After your explanation and having a
look at https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio
it should be easy to fix this. Thanks again.

> 
> > +	 */
> > +	if (dir == IIO_EV_DIR_RISING)
> > +		*val -= (*val2 * ret);
> > +	else
> > +		*val += (*val2 * ret);
> > +
> > +	return IIO_VAL_FRACTIONAL;
> > +}
> > +
> > +static int mcp9600_write_thresh(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info, int val, int val2)
> > +{
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int s_val, s_thresh, i;
> > +	s16 thresh;
> > +	s32 ret;
> > +	u8 hyst;
> > +
> > +	/* Scale value to include decimal part into calculations */
> > +	s_val = (val < 0) ? ((val * MCP9600_TEMP_SCALE_NUM) - val2) :
> > +			    ((val * MCP9600_TEMP_SCALE_NUM) + val2);
> > +
> > +	/* Hot junction temperature range is from –200 to 1800 degree celsius */
> > +	if (chan->channel == MCP9600_CHAN_HOT_JUNCTION &&
> > +	   (s_val < (MCP9600_MIN_TEMP_HOT_JUNCTION * MCP9600_TEMP_SCALE_NUM) ||
> > +	    s_val > (MCP9600_MAX_TEMP_HOT_JUNCTION * MCP9600_TEMP_SCALE_NUM)))
> 
> As above, change the units of the defines to simplify this or perhaps
> just treat these as numbers and put them here rather than using defines at all.
> 
Ok.

> > +		return -EINVAL;
> > +
> > +	/* Cold junction temperature range is from –40 to 125 degree celsius */
> > +	if (chan->channel == MCP9600_CHAN_COLD_JUNCTION &&
> > +	   (s_val < (MCP9600_MIN_TEMP_COLD_JUNCTION * MCP9600_TEMP_SCALE_NUM) ||
> > +	    s_val > (MCP9600_MAX_TEMP_COLD_JUNCTION * MCP9600_TEMP_SCALE_NUM)))
> > +		return -EINVAL;
> > +
> > +	i = mcp9600_get_alert_index(chan->channel, dir);
> > +	guard(mutex)(&data->lock);
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		/*
> > +		 * Shift length 4 bits = 2(15:2) + 2(0.25 LSB), temperature is
> > +		 * stored in two’s complement format.
> > +		 */
> > +		thresh = (s16)(s_val / (MCP9600_TEMP_SCALE_NUM >> 4));
> > +		return i2c_smbus_write_word_swapped(client,
> > +						    MCP9600_ALERT_LIMIT(i + 1),
> > +						    thresh);
> > +	case IIO_EV_INFO_HYSTERESIS:
> > +		/* Read out threshold, hysteresis is stored as offset */
> > +		ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* Shift length 4 bits = 2(15:2) + 2(0.25 LSB), see above. */
> > +		s_thresh = sign_extend32(ret, 15) * (MCP9600_TEMP_SCALE_NUM >> 4);
> > +
> > +		/*
> > +		 * Hysteresis is stored as offset, for rising temperatures, the
> > +		 * hysteresis range is below the alert limit where, as for falling
> > +		 * temperatures, the hysteresis range is above the alert limit.
> > +		 */
> 
> I don't understand this comment.
> Hysteresis as a parameter in sysfs in IIO is also an offset, so why is the current
> threshold relevant?
> 
> Normally hysteresis is about allowing repeat events. I.e. you have to drop below
> threshold - hysteresis  before rising again to trigger a rising event when passing
> threshold.
> 
As above, I just didn't know better.

> 
> > +		hyst = min(255, abs(s_thresh - s_val) / MCP9600_TEMP_SCALE_NUM);
> > +
> > +		return i2c_smbus_write_byte_data(client,
> > +						 MCP9600_ALERT_HYSTERESIS(i + 1),
> > +						 hyst);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> 
> > +static irqreturn_t mcp9600_alert3_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
> > +	if (ret < 0)
> > +		return IRQ_HANDLED;
> > +
> > +	if (!(ret & MCP9600_STATUS_ALERT(MCP9600_ALERT3)))
> 
> This duplicates far too much all these call a function that takes
> a) This bit,
> b) the related channel index.
> C) the direction
> 
> and call that from all these separate handlers.
> Each individual handler become simply:
> 
> 	return mcp9600_alert_handler(private, MCP9600_ALERT3,
> 				     MCP9600_CHAN_COLD_JUNCTION,
> 				     IIO_EV_DIR_RISING);
> 
> etc.
>
Yes, will use a helper function to avoid code duplication.

> > +		return IRQ_NONE;
> > +
> > +	iio_push_event(indio_dev,
> > +		       IIO_MOD_EVENT_CODE(IIO_TEMP, MCP9600_CHAN_COLD_JUNCTION,
> > +					  IIO_NO_MOD, IIO_EV_TYPE_THRESH,
> > +					  IIO_EV_DIR_RISING),
> > +		       iio_get_time_ns(indio_dev));
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> 
> > +
> > +static irqreturn_t (*mcp9600_alert_handler[MCP9600_ALERT_COUNT]) (int, void *) = {
> > +	mcp9600_alert1_handler,
> > +	mcp9600_alert2_handler,
> > +	mcp9600_alert3_handler,
> > +	mcp9600_alert4_handler,
> >  };
>

Dimitri

