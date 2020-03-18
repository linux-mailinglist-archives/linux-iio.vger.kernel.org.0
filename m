Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBDC1895CE
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 07:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgCRG1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 02:27:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32933 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgCRG1c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 02:27:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay11so10750916plb.0;
        Tue, 17 Mar 2020 23:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M0jLEpxC4l3IOb+KMA02Q30dEzRvhIJNxnX68azs+4A=;
        b=QImxNQeUzuTppW30cpuiNPD4z63mXgEyiuPP9OnkZi83y/wsfIVKN2rpttBgdc5U+3
         ZTWJkXPLNvMp8HH4Bh6MfDqK5dI5gHcaKoLDt4WbSojpxG/mgljzDR2LHHkX2DhX/nS2
         RuMQS5fPsMV9Y7rK6ImRAp0P9AczCya+u0ErwXL/8kcnjlzRP+F91DKm27TV66hQ7TJT
         0j3txo5hICGCZSjQAMkc++tcNyziLaBDpV2+AHfGHK1Mhacb34S42YkztdDdXCXz5Ahs
         P4pHsIikKNfjwlM2qRJU6YJXQqjJLz/4OGOi5Oo3FWqZGrPFHGuhEGxYWuTk7l6YdAzo
         VCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M0jLEpxC4l3IOb+KMA02Q30dEzRvhIJNxnX68azs+4A=;
        b=mJXtjClbk2O4VvbfkUGJXBpszpOh60tsvGYK7puLnNywO57epVvDKl003JeFZ42nq9
         2JRj21LKkaY45i2uNzZkX5e2bMoU+fPwQHl2V1TJiMT35gBHSzXV7MNA6tx7Lw+rBqbX
         2EUhHoUYl+bYuRgNHrCpngT6aGHswZ/oHM6hermrO31ePhF4pAmB7EX1c+AiETatistN
         GI6r4au1NFNP8NBH5go6FFmBn2Y9unoUi5lYLlCOFtlANtlsLbO2SuW8OApsOCmFF09w
         SK3fNT36ow6q9yKo3e5blUq7sz0O3wgZ3xuD/YErokldzp3vw8DvAtNPe8VGXeFOGu7t
         f12g==
X-Gm-Message-State: ANhLgQ2nxPwZIzCOBbb+GJjkM4Rb4TFwiiGQmm8raD+DkizhaAiZXWjE
        mlPQ8F1tT4fquvjZSuCgwhEGemW8
X-Google-Smtp-Source: ADFU+vsUY1qyJ3MM5qkB5boM9kpHmxcYeaba4l01BHYDSgM3lynvyO19aBDRv/DFfRZ4K8mimcw9yg==
X-Received: by 2002:a17:902:ab95:: with SMTP id f21mr2178201plr.188.1584512849727;
        Tue, 17 Mar 2020 23:27:29 -0700 (PDT)
Received: from ?IPv6:2409:4072:6086:470e:bc8d:c185:c429:a95b? ([2409:4072:6086:470e:bc8d:c185:c429:a95b])
        by smtp.gmail.com with ESMTPSA id b25sm5060850pfp.201.2020.03.17.23.27.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 23:27:29 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: iio: tsl2563: convert bindings to YAML
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com, sre@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200314134237.12187-1-nish.malpani25@gmail.com>
 <20200315105834.7a5f4475@archlinux>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <1cfe5e97-1c0d-8ffe-88f3-90db77e0f03b@gmail.com>
Date:   Wed, 18 Mar 2020 11:57:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315105834.7a5f4475@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

A v3 PATCH [1] was generated taking care of the reviews which can be 
found inline.

[1] https://marc.info/?l=linux-iio&m=158451158827441&w=2

On 15/03/20 4:28 pm, Jonathan Cameron wrote:
> On Sat, 14 Mar 2020 19:12:37 +0530
> Nishant Malpani <nish.malpani25@gmail.com> wrote:
> 
>> Convert the TSL2563 device tree bindings to the new YAML format.
>>
>> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
>> ---
>>
>> The link for the datasheet is not attached in the binding document
>> because it was not available on the manufacturer's (AMS) website [1].
> 
> Very old part now, though plenty of them in circulation or least there
> used to be.  I have though not powered up that board for a while.
> 
> When doing these conversions, do sanity check them against the driver
> as the old docs aren't always entirely accurate ; >
> Jonathan
> 
>>
>> [1] https://ams.com/ambient-light-sensors
>> ---
>>   .../devicetree/bindings/iio/light/tsl2563.txt | 19 --------
>>   .../bindings/iio/light/tsl2563.yaml           | 46 +++++++++++++++++++
>>   2 files changed, 46 insertions(+), 19 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.txt
>>   create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2563.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.txt b/Documentation/devicetree/bindings/iio/light/tsl2563.txt
>> deleted file mode 100644
>> index f91e809e736e..000000000000
>> --- a/Documentation/devicetree/bindings/iio/light/tsl2563.txt
>> +++ /dev/null
>> @@ -1,19 +0,0 @@
>> -* AMS TAOS TSL2563 ambient light sensor
>> -
>> -Required properties:
>> -
>> -  - compatible : should be "amstaos,tsl2563"
>> -  - reg : the I2C address of the sensor
>> -
>> -Optional properties:
>> -
>> -  - amstaos,cover-comp-gain : integer used as multiplier for gain
>> -                              compensation (default = 1)
>> -
>> -Example:
>> -
>> -tsl2563@29 {
>> -	compatible = "amstaos,tsl2563";
>> -	reg = <0x29>;
>> -	amstaos,cover-comp-gain = <16>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2563.yaml b/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
>> new file mode 100644
>> index 000000000000..2a70b8d62760
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/tsl2563.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/light/tsl2563.yaml#
> 
> Convention is now to name files and this with the manufacturer part
> as well.

Got it! Taken care of in v3.
> 
> light/amstaos,tsl2563.yaml
> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AMS TAOS TSL2563 ambient light sensor
>> +
>> +maintainers:
>> +  - Sebastian Reichel <sre@kernel.org>
>> +
>> +description: |
>> +  Ambient light sensor with an i2c interface.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - amstaos,tsl2563
> 
> The original binding was wrong on this.   Check the driver :)
> I'm a bit embarrassed I never noticed during review as I have
> a tsl2561, be it on a board that was never converted to DT.
> 

You're right. Should have cross-checked with the driver before blindly 
following the original binding. Corrected in v3.
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  amstaos,cover-comp-gain:
>> +    description: Multiplier for gain compensation
>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>> +      - enum: [1, 16]
> 
> Not sure it's that restricted...  or to be honest what
> that is for at all.  Superficially it looks like
> a multiplier to change the 'range' of the the sysfs control.
> 
> I wonder if anyone cares or if we can just start ignoring that going
> forwards?  Sebastian, anyone else?
> 

 From what I understood while reading the datasheet [2] (Page 4), 
'amstaos,cover-comp-gain' is used to switch between the low gain and 
high gain mode which further adjusts the 'Illuminance Responsivity'. 
Ergo, I've taken it forward even in v3 since the driver also relies on 
it [3]. Please let me know if my reasoning is erroneous.

[2] 
https://media.digikey.com/pdf/Data%20Sheets/Austriamicrosystems%20PDFs/TSL2562,63.pdf

[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/light/tsl2563.c#n494
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      light-sensor@29 {
>> +        compatible = "amstaos,tsl2563";
>> +        reg = <0x29>;
>> +        amstaos,cover-comp-gain = <16>;
>> +      };
>> +    };
>> +...
> 

With regards,
Nishant Malpani
