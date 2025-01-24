Return-Path: <linux-iio+bounces-14549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47CA1B19C
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465FF3AB974
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2A218AD7;
	Fri, 24 Jan 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUj1ESUz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624614A0A3;
	Fri, 24 Jan 2025 08:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707097; cv=none; b=LEQF08X2+7ke/NFEUo8jFfGH+ziuvEIZYDGqZc1pR1IpnVz7GZmIGuw37Hah1MNd6keTD+JFN8HP4eRJ13cO6mjYhZhV2/LBZwKlBi2fWmSce8hiLsugKTtC1jIW0ErLdFSoavb6TkoWdji/V5+VVPet3VzYBIUBS41VQ1tFx48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707097; c=relaxed/simple;
	bh=MmL7kmaawLhDE40iynIEjw8KqiRMtsTvOgNf4Im4I6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=my2rwQ81WurTz9N7r9EwV7pTLdEY9kAZrjB2TrCT4PpV5xAoBGnun31Ppuu5GD1NjON3DKMqw1I0mL1BzB23nTfz6TDT6dSl8m+nGXJnqSMxhYlm+kkAYpExFTiZDiWah9Z6cM6SqzDu+SHdlAtRIvhR1uYyxgWeWJGcPjyUBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUj1ESUz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5401bd6cdb4so1989521e87.2;
        Fri, 24 Jan 2025 00:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737707094; x=1738311894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c947JLGqv4VaVudXMzpe4eh6l66vOKPM+YrKoMHD8S8=;
        b=ZUj1ESUzjjc0CDS6aQt2r613Km8ucsCep9kTbezHSyscgJ23WF3zun43B2V9Kknj1Z
         iXSKUw9WK7SmDVaVxVCabDaXFiFqbZkK5WqfpaE2SD7v/Qbpl696ralR4eAA3f5QN2Fb
         GqeOzzHhYqN41QSEQEgGxhWBIrnlbwW3M5b8IH506wowEs4/oLxWIs9id27SY4htLCMx
         kMfq4ss4yS++9xe+OCpN0RCRCtFjIv5Qjr41lM0mO5AmPHTewB3KQq2etWlTjtY8hBtO
         EtKnSgX6YoTgStgB4/j1rR+a6FY+ZUl+tgjZdiKmI/3QqpnCEHHgI/xZwVNUH5Zt3zJJ
         Yrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737707094; x=1738311894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c947JLGqv4VaVudXMzpe4eh6l66vOKPM+YrKoMHD8S8=;
        b=jCymWTYvyYXpkMk4XgJj+/qGOCajF5gUkjv+50oe/b/BK29fxHaO7R0E9fVWuM1x5o
         DrEYK5Dz3ch6pxfovx7HdvLnupnCG15I5u9EGgn9jKRkZvRzJ9sNSeFqtAiGkNDXa2V+
         IJikvcIbrfknGVMgEf7YAQ0uucHL4N62T9e0+x6aAQZrREl59dNaE6k9acifVGxI1iSK
         LNEzHrzGZE0vJQRxJNbjPO9Gq09+UU1XCIptL6l9369ucbPkdchsyuMM0N0SkOmV9XFy
         j0+6xi9sVkCztc4Mao+SifKS5QKZlJirvXZSD82u2c41YsNJScq1MG1vWG6uYDHDZNRY
         SXDg==
X-Forwarded-Encrypted: i=1; AJvYcCXqxu7pr7pILM0PQ7Sm8EOolHsFvvlWQXCdbvm5Xo5QSls/TDz1Z4jme1drPlPoLOKwaMztR82/LwNuicI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdckfB8ilM0xQ4EKhFZvdvGdamBEtrut8nibTQAWXauHaWp/z
	tXNidx6J75WDocJESUd0tdfbW6asXWmnT7HjBOKWZQCKd3yP6Tde
X-Gm-Gg: ASbGncsDKB9uXSg6DKAcAI5Eq94uhUrwfuJRnor2eBw8tirv4NDLWn3RE9X/nQVJjH2
	SYRFhrTaaziXpW3lBcGU9oB9atWAq6NgHkcjB9LV45w4tiTcxQTzbTVB8t1Su6dbFE6o01ud5T/
	iEOVPn6DHdAQSHnwdtD81t8H3lCVDkEpyegt1daE7zh3hP9tKwllsasy74Pq34Nanw3f4GWxG5C
	DQL7guuLiOmLmaTE/clWRlFaKIbJrSQyw7OCitU4OwX7rvjGmOs2LXloEr1xckfvhqoDBs0ZGOi
	nS2m8qALCp26/cGimA==
X-Google-Smtp-Source: AGHT+IExGerILi3x+f1kptL4pRuPaktfxzQxI+YxR3rCC10a0ktRkB0AduP5w1/Vsi7e1TAska3jWg==
X-Received: by 2002:a19:7714:0:b0:543:bb82:f402 with SMTP id 2adb3069b0e04-543bb82fbf8mr3075268e87.53.1737707094148;
        Fri, 24 Jan 2025 00:24:54 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c822f7d0sm213678e87.76.2025.01.24.00.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 00:24:52 -0800 (PST)
Message-ID: <c0bff1a9-0eb1-4bb7-b607-54a66272bb89@gmail.com>
Date: Fri, 24 Jan 2025 10:24:51 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: light: veml6030: fix scale to conform to ABI
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
 <20250119-veml6030-scale-v2-4-6bfc4062a371@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250119-veml6030-scale-v2-4-6bfc4062a371@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2025 19:32, Javier Carrasco wrote:
> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
> 
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet and drop dedicated variables to store the current values of
> the integration time, gain and resolution. When at it, use 'scale'
> instead of 'gain' consistently for the get/set functions to avoid
> misunderstandings.
> 
> Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Javier,

Sorry for the delay - been a bit busy lately. I didn't do a thorough 
review but the total_gain (and rest of the GTS) usage looked good to me :)

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>


