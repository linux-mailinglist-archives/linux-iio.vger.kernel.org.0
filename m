Return-Path: <linux-iio+bounces-22500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B5B1F600
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 21:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC0D17FD3B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824028469E;
	Sat,  9 Aug 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b//ybEci"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002A1B423B;
	Sat,  9 Aug 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754767490; cv=none; b=XgzPFf/FrSHddLRrp+yBnZyjPwbGMJR6/LmCkB9wp7VXdYgd+wImFb/T3wF2P0jBc8fT0MD0Is390Gx5z7ym56ABv7y0FXT+oD1m8qfzfowdg6G1zTEnr5lx+Y6IMRoaUVOF94Lo7FlB6N8m/1UmFJZunLPsf8hWsyMCJo6JFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754767490; c=relaxed/simple;
	bh=6rM9hp+bSRD2mwv60+hmG1MxHKfkDAAW7aTvWln7Awg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbvPbtnJl9GmUmG6fR4sevvE0AyLVZB9JI3DodAfvEZ++6mNRBqPL1rvvNFpm5dey2riWrZw1ess8LNaQiofnDl4cp2vrUOmJw7VCXUh5C1RPjfqY/K3u3hL7ro4dUReYFSNLBn+S3eLhYdx+f4YCPVwoYbcoteUE4+9huoaE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b//ybEci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97028C4CEF4;
	Sat,  9 Aug 2025 19:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754767489;
	bh=6rM9hp+bSRD2mwv60+hmG1MxHKfkDAAW7aTvWln7Awg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b//ybEci7JFKbabO21PK45u8GrXWd01sebu24qH9EFYgr5Wg0nA6LOqSJ6PAJ95Cr
	 r5SwxH/U7LLEf10ivwRk92B+NDQ7CU9jCiNiNikH/p3xHHEsmJsiAssYHqAGdR4p0m
	 B8xUCkF76vcJruWN4zYXYnEIQlUzFyudZeGxoptjzCF3YVrerTL5d70V92Kh7bH6qC
	 9r0EnTc7EKnmH+LRZ3ZMuxIInfVUMO4D6Gb8M/qv4KJ9OPWFt6rnYXw1euEfVOjRLF
	 f/eAixhRuoSoqr+egdgn4n027icTfpeOlNxRm8S1uH53vrNgBC4KHfMATEQTC9dvkn
	 GSGkRKHGMYK/A==
Date: Sat, 9 Aug 2025 20:24:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sean Nyekjaer
 <sean@geanix.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: change invalid data error to
 EBUSY
Message-ID: <20250809202440.552e1cdf@jic23-huawei>
In-Reply-To: <20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com>
References: <20250808-inv-icm42600-change-temperature-error-code-v1-1-986fbf63b77d@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Aug 2025 09:40:10 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Temperature sensor returns the temperature of the mechanical parts
> of the chip. If both accel and gyro are off, temperature sensor is
> also automatically turned off and return invalid data.
> 
> In this case, returning EBUSY error code is better then EINVAL and
> indicates userspace that it needs to retry reading temperature in
> another context.
> 
> Fixes: bc3eb0207fb5 ("iio: imu: inv_icm42600: add temperature sensor support")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: stable@vger.kernel.org
+CC Sean who raised the issue.

> ---
>  drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> index 8b15afca498cb5dfa7e056a60d3c78e419f11b29..1756f3d07049a26038776a35d9242f3dd1320354 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
> @@ -32,8 +32,12 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
>  		goto exit;
>  
>  	*temp = (s16)be16_to_cpup(raw);
> +	/*
> +	 * Temperature data is invalid if both accel and gyro are off.
> +	 * Return EBUSY in this case.
> +	 */
>  	if (*temp == INV_ICM42600_DATA_INVALID)
> -		ret = -EINVAL;
> +		ret = -EBUSY;
>  
>  exit:
>  	mutex_unlock(&st->lock);
> 
> ---
> base-commit: 6408dba154079656d069a6a25fb3a8954959474c
> change-id: 20250807-inv-icm42600-change-temperature-error-code-65d16a98c6e1
> 
> Best regards,


