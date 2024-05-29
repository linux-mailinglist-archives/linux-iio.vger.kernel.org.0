Return-Path: <linux-iio+bounces-5470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D648D3F67
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 22:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE48628978E
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3571C689A;
	Wed, 29 May 2024 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Euqumq09"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9115B0EB;
	Wed, 29 May 2024 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717013565; cv=none; b=cfcM3qR6SD38nvEW8VKbf4EaT4JKVhDh/gLAwQMbWrXq1Za3DRTQWHyHi82cPZ2upFealqV+fkiWMmnol1K6LjjMZ9Sc6JibIetHuPB6FrucCZ20eTMlEClm5e3hzhwDYIv1bEzyyoWf5fv0M/HJVyD1A6GMRnZZIaKxPxT1DIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717013565; c=relaxed/simple;
	bh=ysCwz58Upl2+SUOx/6vsLRR2nSew8pOkk+LFvAR6jo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea8PObb5Nljrgf98W8eJcOcrPCYesVHQDxcYgU83yTlOOpXwLB+0TtX5i5Wm3dLLTp8paERayENjjIMF8/3RB8LZk2YAyIcxHV82rhCMctNSkwIXS2I3CSnlXsemdckPkJNzAs8kaa4urv4Y2fJpGh/lrxt/YPol+LQAWzXsSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Euqumq09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D746C113CC;
	Wed, 29 May 2024 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717013564;
	bh=ysCwz58Upl2+SUOx/6vsLRR2nSew8pOkk+LFvAR6jo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Euqumq09cLjpnx8EZ8oUdtj/5v61cRzBRK0ZVEaqYAlpQ4Nxidu16U3ksfRfTkSpT
	 7GccizxyewNpSYiP8b0L4kMIzbiSRS1DgT/h2v48Vp/d6wuCcU6BQvfdE7nffwyScR
	 4Zhc4NefJq1n4mSY0weNvgtVWRD2lI3306QTjDv4HKmPp0DEWuLAHh/yS5Dldi6067
	 MbzcOEKdx2D6MB1oDV2N33YShMkOAq/sp0suvQPQ3DDcXVPjn66aflA4/XFEaSwg1Z
	 Wr/Vy75uJoXRSG7GOkDF9cqn3fcl2zgZtUFSanEKQspr4pAi8+kzfcEaCBI3qHCQbw
	 NIMo0ZJn8ZBgw==
Date: Wed, 29 May 2024 21:12:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] iio: pressure: bmp280: Add triggered buffer
 support
Message-ID: <20240529211228.2d7fbd93@jic23-huawei>
In-Reply-To: <20240512230524.53990-6-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
	<20240512230524.53990-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 01:05:24 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
> temperature, pressure and humidity readings. This facilitates the
> use of burst/bulk reads in order to acquire data faster. The
> approach is different from the one used in oneshot captures.
> 
> BMP085 & BMP1xx devices use a completely different measurement
> process that is well defined and is used in their buffer_handler().
> 
> Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---

> +
> +const struct iio_buffer_setup_ops bmp280_buffer_setup_ops = {
0-day noted that this isn't actually used.
I'll add it to the buffer setup where it's currently passed as null.
> +	.preenable = bmp280_buffer_preenable,
> +	.postdisable = bmp280_buffer_postdisable,
> +};
> +

