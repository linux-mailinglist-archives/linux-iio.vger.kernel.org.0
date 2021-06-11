Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A040A3A3DC6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFKINw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 04:13:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:13871 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhFKINw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jun 2021 04:13:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623399108; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Yhp1ufU+plb2w7ndSSjd2McDW/6O3DBp8XIN/WdNrZAiQzUxUNln0V8np/bUxgbByI
    9zO7NDfsznUHs4H7pktf2d5MydrDWU4FM3uaRI3sWhkdBEdPAXWaArt3aLYMHQzg1xEV
    UgDfLLYrrfMqa3tYVbHk/EBA3fChCkBqRlqLztFDf2gZmNv7LbEzGoOoTBEMX5heBZSi
    g7tmIt/b8VkxO2nX7OFvp7wya227UMhqBBKlEhL6s3yUmdzhfc4dkAf6B0cIf1EQgpqj
    srKN+dWweb747WQceLCcBNDJZ4Iz3qbVT23ZSo7F54PNgcVTMfD2ND3T7JyBkW0uFN0Z
    MWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399108;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kuM4h7mC8y5z6aurlPPcWWagOJ8KT3YnyvYk99jtCiQ=;
    b=NWF1Np+K1GBG0HY00wFIhrjCpMG7Kp4cDZXag2lzQr3oFLGuoGqZ34Jl3j/BxFFehs
    dxPRM0+UXf/CL8UXhE8xF0g6CnWQp9JPUvrZkY2E+DvBH7EvMxFQ73vwTX8OPnv1xQ4C
    hPWank7Vlnn6KccW6YRSMCdEju/Dw5Lm7xeS6G6xuNX/Wgzir/isd3Y5Q+n6N8yqTwAY
    xPW8mwDNV8WRhLn/GNzoBwM3q9umgN2Taza0Ju18RPW6e3j3sKcWSxHZg4WoXdfZfivJ
    Z70v+isjT67DoZjD3RqsaiLgABGgu4uNLir0XCOqKqgqFXzc5BcTqwYqotath3rfrPZX
    eWbQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623399108;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=kuM4h7mC8y5z6aurlPPcWWagOJ8KT3YnyvYk99jtCiQ=;
    b=XzhQsc8DUz71eqnxYECB2t6h2quPB/gMATka+7qRLSnhBj+Smner5e6KQUaQcj1tvP
    qBO1f2yaFAiRxj8o6QmH4Fo2wSZyklnB93jfbrTUPYXjlK29IUKWz/VP8TueGZzxyVSg
    7X+Od0URCoCLSuB3CsIrvtS41WN/32ksreIhpDcSjkPykcHcYaq8DM3GlVknf9znuXS7
    Cf9Cd7MUPatK4p7frlVNPmo00ndnn0WO3qcpWvGzTXQ1psREPoRItoVkaW48ZW5kRRgI
    hjQJfVvbHZqVRYKnTcr6sP2UUIu2RhWcUmnQD+utSmGyqUpG/WZUqH5JGzXs6zW6bB3E
    7Zpw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxA6m6PrPw="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5B8Bl02c
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 11 Jun 2021 10:11:47 +0200 (CEST)
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
Subject: [PATCH v3 00/10] iio: accel: bmc150: Add support for BMA253/BMA254
Date:   Fri, 11 Jun 2021 10:08:53 +0200
Message-Id: <20210611080903.14384-1-stephan@gerhold.net>
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
Changes in v3:
  - Add new "iio: accel: bmc150: Clarify combo modules in Kconfig" patch
  - Sort "one-line" chip name lists as well, not just multi-line ones

v2: https://lore.kernel.org/linux-iio/20210610122126.50504-1-stephan@gerhold.net/
Changes in v2:
  - Add new "iio: accel: bmc150: Fix bma222 scale unit" patch at the
    beginning so the stable people can backport it without conflicts
  - Add Reviewed-by: from Hans and Andy for all previous patches
  - Add patch 3 and 4 to have all the chip lists in a consistent order
  - Fix last patch to also drop BMA254 from the file header in bma180.c

v1: https://lore.kernel.org/linux-iio/20210610095300.3613-1-stephan@gerhold.net/

Stephan Gerhold (10):
  iio: accel: bmc150: Fix bma222 scale unit
  iio: accel: bmc150: Clarify combo modules in Kconfig
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
 drivers/iio/accel/Kconfig                     | 11 ++-
 drivers/iio/accel/bma180.c                    | 92 +++----------------
 drivers/iio/accel/bmc150-accel-core.c         | 87 ++++++------------
 drivers/iio/accel/bmc150-accel-i2c.c          | 52 +++++------
 drivers/iio/accel/bmc150-accel-spi.c          | 31 ++++---
 drivers/iio/accel/bmc150-accel.h              | 10 --
 8 files changed, 98 insertions(+), 197 deletions(-)

-- 
2.32.0

