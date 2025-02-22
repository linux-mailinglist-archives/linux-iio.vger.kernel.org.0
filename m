Return-Path: <linux-iio+bounces-15961-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DBEA409FD
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65E511893E73
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98EF1F8677;
	Sat, 22 Feb 2025 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4vBWhy+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D71547D2;
	Sat, 22 Feb 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740241527; cv=none; b=CqFp20YjzYlcYDhymtPwwa624QJs3RZScUwFcsSObD5XE9VHreU5MvPEpj8WVtrJHQi1a63gEghd0k3NrfApXawg5ZO2C57L7+444gHgFrPjSRC+Md6ivMCecNGhnpQIIz76a3XG4H1CMbblA3bS+krCMh6Mkj7KxXUVCivt0VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740241527; c=relaxed/simple;
	bh=zL+LhfxbnRmEVhAa1wVr9ILgzHuLe3gxMbsTA9Jzypg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM+EFJVB03kkrkSy/P8E+zIt6d6PHZPswM9ObrfKTJzvGUHj9c0BUwmXQCi7HG5UM+Gi6EMw9SdrOOe4Xa0KFI3yfuGtc58tjdL6x6gUJ+lH9UImkSl0XvAIqwg6j/9dBBIoxdm8+oyO8/lVOqepq8jqjMeYM7m3jRD0uohBL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4vBWhy+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0bb7328fbso327414685a.2;
        Sat, 22 Feb 2025 08:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740241525; x=1740846325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaLmw/zuUJQPU9jiW+lco631RQaNkAStz0tuGq6zmmY=;
        b=B4vBWhy+3BmIPlqHULJpSs1NiYVaspgR9AbSwq5MobQ91KI4TBLtH22VELoky6ierF
         K6Kf04RsbCpgLDmb05SJ0ruNUnjHi8ntKokTify189x77B48GfElWaoHYiVFBUZOaYAz
         /CYRjE1lGQxOazLt8iNmln1+VZLnJGZ33OavgylG7byLz411vefs9m4gf7PLCCqfZoGZ
         JTBeV069gl6VR7YwZRdcYPe1PJFCbBRRrBl8xc5du/lZ0HxpjQfCSRx7/tF653N9TbOU
         GH1mZLt0RxwOXoOD7xwmwLIlumntxYECeTpsRNh7BCFPHfL3yaR9+rkQmXS+0nLR+++/
         ypEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740241525; x=1740846325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaLmw/zuUJQPU9jiW+lco631RQaNkAStz0tuGq6zmmY=;
        b=uEAWfAdlu/xaxzhwCm1nPKPCp22kTTQIoG3X5xkQgfAWjQ4OH9/bwSaUQKScEC2T/n
         xME/9qa0c7Gxkts1w1HKtRzgM7cv89VcYAtoaJWLJDXBiVyvvh9FUJ3upLQP1mPVBgjy
         nMtaYrZ8PinJ9KijLxR8ziQ/JVKvmkzgssrSu3rnXvKeOe2kckLdwIFqq0t8Sk9yH4t+
         0Mo2DihzBuyeblgUcolQ+e8kzbICDgEAf94NdhuCpXOnQ1WOIlV9YCtdldapCRCHv1ic
         dppkIoD4kTIOnNU+VXvP8rKRT7gRV2jft/nx1YXwlGenojCCCwt2c6fnQEm68AOvU6HB
         /f9g==
X-Forwarded-Encrypted: i=1; AJvYcCUnGIV50PJ67GDnG2fiu/7f0gy/6InA231ZbAVU3NGUWeTS3VI1XHQFIN80iF7+gvCvx4fAHtbpBKmf8E7D@vger.kernel.org, AJvYcCXW+rrSqxjkGQQyzeGAh8a1coNK76bJJ/pYvp8wn4chhHZLEXftdHF4zUoBiaF8y/yaIKDH0B5yCwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCm/bKbSHK+NB32RxnJif1iXmPjl4DGnh8J3a8Q/P6JgnPFku
	JaStEakXtjXLxMx60cjxImWnFowJSenYzRDz/REqrWWaqnNvCspa
X-Gm-Gg: ASbGncvSdIIXXaZITxnavo4Pn3sRyLVXI91p6NExUlEnbZebx8awqgOmC0tQxgmc5LY
	eBxW1xb8ufei8ZNTcC24ImkFLoA3Cfeu8niaJSLtbGgnMf8dSqKWiG/7lM/GCUr4d/RGzGhHmwh
	cWtKwpGyYJ22ajF5AjrN1Hnfbjvk4XZWz4lU7DSSiLSxq2QYnHviJlagrBjNAXiHlEp16AEu5w0
	iJqFEZS8TjGmY/UnmPP1rmEzszxMQEqoMrCdX44onfC+Xo7+RQHfflcgONjPU8aOqDVMBp68ZOG
	M4ilJr6PyOkkNEdb3PPb4iU0+pPHnoykz/ym25CdNmWphbdrZFP/
X-Google-Smtp-Source: AGHT+IGETAROiyYxSv8uuhKgoh2sBA7FeH8Wc56J8yhcnhIttmfFPAeCpRfh3GCcsCtDm0I7H/xhGg==
X-Received: by 2002:a05:620a:269b:b0:7c0:b9bf:9c21 with SMTP id af79cd13be357-7c0cef108ccmr830180885a.34.1740241524564;
        Sat, 22 Feb 2025 08:25:24 -0800 (PST)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a178fc35sm716278685a.102.2025.02.22.08.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:25:23 -0800 (PST)
Date: Sat, 22 Feb 2025 11:25:21 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: bmi270: move private struct declaration to
 source file
Message-ID: <mtmwjyo2jd5pmne4od6fsq3qkhh7smeafviu3bhjoafpv55dur@seepjddh4y7z>
References: <20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com>
 <20250219-bmi270-irq-v1-1-145d02bbca3b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-bmi270-irq-v1-1-145d02bbca3b@gmail.com>

On Wed, Feb 19, 2025 at 08:54:45PM -0300, Gustavo Silva wrote:
> The device's private data struct is currently declared in the header
> file, but it does not need to be exposed there. Move it to the driver's
> core source file to avoid unnecessary #include directives or forward
> declarations in the header.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Acked-by: Alex Lanzano <lanzano.alex@gmail.com>
> ---
>  drivers/iio/imu/bmi270/bmi270.h      | 17 +----------------
>  drivers/iio/imu/bmi270/bmi270_core.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index fdfad5784cc52043475b6816286619fac5824684..d94525f6aee85f21cc9e9ae1bc9c1db0dc00b927 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -6,22 +6,6 @@
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  
> -struct device;
> -struct bmi270_data {
> -	struct device *dev;
> -	struct regmap *regmap;
> -	const struct bmi270_chip_info *chip_info;
> -
> -	/*
> -	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
> -	 * that to ensure a DMA safe buffer.
> -	 */
> -	struct {
> -		__le16 channels[6];
> -		aligned_s64 timestamp;
> -	} data __aligned(IIO_DMA_MINALIGN);
> -};
> -
>  struct bmi270_chip_info {
>  	const char *name;
>  	int chip_id;
> @@ -32,6 +16,7 @@ extern const struct regmap_config bmi270_regmap_config;
>  extern const struct bmi270_chip_info bmi260_chip_info;
>  extern const struct bmi270_chip_info bmi270_chip_info;
>  
> +struct device;
>  int bmi270_core_probe(struct device *dev, struct regmap *regmap,
>  		      const struct bmi270_chip_info *chip_info);
>  
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 464dcdd657c4ba27fdb7620c80e9f05e2a831910..9f24d4044ed6f00f67fd3a8f5adda821c3140a18 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -78,6 +78,21 @@
>  #define BMI260_INIT_DATA_FILE "bmi260-init-data.fw"
>  #define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
>  
> +struct bmi270_data {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	const struct bmi270_chip_info *chip_info;
> +
> +	/*
> +	 * Where IIO_DMA_MINALIGN may be larger than 8 bytes, align to
> +	 * that to ensure a DMA safe buffer.
> +	 */
> +	struct {
> +		__le16 channels[6];
> +		aligned_s64 timestamp;
> +	} data __aligned(IIO_DMA_MINALIGN);
> +};
> +
>  enum bmi270_scan {
>  	BMI270_SCAN_ACCEL_X,
>  	BMI270_SCAN_ACCEL_Y,
> 
> -- 
> 2.48.1
> 

