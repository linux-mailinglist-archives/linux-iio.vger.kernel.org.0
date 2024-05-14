Return-Path: <linux-iio+bounces-5045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0468C569D
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 15:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294AD1F23960
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167FE1428E6;
	Tue, 14 May 2024 13:09:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F26DCE8;
	Tue, 14 May 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692182; cv=none; b=p2zH494owuw56xCF4oqvq78zymJ5p638tb+6lUM8QKJzH9cg3DPSfTidIJk1rrRRO6N0CUcz6OlG8sOZLO+4WH6CqgEx8kILmWd/VZT8NGeorzps6zACzh0GEjZ2pL3Bw71qsBtnUWnj9v95x6l2ydET2MRgKQMJJcZ0dNEWMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692182; c=relaxed/simple;
	bh=bSDbNE0FvS5utQeH0zRsryZzZ0j3KAxp2J5ZDyj6wUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcZ7Q3NsVHlLDcyGdrRfTPJlEc/69gAmS9w+NuhP3MRsvf/85Yn38AnIY5Y3I/xcUCxxrguR3DBaAU4D0mqawQJ53j3A6ZSBITU/QwQeTAkynyA5Vqper7TeRa0+jX6+euncclz6NsBAjHdJ22xP0ITwy1SFNt4AZN9Kfr++Fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 4LX+oYvZQrqLZJGE8pUZTg==
X-CSE-MsgGUID: +2JRT6duRMKoVr08927jbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="15509291"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="15509291"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 06:09:40 -0700
X-CSE-ConnectionGUID: 54Qh+E3TRlCZjde8Q+yg8Q==
X-CSE-MsgGUID: yg7Pq/faQw2bfaQjPnS9Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="35440185"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 06:09:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s6ruO-00000007R9A-3LOw;
	Tue, 14 May 2024 16:09:32 +0300
Date: Tue, 14 May 2024 16:09:32 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, jic23@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, nuno.sa@analog.com,
	marcelo.schmitt@analog.com, bigunclemax@gmail.com,
	dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
	alisa.roman@analog.com, marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com, liambeguin@gmail.com
Subject: Re: [PATCH v8 6/6] iio: adc: ad7192: Add AD7194 support
Message-ID: <ZkNijKz0N7PPvmeU@smile.fi.intel.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
 <20240514120222.56488-7-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514120222.56488-7-alisa.roman@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 14, 2024 at 03:02:22PM +0300, Alisa-Dariana Roman wrote:
> Unlike the other AD719Xs, AD7194 has configurable channels. The user can
> dynamically configure them in the devicetree.
> 
> Add sigma_delta_info member to chip_info structure. Since AD7194 is the
> only chip that has no channel sequencer, num_slots should remain
> undefined.
> 
> Also modify config AD7192 description for better scaling.

Some non-critical, mostly style related comments below.

...

This...

> +#define AD7194_CH(p)		(BIT(10) | AD7194_CH_POS(p))
> +				  /* 10th bit corresponds to CON18(Pseudo) */

...should be (you have broken indentation on the comment, btw):

/* 10th bit corresponds to CON18(Pseudo) */
#define AD7194_CH(p)		(BIT(10) | AD7194_CH_POS(p))

But no need to resend because of this, let's wait others to comment, and
if everything fine I think Jonathan can massage this when applying.

...

> +#define AD7194_CH_TEMP		0x100 /* Temp sensor */

Not sure that the comment has any value here.

...

> +static int ad7194_validate_ain_channel(struct device *dev, u32 ain)
> +{
> +	if (!in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid AIN channel: %u\n", ain);
> +
> +	return 0;

While this uses traditional pattern, it might be better looking in a form of

	if (in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
		return 0;

	return dev_err_probe(dev, -EINVAL, "Invalid AIN channel: %u\n", ain);

But at the same time I would rather expect this to be in the caller and here
to have a boolean function

static bool ad7194_is_ain_channel_valid(struct device *dev, u32 ain)
{
	return in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR);
}

> +}

...

> +		return dev_err_probe(dev, -EINVAL,
> +				     "Too many channels: %u\n", num_channels);

		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n", num_channels);

?

Or with limit

		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
				     num_channels);


...

> +	ad7194_channels = devm_kcalloc(dev, num_channels,
> +				       sizeof(*ad7194_channels), GFP_KERNEL);

	ad7194_channels = devm_kcalloc(dev, num_channels, sizeof(*ad7194_channels), GFP_KERNEL);

?

Or

	ad7194_channels = devm_kcalloc(dev, num_channels, sizeof(*ad7194_channels),
				       GFP_KERNEL);

?

...

> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     ain, ARRAY_SIZE(ain));
> +		if (ret == 0) {

And here I would rather go for the traditional pattern, i.e.

		if (ret) {
			...
		} else {
			...
		}

> +			ret = ad7194_validate_ain_channel(dev, ain[0]);
> +			if (ret)
> +				return ret;
> +
> +			ret = ad7194_validate_ain_channel(dev, ain[1]);
> +			if (ret)
> +				return ret;
> +
> +			*ad7194_channels = ad7194_chan_diff;
> +			ad7194_channels->scan_index = index++;
> +			ad7194_channels->channel = ain[0];
> +			ad7194_channels->channel2 = ain[1];
> +			ad7194_channels->address = AD7194_DIFF_CH(ain[0], ain[1]);
> +		} else {
> +			ret = fwnode_property_read_u32(child, "single-channel",
> +						       &ain[0]);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +						     "Missing channel property\n");
> +
> +			ret = ad7194_validate_ain_channel(dev, ain[0]);
> +			if (ret)
> +				return ret;
> +
> +			*ad7194_channels = ad7194_chan;
> +			ad7194_channels->scan_index = index++;
> +			ad7194_channels->channel = ain[0];
> +			ad7194_channels->address = AD7194_CH(ain[0]);
> +		}
> +		ad7194_channels++;
> +	}

-- 
With Best Regards,
Andy Shevchenko



