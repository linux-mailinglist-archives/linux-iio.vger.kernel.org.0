Return-Path: <linux-iio+bounces-20725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40469ADBB8E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E640916E49B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B52153D3;
	Mon, 16 Jun 2025 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3e5LjKGi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45E211A31
	for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107191; cv=none; b=VrLcy8HWhXpcb3oo6wuSg2FsJjOgR+rPX8qnuSSgEgcmIXFByV7nufyScTLkV4Gub6HSWYJPx29jFUr+5tYVNgPXTQc3hFA8qW6nSfF0+Y/SME4svQc9iMCE5TAB7UTxK7Of2pcSrhqZNarjxMBEU24v38BFa1GEyL2UxJZ5NGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107191; c=relaxed/simple;
	bh=Fgc2WWVhmZSNbwYEBSqxyC8hN2ImBZ7wr5GI6gGURtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvSftwgCjPWPsv7qPQCI3rrP+noVSHpyO72K9k0psL+TIHsVigNTJICo9blfpwo+OUGQ9aa44dUEj83V8xlyhMHbOwA6CmcJ+c8riRfWPmiholJcOl6N5U8GPoNVmP5sIE+IEij+TduNeTDM8K83hqFbaqYiLkLm1zB1p+N0SDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3e5LjKGi; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-400fa6eafa9so3511825b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750107187; x=1750711987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8tqSOUPgM1bEdf4klAOUys4IG+Ji9moxOsELLoPJnk=;
        b=3e5LjKGi+PaHpPwAxSWsy05puAGIByyAtxpKsXJe3l9dzhTesO/jCjl9ZLznA7MK1I
         fnn0eSXXdYgyxvBH6soKWMdtwD7wM9P292MVT8PNw5XTIgBIW3lMSZTHL4gd4YI4btJ+
         r/Rw7y+8CV1Zf+oU2t0QFybi8Mh29RsLg/ltE8YCuY5VHtsrNt9jeH71VAIpCzYcrqV+
         oTgy7A+0Q8YrdRB7dwjT9cwjHMq5P5I9GawreWlDA2rWoM8Ez2laX8A0AdK0fZyLadpG
         l3XeGRpgcoIWbcAmM1nm+WK+lHijSoOaadGkn6EMVIwVH25xWVbfXj108PhDWSziLd16
         tiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107187; x=1750711987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8tqSOUPgM1bEdf4klAOUys4IG+Ji9moxOsELLoPJnk=;
        b=hCdn3SVIcawWUKQ41mK2pq9IamlN84NWVCLG8szjqknyZxDoxsVN+IahemHMU4FuOl
         qMf/G/SHKZ8uJyEbP5NltCWrRdPZsNDGKRODxitIYae2LMruc20N0aqUArWBgJKdYaaN
         kr55pyIaglsBhdgw2W72c56FBI36UTmtx8c17bbsG132fXlM8B3AgEjzAFaJkNpPjwhB
         aZ5jp5a9UQypoHHg0j/4dRtO2KJWd4/F+rkkLNw48mSwDzXgkKHQNcgjEpJyZRd2oj9J
         dG4W+IBDGZaVipPgI3FmLFgOEYbg8a5FWUcUVyk6HMfua47Y4PjmQ6NBqQnzHjjZt5wG
         6feA==
X-Forwarded-Encrypted: i=1; AJvYcCUe0v6zE03wGUYelG0w35tqPu46jCIdT3CZy7r9vpDScxQ6Wdrd5NbZE1AESzl6vDNhYH3GDBLK3EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9WLGrbjPnJBTAFW+/1ATy2g2fVMSGSgzBrFkDPqnMFn12XgKu
	Lsxf49/xciR0nlcwNaG3QTfr0WnLIzGZPzVl1qupbF/OMCsaJcbaXThSiHBB9sA1eGI=
X-Gm-Gg: ASbGncvmh2xkM30UbAjDrk2098ML15UU79njILVyyhNU7ifC0rABcZWNwUkXqg1Hr+B
	2hXEgF/oqVwm2Ns1uV9k6Qbx5Ap3zwwKmLaaxUKOlqMilMCqjx5VdGgJvMJxDNZvWEaejUtjEXP
	CPRU0rv85wTheplFXrqzr/esm3vZupz4/+q3a6m76SU27QXWly14lfwWUTx8eVQEfBU2sClCOCd
	BagOSh57VRqDCwVBOaZcB1eGoNcBKPQsuULA9l2h1TEG41qw8ro3YlEWJ3CcZbEWXCT+sXETyIg
	CJJxcgLv2u1zu+9yZUryI4IHBWRKLFC0VNNnZrqkgFWzRx7pvbCf91px081PGlrSKyv1yyJroeG
	lQhehmrzOAFhU7Y6SNKE3kxQP0/RXOL0EhvQpaAIcaCm/r7qJbQ==
X-Google-Smtp-Source: AGHT+IHzYq6GWzIf6b3qYtzYTGBw6n+PghC3rAzoIMdm1SgQulh9Kqlg0au1m+bSuRR9JTofx3sYSA==
X-Received: by 2002:a05:6808:2026:b0:406:6d79:49d2 with SMTP id 5614622812f47-40a7c24c65cmr7434326b6e.26.1750107187404;
        Mon, 16 Jun 2025 13:53:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9583:1e37:58ed:10ae? ([2600:8803:e7e4:1d00:9583:1e37:58ed:10ae])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a740c2306sm1627122b6e.11.2025.06.16.13.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 13:53:07 -0700 (PDT)
Message-ID: <ac4aa95e-2309-49a0-b498-2bc3ee232a36@baylibre.com>
Date: Mon, 16 Jun 2025 15:53:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] iio: adc: ad4170: Add digital filter and sample
 frequency config support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 marcelo.schmitt1@gmail.com
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <dd8a615936dfebb6cd7c8110db2fbe0b81776608.1749582679.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <dd8a615936dfebb6cd7c8110db2fbe0b81776608.1749582679.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 3:32 PM, Marcelo Schmitt wrote:
> Add support for sinc3, sinc5, and averaged sinc5 digital filters along with
> sample frequency configuration.

Wouldn't mind having a sentence here explaining why post filter control
was omitted.

> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

...

>  
> +static const char * const ad4170_filt_names[] = {
> +	[AD4170_SINC5_AVG] = "sinc5+avg",

Do we need to document this as possible type in
Documentation/ABI/testing/sysfs-bus-iio?

> +	[AD4170_SINC5] = "sinc5",
> +	[AD4170_SINC3] = "sinc3",
> +};
> +

