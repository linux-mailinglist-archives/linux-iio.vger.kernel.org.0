Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5C97E36E7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2019 17:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406209AbfJXPmz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Oct 2019 11:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406101AbfJXPmz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 24 Oct 2019 11:42:55 -0400
Received: from wlan-180-98.mxp.redhat.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF16B20650;
        Thu, 24 Oct 2019 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571931775;
        bh=ePGZQqpbgFcM1vjEqk83A0VsM2XrDl7GTwnvhEA3DWM=;
        h=From:To:Cc:Subject:Date:From;
        b=0Qsth0XAWCHDDoI+aUN09ZaPYzvOuxpDLyKRDyJXiG1jA6p1YFpB5nsMXzxdBSrpF
         R3RsiveuL50ziz5HesNbr5xDoWLMrUYlQpDtO57+FHLr1i+VDhrWz5gRYjLkW35uva
         jgxNBN+qPATgUN7jeuNeDGx8FqgBvt8yihnWBlZo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] add support to STM LSM6DSRX 6-axis Mems sensor
Date:   Thu, 24 Oct 2019 17:42:32 +0200
Message-Id: <cover.1571931470.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support to STM LSM6DSRX 6-axis sensor
https://www.st.com/resource/en/datasheet/lsm6dsrx.pdf

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add support to LSM6DSRX
  dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsrx device bindings

 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                       | 3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h                  | 2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           | 8 ++++----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c             | 3 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c              | 5 +++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c              | 5 +++++
 7 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.21.0

