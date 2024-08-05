Return-Path: <linux-iio+bounces-8255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B494837C
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 22:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3AA1C2164A
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2024 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26716BE32;
	Mon,  5 Aug 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="oJshHzU1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870E7143C4B;
	Mon,  5 Aug 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889920; cv=none; b=XpMLTeii0jSFOt1jeZcxlpNJEkPz2+ESphn+4dWtxLn/kwm1z4Ul1s+xS0LabG31JA5FaHh8pvQOR/+u5YlL+QeUFVBIAKUGAL9/bu9rZ6YDTUYbUnaR5Bd+UaCSIS5dmdJRNMK5RW27qjsszIwhKZrgnIRmJqXOv+VuR5kamTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889920; c=relaxed/simple;
	bh=+SXTIe3f9S9YtLjpDF3jRC9wGFSwxnS1+ANtFERZKss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKqUoUCXwniM0MWcBiblA+Dr5+gpUA2Hxi2MhQbNCQYqIZbebSih/EOZ9ZsxY82KcBh1aqTu+nSg3ZZCCN3qQcM/IwObPHWkHAiMOMHrTtfRzs6W1BIRbe6haYlZK7W5l/FejwN+TGlVn1qbe849WgL/L9DQrXn7n2R5GW+aRmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=oJshHzU1; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from [192.168.1.90] (86FF4CFD.dsl.pool.telekom.hu [134.255.76.253])
	by mail.mainlining.org (Postfix) with ESMTPSA id E7CD1E4518;
	Mon,  5 Aug 2024 20:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1722889911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jr7SpfDFS9+WtsvUSprOh+Q497G+LRPTnkvvNlcphQ8=;
	b=oJshHzU1v29gG+ZxTKAF91XOkDbV+UXG1M8ZuhKJ0+RFLoeuAxDm9LefFsFglc607EjvYp
	AWVJvDEPOKM4ju3EsUh7LzMkdk2JKgE2t6PeLhG/e3AeRWnsQFpEQMHaGC/PsdQVWLEXBm
	gXncvjuEG0CRTwzFI3f8YCM3BFTyL13lVJkrAnAH8yrQw9aqxIgyPKZYtRH56jJQsydrLy
	3vbWzApZE2/EhdGuJxe7VBmWd294xrzck1/HPHVmQssdbqcP+pRJxSvJe47d7F+yPsd2LW
	TFYOnf4b5xMwZV8a0/EMI0uy/P2ZmvAPRLzMtCIwr9z0fTRWA7J6m181UBGs4A==
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 05 Aug 2024 22:31:43 +0200
Subject: [PATCH 2/3] dt-bindings: iio: imu: magnetometer: Add ak09118
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240805-ak09918-v1-2-70837eebd7d8@mainlining.org>
References: <20240805-ak09918-v1-0-70837eebd7d8@mainlining.org>
In-Reply-To: <20240805-ak09918-v1-0-70837eebd7d8@mainlining.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722889909; l=1027;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=2sJy5WfIbNskIVyW23EqSE1dEhalHShmGhVggS+O8so=;
 b=gpAXqOd+S+IErU4kFNRkQOSSARuxcqd4fxhbl3snMF9m3SOYQO8LXR9BRHKjwyp/tM2s8nWmK
 pO6ZhxynDk3B1jz1zPRnDPlkEenqam0tgFTnQ9RTdCWsbcknAmSdxsh
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

From: Danila Tikhonov <danila@jiaxyga.com>

Document asahi-kasei,ak09918 compatible.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
index 9790f75fc669..67c60abbfcf0 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
@@ -18,12 +18,14 @@ properties:
           - asahi-kasei,ak09911
           - asahi-kasei,ak09912
           - asahi-kasei,ak09916
+          - asahi-kasei,ak09918
       - enum:
           - ak8975
           - ak8963
           - ak09911
           - ak09912
           - ak09916
+          - ak09918
         deprecated: true
 
   reg:

-- 
2.46.0


