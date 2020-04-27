Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1817C1BA946
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgD0PvJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 11:51:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44009 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728491AbgD0PvI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 11:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588002667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0EVbd8yvTnodt/PwOFNSr4NOJBYWtmio5+4hHlbVdA=;
        b=MbSuDOcZjHsiLgGzFWjiHQzuMnH1n4njgSiooB0wV/YDqhB9+Z1BzIS3mh1u748gOSIbvx
        IwO54eMrEaNvLgJwpjrWUK8IY7IFry188xZY7Ec0anWqtVcmgzrH/KusCx+UAhNIEV1MQz
        9EPE0Ij0YLhN6lpaXb10rYb2cFVPcdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-nI1rz6WXPVO-hYMpnkVNJQ-1; Mon, 27 Apr 2020 11:51:03 -0400
X-MC-Unique: nI1rz6WXPVO-hYMpnkVNJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B660B835B40;
        Mon, 27 Apr 2020 15:51:01 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-38.ams2.redhat.com [10.36.114.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 316A96063C;
        Mon, 27 Apr 2020 15:50:59 +0000 (UTC)
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
Subject: [PATCH v2 8/8] iio: light: cm32181: Fix integartion time typo
Date:   Mon, 27 Apr 2020 17:50:37 +0200
Message-Id: <20200427155037.218390-8-hdegoede@redhat.com>
In-Reply-To: <20200427155037.218390-1-hdegoede@redhat.com>
References: <20200427155037.218390-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 04ba636415c9..95c57b0cb230 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -236,7 +236,7 @@ static int cm32181_reg_init(struct cm32181_chip *cm32=
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

