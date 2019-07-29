Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E03C7793B0
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 21:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfG2TWo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 15:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbfG2TWn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jul 2019 15:22:43 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C422070B;
        Mon, 29 Jul 2019 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428163;
        bh=FuVX0+W2lOd8Os0EJAgzh2ZW/4kXS6mMvvQ9K/Iz7Gg=;
        h=From:To:Cc:Subject:Date:From;
        b=jLpFvuc1vdNUlpYmdZ97PhKS7FJ3usWvDJ5xEgKO64DONvFTBq93As4e735X1vgrF
         hJYCMeXpLF6bcbYwWNXNZ/7nKiyujMaNUGdaCpnc/gXMy7fcwMvy+ITattZY56O3hh
         fM0FfklqaixSSlt/KaH5VEvEv7x5LlbrzVueyYLE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: [PATCH v2 0/4] st_lsm6dsx: move {odr,fs}_table in
Date:   Mon, 29 Jul 2019 21:22:27 +0200
Message-Id: <cover.1564427804.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move odr and gain table in st_lsm6dsx_sensor_settings maps in order to support
devices with different odr/fs definitions. Moreover move iio channel
definitions in st_lsm6dsx_sensor_settings.
This is a preliminary series to add support for LSM9DS1 and irq wake up support.

Changes since v1:
- rebase ontop of linux-iio testing branch
- move iio channel definitions in st_lsm6dsx_sensor_settings

Lorenzo Bianconi (4):
  iio: imu: st_lsm6dsx: move odr_table in st_lsm6dsx_sensor_settings
  iio: imu: st_lsm6dsx: move fs_table in st_lsm6dsx_sensor_settings
  iio: imu: st_lsm6dsx: inline output acc/gyro output regs
  iio: imu: st_lsm6dsx: move iio chan definitions in
    st_lsm6dsx_sensor_settings

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   9 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 473 +++++++++++++++----
 2 files changed, 387 insertions(+), 95 deletions(-)

-- 
2.21.0

