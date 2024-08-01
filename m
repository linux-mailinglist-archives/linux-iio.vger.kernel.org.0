Return-Path: <linux-iio+bounces-8130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30E294481D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39937B284F5
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652DB19FA68;
	Thu,  1 Aug 2024 09:20:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0615189529;
	Thu,  1 Aug 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504051; cv=none; b=dVlelqPQqiNP875REQjYc5SISm8obnAtoW8d5KxLJ15ywyHf1nr7/milXZzmnz4v4qe8qm3sl+O3Ul5sofSGGReN4NORo961wyeZ3D+TD11wqRyDbpuYEjokiuoPv5oQAo+9u0ZvhvIaOpx4vSn3Q8KChV7Pn2JWAk78RPF0EnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504051; c=relaxed/simple;
	bh=epR/EN6mWshA6mci1TxGN1bWxiILuDwYkacz4MLwldU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3RXfWf4P7dx4XaCjiK6U0L+y8fKQoNnGgYNN+nIOX90+Gz0Wel3LPj11vllPBL09vNT9LgEnggBb4BTKv2FjTVcurlUbzJRNSeDhA3hXS+ELGToY5qkx4L8uRfuZV764CnGD93iVj0e1gWj+/XEYc0Dg0DOExCKb9ZVt7yYepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56EB61007;
	Thu,  1 Aug 2024 02:21:08 -0700 (PDT)
Received: from [192.168.1.50] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97AB3F5A1;
	Thu,  1 Aug 2024 02:20:40 -0700 (PDT)
Message-ID: <381fd199-640a-4ca0-8d7e-1c4dae11ef7f@arm.com>
Date: Thu, 1 Aug 2024 10:20:38 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] coresight: cti: use device_* to iterate over device
 child nodes
Content-Language: en-GB
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Michal Simek <michal.simek@amd.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org
References: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
 <20240801-device_child_node_access-v1-1-ddfa21bef6f2@gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240801-device_child_node_access-v1-1-ddfa21bef6f2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/08/2024 07:13, Javier Carrasco wrote:
> Drop the manual access to the fwnode of the device to iterate over its
> child nodes. `device_for_each_child_node` macro provides direct access
> to the child nodes, and given that they are only required within the
> loop, the scoped variant of the macro can be used.
> 
> Use the `device_for_each_child_node_scoped` macro to iterate over the
> direct child nodes of the device.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   drivers/hwtracing/coresight/coresight-cti-platform.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index ccef04f27f12..d0ae10bf6128 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -416,20 +416,16 @@ static int cti_plat_create_impdef_connections(struct device *dev,
>   					      struct cti_drvdata *drvdata)
>   {
>   	int rc = 0;
> -	struct fwnode_handle *fwnode = dev_fwnode(dev);
> -	struct fwnode_handle *child = NULL;
>   
> -	if (IS_ERR_OR_NULL(fwnode))
> +	if (IS_ERR_OR_NULL(dev_fwnode(dev)))
>   		return -EINVAL;
>   
> -	fwnode_for_each_child_node(fwnode, child) {
> +	device_for_each_child_node_scoped(dev, child) {
>   		if (cti_plat_node_name_eq(child, CTI_DT_CONNS))
> -			rc = cti_plat_create_connection(dev, drvdata,
> -							child);
> +			rc = cti_plat_create_connection(dev, drvdata, child);
>   		if (rc != 0)
>   			break;

Don't we need to fwnode_handle_put(child) here, since we removed the
outer one ?

Suzuki


