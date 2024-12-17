Return-Path: <linux-iio+bounces-13594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1BD9F5A93
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 00:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0351699F7
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 23:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186EF1FA15E;
	Tue, 17 Dec 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMaa5hSG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AA14D6F6;
	Tue, 17 Dec 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734478920; cv=none; b=kr0bM3JjaKG6uQnU5Pk+EJvvjjPkX+biDRBmWdEJKAluHF18mHSdObozE/hbjYmuO6cpk8Ed5VDJyOykCbGBN0lkJyXkH1lcWcMoiQTrX7OJqXfcpXFQJidCme55S45bHoydF4FXd50KhSPWef+vEy+UOpE7/Gag5NFoGmhQUb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734478920; c=relaxed/simple;
	bh=XFQv126e9bQJRmD0JNNF7V+d75YK7PLVvxS/mkdEucU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXxNxD9ZMrXcYtx1skEPrAJsbmBy5wAF/c81Fdpm7+Sxe/iL5n8aRN3TNvNr0NaEVrmjxnwq79W9IZ8kVY0i4mbAW5cSdL2GrwNOdqWpjcpmw290nac7uYr1r4WViWdAlE4cHrRvZFMb4gMH8+7KnAsW/tDzTU6GodPlSB8aHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMaa5hSG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so1180689166b.0;
        Tue, 17 Dec 2024 15:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734478917; x=1735083717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2aCCfIbXDLvRpWnQVaN2dBApiT+ck1mNXzxWnHi5wn8=;
        b=OMaa5hSGuO3/78DNjJSH0fXWUHD7SETfb4ppcJ8hxxGNKlJFR52ZJ0JT0LzqJWzA8j
         54mik/HiIzjWUwdL+VaYal4PHYL0Kt2EpVtAmbVc5GllOEzrz/RjgS3wS3jJ878MjXwe
         WdfXC0VRbidegvpBlMGY+/Uo23tF0b+K7STkU3CAhbVfzmPrfN9F1GHTIwt2jJNExd11
         h5QaUbKSxsbtDRD7iJvQRdGZ8AErN1EG1yH7UT4c/h1BqWa/MweKfeoBdvMUbAkTlYXJ
         CCBhYL3X2XVj8oP3iC4WjEMDm53pQysyct0nC4mngQTn8b2uXou1uEzT8xiM+g9umSoR
         jG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734478917; x=1735083717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aCCfIbXDLvRpWnQVaN2dBApiT+ck1mNXzxWnHi5wn8=;
        b=qvI/vvxHG3RcCuvmA+y7RYJOAx2VQluoPZ3siH4mvrANGjLzFo5H4+11Lo6a6kkVEa
         IeW6tuKFhQdkkzPctipOh+Bltq6Lp9MTMqs8D2Sf/1Bx+Llrt4Lt85t+VGQyZH/mV14v
         WHkVI8m5dqBKd2WCXCtFMTZ0quAgI1pJzOdfqi0cXP5ak0tbVqxjv6gofa+rp5o9CT5W
         KaWNyyoAHSBlbasLDyV64T8W3qV0Y6xr1L5gMaM1dRDgofUMo5INcj70B4YNWw5Zu3SO
         yQKwuW692PI/L76LZ0F8xzQQFGNe01jSwzrQQtIFBuSOUxrTdNBikk2t1KB7cA049pbg
         XHqg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Nd1ss9Su0KjWkZ57ct+D5fy34kW+esjxqSbIpMQp8ZMmNhkZ56SMPQsWYHQCSz/7h8LxXJm9vZo=@vger.kernel.org, AJvYcCVxsoiytPpycYYOZrTZdS1SNFkqWXq1Ki5jAOVl1+DeGgwAe8vHPwGYUsL6Pd7zBWkN+D8tJPSRIKWC1Pre@vger.kernel.org
X-Gm-Message-State: AOJu0YztR3i2QCSXh5gShXgg2McLhhoLcbCdU/JuvEsrPCrzssVS/AQa
	hzCesGKimENOyTmuzFnTOrBpkPBhPIFidEOx0JfYkvNBRZSAJvOk
X-Gm-Gg: ASbGnctvzuCjM0cflQMnHjPkk4Dp8iVizZti9QWCaun09aHilsgu0QXhRk+CvxCXPQt
	3/U5Hg7zbIq9+KKgSQi84hIFwjgHfqRzBEhR/8CpBmrbX4kcGVdAYiUAztBuJkkL5XAstFaGUcz
	8RFqetIja04A0odFMg00aUvUAt/GdBHUiLHpjdxoS5DBzuoSD+Manu6fL4Nu5sX1CKIrOpEr0PV
	CMSPNaoBXOnMl2Gfjjo4CfVLsIbT8xuhLTXIbOjuXiOsgG9Rj+VDoMuhpXAMdC4fzg=
X-Google-Smtp-Source: AGHT+IEScIHZxzWBzIEaHuiYT5aSsPsIjbCmG9nDv+Y02BLPWrrFQyBike5bjd6oOosLBcWTtUfj2Q==
X-Received: by 2002:a17:906:3184:b0:aa6:a21b:2aa with SMTP id a640c23a62f3a-aabf47177edmr40279966b.12.1734478917253;
        Tue, 17 Dec 2024 15:41:57 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:9def:1d56:b8d3:22e8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963595e7sm492742566b.115.2024.12.17.15.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 15:41:55 -0800 (PST)
Date: Wed, 18 Dec 2024 00:41:53 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, lars@metafoo.de, krzysztof.kozlowski@linaro.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	abhashkumarjha123@gmail.com, jstephan@baylibre.com,
	jackoalan@gmail.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: common: ssp_sensors: drop conditional
 optimization for simplicity
Message-ID: <Z2IMQXJC-A0TjQK2@vamoirid-laptop>
References: <20241214191421.94172-1-vassilisamir@gmail.com>
 <20241214191421.94172-4-vassilisamir@gmail.com>
 <5e133bba-ee3e-498f-80ea-375dd857c057@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e133bba-ee3e-498f-80ea-375dd857c057@baylibre.com>

On Mon, Dec 16, 2024 at 03:57:44PM -0600, David Lechner wrote:
> On 12/14/24 1:14 PM, Vasileios Amoiridis wrote:
> > Drop conditional in favor of always calculating the timestamp value.
> > This simplifies the code and allows to drop usage of internal private
> > variable "scan_timestamp" of the struct iio_dev.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/common/ssp_sensors/ssp_iio.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > index caa404edd9d0..6b86b5315694 100644
> > --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> > +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> > @@ -8,6 +8,8 @@
> >  #include <linux/iio/kfifo_buf.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> > +#include <linux/unaligned.h>
> > +#include <linux/units.h>
> >  #include "ssp_iio_sensor.h"
> >  
> >  /**
> > @@ -70,7 +72,6 @@ EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, "IIO_SSP_SENSORS");
> >  int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> >  			    unsigned int len, int64_t timestamp)
> >  {
> > -	__le32 time;
> >  	int64_t calculated_time = 0;
> >  	struct ssp_sensor_data *spd = iio_priv(indio_dev);
> >  
> > @@ -82,11 +83,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
> >  	 */
> >  	memcpy(spd->buffer, buf, len);
> >  
> > -	if (indio_dev->scan_timestamp) {
> > -		memcpy(&time, &((char *)buf)[len], SSP_TIME_SIZE);
> > -		calculated_time =
> > -			timestamp + (int64_t)le32_to_cpu(time) * 1000000;
> > -	}
> > +	calculated_time = timestamp + get_unaligned_le32(buf + len) * MEGA;
> 
> Don't we still need to cast to 64 bit to avoid multiplication overflow?
>

Hi David,

Thanks for your message!

Aren't we already covered by the fact that MEGA is defined as an
unsigned long?

	include/linux/units.h:12:#define MEGA 1000000UL

Cheers,
Vasilis

> >  
> >  	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
> >  						  calculated_time);
> 

