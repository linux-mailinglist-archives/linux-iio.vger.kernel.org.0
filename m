Return-Path: <linux-iio+bounces-15610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACCBA3770C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7593AA65A
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4AB19D8B2;
	Sun, 16 Feb 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XaWysHzN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C919C574
	for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732449; cv=none; b=nqDUbYNOEthtjTrzTFu6bCuHCfVl/0bx2j3bSv6u07Qcpt0hrLCoPWKe3X7aJKahomUbOk/JfYAATvY/XU0t12dBye6kdg7b+anVV1fGhxL5DN9Nhb4o4MHB7Zg58EfE+35Eqj00kXOqgdk5132kgAGrVx0/M3JgVsdvhhdoIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732449; c=relaxed/simple;
	bh=nk4XPLj2vMfOsn5+Rh9CmoJtv2ZkwUvSj7f+EABpVqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSMFLCH0nW89HtpOE8nHQC7SOn/KcNIc2upFkEfs5GEi4wMKCZr4zgm9ngZNnqFgqNUuQXrluSjzR0hTdPhS2njeUuYzaavnSlECN8m0lkd1Piciz3WXfCTXIuhpF/tK6Tpo0J+IuuHHZhgm5E7owb9j3XfOsyQJp4xVh8tIcKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XaWysHzN; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2bca6017608so756963fac.0
        for <linux-iio@vger.kernel.org>; Sun, 16 Feb 2025 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739732446; x=1740337246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcVfD6Xa3G9lo1tt04Nxgx0oAC4nyMM+qAjYpd/F8ow=;
        b=XaWysHzNnpcuY/uI0rmJNrty2ciqoMviXbmwDT6uqp3qrPG4O4gGZrEzXnSq4SSnkX
         HIdqcwArRMwd25pKO78Oij1qtXAEq2vNplGebKc0tNQbEQEiZRd4OYhj35MdnsLJRJd7
         unNjtaPmvKbY1RFJKMLSCPEbKmEH44XwjPE1XVByQqHHOgCzwLg5yH4htFXRh3M+nYZC
         GMiYxkHrEBQGaIcRVBZxQibEp6OLkwhBHOF9tWeGibZ4Cx+iOCqO40hUP4Hu13Y29WtZ
         +m8M1c1/CRp6l9CbcdLzoSu4OG+YqbgE39DSAIxixtTcWv1zpYxYlQI9WZrOXGAybarG
         48Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739732446; x=1740337246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcVfD6Xa3G9lo1tt04Nxgx0oAC4nyMM+qAjYpd/F8ow=;
        b=Zs4k8YrEutwxOV9EAkxOh/d9QKbHhVQsvdoLCCRlRt6Qwdh720sMHe6R8hwRCHWnKF
         gRVsUQPFtn7jiRdcACPZsaxN7SI7qSv58ZQkYey1bykYwXIaRwmFMofRRihyO3U0Adjt
         XtMhgGgeZU71qFMLy7W9Z5665V6QH1g1Hn5EvAARXObpEl5h1VUoV3M3G6nAC2j+f0+a
         9AL4QPY5E4JgYphfeNyFYstz1gaZzyn40jhPRMrsPtMos5IchNZiyb45UF6NV/G7bfxv
         cnqyC7i6wyh2l1NJq8Qjl4acLvXdU8MLLKupeozY/amWVAD9GY1ascWdiG1t8neKp9lh
         NOlA==
X-Forwarded-Encrypted: i=1; AJvYcCXTaxLFZn1A+l1MeeLw7CcRLsO0suGlS9yCFyb0DopaoBGcJVNzsYcwth4noIQtA7KMCOpzw61nfsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZNkGSoLHhkVoY+l0BxBaiL/EB6xjKPWoKqkOFPvQMK5v68mc
	oXIT7L4KM32ZMyM0kobZRtBLn879yGgPPKIkFUl6cyj85pgYJWZWYqt7ia3NZhw=
X-Gm-Gg: ASbGnctwjUpxnIaajlcDlodChw5ClhJ8WeOesThNLkfHJlZ0ROqZi42apaYvXtGD70m
	AFUfZARX9umehFkJE5Fpy79MhNQYqW26sBLKdxC0oCBteIAtK3nLZt/346AoUZDxU36rPx71vdG
	Ltep8xP6A7hu4bxSBb2ZhSdAELyHh84edmvGq+yl6NtFTiGUvUUCkTQP0c53a/+pUlcthA8bMSS
	YPEyM+z6xpaIzqu1XGCZ/Azz12/1KN3KyH95skH4DK1GJ7JxFWxZaXoE9dUdQawQjtXiKrwUeoc
	ZNcNKQK9xf5WAqUtiij2chUZKjjRv36prURNFqnCSe6oU086zrAv
X-Google-Smtp-Source: AGHT+IFtgmYi6g/fodUnLHijtbEFjNdELYrMSwxx47OC5josAT5QSsSkYzufqQAX8o92aIhNJUcaxw==
X-Received: by 2002:a05:6870:80c6:b0:29e:32e7:5f17 with SMTP id 586e51a60fabf-2bc99d3fc88mr4044479fac.28.1739732445932;
        Sun, 16 Feb 2025 11:00:45 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548df81esm3423325fac.29.2025.02.16.11.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 11:00:44 -0800 (PST)
Message-ID: <6db4821e-9cfe-4256-a357-51a00a50d083@baylibre.com>
Date: Sun, 16 Feb 2025 13:00:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/27] iio: adc: ad4695: Stop using
 iio_device_claim_direct_scoped()
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Mariel Tinaco <Mariel.Tinaco@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Gustavo Silva <gustavograzs@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 ChiYuan Huang <cy_huang@richtek.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols
 <gstols@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Tomasz Duszynski <tomasz.duszynski@octakon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250209180624.701140-1-jic23@kernel.org>
 <20250209180624.701140-12-jic23@kernel.org>
 <20250216181907.40d36bf7@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250216181907.40d36bf7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/25 12:19 PM, Jonathan Cameron wrote:
> On Sun,  9 Feb 2025 18:06:08 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> This complex cleanup.h use case of conditional guards has proved
>> to be more trouble that it is worth in terms of false positive compiler
>> warnings and hard to read code.
>>
>> Move directly to the new claim/release_direct() that allow sparse
>> to check for unbalanced context.  In some cases code is factored
>> out to utility functions that can do a direct return with the
>> claim and release around the call.
>>
>> Reviewed-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>> v2: Typo in commit description (David).
>> Note there are several sets current in flight that touch this driver.
>> I'll rebase as necessary depending on what order the dependencies resolve.
> I've done this rebase and applied on the testing branch of iio.git.
> 
> Would appreciate a sanity check if anyone has time though!
> 
> New code is as follows.  The one corner I was not sure on was
> that for calibbias reading the direct mode claim was held for a long
> time.  That seems to be unnecessary as we have a copy of osr anyway
> in that function used for other purposes.
> 

...

>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		switch (chan->type) {
> -		case IIO_VOLTAGE:
> -			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -				ret = regmap_read(st->regmap16,
> -					AD4695_REG_OFFSET_IN(chan->scan_index),
> -					&reg_val);
> -				if (ret)
> -					return ret;
> -
> -				tmp = sign_extend32(reg_val, 15);
> -
> -				switch (cfg->oversampling_ratio) {
> -				case 1:
> -					*val = tmp / 4;
> -					*val2 = abs(tmp) % 4 * MICRO / 4;
> -					break;
> -				case 4:
> -					*val = tmp / 2;
> -					*val2 = abs(tmp) % 2 * MICRO / 2;
> -					break;
> -				case 16:
> -					*val = tmp;
> -					*val2 = 0;
> -					break;
> -				case 64:
> -					*val = tmp * 2;
> -					*val2 = 0;
> -					break;
> -				default:
> -					return -EINVAL;
> -				}
> -
> -				if (tmp < 0 && *val2) {
> -					*val *= -1;
> -					*val2 *= -1;
> -				}
> -
> -				return IIO_VAL_INT_PLUS_MICRO;
> +		switch (chan->type)
> +		case IIO_VOLTAGE: {
> +			if (!iio_device_claim_direct(indio_dev))
> +				return -EBUSY;
> +			ret = regmap_read(st->regmap16,
> +					  AD4695_REG_OFFSET_IN(chan->scan_index),
> +					  &reg_val);
> +			iio_device_release_direct(indio_dev);
> +			if (ret)
> +				return ret;
> ////THIS IS THE BIT I WOuLD LIKE EYES on.

Looks fine to me.

> +
> +			tmp = sign_extend32(reg_val, 15);
> +
> +			switch (osr) {
> +			case 1:
> +				*val = tmp / 4;
> +				*val2 = abs(tmp) % 4 * MICRO / 4;
> +				break;
> +			case 4:
> +				*val = tmp / 2;
> +				*val2 = abs(tmp) % 2 * MICRO / 2;
> +				break;
> +			case 16:
> +				*val = tmp;
> +				*val2 = 0;
> +				break;
> +			case 64:
> +				*val = tmp * 2;
> +				*val2 = 0;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			if (tmp < 0 && *val2) {
> +				*val *= -1;
> +				*val2 *= -1;
>  			}
> -			unreachable();
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}

