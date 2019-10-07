Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D2CDE60
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfJGJnv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 05:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfJGJnv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 05:43:51 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA84D21655;
        Mon,  7 Oct 2019 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570441431;
        bh=oFehRgqGofN7D9ygPJMdszHyUO5u13aff7SK6VhEUbI=;
        h=From:To:Cc:Subject:Date:From;
        b=RevdhcZh1grjHfQwVlXSWlbahn+726IXeNLMOwo2IbMYSh+dZ8uIVdhl83d0x0soe
         28qcpwctYLpurxDa8Ys6vlrYQlzfgVwsGSyoiVfllUx1HTPHfYQK2J9+KD74cAH3I1
         Eh+TkmFqLUhL4+2YeIq6HLvXF3PN7TrELyWJXXwE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org
Subject: [PATCH 0/2] add support to STM LSM6DS0 6-axis Mems sensor
Date:   Mon,  7 Oct 2019 11:43:36 +0200
Message-Id: <cover.1570441034.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DS0 6-axis sensor. Just compiled, but LSM6DS0 relies on
the same register map used by LSM9DS1

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DS0
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds0 device bindings

 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                       | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
 6 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.21.0

