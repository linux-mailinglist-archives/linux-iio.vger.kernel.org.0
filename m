Return-Path: <linux-iio+bounces-13746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F49C9FA5D6
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F05165DE9
	for <lists+linux-iio@lfdr.de>; Sun, 22 Dec 2024 13:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B718BBB0;
	Sun, 22 Dec 2024 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgReYwAp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21776DF59;
	Sun, 22 Dec 2024 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734875003; cv=none; b=NQ+GnpPuAcXmTYl7XZWTXSDZo4pMGmLIVaoExk2AYHln6n8fAQe6kxyr5nH+PBxxwLKBNrMrVZfhqmREtP1usPVtfRKBaKF9AzLNQXA9sXLX/3IQxUIW7duJ01u2A5G5IW87mGssZWGkQZpkcUq8UZinDxC9UYy2ZtNI8YCbva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734875003; c=relaxed/simple;
	bh=G9imd+iA9kHRb+DBYh9NANm/BWiCONSCMECmPZW6D30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J3KcGwHp1MvFx2enyrh2i9faxOwzmQX4mfGwFV+DqHsdbmSO/JzVfVeBUbpSU1aPD6i9peAJMvC4toc8UmD8kKgvZN+JX37ERzxMqX8wWPcyux7kHBq1oC+YOkU3UW17KEGrQU2iUCXOFIb/SVIcCr9AltLl9fYfVUEWeLr1s2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgReYwAp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54024ecc33dso4139723e87.0;
        Sun, 22 Dec 2024 05:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734875000; x=1735479800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E+OsrQJ5DyfLI5uNYUCyaDPO/PwkowKSRKwEAX2mzqY=;
        b=CgReYwApEWnPFoT4cF/T1wUV5tigialgcJAlafx0p/2KKiI5KBxoqgDzhXcyhYImRL
         9Xpzf7PyPVBsKuBAdYnbvr49KK8Gt4dMSiO+6SYxf4t0QsVQDN5itC2Wa6Q/EBMuGHyq
         RfUtcEyteWS1/pMIXWT+g8+s+3wYe3AAsK39sp9kn4k9Qjxi0cFeg/KtmBI2lNIAuKw8
         Tnucf4EpLtqZaAnojU7dT7Q6UQUd9ioOKHuM2EN5+Poursb+IAT4cDmuQauDhY9yKOuf
         4/BUQ3RvVW6kribxaISMcPgrUzRQTpKOl0wXrZ2Sc37MxAOsfBZIkD9GrV6UFLTFOLPH
         9ZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734875000; x=1735479800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+OsrQJ5DyfLI5uNYUCyaDPO/PwkowKSRKwEAX2mzqY=;
        b=K/HsRhUc6Grdz24PdD8K11Yu278gM/V6JgxUr7PKhdETMdEDchrPSG7kG/PMqaxR8h
         MmssTgIeaNZpMEoeS1t5lGcisvok/HLvCoEBSJfXLH9Mt9oyhGWeKjVFB9vqnQ8jsq2K
         /Qj+8HldQ0dgmjxqFdLNzzNK7tWmpkmz5r2zZwQGLoJnCApnC4JkNyNv/5Tv3kw2skAA
         pziYzQjI3IIZ23Jy3VSxr/JMQgsnl88IRDV4kagAJlm++YkBV/SQfbngslC2CwV5ZwYk
         WSdmpd9Y6KrY2a07jSlBpkahD6L8L8wkwLMe7K6zXhgG68W1/duz3A1z5QUx/USImuvQ
         rwig==
X-Forwarded-Encrypted: i=1; AJvYcCVzeEK0ciw4ZOQOXMOT5Ca0XeX5yTa0zIThAiGwrTm4HQ4D+C34g9wxeurcauwIuRKfMXZv9LhHY2NCngE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDhZfygcVWCqNoT/gA/kczDglRWuX0FJRqcGWfcUPcPftClL8
	twtoSBsnLuYBtCc0ZsGuH8YmWZ0WWSsClEPdRYVeFyn+RAnuym8y
X-Gm-Gg: ASbGncuOud58HBCGFHpoiUYtKsHDeI5gbeRjD+TWHyJspien6cOf7NW40LYt4nfwt7O
	D0jJQTt61xRE22ouzdMyocBfdUev/8mhnfdIlDUBiwFltiBlDa03NEv7zpXszW+wG8kgME0OTsW
	sB47/V9wQPvHOqfW8L6qNAi9eAZyp4nJ3kOFbJe0L3V98qiaM4XrV5qK0//x3mfxpibQsA+TuoM
	3OCFhjovOekcCk+XnX6zX54QQE9RsM7mf/cSSBMiSxAaCYn0BUOCjGZQPOtXAkJY3zYOZO69tD5
	rEkLM3lUv5TMsG/ZSH+nszhEQfZv7nZKmyE=
X-Google-Smtp-Source: AGHT+IGYiXzzrzEhNciKAoXvfqSYGjU6xF5SjOmegUJoqNZ2o3FgA7CkARjtUB4G8C8kgdUWkNsjzA==
X-Received: by 2002:a05:6512:3d04:b0:53f:22f5:afd4 with SMTP id 2adb3069b0e04-54229597d3emr2933741e87.52.1734874999966;
        Sun, 22 Dec 2024 05:43:19 -0800 (PST)
Received: from ?IPV6:2001:14ba:419:b800::7? (2001-14ba-419-b800--7.rev.dnainternet.fi. [2001:14ba:419:b800::7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5422383586dsm944325e87.283.2024.12.22.05.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 05:43:18 -0800 (PST)
Message-ID: <b4b8ab5e-7b94-4919-98a4-1525be903954@gmail.com>
Date: Sun, 22 Dec 2024 15:43:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: veml3235: fix scale to conform to ABI
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
 <20241220-veml3235_scale-v1-2-b43b190bbb6a@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241220-veml3235_scale-v1-2-b43b190bbb6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2024 21:28, Javier Carrasco wrote:
> The current scale is not ABI-compliant as it is just the sensor gain
> instead of the value that acts as a multiplier to be applied to the raw
> value (there is no offset).
> 
> Use the iio-gts helpers to obtain the proper scale values according to
> the gain and integration time to match the resolution tables from the
> datasheet.
> 
> Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

...

> +static const struct iio_itime_sel_mul veml3235_it_sel[] = {
> +	GAIN_SCALE_ITIME_US(50000, 0, 1),
> +	GAIN_SCALE_ITIME_US(100000, 1, 2),
> +	GAIN_SCALE_ITIME_US(200000, 2, 4),
> +	GAIN_SCALE_ITIME_US(400000, 3, 8),
> +	GAIN_SCALE_ITIME_US(800000, 4, 16),
>   };
>   
> -static const int veml3235_scale_vals[] = { 1, 2, 4, 8 };
> +/*
> + * The MSB (DG) doubles the value of the rest of the field, which leads to
> + * two possible combinations to obtain gain = 2 and gain = 4. The gain
> + * handlding can be simplified by restricting DG = 1 to the only gain that
> + * really requires it, gain = 8. Note that "X10" is a reserved value.

Just a question - do you ensure there is no "invalid" register values? I 
think Jonathan has prefered doing this by writing known initialization 
values at probe.

I *think* the GTS should survive cases where multiple bit patterns can 
be used to represent same gain/time - but I don't remember this for sure.

I didn't have the time to do a proper thorough review - sorry. Still, 
what I browsed quickly looked good :) Thanks!

Yours,
	-- Matti

