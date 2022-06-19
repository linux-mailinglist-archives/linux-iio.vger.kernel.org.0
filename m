Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9EC550CA7
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiFSS7h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiFSS7g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:59:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF118BC8E
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 944EBB80D8B
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4275EC3411D;
        Sun, 19 Jun 2022 18:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665172;
        bh=RAHg7E+KBH2okpS3ttzmwcOwPAvuXdlx2KK36QO/YGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EIBVv7yP73hVgmMlXI7qEFitlVZmAmodu8g9P9hiA3oq2opwDZLl6BQsAgoWdVetD
         kWJOG8A24VMfpid5N2slp6ip/PKDxezz6LcEkPnWwz25ma1aoL+bMoSmuArgtEclFn
         ynWNflTQSUvLwUSVPjrtYeqR4yy0G6EQZiUFp9AhzHIJ7Zuia2LNWOFOVSmOtVYi0e
         Y+qUXlEtCujD511oRhSRajagEu7ex9Ul3BR27q06tLJt1Ikt0nFHv0T3xs5f28v3Sk
         EZHYii9rEU6IEDfpkO3GwUawa4vSABvqMM+yTEbogeEzxNfnuPEj2EA78JmIkjm7XR
         wLDJuQtEwyH8g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 15/17] iio: cdc: ad7746: Add device specific ABI documentation.
Date:   Sun, 19 Jun 2022 19:58:37 +0100
Message-Id: <20220619185839.1363503-16-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220619185839.1363503-1-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

