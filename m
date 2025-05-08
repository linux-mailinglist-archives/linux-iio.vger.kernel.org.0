Return-Path: <linux-iio+bounces-19342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4373AB036C
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDC93BFCF4
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C33289367;
	Thu,  8 May 2025 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9kCDflV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE60288C96;
	Thu,  8 May 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746731636; cv=none; b=mkJNLDeWBzLmjA7Zxcg9DkgUUgf//YqXT7ZMtfVNx3m/u2jjiCAlfHRNyOpl3/PahegqvoczZwdmXjIoXoJmwLk7Tp8VFLvyzYao2/IiCwUg1RT27q5rChCJaqZgzoKmw2I+V/rFGVAvDhc8mNZYgBt/J4pKxR/RCsxqe16ZN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746731636; c=relaxed/simple;
	bh=CK2BuyprwmfYzBmZ7vsS8E/+vFXujjJBxJWgtxSk30Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiDadypM5okZov3JqyWDNg4Yuz6Ih9TvjG6cksGSz7uXpucwmK0vD/KtL+7j/KMVmuQ9gvbn3yjSo7kVdCf4FTd0PmvE1igo5UgFKYGtAb/iSskwfmipzTQq3c44i0Jhnbvf1KuPz46DgNBJ1ssJpKjJ3m1wPmW0hFMy0Fb0OJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9kCDflV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95FDC4CEEE;
	Thu,  8 May 2025 19:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746731635;
	bh=CK2BuyprwmfYzBmZ7vsS8E/+vFXujjJBxJWgtxSk30Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P9kCDflVdlkh6tRc85LKPm3elfqCf2SnO6Ca1TDpX2Wu3VnmtU2cvVCrg/fQ34gIX
	 5KLbHs0z++JWxIPuHWDZT4ATEO/+p3LeCiEzQh6cqELWw3BQUD0nwVyuVK2NG7zbXD
	 5IKC2kxLOseh5AWOXRdmRuT6wQK3+WuonpDlIAwYdSd0kDXPZdNErPNNBfP37lGSIY
	 eJIOolHz+V2k4ZkVhKZFNHhUPyS+p4fqPwDS/ydHovfi2qY+kF85jEiV4+NY/0eEKl
	 KNvtw9Yc7mMuGGTMymyZ+77fg6MdEKUHzVypZQ4tmT0+exUkpqVE8krxByCHZz3yFM
	 ALHWXCY6V/Vow==
Date: Thu, 8 May 2025 20:13:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: admv1013: replace redundant ternary operator
 with just len
Message-ID: <20250508201348.61494209@jic23-huawei>
In-Reply-To: <fbf6c7ef-3680-40ec-8c90-121e6a635b8d@baylibre.com>
References: <20250507134502.254736-1-colin.i.king@gmail.com>
	<fbf6c7ef-3680-40ec-8c90-121e6a635b8d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 May 2025 08:49:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/7/25 8:45 AM, Colin Ian King wrote:
> > The variable ret is being assigned a return value and non-zero error
> > return paths are taken at all stages. At the end of the function ret
> > is always zero, so the ternary operator checking for zero ret is
> > redundant and can be replaced with just len instead.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied.

