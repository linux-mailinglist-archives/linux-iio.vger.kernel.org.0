Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201712C3B69
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 09:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgKYIyx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 03:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgKYIyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 03:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606294492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QZt+xeKqv8xwglUycQkKrbaGN88kn9N6/SdpsqNWQC0=;
        b=NXyiPO+sq4esYK4p7lpbNVE2AFe24zsPXw5M+AppwFmyRO7G+WAzb9ZOZWGPa1vLfqZrf8
        ag9NrxSoaq39oQ64Xjg7lYyH1kmEyENiDBQXQMPvw+k/at3GXJBeAAObztflhzPiNM18Z9
        HFARvLwekRAMiVi/46+V/+gaLHGwgjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-gv4QshKFNwuaW6-0wwXmcA-1; Wed, 25 Nov 2020 03:54:48 -0500
X-MC-Unique: gv4QshKFNwuaW6-0wwXmcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C54E1814266;
        Wed, 25 Nov 2020 08:54:46 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-185.ams2.redhat.com [10.36.114.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C49160C61;
        Wed, 25 Nov 2020 08:54:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH 0/1] iio: accel: kxcjk1013: Add tablet_mode sysfs file for exercising the KIOX010A ACPI DSM
Date:   Wed, 25 Nov 2020 09:54:43 +0100
Message-Id: <20201125085444.11593-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

This builds on top of the recently merged commit e5b1032a656e ("iio: accel:
kxcjk1013: Add support for KIOX010A ACPI DSM for setting tablet-mode"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5b1032a656e9aa4c7a4df77cb9156a2a651a5f9

As explained in that commit: "Some 360 degree hinges (yoga) style 2-in-1
devices use 2 KXCJ91008-s to allow the OS to determine the angle between
the display and the base of the device, so that the OS can determine if
the 2-in-1 is in laptop or in tablet-mode.

On Windows both accelerometers are read by a special HingeAngleService
process; and this process calls a DSM (Device Specific Method) on the
ACPI KIOX010A device node for the sensor in the display, to let the
embedded-controller (EC) know about the mode so that it can disable the
kbd and touchpad to avoid spurious input while folded into tablet-mode."

Currently the kxcjk1013 driver calls the DSM for this once at probe time
to ensure that the builtin kbd and touchpad work.

This commit adds a tablet_mode sysfs file to the i2c_client device
(not to the iio-device so outside of the iio namespace!) which allows
userspace to call the DSM to toggle between laptop/tablet-mode by
writing this file.

I guess this might be a bit controversial, butI would still like to
see this patch go upstream.

The user reporting the initial kbd / touchpad not working issue has
requested for the functionality offered by the DSM (silence kbd and
touchpad) to be made available to userspace; and I already wrote
this patch before then because I would like users to be able to
exercise the DSM to be able to observe what influence it has on
these systems.

Regards,

Hans

