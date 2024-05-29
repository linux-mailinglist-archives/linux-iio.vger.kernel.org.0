Return-Path: <linux-iio+bounces-5458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACDB8D3B9A
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 18:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAE6285BDC
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615FB1836D3;
	Wed, 29 May 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gwhAYFx2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A1E137932;
	Wed, 29 May 2024 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998466; cv=none; b=d+EqA8vBjZc4E7ceizCRwmyMDjIOagG0hq5uYTv3SLTeQ4W+wgVF7CPs2527Qkg9kWNnuscbwm3pM3riryBG8M+81XTuGXqefTzEQPRn7gIWdZA+lyX+7HoEWtogOxgIQe6X5882G+Fl6DR54wOA37LtItw+8JYWUzetRvIScKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998466; c=relaxed/simple;
	bh=v6b5lEqbop3TeCHYdro614L2c+/qdsnDGzEng//zdgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpTY5FMfWLg1RkWY9uG3D8SeKvzXoeqGh31uINk6UJP3zl5qBSrcCnpSUTpdXcuAP0sP/F2qqiZB8z7p1KmACPhofGdyLb/pxGfJ863Cw78FHHuWduFS7cPKV9PjPlpkkApJBxHSnCtn42c9wT+xx31YGfA1btaNV/0KF80JyxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gwhAYFx2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=M5Nz3BqUa1y4XSY54BZ8kmjB0E40UEGATmY0vXCaUd4=; b=gwhAYFx2HtC0zsvG
	zs1OW+Q8Ty+uhFuGWN4fdgmh9Fd4MO9ygl2soP+pHZm0QsbxIgIAM68VrLTn7F9UboGGByt65SbBa
	wV7lim44EXgg7QPDnfj5Q9RPrsoGCRTHVo0nuyfTu5x6leCiUeU0IWUZwADXU2lgeSsMgReeT7DPA
	ExEAP9VuMvFudULPnqAfYCZqmjtAZOHG2ntVv7rus9ZDiOA/9lbdQOP5X0pIZnolDoD7jjEc0mUGN
	Ty/yyN098HsZjGkOTPmVqor+SUPP1Ps6jrOA9U0/wXwTFhZ4LduXZwIxiLTG9UFmKmQqKD1ZvADqG
	frpex5zdKMh03uY6YQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sCLjU-003DqX-0B;
	Wed, 29 May 2024 16:00:56 +0000
From: linux@treblig.org
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] staging: iio: adt7316: remove unused struct 'adt7316_limit_regs'
Date: Wed, 29 May 2024 17:00:55 +0100
Message-ID: <20240529160055.28489-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'adt7316_limit_regs' has never been used since the original
commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
driver").

The comment above it is a copy-and-paste from a different struct.

Remove both the struct and the comment.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/staging/iio/addac/adt7316.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 79467f056a05..f4260786d50a 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -209,15 +209,6 @@ struct adt7316_chip_info {
 #define ADT7316_TEMP_AIN_INT_MASK	\
 	(ADT7316_TEMP_INT_MASK)
 
-/*
- * struct adt7316_chip_info - chip specific information
- */
-
-struct adt7316_limit_regs {
-	u16	data_high;
-	u16	data_low;
-};
-
 static ssize_t adt7316_show_enabled(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
-- 
2.45.1


