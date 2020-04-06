Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4289B19F9AA
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgDFQGJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 12:06:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728878AbgDFQGJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 12:06:09 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9AEACEE0DA8BD16DC166;
        Mon,  6 Apr 2020 17:06:06 +0100 (IST)
Received: from localhost (10.47.92.64) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 6 Apr 2020
 17:06:05 +0100
Date:   Mon, 6 Apr 2020 17:05:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jishnu Prakash <jprakash@codeaurora.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <linus.walleij@linaro.org>, <sboyd@codeaurora.org>,
        <smohanad@codeaurora.org>, <kgunda@codeaurora.org>,
        <aghayal@codeaurora.org>, Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-iio@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: adc: Add PMIC7 ADC bindings
Message-ID: <20200406170554.00003887@Huawei.com>
In-Reply-To: <fe8056c5-9480-a9a3-9626-5ebab8031b08@codeaurora.org>
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
        <1585064650-16235-3-git-send-email-jprakash@codeaurora.org>
        <20200328165410.7db48818@archlinux>
        <fe8056c5-9480-a9a3-9626-5ebab8031b08@codeaurora.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.64]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Apr 2020 17:15:21 +0530
Jishnu Prakash <jprakash@codeaurora.org> wrote:

> Hi Jonathan,
> 
> On 3/28/2020 10:24 PM, Jonathan Cameron wrote:
> > On Tue, 24 Mar 2020 21:14:09 +0530
> > Jishnu Prakash <jprakash@codeaurora.org> wrote:
> >  
> >> Add documentation for PMIC7 ADC peripheral. For PMIC7 ADC, all SW
> >> communication to ADC goes through PMK8350, which communicates with
> >> other PMICs through PBS.
> >>
> >> Signed-off-by: Jishnu Prakash <jprakash@codeaurora.org>
> >> ---
> >>   .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 28 ++++++++++++++++------
> >>   1 file changed, 21 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> >> index 72db14c..20f010c 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> >> @@ -13,7 +13,7 @@ maintainers:
> >>   description: |
> >>     SPMI PMIC voltage ADC (VADC) provides interface to clients to read
> >>     voltage. The VADC is a 15-bit sigma-delta ADC.
> >> -  SPMI PMIC5 voltage ADC (ADC) provides interface to clients to read
> >> +  SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
> >>     voltage. The VADC is a 16-bit sigma-delta ADC.
> >>   
> >>   properties:
> >> @@ -23,6 +23,7 @@ properties:
> >>         - qcom,spmi-adc5
> >>         - qcom,spmi-adc-rev2
> >>         - qcom,pms405-adc
> >> +      - qcom,spmi-adc7
> >>   
> >>     reg:
> >>       description: VADC base address in the SPMI PMIC register map
> >> @@ -65,6 +66,8 @@ patternProperties:
> >>           description: |
> >>             ADC channel number.
> >>             See include/dt-bindings/iio/qcom,spmi-vadc.h
> >> +          For PMIC7 ADC, the channel numbers are specified separately per PMIC
> >> +          in the PMIC-specific files in include/dt-bindings/iio/.  
> > That makes me thing we really should have separate compatibles.  The
> > parts clearly have differences, even if we haven't needed to use them
> > explicitly as yet.  
> I'm not sure what you mean by this. We have added a new compatible 
> property "qcom,spmi-adc7" for PMIC7 ADC.

I've no idea what I meant either :)

Jonathan
> >  
> >>   
> >>         label:
> >>           description: |
> >> @@ -72,7 +75,7 @@ patternProperties:
> >>               For thermistor inputs connected to generic AMUX or GPIO inputs
> >>               these can vary across platform for the same pins. Hence select
> >>               the platform schematics name for this channel. It is required
> >> -            for "qcom,spmi-adc5" and "qcom,spmi-adc-rev2".
> >> +            for "qcom,spmi-adc5", "qcom,spmi-adc7" and "qcom,spmi-adc-rev2".
> >>           allOf:
> >>             - $ref: /schemas/types.yaml#/definitions/string
> >>   
> >>  


