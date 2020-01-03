Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C566412F8BC
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jan 2020 14:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgACNZQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jan 2020 08:25:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46252 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACNZQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jan 2020 08:25:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 003DOuKN013702;
        Fri, 3 Jan 2020 07:24:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578057896;
        bh=DAzV+ImI7hky/CIYwYe7UmdqdeGgThZdrw1X+n2XCXA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YNEqNTynYRvvZS/UrmYllG5D0Swbv1QpWcw4xvk19T8FZFJpKyUdkPTPmcvlpGLeZ
         /PNucDJOVjwV+JIMDkuFG1mRmtQFpcbXIqbptdPfQ7L8BS3jB52mcCgCRZFXFi9p98
         /4R4OPH8wZZUdZZIXRNn5xH2EdMhCHwf0kNOdoXU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 003DOuTD006872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jan 2020 07:24:56 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 3 Jan
 2020 07:24:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 3 Jan 2020 07:24:56 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 003DOtSP004610;
        Fri, 3 Jan 2020 07:24:55 -0600
Subject: Re: [PATCH 1/2] dt-binding: iio: dac8771: Add TI DAC8771 binding
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20191217140731.30504-1-dmurphy@ti.com>
 <20191217140731.30504-2-dmurphy@ti.com> <20191223144442.3171e641@archlinux>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <736cb479-cda3-caff-5f48-fe9a5b13c33f@ti.com>
Date:   Fri, 3 Jan 2020 07:22:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191223144442.3171e641@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan

Thanks for the review.  I was on holiday

On 12/23/19 8:44 AM, Jonathan Cameron wrote:
> On Tue, 17 Dec 2019 08:07:30 -0600
> Dan Murphy <dmurphy@ti.com> wrote:
>
>> Add the TI DAC8771 DT binding.
>>
>> Datasheet:
>> http://www.ti.com/lit/ds/symlink/dac8771.pdf
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> CC: Rob Herring <robh+dt@kernel.org>
>> ---
>>   .../bindings/iio/dac/ti,dac8771.yaml          | 89 +++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml
>> new file mode 100644
>> index 000000000000..6aba6789d36c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8771.yaml
>> @@ -0,0 +1,89 @@
>> +# SPDX-License-Identifier: GPL-2.0
> If possible, it is preferred for new bindings to be dual licensed as
>
> (GPL-2.0-only OR BSD-2-Clause)
>
Ack


>> +# Copyright (C) 2019 Texas Instruments Incorporated
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/bindings/iio/dac/ti,dac8771.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Texas Instruments DAC8771
>> +
>> +maintainers:
>> +  - Dan Murphy <dmurphy@ti.com>
>> +
>> +description: |
>> +  The DAC8771 is a single channel, precision, fully integrated 16-bit digital
>> +  to analog converter (DAC) with adaptive power management, and is designed to
>> +  meet the requirements of industrial control applications.
>> +
>> +  Specifications can be found at:
>> +    http://www.ti.com/lit/ds/symlink/dac8771.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,dac8771
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reset-gpios:
>> +    description: |
>> +       GPIO used for hardware reset.
>> +
>> +  loaddacs-gpios:
>> +    description: |
>> +       GPIO used to shift the data from the SPI FIFO to the processing engine.
>> +
>> +  spi-max-frequency:
>> +    maximum: 25000000
>> +
>> +  vref-supply:
>> +    description: Phandle to the external reference voltage supply.
>> +
>> +  ti,output-range:
>> +    description: Output range of the DAC
>> +       0 - Voltage output 0 to +5 V (default)
> Hmm. I'm never keen on opaque bindings, but sometimes things
> are just too complex to break out as individual fields.
>
> So I guess this is the best we can do.

Yes that is true.  These values are the same as the ones in the data sheet.

It would have been a simpler binding if the current values were not 
nested with the voltage values.

Dan
