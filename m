Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A148A550C9B
	for <lists+linux-iio@lfdr.de>; Sun, 19 Jun 2022 20:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiFSS72 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 14:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiFSS66 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 14:58:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB7BC91
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 11:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B918D61133
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 18:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37511C3411D;
        Sun, 19 Jun 2022 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655665136;
        bh=pSqXL8PdYNWK6nFsXVudQguFqpg6OcFHYHNso3v8vbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hH8AYXkPDbG4+5LKzPazXLGuj86IB2D96bTnPO/WPCzqbVGaIzWtsCKxcnELrMRnT
         Nw8Hsa7LR/oGPAC/Wfpg8+bSmWRvs+1tPCxmgazy5+Q0qsYiNcVWentN7DFDOTa76C
         6AiH4Lr0bzvhMTUVKXoJSr+jNutOYcOmFnoLkaeEQgX+PqV1G/DS1FsD8roMtOPzlE
         UpyMZio9OWPfdPeDciurIbe05Ocv+S6s3Pe8oXi6XT1SdYMDYbojqzT262fOIQUpLF
         +6wPvfonnzvO4q/XQDhDC7eG6MQyYgeQUI8fg3Us4DsOmiz2Jjt+YftN4U+rTQURjr
         p0rnTUqo/yVmw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 01/17] iio: core: Increase precision of IIO_VAL_FRACTIONAL_LOG2 when possible
Date:   Sun, 19 Jun 2022 19:58:23 +0100
Message-Id: <20220619185839.1363503-2-jic23@kernel.org>
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

With some high resolution sensors such as the ad7746 the
build up of error when multiplying the _raw and _scale
values together can be significant.  Reduce this affect by
providing additional resolution in both calculation and
formatting of result. If overflow would occur with a 1e12
multiplier, fall back to the 1e9 used before this patch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index dc3e1cb9bfbd..6b401f63805f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -674,14 +674,28 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
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

