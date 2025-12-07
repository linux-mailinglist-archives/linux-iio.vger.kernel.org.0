Return-Path: <linux-iio+bounces-26917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDD0CAB976
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 20:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6CB3014ADE
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623E8286890;
	Sun,  7 Dec 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2TGVVsD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59B2566D3;
	Sun,  7 Dec 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765136433; cv=none; b=IZK5j1RJmaPxO9Ogo042nk8aLTCCtFR9efEMTSMFa1M9ZH9N6ubnQpjgKHTBCSyUVrAu8VdzIoPmS1uVwicwAWKf3V2hbv1ItQEzMN1me+taNIZuGykd2JQ3tmNIFWVcy/iphCXVGR1pRFcWvZhEAzN+Fm8v7XiOi+r++OeJ14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765136433; c=relaxed/simple;
	bh=hhY3vRagQCkuvtSF7U3kR1yKG+9YKq3sWe6adHVQ4Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRhdfEuXVIHJ+imBqSg2eIMCfCH6U9a+zoOzGCI/hH6k+RRH07B95TorkHmO5UP99U2yOB8/8iDfj81dgVwMe7xr87x4aoBmUlsW43o7yQy4FHOpGT97VnJfQ11OfeWrONFF+s/eIy2uhZpJKqMa3cWO6v/9m3ocY9kWmVtpGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2TGVVsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A490C4CEFB;
	Sun,  7 Dec 2025 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765136432;
	bh=hhY3vRagQCkuvtSF7U3kR1yKG+9YKq3sWe6adHVQ4Gg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W2TGVVsD+wwGXMbhOCZDvQvVN3kC3+HMiU3GwF5Xx0RwO280OxJ02UNvr4nsVfxaT
	 EOATR/SuV/3cvO3rerEfhVMhr6IPygWt5uaxSt6ju0+gk/G3irY4Q2BUpvoV37KLHu
	 4nEgSYSgRMMn0we8+bSwEnPBdEP19Q1QZi7IIby7d7P1rsRY2Yts4mcrzU8UDhpnay
	 hNYefTfi3QmuV3OjmlvDD96QArXD6lyf7+nD4kZpPtetovqbDVECyOEKY+J9V9BZ7/
	 E2AwLGSlwU6BSFGK+UdvWaF/7q7r/FrXmv+hNa1lTZonWo5hpArVOk7h6s5Jo1Guzi
	 Uan6aQv3fFyzg==
Date: Sun, 7 Dec 2025 19:40:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gastmaier@gmail.com>
Subject: Re: [PATCH v2] iio: accel: Change adxl345 depend to negate adxl35x
Message-ID: <20251207194024.34f99a45@jic23-huawei>
In-Reply-To: <20251112-adxl345-allow-adxl34x-mod-v2-1-5b1561eae5a0@analog.com>
References: <20251112-adxl345-allow-adxl34x-mod-v2-1-5b1561eae5a0@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 23:06:38 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> Change 'depends on INPUT_ADXL34X=n' to '!(INPUT_ADXL34X)' to allow both
> drivers to be compiled as modules. The user then can use the blacklist
> to block loading one.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

Applied to my local branch that I'll just push out as testing until
I can rebase on rc1.

Thanks

Jonathan

