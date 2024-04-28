Return-Path: <linux-iio+bounces-4567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142928B4B95
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 13:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE6D1C209D3
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 11:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7981627E8;
	Sun, 28 Apr 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf6rGfOE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978246168C;
	Sun, 28 Apr 2024 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714305383; cv=none; b=Nv2H90L86qwa0m3M7VsizpPQA7Oqq3rZfF9UAzf4rGx5O9RBjb6Is4G0ttG7paj5gnvyIy542CXUssR7NlAjdhYCqBcx2F1S80LZ5H3glBsb8qNUl0ixGwsWMW/qJaix8WyA5wQjTxdbA9aJZWA5h7ex86TEmBwgyAcdAjOqVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714305383; c=relaxed/simple;
	bh=+v7pBmoX5R/7m9qAzplnMws/v/AudtOpCtQCHNPa+AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrfDDX0U7mu9j7btWSldjgCqmCI0gI7giV+rGFxE/aZ6B/VVOVAQogk+rEMaKArc+Zbu9tJtJuwvNN68p5gB5SzMcTele+aZWvovZU//bxvPgX43ZPBOBV9yR4sE8TQRA9vlbVfjK7Dcj0rNztPkz7FIzM2lU5HVAo/gbA4tBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf6rGfOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2D6C2BBFC;
	Sun, 28 Apr 2024 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714305383;
	bh=+v7pBmoX5R/7m9qAzplnMws/v/AudtOpCtQCHNPa+AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nf6rGfOEgaPYgXnsVqmF6nSzezI4r8FdgGY241XXCJ40gSnyHrX8XKc3OHtfX+pKf
	 532twr76R4rCg3lRQBrVFGKbaXTNyQLJvuA1CgBh/KQOY3xIBE9rbCYSVoAEjmMCre
	 JM95r97G83teefOBKiI5TQWO/huGMfJx1XXwWuNeS1SeElA4ntEKRM8hT12ILmu7S3
	 4icQFtZ+1z3tsC/enMR10fWLG5CW4hGzLhrCBZRxb6TF2iZngAL60AjOZzGnDNaTh2
	 GkbG0svUmCIqhxH25WJLlf9gHccjKR8Q+G69ruwFJWwpxvjZOMTIcprWNXaDeGyy62
	 2ArrecGQnrIRw==
Date: Sun, 28 Apr 2024 12:56:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: invensense: fix interrupt timestamp alignment
Message-ID: <20240428125614.3f8d2b59@jic23-huawei>
In-Reply-To: <20240426135814.141837-1-inv.git-commit@tdk.com>
References: <20240426135814.141837-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 13:58:14 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Restrict interrupt timestamp alignment for not overflowing max/min
> period thresholds.
> 
> Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Hi Jean-Baptiste,

I'll pick this up, but for future similar cases, please make a clear
statement in the patch description on whether this is a theoretical
problem, one found by some tooling, or (the most important bit) something
that actually happens in real usage!

That info helps people decided on how aggressively to backport that change.

Applied to the fixes-togreg branch of iio.git.  Given that has a link
tag to this thread, replying here with the above will make that info
somewhat available.  We are late in cycle, so I may just move this to the
final pull request for the merge window if I don't have many other fixes
queued up.

Thanks,

Jonathan


> ---
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index 3b0f9598a7c7..4b8ec16240b5 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -101,6 +101,9 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
> 
>  static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
>  {
> +	const int64_t period_min = ts->min_period * ts->mult;
> +	const int64_t period_max = ts->max_period * ts->mult;
> +	int64_t add_max, sub_max;
>  	int64_t delta, jitter;
>  	int64_t adjust;
> 
> @@ -108,11 +111,13 @@ static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
>  	delta = ts->it.lo - ts->timestamp;
> 
>  	/* adjust timestamp while respecting jitter */
> +	add_max = period_max - (int64_t)ts->period;
> +	sub_max = period_min - (int64_t)ts->period;
>  	jitter = INV_SENSORS_TIMESTAMP_JITTER((int64_t)ts->period, ts->chip.jitter);
>  	if (delta > jitter)
> -		adjust = jitter;
> +		adjust = add_max;
>  	else if (delta < -jitter)
> -		adjust = -jitter;
> +		adjust = sub_max;
>  	else
>  		adjust = 0;
> 
> --
> 2.34.1
> 


