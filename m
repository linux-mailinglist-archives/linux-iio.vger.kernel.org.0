Return-Path: <linux-iio+bounces-21929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50059B0FB49
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 22:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B67C1C2395A
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6B22B8C5;
	Wed, 23 Jul 2025 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EJLXdTKX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A851F8728
	for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753301671; cv=none; b=CoE0Yo/ob7xpVc758Kt8UIlLe8A3S9sFiD9J4WHr0aNxiqdHvTB/j8CAwd6a0O2SpzKFMwHKCKavZhYS8XH2sxZP1E5F5VPGQobBblfIUpoCn+xp/F8+JoHJHj5lw4K1SVD4L2Cf8ABgQlxebrWm21rfh7bYMZve5qu0Wt994FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753301671; c=relaxed/simple;
	bh=em2Cz9/rmdAjWsSOFmWNoQVvO5o5Hf9oOYRtMGO5KXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRfx2PAmtiKv3fRvwNVemDv3O2oI1DmnwdX6+7rPNc/ZLbAyg8BTBXxU/00M/fVMpN1ImOI9c47b8ho9ZGga1yABM9F2azLoRo3EWs1QJBBtFcpI6fQFL0Inh9FCX2J1HpXqczDUwexf5DHqTZp9P1pno1YVgVdtIRhfes0HRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EJLXdTKX; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2ea58f008e9so235572fac.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Jul 2025 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753301666; x=1753906466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeFAWsT+5Sa2P/r48U2EHOfIbtb6U3ASmR6Lx4kN1hA=;
        b=EJLXdTKXGriiSUa/0/z4ftZlVxW1ytM9Gf7Ow5VAgtJvG0jTvvMBPPkpzmL1KFZWiq
         k1PHNMZbzLD8BS2i9cup74Z3Q3LYY1YNufSJXLjQve3jj9S2dOZeCHlbY8hPVXTaXr1r
         VE8ZTkjF/oDvF9QQN93GLbN3X3HuJATJdWNToXogwiOUzqLftQSWox0x/jlg1uJoxkDg
         z5uwvNcjcBAL8+6GJUnAM7ZMO6jGU8485jGctrVYupfV3YwLcK3C1oclP4wC9eVMxD9N
         LrQBubTUEJNgVioiG1cVIabkbu0xDmKBsMAbBGtSm5eMl61wiMRTLUq81C3iHLGG4517
         uYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753301666; x=1753906466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeFAWsT+5Sa2P/r48U2EHOfIbtb6U3ASmR6Lx4kN1hA=;
        b=rPORtqWqOw/ouhBsF+9cWXJqslceHC8NLm1FLSqxRYnVNjq9WswPPwacBUKa097bPY
         OLnMbij7pFBT6BV+XUdvKTYBht0basSMTFLV4ynisosvdgkVrTVfj8cunYF5UxvludSW
         7O2lANJBj8hi3th7lDYYYUM9HHVB9XM87mi3+N7qPucnKhXakOBuPV2SLqxOA/U/8XXJ
         yZSxSToTj16GIhpo9RwRnqbwZMPT1pz5CcqezZX4Ww3WVRaRp1Gi1WN8oy+fiAqls9+c
         kv4LPYFDAgL2S9lt5PqeNk7WX56c2BGmKdDCb90WX2bYVe2CClDrnh5eQPV+pBzbsBz1
         P1rw==
X-Forwarded-Encrypted: i=1; AJvYcCXw7X8oVD4uZv/HVy9W1I22gB4CK0uj7D8RvormpdC7aaliT0Gy892Ei8V6iIS/6XtS7IgfInOyJ2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb2dmR5zEz9nNH27pVC3h0oOvdOdmTcY7JySA82iCMu1cJJcmV
	/sj4lu236GuxRnizcHXfAVIe41B+eUUqz/Di5pKO55neASxHcVvFJ7Ph05EJOdivZeZpiqDT16x
	rgyth
X-Gm-Gg: ASbGncsHqXY9cfui8s45sf6/n0ww4DqSD7/SwT5AA4jXxELlf40QZyqzS4UK1IuyTTq
	xALWen6Y1OH2aDIyQ+wMN4ONsUzjdyrW3ibJVm1r27RcTdDoZ/uTS7YkJPybwB3cnM5Pwvd1cpW
	l7hStSE0YELBHWnZ85bt/97z9gVKZThkABqFNV/O56GZttOOFhcJBPhvf3zV0n1DqZBB1V8E8Cy
	N39qiyyUWCkhYIpqzKIO1ZyKSg8AX9A6K6HAAFgrmks5iFNWrpEg7mwxAIA+crWyiMCqCsRkF6w
	6QgbSK7qnP88Y8Kj22JNv4gY+1RE//J3UpREWW7/Ckdcop2jV21gEjH3D+iqya3mrBusPbA+n3r
	bKE9d5wenpErmjAuk6/dMA41O4NhQsVly0XmMw7Y4E7RTWMv0wgn7yh0xliIMiFB20IcdJjmN
X-Google-Smtp-Source: AGHT+IG7rCWpn41cjSHFGoTs3qbbeuxM852rEoo5nKLZ5KjtIvP9Os93Lx+oVz+RLg26fNx1gCaZ2Q==
X-Received: by 2002:a05:6870:fb87:b0:2ff:a6d7:52a1 with SMTP id 586e51a60fabf-306c7323385mr3619844fac.35.1753301666325;
        Wed, 23 Jul 2025 13:14:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:11dd:c0f5:968d:e96? ([2600:8803:e7e4:1d00:11dd:c0f5:968d:e96])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-306e1c4e079sm32855fac.11.2025.07.23.13.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 13:14:25 -0700 (PDT)
Message-ID: <1abf4238-5bf4-44e9-9a4b-41838cc9e472@baylibre.com>
Date: Wed, 23 Jul 2025 15:14:25 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: light: ltr390: Add debugfs register access
 support
To: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723180457.629833-1-akshayaj.lkd@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250723180457.629833-1-akshayaj.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/25 1:04 PM, Akshay Jindal wrote:
> Add support for debugfs_reg_access through the driver's iio_info structure
> to enable low-level register read/write access for debugging.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
> 
> Changes since v1:
> =================
> - Replaced _[0|1|2] macros with a respective common parameterized macro.
> - Retained base macros to avoid churn.
> - Swapped regmap_write with regmap_read to avoid negate operator.
> - Simplified debugfs function by directly returning return value of
>   regmap_[read|write].
> - Replaced [readable|writeable]_reg with regmap ranges by using
>   [rd|wr]_table property of regmap_config.
>  
> Testing details(updated):
> ========================
> -> Tested on Raspberrypi 4B. Follow for more details.
> 
> akshayajpi@raspberrypi:~ $ uname -r
> 6.12.35-v8+
> akshayajpi@raspberrypi:~ $ uname -a
> Linux raspberrypi 6.12.35-v8+ #5 SMP PREEMPT Tue Jul 15 17:38:06 IST 2025 aarch64 GNU/Linux
> 
> -> Sensor Detection, overlaying of device tree and Driver loading
> akshayajpi@raspberrypi:~ $ i2cdetect -y 1
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:                         -- -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- -- 53 -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
> 
> akshayajpi@raspberrypi:~ $ sudo dtoverlay i2c-sensor ltr390
> akshayajpi@raspberrypi:~ $ lsmod|grep ltr390
> ltr390                 16384  0
> industrialio          110592  1 ltr390
> regmap_i2c             12288  1 ltr390
> 
> 
> 1. Disable sensor via debugfs, verify from i2cget and debugfs.
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x0 | sudo tee direct_reg_access
> 0x0
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x2
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x0 0x0 | sudo tee direct_reg_access
> 0x0 0x0
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x0
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ i2cget -f -y 1 0x53 0x0
> 0x00
> 
> 2. Disable sensor via debugfs and read data status via debugfs.
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 603
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 603
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 603
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ i2cget -f -y 1 0x53 0x7
> 0x28
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ i2cget -f -y 1 0x53 0x7
> 0x00
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x7 | sudo tee direct_reg_access
> 0x7
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x0
> 
> 3. Re-enable sensor via debugfs and read data status via debugfs.
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x0 0x2 | sudo tee direct_reg_access
> 0x0 0x2
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x2
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 608
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 614
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 601
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x7 | sudo tee direct_reg_access
> 0x7
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x8
> 
> 4. Enable interrupts via sysfs and verify via debugfs.
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 1 | sudo tee /sys/bus/iio/devices/iio\:device0/events/in_illuminance_thresh_either_en
> 1
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ i2cget -f -y 1 0x53 0x19
> 0x14
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x19 | sudo tee direct_reg_access 
> 0x19
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x14
> 
> 5. Write falling threshold via debugfs, verify the threshold written via sysfs.
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x24 0x32 | sudo tee direct_reg_access 
> 0x24 0x32
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x32
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x25 0x0 | sudo tee direct_reg_access 
> 0x25 0x0
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x0
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x26 0x0 | sudo tee direct_reg_access 
> 0x26 0x0
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> 0x0
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/events/in_illuminance_thresh_falling_value 
> 50
> final value = 0x0 << 16 | 0x0 << 8 | 0x32 = 50
> 
> 6. Block light and verify interrupts getting generated.
> -> Before blocking light
> cat /proc/interrupts|grep ltr390
>  58:         0          0          0          0  pinctrl-bcm2835   4 Edge      ltr390_thresh_event
> 
> ->After blocking light
> 58:         63          0          0          0  pinctrl-bcm2835   4 Edge      ltr390_thresh_event
> 
> 7. write value to a non-writeable reg via debugfs.
> -> LTR390_ALS_DATA_0|1|2 are non-writeable registers. Writing to them gives I/O error as expected.
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xd 0x1 | sudo tee direct_reg_access
> 0xd 0x1
> tee: direct_reg_access: Input/output error
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xe 0x1 | sudo tee direct_reg_access
> 0xe 0x1
> tee: direct_reg_access: Input/output error
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xf 0x1 | sudo tee direct_reg_access
> 0xf 0x1
> tee: direct_reg_access: Input/output error
> 
> 8. read value from a non-readable reg via debugfs.
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x2 |sudo tee direct_reg_access 
> 0x2
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access
> cat: direct_reg_access: Input/output error
> 
> 9. do simple raw reads from debugfs.
> -> reading raw value via sysfs:
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 627
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 622
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat /sys/bus/iio/devices/iio\:device0/in_illuminance_raw
> 616
> 
> -> reading via debugfs (should be in the same ballpark of sysfs)
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xd | sudo tee direct_reg_access
> 0xd
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
> 0xC7
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xe | sudo tee direct_reg_access
> 0xe
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
> 0x2
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0xf | sudo tee direct_reg_access
> 0xf
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
> 0x0
> final value = 0x0 << 16 | 0x2 << 8 | 0x70 = 624
> 
> 10. Testing reads on registers beyond max_register.
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x27 | sudo tee direct_reg_access 
> 0x27
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
> cat: direct_reg_access: Input/output error
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ echo 0x28 | sudo tee direct_reg_access 
> 0x28
> akshayajpi@raspberrypi:/sys/kernel/debug/iio/iio:device0 $ cat direct_reg_access 
> cat: direct_reg_access: Input/output error
> 
>  drivers/iio/light/ltr390.c | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index ee59bbb8aa09..b63301648689 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -38,12 +38,21 @@
>  #define LTR390_ALS_UVS_GAIN		0x05
>  #define LTR390_PART_ID			0x06
>  #define LTR390_MAIN_STATUS		0x07
> +
>  #define LTR390_ALS_DATA			0x0D
> +#define LTR390_ALS_DATA_BYTE(n)		((LTR390_ALS_DATA) + (n))
> +
>  #define LTR390_UVS_DATA			0x10
> +#define LTR390_UVS_DATA_BYTE(n)		((LTR390_UVS_DATA) + (n))
> +
>  #define LTR390_INT_CFG			0x19
>  #define LTR390_INT_PST			0x1A
> +
>  #define LTR390_THRESH_UP		0x21
> +#define LTR390_THRESH_UP_BYTE(n)	((LTR390_THRESH_UP) + (n))
> +
>  #define LTR390_THRESH_LOW		0x24
> +#define LTR390_THRESH_LOW_BYTE(n)	((LTR390_THRESH_LOW) + (n))
>  
>  #define LTR390_PART_NUMBER_ID		0xb
>  #define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
> @@ -98,11 +107,42 @@ struct ltr390_data {
>  	int int_time_us;
>  };
>  
> +static const struct regmap_range ltr390_readable_reg_ranges[] = {
> +	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
> +	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_MAIN_STATUS),
> +	regmap_reg_range(LTR390_ALS_DATA_BYTE(0), LTR390_ALS_DATA_BYTE(2)),
> +	regmap_reg_range(LTR390_UVS_DATA_BYTE(0), LTR390_UVS_DATA_BYTE(2)),
> +	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
> +	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_UP_BYTE(2)),
> +	regmap_reg_range(LTR390_THRESH_LOW_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),


We don't need separate lines if there is no gap. I didn't check all of the lines
but at least these last two can be combined since LTR390_THRESH_UP_BYTE(2) is
0x23 and LTR390_THRESH_LOW_BYTE(0) is 0x24.

	regmap_reg_range(LTR390_THRESH_UP, LTR390_THRESH_LOW + 2),

And we could avoid adding the extra macros just for this since they
aren't used anywhere else.

> +};
> +

