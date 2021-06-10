Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7A3A2A20
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJL1k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 07:27:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:31037 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJL1k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 07:27:40 -0400
X-Greylist: delayed 5351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 07:27:39 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1623324340; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kMaJnRCmK3pM00zwoIAFaK2fzMgsncYpUL6mtB9QYneg7TtPQtE3wFWg3OfQwDH9Az
    vQHhVCXo72v2zIBrWm0YTJB7LF8QIKCu3hqJDU1BkRJE1oe8W0SlO1+Z8UvhyPiOjIn3
    ZrMoLwqwYOPY57Z3/pgUOfKCT3CAH0GnFYOTYgwF+c33SZSPsH7BoEmrWTGKIfUD5Ozo
    eaKIzy9XV9GSLfKTmTWEcD8N8f0qV7icGvc1TjKfmQ2ZZbiBLx/y/lfHKMnUF2wbpUcl
    OuQBzKVHLGidyTIoyQbBEUFPGvPrhnpjsaSPtstggIY3zBnajGXXMZEcNpm4qeoVMB3j
    14Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623324340;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1WVSBndPGbx2t1HrcMlYrtSeGKXkrVerGYD+9o506GE=;
    b=IPHp0ZWoH/0easmhkjXnqJ2DTV3I4qHNvsyMRWPv6457eeyI49OvMqhLpMrAVwQno8
    meKRuPlJnkfJEW42WlUtgOAR7IjVLbGDl2r1jOuYF6aZbtvaIb1kRd9J4p5chvfeaE9s
    GdI5xMYVXHaPH821/PDF+/vKndFNYq5lUeroZYDV1RLOzKiTKVfb2xu8xFErb7FiRi6M
    vfdql2W60GaxRYsrQhONzaaFOzyhKxQfWm7i29TkChjwJ008UEF/IEmAx9DzVYVLvs+l
    cGBtCa+UOTg4WjpHxe1cGrKQOBv0V1NLPG2Wa6Ktn60OMiMDYsr+NNgmGTF+2+zVIJNP
    D52g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623324340;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1WVSBndPGbx2t1HrcMlYrtSeGKXkrVerGYD+9o506GE=;
    b=QemOYP009w2SfEuWDRiiIWNQY0W6x9Idh4woHRCFtQy1rrp6KP4QBHpYbwZsg9JaBZ
    YRFle+R0+EBtI8tEtpzaw5RqOYQcxBqtCuQl17npephnMVTjQ2zFpRfM/Xr6h0VoIWFw
    4TzwTNFr5mPBRAMpWfXKqtn3MUuL6S/zZJ/qZNc5kGBpWUBlDAnxJT02ZNusN7VRiCwf
    HGxu7CufRZd48hsdzjav5OYl+pjGl0llCY282UjELZ3XyG2ZHWD7kLtVkus+MziMyzjb
    YK79xZmmu7IUl7frin8860eEOMpVNC+Sk8g16JDvGhpR1k2KMtwBtwr+O3jfaBB/MsV0
    bsOQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nxIc/BaYo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ABPetWp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 13:25:40 +0200 (CEST)
Date:   Thu, 10 Jun 2021 13:25:35 +0200
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
Message-ID: <YMH2r3TXp0+qYiLN@gerhold.net>
References: <20210610095300.3613-1-stephan@gerhold.net>
 <CAHp75Vc2c3GX5jESbGexnwJ-WUtZHCjVNsqTVykCrViCjH77+Q@mail.gmail.com>
 <YMHt1Z1QKUGMPDZX@gerhold.net>
 <CAHp75Vervzi9zXdWef8vpGZwM5wS3LtuKTY9f5j9QA0Asbea2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vervzi9zXdWef8vpGZwM5wS3LtuKTY9f5j9QA0Asbea2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 01:51:22PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 10, 2021 at 1:48 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > On Thu, Jun 10, 2021 at 01:29:26PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jun 10, 2021 at 12:56 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > > >
> > > > The Bosch BMA253 accelerometer is very similar to both BMA254 and BMA255.
> > > > The current situation is very confusing: BMA254 is supported by the bma180
> > > > driver, but BMA255 is supported by the bmc150-accel driver.
> > > >
> > > > It turns out the bma180 and bmc150-accel drivers have quite some overlap,
> > > > and BMA253/BMA254 would be a bit better supported in bmc150
> > > > (which has support for the motion trigger/interrupt).
> > > >
> > > > This series adds BMA253 support to bmc150-accel and also moves BMA254
> > > > over to bmc150, removing some unnecessary code from the bma180 driver.
> > > >
> > > > I asked Linus Walleij to test these patches on BMA254 a while ago
> > > > and he suggested that I already add his Reviewed-by.
> > >
> > > I add
> > >
> > >
> > > After addressing comments per patch 1, feel free to add my
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > to the series.
> > >
> >
> > Thanks for the review!
> >
> > I think the re-ordering should be a separate commit to make the diff not
> > too confusing. Is it fine for you if I send that as a follow-up patch?
> > I already have two more patches that would conflict with the reordering,
> > so it would be easier to include that in the next series.
> >
> > But I can also re-send the entire series with the extra patch if you
> > prefer that, just let me know. :)
> 
> I think that doing the reordering first (if there are no fixes so far)
> is a good idea.
> 

OK, I will try to do that somehow. I will probably prepend one of my
additional patches to this series since it has a Fixes: tag that would
just cause the stable people headaches later when backporting.

Thanks,
Stephan
