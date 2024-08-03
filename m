Return-Path: <linux-iio+bounces-8191-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D062294696B
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB71F218A3
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F451369AE;
	Sat,  3 Aug 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkEMJqwt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A184A2F;
	Sat,  3 Aug 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722683866; cv=none; b=TiMupPMYf3mBX5ET4aP3li7YR0W0Y2qUIkuUG2MZjLdvlgY6DkVKOXfxYSh3oow/DCTCjws1pcd6oMK010drNKp1bNqO5MicHBhGSLp2V6gwqwHBGdXw67oWe60LMpk3o06mdsjds68bhgelnqHN1jvWHIlH1GJ+iAh1Yy5VU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722683866; c=relaxed/simple;
	bh=5/DsQtu3T1y/O8PIz5TS2XxabxQtX1xtMM7KNbFl4Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdsoXvbIZaz5bq0+Mx4i5vDgOg7RNLCUwMsCnofL2Reuu2LD4P1AGrGrUBY8horbCbh16WzsfgN294+tzhsfqY9wO62EAB21RxhOrlp8HnbCdxfUeCpWh/QaXkFrMHrQnyQDRJ+/oCUAivwILEKpCknPw41I7vQNXnglfc8zwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkEMJqwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA12C116B1;
	Sat,  3 Aug 2024 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722683865;
	bh=5/DsQtu3T1y/O8PIz5TS2XxabxQtX1xtMM7KNbFl4Jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OkEMJqwtIC8x7UokMCIy/6YiKHgjZxnz1CQJ2dtAposfloCklhkz3D1j9o1U2h2Hy
	 B5PFCi4ydtkqaZYp8N4ibe64K+lp8zQuTIkO+Vy46E4tQKud8Q1RvZL/9GEdR7zhIK
	 ae9k/rSz8qZEZsd795UyDF+Ra3La8jDadLKnjflYun925r1PllzEboU4twrOZbTdiR
	 mKOORmkiDjrny7i7R6eFje1rJDrONRuCy5cATBMyyc9oDFjO+0uYQz7Tyw9SuL2/6a
	 muvxIjbEMkVwnRowzZe6rke+/bQsY4NgJx57mDCOlsNcN+zEpWtVtxFUZflAJUC3U7
	 axp7uT7Qrr7ug==
Date: Sat, 3 Aug 2024 12:17:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Anand
 Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Michal Simek
 <michal.simek@amd.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel
 Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: xilinx-ams: use device_* to iterate over
 device child nodes
Message-ID: <20240803121734.25f0863b@jic23-huawei>
In-Reply-To: <20240801-device_child_node_access-v1-3-ddfa21bef6f2@gmail.com>
References: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
	<20240801-device_child_node_access-v1-3-ddfa21bef6f2@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Aug 2024 08:13:52 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Use `device_for_each_child_node_scoped()` in `ams_parse_firmware()`
> to explicitly state device child node access, and simplify the child
> node handling as it is not required outside the loop.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/adc/xilinx-ams.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index f051358d6b50..27d5e4a6f9d6 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1275,7 +1275,6 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>  	struct ams *ams = iio_priv(indio_dev);
>  	struct iio_chan_spec *ams_channels, *dev_channels;
>  	struct device *dev = indio_dev->dev.parent;
> -	struct fwnode_handle *child = NULL;
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	size_t ams_size;
>  	int ret, ch_cnt = 0, i, rising_off, falling_off;
> @@ -1297,13 +1296,11 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>  		num_channels += ret;
>  	}
>  
> -	fwnode_for_each_child_node(fwnode, child) {
> +	device_for_each_child_node_scoped(dev, child) {
>  		if (fwnode_device_is_available(child)) {
This is fun.  should have been fwnode_for_each_available_child_node()
in the first place rather than iterating over all nodes, and only
doing stuff for the available ones.

Can use the device_for_each_child_node_scoped() but that only includes
available nodes anyway, so my understanding is that we can also drop
this if statement as it will always be true.


>  			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
> -			if (ret < 0) {
> -				fwnode_handle_put(child);
> +			if (ret < 0)
>  				return ret;
> -			}
>  
>  			num_channels += ret;
>  		}
> 


