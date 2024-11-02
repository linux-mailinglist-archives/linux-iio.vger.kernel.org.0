Return-Path: <linux-iio+bounces-11845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA179BA11D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F502823B5
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7519F43B;
	Sat,  2 Nov 2024 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkWDPkKj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A35185936;
	Sat,  2 Nov 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560914; cv=none; b=VNhT1sgqeZ76iiSzlTHWoCIULddpU+5kSD0Dluc3XMU5jWMV4z9LF2nt4Uc0naH75LcX5HnBB7rUkYltTc4ksB2T2Y7aj4ppV09ldm8IqCmECWKx621shr2vv4Iy8KL9pVaA0d6YC+Pi49WddDnd0rd2NtSUjmX/UotG5CGl7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560914; c=relaxed/simple;
	bh=I1I00yJxVnRNbYcCbPxLq0BvJQAdURVwb40IgfewrGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttN2MalL4VXWCaXtK79iNGoVK9tZtHTeYfJWi2iZqdbff1ZDcuNixhhzGg4tuIj32MJtv97QFrMw+2Ao2Es5dyvovu5Fo+v9YVBuYhjJXSOZ92wJgN9O/hxkWgG4OGCfBRNipcdWF2lOpa1a0o87AWvR3V+XkJhRUYHoovpFsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkWDPkKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68A3C4CEC3;
	Sat,  2 Nov 2024 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560913;
	bh=I1I00yJxVnRNbYcCbPxLq0BvJQAdURVwb40IgfewrGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RkWDPkKjBZuBt19L9fNZ3+GmOqFDOZ0eovmENujIAzYJIoU7SSRxc1WnPgFfHfnuB
	 gV+/jG3gPWMc+/C8kFY2OYgkn5arP2YGsXH1SMdmkDqBlWLATdompLQ93aTMDCCi0f
	 UBlNQkD2KXry2KPlpN9PVtNEm3n8wU10hhmAnM01wbPMZKTweq8O0YzVEAiUFJ0Z5u
	 8Oh9tk7wAo37Ffa4WD1m16twJ9EE+m1yAUwnD+UUQkwyTj69CjSXZ/vx+XQZUfZ8US
	 m+y98Zu7WD49hrK8a/xIyRryoKenrlTAOF1T+1IrPjQb81QsOFImbjknMQY6UrcquK
	 BoQ/ZOzw1y5IA==
Date: Sat, 2 Nov 2024 15:21:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] iio: chemical: bme680: Add SCALE and RAW
 channels
Message-ID: <20241102152145.1aadaa8c@jic23-huawei>
In-Reply-To: <20241102131311.36210-3-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
	<20241102131311.36210-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 14:13:06 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add SCALE,RAW channels to the device. Even though PROCESSED should be
> kept for backwards compatibility add comment to avoid using it if the
> value is not actually reported in IIO values.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

