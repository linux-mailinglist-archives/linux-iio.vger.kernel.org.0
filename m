Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FDB2C7885
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 10:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgK2JoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 04:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgK2JoI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 04:44:08 -0500
Received: from localhost.localdomain (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377DE20771;
        Sun, 29 Nov 2020 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606643008;
        bh=IzjRM2tz17biWFG4O1LOuBRWuG84FDy/u1xJLI70bVM=;
        h=From:To:Cc:Subject:Date:From;
        b=eJswMQtuxVLGWJ5D8CeiokLDey6HorsFuVHIQrks2wwlKieFcWtN8qe+Z8AadgGnI
         n4yeOzgeVo8WNljWS49vGmORM1Ki0X/9PEZykEzNUOcDs2VnaMXk47pxthOS4Ps9sq
         tpcFgDgMaMRbX8By3X7QHWr7/wwT8l4wDQFsP6Fc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] add support for LSM6DSOP
Date:   Sun, 29 Nov 2020 10:43:05 +0100
Message-Id: <cover.1606642528.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for LSM6DSOP IMU mems sensor
https://www.st.com/resource/en/datasheet/lsm6dsop.pdf

This series is based on "iio: imu: st_lsmdsx: compact
st_lsm6dsx_sensor_settings table"
https://patchwork.kernel.org/project/linux-iio/list/?series=392743

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DSOP
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsop device bindings

 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                        | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                   | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c            | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c              | 6 +++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c               | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c               | 5 +++++
 7 files changed, 20 insertions(+), 3 deletions(-)

-- 
2.28.0

