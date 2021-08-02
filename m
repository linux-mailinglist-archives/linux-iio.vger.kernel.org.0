Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161B53DDCF0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhHBP5b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 11:57:31 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36478 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhHBP5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Aug 2021 11:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1627919825;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gY1bbe/6ELA+Jh65/Sb7YEW5x3mr2LzaxSbGJqQczGU=;
    b=YLNXwTDzdUYHMG2bt+IMqYfzCcEW8ZJdT0cUTlFudb7YRqLLwyRtDsZ/XkIftExoPf
    82/FHT0BvAB9aro+ilIUzuyCF+OB6wetAWSJLTG8CDnmBxecX2xJEnPTCu8ga0yg8Zs5
    IPWyXGX082A6OdOnMWokILiACB/RLSpMohZQG4vuAlm3oByReXEpgl027M4qRT6OtZ6V
    cJHqObnq/0JIl2RlXdc9vtdMTj1kPP+IXysE99qWF1H9mry9ZfWt5V7WIazIUFdOq9uA
    PDr2JKCTZrv/GIdbTKg5Q1Pz69J7xeFTYkXdD/iynhJE/vD6Egjyq1tnJWIhjn/3GqwH
    Rr1w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIhr0eF6M4Q=="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.30.0 DYNA|AUTH)
    with ESMTPSA id e095f1x72Fv42RB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 2 Aug 2021 17:57:04 +0200 (CEST)
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
Subject: [PATCH v2 0/4] iio: accel: bmc150: Add support for INT2 and BMC156
Date:   Mon,  2 Aug 2021 17:56:53 +0200
Message-Id: <20210802155657.102766-1-stephan@gerhold.net>
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

Changes in v2:
  - PATCH 1/4: Clarify order of "interrupts" with "interrupt-names"
  - PATCH 4/4: Wrap a long line, clarify BOSCH_UNKNOWN with a comment

v1: https://lore.kernel.org/linux-iio/20210719112156.27087-1-stephan@gerhold.net/

Stephan Gerhold (4):
  dt-bindings: iio: accel: bma255: Add interrupt-names
  dt-bindings: iio: accel: bma255: Add bosch,bmc156_accel
  iio: accel: bmc150: Make it possible to configure INT2 instead of INT1
  iio: accel: bmc150: Add support for BMC156

 .../bindings/iio/accel/bosch,bma255.yaml      | 34 +++++++-
 drivers/iio/accel/Kconfig                     |  5 +-
 drivers/iio/accel/bmc150-accel-core.c         | 78 +++++++++++++++----
 drivers/iio/accel/bmc150-accel-i2c.c          | 10 ++-
 drivers/iio/accel/bmc150-accel-spi.c          | 10 ++-
 drivers/iio/accel/bmc150-accel.h              | 20 ++++-
 6 files changed, 134 insertions(+), 23 deletions(-)

-- 
2.32.0

