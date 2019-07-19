Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F60F6E666
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfGSNa7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Jul 2019 09:30:59 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:35530 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726243AbfGSNa7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jul 2019 09:30:59 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6C5FDC1C2C;
        Fri, 19 Jul 2019 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563543058; bh=jpvevAfVqqSo+PGNCx5Sc+HAJGWPFoUHv+j21MEN228=;
        h=From:To:Cc:Subject:Date:From;
        b=iydk+SgUCWwAhcecW+1dVV0hNqtSoqxOehHwLQpEoY3wy5rGQ4i84FWBKSbp/O3Nb
         Pa+aPMcMCzwrmf/JcZW8EZapIxDWRn7/BAUEjBPdjKuM/cc8da7U0oCD/E5Ujx4h4b
         XgBmT/1OZkYTNZ1x5I4Kq0n87wMj5Qn8BNEn6X2QODWwgkU6beuXP8StUQaO/3TQ0g
         iY+fGoz5+Oc2vv0jrrdLO92ZWRUwQcUuoZz6gpMh16yFBHi5AL+f5Y3oVz+AD0/ft4
         Qx3faeQ17YVWw8aOtS/AFZJEg7f0/xptm8U83lLb5aT7ei+YqhZP2E7izy4/Czjk/S
         EbxwdgCFg54mA==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 01823A005D;
        Fri, 19 Jul 2019 13:30:56 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id D46E63EBC1;
        Fri, 19 Jul 2019 15:30:56 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v6 0/2] Add ST lsm6dso i3c support
Date:   Fri, 19 Jul 2019 15:30:53 +0200
Message-Id: <cover.1563542515.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch-series add i3c support for STM LSM6DSO and LSM6DSR sensors.

It is also introduced i3c support on regmap API. Due to the lack of
i3c devices with HDR feature on the market the support, for now, is only
for i3c SDR mode by using i3c_device_do_priv_xfers() method.

The i3c regmap API is already available in the Git repository at:
  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
  tags/regmap-i3c

Change in v6:
  Improve kerneldoc

Change in v5:
  Remove regmap-i3c patch, already applied in regmap tree
  Fix warning when compiling in 64-bit architecture

Change in v4:
  remover hw_id variable from st_lsm6dsx_i3c_probe()

Change in v3:
  Update st_lsm6dsx_probe() call
  Remove i3c_get_device_id() and use i3c_device_match_id()

Changes in v2:
  Change i3c_get_device_id() to drivers/i3c/device.c
  Add support for LSM6DSR

Vitor Soares (2):
  i3c: add i3c_get_device_id helper
  iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO and LSM6DSR

 drivers/i3c/device.c                        | 53 +++++++++++++++++++++++++++
 drivers/i3c/master.c                        | 45 -----------------------
 drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
 drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 57 +++++++++++++++++++++++++++++
 include/linux/i3c/device.h                  |  4 ++
 6 files changed, 122 insertions(+), 46 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c

-- 
2.7.4

