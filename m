Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 761BF185D6B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 15:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgCOOL4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 10:11:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37625 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgCOOL4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 10:11:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so15167919wme.2;
        Sun, 15 Mar 2020 07:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2Kq4iO6XijbXFBEnD85G1Xl5+d7l0FLMqlg0wGGvec=;
        b=aBeErJ5YyBbr4nxnQqkvrKEkkPnz6PAkHkmhro6G6MrJOL/UDFD7Ub6vQoY2SEDq1G
         9k+mhialuNE6IJ+pg1nt6+J0TB3v9w/1JZapZVCSYSppUz2ioutiCwrEHRKuPhyJHUU0
         jdD1cUnn28NFihH8vunjsiP7tvrhC/gnJK60e6sF1svey+0fe48hr95M3sdyIGa7BuLt
         vYGMSoLdIpe1SlnjB1aS4NEqq8w/BUPgrjnjfSWDnnnnxNtGqeJwU1wWXvnXkrj54TtT
         1RwUDuS2jAxhEHmJ+SRHGXYpyb8phDFCR9GqLBHcUDO1ZNoqfgaNWzx6x3bFTEGONVBU
         B1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2Kq4iO6XijbXFBEnD85G1Xl5+d7l0FLMqlg0wGGvec=;
        b=WAP6XHXaGJYWFo+MglGpGw7qNqcZwRSGtqqEb0bojIPH4dFQBY+tXBqZ62ukOXsqAt
         w7XRAvtaPbSf1Tu/0iFfhmpWMVdcoMtl26/d1cKcb025Fk1YQz4DKCjG8QCzvgnkaISZ
         0lEpy9FXAXNZR1Zt1PyT2cwjEwefalmYJ0PB2rz4mfd05lBuRz1dCwcW91+A60T9v2hw
         CRNN1ulHrRyC3sRxMfvsoDJYT4lOCXCFPU3g4SgYkXrUco4r+HetVDZ9pHXIUrdljOxi
         EjEQ4vAdR1Z6PSdXCAJLjlLxQAI0KR4YktiZOeqjpMQHE9tV+k++WGkJkZRV8oOToiXM
         Wm0A==
X-Gm-Message-State: ANhLgQ3lwSq2kx/2WBdzPcyGmg/UmojywqigWChXk/30B7BengT+5Fd8
        vc4egkmxRfROf6rRbYmJeua+MDrB
X-Google-Smtp-Source: ADFU+vvBllAee/olaNqpNFG6FKneY1AlU0738Qu2NgW69UH5bHcTpF1H8IutAQgMKi9fKOhQ/CHFfQ==
X-Received: by 2002:a05:600c:c8:: with SMTP id u8mr22401190wmm.178.1584281513815;
        Sun, 15 Mar 2020 07:11:53 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x13sm26860956wmj.5.2020.03.15.07.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Mar 2020 07:11:53 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: adc: convert rockchip saradc
 bindings to yaml
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200313132926.10543-1-jbx6244@gmail.com>
 <20200315112223.07dd863b@archlinux>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <a35bdff4-601e-6186-584e-9a0b88cf3dbb@gmail.com>
Date:   Sun, 15 Mar 2020 15:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315112223.07dd863b@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

For compatible strings with identical fallback we use 'enum' to combine,
so instead of 3 only 1 additional line is needed for each new SoC patch.

properties:
  compatible:
    oneOf:
      - const: rockchip,saradc
      - const: rockchip,rk3066-tsadc
      - const: rockchip,rk3399-saradc
      - items:
          - enum:
            - rockchip,px30-saradc
            - rockchip,rk3308-saradc
            - rockchip,rk3328-saradc
            - rockchip,rv1108-saradc
          - const: rockchip,rk3399-saradc

[..]
vs
[..]

properties:
  compatible:
    oneOf:
      - const: rockchip,saradc
      - const: rockchip,rk3066-tsadc
      - const: rockchip,rk3399-saradc
      - items:
          - const: rockchip,px30-saradc
          - const: rockchip,rk3399-saradc
      - items:
          - const: rockchip,rk3308-saradc
          - const: rockchip,rk3399-saradc
      - items:
          - const: rockchip,rk3328-saradc
          - const: rockchip,rk3399-saradc
      - items:
          - const: rockchip,rv1108-saradc
          - const: rockchip,rk3399-saradc


Check with:

make ARCH=arm menuconfig
# select Rockchip platform

make -k ARCH=arm64 dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml

make -k ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml

make ARCH=arm64 menuconfig
# select Rockchip platform

make -k ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml

Caution with:

'allOf' and 'additionalProperties: false'
does not completely validate DTS or examples!

On 3/15/20 12:22 PM, Jonathan Cameron wrote:
> On Fri, 13 Mar 2020 14:29:24 +0100
> Johan Jonker <jbx6244@gmail.com> wrote:
>
>> Current dts files with 'saradc' nodes are manually verified.
>> In order to automate this process rockchip-saradc.txt
>> has to be converted to yaml.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> Hi Johan,
>
> A question inline which may just be my lack of yaml knowledge
> showing itself!
>
> Jonathan
>

>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - const: rockchip,saradc
>> +      - const: rockchip,rk3066-tsadc
>> +      - const: rockchip,rk3399-saradc
>> +      - items:
>> +          - enum:
>> +            - rockchip,rk3328-saradc
>> +            - rockchip,rv1108-saradc
>> +          - const: rockchip,rk3399-saradc
>
> My yaml knowledge isn't great.  Why do we have this nested
> structure rather than a straight forward list?
>

