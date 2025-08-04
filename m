Return-Path: <linux-iio+bounces-22265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED1B19F3D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA182189CC71
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B62494F0;
	Mon,  4 Aug 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b5SnxmuE"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2E24677F;
	Mon,  4 Aug 2025 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301788; cv=none; b=TyV0QnESqO0/TQiQvvaEjl/FHRuC7Kfvm3xcSAduVxbmI22deVE2o6NPjI9WOxdloaUnR2VQ14rYg3PwtDhUh0NkIq849lc/IT60DzvVZ0eFUKSzgzYpas23bTfxnzCem7NhipLHGQ4/5+AbQ0wFHPSq1WQZzUngd1BBuTdlT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301788; c=relaxed/simple;
	bh=jytvHH7pK4odHqJphfEsoL0awbTySk4LSYxI1IQpDEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh6SPCDl+GnZ8C6axbLW+M1Z5a8Lg++QTkApxVsW2CUb/0xlovCARc7itZCIDd3jvzRiCkhTbZHMA7Dc0BQRcJ1wJdtFnvzUjYGEXRnutk+T4Arnz+adk2F+WeYt8yLJzMWzZEqkrtkVjPC1IuocfQlVcLTGGHHiS9la+/NqZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b5SnxmuE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754301788; x=1785837788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jytvHH7pK4odHqJphfEsoL0awbTySk4LSYxI1IQpDEg=;
  b=b5SnxmuEIvPCcof+XL1MvtdSWsPTmlGxZk/mnhDM+0xFGhDosorUlVAZ
   gMusk/vN15IUkqqZyB78OQ/hVX9r0h/TsNw1ebCMdswIerlY3MD3BLPie
   Sg//xECGRi1rm8bcYc7/APMAGo4F+jIJmd8OSsWLQ666yc0vTfMIbOz0q
   dBCYUcDa8VCOADut3XmiSutJ/tLFW/s1GmP74CbGBBuRLB2uYzqfRYdoa
   pOpLujAZk7vY/9wewsFgOS0fPjyVHA1Ap0bHHj4cLSpx4eTU6hqSvXVHl
   nv7Sj2to7Wjpdrmslpi6nP/pOxjyidI9ZOrB0ZnGzX7F6AZsde45Q2ZXN
   w==;
X-CSE-ConnectionGUID: GJeNwV3dT46CHM5uTLCa7g==
X-CSE-MsgGUID: 0WIZkIRqSsCoCqFafFaFwQ==
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="276166362"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2025 03:03:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 4 Aug 2025 03:02:34 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 4 Aug 2025 03:02:28 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH 01/15] ARM: dts: microchip: sama7d65: add cpu opps
Date: Mon, 4 Aug 2025 15:32:05 +0530
Message-ID: <20250804100219.63325-2-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804100219.63325-1-varshini.rajendran@microchip.com>
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add CPU OPPs table for SAMA7D65.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index d08d773b1cc5..2e20a7532c03 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -32,6 +32,42 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			clocks = <&pmc PMC_TYPE_CORE PMC_CPUPLL>;
 			clock-names = "cpu";
+			operating-points-v2 = <&cpu_opp_table>;
+		};
+	};
+
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-90000000 {
+			opp-hz = /bits/ 64 <90000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+			opp-suspend;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1150000 1125000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-1000000002 {
+			opp-hz = /bits/ 64 <1000000002>;
+			opp-microvolt = <1250000 1225000 1300000>;
+			clock-latency-ns = <320000>;
 		};
 	};
 
-- 
2.34.1


