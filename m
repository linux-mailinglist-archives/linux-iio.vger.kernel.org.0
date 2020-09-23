Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9F275946
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIWOAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 10:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgIWOAn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 10:00:43 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B132220D;
        Wed, 23 Sep 2020 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600869642;
        bh=uPO5QEsbdE6AvUAkxiDyJMEnsN9G+X32NRZNdDWX7vo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GKmrh7TKpBRsEGTgA4ERGMC6c1N348Rx3sUa10F5RhBLgK29xbuC3wkccDbFEoX81
         Z4eB1C0TDl+nPx/l4YzfJ1OQMCAGEf5I75L9WTB8gTOwOeAdvzPe399aJsSLPigTeS
         0VGt2YFuxr6cQ7DjfI7HKIZxXJDDJeL7TrTJ28Bg=
Received: by mail-oi1-f182.google.com with SMTP id v20so25129405oiv.3;
        Wed, 23 Sep 2020 07:00:42 -0700 (PDT)
X-Gm-Message-State: AOAM530KJbrl+opgoSkXPxjlcp7sUYo+Tyf3HJ32e8o65dnPHGj0rToj
        NgxNZNhvITamIxXg9u0i0LiqLWcthZe6XCYxow==
X-Google-Smtp-Source: ABdhPJw5m3EwopKpxZHXzXo8D6QAKUjhQa+P6a04N3OwKxbxayvWDjFH81CTtEfTj3d77o1PSZFOQUPKo/164Vp/9hE=
X-Received: by 2002:aca:4d58:: with SMTP id a85mr5948098oib.147.1600869641415;
 Wed, 23 Sep 2020 07:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
 <20200914154809.192174-2-dmitry.baryshkov@linaro.org> <20200922234025.GA3476652@bogus>
 <55d3f181-b9e6-4963-9d0c-cefee875058c@linaro.org>
In-Reply-To: <55d3f181-b9e6-4963-9d0c-cefee875058c@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Sep 2020 08:00:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+Obxpy+Zd-3g8BN2h++S413=8V_ff1A2j91Cqc6RnDQ@mail.gmail.com>
Message-ID: <CAL_JsqK+Obxpy+Zd-3g8BN2h++S413=8V_ff1A2j91Cqc6RnDQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 23, 2020 at 3:07 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 23/09/2020 02:40, Rob Herring wrote:
> > On Mon, Sep 14, 2020 at 06:48:01PM +0300, Dmitry Baryshkov wrote:
> >> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> >> close counterpart of VADC part of those PMICs.
> >>
> >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> ---
> >>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 151 ++++++++++++++++++
> >>   1 file changed, 151 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> >> new file mode 100644
> >> index 000000000000..432a65839b89
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> >> @@ -0,0 +1,151 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm5.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Qualcomm's SPMI PMIC ADC Thermal Monitoring
> >> +maintainers:
> >> +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: qcom,spmi-adc-tm5
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  interrupts:
> >> +    maxItems: 1
> >> +
> >> +  "#thermal-sensor-cells":
> >> +    const: 1
> >> +    description:
> >> +      Number of cells required to uniquely identify the thermal sensors. Since
> >> +      we have multiple sensors this is set to 1
> >> +
> >> +  "#address-cells":
> >> +    const: 1
> >> +
> >> +  "#size-cells":
> >> +    const: 0
> >> +
> >> +  qcom,avg-samples:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    description: Number of samples to be used for measurement.
> >> +    enum:
> >> +      - 1
> >> +      - 2
> >> +      - 4
> >> +      - 8
> >> +      - 16
> >> +    default: 1
> >> +
> >> +  qcom,decimation:
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    description: This parameter is used to decrease ADC sampling rate.
> >> +            Quicker measurements can be made by reducing decimation ratio.
> >> +    enum:
> >> +      - 250
> >> +      - 420
> >> +      - 840
> >> +    default: 840
> >> +
> >> +patternProperties:
> >> +  "^([-a-z0-9]*)@[0-9]+$":
> >
> > Less than 10 as unit-addresses are hex?
>
> 8 channels at max currently. I'll fix to use hex though.

Then it should be @[0-7]$

> >> +    type: object
> >> +    description:
> >> +      Represent one thermal sensor.
> >> +
> >> +    properties:
> >> +      reg:
> >> +        description: Specify the sensor channel.
> >> +        maxItems: 1
> >
> > You need a range of values here.
>
> ok.
>
> >
> >> +
> >> +      io-channels:
> >> +        description:
> >> +          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
> >> +
> >> +      qcom,adc-channel:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        description: Corresponding ADC channel ID.
> >
> > Why is this not a cell in io-channels?
>
>
> Do you mean parsing a cell from io-channels rather than specifying it
> again? Sounds like a good idea.

Yes.

> >> +      qcom,ratiometric:
> >> +        $ref: /schemas/types.yaml#/definitions/flag
> >> +        description:
> >> +          Channel calibration type.
> >> +          If this property is specified VADC will use the VDD reference
> >> +          (1.875V) and GND for channel calibration. If property is not found,
> >> +          channel will be calibrated with 0V and 1.25V reference channels,
> >> +          also known as absolute calibration.
> >> +
> >> +      qcom,hw-settle-time:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        description: Time between AMUX getting configured and the ADC starting conversion.
> >
> > Time values should have a unit suffix. Seems like a commmon ADC
> > property...
>
> Could you please be more specific here? Would you like for me to just
> specify the unit in the description?

More a question for Jonathan I guess as to whether this should be
common or not. Maybe we have something already. Settle or acquisition
time is a common thing for ADCs, right?

Properties with units need a suffix as defined in
.../bindings/property-units.txt.

Rob
