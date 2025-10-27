Return-Path: <linux-iio+bounces-25498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA983C0F02A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 16:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E200A4FA12D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0722310624;
	Mon, 27 Oct 2025 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zgyLo0VK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310030FF30
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579307; cv=none; b=cESCGf86TFjID11uxp9jD08LgjAgw8/Ob+S9CuSzpSXLxCnquxeGmixEQqA4+h9rxMdUd+5LoVJW30YBpCiwNEhElFhAZUwW2cpmw8HqWzjGYaPINSjD4Km6c+b996I4RxDedNIRGl0kzkeDbSotSxOavM22kcyAR1KeOCgN7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579307; c=relaxed/simple;
	bh=lUh3vpGKqYs2pu/MSXfc3x0+dDC9t63CUv1Wi22tbtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/ebaEMpN0d6+5eIanY5EzYpnESXUqEV5IX8tBi45RkmcVxMesY4TSTuxmEgC7BO2aBLq1T1US1J7tMAotDpmO3NSJimyfxLf4vuyO7GtxWIWO23lpSjaiBx7F+PTUTQO1bPxgyHDf+qiTQFKIQ1/4uuVBes+YTMrO+ZDiqM+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zgyLo0VK; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c532d70cfaso1629025a34.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761579304; x=1762184104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgczX3f1Sdgn9dYt2cYjuFRk9Cp5P6JmUSzTKrcL85g=;
        b=zgyLo0VKCw1yy9A5p0F2Ba6wDHn6U04F2H7MFjU+UW6KL/j0WpzxvRhyC124wfUH1E
         ++cJqWv5ZwymX6PWqUQ/kX1wy7YKyB7NQCUgW/IEkwB5PO6OGxkCyHMKICskblU19Enx
         9vrv7pX2b3cBvGAKSz2EwUYGFRt8UxwgIWzxJwcQTOqe5NO0/6yAQfTGh6ah8hvoN2OW
         NLZ06xiUHsxaS2nXfEn/+sD0rVKAduReRJnTnnED2BolWdjwJCEzKX7buPg9UeiLfwOS
         KSaDRvlPjkJ4be+TT01s+srv901Ea/t2K7obLeBGOwgp/CHrH/8Z1qnhWdtokedxAMaH
         3Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579304; x=1762184104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgczX3f1Sdgn9dYt2cYjuFRk9Cp5P6JmUSzTKrcL85g=;
        b=F2Mm1szavUFBMEQ5STD3XIshfOT+8S84Hl2WT9OCli2gNgIGKbCJvo+xFdoE5nu86/
         W71or9a/kjvnvXYcwNe1fD8JIMKyTZf5rIoEdWksj46sB5NXMr2etqLH0E/bqIqSRw2R
         x1u8ieJudKews9sWQztDWAi/ERJyxKlT9vTD3REpIPjtqZUIRgQGYsy2hS7V9pSEMUCZ
         YRknEXk/kJO/YhbSc43g6S1ed87qnm7YCAkRw0VJdkGrFkUqjWH75Hk3AIXSCIYheMpo
         Anfp4E02CFEXm/ilwOCk/KCInOs0NffL58mqBF+0qwtotETeFtelyhn8mcYGZSnS0L+P
         Puag==
X-Gm-Message-State: AOJu0YywBt2bOSsmsfsYA4POQ76ntXiztF+RVd3hzqqcdSMPD2tbWLfx
	9deijs6W82xBCz3BgeVaOMyCqPZvyub8rGa1gNWxufGC/rClXg2NBMkEZVSAJCoO6LM=
X-Gm-Gg: ASbGnctcX+hpLuC5UCCxkgaIo+PsAkrMe9NVgfH9bDHzrYELAVJ1hD3JsA8uCYd98vU
	Bb9n6GG4HlYLHaAg+iMEcTJzK+5prkdQVNO4NJtMHXwdysEZdlkg6NYe6B6eqO0HwVrpBtzvgYW
	KbXekV/S/bijGavB+GHQkJRwrYVU7OqfWlBmYYlWNAdASA0uC4jRMBwsa2to/v7OAZ5ge7BddBj
	yQ4O2aasCxacJTAVfcG1ubSQeJ6bf+n/to9OrzPnK1kubKOYNhxejBss2RNNs2rPC1UtYxIZIrh
	7MtV3Ue2VZt4v2PjVZCC1vV0JnkwgRUKdF2TcCKOEdEFXfL1oLOugRKEQvMfMlwovWyo1ndBu/A
	yAZtAL+wXnjVQAGnpc3FWGfM4n22hsgchQiiu+jrM+AfTEiJRDl2Bb2QRrUJKFYMRyQ7WSSioDa
	j8hUfbLV7CA2sey81KkD/fyN27zhPi7Ilby8gpd34z0Reqhc0ZIDhwgoiOWnPj
X-Google-Smtp-Source: AGHT+IHUsZNkj4+DOjpUKZ8N5ak286teUFNqlGTwrn0yBSlI3UZoPloQU43tTLH9nYRicMiQJtvJSw==
X-Received: by 2002:a05:6830:d1b:b0:7c3:e07f:5681 with SMTP id 46e09a7af769-7c677f42aecmr143010a34.10.1761579303905;
        Mon, 27 Oct 2025 08:35:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:46d5:c880:64c8:f854? ([2600:8803:e7e4:500:46d5:c880:64c8:f854])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c530221d90sm2315768a34.33.2025.10.27.08.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:35:03 -0700 (PDT)
Message-ID: <23069e05-82d3-422f-9af7-fc100d4d1466@baylibre.com>
Date: Mon, 27 Oct 2025 10:35:02 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: fix kernel-doc warnings in industrialio-backend.c
To: KRIISHSHARMA <kriish.sharma2006@gmail.com>, nuno.sa@analog.com,
 olivier.moysan@foss.st.com, jic23@kernel.org, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20251027092159.918445-1-kriish.sharma2006@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251027092159.918445-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 4:21 AM, KRIISHSHARMA wrote:
> From: Kriish Sharma <kriish.sharma2006@gmail.com>
> 
> Fix multiple kernel-doc warnings in drivers/iio/industrialio-backend.c,
> including a missing description for the @chan parameter in
> iio_backend_oversampling_ratio_set() and a missing return value
> description in iio_backend_get_priv().
> 
> This addresses the warnings reported by kernel-doc and the kernel test
> robot.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506292344.HLJbrrgR-lkp@intel.com
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
> 
> v2:
> - Fixed another kernel-doc warning.
> 
> v1: https://lore.kernel.org/all/20251025102008.253566-1-kriish.sharma2006@gmail.com
> 
>  drivers/iio/industrialio-backend.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 23760652a046..73704cc1bd03 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -717,6 +717,7 @@ EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
>  /**
>   * iio_backend_oversampling_ratio_set - set the oversampling ratio
>   * @back: Backend device
> + * @chan: Channel number
>   * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
>   *
>   * Return:

I guess it would not hurt to change this to RETURNS: to match the
rest of the file either.

> @@ -1064,6 +1065,9 @@ EXPORT_SYMBOL_NS_GPL(__devm_iio_backend_get_from_fwnode_lookup, "IIO_BACKEND");
>  /**
>   * iio_backend_get_priv - Get driver private data
>   * @back: Backend device
> + *
> + * RETURNS:
> + * Pointer to the driver private data associated with the backend.
>   */
>  void *iio_backend_get_priv(const struct iio_backend *back)
>  {


