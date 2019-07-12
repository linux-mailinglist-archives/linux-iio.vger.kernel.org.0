Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C48D666BD8
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 13:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfGLLxf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 07:53:35 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:57456 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726449AbfGLLxf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 07:53:35 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AEFB1C29BE;
        Fri, 12 Jul 2019 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562932415; bh=Bwpep7STwikCoZMTTU0wnldjsqPyrkJwQldcsqAzApM=;
        h=From:To:Cc:Subject:Date:From;
        b=dNX/GR8NSBXMT8JWtSMb4daS+sUcAd1AUJT8W7txu6BalacxWO8HHtEZOoG6SQsIm
         nkUm8DADsnMpqDcrCbrli4uOdeFvIx4EYoJe+FZUZiPwL7lIeLhCvDUbRzG83On4rt
         oLhMeU2KfF/U+7wZ5f+N0NY+xPDXJatr7IyL9Piay3us5oo41aVuC3UhxcjRNwPuaq
         fdqOZrhD6Y12TBpYjb5NJD5F1TGQ8CuLkUMBNzr+0HBaXb2qsP2hxbXaHYxIhDAt21
         RergnwVg3dX6MI1qiDoX0xdZOguOe3vhuMNuwZ3kAXEg0jsuP1z8v9G7S62kVUi+7o
         NS2Jkg9bBo3QQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5D15AA0061;
        Fri, 12 Jul 2019 11:53:33 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 0F0193E581;
        Fri, 12 Jul 2019 13:53:33 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v4 0/3] Add ST lsm6dso i3c support
Date:   Fri, 12 Jul 2019 13:53:27 +0200
Message-Id: <cover.1562931742.git.vitor.soares@synopsys.com>
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

Change in v4:
  remover hw_id variable from st_lsm6dsx_i3c_probe()

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
 drivers/base/regmap/regmap-i3c.c            | 60 +++++++++++++++++++++++++++++
 drivers/i3c/device.c                        | 46 ++++++++++++++++++++++
 drivers/i3c/master.c                        | 45 ----------------------
 drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
 drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 58 ++++++++++++++++++++++++++++
 include/linux/i3c/device.h                  |  4 ++
 include/linux/regmap.h                      | 20 ++++++++++
 10 files changed, 202 insertions(+), 47 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-i3c.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c

-- 
2.7.4

