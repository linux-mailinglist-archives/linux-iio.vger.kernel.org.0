Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860B83125DF
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 17:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBGQKg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 11:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53774 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhBGQKg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2021 11:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612714150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHU8ek2FEQblhGwoVh2SNTOigMXmoMF50Zhxtt9Mxlg=;
        b=MuJrsDiM+gGygm3Lx9nr5GImroXsxSLPfAmcoUMYcjrF2aqvPbTHDBuvK+tbS8VEsvkBWx
        2cHVMsOEBA8KiZ5fc+8Cv4jFmo4eIsE36qImP99RiyFG7dm+MnQQObsUWkD7UW6Ee9jV8u
        m4QXK6FbvayLdDQBviCGsHbXAp9xLzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-JCiVN-xFOHum0VjkcU_OUg-1; Sun, 07 Feb 2021 11:09:06 -0500
X-MC-Unique: JCiVN-xFOHum0VjkcU_OUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BEC38030B7;
        Sun,  7 Feb 2021 16:09:05 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32BAF1346F;
        Sun,  7 Feb 2021 16:09:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/3] iio: core: Allow drivers to specify a label without it coming from of
Date:   Sun,  7 Feb 2021 17:08:59 +0100
Message-Id: <20210207160901.110643-2-hdegoede@redhat.com>
In-Reply-To: <20210207160901.110643-1-hdegoede@redhat.com>
References: <20210207160901.110643-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Only set indio_dev->label from of/dt if there actually is a label
specified in of.

This allows drivers to set a label without this being overwritten with
NULL when there is no label specified in of. This is esp. useful on
devices where of is not used at all, such as your typical x86/ACPI device.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/industrialio-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e9ee9363fed0..b409e076818b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1755,6 +1755,7 @@ static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 {
+	const char *label;
 	int ret;
 
 	if (!indio_dev->info)
@@ -1765,8 +1766,9 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
 		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
 
-	indio_dev->label = of_get_property(indio_dev->dev.of_node, "label",
-					   NULL);
+	label = of_get_property(indio_dev->dev.of_node, "label", NULL);
+	if (label)
+		indio_dev->label = label;
 
 	ret = iio_check_unique_scan_index(indio_dev);
 	if (ret < 0)
-- 
2.30.0

