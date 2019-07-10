Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952C6648BB
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2019 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfGJO4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Jul 2019 10:56:45 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:36960 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbfGJO4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jul 2019 10:56:44 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 64173C1C7F;
        Wed, 10 Jul 2019 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562770604; bh=wlZvgrVT1cnhuSHx1zID1cemmfpVHJ+ubZIZzKEp5eM=;
        h=From:To:Cc:Subject:Date:From;
        b=OjpWs0Y4Qg+BBOtqLlD7heYkPssrjR3AOfFSvw9SX4JRMwIF0Yka8UKgEIEoqore7
         5jJi8Vg++vwsHFQDIlEbnSILEoF1EEDIeXVZiLgbV5hmydzP3YPLlV7PEoWQpAf83N
         4UG65yGR2yyUOHLPaoiAW0KlVZfStCUArPW6ORmF0sx+ywz/WObRDK8ELSXXwCDE2y
         8ZrablIAkPrUUZFO7AEUdHxRjfe3khI1L66YlanQZBE8zH9bM5ghaYhAOtu4PWhPu6
         tLVyytJVFLfb0RnkNdaKG6CGh8VMLjIGxjUq4tP+Jd2L6hYJ0B7pPrbJOweX3IPyli
         nO2AncxBoKeOg==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id E6898A0057;
        Wed, 10 Jul 2019 14:56:41 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id BCB503FA2F;
        Wed, 10 Jul 2019 16:56:41 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, lorenzo@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, bbrezillon@knernel.org, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 0/3] Add ST lsm6dso i3c support
Date:   Wed, 10 Jul 2019 16:56:36 +0200
Message-Id: <cover.1562767521.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series add i3c support for STM LSM6DSO and LSM6DSR sensors.

It is also introduced i3c support on regmap api. Due the lack of
i3c devices HDR capables on the market the support for now is only for
i3c sdr mode by using i3c_device_do_priv_xfers() method.

The i3c regmap api is already available in the Git repository at:
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
  tags/regmap-i3c

Change in v3:
  Update st_lsm6dsx_probe() call
  Remove i3c_get_device_id() and use i3c_device_match_id()

Changes in v2:
  Change i3c_get_device_id() to drivers/i3c/device.c
  Add support for LSM6DSR

Vitor Soares (3):
  regmap: add i3c bus support
  i3c: add i3c_get_device_id helper
  iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO and LSM6DSR

 drivers/base/regmap/Kconfig                 |  6 ++-
 drivers/base/regmap/Makefile                |  1 +
 drivers/base/regmap/regmap-i3c.c            | 60 ++++++++++++++++++++++++++++
 drivers/i3c/device.c                        | 46 ++++++++++++++++++++++
 drivers/i3c/master.c                        | 45 ---------------------
 drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
 drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 61 +++++++++++++++++++++++++++++
 include/linux/i3c/device.h                  |  4 ++
 include/linux/regmap.h                      | 20 ++++++++++
 10 files changed, 205 insertions(+), 47 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-i3c.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c

-- 
2.7.4

