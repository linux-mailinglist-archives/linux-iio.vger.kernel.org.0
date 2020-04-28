Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382ED1BC6AC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgD1R3n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 13:29:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728520AbgD1R3l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 13:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588094980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=302JfAKXdeKAFP9le9Cjh8LmYPnDyvK9wzRhL+36K80=;
        b=RblZzJo+iJMXBPoQqILs8mJkG2LsNv+KuWmGoDlHyrV/JKtXcINIZq3kM2/L4GoKWLOUiF
        UQj/8hILW91kPOGlHOFmG2Jf3WTXD+n0MjOGT1AU/x2vzs/N24Nh3t5yshi8z6pq9+GDkK
        ylS5BXmy7l1eF4ha2GLIelr1zmkEBDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-3bqQkQLhOoGCWHtZ7pgt1A-1; Tue, 28 Apr 2020 13:29:39 -0400
X-MC-Unique: 3bqQkQLhOoGCWHtZ7pgt1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08BE91054F93;
        Tue, 28 Apr 2020 17:29:37 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-62.ams2.redhat.com [10.36.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71BB25C1D4;
        Tue, 28 Apr 2020 17:29:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 03/11] iio: light: cm32181: Add some extra register defines
Date:   Tue, 28 Apr 2020 19:29:15 +0200
Message-Id: <20200428172923.567806-3-hdegoede@redhat.com>
In-Reply-To: <20200428172923.567806-1-hdegoede@redhat.com>
References: <20200428172923.567806-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These come from a newer version of cm32181.c, which is floating around
the net, with a copyright of:

 * Copyright (C) 2014 Capella Microsystems Inc.
 * Author: Kevin Tsai <ktsai@capellamicro.com>
 *
 * This program is free software; you can redistribute it and/or modify i=
t
 * under the terms of the GNU General Public License version 2, as publis=
hed
 * by the Free Software Foundation.

Note that this removes the bogus CM32181_CMD_ALS_ENABLE define, there
is no enable bit, only a disable bit and enabled is the absence of
being disabled.

This is a preparation patch for adding support for the older
CM3218 model of the light sensor.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 5ca8bbf6667c..6fc0a753c499 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -18,6 +18,9 @@
=20
 /* Registers Address */
 #define CM32181_REG_ADDR_CMD		0x00
+#define CM32181_REG_ADDR_WH		0x01
+#define CM32181_REG_ADDR_WL		0x02
+#define CM32181_REG_ADDR_TEST		0x03
 #define CM32181_REG_ADDR_ALS		0x04
 #define CM32181_REG_ADDR_STATUS		0x06
 #define CM32181_REG_ADDR_ID		0x07
@@ -26,9 +29,13 @@
 #define CM32181_CONF_REG_NUM		0x01
=20
 /* CMD register */
-#define CM32181_CMD_ALS_ENABLE		0x00
-#define CM32181_CMD_ALS_DISABLE		0x01
-#define CM32181_CMD_ALS_INT_EN		0x02
+#define CM32181_CMD_ALS_DISABLE		BIT(0)
+#define CM32181_CMD_ALS_INT_EN		BIT(1)
+#define CM32181_CMD_ALS_THRES_WINDOW	BIT(2)
+
+#define CM32181_CMD_ALS_PERS_SHIFT	4
+#define CM32181_CMD_ALS_PERS_MASK	(0x03 << CM32181_CMD_ALS_PERS_SHIFT)
+#define CM32181_CMD_ALS_PERS_DEFAULT	(0x01 << CM32181_CMD_ALS_PERS_SHIFT=
)
=20
 #define CM32181_CMD_ALS_IT_SHIFT	6
 #define CM32181_CMD_ALS_IT_MASK		(0x0F << CM32181_CMD_ALS_IT_SHIFT)
@@ -82,7 +89,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm3218=
1)
 		return -ENODEV;
=20
 	/* Default Values */
-	cm32181->conf_regs[CM32181_REG_ADDR_CMD] =3D CM32181_CMD_ALS_ENABLE |
+	cm32181->conf_regs[CM32181_REG_ADDR_CMD] =3D
 			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
 	cm32181->calibscale =3D CM32181_CALIBSCALE_DEFAULT;
=20
--=20
2.26.0

