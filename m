Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6351C3A87
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgEDM46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 May 2020 08:56:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29564 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbgEDM4v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2020 08:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588597010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1wso0PV0/yQhvRblN5foX9DoBLtsNJDs2DFcjr24m0=;
        b=XGRf/RGzNtR9TZHpq1ebcY5kpD4a1iSZzNORyuITWbZygoTFxZdvJUBHXvtvldqtNDGgts
        aYIceEWfIb+wjSgi6V74lMQ63ruZXOQ6zXxRfT5GFjDxdSjtqBrE+l4gJaL27lSXaIGGIf
        +2K6TGyurn6gin3NEvU2nu92qHglCQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-zxyMI0AtNwuC6UNy5W9b5g-1; Mon, 04 May 2020 08:56:48 -0400
X-MC-Unique: zxyMI0AtNwuC6UNy5W9b5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D411F1895A42;
        Mon,  4 May 2020 12:56:35 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-224.ams2.redhat.com [10.36.114.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 490855D9DC;
        Mon,  4 May 2020 12:56:33 +0000 (UTC)
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
Subject: [PATCH v4 11/11] iio: light: cm32181: Fix integartion time typo
Date:   Mon,  4 May 2020 14:55:51 +0200
Message-Id: <20200504125551.434647-11-hdegoede@redhat.com>
In-Reply-To: <20200504125551.434647-1-hdegoede@redhat.com>
References: <20200504125551.434647-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix integartion time typo and while at it improve the comment with
the typo a bit in general.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 5eeefa3ee4f1..7ece523aa09e 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -250,7 +250,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32=
181)
  *  @cm32181:	pointer of struct cm32181
  *  @val2:	pointer of int to load the als_it value.
  *
- *  Report the current integartion time by millisecond.
+ *  Report the current integration time in milliseconds.
  *
  *  Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
  */
--=20
2.26.0

