Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB543AA28C
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 19:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhFPRjJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 13:39:09 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:10897 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFPRjI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jun 2021 13:39:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623864983; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hNABVRRNT2MsdzFbvr6BgvKsjl4Q8/jGzeenj33jMvtHLXqGf8ayKu5ZmZCBXYVfMz
    AoxSwuj3kKEaUekxnXwXU7OWHyi/m/heLJSdeRwm1/xTFn63j6rO3aD5BJkWqwTiG7OA
    4STRymXLan/xQRyHIwIylB6Tjv8W9ZR//6RoPuZ4AG4sIjP6ClQq52F+O6enbSFhRHWz
    mRdkOwntu6OFCiPXLMxjRn9hIC4PcLygxLZ34wB6fPuoI9pxClNjJJ8O5m7jPi3Un2en
    ih7vvOEtWB57Bm35wo53hbVunEjFT1iguJv59Chu3hwRYRVsR5oDbEaJqIP4N9eJQEES
    YfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623864983;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bJxY+zu81GJCcTnIlXXVHY4bPB31CHAa0GD6S4EL93Y=;
    b=KUkdWDXIKJrS/aAxnRNR3HyzolkBEpU8UPedmVyNpKSWF3jnzbMtEh5Ne8B5IaMxcR
    eejyMU1EnMh3HYkODpjx5UR1F+joMVyUPB0pAhMPq289Wyrm/z+2Kk+H9DSWLRcMIw5E
    WT7BW5Lj0mNSdmYFTyrgWcHXVn5xCWUVKRttDGMFsmNUsGeUbzwot96PecGoPEU0mDPC
    L/Vx7/Co4oNYkv/haED3Ju7kHFadlKAuhsAmUSX1ZwdCNkxJaDJCVvt/uNfRIFpR9eKx
    fE0rd3iiviZ3iy5Ix/xadj3HCgHVgRVILEFJQNh4dldVC0gS4jRE4OBNZ91DLzjrIpDP
    nwaA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623864983;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bJxY+zu81GJCcTnIlXXVHY4bPB31CHAa0GD6S4EL93Y=;
    b=oeGzyMzIbJ1eW5Pb/sA2M7ZDg9aXzsM1hERh91L/2hZxKT59hkoxTBdkcyKTr2GgPY
    Du3mO0cvP0xI841esDzbOmhuwJpr5dfrkcmjF9ns8mIBpls/tVc9jqGrieKfF+VdwtXS
    IdOb/1Gbq10voMg0j9pqvAXFr6qxIFB3LvmHFQQZP0eLh49odoMl1RUmgaJ38IKm6F0d
    KhjgZZ1mmhXvp3cjFYIS76SJbd1LDV9SLSvlXgWdKK7WXi9jFJ21illEygFtu7DDQNFU
    hxMkk6SbLe9YGl6b9VDx9v8rJV0GTXlRqZjphL4YqF1XBidBzOgIBvu/fP5vFCJsXpJN
    2Dbw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nxIc3GBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5GHaNZkL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 16 Jun 2021 19:36:23 +0200 (CEST)
Date:   Wed, 16 Jun 2021 19:36:21 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/3] dt-bindings: iio: accel: bma255: Merge bosch,bma180
 schema
Message-ID: <YMo2lVcQd4XMZ6Xr@gerhold.net>
References: <20210614163150.7774-1-stephan@gerhold.net>
 <20210614163150.7774-4-stephan@gerhold.net>
 <CACRpkdb2xrWH8=FZg1AAby1Verof2Z_of9+=JNF+nn_U-jtj3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb2xrWH8=FZg1AAby1Verof2Z_of9+=JNF+nn_U-jtj3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 16, 2021 at 11:04:36AM +0200, Linus Walleij wrote:
> On Mon, Jun 14, 2021 at 6:34 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> 
> > In Linux the bma180 and bmc150-accel driver cover fairly similar chips
> > from Bosch (just with minor register differences). For the DT schema,
> > this does not make any difference: They both represent I2C/SPI devices,
> > have one or two interrupts plus a vdd/vddio-supply.
> >
> > This means there is no need to duplicate the schema, we can just
> > document the compatibles for both drivers in a single DT schema.
> >
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> > Some additional notes:
> >   - The datasheet links in bma180 sadly seem all broken for me so
> >     I just dropped them.
> 
> Fair enough, but some people would be able to obtain them using the
> Wayback machine.
>

Good point, perhaps we should add some links directly to the Wayback
Machine if it still has some of the datasheets. Those links should be
more stable. :)
 
> >   - I separated the bma180/bmc150-accel compatibles using a comment.
> >     This is just for clarity, it has no influence on the schema.
> 
> Some DT binding maintainers may be allergic to any mention of
> Linux particulars in binding documents but I am not so fine by me.
> 

Yeah, I kind of expected this to be honest. I don't mind removing those
comments, just thought it would be a bit less confusing for people who
read the bindings (so they know which driver covers which compatibles).
And for those using the bindings outside Linux, the comments can just be
ignored since they do not have any semantic meaning.

> 
> > In the future we could consider combining even more schemas.
> > In particular bosch,bma400.yaml and bosch,bmi088.yaml are also
> > almost identical, although they currently specify different interrupt
> > types. I think in general the situation for those Bosch sensors is
> > exactly the same: The sensors can be configured to either active-high
> > or active-low level. However, at the moment neither bma400 or bmi088
> > actually implement interrupt support. For now I kept those schemas
> > as-is, I think this is better left up for follow-up patches.
> 
> The situation is caused by Bosch sensortec
> division not being particularly involved with the maintenance of these
> drivers in the Linux kernel. (They did send a few initial patches
> some years back, but since have not been heard from.)
> 
> It would be great to get the attention of someone in charge
> @bosch-sensortec.com.
> 
> Their own drivers seem to target stuff like Arduino but more
> generally on the "OS independence shim"-paradigm:
> https://github.com/BoschSensortec
> 
> They have their own community here:
> https://community.bosch-sensortec.com/t5/Bosch-Sensortec-Community/ct-p/bst_community
> Their users ask questions about Linux sensor support all the time.
> Their stance seem to be to work directly with companies making
> products through FAE:s (field application engineers). It's a bit
> like a guild.
> 
> I tried to find a real mail address to them but failed.
> 

Yeah it would be nice if they would become a bit more involved. But from
my experience with various other vendors I'm not really expecting much
here sadly. However, I would be very happy to be proven otherwise. :)

Thanks!
Stephan
