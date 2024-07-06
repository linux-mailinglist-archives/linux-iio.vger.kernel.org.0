Return-Path: <linux-iio+bounces-7381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CD9292C1
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 13:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B2E1C20FBA
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8935589B;
	Sat,  6 Jul 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9urF8Cg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD13A955;
	Sat,  6 Jul 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264623; cv=none; b=FeVhjfG3C4Ht/heRFqoss7kd23inkWl/uTMbHTPuucrUy0DStBFVdlv3sb0Uf5OURkpe2NjDs/WlzINl5b0/RrQFd0lofwYjDr1K/GKUkmfIGW5z4J+ez26tc7Xht8Gvmr1Gav+x0NN5bCS6detYgPOGot3yhMWXsxPGOIMbt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264623; c=relaxed/simple;
	bh=bhjeIJQZtydYNbK7HLzzFjRiskDwIygGEMJZZ7OIMHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7/6SJwtnfxU1YP4NVx8m6Q9cR5T6gBpUcLgx3+6nnb8VpGMGc4NzObm4zfzdhNWJ7x90UPLJPVf36P6L5Cverr/P2jNFev299ddeYnJyOL7msNTSsYqBlQ9yAAwJKDctC9umD3+WrbYFfgYZU1Ba+pdXi4UbBc/NSNk0/7ToEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9urF8Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198FEC2BD10;
	Sat,  6 Jul 2024 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720264622;
	bh=bhjeIJQZtydYNbK7HLzzFjRiskDwIygGEMJZZ7OIMHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n9urF8CgOC8FmTUl38qCBtO/tNyigHKxWjxpWUa/seSYW1P5NY/SC42TL8sjruFJ0
	 c3qzeZ8Xiy9DXMYcs65rONzu0K3beThffYDNPNoQW7Ve26JkACu8DreM6krNz8pKxg
	 NW9yKNpo6v/1mdiUjtc+7hG/AU7jZ5moTPx+7crg71XcH8KPzFp0n/Sa7ERGJ8LRX1
	 z81yGYP6Rssq2QPgbQMbXpvFs5j3ab5a3+BIFu6qCXj4anTC7kYhi+O4O841hVfVIZ
	 wVcCgjaQoXz+qRbSHWcBIl0mvNGS5V1nvZ4rPzamyQ3fCVLVcQG27QEgLt9dGQ68WP
	 Nni3H+sZfKeUg==
Date: Sat, 6 Jul 2024 12:16:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Subject: Re: [PATCH 1/5] iio: adc: ad9467: support multiple channels
 calibration
Message-ID: <20240706121654.12d3bb38@jic23-huawei>
In-Reply-To: <20240704-dev-iio-ad9467-new-devs-v1-1-f1adfee921f7@analog.com>
References: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
	<20240704-dev-iio-ad9467-new-devs-v1-1-f1adfee921f7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 11:25:21 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> The calibration process mixes the support for calibrating multiple
> channels with only having one channel. Some paths do have 'num_channels'
> into account while others don't.
> 
> As of now, the driver only supports devices with one channel so the
> above is not really a problem. That said, we'll add support for devices
> with more than one channel, hence let's properly make the calibration
> process to work with it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Hi Nuno,

Not suggesting you change it here, but one place where I think
the existing code readability could be improved.

>  static int ad9467_calibrate(struct ad9467_state *st)
>  {
> -	unsigned int point, val, inv_val, cnt, inv_cnt = 0;
> +	unsigned int point, val, inv_val, cnt, inv_cnt = 0, c;

Comment on existing code. I'm not keen on mix of assignment and non
assignment in a single line of local variable declarations.
It can get hard to spot what is assigned!

>  	/*
>  	 * Half of the bitmap is for the inverted signal. The number of test
>  	 * points is the same though...
> @@ -526,11 +546,26 @@ static int ad9467_calibrate(struct ad9467_state *st)
>  		if (ret)
>  			return ret;
>  
> -		ret = iio_backend_chan_status(st->back, 0, &stat);
> -		if (ret)
> -			return ret;
> +		for (c = 0; c < st->info->num_channels; c++) {
> +			ret = iio_backend_chan_status(st->back, c, &stat);
> +			if (ret)
> +				return ret;
>  
> -		__assign_bit(point + invert * test_points, st->calib_map, stat);
> +			/*
> +			 * A point is considered valid if all channels report no
> +			 * error. If one reports an error, then we consider the
> +			 * point as invalid and we can break the loop right away.
> +			 */
> +			if (stat) {
> +				dev_dbg(dev, "Invalid point(%u, inv:%u) for CH:%u\n",
> +					point, invert, c);
> +				break;
> +			}
> +
> +			if (c == st->info->num_channels - 1)
> +				__clear_bit(point + invert * test_points,
> +					    st->calib_map);
> +		}
>  	}
>  
>  	if (!invert) {
> 


