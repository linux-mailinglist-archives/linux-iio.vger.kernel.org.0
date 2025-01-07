Return-Path: <linux-iio+bounces-14009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC2A04DCF
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEBF3A4C10
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70611F76D2;
	Tue,  7 Jan 2025 23:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DsSTSjSi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5D1F76A3
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293611; cv=none; b=JPZKQfwfg8qa0CEqIo0pirSdWBZg/ZgE4bjihw/KOYow5OzrVBhTKGbomglSSkpd6dzjKn6TFuTjg1LUGThdr9NnCTuHH31l3eopO/Svo0BvshOsC9B7gq1Brkr2lQEmKIrBR1PeoQLCipW+zopg+5XuYyMyKb7kv1MOqn4bGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293611; c=relaxed/simple;
	bh=JmeWNV5FcZLoOrrSKKyRkVhViGwgBqKbXGL/ScYkwNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDH6bjV4C5c5GTreCk/tKQXdoeU6aHeOas0ovc8DY8jsp1A+zKzqk84eidLu1Nu8OqyvJ2lkHetyqicAZjJTQXapjLyvb2PxL6805nYA93iBZODSUZ4diSvsH3UHRF8pbv9Lig3LQCyYkWtnv8+wE4iT/ulwpQE1oYUSjLvD98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DsSTSjSi; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3eb8559b6b0so8918214b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293609; x=1736898409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SL3D1HRo7TiklJfqyB2qV4HRBGgMR/nUjUyi5xRuIbo=;
        b=DsSTSjSiVCgvdc4eouAesVPiG/aXJbfCdFwj+pAG8cxavc/8lvSRjcYH02+VIwYKIO
         XM+wsJwuFU8OcZwhhupKJoCMYxXlgWHec8zdWPAi/HNqMCucRMCUUlnqC5S1GTJt3tcU
         mtF1F/VDZBJUaw8pNPFHCaX52pE5Gg7njUwfzBxoigIY6SOcI4Ahz0WccaRi74h0q/Z3
         yBOVN6gE5yZPY9cHHb61HUW/Cb1+0IMShNeGgAxQv2u+HB9Tym/RlEjJG58fW+YZWXBv
         qGlnf4XUQ5WZcf17m4PRQVZNMr/qIiU/xVyH/D6zRyPIGE32gHvejXGo4Phv5MdIAUwf
         yxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293609; x=1736898409;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL3D1HRo7TiklJfqyB2qV4HRBGgMR/nUjUyi5xRuIbo=;
        b=Q2H8ofMhtGH2nEIKI5LGgNpGHzYAhpoLk7A5+G5vGD6HaxqwHTmr8KjxiRiqePhloH
         lLCPLRN73IUou7bN0YDCNAwBZq7zt4kXLCEnjiW0nQp1OdDzljM+u0Shx3hjvKnP2FC+
         jr6WJTnWAG3q//DJxCNzOeyRSISsU7FRCjvUjT+INm32rfgZHgBVkMJF0O3/TCUvLnSJ
         0QOau1GdYbrEUGtt84eGsbGf85h4L42BtUMMS32NrM/3c7cgviq3NSKuU5gQ2hF2yAk1
         O3wN1s6rGJMPhR1Liz8CNABY3ZnkF9IjOUqIr2M89nJ+P9aZ1Dhr3jUowimEIQkxpQ/N
         bX6w==
X-Forwarded-Encrypted: i=1; AJvYcCU9GPGbclwbz4pdYe0enis9rLiReYFz6Dm5MKlx9k5mJJMVnnGVMOn0vTG0/nUdnZxJ3kP6hCoz+8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIdRJwQrBalzL9cXz7KssZKoxj36vcNcxMr4hj0JYPb5z6cqfT
	w9cRu4q4FbT8xEm3BwuHd2Gjv4MaB3zQ8HKaR1oZuzG1v/ZNbNFqeiM3JWaBcyo=
X-Gm-Gg: ASbGncu61ypTYyNNXFTVsu3K5kyE7Ne0SVZugANIY8bIkt4ET9xlQ8+u+Fougs24bJW
	pHJ+TFnCc4Obsaf2FiIfNLA6r5ZK7r/C8c0CYizc5qyq0IIAyGlxZdPujmYbai7wJuIRGQmqzSo
	0cZvsejnG38HLA/i0RxqQCk/tHTFBcj0SW3FK14t1nXpXoD8rnkh7bKXNRR5dr5J36Xf4CPc/CX
	EuUuRNX6JdoeL70sxs/QqprrNOrDZ3/UAIrCGzlSqHq1q2sZhXADDYzM0eqzFDu+SiY3wHeowHR
	TIGsUo1ERjaAPB3OSg==
X-Google-Smtp-Source: AGHT+IHSaE+1p2b9DCmp1utb6983FC6IeOrjC2MthVra6tdatzMeuv9ulWTf8ZXQ867XR8BRedE1Rw==
X-Received: by 2002:a05:6808:3c44:b0:3eb:5cdb:f477 with SMTP id 5614622812f47-3ef2ec26b4emr499945b6e.12.1736293608870;
        Tue, 07 Jan 2025 15:46:48 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3ece25014dcsm10941403b6e.26.2025.01.07.15.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:46:47 -0800 (PST)
Message-ID: <64f913bf-a421-4def-a76c-6fcbc190fa64@baylibre.com>
Date: Tue, 7 Jan 2025 17:46:45 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/15] iio: adc: ad7768-1: Add reg_write_masked
 function
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <67649c43050d161621bc0494638bfa71fed82ea8.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <67649c43050d161621bc0494638bfa71fed82ea8.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:26 AM, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This commit adds the ad7768_spi_reg_write_masked() which is a helper
> function for writing specific bits inside a register, without interfering
> with the other bit values.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 574d735f2c3a..675af9ea856d 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -242,6 +242,21 @@ static int ad7768_spi_reg_write(struct ad7768_state *st,
>  	return spi_write(st->spi, st->data.d8, 2);
>  }
>  
> +static int ad7768_spi_reg_write_masked(struct ad7768_state *st,
> +				       unsigned int addr,
> +				       unsigned int mask,
> +				       unsigned int val)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret = ad7768_spi_reg_read(st, addr, &reg_val, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad7768_spi_reg_write(st, addr, (reg_val & ~mask) | val);
> +}
> +
>  static int ad7768_set_mode(struct ad7768_state *st,
>  			   enum ad7768_conv_mode mode)
>  {

Can we convert this driver to use regmap instead of reinventing it?

