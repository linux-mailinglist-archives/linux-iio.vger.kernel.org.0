Return-Path: <linux-iio+bounces-5615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02E8D754C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08271F21A21
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 12:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002BD39FD8;
	Sun,  2 Jun 2024 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVzsVrmF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB613BBC1;
	Sun,  2 Jun 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717330935; cv=none; b=VqvENPPLC0taRFh7fFKVA9movcYVCuJCajE76EfGjyy6ymbCL7iCttDdjNaomxi+vi94gwvMWXj2tYA/cs/deQ/M/GyEyIbXK22FJrs6wE3oweyjjAS01zQltZRuQ/C4V/29yWDlSS6pop3bZryBfpQ/3j30gsIDFtqrln4ad64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717330935; c=relaxed/simple;
	bh=Oz+eUMzrFK1pqjnUuwR3DSFiO4JwSF1BbKfu9Qe9I9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaSUEuGl3ISXcL4yV76/Cl1FWRK80pAOma9OEUveam3kb1T5e1yVpnS1psxwi6y4VdGuKQsc5sulBzWs8HfImz+PDFvasXfFXBparxDCvn/I2LduL604r3UYgWLNmbiocu6+Sp+KK9ZyiOEp2HQRux6B/tQ9MdJHHRWtsNfQtmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVzsVrmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D57C2BBFC;
	Sun,  2 Jun 2024 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717330935;
	bh=Oz+eUMzrFK1pqjnUuwR3DSFiO4JwSF1BbKfu9Qe9I9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZVzsVrmF3SitwiP2xiLG3lZr2i19mUCKMFENb0qG8Wb2dTqO/o+sZgYCD6CxN5jsa
	 hXjghpCv5+aO+YkIxGX//4sCBFaO2TI4M1B7+2LL1NzLwzRk7UXvk7Prsz5Wt+Hr9j
	 HNm8/WKPKwnoDkSuHWhMpHCrQmXhL2pMsTZLXUSfci2BDJkc+KJklegMCGcFOKUNr/
	 G0YXJjT7ETygRQc3qG3A2dedj+TBBZOIV83gwoEfF7fGn/AWAmeb1S0ED6K93pS3xK
	 tTZKm2EdyrVJtbQE1KCtaA9auJJtJEs/h0TqIsWkEV7/mcL+5aamJj3a35AiGsDf1Z
	 wtqfcava8hfHQ==
Date: Sun, 2 Jun 2024 13:22:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v3 5/5] iio: adc: ad7173: Fix sampling frequency setting
Message-ID: <20240602132204.385d689a@jic23-huawei>
In-Reply-To: <20240530-ad7173-fixes-v3-5-b85f33079e18@analog.com>
References: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
	<20240530-ad7173-fixes-v3-5-b85f33079e18@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 15:07:53 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> This patch fixes two issues regarding the sampling frequency setting:
> -The attribute was set as per device, not per channel. As such, when
>  setting the sampling frequency, the configuration was always done for
>  the slot 0, and the correct configuration was applied on the next
>  channel configuration call by the LRU mechanism.
> -The LRU implementation does not take into account external settings of
>  the slot registers. When setting the sampling frequency directly to a
>  slot register in write_raw(), there is no guarantee that other channels
>  were not also using that slot and now incorrectly retain their config
>  as live.
> 
> Set the sampling frequency attribute as separate in the channel templates.
> Do not set the sampling directly to the slot register in write_raw(),
> just mark the config as not live and let the LRU mechanism handle it.
> As the reg variable is no longer used, remove it.
> 
> Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

