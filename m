Return-Path: <linux-iio+bounces-8448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CD9950982
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD84F281352
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C01A0729;
	Tue, 13 Aug 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfnNZ9CS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABD1A0739;
	Tue, 13 Aug 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564437; cv=none; b=V7IxSk245POlO3gGZWEROqrYw5T45mkxqXk/pbbAGfs6hfcvGkBpmu72RiaV/7/SkCvE0nTP1Txs3iCJ92T6/1UynBaJo5X7AJ0+NrsygWdSn4IschNE1BmtLlJ79kUIhOUaRYqjVqPYsdCbngeBC/3mJgE8DuvSCv1a6IARjFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564437; c=relaxed/simple;
	bh=um+LfJ64/7VB0I54NXDgqN32KRspVkV9XVyBp2upe8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pp8QUoPATJWLcGIEHSuvQUeDLSYCtAxuGT1cyDePd66+gwmSYwLw3jD5zYmkV9K/ySNw/HJNBWSS/97MgMr9L8G3sGh9lFir5kHmMjslCGEePFZAi2iJQp+IjIIT+zT5HcqKG+LPTjV6SI6SL7ohc4PuG4jHS53CV0zMiOwIPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfnNZ9CS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7C0C4AF0B;
	Tue, 13 Aug 2024 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564437;
	bh=um+LfJ64/7VB0I54NXDgqN32KRspVkV9XVyBp2upe8Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=kfnNZ9CS3NGyRItuqTkLpcPI7ClhLhinbTLcB3+fXAc01+bAt7KEdUKwSadBwqPB/
	 pVl4eSQUFKrWBsIFDCYTh/lNwVQeNmxwZv0JuXeizulOuRGLaw35fx9GucWIWeceIl
	 4lbYGUDbP+EaMgelxFnMiQ9zk8pc+3mIP3+9s/9sXCf9gXaHyMuobLJxAN0aQzpHo1
	 h5xqhADDIiV1JBLkExgVgSZlj3yw+UEeLs0LvBxWbHMvQFy20HdLQPvMCVzL+U7/yp
	 +YqL6X15HBuWxS7kMzbmIk8rVJdBLy2BABMSX/K2o12X6PYpzLYMPx24yDpNIj4Dr9
	 GKqZLLGK3+TGQ==
Message-ID: <f3c499eb-9d87-4fb4-81ef-e0b77819a96f@kernel.org>
Date: Tue, 13 Aug 2024 17:53:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: imu: smi240: imu driver
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dima.fedrau@gmail.com" <dima.fedrau@gmail.com>,
 "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Lorenz Christian (ME-SE/EAD2)" <Christian.Lorenz3@de.bosch.com>,
 "Frauendorf Ulrike (ME/PJ-SW3)" <Ulrike.Frauendorf@de.bosch.com>,
 "Dolde Kai (ME-SE/PAE-A3)" <Kai.Dolde@de.bosch.com>
References: <20240809111635.106588-1-Jianping.Shen@de.bosch.com>
 <20240809111635.106588-3-Jianping.Shen@de.bosch.com>
 <561b467a-58aa-471c-8ea6-cd6ef927c287@kernel.org>
 <AM8PR10MB47217665274B9848EB21FA65CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <bb33aeb0-7134-45ec-8536-47c524ec9e4b@kernel.org>
 <AM8PR10MB472146AA446E64C63DE3BF31CD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <67255497-7bc9-4392-ab32-d0a6af75f5b0@kernel.org>
 <AM8PR10MB4721373BE7846741A2EC66DACD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <AM8PR10MB4721373BE7846741A2EC66DACD862@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2024 16:51, Shen Jianping (ME-SE/EAD2) wrote:
> Hi
> 
> 
> ...
>>>>>> +
>>>>>> +MODULE_AUTHOR("Markus Lochmann
>> <markus.lochmann@de.bosch.com>");
>>>>>> +MODULE_AUTHOR("Stefan Gutmann <stefan.gutmann@de.bosch.com>");
>>>>>> +MODULE_DESCRIPTION("Bosch SMI240 driver"); MODULE_LICENSE("Dual
>>>>>> +BSD/GPL");
>>>>>
>>>>> Hm? How many modules do you have here? What are their names?
>>>>>
>>>>> We have one module, named  "Bosch SMI240 driver". Any problem here?
>>>>
>>>> Yes, you put MODULE_* to how many files? Two? Three? Why is it needed
>>>> everywhere?
>>>
>>> We put MODULE_* in all the *.c , just like the other IMU drivers already in source
>> tree. They do the same.
>>
>> That's not true. First, look at adis_buffer.c. no MODULE_XXX. Second, maybe they
>> have multiple modules, so the macros are expected. That's why I asked you and
>> you said you do not have more than one module.
>>
>  
> Now I get the point , what you mean for "module".  Yes we have two modules. 
> One module named "Bosch SMI240 driver" therefore we put MODULE_* in smi240_core.c 
> And we have the second module named " Bosch SMI240 SPI driver " and we put therefore MODULE_* in smi240_spi.c

I asked the question on purpose, so you will double check and do not
waste my time with whatever you wan to respond just to avoid work.
Replying something just to silence review is not welcomed.

If you claim you have two modules then please give me the names of the
modules (filenames).

Best regards,
Krzysztof


