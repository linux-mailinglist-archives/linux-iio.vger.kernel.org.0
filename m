Return-Path: <linux-iio+bounces-21946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBD5B10887
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD76189EDEC
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E926B2C8;
	Thu, 24 Jul 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRVyxsK9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2612E36E3;
	Thu, 24 Jul 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355172; cv=none; b=HswojG66MtKvLpJl0Yf7JTpz9bqXpc8g3/EPRulzsmWvE+yKykAcwNbCzKNdj+ZtHEGjMNpktHgkHv+rfgIV6WElJT3RkBe0quUMfAATd5n9fU/rvBsWCALQwZaGWeSfMQsT15sPXYqH83hEZqT5YQ8b7Rt87ywzVoAWV2kLqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355172; c=relaxed/simple;
	bh=yyLYFnj1TRsVNYjUal+LrAv/+x6DYhN0HFMa5CpTYYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGRsy1c2vYg7IrBIg9JD4FbDB9n5Exn1TBsWO0I2WZDQJ1UP4A+juU1LzmUj45vEq8REyRO8iVbeBgqNnsRGF7zlHquRI0Mg9Te74a0fAZugZA3a2tfqkUmFki+/2oC8+Gy5q1Bx4DwWR4Uy7M7YJNEjiPKIgEX0h1Z2z+bR8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRVyxsK9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-719c4aa9b19so9048647b3.0;
        Thu, 24 Jul 2025 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753355170; x=1753959970; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9u+2S39b+8oqxlaivOf6eCtHyoeTAucT5LxR35r4xxY=;
        b=fRVyxsK9iUhvaPAx9w7hQw13/IBO4FJS5mkN6wzVfVjYlDUJb6eoG7quvHWNCvbtFp
         GCxThTW4c+j3sqEjy617ds4GjgSI2m6NBLwkHyMIq3cohaN+4do7zUX2/lYZxjKaAzYq
         NIYcK/cMDA+CNh/Tw5Iwx4YxlBoFRhnr84mX2jkERBJAoXvT21VV0/oP312kxF7/BbER
         SVBE/18aUFvfYsjXZjXcowmKSCGlF9fshekQWrc/O68ImfeMwKBDuC8K8o72dS3CYY04
         YUD4Stoef1bp+11YDHqnE4R2O4yhP45P4ZIE9IXZMb5d7IvgJZysRYoLyXlFA7QZA0CV
         Bt1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355170; x=1753959970;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9u+2S39b+8oqxlaivOf6eCtHyoeTAucT5LxR35r4xxY=;
        b=MA98gi+w4zH17iHMKaEYPH70P+deeoLeVtwbPhkAsLIAYZomJ+q8Y1urRO5PoUpCz7
         Nkv1uSlc7EH7Ua1jLV/2pSBB363bIbMSlDa62oy8nsbZ5+2hyFqWt3g9rq1BbAwuu+Pm
         0+BP05Gk9PSmkZuu3mMktztTQYLNKYoU4m2VW3UNYPjOYw5Mqchw9F0s7E8MmaVeECXd
         wN9VjQY5Nt4KYQUYSx4li/6PjSZC6BOAYIb6GI8ehwTfMS2OKIOcHFQoxepN9v800Ork
         K/+R0ppvm7Lw4fUjeqYdCZ1OA+TZ7f0LMZ3lvkwVcu0WzbO+HOlqvgxXg0v+vzejmNv2
         uqpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfxdhGgQRopeL/8tiTBrFkj+8FLu5GCVu/iN/IJsUbeRepqLkhbKFeJvozeA/cWmO1mHSUcjL1b4U=@vger.kernel.org, AJvYcCX7YGIVpPKveAHGlhMAcj2QkcIbydV1xl7QpZSq6T1aTYZj6Abn5xBp790Gp/Fno05FICghuIK8LZyYAKCI@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnBR2QvWp0ADdvakUxyy5YMKWPQgE5B6TS6QCC/auuK7HFJoh
	BvmLyKI3+nP0q2zdno6vM3W1x9XJyPrI1/jYJ8L9ndS2EeHNcvcLpjquL7HYh7zmEtQ=
X-Gm-Gg: ASbGncuiNcenZq71xzftLN0UAdBiZs3MsFvS97uZEIzjF91P4guLTfmGllgYrhg+KyA
	jn+8cY3aOlk14UIOUK4svFVZGBTEj3A/I9hraqy7oknmfrDApibDwx6CIACYJPNtT8z8IYRG6LB
	Lw3Y7YqJTFS0PqBG0xh4OSJUw7IzxRwStWF/orC4nW1hbjf+BNC52xGZQCbjgypVMMHi4cAHcNJ
	06E69XF/BF59sWDWKRdl9mXoNvuX0QRxRK6hdq/FhG5mdU8SVYLQ/0miTrvYSsQL0otQwe5BCh5
	qO7Cf/IXb+8XQJqNiSx+D5J1tB7ZABr6PGgCOszQvp7V9UdbDsX3zLeNWdqPrzkC2+VID+YJJvO
	fB/I3a+VeJzo=
X-Google-Smtp-Source: AGHT+IHR3GqqfLWbY0BgK3ATN4U3UrfaAl01gIt3c/5mn5ki6mjS9KJBHuKDNnLi6N/oiArkE8n1pQ==
X-Received: by 2002:a05:690c:6608:b0:716:3f46:2cf5 with SMTP id 00721157ae682-719b3f70375mr83935467b3.0.1753355169527;
        Thu, 24 Jul 2025 04:06:09 -0700 (PDT)
Received: from nsa ([2.59.157.148])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719cb96c095sm2954897b3.73.2025.07.24.04.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:06:09 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:06:20 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7280a: Remove unused macros
Message-ID: <5j6qcum4oi4cgnzplmnd4xqx2aothhqpk5votscc6v56xdnlwa@gt6x3ugjyr45>
References: <aIIQ3xxCNfpTouxQ@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIIQ3xxCNfpTouxQ@pc>

On Thu, Jul 24, 2025 at 11:54:23AM +0100, Salah Triki wrote:
> This is to fix the following warnings when compiling the ad7280a driver using
> LLVM=1 and W=2:
> 
> drivers/iio/adc/ad7280a.c:60:13: warning: macro is not used [-Wunused-macros]
>    60 | #define     AD7280A_CTRL_HB_CONV_AVG_4                          2
>       |             ^
> drivers/iio/adc/ad7280a.c:97:9: warning: macro is not used [-Wunused-macros]
>    97 | #define AD7280A_CB4_TIMER_REG                   0x18 /* D7 to D0, Read/write */
>       |         ^
> drivers/iio/adc/ad7280a.c:120:9: warning: macro is not used [-Wunused-macros]
>   120 | #define AD7280A_TRANS_READ_CRC_MSK              GENMASK(9, 2)
>       |         ^
> drivers/iio/adc/ad7280a.c:33:9: warning: macro is not used [-Wunused-macros]
>    33 | #define AD7280A_CELL_VOLTAGE_5_REG              0x4  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:99:9: warning: macro is not used [-Wunused-macros]
>    99 | #define AD7280A_CB6_TIMER_REG                   0x1A /* D7 to D0, Read/write */
>       |         ^
> drivers/iio/adc/ad7280a.c:30:9: warning: macro is not used [-Wunused-macros]
>    30 | #define AD7280A_CELL_VOLTAGE_2_REG              0x1  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:52:13: warning: macro is not used [-Wunused-macros]
>    52 | #define     AD7280A_CTRL_HB_CONV_RREAD_6CELL                    2
>       |             ^
> drivers/iio/adc/ad7280a.c:58:13: warning: macro is not used [-Wunused-macros]
>    58 | #define     AD7280A_CTRL_HB_CONV_AVG_DIS                        0
>       |             ^
> drivers/iio/adc/ad7280a.c:59:13: warning: macro is not used [-Wunused-macros]
>    59 | #define     AD7280A_CTRL_HB_CONV_AVG_2                          1
>       |             ^
> drivers/iio/adc/ad7280a.c:46:13: warning: macro is not used [-Wunused-macros]
>    46 | #define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_5           1
>       |             ^
> drivers/iio/adc/ad7280a.c:37:9: warning: macro is not used [-Wunused-macros]
>    37 | #define AD7280A_AUX_ADC_3_REG                   0x8  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:39:9: warning: macro is not used [-Wunused-macros]
>    39 | #define AD7280A_AUX_ADC_5_REG                   0xA  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:32:9: warning: macro is not used [-Wunused-macros]
>    32 | #define AD7280A_CELL_VOLTAGE_4_REG              0x3  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:41:9: warning: macro is not used [-Wunused-macros]
>    41 | #define AD7280A_SELF_TEST_REG                   0xC  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:96:9: warning: macro is not used [-Wunused-macros]
>    96 | #define AD7280A_CB3_TIMER_REG                   0x17 /* D7 to D0, Read/write */
>       |         ^
> drivers/iio/adc/ad7280a.c:98:9: warning: macro is not used [-Wunused-macros]
>    98 | #define AD7280A_CB5_TIMER_REG                   0x19 /* D7 to D0, Read/write */
>       |         ^
> drivers/iio/adc/ad7280a.c:85:13: warning: macro is not used [-Wunused-macros]
>    85 | #define     AD7280A_ALERT_REMOVE_AUX3_AUX5              BIT(1)
>       |             ^
> drivers/iio/adc/ad7280a.c:138:9: warning: macro is not used [-Wunused-macros]
>   138 | #define AD7280A_DEVADDR_ALL             0x1F
>       |         ^
> drivers/iio/adc/ad7280a.c:100:9: warning: macro is not used [-Wunused-macros]
>   100 | #define AD7280A_PD_TIMER_REG                    0x1B /* D7 to D0, Read/write */
>       |         ^
> drivers/iio/adc/ad7280a.c:74:11: warning: macro is not used [-Wunused-macros]
>    74 | #define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK              BIT(1)
>       |           ^
> drivers/iio/adc/ad7280a.c:61:13: warning: macro is not used [-Wunused-macros]
>    61 | #define     AD7280A_CTRL_HB_CONV_AVG_8                          3
>       |             ^
> drivers/iio/adc/ad7280a.c:31:9: warning: macro is not used [-Wunused-macros]
>    31 | #define AD7280A_CELL_VOLTAGE_3_REG              0x2  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:51:13: warning: macro is not used [-Wunused-macros]
>    51 | #define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_5           1
>       |             ^
> drivers/iio/adc/ad7280a.c:47:13: warning: macro is not used [-Wunused-macros]
>    47 | #define     AD7280A_CTRL_HB_CONV_INPUT_6CELL                    2
>       |             ^
> drivers/iio/adc/ad7280a.c:84:13: warning: macro is not used [-Wunused-macros]
>    84 | #define     AD7280A_ALERT_REMOVE_AUX5                   BIT(0)
>       |             ^
> drivers/iio/adc/ad7280a.c:103:9: warning: macro is not used [-Wunused-macros]
>   103 | #define AD7280A_CNVST_CTRL_REG                  0x1D /* D7 to D0, Read/write */
>       |         ^
> drivers/iio/adc/ad7280a.c:55:13: warning: macro is not used [-Wunused-macros]
>    55 | #define     AD7280A_CTRL_HB_CONV_START_CNVST                    0
>       |             ^
> drivers/iio/adc/ad7280a.c:36:9: warning: macro is not used [-Wunused-macros]
>    36 | #define AD7280A_AUX_ADC_2_REG                   0x7  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:119:9: warning: macro is not used [-Wunused-macros]
>   119 | #define AD7280A_TRANS_READ_WRITE_ACK_MSK        BIT(10)
>       |         ^
> drivers/iio/adc/ad7280a.c:38:9: warning: macro is not used [-Wunused-macros]
>    38 | #define AD7280A_AUX_ADC_4_REG                   0x9  /* D11 to D0, Read only */
>       |         ^
> drivers/iio/adc/ad7280a.c:95:9: warning: macro is not used [-Wunused-macros]
>    95 | #define AD7280A_CB2_TIMER_REG                   0x16 /* D7 to D0, Read/write */
>       |         ^
> drivers/iio/adc/ad7280a.c:48:13: warning: macro is not used [-Wunused-macros]
>    48 | #define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST                3
>       |             ^
> 

Please crop the commit message. No need to past all the compiler output
to make your point valid. This bloats the commit message a lot :)

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---

Some people do like to have all of the register map defined even if not
used. I personally don't... So, with the commit message improved:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7280a.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
> index dda2986ccda0..cf2d70c959b3 100644
> --- a/drivers/iio/adc/ad7280a.c
> +++ b/drivers/iio/adc/ad7280a.c
> @@ -27,38 +27,19 @@
>  /* Registers */
>  
>  #define AD7280A_CELL_VOLTAGE_1_REG		0x0  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_2_REG		0x1  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_3_REG		0x2  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_4_REG		0x3  /* D11 to D0, Read only */
> -#define AD7280A_CELL_VOLTAGE_5_REG		0x4  /* D11 to D0, Read only */
>  #define AD7280A_CELL_VOLTAGE_6_REG		0x5  /* D11 to D0, Read only */
>  #define AD7280A_AUX_ADC_1_REG			0x6  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_2_REG			0x7  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_3_REG			0x8  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_4_REG			0x9  /* D11 to D0, Read only */
> -#define AD7280A_AUX_ADC_5_REG			0xA  /* D11 to D0, Read only */
>  #define AD7280A_AUX_ADC_6_REG			0xB  /* D11 to D0, Read only */
> -#define AD7280A_SELF_TEST_REG			0xC  /* D11 to D0, Read only */
>  
>  #define AD7280A_CTRL_HB_REG			0xD  /* D15 to D8, Read/write */
>  #define   AD7280A_CTRL_HB_CONV_INPUT_MSK		GENMASK(7, 6)
>  #define     AD7280A_CTRL_HB_CONV_INPUT_ALL			0
> -#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL_AUX1_3_5		1
> -#define     AD7280A_CTRL_HB_CONV_INPUT_6CELL			2
> -#define     AD7280A_CTRL_HB_CONV_INPUT_SELF_TEST		3
>  #define   AD7280A_CTRL_HB_CONV_RREAD_MSK		GENMASK(5, 4)
>  #define     AD7280A_CTRL_HB_CONV_RREAD_ALL			0
> -#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL_AUX1_3_5		1
> -#define     AD7280A_CTRL_HB_CONV_RREAD_6CELL			2
>  #define     AD7280A_CTRL_HB_CONV_RREAD_NO		        3
>  #define   AD7280A_CTRL_HB_CONV_START_MSK		BIT(3)
> -#define     AD7280A_CTRL_HB_CONV_START_CNVST			0
>  #define     AD7280A_CTRL_HB_CONV_START_CS			1
>  #define   AD7280A_CTRL_HB_CONV_AVG_MSK			GENMASK(2, 1)
> -#define     AD7280A_CTRL_HB_CONV_AVG_DIS			0
> -#define     AD7280A_CTRL_HB_CONV_AVG_2				1
> -#define     AD7280A_CTRL_HB_CONV_AVG_4			        2
> -#define     AD7280A_CTRL_HB_CONV_AVG_8			        3
>  #define   AD7280A_CTRL_HB_PWRDN_SW			BIT(0)
>  
>  #define AD7280A_CTRL_LB_REG			0xE  /* D7 to D0, Read/write */
> @@ -71,7 +52,6 @@
>  #define   AD7280A_CTRL_LB_MUST_SET			BIT(4)
>  #define   AD7280A_CTRL_LB_THERMISTOR_MSK		BIT(3)
>  #define   AD7280A_CTRL_LB_LOCK_DEV_ADDR_MSK		BIT(2)
> -#define   AD7280A_CTRL_LB_INC_DEV_ADDR_MSK		BIT(1)
>  #define   AD7280A_CTRL_LB_DAISY_CHAIN_RB_MSK		BIT(0)
>  
>  #define AD7280A_CELL_OVERVOLTAGE_REG		0xF  /* D7 to D0, Read/write */
> @@ -81,8 +61,6 @@
>  
>  #define AD7280A_ALERT_REG			0x13 /* D7 to D0, Read/write */
>  #define   AD7280A_ALERT_REMOVE_MSK			GENMASK(3, 0)
> -#define     AD7280A_ALERT_REMOVE_AUX5			BIT(0)
> -#define     AD7280A_ALERT_REMOVE_AUX3_AUX5		BIT(1)
>  #define     AD7280A_ALERT_REMOVE_VIN5			BIT(2)
>  #define     AD7280A_ALERT_REMOVE_VIN4_VIN5		BIT(3)
>  #define   AD7280A_ALERT_GEN_STATIC_HIGH			BIT(6)
> @@ -92,15 +70,8 @@
>  #define  AD7280A_CELL_BALANCE_CHAN_BITMAP_MSK		GENMASK(7, 2)
>  #define AD7280A_CB1_TIMER_REG			0x15 /* D7 to D0, Read/write */
>  #define  AD7280A_CB_TIMER_VAL_MSK			GENMASK(7, 3)
> -#define AD7280A_CB2_TIMER_REG			0x16 /* D7 to D0, Read/write */
> -#define AD7280A_CB3_TIMER_REG			0x17 /* D7 to D0, Read/write */
> -#define AD7280A_CB4_TIMER_REG			0x18 /* D7 to D0, Read/write */
> -#define AD7280A_CB5_TIMER_REG			0x19 /* D7 to D0, Read/write */
> -#define AD7280A_CB6_TIMER_REG			0x1A /* D7 to D0, Read/write */
> -#define AD7280A_PD_TIMER_REG			0x1B /* D7 to D0, Read/write */
>  #define AD7280A_READ_REG			0x1C /* D7 to D0, Read/write */
>  #define   AD7280A_READ_ADDR_MSK				GENMASK(7, 2)
> -#define AD7280A_CNVST_CTRL_REG			0x1D /* D7 to D0, Read/write */
>  
>  /* Transfer fields */
>  #define AD7280A_TRANS_WRITE_DEVADDR_MSK		GENMASK(31, 27)
> @@ -116,8 +87,6 @@
>  #define AD7280A_TRANS_READ_CONV_DATA_MSK	GENMASK(22, 11)
>  #define AD7280A_TRANS_READ_REG_REGADDR_MSK	GENMASK(26, 21)
>  #define AD7280A_TRANS_READ_REG_DATA_MSK		GENMASK(20, 13)
> -#define AD7280A_TRANS_READ_WRITE_ACK_MSK	BIT(10)
> -#define AD7280A_TRANS_READ_CRC_MSK		GENMASK(9, 2)
>  
>  /* Magic value used to indicate this special case */
>  #define AD7280A_ALL_CELLS				(0xAD << 16)
> @@ -135,7 +104,6 @@
>  					     (c) - AD7280A_CELLS_PER_DEV)
>  
>  #define AD7280A_DEVADDR_MASTER		0
> -#define AD7280A_DEVADDR_ALL		0x1F
>  
>  static const unsigned short ad7280a_n_avg[4] = {1, 2, 4, 8};
>  static const unsigned short ad7280a_t_acq_ns[4] = {470, 1030, 1510, 1945};
> -- 
> 2.43.0
> 

