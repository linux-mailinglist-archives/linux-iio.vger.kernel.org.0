Return-Path: <linux-iio+bounces-21293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83AAF740F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A201888A48
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EB2E5417;
	Thu,  3 Jul 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0QF0w4f+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D772E3B0F
	for <linux-iio@vger.kernel.org>; Thu,  3 Jul 2025 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545693; cv=none; b=cJdMfqgUGUTaloD1fXA3naa2190lMOeewf9SPzsqhMyZTJFX0IumyYlm4psAuEajsRMIZDOqdxvF9XB6dBNEG9nA77GANrf7BB/Ay14Q2KkIHqonh4MrhhjvY4C8Wo7wInha2ElHohzYLCiU1WQZXzRELPO+l2SR4Il6Cowdt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545693; c=relaxed/simple;
	bh=PtpH5wJVqKYW0rZnDY/be1PL8Rh1jP1zsGBqF++aL/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StPXMEH2e57vrVg7GuPHy5rIIa6rQcL1xAeekCh3IdoDMCEhgbyZkoN2tvi+0VwHiB7yZu3LfkIlYeLJIUWww3ZmBSdXW6pF+ozoUJIlLX2rca9Wxu695IZlb+V2tzbu47lOT4YWE8go19FJ0gkoeo27EA04TRdqqvbSWFDsrow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0QF0w4f+; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4079f80ff0fso644909b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Jul 2025 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751545690; x=1752150490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQOX2bCYGxP3nqwfchundKWBgCNNg0w16agVTjZVQEI=;
        b=0QF0w4f+fw8UC700Wv7UJ+VBlcMTygaM7mZjBnb58RZFwXrMOSy6xDCQp8oNaevcbj
         4vCXTMMEeLsaEjis2iSS4RaATrQjK6j8sQ25z/xfjzxbRN7fnEHIqNiCXSImjL2oKPvL
         a5BZpAURQHLsQqC68qRP5zGK5CUe8OlL9WY/zLY7VMsRR/mDDjXIWVl3h/Ck+afkH2y/
         WhgZFU2Ju31VnTQl6KHCzffl+wz7ky20huPN+cSb1luwFhfL23WzkrUcHNjey8cArkEr
         k80EfZOVwOarv87EnuEPSeyOAVIJjUPfrL/ea8Wob4T3rygOt4+wsFODSxtPFMhm5htF
         XmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545690; x=1752150490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQOX2bCYGxP3nqwfchundKWBgCNNg0w16agVTjZVQEI=;
        b=pdxH5fBLgi1l48mvukTczW/gZwcMc1hJjxpzbd+H4Wyp4irw7VVBN1g/w3nY/sdswn
         qilHNEbL0I1p+tA2/xbnxA3OeXWcNQ/7tlwzNTvxQQ7aMajiD82gXSTmmwdYaRfV4fMo
         xCI5sRkSm+B/y6sTc/ZZJF90gDHgbk/RBTfRCayGj/0hzRimjvGhzv390+h5E+0LWmHs
         5LEj8vOZRPrieTmoTcheEQ7fAOOa9gdXyWNJ5gnEwBfmHyWmEQbxWmk1HLvcMqlpXl2E
         9NGjlKGNSiFDh1Yp0Ev7synXcnEg8f5Y7et7EW9erVFb090YmJvoCkjhcAQsvrH2a5m0
         3NdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEmTZmlnbOIaLnXJ3W43ySVsbdEl9zx8OVVNSLpCRZ6XCfNm7V11HeolvBPfhxwbw18E4j2glKbX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlo/raMZ2zONgteKIUkAMIiUzbXVFp3aTztjNeDFClzsvm2RyW
	qfnYiqlGPlH25B0aiB/s29ZPbYrSM8rcvmbHeZWpTRz612rY11YiSoir+kuOV+FKwd5XSY6sCRk
	sGLVAk3k=
X-Gm-Gg: ASbGncvUsWDRlniAdJO9GFDfYvB1r5WIteZJurea7TdnqdjoruyfzfJULHD/KaXCN1V
	vAdOIv5XS7FBZ3j0u9nYbKsVy9f4JYlot7cB3o8UFwE4aCqn5ourwRsrQ5dz7nmB1gPbSKQgK25
	b7OaiO2kqIEzOC1NZuzbu02tP/+U6r4cO1r704P6gNhowirjKBmIJz+x4Lozbnl1zfO5tIWWK2W
	a+OJLap9VNlniEvwr0j9tJ7awp/s97kFDWSMH+CIN56+1TDZevCeLUKwOtKt/hljvPGSC2x2Oui
	hyMuxfIwIAgKRdrvAQWhz2GsSK8jDmL3naoXCqvb4jJRdQZuE/EIhukgpHwbbiddMS2HugF+dg1
	nnlYA/aBkazWQN9KihCPAPytH+et/HSaLncRjwVs=
X-Google-Smtp-Source: AGHT+IGqc5LcxnZGH4pFB8Kic92Bfiq8ngbiGeDjZRrypBSEyQOjixQHs54dBB6M5/TaIr4sv7Kp7A==
X-Received: by 2002:a05:6808:2e47:b0:3fe:aebe:dde7 with SMTP id 5614622812f47-40cf2f297a2mr1385913b6e.2.1751545689623;
        Thu, 03 Jul 2025 05:28:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5c00:24f0:997b:5458? ([2600:8803:e7e4:1d00:5c00:24f0:997b:5458])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b32421047sm2955454b6e.41.2025.07.03.05.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 05:28:09 -0700 (PDT)
Message-ID: <b0b0443d-143f-4e41-b8b8-91c6726e838f@baylibre.com>
Date: Thu, 3 Jul 2025 07:28:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the iio tree with the spi tree
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 linux-iio@vger.kernel.org
References: <20250703163824.2f08d866@canb.auug.org.au>
 <20250703093122.00000684@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250703093122.00000684@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/25 3:31 AM, Jonathan Cameron wrote:
> On Thu, 3 Jul 2025 16:38:24 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> Hi all,
>>
>> Today's linux-next merge of the iio tree got a conflict in:
>>
>>   MAINTAINERS
>>
>> between commit:
>>
>>   e47a324d6f07 ("dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI")
>>
>> from the spi tree and commit:
>>
>>   0dd88eaa7126 ("dt-bindings: trigger-source: add generic GPIO trigger source")
>>
>> from the iio tree.
>>
>> I fixed it up (see below) and can carry the fix as necessary. This
>> is now fixed as far as linux-next is concerned, but any non trivial
>> conflicts should be mentioned to your upstream maintainer when your tree
>> is submitted for merging.  You may also want to consider cooperating
>> with the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
>>
> Thanks Stephen,
> 
> David, do you prefer these merged or kept as separate entries?

Ah, shoot, I forgot that we had added the gpio one and just made
one section like this.

I think it would make sense to also merge the new adi one with
the reset to keep things compact.

> 
> I don't think it matters either way in practice though this is the
> more complex merge (the other being just putting the blocks in order.
> 
> We can put a note in the pull request on preference but ultimately Linus
> will resolve this however he prefers! 
> 
> Jonathan
> 
> 
>> -- 
>> Cheers,
>> Stephen Rothwell
>>
>> diff --cc MAINTAINERS
>> index dd764b947dab,d0809d62ff48..000000000000
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@@ -25333,19 -25201,15 +25341,20 @@@ TRADITIONAL CHINESE DOCUMENTATIO
>>   M:	Hu Haowen <2023002089@link.tyut.edu.cn>
>>   S:	Maintained
>>   W:	https://github.com/srcres258/linux-doc
>>  -T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>>  +T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
>>   F:	Documentation/translations/zh_TW/
>>   
>> + TRIGGER SOURCE
>> + M:	David Lechner <dlechner@baylibre.com>
>> + S:	Maintained
>> + F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
>> + F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
>> + 
>>  +TRIGGER SOURCE - ADI UTIL SIGMA DELTA SPI
>>  +M:	David Lechner <dlechner@baylibre.com>
>>  +S:	Maintained
>>  +F:	Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
>>  +
>> - TRIGGER SOURCE - PWM
>> - M:	David Lechner <dlechner@baylibre.com>
>> - S:	Maintained
>> - F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
>> - 
>>   TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
>>   M:	Dan Williams <dan.j.williams@intel.com>
>>   L:	linux-coco@lists.linux.dev


