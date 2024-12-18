Return-Path: <linux-iio+bounces-13625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468379F6F4B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 22:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768701689EC
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FA81FC7E3;
	Wed, 18 Dec 2024 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVzfh1Ax"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3291FC0FF;
	Wed, 18 Dec 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556442; cv=none; b=JM8Px9C/+EBG5qZbxpEEhj/qXPaPSBuX9O708SGgw7saxCtC0JhmBQbLgAH36G5zsXWlVer1hpnG6lL1PAr/NRO+e/CA53jvCcjSmUETos3G6H1UYQOEXAQOF+jdJRyrDs+FAqy/KzNRtLrnRi7d9vTJrk8Y6iqZnS1e9kRKf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556442; c=relaxed/simple;
	bh=mdA/aqc4vInTIIcN9K3Et3QcxinuCdrZ7bhzs+GPwCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUVO3tAfTlq32O44tvyKutwlVDOdufI9n4dJU6onpsrnAth8tenEMxd4XbYLJc0lhGCm0md9NHk+OdpPPBQZL0HpbV4m3Af4DxUIVj5TGlvggeP/ZqmAFT5VYB7UwC1esYsrsqlVS2q3JOV+XDNAvFKjk/85TtmI4S7CQGvI6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVzfh1Ax; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso12102966b.3;
        Wed, 18 Dec 2024 13:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734556439; x=1735161239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CKNuMfRNIeV3zS3kIc0XbdENZZRVyei3P9oAOVAKFTQ=;
        b=RVzfh1Ax56GQSAck+Hr37re8CalOgnFBRhnXaw5FW3OJ30sOABgbxtkirSs42Z0uHM
         LW/gyBo1XXg9H7JGJFhUzsTHJTSg6FNpevxaiuYmYxCj8KEe+qYBKCjKGXBNXFJSz5xj
         mdfYvAn99u+xYJAWbvYsk24o3+GnU98GeoOs/FA728twuFg2b5MnxG1iJltZ0avK7sxd
         Xbg6iBI/GZRIRU7oAS18IF+5kBpSvqBewMnmjrx/qxDEHTLIaGqA19LsX6bwGM1K6kTG
         ugHEyEjtZPFq/Tdup8Qj9AK/bZCeQV+odyvtq5tCLKKRecwzfZKe9kQuNgF3ge8myh6p
         0DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734556439; x=1735161239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKNuMfRNIeV3zS3kIc0XbdENZZRVyei3P9oAOVAKFTQ=;
        b=ED8DfKKo28Xlr6SH4i23GeirEm3kDC8RFCPgdnORDaqtHqjpdMsq276RJdwC3znqn0
         XF0KdMQamD16U6PFQz9mL/JlWsonKlPOOMDFbB+A1hTihAAsuGSCd+LmxbA29H0VBNU2
         YuS9cNFLCxRcWjZiz/f3rJF/oIJXYSytUZS+BGJir9MYhepBuilaJLzuHgpoFaRu6q+o
         Q6NqqxJ/+uE+ifa2mfyBihlx43uv4nvvUHfwDd9exjwl3O96FIMaZkQHiMYFG1XWVPiq
         xAfzjhRizC9LvYISCwzsyaWKXrYDzaVe/+jzxIVH/WgzRSI/sg4+ueYTKChFk5X7h2LG
         6SCg==
X-Forwarded-Encrypted: i=1; AJvYcCVPSCeopLOmVjVY8ORQ9tr/VJt0E20NZkB06YTBUX3TbTgvFkujwg1Jxe5L9kB08srOnUK8wOwroEY=@vger.kernel.org, AJvYcCWOlnqHAjKKDpj3fBVkzqZ2NsoyQ4MGbj8WAOvqizWSal8odStZeSqWDg+VQRC4VaDDXvODPW0NLN8WefVO@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjjBP5kj0Gm4ELhYMZy9zaA718q3Hj7P7C2tyj/j0LnxGflgI
	Pw8cs55+4EhbZ38RqLS7Ia5XA0B5thZ+dJu996uK01vg4X/QgRE9
X-Gm-Gg: ASbGnctGf1qUFxT3FMUYydZLEp027TjHkIo6KN2lTv1FfM6XUPQGRyDjchpBy2jJPTi
	2AE0wO3EBN5bZuV9Dq5uJRcMhwLh+e7TACx2vCRwCnXait8yZPh1mrY2ooW5Jezx9rj7fYzyQZG
	ZjYrEAbk607KftGilhpgtn0mD/h2XjxI2sfGzEmY1eY7kkQQAzzkFLOanHJVCJ3R7QrQgMb2GV+
	BL3e2jQgv+wJkY+5XdztZWU6FV5y4mN2q0Cf6qYkTJVJcR3WYbt47fWbe4XEUV5qF4=
X-Google-Smtp-Source: AGHT+IFVtisHCGBDMwXh/VH5T2LqLUsEW3TmhQyDx/yUQU4jF6AIg/JIwiRmWIwEvvHuOSTMa3hiDQ==
X-Received: by 2002:a17:907:7ba8:b0:aa6:2cc5:56b7 with SMTP id a640c23a62f3a-aabf47a5ed1mr469216766b.33.1734556438711;
        Wed, 18 Dec 2024 13:13:58 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:9828:151f:88ce:ddd3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635960esm602222366b.123.2024.12.18.13.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 13:13:57 -0800 (PST)
Date: Wed, 18 Dec 2024 22:13:55 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, lars@metafoo.de, krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com, jstephan@baylibre.com,
	jackoalan@gmail.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: common: ssp_sensors: drop conditional
 optimization for simplicity
Message-ID: <Z2M7E9gmJyFkNEcD@vamoirid-laptop>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
 <20241214191421.94172-4-vassilisamir@gmail.com>
 <5e133bba-ee3e-498f-80ea-375dd857c057@baylibre.com>
 <Z2IMQXJC-A0TjQK2@vamoirid-laptop>
 <82e97712-3765-4d93-bdb5-f50fa7025e81@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e97712-3765-4d93-bdb5-f50fa7025e81@baylibre.com>

On Wed, Dec 18, 2024 at 09:17:44AM -0600, David Lechner wrote:
> On 12/17/24 5:41 PM, Vasileios Amoiridis wrote:
> > On Mon, Dec 16, 2024 at 03:57:44PM -0600, David Lechner wrote:
> >> On 12/14/24 1:14 PM, Vasileios Amoiridis wrote:
> >>> Drop conditional in favor of always calculating the timestamp value.
> >>> This simplifies the code and allows to drop usage of internal private
> >>> variable "scan_timestamp" of the struct iio_dev.
> >>>
> >>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> >>> ---
> >>>  drivers/iio/common/ssp_sensors/ssp_iio.c | 9 +++------
> >>>  1 file changed, 3 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> >>> index caa404edd9d0..6b86b5315694 100644
> >>> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> >>> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> >>> @@ -8,6 +8,8 @@
> >>>  #include <linux/iio/kfifo_buf.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/slab.h>
> >>> +#include <linux/unaligned.h>
> >>> +#include <linux/units.h>
> >>>  #include "ssp_iio_sensor.h"
> >>>  
> >>>  /**
> >>> @@ -70,7 +72,6 @@ EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, "IIO_SSP_SENSORS");
> >>>  int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> >>>  			    unsigned int len, int64_t timestamp)
> >>>  {
> >>> -	__le32 time;
> >>>  	int64_t calculated_time = 0;
> >>>  	struct ssp_sensor_data *spd = iio_priv(indio_dev);
> >>>  
> >>> @@ -82,11 +83,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> >>>  	 */
> >>>  	memcpy(spd->buffer, buf, len);
> >>>  
> >>> -	if (indio_dev->scan_timestamp) {
> >>> -		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
> >>> -		calculated_time =
> >>> -			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
> >>> -	}
> >>> +	calculated_time = timestamp + get_unaligned_le32(buf + len) * MEGA;
> >>
> >> Don't we still need to cast to 64 bit to avoid multiplication overflow?
> >>
> > 
> > Hi David,
> > 
> > Thanks for your message!
> > 
> > Aren't we already covered by the fact that MEGA is defined as an
> > unsigned long?
> 
> That is only 64-bits on 64-bit architectures, so could still overflow on
> 32-bit architectures where long is 32-bit.
> 

Hi David,

Hmmm, I think you are right. I can fix it in next, iteration. I will
wait also for Jonathan's comments on the rest of the series.

Cheers,
Vasilis

> > 
> > 	include/linux/units.h:12:#define MEGA 1000000UL
> > 
> > Cheers,
> > Vasilis
> > 
> >>>  
> >>>  	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
> >>>  						  calculated_time);
> >>
> 

