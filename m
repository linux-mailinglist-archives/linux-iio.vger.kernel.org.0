Return-Path: <linux-iio+bounces-4911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326DA8C1033
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 15:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AD81C229F7
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8906815250D;
	Thu,  9 May 2024 13:13:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529615279C
	for <linux-iio@vger.kernel.org>; Thu,  9 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260414; cv=none; b=Hy0+4mPCZ41N+yiZz8YO5B4hy5QAAHcfBAulMLibtb00vWsZ45/y4dkKQN0vc6CTX2AwYcuW5d7z250ruOgxqK+MKgAvKjLT+GdZqSjNdTazVL4SfcbE5TcuQpOTUWemInmE3epjGRayBKbHGYSOcp8FDTWn90PY2pGV8S7KCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260414; c=relaxed/simple;
	bh=xHpFBlv53Nwt0GiZ9lqlDTEdIgEYX00qGzSU6Nx3jLM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDlb0L9JS3hikNUWtpSIeRIA+OMXGg265NC2ALbzqP+8gAAjTAXQvPpH2qC/WkQ1djhk6/jNYdGLceYdoGj4REhD4R/ceGReS8OtVG2IELVp6fBkocNdVJILP2qgVtEFT8gAshAY1/xSR9qu/pCS14fbQbsfUIfoWwEWhcnmm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZsnZ3FDXz6JB4V;
	Thu,  9 May 2024 21:10:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C7108140C98;
	Thu,  9 May 2024 21:13:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 May
 2024 14:13:28 +0100
Date: Thu, 9 May 2024 14:13:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <inv.git-commit@tdk.com>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH] iio: imu: inv_icm42600: add support of accel low-power
 mode
Message-ID: <20240509141326.00000684@Huawei.com>
In-Reply-To: <20240507103056.291643-1-inv.git-commit@tdk.com>
References: <20240507103056.291643-1-inv.git-commit@tdk.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  7 May 2024 10:30:56 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add channel attributes "power_mode" and "power_mode_available" for
> setting accel power mode (low-noise or low-power).
> 
> Differents ODRs and filter are possible depending on the power mode.
> Thus make ODRs and filter dynamic and check values when applying.
Hi Jean-Baptiste

No Sign-off?

We have never provided this sort of control because it's near
impossible for user space to know what to do with it.

Various attempts happened in the past to provide enough info
to userspace, but didn't succeed because what low power means
is incredibly chip dependent.  As a general rule everyone wants
low power, but at 0 perf cost :)

What are the results of low power mode? Normally it maps as
something we can enable when some other set of states is set or
automatically control based on how often the device is being accessed etc.

For example, what do we loose by choosing this mode for everything
below 200Hz?

I see there is some reference to 'low noise' - what does that actually
mean for this device? Is it oversampling or running lower resolution on
the ADCs?  If so those are the things to look at as ways to control
this.  Choose lowest power to meet a given set of requirements.

Jonathan

