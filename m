Return-Path: <linux-iio+bounces-22941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EFFB2B06E
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409741B619C2
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D997263F43;
	Mon, 18 Aug 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETjJCfSH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891B253355;
	Mon, 18 Aug 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541891; cv=none; b=numkoj1OFXTfj8jKmUoybh4k65ZTMw27gVZDM3ttbVuMSSaTntKeU0KcZftO26IE/Tzc9Dz5KEMzYa0NFMUvmZmXg3db1+fF4y+q6KaM4qVmUS4KExfVnHrqJvElzRbv50j+pasB3+7zz6m8dxY7ur/U0QgGlk6HM336WpOvLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541891; c=relaxed/simple;
	bh=5cLyi8DTfy4NnbBzqRxkyKq1dYIisK+mHdfaMdalvEw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCW9kpnvEez/h9q3/gzxbZYtFqmHsDOGEAw29rrb5vUzB/ri5ZakuosCBUpfpaT3Qup0F9hJ8mPmNHhipk73fmIdxz0j2cDFz4awxdbK+d/oPnLk0zOaJRFL/Mn4nB5HpUcV2saAPk3Oc9/bNBxTA/0ytWNO6BGtNiOr+zi5Txw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETjJCfSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21105C4CEED;
	Mon, 18 Aug 2025 18:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541891;
	bh=5cLyi8DTfy4NnbBzqRxkyKq1dYIisK+mHdfaMdalvEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ETjJCfSHSE8Wlc2h8oswX/rSB1rtxn62z/0TeX6ZAxCcKeaD5y/sCJIwQTnu1FHqi
	 g/5Mu2kA9BjXqrq6ei917xWwa+aMn3Ut3FjsZvPL7kulkLbOpY6ezlN59YkkBW0gBV
	 J4+DLLfkVjUsNy+ZxExbNa6cDM/cUkH66JdxJXNhkPi+5TWRm1EwmG9HjJ/MVI7+Lx
	 OOUnNsisvu48qx5rPBGKhKEdasQWzFYG17AMT0oBy5DIFm59WAumN71qHTv6nTa2ly
	 9mS+ivoR/wncrGrJZjY1WUm+ELdNb+fDaRHdTVx9vYmTjpYK70OpQiU8VQD9NrzE9S
	 w+Gnq9gKQWW4Q==
Date: Mon, 18 Aug 2025 19:31:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: iio: ad3552r: Fix malformed code-block directive
Message-ID: <20250818193123.6b960398@jic23-huawei>
In-Reply-To: <a7ce7e35-b761-49c6-9e8c-e3f849fae846@baylibre.com>
References: <20250818-docs-ad3552r-code-block-fix-v1-1-4430cbc26676@analog.com>
	<a7ce7e35-b761-49c6-9e8c-e3f849fae846@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 10:16:56 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/18/25 9:44 AM, Jorge Marques wrote:
> > Missing required double dot and line break.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Hmm. This doesn't feel like something that needs a rapid backport
but the generated html is rather ugly without it so I've given
it a fixes tag. 

Fixes: ede84c455659 ("docs: iio: add documentation for ad3552r driver")

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

