Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE82E320F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Dec 2020 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgL0RMa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Dec 2020 12:12:30 -0500
Received: from www381.your-server.de ([78.46.137.84]:59638 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgL0RM3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Dec 2020 12:12:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=SWxmXuJLroH/q3H+DADwiH7ZwDZGKLb5OJYQADTPoHc=; b=I29km8AwBrNGWg1ny6ZzUk/IEU
        OJRkN78vShlnaxrRwYqv4w2HH6QoghY7aw3rAnE2k6xAZHPHFoG2FZnvq8FWgZmemWIrOqlWteqUv
        PFER4k3Ee8eeVEICSsDfUtiunJlVErsTszMbMMcR4N7NFNiR5P8TXs6ikjSM0EUepEn3VzvrB6Zfq
        f1v6zNWG09kiNt2TacAWbMBeu15853ogalHYwliYbCIqoEBKuso7mXJAWu/0eAtSZCB3lh+ul6OEG
        8/MgorM9iNWoiBDSlbMRFauwkpSopMnsMKyjQLFD4gqN9o61LGBbue65dFQ2NA4yLQFCZSUh1lq7f
        5GDZBNNg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1ktZa7-0009HZ-En; Sun, 27 Dec 2020 18:11:47 +0100
Received: from [2001:a61:2af4:a201:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1ktZa7-000T2x-Ab; Sun, 27 Dec 2020 18:11:47 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio: bme680: Use DIV_ROUND_CLOSEST() instead of open-coding it
Date:   Sun, 27 Dec 2020 18:11:25 +0100
Message-Id: <20201227171126.28216-2-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201227171126.28216-1-lars@metafoo.de>
References: <20201227171126.28216-1-lars@metafoo.de>
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
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 6ea99e4cbf92..bf23cc7eb99e 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -479,7 +479,7 @@ static u8 bme680_calc_heater_res(struct bme680_data *data, u16 temp)
 	var4 = (var3 / (calib->res_heat_range + 4));
 	var5 = 131 * calib->res_heat_val + 65536;
 	heatr_res_x100 = ((var4 / var5) - 250) * 34;
-	heatr_res = (heatr_res_x100 + 50) / 100;
+	heatr_res = DIV_ROUND_CLOSEST(heatr_res_x100, 100);
 
 	return heatr_res;
 }
-- 
2.20.1

