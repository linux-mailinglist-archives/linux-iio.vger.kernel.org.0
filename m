Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D0B3CD4FA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhGSMCd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 08:02:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:31962 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbhGSMCb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 08:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626698583;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Xmbk3HX33SsTE3zVHSXppoNwsoA9R4gSAF/Tg1NcqN0=;
    b=mWmrXxFnoiOH2v12RIEG5sq1TVWKJBcwzvFmBiwb062AZfdAJcjdE60efXweoEFWee
    gDizBN3kZygJVxrzhBtTtOwy9ajeXad3J2GBwInjeekSQcS/7VKsiRfPSqKSciWgoJVL
    yVXB5allJC05SP3mGWjO4GKs1z3++U+WrH00EBY+We2Xg2rLTxWiEFqiZGLQzWRs/HpZ
    uF40XC5eEMQtQQs9i6W31/CSwTKft0jPWJHfHEQcrchrB/Uy+A/AydZ/7yHt7McixmBl
    znEQkIa5G9nQPg2HXAuFjzHudaUGQ8UW8aUTncbzSy7pO92XHF3Gkcg+2T4WmYVvXeIM
    9dBg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j4IczAa4o="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id g02a44x6JCh22ZP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jul 2021 14:43:02 +0200 (CEST)
Date:   Mon, 19 Jul 2021 14:42:58 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH 0/4] iio: accel: bmc150: Add support for INT2 and BMC156
Message-ID: <YPVzOuZ3zy+q3Hv3@gerhold.net>
References: <20210719112156.27087-1-stephan@gerhold.net>
 <CAHp75Ve-mK59bOt+am2GGXww=vf-BhXmpwCeKvX8rph9tRr3FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve-mK59bOt+am2GGXww=vf-BhXmpwCeKvX8rph9tRr3FQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 19, 2021 at 03:34:50PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 19, 2021 at 2:26 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > This series makes it possible to set up interrupts with the BMC150 driver
> > on boards where only the INT2 pin is connected (and not INT1). This is
> > particularly always the case for BMC156 since for some reason it only
> > has the INT2 pin and not the INT1 pin.
> >
> > These changes were already partially discussed here:
> > https://lore.kernel.org/linux-iio/YMOphuXSoODIVX06@gerhold.net/
> 
> I forgot the story, but the series sounds to me like déjà-vu. Please,
> remind me if it was sent once before? If yes, then this one misses
> version bumping and/or changelog.
> 

Hm, no I didn't send this one before. :)

Perhaps you are confusing it with the patch series I sent for BMA253
support recently [1] which is where I mentioned I would work on BMC156
support as well as follow-up series (see link above). :)

Thanks!
Stephan

[1]: https://lore.kernel.org/linux-iio/20210611080903.14384-1-stephan@gerhold.net/
