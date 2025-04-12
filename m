Return-Path: <linux-iio+bounces-18001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C752A86CBF
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05FA7B36F5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895281DD9D3;
	Sat, 12 Apr 2025 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM6fDVwJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335F19F42C;
	Sat, 12 Apr 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744456897; cv=none; b=SbjdBOxKCHtbgjQGZvqoGVngLQyyMZ2DnTE4lxDTMP7RxiJ2sbChARrqFwa0vmFS3tKlOSZgeVKUMbepoQq8ZaUXG7nTvNr5B7DINxRR4kkJ3PJ4kfhJ9vhEBaHe1IdZnaH2CJEPSRCkLKPRCcGj2284O5XMAsyuXy5spIFTa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744456897; c=relaxed/simple;
	bh=YfOlKE6PAfGsLaLJzFsbc4yvi3sBWRZ8irx5t8xPNqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZmwwwDCtwNviyZlFtvJnQB7H/OL+xbGBO65b4tXLX6rGCug4jKdLQtBNb341maYfgyboymTp5cQV3UpMu7H6wDvlKR3Jb9DPad6/lm4kd1XZAaj5aqtQfzpC78a6TfeOx9a53jRQU3x3oQoRWFgh9yTeE5ot+ktbQxjUd8ldvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM6fDVwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B17BC4CEE3;
	Sat, 12 Apr 2025 11:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744456896;
	bh=YfOlKE6PAfGsLaLJzFsbc4yvi3sBWRZ8irx5t8xPNqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oM6fDVwJXVvIiSz6YzL+sqXFarnOxeDB/V9gDHvtXh2pStzqt+qSSOGhrDe39m8r1
	 QN91NiF9YguPYt8vikQ7haD+S/t7MWG8OSROc3VqFDJ8/RHspiNsz/6yO6f9uw79xz
	 zi9OMDnNtNWFSNV2kaA4DE6PDZZ68BsPFDfybAdzE3TnSCS1DCu21C0wipU67YV8RK
	 udS9kl08sM77TgcPIccOuGUAKdHa90+KqG4bkTnqxCJRoW1ibn5RTeA5dQmDzTiHcR
	 Uswr9VCQZq0sUezMCh+qEXR8Ub3VMNCtso88fnhRg9Rsu8jH9CUy6Qt73d0HZSWr8g
	 pqztiNKbrLUPQ==
Date: Sat, 12 Apr 2025 12:21:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer
 <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>,
 Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis
 <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie
 wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add Qualcomm Sensor Manager drivers
Message-ID: <20250412122122.43d1b2a7@jic23-huawei>
In-Reply-To: <fc9af95b-abbf-454c-97e1-b884baa5317c@protonmail.com>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
	<20250406140706.812425-4-y.oudjana@protonmail.com>
	<20250406172904.1521881e@jic23-huawei>
	<fc9af95b-abbf-454c-97e1-b884baa5317c@protonmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> >> +
> >> +static void qcom_smgr_accel_remove(struct platform_device *pdev)  
> > 
> > I'm surprised to see a platform device here - will read on but I
> > doubt that is the way to go.  Maybe an auxbus or similar or
> > just squashing this all down to be registered directly by
> > the parent driver.  
> I got the idea from cros_ec_sensors which also deals with a similar 
> sensor hub paradigm.

Generally the use of platform drivers for subfunctions of something
is now not considered the way to go.  Here there seems to be little
point in spinning out another layer of devices.
> >   
> >> +static void qcom_smgr_buffering_report_handler(struct qmi_handle *hdl,
> >> +					       struct sockaddr_qrtr *sq,
> >> +					       struct qmi_txn *txn,
> >> +					       const void *data)
> >> +{
> >> +	struct qcom_smgr *smgr =
> >> +		container_of(hdl, struct qcom_smgr, sns_smgr_hdl);
> >> +	struct sns_smgr_buffering_report_ind *ind =
> >> +		(struct sns_smgr_buffering_report_ind *)data;  
> > 
> > Casting away a const isn't a good sign. Why do you need to do that?
> > 	const struct sns_smg_buffer_repor_ind *ind = data;
> > should be fine I think.  
> 
> The casted struct was previously not const so I was only casting from 
> void *. I made it const lately but didn't notice this cast. Will change it.

Ok. But never a reason to cast from a void *.  The C spec says that
happens implicitly just fine.

> >> +	ret = qcom_smgr_request_all_sensor_info(smgr, &smgr->sensors);
> >> +	if (ret < 0) {
> >> +		dev_err(smgr->dev, "Failed to get available sensors: %pe\n",
> >> +			ERR_PTR(ret));
> >> +		return ret;
> >> +	}
> >> +	smgr->sensor_count = ret;
> >> +
> >> +	/* Get primary and secondary sensors from each sensor ID */
> >> +	for (i = 0; i < smgr->sensor_count; i++) {
> >> +		ret = qcom_smgr_request_single_sensor_info(smgr,
> >> +							   &smgr->sensors[i]);
> >> +		if (ret < 0) {
> >> +			dev_err(smgr->dev,
> >> +				"Failed to get sensors from ID 0x%02x: %pe\n",
> >> +				smgr->sensors[i].id, ERR_PTR(ret));
> >> +			return ret;
> >> +		}
> >> +
> >> +		for (j = 0; j < smgr->sensors[i].data_type_count; j++) {
> >> +			/* Default to maximum sample rate */
> >> +			smgr->sensors[i].data_types->cur_sample_rate =
> >> +				smgr->sensors[i].data_types->max_sample_rate;
> >> +
> >> +			dev_dbg(smgr->dev, "0x%02x,%d: %s %s\n",
> >> +				smgr->sensors[i].id, j,
> >> +				smgr->sensors[i].data_types[j].vendor,
> >> +				smgr->sensors[i].data_types[j].name);
> >> +		}
> >> +
> >> +		qcom_smgr_register_sensor(smgr, &smgr->sensors[i]);  
> > Above I suggest that maybe you should just skip the platform devices and register
> > directly with IIO as you find the sensors. So have the struct iio_dev->device
> > parent directly off this one.  
> 
> As I said previously I followed the model used in cros_ec_sensors, and 
> it made sense to me since I always see platform devices used to 
> represent firmware-backed devices like this.

In this case you end up with

parent device
    |
    |____________________
    |         |          |
ChildA     ChildB       ChildC  (all platform devices)
    |         |          |
IIODevA    IIODevB      IIODEVC

Today we'd probably do those child devices using auxiliary devices but
aside from that, the only reason to do this is you want to have separate
drivers for each child.

You can just do

parent device
   |
   |_______________________
   |         |             |
IIODevA    IIODevB       IIODevC

for the case where there no separate child drivers.

That is the parent driver can just instantiate the IIO Bus Devices
directly (it's kind of a Class really but a bus for historical reasons).
Various IMUs do this when they have separately controlled sampling frequencies
for different types of sensor or even separate fifos. (They are really
sensor hubs, just connected of SPI or similar).

So it's up to you whether you want the separate per channel type devices and
to handle the potential races around those going away.
qcom_smgr_buffering_report_handler() for instance needs a lock to
stop the child driver being unbound between the checks on iio_dev and the
use of it. With one driver that complexity doesn't occur.
See for example drivers/iio/st_lsm6dsx/ that does it this way.

Also possible would be a single IIO device with multiple buffers.
We only have a few of those though so you might run into missing bits of ABI
taking that path.

Jonathan



