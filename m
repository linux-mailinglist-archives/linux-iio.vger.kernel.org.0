Return-Path: <linux-iio+bounces-6883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBDA916250
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 11:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5712B24103
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jun 2024 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C21494DB;
	Tue, 25 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="t3zAvB77"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A949656;
	Tue, 25 Jun 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307683; cv=none; b=U5D2pOY64P+E7UphTUNJGEO9VPsYefuzkqWaxomF2Ub93CPtsTAbsHK5csqGs+1O5/PgVgzGfDiAm0H+zLg/3GvSivU7p9iYTOKNBuRagiH0YeWSA7+IT/fvLWKwMfFyqvPHGGTfPKYIGJxzxpzF5o8F7tkoTn9Uii9FAFaxb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307683; c=relaxed/simple;
	bh=UxNhAgYPGNNHkfJvLdarPdJp5UdmbQ5FuNS5+JKoVFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TvbmSOs3VPSUi8SuxD6xlTEjNoy/xdYyaHsMGWQPSFyJuKIYGxOGLTUCymCSau5LWFJUso4h3ShFyxEZszyQj5jLXSc93MwpEcWTKaymuZv1LraNM3KxNUEh5vse1+BDT9ita8V11kWnxxrywvyOC0tbRFV93T8NqOlfbN/8b4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=t3zAvB77; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P7Z1mW023451;
	Tue, 25 Jun 2024 11:27:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ZL9O4jKbisSwEWT31AVHc7rzLyQfQSAky6Cmq885AcE=; b=t3zAvB77Xc6Rx1Xj
	GOkBEEY1c1hLcvMraq9m1SbiZ8WyB5aSKn7UZXTQ9CNhr4eO+ToZXK2OgJJU8XEq
	f9qEpBpz+LpMUNvzpej8jIFg2mSvLStgQR2xejOMdGW6hooIXHI/ZspWrdflPg7V
	F6slXxMa2qkc/UfjHBdKvP+fOX5nPpzfl8qwixhB2vdb8WIjUHLpGOZdu2e+B010
	UExnxUzdfcppolhWSvYbaemFJR4YdZ53xoyT8f6XgmSNc+kFrEQFFXkTeRnDD8JT
	efvvH7TcjTgYIso8+kIvDQao4hghalRfk1JX29L56mBjzUvIO9GX23OyMp9/7X9o
	h0mg7Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx9jj8hk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 11:27:41 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E508E40045;
	Tue, 25 Jun 2024 11:27:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B946215135;
	Tue, 25 Jun 2024 11:26:58 +0200 (CEST)
Received: from [10.252.26.63] (10.252.26.63) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 11:26:57 +0200
Message-ID: <0e1f7676-65c3-49b6-a3d0-ebac8dda50a7@foss.st.com>
Date: Tue, 25 Jun 2024 11:26:56 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] dt-bindings: iio: add sigma delta modulator backend
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-6-olivier.moysan@foss.st.com>
 <20240618-spearmint-traverse-5981a548c158@spud>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20240618-spearmint-traverse-5981a548c158@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_06,2024-06-24_01,2024-05-17_01

Hi Conor,

On 6/18/24 20:13, Conor Dooley wrote:
> On Tue, Jun 18, 2024 at 06:08:31PM +0200, Olivier Moysan wrote:
>> Add documentation of device tree bindings to support
>> sigma delta modulator backend in IIO framework.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>>   .../iio/adc/sd-modulator-backend.yaml         | 43 +++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml b/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
>> new file mode 100644
>> index 000000000000..b0fa71b75cd0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/sd-modulator-backend.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/sd-modulator-backend.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sigma delta modulator backend
>> +
>> +maintainers:
>> +  - Olivier Moysan <olivier.moysan@foss.st.com>
>> +
>> +properties:
>> +  compatible:
>> +    description: |
>> +      "sd-backend" can be used as a generic SD modulator backend,
>> +      if the modulator is not specified in the compatible list.
>> +    enum:
>> +      - sd-backend
> 
> I'd rather not have a generic compatible like this. Something generic as
> a fallback for the driver to binding against I would be fine with, but
> not something that avoids people documenting their devices.
> 

This binding was modeled on the following binding
Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
But, I understand that we need to encourage people to use a real 
compatible. So, I will remove this generic compatible from the binding 
in v2.

> Also, I think "backend" should be dropped from the
> filename/title/descriptions, the ads1201 is "just" an delta-sigma
> modulator.:wq
> 

There is already a generic sigma delta modulator driver: 
"sd_adc_modulator.c"
This driver follows a different approach, as it registers an IIO device. 
It has to be kept for backward compatibility.
The current patch introduces a new sigma delta modulator generic driver
based on the new IIO backend framework.
So, we have two drivers dedicated to the same type of hardware, but 
intented to be used with different topologies in IIO.
I used "backend" suffix as a differentiator here.
I did not find a better alternative to manage this diversity.
If, you have another suggestion please let me know.

>> +      - ads1201
> 
> Missing vendor prefix.
> 

Ack

BRs
Olivier

> Thanks,
> Conor.
> 
> 
>> +
>> +  '#io-backend-cells':
>> +    const: 0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vref-supply:
>> +    description: Phandle to the vref input analog reference voltage.
>> +
>> +required:
>> +  - compatible
>> +  - '#io-backend-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    ads1201: adc {
>> +      compatible = "sd-backend";
>> +      #io-backend-cells = <0>;
>> +    };
>> +
>> +...
>> -- 
>> 2.25.1
>>

