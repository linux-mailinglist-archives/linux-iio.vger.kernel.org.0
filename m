Return-Path: <linux-iio+bounces-22370-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A8B1D1C8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 07:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE533A8DCF
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 05:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E71F542E;
	Thu,  7 Aug 2025 05:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="QmRBNN0h"
X-Original-To: linux-iio@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B121F4E57;
	Thu,  7 Aug 2025 05:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754542812; cv=none; b=m58xdVasBZWAi+G0X35uSsvr4hcs4Ea6MB9xocE1GbRBP4b3p2/u15f92/N2K0303en8lz5EZiCNO2MnHEf0IoXoqiACDn3wZAOwz1uz388fT+UItkj1zmhNZzbxQoSzu7gsH57A6gk3KgW033/AD0rZEoqr0Ig/bYrm8fuYb5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754542812; c=relaxed/simple;
	bh=yOYzFohhd2o0XfNFY9p4eemwAkmIDupzEGpfmoODdWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umOpaGIYCs6gQLukiFK0OEma664umqz0XsqT3HdHQdpDqJyxa5yOIAjBRQHtM3NEH9AtsLuE2Shg3mvhdxRmU+z5usGn9Qa4hdhmBnIo4I4Ni647Mb0s2ZfQXjW+L6633jLoZ/+mPVaBDB6t92iBBKIChRSNOoR5Xxvyp1BE5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=QmRBNN0h; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PBcZyW0XcKbk668IHk0f4cPCJPghlABu1S2hNa+xTlg=; b=QmRBNN0hK8PStTUgV85T22s04e
	WgqmOQqb5nXuQpUSPTVtrFJ4jwiyUDSLnFrlT34DlyUR3XY45NEjHReEKGI2+lJXn1WLnYRsxNcQ8
	dwG7cMEsEbcdG47oMPalE/S5HHg283Q+9m3utRi0MqnjIaR1F+qHTI0dOtmMLdSzuDLM3OZbEMw5d
	dK7GxCyKLtc+lKuORHZHR7jbgc1HMtvgCtR1T5dsJuPQ3dDXntI4A5Ua+bHG/6eXp4v7eDFdBHAPM
	0RU/NegtPqNNHBDxRdomtCd3n/2M/ge8X0tlWJqU+5zCB7D52m21lvCgDG4Ldhlv+kTlTOyIhPdS3
	ysVTpW6A==;
Received: from [89.212.21.243] (port=38786 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1ujsNe-00BlMl-0p;
	Thu, 07 Aug 2025 06:37:29 +0200
Message-ID: <19634e51-0568-421a-a3c4-b9988c2ccfb1@norik.com>
Date: Thu, 7 Aug 2025 06:37:27 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
To: Bough Chen <haibo.chen@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Nuno S? <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "andrej.picej@norik.com" <andrej.picej@norik.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-2-primoz.fiser@norik.com>
 <2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
 <20250713160247.0f22bbfe@jic23-huawei>
 <de2c8e15-14e9-4c61-9a13-97ef1ec567a4@norik.com>
 <6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
 <20250721093847.GD4844@nxa18884-linux.ap.freescale.net>
 <DU0PR04MB9496FCE8DF07CD0E270B72AF905DA@DU0PR04MB9496.eurprd04.prod.outlook.com>
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
In-Reply-To: <DU0PR04MB9496FCE8DF07CD0E270B72AF905DA@DU0PR04MB9496.eurprd04.prod.outlook.com>
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

Hi,

On 21. 07. 25 11:09, Bough Chen wrote:
>> -----Original Message-----
>> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
>> Sent: 2025年7月21日 17:39
>> To: Nuno S? <noname.nuno@gmail.com>
>> Cc: Primoz Fiser <primoz.fiser@norik.com>; Jonathan Cameron
>> <jic23@kernel.org>; David Lechner <dlechner@baylibre.com>; Bough Chen
>> <haibo.chen@nxp.com>; Nuno Sa <nuno.sa@analog.com>; Andy Shevchenko
>> <andy@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
>> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
>> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
>> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
>> <festevam@gmail.com>; linux-iio@vger.kernel.org; imx@lists.linux.dev;
>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; upstream@lists.phytec.de;
>> andrej.picej@norik.com
>> Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration properties
>>
>> On Mon, Jul 14, 2025 at 05:11:31PM +0100, Nuno S? wrote:
>>> On Mon, 2025-07-14 at 07:56 +0200, Primoz Fiser wrote:
>>>> Hi all,
>>>>
>>>> On 13. 07. 25 17:02, Jonathan Cameron wrote:
>>>>> On Thu, 10 Jul 2025 10:46:44 -0500
>>>>> David Lechner <dlechner@baylibre.com> wrote:
>>>>>
>>>>>> On 7/10/25 2:39 AM, Primoz Fiser wrote:
>>>>>>> From: Andrej Picej <andrej.picej@norik.com>
>>>>>>>
>>>>>>> Document i.MX93 ADC calibration properties and how to set them.
>>>>>>>
>>>>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
>>>>>>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>>>>>>> ---
>>>>>>> ??.../bindings/iio/adc/nxp,imx93-adc.yaml???????????? | 21
>>>>>>> +++++++++++++++++++
>>>>>>> ??1 file changed, 21 insertions(+)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-
>>>>>>> adc.yaml
>>>>>>> b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>>> index c2e5ff418920..d1c04cf85fe6 100644
>>>>>>> ---
>>>>>>> a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.y
>>>>>>> +++ aml
>>>>>>> @@ -52,6 +52,27 @@ properties:
>>>>>>> ???? "#io-channel-cells":
>>>>>>> ???????? const: 1
>>>>>>> ??
>>>>>>> +?? nxp,calib-avg-en:
>>>>>>> +?????? default: 1
>>>>>>> +?????? description:
>>>>>>> +?????????? Enable or disable calibration averaging function (AVGEN).
>>>>>>> +?????? $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +?????? enum: [ 0, 1 ]
>>>>>>> +
>>>>>>> +?? nxp,calib-nr-samples:
>>>>>>> +?????? default: 512
>>>>>>> +?????? description:
>>>>>>> +?????????? Selects number of samples (NRSMPL) to be used during
>> calibration.
>>>>>>> +?????? $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +?????? enum: [ 16, 32, 128, 512 ]
>>>>>
>>>>> Allow 1 as a value and drop the enabled above.???? Averaging over 1
>>>>> sample is same as no averaging and gives simpler binding.
>>>>>
>>>>>>> +
>>>>>>> +?? nxp,calib-t-sample:
>>>>>>> +?????? default: 22
>>>>>>> +?????? description:
>>>>>>> +?????????? Selects sample time (TSAMP) of calibration
>>>>>>> +conversions in ADC
>>>>>>> clock cycles
>>>>>>> +?????? $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>> +?????? enum: [ 8, 16, 22, 32 ]
>>>>>>> +
>>>>>>> ??required:
>>>>>>> ???? - compatible
>>>>>>> ???? - reg??
>>>>>>
>>>>>> This seem like things that should be set at runtime rather than
>>>>>> in the devicetree. Unless there is some justification on why
>>>>>> these values depend on how the chip is wired up?
>>>>
>>>> It depends how ADC 1.8V Vref is wired up, especially how noisy it is.
>>>>
>>>>>
>>>>> Further to that, I'd like to see some explanation of why we care to
>>>>> change it at all. Is it ever a bad idea to enable averaging and
>>>>> pick a large number of samples for calibration?
>>>>
>>>> This is a snippet from the i.MX93 TRM, chapter Analog-to-Digital
>>>> Converter (SAR_ADC) describing calibration steps:
>>>>
>>>> 1. Wait for deassertion of functional reset.
>>>> 2. Configure SAR controller operating clock (MCR[ADCLKSE] = 0).
>>>> 3. Bring ADC out of Power-down state (MCR[PWDN] = 0).
>>>> 4. Configure desired calibration settings (default values kept for
>>>> highest accuracy maximum time).
>>>> ??? MCR[TSAMP]: Sample time for calibration conversion ???
>>>> MCR[NRSMPL]: Number of samples in averaging ??? MCR[AVGEN]: Averaging
>>>> function enable in calibration 5. Run calibration by writing a one to
>>>> MCR[CALSTART].
>>>> 6. Check calibration run status in MSR[CALBUSY]???wait until
>>>> MSR[CALBUSY] = 0; alternatively, MSR[ADCSTAT] can be used to check
>>>> status.
>>>> 7. Check calibration pass/fail status in MSR[CALFAIL] field. If
>>>> MSR[CALFAIL] = 1 then calibration failed. Detailed status can be
>>>> checked in CALSTAT.
>>>>
>>>>
>>>> See point 4).
>>>>
>>>> Not sure why would there be an option to configure i.MX93 ADC
>>>> calibration parameters if one use-case (max accuracy max time) to
>>>> rule them all?
>>>>
>>>
>>> Sometimes HW guys just want to give you some options. Does not mean we
>>> have to use them all :).
>>>
>>> I guess what Jonathan is interested in, is to understand in what
>>> conditions the defaults are no good for the calibration? If we can have
>>> a set of values that should pretty much always work, no need to further
>>> complicate the bindings or the driver.
>>
>> Just my understanding, it is hard to use one fixed settings to fit all kinds of
>> conditions.
>>
>>                  Noise induced from PCB tracks  Electro- magnetic noise
>> 		     |                           |
>> 		     V                           V
>>  ---------
>> |SOC(ADC)|   <---------------------------------<- (~) external Signal
>>  ---------
>>                  ^                 ^
>>                  |                 |
>>              I/O coupled noise    Internal noise
>>
>>
>> So OEM A's board may needs different settings compared with OEM B's board.
> 
> The noise on Vref did impact the calibration, we did get report from customer, and IC guys suggested to do like the following patch, what's your comments?
> 
> https://patchwork.kernel.org/project/linux-iio/patch/20250423-adcpatch-v1-1-b0e84c27ae98@nxp.com/

With this patch we still get calibration warning however ADC is
eventually working.

Where can we get mapping for this register:

#define IMX93_ADC_CALCFG0	0X3A0

It seems that public i.MX 93 TRM goes up to offset 0x39C only?

BR,
Primoz

> 
> Regards
> Haibo Chen 
>>
>> Regards,
>> Peng
>>
>>>
>>> - Nuno S??
>>>> On the other hand, public TRM doesn't give much more information and
>>>>>

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

