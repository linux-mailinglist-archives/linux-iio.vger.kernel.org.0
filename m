Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD362C3B2D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 09:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgKYIga (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 03:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKYIg3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 03:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606293388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mmDrXg1/nVJWCDWoUl8t/ciR7+jylop17aKdlxYsU28=;
        b=Y3+N/c//m6/R+UxKqptk9LY96LMZmpqSfh+uhrNiMiVb43pEgj47oss5FOfyIASzMMLrRC
        eMeLj3H7HbDlBt1Layit+4jVFWOsgoJgjapqT/4dYtj+jVEqbShg85G6Q7ZvPCnZuq4mGh
        z1rhc3wnHG3OXpLrCRYVqtXUQOT6MCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-97P2FFQVMViLeVqAJvV4Pw-1; Wed, 25 Nov 2020 03:36:26 -0500
X-MC-Unique: 97P2FFQVMViLeVqAJvV4Pw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BD3981CBE1;
        Wed, 25 Nov 2020 08:36:25 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-185.ams2.redhat.com [10.36.114.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 195FD5C1A1;
        Wed, 25 Nov 2020 08:36:20 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH 1/3] iio: accel: bmc150: Removed unused bmc150_accel_dat irq member
Date:   Wed, 25 Nov 2020 09:36:16 +0100
Message-Id: <20201125083618.10989-2-hdegoede@redhat.com>
In-Reply-To: <20201125083618.10989-1-hdegoede@redhat.com>
References: <20201125083618.10989-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bmc150_accel_dat struct irq member is only ever used inside
bmc150_accel_core_probe, drop it and just use the function argument
directly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 48435865fdaf..088716d55855 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -183,7 +183,6 @@ enum bmc150_accel_trigger_id {
 
 struct bmc150_accel_data {
 	struct regmap *regmap;
-	int irq;
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;
@@ -1568,7 +1567,6 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 
 	data = iio_priv(indio_dev);
 	dev_set_drvdata(dev, indio_dev);
-	data->irq = irq;
 
 	data->regmap = regmap;
 
@@ -1599,9 +1597,8 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 		return ret;
 	}
 
-	if (data->irq > 0) {
-		ret = devm_request_threaded_irq(
-						dev, data->irq,
+	if (irq > 0) {
+		ret = devm_request_threaded_irq(dev, irq,
 						bmc150_accel_irq_handler,
 						bmc150_accel_irq_thread_handler,
 						IRQF_TRIGGER_RISING,
-- 
2.28.0

