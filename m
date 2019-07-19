Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A756E4F3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 13:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfGSLT3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Jul 2019 07:19:29 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:60198 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbfGSLT2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jul 2019 07:19:28 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C0102C1C2B;
        Fri, 19 Jul 2019 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563535168; bh=MiBjCxUDzzebeZuhxJ+pM4/wZnrQW997011ijzYonDs=;
        h=From:To:Cc:Subject:Date:From;
        b=QYKr9eERoADTDOYRL4bYLZ8LSHT4kAGPGsqCd23c53VNJaZCz3PpdzMGsWWGfDtAO
         MrraABI3prkvVdRGFUm8IrMomQPrJek0adEzVB6j1R9+aTePGDecKrquYJAHoA2xiE
         XQExfzMmhR0fGcVmPC/RvqmALreSq7a4h+hqNhdm7S1MD6QUtDz5sZeiNJMfHJPnr4
         BsA2q7fpJesYm7ig7MQUnTWdg1aopKkJOfioCORzIVVf3/Oi97RXsX7pHD5rG82cKk
         fIEpwzb1tTSX4AQIzYVqEKSJfble0wB9afycpyLwMYsWVzTZWs1LKYHsWENcHEGX/d
         Lrb2nK0OBdngg==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 37902A0060;
        Fri, 19 Jul 2019 11:19:26 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 0C6A03CA2A;
        Fri, 19 Jul 2019 13:19:26 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v5 0/2] Add ST lsm6dso i3c support
Date:   Fri, 19 Jul 2019 13:19:03 +0200
Message-Id: <cover.1563533342.git.vitor.soares@synopsys.com>
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

