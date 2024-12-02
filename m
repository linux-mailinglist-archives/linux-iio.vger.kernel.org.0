Return-Path: <linux-iio+bounces-12973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23CF9E0C11
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 20:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E62B282C4A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F951DE4D7;
	Mon,  2 Dec 2024 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgOnZgUb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDA1DE3DF;
	Mon,  2 Dec 2024 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167697; cv=none; b=Mk4LSJgjuG2WdBG/Z7i0YXpJNWSsIeNo7RvylpT62gA5yipPaYHfjcGzM1nJoVhZxPIZmXfZY0mv3LDs+GMzxQOXMx+mlj/7ygKOfnHNIlXKJkS7ZgLCxRiIYq30BrqrYe6iwX7dRoZDlMSQkdORq7quTpeN+loKqtdoDTXxT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167697; c=relaxed/simple;
	bh=uL42QM54JcwWO9Tw1t+DY/RfwwRTAzGfelzCcphrcYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpHsrCVy3Fmn5NozKGza+sqdl8YrljYHZyg7aVJ6SpcXEAohrJahPxCNFTozOrUyPAnfobKBAQG2uZRSCMZRYu8DkZOlhQZfejqHPIKq+c1RaaG1E4Hs0PlqgZl+WUBmcgPTrWbprL53Gtpro/7wtu4IjqMey+YVJTAJM4ClgZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgOnZgUb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385e2c52c21so1539140f8f.2;
        Mon, 02 Dec 2024 11:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733167694; x=1733772494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rotfJmgcs3FmyrpFGtJ794jpn8DTXvPaHo9IuQQlTPY=;
        b=GgOnZgUbVmpUM+S0SQRW6Ve3aEBnN1fL9KmRuZF5dvsHMJkWNvD7HqZqzoyE6h0gnf
         qZ+LMnPr9pdjLRdHTW3WnI/orguqaRkj11VnhUjPGR2p89vOrSagcdwO5eWJZkzkcQWM
         avIcweC0V2bJEfTlkH8NAkFcCnjY+OgWfyor30IKmRKnDJ1VedVtNoPTqR+PUuTuOanY
         iQJbINiVzWUrohSl6DJTphL8yNKOoeP8vjqESzcI4oGh/M9G6Gk9EDi7W279McTy33/v
         qZFAin2sKvyOdjacsXkPNsjr+omqYE0oQFAz1hSclvq7AZlNl/264m6yNwMSIoHmFKws
         dMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167694; x=1733772494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rotfJmgcs3FmyrpFGtJ794jpn8DTXvPaHo9IuQQlTPY=;
        b=K25ADcypMzWt1NmcWhX81DpEEic6wQ/nFauo7Qvp0jV6QjFUxkixN2sKuyEBIP8+Do
         +CrK7cf4vUdEXqnUqRC+VuGh67LndzHneFZd/8ssZNnYFfjaqb4OyTsJ/n6eEzC4ssh/
         Fvf43U3R+nXRBapuE65CCvsynotSHXu1/se1ME+zqYIp/Rtys8eX0BuFcuh8gdkUPiqt
         tXc0u2Ed/PTmc29A7VQU7uu6iKw29B4t7M3st3g4Ggehhm6jYkV3C9mfciCMfFeCBlbX
         CaSHjuo7PlC7g+mWPHJqJtmQvVevst65ubWqKu/zSYCoTsq25M+leCFuEO95DMwIgIlj
         XGCw==
X-Forwarded-Encrypted: i=1; AJvYcCUBswZTWTt4WSrE2GGNYy3BtvsZ/FwoMEwAuDQpEj0DlZYx8XGpFwxDbn6jjHDeP6BAGgEYgg3b@vger.kernel.org, AJvYcCUw2p9gGPpwqB48TKZ94mKSsSpIp6tOmvWAGNGUtqELmsMgTNFjwzYJXG0p2njW4z5H1ngvdIYjxCg=@vger.kernel.org, AJvYcCXojKu1yi6ovYRmFB5LTO8ef11Jv6hSI/YjA2mrcFAu7a59MTuoBzbwUTDeTg7uLtEjzv0V3oSht5rkwMuv@vger.kernel.org
X-Gm-Message-State: AOJu0YwduUBmTIMpOlJQQbmA8cyzRQ9wN+ZQ5z6XMstprwXlPF3fnfws
	7NSmcVaXshmWckQY+Mxh0oeGmDt4yagstQrmttOlXxmer+Q3xR6b
X-Gm-Gg: ASbGncv4jGK3yjqsmt88y5BxQ8StOJ3y9xBbchoKUsSetMR/RCf0T2hivOYucTKXd4/
	E6xJ2SYHH6Oiv4LV9mMTujZiQpYIPHuXKeqT+R/DKVwQE7ow5Qmr7lFS7L8uadItSuh38r1ujCh
	p+pa2XaBfpVHI1odcj8roBRyxQfVUQUh9/KTY9pd1peu78A3dVk84vieq1IIr8VNXnGjMTNU/40
	PJRiOTA8Ok9fHeyWHfaO+HzcXOl7N3wz+JRDq+WXowWBMvIycD5VBo7nGYom1WIq7m1qqeW6g1G
	hgDFOoxEqvUvYaM3M3F+pVe51+b7F33MiXecRPam4F9bSJ2+Jf4bHQ2ITtSXFVGfEQYaX/gptxp
	gIDSKmQDxK/XV2hE5AwHh5YIRacKPOEV0wik7DFAvGcI=
X-Google-Smtp-Source: AGHT+IGNv6h5qpBFYdC5mpLdlPElOy/mBbW7OjsNkLFhwocwabDBXDNBmlfJeexl4xRSXA3vm969aQ==
X-Received: by 2002:a05:6000:1f89:b0:385:dc45:ea26 with SMTP id ffacd0b85a97d-385dc45f392mr14677344f8f.12.1733167694080;
        Mon, 02 Dec 2024 11:28:14 -0800 (PST)
Received: from ?IPV6:2a02:8389:41cf:e200:d553:b993:925a:609c? (2a02-8389-41cf-e200-d553-b993-925a-609c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d553:b993:925a:609c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5e59sm198035145e9.44.2024.12.02.11.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 11:28:13 -0800 (PST)
Message-ID: <521fffbf-6de8-4ce5-8af1-45c4029c7e60@gmail.com>
Date: Mon, 2 Dec 2024 20:28:12 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] iio: temperature: tmp006: fix information leak in
 triggered buffer
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Antoni Pokusinski <apokusinski01@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, stable@vger.kernel.org
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
 <20241125-iio_memset_scan_holes-v1-1-0cb6e98d895c@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241125-iio_memset_scan_holes-v1-1-0cb6e98d895c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2024 22:16, Javier Carrasco wrote:
> The 'scan' local struct is used to push data to user space from a
> triggered buffer, but it has a hole between the two 16-bit data channels
> and the timestamp. This hole is never initialized.
> 
> Initialize the struct to zero before using it to avoid pushing
> uninitialized information to userspace.
> 
> Cc: stable@vger.kernel.org
> Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/temperature/tmp006.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index 0c844137d7aa..02b27f471baa 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -252,6 +252,8 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
>  	} scan;
>  	s32 ret;
>  
> +	memset(&scan, 0, sizeof(scan));
> +
>  	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
>  	if (ret < 0)
>  		goto err;
> 

@Jonathan, this patch requires 91f75ccf9f03 ("iio: temperature: tmp006:
add triggered buffer support"), which is in the mainline kernel, but not
accessible from iio/fixes-to-greg.

Is there any branch in IIO where the fixes and the new features are put
together? I would like to rebase my series to automatically get rid of
the applied patches, but iio/fixes-to-greg (where the patches were
applied) does not have the feature this patch fixes. Of course I can
manually drop the applied patches, but that is error-prone.

This is not the first time I face this inconvenience, and I suppose
there is a cleaner way that I might be missing, or maybe that branch I
am looking for already exists.

Thanks and best regards,
Javier Carrasco

