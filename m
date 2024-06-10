Return-Path: <linux-iio+bounces-6170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9DB902B67
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 00:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A235C284B76
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 22:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4F115098A;
	Mon, 10 Jun 2024 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mPtzH5VD"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4F14F11E;
	Mon, 10 Jun 2024 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718057703; cv=none; b=jATy/IkwhYywTsqM5CnLcUaLNcGPr23rdTqHeLKkPfG6Gkl6aRjp/nlGX2S1cS06abWqVLhJsHDcLTAThvlT0y2H4PxienzammFr512akXaPFf/PmDrdCNfcGvGToplUyHEAWAxCYLPBQqYxA7OHnq/chiQGx/nO91pZhsjaZ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718057703; c=relaxed/simple;
	bh=Fzp1Ro2brqxBH+/S89PixECc+WC9J8oJVkmAvtW8d88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GL/o7xmm94962A3QetZITGx8dnElzQpHhyTViFzHLTO8LP328Eya4uyAEEnq9BnuG2LwAq82G79FnKpospb6GlitXzGbU9N/BnE7iR2V+lB4ZNz9Q+wptkVtWJg0SG4f48GiCKEu2atZfsjo1Ugz2x8gGbloAseRlI3I+ZiXPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mPtzH5VD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AME0ff089276;
	Mon, 10 Jun 2024 17:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718057640;
	bh=+R6XyuQFmufPzDUNFzaePY3006xEVsSzvf2JAdm6Ojw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mPtzH5VD6tTUq7SU+uuDDYg+ra4Mf5vad5vLgZGPygH7Sdga0w6l+E8Kxix/7PiNu
	 saLO4oh7PRSyGrNTVFVB65znORL2z9uuSifvHD1X8PCL/EvFnTbq7zqsS9a2cuqFQ8
	 LQSePT13nCVD2JLZ9r5OkGk9UXuGwMwPyD+FFAA4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AME0hv009845
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 17:14:00 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 17:13:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 17:13:59 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AMDxFJ033817;
	Mon, 10 Jun 2024 17:13:59 -0500
Message-ID: <01433df1-aa19-4abb-9d87-c54e4c0dff17@ti.com>
Date: Mon, 10 Jun 2024 17:13:59 -0500
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
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <5ad5cf7a-c5c6-449e-9ed9-3d9f74959a19@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


Hi Krzysztof,

On 6/10/24 9:58 AM, Krzysztof Kozlowski wrote:
> On 10/06/2024 16:46, Judith Mendez wrote:
>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>> uses this compatible, require power-domains property.
>>
>> Since there is only one functional and interface clock for eqep,
>> clock-names is not really required, so removed from required
>> section, make it optional for ti,am3352-eqep compatible, and
>> update the example.
>>
> 
> ...
> 
> 
>>           interrupts = <79>;
>>       };
>>   
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +
>> +    bus {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        eqep1: counter@23210000 {
> 
> No need for label
> 
>> +          compatible = "ti,am62-eqep";
>> +          reg = <0x00 0x23210000 0x00 0x100>;
>> +          power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
>> +          clocks = <&k3_clks 60 0>;
>> +          interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
>> +          status = "disabled";
> 
> Drop... which also points to another comment - since this was no-op and
> example is basically the same, then just don't add it. No point.

Ok, then I will drop the new example, thanks.

BTW..
In the existing example for ti,am3352-eqep compatible,
do you know if it is appropriate to drop clock-names
from the example if it is no longer required?

~ Judith

> 
>> +        };
>> +    };
>>   ...
> 
> Best regards,
> Krzysztof
> 


