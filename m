Return-Path: <linux-iio+bounces-12067-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8439C2D7B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4786D1C20FDB
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046017E01B;
	Sat,  9 Nov 2024 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjkGFap2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446B1BC3F;
	Sat,  9 Nov 2024 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731157901; cv=none; b=k8oQWR1ZkJz1yazpsvJlGVWfqt5Z3AnJWSuDir4ytxXtwAmlQgXoq0hafqBMJeKT4XkU5IamVRcT3/Kygl1TgMhJ4YCCDhVFgcZo5Vgyy2E4EYyfAgQ5UKBtMY1Ny9COWRNb+VkrzAJdTCB1MSsxFIIIgMqOmJDbNGVRWcaeafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731157901; c=relaxed/simple;
	bh=AFNJh1pbuvQOV9rLEslXmUglwcrJ/QvLbJapsp2JNnE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivT2KbpidU7wtMtbPbRKM04bpTF13vr+k998AdVAlx7AlSjvHdVXQZUYYS63c+D87wTh5+aTPnEAwCH9g2G2sO3aExk1ia8egHTIw+scfwtzzaoDacYUd5aaEbGf2Ft0Bnq8xHSISpgA4j2uaSDgR/L5ISDGAgtnkQeu/T5yS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjkGFap2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F9BC4CECE;
	Sat,  9 Nov 2024 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731157900;
	bh=AFNJh1pbuvQOV9rLEslXmUglwcrJ/QvLbJapsp2JNnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fjkGFap2ixA8LvzOPRry6ek0ZyY/GcSKqWgAFFsDHKclH8/XeWVYJWkaDQ0PSr2cc
	 fV2xwCpN/kQurAW7PtjsW8I0aL9nMgnw5ekeIp0J8BOb73dA6y7pcBH7zIgTwffgPh
	 oBnwrMSSyvO2h7oyGsBQi55loeEx0UTPYdLEzWd/llqkdQWECQHUJpnVEeZHJnjv/q
	 Tf6pS2dyb0PZyMPM+SRNrw1RaQ4VkzW+kjOd5VXwXo6pSbrWg1e3IO5eCcT47Z+Jo7
	 wdbNRHQyccxfuVY9Af1DLo01qFiB1sxBZFp6cCpGF/wRg9rNgeIdQ8Yvkg81Bec+Vv
	 egqPNoSezSOkg==
Date: Sat, 9 Nov 2024 13:11:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC
 DRIVER), imx@lists.linux.dev (open list:NXP i.MX 7D/6SX/6UL/93 AND VF610
 ADC DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v3 2/2] iio: adc: vf610_adc: limit i.MX6SX's channel
 number to 4
Message-ID: <20241109131132.6a9c8adf@jic23-huawei>
In-Reply-To: <20241107191842.3002319-2-Frank.Li@nxp.com>
References: <20241107191842.3002319-1-Frank.Li@nxp.com>
	<20241107191842.3002319-2-Frank.Li@nxp.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 14:18:41 -0500
Frank Li <Frank.Li@nxp.com> wrote:

> i.MX6SX only has 4 ADC channels, so limit channel numbers to 4 for
> compatible string 'fsl,imx6sx-adc'.
> 
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I'm pretty strongly against putting integers in the id match
data variables.  Instead use a much more easily extended structure
(which will have one element for now)

struct vf610_chip_info {
	u8 num_channels;
};

and then pointers to that structure in the tables.

The integer path regularly goes wrong (0 causes trouble with error handling)
and so I push back on people doing this in new code.

One other comment inline.

Jonathan

> ---
> compatible string 'fsl,imx6sx-adc' already document in
> Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> 
> Change from v2 to v3
> - none
> 
> Change from v1 to v2
> - Add Haibo Chen <haibo.chen@nxp.com>
> - change cast to uintptr_t to fix below warning
> 
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411052345.gyJaM3h4-lkp@intel.com/
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/iio/adc/vf610_adc.c:20:   In file included from include/linux/regulator/consumer.h:35:
>    In file included from include/linux/suspend.h:5:
>    In file included from include/linux/swap.h:9:
>    In file included from include/linux/memcontrol.h:21:
>    In file included from include/linux/mm.h:2213:
>    include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~>> drivers/iio/adc/vf610_adc.c:874:28: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'const void *' [-Wvoid-pointer-to-int-cast]
>      874 |         indio_dev->num_channels = (u32)device_get_match_data(dev);
>          |
> ---
>  drivers/iio/adc/vf610_adc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index a6a0ada8a102f..36f6132bf5ba4 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -809,7 +809,8 @@ static const struct iio_info vf610_adc_iio_info = {
>  };
>  
>  static const struct of_device_id vf610_adc_match[] = {
> -	{ .compatible = "fsl,vf610-adc", },
> +	{ .compatible = "fsl,imx6sx-adc", .data = (void *)4},
> +	{ .compatible = "fsl,vf610-adc", .data = (void *)ARRAY_SIZE(vf610_adc_iio_channels)},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, vf610_adc_match);
> @@ -870,7 +871,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	indio_dev->info = &vf610_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = vf610_adc_iio_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
> +	indio_dev->num_channels = (uintptr_t)device_get_match_data(dev);
That can in theory fail and return NULL. Which here would be interpreted
as 0 channels and probably cause trouble later.

>  
>  	vf610_adc_cfg_init(info);
>  	vf610_adc_hw_init(info);


