Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D38505E65
	for <lists+linux-iio@lfdr.de>; Mon, 18 Apr 2022 21:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347651AbiDRTXy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Apr 2022 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347654AbiDRTXx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2022 15:23:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489620F41
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 12:21:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD9EBB8105F
        for <linux-iio@vger.kernel.org>; Mon, 18 Apr 2022 19:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C2DC385A7;
        Mon, 18 Apr 2022 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650309669;
        bh=DjGNohPhHCYecnNxT0akgHQjeQMgRuKqfumJ63YbeHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqWW0nE5h7yOT1oKPm/eRp7RjWiUkLluQkhXiYg/V2u8cQsAh+4EItHxSrR2QssaP
         GgCOMLtHeDGTGguHKCwRZ2nR+kIXAM1/QyCrHdH4S8E5QrkgZZBFEJCnRXoWwkN1Pa
         vl7vG9x39km+2LEIsXDhzh2hays4IqyRCFsS3aiue/oQuiHsGDQGghHlXpd5nZsujW
         Pwuk6q8/blHL9TWEhggT46fXx74xnNm3SxULflmBnDotoUdQ95+Lx9yxv3G5kg1b4F
         2PqcWUNQZDXJ9LtHQP125gDwgyI0sRpbxikdYyW5zvP/dohV1VV2MOAQ70NJCGFn9o
         7SZ07FV1e+7Pw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/17] iio: core: Increase precision of IIO_VAL_FRACTIONAL_LOG2
Date:   Mon, 18 Apr 2022 20:28:51 +0100
Message-Id: <20220418192907.763933-2-jic23@kernel.org>
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

With some high resolution sensors such as the ad7746 the
build up of error when multiplying the _raw and _scale
values together can be significant.  Reduce this affect by
providing additional resolution in both calculation and
formatting of result.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2f48e9a97274..d831835770da 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -683,14 +683,21 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
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
+		u64 t1, t2;
+		int integer;
+		bool neg = vals[0] < 0;
+
+		t1 = shift_right((u64)abs(vals[0]) * 1000000000000ULL, vals[1]);
+		integer = (int)div64_u64_rem(t1, 1000000000000ULL, &t2);
+		if (integer == 0 && neg)
+			return sysfs_emit_at(buf, offset, "-0.%012llu", abs(t2));
+		if (neg)
+			integer *= -1;
+		return sysfs_emit_at(buf, offset, "%d.%012llu", integer,
+				     abs(t2));
+		}
+	}
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
-- 
2.35.3

