Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA2A3A6552
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhFNLhX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235292AbhFNLfV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:35:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6436561107;
        Mon, 14 Jun 2021 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670398;
        bh=kbj0BgHD5ldkCSyr0ygRZnxHwH236NguuN1JabBSwMQ=;
        h=From:To:Cc:Subject:Date:From;
        b=C7Jj887nOAFybu0KqeXn82Mg2migR3aGQ1vBN3gUEwVn8kdP7B7sAucyRAZsGxv++
         YwJu1ZOKOJNGd3uBPWbXWJ/eXZvHQtHqCjeUFtCScy02lmfZ42WVEYFEgqjHjtXLSA
         hWU+WRbSvu5s2ixbY2Ov/3OZlr1CA+/xiDyyM6I8fvBTA0ZijaXd3mKwhLIOxU9aW0
         fOzYWYVbGEt7U1078xQhLr+fRPH+5EAvBcLwkFoPqDTk8LwHLssf8UQWl2+VkSHbhX
         sMLBkM/tZsdsTxAwbUUy1ABhRqlz2Fth1kHxL5NRfkMZtBuWHSCneBujtSOXBJtY1U
         Tzg09oiW1PVgQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 00/17] iio:adc:ad7280a Cleanup and proposed staging graduation.
Date:   Mon, 14 Jun 2021 12:34:50 +0100
Message-Id: <20210614113507.897732-1-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi All,

This one proved an interesting diversion.

Work done against a somewhat hacked up QEMU emulation of 3 daisy chained
ad7280a devices (18 channels).  Note that the emulation isn't complete
but does do chaining, CRC, and readout of channels etc in a fashion that
worked with the original driver (up to the bug in patch 1) and continues
to work with the updated version. I've not intention to upstream the
emulation (as would need to make it more completed and flexible), but
happy to share it with anyone who is interested.

I briefly flirted with posting a patch to just drop the driver entirely,
but the part is still available and it looked like fun + isn't going
to greatly impact maintainability of the subsystem long term so is low
cost even if it goes obsolete sometime soonish.

There are lots of things we could do after this set to improved the driver
and make things more flexible, but it should basically 'just work'

Anyhow, as normal for staging graduations, last patch has rename detection
turned off so that people can easily see what I am proposing we move
out of staging.

Jonathan Cameron (17):
  staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
  staging:iio:adc:ad7280a: Register define cleanup.
  staging:iio:adc:ad7280a: rename _read() to _read_reg()
  staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
  staging:iio:adc:ad7280a: Use bitfield ops to managed fields in
    transfers.
  staging:iio:adc:ad7280a: Switch to standard event control
  staging:iio:adc:ad7280a: Standardize extended ABI naming
  staging:iio:adc:ad7280a: Drop unused timestamp channel.
  staging:iio:adc:ad7280a: Trivial comment formatting cleanup
  staging:iio:adc:ad7280a: Make oversampling_ratio a runtime control
  staging:iio:adc:ad7280a: Cleanup includes
  staging:iio:ad7280a: Reflect optionality of irq in ABI
  staging:iio:adc:ad7280a: Use a local dev pointer to avoid &spi->dev
  staging:iio:adc:ad7280a: Use device properties to replace platform
    data.
  dt-bindings:iio:adc:ad7280a: Add binding
  iio:adc:ad7280a: Document ABI for cell balance switches
  iio:adc:ad7280a: Move out of staging

 .../ABI/testing/sysfs-bus-iio-adc-ad7280a     |   14 +
 .../bindings/iio/adc/adi,ad7280a.yaml         |   87 ++
 drivers/iio/adc/Kconfig                       |   11 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad7280a.c                     | 1116 +++++++++++++++++
 drivers/staging/iio/adc/Kconfig               |   11 -
 drivers/staging/iio/adc/Makefile              |    1 -
 drivers/staging/iio/adc/ad7280a.c             | 1044 ---------------
 drivers/staging/iio/adc/ad7280a.h             |   37 -
 9 files changed, 1229 insertions(+), 1093 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7280a
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7280a.yaml
 create mode 100644 drivers/iio/adc/ad7280a.c
 delete mode 100644 drivers/staging/iio/adc/ad7280a.c
 delete mode 100644 drivers/staging/iio/adc/ad7280a.h

-- 
2.32.0

