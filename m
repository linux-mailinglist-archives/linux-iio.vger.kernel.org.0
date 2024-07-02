Return-Path: <linux-iio+bounces-7144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF413924222
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 17:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5231B1F257EC
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 15:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C01BB6BE;
	Tue,  2 Jul 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFieF6Mj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13E1BA868
	for <linux-iio@vger.kernel.org>; Tue,  2 Jul 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933469; cv=none; b=qfsggttfx0u7d0+7EKmxWAoc/m0RuiwdQEeCFvvoJeAsXbaDIQpSiKVoW/S0Qgk0rUxIgIYSkHKbVCENClNhuxO+gE31vE+Mdot8U+x9H1QR1LTsNo8OMfb4yhGRTyQOfks0nmrvO7drkRExDfyGsTzktWu8NP7ZU1f8pK2zVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933469; c=relaxed/simple;
	bh=3wDIFCAzKbdD1ksTvoWBNG0yjG8Qu9cMJgzmdSkfLB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihG1x0kd9bQqFE2DnyrzKO8CupvqzuSjEp0uHpvI/rj65zT0Wwf0WBTtBu6CgML1expwZvW+RAF1Dkak3dnOylAp9LMXzyjwIT+iN3MUFGfXS78DcxpJkGMGIbLhu7GfOZTS0IaKRKDlozTsXecP2FRmQPhQZUTBnNL19yNKWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mFieF6Mj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so43408911fa.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2024 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719933466; x=1720538266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aZRAFSNKSFYmWaUZ7KXx9d6xaTURsdAXc42X/QTnRZk=;
        b=mFieF6MjEIEhcRLd1EOERuuQl+gCUEoCScgt8a7JhwOwnnfX4qOwPh6TVeHEargfvL
         xjKUm2DsqixatTZa4ghGI1To6EM7KvnSU2bIIBOEgqRmLVT7EWI87s8bxpHv6IcPe+G3
         kygn5D+uBuszxucXZxTgPzSl9PqxqoVbvqrFTKEGaj1NG7Nn+m6Xxa71c0ZI2NNczRd5
         brsDv7DJCKGUGMtl16UpbxnXJFq1wAjVp7qL1fuwO106qs5rY/Ken2wwe++gqmAW+HXl
         RH+SKWaHB7M+4egfxHGObTeTi9sKJ7ZQ29idLNcYzYRjQtX/hQ2ITnb7mpTupyiE9vHm
         qIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719933466; x=1720538266;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZRAFSNKSFYmWaUZ7KXx9d6xaTURsdAXc42X/QTnRZk=;
        b=bOGPPz9h1lecqA2UYnn42odbH3Ga5krsCjCL2HlunkmcIS5LtKotfbd3VKFONXL4ib
         xJYiFxdJjgNER2AFnqtmd42FlFlk5Ta7oVtZpUcvASS4oTecpUqegsMsVrk2bkwZqNGH
         cXdl1qduwsiq9fNpV/4MYnVEQM8sxiXdTyNx0oTdd6JV6CBy5+MjglzPK30NX+1tzUiP
         BiH8lNOumaDLeABj4l0OHJfspkXBzMpowtSUZpLQ2Y1QSXEW2Ff4VacUWAgQVWD2B/tM
         hfFO74uAN5CAK0mKcqAtBzFA/c2Bb+anF3ur+q0ydICID9l88XroGZxXT4qI/RTmnv0Q
         JCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtcKBbx+MWiUwqeRCg/knPpenpaffoeGcg03pKELtv3jKhvYPEnn5CIHkVScs+BfDbfHki8ScLLkfb+YGJ0BZ3gPdOPfWWLgqd
X-Gm-Message-State: AOJu0YzdSfMRqoJUrKWoZ5/l1agntcFDf22EWcrcRZHX4vDm4PEoPCRd
	kYg34hSB5+Q+9aszyG+wu1YNkLw6A0DqdezLEVRTBz2Xcde6/XvKYUbUeBeGMG0=
X-Google-Smtp-Source: AGHT+IFezitPqzKhwL7ebLXdTGmcGLez1EYOlORtZV6TLHR3os84t6XvnIB5st9wu/KN8fh2boz0JA==
X-Received: by 2002:a05:651c:1546:b0:2ec:505e:c45b with SMTP id 38308e7fff4ca-2ee5e6e70e4mr57381771fa.35.1719933465491;
        Tue, 02 Jul 2024 08:17:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55aeasm199050395e9.17.2024.07.02.08.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:17:45 -0700 (PDT)
Message-ID: <64fd897b-f87d-4a17-af92-5c6ffb481061@linaro.org>
Date: Tue, 2 Jul 2024 17:17:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: pressure: Add driver for Sensirion SDP500
To: pd.pstoykov@gmail.com, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
 <20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240702-mainline_sdp500-v3-2-0902047b3eee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2024 16:59, Petar Stoykov via B4 Relay wrote:
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> 
> Sensirion SDP500 is a digital differential pressure sensor. The sensor is
> accessed over I2C.
> 

...

> +
> +static const struct of_device_id sdp500_of_match[] = {
> +	{ .compatible = "sensirion,sdp500" },
> +	{ .compatible = "sensirion,sdp510" },

Devices look compatible, so express it in the bindings with fallback to
sdp500 (oneOf, see example-schema).

Best regards,
Krzysztof


