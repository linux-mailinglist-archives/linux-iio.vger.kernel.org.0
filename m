Return-Path: <linux-iio+bounces-12189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B18289C64ED
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 00:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A5DB2D14E
	for <lists+linux-iio@lfdr.de>; Tue, 12 Nov 2024 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E80219C8C;
	Tue, 12 Nov 2024 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ts/mEbFx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EEA212D05
	for <linux-iio@vger.kernel.org>; Tue, 12 Nov 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441733; cv=none; b=Istr2PPLVdOPINMTCLAUWqpLDBQNcE2HGkUXY5j2AtYk6Hil35QrsA0dgMft/fyNE+8MuLKN7i2sN2z8X2AZN55uyilae/XFN0VLBegGcBFvNoFUT6DV7Oi3TxiSVGubaWlcbJyQtp7Qh0tfc2lR4nO/sOytP4lOrMw8VRzWQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441733; c=relaxed/simple;
	bh=DsjL5XWtMu7LOlZcx8scvAGiiIKiZ9tDUiuwStI2eok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oZrRd++xsdfsVUBVogHkUjX2Z4S3Tp85vRgvRQbWHzuZ6GgsOhNbom8shLHtNtSmCGU+rquwKsD6Rb6s/+kjowN9SbsK//igQOO2KSl6srFJAkJuTApGuqqPqLq3FEdK1+3O3rEPX5ssuDB2F/Kxu248sfZM/Z+lBHkPVBpJCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ts/mEbFx; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ee763f9779so1399836eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 12 Nov 2024 12:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731441730; x=1732046530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7sig4extPJZ96lJvrKPLyrOLWEJSmKbg3dopfHgQP/c=;
        b=ts/mEbFxY8PajthwxUh0SHvXAjC9tAF3NkrqRnP0XeLjkumrBKov8OYfg6+Rz76+C3
         gq2QcSd+T4V905cGYxU1wlMsaXIlTXgXSJT9tcv3nX1BOdhnZQrLpwOIp5C3kvIQhauH
         Q/Y+bMo/fV9SnWxH3TUiTRetqIUgjnG4Bag9n/iXNNc+gPgqqtW2SR2xb7365Kn1A7bt
         iiziYyv2LXIw19KIUMRFWPBeqBQ8gv6l8uKtwCfxy6vy8S+jdq7+9CTiVqjuUd5iGyLm
         ZyPBcQwV0+PABObdLkMVqy5R5sc0MyufZeQpxERWhyRRqCzc7goyPhLDDg2XFMltHhbP
         HfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441730; x=1732046530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sig4extPJZ96lJvrKPLyrOLWEJSmKbg3dopfHgQP/c=;
        b=rhxT56FyFGaB4nuppqCIfrw9e2gc+yZ/Fup1wpASG+O8L/vH62yQe1vIygNPSROCpf
         H/Niy6MGx8KsBNAHqFkyJtAMim3eXpFPz6SoAU2Qn3fYDYQT4PnKKoqv3GxZHjCEOei1
         YNrt8BoDakVmcC5ezkhB/zeOrZqv+SMVh1k+WyQ2eTCAdeRTHWHmDXzisaN7fHlPrhVW
         no1xD7ugkonnBwiz26yf1o+4/ml2Hfztd9hZY0sj8kuR2Oyfnl9GHew7yMcF9KGwxSRx
         7hcSd7e+6yCS1oj14AzL29a9uNvL5CJWRVg3a4EeqiaHxQVJhF549cmBlzCNNwcgOfD1
         gBlg==
X-Forwarded-Encrypted: i=1; AJvYcCWQoUsArqa/isgOyyPyILuYUPwQDwLWCRz2zGFjHXG/1pzzurYYuWOO9UdSIV01REq136BjEZmcrjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdwaz5EoChan/edSzOogMp+2FfWs+VCxWexQYektqZEvdtjczV
	Qy2I8EIF3ar9h6NDlSbco5LPYXSb3puhP8SwhLwNJpQwIpxX+NqarMJiA7AGQG4=
X-Google-Smtp-Source: AGHT+IHvgnmHiHHXULfY05GGiY7fOLLPMb5a5l/JeZR/daEqHCvkzI6U/0uYYnu+Fc6sEEFJ3gXDJw==
X-Received: by 2002:a05:6820:4c89:b0:5eb:821c:df23 with SMTP id 006d021491bc7-5ee57b96a9bmr12114816eaf.2.1731441730645;
        Tue, 12 Nov 2024 12:02:10 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee494fb9a2sm2503376eaf.1.2024.11.12.12.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:02:09 -0800 (PST)
Message-ID: <4b48ae8e-4eba-4d86-af8b-2b749c53639f@baylibre.com>
Date: Tue, 12 Nov 2024 14:02:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
 <20241111121203.3699-9-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241111121203.3699-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 6:12 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6 (implemented most of the review comments in v5):
What is the plan for addressing the rest of the comments?

I don't want to keep making the same comments over and over again.

