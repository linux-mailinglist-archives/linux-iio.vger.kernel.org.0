Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3622C3B2C
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 09:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgKYIgZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 03:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgKYIgY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 03:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606293384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vqQxrpo85mVYo07Cd2mdR0nFp/9shZ2WoKaglQ8k/eQ=;
        b=Tozkth+Z8jz8Mcp6KW1PYIeY042ur9cwWIYjiRQufrSGB6KMzkRNgWx/sq8bWURR6Cq4cB
        j69qDsgCCKX4U/Jtde88CiGjAN9Bp49dhsLKjl+zuacVHdPW6N4/4kvAWxPw9mBCtngpKF
        Nhd7TuYyTN4UUG0XiIt4Q6YARs6NDLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-hWpwU6LRNa-2oOuhkmnqVw-1; Wed, 25 Nov 2020 03:36:22 -0500
X-MC-Unique: hWpwU6LRNa-2oOuhkmnqVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7D2918C8C00;
        Wed, 25 Nov 2020 08:36:20 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-185.ams2.redhat.com [10.36.114.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 409465C1A1;
        Wed, 25 Nov 2020 08:36:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH 1/3] iio: accel: bmc150: Improve ACPI enumeration support
Date:   Wed, 25 Nov 2020 09:36:15 +0100
Message-Id: <20201125083618.10989-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

This series improves support for ACPI enumeration of bmc150 accels
described by an ACPI node with an ACPI hw-id of BOSC0200:

1. Add support for nodes which describe 2 acceleromers in a single node,
fixing: https://bugzilla.kernel.org/show_bug.cgi?id=198671

2. Add support for reading the mount-matrix from the ACPI node.

This is done in patches 2 - 3, patch 1 is a trivial cleanup which I noticed
could be done while working on this.

Patch 2 is based on an earlier patch for this from Jeremy Cline:
https://lore.kernel.org/r/010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com

That patch was put on hold because normally ACPI nodes which describe
multiple i2c-clients in a single node are handled by:
drivers/platform/x86/i2c-multi-instantiate.c

Which I tried to do at first, but as explained in the commit msg
of the updated patch, that is not possible in this special case
(because it would cause userspace breakage due to the modalias changing).

Regards,

Hans

