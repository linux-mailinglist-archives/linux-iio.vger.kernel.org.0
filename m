Return-Path: <linux-iio+bounces-18224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55014A9240D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66510168C6A
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67B25525A;
	Thu, 17 Apr 2025 17:30:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F2A1A238A;
	Thu, 17 Apr 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911057; cv=none; b=ri0gQ8fFly0Lbw850pFPR3YeyJikDtMldj/7oLtr09ScQ/Sylzeu9F8a9nmP2HaaV1Qd1Q6/jN3UfZ/H6hIdcsNG39zYJ8ZdegABnbHrOmfpd51O050Rp0Y9kSYITfB5bxswk4UMa3Nxs+aBO2RMLPOyTIMOJ11f1pXgcY6nWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911057; c=relaxed/simple;
	bh=68Fo9PxNCm2MVEvQ7px+p7wujeJOAtr26F6i4ENvrJM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jw9sX3G6BJVJYtMOk4CutyvvbBUhWg1VRnC8eYIR8nFVUSP81uF0PNEOy83IndnTnXRPU/e8pZHbLALH3pObokBSaThSwPvl9+s+XXR0n4A5cdiTTgM/deMKqXWWEYpShdDviJMk74IPLUCEXRr2cr1Pp+kX2e7vZNKNrfP9RtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZdlF70NSvz6M4gh;
	Fri, 18 Apr 2025 01:26:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C9D32140595;
	Fri, 18 Apr 2025 01:30:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:30:51 +0200
Date: Thu, 17 Apr 2025 18:30:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, "Cosmin
 Tanislav" <cosmin.tanislav@analog.com>, Tomasz Duszynski
	<tduszyns@gmail.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, "Petre
 Rodan" <petre.rodan@subdimension.ro>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 0/8] iio: more timestamp alignment
Message-ID: <20250417183049.0000336c@huawei.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 11:52:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Wile reviewing [1], I noticed a few more cases where we can use
> aligned_s64 or need __aligned(8) on data structures used with
> iio_push_to_buffers_with_timestamp().
> 
> [1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I have a bunch of these in a 'too hard before sending that patch
pile' as well.  Hopefully you've covered many of those :) There
were definitely more bugs than I expected to see when I started that
effort!  I thought we'd tracked all these down long ago :(

Jonathan

> ---
> David Lechner (8):
>       iio: adc: dln2-adc: use aligned_s64 for timestamp
>       iio: adc: mt6360-adc: use aligned_s64 for timestamp
>       iio: addac: ad74413r: use aligned_s64 for timestamp
>       iio: chemical: pms7003: use aligned_s64 for timestamp
>       iio: chemical: sps30: use aligned_s64 for timestamp
>       iio: imu: adis16550: align buffers for timestamp
>       iio: imu: inv_mpu6050: align buffer for timestamp
>       iio: pressure: mprls0025pa: use aligned_s64 for timestamp
> 
>  drivers/iio/accel/bmc150-accel.h           | 2 +-
>  drivers/iio/adc/dln2-adc.c                 | 2 +-
>  drivers/iio/adc/mt6360-adc.c               | 4 ++--
>  drivers/iio/addac/ad74413r.c               | 5 +++--
>  drivers/iio/chemical/pms7003.c             | 5 +++--
>  drivers/iio/chemical/sps30.c               | 2 +-
>  drivers/iio/imu/adis16550.c                | 2 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
>  drivers/iio/pressure/mprls0025pa.h         | 2 +-
>  9 files changed, 14 insertions(+), 12 deletions(-)
> ---
> base-commit: 3159d40a2ca0ae14e69e1cae8b12f04c933d0445
> change-id: 20250416-iio-more-timestamp-alignment-6c6c6a87ebda
> 
> Best regards,


