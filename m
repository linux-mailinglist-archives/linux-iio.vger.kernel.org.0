Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D174500
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2019 07:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbfGYFcP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Jul 2019 01:32:15 -0400
Received: from comms.puri.sm ([159.203.221.185]:59486 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403750AbfGYFcN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Jul 2019 01:32:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DA12CE048D;
        Wed, 24 Jul 2019 22:32:12 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BHbscUMLiBDJ; Wed, 24 Jul 2019 22:32:12 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 0/5] iio: imu: st_lsm6dsx: Add support for LSM9DS1
Date:   Thu, 25 Jul 2019 07:31:27 +0200
Message-Id: <20190725053132.9589-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Resend 2 of Lorenzo's patches that this builds upon. They have been previously
posted to linux-iio only:
https://lore.kernel.org/linux-iio/cover.1563226641.git.lorenzo@kernel.org/

Then, add support for the LSM9DS1 accel/gyro unit in 3 simple steps. This
is also only a resend and rebase of the v2:
https://lore.kernel.org/linux-iio/20190716093325.7683-1-martin.kepplinger@puri.sm/

So I call this v3 and Lorenzo, I hope that it's fine for you that I just
take your patches here - also since they mention to be intended for supporting
the device.


revision history
----------------
v3: rebase and add Lorenzo's patches in order to apply to the iio testing brach
v2: further simplifications based on Lorenzo's feedback
v1: initial change for adding lsm9ds1 support




Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: move odr_table in st_lsm6dsx_sensor_settings
  iio: imu: st_lsm6dsx: move fs_table in st_lsm6dsx_sensor_settings

Martin Kepplinger (3):
  iio: imu: st_lsm6sdx: move register definitions to sensor_settings
    struct
  iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9sd1
  dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1 device bindings

 .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig            |   1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  12 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 490 +++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
 6 files changed, 440 insertions(+), 74 deletions(-)

-- 
2.20.1

