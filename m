Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040FF19EB87
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 15:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDENmz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 09:42:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42023 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgDENmz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 09:42:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so14148592wrx.9;
        Sun, 05 Apr 2020 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pYq5Ac37hqwzjRVuCDfokJB6SHNuA0PpWl4//5Tmdpo=;
        b=Wqn74vjV4BB8Cecnb8lCadPxosvu/HPRbtAuIdzz1pLSaY1R2XZz0p4+yGOlL2ogHx
         6eOZDPMKSxI03bHUA81tCci+O1O04BylnW6AFu84jQ8oLHkZ2i7WP2kBeVDxi8qzVSpK
         dfMfOL+reJugaHE69yJnniLrUh1Za/ketLTacst79oFS83sH2N7QX7nZmemEKPx3oBPP
         YqRYGHCY70Gy1Htubzgj0OziRXJxIicG4TvU9RPiA6kwKTDenSDUzCRjyCF/xvyrHaid
         NSUV3QLrQHH8n9P+v/yYeMYA+DCbCkN+0hz8Fs4SHLgPxIn17ZrbMr2lSYd4/62t/k5O
         KOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pYq5Ac37hqwzjRVuCDfokJB6SHNuA0PpWl4//5Tmdpo=;
        b=eEJA22jZFyk+Yu1DhvmDfGSzL6G2nhgzfU+lxensFdtKzgGjKybc/PcFtTiYs5MkU6
         Pxor5sojEg8cH1/7hdw14U6nMKeGtLxJ/7IQFDSuwZuN7RfBvjhyoatfK1MADzToXdmB
         NEg472kv0qXRyU+GnTIDX6dXREwm1tLPJCrJXQzbf6KiXZm8oydgMVnMy9ViZJ0QP5Ks
         OMpUZmROor/FvkJap49HOVI3BqKnZRwWpTCPrSjxNu/hMfkZWT/5zeSideO/C0cGPGst
         ZYZf6BPlW9mE7gNvwOA6C+1jPWkMLcASYKOwgso1AwX8Q22E9DzGmYhTNG9Kn2VydlL+
         tjxA==
X-Gm-Message-State: AGi0PubPwyyZqT/4B3yg+vuEWF6iPDmtAj5oE/q1boeIrPX0e/8bMak+
        9JH8oXQRinFTW+X5AKeNqsB2OTes
X-Google-Smtp-Source: APiQypKl9GRvIyv858C82f0tD7OhPqj/2TSvRADObcTMzQWNfvqqDXHOVfsIjuHuld/zf6AIDyol8w==
X-Received: by 2002:adf:92a3:: with SMTP id 32mr11438386wrn.254.1586094171257;
        Sun, 05 Apr 2020 06:42:51 -0700 (PDT)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a7sm19391741wmm.34.2020.04.05.06.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 06:42:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: convert rockchip saradc
 bindings to yaml
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        heiko@sntech.de, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200404102730.3295-1-jbx6244@gmail.com>
 <20200405130621.252578e8@archlinux>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <c5072f74-695f-0554-ab3f-bd5155c356b2@gmail.com>
Date:   Sun, 5 Apr 2020 15:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405130621.252578e8@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Originally I just followed 'rk3288.dtsi' till I saw someone posting a
patch with only 'arm-gic.h' included that made me to have a closer look
at it.
Due to the #ifndef construction it doesn't rise any warnings I think.
Apply the version that fits best.

Kind regards,

Johan Jonker



#ifndef _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_H
#define _DT_BINDINGS_INTERRUPT_CONTROLLER_IRQ_H
[..]
#endif

Something else...
With 2 examples it gives a warning that 2 identical defines are used.
Yaml doesn't separately compile the examples. Must use the same SoC.

This doesn't work. One example for rk3288 and one for rk3399.
examples:
  - |
    #include <dt-bindings/clock/rk3288-cru.h>
    #include <dt-bindings/interrupt-controller/arm-gic.h>
[..]
  - |
    #include <dt-bindings/clock/rk3399-cru.h>
    #include <dt-bindings/interrupt-controller/arm-gic.h>
[..]

From 'rk3288.dtsi':

> // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>
> #include <dt-bindings/gpio/gpio.h>
> #include <dt-bindings/interrupt-controller/irq.h>
> #include <dt-bindings/interrupt-controller/arm-gic.h>
> #include <dt-bindings/pinctrl/rockchip.h>
> #include <dt-bindings/clock/rk3288-cru.h>
> #include <dt-bindings/power/rk3288-power.h>
> #include <dt-bindings/thermal/thermal.h>
> #include <dt-bindings/power/rk3288-power.h>
> #include <dt-bindings/soc/rockchip,boot-mode.h>
>
> / {
> 	#address-cells = <2>;
> 	#size-cells = <2>;
>
> 	compatible = "rockchip,rk3288";

[..]

On 4/5/20 2:06 PM, Jonathan Cameron wrote:
> On Sat,  4 Apr 2020 12:27:28 +0200
> Johan Jonker <jbx6244@gmail.com> wrote:
>
>> Current dts files with 'saradc' nodes are manually verified.
>> In order to automate this process rockchip-saradc.txt
>> has to be converted to yaml.
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> Hi Johan
>
> As I'd already applied these I'd have preferred a fix patch and I'm
not actually
> sure it's really worth making the change.  I don't think we have any rules
> about minimal includes or anything in DT bindings.  Was there an error or
> warning as a result of this?
>
> Still as I hadn't pushed out as non rebasing yet I've picked this
version up
> and dropped the previous.
>
> Thanks,
>
> Jonathan
>
>> ---
>> Changes v2:
>>   Add reviewed by
>>   Fix irq.h already included in arm-gic.h
>> ---
>>  .../bindings/iio/adc/rockchip-saradc.txt           | 37 ----------
>>  .../bindings/iio/adc/rockchip-saradc.yaml          | 78
++++++++++++++++++++++
>>  2 files changed, 78 insertions(+), 37 deletions(-)
>>  delete mode 100644
Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>>  create mode 100644
Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
>>
>> diff --git
a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>> deleted file mode 100644
>> index c2c50b598..000000000
>> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt

[..]

>> diff --git
a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
>> new file mode 100644
>> index 000000000..9b9882323
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/rockchip-saradc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#

[..]

>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/rk3288-cru.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    saradc: saradc@2006c000 {
>> +      compatible = "rockchip,saradc";
>> +      reg = <0x2006c000 0x100>;
>> +      interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>> +      clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>> +      clock-names = "saradc", "apb_pclk";
>> +      resets = <&cru SRST_SARADC>;
>> +      reset-names = "saradc-apb";
>> +      vref-supply = <&vcc18>;
>> +      #io-channel-cells = <1>;
>> +    };
>
