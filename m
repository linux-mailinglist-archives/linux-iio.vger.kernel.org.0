Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD44447BDA
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 09:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbhKHIe6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 03:34:58 -0500
Received: from www381.your-server.de ([78.46.137.84]:42296 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbhKHIez (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 03:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=BzocYnUMMEozi8YsW82kpJmT0XBjWfio9qwDPLpIMd4=; b=K7nfvqBxe49uSaXbp4WcIctixT
        OUJJmjxwh95mwPo6hb6gBA8f5LHJPmeO86FIG2QAXa7msSmJzggfWz5KjTcHWgMyj/CmkWtwix7pg
        yeIKwsApAknVAH88gXU1SUUmaaRQXw+0bcT4JJqOzCqM9ADoypcqN2DkPDPRoAYmNHpghc6qmhdpQ
        CiOyyOL+PW09IE+StSYc/8MzxJ/McOwjEEhwxUk2+g4/rO/k56UrHmC8aPFPz4f3zOyDCvUmPWZhR
        T7IkLtDRMFxK6lDfX0Yd98EMuOLknT5cZ9ygUecgpwgWsMTfYxoegUX55i1yP9poF5K9Zl63Wwh/0
        subxwyvg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mk04X-0002Gn-7h; Mon, 08 Nov 2021 09:32:09 +0100
Received: from [82.135.83.112] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mk04W-000LUa-Vo; Mon, 08 Nov 2021 09:32:08 +0100
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
To:     "Chindris, Mihail" <Mihail.Chindris@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
References: <20211108082447.116663-1-mihail.chindris@analog.com>
 <20211108082447.116663-2-mihail.chindris@analog.com>
 <SN4PR03MB679988CBFA34DF338C85549699919@SN4PR03MB6799.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d8fa67fd-5954-efb0-b57c-0f9356f1fe1f@metafoo.de>
Date:   Mon, 8 Nov 2021 09:32:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <SN4PR03MB679988CBFA34DF338C85549699919@SN4PR03MB6799.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26346/Sun Nov  7 09:21:25 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/8/21 9:29 AM, Chindris, Mihail wrote:
> ...
>> +patternProperties:
>> +  "^channel@([0-1])$":
>> +    type: object
>> +    description: Configurations of the DAC Channels
>> +    properties:
>> +      reg:
>> +          description: Channel number
>> +          enum: [0, 1]
>> +
>> +      custom-output-range-config:
> Copy unanswered comment from V3
>
>>>> Not a generic property so I think this needs an adi prefix.
>>>> Jonathan
>>> I tried with adi prefix but I get weird errors while running dt_binding_check for properties with adi prefix and with type:object
>>> Do you have any suggestion for this issues?
>>>
>>> Mihail
>>>
> @Rob
> Jonathan

I had the same problem with the bindings for the xadc driver: 
https://www.spinics.net/lists/devicetree/msg382081.html


>> +        type: object
>> +        description: Configuration of custom range when
>> +          adi,output-range-microvolt is not present.
>> +          The formulas for calculation the output voltages are
>> +            Vout_fs = 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.03]
>> +            Vout_zs = 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx * 1.03]
> ...


