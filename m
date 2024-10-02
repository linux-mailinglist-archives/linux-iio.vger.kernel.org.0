Return-Path: <linux-iio+bounces-9993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7323398CB57
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 04:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E91C20756
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 02:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060C23CE;
	Wed,  2 Oct 2024 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BS1Lksfs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866D17548;
	Wed,  2 Oct 2024 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727837361; cv=none; b=c8ys2JJ2aUOzC+Q8pZKyU1ZgQm0/lpZTeVAQxfIycfzJsLWWDjO6kK8rwD8N20wyj+k2PYDFI2WrAbkCXjJmVinV5/u4jxZ/b65sxBh1U+MjEh66zm6X9yXR8cSvPO7Ylqw5WaymssEQqwzlvxdb+BYJU649wj+3FpOko2GZQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727837361; c=relaxed/simple;
	bh=g6JCXNF6GwtZ+RgMT/THylB+sN+lh2CnkcPgz8BxFqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ1N5uTQ8LqJQZR0QfkIyHEx6U8uPRZCcnAoT67QJXEFJnvq4N6jty7bo8/5v+rI9/PpOxhd1iNOREJirZLKaVT8100iiIB3czTKKZ6xRREaCxMIrJHXQMgoJFJ4F+iknBDlTYwj/DPC+qnySpcgViWjEJ52lGFVKmTYKPSnWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BS1Lksfs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso50001755e9.0;
        Tue, 01 Oct 2024 19:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727837358; x=1728442158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3G1j1oP4m1f1TYdPZNj2l6bWg0CopPXXYtdupBtxJ8=;
        b=BS1LksfsKgcw/1fUTvi2PoU30VxqyXNWshKOTqQPA78B49SRs46V3hwkqt5R7w7MHv
         QkuoVYLCEsWVzhqTW6RGYRauBj3Ht91VizDolQbjYFwvcf95k9R3sNBzv2I6cDCFn0qj
         1ekbDBJ6Ja8j46xVyWXP+tvzGtusRa8k11qG+7wrMxTfwOMwsSllrRVyGuhPzvMj6TPv
         vHWVtCqpbnINe8XAcP4wbLTG5KAPNFJQZP3qEX8VYIMx+kBgdusWZUZkc+K9CFoZoMVG
         cTzoW7CPhMKTwyWibjycqWDSYFGBkYrGwEZIp356sAxESqfO75iNey1Qil/U2cr/chE3
         +erg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727837358; x=1728442158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3G1j1oP4m1f1TYdPZNj2l6bWg0CopPXXYtdupBtxJ8=;
        b=GeWtqmoFNheVuo/0fWImbG2eGd5iJJv/CYimoH3eMsXibIIN6BCrnXcUDTOaZ4oHiZ
         SW4tbDN7tGlqTCWyVHDQZx3FGBA5AGfPZuCMflLNcB+Fgek4TY7P6du0gRyrA0tg+Hp+
         ti+Xlk0Fse3gmGe4JVGEzZ6IlYwOSSSXQgvsg1YxF/HG19BapdCujHu40hyu9vw8BLXs
         nvHDTngr3GK1KEQWMqxZUxeUoqsDO8UHF9Wr28WmacV+XohFR01y/Hu/0Cebali1g1Sa
         GLSIrpK36RNiJYdGzLvCeC/yk0JxmhIlgklIx9zMlnNZiKSBfLDALGjPeWihVV0PCX1A
         7LiA==
X-Forwarded-Encrypted: i=1; AJvYcCV74bSANVjH3e35OdqQ3ml49IGrr3hiT0B8tWk2ufIKexN3co2oEMoW3JBS+MeME7zd7cq+AmfjAoLlY9hu@vger.kernel.org, AJvYcCXI2XLw+pN2/5Zh2TKc1ur9jPXiCWRdeilBxezUxiw+PbVjFUsNijx65xkV5Pza/f8PH2RzH8MglFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcPI7k81MUiN06bSETaGMHn3Sq5JDLIvJ1LSlTA/RVDqAnNiAx
	Dw0evDkdPRmxhDQtzOOnah0PhAruKS/yuq6Ve3k6t0gYILOQbtbk
X-Google-Smtp-Source: AGHT+IG8i54WhYDVWTDeKf+kvVT+4CKvUd4iQt9WFrOVXWaOje1YYxfJv2duSQ0MQkMhqIKXqV2slA==
X-Received: by 2002:a05:600c:4683:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-42f777bf81bmr10084635e9.8.1727837357387;
        Tue, 01 Oct 2024 19:49:17 -0700 (PDT)
Received: from redaops ([146.70.124.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ff91a1sm5611645e9.38.2024.10.01.19.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 19:49:17 -0700 (PDT)
Date: Wed, 2 Oct 2024 05:49:15 +0300
From: Tudor Gheorghiu <tudor.reda@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: rename macros
Message-ID: <Zvy0qyQJP1S17SFv@redaops>
References: <20241001202430.15874-2-tudor.reda@gmail.com>
 <20241001225426.wUBOFdMi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001225426.wUBOFdMi@linutronix.de>

On Wed, Oct 02, 2024 at 12:54:26AM +0200, Nam Cao wrote:
> 
> You probably want to elaborate what you mean by "their naming choice" (i.e.
> how does the naming choice causes this false warning?)
> 
> I got curious and digged into checkpatch.pl. This script expects macros
> whose names match "IIO_DEV_ATTR_[A-Z_]+" to have the first integer argument
> to be octal. And this driver defines macros which "luckily" match that
> pattern.
> 
> There is only IIO_DEV_ATTR_SAMP_FREQ which matches the pattern, and accepts
> umode_t as its first argument.
> 
> Instead of changing code just to make checkpatch.pl happy, perhaps it's
> better to fix the checkpatch script? Maybe something like the untested
> patch below?
> 
> Or since checkpatch is wrong, maybe just ignore it.
> 
> Best regards,
> Nam
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4427572b2477..2fb4549fede2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -817,7 +817,7 @@ our @mode_permission_funcs = (
>  	["debugfs_create_(?:file|u8|u16|u32|u64|x8|x16|x32|x64|size_t|atomic_t|bool|blob|regset32|u32_array)", 2],
>  	["proc_create(?:_data|)", 2],
>  	["(?:CLASS|DEVICE|SENSOR|SENSOR_DEVICE|IIO_DEVICE)_ATTR", 2],
> -	["IIO_DEV_ATTR_[A-Z_]+", 1],
> +	["IIO_DEV_ATTR_SAMP_FREQ", 1],
>  	["SENSOR_(?:DEVICE_|)ATTR_2", 2],
>  	["SENSOR_TEMPLATE(?:_2|)", 3],
>  	["__ATTR", 2],

Hi!

Yes, this is exactly what I discovered while inspecting checkpatch
myself, however it did not occur to me this could be a problem with
checkpatch. But looking deeper, it seems like it is:

IIO_DEV_ATTR_SAMP_FREQ is defined in include/linux/iio/sysfs.h, along
with other helper macros:

> /**
>  * IIO_DEV_ATTR_SAMP_FREQ - sets any internal clock frequency
>  * @_mode: sysfs file mode/permissions
>  * @_show: output method for the attribute
>  * @_store: input method for the attribute
>  **/
> #define IIO_DEV_ATTR_SAMP_FREQ(_mode, _show, _store)			\
> 	IIO_DEVICE_ATTR(sampling_frequency, _mode, _show, _store, 0)
> 
> /**
>  * IIO_DEV_ATTR_SAMP_FREQ_AVAIL - list available sampling frequencies
>  * @_show: output method for the attribute
>  *
>  * May be mode dependent on some devices
>  **/
> #define IIO_DEV_ATTR_SAMP_FREQ_AVAIL(_show)				\
> 	IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO, _show, NULL, 0)
> /**
>  * IIO_DEV_ATTR_INT_TIME_AVAIL - list available integration times
>  * @_show: output method for the attribute
>  **/
> #define IIO_DEV_ATTR_INT_TIME_AVAIL(_show)		\
> 	IIO_DEVICE_ATTR(integration_time_available, S_IRUGO, _show, NULL, 0)
> 
> #define IIO_DEV_ATTR_TEMP_RAW(_show)			\
> 	IIO_DEVICE_ATTR(in_temp_raw, S_IRUGO, _show, NULL, 0)

The checkpatch script will match all these macros, even if
IIO_DEV_ATTR_SAMP_FREQ is the only one where we need to check for octal
literal arguments. I grep'd through the entire sourcecode, and the only
false positives with literal decimal arguments which match "IIO_DEV_ATTR_[A-Z_]+"
are inside this driver.

I accidentally discovered this issue by running
checkpatch on the said driver files.

I will submit a patch to the checkpatch maintainers with this thread
linked, and if they agree this is a bug and accept the patch,
this driver patch will no longer be needed, since checkpatch will no longer flag
these macros as false positives.

Do I have your permission to add your name and email to Suggested-by?

Thanks!
Tudor

