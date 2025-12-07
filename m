Return-Path: <linux-iio+bounces-26891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EADCAB6BA
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75A243000932
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24117212554;
	Sun,  7 Dec 2025 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPvx+qAS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393902749CA;
	Sun,  7 Dec 2025 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765121823; cv=none; b=iuCnoNm2iJbdi4bmDRunFcXTWxC9TzJ5vucVH9sZNB9qV6CAF4HIFWPzU3O01R8MKHHbM+Oj9tbO5T1otK4oynar0eYIC+ySimXLEZTzoPm/z5iNGx5al2YCz9r8YmT9KTMDrGNs6f4p/WqOlRdYw/qTDK+2kyOpny5idQSzQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765121823; c=relaxed/simple;
	bh=qOzR8k3HGDJRB2FCPi37WFJ+Gpj/ggY4wKKUY8GQgt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU87Gndn5DtDpKpAM1HS/V1lkIxaOsMc2l4uLI13OR6V7L8iQewHNsa6g0KrX3BuGTVMNk1Xi3CbCAltVFdrEX0C28e22nTkt1Yw1/vwrVW6RaT0wJQ3Vk2OYuiz/dS/fX+RNCJVC2WwAif3Nb2980K+d4r3+Ak3KcIwwCZfJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPvx+qAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8463EC4CEFB;
	Sun,  7 Dec 2025 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765121821;
	bh=qOzR8k3HGDJRB2FCPi37WFJ+Gpj/ggY4wKKUY8GQgt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jPvx+qASuv+7wImgRU5I+fU1MLBpM0ckY7imOuOKzzHMuswyf41segxj/jszKWIIz
	 B8UrGB+f9cAtj5OD3T25Cu64BAmSwr1uPbCe5NXc+LiyWwd99blpJVH+ABRNBp7kb9
	 z0pg9GLXKpU9XbV0RPa32fYOhVpZtkNLKAuXz2G1s3XF05PYl9Vxu7TObVeTjExisu
	 tNiXJlOQTc6G7gxrDED0q4Z0stpc59YS/g9/YRr1luoeQfee5Qmn8QbT6B8JiGEk/z
	 8kj1hwrQDaELOa0zlZntOz/QAS5ScyqmVzZJHApijL0Mz84+ctSMVrrWcJC8aQfN+L
	 osMgDn6NTivvA==
Date: Sun, 7 Dec 2025 15:36:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 8/9] iio: imu: st_lsm6dsx: add event spec parameter
 to iio_chan_spec initializer
Message-ID: <20251207153653.1abde6d3@jic23-huawei>
In-Reply-To: <20251201100018.426749-9-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-9-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:17 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In preparation for adding support for more event sources, add to the
> ST_LSM6DSX_CHANNEL_ACC() iio_chan_spec initializer macro an iio_event_spec
> array argument, so that this macro can be used with different arrays by
> sensors that support different event sources; change the st_lsm6dsx_event
> struct declaration to an array (renamed as st_lsm6dsx_ev_motion) so that it
> can be passed to the macro (and opportunistically move it from the header
> file where it does not belong to the C file where it is used).
> In addition, remove from this macro the channel type parameter and
> hard-code IIO_ACCEL in the macro definition, since all callers use
> IIO_ACCEL as channel type argument.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied.

Thanks,
J

