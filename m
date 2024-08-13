Return-Path: <linux-iio+bounces-8434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9056894FD54
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 07:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C200E1C2252B
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 05:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717B3BBC5;
	Tue, 13 Aug 2024 05:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="VJOuKDzw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1E28E37
	for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527660; cv=none; b=VbBexC7IrDJBOJEvRwaOOd1rESC57oPho8e98jLpN2ExABuoO7QiUCifChubmQOd4avOBLdpKUnzBDzTNgXM1iQ7DdGeX98gbDpl3UDObiB32Xbj+1lAXCFF/bnU4d2LB4MnaFZdMhPumL5RpgAmuako1YYBwihBe8min4u3wcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527660; c=relaxed/simple;
	bh=zFEUd2pMUFqc0l2cFhXTA/vcslU9ZSjDvoVcTnst/r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6GSsHByqHX6JmXEbph3+SX9VfuYunXngKfFJOA4dfMriUfxPxgEcQGOc6FBtsRksS4MGb970e3YhEo04zTy+xLS6EwVY5NX9So8xzRd3jHhA1GU63AOT4UBRGJdJ3J3bKnVKsL7PO0WR+equ5ZuTyCuu04yQijaPPHz3AQgk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=VJOuKDzw; arc=none smtp.client-ip=185.136.65.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024081305405388560a319dc6d81327
        for <linux-iio@vger.kernel.org>;
        Tue, 13 Aug 2024 07:40:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kLxXWKJeSf3UekWLu1x2/pCppvnWMzHoBEKo5ap7lj0=;
 b=VJOuKDzwHufpOhs/aRMbQiN8gZR0YU0laF/YR7TdwxfUUdgGe3o8dHTz+s3kZ6TB9MgeeU
 IOFsx6YONsblRcuphd32QIIoOR8jJeU3Dd3SI2gPXT3+oWgQCMvT+IC10tIb3JGRdfQNiv8F
 VLI7jdPcMRBgmDznhM1hW6Ch1Ek6po9SJCOX7IlIa43QfKLWED5ubbayg8JlNgo0J2xaIrYT
 AvZa1YGq5vIFgyyFDF8riHeCmUTVuNIVfU6PlDTTHvtJjB95wXEt3bJ30W7AHzJd613B2fww
 ADz9XWVuF7nBHcIitslUM9oyA0K3zmQjzFtQvY+1Wk0LEpf38lIXn2UA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add EVERLIGHT
Date: Tue, 13 Aug 2024 07:40:40 +0200
Message-ID: <1c79a109a7e91927a9380d2aee91fae32848d7f7.1723527641.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723527641.git.jan.kiszka@siemens.com>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Baocheng Su <baocheng.su@siemens.com>

Add vendor prefix for EVERLIGHT Electronics Co., Ltd.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc0..1d2bf326fe91 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -486,6 +486,8 @@ patternProperties:
     description: Eukréa Electromatique
   "^everest,.*":
     description: Everest Semiconductor Co. Ltd.
+  "^everlight,.*":
+    description: EVERLIGHT Electronics Co., Ltd.
   "^everspin,.*":
     description: Everspin Technologies, Inc.
   "^evervision,.*":
-- 
2.43.0


