Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E1B18EAE8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCVRhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:37:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37106 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgCVRhK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 13:37:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id h72so4061269pfe.4;
        Sun, 22 Mar 2020 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uFjqerOpAXXY1w84b6DnYVFNxiy8C9qzfSlLAukKhAk=;
        b=qnQSMhd39MEE9TjdNvplzII+uAo1ntqM8eJ90m2Esf3prCDYVAX77d9AsYQOE8R6W4
         UbLd01N7XVDpXfqx0uRiCQRO9UYcTzBLAgZtmMWCiUqyhthEW6rx8040YnY3rapUwfMZ
         EyUm6aGr6R2Jph58O2TZxnry7ikEh8svgNUxmkcsYov/hTM4h2GQfP8aBoqRt2u3JaJz
         bRWTcXJKGRRfYbBajPQdfcqrtm7zSLGcyVWvY8Q2IdjI/EoRXCfbecduOr/EiuV3Iwe0
         cZpZGNt9R2b308+CLiy8AO9pbUEL3JvDDRyq0xQ7vH7oJTz0jorZfdv+4wUs6or433NH
         0x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFjqerOpAXXY1w84b6DnYVFNxiy8C9qzfSlLAukKhAk=;
        b=uLzXkj7hwK2dGW+zY4v8VLdVMUhI+VvIspjbdJZXA9+Zj1VgwGaD/pWTaJWzCkgoxm
         N6Wq0pVQEVNbqJM2lWeXeY+088mbxwbKxLhkvZqxbTALeZKtEW+NcnNNdQ1M54ClwGSp
         DjHwUx6hLuzhOSduPj0/2JDNH0ZrMj5LHfOfXCstdIwoZDYSNYwiiGMFzvKS/6Q/dUmZ
         cDGKemnKy55vpR40o7f2Irl8oXAaHNFfAcBeQfPmmiHRudIgIFujJ0XmfEVduHfAyuvX
         P6bhQ8Veshv0BaJcDgnvAszDhb1VJxs+WOYz7EzvhyYkKqu6B75LSs8HLr36Cf8cpUrI
         hkTQ==
X-Gm-Message-State: ANhLgQ0pzT/N9dSiDinTOukB4t4eisnaVfjSTuIF3ZQa+XE/biDrAtlO
        fvMbSOlYidGHvvAwHNfBbGncu+eHPDo=
X-Google-Smtp-Source: ADFU+vsda57LLmdZodUXWrDSSkM4zN5Ko0cmIKxgWT/T8KRBW0AHy4/KzO3fY+ywKVRyrNNdhMnShw==
X-Received: by 2002:a65:424b:: with SMTP id d11mr17452753pgq.17.1584898628938;
        Sun, 22 Mar 2020 10:37:08 -0700 (PDT)
Received: from ?IPv6:2409:4072:992:9f95:b1e5:4cbf:6219:65ee? ([2409:4072:992:9f95:b1e5:4cbf:6219:65ee])
        by smtp.gmail.com with ESMTPSA id x70sm10088379pgd.37.2020.03.22.10.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2020 10:37:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: vcnl4000: convert bindings to
 YAML format
To:     Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <cover.1584380360.git.agx@sigxcpu.org>
 <6182053bb8c442e0b4d72b34c83c7f1565f4a258.1584380360.git.agx@sigxcpu.org>
 <20200322172910.51456fe4@archlinux>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <f5ea512c-d427-94c7-cf5f-f1300cbd4aa3@gmail.com>
Date:   Sun, 22 Mar 2020 23:07:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200322172910.51456fe4@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22/03/20 10:59 pm, Jonathan Cameron wrote:
> On Mon, 16 Mar 2020 18:46:17 +0100
> Guido Günther <agx@sigxcpu.org> wrote:
> 
>> Convert the vcnl4000 device tree bindings to the new YAML format.
>>
>> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Looks good to me. However, I've made far too many mistakes in
> DT binding review recently, so will definitely be waiting for Rob to
> get a chance to look at it!
> 
> Jonathan
> 
>> ---
>>   .../bindings/iio/light/vcnl4000.txt           | 24 ----------
>>   .../bindings/iio/light/vcnl4000.yaml          | 45 +++++++++++++++++++
>>   2 files changed, 45 insertions(+), 24 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
>>   create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt b/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
>> deleted file mode 100644
>> index 955af4555c90..000000000000
>> --- a/Documentation/devicetree/bindings/iio/light/vcnl4000.txt
>> +++ /dev/null
>> @@ -1,24 +0,0 @@
>> -VISHAY VCNL4000 -  Ambient Light and proximity sensor
>> -
>> -This driver supports the VCNL4000/10/20/40 and VCNL4200 chips
>> -
>> -Required properties:
>> -
>> -	-compatible: must be one of :
>> -        vishay,vcnl4000
>> -        vishay,vcnl4010
>> -        vishay,vcnl4020
>> -        vishay,vcnl4040
>> -        vishay,vcnl4200
>> -
>> -	-reg: I2C address of the sensor, should be one from below based on the model:
>> -        0x13
>> -        0x51
>> -        0x60
>> -
>> -Example:
>> -
>> -light-sensor@51 {
>> -	compatible = "vishay,vcnl4200";
>> -	reg = <0x51>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
>> new file mode 100644
>> index 000000000000..74d53cfbeb85
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/vcnl4000.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/light/vcnl4000.yaml#
Shouldn't the devicetree binding document be named with the manufacturer 
part as well?

With regards,
Nishant

>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: VISHAY VCNL4000 ambient light and proximity sensor
>> +
>> +maintainers:
>> +  - Peter Meerwald <pmeerw@pmeerw.net>
>> +
>> +description: |
>> +  Ambient light sensing with proximity detection over an i2c
>> +  interface.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - vishay,vcnl4000
>> +      - vishay,vcnl4010
>> +      - vishay,vcnl4020
>> +      - vishay,vcnl4040
>> +      - vishay,vcnl4200
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +- |
>> +  i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      light-sensor@51 {
>> +              compatible = "vishay,vcnl4200";
>> +              reg = <0x51>;
>> +      };
>> +  };
>> +...
> 
