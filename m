Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67311B8F44
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgDZLD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 07:03:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726225AbgDZLDY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 07:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587899002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0r4SFAC0+UCYN7UhbpOsXXVV0ElOUm3a7IZgFa572w=;
        b=eQClLDyKA1aOxDMJxjUnmmMOUEP26UTOEiciML8rX5sEjKEdNqyFhJnzukLm0RprT0M9/m
        e7mOszC8fOd9rLBt9gb6FULbBHJgtKzpRoxh0CPEkq2ni7EaxjQCndlGFOIJ6Kq8kVSJD3
        IGLx0XuWeOanApQTu3STn1vV6T2PkSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-C4GW0QpgPkCOZHcQa3REAA-1; Sun, 26 Apr 2020 07:03:19 -0400
X-MC-Unique: C4GW0QpgPkCOZHcQa3REAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C8FE464;
        Sun, 26 Apr 2020 11:03:17 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 740B310013A1;
        Sun, 26 Apr 2020 11:03:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 6/8] iio: light: cm32181: Make lux_per_bit and lux_per_bit_base_it runtime settings
Date:   Sun, 26 Apr 2020 13:02:54 +0200
Message-Id: <20200426110256.218186-6-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-1-hdegoede@redhat.com>
References: <20200426110256.218186-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Make lux_per_bit and lux_per_bit_base_it settings stored in struct
cm32181_chip instead of a hardcoded (defined) values.

This is a preparation patch for reading some ACPI tables which specify
a device specific lux_per_bit value.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 4fdf2f4a23ab..e5674d4a8143 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -69,6 +69,8 @@ struct cm32181_chip {
 	u16 conf_regs[CM32181_CONF_REG_NUM];
 	int init_regs_bitmap;
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
 	for (i =3D 0; i < CM32181_CONF_REG_NUM; i++) {
@@ -214,8 +218,8 @@ static int cm32181_get_lux(struct cm32181_chip *cm321=
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

