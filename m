Return-Path: <linux-iio+bounces-7977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE9A93DFA9
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 16:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA4B9B2104B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398A16F85A;
	Sat, 27 Jul 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LifJwpNq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846B116F289
	for <linux-iio@vger.kernel.org>; Sat, 27 Jul 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722089197; cv=none; b=nQvew6rAIiW/Lt/jUFwGv2uBY/rmwJFIpCV14+7EhJr4Q90XS8IJQEZU1b0ExzcS3QczS53TcV3vmPU3dNDtiZfpEXrCEX5p1yzMz/Ez2UrV2wsdr/mUOi1Y+p5ubQxPe2J0/dxIDjVJkpRMI88aQPf87LZf+Ka54bCLRB4eUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722089197; c=relaxed/simple;
	bh=P0pRAyeQ7+V4+5jR3Cg7ELK5mB7JPXPNLuGWE8Jj6Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LldE6KtKQJV0pMl+MtqvRVl6So+iSHyemp6MVLejc9BRVDnOoShfH+zHee01tenFOlxUROgNyXVQEgOYjwzOpsiSQadCymaojEArdagYzK1vAbK/gRFCWJoIfwgX5Pl4gLgn7vnWy5qm4i1kykomYf3LqKfj26zSxgDgpfmmXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LifJwpNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EB1C4AF09;
	Sat, 27 Jul 2024 14:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722089197;
	bh=P0pRAyeQ7+V4+5jR3Cg7ELK5mB7JPXPNLuGWE8Jj6Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LifJwpNqd+gqXGRDLcFbzG4aepRPPlwR7RvYoIBejnkl4bZuHMHQM4J+CpDelSvWS
	 NdukJRWbqKr614uwny40zqoAzQ/HeoCxE4oefD0SR1IMqvYOHe5UxAWf1G8NgcnXuZ
	 AbR3XthE0klUM3epq+6Q6PpAWj+/7ZdGI+SiPTDiuuFgjEiHAC185pYSU8hRI3UTrh
	 t6hDiYlZQ5aDpQe1VwxEOWbTM298bcs3D1tkHhc6TCUHISuR2JNVXg0IZj1OKsQgrT
	 8wLNpigw4Z+bvBBciUOoYw+bnDFuXtjGoWA6hQ6ExL4lMVSQEIB/Df4g747xEVtWCj
	 b52UaMyleCP7w==
Date: Sat, 27 Jul 2024 15:06:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH] iio: buffer-dma: Move exports into IIO_DMA_BUFFER
 namespace
Message-ID: <20240727150630.41e93c9a@jic23-huawei>
In-Reply-To: <20240726-dev-iio-dma-buf-mod-namespace-v1-1-8877cfe7f68e@analog.com>
References: <20240726-dev-iio-dma-buf-mod-namespace-v1-1-8877cfe7f68e@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 13:31:15 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Avoid unnecessary pollution of the global symbol namespace and move
> global APIs into a specific namespace. Import that into the places that
> use them
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied to the testing branch of iio.git which will become togreg after I rebase
on rc1.

Thanks,

Jonathan

