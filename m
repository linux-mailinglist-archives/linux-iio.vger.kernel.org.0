Return-Path: <linux-iio+bounces-21780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFAB0B10E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAF1189A050
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD021C165;
	Sat, 19 Jul 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsy82JPl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4D42AA4;
	Sat, 19 Jul 2025 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752945568; cv=none; b=LJxzw/Z2Fv3ARDtbm5nBye3EWJHCtFFSrm5r1yu4U5RpTAZuJfHY7RUzOvq4nzL+FI7Wmq2QfTYvAjGWc2PPUbTXMuHsWy3/OTG9+b3uUAswZ4lNPnMqQ9nLmD5kNDfO4Vjl6Z3DemDnxLFrBA0gZjG2Hlsf0ySjIf3vkxAHUCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752945568; c=relaxed/simple;
	bh=e5rgUdJo2dK/e+OmbOI/EEyI0Fxk0Q4aGrlatS6p2ok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUq94xyyaTOjkCdTvI6lfUxw7cnrA1ZPPUHrV8F77r1C+6/gh2jm15fK66ptwrqXa4FeMu9Ied3+SJIF+c+6fTOQ8Oqapb8ECW9qbvnwWoD5DRAxVvimUcD9doOZC7pF7yD+M9m6NkwR/TOEQeoN9s7gZeZKlpK7IiLtAXUytoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsy82JPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CD5C4CEE3;
	Sat, 19 Jul 2025 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752945567;
	bh=e5rgUdJo2dK/e+OmbOI/EEyI0Fxk0Q4aGrlatS6p2ok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lsy82JPlf8Wai9HWzJKO1NQn6YwlCKng9fQBt6r64/v8Qng6dDOKMM8omkS9D1cdr
	 Py0yF3kh5CrW3WVJgfnUSyhqsWJCoGJdQT3hJNuHDkdPigYPhkyMESUQEjwiJ0IX8i
	 U0pRV5dVS27OunE/EaSL/0fsviyeKdudIulg/C+CWeFmkg0gfO0TKH72VEoUcgNzzc
	 UD/XM2u9HtVQ4mCBrw54k1zW390nZAX0zRjUaqqRNs0vAtnNOzKtKFT2tpscjre1q7
	 vTGGVzkQeYpi1cfjS0Vz3wg6HqkdbchW2BDuP4pX5Vm8eA+Xm7TaduV+GFiEu32x8J
	 Chxuw66Q8E03Q==
Date: Sat, 19 Jul 2025 18:19:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana via B4 Relay
 <devnull+y.oudjana.protonmail.com@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: Add Qualcomm Sensor Manager driver
Message-ID: <20250719181915.499d5c4d@jic23-huawei>
In-Reply-To: <nSoiRmruHeLNNxpRCxJ5M5aQ-Vx7lE3U9wtVwYh6MVZHr0pkk9Cwl5ggSN3xAZ09zA8bk_RJS6mRAgxWkCIrNGogaElh4x8VKaQPO_Rzrqs=@protonmail.com>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
	<20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
	<20250713164033.3488db3c@jic23-huawei>
	<nSoiRmruHeLNNxpRCxJ5M5aQ-Vx7lE3U9wtVwYh6MVZHr0pkk9Cwl5ggSN3xAZ09zA8bk_RJS6mRAgxWkCIrNGogaElh4x8VKaQPO_Rzrqs=@protonmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > > +static int qcom_smgr_iio_read_raw(struct iio_dev *iio_dev,
> > > + struct iio_chan_spec const *chan, int *val,
> > > + int *val2, long mask)
> > > +{
> > > + struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
> > > +
> > > + switch (mask) {  
> > 
> > 
> > No sysfs access at all to data is unusual but not completely unheard of.  
> 
> There is no (known) method to request a single reading from the QMI
> service. The only known way to get sensor data is to send a buffering
> request to initiate sending data, then the remoteproc sends QMI
> indications at a regular interval carrying sensor data which I am
> pushing to the IIO buffers. The only way to implement direct sysfs
> access would be to store the last received value somewhere then pass
> it to sysfs when requested. This will also require enabling buffering
> if disabled at the time of reading, then waiting until new data is
> received. I didn't like this solution so I skipped direct sysfs access
> altogether. Buffer access is enough for the current use case with
> iio-sensor-proxy in userspace.

This is absolutely fine.   I have mulled in the past implementing core
code to deal with cases where we are in buffered mode but want to still
provide sysfs access.  That applies for cases like ADCs where a couple
of channels are used for a touchscreen but where there is a hardware
restriction on accessing other channels on a oneshot basis whilst streaming
data on the others.  Maybe one day we'll have that support and it will
also help here, but it's not a high priority thing.

> > > +static const struct iio_chan_spec qcom_smgr_pressure_iio_channels[] = {
> > > + {
> > > + .type = IIO_PRESSURE,
> > > + .scan_index = 0,
> > > + .scan_type = {
> > > + .sign = 'u',
> > > + .realbits = 32,
> > > + .storagebits = 32,
> > > + .endianness = IIO_LE,
> > > + },
> > > + .info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
> > > + BIT(IIO_CHAN_INFO_SAMP_FREQ)
> > > + },
> > > + {
> > > + .type = IIO_TIMESTAMP,
> > > + .channel = -1,
> > > + .scan_index = 3,  
> > 
> > 
> > Why 3?  
> 
> Because the same struct is used for this and 3-axis sensors, so we should
> skip the unused values.

I'm not sure how that is related to this value.  These are effectively monotonic
but shouldn't be used to index anything driver side.  So there is nothing
wrong with the value 3, it's just a bit odd.

> 
> >   
> > > + .scan_type = {
> > > + .sign = 'u',
> > > + .realbits = 32,  
> > 
> > 
> > If it's realbits 32 and no shift, why not store it in a 32 bit value?
> > I assume this is a hardware provided timestamp rather than typical software
> > filled in one? Anyhow, I'm not immediately spotting it being used yet
> > so for now perhaps best to drop the channel descriptions.  
> 
> The hardware (or firmware rather) passes an unsigned 32-bit timestamp
> value in a 64-bit QMI field. I was previously passing it as-is to IIO
> but now since I introduced a new struct I can make it 32-bit storagebits.
> 
> But below you said s64 for timestamp so which is it going to be?

I wasn't sure if it was a software or hardware timestamp. Given it's coming
from the QMI thing it's 'hardware' so 32 bit is correct here.

> 
> > > + {
> > > + .service = SNS_SMGR_QMI_SVC_ID,
> > > + / Found on MSM8996 and SDM660 */
> > > + .instance = QRTR_INSTANCE_CONST(1, 50)
> > > + },
> > > + { },  
> > 
> > 
> > No comma on a terminating entry like this.  
> 
> Ok. Gotta keep track of all the conventions used in different subsystems.
I'm curious - have you ever had anyone request the comma?

I know some don't care, but it seems like an odd thing to insist on.

> 
> >   
> > > +};
> > > +MODULE_DEVICE_TABLE(qrtr, qcom_smgr_qrtr_match);  

Jonathan

