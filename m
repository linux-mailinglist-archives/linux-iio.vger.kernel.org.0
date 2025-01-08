Return-Path: <linux-iio+bounces-14045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9949DA06757
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 22:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9974616640C
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 21:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE372040B0;
	Wed,  8 Jan 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z3tMjnjg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57C15E8B
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372395; cv=none; b=k61KNUFnjYjvlZbjMIZ1CruOKS9y41VNuoShtItmdhDDG8STPlnD2HF1wAqgSGbFavl/WBrWMb/xtxs/CmQf12hS7jk/RT5STC2KfYgksNGPM/KJKaYfW+0wnpLf9oILeuMwjUMAobn61Ukk3Iq125Sgc0jHtJeIj7f7mC1AxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372395; c=relaxed/simple;
	bh=o6cvMIX8PXChFXDlIVAOiVsqOrNStTwaSpdg7Nb+m78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeF7fHesXGspsRCins5lytmkP2ajWpq+5wEO6XVCtmLIuCXEWaAkDBhe+VdQYDY13GIpV/L2+8vYG/KJdoDMjDurjz0ImojdMnLOdVK7bvyv7q8fcZhjPDmKfLU/EVnqo4D+9UqoJSPo8xai+TwugiIZ+wKywGFpd6+ck4JpSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z3tMjnjg; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e35be77b5so85905a34.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 13:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736372392; x=1736977192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjYfcCjlYB2tvQKwYd3ADwiwOuCOFo2jlFUrf7VKNts=;
        b=Z3tMjnjguuZnvtw7TL3h2n0yTrlY34ssPZGLiSYhvj5RCpKkmM21UM0/APEZG/X1D/
         a2hTQIwLCvZHKwUjdMRz0/zhCDnLDEt29vOG/TRrstOhiv0fHDv81IbTDBliAGLOFKOc
         nvuvIeUN6rHNfl09xLHwbogNGc5xcq2Z00ogfc1U0Lvr3CrIvPqODUUcJIgTE1erSMwr
         SZNfNHLyEvs2dh4oLdQWp77EQ2xrElUCfEz4Hjblq8gZYxIxCmPUdl4Er1TGyKJuNkOS
         GQdH267DPcaoPuBgV2yg6v1/ywQ6vAT61oEodniyQXBu4tj34anL+I/kreD9M92KTuGq
         +v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736372392; x=1736977192;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjYfcCjlYB2tvQKwYd3ADwiwOuCOFo2jlFUrf7VKNts=;
        b=fBUhs+9DqCSC+W3l+k2/ZAbK7LdGEhgznUOCtcZ2w2Cc+JdOw/WaUJD7CuPNyP7q3i
         vybxiY3MOnEL6R9uJIwGs/pe/0TwPXkviTrSWEA24eXN87yEsVdpEb2NO6+HV61Andxg
         k9tVf39Wm4hBVNv1uBfenz2RmUPUO11OCi7jiDrgX9Z7s2L9I1hNjVMxh9D2NgCXhE0d
         4iU7lOcMMPJvhPxkDcaIBd2Lmhrpi75GtSrAuHkpN367BSt5ftlfVKump4xnRA098Acy
         vXYA9QHhAo/ZocOY0bKqbQeeISbLarbNB0PikQ85UmrygGldr8RzSrCi3RHX9LY+BHz/
         fsDw==
X-Forwarded-Encrypted: i=1; AJvYcCVZaOScIPpgoz9iwwZQQevFC+I6qjYHfP4oImIjOdBDLpoScf494Ii7htHHYeQHxQmwqIS3yH+MR4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwH+ifxOlGqN1k7df5EJXs9h4nZWjNPPjnTwT9fv+YasF0JKhL
	Q4lefOHUArl7tveXXYwHRoWjQQEp31qVyu7yX+7Q3UaUPIf9vdD9Mrp+/KFxRNQ=
X-Gm-Gg: ASbGncsoZaA3kVmWZDssvKm5S0UXzNLuh7j3qncVw2QInH8B1MVK6mRrq34EQorcDBZ
	vNmjXe0GTUE8ZKPvGABx3FpH5oWEvxNAcqUtxVqkVQgEBwea2rPXRaVXdXyzKp0KFB/JYA0fK1I
	xdaSyjUiXoerF13p3Ze2meKZaCxOUNhHDTp841lfp5ZO2MXZk3Ecg7cnF8pajdLe3knP5hKlQCo
	9NLU1kcYRo600WhWgX7aUk+cSkBGFKE4klq1OJEOWj0FuvtQyHXd+zkpKXel5i5Th9xaEI9z16P
	e3N2KnjA4f30TCJRIw==
X-Google-Smtp-Source: AGHT+IHZ0bEQmPtFd1W6CvhefSeqCixzp3HfBMJiNCnEg3vlhlpeMyjDXwcYqLooFaM5D0BAzvf4/Q==
X-Received: by 2002:a05:6871:d307:b0:29e:75ff:4d0c with SMTP id 586e51a60fabf-2aa066493f2mr1962916fac.4.1736372392507;
        Wed, 08 Jan 2025 13:39:52 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a912fc9e01sm6962555fac.29.2025.01.08.13.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 13:39:52 -0800 (PST)
Message-ID: <00bec547-4c33-4f59-b51c-92d1a6f0ac5c@baylibre.com>
Date: Wed, 8 Jan 2025 15:39:50 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] iio: dac: ad3552r-hs: update function name (non
 functional)
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
 <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-9-2dac02f04638@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-9-2dac02f04638@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/25 11:29 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Update ad3552r_qspi_update_reg_bits function name to a more
> generic name, since used mode can be SIMPLE/DUAL/QUAD SPI.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

...

> @@ -247,7 +245,6 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
>  	ret = st->data->bus_reg_write(st->back,
>  				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
>  				      st->config_d, 1);
> -

Stray blank line change. Probably should be squashed into earlier patch.

>  	if (ret)
>  		goto exit_err_streaming;
>  

