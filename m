Return-Path: <linux-iio+bounces-8904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945A09670FC
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8BEB220A3
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680717C222;
	Sat, 31 Aug 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd7TsE6V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EA17B421;
	Sat, 31 Aug 2024 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725101976; cv=none; b=SRFqDU1aA5nE3WvL4ZpbFjWAaLThDiPWASZD1VOc1GUjYtzjhPqTctTxGhrCqgUlLUbq5/dAQcMw+rYVleWbRL9oRcV7bsKcbH+NdFf6dLw748vQjRWXIVFQsg2vDjrr+G0V9XcV+FYDZTJZJlW42JJenGTygbWv7qa72zv+qq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725101976; c=relaxed/simple;
	bh=Jrz3gXm1XjGENmJEvxxnLwbaG2jUawmf6vv3QYFSFfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKLTtf+TmKqUcjfFwTv2qENaGVSs8ZVRa5stoZxWIMNz6C5/XTdPzvkM7Mcj1D+2t8xg6MRYMzK9p0CkdKPzjM/yzEVRUgWrcgABn1C2+LYsIR984rnzha+YtB+vpPPRYBV6m7cR4Sk81qtlWLM26sgTznBYRex4F1RNQZ6VU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd7TsE6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46F7C4CEC0;
	Sat, 31 Aug 2024 10:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725101976;
	bh=Jrz3gXm1XjGENmJEvxxnLwbaG2jUawmf6vv3QYFSFfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qd7TsE6Vi/jjQGUmBMiq4X+eTv/P2JGRlwmDkR0sEgPrVoBdNM7p9bhrlDlK8tEbf
	 fVA0h9XHPUHqdt36sPz15dyrjlguTwzLhRPoTRuHcL0WdC9+kzj4yIcJcAniCiBCbL
	 TCgEM+7mF042oiJy3z+/hu9vg6KnijvZGWKNKtqb6+EcakFd2eA/GVE9o+DKBo2H6X
	 5OvUpypZUyqfk0a0G7CGzicpF45l2MCsxn2ZnpMMBDbWKTu6/QA8U9BT4FRaknXeUi
	 YZrr3/k5dLPqZ9phU3c3E/QPjBVF5gZN4Vl3u6cjBDBtzUkgV52aoVAI7NYJyimv2f
	 i9pBVqMABSF1A==
Date: Sat, 31 Aug 2024 11:59:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: iio: rm .*.cmd when make clean
Message-ID: <20240831115931.596e35fb@jic23-huawei>
In-Reply-To: <20240829053309.10563-1-zhangjiao2@cmss.chinamobile.com>
References: <20240829053309.10563-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 13:33:09 +0800
zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:

> From: zhangjiao <zhangjiao2@cmss.chinamobile.com>
> 
> rm .*.cmd when make clean
Where do those come from? 

> 
> Signed-off-by: zhangjiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/iio/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index fa720f062229..3bcce0b7d10f 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -58,7 +58,7 @@ $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
>  clean:
>  	rm -f $(ALL_PROGRAMS)
>  	rm -rf $(OUTPUT)include/linux/iio
> -	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> +	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
>  
>  install: $(ALL_PROGRAMS)
>  	install -d -m 755 $(DESTDIR)$(bindir);		\


