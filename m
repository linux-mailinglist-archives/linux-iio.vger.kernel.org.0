Return-Path: <linux-iio+bounces-7615-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12368930B5C
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 21:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290482817FD
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF913C809;
	Sun, 14 Jul 2024 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dHNtBbIk"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E48528F;
	Sun, 14 Jul 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720985862; cv=none; b=sS5UQzw01zwqdfTpVplwA6+S1vtE5l97/X22kHtupL8D2sFZku933j5tNsN0Tme67ATS4VLKTdrU1sccy5e09JtYCEcqf0Lw5HMoAM1OZHgomQc1UoTcDlB9uMdAJbf62Rfy+GFR6er7hBwHxxYsPVaOUDs9Ffrd6CZZzEwcdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720985862; c=relaxed/simple;
	bh=4YxiUJOMhtBJ05JJQe+Rd3u0p97d9S9/2Q9OVkKia3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OKIoILsDjXtUfjsXUKVJP3K8y30xm1KJgQt2Gc7//D10ZNhjfNSeHqLgp4uBnYXsIhaREaHQF76OfmxofwIuVXN9hTiikxE5c9cply+IidbPt2i0z8pyqs3u8bg9DtK2mfRF+Xytz6v0nlIIQaGsiyfy8mfcztIB0jCxJnwO2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dHNtBbIk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720985853;
	bh=4YxiUJOMhtBJ05JJQe+Rd3u0p97d9S9/2Q9OVkKia3w=;
	h=From:To:Cc:Subject:Date:From;
	b=dHNtBbIkwUxlvqu+GGZHlNV7jEqFZXDNcfKEkl8NVHqBwrTMQ9Vjlsw2pXBegtc4+
	 3owoP7Oxvc9fFAgMQMG2twA5vZ419j3ha799E03IP/qyB8DrC+9GNfdI6WXLnIrwhj
	 jqTaoSvz0VdU2y/r7fgycm2VyZyjdJwfJdIwnMrqiQ3ds5v/STVwR1FE1QFShlaUOV
	 tUCnLJrm/oGeAwpFemJCA6sSdgSvznTgrHmDTMqf8WvdcvlHuyU3Td5J4cDJ+/ARqP
	 GzDMCoyDU7QN2oyyEAUqNriom5ZzMhalcSSBX9ZWKWnrEI8GfZjo6j2WqFrFitcAoQ
	 fspYlS8olmAlQ==
Received: from shreeya.shreeya (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 93FAB3781188;
	Sun, 14 Jul 2024 19:37:31 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] iio: light: ltrf216a: Document the device name
Date: Mon, 15 Jul 2024 01:07:09 +0530
Message-Id: <20240714193709.543509-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compatible 'ltr,ltrf216a' is used by Valve's Steamdeck device
via the ACPI + PRP0001 mechanism.
Document the device name alognside the compatible.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/iio/light/ltrf216a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index 68dc48420a88..e97ff8f7ecd0 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -528,7 +528,7 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
 
 static const struct of_device_id ltrf216a_of_match[] = {
 	{ .compatible = "liteon,ltrf216a" },
-	{ .compatible = "ltr,ltrf216a" },
+	{ .compatible = "ltr,ltrf216a" }, /* For Valve's Steamdeck device */
 	{}
 };
 MODULE_DEVICE_TABLE(of, ltrf216a_of_match);
-- 
2.39.2


