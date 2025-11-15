Return-Path: <linux-iio+bounces-26249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED9C60A23
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 19:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F7F3B73C4
	for <lists+linux-iio@lfdr.de>; Sat, 15 Nov 2025 18:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8C3016EA;
	Sat, 15 Nov 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teNRFmWf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA221DC997;
	Sat, 15 Nov 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763232492; cv=none; b=eATQ9p7FqA/LoEnTCQteJmLB6gcDRozpIT0kS9WxcolyPK0c1bwUCKQ1ckjFw10H8YWL5Nr6wirt7O8lCUoqYxu3VNBMbFquto7imiEf0JnETelHyCvEeVmiD9x8oNWU+CdkuDHiAhS1rYW140VmmRXFB0lS6Skc1y6YPffkPrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763232492; c=relaxed/simple;
	bh=zsD/1xrcjQwaGbTZQLnWPjZK1+Xm/pQiHyTNsGL8T5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtC1bBvIg9wkVhWNaesxAdikaRZ/bTpiP4cR2VTAG48gc5eEePfdTutLxHvGSLZ+U2VZbPv7oQli3z+9kFcSrWVRNDXtCDE5unMxdAYPjXv+WGbPR8+9iPOYmZDddejHYoK9d0loa3rOd4DKFQBLItY+zobZKh7PQ3j9rNpyDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teNRFmWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A470C4AF09;
	Sat, 15 Nov 2025 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763232491;
	bh=zsD/1xrcjQwaGbTZQLnWPjZK1+Xm/pQiHyTNsGL8T5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=teNRFmWfGh84Qc5mVeTvLzCvxVbOcZ2oSAA+uZOPUslh/fTD+p//Fp0YzMKIKjEH3
	 6xSCD8K3GoCySfR7skQlx9RgkPID/3N5Rr1aFkJEE1o/tQsam4GmijI8Bv9DTGgdOf
	 1n9Xk6WWTs5ndoCuTNrOAT5KXsfsOqZ4nVFWL/A4DR/vnB5QzTXzsMZ4YuHQRtNdc3
	 A1ij9BVYQQiS83qb62uNfPeLFJYFVBO/k3PrhDI93UTR0AMLCvWx/uivf3avAG8Rmc
	 r3CEYbKYLWsX6n/pTwdhS1wZRphBDGBXCUg9ea/rVb3t6ppBuvMfX75PEZ1gAGAJU2
	 +fEu+/poUkibg==
Date: Sat, 15 Nov 2025 18:48:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Message-ID: <20251115184805.219c0715@jic23-huawei>
In-Reply-To: <aRDsoY7Ac4i0eGTF@smile.fi.intel.com>
References: <20251109192556.3163077-1-andriy.shevchenko@linux.intel.com>
	<aRDsoY7Ac4i0eGTF@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Nov 2025 21:33:53 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Nov 09, 2025 at 08:24:36PM +0100, Andy Shevchenko wrote:
> > The driver code is full of intXX_t and uintXX_t types which is
> > not the pattern we use in the IIO subsystem. Switch the driver
> > to use kernel internal types for that. No functional changes.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > Jonathan, what is the status of fixing the type for
> > iio_push_to_buffers_with_timestamp()? This patch doesn't do that
> > as I see no API has been fixed (and it seems the only one that uses
> > the *intXX_t parameter).
> > 
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> FWIW,

That interface is supposed to be going away anyway in favour
of iio_push_to_buffers_with_ts() which doesn't have that issue.
I'd rather an effort was put in that direction than changing
the types as part of that old interface.

Thanks,

Jonathan

> 
> $ git grep -l 'u\?int[0-9][0-9]\?_t' -- drivers/iio/
> drivers/iio/accel/bmc150-accel-core.c
> drivers/iio/accel/bmc150-accel.h
> drivers/iio/accel/fxls8962af-core.c
> drivers/iio/accel/hid-sensor-accel-3d.c
> drivers/iio/accel/kionix-kx022a.c
> drivers/iio/accel/kxcjk-1013.c
> drivers/iio/accel/sca3000.c
> drivers/iio/accel/sca3300.c
> drivers/iio/accel/ssp_accel_sensor.c
> drivers/iio/adc/ad4000.c
> drivers/iio/adc/ad7791.c
> drivers/iio/adc/ad7887.c
> drivers/iio/adc/at91_adc.c
> drivers/iio/adc/ingenic-adc.c
> drivers/iio/adc/max1363.c
> drivers/iio/adc/qcom-spmi-rradc.c
> drivers/iio/adc/qcom-vadc-common.c
> drivers/iio/adc/ti-ads7950.c
> drivers/iio/adc/ti-tlc4541.c
> drivers/iio/adc/xilinx-xadc-core.c
> drivers/iio/adc/xilinx-xadc-events.c
> drivers/iio/adc/xilinx-xadc.h
> drivers/iio/chemical/scd4x.c
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h
> drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> drivers/iio/common/ssp_sensors/ssp.h
> drivers/iio/common/ssp_sensors/ssp_iio.c
> drivers/iio/common/ssp_sensors/ssp_iio_sensor.h
> drivers/iio/dac/ad3552r.c
> drivers/iio/dac/ad5446.c
> drivers/iio/dac/ad5449.c
> drivers/iio/dac/ad5766.c
> drivers/iio/dac/ad7303.c
> drivers/iio/dac/ad8460.c
> drivers/iio/dac/ds4424.c
> drivers/iio/dac/ti-dac7612.c
> drivers/iio/frequency/admv4420.c
> drivers/iio/gyro/adis16136.c
> drivers/iio/gyro/ssp_gyro_sensor.c
> drivers/iio/humidity/ens210.c
> drivers/iio/imu/adis16400.c
> drivers/iio/imu/adis16460.c
> drivers/iio/imu/adis16480.c
> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
> drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h
> drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
> drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> drivers/iio/industrialio-buffer.c
> drivers/iio/light/ltr501.c
> drivers/iio/light/rohm-bu27034.c
> drivers/iio/light/si1133.c
> drivers/iio/light/stk3310.c
> drivers/iio/light/vcnl4000.c
> drivers/iio/position/hid-sensor-custom-intel-hinge.c
> drivers/iio/pressure/icp10100.c
> drivers/iio/pressure/ms5611_core.c
> drivers/iio/temperature/mlx90632.c
> 


