Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055416F2B3
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 12:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfGUKyS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 06:54:18 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:25682 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfGUKyS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jul 2019 06:54:18 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d33 with ME
        id fNuE2000w4n7eLC03NuFSk; Sun, 21 Jul 2019 12:54:16 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 12:54:16 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gustavo@embeddedor.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: sca3000: Fix a typo
Date:   Sun, 21 Jul 2019 12:53:53 +0200
Message-Id: <20190721105353.30504-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

All #define are about SCA3000_... except the last one.
Make it consistent.

s/SAC3000/SCA3000/

This #define is apparently unused up to now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/accel/sca3000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4964561595f5..537e9325bcc7 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -114,7 +114,7 @@
 /* Currently unsupported */
 #define SCA3000_MD_CTRL_AND_Y				BIT(3)
 #define SCA3000_MD_CTRL_AND_X				BIT(4)
-#define SAC3000_MD_CTRL_AND_Z				BIT(5)
+#define SCA3000_MD_CTRL_AND_Z				BIT(5)
 
 /*
  * Some control registers of complex access methods requiring this register to
-- 
2.20.1

