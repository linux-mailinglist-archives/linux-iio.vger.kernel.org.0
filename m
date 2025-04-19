Return-Path: <linux-iio+bounces-18346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB829A94500
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062A67A2D22
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670491E00B4;
	Sat, 19 Apr 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmg/pM0F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30C64690;
	Sat, 19 Apr 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745086396; cv=none; b=bM+jHyv/I7OwWNNv5ODB444HFOPvNGdie7yXAgwyfMN2OlKLG2NNnV8O6ixxipsx2ctlH7Suwz9sxRXuzHADsZ1YPBGCU5gkvh+WncwzRLAJ8KC3mqkrB6MGXCd3tlKuVe/ZBpQIYVwVAdvsgBAJSubROgPN4jL+iF5K0m+DE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745086396; c=relaxed/simple;
	bh=GdnvWDBNR2gOB+LenT8RHWopVk2MCmbNJTEOMWfKmjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkzdAk7qFcmCKkZPKcC5tDCL4exr8qneOC+ZcDe5OcgeUXcAwxbA8st5i8/S5/cHj6XUWNy8C2O3ndRoYXz6xqd3Ozc5a+YTbadgifhRJjBHT1b5PtJ6qE6bQh0IEviUJtuxMWbjrCa65k8SquUf/H4GFiqAkHE+cTRPNnn9wts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmg/pM0F; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af28bc68846so2384719a12.1;
        Sat, 19 Apr 2025 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745086394; x=1745691194; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TNRnOiyXacyKehrBjfG/SIyIph4B3poZy/96JlS18Fw=;
        b=Rmg/pM0FVZ6BE0J/kfw//FmCaPIOcrZwlvbtBwyPx0Z8zKdm512jA0R64gtVhlIIV3
         9VZZP19+Qoaev7EQma/gMnGsXm13nz1gLXgFlkf5N2uO98+jnXbXk1BW1MBEPh/f1dOb
         I34Mh3N4ya2Qf7hEiuPJbplK4TJC0brTBzTcZD8KMcXXx2TE0x+8PHd7uqXjphpY8Z/F
         hMedWh1iL/nodVUQmEMcM1zRK5u45QxuVjIAeZlXfi5cnkDzF3gbGVyns0sJtoN+GmOA
         Hsr622fzEGoijfUU8ReiVKGvPwdpK5GB+v/lIlrXBzudMbk7Nrj1vydaIXsBWot+jgG7
         zyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745086394; x=1745691194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNRnOiyXacyKehrBjfG/SIyIph4B3poZy/96JlS18Fw=;
        b=M0IKE3BfmAO7za9ctbQqFt8Q/PsQhJpn1bUu+gyuabugzCt+sFl+qvRujgy1i0OaLK
         8OneJ2Oy3LrAR79Q1AdSdchYlAqZGhhDGNtPe6x+bEGvV0VZXlSyqRmLbEmz5rsPunkE
         8NH+XnFOjZSVQxiJ/t9I8nPmE45LjPifp/INW7cB7PngXb9LrdsMFf1KFLFLCUapbGf4
         1xdyf16XyjCHpuDM39aDz0zbMcMHYvTleTtdGfpaq7CywHMJ0/Lt5rvaJ8VcUHN3QsMi
         VGsytPD/8cMFWR4cbqgB/tf+Ht9Ib3ilcb/0xi/wBSmfoOOqsmjZ1mnOO7tgi/ny3nff
         jrfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Hmaq93DYK5A8rujhm459td5SnpgHExhZYFBaxFD2YMqPpPenW0ju4gdaj97PkIAFJwMmqE/FDAc=@vger.kernel.org, AJvYcCX69sB1QfaJqceKOqyJkeaMmqF2LDKaLI8DkCGM4Ks3Wm6YP3/5SX6OjlLbsrQSKdR1wQ3xXIGcjMpXcp1/@vger.kernel.org, AJvYcCXW6BG/6Pl+6h4xJ0LIrA9sK8Wqd/lsMtVGnSp/bKAX5W8E+XIXXdLVk6drrrwUXCho0py83okG@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUntERsHEMZfMW0XIgttMmL8clB5NeSDWy4kqTl0R5arGUJlX
	vb4h4XHguwFvtnhk3k/I7hnyPQIBH2wkS6SMEeus5hMwoE631j6SRAoDY5TUbNU=
X-Gm-Gg: ASbGnctAz8ZmlZqlvc8jOnGnGKqXAVtmFd4ka+cuuVq5IrCf3TLdw7Y65dQt9sun0jX
	1rOuRHYT1NzXdNIFJlrS9WgXYXOElghUv/jVClQmnu4nIBV4w5lZ2aC0DHL7/2JFch8nMQ5Y730
	IRQUoKlikHMESwA72r9X5v/b0FAbV0lx4wEqQKwqyzxvAFvmH3HcuVGxP/8FnxF6Uv/3XfewPW8
	3/So0gnCgqRinuebMJ8P2ipLcMrZEsG6hhDV4z6jI7sdMoUZcO3Oa1oAd6g7l+CGealKMd4ItM6
	SmEOZ1kOssL9lUD47e38OWHlBPNhh9Adh4Cvzjh+y4+7Qw4=
X-Google-Smtp-Source: AGHT+IF0skBMQ1kT+xLk+++XTW5TiYx+jOnZJc1EJcM6tPtPprZSLzpSuU4H8FPoV2YJAsHrhEPaxA==
X-Received: by 2002:a17:902:d58c:b0:220:c813:dfcc with SMTP id d9443c01a7336-22c536075cdmr122327445ad.40.1745086393993;
        Sat, 19 Apr 2025 11:13:13 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50ed0ee3sm36362525ad.206.2025.04.19.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 11:13:13 -0700 (PDT)
Date: Sat, 19 Apr 2025 15:14:24 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: himanshujha199640@gmail.com, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adis16201: Correct accelerometer scale factor
Message-ID: <aAPoAESnjjyNsHI2@debian-BULLSEYE-live-builder-AMD64>
References: <20250419125413.679290-1-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250419125413.679290-1-gshahrouzi@gmail.com>

LGTM. Minor comments inline.

On 04/19, Gabriel Shahrouzi wrote:
> The IIO_CHAN_INFO_SCALE previously reported for accelerometer channels
> used 0.4624 mg/LSB. This value matches the datasheet specification for
> the offset calibration registers (X/YACCL_OFFS_REG, pg 18).
> 
> However, the scale should reflect the sensor output data registers
> (X/YACCL_OUT, pg 15, Tables 7 & 8), which use 0.4625 mg/LSB. This is
> also consistent with the typical sensitivity in Table 1 (1 / 2.162 ≈
> 0.4625).
> 
> Fixes: 57f9386405a2 ("Staging: iio: accel: adis16201: Add comments about units in read_raw()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---

>  drivers/iio/accel/adis16201.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index 8601b9a8b8e75..982b33f6eccac 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -133,7 +133,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			 * 1 LSB represents 0.244 mg.
Maybe also update the comment?

>  			 */
>  			*val = 0;
> -			*val2 = IIO_G_TO_M_S_2(462400);
> +			*val2 = IIO_G_TO_M_S_2(462500);
If we do the math with more decimal digitis we have 1 / 2.162 == 0.46253469010176
Would it make sense to do 
			*val2 = IIO_G_TO_M_S_2(462535);
?

>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_INCLI:
>  			*val = 0;

