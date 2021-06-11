Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD53A4887
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFKSXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:23:24 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:8040 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFKSXY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 14:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623435678; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pWYHQBFk8L+A8EkTTGJog4B0JvDOrx5AIa7SJhsZ9mMxfu9DVTrCyGjaqGhe05FNcZ
    Cbw/VwrIGwWT7KoU6nurmS8/DhUtdhXTM1rM9NU4olihoHqSRJOHQ/QReQRM3qJB698t
    6mTZ9yBYKl8HgTYUuOQI/eP4CGzp8pL9riquk3Kzmb3pJecec00HlPh3Zw50famGsz2l
    OQNtSnscNbct6z3gx4nfuDj1i3v4napfqYtXehSFmQ+nC9t4/gQgkp/XG0fjWkvgs9/p
    dFdrvnLkCn2y4RUyAQ/Rtct5GX6tj6NyWm4yTVSdOagQGHlwDgNpFTh137kjLrT+tW0E
    4uWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623435678;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lmf4bw65mbkhp3InKqMJNO7ZwRHsfXnSV9W6BmPcfCI=;
    b=rAcceJVKTmqxvyDP6iGjGU0vDTR5U03GHJ9vzw4UJF4pfsh4rUblxTzMLqFClCRj2T
    +74CU7FzpNr2RVuedPhgnm+SRnPn7ao30y2s2AZcxFxrHkEbicHWkDekHere9cOtQBbn
    YnJFTfuYV+n2h/pPh8tG3X+HHPae+iB6KGRIdNzR2fYu85ELFtL9ssV4ON9F46FKKxwk
    OnZZ+D0tddBoAn0lDZz0Lf3U0Lap+9Zr8+mOCBTI2mRxA4//zpoJDNwbuzCbzPl1189Y
    lPI6jxAXAMJtI6uvNwjZVM9YIVpmcleHNDSBJPhDwL6emWfJ64gxlmZNDBwCivx9bMXO
    faAA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623435678;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lmf4bw65mbkhp3InKqMJNO7ZwRHsfXnSV9W6BmPcfCI=;
    b=G/Db1wMSOsBz61SpIGz3R11vUYYeA5lM0OfO6Vwga8bg/R6QIl3oCuDby0b7p2dSas
    PV1QGOaztTqxpLjmjQdaYK7eXf+GGNGQtZIpjLfMPcAu2D5gVU9fbBJvQhF19HTmpchJ
    2ljbNSe8igmSZvBOa0psBB+Lqt4+N6Lpr0QUHniJnPyFasuCgkhVRay6LwHlimmPCuRl
    UlgUzV7JdhYXiKnLEmF1TlZKVPcGMSWJCCUKwdQ4zMsBWeXJVYWFcXUXYUOXzj6y4lOX
    NrLVlPw56/RRNC0fPXJ5ONtGSfBWoMGuwHWjr93bDmUuBX8EOmpzucJikHEz1b69sSVc
    awPA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nwIc3GBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5BILH2oE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 20:21:17 +0200 (CEST)
Date:   Fri, 11 Jun 2021 20:21:05 +0200
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
Message-ID: <YMOphuXSoODIVX06@gerhold.net>
References: <20210611080903.14384-1-stephan@gerhold.net>
 <20210611080903.14384-9-stephan@gerhold.net>
 <20210611185941.3487efc6@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611185941.3487efc6@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 11, 2021 at 06:59:41PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 10:09:01 +0200
> Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > BMA253 has two interrupt pins (INT1 and INT2) that can be configured
> > independently. At the moment the bmc150-accel driver does not make use
> > of them but it might be able to in the future, so it's useful to already
> > specify all available interrupts in the device tree.
> > 
> > Set maxItems: 2 for interrupts to allow specifying a second one.
> > This is necessary as preparation to move the bosch,bma254 compatible
> > from bosch,bma180.yaml to bosch,bma255.yaml since bma180 allows two
> > interrupts, but BMA254 is better supported by the bmc150-accel driver.
> > 
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  .../devicetree/bindings/iio/accel/bosch,bma255.yaml        | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > index 8afb0fe8ef5c..65b299a5619b 100644
> > --- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
> > @@ -32,7 +32,12 @@ properties:
> >    vddio-supply: true
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: |
> > +      The first interrupt listed must be the one connected to the INT1 pin,
> > +      the second (optional) interrupt listed must be the one connected to the
> > +      INT2 pin (if available).
> 
> As this is a direct copy from the bma180 binding and we are moving devices
> from one to the other, we need to support this as the default.
> Longer term, from the bma253 datasheet, it look looks the two pins are equally
> capable so if we get a board where only the int2 pin is connected then we will
> need to use interrupt-names to distinguish the two (as we do in other drivers).
> 

This kind of sounds like a strange board layout in general. But what's
worse is that for some reason even Bosch thought this is a "good" idea
so they released the BMC156 [1]. It works just like the BMC150 but has
only a single interrupt pin. One would expect that would be INT1,
but nope, it's INT2 of course. :-)

I have a device with BMC156 where this is the case, so I guess I need to
make bmc150-accel use INT2 somehow (without specifying INT1). It might
be easiest if we treat this the same way as the case that you mentioned,
i.e. everyone with BMC156 would specify the interrupt-names explicitly
to have a consistent meaning of the device tree.

[1]: https://www.mouser.de/datasheet/2/783/BST-BMC156-DS000-1509546.pdf

> Another thing to note is that we don't have to have separate binding docs just
> because we have separate drivers. At somepoint we might want to consider just
> fusing the two docs.
>  

Good point! I might do that together with the BMC156 changes. :)

Thanks!
Stephan
