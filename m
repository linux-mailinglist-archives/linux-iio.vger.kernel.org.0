Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4051C3A5E
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgEDM4N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 08:56:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23574 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728074AbgEDM4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 08:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588596970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEIP3+ximyK56naAEpjry6N6TSQhKE54lVNyGu2CW8s=;
        b=ez66Viouz9ozODrOGUmUKzjvSa7wWKjcq10meUB9gKW0pKRulM1Kznf8RGv6iL3tNXVp5J
        DKDwr0H6pJctoG27Yt9B4pJZgEftlsO/xKzT2LcfsVzayPf7+hFZe8gSD92QstLt0lAUoD
        FriE/lFW2j5oH1567HaH5qBVucofB/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-xS5RiQ1TMk-c-JxfueaQCA-1; Mon, 04 May 2020 08:56:06 -0400
X-MC-Unique: xS5RiQ1TMk-c-JxfueaQCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7035F107ACF3;
        Mon,  4 May 2020 12:56:04 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-224.ams2.redhat.com [10.36.114.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C05CA5D97D;
        Mon,  4 May 2020 12:55:58 +0000 (UTC)
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
        linux-iio@vger.kernel.org
Subject: [PATCH v4 02/11] iio: light: cm32181: Add support for ACPI enumeration
Date:   Mon,  4 May 2020 14:55:42 +0200
Message-Id: <20200504125551.434647-2-hdegoede@redhat.com>
In-Reply-To: <20200504125551.434647-1-hdegoede@redhat.com>
References: <20200504125551.434647-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for ACPI enumeration, this has been tested on a HP
HP Pavilion x2 Detachable 10 (Bay Trail model).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- This is a new patch in v3 of this patch-set
---
 drivers/iio/light/cm32181.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 2c139d85ef0c..91f83f9b9ea3 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -343,9 +343,18 @@ static const struct of_device_id cm32181_of_match[] =
=3D {
 };
 MODULE_DEVICE_TABLE(of, cm32181_of_match);
=20
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cm32181_acpi_match[] =3D {
+	{ "CPLM3218", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cm32181_acpi_match);
+#endif
+
 static struct i2c_driver cm32181_driver =3D {
 	.driver =3D {
 		.name	=3D "cm32181",
+		.acpi_match_table =3D ACPI_PTR(cm32181_acpi_match),
 		.of_match_table =3D of_match_ptr(cm32181_of_match),
 	},
 	.probe_new	=3D cm32181_probe,
--=20
2.26.0

