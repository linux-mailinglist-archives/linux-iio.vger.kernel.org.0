Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856CF38DBFC
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhEWRCh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhEWRCh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SrXNkz53ySTGpigrRKYpycHhIbtjz7THZSCO6yI0sDA=;
        b=VOOIYlCDITZtX5z2Cwq/8RYJ1L+ZbeQgjMj6vpE9foozOKuGx4hAykrTj7i6Dt/WpPa3MA
        h1dOkDO0NJNHbSAk/UHzH2hT3BEJoUrV4M2LdqsnElbwzFAaAdBVvwHQ3YVpZg/lySC2iO
        50X4YychtIjVGoxvRdNrRLFpUSsrSdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-ehFqQU2MNJGWQgHjX41J4w-1; Sun, 23 May 2021 13:01:07 -0400
X-MC-Unique: ehFqQU2MNJGWQgHjX41J4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B72E280ED8B;
        Sun, 23 May 2021 17:01:05 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7597E5D9F2;
        Sun, 23 May 2021 17:01:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 0/9] iio: accel: bmc150: Add support for yoga's with dual accelerometers with an ACPI HID of DUAL250E
Date:   Sun, 23 May 2021 19:00:54 +0200
Message-Id: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi all,

Here is v2 of this series, addressing Andy's review remarks and
rewrap some comments at 80 chars limit.

For more info here is the v1 cover-letter:

Some 360 degree hinges (yoga) style 2-in-1 devices use 2 bmc150 accels
to allow the OS to determine the angle between the display and the base
of the device, so that the OS can determine if the 2-in-1 is in laptop
or in tablet-mode.

We already support this setup on devices using a single ACPI node
with a HID of "BOSC0200" to describe both accelerometers. This patch
set extends this support to also support the same setup but then
using a HID of "DUAL250E".

While testing this I found some crashes on rmmod, patches 1-2
fix those patches, patch 3 does some refactoring and patch 4
adds support for the "DUAL250E" HID.

Unfortunately we need some more special handling though, which the
rest of the patches are for.

On Windows both accelerometers are read (polled) by a special service
and this service calls a DSM (Device Specific Method), which in turn
translates the angles to one of laptop/tablet/tent/stand mode and then
notifies the EC about the new mode and the EC then enables or disables
the builtin keyboard and touchpad based in the mode.

When the 2-in-1 is powered-on or resumed folded in tablet mode the
EC senses this independent of the DSM by using a HALL effect sensor
which senses that the keyboard has been folded away behind the display.

At power-on or resume the EC disables the keyboard based on this and
the only way to get the keyboard to work after this is to call the
DSM to re-enable it (similar to how we also need to call a special
DSM in the kxcjk-1013.c accel driver to re-enable the keyboard).

Patches 5-7 deal with the DSM mess and patch 8 adds labels to the
2 accelerometers specifying which one is which.

Regards,

Hans


Hans de Goede (9):
  iio: accel: bmc150: Fix dereferencing the wrong pointer in
    bmc150_get/set_second_device
  iio: accel: bmc150: Don't make the remove function of the second
    accelerometer unregister itself
  iio: accel: bmc150: Move check for second ACPI device into a separate
    function
  iio: accel: bmc150: Add support for dual-accelerometers with a
    DUAL250E HID
  iio: accel: bmc150: Move struct bmc150_accel_data definition to
    bmc150-accel.h
  iio: accel: bmc150: Remove bmc150_set/get_second_device() accessor
    functions
  iio: accel: bmc150: Add support for DUAL250E ACPI DSM for setting the
    hinge angle
  iio: accel: bmc150: Refactor bmc150_apply_acpi_orientation()
  iio: accel: bmc150: Set label based on accel-location for ACPI
    DUAL250E fwnodes

 drivers/iio/accel/bmc150-accel-core.c | 110 +++++----------
 drivers/iio/accel/bmc150-accel-i2c.c  | 193 ++++++++++++++++++++++----
 drivers/iio/accel/bmc150-accel.h      |  66 ++++++++-
 3 files changed, 260 insertions(+), 109 deletions(-)

-- 
2.31.1

