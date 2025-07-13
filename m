Return-Path: <linux-iio+bounces-21599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2DB03138
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E842C177A9B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 13:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3A27877D;
	Sun, 13 Jul 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdivMPP9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C817E4;
	Sun, 13 Jul 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752414142; cv=none; b=Lzs9bPbzddY4HsKfjc8DjPurF+yhmROAz9qtQcF3ahSMcTiOFXdx8QckgNEc+R9otSwQPaYcDl8raqAit3XmULeFAaB2fO8J1xPk2KnItMusq507MChVxlnOtH4WLSlMilL8JkS+xiWX+oBnQbihemsyV2pv18Kx4QSQru/04gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752414142; c=relaxed/simple;
	bh=FiK8zDiaUXmEFpaObLQbyvo1T/Qz+0i0aynWUyUlYpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMF6KqA0LzRi/Ome3TSMZqVxy14EVH8Uco4T8JEdnXhS7um6tc80GOrpgdQWc50bbpWrmpkLrRHF1HyCxanFEpte/lfPsfJsPmd9GWutccFbrZhH8F0TZyP+c+i/SVicuOBU6BRLrHHGyy4A6ScnWECCJTDQqtJ0Q/UDCP8mFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdivMPP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56391C4CEE3;
	Sun, 13 Jul 2025 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752414141;
	bh=FiK8zDiaUXmEFpaObLQbyvo1T/Qz+0i0aynWUyUlYpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cdivMPP9gmyMal7Nz7Wbd/EGgmLpj9fDl8OwcZ4G+mx29lSB8u6s86519fxpUEi4Z
	 XVtHYlbWjRcaS8MaQ2xI6SyDaLN0B/5fZbUXxhluZKS8R8FI/68jQpwNyk7RxjeMuX
	 niU8g8i2Qtrkum09IYF/jhGwEErAQiDrTOkkvcBMJsu9aZhdBuKw1VS7oDNxsmpXQl
	 rCKFxaYRrAMrI0LuC7Rhn+R9xMdevwEJr9X/fPJXzJYgSvdzAGT8K5pusYzS1MDXAz
	 hUetqiWXI28yhZx6sDH9HYLSQDmK4wWaeh34OVmB/6R+z55qTKzG5Oxa7t+u28w+P7
	 8tsZyQLgDNZRQ==
Date: Sun, 13 Jul 2025 14:42:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
 <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
 <marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
 <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
 <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v3 2/2] iio: imu: smi330: Add driver
Message-ID: <20250713144214.6ee02f59@jic23-huawei>
In-Reply-To: <AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20250703153823.806073-1-Jianping.Shen@de.bosch.com>
	<20250703153823.806073-3-Jianping.Shen@de.bosch.com>
	<20250706175328.7207d847@jic23-huawei>
	<AM8PR10MB47217D838CA7DDACBE162D15CD49A@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 19:38:18 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> Hi Jonathan,
> 
> "available_scan_masks" works not as expected.  We test it using kernel version v6.16. see the test result inline.
> 
> Best Regards 
> Jianping 
> 
> >> +
> >> +static irqreturn_t smi330_trigger_handler(int irq, void *p) {
> >> +	struct iio_poll_func *pf = p;
> >> +	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	struct smi330_data *data = iio_priv(indio_dev);
> >> +	int ret, chan;
> >> +	int i = 0;
> >> +
> >> +	ret = regmap_bulk_read(data->regmap, SMI330_ACCEL_X_REG, data-
> >>buf,
> >> +			       ARRAY_SIZE(smi330_channels));
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	if (*indio_dev->active_scan_mask != SMI330_ALL_CHAN_MSK) {
> >> +		iio_for_each_active_channel(indio_dev, chan)
> >> +			data->buf[i++] = data->buf[chan];  
> >
> >If I follow this correctly you are reading all the channels and just copying out the
> >ones you want.  Just let the IIO core do that for you by setting iio_dev-  
> >>available_scan_masks = {  SMI330_ALL_CHAN_MSK, 0 }; and push the whole  
> >buffer every time.  
> 
> For the most frequent use cases, we define available_scan_masks = { SMI330_ALL_CHAN_MSK, SMI330_ACC_XYZ_MSK, SMI330_GYRO_XYZ_MSK, 0 }; and push the whole buffer every time.
> From the user space we just enable 3 channels gyro_x, gyro_y, and gyro_z. Then we enable buffer and expect that only the gyro values and timestamp in iio_buffer. Nevertheless, we have 3 accelerometer values and the timestamp in iio_buffer.

> It seems that the iio core does not take care which channel is enabled,  just copy the first 3 values (acc x,y,z) into iio_buffer.  Our driver code still needs to take care and just copy the enabled channel value to buffer.

Look again at how it works.  If you provide ACC_XYZ_MSK, then your driver has to handle it.
available_scan_masks is saying what your driver supports. The driver can check active_scan_mask
to find out what is enabled.  So right option here is only
{ SMI330_ALL_CHAN_MSK, 0, }  In that case the driver never needs to check as there is only
one option.

Then if any subset of channels is enabled the IIO core copy out just the data that
is relevant.


> 
> Another side effect after using available_scan_masks is that the active_scan_masks sometimes does not reflect current channel activation status.
> 
> Is some step missing to properly use available_scan_masks ?  How can a user find out from user space which channel combination is defined in available_scan_masks ?

Why would userspace want to?  Userspace requested a subset of channels
and it gets that subset.  So it if asks for the channels that make up
SMI330_ACC_XYZ_MSK, if available_scan_mask == { SMI330_ALL_CHAN_MSK, 0 } then
the IIO core handling selects SMI330_ALL_CHAN_MSK (smallest available mask that
is superset of what we asked for) and sets active_scan_mask to that.  The driver
follows what active_scan_mask specifies and passes all channel data via
the iio_push_to_buffers*() call. The demux in the IIO core than takes that
'scan' and repacks it so that userspace receives just the data it asked for
formatting exactly as the driver would have done it if you had handled
each channels separately in the driver.

So the aim is that userspace never knows anything about this.  Just set
what channels you want and get that data. 

Jonathan


> 
> >
> >The handling the core code is reasonably sophisticated and will use bulk
> >copying where appropriate.
> >
> >If there is a strong reason to not use that, add a comment here so we don't
> >have anyone 'fix' this code in future.
> >  
> >> +	}
> >> +
> >> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf,
> >> +pf->timestamp);
> >> +
> >> +out:
> >> +	iio_trigger_notify_done(indio_dev->trig);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}  
> 
> 


