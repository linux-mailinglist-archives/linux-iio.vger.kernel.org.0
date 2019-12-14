Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BB811F2D8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2019 17:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfLNQxQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Dec 2019 11:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNQxQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Dec 2019 11:53:16 -0500
Received: from localhost.localdomain (209-213-91-242.bos.ma.meganet.net [209.213.91.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE4E2465B;
        Sat, 14 Dec 2019 16:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576342395;
        bh=CvoUsLnSJWvSvoJF2OxzSaBJ0cz178+fg54oFeJIZ+E=;
        h=From:To:Cc:Subject:Date:From;
        b=XgvtMQ8B1bXpjspMPyGi9hkV8/sEkeegH3K4aVmtv1i6QX7lGc1XFQtEtU7ijhDA3
         n3e8HHTBG74VEJo/AaIu6xJF8qbQVouNiT+C2OA1VD8MwzxszkTmjmlDfKq+yiF/5a
         NAXAgPPP7UYOnIsPOnq0q1u9OWAZux/pP+T0cxZM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 0/6] introduce i2c master controller support for LSM6DSM
Date:   Sat, 14 Dec 2019 17:52:53 +0100
Message-Id: <cover.1576341963.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enabled i2c master controller support for LSM6DSM devices.
Enable ext_sensor0 for lsm6dsm (currently just one external sensor
is supported). This series has been tested using LIS2MDL as slave device
connected to the i2c controller of the LSM6DSM

Lorenzo Bianconi (6):
  iio: imu: st_lsm6dsx: export max num of slave devices in
    st_lsm6dsx_shub_settings
  iio: imu: st_lsm6dsx: check if master_enable is located in primary
    page
  iio: imu: st_lsm6dsx: check if pull_up is located in primary page
  iio: imu: st_lsm6dsx: check if shub_output reg is located in primary
    page
  iio: imu: st_lsm6dsx: rename st_lsm6dsx_shub_read_reg in
    st_lsm6dsx_shub_read_output
  iio: imu: st_lsm6dsx: enable sensor-hub support for lsm6dsm

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 23 +++++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 27 +++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 74 ++++++++++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 76 ++++++++++++-------
 4 files changed, 157 insertions(+), 43 deletions(-)

-- 
2.21.0

