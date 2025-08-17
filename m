Return-Path: <linux-iio+bounces-22873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0F6B29458
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 19:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10F6E1B26A36
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4E2FFDF4;
	Sun, 17 Aug 2025 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGIhOmtJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891119F11B
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450352; cv=none; b=jn+1D0VEuDFoNEOlm2f0Miqhwb1ZSUHw5nnOaTGake/qXpsqN2h0MDPd3SEhzIP496nSg7gE7GGudFcmuWNvfbPWv9935lwyEGjeI95t7o/wWHiuh2aTvOjKtjAoMhK/BjVwylhXE2aeVmh5HzQ+AumjVuzhJZ7AKNkqQXXZmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450352; c=relaxed/simple;
	bh=uV4ksxJs0CL6AoOIUQly4WCgI1y/DoH9qzszHTPOdIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckw4lnCysvppdazdU9WpiYaj8vDYKWRPVX0w3zSC10GaYCEuxvQXSelbHpEHNzFoaYQRBFX9LypJv3ib0N56Ky06F2h2tSFhU+ewOH25PdbKBmilvh1h89iN4l/LK+L9bex8B5PflnAsq6jbljcuxu+qP8a3U5Krj2RvkXXeiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGIhOmtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA04C4CEEB;
	Sun, 17 Aug 2025 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755450351;
	bh=uV4ksxJs0CL6AoOIUQly4WCgI1y/DoH9qzszHTPOdIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SGIhOmtJHsRqL3WMd4hLXyzu1YVw9zb8jta5pNLmOjsJT2GbevTYPA1N9ovGbrF/6
	 1nixrTcEFbmCtJ8RiojTDTAr2MV9lmCDMz/PiThmPQS7GW8L1ekILX0uSAx3iEA7tb
	 d1LvDzRMlfwiXQsZsTiBtU3dwxPZC94WRh09Dh+OKRx4YFBmk5fHAUbXDqdsX9FMBc
	 X2sim9Q0UgD674721tj2D5aHm8l195IGthIodaDW2gAR4PP6OnObPyZ+g+lCr+J9G+
	 r6P5UvYrq+Sm+Ge2YZzc1wIUK7/7H5rYDxY/2MUAb0GKvDEir1twKegaC+ib8Ad60Q
	 8/0E+jtqux6jQ==
Date: Sun, 17 Aug 2025 18:05:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 9/9] iio: pressure: bmp280: test longer
 autosuspend (WIP)
Message-ID: <20250817180545.11a2bbee@jic23-huawei>
In-Reply-To: <20250810185846.114355-10-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-10-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 20:58:46 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Autosuspend delay should be configurable from sysfs via the power
> attributes, but that is apparently not working for me.  Since the
> standard value for autosuspend_delay is shorter than my typical
> measurement period and a suspend/resume incurs both additional latency
> and stronger tailing on the acquisition time, monkey-patch a 2s value
> in until I can figure out how to do this properly.
> 
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

Currently delay seems very short anyway, so I wouldn't mind increasing
it like you have here.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 5c4126e4eccd..7d51ab0b92e9 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -3500,6 +3500,8 @@ int bmp280_common_probe(struct device *dev,
>  	 * start-up time.
>  	 */
>  	pm_runtime_set_autosuspend_delay(dev, data->start_up_time_us / 10);
> +	/* test */
> +	pm_runtime_set_autosuspend_delay(dev, 2*MSEC_PER_SEC);
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_put(dev);
>  


