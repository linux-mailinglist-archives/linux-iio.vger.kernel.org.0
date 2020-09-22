Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A989827408B
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 13:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIVLQH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 07:16:07 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:48271 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgIVLQH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 07:16:07 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 07:16:07 EDT
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id CE2C84E24AB;
        Tue, 22 Sep 2020 19:07:04 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] iio: fix spellint typo in comments
Date:   Tue, 22 Sep 2020 19:06:56 +0800
Message-Id: <1600772818-30882-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQktDTUpMHRgeSk5CVkpNS0tMTElDSU5ISExVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhg6Vio4LT8pNA4vMRItHEw9
        STFPCx9VSlVKTUtLTExJQ0lOTEhNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTU9CNwY+
X-HM-Tid: 0a74b57ee0439376kuwsce2c84e24ab
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change the comment typo: "definately" -> "definitely".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/iio/light/gp2ap002.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index d5e1cd2..7ba7aa5
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -566,7 +566,7 @@ static int gp2ap002_probe(struct i2c_client *client,
 
 	/*
 	 * Initialize the device and signal to runtime PM that now we are
-	 * definately up and using power.
+	 * definitely up and using power.
 	 */
 	ret = gp2ap002_init(gp2ap002);
 	if (ret) {
-- 
2.7.4

