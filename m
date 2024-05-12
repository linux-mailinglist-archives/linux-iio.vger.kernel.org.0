Return-Path: <linux-iio+bounces-4992-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75E58C386B
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA50B21532
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212F54F8D;
	Sun, 12 May 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iREMqnlP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17711548EF;
	Sun, 12 May 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547899; cv=none; b=AL7FUL+RnM0vrIvj3x7NQXQd7y+mRiYZdeDTcJLNDLkMA2/UyZ84N0tpGC5MhLtc/0PnORCBR2py97CN+ii9e5kC/xseK6OYlhBzV8cWGItCxP2qJXdkkdvtayXNBIdP6l6/BWB8r9ytR5R4tlNZVNr4iKsWNzeFbt5kyDpIMzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547899; c=relaxed/simple;
	bh=KABWPSbHpvmtKnPg4A93biTrYG88WNcAY9eSzBS5eVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRFSXgEANU6jGx+EqL1tX6qhF1a8bSUo468v21NXJvqlrF8a9teKewrqvRXMlawAV9reezIyV2nlb7C4sSs4rxENYf06WKoHiop4hy9+oiXN40emvlJB2YmCmEO5AN8Ct6M0mg6qoaQPz6P8Wc3RxN/kmlH2v2YDtKp7vnUl/iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iREMqnlP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so2906778a91.3;
        Sun, 12 May 2024 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715547897; x=1716152697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNrdwe3Z9A9HuLWPo/8I49VhiOGouu8gCZqc/WgXHyY=;
        b=iREMqnlPkfDvlXKYVvW1fCebTtiP+tyzR3ZwoTWctPEbSK8ROmS1UnQpfZ5qtoMUnz
         vv0sAl1wth4a66dyBl7EJYdYPuIliLTMOQaBhlNnHAdmED/hWrBxX5IJJxFih3/3NEVi
         J1NU44gciKnb7HQSXBYEbvcz+NVhznHsd34XJoZ/35MFgasr/mxe6vSq6bR8Q5ziK8RX
         ByQYJkMW9u6xrdyPuFg9ePeJTrALnxfSp/2kXeTn+zluu8OvbdjGWt+OuaESOqUBNfw/
         aVLKBtBqedtU+5Uj4gFyXgRggKbDqgiEAp/rlwv7NxRfYOoUf9mAi4Iz3Fs+k2CdZF7z
         9Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715547897; x=1716152697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNrdwe3Z9A9HuLWPo/8I49VhiOGouu8gCZqc/WgXHyY=;
        b=X0SlrX3uTqHLAVG9OFCcjzKClQ+jiocMtfVMTRAegpXHgv6pSxNRBkIrH5fnn/I0cE
         VlmCFAc516bG2LudktSe56BRHKOx8x5XY7aZfkM1plrQli0XbF0sxLlsE/L0fwKvPBjZ
         6qe19K3DNmEmZkYI3NxHzdMew8E9Q2SWRBfMUtk/g/45dPe7X9AKpk4UUZ7UNUdFvjNa
         +9z2sWmErfPCn+ndqDdCUsbjY8dS0SLyyOglZCj0qLl+X0x3fC5ami3tuR3vlC0bBy2+
         F5thLJTEXPW9ZpuJ47Ny+B/w5CDf+2QZIWWJVJEnLP4lOMO8DQWRjkhH6q4Chi5v9i/V
         JzKw==
X-Forwarded-Encrypted: i=1; AJvYcCVjxhIhbWQqDlUEgkNc2fSrvF0u13MQFCbtfzyVvvIMZFW/cCrvzJCXbmhqC4qP2gwDl0LZIkAfhpyNNNKKgYK5WvJY9qNiwpN6hpUC394rRSyrs1MqSe0lwypuuCrEPxu/0Tnw1DOKuIeJGELatfpCX1oF3H5qYqW2/0WIQc9QQD0KAw==
X-Gm-Message-State: AOJu0YwV0/W2K0L7PvXLFsIyZXHlz8jfa7UMTgauI2qJ0y97D2cmpDFe
	H2blOLNhOg3LOcQze/7AWE0RSEwv2c3ty83w4M1ZzqdzzLxjOgl7buzE2YDj1hA=
X-Google-Smtp-Source: AGHT+IEZMUgzGeoGEtkbYCnh7d/Mv0V0MuN+RoMuh9zvhoc3EudJ02fb85SBBA74w+PUSaRmRfYD4A==
X-Received: by 2002:a17:90a:69e4:b0:29b:c2b3:2712 with SMTP id 98e67ed59e1d1-2b6cc97d7a6mr6858657a91.26.1715547897345;
        Sun, 12 May 2024 14:04:57 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a447391sm6534865a12.3.2024.05.12.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 14:04:57 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: vendor-prefixes: add ScioSense
Date: Sun, 12 May 2024 18:04:37 -0300
Message-ID: <20240512210444.30824-2-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512210444.30824-1-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for ScioSense B.V.
https://www.sciosense.com/

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3..298f13a0d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1246,6 +1246,8 @@ patternProperties:
     description: Smart Battery System
   "^schindler,.*":
     description: Schindler
+  "^sciosense,.*":
+    description: ScioSense B.V.
   "^seagate,.*":
     description: Seagate Technology PLC
   "^seeed,.*":
-- 
2.45.0


