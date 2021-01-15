Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8BA2F7481
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jan 2021 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbhAOIk5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jan 2021 03:40:57 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:11316 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbhAOIk4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2021 03:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610699882;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:From:
        Subject:Sender;
        bh=/ES9AWFZgX/EjpanHclUGFBICYc1TRJYxOhIwf3/NGY=;
        b=qPdMbi5vCh3JClgG7+W19z9NqpWwkLUD7U7eV3iXZhVl5OdyngiCsenNze4Tp9EVwM
        DSJukjvp5V6WGN8XQbwfbtKXLdmu+w7riU/SNaZEoVPZrwkUtXO/u924FOU+ptkhk4Z1
        bvDZ5aICa1ZDuGtrrqGeBzH6oE9YDB46Abl0lamgVRKwoZ7c8XscoQBhc+MYXsac1dch
        EhpvHGTl+zrSq4lg3HmCB3leccNtiJmDZEb7M5isOBplOYbvZDgSaLrf4GdAUNopYDtT
        2bxJLXv8o3cTbAswDdW4tSC50+n80x+n2MRBRNQ9mdl6Y/+Ic5PM3gsE6v4PPVZXh1k8
        aWFg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j6IczBboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id R0a218x0F8bloto
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 15 Jan 2021 09:37:47 +0100 (CET)
Date:   Fri, 15 Jan 2021 09:37:42 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: accel: bma255: Fix bmc150/bmi055
 compatible
Message-ID: <YAFUVuq6upzuH0VF@gerhold.net>
References: <20201202083551.7753-1-stephan@gerhold.net>
 <20201209181739.GA708144@robh.at.kernel.org>
 <20201213132514.00d7ffff@archlinux>
 <20210114205937.11e650d0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114205937.11e650d0@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jan 14, 2021 at 08:59:37PM +0000, Jonathan Cameron wrote:
> On Sun, 13 Dec 2020 13:25:14 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed, 9 Dec 2020 12:17:39 -0600
> > Rob Herring <robh@kernel.org> wrote:
> > 
> > > On Wed, 02 Dec 2020 09:35:51 +0100, Stephan Gerhold wrote:  
> > > > The bmc150-accel-i2c.c driver has an "_accel" suffix for the
> > > > compatibles of BMC150 and BMI055. This is necessary because BMC150
> > > > contains both accelerometer (bosch,bmc150_accel) and magnetometer
> > > > (bosch,bmc150_magn) and therefore "bosch,bmc150" would be ambiguous.
> > > > 
> > > > However, the binding documentation suggests using "bosch,bmc150".
> > > > Add the "_accel" suffix for BMC150 and BMI055 so the binding docs
> > > > match what is expected by the driver.
> > > > 
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Fixes: 496a39526fce8 ("iio: accel: bmc150-accel: Add DT bindings")
> > > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >     
> > > 
> > > Reviewed-by: Rob Herring <robh@kernel.org>  
> > Applied to the fixes-togreg branch of iio.git which is now based on stuff
> > queued up for the merge window. I'll send a pull not long after rc1.
> > 
> 
> Not sure why, but the Fixes tag above is invalid. 
> 

I think we can call this a "race condition" :)

I sent the patch on Dec 02 and you rebased the patch on Dec 03 for
"iio-for-5.11b-take2" (because some sign offs were missing there).
My patch simply refers to the old commit hash.

Stephan
