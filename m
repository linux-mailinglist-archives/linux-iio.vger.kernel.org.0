Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386C236884B
	for <lists+linux-iio@lfdr.de>; Thu, 22 Apr 2021 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhDVU5T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Apr 2021 16:57:19 -0400
Received: from www381.your-server.de ([78.46.137.84]:33794 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhDVU5T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Apr 2021 16:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=WdiGJiqeCQo6kCNVn3p2IvtMh4cnlFUEy/FrSR2EMxM=; b=B2dnbdjSU8rDIkoOCQpXNImKcW
        ehajtmNXV5s/sc93ARWn2bXc/B08D6XHIb2cJBth88zUnVNPTxEUXOKslgV9KwVxOdTbHbYvfkK3N
        nJChha9ghtyDLI/svr6zcS+LQ+/xTtAG5FtFtfAaSvZhEbnHQQkWsOq4ZgZ7l1gD1LPSTWZKdmWiE
        7iHNTdoYLonXHrMg2XyvEvj5kkK5iCF+Cj9y+PLYGWxyNUiaZbNuD3k4KpYf6E68uWXBHrG+hXQIQ
        zZgIWxfF4N+6Vpd+PwjL2Em43lcZuqu2URajbKWF3e6nOJWAF+cAkj5n3S46YWEdJuCqOKLc2fP7f
        4oGPe3CQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lZgNL-000Cxn-Ul; Thu, 22 Apr 2021 22:56:40 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lZgNL-000Ude-Ai; Thu, 22 Apr 2021 22:56:39 +0200
Subject: Re: [PATCH v2 1/2] dt-bindings: staging: iio: cdc: ad7746: add
 binding documentation for AD7746
To:     Lucas Stankus <lucas.p.stankus@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <cover.1618785336.git.lucas.p.stankus@gmail.com>
 <54a9eaeaa42d47037b2a07bd933e6dfade745d02.1618785336.git.lucas.p.stankus@gmail.com>
 <20210420193746.GA3632576@robh.at.kernel.org>
 <CACKVXZDtUync4HnScJnMEj=Gh7bukUUpnPrtE0w1PPgCZOHORg@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8b2c672a-f260-fe19-5baf-adf6ce6fabf2@metafoo.de>
Date:   Thu, 22 Apr 2021 22:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CACKVXZDtUync4HnScJnMEj=Gh7bukUUpnPrtE0w1PPgCZOHORg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26148/Thu Apr 22 13:06:46 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/22/21 9:16 PM, Lucas Stankus wrote:
> On Tue, Apr 20, 2021 at 4:37 PM Rob Herring <robh@kernel.org> wrote:
>> On Sun, Apr 18, 2021 at 07:49:51PM -0300, Lucas Stankus wrote:
>>> Add device tree binding documentation for AD7746 cdc in YAML format.
>>>
>>> Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
>>> ---
>>>
>>> A minor note about the adi,excitation-vdd-permille property. Jonathan
>>> suggested the name to be adi,excitation-vdd-milicent, but I was unsure of
>>> the milicent naming. With a quick search I found out that the common way to
>>> call a thousandth is 'per mille'[1], but I didn't find any use of it in the
>>> kernel documentation. Any thoughts about it?
>> Seems okay to me.
>>
>>> [1] https://en.wikipedia.org/wiki/Per_mille
>>>
>>>   .../bindings/iio/cdc/adi,ad7746.yaml          | 73 +++++++++++++++++++
>>>   1 file changed, 73 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
>>> new file mode 100644
>>> index 000000000000..a2a7eee674ba
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
>>> @@ -0,0 +1,73 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/cdc/adi,ad7746.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
>>> +
>>> +maintainers:
>>> +  - Michael Hennerich <michael.hennerich@analog.com>
>>> +
>>> +description: |
>>> +  AD7746 24-Bit Capacitance-to-Digital Converter with Temperature Sensor
>>> +
>>> +  Specifications about the part can be found at:
>>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad7291.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - adi,ad7745
>>> +      - adi,ad7746
>>> +      - adi,ad7747
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  adi,excitation-vdd-permille:
>>> +    description: |
>>> +      Set VDD per mille to be used as the excitation voltage.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [125, 250, 375, 500]
>>> +
>>> +  adi,exca-output-en:
>>> +    description: Enables the EXCA pin as the excitation output.
>>> +    type: boolean
>>> +
>>> +  adi,exca-output-invert:
>>> +    description: Inverts the excitation output in the EXCA pin.
>>> +    type: boolean
>> 'invert' assumes I know what the non-inverted signal is. Sometimes that
>> makes sense, but if you can define in terms of the inverse that would be
>> better. For example, for a normally active low signal, name the property
>> 'foo-active-high'.
> Thanks for the feedback!
>  From reading the data sheet I couldn't quite grasp what would be an inverted
> excitation output, but I don't have a lot of experience with CDCs. Maybe someone
> with more experience could help out with a better suggestion.

This is the only thing I could find 
https://www.analog.com/media/en/technical-documentation/application-notes/AN-1585.pdf.

The datasheet also says that only at most one of them should be 
inverted. So maybe only a single property which selects which of the two 
is inverted.


