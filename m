Return-Path: <linux-iio+bounces-26713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 255C8CA1BC1
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 22:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88065305130E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D22D8762;
	Wed,  3 Dec 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WaYNyBLJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47C2D738A
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798649; cv=none; b=I6Ghdul26OmYSYu5O3cVrYGatm3l91DY2/gXhIbTGeXPwSZzW56NXrcJNZrzi9InQEvZbMpzKbmEymN3egiGB/XJM8lP+ttswzFN/A49WmMzPOdvNYeS/xdSlEobBsOUZKPSI5coPSY+ccciumR9TI0uGKV9zvG0iedQf5m7Bys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798649; c=relaxed/simple;
	bh=ZXM2nfJu5oJwY2GOEZGATNrTU2G/aWMWHGcN8Dki1p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOoATFbFyuS6kqVWcE5C0G+RplxdVR863kaFGgj7VpE2G5n/653VBHOW9DR9NopTpcVULBVj0pY12rwIzS7Pif2MKC3CyhCCOriXldL1AP3xSC0KX+aHZ9FhGB39WHVL5BwIb9TzT/nJ1Q47gjHT2jB+7F2dv1omV3y7GE8EBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WaYNyBLJ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c71cca8fc2so198284a34.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764798645; x=1765403445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOXwn281er3xrUTkTtRg7swbv+pAMR6MbFqtuUChdDQ=;
        b=WaYNyBLJrWuyLgqV5DLUGQbBREyg2hP0nNHg/p5/IIZQefN8E8qr8ZAbwEPNi4hpZC
         wqmF6dYqJX51Qt+f71c75ydSBO+GJ3OTT7JWQASsTGR8VU3xxE0F0RCShCu3qAkpPEIt
         HG08CvCIQn18OR6h9wA/4qA6jooUZGxS4/Xf4KcRACVS6pIVChYAwOGm+sNv/Eux+/0o
         gfic8zEms9xX61ROEuSJNXfXPgHWROhV0te/2YQeuV/4janzIQuLiDqftX8b1Dt/j0Ax
         uoIxIor32oAzbZJVMudUi3gDVIrPVmTe+Rntb+YvrRJBt7hXRtSHY6wC55HRB+fx9BQK
         OAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798645; x=1765403445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOXwn281er3xrUTkTtRg7swbv+pAMR6MbFqtuUChdDQ=;
        b=CfNXhHHzkc6PwstpAcSNRo/bcoQXhU1W0Dq6+r1OMTKOImBi0wsWQw2C5Qp73IdOCy
         G1/4ubE7dfiGoKHEnHrkOVuPRZoCG6tkCLhigrGvmz3/TXxtmubeUHr/VrAbmK2AqGpP
         3fbL+CHJXqGfBW325sz1isux8Oiw6BOcOAZvF5dJJcqZsX6+6sFU/z50ncRNm24jXRku
         Qr891ZVHhJPbr/t/LcyuONxaaGlMfMu6qJxAjielllJiyrn+aOYNcc8Shy+C5jU14XLD
         rMXjQX42z2gS7Hy2S28U02fmbUjizjkkyfrJ7D/xmBCmoDANsSRyW08yvW9MZbU1l5DH
         W9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrNTULZm2Q4MwS4oxF91WP4GbaKIQOGnyThPrisYG2/ipXTSzQPg4eWodpHOO9bTyC86MLlfST518=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpIhNC0CKXBnexwzzO9OPAD0uwr9ul2HVdZvnsUYtJQfhgU2Q
	+H/kNsKndKpeAChTy8UBsPDgTs8UA8dpp7WiwZB8TGisInMRw2WZ+n1yRJPdU0Dp7dM=
X-Gm-Gg: ASbGncv+5SayOasYzRtFFeR7tnmT8uaXGIAouRr1+DSXrMG7ivGPql8GjQLAZy9uADH
	7utITFRclFDGG7JWGH+DsKBbL/EjK1X3Pwdht9FBHr4VewLWZ7P+iOpO4MT80Lw/poaeblGLm12
	mfaBI43ZguijIZafyZoKb3RcdR1w5lZSSNcTBDu2ZDRa3XnI+2rc3oZXTq+YADrBqpRnQhioRf8
	vJLkzRRkyBB5brXchCTCDT5j2RgTIfV9Xmhd1GYC6B0nzyFQ1tD10LgYAqvdOP4/Qq5yNxCNP8E
	liqoQQFxhVzAyZkOoqWSIzu4sYoRxPTFMOgXc5HNoc0LUr/jyb+jCiRFPFYK5oRzugRG82rhJIu
	xVrMls5mhYhcG5HS6118uE6KzSOtiyRZCgdim6Ckr59Ipn5QIEixQhMOKMWx2jLZJrtRJk5uALc
	IIbVL0HazHgWznPQs=
X-Google-Smtp-Source: AGHT+IGUpwPWULKfwpJt6xdvUQml+OeY2AizRJFVIHBX8/UQQAjzB4wdDPV7yTsLxrebEUH9T57tUg==
X-Received: by 2002:a05:6830:919:b0:7c7:66f7:2caf with SMTP id 46e09a7af769-7c94dab06dbmr2589753a34.10.1764798645378;
        Wed, 03 Dec 2025 13:50:45 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b05:aad2:5053:6d1? ([2600:8803:e7e4:500:6b05:aad2:5053:6d1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f640e61sm9472724a34.13.2025.12.03.13.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:50:45 -0800 (PST)
Message-ID: <3b80f8f3-c435-49f8-8c55-42568215bf0b@baylibre.com>
Date: Wed, 3 Dec 2025 15:50:43 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/6] iio: core: Add cleanup.h support for
 iio_device_claim_*()
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 1:18 PM, Kurt Borja wrote:
> Add guard() and ACQUIRE() support for iio_device_claim_*() lock.
> 
> This involves exporting iio_device_{claim, release}() wrappers to define
> a general GUARD class, and then defining the _direct and _buffer
> conditional ones.

Commit messages should say why we need this.

Also, this seems like two separate things. Adding a new claim/release pair
and adding the conditional guard support to the existing ones. So perhaps
better as two separate patches.

> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/industrialio-core.c | 12 ++++++++++++
>  include/linux/iio/iio.h         | 20 ++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index adf0142d0300..da090c993fe8 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -2171,6 +2171,18 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>  
> +void __iio_device_claim(struct iio_dev *indio_dev)
> +{
> +	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
> +}
> +EXPORT_SYMBOL_GPL(__iio_device_claim);
> +
> +void __iio_device_release(struct iio_dev *indio_dev)
> +{
> +	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
> +}
> +EXPORT_SYMBOL_GPL(__iio_device_release);
> +
>  /**
>   * __iio_device_claim_direct - Keep device in direct mode
>   * @indio_dev:	the iio_dev associated with the device
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 27da9af67c47..472b13ec28d3 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -10,6 +10,7 @@
>  #include <linux/align.h>
>  #include <linux/device.h>
>  #include <linux/cdev.h>
> +#include <linux/cleanup.h>
>  #include <linux/compiler_types.h>
>  #include <linux/minmax.h>
>  #include <linux/slab.h>
> @@ -661,9 +662,23 @@ void iio_device_unregister(struct iio_dev *indio_dev);
>  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
>  			       struct module *this_mod);
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> +void __iio_device_claim(struct iio_dev *indio_dev);
> +void __iio_device_release(struct iio_dev *indio_dev);
>  bool __iio_device_claim_direct(struct iio_dev *indio_dev);
>  void __iio_device_release_direct(struct iio_dev *indio_dev);
>  
> +static inline void iio_device_claim(struct iio_dev *indio_dev)
> +	__acquires(indio_dev)
> +{
> +	__iio_device_claim(indio_dev);
> +}
> +
> +static inline void iio_device_release(struct iio_dev *indio_dev)
> +	__releases(indio_dev)
> +{
> +	__iio_device_release(indio_dev);
> +}

It was unfortunate that we had to drop "mode" from iio_device_claim_direct_mode()
during the recent API change, but at least it is fairly obvious that "direct"
is a mode. Here, dropping "mode" from the name hurts the understanding. These
could also use some documentation comments to explain what these are for and
when it is appropriate to use them. I had to really dig around the code to
come to the understanding that these mean "don't allow switching modes until
we release the claim".

I would call it something like iio_device_{claim,release}_current_mode().


> +
>  /*
>   * Helper functions that allow claim and release of direct mode
>   * in a fashion that doesn't generate many false positives from sparse.
> @@ -690,6 +705,11 @@ static inline void iio_device_release_direct(struct iio_dev *indio_dev)
>  bool iio_device_claim_buffer(struct iio_dev *indio_dev);
>  void iio_device_release_buffer(struct iio_dev *indio_dev);
>  
> +DEFINE_GUARD(iio_device_claim, struct iio_dev *, iio_device_claim(_T),
> +	     iio_device_release(_T));
> +DEFINE_GUARD_COND(iio_device_claim, _buffer, iio_device_claim_buffer(_T));
> +DEFINE_GUARD_COND(iio_device_claim, _direct, iio_device_claim_direct(_T));
> +
>  extern const struct bus_type iio_bus_type;
>  
>  /**
> 


