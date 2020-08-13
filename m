Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A897E243435
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMGxQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 02:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgHMGxP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 02:53:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985DDC061757
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2020 23:53:15 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1k676l-0005EP-FS; Thu, 13 Aug 2020 08:53:03 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1k676j-0002oU-6l; Thu, 13 Aug 2020 08:53:01 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>, trivial@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: ABI: iio: fix some spelling mistakes
Date:   Thu, 13 Aug 2020 08:52:20 +0200
Message-Id: <20200813065220.23256-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This fixes some typos found while browsing the documentation.

Cc: trivial@kernel.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 Documentation/ABI/testing/sysfs-bus-iio | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d3e53a6d8331..ef86702678c7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -49,9 +49,9 @@ Description:
 		resulting sampling frequency.  In many devices this
 		parameter has an effect on input filters etc. rather than
 		simply controlling when the input is sampled.  As this
-		effects data ready triggers, hardware buffers and the sysfs
+		affects data ready triggers, hardware buffers and the sysfs
 		direct access interfaces, it may be found in any of the
-		relevant directories.  If it effects all of the above
+		relevant directories.  If it affects all of the above
 		then it is to be found in the base device directory.
 
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
@@ -1013,7 +1013,7 @@ What:		/sys/.../events/in_activity_running_thresh_falling_en
 KernelVersion:	3.19
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Enables or disables activitity events. Depending on direction
+		Enables or disables activity events. Depending on direction
 		an event is generated when sensor ENTERS or LEAVES a given state.
 
 What:		/sys/.../events/in_activity_still_thresh_rising_value
-- 
2.28.0

