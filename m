Return-Path: <linux-iio+bounces-5291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4F58CF022
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A846281C34
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEA184DE3;
	Sat, 25 May 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL8DAVf7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882185C48;
	Sat, 25 May 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655305; cv=none; b=PPidJGxxD9Vwq8nFB5Y4Fd9P6FoAfSQCs4KMlhkd8fDH9F1Oukxwohl9poUs3+ZwWLwpDR7+O12rSIa1hcCsv1t+3c6imFIbvuTEu0IMXaJIuuAH5kkTK+obkKN4VIi9r5ZHIen3a+cQIVkzUydhhBhjtS0bAdmtWz53f4ARAdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655305; c=relaxed/simple;
	bh=H6n28H+HtDv/m+Z1+XAALfhcjV4LjMbqOBUaBrxM3Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JwvEM7tIFPTyQpqcJyZ2l7b65bM9E7dA+MgO5OPO8Bv8kvY6M1VqiEb1L9wtZjsfQOviy9cVnWu2Y2GplKSJMRAmo3qFmijJDYYSrrrXFLB2bZKX9Qs7d42s6OjH4VzKlE1y6CHqZXeNystrIZEB+NH2wS+UASSoWg/2uUQhS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL8DAVf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ADAC2BD11;
	Sat, 25 May 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716655304;
	bh=H6n28H+HtDv/m+Z1+XAALfhcjV4LjMbqOBUaBrxM3Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EL8DAVf7nI3oseEWJ/I7FAvknOv5mdFSVP1N2cjZjH3S5EvFYJAotPLRF9Tq5Ulzt
	 aIX5ZCUokZwwBP7CLzDXUuFtgZeQkhuxXWRZ57LHB0Ueczstp65nkQidiBmCfU6vuN
	 mv40CdFbDOAbkkWrAk5MYSvChbkRgi5HTlPVXrAZ0yHZbFPBlMNifVwCzV4wpohyQJ
	 axIp+MsCOwtrRg9Ikskfe/2mTWqfia8d5TWQxgSK9aWEngPE9nMziHYNPLBHqbMccp
	 N6k0535Xd4GjRu5M32FMy+F7o18mDhPy4aHmmA8EYXJBGP8QZI8afj12wdIp6O60hf
	 6HIBHVH0dEv0Q==
Date: Sat, 25 May 2024 17:41:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux@treblig.org
Cc: lars@metafoo.de, marius.cristea@microchip.com, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] IIO dead struct cleanup
Message-ID: <20240525174133.4d70bb0b@jic23-huawei>
In-Reply-To: <20240522230457.478156-1-linux@treblig.org>
References: <20240522230457.478156-1-linux@treblig.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 00:04:54 +0100
linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   Three dead structs to cleanup in iio.
> The bmi and pac are very recent.
> 
> (Build tested only)
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> 
Series applied,

Thanks,

Jonathan

> Dr. David Alan Gilbert (3):
>   iio: accel: bmi088: remove unused struct 'bmi088_scale_info'
>   iio: adc: pac1934: remove unused struct 'samp_rate_mapping'
>   iio: light: rohm-bu27034: remove unused struct 'bu27034_result'
> 
>  drivers/iio/accel/bmi088-accel-core.c | 5 -----
>  drivers/iio/adc/pac1934.c             | 5 -----
>  drivers/iio/light/rohm-bu27034.c      | 6 ------
>  3 files changed, 16 deletions(-)
> 


