Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB67C33A6FF
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhCNQtp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbhCNQtN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF5C064EE7;
        Sun, 14 Mar 2021 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740553;
        bh=TIkLnFvDn0Gus8RuL5hZCuQ9dlOq3T2jPCiigzuiFRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rig+ga39pURJnAzyJyl7Qq2Lgq0vvpUWO/KNgW101mWqfFlN9N2MSRKrNvZVzpWC1
         0DgnKRWscuqfjS7sOmbpWrNfVRWUdSKY3xkGpdb23CDm6sf/D0kGxnzYS3LkiGJrOn
         T778dcpThZrMFWQqMsf+a0Tl68MUt+uCXoerRR2E+w4zcJQ04RdU9bMvdD4YPPLvMQ
         Skd0MRyrgSD5gwKhqb6Pr87IVf/XkJ7ljLrLkP7NgwTlxjq19MZZBULTb5GiTCbjGv
         p+IX6AB+m8xaYuuYsaOwcbLyfpAeArpNxHC8TY6RnP02Tkab5qwCQx0QuzD9B/OcfW
         VVAj6Cg/xLN2Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 7/8] iio: accel: sca3000: kernel-doc fixes. Missing - and wrong function names.
Date:   Sun, 14 Mar 2021 16:46:54 +0000
Message-Id: <20210314164655.408461-8-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
References: <20210314164655.408461-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

All extremely obvious so nothing to add to patch title.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/sca3000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 467b5fcb81db..cb753a43533c 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -351,7 +351,7 @@ static int __sca3000_unlock_reg_lock(struct sca3000_state *st)
 }
 
 /**
- * sca3000_write_ctrl_reg() write to a lock protect ctrl register
+ * sca3000_write_ctrl_reg() - write to a lock protect ctrl register
  * @st: Driver specific device instance data.
  * @sel: selects which registers we wish to write to
  * @val: the value to be written
@@ -389,7 +389,7 @@ static int sca3000_write_ctrl_reg(struct sca3000_state *st,
 }
 
 /**
- * sca3000_read_ctrl_reg() read from lock protected control register.
+ * sca3000_read_ctrl_reg() - read from lock protected control register.
  * @st: Driver specific device instance data.
  * @ctrl_reg: Which ctrl register do we want to read.
  *
@@ -421,7 +421,7 @@ static int sca3000_read_ctrl_reg(struct sca3000_state *st,
 }
 
 /**
- * sca3000_show_rev() - sysfs interface to read the chip revision number
+ * sca3000_print_rev() - sysfs interface to read the chip revision number
  * @indio_dev: Device instance specific generic IIO data.
  * Driver specific device instance data can be obtained via
  * via iio_priv(indio_dev)
@@ -902,7 +902,7 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
 }
 
 /**
- * sca3000_write_value() - control of threshold and period
+ * sca3000_write_event_value() - control of threshold and period
  * @indio_dev: Device instance specific IIO information.
  * @chan: Description of the channel for which the event is being
  * configured.
-- 
2.30.2

