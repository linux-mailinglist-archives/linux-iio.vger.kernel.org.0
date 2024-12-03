Return-Path: <linux-iio+bounces-12984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123979E1355
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 07:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B28282471
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D81862BB;
	Tue,  3 Dec 2024 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkMF/SeP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FADB7DA8C;
	Tue,  3 Dec 2024 06:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207281; cv=none; b=ok1SvDKaknFJU1k0KTwBNGqp60hARYPspaLxBux4nHWMtZLOM7rHgCXZeOh/eosbK3dkaD5AzYyNwtWfY7Vgdat1oCxK/E8FE3zWUTLBa/kGlIO+YE7EyAfAleKD2BAxYFyIxc8huCEpt+h/UDrjZyfFa8HvNVacb/RiCKVKOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207281; c=relaxed/simple;
	bh=BVNz6a6RQMt/P4mz6tdTnhvoVtjhnxgIemE1GaEyFuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=np49sIKJHkqYbDoRjJRzpoUEKG1IFCwNK13aMFCOjSKGv9ItGWhbkRe3fhWrhlqumvfewU0P0tIRRX8gg+gNMugtwyQBxvP2erbdsZzj2rSRah/5N/VmHpiHe4Wbyqy4qsf+jAXmuxlAAESfKNIR6P2hgwxOplEAHQ0Wt5sbfcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkMF/SeP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df80eeeedso5322819e87.2;
        Mon, 02 Dec 2024 22:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733207278; x=1733812078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tn8XClVZRZxX3/WQO34yniUIKIw8qkK1xsMKchWydIA=;
        b=nkMF/SeP7oGso6gPPRKpCjDx9nlZzN8KUfAUQvJKp/ePPnvlsRY9bz9FgV5EstikFj
         QcQ9ukL5iWEEFZ6a02ceFv/ufpMyBV1k1yB5OzWY8eA+XGDPhF06nZf4HzeRsdzKM7+l
         Mces4/O/rrv6mtJaS+XwQ2HwqCVIxRjWPPiHP1yS9kzykZlkAgPrFTKQsYVxxltzNKb0
         wb3+gB2ApmKlhIKRVeovmBt9BvHad0uKFN3K1vzAaRhWtVP+5oAtEcwrJq+aFuMbz23O
         eAFC+p+9jA028iFuPu+apRbMPaJY88PS8JvGOOjbmssY413/e2Qbd3MdM85Sor45p2RE
         NN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733207278; x=1733812078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tn8XClVZRZxX3/WQO34yniUIKIw8qkK1xsMKchWydIA=;
        b=etgjKDz1ytnmrRy5ZJTyVwGgBi8OeVijSeVDULv44hCidlwcfu7JeBXJd0akWAS76L
         pud4ZouPHJ8OqALLf1gIEpmNoXsHtnh7FsFEeYVqcsNi7ui4ISsX0fEste1t0KL9c9E6
         j8NcsL0WEHUqiIoeOCtadUvEs3Gl0MD1/RyJX1F5Baae9iVTUPXDtxVCrAC9iT8RFlZv
         qpSUXfzPg/mzmDGZI7lKD9jOkNwSxlmlQLuvJUZPzCXQpdxUVSAB7n7qET9eLdSYzuGS
         IE81a4XPXHsEGh6yO9uvr580GGcOrxln7XIOQIYgcsI1TtDqoQyPzISp4+PJDS7sajzM
         hr/g==
X-Forwarded-Encrypted: i=1; AJvYcCUc7qAe1Wrr1EIgmeqPjM67VAJna2IPE6vVh6DKudwZ4ef/GAMRiGGIvvVJoRBj79WihqXRr16+rjkzEStl@vger.kernel.org, AJvYcCW3OSusfyDxi1xAIKbupLLL0IfxDaiUEsIoDRGuXKCJEGZXNJusOeAAznUexiAOvx5RWSLpaSx0AM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypgV6oXKKETQH4sMyH0CHtHq1Qke51jeaqHH9ijUyC8q6QCVAW
	cZwJdwIke/NKPhYJVwnEnHdqCPbAnFL9getJtqXFbNa2zTh5GDJU
X-Gm-Gg: ASbGncu/4yrZipjW5spFfYDGC3eD705kh3iPJ4cTuE90HtYaiHdLLw6LxPa982t1/Re
	chGdHCnnkKxWdyLWPTiB10gvxYBAcQZvGd/cVz3EAr4QCoeNIci0EYA2QdCIEcIZO8qL2IqId3+
	PqS0ClS/gydDmwzfNAJWIdhdIAQVdsdHIbnMgMO4CpmfnmSxlZxDP9HDvvS6g0xA31LbDL8Ne1Y
	SD5B27pjfkkNxaucsVWQ3GwJ7NDaQB6F25lZqqcCpkinluSZB6RwPKL2f8V1NWCZ21Tu4Q8fIW3
	tLHwK73AlLqKoYBDr5YqXEW1NoUu3s4=
X-Google-Smtp-Source: AGHT+IG6/iBhi38LxIDWitZejm7IOANx4mjE7WdE7+FthbU+d4d0bYVm1bQgAKA/JAOkusW63REprQ==
X-Received: by 2002:a05:6512:2254:b0:53d:d486:9705 with SMTP id 2adb3069b0e04-53e129f0048mr704191e87.9.1733207277766;
        Mon, 02 Dec 2024 22:27:57 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f0e6sm1710764e87.154.2024.12.02.22.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 22:27:55 -0800 (PST)
Message-ID: <4004fafd-7596-4def-bf78-e91685f0c934@gmail.com>
Date: Tue, 3 Dec 2024 08:27:53 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: kx022a: document new chip_info structure members
To: Mehdi Djait <mehdi.djait@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Z02eXtrrO8U5-ffo@mva-rohm>
 <hv7kqspym5qkcwbw4r6ogi362sbooohijplxbkro5qdmndvhr6@t2cftbs4n7rz>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <hv7kqspym5qkcwbw4r6ogi362sbooohijplxbkro5qdmndvhr6@t2cftbs4n7rz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 15:41, Mehdi Djait wrote:
> Hi Matti,

> On Mon, Dec 02, 2024 at 01:47:42PM +0200, Matti Vaittinen wrote:
>> The kx022a driver supports a few different HW variants. A chip-info
>> structure is used to describe sensor specific details. Support for
>> sensors with different measurement g-ranges was added recently,
>> introducing sensor specific scale arrays.
>>
>> The members of the chip-info structure have been documented using
>> kerneldoc. The newly added members omitted the documentation. It is nice
>> to have all the entries documented for the sake of the consistency.
>> Furthermore, the scale table format may not be self explatonary, nor how
>> the amount of scales is informed.
>>
>> Add documentation to scale table entries to maintain consistency and to
>> make it more obvious how the scales should be represented.
>>
>> Suggested-by: Mehdi Djait <mehdi.djait@linux.intel.com>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Wording is difficult. Especially when not working on ones native
>> language. So, I am glad is someone evaluates whether using the 'NANO'
>> to describe 0.000 000 001 is correct - or if term like 'ppb' would make
>> more sense...
>> ---
>>   drivers/iio/accel/kionix-kx022a.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
>> index 142652ff4b22..82c4ced7426d 100644
>> --- a/drivers/iio/accel/kionix-kx022a.h
>> +++ b/drivers/iio/accel/kionix-kx022a.h
>> @@ -137,6 +137,11 @@ struct kx022a_data;
>>    *
>>    * @name:			name of the device
>>    * @regmap_config:		pointer to register map configuration
>> + * scale_table:			Array of two integer tables containing
>> + *				supported scales. Each scale is represented
>> + *				a 2 value array. First value being full
>> + *				integers, second being NANOs.
> 
> How about:
> 
> Array of tables containing two scaling factors for the supported
> acceleration measurement ranges. First value is the integer part and
> second value is the fractional part in nano units.
> 

Hi Mehdi. Thanks for the input. I definitely prefer your wording over 
what I wrote. Except maybe the note about each table containing two 
scaling factors. I think a table contains two integers, but only one 
scaling factor which is composed of those integers.

I am also still wondering if ppb (or even fully written "parts per 
billion") should be used instead of nano. In my ears the "nano" needs 
units, but I suppose the scale does not have any.

Yours,
	-- Matti

