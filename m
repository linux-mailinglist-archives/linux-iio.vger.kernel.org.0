Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89D83547B5
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 22:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhDEUnD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 16:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235457AbhDEUnD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 16:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617655376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T9pT04HFS6m2DAVcuINr+EcsKi1hIY98jB9f+EJVDaQ=;
        b=iVsk1wSLPjopuvO8EvxVfvYg0ObQbHSRZUY624gVzaFENqT2SE/4Bc3L+hpDu1pMawu6G9
        /Z7U4iUu13FyQDSwbbvb1ROUZ/wEKJMmdPsGbLxW0gYSa2bPg39yjb9r7CWFLf6923QWon
        nW/svmoobH+8rrCmVSjDdjk3udBb/GI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-Dj3FcjY-O_COdzyJ4IFtGw-1; Mon, 05 Apr 2021 16:42:54 -0400
X-MC-Unique: Dj3FcjY-O_COdzyJ4IFtGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF80107ACCD;
        Mon,  5 Apr 2021 20:42:52 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68D455D9F0;
        Mon,  5 Apr 2021 20:42:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 resend 2/2] iio: documentation: Document accelerometer label use
Date:   Mon,  5 Apr 2021 22:42:24 +0200
Message-Id: <20210405204224.18715-3-hdegoede@redhat.com>
In-Reply-To: <20210405204224.18715-1-hdegoede@redhat.com>
References: <20210405204224.18715-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 7379e40d862d..b7529bca83f5 100644
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
2.30.2

