Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48FC745594
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jul 2023 08:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGCGq4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jul 2023 02:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGCGqz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jul 2023 02:46:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC51CD
        for <linux-iio@vger.kernel.org>; Sun,  2 Jul 2023 23:46:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qGDKO-0001hK-U0; Mon, 03 Jul 2023 08:46:28 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qGDKM-00038H-Op; Mon, 03 Jul 2023 08:46:26 +0200
Date:   Mon, 3 Jul 2023 08:46:26 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Conor Dooley <conor@kernel.org>, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, alazar@startmail.com, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: fix datarate max
 value and meaning
Message-ID: <20230703064626.2vr6tfwthoi5kivh@pengutronix.de>
References: <20230621160857.3400747-1-m.felsch@pengutronix.de>
 <20230621-unsavory-ransack-f0a3af93325c@spud>
 <20230702174148.00004260@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702174148.00004260@Huawei.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23-07-02, Jonathan Cameron wrote:
> On Wed, 21 Jun 2023 21:41:05 +0100
> Conor Dooley <conor@kernel.org> wrote:
> 
> > On Wed, Jun 21, 2023 at 06:08:57PM +0200, Marco Felsch wrote:
> > > Datarate (dr) is a 3-bit wide register field. Values from 0 to 7 are
> > > allowed for all devices but only for the ADS1115 devices a value of 7
> > > does make a difference.
> > > 
> > > While on it fix the description of the datarate for ADS1115 devices as
> > > well.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  .../devicetree/bindings/iio/adc/ti,ads1015.yaml   | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > > index 2127d639a7683..e004659099c19 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > > @@ -78,9 +78,9 @@ patternProperties:
> > >        ti,datarate:
> > >          $ref: /schemas/types.yaml#/definitions/uint32
> > >          minimum: 0
> > > -        maximum: 6
> > > +        maximum: 7
> > >          description: |
> > > -          Data acquisition rate in samples per second
> > > +          Data acquisition rate in samples per second for ADS1015, TLA2024
> > >            0: 128
> > >            1: 250
> > >            2: 490
> > > @@ -88,6 +88,17 @@ patternProperties:
> > >            4: 1600 (default)
> > >            5: 2400
> > >            6: 3300
> > > +          7: 3300
> > > +
> > > +          Data acquisition rate in samples per second for ADS1115
> > > +          0: 8
> > > +          1: 16
> > > +          2: 32
> > > +          3: 64
> > > +          4: 128 (default)
> > > +          5: 250
> > > +          6: 475
> > > +          7: 860  
> > 
> > I'll leave this one to Rob or Krzysztof to ack/review, but this does
> > seem like as good an opportunity as any to migrate to a property that
> > allows you to put the actual data acquisition rate in & not have to add
> > new key-value mappings to the binding to support devices with differing
> > schemes.
> 
> I agree a value would have been better, but now we are where we are,
> I'm not sure it's worth the churn of changing it - particularly as the
> driver will need to support the old binding for every anyway.

Yep, this would be an API change :/

Regards,
  Marco
