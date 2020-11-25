Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1593C2C3B4B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 09:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgKYIqO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 03:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbgKYIqO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 03:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606293974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BYExABNThzbvubDz7odol/3lPd7A9PBzJbX0bMcpnwY=;
        b=N3B2Xgeg0YP++5G+N3ubFtoaxnQUsnnpaR1dr/J7cIS3+u2qqrH3r/3JTGcVWoakYa5Mjy
        HsL/+jjix77H1cD6Z65FGMC57WwqlYNlG2GxsbvB/KAiov7+d/YYMRuk49L6O3c3IrsqVd
        bOBv5n6y7fa3dY7oqwPvNIslyc1DZ+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-O87OBD48Nbenyj90hAncdg-1; Wed, 25 Nov 2020 03:46:11 -0500
X-MC-Unique: O87OBD48Nbenyj90hAncdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31269107ACFA;
        Wed, 25 Nov 2020 08:46:10 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-185.ams2.redhat.com [10.36.114.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D1465D9C2;
        Wed, 25 Nov 2020 08:46:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: core: Copy iio_info.attrs->is_visible into iio_dev_opaque.chan_attr_group.is_visible
Date:   Wed, 25 Nov 2020 09:46:06 +0100
Message-Id: <20201125084606.11404-2-hdegoede@redhat.com>
In-Reply-To: <20201125084606.11404-1-hdegoede@redhat.com>
References: <20201125084606.11404-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio-core extends the attr_group provided by the driver with its
own attributes. To be able to do this it:

1. Has its own (non const) io_dev_opaque.chan_attr_group attr_group struct
2. It allocates a new attrs array with room for both the drivers and its
   own attributes
3. It copies over the driver provided attributes into the newly allocated
   attrs array.

But the drivers attr_group may contain more then just the attrs array, it
may also contain an is_visible callback and at least the adi-axi-adc.c
is currently defining such a callback.

Change the attr_group copying code to also copy over the is_visible
callback, so that drivers can define one and have it workins as is
normal for attr_group-s all over the kernel.

Note that the is_visible callback takes an index into the array as
argument, so that indices of the driver's attributes must not change,
this is not a problem as the driver's own attributes are added first
to the newly allocated attrs array and the attributes handled by the
core are appended after the driver's attributes.

Cc: Michael Hennerich <michael.hennerich@analog.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/industrialio-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 261d3b17edc9..7943d0545b61 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1466,11 +1466,14 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		goto error_clear_attrs;
 	}
 	/* Copy across original attributes */
-	if (indio_dev->info->attrs)
+	if (indio_dev->info->attrs) {
 		memcpy(iio_dev_opaque->chan_attr_group.attrs,
 		       indio_dev->info->attrs->attrs,
 		       sizeof(iio_dev_opaque->chan_attr_group.attrs[0])
 		       *attrcount_orig);
+		iio_dev_opaque->chan_attr_group.is_visible =
+			indio_dev->info->attrs->is_visible;
+	}
 	attrn = attrcount_orig;
 	/* Add all elements from the list. */
 	list_for_each_entry(p, &iio_dev_opaque->channel_attr_list, l)
-- 
2.28.0

