Return-Path: <linux-iio+bounces-8401-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3860C94DC56
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D2F1F21CB0
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 10:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECB8157472;
	Sat, 10 Aug 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNGzBp/N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965332F2A;
	Sat, 10 Aug 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723286342; cv=none; b=Oyen8DdsHpGV0SHyzcef4tXE3M/H4XkQuafUYToIccPbtQGknldoYlzIy+EDHjc5IMhRKei2vJY/h9j0K7h6iQEA/puMWY5XZt/bY5/kYxHHUM/zYfq+MdU0oEQP0YgY2+l/A9cdxfz9Sy+gXTHGIBLL8d5gWmFUjO055lvASWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723286342; c=relaxed/simple;
	bh=0vNqomN9bAeuns1PhwCNV03ItP9jYxldk/oGAUya2VE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5I9peVq03qlL3pNdEVSKsvvdO8d9E4N+sPwpsw7tr0MSPJAUXZt7St6yh6UW16NzqfKHzqZnDorxEBY/jf6LF8wlvLgb9iXoTI/UVpEd5GE8sSTNeajyagcWEH/zyLiZxnzfHq3qgzN5cVJ/Z05gD0IAhdA7dQC2kcBQXgZFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNGzBp/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113BBC32781;
	Sat, 10 Aug 2024 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723286342;
	bh=0vNqomN9bAeuns1PhwCNV03ItP9jYxldk/oGAUya2VE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNGzBp/N7wVNNWQDT4wB6QREkJiXMPcaxhq+iaCXcPWGns2Q/heV84nWyQSJYMDoM
	 nPc8EXCFXC0La/XVWTjXw/IUGyfLev/ndDq/UHCVL0glLGcU3Di0tbYZxMQMrRRNLi
	 cctTTLqA9P7xZLXidBx7SGTpo4R6F/z6m3kHxQcMF1+Pg8KJ0nomtKrxT/T6wpPLIf
	 oYF81fNCqx2qEBM7f0hDHdPUTaJe+amWiSQX7JTHrmj/niA4dRw4RYLKU4/yDkSjEn
	 FzccGrcjALyocLX11Iht5cfjYa91qRCeehfjeu9w/hXPpUPPy0ZnDFl4mF7u18XhNU
	 8aDx+2bAJHprQ==
Date: Sat, 10 Aug 2024 11:38:55 +0100
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
Subject: Re: [PATCH v2 2/3] iio: adc: xilinx-ams: use device_* to iterate
 over device child nodes
Message-ID: <20240810113855.691dfb6d@jic23-huawei>
In-Reply-To: <20240808-device_child_node_access-v2-2-fc757cc76650@gmail.com>
References: <20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com>
	<20240808-device_child_node_access-v2-2-fc757cc76650@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 08 Aug 2024 17:12:38 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Use `device_for_each_child_node_scoped()` in `ams_parse_firmware()`
> to explicitly state device child node access, and simplify the child
> node handling as it is not required outside the loop.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

One follow up question for those familiar with the driver.
Why do we check if the main device is available?
	if (fwnode_device_is_available(fwnode)) {
		ret = ams_init_module(indio_dev, fwnode, ams_channels);
		if (ret < 0)
			return ret;

		num_channels += ret;
	}


How is the platform device driver probed if it's not available?

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


