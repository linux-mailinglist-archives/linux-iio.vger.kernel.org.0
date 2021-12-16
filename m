Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB9B477BF4
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 19:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhLPSwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 13:52:25 -0500
Received: from www381.your-server.de ([78.46.137.84]:47632 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbhLPSwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=7cvx790pwuy2FZQtM7URaUvK+FVvl+IqKyJYUudlEag=; b=m1iLy2mq5oavWPAck6ba4rQVpd
        jqu5gNf1+ZWBr6AueB3PsWirKTVjuLL8MGPhcvR1YQWCDx64QdeBr+4yoOfbbTSTGEzR51tG2w+cV
        ef9wtL4y2xct5Vu2GvWdUOA6jsfk9uxQszjR37+bNmpbCb9byuygZG6Bg/pZRRT2dmktWNL74ABQd
        Q9osM0ee4Pf2ip9Kk8PuMHjFng01DfPIF/hCmzjMGXbAJskNHDRG06/4qttu14gghC+/PH4eLUmTV
        xt59Se1q9H0Bqc9NkUY3sP7qNiOeCLk5dtcffp5iwFB6QAiOP7P+IUignmPzTeHGaZflpsxRrMyCi
        ln6J5Kog==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000ASF-As; Thu, 16 Dec 2021 19:52:23 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrb-000HSt-1R; Thu, 16 Dec 2021 19:52:23 +0100
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
Subject: [PATCH 06/13] iio: ina2xx-adc: sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:10 +0100
Message-Id: <20211216185217.1054495-7-lars@metafoo.de>
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

Use sysfs_emit() to format the custom `in_allow_async_readout` device
attribute of the ina2xx-adc driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ina2xx-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 352f27657238..4e66473b0821 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -539,7 +539,7 @@ static ssize_t ina2xx_allow_async_readout_show(struct device *dev,
 {
 	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
 
-	return sprintf(buf, "%d\n", chip->allow_async_readout);
+	return sysfs_emit(buf, "%d\n", chip->allow_async_readout);
 }
 
 static ssize_t ina2xx_allow_async_readout_store(struct device *dev,
-- 
2.30.2

