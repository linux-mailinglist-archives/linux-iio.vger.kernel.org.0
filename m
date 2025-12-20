Return-Path: <linux-iio+bounces-27249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE1CD2786
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 951C7300250F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6032288537;
	Sat, 20 Dec 2025 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEbRpTae"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC4023507B
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766205927; cv=none; b=nA3gkfQTmMENSpZ0iPZOULrQfcMlnGIPYF7vBlcy+dDgzc+Ycdynz1vGM8rw9rETQ20GoJoSzSHLR1s3pT4AUq+pjTcunTTRnwAnl/zc9JtgU41FIhiZPGXV+1DHUjPaFGnK8JjWQVjRE86YtbhDEbPN5/NLdOiRs0bldtABAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766205927; c=relaxed/simple;
	bh=3XD+NkpcZTU/W73Hy+kOFeYPNEoItwOCz+RbR76NFfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPTMvELDBuXBbcIi5C5NwtOdx7wk7l7b+2LnBppq+y1yM8R3EAxht6MK9TNVhHyQs8eKMH0WXDmzkM28oGOoSTFbg20v8HbjV502+1JAdiAg0Tis9qZaOjKkMe/K50pu/qwGQl1uBLoF9Qi1XWYU2EHigd7tNBz/xFQwO7yfvTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEbRpTae; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bddba676613so1715673a12.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766205925; x=1766810725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqYafUTDSZfPsysO9mEmE6QfuUf7CzNj4lMlpvwZLbw=;
        b=GEbRpTaeWcnWq+Pi4MmFHhGAy/dSP+mfe7YwBrlqEPMzqlZ5CI7dWC1ea/+cbjMkk+
         IrZAcPc9qWIj/Mf71Z2FAh54FSif1QcBtHWK5qoQvxCsA36fNYVnOvG2phfLjfAq1e6p
         rue5YzrgZoPLjqHcwgNCtSznA/3vwdSaBGLJdnhYEQ+0CzRnH2ltw/7hE4CdgPDHnOk0
         LNyQRlx8VJu9tdxaV8c5sfsVCe8Xrl6ZG4aHgb9zy8Xn4YBd52qraN2o90K6mTSl4JLj
         Sn8FhfSESm5tufYh8fLyC4Z9sPq3qvupCE+4w70ig77co0J78GU8Sx6W7YuQsl8DSG80
         ow7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766205925; x=1766810725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqYafUTDSZfPsysO9mEmE6QfuUf7CzNj4lMlpvwZLbw=;
        b=WLAi0KndNwEP8MPqqZdC1lAK1Liwe+u112Uw2agHCJsM8ctu/DQFXcPyVC7sxadzKT
         8mfgI+NUX6BVlTO+pTykER3DDbfDS3Yf1EoT9AbgyF+uGv6ydBVFX0jqqCKA/XAs76aM
         HSLhaaROqmb6lRjJT2+dyY1d9OvdJq/5C1o8HHaPQhQUh/GIWbbRnEvZcuM306b4hMVd
         4XgBpanNoQPVjOaHfzMWUVCdGcGIC/iPqR98EPG0MjLtIDjLIH8qu2i4VoG2lZA7hdJa
         lU9sfe/74Hpitb5iSQPbYPzKOsKa5XziZLRLRDdrU8Pl1/cM7kzsG2EeRs5/ShIPW0wi
         Ujqw==
X-Forwarded-Encrypted: i=1; AJvYcCX+aZ+C2WQsyIKUf9Nue4EhH3E+JZLtGTuzE3SzZ2+PJIuVfAjq635dHDKZk70wJhdkinYv+rOzpBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZkt8T8SbLCgHoi92GpcG4H4CbZHU4jgAaoKUOSARFH4FVPxX
	l1MW1JmLO/lbozRKm30XMgk0BuxGSYBMzHMMKUxr9xjRLFd+hYys4SPd
X-Gm-Gg: AY/fxX7m/fuE6ylg0qeYGbEa7Gr6reHNl8kgO3kKJBOgNIhlUbxFIIzLyOEk0GN3Ufn
	Xq8eCbLKgtTWr5D1s1AEUHKrSOvrYMnkeiswyJ5Poigw0yEHfafdl91f5GbLxJpYOnIiKDJKbaQ
	s01lx36bZxnsB/iVeXC0HIHC/nFYjHA/s5SvhHU9sxORtij4x9sTCGxG35+eAHePtmxDgeAx7EP
	xH3mj1okhr+qfJwbGIET8LmNHLN8hwgNAut/7OsUA26LwnwlIu6BwVyM3voiVWyfmxGuXUI11ar
	qIYNXv/qoZrjddLdsPIrWgwdHWmAxlZ8zf10wwqUWCDDnRR3FyXqnUt0gszVLDuziR2njq81Lp5
	8vK5XLEJsk0o+8PA8ozsshCXV+V4CTe01ihn8c2zwSLfwW8atUtz6mln+xaL7SqucTCB55SFTsB
	tZf+Gl+UGs3HPjryXF73I=
X-Google-Smtp-Source: AGHT+IFgZv1uTvMJojPy5n4aomYP3iTsX6k9vEoRgpcI6NO2pt4mwuRbPwmDHuWbS1pHE1yOmhXAUA==
X-Received: by 2002:a05:7022:799:b0:119:e569:f619 with SMTP id a92af1059eb24-121722ac27cmr6131836c88.18.1766205925216;
        Fri, 19 Dec 2025 20:45:25 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c058sm15780157c88.11.2025.12.19.20.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:45:24 -0800 (PST)
Date: Sat, 20 Dec 2025 01:47:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Message-ID: <aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> Zero out input buffer before reading the new conversion.
> Perform this operation in core instead of in the bus specific code.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  drivers/iio/pressure/mprls0025pa.c     | 2 ++
>  drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
> index 00b1ff1e50a8..7cc8dd0d8476 100644
> --- a/drivers/iio/pressure/mprls0025pa.c
> +++ b/drivers/iio/pressure/mprls0025pa.c
> @@ -16,6 +16,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> +#include <linux/string.h>
>  #include <linux/units.h>
>  
>  #include <linux/gpio/consumer.h>
> @@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_data *data, s32 *press)
>  		}
>  	}
>  
> +	memset(data->rx_buf, 0, sizeof(data->rx_buf));
This is unusual and I don't think it's needed for the SPI path. Doesn't the I2C
subsystem overwrite the rx buffer with what it reads from the device?

>  	ret = data->ops->read(data, MPR_CMD_NOP, MPR_PKT_NOP_LEN);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
> index a0bbc6af9283..0fe8cfe0d7e7 100644
> --- a/drivers/iio/pressure/mprls0025pa_i2c.c
> +++ b/drivers/iio/pressure/mprls0025pa_i2c.c
> @@ -25,7 +25,6 @@ static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
>  	if (cnt > MPR_MEASUREMENT_RD_SIZE)
>  		return -EOVERFLOW;
>  
> -	memset(data->rx_buf, 0, MPR_MEASUREMENT_RD_SIZE);
>  	ret = i2c_master_recv(client, data->rx_buf, cnt);
>  	if (ret < 0)
>  		return ret;

