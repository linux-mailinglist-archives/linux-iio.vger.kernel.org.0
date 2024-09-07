Return-Path: <linux-iio+bounces-9292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC72F970303
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F08B1F2236E
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520A15C131;
	Sat,  7 Sep 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGs29GwU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D01157494;
	Sat,  7 Sep 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725723923; cv=none; b=RzC9qIr1o37+7qQOeIKXnqGnwgcl0sC+nAo63algMlEA+F0ql+XjThYSaANdOYr+JG7fcTDQNuHMr8fm26NWvZXO5CiqhNi1WiwZoNqnw1/9KgR1fslEkbv86ejLm+asl1MHda7FelFDAAJf9gDafFiPSDHRqnpusirEEZqs3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725723923; c=relaxed/simple;
	bh=91ReaGq7VNdGSt19Yaipjsils2A9zQYc0WAuFjzbXSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qk78tE+ML3TQtjAtkaBfEN8OiVsY34Gl2HEBfJsZHOLmPelqrIVcV29f9Iup/AKirGrlNe9tt7ZFVKmyVNz5GXC2FzB7sUO1isZNUXdpqwf9jwTweV5/sW/XB1tPzSjofUYfqBH3V5DAncg+yco7Em9QRrY0Th+O+yb2XeHCbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGs29GwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B73DC4CEC2;
	Sat,  7 Sep 2024 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725723922;
	bh=91ReaGq7VNdGSt19Yaipjsils2A9zQYc0WAuFjzbXSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FGs29GwUuGunByS3vsM2Md7Ni2WsrlUO0ERPsz2p4/2n2fXcNkEWDea5W0OY4aSxH
	 BEnCZ9cVhTHIPKjNCFo/o+Dv03Nhv0JPSau9z6h0yjbJiraq+9HpYNPFoDme4uyigG
	 3XHY6EV+/9jsSPOOtb4YC60c8rkV23YyhQ+P8E4Jp5bHsZsWScBTST41Tv24OZoBwo
	 rhCE9Qn+52zwNfynerHs5jjWVpmiSNWqG60zAWGE6516rADjRTvxTkxDfx7V1DNbwT
	 BG/DpZ3T7ss5KY1ufdVg/gziFHMgr70wlkt0UwTLe0idCxScA6k+7UFZqP/yv/XLfr
	 /nn7XNWEuh7kQ==
Date: Sat, 7 Sep 2024 16:45:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: event_monitor: Fix missing free in main
Message-ID: <20240907164516.5990ac46@jic23-huawei>
In-Reply-To: <20240904080533.104279-1-zhangjiao2@cmss.chinamobile.com>
References: <20240904080533.104279-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 16:05:33 +0800
zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:

> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Free string allocated by asprintf().
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
Applied, but probably now 6.13 material

Thanks,

Jonathan

> ---
>  tools/iio/iio_event_monitor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 8073c9e4fe46..d0b8e484826d 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -449,6 +449,7 @@ int main(int argc, char **argv)
>  		enable_events(dev_dir_name, 0);
>  
>  	free(chrdev_name);
> +	free(dev_dir_name);
>  
>  	return ret;
>  }


