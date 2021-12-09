Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5145946ECE8
	for <lists+linux-iio@lfdr.de>; Thu,  9 Dec 2021 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbhLIQV2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Dec 2021 11:21:28 -0500
Received: from www381.your-server.de ([78.46.137.84]:41278 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhLIQV1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Dec 2021 11:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=wLh3taj/8kVghouC7V0K2FizLR95JvJNX8ZwUbuqSz4=; b=CQ9Xc+zz6hpplnR5FpcwLQOhLa
        Q8+Yho9kv1J6hyp57FgFmbZ/1PvJ384vrN2qWWkPTpt8aClIsisyf0kRTQGzvX6dgHxmsl6kR333b
        YqaMtjCPedBvT39R0hq9X9an6XfOl+hDPFU7uXCvnhfVBmk3iosNOsCk7Wi7LaC7KtltgkfesYORb
        +bOJKvxA/LcyFyMK6++ZsY5jXJ8zC8JdFOUcldRHYWvPNsd9cnALGlHKqCDo98qx94Wjdkzd6Jvyl
        gmJ178fgxQfk26gAOvk9BOAxRJux1Iz+xq6uuSIjHWGBz72sMve3Fedx/A/bLthrVMMNVW5wX/pOd
        GjvBqDew==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mvM7E-0007zV-RX; Thu, 09 Dec 2021 17:17:52 +0100
Received: from [2001:a61:2aa6:c001:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mvM7E-00083w-Ln; Thu, 09 Dec 2021 17:17:52 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] iio: in2xx-adc: Remove unnecessary cast
Date:   Thu,  9 Dec 2021 17:17:29 +0100
Message-Id: <20211209161730.396848-2-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209161730.396848-1-lars@metafoo.de>
References: <20211209161730.396848-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26378/Thu Dec  9 10:21:16 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

`buf` is cast to a const char *, but `buf` is already a const char *, so
the case is unnecessary.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 352f27657238..08f243f5b92b 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -550,7 +550,7 @@ static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
 	bool val;
 	int ret;
 
-	ret = strtobool((const char *) buf, &val);
+	ret = strtobool(buf, &val);
 	if (ret)
 		return ret;
 
-- 
2.30.2

