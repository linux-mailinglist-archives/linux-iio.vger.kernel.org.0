Return-Path: <linux-iio+bounces-27614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8AD0EF96
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B6803004CFB
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0033ADBA;
	Sun, 11 Jan 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qP0S6EvZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F54450F2;
	Sun, 11 Jan 2026 13:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768138070; cv=none; b=FNhEa7OKZGSa+YYKlBBrIXrYTMi3XPukZoUoGXwuuxIRn7oksWtQ8HIc+viZG69Q2DeAgcgOZhmzhPGwvKZIUHprmLoKNIbZiNIX3GqYHWV5DiO0JOU3NkPT41J09TcuFrGt0G9yNvbGQ5bepIcZBCCZ1oyOyY+vN2KlSZYlGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768138070; c=relaxed/simple;
	bh=6BoqbWf0ldTPnl6aKGqjg1vW7/77pwGC4a2jL13ON3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUpicPTSW0+cH1tM7oeWilASR3TY/qz0XZHozgdRGEUCmStKZXfBjM/9md9QtYmdlXULPQ1LrcxOQqZ4XU1UwKco4yxjx592QASEF6YYTI9vCmTnpqRRpLiGG16fgw3taX3zdFalwxe+lDDdN7MPCTIYLrYLWjM/v/S71AJyu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qP0S6EvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E1FC4CEF7;
	Sun, 11 Jan 2026 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768138070;
	bh=6BoqbWf0ldTPnl6aKGqjg1vW7/77pwGC4a2jL13ON3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qP0S6EvZMBgENt+yqoBY2BIivWpgiyI5kKH1HDM0WhbeUjCOBTAWlyS0zBbItJ3VR
	 XN88+L7+XdpSvP6c0HovPwt7Q29KOLpU6SgLOojUsDvxdcXJncpY8O+/NNa6Gp0CTt
	 LxhDazsEKVvbmitU3gwCe3oSUBSDUckxzBC8efe1U/GMaNRxC6OBPuTb5HLkywZwCb
	 H+HVTlIit5mvZAgatNqEzCpZ13ptGcITWB4wP0pIxJcS2GDOj9AXlmYTYLFy+2gphO
	 CC4tIPq1dskobYn+SwKtyDwzLJW86EvewJH4SvdmealV7rBtgUmIcmdDlt/XBFLkvG
	 /j4d1OyMz00rg==
Date: Sun, 11 Jan 2026 13:27:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
Message-ID: <20260111132741.4e8608af@jic23-huawei>
In-Reply-To: <20260107143550.34324-1-linmq006@gmail.com>
References: <20260107143550.34324-1-linmq006@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Jan 2026 22:35:50 +0800
Miaoqian Lin <linmq006@gmail.com> wrote:

> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer. The code incorrectly uses 'count'
> as the index for null termination instead of the actual bytes copied.
> If count exceeds the buffer size, this leads to out-of-bounds write.
> Add a check for the count and use the return value as the index.
> 
> The bug was validated using a demo module that mirrors the original
> code and was tested under QEMU.
> 
> Pattern of the bug:
> - A fixed 64-byte stack buffer is filled using count.
> - If count > 64, the code still does buf[count] = '\0', causing an
> - out-of-bounds write on the stack.
> 
> Steps for reproduce:
> - Opens the device node.
> - Writes 128 bytes of A to it.
> - This overflows the 64-byte stack buffer and KASAN reports the OOB.
> 
> Found via static analysis. This is similar to the
> commit da9374819eb3 ("iio: backend: fix out-of-bound write")
> 
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Hi Miaoquian,

You haven't listed why you didn't add David's Reviewed-by tag from v1.
b4 found it though so all is fine, but none the less please make sure you either
pick up tags, or in the change log say that you didn't deliberately.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
> changes in v2:
> - update commit message
> - v1 link: https://lore.kernel.org/all/20251027150713.59067-1-linmq006@gmail.com/
> ---
>  drivers/iio/dac/ad3552r-hs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 41b96b48ba98..a9578afa7015 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -549,12 +549,15 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
>  
>  	guard(mutex)(&st->lock);
>  
> +	if (count >= sizeof(buf))
> +		return -ENOSPC;
> +
>  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
>  				     count);
>  	if (ret < 0)
>  		return ret;
>  
> -	buf[count] = '\0';
> +	buf[ret] = '\0';
>  
>  	ret = match_string(dbgfs_attr_source, ARRAY_SIZE(dbgfs_attr_source),
>  			   buf);


