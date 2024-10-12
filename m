Return-Path: <linux-iio+bounces-10490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A587F99B334
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CADE1C22B73
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63B154C0F;
	Sat, 12 Oct 2024 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1nDcz0b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA121DFE3;
	Sat, 12 Oct 2024 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728730671; cv=none; b=Or2uw0b3e2fIPJ7UEDMT5Dddn4m7Tbq0vHq2VNK3DCGLkJ63mxe8Rf9HQP8KKGxgnWJaLuQP4CqrivdMX9pL/7zBTsieAKxjXrBZKiN6AjR9v3LRT2GEYZHUw2jZn/OOliF3oZ0d0zKqRr/VxQSP852Y7PaTbtqeKXRBca7F+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728730671; c=relaxed/simple;
	bh=9UghHgWpS2nZIYJzy2EdHZv9DA9q+aDgXC0Uf/Q/JVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWU4OoEoxdZ6YE4eweXxZ5sRLcnpRXMxNXTPGUVLkb9iJEa30t73fx47swAcOO/APfF274tAd1TOZOPA58u/PxSFQxQADD2aQo/R2JCYMKM99xgMV02Vx0Hl9YYMOD/hFWCHTAxVDih13TbDE2xozd5omKa4U/IJ5GnAvAy/zbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1nDcz0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD9DC4CEC6;
	Sat, 12 Oct 2024 10:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728730670;
	bh=9UghHgWpS2nZIYJzy2EdHZv9DA9q+aDgXC0Uf/Q/JVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1nDcz0bVjIKCucAzGUkQdtiWJe7vDfdR4ysfJxN/pnvNdavO0/Fg3WT+npGdCU0i
	 TqUH7MmLPeqCcLX15yzhJpn4/aHeW70MCkhSU6mj/2wFGtOy7lxolt0kwGs6R++0lK
	 tdIe+V4rKVJuOWk9qbfa5JXJmo7c1brIhw0/phS6DPwpq1321paw8vwjQrwxr19gNe
	 jP+HkFfHK3yytu74DMKGSCz/LdtceK06meB751o2Eizdj2p6IGyc8yQpLbzZIY2tZ2
	 leycK96jZgF3e7vUOzfAPDrLvOpaKTT6VbrNaaO14pw2arfOxyGKJQocoZ5r/Xx+yW
	 LtYXLc5DYiA7A==
Date: Sat, 12 Oct 2024 11:57:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 0/3] Add i2c driver for Bosch BMI260 IMU
Message-ID: <20241012115743.4a878daa@jic23-huawei>
In-Reply-To: <20241011153751.65152-1-justin@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 08:37:46 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Add support for the Bosch BMI260 IMU to the BMI270 device driver.
> 
> The BMI270 and BMI260 have nearly identical register maps, but have
> different chip IDs and firmware.
> 
> The BMI260 is the IMU on a number of handheld PCs. Unfortunately,
> these devices often misidentify it in ACPI as a BMI160 ("BMI0160," for
> example), and it can only be correctly identified using the chip
> ID. I've changed the driver to fail if the chip ID isn't recognized so
> the firmware initialization data isn't sent to incompatible devices.

So just to check, is the firmware always specific to an individual chip?

Normally we strongly resist hard checks on mismatched IDs because they break
the option for using fallback compatibles to get some support on older
kernels for newer devices, but if the firmware is locked to a
device then that is a good justification.  Fallback compatibles in DT
will never work here.

Note that means you need a specific compatible in
Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml

Technically you could match on a single ID and figure it out, but that
will lead to potential confusion if an older kernel is used with a binding
written against current kernel and the driver just doesn't work. Not a regression
but in my view inelegant.


Make sure you include this detail about specific firmware selection in there
as well.

Jonathan

> 
> Also add triggered buffer and scale / sampling frequency attributes,
> which the input tools commonly used on handheld PCs require to support
> IMUs.
> 
> Like the BMI270, the BMI260 requires firmware to be provided.
> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> ---
> 
> Justin Weiss (3):
>   iio: imu: Add i2c driver for bmi260 imu
>   iio: imu: Add triggered buffer for Bosch BMI270 IMU
>   iio: imu: Add scale and sampling frequency to BMI270 IMU
> 
>  drivers/iio/imu/bmi270/Kconfig       |   1 +
>  drivers/iio/imu/bmi270/bmi270.h      |  24 +-
>  drivers/iio/imu/bmi270/bmi270_core.c | 369 ++++++++++++++++++++++++++-
>  drivers/iio/imu/bmi270/bmi270_i2c.c  |  22 +-
>  drivers/iio/imu/bmi270/bmi270_spi.c  |  11 +-
>  5 files changed, 413 insertions(+), 14 deletions(-)
> 
> 
> base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a


