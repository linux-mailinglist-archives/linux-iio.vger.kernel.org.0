Return-Path: <linux-iio+bounces-8424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A248D94F124
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 17:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8501F22895
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C94818628F;
	Mon, 12 Aug 2024 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eImntX/0"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD41DA26;
	Mon, 12 Aug 2024 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474874; cv=none; b=YD2Dru6v5XC1SjySs68vTeV8OqNfYgC25T4tZfvSxqoydWOZz/jJcl2Mg791j5axgrnYDEK82om2EiDI2kW+Ip5veBjCdYVozZCQh1dO9xjcpPamW6JYKo1E0hDaa9YQn2uMPOnEdVrgDXylaoX/hTCK2/JsNx6DJlaIS+ghU+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474874; c=relaxed/simple;
	bh=VyonfWlsq1MTm3DXqgxcfIvMNB6opcaxx6uq4IMKHsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDsw45P+2jXZ7t1xxNn/lFmk/ZFOw10FC0caWzTr50LFje/94Q9rSz6rB51lhKQGwMZmooQCCmbDjx5fqi2xlFli2/tjOgZhbakEEsku2LfpOZNJ0C4LR0niLrXX672LwNvPt0PJRD4ypkRYgjD+JD+L23ygmQvijAWIRobr4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eImntX/0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E5E8FF807;
	Mon, 12 Aug 2024 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723474869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcnVQb/yrvDYJxCY7i392OtDZOwd6IXmcourEZmhOEM=;
	b=eImntX/09QmFtD+KwtwW/PiFL8FBHh8x6fardUgTSBSQGvgkcg0mvGZwiWIZ7w/PQcZb1g
	Kvr+ighKlHbB1U2hXlYFC8aTluW8ysYaUIkSprsQvq0/wHQccQh+yxHuTTBj0TnVk6YouR
	DV1HcDXkm5SHm5Bj6+wGIXajsYOODy2NY1tM1/ZaOknCQYciTuP5Xzuz/s8L7RFn0KtTL/
	PknVlgJ6TlyNAySg2HUSu4lfucNRkB6uu7CJCPTeTkeH2McnLmDlfISi1jw09O6xZya0Ua
	vMzEY8bvYHzkR0SA1cFR3snY1zkepdzuKdd+qPiE1Or7MvwwU/GphKMupT/8xA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Mon, 12 Aug 2024 17:00:57 +0200
Subject: [PATCH v4 3/3] riscv: dts: sophgo: Add SARADC description for
 Sophgo CV18XX
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-sg2002-adc-v4-3-599bdb67592f@bootlin.com>
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
In-Reply-To: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@outlook.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.bonnefille@bootlin.com

Adds SARADC nodes for the common Successive Approximation Analog to
Digital Converter used in Sophgo CV18xx series SoC.
This patch adds two nodes for the two controllers the board, one in
the Active domain and the other in the No-Die domain.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae470f..71a2618852fa 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -133,6 +133,26 @@ portd: gpio-controller@0 {
 			};
 		};
 
+		saradc: adc@30f0000 {
+			compatible = "sophgo,cv1800b-saradc";
+			reg = <0x030f0000 0x1000>;
+			clocks = <&clk CLK_SARADC>;
+			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			channel@0 {
+				reg = <0>;
+			};
+			channel@1 {
+				reg = <1>;
+			};
+			channel@2 {
+				reg = <2>;
+			};
+		};
+
 		i2c0: i2c@4000000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x04000000 0x10000>;

-- 
2.46.0


