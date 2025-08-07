Return-Path: <linux-iio+bounces-22396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F3B1D80A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5AB3BB00A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 12:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BD625229D;
	Thu,  7 Aug 2025 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbwUcW3I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C3B7E9;
	Thu,  7 Aug 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570177; cv=none; b=Wkmz/GBkV2+y3Epjafk9XRV9r+NXaEWKan14xOhTMYxSZK47paT2q5rYiWFAQ4q+6ckO5G7OSSWM55keXU8OzeNGs5IKOI0fuu8rwlyqCTbDm67SdasIp8kLp8bDoGfjjrC0XGksuRaz/mMBSYduF01TTuWH0vw9m7WnbwGSsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570177; c=relaxed/simple;
	bh=7Qc79qmokKmkGc2DoArf30XE1/1SyEXBr9TKp4BQMc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1B/gHlJ8//NHFa0kf6ufpthViAcfypS5lC2EYBDspwZLt4uSc28mQQRJKpd7j4hbjbRPNsOgp6DKisuday2k0fhmC5AtRlPnr6lTMyZ/8SLBPPeJEepPkrIONUHGD1uQBZv6yE4fxrZov7AoBl5bDVOf/g04jaOvOpiaQCQZm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbwUcW3I; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acb5ec407b1so144627866b.1;
        Thu, 07 Aug 2025 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754570174; x=1755174974; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UEZ6JMjMFWq/ajIytlyIukchYS0I5o5itIY5eZHJYRk=;
        b=MbwUcW3I4G+z4AJdKznUxLtcNdHgS8yxtzDH9oSUkh5FI3rH6ldNVJoRPTXYo41GAy
         /rUGbxoIAJdJF6LDs0tccS8ypIA4k8Zl0WMM1norROV8iHNeRRSF6HqcHiFn+rjrhyAt
         XSnOy9Jqmwt4G5p894bHSssr+Nfqjm/dei+P/wYX/5/7LemXIBX0WHh+y1IKlL3C+30i
         DQ31XPmSD9ZSXjebVnRKiSABEPFwsectYOskbCRXJccT2tNtDLOPjGhoBNQvW0J49xyp
         lgLbcltQIpT5o9sxr6mLsH4Ls532PQ2BmYaYjK2clifvw+TMxNyPiCLXRb91TZ+MbCYG
         zSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570174; x=1755174974;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEZ6JMjMFWq/ajIytlyIukchYS0I5o5itIY5eZHJYRk=;
        b=pwUSXzEHWdyMRWnaHU5EKMMGlilP35pR1e3JwA0iufM8iaDoAkGmqOR1Tut4aaEiN5
         d+xhR1KCJPrrUhy2grMnqtwJSmxwDMv9T5uOxFVHQn45mV8Sq5oBnFFjSz4DT7S8wBFY
         A7O/gDXu+sHZu1spg1jWkhQy0ssvV74rkNoDhC3XCyR2KE0M23U9x+/zvGilBkFjvuIt
         YRHge3rGJG/HEapwYa+VOT9FiiyK0owXwDflRmap8w9lyk/ucCToy0c/t3C8oQtMdcoE
         zEnXOKlXUxx3fFPelVSyyVxoVUZEZsqJFLZxFYsmxJwVeDXH/GVzPbqlp76dJc93opk8
         BqKw==
X-Forwarded-Encrypted: i=1; AJvYcCXTqN9TuYt4N8lxaNvwN6thmenbbkDNtKejXFR8m5uNYcEoK0+g5cQbusdbE8Mz8ak99nx8KfJcaLun@vger.kernel.org, AJvYcCXWU/oVbxQvIEjPW3puAZK7xDjO4xzzHrdf2iYP222HdMwkaCDlTKBCYzTx1wH3UrmaZuUUFUUhwpt/@vger.kernel.org, AJvYcCXx7I2ELPQFGvHLzWSE9P/9WMEq3IjfV4CtcJ9qT7P1v8Y349g0raXrDDUQomQmup/rG/zM1xZ60c2V0eZP@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXlFaUM13xEHCYstg2CkzMsOmCIhugeIn9CuzqCLIXk9wHir3
	J7IGx67M/tw9DlC99wr7agh7eWknrQ4aNNiZTyjbwjN5PZO1IOo1NABO
X-Gm-Gg: ASbGnctkTiTR9iP/stPRCQoMaXz0UxXd17jdEUMExuAyt/EOir5sZaftJ63mmPlXvTd
	SxhUFui+yEVltghrcSHuUfxLvcp9dz08MrCVMygoGI24ZDJrX3Ce5oLwXxeWe/ud3xQvtiNgJ3Q
	zC8VzgV5qgJnyCw7cVo8YXKWZ+kXx+BOYBnnSEOTDcRFPKpLedEFrBtIF444hIyDKfRyhc7+bMR
	y3HgH+po2YiQA7ArNJmzkRr9b29OUM0Ds6KSDmhsPOCJUB9QLjCehXV+qDP51DROe4hipOYfW4F
	7yUY93e9QiXcjpNVyKLKTLX5yAY1N4uLKgHL1+hmkZwuS3aBvXLz8+B4+lP42tl9r3MYWtXQpuV
	3aI1agi5e0mM=
X-Google-Smtp-Source: AGHT+IHk2AcS+bLdWTHxF1OqJx/oUlvpaaN2dcXOog3JeWq/xuwaQ4xdOXUhvBifyXQXzMv2Zks6ZA==
X-Received: by 2002:a17:907:3e8d:b0:ae0:bdc2:9957 with SMTP id a640c23a62f3a-af9904e86e2mr613390066b.61.1754570174100;
        Thu, 07 Aug 2025 05:36:14 -0700 (PDT)
Received: from nsa ([185.128.9.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3375sm1298171666b.41.2025.08.07.05.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:36:13 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:36:30 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] iio: adc: ad7476: Use correct channel for bit
 info
Message-ID: <zjcwfs4litbfhrq2ho6znuoiwzytp3ty7kwxn6obf6hle73nui@ez6xsjluwoki>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <3d3ccb9195271c8c0cf4b476a10b81fe309d3564.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d3ccb9195271c8c0cf4b476a10b81fe309d3564.1754559149.git.mazziesaccount@gmail.com>

On Thu, Aug 07, 2025 at 12:34:30PM +0300, Matti Vaittinen wrote:
> The ad7476 supports ADCs which use separate GPIO for starting the
> conversion. For such devices, the driver uses different channel
> information if the GPIO is found. The bit information is still always
> used from the original (non 'convstart') channels.
> 
> This has not been causing problems because the bit information for the
> 'convstart' -channel and the 'normal' -channel is identical. It,
> however, will cause issues if an IC has different characteristics for an
> 'convstart' -channel and regular channel. Furthermore, this will cause
> problems if a device always requires the convstart GPIO and thus only
> defines the convstart channel.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
>  v1 => :
>  - No changes
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7476.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 7b6d36999afc..fc701267358e 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -121,8 +121,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  
>  		if (ret < 0)
>  			return ret;
> -		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
> -			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
> +		*val = (ret >> chan->scan_type.shift) &
> +			GENMASK(chan->scan_type.realbits - 1, 0);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->scale_mv;
> @@ -345,7 +345,7 @@ static int ad7476_probe(struct spi_device *spi)
>  	/* Setup default message */
>  
>  	st->xfer.rx_buf = &st->data;
> -	st->xfer.len = st->chip_info->channel[0].scan_type.storagebits / 8;
> +	st->xfer.len = indio_dev->channels[0].scan_type.storagebits / 8;
>  
>  	spi_message_init(&st->msg);
>  	spi_message_add_tail(&st->xfer, &st->msg);
> -- 
> 2.50.1
> 



