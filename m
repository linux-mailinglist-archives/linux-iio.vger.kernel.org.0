Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4151E3D70F6
	for <lists+linux-iio@lfdr.de>; Tue, 27 Jul 2021 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhG0INc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 27 Jul 2021 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbhG0INc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 04:13:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BAAC061757
        for <linux-iio@vger.kernel.org>; Tue, 27 Jul 2021 01:13:32 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m8IDP-0007jS-2I; Tue, 27 Jul 2021 10:13:27 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m8IDO-0007JH-02; Tue, 27 Jul 2021 10:13:26 +0200
Message-ID: <145309b88353d4127c659dfabd374252cb2afc48.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/3] iio: adc: Add driver for Renesas RZ/G2L A/D
 converter
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Date:   Tue, 27 Jul 2021 10:13:25 +0200
In-Reply-To: <CA+V-a8shgfxffdOTj0cyxz36XVxGxUkq1obPJNOSc94BKUWung@mail.gmail.com>
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
         <20210726182850.14328-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
         <f23358e3e040cc8522b259669ec61a22c5439394.camel@pengutronix.de>
         <CA+V-a8shgfxffdOTj0cyxz36XVxGxUkq1obPJNOSc94BKUWung@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2021-07-27 at 09:02 +0100, Lad, Prabhakar wrote:
[...]
> > > +     ret = devm_add_action_or_reset(&pdev->dev,
> > > +                                    rzg2l_adc_reset_assert, adc->adrstn);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
> > > +                     ret);
> > > +             return ret;
> > > +     }
> > 
> > This is the wrong way around. Installing devres actions should be done
> > after the thing they are supposed to revert in case of error. You should
> > move this down below the reset_control_deassert(adc->adrstn).
> > 
> Ouch my understanding was, there won't be any harm in asserting the
> reset line. Agree with will move this below
> reset_control_deassert(adc->adrstn).

You are probably right, but it's still better do it correctly. Just
imagine one of the reset lines turns out to be shared later, or somebody
else will look at this driver for inspiration.

regards
Philipp
