Return-Path: <linux-iio+bounces-3691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E7C88782C
	for <lists+linux-iio@lfdr.de>; Sat, 23 Mar 2024 11:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6787C1C20D26
	for <lists+linux-iio@lfdr.de>; Sat, 23 Mar 2024 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065781640B;
	Sat, 23 Mar 2024 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g8LmlDlv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B5613FEA
	for <linux-iio@vger.kernel.org>; Sat, 23 Mar 2024 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711191489; cv=none; b=N7ORI/W3c71Ax5X7vO3Gu3wcVByHHEYSUWerzGP/jJi3r0e2M4zAPfIEW2eSAnIVbtQ2Y4GP1+8X0BB9p27dFjGPc8qr042Fx92NqrWUNwecdy0WcIfiwpTiyt84c0PF4eVRgO/PZ2pV61ZQnMX0QAHEzL9xA7ctJyxiCqjc3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711191489; c=relaxed/simple;
	bh=n69ToU/bGzfYVBCPdb/s16H80OBw86Sk8GJ1YQygjQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4H8BKMmMbIRQ2/X7RQlSmN4AKQgC7h9TMRa4Af4nZJASbre2nfe2S9l8f919x7fZma+wgvQxJOPcOkw1q+FztHFCNgGtSs/wEtcip6s0bxTnNnrU/S/jSAlBgOPo+GE+AlPfJRpKJpVONik9Ch8NA6spqLtglNBM5UH11DiPrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g8LmlDlv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56bf957dbb5so312300a12.0
        for <linux-iio@vger.kernel.org>; Sat, 23 Mar 2024 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711191486; x=1711796286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JDNnuYfBg2LsQPsZLEVL1qEcxCMLm0xKdzHquFpm9cY=;
        b=g8LmlDlvSc6gdVIrR6wVJXeff8dDjY0VYXBZqjq3ZUDvc/qb6AO+bmeKNX+T823kgF
         kAJpa0FYZqc68qAMGODtmjDefZznkgo87u/2mXrDRqvRTBt3+wb2eJpoI2othQedRdFp
         kMEvmnyklGMO5i3n+GQj6GXSXY32+RAQ5cclljVRTEn4bWYfDFAnimWv3j38jPHW5r0B
         kqTRCLIeAv+q61ClInGSLhD6WijYDH3chxr8zuxBuwOqsibWpquHLmA5wOwRK3YWF8f4
         MoUuZGYD+GR8Da8l4u4Dz84mNmqGVMWbw5uROvWTGawSV6SWDguaZ0C3kIkzoQu0m/9M
         UBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711191486; x=1711796286;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDNnuYfBg2LsQPsZLEVL1qEcxCMLm0xKdzHquFpm9cY=;
        b=ZJ/39p1rjG6AH4rEVie5tdDbfk8z2vr+Gpxa2aHBG7ATp7lBHVMQUDslVNCnCQugTS
         pvXumPlFItW4F1kJPCBAQ4jcveQ8XHZ538PTcEQb0Bhvuo3CGcJhv5hDKxTl7NgIOKG3
         pVndtUFpPnyzfyQLt/vXuBCutS3LQlye+RdDOn9Y02nNJXi1vSXWQzKHLZng4bw0pSjg
         ++R8Sniby0sVKtkPRrDEpi7nQNOClIxeXzLEiupmEk4nPDCAOq44lNrnS/5JPIG4NmJk
         n//xvOCqyhx+6sUFQLRX6cktF4AJksat02AQDS4wctc/TabMQtgw3Fq4CKCDowZSKlwq
         2t+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzDs2aGRI8aZKHKCai/EsZ6VTgrvYLB6zXUtxp5wCA8npMylX/jLINyAlRzQB3QYlKkUVMF4fEHYWtx6kwLaF37tkt1BXhl04S
X-Gm-Message-State: AOJu0YyuoT9sKr1OFl54igFW+PvlBy8o/F27Ihi/aes7QhHa/oTrnW3S
	vpypeaXyr7RrIog/KscGe6unlkHTeJhACUsIfPu0kLk1ib7cHO5IJTfwRd3OCO0=
X-Google-Smtp-Source: AGHT+IGvpJx1hrtUJJNQa2vXd8FmTJjhq04TKEcEsVe7vYgGuRI7Iwrvi+VoNuxBhvV1hXnkNLMALA==
X-Received: by 2002:a50:ccc9:0:b0:568:bc48:5f27 with SMTP id b9-20020a50ccc9000000b00568bc485f27mr1351215edj.39.1711191485958;
        Sat, 23 Mar 2024 03:58:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id u8-20020aa7d888000000b0056bbf8898e7sm796706edq.54.2024.03.23.03.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 03:58:05 -0700 (PDT)
Message-ID: <17d410dd-bb9b-4962-bd53-1385d25d898b@linaro.org>
Date: Sat, 23 Mar 2024 11:58:03 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add AD4000
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Rob Herring <robh@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 jic23@kernel.org, Michael.Hennerich@analog.com, linux-kernel@vger.kernel.org
References: <cover.1711131830.git.marcelo.schmitt@analog.com>
 <81665b5f0d37d593e6d299528de8d68da8574077.1711131830.git.marcelo.schmitt@analog.com>
 <171115011818.1710405.2845384923597786826.robh@kernel.org>
 <Zf5Mhm4KRQzu9qZs@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zf5Mhm4KRQzu9qZs@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/03/2024 04:29, Marcelo Schmitt wrote:
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4000.example.dtb: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
>> 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4000.example.dtb: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
>> 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
>>
> 
> ok, adding proper #address-cells and #size-cells fixes the warning.
> 
>   '#address-cells':
>     const: 1
> 
>   '#size-cells':
>     const: 0
> 
> I'm assuming missing those in v1 doesn't hurt review so will wait for some
> feedback before sending a v2.

Hurts in a way it is a proof you did not test your binding before
sending. Performing review on untested code might be a waste of
reviewers time. Please test your code before sending it. I am not going
to perform review of untested code.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Best regards,
Krzysztof


