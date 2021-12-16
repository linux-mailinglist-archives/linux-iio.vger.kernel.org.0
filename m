Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD24477BFB
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhLPSw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 13:52:27 -0500
Received: from www381.your-server.de ([78.46.137.84]:47646 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbhLPSwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=BBaC//QzMa0MkeC/oNIh9AeCy5tSskx0B8Tv7sgSUEo=; b=S2WVY1Vy7o/+sC4cDnD+6yljpW
        9Em50yTymWGtqvaOcaYI/L/RXQeyOLDE3sJDW1Y17aNQlQn53vfbLLtBFbmqZycTNk2/UFQeXP2QC
        QEBej5MPa8BmWQPenABToQRuehZd3u7Cmq7t5sMg7xQ6mT9mUHgwqyq12mFz/geRKZjH/MtSLmMhU
        AJqcIRirsd/ylMif2C/tHYgoHNfxbx0Tn6cllcqWOOohFSpLl0AMNdRcXVk9sijP285MW3aKKgy60
        R7GqRGO7vTiW99HnwPZtj2H4DZLLzBJ221buPqvRbRLFyJ5LxSYvn0BX9SPt3sPPwpUxBGcq1+mU7
        tbT2lGmw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000AS7-T5; Thu, 16 Dec 2021 19:52:22 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000HSt-IY; Thu, 16 Dec 2021 19:52:22 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/13] iio: ad9523: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:08 +0100
Message-Id: <20211216185217.1054495-5-lars@metafoo.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211216185217.1054495-1-lars@metafoo.de>
References: <20211216185217.1054495-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26389/Thu Dec 16 07:02:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
knows about the sysfs buffer specifics and has some built-in checks for
size and alignment.

Use sysfs_emit() to format the custom device attributes of the ad9523
driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/frequency/ad9523.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index bdb0bc3b12dd..a0f92c336fc4 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -551,7 +551,7 @@ static ssize_t ad9523_show(struct device *dev,
 	mutex_lock(&st->lock);
 	ret = ad9523_read(indio_dev, AD9523_READBACK_0);
 	if (ret >= 0) {
-		ret = sprintf(buf, "%d\n", !!(ret & (1 <<
+		ret = sysfs_emit(buf, "%d\n", !!(ret & (1 <<
 			(u32)this_attr->address)));
 	}
 	mutex_unlock(&st->lock);
-- 
2.30.2

