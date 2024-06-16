Return-Path: <linux-iio+bounces-6321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EC3909C56
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4225E1C20A45
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2024 07:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A59F17B41E;
	Sun, 16 Jun 2024 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aThcDw+q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487B16D32D;
	Sun, 16 Jun 2024 07:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718524041; cv=none; b=eV09mC959SINZJpBJZ9qOsKZYt1dvDw/HPCiNnrKIW/+q5isUAQC3xbtu8I1AtHnuaxKQTb0qkmQT3M4i1uLQpgG6HbQn+xEX4jk70IEFM+5CDDbjpFZ83PZH9IOBKfsxGCGSw81rr2kk/NeE83wRkL1CKAI2b+6v7pD5pCof0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718524041; c=relaxed/simple;
	bh=7batiA/eT9TlJ61yp8gwhpv8o2ZrBq6dRG6VImrvxsE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LFr/GsafMDlrHWiK3KfrncxDtsqGY0zgIoonvlGS+qxDlc+JXDgX9zPKzroKQ737lF2tI9uVv090aUMNa5FYVNPcseeF8ZdKNtSnlRwNpytzZcJLSUn6xsSJ1joj4qbIMqhcJwPOylNfnKOPIwFeAC0/eAhH5EXjVU1b0cn62Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aThcDw+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B60DC2BBFC;
	Sun, 16 Jun 2024 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718524040;
	bh=7batiA/eT9TlJ61yp8gwhpv8o2ZrBq6dRG6VImrvxsE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=aThcDw+qUsLKIqqTfN64AlUckdqC7YYGsIfSMQd6iDZJwPLtBGw+U659fYybu/oX5
	 UrhH7DkDvgHfTcnBXvSCM1J1nArKVUynh7U8WP9bpqMoG2XOcMCK+hPQxkWDIQb5iT
	 WemIPIn+0WF594n3UNxLjJ1x79ff3C7Lv5hgUvH0s7It5AjrX7jvi4WaeCY8Dp/iqZ
	 rw/27JFm9amfhw7um7HxuHYSohqBS1l2Ic/TJ8q7KTH5/39KZinvcla9a7IOBz8UwG
	 /SY9/zIaQmTeCU9RZxB2CEZWBG9qWZFmlQUhJ8IiP+fNnX8SQQ3iNda4ogSWkS5UK7
	 7Uv9ye4MG129g==
Message-ID: <18b7ea5a-ea10-47b6-9d86-9dcec50e5f9e@kernel.org>
Date: Sun, 16 Jun 2024 09:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dt-bindings:iio:proximity: Add hx9031as binding
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>, jic23@kernel.org
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
References: <20240511170143.7ca6a410@jic23-huawei>
 <20240514202540.341103-1-yasin.lee.x@outlook.com>
 <SN7PR12MB81012845A114E1FE7C49DFC3A4E32@SN7PR12MB8101.namprd12.prod.outlook.com>
 <29fa61c3-f7c7-4769-a5eb-75783086cb9f@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <29fa61c3-f7c7-4769-a5eb-75783086cb9f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2024 10:06, Krzysztof Kozlowski wrote:
> On 14/05/2024 22:25, Yasin Lee wrote:
>> From: Yasin Lee <yasin.lee.x@gmail.com>
>>
>> A capacitive proximity sensor with 5 channels
>>
>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.

Did you implement this?

> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Did you implement this?

> 
> Subject: missing spaces. See  `git log --oneline -- DIRECTORY_OR_FILE`
> on the directory your patch is touching.

Did you implement this?


> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline), work on fork of kernel
> (don't, instead use mainline) or you ignore some maintainers (really
> don't). Just use b4 and everything should be fine, although remember
> about `b4 prep --auto-to-cc` if you added new patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.

Did you implement this?


> 
> Limited review follows.
> 
>> ---
>>  .../bindings/iio/proximity/tyhx,hx9031as.yaml | 60 +++++++++++++++++++
>>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
>> new file mode 100644
>> index 000000000000..62a71c0c4d04
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9031as.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9031as.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Tyhx's HX9031AS capacitive proximity sensor
>> +
>> +maintainers:
>> +  - Yasin Lee <yasin.lee.x@gmail.com>
>> +
>> +description: |
>> +  Tyhx's HX9031AS proximity sensor.
>> +
>> +allOf:
>> +  - $ref: /schemas/iio/iio.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: tyhx,hx9031as
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description:
>> +      Generated by device to announce preceding read request has finished
>> +      and data is available or that a close/far proximity event has happened.
>> +    maxItems: 1
>> +
>> +  vdd-supply:
>> +    description: Main power supply
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      hx9031as@2a {
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Did you implement this?

> 
> 
>> +        compatible = "tyhx,hx9031as";
>> +        reg = <0x2a>;
>> +        interrupt-parent = <&pio>;
>> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING 16 0>;
>> +        vdd-supply = <&pp3300_a>;
>> +        status = "okay";
> 
> Drop

Did you implement this?

> 
>> +      };
>> +    };
>> +
>> +
>> +
>> +
>> +
>> +
> 
> Drop useless blank lines...

Did you implement this?


Best regards,
Krzysztof


