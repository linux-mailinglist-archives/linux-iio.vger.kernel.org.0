Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34E1B18F9
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 00:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDTWCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 18:02:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34771 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWCs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 18:02:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so3119270otu.1;
        Mon, 20 Apr 2020 15:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K5L6UQW35I1N2wLdBvnczZT21mI2+tpfuparcRqaXcg=;
        b=kbOWWyKG07RmL5TH6HvG2hET8iNpKI8YVSvVvxqa5g5bDZKnitwPqfX17RYOyx6COi
         NDh5cyixNJ8/QTap3FLPatFsjgc0UbZJ0KEbDUH4/HUU8pGdlrCMYETt3lxb3l5nVhkj
         vpxwZi10bwan/ZQQyqB/wsuX8N8xEuzRiVczXaj+x58TPItjgrASvY9qPIsYYaaPOgva
         3XIlWgN9s294pzitQhko9NtECanxYKYFaQgRVOiLkHcfDr3t7tS1a7D773F+SP+/u09f
         R5m/gk6qeKz/fzLE+J72NrgxnNaq50AvCVNdHNIp7ao9rN2AoglnR8PkP9bgPYOxlxlM
         d9cQ==
X-Gm-Message-State: AGi0PuZNxWKWm0x9QWdKGdyRbrJjiHbBJv0C/6hhiYrCyh/vPc4Lz9Z3
        DTEYltGFOFA83mxoymH0EA==
X-Google-Smtp-Source: APiQypK8Fy8ojOtSADNqJzMy08M5eOTn6FPLAGyy8imAAB2qDC8Uez6oOOnaxrHsIXx+Ie0sAjhDhg==
X-Received: by 2002:a9d:3e4b:: with SMTP id h11mr10435724otg.252.1587420166984;
        Mon, 20 Apr 2020 15:02:46 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 204sm191218oid.18.2020.04.20.15.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:02:46 -0700 (PDT)
Received: (nullmailer pid 9872 invoked by uid 1000);
        Mon, 20 Apr 2020 22:02:44 -0000
Date:   Mon, 20 Apr 2020 17:02:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, smohanad@codeaurora.org,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V2 2/3] iio: adc: Add PMIC7 ADC bindings
Message-ID: <20200420220244.GA32739@bogus>
References: <1586942266-21480-1-git-send-email-jprakash@codeaurora.org>
 <1586942266-21480-3-git-send-email-jprakash@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586942266-21480-3-git-send-email-jprakash@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 15, 2020 at 02:47:45PM +0530, Jishnu Prakash wrote:
> Add documentation for PMIC7 ADC peripheral.
> For the PMIC7-type PMICs, ADC peripheral is present in HW for the
> following PMICs: PMK8350, PM8350, PM8350b, PMR735a and PMR735b.
> Of these, only the ADC peripheral on PMK8350 is exposed directly to SW.
> If SW needs to communicate with ADCs on other PMICs, it specifies the
> PMIC to PMK8350 through the newly added SID register and communication
> between PMK8350 ADC and other PMIC ADCs is carried out through
> PBS(Programmable Boot Sequence) at the firmware level.
> 
> In addition, add definitions for ADC channels and virtual channel
> definitions (combination of ADC channel number and PMIC SID number)
> per PMIC, to be used by ADC clients for PMIC7.
> 
> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> ---
>  .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 52 +++++++++++--
>  include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h    | 67 ++++++++++++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h   | 88 ++++++++++++++++++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h   | 46 +++++++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h   | 28 +++++++
>  include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h   | 28 +++++++
>  include/dt-bindings/iio/qcom,spmi-vadc.h           | 78 ++++++++++++++++++-
>  7 files changed, 380 insertions(+), 7 deletions(-)
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
>  create mode 100644 include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index 8273981..62aa311 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -13,7 +13,7 @@ maintainers:
>  description: |
>    SPMI PMIC voltage ADC (VADC) provides interface to clients to read
>    voltage. The VADC is a 15-bit sigma-delta ADC.
> -  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
> +  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
>    voltage. The VADC is a 16-bit sigma-delta ADC.
>  
>  properties:
> @@ -28,6 +28,7 @@ properties:
>            - qcom,spmi-vadc
>            - qcom,spmi-adc5
>            - qcom,spmi-adc-rev2
> +          - qcom,spmi-adc7
>  
>    reg:
>      description: VADC base address in the SPMI PMIC register map
> @@ -70,6 +71,8 @@ patternProperties:
>          description: |
>            ADC channel number.
>            See include/dt-bindings/iio/qcom,spmi-vadc.h
> +          For PMIC7 ADC, the channel numbers are specified separately per PMIC
> +          in the PMIC-specific files in include/dt-bindings/iio/.
>  
>        label:
>          $ref: /schemas/types.yaml#/definitions/string
> @@ -89,6 +92,8 @@ patternProperties:
>                of 512 will be used.
>              - For compatible property "qcom,spmi-adc5", valid values are 250, 420
>                and 840. If property is not found, default value of 840 is used.
> +            - For compatible property "qcom,spmi-adc7", valid values are 85, 340
> +              and 1360. If property is not found, default value of 1360 is used.

We express constraints in schema now, don't duplicate with free form 
text.

>              - For compatible property "qcom,spmi-adc-rev2", valid values are 256,
>                512 and 1024. If property is not present, default value is 1024.
>  
> @@ -122,11 +127,11 @@ patternProperties:
>                channel calibration. If property is not found, channel will be
>                calibrated with 0.625V and 1.25V reference channels, also
>                known as absolute calibration.
> -            - For compatible property "qcom,spmi-adc5" and "qcom,spmi-adc-rev2",
> -              if this property is specified VADC will use the VDD reference (1.875V)
> -              and GND for channel calibration. If property is not found, channel
> -              will be calibrated with 0V and 1.25V reference channels, also known
> -              as absolute calibration.
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
> +              "qcom,spmi-adc-rev2", if this property is specified VADC will use
> +              the VDD reference (1.875V) and GND for channel calibration. If
> +              property is not found, channel will be calibrated with 0V and 1.25V
> +              reference channels, also known as absolute calibration.
>          type: boolean
>  
>        qcom,hw-settle-time:
> @@ -149,6 +154,12 @@ patternProperties:
>                Certain controller digital versions have valid values of
>                15, 100, 200, 300, 400, 500, 600, 700, 1, 2, 4, 8, 16, 32, 64, 128 ms
>                If property is not found, channel will use 15us.
> +            - For compatible property "qcom,spmi-adc7", delay = 15us for
> +              value 0, 100us * (value) for values < 8, 1ms for value 8
> +              and 2ms * (value - 8) otherwise.
> +              Valid values are: 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000,
> +              4000, 8000, 16000, 32000, 64000, 128000 us.
> +              If property is not found, channel will use 15us.
>  
>        qcom,avg-samples:
>          $ref: /schemas/types.yaml#/definitions/uint32
> @@ -160,6 +171,9 @@ patternProperties:
>              - For compatible property "qcom,spmi-vadc", valid values
>                are: 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
>                If property is not found, 1 sample will be used.
> +            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7"
> +              and "qcom,spmi-adc-rev2", valid values are: 1, 2, 4, 8, 16.
> +              If property is not found, 1 sample will be used.
>  
>      required:
>        - reg
> @@ -244,6 +258,32 @@ allOf:
>                  enum: [ 1, 2, 4, 8, 16 ]
>                  default: 1
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,spmi-adc7
> +
> +    then:
> +      patternProperties:
> +        "^.*@[0-9a-fx]+$":

'x' should not be in unit-addresses.

> +          properties:
> +            qcom,decimation:
> +              items:

Not an array, so 'items' doesn't make sense here.

> +                enum: [ 85, 340, 1360 ]
> +                default: 1360
> +
> +            qcom,hw-settle-time:
> +              items:
> +                enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
> +                        8000, 16000, 32000, 64000, 128000 ]
> +                default: 15
> +
> +            qcom,avg-samples:
> +              items:
> +                enum: [ 1, 2, 4, 8, 16 ]
> +                default: 1
> +
>  examples:
>    - |
>      spmi_bus {
