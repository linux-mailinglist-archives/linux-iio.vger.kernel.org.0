Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDE27A3E3
	for <lists+linux-iio@lfdr.de>; Sun, 27 Sep 2020 22:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgI0UCo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Sep 2020 16:02:44 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:14485
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbgI0UCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2020 16:02:43 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169503"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:14 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     David Lechner <david@lechnology.com>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/18] counter: use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:25 +0200
Message-Id: <1601233948-11629-16-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/counter/ti-eqep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 1ff07faef27f..e27771df8e23 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -439,7 +439,7 @@ static int ti_eqep_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	counter_unregister(&priv->counter);
-	pm_runtime_put_sync(dev),
+	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
 	return 0;

