Return-Path: <linux-iio+bounces-23812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D05B463EF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 21:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9C95C8446
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB02773DB;
	Fri,  5 Sep 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zo/88RbZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A698A22C32D
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101749; cv=none; b=isaIfEdX4vV9LXVs3h05uxcnRq/jlbRmYJoqI68h5hHpbUikEYml4WFTCO6ksOj+pj1by9XPuVEm1XOGQZXtfMWVo8/d5surZhP002eR4/gTCTuHj1Fnvl/xRGgo0O2WMK+ozZY3AZstaXDZdvRMRvmkRBNzOKuBVdKDam1Bni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101749; c=relaxed/simple;
	bh=SDXmXmmQ1vFXl5JZs1WJtKI6JEciS/jqDcvT58tTS3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDNBx8bkZVZY+VbW9DGCUNQcqYRovhu47wryqvmJYRXCzXjtJvtId4B2ugIHzo7xqMMmaWFqYZqQtqdeFveyVAV9sbbqbZUkIFXHalqUEcz7XRzwLFj+xGpSo2ggCb4HV++SMNNlvXNCJcFS5d9xp7q6dXquDIUjWJizndScw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zo/88RbZ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30cce872d9cso2374440fac.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 12:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757101747; x=1757706547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Szv82Yg+I4qLiwXwVi16VMgcWXR81jSEFdZnsxSabZg=;
        b=Zo/88RbZ8lyQFhw9ebZaQt80sP8CNUlPBN7QFTYbY7uYEhD9sEhlMiKaOWPucu9vYi
         Z+vNYCJuXYTpkvPOprh3Ax1h0qj1Mas6y0HCobeHzgv4g/2Tiuamkt76y62jViwwH+h/
         uqbBGWx8NoiCWMrPQpt5gkXd+VpRNWgLmkBWpjl6duA8Zf/esd4gZbxJypYlB/gkf0Ov
         eUblqhPoltvH5PMDFaQhltsEX4bB4EVspdVkakHYifC4tSCeGamL9AnBO1D39JVX5aqk
         9ec31rWFBRQQTaePZ33eaG92gUmoysdl52K66KMZlUOAvdRm09r4BRPmqQ8NIFPvXdxX
         yVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757101747; x=1757706547;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Szv82Yg+I4qLiwXwVi16VMgcWXR81jSEFdZnsxSabZg=;
        b=QDVVHNkR5bT++LKLgKcl5zaZI6fFV8yYRfcBw03GwP9PNzAstE8Cvcc6xpCJFtmMk7
         vrn38de5mql9D8QcxkyWp2jkYt1Yoj1nRhl/dNewfo6rP08mVZXS8ZDJUbhb8Vp5PP2f
         KROD0oCO9FTuXbBJ40wX4+rkGvH8EK72yy7yEo2HRiCkajmHmfFiRVQ7IOZJX9dDCzFe
         9Y6v0iBzhUOSNv0XpjfFY74PaQN9ceRCpJPSuPcKg2CYUeYdscRL26jA3OKthD4xYm0/
         j9wR+YH8eetsGDQSON69suMfwI/GEaI86wJAkbcTxdlM8DfwGhybXLMe+L1H0EDLrzRA
         kTZw==
X-Gm-Message-State: AOJu0YwS7KQKBqbLmr87b7ajkHUEOXTEgxkEhkI21n8HXsygzwbRsfue
	dCfnf8BZb31N+dwF57J7pIqcnb4T2ycCvhsBNESGIfvTZL8ENag0vblMetv6hJzhsiI=
X-Gm-Gg: ASbGncvR6UHoGmEiSCT0nAWfTjCZj3dLQt6zahXH7z4wIeU7hDEjeUmr4ylyzzfRe69
	4gWIBoPJaSOGJNbeciYQFHNSV2whlVcuIkoLe+92/43dKdCfRXAzgBEHz/DV7qq5T3VNJTX5BJO
	K21//KorZHwofXxsKhkkNYF3q2T/E5XW7bmzhQnZtoiYBm1IDspGL+5lBxZdN+Nq8RBnajWWlu2
	/Z9mfNCeMIwYnKkb1yREpEOoraoHWpw4dX24j+6mvTCSoFQMkdlEqhDIaWRcX6+1siogPqvCoj4
	0mwUh/710mQruk3cA3bc1fstp+BT5vMbGRkm9xDbPKTWoVh6AEGJXVezxa8FVTi9czBY20kVwky
	gwojg+oSRRINxd/oAZmi+pFmixa0NvL6yX0eEwhwNtBoKfu/l/QB1c2+q6eXUyotoRuj9AAz0gE
	S1IJIglRc=
X-Google-Smtp-Source: AGHT+IFRxRKk8LtvZ6He+rGVAow3FoQP7Fwy9rnhW18mDzyKWJ4V4U2SXMzMRn0S6iDAapzSQorQTA==
X-Received: by 2002:a05:6870:b013:b0:321:8f88:a39c with SMTP id 586e51a60fabf-3218f88c130mr1286348fac.47.1757101746811;
        Fri, 05 Sep 2025 12:49:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:52e:cda3:16cc:72bb? ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-319b5fcbbaasm3996358fac.15.2025.09.05.12.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:49:06 -0700 (PDT)
Message-ID: <e97130f5-9ec6-4ac4-9944-96f992eb215f@baylibre.com>
Date: Fri, 5 Sep 2025 14:49:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] iio: imu: inv_icm42600: Use
 devm_regulator_get_enable() for vdd regulator
To: Sean Nyekjaer <sean@geanix.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, rafael@kernel.org,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250901-icm42pmreg-v3-0-ef1336246960@geanix.com>
 <20250901-icm42pmreg-v3-4-ef1336246960@geanix.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250901-icm42pmreg-v3-4-ef1336246960@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 2:49 AM, Sean Nyekjaer wrote:
> The vdd regulator is not used for runtime power management, so it does
> not need explicit enable/disable handling.
> Use devm_regulator_get_enable() to let the regulator be managed
> automatically by devm.
> 
> This simplifies the code by removing the manual enable and cleanup
> logic.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


