Return-Path: <linux-iio+bounces-25235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE9BED40E
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1716319A696F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB8246BB2;
	Sat, 18 Oct 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYtZSTuo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166E22F772;
	Sat, 18 Oct 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806196; cv=none; b=sK4O8EIpC/4a14nSrDg/vBOLdjlt9G0OVkIQYzkdpUka6VwxR7ZrA2TkxbHMXCORDx/DrRJwoBGQwSfhPtBfKqsxeLJItTxgmFGUDYbHfBuGfzyQgL/Wprl4vfL4h7gOFq2DNnW8Q2g4v6IAGv6kRSK/tADemT1f1gGr9HTerhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806196; c=relaxed/simple;
	bh=f8gC70FCc5N3kSFrstUNj4iCHhGav7+nLwm07B2ZIKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrF35+6P9gTHYjDSMJNNQpCMKyhzv4tG2BlqIV1SZ2lPcondfn7mkhBWAyWiurr06szbbRCEopcFePUwt0Xd9pAyDf1JJmD/zAGCY7mmMvoJq5ygWSDIDX+P4YV7SXyPm78JebyI3/7LOuroXDssKt+9p79/4FEdKi7nvRzaIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYtZSTuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743FFC4CEF8;
	Sat, 18 Oct 2025 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760806195;
	bh=f8gC70FCc5N3kSFrstUNj4iCHhGav7+nLwm07B2ZIKE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cYtZSTuoITaYKdjbYKGiySiEWUMvyOUpd/TShUe+ihBLavej7snj0KL2XoA4uT8Z7
	 Jxuov4r5G360nzymB+6OPLVE6KsauahOIHbEiUU9v81aOvXUW79ENGxyuq5lU30y9N
	 BSYBTq3xBtsscwunUuP4GQfHA+qlgH4dijpuK0qCyE/R2G3QfsExLtavouBSEG+dY+
	 E1CnO+A0Yh2YOEiBqpNyIuWBVVkHA+pv5JoJL6jdyDp/LcvNntuFb12WHG7B9wn3xj
	 B217zuaalBt9mAzDPWNj/rL3Be6/UPRPNeoVVlri3kGZWvo/Ptj2eWlpWs6EoH1rQb
	 bh/+Crsjpau3Q==
Date: Sat, 18 Oct 2025 17:49:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test
 robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: adc: ti_am335x_adc: Limit step_avg to valid
 range for gcc complains
Message-ID: <20251018174949.36946cd9@jic23-huawei>
In-Reply-To: <d5e5e8cbbc9354ca1dd4745253df6cde07822325.1760433015.git.xiaopei01@kylinos.cn>
References: <d5e5e8cbbc9354ca1dd4745253df6cde07822325.1760433015.git.xiaopei01@kylinos.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 17:12:50 +0800
Pei Xiao <xiaopei01@kylinos.cn> wrote:

> FIELD_PREP() checks that a value fits into the available bitfield, add a
> check for step_avg to fix gcc complains.
> 
> which gcc complains about:
>   drivers/iio/adc/ti_am335x_adc.c: In function 'tiadc_step_config':
>   include/linux/compiler_types.h:572:38: error: call to
> '__compiletime_assert_491' declared with attribute error: FIELD_PREP: value
> too large for the field include/linux/mfd/ti_am335x_tscadc.h:58:29: note:
> in expansion of macro 'FIELD_PREP'
>     #define STEPCONFIG_AVG(val) FIELD_PREP(GENMASK(4, 2), (val))
>                                 ^~~~~~~~~~
> drivers/iio/adc/ti_am335x_adc.c:127:17: note: in expansion of macro 'STEPCONFIG_AVG'
> 	stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1)
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510102117.Jqxrw1vF-lkp@intel.com/
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Given it is a false positive warning I've not queued this up as a fix, but
rather for the next merge window.  If people think it is more urgent that that
then reply to let me know.

Applied to the togreg branch of iio.git and pushed out as testing to see if
we get an autobuilder warnings.

Thanks,

Jonathan

> ---
> changes in v2: use '<=',adc_dev->step_avg[i]'s max value is STEPCONFIG_AVG_16
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 99f274adc870..a1a28584de93 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -123,7 +123,7 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>  
>  		chan = adc_dev->channel_line[i];
>  
> -		if (adc_dev->step_avg[i])
> +		if (adc_dev->step_avg[i] && adc_dev->step_avg[i] <= STEPCONFIG_AVG_16)
>  			stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
>  				     STEPCONFIG_FIFO1;
>  		else


