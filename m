Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C727A3DC
	for <lists+linux-iio@lfdr.de>; Sun, 27 Sep 2020 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgI0UC2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Sep 2020 16:02:28 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:14476
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgI0UC2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2020 16:02:28 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 16:02:25 EDT
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169486"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:11 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        David Lechner <david@lechnology.com>,
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH 00/18] use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:10 +0200
Message-Id: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These patches replace commas by semicolons.  This was done using the
Coccinelle semantic patch (http://coccinelle.lip6.fr/) shown below.

This semantic patch ensures that commas inside for loop headers will not be
transformed.  It also doesn't touch macro definitions.

Coccinelle ensures that braces are added as needed when a single-statement
branch turns into a multi-statement one.

This semantic patch has a few false positives, for variable delcarations
such as:

LIST_HEAD(x), *y;

The semantic patch could be improved to avoid these, but for the moment
they have been removed manually (2 occurrences).

// <smpl>
@initialize:ocaml@
@@

let infunction p =
  (* avoid macros *)
  (List.hd p).current_element <> "something_else"

let combined p1 p2 =
  (List.hd p1).line_end = (List.hd p2).line ||
  (((List.hd p1).line_end < (List.hd p2).line) &&
   ((List.hd p1).col < (List.hd p2).col))

@bad@
statement S;
declaration d;
position p;
@@

S@p
d

// special cases where newlines are needed (hope for no more than 5)
@@
expression e1,e2;
statement S;
position p != bad.p;
position p1;
position p2 :
    script:ocaml(p1) { infunction p1 && combined p1 p2 };
@@

- e1@p1,@S@p e2@p2;
+ e1; e2;

@@
expression e1,e2;
statement S;
position p != bad.p;
position p1;
position p2 :
    script:ocaml(p1) { infunction p1 && combined p1 p2 };
@@

- e1@p1,@S@p e2@p2;
+ e1; e2;

@@
expression e1,e2;
statement S;
position p != bad.p;
position p1;
position p2 :
    script:ocaml(p1) { infunction p1 && combined p1 p2 };
@@

- e1@p1,@S@p e2@p2;
+ e1; e2;

@@
expression e1,e2;
statement S;
position p != bad.p;
position p1;
position p2 :
    script:ocaml(p1) { infunction p1 && combined p1 p2 };
@@

- e1@p1,@S@p e2@p2;
+ e1; e2;

@@
expression e1,e2;
statement S;
position p != bad.p;
position p1;
position p2 :
    script:ocaml(p1) { infunction p1 && combined p1 p2 };
@@

- e1@p1,@S@p e2@p2;
+ e1; e2;

@r@
expression e1,e2;
statement S;
position p != bad.p;
@@

e1 ,@S@p e2;

@@
expression e1,e2;
position p1;
position p2 :
    script:ocaml(p1) { infunction p1 && not(combined p1 p2) };
statement S;
position r.p;
@@

e1@p1
-,@S@p
+;
e2@p2
... when any
// </smpl>

---

 drivers/acpi/processor_idle.c               |    4 +++-
 drivers/ata/pata_icside.c                   |   21 +++++++++++++--------
 drivers/base/regmap/regmap-debugfs.c        |    2 +-
 drivers/bcma/driver_pci_host.c              |    4 ++--
 drivers/block/drbd/drbd_receiver.c          |    6 ++++--
 drivers/char/agp/amd-k7-agp.c               |    2 +-
 drivers/char/agp/nvidia-agp.c               |    2 +-
 drivers/char/agp/sworks-agp.c               |    2 +-
 drivers/char/hw_random/iproc-rng200.c       |    8 ++++----
 drivers/char/hw_random/mxc-rnga.c           |    6 +++---
 drivers/char/hw_random/stm32-rng.c          |    8 ++++----
 drivers/char/ipmi/bt-bmc.c                  |    6 +++---
 drivers/clk/meson/meson-aoclk.c             |    2 +-
 drivers/clk/mvebu/ap-cpu-clk.c              |    2 +-
 drivers/clk/uniphier/clk-uniphier-cpugear.c |    2 +-
 drivers/clk/uniphier/clk-uniphier-mux.c     |    2 +-
 drivers/clocksource/mps2-timer.c            |    6 +++---
 drivers/clocksource/timer-armada-370-xp.c   |    8 ++++----
 drivers/counter/ti-eqep.c                   |    2 +-
 drivers/crypto/amcc/crypto4xx_alg.c         |    2 +-
 drivers/crypto/atmel-tdes.c                 |    2 +-
 drivers/crypto/hifn_795x.c                  |    4 ++--
 drivers/crypto/talitos.c                    |    8 ++++----
 23 files changed, 60 insertions(+), 51 deletions(-)
