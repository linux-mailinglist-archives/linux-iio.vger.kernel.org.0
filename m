Return-Path: <linux-iio+bounces-4914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CFE8C17CE
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 22:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E881F228C4
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACEA7FBD2;
	Thu,  9 May 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEOTVCFI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766DC2C6;
	Thu,  9 May 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715287566; cv=none; b=czTnRqZ+WYNR6S+WIC6TpA8wTN5X/rahaoZAPtsIohma4AJH9M2AJsrlxp01DXPJEfdhgd4J5NQ0A5MnscVdPD4Hfo7GjTr0UoQo5Taig1K7VrnTwcXGZYMF7kcYblFtJFQrQrTc8N5D+ujXT3S8rTLc/SMkyfaty4X/8o6zGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715287566; c=relaxed/simple;
	bh=/0DtUfatc+iKEpmodtq0/xWX09HdNbfAK/RznEyeg7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4IpjdG52rkpt4cghNozH7A0t6BrKg1JiXIYMjdttcwPsqRMF9dV3oTtCDJcPZgvoX7DYHyfNE7UXDcz3Hs+5+bfPGz5XheaLvQqX7H10Ocd4B33jwBu7CuyCm9D54DK2AOWTenvKqCnPAwGgKOBUsDdIF1LHuTvBbnosiuCRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEOTVCFI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41fc2f7fbb5so7048965e9.1;
        Thu, 09 May 2024 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715287562; x=1715892362; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x4LGq2pOeT4TIMeu0pI2Jim5yLWTmRuC6LOpfckMHrE=;
        b=GEOTVCFIIU4U1Xob2cfZ2eC8i8j9uyPPqqA1fgiPWCrsriIZmjCgz67D6aIe9hKkIp
         MUkGhJWjzyOPKTg7FZ40TIsAY18dT4G44k8BqdM8AViQ71Y0M3dyV7HZL25iiCv2wEEO
         ogBeVY2y6dCn9F2QKBaz0+0M0VwCjcwxXRUfn8aBVH1PdRPjkFl/HclkYb34Q61zHxKR
         5wbO9ABrHf2O8qh1zcZhOYQfGQ/zTPhLdq4GV5CzNrmketgdYSoi3zbur/b+Pc4ap1Li
         YNoe5YqttS2+FjgWlL4zf5/ONGuxZEv/P9onv5S6lNC5SC5VbLYnIqeeJIne7IUubv4W
         ZWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715287562; x=1715892362;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4LGq2pOeT4TIMeu0pI2Jim5yLWTmRuC6LOpfckMHrE=;
        b=LZOFZiJ+qtMCHCwZticvufXl8JK0w7uontLsnTQmaD43vdTkCuUc5I9vVc4w8aMOH2
         GHVgmeAg+XH/hf+mptnaN7yAsxgQfYB/H7YhHwAMos2X12XImjxVhEf822lo+2x5HSho
         MwfrPtnE5ftSkqi5wuO6DxqNWp1U57podO2DedsTsBYfok94g+CIfNS+omLyzZ2q7awc
         pnFHok0CpnSYdoFbTX/bj6BZrSESQd2bIOcNNNnA2yS0peIXC0i30/70wFyJ4dIcKu/7
         cp0H53/odCN/Nfro39D3GB/wW/StFO66PtlGipkn5HdBr3p1kpJDk8fGmLcYsP0DPDUJ
         2TKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOKQCMDcIn6IdGfBnSkmK6YwmmuOcFa3VBIKkqsbxpqXCxFA2Sj/Ttmy9lt99z3rQClP4mjjR0I9grijso1jk3r39iWYlUi81hegLmo4PQuYbcnTulnItCtuEnZw7tX9/G9rYiMqe6
X-Gm-Message-State: AOJu0YwK4QZF6ibuBQvKFFrt4nUqLK9/Y1OFqVKDW4UaO5PykN2tZ09w
	j8hls715N6nWj31jpuIzaoaNHfKGGQIcB/h8khEYxyGEkcKQP8xo
X-Google-Smtp-Source: AGHT+IH7jJ4cEgxUCyfrS6sXo9hcEZSrmJM1s36zm1yuh0698F2ZYfIDz4lVTxQwad0spDPwjPe89A==
X-Received: by 2002:a05:600c:1381:b0:41a:56b7:eb37 with SMTP id 5b1f17b1804b1-41fead61bc5mr5203405e9.20.1715287561829;
        Thu, 09 May 2024 13:46:01 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8f8asm37265055e9.10.2024.05.09.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:46:01 -0700 (PDT)
Date: Thu, 9 May 2024 22:45:59 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <20240509204559.GB3614@debian>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
 <20240430120535.46097-6-dima.fedrau@gmail.com>
 <20240505184700.5c85b2ba@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240505184700.5c85b2ba@jic23-huawei>

Am Sun, May 05, 2024 at 06:47:00PM +0100 schrieb Jonathan Cameron:
> On Tue, 30 Apr 2024 14:05:35 +0200
> Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> 
> > The device has four programmable temperature alert outputs which can be
> > used to monitor hot or cold-junction temperatures and detect falling and
> > rising temperatures. It supports up to 255 degree celsius programmable
> > hysteresis. Each alert can be individually configured by setting following
> > options in the associated alert configuration register:
> >   - monitor hot or cold junction temperature
> >   - monitor rising or falling temperature
> >   - set comparator or interrupt mode
> >   - set output polarity
> >   - enable alert
> > 
> > This patch binds alert outputs to iio events:
> >   - alert1: hot junction, rising temperature
> >   - alert2: hot junction, falling temperature
> >   - alert3: cold junction, rising temperature
> >   - alert4: cold junction, falling temperature
> > 
> > All outputs are set in comparator mode and polarity depends on interrupt
> > configuration.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > ---
> Various comments inline.
> 
> Jonathan
> 
> >  drivers/iio/temperature/mcp9600.c | 358 +++++++++++++++++++++++++++++-
> >  1 file changed, 354 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > index cb1c1c1c361d..f7e1b4e3253d 100644
> > --- a/drivers/iio/temperature/mcp9600.c
> > +++ b/drivers/iio/temperature/mcp9600.c
> > @@ -6,21 +6,80 @@
> >   * Author: <andrew.hepp@ahepp.dev>
> >   */
> >  
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> >  #include <linux/err.h>
> >  #include <linux/i2c.h>
> >  #include <linux/init.h>
> > +#include <linux/math.h>
> > +#include <linux/minmax.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/units.h>
> >  
> > +#include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  
> >  /* MCP9600 registers */
> > -#define MCP9600_HOT_JUNCTION 0x0
> 
> As below. Reformating in a precursor patch. I wouldn't necessarily bother
> though as aligning defines is usually more effort than it is worth over time.
>
Ok, will skip the aligning.

> > -#define MCP9600_COLD_JUNCTION 0x2
> > -#define MCP9600_DEVICE_ID 0x20
> > +#define MCP9600_HOT_JUNCTION		0x0
> > +#define MCP9600_COLD_JUNCTION		0x2
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
> > +
> > +#define MCP9600_DEVICE_ID		0x20
> >  
> >  /* MCP9600 device id value */
> > -#define MCP9600_DEVICE_ID_MCP9600 0x40
> > +#define MCP9600_DEVICE_ID_MCP9600	0x40
> 
> If you want to reformatting existing lines, do it in a precursor patch - not
> buried in here.
> 
Ok, will skip the aligning.

> >  
> >  struct mcp9600_data {
> >  	struct i2c_client *client;
> > +	struct mutex lock[MCP9600_ALERT_COUNT];
> 
> All locks need documentation.  What data is this protecting?
> 
It protects hysteresis values, since these are represented as offsets
from thresholds. To read/write hysteresis values we need to read first
the corresponding threshold value. This can lead to race conditions, as
both can be accessed concurrently via sysfs.

> > +	int irq[MCP9600_ALERT_COUNT];
> >  };
> >  
> >  static int mcp9600_read(struct mcp9600_data *data,
> > @@ -83,10 +148,292 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
> >  	}
> >  }
> >  
> > +static int mcp9600_get_alert_index(int channel2, enum iio_event_direction dir)
> > +{
> > +	switch (channel2) {
> > +	case IIO_MOD_TEMP_OBJECT:
> > +		if (dir == IIO_EV_DIR_RISING)
> > +			return MCP9600_ALERT1;
> > +		else
> > +			return MCP9600_ALERT2;
> > +	case IIO_MOD_TEMP_AMBIENT:
> > +		if (dir == IIO_EV_DIR_RISING)
> > +			return MCP9600_ALERT3;
> > +		else
> > +			return MCP9600_ALERT4;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int mcp9600_read_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir)
> > +{
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int i, ret;
> > +
> > +	i = mcp9600_get_alert_index(chan->channel2, dir);
> > +	if (i < 0)
> > +		return i;
> > +
> > +	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_CFG(i + 1));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return (ret & MCP9600_ALERT_CFG_ENABLE);
> 
> FIELD_GET() even if it happens to be bit(0) as then we don't have to go
> check that's the case.
> 
Ok.
> > +}
> > +
> > +static int mcp9600_write_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      enum iio_event_type type,
> > +				      enum iio_event_direction dir,
> > +				      int state)
> > +{
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	int i, ret;
> > +
> > +	i = mcp9600_get_alert_index(chan->channel2, dir);
> > +	if (i < 0)
> > +		return i;
> > +
> > +	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_CFG(i + 1));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (state)
> > +		ret |= MCP9600_ALERT_CFG_ENABLE;
> > +	else
> > +		ret &= ~MCP9600_ALERT_CFG_ENABLE;
> > +
> > +	return i2c_smbus_write_byte_data(client, MCP9600_ALERT_CFG(i + 1), ret);
> 
> A read modify write cycle like this normally needs some locking to ensure another
> access didn't change the other bits in the register.
> 
Each alert has it's own configuration register. All bits except the
enable bit are set during probe and there is no need besides the enable
bit to set them.

> 
> > +}
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
> > +	i = mcp9600_get_alert_index(chan->channel2, dir);
> > +	if (i < 0)
> > +		return i;
> > +
> > +	guard(mutex)(&data->lock[i]);
> > +	ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * Temperature is stored in two’s complement format in bits(15:2),
> > +	 * LSB is 0.25 degree celsius.
> > +	 */
> > +	*val = sign_extend32(ret, 15) >> 2;
> Use sign_extend32(FIELD_GET(...), 13)
> So which bits are extracted is obvious in the code.
> 
Ok.
> > +	*val2 = 4;
> > +	if (info == IIO_EV_INFO_VALUE)
> > +		return IIO_VAL_FRACTIONAL;
> > +
> > +	ret = i2c_smbus_read_byte_data(client, MCP9600_ALERT_HYSTERESIS(i + 1));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/*
> > +	 * Hysteresis is stored as offset which is not signed, therefore we have
> > +	 * to include directions when calculating the real hysteresis value.
> > +	 */
> > +	if (dir == IIO_EV_DIR_RISING)
> > +		*val -= (*val2 * ret);
> > +	else
> > +		*val += (*val2 * ret);
> 
> I don't follow this maths.  Hysteresis is an unsigned offset.  Maybe some confusion
> over the ABI?  
> 
The alert hysteresis range is from 0 to 255 degree celsius. The
direction bit in the alert configuration register defines whether the
value is below or above the corresponding threshold. The offset here is
the threshold itself. I will improve the comment.

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
> > +	s_val = (val < 0) ? ((val * (int)MICRO) - val2) :
> > +			    ((val * (int)MICRO) + val2);
> > +
> > +	/* Hot junction temperature range is from –200 to 1800 degree celsius */
> > +	if (chan->channel2 == IIO_MOD_TEMP_OBJECT &&
> > +	   (s_val < (MCP9600_MIN_TEMP_HOT_JUNCTION * (int)MICRO) ||
> > +	    s_val > (MCP9600_MAX_TEMP_HOT_JUNCTION * (int)MICRO)))
> 
> Why the casts?
> 
Missed to remove them. Will fix it in the next version of the patch.
> > +		return -EINVAL;
> > +
> > +	/* Cold junction temperature range is from –40 to 125 degree celsius */
> > +	if (chan->channel2 == IIO_MOD_TEMP_AMBIENT &&
> > +	   (s_val < (MCP9600_MIN_TEMP_COLD_JUNCTION * (int)MICRO) ||
> > +	    s_val > (MCP9600_MAX_TEMP_COLD_JUNCTION * (int)MICRO)))
> > +		return -EINVAL;
> > +
> > +	i = mcp9600_get_alert_index(chan->channel2, dir);
> > +	if (i < 0)
> > +		return i;
> > +
> > +	guard(mutex)(&data->lock[i]);
> > +	if (info == IIO_EV_INFO_VALUE) {
> 
> I would use a switch statement so it is obvious what each case is.
> 
Ok.
> > +		/*
> > +		 * Shift length 4 bits = 2(15:2) + 2(0.25 LSB), temperature is
> > +		 * stored in two’s complement format.
> > +		 */
> > +		thresh = (s16)(s_val / (int)(MICRO >> 4));
> > +		return i2c_smbus_write_word_swapped(client,
> > +						    MCP9600_ALERT_LIMIT(i + 1),
> > +						    thresh);
> > +	}
> > +
> > +	/* Read out threshold, hysteresis is stored as offset */
> > +	ret = i2c_smbus_read_word_swapped(client, MCP9600_ALERT_LIMIT(i + 1));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Shift length 4 bits = 2(15:2) + 2(0.25 LSB), see above. */
> > +	s_thresh = sign_extend32(ret, 15) * (int)(MICRO >> 4);
> > +
> > +	/*
> > +	 * Hysteresis is stored as offset, for rising temperatures, the
> > +	 * hysteresis range is below the alert limit where, as for falling
> > +	 * temperatures, the hysteresis range is above the alert limit.
> > +	 */
> > +	hyst = min(255, abs(s_thresh - s_val) / MICRO);
> > +
> > +	return i2c_smbus_write_byte_data(client,
> > +					 MCP9600_ALERT_HYSTERESIS(i + 1),
> > +					 hyst);
> > +}
> > +
> >  static const struct iio_info mcp9600_info = {
> >  	.read_raw = mcp9600_read_raw,
> > +	.read_event_config = mcp9600_read_event_config,
> > +	.write_event_config = mcp9600_write_event_config,
> > +	.read_event_value = mcp9600_read_thresh,
> > +	.write_event_value = mcp9600_write_thresh,
> >  };
> >  
> > +static irqreturn_t mcp9600_alert_handler(int irq, void *private)
> > +{
> > +	struct iio_dev *indio_dev = private;
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +	enum iio_event_direction dir;
> > +	enum iio_modifier mod;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < MCP9600_ALERT_COUNT; i++) {
> > +		if (data->irq[i] == irq)
> 
> This search for a match is a little messy. I'd be tempted
> to wrap the generic handler in a per instance interrupt handler
> (so have 4 functions) and thus move this matching to the place
> where they are registered, not the interrupt handler.
> 
> There isn't a lot of shared code in here so you may be better
> off just having 4 separate interrupt handler implementations.
> 
You are right, it is definitely the better solution.

> > +			break;
> > +	}
> > +
> > +	if (i >= MCP9600_ALERT_COUNT)
> > +		return IRQ_NONE;
> > +
> > +	ret = i2c_smbus_read_byte_data(data->client, MCP9600_STATUS);
> > +	if (ret < 0)
> > +		return IRQ_HANDLED;
> > +
> > +	switch (ret & MCP9600_STATUS_ALERT(i)) {
> > +	case 0:
> > +		return IRQ_NONE;
> > +	case MCP9600_STATUS_ALERT(MCP9600_ALERT1):
> > +		mod = IIO_MOD_TEMP_OBJECT;
> > +		dir = IIO_EV_DIR_RISING;
> > +		break;
> > +	case MCP9600_STATUS_ALERT(MCP9600_ALERT2):
> > +		mod = IIO_MOD_TEMP_OBJECT;
> > +		dir = IIO_EV_DIR_FALLING;
> > +		break;
> > +	case MCP9600_STATUS_ALERT(MCP9600_ALERT3):
> > +		mod = IIO_MOD_TEMP_AMBIENT;
> > +		dir = IIO_EV_DIR_RISING;
> > +		break;
> > +	case MCP9600_STATUS_ALERT(MCP9600_ALERT4):
> > +		mod = IIO_MOD_TEMP_AMBIENT;
> > +		dir = IIO_EV_DIR_FALLING;
> > +		break;
> > +	default:
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	iio_push_event(indio_dev,
> > +		       IIO_MOD_EVENT_CODE(IIO_TEMP, 0, mod,
> > +					  IIO_EV_TYPE_THRESH, dir),
> > +		       iio_get_time_ns(indio_dev));
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
> > +{
> > +	struct mcp9600_data *data = iio_priv(indio_dev);
> > +	struct i2c_client *client = data->client;
> > +	struct device *dev = &client->dev;
> > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > +	unsigned int irq_type;
> > +	int ret, irq, i;
> > +	u8 val;
> > +
> > +	/*
> > +	 * alert1: hot junction, rising temperature
> > +	 * alert2: hot junction, falling temperature
> > +	 * alert3: cold junction, rising temperature
> > +	 * alert4: cold junction, falling temperature
> > +	 */
> > +	for (i = 0; i < MCP9600_ALERT_COUNT; i++) {
> > +		data->irq[i] = 0;
> 
> All of data is zeroed already so this should not be needed.
>
Yes.

> > +		mutex_init(&data->lock[i]);
> 
> Why per interrupt locks?  Seems unlikely to be a big problem
> to share one.
>
I think the code is misleading here. The locks are not per interrupt,
just for setting thresholds, since each alert has its own configuration
registers. Locks are just needed because hysteresis values depends on
threshold values. I think there should be no problem when using a single
lock for setting thresholds/hysteresis values across all alerts. Don't
know if its worth having the four locks since it it not the fastpath.

> > +		irq = fwnode_irq_get_byname(fwnode, mcp9600_alert_name[i]);
> > +		if (irq <= 0)
> > +			continue;
> > +
> > +		val = 0;
> > +		irq_type = irq_get_trigger_type(irq);
> > +		if (irq_type == IRQ_TYPE_EDGE_RISING)
> > +			val |= MCP9600_ALERT_CFG_ACTIVE_HIGH;
> > +
> > +		if (i == MCP9600_ALERT2 || i == MCP9600_ALERT4)
> > +			val |= MCP9600_ALERT_CFG_FALLING;
> > +
> > +		if (i == MCP9600_ALERT3 || i == MCP9600_ALERT4)
> > +			val |= MCP9600_ALERT_CFG_COLD_JUNCTION;
> > +
> > +		ret = i2c_smbus_write_byte_data(client,
> > +						MCP9600_ALERT_CFG(i + 1),
> > +						val);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = devm_request_threaded_irq(dev, irq, NULL,
> > +						mcp9600_alert_handler,
> > +						IRQF_ONESHOT, "mcp9600",
> > +						indio_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		data->irq[i] = irq;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mcp9600_probe(struct i2c_client *client)
> >  {
> >  	struct device *dev = &client->dev;
> > @@ -109,6 +456,8 @@ static int mcp9600_probe(struct i2c_client *client)
> >  	data = iio_priv(indio_dev);
> >  	data->client = client;
> >  
> > +	mcp9600_probe_alerts(indio_dev);
> 
> Why no error check? 
> 
Missed that one. Thanks.
> > +
> >  	indio_dev->info = &mcp9600_info;
> >  	indio_dev->name = "mcp9600";
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > @@ -140,6 +489,7 @@ static struct i2c_driver mcp9600_driver = {
> >  };
> >  module_i2c_driver(mcp9600_driver);
> >  
> > +MODULE_AUTHOR("Dimitri Fedrau <dima.fedrau@gmail.com>");
> >  MODULE_AUTHOR("Andrew Hepp <andrew.hepp@ahepp.dev>");
> >  MODULE_DESCRIPTION("Microchip MCP9600 thermocouple EMF converter driver");
> >  MODULE_LICENSE("GPL");
> 

Dimitri

