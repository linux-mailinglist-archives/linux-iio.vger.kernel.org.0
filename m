Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111B3275BBA
	for <lists+linux-iio@lfdr.de>; Wed, 23 Sep 2020 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIWPYh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Sep 2020 11:24:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2915 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbgIWPYh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Sep 2020 11:24:37 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 204A9E9A6D34B297EF64;
        Wed, 23 Sep 2020 16:24:35 +0100 (IST)
Received: from localhost (10.52.124.240) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 23 Sep
 2020 16:24:34 +0100
Date:   Wed, 23 Sep 2020 16:22:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Zhang Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5 1/9] dt-bindings: thermal: qcom: add adc-thermal
 monitor bindings
Message-ID: <20200923162254.00003ebb@Huawei.com>
In-Reply-To: <CAL_JsqK+Obxpy+Zd-3g8BN2h++S413=8V_ff1A2j91Cqc6RnDQ@mail.gmail.com>
References: <20200914154809.192174-1-dmitry.baryshkov@linaro.org>
        <20200914154809.192174-2-dmitry.baryshkov@linaro.org>
        <20200922234025.GA3476652@bogus>
        <55d3f181-b9e6-4963-9d0c-cefee875058c@linaro.org>
        <CAL_JsqK+Obxpy+Zd-3g8BN2h++S413=8V_ff1A2j91Cqc6RnDQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.240]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Sep 2020 08:00:29 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 23, 2020 at 3:07 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 23/09/2020 02:40, Rob Herring wrote:  
> > > On Mon, Sep 14, 2020 at 06:48:01PM +0300, Dmitry Baryshkov wrote:  
> > >> Add bindings for thermal monitor, part of Qualcomm PMIC5 chips. It is a
> > >> close counterpart of VADC part of those PMICs.
> > >>
> > >> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >> ---
> > >>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml   | 151 ++++++++++++++++++
> > >>   1 file changed, 151 insertions(+)
> > >>   create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> > >> new file mode 100644
> > >> index 000000000000..432a65839b89
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
> > >> @@ -0,0 +1,151 @@
> > >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/thermal/qcom-spmi-adc-tm5.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: Qualcomm's SPMI PMIC ADC Thermal Monitoring
> > >> +maintainers:
> > >> +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    const: qcom,spmi-adc-tm5
> > >> +
> > >> +  reg:
> > >> +    maxItems: 1
> > >> +
> > >> +  interrupts:
> > >> +    maxItems: 1
> > >> +
> > >> +  "#thermal-sensor-cells":
> > >> +    const: 1
> > >> +    description:
> > >> +      Number of cells required to uniquely identify the thermal sensors. Since
> > >> +      we have multiple sensors this is set to 1
> > >> +
> > >> +  "#address-cells":
> > >> +    const: 1
> > >> +
> > >> +  "#size-cells":
> > >> +    const: 0
> > >> +
> > >> +  qcom,avg-samples:
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > >> +    description: Number of samples to be used for measurement.
> > >> +    enum:
> > >> +      - 1
> > >> +      - 2
> > >> +      - 4
> > >> +      - 8
> > >> +      - 16
> > >> +    default: 1
> > >> +
> > >> +  qcom,decimation:
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > >> +    description: This parameter is used to decrease ADC sampling rate.
> > >> +            Quicker measurements can be made by reducing decimation ratio.
> > >> +    enum:
> > >> +      - 250
> > >> +      - 420
> > >> +      - 840
> > >> +    default: 840
> > >> +
> > >> +patternProperties:
> > >> +  "^([-a-z0-9]*)@[0-9]+$":  
> > >
> > > Less than 10 as unit-addresses are hex?  
> >
> > 8 channels at max currently. I'll fix to use hex though.  
> 
> Then it should be @[0-7]$
> 
> > >> +    type: object
> > >> +    description:
> > >> +      Represent one thermal sensor.
> > >> +
> > >> +    properties:
> > >> +      reg:
> > >> +        description: Specify the sensor channel.
> > >> +        maxItems: 1  
> > >
> > > You need a range of values here.  
> >
> > ok.
> >  
> > >  
> > >> +
> > >> +      io-channels:
> > >> +        description:
> > >> +          From common IIO binding. Used to pipe PMIC ADC channel to thermal monitor
> > >> +
> > >> +      qcom,adc-channel:
> > >> +        $ref: /schemas/types.yaml#/definitions/uint32
> > >> +        description: Corresponding ADC channel ID.  
> > >
> > > Why is this not a cell in io-channels?  
> >
> >
> > Do you mean parsing a cell from io-channels rather than specifying it
> > again? Sounds like a good idea.  
> 
> Yes.
> 
> > >> +      qcom,ratiometric:
> > >> +        $ref: /schemas/types.yaml#/definitions/flag
> > >> +        description:
> > >> +          Channel calibration type.
> > >> +          If this property is specified VADC will use the VDD reference
> > >> +          (1.875V) and GND for channel calibration. If property is not found,
> > >> +          channel will be calibrated with 0V and 1.25V reference channels,
> > >> +          also known as absolute calibration.
> > >> +
> > >> +      qcom,hw-settle-time:
> > >> +        $ref: /schemas/types.yaml#/definitions/uint32
> > >> +        description: Time between AMUX getting configured and the ADC starting conversion.  
> > >
> > > Time values should have a unit suffix. Seems like a commmon ADC
> > > property...  
> >
> > Could you please be more specific here? Would you like for me to just
> > specify the unit in the description?  
> 
> More a question for Jonathan I guess as to whether this should be
> common or not. Maybe we have something already. Settle or acquisition
> time is a common thing for ADCs, right?

It's not common in my experience, but not unheard of.
Only cases currently supporting controlling it explicitly in the
kernel that I can spot, are currently all qcom parts
(I'd guess they are all using the same IP underneath)

I think it is usually it's a case of building your analog
circuitry to match the spec of your ADC / MUX rather than
relaxing that spec by adding a delay.

It's a property with obvious enough meaning though that I
wouldn't have a problem with it being a generic property even
it is one that doesn't actually get used much.

> 
> Properties with units need a suffix as defined in
> .../bindings/property-units.txt.

We have a bunch of legacy bindings that don't have units but
all new ones certainly should!

Thanks,

Jonathan

> 
> Rob


