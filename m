Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3055B1E0
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiFZMVE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiFZMVB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:21:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3320E02C
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E53B61217
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E791FC341CA;
        Sun, 26 Jun 2022 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246058;
        bh=RAHg7E+KBH2okpS3ttzmwcOwPAvuXdlx2KK36QO/YGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRwAYaNduwWP67Y6GxK+o+44n/o+lfvOoAVNY4BwQsPbVdOV1MJHr08BmieRz+1QW
         0uwM6iTPI7k30ARgcxMvkGh2QwIG9JjZoiOg7M3oV4hMX/W9WYf1Uke2no78/rUGo/
         UhtxkzP6Pa1W/jTWLcVJ/apeDM50rHrAWDhXq0tVFwvnu9mhMDsaw1VEOTGlObH/CH
         YmyRP70KaDcDYRq+9i3vakYFpv/Uu2UPmEauY1cJ5ID54ibTTZOUFVV9mFzadNfIBj
         u4Z9VuCR5VK5PsJlCEGQb+a5hqGEqKGtnAQohkc6x6tC5LrkSwUbn26I+3gGlNCnwk
         sY882GCsnMU6g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 15/17] iio: cdc: ad7746: Add device specific ABI documentation.
Date:   Sun, 26 Jun 2022 13:29:36 +0100
Message-Id: <20220626122938.582107-16-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626122938.582107-1-jic23@kernel.org>
References: <20220626122938.582107-1-jic23@kernel.org>
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

The datasheet description of offset calibration is complex, so for that
on just refer the reader to the device datasheet.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746 | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746 b/Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746
new file mode 100644
index 000000000000..6db81725b5d2
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-cdc-ad7746
@@ -0,0 +1,11 @@
+What:		/sys/.../iio:deviceX/in_capacitableY_calibbias_calibration
+What:		/sys/.../iio:deviceX/in_capacitableY_calibscale_calibration
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Write 1 to trigger a calibration of the calibbias or
+		calibscale. For calibscale, a fullscale capacitance should
+		be connected to the capacitance input and a
+		calibscale_calibration then started.  For calibbias see
+		the device datasheet section on "capacitive system offset
+		calibration".
-- 
2.36.1

