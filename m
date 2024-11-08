Return-Path: <linux-iio+bounces-12015-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB159C165B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 07:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5508EB23394
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 06:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C769C1CF291;
	Fri,  8 Nov 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="G/44vCKJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F761FFE
	for <linux-iio@vger.kernel.org>; Fri,  8 Nov 2024 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731046413; cv=none; b=HXHDS+rmrhXO2QEPbC9Voz+4TWfPEpmnBTSB84rzsG7dVzrtOp7ZleyC/1BwXPWj+z4+Q0OoRmcimQPLdJX22flbORtGQGe1TQwnuFnSmkpsKhpqrelv0FRRNQgP9GfUTfc4r4LTy5FRdG8GZwYv45q1URlqVFOg9Mmk3WLtp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731046413; c=relaxed/simple;
	bh=mWM/hpGewpobb2FaKNZvD0q2zMFLsYrjG86Dv4JJAKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=oPkx1MQYNUlK1ZSwhzvDNK6CKa1pM7GInh+3HByW8Uy8gRMTT6gs1HSp7IrL4Xo0EZrJn5NiZ5GLWzVpOPAwX6ZRhWMMFr8ZDn22gtErnbTbNhvS6DXDpFw3vqpnGgFN034ClDwNpBwENfTQIgoe5Q3ms+cxrmNQge0uYGZfxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=G/44vCKJ; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 9IFEtQZYszBgw9IFFtJmQp; Fri, 08 Nov 2024 07:13:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731046401;
	bh=LGAtIE4+aaSXqAdinYIzm8GGKQx74uye1DkHMY08sr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=G/44vCKJiDR4LSAqfFjzmUq2/o2+mwAHP0kiTE/nZbWctwHpXVGxydovAIdFh4dCr
	 hUQqfkBwwvFnaXhyAxb2IQraIz1PmEkzhBuDmKQTOXqR9vuBOHNWsFD8a2nZUgzT/Q
	 0XVLMOtg+X9wf45TOkDlEeS6eqnM7pvdlx85hb8cEgvPZjQduKIcThDADqzTfjeZ/h
	 pMPDOG2p0dIJybDTc58w3zNoVycZY4VLv3OpP3xY7N9munFRGCJvbC5kCBfVCjgHis
	 iI6ujKXJ06ugeQg0/CzhpBthGsIkJrXG4xTpl7kz3ROsW6efg1Y5tgTUlCD2iMOS48
	 90ZWy+/pxJ3lg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 08 Nov 2024 07:13:21 +0100
X-ME-IP: 90.11.132.44
Message-ID: <8e52cc9a-0da0-4393-af66-6dac092148ef@wanadoo.fr>
Date: Fri, 8 Nov 2024 07:13:20 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: adc: vf610_adc: use devm_* and
 dev_err_probe() to simple code
To: Frank Li <Frank.li@nxp.com>
References: <20241107191842.3002319-1-Frank.Li@nxp.com>
 <4bd12695-075d-474c-b720-d295cc6028ce@wanadoo.fr>
 <Zy0Z3wIsgX+O4DEw@lizhi-Precision-Tower-5810>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 imx@lists.linux.dev
In-Reply-To: <Zy0Z3wIsgX+O4DEw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/11/2024 à 20:49, Frank Li a écrit :
> On Thu, Nov 07, 2024 at 08:38:20PM +0100, Christophe JAILLET wrote:
>> Le 07/11/2024 à 20:18, Frank Li a écrit :
>>> Use devm_* and dev_err_probe() simplify probe function and remove
>>> vf610_adc_remove(). Change type of 'vref_uv' to int because
>>> regulator_get_voltage() return type is int.
>>>
>>> Reviewed-by: Haibo Chen <haibo.chen-3arQi8VN3Tc-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>> Signed-off-by: Frank Li <Frank.Li-3arQi8VN3Tc-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
>>> ---

...

>>
>>>    	info->vref = devm_regulator_get(&pdev->dev, "vref");
>>
>> With the change to devm_regulator_get_enable_read_voltage(), is it still
>> needed?
> 
> Suspend function need vref to disable regulator.

Ok.

But why switch to devm_regulator_get_enable_read_voltage() then?
Shouldn't keeping regulator_get_voltage() be enough and simpler?

CJ

> 
>>
>> CJ
>>
>>>    	if (IS_ERR(info->vref))
>>>    		return PTR_ERR(info->vref);
>>> -	ret = regulator_enable(info->vref);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>> -	info->vref_uv = regulator_get_voltage(info->vref);
>>> +	info->vref_uv = devm_regulator_get_enable_read_voltage(&pdev->dev, "vref");
>>> +	if (info->vref_uv < 0)
>>> +		return info->vref_uv;
>>>    	device_property_read_u32_array(dev, "fsl,adck-max-frequency", info->max_adck_rate, 3);
>>
>> ...
>>
> 
> 


