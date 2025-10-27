Return-Path: <linux-iio+bounces-25497-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC8C0EF2B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 16:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12C6F4F8C32
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851430AACE;
	Mon, 27 Oct 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AkHuYLsS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56054302143
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578360; cv=none; b=E4/A/tMP5P/qX7p+RTII59D/5qQ1LyJMwqm2N+bI3xKdhux4PZ2PAPkAAubRvwCpBJj+M4tC8hBovZf/byg8Sc5E1/2+4uvDB8oJsN9Ieq6BcLaW62KWlP7WtY+9zNAA1JB3/3TDWaMi5Lm1yOGaz6ukzzR6sDdP+5VFMBPC2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578360; c=relaxed/simple;
	bh=KixK2y+JDj2jpYzeklb+J7CuSxEOJKGpkz49v27WZzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NapT13eEeIS99aFFA9W23vUIY/9g/DEYaDxboJn4Zg14/MSu7XwXDPResEDVP6Eikd8BSXjlnOGKNJMwc55h97nxuwpZeYRdpFd77dIDqRlpoQCkLlpIuEz1EQq6UpFKeSLcLCMrfaFs5zbTRtYFSHp7SbMUK+01A+zCUpYk3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AkHuYLsS; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4445c606626so1161335b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761578356; x=1762183156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOEpFoGH59PM/ywxUlp4N3kjMG7XFuzAFXwRgcemaNY=;
        b=AkHuYLsSvNKHLktPzVrPstr0klzNEz01NL13g79nQmNPcly/Z07qvjCI8edqfCwONy
         AGVWtbn5Bj5GucX25v4Y8pGXuDNa2Y85TqUR+zM/tu2lh7ib5jFMVAC+xYfwzri4XLKc
         OWWIuLYy7ch/RrNi/532T/urjiSXFAofGva1YPz09uwvLOruta+wQ83gTL8xJqjjvcLJ
         bS4ckwDaCBUyjfYGsjngIzzgbCjk7ggb58lvlFAEpOckKCE934lGfSXxhLZw0fOudjPJ
         XNSB3d6B1+ZnyAvvbuqG7Qh9qDpJ6ncda8OQgEd+5BlLxm6KoxY/zbmLXB8zFQhSPFzy
         3ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578356; x=1762183156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOEpFoGH59PM/ywxUlp4N3kjMG7XFuzAFXwRgcemaNY=;
        b=pV6+rrCr+MvCzu8SunuoGtCLavI25Dc7jLjYriIv5NPw2yPecl4QlWuhy1k+Qbv9er
         5zbfvSibpC6JIW1bzB1A+136A+gervLEQw/CfxLN4JitCPtWkMJOxv6wWNDXZecgJouK
         Plwx0DtOZpCsa65V8aMy7FogDuNxuQmhQ0G0OtjsnvoAU4sfGn2RyIm8U+iI32RaaXYq
         G8TcOn6vmrWKOhBTxOR1C6ajgTXz2p/doc736mFZkgTwglPhfxBBnxugc1kLETFBGz+7
         OD89FfpUndoRYrYPcn3mxiZ6sDbC7jsrvcw8W4j8OBNHjrAOeJ/9hyrrssRAdMU0PsIO
         dcDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX84yjIyYZu7oH8ojALFeVKETUziGNRrDPNpvBgMT9phVi97gxI815tHtaqJDMtsji322xpjB40bbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFn2OxdkYvcgSbr1cB+wInpcGIGYItRhbsIosjKQbfjMwDcHN8
	zMkcHdoGIihdYtRhsY+4ebcXI6oC0gGogPi6JRFgapEBp5otlWDJoUEpIhDMShJCiJ8=
X-Gm-Gg: ASbGncs7SCTdeyBuOZf0+ZKmv+lyZom7vAjtOK0jFSOCQAB6YKt4VrmDSdXORF6UXap
	UWHN7wksX6jTbOCh+oGQ63MKJ9Vfyi+glbuo8NhVk+3F7peoKKHoELPMI//Cvzy0T6sbw1W+iCW
	5xmL/ALA2aQS7yAxgpMk6WEPv8Dw4uBz47WOCSxIM5zUh/HMojuACPsljizAwZFWg0xXw52hVHv
	gYZkCL+tjupPJHojSG4XC8QiOblqM+YYDYVgI5tx3eqKr672Jxd0iidiCfI/A3bOZqoANTPqooz
	X4ob/P/o2llM/IRP1qGppeMQztTi/7nNaNTJGpzdS6ytPQMEp8wmC00MIm8solvfOEIVq7e1OjP
	J8CE7ZSfVIGZjg6ggqSGtXG2CehBcwYVulAPcGmkY/uLt4Fqw9/bTK3lBTjgTabuHrnX6s4z1SU
	xXo4NxalDPIx1bDgb62nqWCcy9XXob3dUUmQcyj81Xk6xbzlO5Jg==
X-Google-Smtp-Source: AGHT+IET1m0Og168FNkiHiiqS/dkK0Q1Ob1wq3rotBlVC0PelMHhFuKEOpxhv9FYgyGB4FjHQFu58w==
X-Received: by 2002:a05:6808:21a6:b0:439:ae49:9159 with SMTP id 5614622812f47-44f6bb045aamr63228b6e.36.1761578356367;
        Mon, 27 Oct 2025 08:19:16 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:46d5:c880:64c8:f854? ([2600:8803:e7e4:500:46d5:c880:64c8:f854])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-654ef272326sm1909058eaf.2.2025.10.27.08.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:19:15 -0700 (PDT)
Message-ID: <0d423afe-9aa5-4423-935e-1acf71f457ee@baylibre.com>
Date: Mon, 27 Oct 2025 10:19:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in
 ad3552r_hs_write_data_source
To: Miaoqian Lin <linmq006@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Angelo Dureghello <adureghello@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20251027150713.59067-1-linmq006@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251027150713.59067-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 10:07 AM, Miaoqian Lin wrote:
> When simple_write_to_buffer() succeeds, it returns the number of bytes
> actually copied to the buffer, which may be less than the requested
> 'count' if the buffer size is insufficient. However, the current code
> incorrectly uses 'count' as the index for null termination instead of
> the actual bytes copied, leading to out-of-bound write.
> 
> Add a check for the count and use the return value as the index.
> 
> Found via static analysis. This is similar to the
> commit da9374819eb3 ("iio: backend: fix out-of-bound write")
> 
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


