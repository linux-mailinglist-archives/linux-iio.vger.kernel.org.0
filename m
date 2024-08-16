Return-Path: <linux-iio+bounces-8513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EEE954E73
	for <lists+linux-iio@lfdr.de>; Fri, 16 Aug 2024 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF161C223BA
	for <lists+linux-iio@lfdr.de>; Fri, 16 Aug 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701B01BE250;
	Fri, 16 Aug 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO9vpP9x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268EC2BB0D;
	Fri, 16 Aug 2024 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824509; cv=none; b=RzlE6nK2bP1PflvhmpOKcR5fTBHyONHla9Z+D4ErnCMQpZ+Qgwvquifj+qxQuZJZvVKO/2KFkzQt+TIV3pH30jviTI3XuGZQ2EGl2p9PM70YGIXlgXCx9aQ8hkTYLAEoqmBid6OtYV04Eveuq/391Q89YROxiXKk6M4XqYjblpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824509; c=relaxed/simple;
	bh=zo8q/X1fSRtsBnuH8fxiwu/3UwY5gwODpqavldS2UHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkoexLFBnIAyRC2s7CTKWmPS0mUHBpfW39iBCq3ayPgsTcH9QkJMy6FSBW8+mRkXs4TO4YFRuxEU2ye2ku9tU0ajvJQ759cgAuElOK3M/3TNd1TqUUAqKZ8arTgwmrZTGhTpjR4jhMf1puyDOEcU2lSd4HebSjLhtS+zfxyh58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO9vpP9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8972C32782;
	Fri, 16 Aug 2024 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723824508;
	bh=zo8q/X1fSRtsBnuH8fxiwu/3UwY5gwODpqavldS2UHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VO9vpP9xmM/M4DdRO1plyue8kafzxyFSCc9GpectRLdvDmmyQAYmSwbjUAhOC5k2u
	 mda0Ufu18I5DD1TqpWZZgMnTthB3uJZnmmpqRMM353hDyt0fxS/9WkmUtNTsItuYxg
	 mA58CQtkXF+9MmmW96kdUSxpXnuvRdxWdCe3XKgohcurM60wffbalFSybwWp75XJ1a
	 8Q8I4INVGfovM90LqwJbh+9HG+ba+90Z8QBHA9vfOB6H06ciZ1rBRHsiEoOCje5L5H
	 cq4W7bEuWgbeKKSlhbI3uYtFqCiRtOxZGoecJLP7WnJHc4TXIWdRZ3y+KqkGqHrBMW
	 u8Re3VX4L+fsg==
Date: Fri, 16 Aug 2024 17:08:15 +0100
From: Lee Jones <lee@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	Michal Simek <michal.simek@amd.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Pavel Machek <pavel@ucw.cz>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 3/3] leds: as3645a: use device_* to iterate over
 device child nodes
Message-ID: <20240816160815.GD5853@google.com>
References: <20240808-device_child_node_access-v2-0-fc757cc76650@gmail.com>
 <20240808-device_child_node_access-v2-3-fc757cc76650@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808-device_child_node_access-v2-3-fc757cc76650@gmail.com>

On Thu, 08 Aug 2024, Javier Carrasco wrote:

> Drop the manual access to the fwnode of the device to iterate over its
> child nodes. `device_for_each_child_node` macro provides direct access
> to the child nodes, and given that the `child` variable is only required
> within the loop, the scoped variant of the macro can be used.
> 
> Use the `device_for_each_child_node_scoped` macro to iterate over the
> direct child nodes of the device.
> 
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/leds/flash/leds-as3645a.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/leds/flash/leds-as3645a.c b/drivers/leds/flash/leds-as3645a.c
> index 2c6ef321b7c8..8e6abedf6e00 100644
> --- a/drivers/leds/flash/leds-as3645a.c
> +++ b/drivers/leds/flash/leds-as3645a.c
> @@ -478,14 +478,12 @@ static int as3645a_detect(struct as3645a *flash)
>  	return as3645a_write(flash, AS_BOOST_REG, AS_BOOST_CURRENT_DISABLE);
>  }
>  
> -static int as3645a_parse_node(struct as3645a *flash,
> -			      struct fwnode_handle *fwnode)
> +static int as3645a_parse_node(struct as3645a *flash, struct device *dev)

Please swap the parameters to have the more senior one (dev) at the start.

>  {
>  	struct as3645a_config *cfg = &flash->cfg;
> -	struct fwnode_handle *child;
>  	int rval;
>  
> -	fwnode_for_each_child_node(fwnode, child) {
> +	device_for_each_child_node_scoped(dev, child) {
>  		u32 id = 0;
>  
>  		fwnode_property_read_u32(child, "reg", &id);
> @@ -686,7 +684,7 @@ static int as3645a_probe(struct i2c_client *client)
>  
>  	flash->client = client;
>  
> -	rval = as3645a_parse_node(flash, dev_fwnode(&client->dev));
> +	rval = as3645a_parse_node(flash, &client->dev);
>  	if (rval < 0)
>  		return rval;
>  
> 
> -- 
> 2.43.0
> 
> 

-- 
Lee Jones [李琼斯]

