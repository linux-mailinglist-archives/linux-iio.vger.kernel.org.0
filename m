Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73025505E75
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbiDRTYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347676AbiDRTYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:24:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D035862
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA2CDB81060
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1C7C385A1;
        Mon, 18 Apr 2022 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309698;
        bh=DwEYq/7mM8vKR7Riro/yQEtxNUp3+whQUQAx1xp/Xy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvfXLRKaFeKs+4B7mXivDxGytWkHCJSpbDa97+iSpn4iQxgBLrcYPjsJ3tCBrbdOW
         ClOReEKKWCAefqMTjlelm+mj/M9z599IVo3qyME4vS645tZ3Lm4DUlI6PBMNx9z2C0
         VXPlxzMDoJhuCLcLNaEd1CtZkvH50Ti9/T8MzBqXH/NM1tfj1FM/GWvSSXUpQCVcL+
         PnQCwCCFzQUigwu45HkTvg8jnYgMk2parWLczYchjP9j160eKcl1dLTTowAFgrhdax
         cebj4hRN9ZWLsxOuobBcAzO3xRkemUbgD0kdycb2x5l4GcosfpCFZotXrvChKcGmKJ
         IB95cZ2WVV84g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/17] iio: cdc: ad7746: Add device specific ABI documentation.
Date:   Mon, 18 Apr 2022 20:29:05 +0100
Message-Id: <20220418192907.763933-16-jic23@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418192907.763933-1-jic23@kernel.org>
References: <20220418192907.763933-1-jic23@kernel.org>
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
2.35.3

