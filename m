Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C180B2F0446
	for <lists+linux-iio@lfdr.de>; Sun, 10 Jan 2021 00:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbhAIXNT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jan 2021 18:13:19 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60701 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhAIXNT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2021 18:13:19 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B0CC840009;
        Sat,  9 Jan 2021 23:12:35 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/6] iio:pressure:ms5637: add ms5803 support
Date:   Sun, 10 Jan 2021 00:11:42 +0100
Message-Id: <20210109231148.1168104-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

This series adds support for the Measurement Specialities ms5803. It is
very similar to the ms5805 but has a different PROM layout (which I
suspect predates the ms5805 PROM layout). Also it supports less
frequency sampling options.

After a bit of preparatory work in the ms5637 driver and its common
library, mainly to handle the PROM layout and sample frequencies, adding
support is trivial.

Changes in v2:
 - Dropped "iio:pressure:ms5637: switch to probe_new" to keep the i2c_device_id
   table.
 - Reorder trivial-devices.yaml

Alexandre Belloni (6):
  dt-bindings: trivial-devices: reorder memsic devices
  iio:pressure:ms5637: introduce hardware differentiation
  iio:pressure:ms5637: limit available sample frequencies
  iio:common:ms_sensors:ms_sensors_i2c: rework CRC calculation helper
  iio:common:ms_sensors:ms_sensors_i2c: add support for alternative PROM
    layout
  iio:pressure:ms5637: add ms5803 support

 .../devicetree/bindings/trivial-devices.yaml  | 10 ++-
 .../iio/common/ms_sensors/ms_sensors_i2c.c    | 76 ++++++++++++++----
 .../iio/common/ms_sensors/ms_sensors_i2c.h    | 15 +++-
 drivers/iio/pressure/ms5637.c                 | 77 +++++++++++++++----
 4 files changed, 143 insertions(+), 35 deletions(-)

-- 
2.29.2

