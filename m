Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4944F3E4
	for <lists+linux-iio@lfdr.de>; Sat, 13 Nov 2021 16:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhKMP0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Nov 2021 10:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhKMP03 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Nov 2021 10:26:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 744CD610A0;
        Sat, 13 Nov 2021 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636817017;
        bh=t4ShRd5UpDtwAuQPRQtmnlYscptnVPp+MOyvcekVF9w=;
        h=From:To:Cc:Subject:Date:From;
        b=CyxnqAiUSoYIAj9wbapLAIsTJo91JRK8gJMN9UC3ak+t8d2SPVM7ggfjp7AU18m8W
         drE0CF7zySWbAMu8QV3axvzMpX7+CN6YCItUMa8MoZdZt4rAYIN9s07ZXoX7HrG+Lk
         lRzEoLGc9RwaOtSrJPMC9w16I7fRoux7qObG8EtTugC/dFEFKa4qjCvfIV53eFZY0g
         iir4SwhBKKwa3OMeud7BMkibTGsycv+3bWZ+v5ctYQhfBYeSU77Ha8ufx2aZeswJQn
         Z1RkW2gV0TRs/WcvmzfuyGxjGmyobFiwhroKbXTzGDuUUHDMYXgzbTEBFT8Axg383Y
         +MUbX1mSrKDSQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] add the capability to disable st_lsm6dsx sensor-hub
Date:   Sat, 13 Nov 2021 16:23:13 +0100
Message-Id: <cover.1636816719.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce the capability to disable sensorhub through a device-tree property
since since there are some configurations where users want to
explicitly disable sensor-hub auto-probing at bootstrap.
A typical configuration is when the sensorhub clock/data lines are connected
to a pull-up resistor since no slave sensors are connected to the i2c master.
If SDO/SA0 line is connected to the same pull-up resistor, when the driver
tries to probe slave devices connected on sensor-hub, it will force SDO/SA0
line to low, modifying the device i2c address.

Changes since v1:
- rename disable-shub property in disable-sensor-hub
- improve commit log

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add dts property to disable sensor-hub
  Documentation: dt: iio: st_lsm6dsx: add disable-sensor-hub property

 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 7 +++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.31.1

