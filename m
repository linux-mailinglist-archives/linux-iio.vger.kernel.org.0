Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10853758FA6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jul 2023 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjGSHyF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Jul 2023 03:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjGSHxn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jul 2023 03:53:43 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509151FCB;
        Wed, 19 Jul 2023 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689753222;
  x=1721289222;
  h=references:from:to:cc:subject:in-reply-to:date:
   message-id:mime-version;
  bh=rwAJJHUO0JnZisxLO3+eFKnrpeHeVsnZgdBx2AOpPlA=;
  b=C454Vq2mvtoEcaJTDLue2KJ7yXoSm8duWwR2/BiMXdIsEK7lU5TnocMp
   abPkAjjRUK+X3fsPjd53EOpH7w+43qa1XR8hY7NShu+1YZKLq5EOKWexX
   WLNJhITxq3YCs5/Wfw4t2WyZ7p80WkqwpOATqgZPf/UAGArxm3bfKsRYi
   gZgbmxHsh0Po0W3MDgucjPnr/R6ZhtlyCaoDSMa8fyPwQ2LX657jz0sIw
   owbvBpD4Y3HWv4hpJlFV4krNqLpd8aLsY4UQetHm99VlF+R4cxOUnhIXm
   UeFCtp8s+3D0JgL6EyXyexyyuBx2A7GRBo5eryB1Y8gAqTmx1adu5Dq+b
   g==;
References: <cover.1689753076.git.waqar.hameed@axis.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] iio: Add event enums for running period and count
In-Reply-To: <cover.1689753076.git.waqar.hameed@axis.com>
Date:   Wed, 19 Jul 2023 09:51:17 +0200
Message-ID: <ee4a801ae9b9c4716c7bd23d8f79f232351df8bd.1689753076.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are devices (such as Murata IRS-D200 PIR proximity sensor) that
check the data signal with a running period. I.e. for a specified time,
they count the number of conditions that have occurred, and then signal
if that is more than a specified amount.

`IIO_EV_INFO_PERIOD` resets when the condition no longer is true and is
therefore not suitable for these devices. Add a new `iio_event_info`
`IIO_EV_INFO_RUNNING_PERIOD` that can be used as a running period. Also
add a new `IIO_EV_INFO_RUNNING_COUNT` that can be used to specify the
number of conditions that must occur during this running period.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 16 ++++++++++++++++
 drivers/iio/industrialio-event.c        |  2 ++
 include/linux/iio/types.h               |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 7140e8e7313f..a2854dc9a839 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2163,3 +2163,19 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		An example format is 16-bytes, 2-digits-per-byte, HEX-string
 		representing the sensor unique ID number.
+
+What:		/sys/.../events/in_proximity_thresh_either_runningperiod
+KernelVersion:	6.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A running period of time (in seconds) for which
+		in_proximity_thresh_either_runningcount amount of conditions
+		must occur before an event is generated. If direction is not
+		specified then this period applies to both directions.
+
+What:		/sys/.../events/in_proximity_thresh_either_runningcount
+KernelVersion:	6.6
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Number of conditions that must occur, during a running
+		period, before an event is generated.
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index f77ce49d4c36..19f7a91157ee 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -252,6 +252,8 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_TIMEOUT] = "timeout",
 	[IIO_EV_INFO_RESET_TIMEOUT] = "reset_timeout",
 	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
+	[IIO_EV_INFO_RUNNING_PERIOD] = "runningperiod",
+	[IIO_EV_INFO_RUNNING_COUNT] = "runningcount",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 82faa98c719a..117bde7d6ad7 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -19,6 +19,8 @@ enum iio_event_info {
 	IIO_EV_INFO_TIMEOUT,
 	IIO_EV_INFO_RESET_TIMEOUT,
 	IIO_EV_INFO_TAP2_MIN_DELAY,
+	IIO_EV_INFO_RUNNING_PERIOD,
+	IIO_EV_INFO_RUNNING_COUNT,
 };
 
 #define IIO_VAL_INT 1
-- 
2.30.2

