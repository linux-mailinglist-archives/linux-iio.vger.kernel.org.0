Return-Path: <linux-iio+bounces-16717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A25A5A700
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 23:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D95827A7A48
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9759A1E5B6E;
	Mon, 10 Mar 2025 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PCirRrg1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD41E7C23
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 22:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645240; cv=none; b=gb5lnEjvzqfvZDAf+XxqSP1cFxyLkdSYuqbVS/QSnlzthtU0Gfo3mQNVUrTzcP3znNkYKbFo/pYa9HWsgaEc83WiFGbe7q3dPD8KDR356bMXthK8n0O3d3VgdlkhSLkHqzwc3Ft0Zm7HTy/0A0JNZNtFELX1dfCe8olIYNXmtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645240; c=relaxed/simple;
	bh=DLkLyYCoY54CSkX7dRyIDdg0jO39syf/dI+qTo9gvvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMvkMd48h2NagNFvoD1/Wap7DKGVtW29GC8dOLUaGZfhsPLYqmXGk4Y4g3WBXnSERvzZkoGWi5lH9mxT2NuManTP98hg3gEImbKT5qDJ2fqgemHNn6tvNffSvOLgqgA+L9AfTo7oqm9EKt68Hmx+Yk8/aPO7jUeEYIbUhhnVoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PCirRrg1; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2bcceee7b41so1197877fac.2
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 15:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741645236; x=1742250036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQMV/S00YsLVubCqxsR5sdBdtl4HHeIQe46/Njox1TA=;
        b=PCirRrg14QGP/QzmOLUofLkYDwFw0dDP3nqia+bELbElnk8nOlr83mJjknGTlVzbS6
         jieEvPk4dkbzvSr3jWsWjqgKWnTWyEVrWTGiXOIEZBxwuns6nIPXqiI8smCSPTjla13g
         pE1H5TsvtnKWfKrZQHo6vQBpysBWuCclNfsaNkEj505RoOjbONwHyA+fOfZCbTxAtDlm
         lL6Niax0WEQM1Zdlb0vFI+mIzFJiDLL0WXChL850wokt+6B7m07wfZWRzPfn8HmHRjN/
         +AuOHZd2GNuQbdp3QlG3fK9e7sd/rNuWqsNrSoRh5D8sb/ctcTk5bARLUBdFv6RZpCD/
         hH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741645236; x=1742250036;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQMV/S00YsLVubCqxsR5sdBdtl4HHeIQe46/Njox1TA=;
        b=oPJa5cAvUGmLbm3Eaza+uvIefizVfmkRPDhwScqOlxdVgIEvrshOjjUc6HbipAjevA
         +SI4nTSsYCOUapHmi5fAkj2KfQ91qbdSkuHRXlhBcpyQsnqlXxcNxdGDM0VMnLDcmxE9
         ODSfAyQL/q4dMnwA706NlBqh1pwRoSsvFoIeSCEpaK91CnRmhrFDrbap0ESiFLWCi7pT
         W1d+4pxidU2hmnHOypXyx838NEe42W5Sru9cXLJgoQsDGe+K+BZQmDqLa9FwLfk6rUYp
         NHSz9ka7VzPXQ/5Ci8vj+rzwouQR36EFCDkRRtsT084jlp4zL0BaguRZGzPfq/2QWGIn
         HFig==
X-Forwarded-Encrypted: i=1; AJvYcCWjMvKXIjwpcmrqYKEs10Rrr+ZkcZQ198x9C4ZvreZAuQHEoiVCN0tbmP0M8CC+vEh06Rha2ie1vuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/r4x+gBeYkco5nQ4T2TQRJWKfq66t0ZFdKMthaeZ9g+0qdk2
	mZPoHmhKoq4CpiyDm8WrXuNUjhmTG0KC8N9Y4xDCoieQ7yt2PiRUtcQddnEMTXI=
X-Gm-Gg: ASbGnctQwbkMmaMmMiitAfnPAYB3+jjipK+zQstIm4MYMZi3fcGGI07VA6G7SImlTVS
	jxcm6ZXlx7/72QahjAVvS0BNi/GKM4DFLkQuB6SNcsNWnSfiPURtMCfkeLvXCkPJh7hJQrOvwH+
	xsg1JpFh3r0FLS+avPZLn2p5PQ5E/BK5nKgo6r3kiZAFYdA16pYXbZUv7tq02XTebG+IqwF0su5
	kxzOcKsw4axcDO8co7mxWw8W2nYnA4YAvlfowE3adsGNpRWofKr8/6FHjL4PL7aoTj2T9rc4m0Y
	7H4IsXBX+93WJARxjtN6i6FNoCfT/wOO8Al3V984utv2OAOMujqtASD29UJ09LVbnkWJ7y2hb1Q
	/epdK5Q==
X-Google-Smtp-Source: AGHT+IGE9malwHWQ10W5gtyfU1rUPb9WODa73R6XJAoeq/Dr/s6GKnbkqOphoeJcPfEvv5ENXANO4g==
X-Received: by 2002:a05:6808:2390:b0:3f8:498c:9ef7 with SMTP id 5614622812f47-3f8498ca481mr3507632b6e.24.1741645236226;
        Mon, 10 Mar 2025 15:20:36 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f7dcdc4050sm1059241b6e.40.2025.03.10.15.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 15:20:34 -0700 (PDT)
Message-ID: <fa8b21c0-f3f3-4022-bef6-2e14586256cc@baylibre.com>
Date: Mon, 10 Mar 2025 17:20:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] iio: accel: Use iio_push_to_buffers_with_ts() to
 provide length for runtime checks.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309182100.1351128-1-jic23@kernel.org>
 <20250309182100.1351128-7-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309182100.1351128-7-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 1:20 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new function allows us to perform debug checks in the helper to ensure
> that the overrun does not occur.  Use it in all the simple cases where
> either a static buffer or a structure is used in the drivers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/accel/adxl355_core.c    | 4 ++--
>  drivers/iio/accel/bma180.c          | 3 ++-
>  drivers/iio/accel/bma220_spi.c      | 4 ++--
>  drivers/iio/accel/bma400_core.c     | 5 +++--
>  drivers/iio/accel/fxls8962af-core.c | 4 ++--
>  drivers/iio/accel/kxcjk-1013.c      | 4 ++--
>  drivers/iio/accel/kxsd9.c           | 5 ++---
>  drivers/iio/accel/mma7455_core.c    | 5 +++--
>  drivers/iio/accel/mma8452.c         | 5 +++--
>  drivers/iio/accel/msa311.c          | 4 ++--
>  drivers/iio/accel/mxc4005.c         | 4 ++--
>  drivers/iio/accel/sca3300.c         | 5 +++--
>  drivers/iio/accel/stk8312.c         | 2 +-
>  drivers/iio/accel/stk8ba50.c        | 4 ++--
>  14 files changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> index e8cd21fa77a6..ae949ada6db5 100644
> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -666,8 +666,8 @@ static irqreturn_t adxl355_trigger_handler(int irq, void *p)
>  	if (ret)
>  		goto out_unlock_notify;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,

Could also use aligned_s64 in the declaration of buffer.ts.

> +				    sizeof(data->buffer), pf->timestamp);
>  
>  out_unlock_notify:
>  	mutex_unlock(&data->lock);

The rest check out.

Reviewed-by: David Lechner <dlechner@baylibre.com>


