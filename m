Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EB55B2F6
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 18:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiFZQpz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 12:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiFZQpx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 12:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B716BE01E
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 09:45:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 537BA60C4E
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 16:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3B4C385A2;
        Sun, 26 Jun 2022 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656261951;
        bh=R8u/rHNKgyxdVEdWnyXjIbILPZqGYc/sVTmiNosoNsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcrgYBYLxZXtOXlD/DyfHNjsM5Dq3Yvtf0SLHBkA8HrP41HMrbbwB3jPg4jiT/fa4
         2cvsb1QYl6q/dWKHLqs0A+Rih/IT42AYLhd7aUZkl7ohxEYgrp0wKe6D0q6vquVcK+
         O8DxvJ2/fPGcDFUqy74Qo63vObkFMrCPPNuSEau/BHBH4pU9/jpEBITdWxjtjVppuj
         r/qTZIrWNardJBQLZ91YSHQTCZoeAum6kSEGHjnHgoDLOh18TLwtIiENhgH3g7Ggqx
         IJmSFjegdxDPqFJDIxee5aznEj/OStS/c1msukpfIyMksMy7iw9prDlz+iAnp5ZcXD
         BtIAVUyRrfY4g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 3/4] iio: ABI: stm32-timer-trigger: Fuse unusual ABI into main doc.
Date:   Sun, 26 Jun 2022 17:55:10 +0100
Message-Id: <20220626165511.602202-4-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626165511.602202-1-jic23@kernel.org>
References: <20220626165511.602202-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

We can't duplicate the description of sampling_frequency. This device
has some unusual requirements which we solved by giving a
sampling_frequency of 0 special meaning. As such add a note
about this unusual usage to the main documentation.

Whilst I don't particularly like this resolution, it is the best
I could come up with given earlier discussion on this topic.

Link: https://lore.kernel.org/linux-iio/20210315101217.00002c50@Huawei.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 Documentation/ABI/testing/sysfs-bus-iio             | 3 +++
 Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 | 8 --------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 3e00d7f7ee22..e81ba6f5e1c8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -107,6 +107,9 @@ Description:
 		relevant directories.  If it affects all of the above
 		then it is to be found in the base device directory.
 
+		The stm32-timer-trigger has the additional characteristic that
+		a sampling_frequency of 0 is defined to stop sampling.
+
 What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_sampling_frequency_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_sampling_frequency_available
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
index c4a4497c249a..05074c4a65e2 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
+++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
@@ -90,14 +90,6 @@ Description:
 		Reading returns the current master modes.
 		Writing set the master mode
 
-What:		/sys/bus/iio/devices/triggerX/sampling_frequency
-KernelVersion:	4.11
-Contact:	benjamin.gaignard@st.com
-Description:
-		Reading returns the current sampling frequency.
-		Writing an value different of 0 set and start sampling.
-		Writing 0 stop sampling.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_count0_preset
 KernelVersion:	4.12
 Contact:	benjamin.gaignard@st.com
-- 
2.36.1

