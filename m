Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE286F2AE
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jul 2019 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfGUKto (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jul 2019 06:49:44 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:36652 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfGUKto (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jul 2019 06:49:44 -0400
Received: from localhost.localdomain ([92.140.204.221])
        by mwinf5d33 with ME
        id fNpd200044n7eLC03NpeBX; Sun, 21 Jul 2019 12:49:42 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jul 2019 12:49:42 +0200
X-ME-IP: 92.140.204.221
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, broonie@kernel.org, dpfrey@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: light: apds9960: Fix a typo
Date:   Sun, 21 Jul 2019 12:49:18 +0200
Message-Id: <20190721104918.30253-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

s/ADPS9960/APDS9960/
(P and D switched)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/light/apds9960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index b09b8b60bd83..c5dfb9a6b5a1 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1135,5 +1135,5 @@ static struct i2c_driver apds9960_driver = {
 module_i2c_driver(apds9960_driver);
 
 MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
-MODULE_DESCRIPTION("ADPS9960 Gesture/RGB/ALS/Proximity sensor");
+MODULE_DESCRIPTION("APDS9960 Gesture/RGB/ALS/Proximity sensor");
 MODULE_LICENSE("GPL");
-- 
2.20.1

