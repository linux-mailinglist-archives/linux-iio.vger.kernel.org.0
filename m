Return-Path: <linux-iio+bounces-22002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D93B1136F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 23:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C517AA0C6
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 21:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74F82405F9;
	Thu, 24 Jul 2025 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dIzrxeZa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511121858A
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394354; cv=none; b=UHA4oKLsJFVIJ24PVo0XNtXPnpblU/BOnW33x7jQCGXQB0bRwKl/7eBr7VJW6ivyIT0UiPXhbnjXgyiTRSbd7ej+xzvLiYYLPCPe9/ObNYzIgppnoiD7LKkk1y1lvOBZ5rr+0VYGleDgkTTdwrAr8lUxedeY1u0y/tghzfKFB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394354; c=relaxed/simple;
	bh=4k0T4FtTtRJhZ8EtAIZW4FvS1POM0DpXLaGklf7ZgjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFp5fPH/xeUsEH/M9+gAVFHN1QCjE2OWrjrH42juoOSQeVzp9B+G6tiz4wjWdrITQFNfzrXOFyNSEB1MJDJpw3Bq5gIxY0nXaYtiyvDhQ8cYCcii+eMzn9T3/iF8l5gqg5AmRcC1MbjMwyHfrixYvJSpthORWk5CJjs4OywtrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dIzrxeZa; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-879c3222a14so50164039f.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753394351; x=1753999151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Xorxttia45jyMhqtR43aAiPCILZbP+rrQy2ed6BrHA=;
        b=dIzrxeZa+h66jAHidlKYfCI4Ml5ALnGiADmE9PgykLfoG3b3Lu/M98jJ6c8fiDM7wL
         EAnvgursUix45296KOpHhzvhc2udU3BCKwYn/i6ueD6XTWbnel05RH4sx90BcPszJ72z
         w5bRXiPThvndauXxrOyTFOmwsdwiwX8iAXP04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394351; x=1753999151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xorxttia45jyMhqtR43aAiPCILZbP+rrQy2ed6BrHA=;
        b=p+tEQqW0PHS1xcDkEqrfN7uHkINs1b+UK6vo5PyJVM23myqqEMx1Wyi0mU2Pffd0Pk
         djDLwWGpl2YFnkwLbwzBsYQUyvfYgw3xFftOPnQ4caNTk/AnlgCQqgf3B+OOo52AAlqu
         LvGAAwYDc2qn/IgcOQmkPNpBKx44SfmJSRKdzQaAHLhUj1OYBAqPDMD5Epcohk4oXg2s
         LcY4v4pKc/2Domzu51fjOHYPNXvS1PMDUVX2bHuwMl0DTmbG/VzoATEzfsxoLqh4gGvK
         eryuo8gfLVQffpDGYV32ygD8uOHYS865P/bDoBAiUwy4xAAOHn8XgQgohvqTBriDOnRa
         hdmg==
X-Forwarded-Encrypted: i=1; AJvYcCVoj7tOICiL6kfbNvh4ccLKlnbqeIyjhQR8n1C7ABuIs/H1yxv+K+gw4Nhd9ULTnVgh3X5P2GpfjfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSjbiyrMP90pePksccWCJR1o4/XiNg3aKPeqdo+GeoW24B8TrD
	UqqPmyRRuABQOb/0sjkRaFLYzVDvQcOwmVkzK1mHu/ER6DtisvAIazINuyi9eBJ/aKQ=
X-Gm-Gg: ASbGncvHNVD4RGzuwiAHtdeH/SwHO5ZDYqdEVJHPrvKCed9HPl4D1asWNQVoRtU2KDb
	O1xsTACDfsxLWQL1TBhSjQ/xq2uRjIq5TnjidVUB5ilnUSfcB77fREeGad1j16SZl1jvz1Rst+c
	oqZCbP7q8y5obHU0wEZXYxapp3IARgNwprUbcH0i1diQyALiOVQ98riLRJlE5zanRvi7b3rQP73
	mdziwgj0PNk/uHQKhqDlE1rFnMOgo0Gc/RF59bswZRoMJ+sitGSundIYeug5QrxhjpTM2L1C4AT
	Nw8Hlxre0qpxeoQ0M/vZixsDfe1lq+UAD1HMD/tOmuiD4iZ4FQ3AYkiwRme4I+AiDE9E//8kl8A
	7B60GSEM4Bh9FPiKGWRP9IeOb0mOmKhVBTw==
X-Google-Smtp-Source: AGHT+IERe89uSYSHDFP4y+Ud0LoliQuPdbBEQmIaghSs2O1f98XNA+2k/Ls89WY65YByhL+8qTuXuw==
X-Received: by 2002:a05:6602:641e:b0:87c:5a38:45e9 with SMTP id ca18e2360f4ac-87c64f48d4dmr1555284839f.3.1753394351310;
        Thu, 24 Jul 2025 14:59:11 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508aea61939sm641314173.1.2025.07.24.14.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:59:10 -0700 (PDT)
Message-ID: <82bd5d44-a23d-4d49-a79a-b6792e62bd62@linuxfoundation.org>
Date: Thu, 24 Jul 2025 15:59:10 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: light: ltr390: Add debugfs register access
 support
To: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250724143945.636380-1-akshayaj.lkd@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250724143945.636380-1-akshayaj.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/25 08:39, Akshay Jindal wrote:
> Add support for debugfs_reg_access through the driver's iio_info structure
> to enable low-level register read/write access for debugging.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
> 
> Changes since v2:
> ================
> - merged the regmap_range of LTR390_UP_THRESH with LTR390_LOW_THRESH.
> 
> Changes since v1:
> =================
> - Replaced _[0|1|2] macros with a respective common parameterized macro.
> - Retained base macros to avoid churn.
> - Swapped regmap_write with regmap_read to avoid negate operator.
> - Simplified debugfs function by directly returning return value of
>    regmap_[read|write].
> - Replaced [readable|writeable]_reg with regmap ranges by using
>    [rd|wr]_table property of regmap_config.
> - Updated the testing details with v2 changes.
>   
> Testing details (done for v2):
> ==============================
> -> Tested on Raspberrypi 4B. Follow for more details.

This is way too much testing information. Summarize what you tested
instead. It makes it easier to see the results as a summary.

> 
> akshayajpi@raspberrypi:~ $ uname -r
> 6.12.35-v8+
> akshayajpi@raspberrypi:~ $ uname -a
> Linux raspberrypi 6.12.35-v8+ #5 SMP PREEMPT Tue Jul 15 17:38:06 IST 2025 aarch64 GNU/Linux
> 
> -> Sensor Detection, overlaying of device tree and Driver loading
> akshayajpi@raspberrypi:~ $ i2cdetect -y 1
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
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
>   58:         0          0          0          0  pinctrl-bcm2835   4 Edge      ltr390_thresh_event
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
>   drivers/iio/light/ltr390.c | 53 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index ee59bbb8aa09..b1028d027e1b 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -38,12 +38,21 @@
>   #define LTR390_ALS_UVS_GAIN		0x05
>   #define LTR390_PART_ID			0x06
>   #define LTR390_MAIN_STATUS		0x07
> +
>   #define LTR390_ALS_DATA			0x0D
> +#define LTR390_ALS_DATA_BYTE(n)		((LTR390_ALS_DATA) + (n))
> +
>   #define LTR390_UVS_DATA			0x10
> +#define LTR390_UVS_DATA_BYTE(n)		((LTR390_UVS_DATA) + (n))
> +
>   #define LTR390_INT_CFG			0x19
>   #define LTR390_INT_PST			0x1A
> +
>   #define LTR390_THRESH_UP		0x21
> +#define LTR390_THRESH_UP_BYTE(n)	((LTR390_THRESH_UP) + (n))
> +
>   #define LTR390_THRESH_LOW		0x24
> +#define LTR390_THRESH_LOW_BYTE(n)	((LTR390_THRESH_LOW) + (n))
>   
>   #define LTR390_PART_NUMBER_ID		0xb
>   #define LTR390_ALS_UVS_GAIN_MASK	GENMASK(2, 0)
> @@ -98,11 +107,40 @@ struct ltr390_data {
>   	int int_time_us;
>   };
>   
> +static const struct regmap_range ltr390_readable_reg_ranges[] = {
> +	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
> +	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_MAIN_STATUS),
> +	regmap_reg_range(LTR390_ALS_DATA_BYTE(0), LTR390_ALS_DATA_BYTE(2)),
> +	regmap_reg_range(LTR390_UVS_DATA_BYTE(0), LTR390_UVS_DATA_BYTE(2)),
> +	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
> +	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
> +};
> +
> +static const struct regmap_access_table ltr390_readable_reg_table = {
> +	.yes_ranges = ltr390_readable_reg_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ltr390_readable_reg_ranges),
> +};
> +
> +static const struct regmap_range ltr390_writeable_reg_ranges[] = {
> +	regmap_reg_range(LTR390_MAIN_CTRL, LTR390_MAIN_CTRL),
> +	regmap_reg_range(LTR390_ALS_UVS_MEAS_RATE, LTR390_ALS_UVS_GAIN),
> +	regmap_reg_range(LTR390_INT_CFG, LTR390_INT_PST),
> +	regmap_reg_range(LTR390_THRESH_UP_BYTE(0), LTR390_THRESH_LOW_BYTE(2)),
> +};
> +
> +static const struct regmap_access_table ltr390_writeable_reg_table = {
> +	.yes_ranges = ltr390_writeable_reg_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ltr390_writeable_reg_ranges),
> +};
> +
>   static const struct regmap_config ltr390_regmap_config = {
>   	.name = "ltr390",
>   	.reg_bits = 8,
>   	.reg_stride = 1,
>   	.val_bits = 8,
> +	.max_register = LTR390_THRESH_LOW_BYTE(2),
> +	.rd_table = &ltr390_readable_reg_table,
> +	.wr_table = &ltr390_writeable_reg_table,
>   };
>   
>   /* Sampling frequency is in mili Hz and mili Seconds */
> @@ -586,6 +624,20 @@ static int ltr390_write_event_config(struct iio_dev *indio_dev,
>   	}
>   }
>   
> +static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
> +						unsigned int reg, unsigned int writeval,
> +						unsigned int *readval)
> +{
> +	struct ltr390_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->lock);
> +
> +	if (readval)
> +		return regmap_read(data->regmap, reg, readval);
> +
> +	return regmap_write(data->regmap, reg, writeval);
> +}
> +
>   static const struct iio_info ltr390_info = {
>   	.read_raw = ltr390_read_raw,
>   	.write_raw = ltr390_write_raw,
> @@ -594,6 +646,7 @@ static const struct iio_info ltr390_info = {
>   	.read_event_config = ltr390_read_event_config,
>   	.write_event_value = ltr390_write_event_value,
>   	.write_event_config = ltr390_write_event_config,
> +	.debugfs_reg_access = ltr390_debugfs_reg_access,
>   };
>   
>   static irqreturn_t ltr390_interrupt_handler(int irq, void *private)

thanks,
-- Shuah

