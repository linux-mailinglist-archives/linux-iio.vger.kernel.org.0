Return-Path: <linux-iio+bounces-290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A17F634E
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 16:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39661B217BB
	for <lists+linux-iio@lfdr.de>; Thu, 23 Nov 2023 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0DA3D977;
	Thu, 23 Nov 2023 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EeHEMHjM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D190D10D2
	for <linux-iio@vger.kernel.org>; Thu, 23 Nov 2023 07:48:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548d1f8b388so1492834a12.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Nov 2023 07:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700754491; x=1701359291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGFlvgruXhRu8yz7L9ZekLGqznWc+QZuVKrR49lhS6E=;
        b=EeHEMHjM66IdclB7DXL5A9ZNB9cyPvqIoBfkovYrwzffQlryiVPTu91YqEpqz6z+0v
         sMnEBMZ8vkQLvfFYL7a4JFDA9VDsrtQGQ5X31I4MQaAuMmtShJSlVNEr0ZpUcSDzvg4X
         73yk6bs+wy8WXis0OsDF4vxOs7ieADU1fck2552FHzl72/BlXaM4nxPwwLcQxpMF9ulf
         n5os3yKBimyP/vcg1ehIsjjasVaTrJJpUaL/1qk/53/SURaSaj55t/6phSOROSvyCa/I
         fmEdVgeyRGiz+SovsR7wfiydSoxVCuY8DM6c5wrRi5tyrEAPNx0MBFqoBUBj4MCRPLr9
         MYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700754491; x=1701359291;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGFlvgruXhRu8yz7L9ZekLGqznWc+QZuVKrR49lhS6E=;
        b=crY52b5MBs/dv8reKwLOomRd41km18DGWwC1P9XAK3AcQMFUcm/AYydQov6L73Ujxf
         m4cpuaGW4k/yRRSGpWHyQMVorBu4XheZ28GGGx7wsrCI1gleE1E1lZmw2v6GwJ/3CD35
         mAzzQaS5Gdvs4SBxVuxuRLpmePLuZbE0Xg8p59QA1pZCqEDyo/CL37+b2pBJdQbI35Pi
         cKskf//OuFclJ7Oz5CUEphGP6OwxVPhi8g+NjwhKjlb5KtnyPomSoZVTgqzcZknBG+ZI
         C7dveu5Cee5YUYRDWcXb5ScJywKMktlZmeJgu2EG9aCo2Y0oR/7ozwt8xifCZ9eb6Af+
         j/mQ==
X-Gm-Message-State: AOJu0YxIT2lZtanhJp1h6bFXMQFVFImyqHSJ36XiAW2XUJQeKZ5fpR7W
	i7Ik/msG8DJOooBggkuvFkbzyHPOyMb5L+44akQ=
X-Google-Smtp-Source: AGHT+IGaJmhEqO/Y8HdUb2/TOpS7aETwYhgf8/09huNi6nknC6DEZo0NTNEU2jRYijP+J1qfr0f5cQ==
X-Received: by 2002:a17:906:51ca:b0:9e3:fbab:e091 with SMTP id v10-20020a17090651ca00b009e3fbabe091mr4245964ejk.15.1700754491216;
        Thu, 23 Nov 2023 07:48:11 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906481800b009920e9a3a73sm925358ejq.115.2023.11.23.07.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 07:48:10 -0800 (PST)
Message-ID: <3af25437-9329-4d2a-9558-f04cb4855e16@linaro.org>
Date: Thu, 23 Nov 2023 16:48:08 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: add AD7173
Content-Language: en-US
To: Ceclan Dumitru <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
 linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 ChiaEn Wu <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
 Mike Looijmans <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123140320.30409-1-user@HYB-hhAwRlzzMZb>
 <6882a92f-1a15-4ea5-be1e-9d56afc0ce5d@linaro.org>
 <643753e7-6f97-4c38-b21e-e95573f60f85@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <643753e7-6f97-4c38-b21e-e95573f60f85@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2023 16:11, Ceclan Dumitru wrote:
> 
> 
> On 11/23/23 16:26, Krzysztof Kozlowski wrote:
>> On 23/11/2023 15:02, mitrutzceclan wrote:
>>> +  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
>>
>> Drop "Bindings for" and instead describe hardware.
>>
> 
> Okay
> 
> ...
> 
>>> +  avdd-supply:
>>> +    description: avdd supply, can be used as reference for conversion.
>>> +
>>> +  required:
>>
>> Please test your code before sending. You ignored my comment. This has
>> both wrong indentation and wrong placement - should be after all
>> properties and patternProperties.
>>
>> Do not ignore comments but respond to them.
>>
> 
> There were no errors while testing the yaml binding (with
> DT_CHECKER_FLAGS=-m dt_binding_check - to make sure that this is how
> bindings should be tested). Indeed I did not test the yaml if the
> required properties are missing from the example. What is indicative in
> this patch that it was not tested?

Then your testing method might miss something, because as you can see -
Rob's bot found the issue.

> 
> I did not ignore your comment. I did not have questions about it. I
> missed the indentation. Sorry about that.
> 
> But about the placement of 'required': the example-schema does not have
> the exact case of pattern properties. Also, there are multiple iio/adc
> (ad4130, ad7124, ad7292) bindings that place required before
> patternProperties. I assumed that this placement is correct.
> 
> Will move it in next version.
> 
> In regards to responding to comments: if there are no questions about a
> comment and will fix in next version, should there be a response anyway
> just confirming it?

The point is that code did not change here and there was no
Ack/Done/something reply.

Best regards,
Krzysztof


