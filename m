Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1228B3CD3E7
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhGSKtF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 06:49:05 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:21388 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbhGSKtF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 06:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626694003;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gOVW74tbyAb3gpoCUimfW1muG7xDS0xi+AzomYVOF2s=;
    b=Q1R90xzwYBmb3xnp4XhNuRwakSdHofCGEOs+dBKqlGSwg4G6P/D/rkOB3dbw5+y3MG
    FqQ2rMUCnnEGhKUdvxJEfhzxDLomkzC52XyL05udaH1Qnmym7zlCCsYlSiipLxrgaFGr
    3oTQP+1D7GqzIisXCDiRt/1wYo/U6D+VdyJ+OXfCFC+xoWSqpSPxqhZ+HpeZ4TatAyWW
    x+JPEnVsmNjyOla0e3UBmC+2iCyFjq2wMkLg/z2Q7PfEHT28NNOrHwJOHiekYLssY4bi
    TgiVOipd9j/ut8G0Qga+t3J2GXS1h8tUEBTI7YtPHfaIDE557bP7bOQWJWHb4knxnIh9
    Orcw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4m6O43/v"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id g02a44x6JBQg27Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jul 2021 13:26:42 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/4] iio: accel: bmc150: Add support for INT2 and BMC156
Date:   Mon, 19 Jul 2021 13:21:52 +0200
Message-Id: <20210719112156.27087-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series makes it possible to set up interrupts with the BMC150 driver
on boards where only the INT2 pin is connected (and not INT1). This is
particularly always the case for BMC156 since for some reason it only
has the INT2 pin and not the INT1 pin.

These changes were already partially discussed here:
https://lore.kernel.org/linux-iio/YMOphuXSoODIVX06@gerhold.net/

Stephan Gerhold (4):
  dt-bindings: iio: accel: bma255: Add interrupt-names
  dt-bindings: iio: accel: bma255: Add bosch,bmc156_accel
  iio: accel: bmc150: Make it possible to configure INT2 instead of INT1
  iio: accel: bmc150: Add support for BMC156

 .../bindings/iio/accel/bosch,bma255.yaml      | 27 +++++++
 drivers/iio/accel/Kconfig                     |  5 +-
 drivers/iio/accel/bmc150-accel-core.c         | 77 +++++++++++++++----
 drivers/iio/accel/bmc150-accel-i2c.c          | 10 ++-
 drivers/iio/accel/bmc150-accel-spi.c          | 10 ++-
 drivers/iio/accel/bmc150-accel.h              |  9 ++-
 6 files changed, 118 insertions(+), 20 deletions(-)

-- 
2.32.0

