Return-Path: <linux-iio+bounces-6774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 483F3913CAE
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36C81F22903
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A637618306E;
	Sun, 23 Jun 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA3RS54Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DCE183067
	for <linux-iio@vger.kernel.org>; Sun, 23 Jun 2024 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719159385; cv=none; b=Q64TT6i9jAu8t28nns1/xMlpU6OVk1wvsv7roRjsvM0tE+OAIADFC6sLvWOCluJkPxCEmxWsA7h7a8qXd0vXvVMLdemaJ2A4GUaeYpMm7v6z0roZhIHIa+W/hL1y2O/I2ycI1AAmBf1wpeYFFDACELBW2ULigDjFsv5/7MbHtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719159385; c=relaxed/simple;
	bh=Ns25Tlc0xYYYrSErJuTaK7V6BqSOqaWXRjiI5NqzIdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtPF1O3A6g5X1Az1jOlnViGKNi/mueWkpDQGNKEldFZ55o6QSBNmF6MnIHavohfZ0LT95G6VbWB+2UJgbud9Uty+bOAA6FpPD0QrGW/a1GL/XONLIwUzuzckoH5hpa1tNFz9WGoUK3VIbt3qoRUWqRsA6HiTcoQp5fEAtIrxBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA3RS54Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC43C32781;
	Sun, 23 Jun 2024 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719159385;
	bh=Ns25Tlc0xYYYrSErJuTaK7V6BqSOqaWXRjiI5NqzIdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AA3RS54QfPhY1qI7f+746W1NnibUfpFAzqr/JlVgdCcacMjOqGlkAVXxqqlZp7WBe
	 Zp5yry8VW6K+1trGQOYk9duD9BHyg7hUUqN0UN0Pexg5DUiUbzZLInRC4lS9CkX1YC
	 trQVFQ6wgXYX+Z7iuaKa3HKUs8do30C9TTIq6nE4NeIuTP1ACChUKeRpjDlRWxqhYZ
	 OD87LUKR1OKWXBjk2077YXcLQcZz3h2bP1u8jT2PbpdyK1QiO44hw+i2yn0KsWxx3R
	 ZFfE0ISqWIpguq14GfSriSYU9FPS6cVSUqHi9w0qlBthcVbjThnOOfX9y5tDISpuVc
	 7Pnl20V7DeNUw==
Date: Sun, 23 Jun 2024 17:16:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 8/9] iio: imu: adis16475: make use of the new lock
 helpers
Message-ID: <20240623171619.7e872cbe@jic23-huawei>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-8-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
	<20240618-dev-iio-adis-cleanup-v1-8-bd93ce7845c7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 15:32:11 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> Use the new auto cleanup based locks so error paths are simpler.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
This failed a build test...

>  static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
> @@ -340,7 +335,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
>  	if (!freq)
>  		return -EINVAL;
>  
> -	adis_dev_lock(&st->adis);
> +	adis_dev_auto_lock(&st->adis);
>  	/*
>  	 * When using sync scaled mode, the input clock needs to be scaled so that we have
>  	 * an IMU sample rate between (optimally) int_clk - 100 and int_clk + 100.
> @@ -385,7 +380,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
>  		sync_scale = scaled_rate / st->clk_freq;
>  		ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_UP_SCALE, sync_scale);
>  		if (ret)
> -			goto error;
> +			return ret;
>  
>  		sample_rate = scaled_rate;
>  	}
> @@ -400,7 +395,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
>  
>  	ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
>  	if (ret)
> -		goto error;
> +		return ret;
>  
>  	adis_dev_unlock(&st->adis);
You missed this one... I dropped it whilst applying.

>  	/*
> @@ -410,9 +405,6 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
>  	assign_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
>  
>  	return 0;
> -error:
> -	adis_dev_unlock(&st->adis);
> -	return ret;
>  }

