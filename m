Return-Path: <linux-iio+bounces-7337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC47928578
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 11:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB1E1F22B8E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 09:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B3146A9B;
	Fri,  5 Jul 2024 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="eog9TsOq"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A8146015;
	Fri,  5 Jul 2024 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173068; cv=none; b=kAdrvi5sBaRuZVW0ffGRIvg7ec07tnlsoQ3eOv9wxsUokS9GFbeSlUvPtkAYlYl/v8SqpezlQjTqUGYidxZaERBGb8OxWzYHFPeApzeBNv90o5bCZicsoOe3OkQK8m3TRMpwBE/UTqRxiiTSIGHHISqu99YvtJVKs82ZPpfv0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173068; c=relaxed/simple;
	bh=sXd368oAAwWq4VK0mGuPO3OdSq/Yp60ZT2fpecwd7qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxPlnlOJ0ApKxKhYgL6W88Lld17RlF9PDYAcueHKnhF1eW71MCClocMXh6CvRRI5U//+rp+7CJnhZDrZwW4s/SGhz8YEK0AZzkyaE7+KGdLRQFEVdPh3B/zHFIEmo0n/uGTJp/Haxsqp0jX1NBaOVqtnQNQ0f9v2/oQm1yr+8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=eog9TsOq; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B147D882F0;
	Fri,  5 Jul 2024 11:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720173063;
	bh=96I37y7l6BCzp899YSBCDVRbsoRH4E+fgJrQ/eLsQVg=;
	h=From:To:Cc:Subject:Date:From;
	b=eog9TsOq9oh+2k5GS+ci3AHhzM1vJ4PExhBE0FZQYxZe7nA26v1cNgdnX+PTJ2dmQ
	 EuWVKeQ0CWWJGSY48aYQKloplGBmDjmZGtPSP/yPqwgvPZiDgg5bY7JrPtcg6x6a2q
	 X52d1FM2tUbAoyQymu0QBaDxx20OM/VL8k+KlvdOyuNpBiZ6+Iric+XPdvRjxtSeXP
	 5Gg5ijW5OQsykU5OW8ACq5UBZ9PXwxz5quvlX6oeiHe+QK9r+fOmqGd93nvkvrAQN+
	 Ftw7KIc1QXfUVCWr2rC6eDoxpWKOP6xPtBZ/JZ32MovYRcYRnq+Fa+o24QY2E+9agL
	 deanRyS7hiiAw==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	devicetree@vger.kernel.org
Subject: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a compatible string
Date: Fri,  5 Jul 2024 11:50:28 +0200
Message-ID: <20240705095047.90558-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The "ltr,ltrf216a" compatible string is not documented in DT binding
document, remove it.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Shreeya Patel <shreeya.patel@collabora.com>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/light/ltrf216a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
index 68dc48420a886..78fc910fcb18c 100644
--- a/drivers/iio/light/ltrf216a.c
+++ b/drivers/iio/light/ltrf216a.c
@@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
 
 static const struct of_device_id ltrf216a_of_match[] = {
 	{ .compatible = "liteon,ltrf216a" },
-	{ .compatible = "ltr,ltrf216a" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ltrf216a_of_match);
-- 
2.43.0


