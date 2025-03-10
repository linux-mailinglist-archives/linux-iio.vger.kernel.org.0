Return-Path: <linux-iio+bounces-16659-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88150A58E80
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 09:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC29188C7B4
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 08:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9089222371C;
	Mon, 10 Mar 2025 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QibrLrOH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251B22422E;
	Mon, 10 Mar 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596412; cv=none; b=sxWJcLM8o0ofhCqyIXjLrNGz+4uLjUFD5igN2aC2vF0a0uMEYQCt2yqg+zQLRtTWANti9pP6ku4Wk/pkCRLcCMJ8U7Ph5Iz2e+pvBvUT2GSleg1KPyFskOvEhy8DD1SuzGnRChzDFTom60+FTYEbnyWAvp5y+/BE5/rU3TUJQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596412; c=relaxed/simple;
	bh=mh8HyHXQ6/d/FhUCIKGxcKlG3XXGbsIm6XfUMld4Jvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bndo6Ofn11VzWGSRXOG26QDoCrzx4vp//0QltOFsSJ7/ioe8wXvDdBOTjfQL4FqPIk3t14nOi0Pf5/tHOc5R2ZW7Hq16k0CyulUNO1P/TefmvYDZx9iE+bTL5J3dR8KCq78B6t/ENXnIbKGFzZkTBZtDMiFYIP7In175kYPcUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QibrLrOH; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bee1cb370so35731641fa.1;
        Mon, 10 Mar 2025 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741596409; x=1742201209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kxFdKMeEv/lKowIGUHk9sdguJMU85BbPfG1wmxgoUc=;
        b=QibrLrOHC9h34H4hSNPjOETIucZgsDJMXx7PuLUq0+V5kz1i5g2q83eKRnfpQDoHo7
         /0vCM8fESQhiVUKkch9/B9rqDGpo4ll6J2rDGSU6zGv53Sf2zb3Rip1WRKG3CLc4XHzN
         knjtZCaINAFTDnPuq07QJ48U4edUX+I/EQromq7CScjvhXQGZuFeSV51qSWqGwc+FU1J
         SPZGmXfmit+T6qN81w5SrNHqKkilJYagtgnqyeBxep1dr23qFbS2mzmWUJDP1rOJJwic
         w7nDliW9F6dNnmhAD+EjnfXhR5S7vzgoXCXvb71kuk0mnD2i4m7y4c4UWGKknRVdP6u2
         jGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596409; x=1742201209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kxFdKMeEv/lKowIGUHk9sdguJMU85BbPfG1wmxgoUc=;
        b=bQC6vVRIYhSex/hgnalgxydikvCI9yb/QrYJhowU6dVN5THqmjd3uE+G97lsWlOHmC
         J/FBfzyXM/1RnX38wCP/fT9h45JdVGZy+UHmFtP7ouPcJJXxkOp22WPsylEoQJQbyUWj
         eZFypNsQhjVSgFnUABkoBJllLTwC0ydeGQo5T3zGgQPBiJTGomDN/iykrY1oXQ4L4SvK
         2Ajd6XtN2mRb+bJW9rd7CYlegVKRN3ljdtyqpIdwNboGTTwAkupHSLEi8diUuW++W1Dr
         6KStQHfLaUfDIdLOyofwFVt2o2Hehg9YLPyZduyexm7RnRc3Orv+FcfhpU0c+gqAZ1Mm
         PLPw==
X-Forwarded-Encrypted: i=1; AJvYcCUsKyYyCCdgElBT9OHArZlmQDWMSCCBEH+8qY1pCekEmwQobfV5BhNboHKmR8rxJ89CG2x3k0F+NCySKRBh@vger.kernel.org, AJvYcCWI+R/y8Ujh0L6xBZN+GlC9OPY7UKk/pHA8FrBjcwp4koxbh/T7LlBvI9jv7+0I66iTdZSwkqisZ/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiufGbcDWkdY6Xc6cjJTj+JQ4fw0rx2NQ3e0WXpEEh+F+7d8m
	hx2mFpmU1hOiJ4QSDcNjk18sVsod/TYcFqdNcKK1EH8lJTLqmwIq
X-Gm-Gg: ASbGncsUo3EJZ8v8MF69gJmq3AJ0cZLsF8id5qD6c4E/u2Xwvki3nxfuNa6PxbM4uMt
	bZ2IwzJwxoI7ka86ZXB33CrB+8rijBpstdkiDii8dIfxnPykiRdQf+ZcmHjsCYgtIOz4Q+Ui8tI
	6vXttcGjU59L0GvQLCYT0pKnIatUJbYMQ3aY5WKCrgnuz57JOqmfFyvcE1Yf7pAxl5Z2i75N2E4
	Q2S48DH88SkAAoPl+m5TkY2NrVhpSID8USwUGJes5BVz7LT2JtYYYP//P/NKeNV1FsxxSnnwwgb
	4J5UYmxz3+vsQtyuKY/PA68ia0Z2erKxri1VOsPPiY+cW2RwOizmKtna4Jw4NWFABIZmHWfuQAQ
	IfyVijqbuIBmj6CUSGwkCCl0OpFf4TJTliKmw
X-Google-Smtp-Source: AGHT+IFRw2fsCIEHOiOk/9zkIwvF6fmRqOfBPkp/8Z+uXYcVOozuo8aAY27GOYneOIaMTBztMNgwhQ==
X-Received: by 2002:a05:651c:1541:b0:30b:c6fe:4530 with SMTP id 38308e7fff4ca-30bf44e5a77mr40068971fa.3.1741596408322;
        Mon, 10 Mar 2025 01:46:48 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c03a3e556sm8129041fa.16.2025.03.10.01.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 01:46:46 -0700 (PDT)
Message-ID: <a6fcc1af-5fb8-48bd-8ed8-6fb16b1a5d4c@gmail.com>
Date: Mon, 10 Mar 2025 10:46:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] iio: adc: Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <60a55e4027cf9335b37d4affc11d805a1504cab7.1740993491.git.mazziesaccount@gmail.com>
 <20250308164441.00f64ab2@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250308164441.00f64ab2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2025 18:44, Jonathan Cameron wrote:
> On Mon, 3 Mar 2025 13:33:39 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
>> an automatic measurement mode, with an alarm interrupt for out-of-window
>> measurements. The window is configurable for each channel.
>>
>> The I2C protocol for manual start of the measurement and data reading is
>> somewhat peculiar. It requires the master to do clock stretching after
>> sending the I2C slave-address until the slave has captured the data.
>> Needless to say this is not well suopported by the I2C controllers.
>>
>> Thus the driver does not support the BD79124's manual measurement mode
>> but implements the measurements using automatic measurement mode relying
>> on the BD79124's ability of storing latest measurements into register.
>>
>> The driver does also support configuring the threshold events for
>> detecting the out-of-window events.
>>
>> The BD79124 keeps asserting IRQ for as long as the measured voltage is
>> out of the configured window. Thus the driver masks the received event
>> for a fixed duration (1 second) when an event is handled. This prevents
>> the user-space from choking on the events
>>
>> The ADC input pins can be also configured as general purpose outputs.
>> Those pins which don't have corresponding ADC channel node in the
>> device-tree will be controllable as GPO.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Hi Matti
> 
> Just a few really trivial comments.  If all else in the
> set was resolved I'd probably have applied with a tweak or two
> 
> Thanks,
> 
> Jonathan
> 
>>   obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
>> new file mode 100644
>> index 000000000000..466c7decf8fc
>> --- /dev/null
>> +++ b/drivers/iio/adc/rohm-bd79124.c
>> @@ -0,0 +1,1108 @@
> ...
> 
>> +
>> +/* Read-only regs */
> 
> Given naming this is pretty obvious.
 > I would drop the comment

I will drop this, although I am not sure it is as self explatonary as 
one thinks. I've seen people getting this wrong because the logic of 
regmap-ranges is kind of reversed. (Eg, read-only is done by adding 
range to wr_tables and not to rd_tables - as a no-range).

Thanks for the review, and rest of the comments just agreed with.

-- Matti

