Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3652E3210
	for <lists+linux-iio@lfdr.de>; Sun, 27 Dec 2020 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgL0RMa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Dec 2020 12:12:30 -0500
Received: from www381.your-server.de ([78.46.137.84]:59632 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgL0RM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Dec 2020 12:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=+RD1w1y/KSj9rvMQ9ijYR7f4jBxgt469qeYgrjA1pVQ=; b=XddkdIXaCDdDP/rwP+HCNlkg54
        Afq0FI3DSUNE18izXDfKLys3tLMcHBkZdOdDVTBUcEFp4lK4+qXPySaluLyEMEggqEeavaRfvvivR
        q8YIfRAGbKI8Qz3nbc4B0q5RNSXeUPqmK2oIk1AoPS2EZc/kv2Y+rO3LXItmEtYd3plniDqmMy1MX
        8KoDhF/OL+43ae2/XkECZoyDN5RucvUNogXAKbH1FGAZQtR6VEVVMfYyupLON/1t8HQEJjF+RFR/D
        QqvtMckGT338wfuWWZSJwYfjgFKGX+D43EN9+v3oeBjTg1vYzba0M6S9WX+ufi1IJAi2bH1sVoBdv
        UUNdFcsg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1ktZa7-0009HY-DD; Sun, 27 Dec 2020 18:11:47 +0100
Received: from [2001:a61:2af4:a201:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ktZa7-000T2x-7s; Sun, 27 Dec 2020 18:11:47 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] iio: vl6180: Use DIV_ROUND_CLOSEST() instead of open-coding it
Date:   Sun, 27 Dec 2020 18:11:24 +0100
Message-Id: <20201227171126.28216-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26030/Sun Dec 27 13:44:56 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use DIV_ROUND_CLOSEST() instead of open-coding it. This documents intent
and makes it more clear what is going on for the casual reviewer.

Generated using the following the Coccinelle semantic patch.

// <smpl>
@r1@
expression x;
constant C1;
constant C2;
@@
 ((x) + C1) / C2

@script:python@
C1 << r1.C1;
C2 << r1.C2;
@@
try:
	if int(C1) * 2 != int(C2):
		cocci.include_match(False)
except:
	cocci.include_match(False)

@@
expression r1.x;
constant r1.C1;
constant r1.C2;
@@
-(((x) + C1) / C2)
+DIV_ROUND_CLOSEST(x, C2)
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/light/vl6180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index 4775bd785e50..d47a4f6f4e87 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -392,7 +392,7 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
 {
 	int ret, it_ms;
 
-	it_ms = (val2 + 500) / 1000; /* round to ms */
+	it_ms = DIV_ROUND_CLOSEST(val2, 1000); /* round to ms */
 	if (val != 0 || it_ms < 1 || it_ms > 512)
 		return -EINVAL;
 
-- 
2.20.1

