Return-Path: <linux-iio+bounces-23617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD4B3EED9
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938A01881DB7
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B88334385;
	Mon,  1 Sep 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="2XRtVlFz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED626E6FA;
	Mon,  1 Sep 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756087; cv=none; b=TYSIXjGQba8PrxHVckGKamR09KvM7Z35qvCPjMNv/fWYAUdgJD6MnBOCmnRxk107ETin5aPqpLX/XU/Cw9+swxUwn/ktHvYr52WlzEV7qvqYqO5B2g39MOmbu122RMpCapd/j7wjeAjk+mxk7IreYSkmnyoO4h4XBxPbl9DYcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756087; c=relaxed/simple;
	bh=MD4HCwUvfIvFN3UNE2WLqBZ2S3b0H6JiK7ZpEnzQ2RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXOZhrNNXjV12IbQp/rsaF/w4WpLD33XJLE20PU3cBO1vug2qJLk0TBL1dKzJ2gPVeJtkIfzOGa8WnOJr0gg6pmob2E2QHKRXDKfB8b6eQg89ve+VaXYcoJ1TeAlb7rHxjYUHa2ltgugPALpgkiWz8qz50Lm6+Ur0FBdoEffoMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=2XRtVlFz; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id BDC4E173BF2;
	Mon, 01 Sep 2025 22:47:57 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avicqrcP2k3aEOHhJaiNrVBkKGWsrB69WBiLZbLF7IY=;
	b=2XRtVlFzZ7FuwhCqcD1KJRDm5ckTeAgWiL3/Ts2qejB6t4QX6Nt28i3oQNr44d69+/beVB
	I3KcIkCI+Xgx3l9rRSgEtQMA9sES9ThYx0W9dC7AU0uvcX8ob8oJGqT9RHZ368FRQLGwb0
	Kvl6HYTIz1r6J0DtteiVX6ur/g5z03qpmUnYOYbi9ZIwz5WCDO7vk2rrnFKRX+FVrCCq8v
	S26mo5X6e6iCaF7wpwRD7fEx4mKhYCleIGxAN12NowuY4FncZWAhy8angQ/v+DIdgB8lMV
	C9ehWfEm9zqgJPo7TIeCd2QTtKG4wLqvpIm36gzGzRhJYlLfzhu+CqdqnUkW2w==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 10/10] iio: accel: BMA220 add maintainer
Date: Mon,  1 Sep 2025 22:47:36 +0300
Message-ID: <20250901194742.11599-11-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901194742.11599-1-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer of this driver.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af1c8d2bfb3d..dd94505fb9a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4402,6 +4402,13 @@ F:	include/net/bond*
 F:	include/uapi/linux/if_bonding.h
 F:	tools/testing/selftests/drivers/net/bonding/

+BOSCH SENSORTEC BMA220 ACCELEROMETER IIO DRIVER
+M:	Petre Rodan <petre.rodan@subdimension.ro>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
+F:	drivers/iio/accel/bma220*
+
 BOSCH SENSORTEC BMA400 ACCELEROMETER IIO DRIVER
 M:	Dan Robertson <dan@dlrobertson.com>
 L:	linux-iio@vger.kernel.org
--
2.49.1


