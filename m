Return-Path: <linux-iio+bounces-12852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30ED9DF110
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8EAF281248
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DACC1A00DF;
	Sat, 30 Nov 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDAbkxd/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42E19D084;
	Sat, 30 Nov 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732975798; cv=none; b=jntKtJG1oIEBL6wiWtfugsuq8FUZWZpUasfTMx5egDjC2qO1Ubq2fL3571JwP5bMvt9E1vTsEHax+PGOdI/JEQdM1U/lW/NhSIDv9Tl3ZpQrW6XwB6+gEI9HYxBiquTzGBLgzlSTJxxebWEMGZ1+WUgHCYlbf0fwGCCeOg+iAzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732975798; c=relaxed/simple;
	bh=EbwBj0d/76MLb2NpuUCdxmploYc+essUj85S+EBrXwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKs00mzeryq+xNGFXiHHvv4fTjAq8BB+50bTtwZDXbPVoWhMGyPjFM6/SYEk0wKQ5hLZLEmvSCClS2w7DaQyW0JLfa9Orxxj17lWClb8gDv4RHtLy/Mglf1pcPptmOTqh5ogtOXcO/RF3BWbrXlSFwl27vjaKacsAGkP1sdy9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDAbkxd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5643C4CECC;
	Sat, 30 Nov 2024 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732975797;
	bh=EbwBj0d/76MLb2NpuUCdxmploYc+essUj85S+EBrXwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CDAbkxd/A/hjyKfcKVNHo3S5mgwoETxN1J/gqh0H7y9a8DR8qfaPKdKfcZMSTExTy
	 2Oqq7kNb+T4Cnym4n6TVYdkDfjOnSEYN0qSlGHlBYnRDARHwTP4f2OSoHg1m5f7t0M
	 ISRX6D60IMUgYn2uQEUt83GZMN5cE9q/Qg95qrW/92O8KUKhwSfWvBWJhjJGKziRQb
	 zjeAlG/g014DfUpSTk8A6w0YgsJfhe2IYPimHPTYEUwJ8+NAhG6gyBWt68LShF6xeJ
	 w1jz5JwYH1sLZMgfbLz5RsBdeHUqzTGQL2lLT2xUBf1L6Qm1TBWh9qqAMJRPbaD0Pu
	 2bcWqjzqpkCUQ==
Date: Sat, 30 Nov 2024 14:09:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
 jstephan@baylibre.com, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/6] iio: adc: max1363: make use of
 iio_is_soft_ts_enabled()
Message-ID: <20241130140948.1e0f1082@jic23-huawei>
In-Reply-To: <20241130002710.18615-5-vassilisamir@gmail.com>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
	<20241130002710.18615-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 01:27:08 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Use the iio_is_soft_ts_enabled() accessor to access the value of the
> scan_timestamp. This way, it can be marked as __private when there
> are no direct accessors of it.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Hmm.  A younger me one ;) 

A simple allocation that is always big enough is going to cost
us very little.  Should almost certainly be using kzalloc.

I'd change this driver to just stick an array of size
12 * 2  + 8 so 32bytes in the iio_priv()
(12 channels, possibly of 2 bytes each + aligned timestamp)
and always use that for the rx_buf.

Both a simplification and probably a performance improvement
as well by dropping the frequent allocations.


> ---
>  drivers/iio/adc/max1363.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 9a0baea08ab6..57d9aff729f4 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1473,7 +1473,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  		d_size = numvals*2;
>  	else
>  		d_size = numvals;
> -	if (indio_dev->scan_timestamp) {
> +	if (iio_is_soft_ts_enabled(indio_dev)) {
>  		d_size += sizeof(s64);
>  		if (d_size % sizeof(s64))
>  			d_size += sizeof(s64) - (d_size % sizeof(s64));


