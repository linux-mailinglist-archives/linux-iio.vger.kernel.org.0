Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDF8477C51
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 20:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbhLPTRR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 14:17:17 -0500
Received: from www381.your-server.de ([78.46.137.84]:42130 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbhLPTRR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 14:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=hCRseAsLnOW9qZ6QMybhImyCcn6O1pSm39G2tEkDXdE=; b=PBjI+V+O8rNfdC/l9O9bwD6d0y
        8EZbP+yfm381/QAEOVOvaLuEw/kMC3nNSE9J6+yuEKlc9zFlikh6vtLVu4d3TqbS9Iub+HYcSt2do
        81uX0gQ/0D6ytA2GOVbQbWPp/sPcpAnD41EYVXVgrS94zlC6gXR3OzGGkmU+0mXoPJ/LrhYh7b8sm
        WHQPVHXQyRfKyfYEkubACpW33fMV40sZLibfR0/eTlGcp7vgyIX3KBdkgajCIt7vfuVunGYzpcxNO
        vp46QcKGuI5Ye9K8hOSKJhY72u/D3YH8iYrLWNLO3BGBuJH6DsPzXKTBMgfS0cJ4sTjCdWorkQNmL
        w1sU5ljA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvul-000B4u-AV; Thu, 16 Dec 2021 19:55:39 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrc-000HSt-Dz; Thu, 16 Dec 2021 19:52:24 +0100
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
Subject: [PATCH 12/13] iio: scd4x: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:16 +0100
Message-Id: <20211216185217.1054495-13-lars@metafoo.de>
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

Use sysfs_emit() to format the custom `calibration_auto_enable` device
attribute of the scd4x driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/chemical/scd4x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 267bc3c05338..20d4e7584e92 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -423,7 +423,7 @@ static ssize_t calibration_auto_enable_show(struct device *dev,
 
 	val = (be16_to_cpu(bval) & SCD4X_READY_MASK) ? 1 : 0;
 
-	return sprintf(buf, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t calibration_auto_enable_store(struct device *dev,
-- 
2.30.2

