Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F031C241
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBOTLq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 14:11:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhBOTLp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 14:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613416215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rhWeoWA0yDSgOZOfB26TbTET/0qvQB8GfCjmVCIUYxY=;
        b=BAjIC7mxvfJU4zIQ5y8M9zwk6bMF5l8yN/k6MyoiPiiIomyyKZOEvCg9xrKfDglVIHiSkM
        s8En+BMLARFNbO8pELipu7BIXFZyCy2du9Qry3+SOXFPyBZP67v1RzIJGvPDwePA9rklUf
        lpMR0G6JXSuUgQMpMLxot5KkczZ1vYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-tylSJ-EjN5uMKullNpKceg-1; Mon, 15 Feb 2021 14:10:11 -0500
X-MC-Unique: tylSJ-EjN5uMKullNpKceg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18D2918957E4;
        Mon, 15 Feb 2021 19:10:10 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-74.ams2.redhat.com [10.36.115.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F5D360BE2;
        Mon, 15 Feb 2021 19:10:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Mark Pearson <mpearson@lenovo.com>
Subject: [PATCH v2 2/2] iio: documentation: Document accelerometer label use
Date:   Mon, 15 Feb 2021 20:10:03 +0100
Message-Id: <20210215191003.698888-2-hdegoede@redhat.com>
In-Reply-To: <20210215191003.698888-1-hdegoede@redhat.com>
References: <20210215191003.698888-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some 2-in-1 laptops / convertibles with 360° (yoga-style) hinges,
have 2 accelerometers, 1 in their base and 1 in their display.

In many cases the kernel can detect the location of each accelerometer
based on e.g. information from the ACPI tables.

It is important for userspace to know the location of the 2 accelerometers.
Rather then adding a new sysfs-attribute for this we can relay this
information to userspace by using standardized label strings for this.
This mirrors how this is done for proximity sensors.

This commit documents 2 new standardized label strings for this purpose:
"accel-base"
"accel-display"

Note the "base" and "display" suffixes were chosen to match the values
used for the systemd/udev hwdb.d/60-sensor.hwdb file's ACCEL_LOCATION
property.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Pearson <mpearson@lenovo.com>
Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 364f842350ab..5764f100d33d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -72,6 +72,13 @@ Description:
 		calculated by firmware from other sensor readings, rather then
 		being a raw sensor reading.
 
+		For accelerometers used in 2-in-1s with 360° (yoga-style) hinges,
+		which have an accelerometer in both their base and their display,
+		the following standardized labels are used:
+
+		* "accel-base"
+		* "accel-display"
+
 What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
-- 
2.30.1

