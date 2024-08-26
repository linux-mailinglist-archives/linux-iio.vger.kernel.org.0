Return-Path: <linux-iio+bounces-8797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E692F95EF13
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E5FB23366
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2024 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3D155A5B;
	Mon, 26 Aug 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzMhNFqN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013DB15099D;
	Mon, 26 Aug 2024 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669561; cv=none; b=MfrNT2WNaZHGko4K0duiKgXTO05VQxNGC1IfRRGcQb4GSoqWiMwy8SKsfukX8v0AryRQJalYRCeQEbSnUVLtl/rCTq31tFFIsnAHGHaeWDgGDzINNQngRYURwsFBVFt8MqVyJMEwu9Wx8djHzZz7CzIfzQGp4aYX1IBwSa/Bl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669561; c=relaxed/simple;
	bh=q02QQHNSPXQ2BpaRfA4j+Kddrd7KJZ3iKb/VL/LUe64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OivXkzExIe7Ip+0fzgY/6quGz9tkNo3VQKcHuU7K7DQ7mSmPMDwaILnY+xpC1FmYZsFg2Sb0f8nli7JxTmjSq0itkbEhIFZHBW57Tl93K24ZgOrAaDqMh7uQaTm2KDnm3uwZtid7jCUkFmXxbeLFqDwtl9LbN+Y6pfE1oP0SbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzMhNFqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84929C51436;
	Mon, 26 Aug 2024 10:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724669560;
	bh=q02QQHNSPXQ2BpaRfA4j+Kddrd7KJZ3iKb/VL/LUe64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RzMhNFqNTgXUW/aD9kPhiKSzQESHhFWTzKO1lsPgyvemBdgPR9ziewWG7UjeE0yvI
	 3xjt1snY9VHSOPdIYNC31+xjKfkuYglTzzXEMy2dPFwQfMELn/hNZU7hy/rjle3Gql
	 I2igg5bDZxyWH5fuY2XbEeWGcAz73rnGwLkChirACmu5pk1I195fiEfIQM+xz6vCdk
	 qbHA1wLOJL2uo2tWg9/pb/zudA5M68xgphYHHyEXYKTX3G8qhvntGgG1/y47dac8IX
	 xw3/8mAYnLLlI4AISai9aNq09yDclODd/kbTzDMKo/ayGrlSBhXgsT96BBQn0D9jEN
	 Q4QfBlmjRl89w==
Date: Mon, 26 Aug 2024 11:52:26 +0100
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
Subject: Re: [PATCH v3 1/2] iio: adc: xilinx-ams: use device_* to iterate
 over device child nodes
Message-ID: <20240826115226.43027f1b@jic23-huawei>
In-Reply-To: <20240820-device_child_node_access-v3-1-1ee09bdedb9e@gmail.com>
References: <20240820-device_child_node_access-v3-0-1ee09bdedb9e@gmail.com>
	<20240820-device_child_node_access-v3-1-1ee09bdedb9e@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 21:02:26 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Use `device_for_each_child_node_scoped()` in `ams_parse_firmware()`
> to explicitly state device child node access, and simplify the child
> node handling as it is not required outside the loop.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied, but I would ideally still like one of the xilinx folk
others familiar with this driver to take a look.  It'll be a
few days before this ends up in next anyway as I need to rebase
after Greg (hopefully) takes the pull request from last week.

It would be lovely to get rid of the direct fwnode usage
in here but I'm not 100% sure if there is a path that will land
on a disabled fwnode.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/xilinx-ams.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index f051358d6b50..ebc583b07e0c 100644
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
> @@ -1297,16 +1296,12 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>  		num_channels += ret;
>  	}
>  
> -	fwnode_for_each_child_node(fwnode, child) {
> -		if (fwnode_device_is_available(child)) {
> -			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
> -			if (ret < 0) {
> -				fwnode_handle_put(child);
> -				return ret;
> -			}
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
> +		if (ret < 0)
> +			return ret;
>  
> -			num_channels += ret;
> -		}
> +		num_channels += ret;
>  	}
>  
>  	for (i = 0; i < num_channels; i++) {
> 


