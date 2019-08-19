Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4791C28
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2019 06:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfHSEsf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Aug 2019 00:48:35 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:47371 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfHSEsf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2019 00:48:35 -0400
Received: from localhost.localdomain ([92.140.207.10])
        by mwinf5d86 with ME
        id qsoW2000X0Dzhgk03soXPB; Mon, 19 Aug 2019 06:48:33 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Aug 2019 06:48:33 +0200
X-ME-IP: 92.140.207.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, ak@it-klinger.de, robh@kernel.org,
        songqiang1304521@gmail.com, tglx@linutronix.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Kconfig: Fix the reference to the RFD77402 ToF sensor in the 'help' section
Date:   Mon, 19 Aug 2019 06:48:27 +0200
Message-Id: <20190819044827.5259-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This should be RFD77402, not RFD77420.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure that the Kconfig prefix is correct. I have choosen it because of
commit 21cf20a84a ("Kconfig: change configuration of srf04 ultrasonic iio sensor")
---
 drivers/iio/proximity/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 6b5cce6f1a7b..d53601447da4 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -62,7 +62,7 @@ config RFD77402
 	tristate "RFD77402 ToF sensor"
 	depends on I2C
 	help
-	  Say Y to build a driver for the RFD77420 Time-of-Flight (distance)
+	  Say Y to build a driver for the RFD77402 Time-of-Flight (distance)
 	  sensor module with I2C interface.
 
 	  To compile this driver as a module, choose M here: the
-- 
2.20.1

