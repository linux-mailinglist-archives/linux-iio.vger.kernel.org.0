Return-Path: <linux-iio+bounces-8395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0A94DC36
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD5B21979
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537051514DC;
	Sat, 10 Aug 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqgO4Fya"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA173EA69;
	Sat, 10 Aug 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285007; cv=none; b=IUL6aqBhvfIyNoZxbWLZ7cGSCHfY3ReEZf8dMswjoaw1ZGyD3mxYDMsbMQDiw1rgvmba82SzlFM/HgaV0OwHWoYKN6NfP1+56usT4kUGLe0/opBf/TgGE8T9UqXnwIK/jZJ571+ZTOE4Xm/d6Fx5DtZaoVH8d9xGUA2iQZ07+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285007; c=relaxed/simple;
	bh=CZlapVab1zX6+Ny8nGKNoFjU2OOlzpbyEGauM6ne+FM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMgUPXYj5estoqETt0SWvXKMcR2ZkPzmX7U7z0Nr4fgmy9/XotTEfhxtDyhZrl7kfLHMmdL0Pc1lDr2FBeTiZjzcB/fG8lpzO644EGhI93uaEbLtq7bdw2uyjz/CF96hjZvHodJZoCNwhSXwL9tJyZvdVjXI8Skd5Bcoo97A5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqgO4Fya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E048C32781;
	Sat, 10 Aug 2024 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723285006;
	bh=CZlapVab1zX6+Ny8nGKNoFjU2OOlzpbyEGauM6ne+FM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qqgO4FyayWlbq9meWHn+ECRuXgXDBdIpdrqZZWw3BLzJTiT0LgCKIgGJN2Bd6aDx8
	 zjc1lnrLY2b5y1nLzxEjjtpZsJ0pAfc0i3sxQwmto/IAzoq55xTSY70AoWzw4cqxpH
	 oYJdCf6HhePDBSVoGTxO5fx1K5DgFtx7qBgPSsklj+Lbb3vlK7Eca9DU1edI26Rn3R
	 sNffpPH5tFX7D/GPE893WspkS+fGITwQKNbmtw0pZGl9BlJ8fVtAqx3VxT/v5JrQmv
	 +Yautj7IfX9463HMmLl/1YNf98VvqEVcM4SKc80Cff0Dmk6bxXv/BQsGRHzd40+iDX
	 7xycA8vBe2DWg==
Date: Sat, 10 Aug 2024 11:16:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, kangjiajun@awinic.com,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, liweilei@awinic.com, robh@kernel.org,
 waqar.hameed@axis.com
Subject: Re: [PATCH V5 2/2] iio: proximity: aw9610x: Add support for aw9610x
 proximity sensor
Message-ID: <20240810111637.3280eff6@jic23-huawei>
In-Reply-To: <20240808102753.4023286-1-wangshuaijie@awinic.com>
References: <20240727160216.2488ed29@jic23-huawei>
	<20240808102753.4023286-1-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> >> +static int aw9610x_cfg_all_loaded(const struct firmware *cont,
> >> +		struct aw9610x *aw9610x)
> >> +{
> >> +	struct aw_bin *aw_bin;
> >> +	int ret;
> >> +
> >> +	if (!cont)
> >> +		return -EINVAL;
> >> +
> >> +	aw_bin = kzalloc(cont->size + sizeof(*aw_bin), GFP_KERNEL);  
> >Use __free(kfree) 
> >
> >lots of examples in tree, but will avoid need to manually free and
> >simplify this code a little.
> >  
> 
> I'm sorry, I didn't quite understand what you meant. Are you suggesting
> the use of devm_? Could you please provide more detailed suggestions?
> Thank you!

No. Search for that string __free(kfree) and you will see what
I mean.  It provides scope based destructors.

devm is about tying lifetime to device registration, here we need to tie
it to this scope of this function.


> 
> >> +	if (!aw_bin)
> >> +		return -ENOMEM;
> >> +
> >> +	aw_bin->len = cont->size;
> >> +	memcpy(aw_bin->data, cont->data, cont->size);
> >> +	aw9610x_parsing_bin_file(aw_bin);
> >> +
> >> +	snprintf(aw9610x->chip_type, sizeof(aw9610x->chip_type), "%s",
> >> +			aw_bin->chip_type);
> >> +	ret = aw9610x_bin_valid_loaded(aw9610x, aw_bin);
> >> +	kfree(aw_bin);
> >> +
> >> +	return ret;
> >> +}

> >> +
> >> +static void aw9610x_cfg_work_routine(struct work_struct *work)
> >> +{
> >> +	struct aw9610x *aw9610x = container_of(work, struct aw9610x,
> >> +			cfg_work.work);
> >> +
> >> +	aw9610x_cfg_update(aw9610x);  
> >
> >So this is polling in driver.   We'd normally hook up to a hrtimer
> >trigger for that.  Perhaps you need this for your events sampling though?
> >If so that may be fine to do somewhat like this. I'm just not sure
> >of the usecase currently.
> >  
> 
> The primary objective of this delayed task is to load the register
> configuration file. The chip needs to load the register configuration
> file during power-on initialization. In cases where the driver is compiled
> directly into the kernel, rather than existing as a dynamically loaded
> module, there may be a situation where the driver attempts to load before
> the file system is fully prepared, resulting in an inability to access the
> register configuration file.

I believe there are standard ways to handle this.
the driver shouldn't be relying on local tricks to make this work.
https://www.kernel.org/doc/html/v4.16/driver-api/firmware/fallback-mechanisms.html

> Therefore, a delayed task mechanism is employed
> to ensure the register configuration file is loaded properly.
> 
> If there are any concerns about my understanding or approach, please feel
> free to offer suggestions. Thank you very much!
> 
> >> +}


> >> +static void aw9610x_irq_handle(struct aw9610x *aw9610x)
> >> +{
> >> +	u32 curr_status_val;
> >> +	u32 curr_status;
> >> +	unsigned char i;
> >> +	int ret;
> >> +
> >> +	ret = aw9610x_i2c_read(aw9610x, REG_STAT0, &curr_status_val);
> >> +	if (ret)
> >> +		return;
> >> +
> >> +	for (i = 0; i < AW_CHANNEL_MAX; i++) {
> >> +		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
> >> +			(((curr_status_val >> (16 + i)) & 0x1) << 1) |
> >> +			(((curr_status_val >> (8 + i)) & 0x1) << 2) |
> >> +			(((curr_status_val >> (i)) & 0x1) << 3);  
> >
> >Add a comment on what is going on here as it's tricky to read.
> >Also, no brackets around the i in last line.
> >Probably better expressed as a series of FIELD_GET() calls with appropriat
> >masks of the 32 bit value.
> >
> >  
> 
> The work processed here is to parse the interrupt status of different channels.
> bit0/bit8/bit16/bit24 represent the interrupt status of channel 0, with each of
> the 4 bits corresponding to an interrupt status for approaching a threshold.
> Similarly, bit1/bit9/bit17/bit25 represent the interrupt status of channel 1.
> To facilitate subsequent interrupt status judgments, the 4 interrupt statuses
> of the same channel are combined into a single data.
> 
> Sorry, I have not found a suitable way to utilize FIELD_GET for this purpose.

That's fine. Just add a comment to say it is gathering up the status bits
for a particular channel.

> 
> >> +
> >> +		if (!aw9610x->channels_arr[i].used ||
> >> +				(aw9610x->channels_arr[i].last_channel_info ==
> >> +				curr_status))  
> >Align as
> >		if (!aw
> >		    (aw9610...
> >  
> >> +			continue;
> >> +
> >> +		switch (curr_status) {
> >> +		case FAR:
> >> +			iio_push_event(aw9610x->aw_iio_dev,
> >> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> >> +						IIO_EV_TYPE_THRESH,
> >> +						IIO_EV_DIR_RISING),
> >> +					iio_get_time_ns(aw9610x->aw_iio_dev));
> >> +			break;
> >> +		case TRIGGER_TH0:
> >> +		case TRIGGER_TH1:
> >> +		case TRIGGER_TH2:
> >> +		case TRIGGER_TH3:  
> >4 thresholds on the same channel? This is confusing given we are reporting them
> >as events on different channels. but this loop is over the channels.
> >
> >  
> 
> There are 4 proximity thresholds on the same channel, each representing
> a different level of proximity. TRIGGER_TH0/TRIGGER_TH1/TRIGGER_TH2/TRIGGER_TH3
> all represent proximity states, but with varying degrees of proximity.
> 
> Here I have a question to ask. I'm not sure how to use iio to report
> different proximity states. Can you give me some suggestions? Thank you!

This is a limitation of IIO and need to limit the scale of the event descriptor.
We don't support more than one threshold of a given type per channel.

It's an design decision based on the fact that for sensors, it is
rarely useful to actually support multiple thresholds.  If software has
gotten an interrupt of the first one, it can read the channel value and
if it likes modify the threshold.  As such, what does having another
level actually bring to a usecase?

Lots of hardware supports multiple thresholds we just choose not to
expose it.  I might consider ways around that, but first I need
to understand the user space usecase for it.

Note there are lots of reasons to do this in baremetal / realtime systems
where particular actions are triggered in a timely fashion.  By the time
you are dealing with a full Linux software stack most of those don't
make sense any more because there is a lot more software processing in the
loop.

Jonathan



> 
> >> +			iio_push_event(aw9610x->aw_iio_dev,
> >> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> >> +						IIO_EV_TYPE_THRESH,
> >> +						IIO_EV_DIR_FALLING),
> >> +					iio_get_time_ns(aw9610x->aw_iio_dev));
> >> +			break;
> >> +		default:
> >> +			return;
> >> +		}
> >> +		aw9610x->channels_arr[i].last_channel_info = curr_status;
> >> +	}
> >> +}
> >> +  
> 
> Kind regards,
> Wang Shuaijie

