Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D265AA05
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2019 12:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF2KOD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Jun 2019 06:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfF2KOD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Jun 2019 06:14:03 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320F1214AF;
        Sat, 29 Jun 2019 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561803242;
        bh=moQlfPAMjOa6uyPq6FEFz2uPwgDciwkvitY9uyUvuk4=;
        h=From:To:Cc:Subject:Date:From;
        b=SVr0ARyPmrqPYgo0rtuiT0U9z+1BQsSGT9tK/vlFGenjBSqfc3Bqn0qOmqrMNKOvF
         EBXa6KKqpDIHTaIx7aSo/yHbq/lx2mgOh2B/H3lt9LjCBOPg6C6Yyf4xs/CIQm3VOO
         AmrYKti8x9GwaHzObtiq/5yK60sRxrRAHCvkG858=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH 0/2] add support to STM LSM6DS3TR-C 6-axis Mems sensor
Date:   Sat, 29 Jun 2019 12:13:52 +0200
Message-Id: <cover.1561802767.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DS3TR-C 6-axis sensor
https://www.st.com/resource/en/datasheet/lsm6ds3tr-c.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DS3TR-C
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6ds3tr-c device bindings

 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                       | 2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           | 8 ++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 5 ++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
 7 files changed, 22 insertions(+), 6 deletions(-)

-- 
2.21.0

