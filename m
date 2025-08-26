Return-Path: <linux-iio+bounces-23272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACE6B34FF6
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 02:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C616A240F51
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD03B72604;
	Tue, 26 Aug 2025 00:10:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB793E47B
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167013; cv=none; b=qCVf9C9jtIpSoVMOH7l2ucSnR6HaM9VKUugbPGBsirb/KPJxzshmdn5sB0VNEuxKA6uXugZyDKUK2926WCMQzVUCaMmZd8YxSqBG64wXSnErit5kWBlxYi3zAB4yQWQBmzo+2Bg5B2xrD9FPjep0CzYHmrqKZ5T7CeudLKtzG4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167013; c=relaxed/simple;
	bh=Hc7VeX3O33EahJN9GMeBmCtHLDZ+kZemn/sSV1xh9+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hACGo48WZoxPJY0cigGlDXA3azQBqRs8vgmAYzWvxiUnVo5s+X88FOdEs0XnBdSyaw99jbdGAOoYcO7hdJ8xqUf2TM/NiQTK8ReO6neOOqKy8Ec/ljmC+q1xAU4+SlCgf8/G8dDTq/jMjwi7abZqRqh01Py3m+iZpY9zKGwf/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
Date: Mon, 25 Aug 2025 20:10:03 -0400
Subject: [PATCH v7 1/5] iio: core: Add IIO_VAL_EMPTY type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-mcp9600-iir-v7-1-2ba676a52589@kernel.org>
References: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
In-Reply-To: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Collins <bcollins@kernel.org>
X-Migadu-Flow: FLOW_OUT

In certain situations it may be necessary to return nothing when reading
an attribute.

For example, when a driver has a filter_type of "none" it should not
print any information for frequency or available frequencies.

Signed-off-by: Ben Collins <bcollins@kernel.org>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 159d6c5ca3cec3f5c37ee9b85ef1681cca36f5c7..e4ff5b940223ab58bf61b394cc9357cd3674cfda 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -702,6 +702,7 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
 	case IIO_VAL_INT_64:
 		tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
 		return sysfs_emit_at(buf, offset, "%lld", tmp2);
+	case IIO_VAL_EMPTY:
 	default:
 		return 0;
 	}
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index ad2761efcc8315e1f9907d2a7159447fb463333e..261745c2d94e582bcca1a2abb297436e8314c930 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -32,6 +32,7 @@ enum iio_event_info {
 #define IIO_VAL_FRACTIONAL 10
 #define IIO_VAL_FRACTIONAL_LOG2 11
 #define IIO_VAL_CHAR 12
+#define IIO_VAL_EMPTY 13
 
 enum iio_available_type {
 	IIO_AVAIL_LIST,

-- 
2.39.5


