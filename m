Return-Path: <linux-iio+bounces-9289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879649702EB
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FFFE1C2194D
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1615D5AB;
	Sat,  7 Sep 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1DueVmx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47B15575B;
	Sat,  7 Sep 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725722675; cv=none; b=aHPv7JQ5AQKRn+0B8fccEhIoOZGFT8Uax33LFNgtI90zKIngSYOKPLsgLwUpmJ4bhbt3+zsyWVev/+jgPs6cj/Qw/yNsYBh18Aho/YOMYd0mNmA+HEv2YPvEkEkQX3EU3Nh/LDgVS8/I88A6x3tYwwXdmAgVbobxFXaFWYz4Zxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725722675; c=relaxed/simple;
	bh=jhLXQJawWBDkbFggdpNW48Hr8s/TuAp/SJeXz7sXQXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/KtMfILbwwHO6/Hj7XGGw6Y48Imd2guYEyfJTa8xHqNfB/kD/5LNCfRuso16M8/OUoO7BcIuxyEprdG/I7or2M2e/hjpdKcbk4JzDJSzrfKj5mmfntMXWrllNfoG5+FjI3FF/sroOajIec6u1Q7JhPEE3SuGHXAhba24DznVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1DueVmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA92C4CEC2;
	Sat,  7 Sep 2024 15:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725722674;
	bh=jhLXQJawWBDkbFggdpNW48Hr8s/TuAp/SJeXz7sXQXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q1DueVmxvTn83qsAbaSAOBL1Ok7KCPBoK/B3+dkaj0MrhhBCvyLbRicOgGVhJ79Re
	 4Sx6hgoaytLGIcZV7mPCqB5HCGI6GrBGIcluHE/3oSXWauoa+C5+BPG+53w6TTLvhs
	 xDJtRePvg4NjOwhpNGOIU+yoVyOCky1ofRhuu6ltpiJbr1c6CqMr5NowqMjcytB8Ki
	 kvPb9CPC3dI54ElUA7KbsBljdWoFV6QatrotdmzS/FayrFZMVz34qUVryL+IkTDTVI
	 FOhfNnEPAdeu4quLWjt5swOA8rSwNE20T1zxRcfPuB+C7B+tOi37FgvkHHC1rAeS3P
	 fxTMEedBIvOhg==
Date: Sat, 7 Sep 2024 16:24:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH v1 0/3] iio: reduce acpi.h usage
Message-ID: <20240907162428.6798ade0@jic23-huawei>
In-Reply-To: <20240903212922.3731221-1-andriy.shevchenko@linux.intel.com>
References: <20240903212922.3731221-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 00:28:19 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Reduce acpi.h usage (partially, more will come).
LGTM
Applied to the togreg branch of iio.git and pushed out as testing.
Probably next cycle material though given timing,

Jonathan

> 
> Andy Shevchenko (3):
>   iio: imu: fxos8700: Drop unused acpi.h
>   iio: proximity: sx_common: Unexport
>     sx_common_get_raw_register_config()
>   iio: proximity: sx_common: Drop unused acpi.h
> 
>  drivers/iio/imu/fxos8700_core.c   |  1 -
>  drivers/iio/proximity/sx9324.c    | 20 ++++++++++++++++++++
>  drivers/iio/proximity/sx9360.c    |  1 -
>  drivers/iio/proximity/sx_common.c | 21 ---------------------
>  drivers/iio/proximity/sx_common.h |  4 ----
>  5 files changed, 20 insertions(+), 27 deletions(-)
> 


