Return-Path: <linux-iio+bounces-19171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BFAA9D66
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 22:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A301A810DB
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554FD26FA76;
	Mon,  5 May 2025 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="jQvavoer"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D671C861D;
	Mon,  5 May 2025 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477675; cv=none; b=urM1egfPagXBXzbGQqSAH+fgC8aKAP3I9HVEKpAUuDehmZM8KJ1ZjVT9kKEmzYConfgj1poIdq6Hj1/9wi3g/rNHgwEunQ7MATsyD7HUZhXzq7PiY4OYBrH4GLjfweR8eiRC8aOfJ58N47yMxEpTC6EacLcE0OwL9CipJ6d2u3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477675; c=relaxed/simple;
	bh=589Hn1DPR3SMZqcj1xdFXKuu2fkuVK1aK4umKujMxbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6cwiWHUt3/zah84HoewRoaQopT4Lv2xlh1nakJZnbLR7DTua1X6YA6UiHUtug7gmD5NbgPt03bvIEvOKBlsZovJyJnzkGQiCbPzqER0aUPI9LYoZ91Yvc14QLBURW3yEqrr0bmqAjHA9GWU573zwZRlStru/hLfXZJ6jvG5sxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=jQvavoer; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RLLmBY44/y5KBdQ1WbhdNwP7F87SY18V5DdwbRBE1/s=; b=jQvavoercZhQcDAvMyi74bxNIB
	jh0wpTF/ZQxv32KguxpLWNWmByiii4mRW0JK7d7ZxZVGNghbYVxOBTcNFq9KYL64hb+uilA5VQWAB
	pOeXdDOyCGvYtQv0YOxEgppPbGLkFfx/y8GGiR3yqsMgrVql6Czls7NZVT9hLjXJsj7X0vT6Acz9F
	YqKDtI7Fxhxvq4EmxYyhh7D1gOIjf6VRhnPBCjE0Fnzatj/XRIIf/Jg+Xyh50Y6d90oqLMOjHSoh3
	5IsoUB5EzuwdwkMukwjH2AZAzIN6m4wG2/6rHpyefgZrpWZp2QSN5bt24u6X6OexsaYtJ8MoRvWPX
	RxAx2f4w==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1uC2Ma-000DpQ-2z;
	Mon, 05 May 2025 22:24:32 +0200
Received: from [31.220.118.240] (helo=anderl.fritz.box)
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1uC2MZ-0007So-22;
	Mon, 05 May 2025 22:24:32 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Andreas Klinger <ak@it-klinger.de>,
	lars@metafoo.de,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	andriy.shevchenko@linux.intel.com,
	muditsharma.info@gmail.com,
	perdaniel.olsson@axis.com,
	emil.gedenryd@axis.com,
	mgonellabolduc@dimonoff.com,
	arthur.becker@sentec.com,
	clamor95@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINER: add maintainer for veml6046x00
Date: Mon,  5 May 2025 22:23:13 +0200
Message-Id: <20250505202313.205522-4-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505202313.205522-1-ak@it-klinger.de>
References: <20250505202313.205522-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27629/Mon May  5 10:35:28 2025)

Add maintainer for Vishay veml6046x00 RGBIR color sensor driver and dt
binding.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69511c3b2b76..297c01e2357f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25800,6 +25800,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml6030.c
 
+VISHAY VEML6046X00 RGBIR COLOR SENSOR DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
+F:	drivers/iio/light/veml6046x00.c
+
 VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
-- 
2.39.5


