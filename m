Return-Path: <linux-iio+bounces-18259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C617A9392D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105F08E366E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B62063D8;
	Fri, 18 Apr 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmmkpSQg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815C205AAB;
	Fri, 18 Apr 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989135; cv=none; b=HzYLCGZMcR79hT/QLwBUsMtw9XAEHC4lAdbajbuqZZR+y6ZoRxReTxpIrUXrHJij3dZwtcsUbfVvwssYP990dVtIR1nQmhlZXSqabwsoCw3PL2SGsfoyDDZDIn9QDIWDd/8rcDbWFm33VyNosfstNM5HidyQVRmqjrhYai/9l3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989135; c=relaxed/simple;
	bh=3zBMbevmftHKgtZjXChlH+4wGCH2oPPjVAd5sR/b+a8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnwXD8GP2FCr1y+zfbl++u85Oq7FvCIeUnrsnvK1fQzSHySXFjn6Iu1FCdVEO+/wtseJnHpJOa0tdbw9QmIW+UX2rKteVjNVGKNOj0Vhd94b6UAZn/Qj2GUaVgSVbSAdecM3zO9m+t7YR92BgWgPDPjbQBqysjS7+o3nlCekCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmmkpSQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1EDC4CEE2;
	Fri, 18 Apr 2025 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744989135;
	bh=3zBMbevmftHKgtZjXChlH+4wGCH2oPPjVAd5sR/b+a8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XmmkpSQg9Be6kXQaDSItIU+t/NedTQxFVGDKh2Xee68mDbgHJs7aoYzuE1Roej7NC
	 zfUBEFqp60rjQ/HmJ/aVpERhug+/TBUtXBRwYDRpZXNaO2Xhfh8CD/MyJ6QAdrHMCn
	 8JJBa8hD3/FFezgjrDkFV5M+PxVr0lMCLIYxx6uC6pcx7nXofbpO/zgzZWvzBozPTQ
	 6ZxvJ1Hx+0vbnrvcTPYdiQxdWKw22zjbhDvss+lK6nw6OJc8xYy+dnhhgTj4xRrbQJ
	 n5Nh+AUmzWbbnijWxaJ17cPGqyZQt1FHUPZjdjmRoGmt9iNRNUD8053yroEvDu9apJ
	 oP2+caXkZk2SA==
Date: Fri, 18 Apr 2025 16:12:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/8] iio: more timestamp alignment
Message-ID: <20250418161205.23a30da9@jic23-huawei>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 11:52:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Wile reviewing [1], I noticed a few more cases where we can use
> aligned_s64 or need __aligned(8) on data structures used with
> iio_push_to_buffers_with_timestamp().
> 
> [1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/
I picked up via one or other branch all but 1 (as that was already fixed), 6 and 8

Jonathan

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
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


