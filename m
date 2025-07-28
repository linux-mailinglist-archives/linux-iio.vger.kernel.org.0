Return-Path: <linux-iio+bounces-22088-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9CB135F5
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 09:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0A8178B64
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CE233721;
	Mon, 28 Jul 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b="SiTiyCUI"
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB1223DF9;
	Mon, 28 Jul 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689329; cv=none; b=Bmp8QEs1AdFAikldK2jf8AgIGp/1En4ZdaH6ZZ6x3dc8748fthUgKFjGnwz6mh5oVqJZNnL527e/MRaOs4JhzBG4XLAt5JVIu3paJJVVav/qyNYR/UzU29iKYpYbeQ/vNBIOEjtQIuwoSwW03m9wpoWs9mqmqiy2gWbdl3HDqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689329; c=relaxed/simple;
	bh=qOedZv7756/fVVd5cPJtxxIJU+1REqIcJB4kfq+mB7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6IsHkiXDWvBKsWKeC5irh3LcGC+/ut9D3+lSqnOIb7WxLw58+hZdhXz0da0Yl9j44RhB/YIBHBOZh1NIGpdiWgTW8Qzp62GUwUCTV6k1PWMPJYo1ZRF8GmcIwJrmfUFg492HjOJ0yL5kB7BtThUk6JqVfYZim7/uViYv3JGWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; dkim=pass (2048-bit key) header.d=it-klinger.de header.i=@it-klinger.de header.b=SiTiyCUI; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=it-klinger.de; s=default2502; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cNybS8mn+hrVW7tJqT823GFnF+wuyNe0y7fZM7Cs0D4=; b=SiTiyCUIxuayZfEoAhfV5gm3le
	m3Y+UntLhU4z3Rf8wGXYXberBhLIDxaFAiKTVdZIZr99xCcbxAvzYZSbC+VRSgzOk1a9YkUGVyAAC
	0mwbyOQK+XfhMzrLw8L1+nBxxb6uFjkJpxadmjp9xnIpeAioUQE6c8GgafQz91TyaUc9CLsBHBdu6
	XwAZLrSyd/totYJkgXwRuW53Y6YJOdYO6P+o32WQe6W0YP8BqRRF/gwFJ+LRR+u4n1tH5w9nKmxC+
	F7GiqUBr4GJx7w5wvIVVeN9uTi5r8xmYbJYAEBhKc/MWnS4RAeNsk16LwTG6OP0YuosGXyUoWtWc4
	xxJnnVAA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1ugIhe-0004YW-08;
	Mon, 28 Jul 2025 09:55:22 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1ugIhd-0006b7-1t;
	Mon, 28 Jul 2025 09:55:21 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: lars@metafoo.de,
	javier.carrasco.cruz@gmail.com,
	mazziesaccount@gmail.com,
	andriy.shevchenko@linux.intel.com,
	arthur.becker@sentec.com,
	perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com,
	muditsharma.info@gmail.com,
	clamor95@gmail.com,
	emil.gedenryd@axis.com,
	ak@it-klinger.de,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] MAINTAINER: add maintainer for veml6046x00
Date: Mon, 28 Jul 2025 09:54:46 +0200
Message-Id: <20250728075447.338725-4-ak@it-klinger.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728075447.338725-1-ak@it-klinger.de>
References: <20250728075447.338725-1-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27712/Sun Jul 27 10:35:17 2025)

Add maintainer for Vishay veml6046x00 RGBIR color sensor driver and dt
binding.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fad6cb025a19..d38e92d5229d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26424,6 +26424,12 @@ S:	Maintained
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


