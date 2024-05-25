Return-Path: <linux-iio+bounces-5292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA97F8CF02C
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181A81C20F3A
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C38E86120;
	Sat, 25 May 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHvxYa/P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1AA487A5;
	Sat, 25 May 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655493; cv=none; b=s6hna93zNHKL9EI6llR+fjS+0EFqc6Qafd8fdumk2rf2m40tkbzsVUGgdd+ZiW9vuHxwnAj39cVh9HoDqeC7lOjDB8v2nh/JcC3fz0ghSsol0HC1J9tSDEQUMwvVI2BQInaio+chZ2CYpD5pilR34k4EgdhFoGQFlyOqCQ2L910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655493; c=relaxed/simple;
	bh=ARjbJw+jQ2X38/LEv34uPIjrizpX07evBtL7LyQ2dXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlE0Zz+jC+LUIpaGhGhK1ob6v2nYkJlz+6pOHbBxjMyTwZyeGLRp2KGK7UfZ8KDmInSr4BLQx90CEgk0ZoMHIElQUtlhUx4czC48c9Yiyve13OWD4vqKXfbzSDLfMHNUr+u+cJeXEceamWZZxaEKvp5OsntjOBTUz20KDDNlLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHvxYa/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B15C2BD11;
	Sat, 25 May 2024 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716655492;
	bh=ARjbJw+jQ2X38/LEv34uPIjrizpX07evBtL7LyQ2dXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KHvxYa/PmDp6e6bKLvblDWmCFHdTWuN0bba39OZZ790rFXa43HgVnOS8kfRVsMFJO
	 nEK3r4DBzfb2Ttekwp3vzO4P0TrGDmvL4uw5XMXEPodwQDnbZKSE2vfHT2FvwQnvJR
	 93OJdLV6mf1uRKfVWM3Ry2N2ah7K+0FE5yrgdlM0forjcMwiWTQuehxBy3lEEmyH2Q
	 CZ7vCl0sRbnqJ7THJEyJ6tUevxXlO5dsakXu2uzNVYsd6EpihrQgr8rkgj/Qzq02EF
	 PvNo6RAzMmkOL50NGzD5vaJpBboECPKoYGQxCRmBPNGCJVV3UXMWCToWu2zlGFrNqQ
	 q08iE/6Qp7R/g==
Date: Sat, 25 May 2024 17:44:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH 0/3] AD7173 fixes
Message-ID: <20240525174440.49deb37c@jic23-huawei>
In-Reply-To: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
References: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 11:45:38 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> This patch series adds fixes for ad7173 driver that were originally
> sent along AD411x series. To ensure that they are included in this
> current rc cycle they are sent in a separate series with the Fixes tag.
> 
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Applied to the fixes-togreg branch of iio.git.  That has been rebased
on char-misc/char-misc-linus post the char-misc pull request going upstream
but will be rebased again on rc1, probably on Monday.

Jonathan

> ---
> Dumitru Ceclan (3):
>       iio: adc: ad7173: fix buffers enablement for ad7176-2
>       iio: adc: ad7173: Add ad7173_device_info names
>       iio: adc: ad7173: Remove index from temp channel
> 
>  drivers/iio/adc/ad7173.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> ---
> base-commit: 5ab61121a34759eb2418977f0b3589b7edc57776
> change-id: 20240521-ad7173-fixes-4e2e5a061ef2
> 
> Best regards,


