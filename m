Return-Path: <linux-iio+bounces-16863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E3A62D25
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 14:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA54A17A3B9
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D41DB12E;
	Sat, 15 Mar 2025 13:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+qQUJlu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAC1FDD;
	Sat, 15 Mar 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742043637; cv=none; b=NsdUzWdY59Zxvufa1DM1bSiDcWlK37nyGHnizb1Q87B7fHRS/yEvKagS4sBD2cy4h1E9SWLvL/KIsiHm4OUPz80kusgpEVxSFLZkojG/KG59mzxH2F3fPONmRdaPz3tC5oC7Sx5iE2zoUkk9eYW+RcMucc59sliKIy8JgEiYEzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742043637; c=relaxed/simple;
	bh=2u/3haK34KXboBV2Ha0iRF1xoQYUJwHiolwLD2dwjOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAKWd1TDaubhfORJvbQJCwUsiZyaOgkB+rx+CaJMm76y4FChI9RJoIKMUjCKS7dSCCHXhUc0Cc9fof9f/hrn2hKRtMl79wvWBQelUKKi+4lesZawsYpRALFAMDFBs8qczdY4zC6MBZyRm0wIdXqavNN3PHZJNRw84yxQRfyou8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+qQUJlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00081C4CEE5;
	Sat, 15 Mar 2025 13:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742043637;
	bh=2u/3haK34KXboBV2Ha0iRF1xoQYUJwHiolwLD2dwjOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K+qQUJluJ0S6V1llmo89P/xrIR0dOzlEFGcMlumOCLVHvg2qKg/9lI/rxEO+LM1k0
	 ONhWGIRWwEMywG08CtsFfzmSvS0rVc2NADdX7+DlpasCrtDkiRHfnJMTqWrHMKSsAF
	 FLNmlPe4+MBiPyJAi+X4olarHjGqCC4O37Zda4RQoDnGRu+3q8paPFr006XQPGAHuE
	 9sX3joSFStshc4EChzHzmYOWHAhZ/zqkMKbV9ykjyMX+E00NWrDVz58sDNKXzTGsVy
	 fu+sQ3gsDYH+d08NQ37DNgJQmq1BNZHObAMLMQu6/fcH4ElSm8MJbjtZ0mcWjcnA1M
	 nJdbTXrsg4Bvw==
Date: Sat, 15 Mar 2025 13:00:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Suraj Patil <surajpatil522@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Suraj Patil <your-email@example.com>
Subject: Re: [PATCH] iio: industrialio-trigger: Fix typos in comments
Message-ID: <20250315130030.6db07f89@jic23-huawei>
In-Reply-To: <20250311155927.467523-1-surajpatil522@gmail.com>
References: <20250311155927.467523-1-surajpatil522@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 15:59:27 +0000
Suraj Patil <surajpatil522@gmail.com> wrote:

> Fixed multiple occurrences of 'reenable' to 're-enable' in comments.
> 
> Signed-off-by: Suraj Patil <your-email@example.com>
> Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
Please carefully read what your changes are before sending!
This obviously breaks the code.  

Also don't take a code spell checker to literally.
reenable is fine here.


> ---
>  drivers/iio/industrialio-trigger.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..21688cd348c6 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -162,11 +162,11 @@ static void iio_reenable_work_fn(struct work_struct *work)
>  	 * This 'might' occur after the trigger state is set to disabled -
>  	 * in that case the driver should skip reenabling.
>  	 */
> -	trig->ops->reenable(trig);
> +	trig->ops->re-enable(trig);
>  }
>  
>  /*
> - * In general, reenable callbacks may need to sleep and this path is
> + * In general, re-enable callbacks may need to sleep and this path is
>   * not performance sensitive, so just queue up a work item
>   * to reneable the trigger for us.
>   *
> @@ -175,14 +175,14 @@ static void iio_reenable_work_fn(struct work_struct *work)
>   *    the final decrement is still in this interrupt.
>   * 2) The trigger has been removed, but one last interrupt gets through.
>   *
> - * For (1) we must call reenable, but not in atomic context.
> + * For (1) we must call re-enable, but not in atomic context.
>   * For (2) it should be safe to call reenanble, if drivers never blindly
> - * reenable after state is off.
> + * re-enable after state is off.
>   */
>  static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
>  {
>  	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
> -	    trig->ops->reenable)
> +	    trig->ops->re-enable)
>  		schedule_work(&trig->reenable_work);
>  }
>  
> @@ -243,8 +243,8 @@ EXPORT_SYMBOL(iio_trigger_poll_nested);
>  void iio_trigger_notify_done(struct iio_trigger *trig)
>  {
>  	if (atomic_dec_and_test(&trig->use_count) && trig->ops &&
> -	    trig->ops->reenable)
> -		trig->ops->reenable(trig);
> +	    trig->ops->re-enable)
> +		trig->ops->re-enable(trig);
>  }
>  EXPORT_SYMBOL(iio_trigger_notify_done);
>  


