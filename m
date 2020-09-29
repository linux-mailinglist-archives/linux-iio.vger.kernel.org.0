Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3554927CC84
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbgI2MhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 08:37:12 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:8965 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728786AbgI2MhF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 08:37:05 -0400
X-IronPort-AV: E=Sophos;i="5.77,318,1596492000"; 
   d="scan'208";a="360346486"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:36:52 +0200
Date:   Tue, 29 Sep 2020 14:36:52 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     linux-iio@vger.kernel.org, drbd-dev@lists.linbit.com,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        David Lechner <david@lechnology.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        linux-amlogic@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 00/18] use semicolons rather than commas to separate
 statements
In-Reply-To: <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2009291428020.2808@hadrien>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr> <CAMj1kXGh+CzuXkAnqsoMO2A3T1p=D6uFOV347Ym5+VFn5U1gWg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On Tue, 29 Sep 2020, Ard Biesheuvel wrote:

> On Sun, 27 Sep 2020 at 21:56, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > These patches replace commas by semicolons.
>
>
> Why?

Among the complete 5000 lines of changes there is one probable bug where
an if branch ends with a comma and thus pulls the subsequent statement
under the if branch, in contradiction to what is indicated by the
indentation.

The use of comma often appears to be random, with a sequence of similar
statements where some have commas and some don't.

From a self-interested point of view, commas are not good for Coccinelle,
because multiple statements are put into one.  Any problems involving them
are thus likely to be overlooked unless one thinks of looking for them
explicitly.  As an example, Christophe Jaillet noticed that one sequence
of comma assignments would be better written using swap.  If one looked
for opportunities for using swap in the most obvious way, one wouldn't
find it.

julia


>
>
> > This was done using the
> > Coccinelle semantic patch (http://coccinelle.lip6.fr/) shown below.
> >
> > This semantic patch ensures that commas inside for loop headers will not be
> > transformed.  It also doesn't touch macro definitions.
> >
> > Coccinelle ensures that braces are added as needed when a single-statement
> > branch turns into a multi-statement one.
> >
> > This semantic patch has a few false positives, for variable delcarations
> > such as:
> >
> > LIST_HEAD(x), *y;
> >
> > The semantic patch could be improved to avoid these, but for the moment
> > they have been removed manually (2 occurrences).
> >
> > // <smpl>
> > @initialize:ocaml@
> > @@
> >
> > let infunction p =
> >   (* avoid macros *)
> >   (List.hd p).current_element <> "something_else"
> >
> > let combined p1 p2 =
> >   (List.hd p1).line_end = (List.hd p2).line ||
> >   (((List.hd p1).line_end < (List.hd p2).line) &&
> >    ((List.hd p1).col < (List.hd p2).col))
> >
> > @bad@
> > statement S;
> > declaration d;
> > position p;
> > @@
> >
> > S@p
> > d
> >
> > // special cases where newlines are needed (hope for no more than 5)
> > @@
> > expression e1,e2;
> > statement S;
> > position p != bad.p;
> > position p1;
> > position p2 :
> >     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> > @@
> >
> > - e1@p1,@S@p e2@p2;
> > + e1; e2;
> >
> > @@
> > expression e1,e2;
> > statement S;
> > position p != bad.p;
> > position p1;
> > position p2 :
> >     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> > @@
> >
> > - e1@p1,@S@p e2@p2;
> > + e1; e2;
> >
> > @@
> > expression e1,e2;
> > statement S;
> > position p != bad.p;
> > position p1;
> > position p2 :
> >     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> > @@
> >
> > - e1@p1,@S@p e2@p2;
> > + e1; e2;
> >
> > @@
> > expression e1,e2;
> > statement S;
> > position p != bad.p;
> > position p1;
> > position p2 :
> >     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> > @@
> >
> > - e1@p1,@S@p e2@p2;
> > + e1; e2;
> >
> > @@
> > expression e1,e2;
> > statement S;
> > position p != bad.p;
> > position p1;
> > position p2 :
> >     script:ocaml(p1) { infunction p1 && combined p1 p2 };
> > @@
> >
> > - e1@p1,@S@p e2@p2;
> > + e1; e2;
> >
> > @r@
> > expression e1,e2;
> > statement S;
> > position p != bad.p;
> > @@
> >
> > e1 ,@S@p e2;
> >
> > @@
> > expression e1,e2;
> > position p1;
> > position p2 :
> >     script:ocaml(p1) { infunction p1 && not(combined p1 p2) };
> > statement S;
> > position r.p;
> > @@
> >
> > e1@p1
> > -,@S@p
> > +;
> > e2@p2
> > ... when any
> > // </smpl>
> >
> > ---
> >
> >  drivers/acpi/processor_idle.c               |    4 +++-
> >  drivers/ata/pata_icside.c                   |   21 +++++++++++++--------
> >  drivers/base/regmap/regmap-debugfs.c        |    2 +-
> >  drivers/bcma/driver_pci_host.c              |    4 ++--
> >  drivers/block/drbd/drbd_receiver.c          |    6 ++++--
> >  drivers/char/agp/amd-k7-agp.c               |    2 +-
> >  drivers/char/agp/nvidia-agp.c               |    2 +-
> >  drivers/char/agp/sworks-agp.c               |    2 +-
> >  drivers/char/hw_random/iproc-rng200.c       |    8 ++++----
> >  drivers/char/hw_random/mxc-rnga.c           |    6 +++---
> >  drivers/char/hw_random/stm32-rng.c          |    8 ++++----
> >  drivers/char/ipmi/bt-bmc.c                  |    6 +++---
> >  drivers/clk/meson/meson-aoclk.c             |    2 +-
> >  drivers/clk/mvebu/ap-cpu-clk.c              |    2 +-
> >  drivers/clk/uniphier/clk-uniphier-cpugear.c |    2 +-
> >  drivers/clk/uniphier/clk-uniphier-mux.c     |    2 +-
> >  drivers/clocksource/mps2-timer.c            |    6 +++---
> >  drivers/clocksource/timer-armada-370-xp.c   |    8 ++++----
> >  drivers/counter/ti-eqep.c                   |    2 +-
> >  drivers/crypto/amcc/crypto4xx_alg.c         |    2 +-
> >  drivers/crypto/atmel-tdes.c                 |    2 +-
> >  drivers/crypto/hifn_795x.c                  |    4 ++--
> >  drivers/crypto/talitos.c                    |    8 ++++----
> >  23 files changed, 60 insertions(+), 51 deletions(-)
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
