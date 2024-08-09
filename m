Return-Path: <linux-iio+bounces-8341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06594CC7F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 10:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 670A8B23199
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 08:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D436D18E047;
	Fri,  9 Aug 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KqDbKJrY"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-216.smtpout.orange.fr [193.252.23.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1E719046B;
	Fri,  9 Aug 2024 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192990; cv=none; b=taT6F9AvsiEFbSYtJNE/EaIfduHgPTgRxO1L+yvqbiUXl/3Hm5LrJTBJO8Zyd6qewID6Pt8wKgDjC/mCgP3pIxk/fdZnQ8l+gGIK9im5eXu1H2F/L9SzHArbNDub0nfwbvNJSdooJnZzVChYkO9Eg68MJxAi4UzIz38RwyImpnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192990; c=relaxed/simple;
	bh=cVZzpsIzNEExCRX7vCdguvjsc/4A16/eADuKXY/emNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2apsOe2A4KQuBZXmuDtpWAm9l9k2DZVGQ1aC5E9tICbcM9FJunEV4BaB/Uah+Y4BGIrSloosoC5Nvkp/Sk/Rvb5/V7Js4DE96SJlpLXXPhILq/U7kkB4NAGiifWJld1bM07TRWnqG0GwjDdPl1tdK65i4q82LgaklmvESm+UDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KqDbKJrY; arc=none smtp.client-ip=193.252.23.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id cLC8sXuDHnYGvcLC8s91Nj; Fri, 09 Aug 2024 10:41:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1723192916;
	bh=jAQcaYCpLLbCCL6sptornWQTy8rq1Ocj8UUsl9janU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KqDbKJrYvwCIEkfIVbRrv5+upid3bGVtGtvUnqrNhatShyytX8B0MY3GgIB3r2Ew5
	 oLBBwmi1Om+z+fairEWM/YUliO2xDb5ZI3UQ3rvWK6O3h8GycyOo4sMtG+4UgSSKzB
	 DglyOV851VNJkjIYiCUzQ/Qf4kHrLZkBgicAkkhfcUMdT2mJFcCnY9SnuU/T8PREt9
	 SbcO+WQQnYy7sK8iP40MqBYQRQGi7rYgRaIJP/MvOgoWiSohrNXuaHK3CRMuvrIECM
	 Jo9EKErmMwbDe1+lfDwEW9qr5a93oYtAQx1UQfzZpFg23wG4sIeaseQCieqQC7eCEP
	 LyicOmIIucU7g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 09 Aug 2024 10:41:56 +0200
X-ME-IP: 90.11.132.44
Message-ID: <93f18533-da95-4f29-b6d9-8b8337a4cc90@wanadoo.fr>
Date: Fri, 9 Aug 2024 10:41:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: pac1921: add missing error return in probe()
To: matteomartelli3@gmail.com
Cc: dan.carpenter@linaro.org, jic23@kernel.org,
 kernel-janitors@vger.kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain>
 <36b1a47a-7af2-4baf-8188-72f6eed78529@wanadoo.fr>
 <66b5c5df76766_133d37031@njaxe.notmuch>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <66b5c5df76766_133d37031@njaxe.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/08/2024 à 09:31, Matteo Martelli a écrit :
> Christophe JAILLET wrote:
>> Le 08/08/2024 à 21:28, Dan Carpenter a écrit :
>>> This error path was intended to return, and not just print an error.  The
>>> current code will lead to an error pointer dereference.
>>>
>>> Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
>>> Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> ---
>>>    drivers/iio/adc/pac1921.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
>>> index d04c6685d780..8200a47bdf21 100644
>>> --- a/drivers/iio/adc/pac1921.c
>>> +++ b/drivers/iio/adc/pac1921.c
>>> @@ -1168,8 +1168,8 @@ static int pac1921_probe(struct i2c_client *client)
>>>    
>>>    	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
>>>    	if (IS_ERR(priv->regmap))
>>> -		dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
>>> -			      "Cannot initialize register map\n");
>>> +		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
>>
>> The (int) is unusual.
>>
> The (int) explicit cast is to address Wconversion warnings since dev_err_probe
> takes an int as argument.

Ok, but:

1) With the cast removed, on my x86_64:
	$ make CFLAGS="-Wconversion" drivers/iio/adc/pac1921.o

doesn't generate any error.

2)
	$ it grep dev_err_probe.*\)PTR_ERR | wc -l
	2

	$ it grep dev_err_probe.*PTR_ERR | wc -l
	1948
So, should the cast be needed, maybe another fix could make sense?

CJ

>>
>> CJ
>>
>>> +				     "Cannot initialize register map\n");
>>>    
>>>    	devm_mutex_init(dev, &priv->lock);
>>>    
>>
> 
> Thanks,
> Matteo Martelli
> 


