Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4671F1A6AFF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbgDMRHg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732482AbgDMRHf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Apr 2020 13:07:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D6382063A;
        Mon, 13 Apr 2020 17:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586797654;
        bh=aZjUtUk9QZwo2K36lV5HFVf06Y2lBOpMb8+khBRP8JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DujfD7l5PVD2eexgA0mb8vvI4TrQRk6HOy7OoMqiCxHZp6P47b2VEv6KjP6M0dE2x
         Jly+puteAITXPxDql3q+W9tnHcxkKtxGlr5P6PfAS2MP0Khr1xrhsi2y+fsioFk7cE
         vlWp+5+biQe8//+QZGYtfiUAJ9qlbotuBZlD24dQ=
Date:   Mon, 13 Apr 2020 18:07:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/6] irq/irq_sim: try to improve the API
Message-ID: <20200413180728.0714da3d@archlinux>
In-Reply-To: <CAMRc=Mc=gTrpQsMdOTBJaYT6JLg=o17Mm78ijAGUJYE2pXcCQQ@mail.gmail.com>
References: <20200211131240.15853-1-brgl@bgdev.pl>
        <CAMRc=Mc=gTrpQsMdOTBJaYT6JLg=o17Mm78ijAGUJYE2pXcCQQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Mar 2020 08:57:43 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> wt., 11 lut 2020 o 14:12 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82=
(a):
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This is my second take at improving the interrupt simulator interface.
> > I marked it as v2 but it actually takes a completely different approach.
> >
> > The interrupt simulator API exposes a lot of custom data structures and
> > functions and doesn't reuse the interfaces already exposed by the irq
> > subsystem. This series tries to address it.
> >
> > First, we make irq_domain_reset_irq_data() available to non-V2 domain A=
PI
> > users - that'll be used in the subsequent patch. Next we overhaul the
> > public interfaces - we hide all specific data structures and instead
> > rely on the irq_domain struct and virtual interrupt numberspace.
> >
> > Next four patches simplify the interface even more, but since the change
> > may be a bit more controversial due to modification of the irq_domain
> > I decided to split them out of the second patch.
> >
> > In patch 3/6 we're adding a new callback to irq_domain_ops that is call=
ed
> > right before all the other code in irq_domain_remove(). Next we use it =
to
> > remove the simulator-specific cleanup function from irq_sim.h - users n=
ow
> > can simply use the regular irq_domain_remove().
> >
> > Last two patches show that the new callback isn't limited to the interr=
upt
> > simulator and can be used to shrink code in real driver too. We introdu=
ce
> > a new helper for a common use case of disposing of all mappings before
> > removing the irq_domain and use it in the keystone irqchip driver.
> >
> > The end effect is that we limit the interrupt simulator API to two
> > functions (plus one device managed variant) and zero new structures.
> >
> > v1: https://lkml.org/lkml/2019/8/12/558
> >
> > v1 -> v2:
> > - instead of just making the new data structures opaque for users, remo=
ve
> >   them entirely in favor of irq_domain
> > - call irq_set_handler() & irq_domain_reset_irq_data() when unmapping
> >   the simulated interrupt
> > - fix a memory leak in error path
> > - make it possible to use irq_find_matching_fwnode() with the simulator
> >   domain
> > - correctly use irq_create_mapping() and irq_find_mapping(): only use t=
he
> >   former at init-time and the latter at interrupt-time
> > =20
>=20
> Hi,
>=20
> it's been three weeks, so gentle ping on that.
>=20
> Or should I resend the entire series with a more elaborate commit
> message for patch 1/6?

I'd resend it now if nothing has happened that I missed.  Merge window
having just closed, it's the perfect time for a rebase on rc1.

thanks,

Jonathan

>=20
> Bartosz

