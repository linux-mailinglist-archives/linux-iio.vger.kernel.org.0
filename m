Return-Path: <linux-iio+bounces-18265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D30A939F7
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6091B66E05
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C05213E6B;
	Fri, 18 Apr 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R66XEF5o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38521325D;
	Fri, 18 Apr 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990848; cv=none; b=uMEwdxn5rq3reeKMo+rgKZp5/5I2z3yRcRg/nh0wnHWVTMBcFLFQZy8fZd/t+PYW8hvGrg9/pHyn30zVP20XpZHljRFTica9uIOb0vEFatWak4tspfl2KrLbep4gu3eB+ivwzQ6+1rLlqykEGp1dL3nhe/tXa95uvKri0utdsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990848; c=relaxed/simple;
	bh=rPXKeb649bya67Hj2amG1rEuNmF4UK0HVq6E3shvdXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2Ss+0qdxBeqsrOUxYEYtspEd0e5ZpgI6Os4bpHOQwn6rk101KiBSK/GTBTNebhx8kCuNd4tMrFaPpIiIYUKkW8BmV4QQ2Ufj8D9vx5BQeXByHtr3hhgNBJsZoHaYl4T+qlHr4hKx2Ou++aiC50SsOFaAwC1FseDKWIRGPK1PLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R66XEF5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0C0C4CEE2;
	Fri, 18 Apr 2025 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990848;
	bh=rPXKeb649bya67Hj2amG1rEuNmF4UK0HVq6E3shvdXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R66XEF5owpz2ItMA+GVvWVvtlwaHBtrPL9CgOuefaYEsKVD+G9RhMV4lhFQNzzLz7
	 6qlvMzRZS/JvDjxKUD/BSXbOIjQVjSvnaarD3sJ+LAu8HbIYbp+9sCeke0XNepPll/
	 aST73jlpbkU+KtK4dFXEvUK52VPE/4w4cz6Zl3+/Uksk0D6A2Hy90+da3R0cPl0Jou
	 ivb4cE+uyV95rYMf5bXPSwiHFshGG59l3YMF28rdaJrdgaLff8dzJ/w5dGFeBEMsP+
	 9svFfgAZK2JjH+0roQjh2VqwlNPBKxFsCMm5JEpY2/IGk361x8Pr8+f/afepwca8pn
	 jtNJ9S8zswQZQ==
Date: Fri, 18 Apr 2025 16:40:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: Use SLEEP bit instead of RESET to
 disable output
Message-ID: <20250418164040.0f103380@jic23-huawei>
In-Reply-To: <20250417135434.568007-1-gshahrouzi@gmail.com>
References: <20250417135434.568007-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 09:54:34 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> According to the AD9832 datasheet (Table 10, D12 description), setting
> the RESET bit forces the phase accumulator to zero, which corresponds to
> a full-scale DC output, rather than disabling the output signal.
> 
> The correct way to disable the output and enter a low-power state is to
> set the AD9832_SLEEP bit (Table 10, D13 description), which powers down
> the internal DAC current sources and disables internal clocks.
> 
> Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
Seems reasonable but I'd like some more review of this before picking it up.
So feel free to poke me if nothing happens in say 2 weeks from now.

>  drivers/staging/iio/frequency/ad9832.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index db42810c7664b..0872ff4ec4896 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -232,7 +232,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  			st->ctrl_src &= ~(AD9832_RESET | AD9832_SLEEP |
>  					AD9832_CLR);
>  		else
> -			st->ctrl_src |= AD9832_RESET;
> +			st->ctrl_src |= AD9832_SLEEP;
>  
>  		st->data = cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
>  					st->ctrl_src);


