Return-Path: <linux-iio+bounces-9839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 800DC989041
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 18:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD691F21B50
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ECD1386D7;
	Sat, 28 Sep 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZHywS7j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379B745F2;
	Sat, 28 Sep 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539951; cv=none; b=Khor4RjZoowVc4pgng//3EeYMcku/v0kx1Q/IWmjQRU8vylC8i/qeU5DzYqtonBjvsaZ+OR0BU6K8cGH/qrp/2uWpLLJygo+CFMY/FnJVRPsAojc+stVCvbgaercC420uMzHst6BkwZpbMUUp0X2r0TK/KMNVD5hS0kAoD9HxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539951; c=relaxed/simple;
	bh=BErWKprwREgDwHntZmseaJzl32ICJ1D6tLLRQbjKn4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvhA/blMJ8crPHQddH1RF+7YVV+cGMb+tzOslzhUSSJr4gPyexIhO8XAOmcuTEnTDN12+Nd4ZL7+80hmHk0zV4SmdBdri8COHYECQOnO9wJh083qA2JckMliElq7e/UxBQhpp0M3ypVuQ8Ut4ZdTUdxbrHFyE6Q4b70hR80R09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZHywS7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD7EC4CEC3;
	Sat, 28 Sep 2024 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727539951;
	bh=BErWKprwREgDwHntZmseaJzl32ICJ1D6tLLRQbjKn4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KZHywS7jUKIsqJeTZkcYniJvlwCF96GXvFvw8WhUZCrQ8ykRinYz6exvxsPREtIX6
	 saWGhzdrNSw2t7xvCIrjWIsopQIjls9WT5NXD4PjDVUc2yRAtBCDSpGWjBq1ocaoL9
	 aNhOTKwgTspjYs1Ou5D5nxZ8jriMI7C2vCVKPP9YKZ7MvAyupLhg8HhI4Z4Z4ab2h7
	 WckTia1Pf2u76Lk3VYC5VR+VFY1Elf+PgWW5bI4gYjYEMtN2g05qdS4gsUO9X4jwzZ
	 NMLAAmdobrMym9OanEUYAa/V3P9kpjuaG2RDOSh9xMeMqKSNx0FDlp9JVuFLgFddgB
	 wwlsTdwdy91CQ==
Date: Sat, 28 Sep 2024 17:12:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 01/10] iio: light: veml6030: fix ALS sensor
 resolution
Message-ID: <20240928171221.2b57638d@jic23-huawei>
In-Reply-To: <20240923-veml6035-v2-1-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
	<20240923-veml6035-v2-1-58c72a0df31c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 00:17:49 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The driver still uses the sensor resolution provided in the datasheet
> until Rev. 1.6, 28-Apr-2022, which was updated with Rev 1.7,
> 28-Nov-2023. The original ambient light resolution has been updated from
> 0.0036 lx/ct to 0.0042 lx/ct, which is the value that can be found in
> the current device datasheet.
> 
> Update the default resolution for IT = 100 ms and GAIN = 1/8 from the
> original 4608 mlux/cnt to the current value from the "Resolution and
> maximum detection range" table (Application Note 84367, page 5), 5376
> mlux/cnt.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied this patch to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/light/veml6030.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 4c436c5e0787..a3dfe56b7eec 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -780,7 +780,7 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
>  
>  	/* Cache currently active measurement parameters */
>  	data->cur_gain = 3;
> -	data->cur_resolution = 4608;
> +	data->cur_resolution = 5376;
>  	data->cur_integration_time = 3;
>  
>  	return ret;
> 


