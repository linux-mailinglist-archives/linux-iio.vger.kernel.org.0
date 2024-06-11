Return-Path: <linux-iio+bounces-6175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45589040E3
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 18:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1561F23C6E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 16:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CCB3A1DB;
	Tue, 11 Jun 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EV5spNM4"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B362C694;
	Tue, 11 Jun 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122142; cv=none; b=FxYIdsXCMj6CrSRcQ3jXAAQtkBpissrKdH/iAuWLFaNPAMF8qCZiL8sHuWPo0e0pWFMgVVMK59K8kkOQedsLAKlLeaOcmtuvqDyOQl/NGSjaprswfRKmlGKpv+MdCpGHRLTy5yYrAW5Si8n9MXUsTd+FGiSUQASes9L/T1mMBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122142; c=relaxed/simple;
	bh=0AAToXA8gAd2fVKluKS0f3RXu7oL/DA1sg6/cvjA2oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjBi3HixSFjytAn7xxUR1hqGuoLXCIbRFPmWCIycVZXRBEYtzDQOaycG4YzVIQKG09ZsiZhnbRSnpzaYiKJqrLb3642QOnnegN+4+JAHh1A2VSX9qfM5lI8PSG3nP/LdbZQrMrAOa4cC8QrWIABDM9X6LEuMq4WlfZ7eLltEs28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EV5spNM4; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1718122138; bh=0AAToXA8gAd2fVKluKS0f3RXu7oL/DA1sg6/cvjA2oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EV5spNM4+kIQhUhZRglFKWoB/AeY304060Sx0g8feswPAdkFeUug1pbO/Qr6hZCxp
	 alcz9KMPjZMFpNcLakgckEHzr/U38HgdgrRHq/RdVWvLXWVTb1E69ATbqRNOpFeinQ
	 sCF4amoTEBNzFA9+xeiiIHw0YP07ActmbK2oozuvrJQ78egvZPLdIyYjDM5YulzCSy
	 R7turl3DuRKD4G7htQYgJmHEyao29GvtsZVeSiIusVaZDkM4rWUyFuRffGxICmeQj1
	 jrRCYgXOUph3Hj0yB4+BsGEF/ApOYN/7yF11kBWkYn/+cnFCSFY4HR6Wgo4SklNEot
	 eLH/Ydaon5IFg==
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	denis.ciocca@st.com
Cc: devicetree@vger.kernel.org,
	linus.walleij@linaro.org,
	robh+dt@kernel.org,
	kauschluss@disroot.org
Subject: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12 accelerometer
Date: Tue, 11 Jun 2024 21:35:53 +0530
Message-ID: <20240611160821.13941-2-kauschluss@disroot.org>
In-Reply-To: <20240611160821.13941-1-kauschluss@disroot.org>
References: <20240611160821.13941-1-kauschluss@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for LIS2DS12 accelerometer by STMicroelectronics.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index fff7e3d83a02..71c1ee33a393 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -26,6 +26,7 @@ properties:
           - st,lis2dw12
           - st,lis2hh12
           - st,lis2dh12-accel
+          - st,lis2ds12
           - st,lis302dl
           - st,lis331dl-accel
           - st,lis331dlh-accel
-- 
2.45.1


