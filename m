Return-Path: <linux-iio+bounces-5064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC58C72A7
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 10:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03831C220C2
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2024 08:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498877FBA8;
	Thu, 16 May 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdaUahUE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12D6BB4E;
	Thu, 16 May 2024 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715847522; cv=none; b=HB1twJDg3zcaeuYA8PY1piQWdeyzQqOWdGmspEYZiXHus1Tn8tutnOToYFIxnAFCtlg7xnLCoz+fGMaZAKzv5W6QXXUNbmBlox7uandvTMVS0NChmfuti9Tku7JtGa81KlyxE8HhksleWPM4PlUZnmHt7sEynQWQg5VLjCUHakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715847522; c=relaxed/simple;
	bh=CITnHg3hztxDwIk/f59/vJPVn2lRb2THpXbzWL+hi0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozgX/9a+aoUuQ5J3Yl/mowQ9d3+jVjUSpgMFSq6Fs4oVtW3LtTng70n6Us+Ej5jli6ehzC1+nQdFKv/fZvytKrEHqc9/EAiTPKoJQ+lGjv8kbW12q69KXxWHymH13SKLQSm6oRANpgHC5PJ/RB9qvcpsjvaACvY6DlHe3Sk1d6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdaUahUE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792b94301eeso680980285a.3;
        Thu, 16 May 2024 01:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715847519; x=1716452319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NufQYItcoqGYUWHJufmWbVDuGs9yuO6ZiwwLJ3NloNU=;
        b=EdaUahUEASSQlcRcbMJ224nV6mRO7v1ST1uZld+eYyCQ6s8AoIYNwRZcocglAxtnxU
         tCy1Pzsj1UKeTX0cHfvkfU28niJWI52Q6vQ/E6YqOiuJt5iltUtGWqIJ6PoJXlvGhCMl
         czq8OZl58AwHWHmABtnFUmBIaXlfYgh9GI7/7OW71f5IRZz977FXmjDqu+Ju/xP6OlMK
         4tT7LPjzmlcQ14hW2xqAwHJXxMUzGNfn2HfCNNMqNdNEmr507ecDRnB7B66ag2/m6z0T
         4W0skhlXZpeMGZUSUbDFxTOdYMQ6vQd9qU/X8FCq4r8ln1+eIaMxi04wiXE72Dcz8Xpw
         /+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715847519; x=1716452319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NufQYItcoqGYUWHJufmWbVDuGs9yuO6ZiwwLJ3NloNU=;
        b=K8w5oaOJB9i5mI0xi5HexH0KdkT+kSTBrFxtwseeATucZaQ4Kda1REeOQCJidrBTiN
         lJRTeN4PHpYcSojU0I6AKzvPwzowR6bElhICj8osiZ930IuxjmVXqslE+JrWavTBeW25
         diDIDsZRIa1W12WMUey+SOzK+SZecPcdetCjIja32jC/6hR6zwE+PAagG/u3mhkwK1s2
         1NccNhDry8aDnET9po0RFWE/hTE2hDwgUx77EY6bLH4HBbZ57bY/U+X2JUAX5vziW8SP
         KzqfL4/nBg5imyrWUqd2Cc6KYbt5zYAtyO7jzka0IKb2PCtjvclrWDPwpmAFfG3ALLpV
         Eogg==
X-Forwarded-Encrypted: i=1; AJvYcCXsQjTMbhLPNazUy6Ihc4eiWhs7GX/+A8Mi+AMLzBG0yJnO/7fTO48w6VCbtz+WB+HAdxSPAPEGC9GeJCmQMjQckOPd/S568IyYgt5GBnBI6lpraokcOekW/gfUJ+kUmvn3vliyP2IO0o01lgX6Dx/SIaTSGOd/JV1FN/f77jlxeGaUGw==
X-Gm-Message-State: AOJu0Ywh9sZJMiryABvJPnA7rZLFSej+btdkEgnWWG1IZ1aCtbno6/s9
	IdqSMoncPN1xGArXjD/R8PzW+fzNHo1z6Z5gjG02Zj3RkvEbjAek
X-Google-Smtp-Source: AGHT+IEQPkYaCzuRgbmNgMK95ZcP2QiHIUppBsYhfuNLnFMm6iMkg7R816Bql3KHD6duzHO/AY1zFg==
X-Received: by 2002:a05:620a:2281:b0:792:c0bd:bd5c with SMTP id af79cd13be357-792c760106emr1880876785a.69.1715847519365;
        Thu, 16 May 2024 01:18:39 -0700 (PDT)
Received: from [192.168.0.137] ([188.24.105.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf275856sm775308285a.9.2024.05.16.01.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 01:18:39 -0700 (PDT)
Message-ID: <3163f930-fa45-4673-bc26-58fef7be49da@gmail.com>
Date: Thu, 16 May 2024 11:18:35 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: adc: ad7173: add support for ad411x
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
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
 <CAMknhBGxEfGJhi+0Pxi+XqCSKLAKLzhLOt_rZo+vP=XqQDqWGA@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBGxEfGJhi+0Pxi+XqCSKLAKLzhLOt_rZo+vP=XqQDqWGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/05/2024 00:42, David Lechner wrote:
> On Sat, Apr 20, 2024 at 9:33 AM Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Mon, 15 Apr 2024 21:42:50 +0300
>> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
>>
>>> On 13/04/2024 13:49, Jonathan Cameron wrote:
>>>> On Tue, 9 Apr 2024 11:08:28 +0300
>>>> "Ceclan, Dumitru" <mitrutzceclan@gmail.com> wrote:
>>>>
>>>>> On 06/04/2024 17:53, Jonathan Cameron wrote:
>>>>>> On Wed, 3 Apr 2024 10:40:39 -0500
>>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>>
>>>>>>> On Wed, Apr 3, 2024 at 2:43 AM Ceclan, Dumitru <mitrutzceclan@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On 01/04/2024 22:37, David Lechner wrote:
>>>>>>>>> On Mon, Apr 1, 2024 at 10:10 AM Dumitru Ceclan via B4 Relay
>>>>>>>>> <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>>>>>>>>
>>> ...
>>>>>
>>>>>>>> Other alternative that came to my mind: attribute "adi,current-channel".
>>>>>>>
>>>>>>> Having a boolean flag like this would make more sense to me if we
>>>>>>> don't agree that the suggestion below is simpler.
>>>>>>>
>>>
>>> ...
>>>
>>>>
>>>> We do directly relate reg to channel numbers in drivers like the ad7292 (where not
>>>> all channels are differential)  I'm not convinced either way on what is best
>>>> here where reg is currently just an index into a channel specification, not
>>>> meaningful for which pins are involved.
>>>>
>>>> It doesn't seem worth adding an equivalent of diff-channels for a single channel
>>>> setup but I guess it would be more consistent.
>>>>
>>>
>>> Would you agree with the attribute adi,current-channel within the channel and
>>>  diff-channels set to the correspondent current inputs (13 10 for pair IN2)?
>>
>> From another thread today I've concluded we do need a single-channel
>> equivalent of diff-channels, but you are right that here it is a differential
>> channel so <13 10> seems like the best option to me.
>>
> 
> Current inputs are differential? It seems like we would need 4 input
> pins for that.
We cannot measure differential current channels.
We are measuring a voltage differential channel of the voltage drop across
the shunt resistor. Differential in the sense that inputs 13 and 10 are
routed to the ADC.

