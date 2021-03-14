Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F5233A6FC
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhCNQto (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhCNQtO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A272764EFD;
        Sun, 14 Mar 2021 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740554;
        bh=Ko4RHfeRiPgIuOQ2++0iN+Is16NDTE8N/s0kSIEk+M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hWBYL1rtyqt5fuw+PjK1ERwD4h1SNgfiJAtNKdP+HR5Qje2tvTisDd9fIJ+XQ2/7U
         5ihhix0OJDGRxxXNqEFaEcz0xmY3mtt6cHcms57tP3WSXByYtXF4v6bqn5zcUlpN5c
         5CpG5g8ft9k7SM7pUeUECSZlAKYVu0GeBZyV4td17t3J+4Ta1hzKj33TsVAP/QTKv6
         b7Wvdx+uV5SWxAWDSK/gUYcskx6crL6D+jjdDuConpBnSo9XVCGCiyLAlXMDPYmVo/
         oXpdGhVcAONyTsZQiVXvga13tynFQ0vD5Yk9/cZH8uDmfcueOnbaOq4p6TYX7LnJNS
         Sq6qW0T3KWckw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: [PATCH 8/8] iio: buffer: kfifo_buf: kernel-doc, typo in function name.
Date:   Sun, 14 Mar 2021 16:46:55 +0000
Message-Id: <20210314164655.408461-9-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
References: <20210314164655.408461-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Should have been _kfifo_ and was _fifo_

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/buffer/kfifo_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 4ecfa0ec3016..d72cfb354be6 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -180,7 +180,7 @@ static void devm_iio_kfifo_release(struct device *dev, void *res)
 }
 
 /**
- * devm_iio_fifo_allocate - Resource-managed iio_kfifo_allocate()
+ * devm_iio_kfifo_allocate - Resource-managed iio_kfifo_allocate()
  * @dev:		Device to allocate kfifo buffer for
  *
  * RETURNS:
-- 
2.30.2

