Return-Path: <linux-iio+bounces-10957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC79AB86A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 23:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434A5B2291C
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC351CCEF5;
	Tue, 22 Oct 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fqsh8Esd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270591CCB4F
	for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632141; cv=none; b=jLYKTHNMl1QhpnLuIIfffIksWN4dMQ+NwBmMYyqN4tW/Mbxpj2Ele8p3B+vb8ZEPVAWE37+P6VKyN0xdsJftV5w2DLPA6KObaDs4tko+YuIkkrtNIajW6GhCcgG+lYx7e6pslVlETYaIWcNemcOkxVXfW2ZBy7l7KbWzvBMhv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632141; c=relaxed/simple;
	bh=+YYH5lgcgAAaWaHi+QEZ+cdfVTHaJNkCs4qgJ5a/kQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CGz3YIMQ2Xei2YM05CJZNO5O2maWzI/cgnp25BvVhM7geOb+TOJ+8C/GvvwH7PLj5n/0oJFquejUwcbiRtqDBUMG9vSfnzGX9+VTtwpL2NcOI+3aCwJ3+h+hGfEOoiGIHP2ax7cnAGvzTct7vi3U6XoSQGo897WV01VTGAfbsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fqsh8Esd; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e612437c09so1596033b6e.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Oct 2024 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729632137; x=1730236937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kRXTgQ4kD13MzuhZYlApMraa0F9l/eY7TJeEM2D+iLw=;
        b=fqsh8EsdQBerPS2D0z7zu3qr4h5LJDlvdDYscINk7WggoFfEMxJGneRbUjvv+si82H
         dLIBLS+jZnukIYI641NVQlF3jn6rQorjF2vsHIXUuTWtuwkhGVcN5NuDs0ur2M7D3G+N
         SxuhchHep3dHHZOQF9sTGoH8zUCqcU9FPUFnUctz+OkfXvnAMRM5fyhMyQactrP3Suic
         FxKhGjKLdXUzqoeBolWXvsLm+6BwficOxfeQjpuAPsxzJd8TuNv7drj2UatX1B16q3Br
         q7AHyHC+ivWSkiSBtZNzESHKI01/2ex+yyt03Cc/AAaKf5YakZ+2ktUvnqmrKy+hEa7v
         jE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632137; x=1730236937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRXTgQ4kD13MzuhZYlApMraa0F9l/eY7TJeEM2D+iLw=;
        b=tepfy2b7v0lNbTI4rMOQzJUbVdCXZtt+ZB9XmegT6Zam8XfYZCR1PTwGbhb5LgbJ5u
         5eIKzIyk+/dKl/ftjtd7EUm0Z1wCdAWVhifr5X/Gv8paQfKrFQe+L54nNivyybAVc4Vv
         wpyQlSZR/6M48NMJrBb1gWOG3FWMwlhFpi2oJyOHOWsPa2kM1HN3imcxDHGSBmTle5vo
         YXqjIjj6MGMzH6p/ZK/R0QrRve7FIOlMI93MSoK8PV2r+NmkMIP0lryf4Yp7ENfya4+r
         F2eB6gVF41wCcHdkcJk6TCLdm90R2fjEkOftAj5EK1zOOsE/2/FylVfpJx9ZpXtc9vJh
         d0nw==
X-Forwarded-Encrypted: i=1; AJvYcCWAn+61GFF1/i7NJDSIka/5rlSo9W1V131xqFr0oFIPDswy7ldFPuGjrh4tuixEJ1gK7iPXOqHYtsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SMFbKKFg5cx3KmrIjNd30G+fY+c4EGbZtrzT/WlNtTs448rr
	cb0cRO3t00Jiw7Cw9Yc3Q1nWxsmnVxsX7pET9QhHethV1SUNE4OAI3wEOxmDcuk=
X-Google-Smtp-Source: AGHT+IE8vnvbyO1Ahx+nEmiTVW8i0jHcIewmd1FWR1wF8TmYYeJLFJS/8BBtpEfwgmyTIgpcHmpmCw==
X-Received: by 2002:a05:6808:4482:b0:3e6:0:f47c with SMTP id 5614622812f47-3e6244eeb13mr509721b6e.9.1729632137230;
        Tue, 22 Oct 2024 14:22:17 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6102e26f5sm1475150b6e.19.2024.10.22.14.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 14:22:15 -0700 (PDT)
Message-ID: <4d32a462-7a9d-4170-a01d-9de258231fd1@baylibre.com>
Date: Tue, 22 Oct 2024 16:22:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] iio: adc: adi-axi-adc: add interface type
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, nuno.sa@analog.com,
 conor+dt@kernel.org, ukleinek@kernel.org, dragos.bogdan@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
 <20241018104210.51659-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241018104210.51659-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 5:42 AM, Antoniu Miclaus wrote:
> Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
> IP.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static int axi_adc_interface_type_get(struct iio_backend *back,
> +				      enum iio_backend_interface_type *type)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CONFIG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N)
> +		*type = IIO_BACKEND_INTERFACE_CMOS;
> +	else
> +		*type = IIO_BACKEND_INTERFACE_LVDS;

These should be the more specific IIO_BACKEND_INTERFACE_SERIAL_CMOS
and IIO_BACKEND_INTERFACE_SERIAL_LVDS.

> +
> +	return 0;
> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -285,6 +307,7 @@ static const struct iio_backend_ops adi_axi_adc_generic = {
>  	.iodelay_set = axi_adc_iodelays_set,
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
> +	.interface_type_get = axi_adc_interface_type_get,
>  };
>  
>  static int adi_axi_adc_probe(struct platform_device *pdev)


