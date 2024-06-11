Return-Path: <linux-iio+bounces-6173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48AF903DFC
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 15:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD73281FA5
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3407717D372;
	Tue, 11 Jun 2024 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VZiwh1Wv"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1229617C221;
	Tue, 11 Jun 2024 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114026; cv=none; b=cmxSZi4Wu70aStWiSY7ZIb3A8v/FS6o9vQTFx59ocNRcZWIJXo2Iv2JMqUGz4Vz1u6MXyrDgTpCY+1nDipKdCisjwu28LNgjyBzUf/7nd4c0smbyvQGRQwZMeAeF+jZ6egVp/FFTnZTqeZJlrbj2LVPIvWLZkggcGp09Yu7wBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114026; c=relaxed/simple;
	bh=0Q4yHJdDN6fFzURbHUhwnLVXmMBVrY14VDTQpc9SOdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XwGA4+eJAFmrpu7hDlDdPJazssrDC+/j9f19DcCoMeHh9qoFVqTS77ODeBlRfY7cJjZn2xohcG/kHP6/HKTln4x/uvg5VRIFKtx9GMmhCd81OoXEGd78h4W+QKwrLsLgikY9iH3KaNLW9pFh3IEykWXBIqu+j1MV+CGK3jNAQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VZiwh1Wv; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45BDqmZc020929;
	Tue, 11 Jun 2024 08:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718113969;
	bh=EtD85aOQjnjw+uq24TpicW0xsz3EbF9jhHpe/YAcGyY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VZiwh1WvLE0TLnBz3hn2BLqTrP/d4whLjlxgUKs7U1+yRzJsCZbbknoCGGmR1iV1c
	 CG2ZgbL2xlcdVdNLB/4cX1DByba8dINIqsOn5QSih7aZ2MutT2xpBNHey8lV2+hQNr
	 isZS/DSzbCleydpbvFWy2pY9MMDH2210HkFdg6DY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45BDqmAA043441
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 08:52:48 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 08:52:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 08:52:48 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45BDqmwV089179;
	Tue, 11 Jun 2024 08:52:48 -0500
Message-ID: <3c87646c-a247-4b0e-a052-a294b87aeae1@ti.com>
Date: Tue, 11 Jun 2024 08:52:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob
 Herring <robh@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        David
 Lechner <david@lechnology.com>, Nishanth Menon <nm@ti.com>,
        William Breathitt
 Gray <wbg@kernel.org>
References: <20240610144637.477954-1-jm@ti.com>
 <20240610144637.477954-2-jm@ti.com>
 <5ad5cf7a-c5c6-449e-9ed9-3d9f74959a19@linaro.org>
 <01433df1-aa19-4abb-9d87-c54e4c0dff17@ti.com>
 <b72164f9-1b1b-4329-8d4a-66fc626c45fe@linaro.org>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <b72164f9-1b1b-4329-8d4a-66fc626c45fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 6/11/24 1:51 AM, Krzysztof Kozlowski wrote:
> On 11/06/2024 00:13, Judith Mendez wrote:
>>
>> Hi Krzysztof,
>>
>> On 6/10/24 9:58 AM, Krzysztof Kozlowski wrote:
>>> On 10/06/2024 16:46, Judith Mendez wrote:
>>>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>>>> uses this compatible, require power-domains property.
>>>>
>>>> Since there is only one functional and interface clock for eqep,
>>>> clock-names is not really required, so removed from required
>>>> section, make it optional for ti,am3352-eqep compatible, and
>>>> update the example.
>>>>
>>>
>>> ...
>>>
>>>
>>>>            interrupts = <79>;
>>>>        };
>>>>    
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>>> +
>>>> +    bus {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +        eqep1: counter@23210000 {
>>>
>>> No need for label
>>>
>>>> +          compatible = "ti,am62-eqep";
>>>> +          reg = <0x00 0x23210000 0x00 0x100>;
>>>> +          power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
>>>> +          clocks = <&k3_clks 60 0>;
>>>> +          interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
>>>> +          status = "disabled";
>>>
>>> Drop... which also points to another comment - since this was no-op and
>>> example is basically the same, then just don't add it. No point.
>>
>> Ok, then I will drop the new example, thanks.
>>
>> BTW..
>> In the existing example for ti,am3352-eqep compatible,
>> do you know if it is appropriate to drop clock-names
>> from the example if it is no longer required?
>>
> 
> It does not really matter.
> 
Understood, thanks.

> Best regards,
> Krzysztof
> 


