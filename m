Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E19477BFA
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbhLPSw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 13:52:27 -0500
Received: from www381.your-server.de ([78.46.137.84]:47648 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbhLPSwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 13:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=r+U1xhyssSTBOXzzkSA+bcC9nDbJhc561YC9ShPSarQ=; b=MuH/a/p7z3BiS9KtQbEo8op+fD
        P+QGbyyQOIxWgC4wSp5Xu8QwutcdfTAo/OOq1APqlqI+hE409k9WWqJI9tSz9jpRc8P8QU3tOCIrW
        ++3UUsdeVmrtcgNcTEBZ3/wkhk6X3AZEFb4K2R6qaqPzg86pymPJzU8MbJ4wSPXeuuT6g8vRcEK+N
        Oq1iNOxh4NQdqIMrVBE2Imd331jDhRcWCuwvvEGCTJKEfBXXt+1EKSa1eSrkRP8atQoOg891+IiyP
        WPXZckZkMBbO75rsLsBL3De5COHnX1Q495EI/qvCfSTpC+1zOeDdndHkTwNN4RcGuo0pFtXCSfBge
        vgo3PBYg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxvra-000ARw-6p; Thu, 16 Dec 2021 19:52:22 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxvrZ-000HSt-Sj; Thu, 16 Dec 2021 19:52:21 +0100
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
Subject: [PATCH 01/13] iio: core: Use sysfs_emit()
Date:   Thu, 16 Dec 2021 19:52:05 +0100
Message-Id: <20211216185217.1054495-2-lars@metafoo.de>
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

This patch converts the places in the IIO core that follow the pattern of

   return s*printf(...)

to

   return sysfs_emit(...)

This covers the new places that have been introduced where sprintf() is
used for formatting sysfs output since the last time this was done in
commit 83ca56b663cf ("iio: core: Use sysfs_emit() (trivial bits)").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 4 ++--
 drivers/iio/industrialio-core.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 94eb9f6cf128..f7721553a938 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1383,9 +1383,9 @@ static ssize_t direction_show(struct device *dev,
 
 	switch (buffer->direction) {
 	case IIO_BUFFER_DIRECTION_IN:
-		return sprintf(buf, "in\n");
+		return sysfs_emit(buf, "in\n");
 	case IIO_BUFFER_DIRECTION_OUT:
-		return sprintf(buf, "out\n");
+		return sysfs_emit(buf, "out\n");
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 20d5178ca073..25144383865c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -747,7 +747,7 @@ static ssize_t iio_read_channel_label(struct device *dev,
 		return indio_dev->info->read_label(indio_dev, this_attr->c, buf);
 
 	if (this_attr->c->extend_name)
-		return sprintf(buf, "%s\n", this_attr->c->extend_name);
+		return sysfs_emit(buf, "%s\n", this_attr->c->extend_name);
 
 	return -EINVAL;
 }
-- 
2.30.2

