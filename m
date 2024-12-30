Return-Path: <linux-iio+bounces-13859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F69FE5C9
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 13:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F651882247
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC0B1A83E0;
	Mon, 30 Dec 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOuI7xUm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F619F424;
	Mon, 30 Dec 2024 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735560827; cv=none; b=DaoDrD+Jk4sBMi1pOgvL48x+NY0ZX66NAMP2iwV4QvrSaVMPH8UKae4qPJ7g69FfXqKk9AqyEXXFPkchVowuPLOCLUveT4gGjsijETNjeRYnvuQlnRWN/CWDveuObiL33Vi0dAj018akmfVcsNbHkYlbqN9q6rYOtfyGuRKwmcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735560827; c=relaxed/simple;
	bh=WnfUTk2moT3ruKw2xLsOx06fKIwpiG5I/E0Cd61G6vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+G6Pj2AYjkS2e/9qZ9z0d+Tiyd/btHvYLV/x2+SL0FOMCCanecBEIAKR/DEDzKFX+ON4H5xA9QUM5l6TcW5/b8ARtzp4TaLBDIUVJZddnC1AK4pTOUBDUgdEaWCiv8PdpfRP/VZcwwBVJGGc3ZgfRMeiidhmLeOyi1HzL6R8Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOuI7xUm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54021daa6cbso9564783e87.0;
        Mon, 30 Dec 2024 04:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735560824; x=1736165624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFwdEcoMcD/TMKPSsqz4qQkSim/D2zFInGS3KJlM/V4=;
        b=fOuI7xUm0fekMa+Q0ej7L3xqV16nRw3WLSu5BBme2yJn8ONOt0JOkPdj3piLJGflW7
         cMTXqhmwB98HzWKBNBWvOFK3oS8OGC+eGwEy1NAs93yK0S2Z3CvCFS7orfrMFiRXRTHm
         0aGWo/seiD7b+udOwEu4WBh8ie9u9aeamzuCHDvjEYErozUM34RAohx4ZUIfK0ys2c8E
         61150kgGnxBnsurnWQm+g5jPjjvDwUyvEGyTq/WcZ/xH6zBgq5KbznBCTKNmy/4qEQoz
         6penwMPtVKBhABeOGhZ5e26BM6LRWTgvhc0pCrrQwX9hrav20wsTx4RPbqJUxiSGd5gd
         dzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735560824; x=1736165624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFwdEcoMcD/TMKPSsqz4qQkSim/D2zFInGS3KJlM/V4=;
        b=er9o9g0iycURHEdVuWw0Ybi9ubHc4Po0JXGP2C5wXHraWt8E9S+7A2p7oiSXqnwDwV
         4CoCDibrpOljqbFVUHH98WwJIVYwqNiNhC1EbEtAcxaaoVXD2VCKLS6Xd/zEr8CQtbgz
         oDIhPN1ZxtNr6f/ocdKXcOi2cr7eOm+9bILIcCGdrVzn1PaV4Xn8ayB0N/gjrJbL4Xq3
         5oHkW6/y0Rdarwxl5MSIMvqbgMhtFDqZ+q3IgnpEtXQLWSNqxpDjB9AMk9szlATXUC0G
         ZUaDZ8rMqbiNklFHOHrnJGw3AuP/KylBcx+5v7BtVySk+fmHuDpvSbf1T6yEpGL/aI+1
         o7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXcBtQtYgO/fHP4PuHBgYRTyM/tlVNanme4RaFcpGkZ3bF2aX/APIgnd3OsDruwUVj57Z+5yLaHluyjFzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYd0JaM5Z9Dbwe5KXo0/2m+67XCYyO1jtzZ9Zz0bno4dHh4djr
	8Dvp6O8DbAPYESIe9d4IqdhvZvNmKk7UfZXI2OkZOxOBSTgQCfxs
X-Gm-Gg: ASbGnct6P79w52DzQkdcuQhJUigFvayKkBy1XE6SIZ5SAVkNAQ8jDszJbI2ZCyH5phI
	5V6LIRpn52hUXDr8QQ3fNMCSSXhHYzDlwQI9CpFUakp6hoh1NblJQsFtdVG1vfb57vXsNeqWwl1
	ijq/6kCpF+JQmxUtBdu14eVTPpXdIf+qdUrNs5iVp8pDN+PQCn7qBi3k5fNEkDuMkhkO/7T+DS2
	r+KpOmRtDtHf3CCZjXP5WMSjaFq+t65iG0VaaMwiHpWDKqz1Xtm3Atqa0Qgk0hIghRp15B36gMv
	PsEcDts6QJGaDmVXWWzrfy6tGLpBpSY9O5E=
X-Google-Smtp-Source: AGHT+IGK8gpRDA7Xwi78Iqeha9ewaZVX2tA/Q9bW9Or+WZQse96G/4rJTjrf+sN9XEyOCC2AGpxwzQ==
X-Received: by 2002:a05:6512:6411:b0:542:29a8:e8c7 with SMTP id 2adb3069b0e04-54229a8edcemr11927495e87.3.1735560823405;
        Mon, 30 Dec 2024 04:13:43 -0800 (PST)
Received: from ?IPV6:2001:14ba:419:b800::7? (2001-14ba-419-b800--7.rev.dnainternet.fi. [2001:14ba:419:b800::7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-542235f6151sm3093751e87.1.2024.12.30.04.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Dec 2024 04:13:41 -0800 (PST)
Message-ID: <a83c2a6d-655a-45c1-87fd-a233fabbea82@gmail.com>
Date: Mon, 30 Dec 2024 14:13:39 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: veml3235: fix scale to conform to ABI
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
 <20241224-veml3235_scale-v2-4-2e1286846c77@gmail.com>
 <b5aa553d-fed4-459e-bbe8-70b9b9b39cbd@gmail.com>
 <D6OY5V93Q2YC.S61HE5A0GMO1@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <D6OY5V93Q2YC.S61HE5A0GMO1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/12/2024 12:01, Javier Carrasco wrote:
> On Sun Dec 29, 2024 at 7:53 AM CET, Matti Vaittinen wrote:
>> On 24/12/2024 12:59, Javier Carrasco wrote:
>>> The current scale is not ABI-compliant as it is just the sensor gain
>>> instead of the value that acts as a multiplier to be applied to the raw
>>> value (there is no offset).
>>>
>>> Use the iio-gts helpers to obtain the proper scale values according to
>>> the gain and integration time to match the resolution tables from the
>>> datasheet. When at it, use 'scale' instead of 'gain' consistently for
>>> the get/set functions to avoid misunderstandings.
>>>
>>> Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>
>> This looks good to me, although I now think we made a mistake with the
>> naming of the iio_gts_find_gain_sel_in_times().
>>
>> The intended use is finding the gain and time (selector) for the new
>> scale (while preferring keeping the time unchanged if possible), right?
>>
>> So, in this regard it'd be better to use name which reflects the fact
>> that the function finds gain and time for given scale.
>>
>> I would now (after having to look the doc of this new function while
>> reviewing the code 2 weeks after reviewing this new function :rolleyes:)
>> name it something like:
>>
>> iio_gts_find_gain_time_sel_for_scale()
>>
>> Well, it's not really in the scope of the review anymore, but I'd love
>> to see a renaming patch while we have only one user... :)
>>
>> Anyways:
>>
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>


> Thank you for your suggestion, I will add it to v3 as this patch and the
> one that introduced the helper functions have not been applied yet, so
> we don't need an extra patch to rename the function.

Great, Thanks!

> I will add your
> tag too because I will only change what you suggested.

Sure!

Yours,
	-- Matti


