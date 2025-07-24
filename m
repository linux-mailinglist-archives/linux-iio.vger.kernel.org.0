Return-Path: <linux-iio+bounces-21945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506EB10870
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1474A1CE5587
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B6264627;
	Thu, 24 Jul 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmYwwP0L"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB702F43;
	Thu, 24 Jul 2025 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355017; cv=none; b=Cx92u+D14JUmuyX3Hc7AqmvP9IHThsD1mmyAlC/Pii22eo98w0Ha2B7Gm3K6iOS7KoTLNjnh2WpMzPYofsE3G3uRvg1qTURRkkRLm+hh0FjFULD0t7cq2gGI8MNFbhvN+B3fFwaLBPSpmW/4/FP/kpLV1s6JQ+6XvTW8gTZXe0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355017; c=relaxed/simple;
	bh=FB4qQxbauwuEdw7MX721tC+DjFmD6TO78Gayu3O5ISU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eaq3lsoPxJU6Rjsppe1gmrvcFM1tgMUCkpSCUi6JxtSq7h16pB4y3ZJ1t/DCniZ4UVe63tlUiyoBiDu0PJXv2TAO7fyBzDS00xY5FKkGEI5sITmLjOp2whgIyl/aR0f4PcKvteoq/wFGy/gNkWdglOJaij/xmScBRukL1Vpym0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmYwwP0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3D6C4CEED;
	Thu, 24 Jul 2025 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753355017;
	bh=FB4qQxbauwuEdw7MX721tC+DjFmD6TO78Gayu3O5ISU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RmYwwP0LqiMHdFdVwx9v33yWcWYMoZWF/x6qvfooZkStI1qOrPd5y604YwZ1F1T2x
	 0r8nIIhhl2a5NTiceHZbIAVFCC9mnstST0UloUBisf0uSO/lGt0q+cS6JE8JuDAbJ2
	 FWsQ1N9MB579MFs17Jt202aPHdjdN/AP4lxzvmcMwKbYAMuK/LW3L2JcIG5mwEOHcI
	 vVX27HFa/9TnAv5OGj3oV54jyQ3wcmOyfgEG2oUATKlc7xs+qaHjeYPEadyShrjSkS
	 O5PbUVeQbuOS91TWus34cxAUerldnGwuuwA3szlj9LWwKnFeEa6aLQdwJ2pgMo1XG+
	 VA1VJxaF7tRKw==
Date: Thu, 24 Jul 2025 12:03:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Mathieu Othacehe <othacehe@gnu.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] iio: proximity: isl29501: fix buffered read on
 big-endian systems
Message-ID: <20250724120329.671dc192@jic23-huawei>
In-Reply-To: <20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com>
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 15:54:21 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix passing a u32 value as a u16 buffer scan item. This works on little-
> endian systems, but not on big-endian systems.
> 
> A new local variable is introduced for getting the register value and
> the array is changed to a struct to make the data layout more explicit
> rather than just changing the type and having to recalculate the proper
> length needed for the timestamp.
> 
> Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
ok. This probably is the best minimal fix but there is a bunch of other type
confusion around this in the driver (not as far as I can see actual bugs though).

Might be good to circle back and make the val parameter of isl29501_register_read()
a u16 as a follow up.

Applied to my temporary fixes-togreg-for-6.17 branch on iio.git and marked
for stable.

Thanks,

Jonathan



> ---
> Changes in v2:
> - Use u16 to match channel scan_type and introduce new local u32 variable
>   for getting the register value.
> - Reword subject and commit message since we now consider this a bug fix.
> - Fix not zero-initializing the new struct.
> - Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com
> ---
>  drivers/iio/proximity/isl29501.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
> index d1510fe2405088adc0998e28aa9f36e0186fafae..f69db6f2f380313b8444ee21399ee3a9faed6f04 100644
> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -938,12 +938,18 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct isl29501_private *isl29501 = iio_priv(indio_dev);
>  	const unsigned long *active_mask = indio_dev->active_scan_mask;
> -	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
> -
> -	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
> -		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
> +	u32 value;
> +	struct {
> +		u16 data;
> +		aligned_s64 ts;
> +	} scan = { };
> +
> +	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask)) {
> +		isl29501_register_read(isl29501, REG_DISTANCE, &value); 
> +		scan.data = value;
> +	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070
> 
> Best regards,


