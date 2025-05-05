Return-Path: <linux-iio+bounces-19139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8270CAA9997
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21841882DD2
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD62561C2;
	Mon,  5 May 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSutAaVK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD628189916;
	Mon,  5 May 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463413; cv=none; b=UyxL7eefVXWCDdxbOe2gr1aRZSBFaWEdhfEm/z1+Qs3KznJfjq0CajhD9lgBktzneQqHU3ejwIvF3LY848Ih25jZ/zWZcvrT05bvktWAk2nIha51hzfLXEiiWKFqonhoHl9L60RAxBhc772/lSHIgbdWANlM34C9gRFvqvRZ3K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463413; c=relaxed/simple;
	bh=qhYcS/yhGjmJKAoC6feXiZykrZ04BhDEoZDWz3NoqhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1EeYWgBdZVdLGcksDLJyyyzhpY+mvfmSwLX0nrFLPHBmbMf+bjFShQ8YLq4U96Svio0mEaSN1qjfkEq4fNVSNTA/LFzs/akKBcC9VyZgJr8eeXfsaBC7p0mbPkSeGhsgsy5HJzbz4SrfAjLzPa5xF6Ok8HGvLRkf1fNRSq43mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSutAaVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB44C4CEE4;
	Mon,  5 May 2025 16:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746463413;
	bh=qhYcS/yhGjmJKAoC6feXiZykrZ04BhDEoZDWz3NoqhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cSutAaVKh6wf+HOBwQKA7jGYgo0i9BgtwBFPBbW3tosClh5FWZ2U5e5jMgFb03AA2
	 Xr2u7/tHqWIwfYGFZwMhRY9fRnf7krhyXmmdFK63ulGMiPo+d0+yI1qNEgOSI/Irx8
	 05DasfPB1odHClvFHLRsQPDXe1Z8p2vUGC8K71JGELjHZXxIfLDMgZH+Y5irHkPWCq
	 l/tjTcsIPJdiHeVJRZFoFS5h/RoCPjwV0e56PdBsklJrsM8Lhka6YFdDGXyJCffjKg
	 w4oW/imAi8VMNJD67ocP+WPGeOEZbBVntdi/IVHRz7A3FQEGrrQKV1Bnwa5hsom6c7
	 FOI0MuTnw3CWQ==
Date: Mon, 5 May 2025 17:43:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Markus Burri <markus.burri@bbv.ch>
Subject: Re: [PATCH v2] iio: backend: fix out-of-bound write
Message-ID: <20250505174325.0216b11e@jic23-huawei>
In-Reply-To: <20250505045346.29647-1-markus.burri@mt.com>
References: <20250505045346.29647-1-markus.burri@mt.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 May 2025 06:53:46 +0200
Markus Burri <markus.burri@mt.com> wrote:

> The buffer is set to 80 character. If a caller write more characters,
> count is truncated to the max available space in "simple_write_to_buffer".
> But afterwards a string terminator is written to the buffer at offset count
> without boundary check. The zero termination is written OUT-OF-BOUND.
> 
> Add a check that the given buffer is smaller then the buffer to prevent.
> 
> Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---
>  drivers/iio/industrialio-backend.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index a43c8d1bb3d0..31fe793e345e 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
>  	ssize_t rc;
>  	int ret;
>  
> +	if (count >= sizeof(buf))
> +		return -ENOSPC;

if count is buf - 1 this passes but...

> +
>  	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);

This effectively copied in one less than we expect so we drop a character.
So I think we want to add the -1 to the check as Nuno suggested.

>  	if (rc < 0)
>  		return rc;
>  
> -	buf[count] = '\0';
> +	buf[rc] = '\0';
>  
>  	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
>  
> 
> base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e


