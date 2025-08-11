Return-Path: <linux-iio+bounces-22607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765B0B21683
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 22:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD08423FA4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E52D9EE8;
	Mon, 11 Aug 2025 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmSosz69"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943E311C31;
	Mon, 11 Aug 2025 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944330; cv=none; b=gg6ulMkCEMLi6CO8ungJi3kLB00OYfCieMv5Q5h5kn5TNIZr90HAaWy1BDGg1ZhqygqmSmlvqDNa/rlbhPMzmHNhXTBVMtDPDVP5wf+Ex6PWzYCbUiT7cVu7nS/5wR114Oyem856ICm8QiTTfi/dny/jeRiFxNGDMzJch0N2miM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944330; c=relaxed/simple;
	bh=ly505YzUJCW+w4zhIqTBgdX8GQwNdFihL6xwl57D2e8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aI8FQOUjIejNHAYcQxR+FoJsb1UZdgMqrbnI4XETU8QzH4Y839YPktmSwHv9he8zxLSc8/PIcI8+/DwHWNMVC3azMnEViGCxoUp+LhrE/hF9yfBnv7uzJEsJ9/hVrjFyCdMUf4n/zctTwhH89RTbKvvMN38Z20KP4DaSgGXKciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmSosz69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF9FC4CEED;
	Mon, 11 Aug 2025 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754944330;
	bh=ly505YzUJCW+w4zhIqTBgdX8GQwNdFihL6xwl57D2e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DmSosz69RADL61BU8YtrkDonA6FsRPJqOl2gRpOcoJj5nvL4/uwrGydZdT+xpkn2B
	 mxSYa0jmyzZnDQ5htfR/Nf3x8DCeyTO0/Hsx+HOtlzdnvtLPmH873jwwh37Nsks9Nq
	 9q0MkssxJNwFUd7n+BHeklO8vAupuhXH9dmMnWD9f7Tho6DTTLBStfWjM5KQ6QIzKq
	 vvqt2vmRV9215aH9qHQKZxei9bIyH4ivLTLLbAiSUlh1QW1iM9pHJNbfDLOvAhLEz1
	 KuKKMTNEjSRNeCsfyvWeD6CYTodak4s20fh5xju9uXUz4JlcIOsv3gfy1xFSuWkvIi
	 T8iaYQixe8XKQ==
Date: Mon, 11 Aug 2025 21:32:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250811213200.2a5da728@jic23-huawei>
In-Reply-To: <20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
References: <20250807-tlv493d-sensor-v6_16-rc5-v3-0-b80d2cb41232@gmail.com>
	<20250807-tlv493d-sensor-v6_16-rc5-v3-1-b80d2cb41232@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 07 Aug 2025 08:26:35 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
> 
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
> 
> The driver supports raw value read and buffered input via external trigger
> to allow streaming values with the same sensing timestamp.
> 
> While the sensor has an interrupt pin multiplexed with an I2C SCL pin.
> But for bus configurations interrupt(INT) is not recommended, unless timing
> constraints between I2C data transfers and interrupt pulses are monitored
> and aligned.
> 
> The Sensor's I2C register map and mode information is described in product
> User Manual [1].
> 
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/infineon-tlv493d-a1b6-datasheet-en.pdf
> Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-UserManual-v01_03-EN.pdf [1]
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Andy did a detailed review, so I only took a quick glance at this version.
One additional thing I noticed though.

> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_mark_last_busy(dev);

Drop the mark last busy.  That's now always called in pm_runtime_put_autosuspend()
after a patch that just merged in this merge window.

Seems you got it for the other cases but maybe just missed this call.

> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "iio device register failed\n");
> +
> +	return 0;
> +}
>


