Return-Path: <linux-iio+bounces-26097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6FC442A3
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 17:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B59C188A922
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438202FE56C;
	Sun,  9 Nov 2025 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8Bqg5TT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C618C26;
	Sun,  9 Nov 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762706744; cv=none; b=BwtGbcbG0agfljy3n0c9H2CzZS2ju40RhuCJFbTCsTsaiY/xm8GSCJY29mW22GN8Qc/9tUCuARGxWMVUWwQbF+acR0RKhfYqU+WKJcgMyafIHtuRsdFrpOh+f2LVQNg+8I3w5M1TEoAkWSfTectQOESRT9fAnqs8tC6bpvrANjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762706744; c=relaxed/simple;
	bh=LMpiD8lMyszFsZ3IYN/FGo6GYILYABYGkNHfbC8X2fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJXkFk2okqcpBy6gwNSRbjsA+Asq1qIgD5KXHNRmf4dnXniXFCSCB5AbRAAyr5ZxwfVhYPX5wou1COdaWwn3lXGzjyDsoag8TxTolQY+kmLP6e3KZJEJalAshpQLKOkcq9B84TKFvVozyGKMkuw8+BEp3j9MJBrALE4eLbnmCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8Bqg5TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B24CC19421;
	Sun,  9 Nov 2025 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762706743;
	bh=LMpiD8lMyszFsZ3IYN/FGo6GYILYABYGkNHfbC8X2fQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R8Bqg5TTNPXyQCyHRSr12PRvLz+jgtPuU1+maTvGdRT5JtbTnCDQZ7VS+BpsxA+/R
	 62+h2cTgC5szi09t7MIC4++8y4EXYpAflbw4fcOW++zzOx8lJXnBX/FJN7s8xaA0Gt
	 Q+nWOasVMyUq8lcEU89eY17mAPxYe15b+JzT6KCeXJdxpQ/khHsQGGlOgBB455/jEG
	 +6u71rVaNUbxPirMKkyzijAKrvbCz2ovaVNk+8efAZNALkZ05P4YRTOBiz5lOsgD+0
	 OXmRQQ5yy3vlGMFyWPQ0cfIgSl66etE5waikLLgzuysoAXNMlMqC6V5Hrnkx9Rpsgm
	 lyiC+6INfnJMw==
Date: Sun, 9 Nov 2025 16:45:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Tejun Heo
 <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic
 Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Marius Cristea
 <marius.cristea@microchip.com>
Subject: Re: [PATCH] iio/adc/pac1934: replace use of system_wq with
 system_percpu_wq
Message-ID: <20251109164536.2ed7867d@jic23-huawei>
In-Reply-To: <20251105104330.111057-1-marco.crivellari@suse.com>
References: <20251105104330.111057-1-marco.crivellari@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 11:43:30 +0100
Marco Crivellari <marco.crivellari@suse.com> wrote:

> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistency cannot be addressed without refactoring the API.
> 
> This patch continues the effort to refactor worqueue APIs, which has begun
> with the change introducing new workqueues and a new alloc_workqueue flag:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> system_percpu_wq replaced system_wq, so change the wq in iio/adc/pac1934.
> 
> The old wq (system_wq) will be kept for a few release cycles.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
I'd start these descriptions off by saying the system_wq is deprecated.
Then people are already on the page for there being a necessity to make
a change.

Anyhow, I've seen enough of the discussion of other related patches to
be fine with this.

Applied.

> ---
>  drivers/iio/adc/pac1934.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index 48df16509260..ec96bb0f2ed6 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -768,7 +768,7 @@ static int pac1934_retrieve_data(struct pac1934_chip_info *info,
>  		 * Re-schedule the work for the read registers on timeout
>  		 * (to prevent chip registers saturation)
>  		 */
> -		mod_delayed_work(system_wq, &info->work_chip_rfsh,
> +		mod_delayed_work(system_percpu_wq, &info->work_chip_rfsh,
>  				 msecs_to_jiffies(PAC1934_MAX_RFSH_LIMIT_MS));
>  	}
>  


