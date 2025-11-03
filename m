Return-Path: <linux-iio+bounces-25839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA4C2B292
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 11:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE7EF4F12FE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 10:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750512FFFB8;
	Mon,  3 Nov 2025 10:52:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD32989B5;
	Mon,  3 Nov 2025 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167141; cv=none; b=fsUDAgxj25+pW90/xRUlBLKU8R/99o2ypipHB4q1d22x5NBn3vfjt9sYnfn1HBvR9OV7CQZXiXrpAvipwn6ARpKqrLJEhEZ6NIogjo3L0SdANvZ0v+JBPVMb9W6PhqSwIrmume/tEuHFAfLkSSmmUWYxRIUzvmWBZIDTgnA00Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167141; c=relaxed/simple;
	bh=0c1EsOMFLqpemzC0/3pkGn0Do+Ts2TX4dnKNVVghnt4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BGKhT74VEBLR8P2uTK/sbndBOmTqt3LMsMxQiwo2LQKDbeCuJgIJeyNTNiTirJ+fI//BlLODnb9Pi3Dl3ZAdruHzhSCeddyxUiQ70KZk7QTHDOGn7MdgK0ghrOFR4UEMpS3tjeMeYQynzlRMg7baOQRDZY8wkqDYmHKB6P9va1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 3 Nov
 2025 18:52:17 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 3 Nov 2025 18:52:17 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<billy_tsai@aspeedtech.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: Add AST2700 ADC compatible strings
Date: Mon, 3 Nov 2025 18:52:16 +0800
Message-ID: <20251103105217.1764355-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add the compatible strings "aspeed,ast2700-adc0" and "aspeed,ast2700-adc1"
to the binding for the Aspeed ADC. These new compatibles represent the
ADC instances found on the AST2700 SoC, which are similar to the AST2600
but have their trimming data located at different SCU offset.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
index 5c08d8b6e995..509bfb1007c4 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
@@ -29,6 +29,8 @@ properties:
     enum:
       - aspeed,ast2600-adc0
       - aspeed,ast2600-adc1
+      - aspeed,ast2700-adc0
+      - aspeed,ast2700-adc1
     description:
       Their trimming data, which is used to calibrate internal reference volage,
       locates in different address of OTP.
-- 
2.25.1


