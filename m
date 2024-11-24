Return-Path: <linux-iio+bounces-12616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251F39D77E7
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 20:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB22B224F5
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140C313D8A0;
	Sun, 24 Nov 2024 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfSIc26D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35468472;
	Sun, 24 Nov 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732476021; cv=none; b=hmvGdDOTIP6fUUcz6uCjaRoixT8NMtOvcXZHahw4UWH3JJmDfMmSA+a+pJXBOtzH5nznjeoF9iR7uksJC92gLdmmYll+mhnGDBxg/Wb8HpBLMWQDKetmzYt9uv11IsnJEEv1x2PWBik/TanyN4hIbr3CI9/2NeylNW1rBWllHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732476021; c=relaxed/simple;
	bh=kURWdOoDdQMTjPxYVyyXSdXenPGV0w5RM1QJmlvovx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhyEOBIXyXqyCcWKN6CXKcmKnO6qKjbGlhTx21VxH4siO4njHxo0Nc4zIJnOJ5i5KpU/t1nefM3mDEIAH5mhl/hUYlC2RYFw18AlRd1kQ6speGjsOqu+JsqO0QGRWeJ7Itv2ihZagqW52mzP9igxu54ldLuPQClnipzfFl7CM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfSIc26D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2564C4CECC;
	Sun, 24 Nov 2024 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732476021;
	bh=kURWdOoDdQMTjPxYVyyXSdXenPGV0w5RM1QJmlvovx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfSIc26DUoQyOzo/iYsNPW/6iv1vDMPJ+T1LB/NzIckNxz2+uHmCVXSvEwlykPakU
	 yB4mRY/BcAbE4SWNYSj6o8srAb9Am+IpubzZimt3pMDXYtGAy3agfgjV4c1kYgt/iK
	 Wn/RGYsZvu87IVIAdsrpwFvi6ZBOmX3ela+hXvgKkd+K/EAjuysp1mrRxdadiAPppb
	 kAr8glnrHKQDYE5ZYmPAzhZfuS6bNQUWnFR5jg7Mt5wwM+Y7fWaBninUVxfr4BEvwV
	 je65pO7FLoj/DJbtCbD6inJxAmjpmGyCrwW8p3Yb7IA0PXNTGrVzwIolhnRJb+Iv8f
	 QEiHL45MrlJsg==
Date: Sun, 24 Nov 2024 19:20:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Ranquet <granquet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: add calibration support
Message-ID: <20241124192015.0f1b069e@jic23-huawei>
In-Reply-To: <20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com>
References: <20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 11:12:00 +0100
Guillaume Ranquet <granquet@baylibre.com> wrote:

> The ad7173 family of chips has up to four calibration modes.
> 
> Internal zero scale: removes ADC core offset errors.
> Internal full scale: removes ADC core gain errors.
> System zero scale: reduces offset error to the order of channel noise.
> System full scale: reduces gain error to the order of channel noise.
> 
> All voltage channels will undergo an internal zero/full scale
> calibration at bootup.
> 
> System zero/full scale can be done after bootup using the newly created
> iio interface 'sys_calibration' and 'sys_calibration_mode'
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
> Calibration on the ad7173 family is the same as on the ad7192 family of
> chips and mostly uses the ad_sigma_delta common code.
The documentation in sysfs-bus-iio-adc-ad7192 needs promoting.
It is still fairly devices specific though.
Maybe we need a 
sysfs-bus-iio-adc-ad ?

Note that documentation can only be in one file for a given attribute
or the docs build system complains.

Other than that, looks good to me.

Jonathan

