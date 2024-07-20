Return-Path: <linux-iio+bounces-7755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B693820D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5811F214C6
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE213DDA8;
	Sat, 20 Jul 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egsHOapL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C3B12EBE3
	for <linux-iio@vger.kernel.org>; Sat, 20 Jul 2024 16:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721492101; cv=none; b=YwrBVEJo0hZC9C+DDVMx2t0cub37ZdBIivvqIBrdZS5FzffrxC7/xMN6GmIicIhWTypmXz8Wx3mSo2RDFtM6n/0dXOBc+2FAs0xSebNUgVTw9RScoT+CXnx6M0ISMDZCmGsVQvgnLPLG2EUjyK7hNj3oFk61Pat7S7BSQgSBHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721492101; c=relaxed/simple;
	bh=/5g1QsobQ78H8kQa17zACcnX6hnkw3iyAyTZPTVKj2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1QLqfFUm955FykgZh0wXd26pjLTUI6I1LiV9LLhoKerqhCLmkcVuKYvCr/t2qWlmGfQpl9rguHklDP8jNefOs7HNELv/oDpD4sqK7wea4rG7MNW5BIJ6oMvd7SgsSbvcIj+bVnazYWKaDt7IiU3k7W7Xdvn85w/8Bx212vpLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egsHOapL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108DFC2BD10;
	Sat, 20 Jul 2024 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721492100;
	bh=/5g1QsobQ78H8kQa17zACcnX6hnkw3iyAyTZPTVKj2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egsHOapLInXzi32q8S46KK74WxWmJCipfLd2eJh/hSSA5vVN2wEBgSTGB0Dn8j7MJ
	 Jl2eWXwbxDnq+BdIfr2QJ3STuoKGIp5nbM90EfviBegNdm1EGz4+m3wHdZLxPTsQri
	 wMpjpJqVHq2dHtHPbNdxOAOZVF/0G+F70FLiJaDRJkdz/pMCLC3R2xVK8bA3KQdLfS
	 n/JJLIiFL9YDHIF8SUKjxNjy1YYK4Cwp3i/FkBBqqweH0Do1Ser9+H2qHUyiyQLyVe
	 TU2CTFOB3PlAIuBrEJSi37JDPoJXeii3XmfwOl5DI3rtt8rtXwGIGdzkkxWQ4/QgSZ
	 u59oEOkWS4Vkw==
Date: Sat, 20 Jul 2024 17:14:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, Song Qiang
 <songqiang1304521@gmail.com>
Subject: Re: [PATCH 22/22] iio: proximity: sx_common: make use of
 iio_for_each_active_channel()
Message-ID: <20240720171454.61d031e0@jic23-huawei>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-22-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
	<20240718-dev-iio-masklength-private2-v1-22-8e12cd042906@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jul 2024 15:38:08 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use iio_for_each_active_channel() to iterate over active channels
> accessing '.masklength' so it can be annotated as __private when there are
> no more direct users of it.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
I applied them all to the testing branch of iio.git which will be rebased on rc1
once available then pushed out as togreg for linux-next to pick up.

A few of the functions that got changes were pieces of nastiness that I'd long
banished from my mind so at least I got to look at those again :)
Datashuffling logic is 'fun'.


Thanks,

Jonathan

