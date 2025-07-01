Return-Path: <linux-iio+bounces-21219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3DCAF06A0
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 00:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85091C20F52
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98C02EBDC7;
	Tue,  1 Jul 2025 22:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QsFt1Cj/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BF725DCE5
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751409324; cv=none; b=clvp232oEgm1F8tLFz5/AmZFu9LkB/AUQFMqghvgUnTAbWQOo0z1bvrXUwPEjoSuA5gWkCa04dOInv30E3auR/f/y2iJvzVuytK71tseL6ZhLYCKUd8IScH3GFcI0m2bcx4YWHMnAezzgvF0zOMk3Z+mtLKvgoyQMayDr4wg2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751409324; c=relaxed/simple;
	bh=kHBTVaTYl26qVaHyvvSh3GT1bicZ+Ubo8tTsKqPf+U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CC2B1N+jiak8+DBrKSK/M7ccKNWsR/TRgh8LYdOgpdVXmiwW4CiEra1HT0SDnGLsKgS9wwXo45XsD1VUlEppxH7aaxPaaJ43XD5Wm50vne4d5WuFz4ibXy1FmRTUNxzrKyH3QUuJ6FtGDoaQtZHEVT+Vsh0S/69cW000JSVHvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QsFt1Cj/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2e999729ccbso2309135fac.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751409321; x=1752014121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=miJuucrc+JOfDPn8zr/++YVg6+KrXVyM9185KeWVaHo=;
        b=QsFt1Cj/ue1gTD6IjTYCKRIFJt/jCEWTBUvZQTgpElyWXio16SX6YoPC89S4pxMyYx
         NwsMu5J6d92islDwpiXUdLIwmMedocvexHomPIJDJe8CUj0gABSlgxIxxuM+Ys9kJ49e
         W2AZu1QRJED+9ykbVPdXxMuIPVb9xhP8GsbUF3k0qUFKfxb9W8Xp/R16uIh8qJg2HyxA
         Sprxi0B3msL3KzpsNOJzcEv0I377+5G6JhHNsUeBSFjZtAwX19v3MY8bk9xtUei9tm4n
         dLeAtsw6LC62YwGSteZgQHny+rc6tSd4Gbh2STBh9lF2yEEAUMLipDOoyM26INbDG3jt
         3CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751409321; x=1752014121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miJuucrc+JOfDPn8zr/++YVg6+KrXVyM9185KeWVaHo=;
        b=TjHhTXNCsOBEgRyqHumEvxdou45XZ86H74E6N2UsWF3Mlz9YqtcH3eD/TvhHuB/Dsl
         QKDoFVvBBIXd0/zM/TPwMu/8bFaPx/DX7L8mqvJ3eq9PmdUXfsdYooP0McKrKqJmn0YU
         vYn1e19W6AXFbg/jL+LBUm/882vAzDyL7BTo5MclNiJ+XEUyMYU6IOg2n0md6/6egpNn
         +ytkyVgjwkMaMg9JY8C4BZw1sz9YFNtwlOaDn7wEEEMuw46un1zK3pp2rkWGGA38zF3z
         abWMwz4Gf7rWG88K6vyWvI8NLSxwATpEBiC8tznwi6sb5oNhDOEhBZhoIaJTUU+gX7wK
         D6aA==
X-Forwarded-Encrypted: i=1; AJvYcCWNHWnHuVZehEVIs+FSuWVsbDpqElcUpBjXOhKa/AdsZ1Uqx4WoRb5AAODsFiU4Mj54jH68VPwpzvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA0MMP33SjMbRHRFDFIY77RO7AElEFTUxM5ymWzR818/+5YMax
	vrqqdZkebpcwY9WFlSzCq2f8To+3GR3yrgbOP6TyIk28/ocrHfTSTOTXCGHPXpZALUkVrHH8xyC
	gYhIuCBk=
X-Gm-Gg: ASbGncseQcnnFnnHXuBs4iugTQuL4uzFP354CbK+Emv0zD4Z8rTwMy19KJIg4UKl1yp
	XoKG2kV9rOODLXyTVRsgYAMJn6qTPljpPOtL50yo/6rV9XUQAg/dUzsK0UEj93WflNTaDbg8XjQ
	ojDqC9SmYceHOChNHhG/acsOPNXqIUnLej3eTWEl1W7FzDByk1Mju/ew6Q6glbn+wu8y7QsEe3I
	5Bq6P/sQXoB+QVzCZv41V5VnGccqX7mvvs9Xv+o/Fr5ODqsgDv44EAaiR24yWRqjd+kiO0+LhQH
	QLu5lWbDwr8BowIX4kPq9Y+RKixz4y5QfVyhs8ixzcPXPQpCqY9gxfpywYVURySrpPvVc4lSXyO
	cEwBoE9cGGS2ss9uxy1SqYEF6Gao1RpFQTI4Gds8=
X-Google-Smtp-Source: AGHT+IH53MEMdEE6yq9bVDAZnjcNxPtMU7WUuM75MJbbFr+Tl2mQZQ4pCuMDdSK1Godm2CsMYb9fMQ==
X-Received: by 2002:a05:6870:3313:b0:2d8:957a:5163 with SMTP id 586e51a60fabf-2f5a8b200a0mr472131fac.10.1751409320821;
        Tue, 01 Jul 2025 15:35:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5? ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4eb261fsm3550672fac.8.2025.07.01.15.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 15:35:19 -0700 (PDT)
Message-ID: <e748d82b-43c7-48e6-b441-cef464f189e6@baylibre.com>
Date: Tue, 1 Jul 2025 17:35:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and
 avg sample before setting register
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, conor@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250701213728.32064-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250701213728.32064-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 4:34 PM, Rodrigo Gobbi wrote:
> avg sample info is a bit field coded inside the following
> bits: 5,6,7 and 8 of a device status register.
> 
> channel num info the same, but over bits: 1, 2 and 3.
> 
> mask both values in order to avoid touching other register bits,
> since the first info (avg sample), came from dt.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Tks for the tip, @David, I didn`t know those macros.
> Best regards!

:-)

> 
> Changelog:
> v2: use proper bitfield macros + change at commit msg
> v1: https://lore.kernel.org/linux-iio/20250621185301.9536-1-rodrigo.gobbi.7@gmail.com/#t
> ---
>  drivers/iio/adc/spear_adc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index e3a865c79686..ff7fb13fe947 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -21,6 +21,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
> +#include <linux/bitfield.h>

This should be moved up with the other non-iio includes.

For bonus points, a separate patch that cleans up and sorts the existing
includes would be appreciated.

add:
#include "linux/array_size.h"        // for ARRAY_SIZE
#include "linux/compiler_types.h"    // for __iomem
#include "linux/dev_printk.h"        // for dev_err_probe, dev_info
#include "linux/math.h"              // for DIV_ROUND_UP
#include "linux/mutex.h"             // for mutex_unlock, mutex_lock, mutex_...

remove unused:
#include <linux/device.h>
#include <linux/iio/sysfs.h>
#include <linux/kernel.h>
#include <linux/slab.h>

> +
>  /* SPEAR registers definitions */
>  #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)
>  #define SPEAR600_ADC_SCAN_RATE_HI(x)	(((x) >> 0x10) & 0xFFFF)
> @@ -29,9 +31,9 @@
>  
>  /* Bit definitions for SPEAR_ADC_STATUS */
>  #define SPEAR_ADC_STATUS_START_CONVERSION	BIT(0)
> -#define SPEAR_ADC_STATUS_CHANNEL_NUM(x)		((x) << 1)
> +#define SPEAR_ADC_STATUS_CHANNEL_NUM_MASK    GENMASK(3, 1)
>  #define SPEAR_ADC_STATUS_ADC_ENABLE		BIT(4)
> -#define SPEAR_ADC_STATUS_AVG_SAMPLE(x)		((x) << 5)
> +#define SPEAR_ADC_STATUS_AVG_SAMPLE_MASK    GENMASK(8, 5)
>  #define SPEAR_ADC_STATUS_VREF_INTERNAL		BIT(9)
>  
>  #define SPEAR_ADC_DATA_MASK		0x03ff
> @@ -157,8 +159,8 @@ static int spear_adc_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&st->lock);
>  
> -		status = SPEAR_ADC_STATUS_CHANNEL_NUM(chan->channel) |
> -			SPEAR_ADC_STATUS_AVG_SAMPLE(st->avg_samples) |
> +		status = FIELD_PREP(SPEAR_ADC_STATUS_CHANNEL_NUM_MASK, chan->channel) |
> +			FIELD_PREP(SPEAR_ADC_STATUS_AVG_SAMPLE_MASK, st->avg_samples) |
>  			SPEAR_ADC_STATUS_START_CONVERSION |
>  			SPEAR_ADC_STATUS_ADC_ENABLE;
>  		if (st->vref_external == 0)




