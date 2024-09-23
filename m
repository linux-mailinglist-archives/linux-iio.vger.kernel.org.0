Return-Path: <linux-iio+bounces-9740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641F097EC24
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 15:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EB81C2113D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD7199392;
	Mon, 23 Sep 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b="QQS27F5e"
X-Original-To: linux-iio@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709519644B;
	Mon, 23 Sep 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097381; cv=pass; b=d3UOfLNcZaVU6YrwLAu+DSvgqO/uopYmhAyxJALumnp0aT48lM0nFtQ5HPhTLRh+SpO8HeVBWqxdOVkuv1UJyAUUKUAX7Nuq/woEsubMJBFwvaVhPv9dx8xj2esVwgtvVpUwUWW1F2x9nGhYc2fAmy/XX4/YoL1IZ4mEUWrZ8Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097381; c=relaxed/simple;
	bh=m2PmP+xxceZxwGVNP6TCQqgIcRXycNi4N+H9QM8j8mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mX7oX1DvNqpLiD22+c7EOcvBi3h0/ApZyh06H7D/gr40tJN8dULZ0w0DjKHllL9s/Clmjy+BIeadC6iOwt6LtJWBk/K88GPN0Jfg8G6rIV5QMC+FUWfYCb183Co1V7EgRQqkFBj+ioA/LO0dIfgtrYG1TR1dkQcm74IvL38SnGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b=QQS27F5e; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727097356; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PjF9wlzWpNZ6wgOlCVh/pllfLyHWXgODapqO2VqF4lguPNvG+HMnLfMvh1fhB2f+Tm8TwLKOvNFzdE1zrooLCaWzK/A1fgY1km0M1sZKpKGQOgvlCr6ClXtzwElbRVLjtXot+nFILsMzG9xsFZ9AAbzTJ7PG2MZfcErpJwwHeHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727097356; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=msYfRs07SsKacfZRa430+XqCSrKfn5G0aPxsNP2/Vmk=; 
	b=SD2kG+hPIWEz52D0tz1v3A797asdpq3Rh0/nsQ9xV6jW0tFCYng52A/R3gGlMCfDh7DbBE49QeJyqbJx4A1hShF/3+ktUKWibrwZOLMcxiXqNQySkt/mQtODc2NFrW3Uzg1hLcOII1PkmKxsNm6tHg196XZaqzf0wR8vz83eAo4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=shreeya.patel@collabora.com;
	dmarc=pass header.from=<shreeya.patel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727097356;
	s=zohomail; d=collabora.com; i=shreeya.patel@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=msYfRs07SsKacfZRa430+XqCSrKfn5G0aPxsNP2/Vmk=;
	b=QQS27F5emJMwCIvWr6MIIDjnjYuZqD2HTUvhwBdjtSRszSnEXLYRRBdShktfvCoc
	EcCOfuEM1KnLspvX3o7rOz71ILEBkqDKu6RUsFungEzxI7Uhr2bhPoBWzSan2z3gUP/
	GYfZ+Bq7MufjzImtqn3HLFUx3JuJs8iHuTU9bQSE=
Received: by mx.zohomail.com with SMTPS id 1727097354412395.9383569758477;
	Mon, 23 Sep 2024 06:15:54 -0700 (PDT)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org,
	marex@denx.de,
	conor+dt@kernel.org,
	kernel@collabora.com,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH] iio: light: ltrf216a: Document device name for compatible
Date: Mon, 23 Sep 2024 18:45:27 +0530
Message-Id: <20240923131527.1408691-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Compatible 'ltr,ltrf216a' is used by Valve's Steamdeck device
via the ACPI + PRP0001 mechanism.
Document this info alongside the compatible.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/iio/light/ltrf216a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index bc8444516689..b1dacb48d610 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -561,6 +561,7 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
 static const struct of_device_id ltrf216a_of_match[] = {
 	{ .compatible = "liteon,ltr308", .data = &ltr308_chip_info },
 	{ .compatible = "liteon,ltrf216a", .data = &ltrf216a_chip_info },
+	/* For Valve's Steamdeck device, an ACPI platform using PRP0001 */
 	{ .compatible = "ltr,ltrf216a", .data = &ltrf216a_chip_info },
 	{}
 };
-- 
2.39.2


