Return-Path: <linux-iio+bounces-27771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34586D1EB58
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EFCB3012942
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0917C396B85;
	Wed, 14 Jan 2026 12:21:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE063904D0;
	Wed, 14 Jan 2026 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393309; cv=none; b=hSqyp+pWXT7w7uAKGQpd9shYztrB0rIvQAMMnjOU3uBZJahY5ASEwyo6eICG93WpgFoEjBZlSBIsEDl8MbF1vxr5M8q51PYS/HUOYTEkjpCRoS2GH3f8vQi/xvNKC3J2ZL/w+h3RyhEiBGupHsc1UIsy0A+Gl62YfQRiMNFAP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393309; c=relaxed/simple;
	bh=7zZcDF9gSmRnrONZN0KyqDT+wCk5pjDYznP+xYeRZqA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pS9w2EwZZjVRp9WYgIosQj0/i+JmN1P2n9ZswDdybNobJNkF8STKvOecPIivesif86uKneJ/e0lni4oXwlfoFOLe9KlcvhYffVkdyk0TtfRO5cY0HrjKnFczoyeDz6z3dL8tLRaekkyVOLeCzxeynJ1D5l4YRipSbI2V70UhmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drlbG4ftDzJ46pC;
	Wed, 14 Jan 2026 20:21:30 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 45AB340570;
	Wed, 14 Jan 2026 20:21:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 12:21:44 +0000
Date: Wed, 14 Jan 2026 12:21:43 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 00/13] iio: pressure: mprls0025pa: driver code
 cleanup
Message-ID: <20260114122143.000073cd@huawei.com>
In-Reply-To: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:05:34 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> This series contains a collection of patches to the MPR sensor based
> on feedback I received for other drivers.

Hi Petre,

I took a look at the whole series and didn't have anything to add to
Andy's review.

As we are somewhat near the end of the cycle, if you have time,
feel free to send a v3 sooner than the normal delay of 1ish weeks
(unless there is something you want to wait for more feedback on!)

I'll almost certainly take the lot for the merge window now rather
than trying to get the fixes in this cycle.

Thanks,

Jonathan



> 
> major changes:
>  - trigger flag fix (define edge direction only in the device tree)
>  - fix SPI timing violation
>  - fix scan_type struct
>  - fix pressure calculation
>     (does not affect users that define a sensor via the pressure-triplet)
>  - stricter check for the status byte + better error return levels
>  - drop the use of devm_kzalloc()
>  - stick to the datasheet parameters while performing the measurement
>     sequence
> 
> minor changes:
>  - includes added and removed
>  - rename generic 'buffer' variable to 'rx_buf'
> 
> I still included the memset patch for the reasons described in the v1 thread.
> if you strongly consider that patch inadequate then please skip it.
> 
> Tested on two sensors - MPRLS0015PA0000SA and MPRLS0001BA00001A
> 
> Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> Changes in v2:
> - reordered patches based on Marcelo's input
> - implemented code changes based on Marcelo and Jonathan's reviews
> - Link to v1: https://lore.kernel.org/r/20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro
> 
> ---
> Petre Rodan (13):
>       iio: pressure: mprls0025pa: fix spi_transfer struct initialisation
>       iio: pressure: mprls0025pa: fix SPI CS delay violation
>       iio: pressure: mprls0025pa: fix interrupt flag
>       iio: pressure: mprls0025pa: fix scan_type struct
>       iio: pressure: mprls0025pa: fix pressure calculation
>       iio: pressure: mprls0025pa: cleanup includes
>       iio: pressure: mprls0025pa: remove redundant declarations
>       iio: pressure: mprls0025pa: rename buffer variable
>       iio: pressure: mprls0025pa: introduce tx buffer
>       iio: pressure: mprls0025pa: move memset to core
>       iio: pressure: mprls0025pa: stricter checks for the status byte
>       iio: pressure: mprls0025pa: change measurement sequence
>       iio: pressure: mprls0025pa: add copyright line
> 
>  drivers/iio/pressure/mprls0025pa.c     | 112 +++++++++++++++------------------
>  drivers/iio/pressure/mprls0025pa.h     |  15 ++---
>  drivers/iio/pressure/mprls0025pa_i2c.c |  13 +---
>  drivers/iio/pressure/mprls0025pa_spi.c |  41 +++++-------
>  4 files changed, 73 insertions(+), 108 deletions(-)
> ---
> base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
> change-id: 20251215-mprls_cleanup-01de8971b439
> 
> Best regards,


