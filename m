Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584E83C6D15
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jul 2021 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhGMJTx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Jul 2021 05:19:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3391 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbhGMJTx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jul 2021 05:19:53 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GPF9J3xX8z6L7wy;
        Tue, 13 Jul 2021 17:05:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 13 Jul 2021 11:17:01 +0200
Received: from localhost (10.47.87.34) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 13 Jul
 2021 10:17:00 +0100
Date:   Tue, 13 Jul 2021 10:16:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Liam Beguin <liambeguin@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>,
        <charles-antoine.couret@essensium.com>, <Nuno.Sa@analog.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/4] dt-bindings: iio: adc: ad7949: add
 adi,reference-source
Message-ID: <20210713101642.00001262@Huawei.com>
In-Reply-To: <CCRBPUEYGCAC.CJ1Y3GDWQYYJ@shaak>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
        <20210709155856.1732245-5-liambeguin@gmail.com>
        <20210710180001.051f7367@jic23-huawei>
        <CCRBPUEYGCAC.CJ1Y3GDWQYYJ@shaak>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.34]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Jul 2021 13:05:23 -0400
"Liam Beguin" <liambeguin@gmail.com> wrote:

> Hi Jonathan,
> 
> On Sat Jul 10, 2021 at 1:00 PM EDT, Jonathan Cameron wrote:
> > On Fri, 9 Jul 2021 11:58:56 -0400
> > Liam Beguin <liambeguin@gmail.com> wrote:
> >  
> > > From: Liam Beguin <lvb@xiphos.com>
> > > 
> > > Add bindings documentation for the adi,reference-source property.
> > > This property is required to properly configure the ADC sample request
> > > based on which reference source should be used for the calculation.  
> >
> > Should this be per channel? That will effect some of what I say below...
> >  
> 
> We could make it per channel. Ideally, I'd also like to add support for
> differential channels, so might as well add per channel configurations
> now.
> 
> > > 
> > > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > > ---
> > >  .../bindings/iio/adc/adi,ad7949.yaml          | 21 +++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > > index 9b56bd4d5510..eae3121cad01 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7949.yaml
> > > @@ -35,6 +35,27 @@ properties:
> > >    "#io-channel-cells":
> > >      const: 1
> > >  
> > > +  adi,reference-select:  
> >
> > This is one field in the register, but it's not one thing, so lets break
> > it up
> > in DT. We should do this both to make for more readable dts files and to
> > enforce the requirements on regulators...
> >  
> > > +    description: |
> > > +      Select the reference voltage source to use when converting samples.
> > > +      Acceptable values are:
> > > +      - 0: Internal reference and temperature sensor enabled.
> > > +           Vref=2.5V, buffered output
> > > +      - 1: Internal reference and temperature sensor enabled.
> > > +           Vref=4.096V, buffered output
> > > +      - 2: Use external reference, temperature sensor enabled.
> > > +           Internal buffer disabled
> > > +      - 3: Use external reference, internal buffer and temperature sensor
> > > +           enabled.
> > > +      - 6: Use external reference, internal buffer and temperature sensor
> > > +           disabled.
> > > +      - 7: Use external reference, internal buffer enabled.
> > > +           Internal reference and temperature sensor disabled.  
> >
> > So question 1 is whether to use an external or internal reference.
> > Normally we'd make the coarse decision of whether to use an external
> > reference
> > by whether there is a regulator provided. That won't work so well if we
> > make
> > this per channel.
> >
> > Question 2, assuming internal reference, what voltage? Those should take
> > an actual voltage (probably in mV and match against an enum of the two
> > possible values).
> > Binding should check to make sure this isn't specified as well as saying
> > we
> > are using an external refernce.
> >
> > Question 3, assuming external reference, is temperature sensor enabled?
> > - actually dumb question, but why would anyone not want this enabled?
> > Maybe turn it
> > off in runtime pm, but in general if you've fitted a chip with a
> > temperature sensor
> > you at least sometimes want to measure temperature! So my gut feeling is
> > don't
> > allow this to be controlled (effectively drop cases 6 and 7 above as
> > being
> > unlikely to be of interest to anyone)
> >  
> 
> I like your suggestion of breaking this down so far, it would look
> something like this:
> 
> 	ad7949: adc@0 {
> 		compatible = "adi,ad7949";
> 		reg = <0>;
> 
> 		vref-supply = <&vdd_supply>;
> 
> 		channel@0 {
> 			adi,internal-ref-mv = <2500>;
> 			reg = <0>;
> 		};
> 
> 		channel@1 {
> 			reg = <1>;
> 			/*
> 			 * defaults to vref-supply if defined or error
> 			 * out
> 			 */
> 		};
> 	};
> 
> > Question 4, Is the internal buffer enabled when using and external
> > reference.
> > This one is interesting. We could just expose it in general, but I
> > wonder
> > if we can do something that reflects how it is used. From the various
> > figures in
> > the datasheet this seems to be coupled to whether the external reference
> > is on
> > pin REF_IN or pin REF. If that's the case can we have two optional regs
> > only
> > one of which should be supplied? However, this gets more fiddly because
> > the default right now is vref-supply actually being connected to the
> > vrefin connection.
> > That's annoying as it stops us using the obvious naming...
> > Hence I think we can have
> > vref-supply (actually connected to vrefin) and vref-unbuffered-supply
> >  
> 
> I really like the idea of using the same names as the datasheet
> (vref-supply and vrefin-supply), to infer the buffered state,
> but it's annoying (and confusing) that it's setup the other way
> right now.
> 
> I wonder what happens if the reference is connected to refin and we're
> configured as unbuffered (and the other way around).
> I looked around and I might be able to test it on one setup I have where
> the external reference is connected to REF.
> 
> If it's not a breaking change, would it be okay with you to follow the
> datasheet naming?

Absolutely. If we can get away with fixing that it would be great.

Jonathan

> 
> Liam
> 
> >
> >  
> > > +
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1, 2, 3, 6, 7]
> > > +    default: 7
> > > +
> > >  required:
> > >    - compatible
> > >    - reg  

