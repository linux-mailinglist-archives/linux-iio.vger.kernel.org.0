Return-Path: <linux-iio+bounces-4912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA248C10A2
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 15:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964412817A1
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3EB15B108;
	Thu,  9 May 2024 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDYx5Ksu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646A14BF90;
	Thu,  9 May 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262494; cv=none; b=Ddeyp1laKtBS+rS4fDbV5Aa441i+5EOdyAjhXgcwnSkl9HYAjcjzqN/t/TUXm3dkRVw+Z2et9Nu0WlS2WCarD0UQMBbVdRmyyJ2Z4W7xmhLbspSca8RXsxRTn5odNTS6P0f0XJogm/Wnpg+BjVX7Zstu0cZg7b5s6f+O+fFhUvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262494; c=relaxed/simple;
	bh=UjqyFlQCa5wEd1OFAPx4ZnDVfuZab+U9x7MCQLFeEGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=no6+epbvSVADiepYsuiozp6/H8wCscz8o6+Mj3ulDeMbI9z5jZ8gCcW3lMLLPp4/FfPMTDUu0cf+kLPkIHhWUq/tp0i0ZXaaH6h1/VOYFMPYHqFNAfRxaLlYJBgsu3h90VmMTWFedO2FBTCYZdhOmhVs9PrvV+GDg24GG6YnLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDYx5Ksu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34dc129accaso609199f8f.0;
        Thu, 09 May 2024 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715262491; x=1715867291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qHNVWdT43ishvyFqorNYoQKL9lNyD+xXi+txoFf9Vw=;
        b=XDYx5KsuOXN6PPAYJTFS1b7/xPGygPTu4FX8F0fyfkhXu6U69PMbQfShVH1ommwpGF
         8127rqp0agcjVuRi0fJFac+WvduO3JqSg9hUc3bGbKb5+Gg2wDnU010TYOaMFhns5/i9
         XcUAKyRg4m4msCvE9ty6XuD8obc8S+7tiravM6skkdHL3dqnW8mYImIcuxQVCqf/xn9j
         33tEJ3Mq9sceCOcr/0qZ/tusjSO9uuAHd5qKggp5RDI1kMOFakAHBBC2G+PPaMAQE7h4
         UAZWbXk8FbcgdAnEbT9iXscJinvWZZkio3Tqvf9J/x9tbPIoqcTmBwSoLo9v7ecsbwaa
         Id3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715262491; x=1715867291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qHNVWdT43ishvyFqorNYoQKL9lNyD+xXi+txoFf9Vw=;
        b=mneH+GQbsaA05pfNCQO7Bc/BeBliV959hF1AwCkve5aRQeC4FFzRq8ErdaDnrzNfaI
         LFC++F1xnjtzgSUwSzVBWMofhTHa5FlJGWaTZXdYoDQ/6giP20CwyjYGLfGXQy7vPsm+
         SV/zGdPb0TrsFucCB0iOztzKXfyFa9ZGg9lQ/Zm3RIkfdSyN97rle1tGzvv9ryqyj2nU
         pT5bwt7QQsfqaNbNMl5qUL9osSUfjr8zRJxyQpjLakTHTVREu9j7CFvtrQ/POuE3kija
         coBU+Xz7+jTa11Fy7utgOZuWjZjGYbYY+VBi1Jowy2fW97y1Eg0aIp/I6KYNHoaw8aXB
         dVdA==
X-Forwarded-Encrypted: i=1; AJvYcCVWtYkK8IpOPflQfiIki1TXka/vOv+l/CLz9FU1BeLoG2RubBmZwXRKhXqZD/nSlUuj7IHCyBFM15nkzRXRRtEctvXozPy3Xexvyshzs/RBCBdWmBk4GTVIEPeQB0UTd1wsTBeVko3z/8JQhggEzBBcEV5UUG0jfbeT5ClkO6G/d9KGPA==
X-Gm-Message-State: AOJu0YzwmXnKRRF+mfwaYjQCi01eTqXlXbmy9rvBLN1ZTiqISmuT6FkU
	WLCRhpOtSAGwRVCYW6A406CY/vaje4ehBl+4EDiiqCbQ8zH/oy9IKJ+CmOUep8k=
X-Google-Smtp-Source: AGHT+IFMCA0qWwr+/vpgCssxwDTDBCacEo332oMvYOlecWyHgR1pgQrcO2sce71ZJoOTugtW9/BIYQ==
X-Received: by 2002:adf:fd8c:0:b0:34c:4c89:108a with SMTP id ffacd0b85a97d-34fca6213e9mr3819268f8f.43.1715262490742;
        Thu, 09 May 2024 06:48:10 -0700 (PDT)
Received: from [10.76.84.173] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad037sm1750786f8f.71.2024.05.09.06.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 06:48:10 -0700 (PDT)
Message-ID: <0fef36f8-a7db-40cc-86bd-9449cb4ab46e@gmail.com>
Date: Thu, 9 May 2024 16:48:08 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-1-34618a9cc502@analog.com>
 <CAMknhBHeKAQ45=5-dL1T1tv-mZcPN+bNo3vxWJYgWpEPE+8p3Q@mail.gmail.com>
 <25cb3514-1281-49a8-9e9b-40ead9b050dc@gmail.com>
 <CAMknhBHu8DveBgV3cor8RP2Up4Zs-+QRx7S2aoHZ_3iKiErVjg@mail.gmail.com>
 <20240406155328.447b594f@jic23-huawei>
 <64b7fd83-f226-4b1f-a801-0fe1cf20f842@gmail.com>
 <20240413114825.74e7f3fa@jic23-huawei>
 <89e93f4d-e569-46ee-802d-a1668a01b882@gmail.com>
 <20240420153310.7876cb8a@jic23-huawei>
 <681f3bfb-76d0-41a8-82b5-6d27641c24b6@gmail.com>
 <20240428181334.5792e1df@jic23-huawei>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <20240428181334.5792e1df@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/04/2024 20:13, Jonathan Cameron wrote:
> On Tue, 23 Apr 2024 11:18:47 +0300
> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
> 
>> On 20/04/2024 17:33, Jonathan Cameron wrote:
>>> On Mon, 15 Apr 2024 21:42:50 +0300
>>> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
>>>   
>>>> On 13/04/2024 13:49, Jonathan Cameron wrote:  
>>>>> On Tue, 9 Apr 2024 11:08:28 +0300
>>>>> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
>>>>>     
>>>>>> On 06/04/2024 17:53, Jonathan Cameron wrote:    
>>>>>>> On Wed, 3 Apr 2024 10:40:39 -0500
>>>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>>>       
>>>>>>>> On Wed, Apr 3, 2024 at 2:43 AM Ceclan, Dumitru <mitrutzceclan@gmail.com> wrote:      
>>>>>>>>>
>>>>>>>>> On 01/04/2024 22:37, David Lechner wrote:        
>>>>>>>>>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>>>>>>>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:        
>>>>>>>>>>>
>>>>>>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>        
>>>>>>>>>    
...
>>
>>>>  
>>>>>>
>>>>>> I think that a distinction needs to be made here:
>>>>>> - When a device is only pseudo differential, sure, it is in a different category
>>>>>> - When a device is fully differential and you are using it as pseudo-differential
>>>>>>   you are having two inputs compared to one another
>>>>>>
>>>>>> I would need more clarification is why would supply-vincom be a requirement.
>>>>>> The voltage supplied to VINCOM will not be used in any computation within 
>>>>>> the driver. From the perspective of getting the data it doesn't matter if 
>>>>>> you are using the channel in a pseudo-differential, single ended or fully
>>>>>> differential manner.    
>>>>>
>>>>> I'd missed until now that the datasheet (I looked ad4114) says aincomm should be connected to analog
>>>>> ground so indeed nothing to turn on in this case and no offset to supply
>>>>> (the offset will be 0 so we don't present it).
>>>>>
>>>>> I'll note the datasheet describes the VINCOM as follows.
>>>>>
>>>>> Voltage-Input Copmmon. Voltage inputs are reference to VINCOM when the inputs are configured
>>>>> as single-ended.  Connect AINCOM to analog ground.
>>>>>
>>>>> The reference to single ended is pretty clear hint to me that this case
>>>>> is not a differential channel. The more complex case is the one David
>>>>> raised of the AD4116 where we have actual pseudo differential inputs.
>>>>>     
>>>>
>>>> Alright, from my perspective they all pass through the same mux but okay,
>>>> not differential. The only issue would differentiating cases in AD4116 where
>>>> the pair VIN10 - VINCOM is specified as single-ended or differential pair.
>>>>
>>>> Also, AD4116:
>>>> "0101101111 ADCIN11, ADCIN15. (pseudo differential or differential pair)
>>>>  0110001111 ADCIN12, ADCIN15. (pseudo differential or differential pair)
>>>>  0110101111 ADCIN13, ADCIN15. (pseudo differential or differential pair)
>>>>  0111001111 ADCIN14, ADCIN15. (pseudo differential or differential pair)"
>>>>
>>>> Not really sure where the "actual pseudo differential" sits.
>>>>
>>>> Would you agree with having device tree flags that specifies how is the
>>>> channel used: single-ended, pseudo-differential, differential.
>>>> For the first two, the differential flag will not be set in IIO.  
>>>
>>> Yes. I think that makes sense - though as you observe in some cases
>>> the actual device settings end up the same (the ad4116 note above).
>>>  
>>  This precisely why I suggest this approach, because a channel used as
>> single-ended, pseudo or fully differential will have the same register
>> configuration on all models. I do not see any other way to know from
>> the driver this information.
>>
>>> If a given channel supports single-ended and pseudo-differential is
>>> that really just a low reference change (I assume from an input to the
>>> the IO ground)? Or is there more going on?
>>>   
>>  I'm not sure if I understood what was said here. The reference specified
>> in the channel setup does not need to change.
> 
> So what is the effective difference?  My assumption was that single-ended
> means reference to 0V in all cases.  Pseudo differential means reference
> to an input that is common across multiple channels, but not necessarily 0V?
> 

I do not have a clear answer...

This ADI page for example, defines pseudo-differential precisely what we
assumed (non 0V on IN-):
	"On the negative input IN- you apply a DC voltage to shift your signal."
https://ez.analog.com/data_converters/precision_adcs/w/documents/2875/difference-between-pseudo-differential-and-single-ended-mode-of-an-adc

While this page defines what we call single-ended as "pseudo-differential unipolar".
https://www.analog.com/en/resources/technical-articles/sar-adc-input-types.html

These two use-cases are not clearly differentiated from one another, what we are
referring to as pseudo-differential is called single-ended in some datasheets.



I've made a summary of how each datasheet defines these cases:

AD411x (1, 2, 4, 5) only mention single-ended as IN- selecting VINCOM.
                                                         (connected to AVSS)

AD4116 mentions both single-ended and pseudo 
       (pseudo specified as IN- connected to a non 0V reference)

AD717x (2-2, 3-8) 
	Does not contain pseudo differential references
	Single-ended is exemplified as IN- connected to 0V or a non 0V reference.

AD717x (5-2, 5-8, 7-2)
	Mentions at the start that pseudo differential is supported.
	Single-ended is exemplified as both IN- connected to 0V and a non 0V reference.

AD7172-4 only mentions single-ended with the example IN- connected to AVSS.
                                 (This model does not have the internal reference)

AD7176-2 is special, as has only the pseudo differential section but
calls them single-ended:
"Pseudo Differential Inputs
 The user can also choose to measure four different single-ended
 analog inputs. In this case, each of the analog inputs is converted
 as being the difference between the single-ended input to be
 measured and a set analog input common pin."

>>
>>> If it's the reference, then can we provide that as the binding control
>>> signal?  We have other drivers that do that (though we could perhaps make
>>> it more generic) e.g. adi,ad7124 with adi,reference-select
>>>  We already have adi,reference-select in the binding and driver, I do not  
>> see how it could help the driver differentiate between (single, pseudo...)
> 
> Indeed that doesn't work.  Problem in this discussion is I've normally forgotten
> the earlier discussion when I come back to it :( 
>>
>>> I don't like that binding because it always ends up have a local enum
>>> of values, but can't really think of a better solution.
>>>  
>>
>>>>  
>>>>>>
>>>>>> Regarding VINX VINX+1, it is not mandatory to respect those, from AD4111 page27:
>>>>>> "Due to the matching resistors on the analog front end, the
>>>>>>  differential inputs must be paired together in the following
>>>>>>  pairs: VIN0 and VIN1, VIN2 and VIN3, VIN4 and VIN5, and
>>>>>>  VIN6 and VIN7. If any two voltage inputs are paired in a
>>>>>>  configuration other than what is described in this data sheet,
>>>>>>  the accuracy of the device cannot be guaranteed."    
>>>>>
>>>>> OK, but I'll assume no 'good' customer of ADI will do that as any support
>>>>> engineer would grumpily point at that statement if they ever reported
>>>>> a problem :)
>>>>>     
>>>>>>
>>>>>> Tried the device and it works as fully differential when pairing any
>>>>>> VINx with VINCOM. Still works when selecting VINCOM as the positive
>>>>>> input of the ADC.
>>>>>>
>>>>>> I really see this as overly complicated and unnecessary. These families
>>>>>> of ADCs are fully differential. If you are using it to measure a single ended
>>>>>> (Be it compared to 0V or pseudo differential where you are comparing to Vref/2
>>>>>> and obtaining results [Vref/2 , -Vref/2]) the final result will not require knowing
>>>>>> the common voltage.    
>>>>>
>>>>> For single ended VINCOM should be tied to analog 0V.  If the chip docs allowed
>>>>> you to tie it to a different voltage then the single ended mode would be offset
>>>>> wrt to that value.
>>>>>
>>>>> For the AD4116 case in pseudo differential mode, You would need an ADCIN15 supply because
>>>>> that is not connected to analog 0V.  If the device is being used in a pseudo differential
>>>>> mode that provides a fixed offset voltage.
>>>>>
>>>>> So my preference (though I could maybe be convinced it's not worth the effort)
>>>>> is to treat pseudo differential as single ended channels where 'negative' pin is
>>>>> providing a fixed voltage (or 0V if that's relevant).  Thus measurements provided
>>>>> to userspace include the information of that offset.
>>>>>     
>>>>
>>>> What do you mean by offset? I currently understand that the user will have
>>>> a way of reading the voltage of that specific supply from the driver.   
>>>
>>> How?  We could do it that way, but we don't have existing ABI for this that
>>> I can think of.
>>>   
>> Expose a voltage channel which is not reading from the device...but that is
>> too much of a hack to be accepted here
> 
> We have done things like that for a few corner cases where we were really stuck
> but it is indeed nasty and hard to comprehend. Also so far they've been 'out'
> channels I think which doesn't make sense here.
> 
>>>>
>>>> If you mean provide a different channel offset value when using it as
>>>> pseudo-differential then I would disagree  
>>>
>>> Provided to user space as _offset on the channel, userspace can either
>>> incorporate it if it wants to compute absolute (relative to some 0V somewhere) value
>>> or ignore it if it only wants the difference from the reference value.
>>>
>>> I'm open to discussion other ABI options, but this is the one we most naturally have
>>> available.  
>> _offset is already used when the bipolar coding is enabled on the channel
>> and is computed along datasheet specifications of how data should be processed,
>> this is why I disagree with this.
> 
> OK.  It would be easy enough to apply an offset to that, but it would
> complicate the driver and could seem a little odd.
> 
>>
>> This feels over-engineered, most of the times if a channel is pseudo
>> differential, the relevant measurement will be the differences between
>> those two inputs.
>>
>> If a user needs to know the voltage on the common input, he just needs to
>> also configure a single ended channel with the common input where the
>> negative AIN is connected to AVSS.
> 
> OK.  I'm somewhat convinced that this is enough of a pain to describe that
> we should just rely on them having some other way to get that offset if they
> are deliberately using it to shift the range. We can revisit if it ever
> becomes a problem.
> 
> So, I think the conclusion is just don't represent AIN-COMM (or similar)
> as an explicit voltage we can measure.
> 
Perfect. I'll keep the adi,channel-type attribute in the next version 
(that is there just to control the differential flag from the iio
channel struct) and we'll see if it's alright.

>>>>  
>>>>> We haven't handled pseudo differential channels that well in the past, but the
>>>>> recent discussions have lead to a cleaner overall solution and it would be good
>>>>> to be consistent going forwards.  We could deprecate the previous bindings in
>>>>> existing drivers, but that is a job for another day  (possibly never happens!)
>>>>>     
>>>>
>>>> I really hope that a clean solution could be obtained for this driver as well :)   
>>>
>>> I bet you wish sometimes that you had easier parts to write drivers for! :)
>>> These continue to stretch the boundaries which is good, but slow.
>>>
>>> Jonathan  
>>
>> Not easier, fewer crammed into the same driver :)
> 
> I sympathise! It's been an annoyingly busy kernel cycle in the day job. I was hoping to
> get back to you sooner so that more of this was fresh(ish) in my mind :(
> 
> My gut feeling is that this is a case for documentation / really detailed cover
> letter for the next version to make sure we have come to at least a (mostly)
> consistent conclusion.
> 
> Jonathan
> 

