Return-Path: <linux-iio+bounces-20632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80100AD9C58
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC193B9FE8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 11:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E271F4706;
	Sat, 14 Jun 2025 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co8Utudz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27DC156677;
	Sat, 14 Jun 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749899199; cv=none; b=XktjVUcj0iCp8ErEvhqh9gqmz5+p0RfvKwerkg2/JYFmd7/zejgyMvE2xQ6cRHdquACTRww40BsRHXDhueTSqk3BRwNAoGkmJ0B80pX5fEMkb4KQ26FQhLCSoIypBfkTZ9nYXi60+xJyu7PcYmolGUtZTbl6Lf4rhUetH1ttQU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749899199; c=relaxed/simple;
	bh=hUeZpi//dDvfH/JYOCiRdX5UhC5w0EiRfTwFT93H53E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BuDYwP5EOhuuXkyht5YEVNj9wAN8/mf78cYH8GYvtp/1+iquQ1X67jYoFEGTl1XWu+1K8FqL5/nlkzzq0A+ajaQlMr4+2ngvNyJuq+t62Gogj+xKs4NvHcEOcJY/guWuueEBQG7r20Rdjuq5er7lUb1HEkeoPnGT+BMV2SZX3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co8Utudz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BB4C4CEEF;
	Sat, 14 Jun 2025 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749899199;
	bh=hUeZpi//dDvfH/JYOCiRdX5UhC5w0EiRfTwFT93H53E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=co8UtudzfaW/6QLBo7WRmx9a6StOAHC7VHOjwXPhZPiRWhDti0BbtrkMAESJhXBxD
	 uBM6NbIcBoA7X8v3mMPfWTevjaRRMDDClOwoXh/VE5WB7WXe+64Fage7QEzTLYIRSS
	 07hiDaUlVMHFl8wSJZms7REYMbZyT9xXqUTVCrXEh2tV/nAbnk+HSNRjH3nGk8R103
	 BSfn/j6K50ZCbOpAdNDsyEESq3yJoHpz8RdZ3TNbOMxNqZ1LzgS7pmivZ9JXSqHdR8
	 QqX5RCaDK/8MXc8vtlNmPYy3fdFnQYlaWlQlQbkMXG8odMWS/+m8KDH+NemFqp6TFx
	 qEzpMOtT00vrw==
Date: Sat, 14 Jun 2025 12:06:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: chuguangqing <chuguangqing@inspur.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jean-Baptiste Maneyrol
 <jmaneyrol@invensense.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/10] iio: convert to use maple tree register cache
Message-ID: <20250614120631.0361c612@jic23-huawei>
In-Reply-To: <20250611085838.4761-1-chuguangqing@inspur.com>
References: <20250611085838.4761-1-chuguangqing@inspur.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 16:58:28 +0800
chuguangqing <chuguangqing@inspur.com> wrote:

> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
Given most of these have fairly small regmaps I doubt it makes a lot
of difference.  However, I'm fine with changing them just to avoid
cases that will get cut and pasted into new drivers.

Applied to the togreg branch of iio.git and pushed out as testing
for some basic poking from 0-day

Thanks,

Jonathan

> chuguangqing (10):
>   iio: chemical: bme680: convert to use maple tree register cache
>   iio: dac: ad5380: convert to use maple tree register cache
>   iio: dac: bd79703: convert to use maple tree register cache
>   iio: health: afe4403: convert to use maple tree register cache
>   iio: health: afe4404: convert to use maple tree register cache
>   iio: imu: icm42600: convert to use maple tree register cache
>   iio: imu: bno055: convert to use maple tree register cache
>   iio: light: isl29028: convert to use maple tree register cache
>   iio: light: ltr501: convert to use maple tree register cache
>   iio: light: opt4060: convert to use maple tree register cache
> 
>  drivers/iio/chemical/bme680_core.c               | 2 +-
>  drivers/iio/dac/ad5380.c                         | 2 +-
>  drivers/iio/dac/rohm-bd79703.c                   | 2 +-
>  drivers/iio/health/afe4403.c                     | 2 +-
>  drivers/iio/health/afe4404.c                     | 2 +-
>  drivers/iio/imu/bno055/bno055.c                  | 2 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ++--
>  drivers/iio/light/isl29028.c                     | 2 +-
>  drivers/iio/light/ltr501.c                       | 2 +-
>  drivers/iio/light/opt4060.c                      | 2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)
> 


