Return-Path: <linux-iio+bounces-7980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FD793DFDE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3937B2129F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E459D17D373;
	Sat, 27 Jul 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrA1SrV2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972541E521;
	Sat, 27 Jul 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722092797; cv=none; b=rxzxPt0UvqQnlhjP782WBtKp+63yGWUTkQilgvdd4LX0YdNQI4lZs3Oz4e8rCxkJiK/XM7LYQ8X9OuZp60VMKIu6sW0VwLZ/JuLlrUqyCVfoSQq+0sLMoUKy1gCN5vgYu3+F/XsQt6bbB6plXeAZhel4/tzself18gm5+EV6Z/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722092797; c=relaxed/simple;
	bh=cmX0UIFq01T8RRA+cBWp3yu4O50rO3JDTINipAtvJBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5NgbMyGIob3tvyC9ky253/x7acj/fZygw5+PwfuzVI0IQymGYiYkzP/VNuJCoH9g8Jy+6d9WryKFpUO/J3G5mXj+E8EOdTS4Z4oaqK1Q/2OJL0EwF1BlLhMO3BT8Vi3dkbgWcJTOCIZ13CuPIaE1/jTU1AlpzJExGlN0B/nm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrA1SrV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E00C32781;
	Sat, 27 Jul 2024 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722092797;
	bh=cmX0UIFq01T8RRA+cBWp3yu4O50rO3JDTINipAtvJBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hrA1SrV2aA6NGLwbCY1ZUooC2TyuBMPdwWRKsfu9Llfmb+Du22HeaLfhC+CLK6bZv
	 gapdPitvxtwiYSemQ/rC9VqKeXD3+rq7uMTrPNteZfgj8iFPpbOsBgAHD3wTrSImyx
	 H8i+MD31f/akcktWORjLObhjP/ByfX7gUZiSnLEiYpPct76mBRkFz3CiVBcsjNj1vL
	 6HXTJcMjdNV57KGpHPpl/Fa9vgahWqQA2WXo/TOQT7JigV4rU1dTPtVqALBfpVanJS
	 Td9t9VX/CGcCo6GFidspyM/M5SzwEUlu+XEkBOfVzx+6LZeGIr/rWRvjQdaswy5jUa
	 K+39wlV+MDWKg==
Date: Sat, 27 Jul 2024 16:06:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: wangshuaijie@awinic.com, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, waqar.hameed@axis.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V5 2/2] iio: proximity: aw9610x: Add support for aw9610x
 proximity sensor
Message-ID: <20240727160628.115e295e@jic23-huawei>
In-Reply-To: <3ef6c902-b004-4aa0-96c9-dabd81a01a6a@kernel.org>
References: <20240726061312.1371450-1-wangshuaijie@awinic.com>
	<20240726061312.1371450-3-wangshuaijie@awinic.com>
	<3ef6c902-b004-4aa0-96c9-dabd81a01a6a@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> 
> > +static int aw9610x_read_chipid(struct aw9610x *aw9610x)
> > +{
> > +	unsigned char cnt = 0;
> > +	u32 reg_val;
> > +	int ret;
> > +
> > +	while (cnt < AW_READ_CHIPID_RETRIES) {
Why retries? 
> > +		ret = aw9610x_i2c_read(aw9610x, REG_CHIPID, &reg_val);
> > +		if (ret < 0) {
> > +			cnt++;
> > +			usleep_range(2000, 3000);
> > +		} else {
> > +			reg_val = FIELD_GET(AW9610X_CHIPID_MASK, reg_val);
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (reg_val == AW9610X_CHIP_ID)
> > +		return 0;  
> 
> So devices are detectable? Encode this in the bindings (oneOf and a
> fallback compatible) and drop unneeded entry from ID tables.

Hi Krzysztof,

I think this is not a good idea.

Even though these two are detectable, this breaks if along comes a 3rd device
in the future which is truly compatible with one of these two parts but that
we don't yet know about (so can't discover). For that part we will want to
provide a meaningful fallback compatible.

It needs to fallback to either the 3 channel or the 5 channel chip and handle
it as appropriate. (Note that this difference is non obvious as right now the
code pretends there are always 5 channels and that needs fixing).

If the chips provided a register that told all the chip specific data like
how many channels, then sure making one fallback to the other would be fine
as future devices could use those standard registers.

With just an Id register, we can't discover enough.  Hence these two
parts should not be listed as compatible with each other.

Jonathan

> 
> Best regards,
> Krzysztof
> 


