Return-Path: <linux-iio+bounces-8480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD6952306
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 21:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44AA2862A8
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777081BF315;
	Wed, 14 Aug 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZD9PQQdV"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953B6B679
	for <linux-iio@vger.kernel.org>; Wed, 14 Aug 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665581; cv=none; b=PzUL912/63YCVzAphUSHTJv7FgUvt7IFTSqJGJAOSszw0aVH6/CpVykXo1Yadx8kxJR08J9f+jEnTbJwhxVWqlLtGJYdro4B2YJm0c9F+W9jwSCDh8m9v1eEb85a/6yP9teDgiVqD1vs7sPE5IPTwNnNgR4kbQPWxxi8IbRtPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665581; c=relaxed/simple;
	bh=QmrgaxSMKil5DIS2QmXxaYCQCOFoeghgHZ9rBVGDDXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BNbcYN8BnccARiDJrOOUl0h5qEqFcTFSWsBOYD9kEvxZV4wO0P5zGK9ccwB6R1uQgVmqZ7HYfm8wP7IxdjytgOeYY4wXmlDd8C1Kp4bGZFsPfC1WxNUzyMUDpT+i0VysZgwr+C6JdlMQaiK/wR5qcJyA9lAeo74Pi1KIKnUtaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZD9PQQdV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5EC318899D;
	Wed, 14 Aug 2024 21:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723665577;
	bh=ct7TeOXmO5Nd7v8ANEkmne4h/H1llFUOu8okA1RSj1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZD9PQQdVt+wxs8e/l+X2ZCgwpC/sFXXnZJDQjX1dvcxgqO5H3nERV3qLtWfi0Gfob
	 vQjhDWxAN1uoGyuz3B4cBY4gjXsWFMwHlr/nRpZ3gqC9o8oxTOF2Mc4DBPzvo+/7gz
	 FtJ3sz1WThMQQbM8YEUOPvJag7x2/ZPq/uoO/NHLZ3oLBCJyv0OkzWSKP70eJP/Iz6
	 faDUVyZqRGKnZGKFOhELWp95JDiWWwboVu9OctsrDAV7QVjELB5706etWoXZoGYTZd
	 KqvzHc9jduMerwAgvIw5gNBcNMmewIbu0IC8kci7iTJhvzCz1Q4mhqP+kDSxm05hKZ
	 kFrXmneluCNBQ==
Message-ID: <4f51d5bf-f603-4d74-b297-a465697e4e92@denx.de>
Date: Wed, 14 Aug 2024 21:53:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] iio: light: noa1305: Make integration time
 configurable
To: Jonathan Cameron <jic23@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-iio@vger.kernel.org
References: <fb9734ff-5029-4855-971a-3dc734881b4e@stanley.mountain>
 <20240814195844.71f6ba35@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240814195844.71f6ba35@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/14/24 8:58 PM, Jonathan Cameron wrote:
> On Thu, 8 Aug 2024 10:12:12 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
>> Hello Marek Vasut,
>>
>> Commit 025f23cfebad ("iio: light: noa1305: Make integration time
>> configurable") from Jul 15, 2024 (linux-next), leads to the following
>> Smatch static checker warning:
>>
>> 	drivers/iio/light/noa1305.c:201 noa1305_write_raw()
>> 	error: buffer overflow 'noa1305_int_time_available' 16 <= 31
>>
>> drivers/iio/light/noa1305.c
>>      183 static int noa1305_write_raw(struct iio_dev *indio_dev,
>>      184                              struct iio_chan_spec const *chan,
>>      185                              int val, int val2, long mask)
>>      186 {
>>      187         struct noa1305_priv *priv = iio_priv(indio_dev);
>>      188         int i;
>>      189
>>      190         if (chan->type != IIO_LIGHT)
>>      191                 return -EINVAL;
>>      192
>>      193         if (mask != IIO_CHAN_INFO_INT_TIME)
>>      194                 return -EINVAL;
>>      195
>>      196         if (val)        /* >= 1s integration time not supported */
>>      197                 return -EINVAL;
>>      198
>>      199         /* Look up integration time register settings and write it if found. */
>>      200         for (i = 0; i < ARRAY_SIZE(noa1305_int_time_available); i++)
>>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^
> Good find. Should be ARRAY_SIZE() / 2 I think.
> 
> Marek, spin a patch?  If not I'll get to it soonish.

Patch is posted:

[PATCH] iio: light: noa1305: Fix up integration time look up

Thanks for the suggestion, sorry for the delay.

