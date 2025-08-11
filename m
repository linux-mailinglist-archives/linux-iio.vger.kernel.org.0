Return-Path: <linux-iio+bounces-22596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F68B21540
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069413B79FA
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E62D6635;
	Mon, 11 Aug 2025 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k35B6yyD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2254C29B216
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939895; cv=none; b=cZyc83PftY0xe8XqRj83HQeOlMR63PriRzRufZ5moPM8F8hFGVxhEneykvrhm69pF0KcFe9Y+Z6qMLHZBJw6yWosHfAgcqP3XJm6kQdMyN3AfQRyKSD7Ms0Eh1auCi9fFBxiyYBf1yTAvlrs/83285H/AcBjUD7bq025/KV0nFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939895; c=relaxed/simple;
	bh=NQZV9bm3Gom84bDFKkgr3+KlA71bM5X2Com280Owt/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP6n2v4eYTmZEQfwqRUuXLDwZCBmoGwemfeTEeSrkfT3XdgS4fu0Y29VxtDIv9LsBuzfo9sZHVLidC8tV0P5YMMaK71Lt0No06PO2smJbC1+YAJV4EpQbPBhoIjTURGfejmSJYtfoozVKqT9d9HytBmHkICnpDMiuwJXALY/Tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k35B6yyD; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-30b6c230808so1200788fac.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754939891; x=1755544691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AI/sGQsL/aW+QHdvLDtUmPvb4wNwg5knHWyurN/Guw=;
        b=k35B6yyDOeXzytZZKiVTgoIHEQl0/t+rH+JZu+0sBEjzVJ+lDYk863Dldr4k7m+YNW
         RvcNC1Ny4i2lxScHc/RNw0UY0qk553Jq9qt3ir7eurWtmxgW1Tk1pTTXUEkbQFagqZG9
         Mgdi+AmkZ/fz+/fEbuqytv7IeSRCknDcQjazdSZdtuM+e49XToKd4FMZ89Y8gr0BedLG
         iMHt+M8omYWB00buLb54cSZvlNLHGhZw4KUWdlVoK3HS6ksS9KKW96olI7mUFQX9F6Wt
         f8gzXR7eBLoPBLEVKVAh+q49dZy0iADVOFG1cJvAgT+9KmirICcqGbHas8nCNSP+RTnH
         hNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939891; x=1755544691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AI/sGQsL/aW+QHdvLDtUmPvb4wNwg5knHWyurN/Guw=;
        b=VhEG302BYDFou4Jd8yJFvU2P8IP8hci80J67V/q5gRXNU2opkd4wA3s7PseXhWECxQ
         l0Nblqm1BI+kkZ8NGHRIYvtBzJvlbL7wMw/sYEbyPLHIRMY2ezgNh/z3s2LI1dHacmAp
         ZHy3WD/tH+2poXrughxV+PA33giTNNtpriz0XQ6RLHXtZ4YWOm5qrBD2g46/T5luq12l
         h9V05DmtNaot9PNsZY7z1GWuPTFKNQ7wlduRGKKAo8wQEijeGDSyZ4QH59vNSxoi06vY
         H5mJZGiSUpwmCFQBtnQRryHyxYYo/2DjMDoimuEkXd1Nd5koQYT8lu0+sTPtXSz9VjRl
         NoUA==
X-Forwarded-Encrypted: i=1; AJvYcCXTYi6E3i7xk3ys7YHp3S5eWtBgM6t9xAoQ3INDxRSNNXQWf05eLbXWmeFblgWt99yCmaixmYB0n18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgzteaE0SCEEtWt1Aq5xMr72dcnCmMYgV9DTq9ZcgI9FlCDSA5
	73x5jzkPrlsX5viCqXvMW3YjMe7Y9uxneio78V+rIyyJHKjvEh6qIkPCgPZzJXJi9uGbGdb5Sxe
	QD6Rf
X-Gm-Gg: ASbGnctUU2R+S+6G6oZkU7se0Mye2wSbs7rnzgqIgASXOXA428FIZYmVFOG1nRNZKO9
	/1EvkYe4iyPuaTznGRLG4LjrAOVEvfiAk6cv4sfhAk12vFuQ5EF8pD1580hcemCsL6d/E3jwUtU
	Je7VMZKUEQeBFeSrguab81XPKHwZAVYP9jngRlvU43X/+94W6gRBlsxm5T01734q35SaB1TJf9c
	D35pnIGixga0PSAlY6K0/RDFnTTyY/zWrvoikAO8c4D9CGpf3cfzqzKlrJEr+owr3V/j0a2paWs
	cK2jwzWtg9ndjKGnopmLCC9CggbKFWCzzqSCsdk4ywKSpA26KSaHD7oHyttLp0GmRvia5AaUMiw
	3R1nhFP+x8pX7QODzbiOgHbuPbbGCYfgrRWq2moQEKgw1hIiC5ZmfJSNNKTph3EPZLqi9UQtO4p
	E=
X-Google-Smtp-Source: AGHT+IEk4tJYU293i2xanK9PPMki/B/oadFN1LAk0tX3PXUVY4o8rCfhXdsvnLhc2bj8rE/LJaOkBw==
X-Received: by 2002:a05:6871:e486:b0:30b:cba0:31d2 with SMTP id 586e51a60fabf-30c950a75ccmr627923fac.31.1754939891168;
        Mon, 11 Aug 2025 12:18:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba? ([2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30b8d44e03asm6293482fac.31.2025.08.11.12.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 12:18:10 -0700 (PDT)
Message-ID: <5732b907-ccb8-4302-8fd7-ded63a5d852b@baylibre.com>
Date: Mon, 11 Aug 2025 14:18:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7380: fix missing max_conversion_rate_hz on
 adaq4381-4
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-v1-1-ffb728d7a71c@baylibre.com>
 <CAHp75Vc_-2czsaZ_-3+cSWAzyvz-PASR5mjCyoAxTu9qSEYyLA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75Vc_-2czsaZ_-3+cSWAzyvz-PASR5mjCyoAxTu9qSEYyLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/25 2:07 PM, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 8:32 PM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Add max_conversion_rate_hz to the chip info for "adaq4381-4". Without
>> this, the driver fails to probe because it tries to set the initial
>> sample rate to 0 Hz, which is not valid.
> 
> ...
> 
>> +       .max_conversion_rate_hz = 4 * MEGA,
> 
> MEGA --> HZ_PER_MHZ

If we do this, we should fix up all of the other similar ones
in a separate patch. So I would leave this patch as-is.

> 
> With that done
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> 


