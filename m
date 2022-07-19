Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B957A290
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiGSPBI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237659AbiGSPAn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 11:00:43 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C245DB02
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 08:00:41 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JD2eAB024891;
        Tue, 19 Jul 2022 11:00:33 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3hbt85m2us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 11:00:33 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 26JF0Wxr039321
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jul 2022 11:00:32 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Jul 2022 11:00:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 19 Jul 2022 11:00:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Jul 2022 11:00:30 -0400
Received: from euswvd-wpr-708.reddog.microsoft.com ([10.140.226.204])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 26JF0L5D025152;
        Tue, 19 Jul 2022 11:00:23 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <andy.shevchenko@gmail.com>,
        <Ibrahim.Tilki@analog.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: adc: add adi,max11410.yaml
Date:   Tue, 19 Jul 2022 14:59:30 +0000
Message-ID: <20220719145932.96-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707164810.7811fbb0@jic23-huawei>
References: <20220707164810.7811fbb0@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: N67q5UIorquPQZLkbmO7AmBl3KIM81w3
X-Proofpoint-GUID: N67q5UIorquPQZLkbmO7AmBl3KIM81w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_03,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207190062
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> On Thu, 7 Jul 2022 08:31:26 +0000
> Ibrahim Tilki <Ibrahim.Tilki@analog.com> wrote:
> 
> > Adding devicetree binding documentation for max11410 adc.
> > 
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> 
> Hi.
> 
> A few questions inline. Mostly stuff I couldn't figure out from a quick
> scan through the datasheet.
> 
> > ---
> >  .../bindings/iio/adc/adi,max11410.yaml        | 168 ++++++++++++++++++
> >  1 file changed, 168 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > new file mode 100644
> > index 000000000..f28d29fb2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > @@ -0,0 +1,168 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2022 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,max11410.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices MAX11410 ADC device driver
> > +
> > +maintainers:
> > +  - Ibrahim Tilki <ibrahim.tilki@analog.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can be
> > +  found here:
> > +    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max11410
> > +
> > +  reg:
> > +    description: SPI chip select number for the device
> 
> Description not needed as same for all SPI devices.
> 

Removed in v3.

> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: IRQ line for the ADC
> The description doesn't tell us anything so drop it.
> There is no need to provide description lines for self documenting
> items like this.

Removed in v3.

> > +    maxItems: 1
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  avdd-supply:
> > +    description: avdd supply can be used as reference for conversion.
> 
> Mention it's also a necessary power supply.  As mentioned in driver review
> I'd suggest you actually treat this as 'no explicit reference supplied'.
> That simplifies the meaning of the adi,reference below.
> 

Please see my comments to this in section "adi,reference".

> > +
> > +  vref0p-supply:
> > +    description: vref0p supply can be used as reference for conversion.
> > +
> > +  vref1p-supply:
> > +    description: vref1p supply can be used as reference for conversion.
> > +
> > +  vref2p-supply:
> > +    description: vref2p supply can be used as reference for conversion.
> > +
> > +  vref0n-supply:
> > +    description: vref0n supply can be used as reference for conversion.
> > +
> > +  vref1n-supply:
> > +    description: vref1n supply can be used as reference for conversion.
> > +
> > +  vref2n-supply:
> > +    description: vref2n supply can be used as reference for conversion.
> > +
> > +  spi-max-frequency:
> > +    maximum: 8000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - avdd-supply
> > +
> > +patternProperties:
> > +  "^channel(@[0-9a-f]+)?$":
> > +    $ref: "adc.yaml"
> > +    type: object
> > +    description: Represents the external channels which are connected to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number in single-ended mode.
> > +        minimum: 0
> > +        maximum: 10
> > +
> > +      adi,reference:
> > +        description: |
> > +          Select the reference source to use when converting on
> > +          the specific channel. Valid values are:
> > +          0: REF0P/REF0N
> 
> VREF0P etc to match namign above.
> 

Corrected in v3.

> > +          1: REF1P/REF1N
> > +          2: REF2P/REF2N
> > +          3: AVDD/AGND
> > +          4: REF0P/AGND
> > +          5: REF1P/AGND
> > +          6: REF2P/AGND
> 
> Is it valid to use REF0P/AGND for a differential channel?  If not
> I would reduce this list to 0-2 only.  If it is valid (so actually
> useful to do so) then we are stuck with this.  That does make me wonder
> if there is a difference between 3 and 7?  If not, just don't list 7
> 

Yes, it is valid. Option 3 and 7 are the same, 7 is removed in v3.

I think we should list 4-6 here and removing 3 would cause more confusion
to users in that case. This enum reflects the register field directly, maybe we
can do some mapping for convenience. AVDD is already treated as default reference
and user is free to specify it explicitly.

Maybe we can split reference description into two parts:
"adi,reference" = <0>; // [0-2], AVDD if not specified.
"adi,reference-n-agnd"; // boolean for connecting negative input to agnd.

But I think it would be more confusing. The most straightforward way is the enum IMO.
I cannot think of a better way to describe reference than what we already have.

> > +          7: AVDD/AGND
> > +          If this field is left empty, AVDD/AGND is selected.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +        default: 7

...
