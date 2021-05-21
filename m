Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E0138CBB0
	for <lists+linux-iio@lfdr.de>; Fri, 21 May 2021 19:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhEURPu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 May 2021 13:15:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhEURPu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 May 2021 13:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621617267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pCgaqDw5Xoc3eJxJfY7O89kRCc0yBN0WDqkGQNlmEqk=;
        b=VPiKs51mBaYWBXXp/nlLBBOO/bh9IVmAkF+SNwF6F27gjnEysEo/i2wN/Bl6jCJapCXHLa
        PH53pj7fhapW1602f+QogzqaKgrFHR5OtySwxs8DLTNML4T+lH9PyMeKIoOGi2olInDvBj
        gj4sBBALBODM373ixb0bHjV9Icxps0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-oof1jAQOO12a2qpiSgeZyw-1; Fri, 21 May 2021 13:14:23 -0400
X-MC-Unique: oof1jAQOO12a2qpiSgeZyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D3F9104FB62;
        Fri, 21 May 2021 17:14:21 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-187.ams2.redhat.com [10.36.114.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 057B810013D6;
        Fri, 21 May 2021 17:14:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: [PATCH 0/8] iio: accel: bmc150: Add support for yoga's with dual accelerometers with an ACPI HID of DUAL250E
Date:   Fri, 21 May 2021 19:14:10 +0200
Message-Id: <20210521171418.393871-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

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


Hans de Goede (8):
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
  iio: accel: bmc150: Set label based on accel-location for ACPI
    DUAL250E fwnodes

 drivers/iio/accel/bmc150-accel-core.c |  87 ++----------
 drivers/iio/accel/bmc150-accel-i2c.c  | 192 +++++++++++++++++++++-----
 drivers/iio/accel/bmc150-accel.h      |  66 ++++++++-
 3 files changed, 239 insertions(+), 106 deletions(-)

-- 
2.31.1

