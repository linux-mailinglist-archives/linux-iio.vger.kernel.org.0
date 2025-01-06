Return-Path: <linux-iio+bounces-13932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F41A023AA
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 11:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CBD18824D5
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A861DC98B;
	Mon,  6 Jan 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqoUdcns"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E61DACBE;
	Mon,  6 Jan 2025 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736161147; cv=none; b=eG/QmisK/WtmsT6z78R1SF8IfM4bXn895SQhkt55NGQSoVNWc3H/FBUcF+t5QA4gRleyYZ+PyARIRpNfW7IE2PStfjK3Mla11uNy4Hn4wcHzldDe3vYkKev3041yc/aAV/RNn0rorQU/wKIbPNmYBobCuswVUP/7EGtvN++JS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736161147; c=relaxed/simple;
	bh=sPnK4NincK9ONjdqEGtqrcdtTHIRO612NkOB1/BvDOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpkxD8ebE8ZWymdntsij7hgXibNdWEoVcw+MtNB1GdhL8y4Ohf1Tw3MPCs3/qxL3a5bhQ1oj1Q6ejPL6bBvlhh5rgJbXzJVPZZghOlkHq4f2ag9FtP58Ko1daufN6mRE51kilzlLU5D1bcl396NTg7YJuG1MAvXbkoF49uKHesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqoUdcns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC94BC4CEDD;
	Mon,  6 Jan 2025 10:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736161146;
	bh=sPnK4NincK9ONjdqEGtqrcdtTHIRO612NkOB1/BvDOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EqoUdcnsg+VIh+OkW0itMm9HUHRBuiX251fwQ8fEl0m9x5iNaWZuW0UGnwkniy3wr
	 5/oi/UbCIXtHUJ5Ih4YtuU9mWo92dvnApo0grsjfYPnGMNuBvFkRzhKH6N/i9lZzPp
	 0oUlwiWN21LKuYDQGkEt2qEEoGeI/FR/mjSfrxl+q4v3NqotfbqgonMsA4lwznQbI3
	 BF4Y04Qr7GGkrj2s8oE4YPqqA/bMpX/8KMwLUH1GeOfMySj6ZA8A4oyPGWs/r4Wt6n
	 S+fBA0BDMoCoylextHETj8UX4qt3P7fyGeF9Ote0BVdt4ugZlaGcvf5XiIiANucLjF
	 ZcURZ/V6r15Zw==
Message-ID: <ef13cebd-6772-4d03-8677-a6a2d4884d77@kernel.org>
Date: Mon, 6 Jan 2025 11:58:54 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 javier.carrasco.cruz@gmail.com, andriy.shevchenko@linux.intel.com,
 marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
 mitrutzceclan@gmail.com, tgamblin@baylibre.com, matteomartelli3@gmail.com,
 alisadariana@gmail.com, gstols@baylibre.com, thomas.bonnefille@bootlin.com,
 herve.codina@bootlin.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
 <20241226055313.2841977-2-j2anfernee@gmail.com>
 <lfthwnvwodqogsk446r5nzpmjunfnpdv33xmaookedwjgpdu4n@llvla6siyl5f>
 <CA+4VgcK_9_YD0d7LUKbxU6yd3Qo9RT4yNbi90mMN=kK0LHXwow@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CA+4VgcK_9_YD0d7LUKbxU6yd3Qo9RT4yNbi90mMN=kK0LHXwow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/01/2025 08:22, Yu-Hsian Yang wrote:
>>> ---
>>>  .../bindings/iio/adc/nuvoton,nct7201.yaml     | 49 +++++++++++++++++++
>>>  MAINTAINERS                                   |  1 +
>>>  2 files changed, 50 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
>>> new file mode 100644
>>> index 000000000000..08b52258e4af
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
>>> @@ -0,0 +1,49 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/nuvoton,nct7201.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Nuvoton nct7201 and similar ADCs
>>> +
>>> +maintainers:
>>> +  - Eason Yang <j2anfernee@gmail.com>
>>> +
>>> +description: |
>>> +   Family of ADCs with i2c interface.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - nuvoton,nct7201
>>> +      - nuvoton,nct7202
>>
>> Devices aren't compatible? Explain in the commit msg why they aren't or
>> use proper compatibility (oneOf, see numerous other bindings or example-schema).
>>
>>
> 
> +  compatible:
> -    enum:
> -      - nuvoton,nct7201
> -      - nuvoton,nct7202
> +    oneOf:
> +      - const: nuvoton,nct7201
> +      - const: nuvoton,nct7202


Nothing improved. I referenced 'oneOf' for the case of compatibility.
Don't use it to code enum in different way.

Address the comment and questions. You did not respond to several
comments, so I assume you are going to implement/fix all of pointed out
things.

Best regards,
Krzysztof

