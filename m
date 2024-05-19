Return-Path: <linux-iio+bounces-5127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692C8C95BD
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 20:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A973E1C20AD6
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 18:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB414AEFA;
	Sun, 19 May 2024 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPcl4mgx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576D50297;
	Sun, 19 May 2024 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716141799; cv=none; b=hFxTj+GQlK9fO4ZV7zvfX28V5zHLYUifQTIfpAn9mM8JtnjRDQskVe3isgituKJeS0gyKg7Fp6mk2wlXPSwueQkABJhJoQTrPN1PjdUAcH9RHTud3HwrVDXoDdPcUYFec+WPLaLk1N8saRaDCFqNnnROGpJecN3bSw38uG501/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716141799; c=relaxed/simple;
	bh=5u6Kmcb4zUJUkge3R6Zf3jnoUhdhS8dKOk/lRvZwtr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNyuNrxmHgkuaDJ1dkqrOkbF5Qnw4yLZJcztWMIfO0a6C+HamYX+oV+jIrfi6QkJXTw5GNoC7Xk+WpiizFhkU7081N24/xktKKbP84qIeHWFLEqocBxWnt7LB+kOh6F2ewlykIicagiZKJZyvVSmoip3Yc4Km+z82DOOl78wX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPcl4mgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C96C32781;
	Sun, 19 May 2024 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716141799;
	bh=5u6Kmcb4zUJUkge3R6Zf3jnoUhdhS8dKOk/lRvZwtr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aPcl4mgx9k+AqW33OPBHRdbwX1+oRl5B1JmVzba/Msx02oIK1/KfsvJIgsffkhHQI
	 q7np+UrzlgrLu6rA0HljgzBFpNocYvWvmpaZR2DbP4RgD4zaTJ3OiCpT6bjkumGjrg
	 bcq73b/erZQ3XXkTo9cxVb/QtHsi8+yeAh2WzaBdehQVtzbuvUDvy4h2tEi060nF9M
	 X3QOH8kWW1Psp9Dgtgqcdp3BKnHmHHVGgcbfeTkLMy+CFb8uwZWTFgjnURj7kNR9Mk
	 anQW58k56xU7FNUkiRWpyAroeJdkwrp2jDq1aDK653iAQf9+zlZaMXDT3J0DEQm8y+
	 0VDFncskOrh6A==
Date: Sun, 19 May 2024 19:03:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, nuno.sa@analog.com,
 marcelo.schmitt@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com,
 okan.sahin@analog.com, fr0st61te@gmail.com, alisa.roman@analog.com,
 marcus.folkesson@gmail.com, schnelle@linux.ibm.com, liambeguin@gmail.com
Subject: Re: [PATCH v8 6/6] iio: adc: ad7192: Add AD7194 support
Message-ID: <20240519190304.4d93530a@jic23-huawei>
In-Reply-To: <ZkNijKz0N7PPvmeU@smile.fi.intel.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
	<20240514120222.56488-7-alisa.roman@analog.com>
	<ZkNijKz0N7PPvmeU@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 16:09:32 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Tue, May 14, 2024 at 03:02:22PM +0300, Alisa-Dariana Roman wrote:
> > Unlike the other AD719Xs, AD7194 has configurable channels. The user can
> > dynamically configure them in the devicetree.
> > 
> > Add sigma_delta_info member to chip_info structure. Since AD7194 is the
> > only chip that has no channel sequencer, num_slots should remain
> > undefined.
> > 
> > Also modify config AD7192 description for better scaling.  
> 
> Some non-critical, mostly style related comments below.
> 
Tweaked a bit. And applied.  Please check the result in the testing branch
of iio.git.
> ...
> 
> This...
> 
> > +#define AD7194_CH(p)		(BIT(10) | AD7194_CH_POS(p))
> > +				  /* 10th bit corresponds to CON18(Pseudo) */  
> 
> ...should be (you have broken indentation on the comment, btw):
> 
> /* 10th bit corresponds to CON18(Pseudo) */
> #define AD7194_CH(p)		(BIT(10) | AD7194_CH_POS(p))
> 
> But no need to resend because of this, let's wait others to comment, and
> if everything fine I think Jonathan can massage this when applying.

Fixed.

> 
> ...
> 
> > +#define AD7194_CH_TEMP		0x100 /* Temp sensor */  
> 
> Not sure that the comment has any value here.
Dropped

> 
> ...
> 
> > +static int ad7194_validate_ain_channel(struct device *dev, u32 ain)
> > +{
> > +	if (!in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Invalid AIN channel: %u\n", ain);
> > +
> > +	return 0;  
> 
> While this uses traditional pattern, it might be better looking in a form of
> 
> 	if (in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR))
> 		return 0;
> 
> 	return dev_err_probe(dev, -EINVAL, "Invalid AIN channel: %u\n", ain);
> 
> But at the same time I would rather expect this to be in the caller and here
> to have a boolean function
> 
Moved it.

> static bool ad7194_is_ain_channel_valid(struct device *dev, u32 ain)
> {
> 	return in_range(ain, AD7194_CH_AIN_START, AD7194_CH_AIN_NR);
> }
> 
> > +}  
> 
> ...
> 
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Too many channels: %u\n", num_channels);  
> 
> 		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n", num_channels);
> 
> ?
> 
> Or with limit
> 
> 		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> 				     num_channels);
> 
> 
This one.
> ...
> 
> > +	ad7194_channels = devm_kcalloc(dev, num_channels,
> > +				       sizeof(*ad7194_channels), GFP_KERNEL);  
> 
> 	ad7194_channels = devm_kcalloc(dev, num_channels, sizeof(*ad7194_channels), GFP_KERNEL);
> 
> ?
> 
> Or
> 
> 	ad7194_channels = devm_kcalloc(dev, num_channels, sizeof(*ad7194_channels),
> 				       GFP_KERNEL);
Nope. too long in either case.

> 
> ?
> 
> ...
> 
> > +	device_for_each_child_node_scoped(dev, child) {
> > +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> > +						     ain, ARRAY_SIZE(ain));
> > +		if (ret == 0) {  
> 
> And here I would rather go for the traditional pattern, i.e.
> 
> 		if (ret) {
> 			...
> 		} else {
> 			...
> 		}
It's odd, as it's two good paths I've left this one alone.

> 
> > +			ret = ad7194_validate_ain_channel(dev, ain[0]);
> > +			if (ret)
> > +				return ret;
> > +
> > +			ret = ad7194_validate_ain_channel(dev, ain[1]);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*ad7194_channels = ad7194_chan_diff;
> > +			ad7194_channels->scan_index = index++;
> > +			ad7194_channels->channel = ain[0];
> > +			ad7194_channels->channel2 = ain[1];
> > +			ad7194_channels->address = AD7194_DIFF_CH(ain[0], ain[1]);
> > +		} else {
> > +			ret = fwnode_property_read_u32(child, "single-channel",
> > +						       &ain[0]);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret,
> > +						     "Missing channel property\n");
> > +
> > +			ret = ad7194_validate_ain_channel(dev, ain[0]);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*ad7194_channels = ad7194_chan;
> > +			ad7194_channels->scan_index = index++;
> > +			ad7194_channels->channel = ain[0];
> > +			ad7194_channels->address = AD7194_CH(ain[0]);
> > +		}
> > +		ad7194_channels++;
> > +	}  
> 


