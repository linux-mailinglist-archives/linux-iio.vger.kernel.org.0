Return-Path: <linux-iio+bounces-13943-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD2A0333B
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 00:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D133A265B
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 23:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672AD1DF984;
	Mon,  6 Jan 2025 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yoIJsJGI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69F1BF58
	for <linux-iio@vger.kernel.org>; Mon,  6 Jan 2025 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205585; cv=none; b=cb/688IKu/bFMGSLqlTAt309j4P0XIrcf9JjWYjcCALQo3EPx6idpztjGwzTjyn8MsQz7uo0Ph/p1J1QGDinTtHjb6GjyvkHTzX+jaAZtKPbi2AgGeLmBnR1NsPOziIQrQx1WZqk2rqgFyuJoSqsXTTOyVsF3xVnco4L+LPiTqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205585; c=relaxed/simple;
	bh=vxSkOEubjrYE31visdLvN00WQtnp4fw2m38c1g7GAG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXVDswVGIh6uoCO5fvEaoxDt+ylFzqyCMKImpfIshkDqGgshh/lEhGA/LgGquKnROUCy0a3/qPiemU9rB+34pG9UKRcQoQKsjqytSWsKhg0OaWFshmv9GxdOjl06HePkRcogJVjXBjU4/PTw2V/BZ3IgVhoFIG8R2Oq812Rz3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yoIJsJGI; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eba50d6da7so3729683b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Jan 2025 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736205581; x=1736810381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9cFHgkZZf4ULbUzPzrauoD5fOewYhLhqfyTWYj/9DU=;
        b=yoIJsJGIxzMWNklgAG4GxV9RgBLOEUq1Drqv8rzpld6GmoKU6VQuMFfvkMDAetmOe9
         LQa8sJDim988BEbS8eb7r4poA9dNpHATToKVqParS8i15//eJKAl7wMQw9wXAXF4YrKJ
         vPc4EqSNsLs4rvrMJtkmpHqyzijNZaRSzhj4AvDnPVyoBmpXJ22m60BvYa5bOi0PhGBd
         jGVisJFT5Wy84ermYKeXrxC6S4uwpnM5wbtY0Ud39abj98TvVGu2Ae35UxpwkpOO4FFP
         HbNEkScV+FCa0GlzLnIyqplJHsBeKHHMS6lhqGxTw+qq9Q4RrlHoXKeJP0LJ88SB7Ujm
         CBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736205581; x=1736810381;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9cFHgkZZf4ULbUzPzrauoD5fOewYhLhqfyTWYj/9DU=;
        b=HBH/ffEWZnjhqee8rnAf0Mq9t1z4jp7i5KBSPCJzMNl0oCnS0svscKAstPHCo3p7NK
         R80dLDqN+yTt1grnhPeU5f5IzAPTHisKKS43HayZgOPe7gpQt5B4rO4mSelsBQRlPy8r
         KhDZjzdkl/UVom73Q6Cn9YBXOWpszLiCN6qSD1CKL8CNAQ/ID4b36yZaI/RJniLAP3zO
         klg2YXXzsPs8dGR69665uBaGnzHKurxKkf0pF4jbG5xAY5PgLPiyaZVSN9gB+9KfeCrY
         g4hoRJBESayLUxC9PhiYNC7Ah1x8+lDcQ1iPMokR+C6isMyitgybPis0mcUdGz37tBl5
         Htvw==
X-Forwarded-Encrypted: i=1; AJvYcCW3hZuSp04gRUYLI/aYp7jSh6y5rW5q1hquq6NyUM+ynA6zFzjVXB6SeYO6NOZctfvDBG5ktD69Rnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRk0/GfyjYtqkUKH+3aRsik8vxvi9TjzT0LLQXKzJAfNEVZC7
	DKOEmmWtfRU9mbcr5yD4Yntr4QievfvLfUxFDiHG+C0Av6fGfBoiFy63lYDPx90=
X-Gm-Gg: ASbGncs+UNqMhMZcVg+1oB++1cCcnIdK0O8dO+j9Od0T5nLTUZ2FvgxvAL21Hv7gqhU
	1TpMxIvQqRtlzJ5tP2tDNm44YGK1B0uLROBnQXKWacy79+jKmYj8Exf2s5SL5sS5Cff1xhcsavS
	wIfl3jWKvizGxpCgznA+Kv1603vk4FAVyI4A8YWLrN9z5TwHHzww5sLyU+Hi/5iEDyabNFHsXWu
	Zen8tQLrvEIJSPu1jtbt/n4X7cQ5to/kXDFZXN4ba1zgeWbdBKDyWU4VpzkOhXbmossEu4o0MSo
	2CTq4kLx8DLTUbu4Pg==
X-Google-Smtp-Source: AGHT+IEIYJ8l8v4enELs2xUKlOqa0VjQHnsWky2/g9QZWxx2hCypnYuLY47akDVbPvEoUd1iLRzVQw==
X-Received: by 2002:a05:6808:168c:b0:3e5:f4fa:5984 with SMTP id 5614622812f47-3ed890b182amr26830452b6e.38.1736205581466;
        Mon, 06 Jan 2025 15:19:41 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece24a831esm10518980b6e.21.2025.01.06.15.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 15:19:40 -0800 (PST)
Message-ID: <b06248df-694a-4a9a-8fe6-ed0ae6c85065@baylibre.com>
Date: Mon, 6 Jan 2025 17:19:38 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/27] iio: adc: ad4000: Stop using
 iio_device_claim_direct_scoped()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
 <20250105172613.1204781-10-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250105172613.1204781-10-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/25 11:25 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
> 
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/ad4000.c | 61 +++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 1d556a842a68..ef0acaafbcdb 100644

...

> +static int ad4000_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +

Spurious blank line added.

> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret = __ad4000_write_raw(indio_dev, chan, val2);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
>  	default:
>  		return -EINVAL;
>  	}


