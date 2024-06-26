Return-Path: <linux-iio+bounces-6958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB9918359
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86347285DD0
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D3D1836F2;
	Wed, 26 Jun 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="YNQaqc8T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840B181317
	for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409963; cv=none; b=L4oJTrgltdr2fZyG4DtPyzVQOTs+an20JKMbMfVkVlqhslNaPeT8E3JtXXD2NYTT519pZRemQaTYy8PsVBKj49eJLKp0hMLdnLvbPbTbsUnPtbU3FAi+ilEy3BQip/K1Qtyv1KSI31jw+w1On28oB/xV1dAjD6P/kgD2JpNNHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409963; c=relaxed/simple;
	bh=UWuxARd963PTRuc1dV8trvcvv+pfkuk1MtM25GNikLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lJihSInOrWgnfSbUwiHgDSfQNN4dfGbUXR29njXbLYfKsqsMmEXbCCDaJ1qXqouwd6LUBBjXGML5x0QW2/A8wqfb8/79ZQ+HEl5RBEYqofdqaansTFisFqj5Yp6WniOwjtoTQkbLK88B+apiWlLT/rCYQqe4VNu+OBkMX7YNvu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=YNQaqc8T; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa1a542466so5696575ad.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2024 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1719409961; x=1720014761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iazP3yI5m3l9lJVwFwixRYPwhKO1w0d0YUzUh64kBe8=;
        b=YNQaqc8T8DDdKKoLI2yVfea80LUaKRtLLGee1CXoawbvnIRzxP9s7Rx+h86ybnmbq7
         rSI47vxdW0BrWm1tJB/nNQfgrDTpk7lDN07CqQZoTM69bfspNH9oF9g19dSDO7LbMILt
         YlSrasYme7rZ9LOgamIbNF7ys6E3Ct/+oBOOUk1d/1hjH3S/P766sqbE8Dvv1edYIh1j
         eS8lYn1hWXQtLDW9jf1mChwIn89DhKbvyJObv3Brvac1ZhXrsf8Y70olGhJd0iPPLLHA
         s9z4UURI+CPXY+KXbW1v9frPux6y/cdZ1oVrchlGkKaQ4y1anZMHPxGOaVAr2pFXc9iQ
         eLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409961; x=1720014761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iazP3yI5m3l9lJVwFwixRYPwhKO1w0d0YUzUh64kBe8=;
        b=SjiO+5jBN/U+o8IMVIMKXuWzdL/t655to1G6MkZPiIMuDrl8mJ6CQhlzsCfXD5IgXU
         4jK+c61gtuZ8iZkyHjqKwde68ryBuC7mUnXIvuDTOH6oHJjNTSUvag6aBJ2gfXEuU0UT
         kYApdA9fKYwkDxExEa+Y7oS6LKXTMCW+cgw9zWQxE0a5aawsJ4Rn6gsj8Q9b073wGDz2
         +GXIP/mc6TPGAWwTLN594bG3znqt7wxKpxhnwQTwrlEHPZFtApAFGHtVLnMFWB+HJehk
         Q28JL45f5ASdCyQdc05ZYvI+ssiWqvfGVI79gl3lDAHWGue8BgIRQhrWwUgFmnpUrl7w
         ATkg==
X-Forwarded-Encrypted: i=1; AJvYcCXfrwA219ToZCiGbXGtOiBvTYhRgqehaSpmF7Oj4xOem2/8NhWxlT+uPDrat/Yn16pixbUZgFordW7YJZl46YUJJ0gz6gCyip1v
X-Gm-Message-State: AOJu0Yxm2vvDzSRZkhX6YqsH5+KiIG5liSJY6jUUnRhvEAswaQ446FnR
	g+jg1epSBJoh5vLxAJyRBsFkwGottCWCn2TgkoV4zIUAwtRfihiE1Hzfx08IACg=
X-Google-Smtp-Source: AGHT+IH3CNjIyClXeBhBIYEQod0tmwp3pXAtZsMXPvN3G1ST+U+6N/EhFhUwyDrDXsZEiJ5m4B+KRQ==
X-Received: by 2002:a17:903:22c6:b0:1fa:918e:eac with SMTP id d9443c01a7336-1fa918e0fe8mr20229275ad.35.1719409961073;
        Wed, 26 Jun 2024 06:52:41 -0700 (PDT)
Received: from localhost.localdomain ([180.150.113.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb2a7csm99231815ad.256.2024.06.26.06.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:52:40 -0700 (PDT)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add AVAGO APDS9306
Date: Wed, 26 Jun 2024 23:22:31 +0930
Message-Id: <20240626135231.8937-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer of APDS9306 ambient light sensor driver.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ca8f35dfe03..ebe19ba2d62f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3521,6 +3521,13 @@ F:	include/linux/cfag12864b.h
 F:	include/uapi/linux/map_to_14segment.h
 F:	include/uapi/linux/map_to_7segment.h
 
+AVAGO APDS9306 AMBIENT LIGHT SENSOR DRIVER
+M:	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+F:	drivers/iio/light/apds9306.c
+
 AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org

base-commit: 55027e689933ba2e64f3d245fb1ff185b3e7fc81
-- 
2.34.1


