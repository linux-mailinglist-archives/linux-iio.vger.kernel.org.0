Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2483A496A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFKTXs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 15:23:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:14322 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhFKTXs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 15:23:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623439305; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=C14f4ImV4YIKUwwLO8flA0EpUUJxp4JFVSxX3+y2oBfeUgJhj3li4GR5ngVZHptAdh
    G4QjxcCNGyLeSByTCZndIi/WiLItgnnZ3XCGbrQD2ophFYUEzwuKnWgvR3jtwH3MQqOG
    oLWxte4QMNbPokJxAsZe4Bb+p55weKbU13VDRh5CpQxlI9CA0fgwe362HiHHBw4/AYJQ
    kHFaeLYW2l0qVC8r+bycKgOOa8nXuMmJtvPTA6WW5uHdbzCvLfyPzL2HEf2UMY24st4u
    FcWTBEwhMTfcqlwzTwsoY4pKt5QttjAJbhuEexUILTrVXb2CuSdseqxFrIv/PuZOwVe7
    +ZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623439304;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=XsT2mc5sUNn8Z5nl+P3PORvjty7kJiP/+u9qOCuo8Uw=;
    b=huXIG/DCfLvcgW5spaBRHWaS8a+IXdXI1KwKPW6/1UsK91AplTfGpm/J0+at9KvmPG
    mccXd+T6hcU1w4jeL2xV+/MZCyOC5mmb5E1AXv2kO8+lkW89XuTuFY8Cy56JG1vVITUA
    WcPVOYgF+woX+f3tBCJV3Vd9lwtODO1Iv81coj0VTYbT+XTEwhwSXxR2lcuLZvhC6kkG
    BvEgCDUV4nYpADU+rHy/aJWC7Wso1XCLZPNgXMroEokoTgCGpoc9vhOb+1JrEzZmDuHc
    wr1/p7ryNp8LEOchmumuyS7Vvcpvzo7mTEI8CvH7Enzc5hqrIova1Fz3xClwRA7bJpZs
    0DFw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623439304;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=XsT2mc5sUNn8Z5nl+P3PORvjty7kJiP/+u9qOCuo8Uw=;
    b=fWRrB8pipPj+4rySyyivK5vx9/lLeh785L5jqbSkriImPhYaKefw9BYyCVObrOSu4d
    cOCihF5yMDhdsoYrBamGotDZbC79xYcijKEA5BtxIh5Zl78qkCpPWXQnKenZk3giArLE
    k8l8eH4W0kuM7QLRcZVXOKC7Ydk+ZDuCYrP3s2iZhpoMVFcIR6bQGxGT45+Tey8VkdHL
    2VMg2Zf2lvlAqyZ0oLDLk827QeeiZnsY9bODax81FCNP+f7AwWsQ3x2rnglT3hbPxA0y
    X2+5X+VZSiwFAicS6IArjzb3YhJ2BI2JpfqIZs7yDI14zO7hLXlAG2Y7drfC3rASeo06
    uwkA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nwIc3GBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5BJLi2vZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 21:21:44 +0200 (CEST)
Date:   Fri, 11 Jun 2021 21:21:39 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 08/10] dt-bindings: iio: bma255: Allow multiple
 interrupts
Message-ID: <YMO3w92OEuLJTWcl@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
 <20210611080903.14384-9-stephan@gerhold.net>
 <20210611185941.3487efc6@jic23-huawei>
 <YMOphuXSoODIVX06@gerhold.net>
 <20210611192639.587838ea@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611192639.587838ea@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 07:26:39PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 20:21:05 +0200
> Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > On Fri, Jun 11, 2021 at 06:59:41PM +0100, Jonathan Cameron wrote:
> > > On Fri, 11 Jun 2021 10:09:01 +0200
> > > Stephan Gerhold <stephan@gerhold.net> wrote:
> > >   
> > > > BMA253 has two interrupt pins (INT1 and INT2) that can be configured
> > > > independently. At the moment the bmc150-accel driver does not make use
> > > > of them but it might be able to in the future, so it's useful to already
> > > > specify all available interrupts in the device tree.
> > > > 
> > > > Set maxItems: 2 for interrupts to allow specifying a second one.
> > > > This is necessary as preparation to move the bosch,bma254 compatible
> > > > from bosch,bma180.yaml to bosch,bma255.yaml since bma180 allows two
> > > > interrupts, but BMA254 is better supported by the bmc150-accel driver.
> > > > 
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > > ---
> > > >  .../devicetree/bindings/iio/accel/bosch,bma255.yaml        | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > > > index 8afb0fe8ef5c..65b299a5619b 100644
> > > > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > > > @@ -32,7 +32,12 @@ properties:
> > > >    vddio-supply: true
> > > >  
> > > >    interrupts:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > > +    description: |
> > > > +      The first interrupt listed must be the one connected to the INT1 pin,
> > > > +      the second (optional) interrupt listed must be the one connected to the
> > > > +      INT2 pin (if available).  
> > > 
> > > As this is a direct copy from the bma180 binding and we are moving devices
> > > from one to the other, we need to support this as the default.
> > > Longer term, from the bma253 datasheet, it look looks the two pins are equally
> > > capable so if we get a board where only the int2 pin is connected then we will
> > > need to use interrupt-names to distinguish the two (as we do in other drivers).
> > >   
> > 
> > This kind of sounds like a strange board layout in general. But what's
> > worse is that for some reason even Bosch thought this is a "good" idea
> > so they released the BMC156 [1]. It works just like the BMC150 but has
> > only a single interrupt pin. One would expect that would be INT1,
> > but nope, it's INT2 of course. :-)
> > 
> > I have a device with BMC156 where this is the case, so I guess I need to
> > make bmc150-accel use INT2 somehow (without specifying INT1). It might
> > be easiest if we treat this the same way as the case that you mentioned,
> > i.e. everyone with BMC156 would specify the interrupt-names explicitly
> > to have a consistent meaning of the device tree.
> 
> That will really confuse people who think they just have one interrupt so
> why do they need the name!  You'll have to special case that delight in
> the driver.
> 

Okay, good that we discussed this before then. :)
I was unsure if it would be better to special case it for BMC156 *or*
add support for the interrupt-names, but perhaps I'm just going to do
*both* then. (Special case it for BMC156, look at interrupt-names for
all others.)

Thanks!
Stephan
