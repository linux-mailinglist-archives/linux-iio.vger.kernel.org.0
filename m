Return-Path: <linux-iio+bounces-17253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DC5A6E2B6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 19:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86A31891B3B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1679C266F02;
	Mon, 24 Mar 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xb38XE9m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813F10F1
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842402; cv=none; b=YXSYDT4Pfi7VGSXNdRBLKUpZb4ZvvMAwCzadGCYJUUe6bz5+TP3RjTihZUivnhhmhHVwmaKoEFLJLp2ldtunfboRwMKNCfwL9ZTZ23B/bP0pUFh5CNKvhzVfiLvzkCpAtb/1G/BLaDlU7JTLw5NhJEQj45ZEqD8+JUzh61gmTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842402; c=relaxed/simple;
	bh=9Et+bejBKOhYPrG+RLIDdB0IB0BGiirDMd/wt2M4F8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pwhMzIkGqSgwlUGdDfpLuehdRwIkx0vpdhX9PUAXP3ti40E5vYK/byI/EORyZUgi924KZJKoM7HnxlM4tq+/N0CaoE6/BWa/ptsh/SG8N+hsEmyXhIDIQhEmGKPFy7uvqAzTOfYrblm6O5nHNvWZ7tx180ufkXaSjWMxCSZgeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xb38XE9m; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72c173211feso797663a34.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742842400; x=1743447200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZA6ZpsiQTf1qeWnuqFjmneHdX8zeg+LaVhzQbpBn2E=;
        b=xb38XE9mLRztHaEIdj18E+GP0M6qhI1LxnYODqJGtvxcXfnNhuhkEo4ain0supuID2
         yzA1xdwRPaFKvdOvWNW/yjR6S9jRzXQwC6+OXO9GTPYvYIb2aFTwGfXH9I/ZtpybGlH0
         qlZV/Vi/64gqy3Wpdfvw2pp5uu54lcyAC5jrAEWVpKYkCcBbRSj3mRm3HTn3SOsW+uQA
         6eFt8FRAs8ydcFZACun1CsclsQvVNO45Dn/AajS1UxoIYgy9WP3ADZ3HDD/XZDbZSgcS
         Ju1LpoOatGdFvAiwzq7TLnsnBNA/lXMhvrTFrWABP4nTJv6Q+3cumvrOhQVZhkja5ul6
         7s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842400; x=1743447200;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZA6ZpsiQTf1qeWnuqFjmneHdX8zeg+LaVhzQbpBn2E=;
        b=QoVlIPudrU7ndCiE2ggI+4GiLmNr2gGMnCgUw0Kxry2201pyjn4jxqA14OpjCa2bUR
         v4167CIyojOhjZJXPlssnpvqdEmHdwl8DnhKEoW/f2oQi9jCUavosfqz4TMjhAjIO8OK
         NR1EXTGGOg/zHbMyOW4wJedTw1f2dM8CHiqy9aaMpcN5Sz0aDebS+XdoHGcaTIwybn25
         +qipBR1S9XyvNuU6Rciy/HmU9D49kpZPWgSs5FzAjAQhKOUaE8l10BM4aV+oF2FcP+Do
         mvLEMM+0R70MfuhEOXOKzI3DJBUZa/jmtjeqUFmuQ1qrq1WJ4L5S9UCqVvsBAQRg/DKK
         kxKw==
X-Forwarded-Encrypted: i=1; AJvYcCVky1KTK0SoZK50IU2CNqHVtHVeXELjvdMR1VyaGr90ElmUKNyURmFzVjYzdCitbh9B6oN5fEG4U60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYH+J7UB3APiJ1HWCIF/+Jubww1qF2ZAMhxJlPHQw84TT7BVqg
	ttd4v/k3ja9YWuZeDnHrMRBRUhgaxCLahMnn/y5fm0hyMjoYEAU2kyqgzrxOKuI=
X-Gm-Gg: ASbGncvTuHOKqgWEKq0tPTnYhU6SMES2bb2vv+hc0qc2GjK7XaQh5tgA1bU3HD9yIV5
	QErVC0Duurtt+rACQCpdlINbTMF01O9XNYZV/4K/9bUgDsalAMvfYazMHWmrRe7Ctcqz9nCrxkx
	RJus98bKimF+v3PQvNI16GYSkfCDX2nQxd+Uv1MHzeSGhcyCw7OkXsWNGLuTm0Jo2ldzCAjFryB
	K7ldDtDj9FDS9M64x+JefaCe2PhSsKAUKmJQE1xQDUVTUzqanRarncUtrlFwc12nxRb5KiroMvu
	nWPJZHYr4eiRC7wEYEudxpU7LgftDFm2UGG7/GU2BDXTMK0HqQRESQ3l8MJwhFstNnuIE8GL5JW
	Epk86DA==
X-Google-Smtp-Source: AGHT+IF6cN3R+AuP+yrpCG8uySpNH6oMp8tp8ZKnKYMSbTLqIU4c2Zi4NYw2RNf6jlvZs1qwrYXK/g==
X-Received: by 2002:a05:6830:6217:b0:72b:8a8b:e032 with SMTP id 46e09a7af769-72c0ae4658fmr9534102a34.2.1742842399668;
        Mon, 24 Mar 2025 11:53:19 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0ac6c76esm1630781a34.49.2025.03.24.11.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:53:19 -0700 (PDT)
Message-ID: <9b565cb2-815b-4ca9-a7dc-8ca2e8eb5f72@baylibre.com>
Date: Mon, 24 Mar 2025 13:53:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iio: backend: add support for decimation ratio set
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Guillaume Stols <gstols@baylibre.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-2-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250324090813.2775011-2-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/25 4:07 AM, Pop Ioan Daniel wrote:
> Add backend support for setting the decimation ratio used.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 18 ++++++++++++++++++
>  include/linux/iio/backend.h        |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 363281272035..f4db6514944a 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -417,6 +417,24 @@ int iio_backend_test_pattern_set(struct iio_backend *back,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_test_pattern_set, "IIO_BACKEND");
>  
> +/**
> + * iio_backend_set_dec_rate - set decimation ratio

In [1], we decided that for a similar chip we could use "decimation rate" and
"oversampling ratio" interchangeably. And in [2], we recently added a backend
op for setting the oversampling ratio. Would it make sense to use that here
as well instead of introducing a new function? If not, we'll want more of an
explanation here on what the difference is. But from what I can tell, this
sounds very similar to the other case where they are essentially the same thing.
On the other hand, this is internal API and not userspace ABI, so having a
separate name might not be so bad, especially if there is a chance we would ever
have both at the same time.

[1]: https://lore.kernel.org/linux-iio/20250112122047.1e1978e0@jic23-huawei/
[2]: https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/drivers/iio/industrialio-backend.c?h=testing&id=22894e0be908791e3df011cdfac02589c2f340bd

> + * @back: Backend device
> + * @rate: Rate in decimal
> +
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +
> +int iio_backend_set_dec_rate(struct iio_backend *back, unsigned int rate)
> +{
> +	if (!rate)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, set_dec_rate, rate);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_set_dec_rate, "IIO_BACKEND");
> +

