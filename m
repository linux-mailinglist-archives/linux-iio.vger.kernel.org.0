Return-Path: <linux-iio+bounces-27673-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F39D19CD5
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 16:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAA9F3004E3E
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6D73164D8;
	Tue, 13 Jan 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Fq9jHppC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD232BEC2A
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768317504; cv=none; b=vFuxH95b//w3j4f/c6nHx/OHfE/f6rvhzwOH2sR88hbjIbj62JFxNZpi2o9BGAuOCjM3Y59zFqWWKofyZiFK1ZBDqIo7VAQGtz0ZFr1clW5v4C73Dt3jCPuQfLFDRvya4wj1Pph2BjrC7vP2sUDl11e6HvniCorHWvfGUS/4xA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768317504; c=relaxed/simple;
	bh=AAxq7k2bfhjX0BCu8MUMz5QoOhirq9XPHtu6DKWTO5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXu3TwwmUMShVrW4GW/ytBXvBuyyyqsdP0Ya0QJ1avcAUps3nlKYpVpd9Puh+xs4hj0/QEbP2oMZw1MQbUSsc2U55D2YaClDheRdMPHRArCsYuwfDNTQADeuYB/oFbW40UzA1aI+fx1+Y97vcffJdVRVu3Bku3AGk0HesUDY7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Fq9jHppC; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45c60ecc0f8so493282b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768317501; x=1768922301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EODg6UvjGU0Bpxy1ibYdGbWyRiJXLp+tPE7r+z8uYu0=;
        b=Fq9jHppCa+6IYatqzwRm472OCAS/+v+ifswicZS8vfWc/BnPnuqsT0rHRkz1eKFMOt
         gLUtnJ5/mKrQgF/64J6Rw8etzTtamd1aadYnckdDaJoXF69zx3ua2kDkbue402hN4OmO
         hbsU1LWcxUJLU98BGkkcN7oectLrNv+4uJpbexaUPS6sjoiKAc+knSsSOV7LXZnnA/KD
         udj8CWNKOdaJhjHnn45bjlj6zDD7DrkC5KL+yq5ACNHr2l4WJ0cs0JTYDpyZjMGALoTY
         LGsphbU4t0vlpDdamZlNyKj+vUR1NYTQHT+8FdsBclhD/akylNBb4BBlKOEDCpiuu198
         kJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768317501; x=1768922301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EODg6UvjGU0Bpxy1ibYdGbWyRiJXLp+tPE7r+z8uYu0=;
        b=P+hqlwP75iIsiYaR8GgGjjhPbaOvDC4R0StKFAgxdIBbquS+mIn1a1MiT4J9OsjltD
         0UDFwYWbTaeDKaQU6D9D0WG6LphT8VVEeG9+uiJWI7ZF82hRzzPAbw9NdADT8eYOsNoH
         GQvpxuyUdqVEsq6OPwH4CnQOYQpQmLWsgNIqxyoVuEUigEq1Px95SA2hYfyBQuBvzxmd
         bTBkpgYRnqDBl2dhJ39KH7lYo9hRkVYcqi0dzxk3RtBmC9IsKdql8Wi00YXC/VFPr9IG
         xQqqDu9sq/iFW2FcFIR8Ol1DZ0dNTtXA8B/hIlFQHBonEFzF8MT/Q8Qd16/4TCm8vk1C
         iztA==
X-Gm-Message-State: AOJu0YzFEQZC0aBvD0fdu0hyBUT1sdlST2LSAnnsNkF+aZh0KTF6kK+5
	YPwVPbnvI0GQQYguna6rbzpmSYVLEJcqBSkWWaup8RALTaAYcWP8Da5/5bZM+LvTOjA=
X-Gm-Gg: AY/fxX67GCe5J0P98jAySklkHEYJxssYOsb5GFRI0UZGCtqoRIT12aPl/K49yxgagvH
	+fpystpwiY2QTnRIKMC2GoyHYtOCzuF67/AbIh/IIvDSxNIiGZh2R0GhXtITjovcp8lx0+d5nzx
	pCdidxskvzchBXJZwrFhgsKDjyfDeRKKD3YVpiMYldaBIYoCUI/GxFxwhTdQGvg6a+X2krhEjDb
	NrKlmaGMc3B32p4SlaZW7YXfjsYoYOiFz7t0jJ67qf/yaJzKBmYC9ersCNS/fKxWruLuX/RUK7g
	W9E20K9B7AyLy0kCr99pl1ilQvs0nR1H5qahnWgcr37ZHnOsoOYx2FJCN0Zb/sPG12UWn52fc87
	ulp2HUrdkTjU1mZH4PomVF36mIoaTZ6JF88fbI1XBu1FwWVDf8mvmWyyUtm8SodCzrUbNuqiYgo
	s1qqFpKg4MT9xtCrs6em8c0gw4AiK7k4B2kS/YlYxP1jrkr6WYuSviizi12vql
X-Google-Smtp-Source: AGHT+IFT92M9Z0Q4ZGT5QM0lnf9elMyYEJCafpkOjg2G5CeEnSg7iOZ3w04Rr1IfnpHkqeUw/jn17g==
X-Received: by 2002:a05:6808:c319:b0:45a:6d59:44f5 with SMTP id 5614622812f47-45a6d5950eamr8885303b6e.30.1768317501063;
        Tue, 13 Jan 2026 07:18:21 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:2f58:e1e3:bd08:f09e? ([2600:8803:e7e4:500:2f58:e1e3:bd08:f09e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4781c286sm16607374a34.8.2026.01.13.07.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 07:18:20 -0800 (PST)
Message-ID: <a9c067c6-287d-4bd7-91d3-fabd6d5b67a4@baylibre.com>
Date: Tue, 13 Jan 2026 09:18:19 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: industrialio-backend: support backend
 capabilities
To: Tomas Melin <tomas.melin@vaisala.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260113-b4-ad9467-optional-backend-v2-0-0a27e7e72f41@vaisala.com>
 <20260113-b4-ad9467-optional-backend-v2-2-0a27e7e72f41@vaisala.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260113-b4-ad9467-optional-backend-v2-2-0a27e7e72f41@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/26 6:12 AM, Tomas Melin wrote:
> Not all backends support the full set of capabilities provided by the
> industrialio-backend framework. Capability bits can be used in frontends
> and backends for checking for a certain feature set, or if using
> related functions can be expected to fail.
> 
> Capability bits should be set by a compatible backend and provided when
> registering the backend.
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
>  drivers/iio/industrialio-backend.c | 10 ++++++++++
>  include/linux/iio/backend.h        |  9 +++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 447b694d6d5f72dc6f018b1697fdb88e555bd61e..997ec743dc67e7cf420ff667af33b4f6a71a5377 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -62,6 +62,7 @@ struct iio_backend {
>  	 * backend. Used for the debugfs directory name.
>  	 */
>  	u8 idx;
> +	u32 caps;
>  };
>  
>  /*
> @@ -542,6 +543,9 @@ int devm_iio_backend_request_buffer(struct device *dev,
>  	struct iio_backend_buffer_pair *pair;
>  	struct iio_buffer *buffer;
>  
> +	if (!iio_backend_caps(back, IIO_BACKEND_CAP_BUFFERING))
> +		return 0;

I would be inclined to return an error here and leave it up to the
caller to decide it if is OK to ignore the error or not. Otherwise,
the return value of 0 has two possible meanings and the caller would
have to separately check the flags to see which one it is.

We also need to add this flag to existing backends in the same patch,
otherwise it is going to break existing callers. (Or we could split
it into multiple patches - 1) add new enum and fields, 2) set flags
on existing backends - 3) introduce new checks).

> +
>  	pair = devm_kzalloc(dev, sizeof(*pair), GFP_KERNEL);
>  	if (!pair)
>  		return -ENOMEM;
> @@ -774,6 +778,12 @@ int iio_backend_extend_chan_spec(struct iio_backend *back,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_extend_chan_spec, "IIO_BACKEND");
>  
> +int iio_backend_caps(struct iio_backend *back, u32 cap)

This would be more understandable to me as:

bool iio_backend_has_capabilities(struct iio_backend *back, u32 flags)

(caps is fine too if we want to keep it short)

Also could use kerneldoc comments.

> +{
> +	return back->caps & cap;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_caps, "IIO_BACKEND");
> +
>  static void iio_backend_release(void *arg)
>  {
>  	struct iio_backend *back = arg;
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 7f815f3fed6ae34c65ffc579d5101020fc9bd336..c020bc48cc05d6fcea00d23e471b12a29b5c0551 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -84,6 +84,12 @@ enum iio_backend_filter_type {
>  	IIO_BACKEND_FILTER_TYPE_MAX
>  };
>  
> +enum iio_backend_capabilities {
> +	IIO_BACKEND_CAP_TEST_PATTERNS = BIT(0),
> +	IIO_BACKEND_CAP_BUFFERING = BIT(1),
> +	IIO_BACKEND_CAP_CALIBRATION = BIT(2)
> +};

These could use kernel doc comments the specifically call out the
functions that these correspond to. And also an explanation on why
we don't have them for everything (I assume we are just adding them
on an as-needed basis).

> +
>  /**
>   * struct iio_backend_ops - operations structure for an iio_backend
>   * @enable: Enable backend.
> @@ -179,10 +185,12 @@ struct iio_backend_ops {
>   * struct iio_backend_info - info structure for an iio_backend
>   * @name: Backend name.
>   * @ops: Backend operations.
> + * @caps: Backend capabilities.
>   */
>  struct iio_backend_info {
>  	const char *name;
>  	const struct iio_backend_ops *ops;
> +	u32 caps;
>  };
>  
>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
> @@ -235,6 +243,7 @@ int iio_backend_read_raw(struct iio_backend *back,
>  			 long mask);
>  int iio_backend_extend_chan_spec(struct iio_backend *back,
>  				 struct iio_chan_spec *chan);
> +int iio_backend_caps(struct iio_backend *back, u32 cap);
>  void *iio_backend_get_priv(const struct iio_backend *conv);
>  struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name);
>  struct iio_backend *devm_iio_backend_fwnode_get(struct device *dev,
> 


