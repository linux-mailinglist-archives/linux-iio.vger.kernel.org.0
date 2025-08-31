Return-Path: <linux-iio+bounces-23531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C89B3D37B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 14:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA5694E142D
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1111A25EFBB;
	Sun, 31 Aug 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb+qhHwC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FF5156F5E;
	Sun, 31 Aug 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756645110; cv=none; b=SeC1+gfeY4OJJ998iHyU8zt8Vqyq2nH+EX5SHyNacYweyaEiKbpmo6EC3xNx7i4/2NB30CKWhK1CUu7fhdONQZp80TFnwG+grSA8+bUppvG3a9B59r6eIKToDkx76I9J7SwXLAJ2QLNCR68a2HGkU/D621B5XTJvs3iNI2LdYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756645110; c=relaxed/simple;
	bh=yJ0uIpHm+mUKrddjCoiv9Fi3F7RElGG2VRluOwc4MHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2fyLppdXauhH/oFiQZBTb4NKwZNzV3J0HsJeR4A+k4i4ahs+xHVSMznhIAO79ThjnelPZ+bH8g66ewI53ngZpA+OYUc+5XKRElJri5lJGvRaJ5Af2GCYNCdZr7DHY8lL+A1zpup9ZWL+6jzxaJG3VkUd+0NWA2qCZsPZxNviJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb+qhHwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E475C4CEED;
	Sun, 31 Aug 2025 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756645110;
	bh=yJ0uIpHm+mUKrddjCoiv9Fi3F7RElGG2VRluOwc4MHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Lb+qhHwCpKJrLmMfGb+TU30yG0OySR+8ZFFyYPtAivqyAiXJN33DKmVMzeOA5tbjP
	 UzmQN5HXg9Qk8knKCCsv7acZiJ5skFAgEAK2byapc9W7+szc8FCQ6AOcFJUcnLjYFA
	 kDPVnyVrIQ8FlpATsL6VznJ2/KEOvRhHJe+qY2GcL85vdiafZ6J+G7on+8ZfgSbF9S
	 IS1Z5/hPnxNpNx2Aa//WRKxoJJvDlTY3WLkWSXwatg3AMft74ggY53g6ECeEhctmV9
	 LMcoHzRwxTXhrfwavuK3X2vFTVGB0s8FeEk1ANRFDBCJNBFv9NKskKpiv5/0Er49L/
	 GNelUsTaMstJA==
Message-ID: <7c98542d-c196-4071-b29c-91cd81072aa5@kernel.org>
Date: Sun, 31 Aug 2025 14:58:24 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] iio: imu: icm20948: add support for gyroscope
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250831-icm20948-v1-0-1fe560a38de4@gmail.com>
 <20250831-icm20948-v1-3-1fe560a38de4@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250831-icm20948-v1-3-1fe560a38de4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2025 20:42, Bharadwaj Raju wrote:
> Add support for reading the gyroscope, which is exposed as another IIO
> device under the icm20948 driver.
> 
> For now, the only configuration supported is changing the full-scale
> range.
> 
> Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
> ---
>  drivers/iio/imu/inv_icm20948/Makefile            |   1 +
>  drivers/iio/imu/inv_icm20948/inv_icm20948.h      |  78 ++++--
>  drivers/iio/imu/inv_icm20948/inv_icm20948_core.c |  55 ++--
>  drivers/iio/imu/inv_icm20948/inv_icm20948_gyro.c | 343 +++++++++++++++++++++++
>  4 files changed, 432 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm20948/Makefile b/drivers/iio/imu/inv_icm20948/Makefile
> index c508c2dc3eee2c32be20067e3e0868a203d8aa1a..88a37be159e1d6f575da1c070c84ac94cd963020 100644
> --- a/drivers/iio/imu/inv_icm20948/Makefile
> +++ b/drivers/iio/imu/inv_icm20948/Makefile
> @@ -3,6 +3,7 @@
>  obj-$(CONFIG_INV_ICM20948) += inv-icm20948.o
>  inv-icm20948-y += inv_icm20948_core.o
>  inv-icm20948-y += inv_icm20948_temp.o
> +inv-icm20948-y += inv_icm20948_gyro.o
>  
>  obj-$(CONFIG_INV_ICM20948_I2C) += inv-icm20948-i2c.o
>  inv-icm20948-i2c-y += inv_icm20948_i2c.o
> diff --git a/drivers/iio/imu/inv_icm20948/inv_icm20948.h b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> index f9830645fbe96fd02eef7c54d1e5908647d5a0fe..ca2513114378cdcba5bc315fc94cd61f930b4dfa 100644
> --- a/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> +++ b/drivers/iio/imu/inv_icm20948/inv_icm20948.h
> @@ -3,45 +3,83 @@
>   * Copyright (C) 2025 Bharadwaj Raju <bharadwaj.raju777@gmail.com>
>   */
>  
> -#ifndef INV_ICM20948_H_
> -#define INV_ICM20948_H_
> + #ifndef INV_ICM20948_H_
> + #define INV_ICM20948_H_
>  
> -#include <linux/bits.h>
> -#include <linux/bitfield.h>
> -#include <linux/mutex.h>
> -#include <linux/regmap.h>
> -#include <linux/i2c.h>
> -#include <linux/iio/iio.h>
> -#include <linux/err.h>
> + #include <linux/bits.h>
> + #include <linux/bitfield.h>
> + #include <linux/mutex.h>
> + #include <linux/regmap.h>
> + #include <linux/i2c.h>
> + #include <linux/iio/iio.h>
> + #include <linux/err.h>
>  
>  /* accel takes 20ms, gyro takes 35ms to wake from full-chip sleep */
> -#define INV_ICM20948_SLEEP_WAKEUP_MS 35
> + #define INV_ICM20948_SLEEP_WAKEUP_MS 35
>  
> -#define INV_ICM20948_REG_BANK_SEL 0x7F
> -#define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
> + #define INV_ICM20948_REG_BANK_SEL 0x7F
> + #define INV_ICM20948_BANK_SEL_MASK GENMASK(5, 4)
>  
> -#define INV_ICM20948_REG_WHOAMI 0x0000
> -#define INV_ICM20948_WHOAMI 0xEA
> + #define INV_ICM20948_REG_WHOAMI 0x0000
> + #define INV_ICM20948_WHOAMI 0xEA
>  
> -#define INV_ICM20948_REG_FIFO_RW 0x0072
> + #define INV_ICM20948_REG_FIFO_RW 0x0072
>  
> -#define INV_ICM20948_REG_PWR_MGMT_1 0x0006
> -#define INV_ICM20948_PWR_MGMT_1_DEV_RESET BIT(7)
> -#define INV_ICM20948_PWR_MGMT_1_SLEEP BIT(6)
> + #define INV_ICM20948_REG_PWR_MGMT_1 0x0006
> + #define INV_ICM20948_PWR_MGMT_1_DEV_RESET BIT(7)


This makes no sense.

Best regards,
Krzysztof

