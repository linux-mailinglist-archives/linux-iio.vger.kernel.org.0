Return-Path: <linux-iio+bounces-23736-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B73A9B44E4C
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835FE1895429
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB32D2483;
	Fri,  5 Sep 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="QeTu9MFv"
X-Original-To: linux-iio@vger.kernel.org
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859702D0C69;
	Fri,  5 Sep 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055315; cv=none; b=tU2lNU4LvYIprGG8LMtQiNmQb0w+ltwxtB4UQa+Ha1BZyf9Snrl5wZKkMnhoYAciMqWoyiHEXLPxOzeZe2WeYXHm9t3eqhoH6a13ruMlnplLzN5VFviGXK/3zt1As8U73LJCgttkU4xTghRKuLL5YEu5ZbHgEqXMvCrvOSa/o7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055315; c=relaxed/simple;
	bh=x6hRsXvpi3Q1ScsdeGG70+t0NvEUi9+opN62O7IcgWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SclRz+uJgKXtgydkJCyv1kKQrc68GN0kqMpvbzdCZcrnlwovvWWn1awM4HshHkC5QxeVcHQhQCu3xP8ufBQUy28mnrSq/3f7UzmhdiRZL4mCUti+wWzXZi6gU3hGZI7EsXs7fQOzx/mk99ASQgutEjPiSqnS+ug2hfajo8CbmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=QeTu9MFv; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=jMAXIdnYVxleMChf2/qG6/ru4xaGe53QynIZ8eE+vyo=; b=QeTu9MFvsp0wse4ccpInF920ov
	HAPbTbEojWg+k2RpXVWEIAIetG9bJsFU+0D8c0wH+M+IwGYpNlbzUPQehpXL43zRWiXJ4+mLWCljj
	Fl9QzUiPIU3zNYMNC4nb3pJuZ+nEGz9SSAl5RJnJfk3lvDfUg31O84pSo/TSr2Q+Z2BxFCYBHOIq1
	7jxUo5GKEQHa9+fkpCWtPLxngLZ+UuIYTy64s2nH/Tne8Lds3AkIM5RpU6COYWm0qEqTz3DcmQhGN
	MV3VbqXSdCkVasAVtoE1fvVPR7qCDH1MdIcLtWr0SVBcW0YXWhowGGlSE7YJ9lGizwIYQcfZBj4to
	l4jEPMtg==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:37248 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uuQLi-00000004eMg-1RMD;
	Fri, 05 Sep 2025 08:55:05 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 1/2] dt-bindings: iio: afe: current-sense-amplifier: Add io-channel-cells
Date: Fri,  5 Sep 2025 08:55:02 +0200
Message-Id: <20250905065503.3022107-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

The current-sense-amplifier is an IIO provider thus can be referenced by
IIO consumers (via "io-channels" property in consumer device node). Such
provider is required to describe number of cells used in phandle lookup
with "io-channel-cells" property.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:
- refactor commit msg drop warnings introduced by commit #2
- drop Fixes: tag

Link to v1: https://lore.kernel.org/all/20250903113700.3079626-1-primoz.fiser@norik.com/

 .../devicetree/bindings/iio/afe/current-sense-amplifier.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
index 527501c1d695..bcf4ddcfd13b 100644
--- a/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
+++ b/Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
@@ -24,6 +24,9 @@ properties:
     description: |
       Channel node of a voltage io-channel.
 
+  "#io-channel-cells":
+    const: 0
+
   sense-resistor-micro-ohms:
     description: The sense resistance.
 
@@ -46,6 +49,7 @@ examples:
   - |
     sysi {
         compatible = "current-sense-amplifier";
+        #io-channel-cells = <0>;
         io-channels = <&tiadc 0>;
 
         sense-resistor-micro-ohms = <20000>;
-- 
2.34.1


