Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9927446ECE9
	for <lists+linux-iio@lfdr.de>; Thu,  9 Dec 2021 17:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhLIQV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Dec 2021 11:21:29 -0500
Received: from www381.your-server.de ([78.46.137.84]:41270 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237216AbhLIQV1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Dec 2021 11:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=n5Dkv+SafM6uFCrQBXjmUP6uD3VzZH/9wct2o6CMcMc=; b=ajyk4FHsHv3ACqENZLcP3vhiQq
        znAHBGClQD6PVupFwPe3OhxiRxaxumG1NkUTBkwNolH3wYtCPBEhPmPYlavgMuPIZRN+siU5uD/lV
        smj0QWUV9DXJMqAVziRVQ2jxVVVxQ1AyFEOYVXSWhNzLs9HJa4qqYu/K3sMNMAVG2/LGHd1ZRfB7A
        mhr5qsAbiIjl3hUbXdQfmIWq2sBs6Xe4ZDSO8lQ3/ZGtktsuXqEpIVVyPO7PDSlBIV3+Xl/PihaZ0
        rqO7fxuUGM2OU25a337RzumEeKSZYwnDSjkxuAF4XvI70Ocr03A0sK0uMdnytkVQt905PIBHG3NyV
        qN7QMH8A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mvM7E-0007zT-NS; Thu, 09 Dec 2021 17:17:52 +0100
Received: from [2001:a61:2aa6:c001:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mvM7E-00083w-Hj; Thu, 09 Dec 2021 17:17:52 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] iio: as3935: Remove unnecessary cast
Date:   Thu,  9 Dec 2021 17:17:28 +0100
Message-Id: <20211209161730.396848-1-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
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
 drivers/iio/proximity/as3935.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index d62766b6b39e..51f4f92ae84a 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -133,7 +133,7 @@ static ssize_t as3935_sensor_sensitivity_store(struct device *dev,
 	unsigned long val;
 	int ret;
 
-	ret = kstrtoul((const char *) buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return -EINVAL;
 
-- 
2.30.2

