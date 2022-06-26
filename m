Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5D55B1E1
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 14:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiFZMU1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jun 2022 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiFZMUZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2022 08:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33229E02C
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 05:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8847E61219
        for <linux-iio@vger.kernel.org>; Sun, 26 Jun 2022 12:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0604C34114;
        Sun, 26 Jun 2022 12:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656246022;
        bh=t7UDbWnHPquhiOglFYsd592JTk5Mv50Vw8rUaSDwT+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfNUj6HcugqpSp3sUQhVJ7zDrvxVRyb585P8UFqcMX4um8Rk/m6VMyUcOhOK3bsTS
         cVEdiR0y96558NBb6oKPuA/Lw0/Oppyenx6i9ZuIkLKP8KpfMBSDevMtL3iZE+tcV8
         kuyrPnCcFWpieUkQ5d7KSp5uneTPLBaHOLBpQFzJDakLYrKAoo6JQF0wdOnzf0aUTA
         W51mKRs5bczaxB2cu9GYZRqbvX0on3p3LLEVDeK2i2D12gkvDuF2f2fxZVgTmerSko
         LDU7X+B5z9C4C7q7S36AG1w+Q9HyK5olxyxmpVEHue3ulslv6tYdN9Lo3beqDLOhkG
         EKpQDZGj26Jmg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 01/17] iio: core: Increase precision of IIO_VAL_FRACTIONAL_LOG2 when possible
Date:   Sun, 26 Jun 2022 13:29:22 +0100
Message-Id: <20220626122938.582107-2-jic23@kernel.org>
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

With some high resolution sensors such as the ad7746 the build up of error
when multiplying the _raw and _scale values together can be significant.
Reduce this affect by providing additional resolution in both calculation
and formatting of result. If overflow would occur with a 1e12 multiplier,
fall back to the 1e9 used before this patch and 9 decimal places.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index dc3e1cb9bfbd..8225d0c43010 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -18,6 +18,7 @@
 #include <linux/poll.h>
 #include <linux/property.h>
 #include <linux/sched.h>
+#include <linux/units.h>
 #include <linux/wait.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
@@ -674,14 +675,28 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 		else
 			return sysfs_emit_at(buf, offset, "%d.%09u", tmp0,
 					     abs(tmp1));
-	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp2 = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
-		tmp0 = (int)div_s64_rem(tmp2, 1000000000LL, &tmp1);
-		if (tmp0 == 0 && tmp2 < 0)
-			return sysfs_emit_at(buf, offset, "-0.%09u", abs(tmp1));
-		else
-			return sysfs_emit_at(buf, offset, "%d.%09u", tmp0,
-					     abs(tmp1));
+	case IIO_VAL_FRACTIONAL_LOG2: {
+		u64 t1, t2, mult;
+		int integer, precision;
+		bool neg = vals[0] < 0;
+
+		if (vals[0] > ULLONG_MAX / PICO) {
+			mult = NANO;
+			precision = 9;
+		} else {
+			mult = PICO;
+			precision = 12;
+		}
+		t1 = shift_right((u64)abs(vals[0]) * mult, vals[1]);
+		integer = (int)div64_u64_rem(t1, mult, &t2);
+		if (integer == 0 && neg)
+			return sysfs_emit_at(buf, offset, "-0.%0*llu",
+					     precision, abs(t2));
+		if (neg)
+			integer *= -1;
+		return sysfs_emit_at(buf, offset, "%d.%0*llu", integer,
+				     precision, abs(t2));
+	}
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
-- 
2.36.1

