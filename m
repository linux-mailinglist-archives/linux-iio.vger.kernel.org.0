Return-Path: <linux-iio+bounces-3282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E686F630
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBAA1C220D2
	for <lists+linux-iio@lfdr.de>; Sun,  3 Mar 2024 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B26BFB5;
	Sun,  3 Mar 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAdkCdBR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748251E499
	for <linux-iio@vger.kernel.org>; Sun,  3 Mar 2024 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484263; cv=none; b=Y2LCKANr9FPawlwD8LUZgyn8AnrCGvPIYyt0u8sDa6FeP30+UU/WaTXD1Zke9bsYKejTV/QmPyV1AKFQoLTs8KLviUat0LTMj8tCndncp3LWS2Y0Ji1KgtT5kO75g6O4aDpKwTmS8GSel6wqTBowqgQnUj/xI/GHhunRCWQfQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484263; c=relaxed/simple;
	bh=7l/8Rwlm4hea5NYacImvS2b5zcMcrqvxbs2FEOj2wtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVu+kbHgLMMlnkjgDYgxjgLDe5kV2Yv/OJwJ2vhgieA/I5VVyrvIZZYlMwW8moUQT9oR3E6i3OoRmhTur3aHf0bbi2JSwEAfWAtPqD72va0XvI2CmnFQP/aa2Ace45tXn4vtHaKoXgbDw+EDh9MCVrUEC10v7Jw9/MfJmex6VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAdkCdBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B0C433F1;
	Sun,  3 Mar 2024 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709484262;
	bh=7l/8Rwlm4hea5NYacImvS2b5zcMcrqvxbs2FEOj2wtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oAdkCdBRQXJIfhQZaMf77Ag5/+s8VitkvTR4PARVJvz9ZNA/W9GL9i8Xtg6gXHZTN
	 dhjIkiLIfjQxncFGXEEAyKfJOvXsE27LjFAZ+2uyCZ3ABGjoWl3i3e2bqMXjRhY6Dm
	 t8gecY2/z2YIb/uw50gbCYahxOBYGLUoXCzM+HjvShZpKAc02G1mRk7EbtUMTAQMLM
	 ROTSGlzwt+WN7aRrEX4TMDCyxPPKr4N88Ip1oRiCX2r4Wo4vwLo5erPAv2Id+eP3pQ
	 dlBWsQfOWXb/YJ/+7LT7eST3PIdgSltKy9uFVuNN0w/i74RoJ4zFiC0iQ3WRy3r6x5
	 3LjYJwmlNv4nQ==
Date: Sun, 3 Mar 2024 16:44:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH 0/4] Add WoM feature as an IIO event
Message-ID: <20240303164410.6b7cb206@jic23-huawei>
In-Reply-To: <20240225160027.200092-1-inv.git-commit@tdk.com>
References: <20240225160027.200092-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 16:00:23 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM (Wake-on-Motion) feature for all chips supporting it
> (all except MPU-6000/6050/9150). WoM compares the magnitude of
> the current accel sample with the previous one against a threshold
> and returns an interrupt event if the value is higher.
> 
> Report WoM as an accel mag_adaptive_rising IIO event, add system
> wakeup functionality if WoM is on and put the chip in low-power
> mode when the system is suspended. WoM threshold value is in SI
> units since the chip is using an absolute value in mg.


Adaptive thresholds are normally used when a threshold is based on
some offset form a heavily filtered version of the same channel (often
with filter resets and other nastiness)  It's an obscure hack we added
because we couldn't really get these to fit with another scheme.
This seems simpler than that from your description.

As it's just against the previous reading and I assume the chip
is in a self clocking mode during this, it might be more appropriate
to use a Rate of Change Event (ROC).  There are references to
this being a threshold on highpassed sample, so I guess there might
be some filtering to make this messier? 

The control of a roc threshold will be a little more complex as
you'll need to take into account the sampling frequency.
Advantage is you end up with something easily human understandable.

A human doesn't want to have to figure out what the right value
is for the particular frequency they are sampling at.

Jonathan

> 
> 
> Jean-Baptiste Maneyrol (4):
>   iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
>   iio: imu: inv_mpu6050: add WoM event inside accel channels
>   iio: imu: inv_mpu6050: add new interrupt handler for WoM events
>   iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 523 +++++++++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  33 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  17 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  70 ++-
>  4 files changed, 541 insertions(+), 102 deletions(-)
> 


