Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C483A299A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 12:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhFJKt5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 06:49:57 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.104]:13107 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhFJKt4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 06:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623322076; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pVGRBInTCe8yJR69vKX7XN52uZtLhIqsLVpg51aWeygm1x9dfbbKwz8kJp4toe9DN3
    pDko6xBblv/W2V2b9wtstOrwV6xw1kKiU5SK1PtfWN1+i8issIwsuhJPoSQjFz0TySkU
    X3ozVxaRebVEN246v5DSu6fFSkToc+J3jJZ0xQ5Y+kw+ibnrzruzLiPwdHb6Y91b/M5k
    vCk5Ubsip6knRvvASSmXsKXzVSXJkpu+aMLBbuZHIWKj6V+oH9iTNGIja4Rn9mdocbI9
    7CD9WSBemlcw1FOLyo+TCRoYcy2NRUvc5eFBKiYlJfkwjRHldkEUGELoIfsj2KWz5Bxa
    c7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623322076;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Bm99M6s0qTGEiPIsLyxdPHk0FCKA2V3t0XhTXzjpNnA=;
    b=PdTueLPa7LAv3UpBL6ZmABayj7Ob2K8ALSmFnjiQhCW5klhEIRM3ptEmam1ERF9dg6
    X6nW/JoLSZtVjCFU1GrvmhK7MR7yg3gQKDscasauiFBw4ML7A8bCoVFuX+6Tulj64Tw9
    xrjJwK1uUs8vpGYjWKk/beLnQ1lOrzQnGSDsszI3geQrJWLTSY4A5rRCtDZXbdfdNBxP
    JnH0qH4VJPIvnjThIVWl2Ax04UA0cJGQ5huwy7emaxzIcEkNpUd1d+wleRVrq5gYnwZB
    woJcuZuO6Uy0jUu4nos75KLqyBb+8qd7jvT3/K0kYXXooHEHFkLRGsGpxibmqGBedVqm
    IGRA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623322076;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Bm99M6s0qTGEiPIsLyxdPHk0FCKA2V3t0XhTXzjpNnA=;
    b=h1F7OOvjXVAL4+Odx09eNKaO7roZSdFJL1B/t3wmkVmiybM3qXD4GDkh0x2f6gmIbb
    2c3xuu7KnOXdLOgzflX6RZEEMBS+fscbVvXNoZARBIPMt0EDLRjnDmg7tEIQzchnmULG
    edpvOr4BpdjW24bPfYIQxD6bi/rpeUEO6awzVXvxBGoCWMMPYv5VDXuVUrP0cPBZFPfz
    xNxtgJ04kfVUOx/Ihcogz4/jd1jSdK2KpnMH+HAl1az05Cg2St1Enz1TT7CPROG4Nmmo
    6AMvuaTmdLGcoGPmWPjQ2S0tPxbTnZc5ssQsgXE1XU+WLCL5TZquC8LsnIA6hgFbAiOo
    scXA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nxIc/BaYo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5AAlttHB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 12:47:55 +0200 (CEST)
Date:   Thu, 10 Jun 2021 12:47:49 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/6] iio: accel: bmc150: Add support for BMA253/BMA254
Message-ID: <YMHt1Z1QKUGMPDZX@gerhold.net>
References: <20210610095300.3613-1-stephan@gerhold.net>
 <CAHp75Vc2c3GX5jESbGexnwJ-WUtZHCjVNsqTVykCrViCjH77+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc2c3GX5jESbGexnwJ-WUtZHCjVNsqTVykCrViCjH77+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 01:29:26PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 10, 2021 at 12:56 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > The Bosch BMA253 accelerometer is very similar to both BMA254 and BMA255.
> > The current situation is very confusing: BMA254 is supported by the bma180
> > driver, but BMA255 is supported by the bmc150-accel driver.
> >
> > It turns out the bma180 and bmc150-accel drivers have quite some overlap,
> > and BMA253/BMA254 would be a bit better supported in bmc150
> > (which has support for the motion trigger/interrupt).
> >
> > This series adds BMA253 support to bmc150-accel and also moves BMA254
> > over to bmc150, removing some unnecessary code from the bma180 driver.
> >
> > I asked Linus Walleij to test these patches on BMA254 a while ago
> > and he suggested that I already add his Reviewed-by.
> 
> I add
> 
> 
> After addressing comments per patch 1, feel free to add my
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> to the series.
> 

Thanks for the review!

I think the re-ordering should be a separate commit to make the diff not
too confusing. Is it fine for you if I send that as a follow-up patch?
I already have two more patches that would conflict with the reordering,
so it would be easier to include that in the next series.

But I can also re-send the entire series with the extra patch if you
prefer that, just let me know. :)

> And I guess you can drop Laurentiu Palcu email because most of those
> sensor drivers were done by an Intel team that is not at the company
> anymore for a few years.
> 

Oh yeah, got a lot of mails that it couldn't be delivered to Laurentiu.
Oh well.

Thanks,
Stephan
