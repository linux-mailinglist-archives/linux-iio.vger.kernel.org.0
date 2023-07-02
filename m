Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49B2744D0A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jul 2023 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGBJmF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jul 2023 05:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJmF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jul 2023 05:42:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0D0E5C;
        Sun,  2 Jul 2023 02:42:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qv3sl4JQ8z6D9BC;
        Sun,  2 Jul 2023 17:39:07 +0800 (CST)
Received: from localhost (10.48.51.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 2 Jul
 2023 10:41:53 +0100
Date:   Sun, 2 Jul 2023 17:41:48 +0800
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Marco Felsch <m.felsch@pengutronix.de>, <jic23@kernel.org>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alazar@startmail.com>, <daniel.baluta@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: fix datarate max
 value and meaning
Message-ID: <20230702174148.00004260@Huawei.com>
In-Reply-To: <20230621-unsavory-ransack-f0a3af93325c@spud>
References: <20230621160857.3400747-1-m.felsch@pengutronix.de>
        <20230621-unsavory-ransack-f0a3af93325c@spud>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.51.211]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Jun 2023 21:41:05 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jun 21, 2023 at 06:08:57PM +0200, Marco Felsch wrote:
> > Datarate (dr) is a 3-bit wide register field. Values from 0 to 7 are
> > allowed for all devices but only for the ADS1115 devices a value of 7
> > does make a difference.
> > 
> > While on it fix the description of the datarate for ADS1115 devices as
> > well.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> >  .../devicetree/bindings/iio/adc/ti,ads1015.yaml   | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > index 2127d639a7683..e004659099c19 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > @@ -78,9 +78,9 @@ patternProperties:
> >        ti,datarate:
> >          $ref: /schemas/types.yaml#/definitions/uint32
> >          minimum: 0
> > -        maximum: 6
> > +        maximum: 7
> >          description: |
> > -          Data acquisition rate in samples per second
> > +          Data acquisition rate in samples per second for ADS1015, TLA2024
> >            0: 128
> >            1: 250
> >            2: 490
> > @@ -88,6 +88,17 @@ patternProperties:
> >            4: 1600 (default)
> >            5: 2400
> >            6: 3300
> > +          7: 3300
> > +
> > +          Data acquisition rate in samples per second for ADS1115
> > +          0: 8
> > +          1: 16
> > +          2: 32
> > +          3: 64
> > +          4: 128 (default)
> > +          5: 250
> > +          6: 475
> > +          7: 860  
> 
> I'll leave this one to Rob or Krzysztof to ack/review, but this does
> seem like as good an opportunity as any to migrate to a property that
> allows you to put the actual data acquisition rate in & not have to add
> new key-value mappings to the binding to support devices with differing
> schemes.

I agree a value would have been better, but now we are where we are,
I'm not sure it's worth the churn of changing it - particularly as the
driver will need to support the old binding for every anyway.

Jonathan

> 
> >  
> >      required:
> >        - reg
> > -- 
> > 2.39.2
> >   
> 

