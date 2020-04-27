Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4811BA939
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgD0PvB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 11:51:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52659 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728487AbgD0PvA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 11:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588002659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fY6m/15VheJvgRGWmA9hnnwR6MqOrOf6tNIZ+WDEnoQ=;
        b=U79UO5eMIgHUkxezrHDi80YMkbSuS7UqtUsD4jkVXe6d6AWUaf0DMuZ3yBsPdEheNqGUC1
        8T5cHnkueIeEUNBFv/9gWyrOUEog3opSXj+cAfXXdruqyNFdRrHdjwHGuIi2I6W4fWG6OC
        lt0GnMMh/iWLwRKCWa07aWXWwdIY/Sc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-hiFdzsm6N1ODuSZG6p3XyQ-1; Mon, 27 Apr 2020 11:50:58 -0400
X-MC-Unique: hiFdzsm6N1ODuSZG6p3XyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11A1C464;
        Mon, 27 Apr 2020 15:50:56 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-38.ams2.redhat.com [10.36.114.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81D6F60BEC;
        Mon, 27 Apr 2020 15:50:53 +0000 (UTC)
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
Subject: [PATCH v2 6/8] iio: light: cm32181: Make lux_per_bit and lux_per_bit_base_it runtime settings
Date:   Mon, 27 Apr 2020 17:50:35 +0200
Message-Id: <20200427155037.218390-6-hdegoede@redhat.com>
In-Reply-To: <20200427155037.218390-1-hdegoede@redhat.com>
References: <20200427155037.218390-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make lux_per_bit and lux_per_bit_base_it settings stored in struct
cm32181_chip instead of a hardcoded (defined) values.

This is a preparation patch for reading some ACPI tables which specify
a device specific lux_per_bit value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index ebdbc7f865f3..92f99cbb5cc1 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -69,6 +69,8 @@ struct cm32181_chip {
 	u16 conf_regs[CM32181_CONF_REG_NUM];
 	unsigned long init_regs_bitmap;
 	int calibscale;
+	int lux_per_bit;
+	int lux_per_bit_base_it;
 	int num_als_it;
 	const int *als_it_bits;
 	const int *als_it_values;
@@ -116,6 +118,8 @@ static int cm32181_reg_init(struct cm32181_chip *cm32=
181)
 			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
 	cm32181->init_regs_bitmap =3D BIT(CM32181_REG_ADDR_CMD);
 	cm32181->calibscale =3D CM32181_CALIBSCALE_DEFAULT;
+	cm32181->lux_per_bit =3D CM32181_LUX_PER_BIT;
+	cm32181->lux_per_bit_base_it =3D CM32181_LUX_PER_BIT_BASE_IT;
=20
 	/* Initialize registers*/
 	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {
@@ -212,8 +216,8 @@ static int cm32181_get_lux(struct cm32181_chip *cm321=
81)
 	if (ret < 0)
 		return -EINVAL;
=20
-	lux =3D CM32181_LUX_PER_BIT;
-	lux *=3D CM32181_LUX_PER_BIT_BASE_IT;
+	lux =3D cm32181->lux_per_bit;
+	lux *=3D cm32181->lux_per_bit_base_it;
 	lux =3D div_u64(lux, als_it);
=20
 	ret =3D i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
--=20
2.26.0

