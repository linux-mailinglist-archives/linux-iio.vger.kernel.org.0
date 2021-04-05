Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75C83547B4
	for <lists+linux-iio@lfdr.de>; Mon,  5 Apr 2021 22:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhDEUmx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Apr 2021 16:42:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235457AbhDEUmx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 16:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617655366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1fCmnZr6BR8aX0+gHUG0FeM5qO2eDytcn8WJ1wUJsk=;
        b=LyDPUXSGxT60HCL5lncG6fjZgJdYkENNtgC61eIAqp8fbC+4iGsHLRQrZJUqnmm7v9IVTW
        1z9w4tiFUSWxiVW5qm4hpsz5PQGcbbkogdVLOSvGInBxaG0/oTAyifVbo79e3OA/m38hT1
        2p7bYok7NntLtVpgb8tG2L3T70yqQAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-KFWq2IvDMlKNdJVo7frBUg-1; Mon, 05 Apr 2021 16:42:45 -0400
X-MC-Unique: KFWq2IvDMlKNdJVo7frBUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B67B8030CA;
        Mon,  5 Apr 2021 20:42:43 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AEE05D9F0;
        Mon,  5 Apr 2021 20:42:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2 resend 1/2] iio: documentation: Document proximity sensor label use
Date:   Mon,  5 Apr 2021 22:42:23 +0200
Message-Id: <20210405204224.18715-2-hdegoede@redhat.com>
In-Reply-To: <20210405204224.18715-1-hdegoede@redhat.com>
References: <20210405204224.18715-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add an entry to Documentation/ABI/testing/sysfs-bus-iio for
the new device label sysfs-attribute support.

And document the standardized labels which may be used with proximity
sensors to hint userspace about the intended use of the sensor.

Using labels to differentiate between the multiple proximity sensors
which a modern laptop/tablet may have was discussed in this thread:
https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com/

As mentioned there the "proximity-wifi*" labels are already being used
in this manner on some chromebooks, see e.g.:
arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
arch/arm64/boot/dts/qcom/sc7180-trogdor-lte-sku.dtsi

And the "proximity-palmrest" and "proximity-lap" labels are intended
to be used with the lap and palmrest sensors found in recent Lenovo
ThinkPad models.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Pearson <mpearson@lenovo.com>
Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Drop the too generic:
  What:           /sys/bus/iio/devices/iio:deviceX/in_*_label
  What:           /sys/bus/iio/devices/iio:deviceX/out_*_label
  lines from the newly added documentation, if/when we start
  using channel-labels with proximity sensors then those should
  get a separate in_proximityX_label documentation.
---
 Documentation/ABI/testing/sysfs-bus-iio | 39 +++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d957f5da5c04..7379e40d862d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -33,6 +33,45 @@ Description:
 		Description of the physical chip / device for device X.
 		Typically a part number.
 
+What:		/sys/bus/iio/devices/iio:deviceX/label
+KernelVersion:	5.8
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Optional symbolic label for a device.
+		This is useful for userspace to be able to better identify an
+		individual device.
+
+		The contents of the label are free-form, but there are some
+		standardized uses:
+
+		For proximity sensors which give the proximity (of a person) to
+		a certain wlan or wwan antenna the following standardized labels
+		are used:
+
+		* "proximity-wifi"
+		* "proximity-lte"
+		* "proximity-wifi-lte"
+		* "proximity-wifi-left"
+		* "proximity-wifi-right"
+
+		These are used to indicate to userspace that these proximity
+		sensors may be used to tune transmit power to ensure that
+		Specific Absorption Rate (SAR) limits are honored.
+		The "-left" and "-right" labels are for devices with multiple
+		antennas.
+
+		In some laptops/tablets the standardized proximity sensor labels
+		instead	indicate proximity to a specific part of the device:
+
+		* "proximity-palmrest" indicates proximity to the keyboard's palmrest
+		* "proximity-palmrest-left" indicates proximity to the left part of the palmrest
+		* "proximity-palmrest-right" indicates proximity to the right part of the palmrest
+		* "proximity-lap" indicates the device is being used on someone's lap
+
+		Note "proximity-lap" is special in that its value may be
+		calculated by firmware from other sensor readings, rather then
+		being a raw sensor reading.
+
 What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
-- 
2.30.2

