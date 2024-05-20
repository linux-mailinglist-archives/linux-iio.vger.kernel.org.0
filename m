Return-Path: <linux-iio+bounces-5139-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D353C8C9905
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 08:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667D01F2150D
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DC717991;
	Mon, 20 May 2024 06:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="d2UwD8tg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02245DDC9;
	Mon, 20 May 2024 06:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716187828; cv=none; b=rzVexpjhGxrgo+y4wbU12HtY1u5YVlnU+Gu/+G6PU6udPuFtgM69Jmuony6n54zl0QoDPZLo3YZf/B9xW0W67MKUrWThU+I8K5q6xR1YYZZVR3zp3TSSvwozvJVB2FTKigcfZnflljJ8Glo8+H3F57lR/V76Z9IPPFnhiz8GMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716187828; c=relaxed/simple;
	bh=yoH8oeBLT5Cu51w1sJjng5xImPIsD2a4dU6lBCLq7rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcrzZBfDsBj2BmIcPqqFn7IUYNpm5pg4OTvQ7SFd8KfOVYT5P8LfwmCejVcQea4gaylNjgF0fpcqiZHYkGFoRTyCASDmbn9hro+S+dbW8yi985JiB/7QNu5x9x3jG+AahPHG2jpc9SGPUWtJoQB0ppqyLWo3eblWT1Pw99u5VXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=d2UwD8tg; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 8wqjsLlFYNQ4U8wqjss3lc; Mon, 20 May 2024 08:50:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716187821;
	bh=jpxVqrtviSVUp8X0CW4K+jbJq11ePR7iU9EMfMGgpms=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=d2UwD8tg+nBA0iqIBmIfM4nZLjJAxII/pRMAcXwnF+5352+pyr4KaS3+W9pcNtpxj
	 74iqtSNiVSNsT+ApcJfrB86g0CS0pI8oyl0bwkdJiTXSiJ+jNAaq+j3Vi/Vh9uKZZG
	 7Pv9yxvf0gDTzLb6PDjNRzbA8TVrjRrmJzex9/NOHJgfIUY5XCfsn89k9j6PbpFXBt
	 TcKCUTEyav8cFxcX/C2Mu3ZKwRKU4L8B+IyH4HHGmY2+4dz+/gKBzT/ZMCdko5esPq
	 Dq/VIM5hkBDaPPQ312JfMKPqoxaA1tZChiRe5fn+wLwvPY7r+oxS63uL/yC1C1/l0s
	 Dwbf6J4ee38QQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 20 May 2024 08:50:21 +0200
X-ME-IP: 86.243.17.157
Message-ID: <f2b74e41-45d4-4efd-9a16-df763987a7fe@wanadoo.fr>
Date: Mon, 20 May 2024 08:50:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] iio: chemical: ens160: add triggered buffer support
To: jic23@kernel.org
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 gerald.loacker@wolfvision.net, krzk+dt@kernel.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 Gustavo Silva <gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
 <20240512210444.30824-5-gustavograzs@gmail.com>
 <b8775460-5519-4294-9218-d8e814e05305@wanadoo.fr>
 <20240519150351.6c248b1d@jic23-huawei>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240519150351.6c248b1d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/05/2024 à 16:03, Jonathan Cameron a écrit :
> On Mon, 13 May 2024 21:13:07 +0200
> Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
> 
>> Le 12/05/2024 à 23:04, Gustavo Silva a écrit :
>>> ENS160 supports a data ready interrupt. Use it in combination with
>>> triggered buffer for continuous data readings.
>>>
>>> Signed-off-by: Gustavo Silva <gustavograzs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>
>> ...
>>
>>> +static irqreturn_t ens160_trigger_handler(int irq, void *p)
>>> +{
>>> +	struct iio_poll_func *pf = p;
>>> +	struct iio_dev *indio_dev = pf->indio_dev;
>>> +	struct ens160_data *data = iio_priv(indio_dev);
>>> +	__le16 val;
>>> +	int ret, i, j = 0;
>>> +
>>> +	mutex_lock(&data->mutex);
>>> +
>>> +	for_each_set_bit(i, indio_dev->active_scan_mask,
>>> +			 indio_dev->masklength) {
>>> +		ret = regmap_bulk_read(data->regmap,
>>> +				       ENS160_REG_DATA_TVOC + 2 * i, &val, 2U);
>>> +		if (ret)
>>> +			goto err;
>>> +
>>> +		data->scan.chans[j++] = val;
>>
>> Is it safe? How can we know if it has been only *partly* updated? Does
>> it matter to know?
> 
> You've lost me. What do you mean by partly updated?
> This won't push anything to the kfifo etc unless all succeeded.
> Or is there a race with something else in here?

Forget it, I misread the place of iio_push_to_buffers_with_timestamp().

I thought we were going through it when 'goto err'.

CJ

> 
>>
>> CJ
>>
>>> +	}
>>> +
>>> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>>> +					   pf->timestamp);
>>> +err:
>>> +	mutex_unlock(&data->mutex);
>>> +	iio_trigger_notify_done(indio_dev->trig);
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>
>> ...
> 


