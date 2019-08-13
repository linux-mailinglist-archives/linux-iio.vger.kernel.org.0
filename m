Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EF58B139
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfHMHg1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 03:36:27 -0400
Received: from comms.puri.sm ([159.203.221.185]:43632 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbfHMHg1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Aug 2019 03:36:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6096DE02ED;
        Tue, 13 Aug 2019 00:36:26 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fzMDDzpVYdlG; Tue, 13 Aug 2019 00:36:25 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 0/3] iio: imu: st_lsm6dsx: Add support for LSM9DS1
Date:   Tue, 13 Aug 2019 09:35:30 +0200
Message-Id: <20190813073533.8007-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add basic functionality for LSM9DS1. This has become a trivial addition
by now.

revision history
----------------
v4: rebase on top of today's iio testing branch with Lorenzo's recent work
v3: rebase and add Lorenzo's patches in order to apply to the iio testing brach
v2: further simplifications based on Lorenzo's feedback
v1: initial change for adding lsm9ds1 support


Martin Kepplinger (3):
  iio: imu: st_lsm6sdx: move register definitions to sensor_settings
    struct
  iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9sd1
  dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1 device bindings

 .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig            |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   8 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 118 ++++++++++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
 6 files changed, 129 insertions(+), 10 deletions(-)

-- 
2.20.1

