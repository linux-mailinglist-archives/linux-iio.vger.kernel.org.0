Return-Path: <linux-iio+bounces-3560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D4187DA56
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 14:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9791C20C83
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 13:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBA618C38;
	Sat, 16 Mar 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YACP471a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F1D2F4A
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597254; cv=none; b=gG40E79s/22GeB1MScf49DIR1W5rBgYipdJ9Rfr6K2R9t+mAcuFpL9EJF1uuKhoqciGRz+HTio0jv7UJBwhSz1FIGKmWEDsOjq9Oz8GgIiuTvlEAw5aGeb1Ob7wP4NF3fsu0Z5/yjRhVZh/LeyFNpKIKFXx/DA3NR4e58L8nOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597254; c=relaxed/simple;
	bh=SIfCb+sbAvYjkscVMwZoTA++yp3e3DUiXlKfVWJMTkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7S8ne/70Svzxbo7kMszIsvg9sFTQOoSVoZ6UT4WJaEWjqKuefc8WUQIrhbitvaH08Q6qmRsa2B7+zDDUR0wd3Epazc6Ypmm8ljg6hGMjyfMXrYK8tFaA9czo03pEhf1i51cgMQ8vjJkDLk6gzhX1Z70QIkKnL/UK9ulnbFMycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YACP471a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077EDC433C7;
	Sat, 16 Mar 2024 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710597253;
	bh=SIfCb+sbAvYjkscVMwZoTA++yp3e3DUiXlKfVWJMTkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YACP471a9+Xky7f5wiXDaW4ul50f7xBgnWSmCtYrwj3I/tjVeq2PEzXAajFf1OXEq
	 5gWyATD/aG2HEfTcJ2uUQ1YPsudOOlmFHJQBL6dzzjHqmrZSX1kFWsYxgELELdENrc
	 LUyQOc9Oj69s7T12QymGKDJAWnCZkIoiQ4MMvmeChvDWr+ucovawYQZIPVfQGpkMlD
	 HY2zGyKxnbaLJgVQlv2ZVu7ZqWttorhhktfQKph8aU9d2k75sIpLzFAoH8tk5+h99R
	 xm46jy3mgBVfqNz6myo/Pngu1ugDe14VPoH/D++577w8Epebx9hW7jaRYEBMh7wB6s
	 MG8lmmfFjtsrw==
Date: Sat, 16 Mar 2024 13:54:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v3 0/4] Add WoM feature as an IIO event
Message-ID: <20240316135330.7556bccb@jic23-huawei>
In-Reply-To: <20240311160557.437337-1-inv.git-commit@tdk.com>
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 16:05:53 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Add WoM (Wake-on-Motion) feature for all chips supporting it (all except
> MPU-6000/6050/9150). WoM compares the magnitude of the current accel sample
> with the previous one against a threshold and returns an interrupt event if
> the value is higher.
> 
> WoM is checking against all axes and maps best to ROC since it compares the
> last 2 samples. Thus report WoM as an accel x|y|z roc_rising IIO event, add
> system wakeup functionality if WoM is on and put the chip in low-power mode
> when the system is suspended. Corresponding ROC value is in SI units since
> the chip is using an absolute value in mg.
> 
> v2:
> - Rework to use accel x|y|z roc for reporting WoM event
> - Use only datasheet advertised bits for MPU-6500 family chips
> 
> v3
> - Coding style fixes
> - Convert mutex usage to guard/scoped_guard
> 
Applied to the togreg-normal branch of iio.git and pushed out for 0-day
to get started. I'll be rebasing that tree after rc1 so use at your
own risk ;)

btw thought I'd sent this on Thursday  - just found it still open on my screen :(

Jonathan

> Jean-Baptiste Maneyrol (4):
>   iio: imu: inv_mpu6050: add WoM (Wake-on-Motion) sensor
>   iio: imu: inv_mpu6050: add WoM event as accel event
>   iio: imu: inv_mpu6050: add new interrupt handler for WoM events
>   iio: imu: inv_mpu6050: add WoM suspend wakeup with low-power mode
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 542 ++++++++++++++++--
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  36 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |  17 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  83 ++-
>  4 files changed, 595 insertions(+), 83 deletions(-)
> 


