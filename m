Return-Path: <linux-iio+bounces-21656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B2B05130
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 07:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931AC1AA7F1A
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 05:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4B2D0C6C;
	Tue, 15 Jul 2025 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="aIH7JRcB"
X-Original-To: linux-iio@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B069D2B;
	Tue, 15 Jul 2025 05:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558410; cv=none; b=s1rR22f24Qzlufc4Zg/eb4aWq2r/kQmmA9Ps+skDF5fBqU+b1rMy4PnjgXe5+PxjfNmHWsFxb+uihiqJx7ZS4Zh3PB2wy6u+7xeFPc4dloLmp4iU/ldtTeaXVRFm76wlts+Bq2YTgiAM/bU0mY7NAWU6AGfyqB0i7wNLNKbjNkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558410; c=relaxed/simple;
	bh=g8ObzbtsLMh6hIRHoS8hWGgVk9t7E1qWN/EE5RDZ0Ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLcqVk5eqM3BizJHbZmQO8qxYiXwXX9RHKrHhtRNc26C57CjmbeJXca5DhtRbUCX5J+Gg6VVtBgP7Jn9SFrrjOu0jj5cFxczVyPdjy7Ev0bpp2y3DWlfUz/mChOC2kaammvvq//oxh8xQHoi78BPOAiVXsXM/N29yAFPx5y7cdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=aIH7JRcB; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kB2cLJNy4hPYhqXCKFroTjovGqdHkjo6jWxolFG5Rks=; b=aIH7JRcBnFaTDYDYU0B/+YjYO1
	Z1AivAp6BGemuHi/coTdiNbfy5cJLpV80/vxnQiEqnMSTvkkJqIAMxBpM1ubIIIBCNWRyWJm/j3Kr
	FYsMoE4rw7HBQah/RnPQkcXpw+W1lhUwBfLQkCBDkd8ysFhki0gnEhPhvHKxcOz0Wb8eidC9oACAn
	47bAUJsrC5VhNd5s+jyYorwO5ORVD/q+r4muR10gIJDNLaf0xWK44U3yMN4QMJNr6qq7c0rDnNpU+
	JiC+D+ly8vSZTQSs4iUnTb8EOu16nB9YCO5fwHkkTPiotPsWIyFkpQlsmUTSb4S4LjKorw/+YafA2
	LChQLk2A==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:33050 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1ubYV3-003pbU-2v;
	Tue, 15 Jul 2025 07:46:45 +0200
Message-ID: <c9d17343-e4a5-49ab-9a3e-b6da9d591195@norik.com>
Date: Tue, 15 Jul 2025 07:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Haibo Chen <haibo.chen@nxp.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 upstream@lists.phytec.de, andrej.picej@norik.com
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-2-primoz.fiser@norik.com>
 <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
 <20250713160247.0f22bbfe@jic23-huawei>
 <de2c8e15-14e9-4c61-9a13-97ef1ec567a4@norik.com>
 <6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Nuno,

On 14. 07. 25 18:11, Nuno Sá wrote:
> On Mon, 2025-07-14 at 07:56 +0200, Primoz Fiser wrote:
>> Hi all,
>>
>> On 13. 07. 25 17:02, Jonathan Cameron wrote:
>>> On Thu, 10 Jul 2025 10:46:44 -0500
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>
>>>> On 7/10/25 2:39 AM, Primoz Fiser wrote:
>>>>> From: Andrej Picej <andrej.picej@norik.com>
>>>>>
>>>>> Document i.MX93 ADC calibration properties and how to set them.
>>>>>
>>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>>>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>>>>> ---
>>>>>  .../bindings/iio/adc/nxp,imx93-adc.yaml       | 21 +++++++++++++++++++
>>>>>  1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-
>>>>> adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> index c2e5ff418920..d1c04cf85fe6 100644
>>>>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>> @@ -52,6 +52,27 @@ properties:
>>>>>    "#io-channel-cells":
>>>>>      const: 1
>>>>>  
>>>>> +  nxp,calib-avg-en:
>>>>> +    default: 1
>>>>> +    description:
>>>>> +      Enable or disable calibration averaging function (AVGEN).
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum: [ 0, 1 ]
>>>>> +
>>>>> +  nxp,calib-nr-samples:
>>>>> +    default: 512
>>>>> +    description:
>>>>> +      Selects number of samples (NRSMPL) to be used during calibration.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum: [ 16, 32, 128, 512 ]
>>>
>>> Allow 1 as a value and drop the enabled above.   Averaging over 1 sample
>>> is same as no averaging and gives simpler binding.
>>>
>>>>> +
>>>>> +  nxp,calib-t-sample:
>>>>> +    default: 22
>>>>> +    description:
>>>>> +      Selects sample time (TSAMP) of calibration conversions in ADC
>>>>> clock cycles
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum: [ 8, 16, 22, 32 ]
>>>>> +
>>>>>  required:
>>>>>    - compatible
>>>>>    - reg  
>>>>
>>>> This seem like things that should be set at runtime rather than
>>>> in the devicetree. Unless there is some justification on why
>>>> these values depend on how the chip is wired up?
>>
>> It depends how ADC 1.8V Vref is wired up, especially how noisy it is.
>>
>>>
>>> Further to that, I'd like to see some explanation of why we care
>>> to change it at all. Is it ever a bad idea to enable averaging and
>>> pick a large number of samples for calibration?
>>
>> This is a snippet from the i.MX93 TRM, chapter Analog-to-Digital
>> Converter (SAR_ADC) describing calibration steps:
>>
>> 1. Wait for deassertion of functional reset.
>> 2. Configure SAR controller operating clock (MCR[ADCLKSE] = 0).
>> 3. Bring ADC out of Power-down state (MCR[PWDN] = 0).
>> 4. Configure desired calibration settings (default values kept for
>> highest accuracy maximum time).
>> • MCR[TSAMP]: Sample time for calibration conversion
>> • MCR[NRSMPL]: Number of samples in averaging
>> • MCR[AVGEN]: Averaging function enable in calibration
>> 5. Run calibration by writing a one to MCR[CALSTART].
>> 6. Check calibration run status in MSR[CALBUSY]—wait until MSR[CALBUSY]
>> = 0; alternatively, MSR[ADCSTAT] can be
>> used to check status.
>> 7. Check calibration pass/fail status in MSR[CALFAIL] field. If
>> MSR[CALFAIL] = 1 then calibration failed. Detailed status
>> can be checked in CALSTAT.
>>
>>
>> See point 4).
>>
>> Not sure why would there be an option to configure i.MX93 ADC
>> calibration parameters if one use-case (max accuracy max time) to rule
>> them all?
>>
> 
> Sometimes HW guys just want to give you some options. Does not mean we have to
> use them all :).
> 
> I guess what Jonathan is interested in, is to understand in what conditions the
> defaults are no good for the calibration? If we can have a set of values that
> should pretty much always work, no need to further complicate the bindings or
> the driver.

In case you have a noisy Vref you can adjust the parameters to pass the
calibration and have a working ADC.

The trade-off is a less precise ADC but at least a working one.

In ideal case you would have Vref supplied by the dedicated LDO and tons
of decoupling caps, but in real-world you have it connected to a noisy
SMPS and you need to adjust the parameters accordingly.

That's it :)

BR,
Primoz

-- 
Primoz Fiser
phone: +386-41-390-545
email: primoz.fiser@norik.com
--
Norik systems d.o.o.
Your embedded software partner
Slovenia, EU
phone: +386-41-540-545
email: info@norik.com

