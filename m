Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD083A2B63
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFJM0M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:26:12 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:13021 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhFJM0L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:26:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623327845; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hmWcmTbFcfJIZhpN8lB/Af7O8Ffmi1J3tCRRzfEcJ10ocHwRLLjLGVEiK+MaihW1SE
    W9uC1MHnsjTjuC9axGlBZ3cY5YH9OPbnDIMsdXWpHjLYlaKHDk+b47rfM5qwKIYQw+9T
    ZHX/PJLcIuDpIu04QpkPjk3Ae7lfXXAstBL7iQCGruK6JD02uUKpM0TPe7/cchMfI5BK
    KTiQmSrOg10sct7xYKN3tBWYnlqPwYIRRLkWPKHGSjiErx8JmVrDhRl6SwwWhXF3xJ+t
    XpY4x5O+T2cUChf9FzhsqRN5os4coAKmFUXNOkhoHMdRlTtaLYSKiF22dK9V2/LXxBe2
    Whig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327845;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=WWfIAzLAANbVJWhsgxoCayfOaMa3fakGbotSDvMuu90=;
    b=JWtuT/MplLpsFQfGy4TGCVoiNwp0odeGu2zvkhglBDI3v0bG3VNIYW/4RxeN7c+7iz
    AQ2ztX7WR6RpdePf3X3m0RhrjVJ9cVrOGU0qBvvh55Djs8s8/nwwPXznAL9VBF0qso1p
    WY3qfIhOptR2mXl3zMMbQuKRVeJ8JT1D8MSE1geHXtSatN5k4KUsG03bSCvU6upDYrV0
    M6kUaZoIWZCwhB2FEec4PlU4xuDnkcsEGQfwgxXTKssu30PQmwBNcaT/FagP5flC5yD3
    DbDGoe688uDAwPOBMgQjWOhHWrra9xfryosS1+r82G0pHrhHylLr5xPPr1+a/0xtImN4
    Tn5g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623327845;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=WWfIAzLAANbVJWhsgxoCayfOaMa3fakGbotSDvMuu90=;
    b=WJo/1jstHTm5p/9n59JSdSAs+LERsUeKGR6/ZHecBsAlIKhobRvpGnkZImdu5mF1Pe
    S+0a+qyYc9dFBAjG8pVCqDouJk4qh1Oud+HM12mKd9tNObMFYxpjmQVXmFGly94u8r0u
    0H+F8imosx0T6j8oTgyfPfktkYkv0EhwvOvd2+vOL3fB5Bc9xDa3E263JWxZALvSgNXQ
    TYT0an8JTLF+hX3GNGxT7s9rlkMIKr/n+ChDyisLNyn6mNcUKBCyYhnCAUvyRksArScr
    v98F40atcdKQYd3v5YfHNuzfKWmP8ey/a3EQeZiQP0of68PTaacR3F23HIYhIkOkikVI
    oiew==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA626NTAM6"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACO4tzq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:24:04 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 0/9] iio: accel: bmc150: Add support for BMA253/BMA254
Date:   Thu, 10 Jun 2021 14:21:17 +0200
Message-Id: <20210610122126.50504-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Bosch BMA253 accelerometer is very similar to both BMA254 and BMA255.
The current situation is very confusing: BMA254 is supported by the bma180
driver, but BMA255 is supported by the bmc150-accel driver.

It turns out the bma180 and bmc150-accel drivers have quite some overlap,
and BMA253/BMA254 would be a bit better supported in bmc150-accel
(which has support for the motion trigger/interrupt).

This series adds BMA253 support to bmc150-accel and also moves BMA254
over to bmc150, removing some unnecessary code from the bma180 driver.

In v2 I also sneaked in a small fix for the scale table of BMA222
to simplify backporting for the stable people.

---
Changes in v2:
  - Add new "iio: accel: bmc150: Fix bma222 scale unit" patch at the
    beginning so the stable people can backport it without conflicts
  - Add Reviewed-by: from Hans and Andy for all previous patches
  - Add patch 3 and 4 to have all the chip lists in a consistent order
  - Fix last patch to also drop BMA254 from the file header in bma180.c

v1: https://lore.kernel.org/linux-iio/20210610095300.3613-1-stephan@gerhold.net/

Stephan Gerhold (9):
  iio: accel: bmc150: Fix bma222 scale unit
  iio: accel: bmc150: Drop misleading/duplicate chip identifiers
  iio: accel: bmc150: Drop duplicated documentation of supported chips
  iio: accel: bmc150: Sort all chip names alphabetically / by chip ID
  dt-bindings: iio: accel: bma255: Document bosch,bma253
  iio: accel: bmc150: Add device IDs for BMA253
  dt-bindings: iio: bma255: Allow multiple interrupts
  dt-bindings: iio: accel: bma180/bma255: Move bma254 to bma255 schema
  iio: accel: bma180/bmc150: Move BMA254 to bmc150-accel driver

 .../bindings/iio/accel/bosch,bma180.yaml      |  3 +-
 .../bindings/iio/accel/bosch,bma255.yaml      |  9 +-
 drivers/iio/accel/Kconfig                     |  8 +-
 drivers/iio/accel/bma180.c                    | 92 +++----------------
 drivers/iio/accel/bmc150-accel-core.c         | 87 ++++++------------
 drivers/iio/accel/bmc150-accel-i2c.c          | 52 +++++------
 drivers/iio/accel/bmc150-accel-spi.c          | 31 ++++---
 drivers/iio/accel/bmc150-accel.h              | 10 --
 8 files changed, 95 insertions(+), 197 deletions(-)

-- 
2.32.0

