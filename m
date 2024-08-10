Return-Path: <linux-iio+bounces-8396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2394DC3F
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 12:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C8B2827A6
	for <lists+linux-iio@lfdr.de>; Sat, 10 Aug 2024 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1275154420;
	Sat, 10 Aug 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAs+QjlF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3393EA69;
	Sat, 10 Aug 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285210; cv=none; b=FmLegjGBdOrvk4pRCq6wv3jHl0Kba/h8cYnnvBkA4hiJyYi+F5G3G2dAbJopDubAZl/YuJcuTL7GKUeZ/cN7ZS0XjznQhqwzDe9LAThKB3NqeC5dxKykvW7BcKJYcWsFiO+0YdDRMRfAZ0EWycf3ybLrmhUVye/EiKNuGgIUhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285210; c=relaxed/simple;
	bh=mjqO8EBvokap4+aLVp66lu/jMfuucpNERrNXmYuk1N0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5S8DNV3+wULfbXA1qzNl3MeQnRcpaDUdAv6I7cmTJRXcTbLbBoNjWZA7YLoFXdNq2rUG3Iw/SLt4HplkvkvHZEZdZjyzTQ2BZlmD7YXdrf8enSmgZ379+lTdN3346GJih6KLgCXZHPLoWFGSGMsCES1o+0AFRWB8KsZhlfPhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAs+QjlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12D8C32781;
	Sat, 10 Aug 2024 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723285210;
	bh=mjqO8EBvokap4+aLVp66lu/jMfuucpNERrNXmYuk1N0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RAs+QjlFUHneJvAQtdR3Er7XUE6VfSEdRszBU7smEzDav/9EhhrYE78jFU//rPeMF
	 vA+05opKm9aeFSuq0JmkJeyfGSdKYN4jqymrq9zPGqIcYpLoqveDuYCavkj7UB+Q8n
	 dfx8rsMVRU7XVhs9EIbsNJox/hrhtMO83bbrgmh8Wdwf+UGrRnwSK6Xv+YX31SMBj/
	 AxeLBqr4HL5vTFxT4lqvneubwtF0EDc91mKy16d2KEBmS/LdqQT6jtaZJSA4Wlh+e1
	 qg2iaaNzfub7u1eCzo1wl9TlV/MtYScigrrFEurp1GSeLSR7nLcLWZ/Oz8LFUUtrU1
	 hXkDKRHcP6WmA==
Date: Sat, 10 Aug 2024 11:20:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jagath Jog J
 <jagathjog1996@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>, Jonathan
 LoBue <jlobue10@gmail.com>
Subject: Re: [PATCH v3 0/2] iio: fix bug with triggers not resuming after
 sleep
Message-ID: <20240810112003.3e0b77a5@jic23-huawei>
In-Reply-To: <20240807185619.7261-1-benato.denis96@gmail.com>
References: <20240807185619.7261-1-benato.denis96@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 20:56:17 +0200
Denis Benato <benato.denis96@gmail.com> wrote:

> When a device enters an idle state (for example ASUS RC71L with s2idle)
> and an iio driver has a trigger attached such as iio-trig-hrtimer,
> after resuming the device the trigger is not triggering data acquisition.
> 
> This patch series solves the problem reliably and is well tested after
> many cycles and many reboots.
> 
> Closes: https://lore.kernel.org/all/31d7f7aa-e834-4fd0-a66a-e0ff528425dc@gmail.com/
> 
> Changelog:
> - V2: patch 2:
>         + Simplify code
>         + Remove unneeded code protections around SET_RUNTIME_PM_OPS()
>         + pm_ptr() to let the compiler drop bmi323_core_pm_ops if !CONFIG_PM
> 
> - V3: patch 1:
> 	+ Add pf->irq=0 that was accidentally left out
Dropped v2 and picked up v3.

Thanks,

Jonathan

> 
> Previous patches obsoleted:
> https://lore.kernel.org/all/20240727123034.5541-1-benato.denis96@gmail.com/
> https://lore.kernel.org/all/20240725002641.191509-3-benato.denis96@gmail.com/
> 
> Denis Benato (2):
>   iio: trigger: allow devices to suspend/resume theirs associated
>     trigger
>   iio: bmi323: suspend and resume triggering on relevant pm operations
> 
>  drivers/iio/imu/bmi323/bmi323.h      |  1 +
>  drivers/iio/imu/bmi323/bmi323_core.c | 23 +++++++++++++++++++++++
>  drivers/iio/imu/bmi323/bmi323_i2c.c  |  1 +
>  drivers/iio/imu/bmi323/bmi323_spi.c  |  1 +
>  drivers/iio/industrialio-trigger.c   | 27 +++++++++++++++++++++++++++
>  include/linux/iio/iio.h              | 17 +++++++++++++++++
>  6 files changed, 70 insertions(+)
> 


