Return-Path: <linux-iio+bounces-11866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0439BA53C
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 12:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB67281D92
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0AC15F40B;
	Sun,  3 Nov 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3j5uip9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC0156C40;
	Sun,  3 Nov 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730632721; cv=none; b=qbouRZeWzhZsSE3NGwXWBz4SAcZZQE44WgYpPIm5RuE+4GVZzeJaEPOScezY2e/aeMdPkwXwpQam6clCLTJJaUjt7WEYcdHEOQ+o9K72lOym492l1kg3BF+rIRvkIT9C8u6PDpf9bDvPzl1GAVTT/IuUL97E7wgYLrvHUleLLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730632721; c=relaxed/simple;
	bh=tsdwG1Q1xmRmxAsCgP2WDVLVVMRmygDokm5rALXU01o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQbBk7Qz2+szQ5gU3kXKGlsO3Fym/qpa4tR9gvF5YN5R92RnxIaW3Rqr5O8qxo9neUbo7aaj0uUM1APhNgI2/pvM27W7CD4rlPHQaOW585y2x6mtPPVdRRwuF8VaG8Oh2lgl+HqPB39algwyKfjV/sp9VtS7R43ddcoRNjOzA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3j5uip9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE74C4CECD;
	Sun,  3 Nov 2024 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730632720;
	bh=tsdwG1Q1xmRmxAsCgP2WDVLVVMRmygDokm5rALXU01o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V3j5uip97WbWrAa/Xn2h4XP7A71nZWwI7ETFvR+uqCSaPAoDaZEXhVYpmxr6AfzlH
	 KJ4nosvuO7+Yh8dtW8/bui6ZkAtKTJtubB+j3WCNfbRVhAVMJTbE6Jz/EkMRiRBOXk
	 pXLIEhxWm5m5BiOuukWMP3rk1DqAASYoauPqXJSVu8thwXSbTXrZMdxlkMdEAqSGY9
	 9Go1hP6Aw+aUU2r/V6eCSC6qd810vwU+NZ/Vtn1zlkE8XmHKn4muqdhfLV5jkPfRAw
	 XZxvFhRG2Ll10d8Euig8OXwLo8a8oG/p6trKmaBVazEc1B7m46B4LWRFPDnhWQgG1R
	 W/C+SvykBPRMQ==
Date: Sun, 3 Nov 2024 11:18:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, Anup
 <anupnewsmail@gmail.com>
Subject: Re: [PATCH] iio: invensense: fix integer overflow while
 multiplication
Message-ID: <20241103111827.0894a40a@jic23-huawei>
In-Reply-To: <20241103-coverity1586045integeroverflow-v1-1-43ea37a3f3cd@gmail.com>
References: <20241103-coverity1586045integeroverflow-v1-1-43ea37a3f3cd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 03 Nov 2024 08:43:14 +0000
Karan Sanghavi <karansanghvi98@gmail.com> wrote:

Hi Karan,

> Typecast a variable to int64_t for 64-bit arithmetic multiplication

The path to actually triggering this is non obvious as these
inputs are the result of rather complex code paths and per chip
constraints.  Have you identified a particular combination that overflows
or is this just based on the type?  I have no problem with applying this
as hardening against future uses but unless we have a path to trigger
it today it isn't a fix.

If you do have a path, this description should state what it is.

> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
If it's a real bug, needs a Fixes tag so we know how far to backport it.

> ---
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index f44458c380d9..d1d11d0b2458 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -105,8 +105,8 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
>  
>  static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
>  {
> -	const int64_t period_min = ts->min_period * ts->mult;
> -	const int64_t period_max = ts->max_period * ts->mult;
> +	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
> +	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
>  	int64_t add_max, sub_max;
>  	int64_t delta, jitter;
>  	int64_t adjust;
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241102-coverity1586045integeroverflow-cbbf357475d9
> 
> Best regards,


