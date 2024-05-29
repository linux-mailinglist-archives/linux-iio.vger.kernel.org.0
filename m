Return-Path: <linux-iio+bounces-5418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F395C8D2960
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 02:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2D51F255B5
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 00:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98673819;
	Wed, 29 May 2024 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8ZBOx/4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDC9171A4;
	Wed, 29 May 2024 00:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941733; cv=none; b=glSZFEyHHarOIMqWJJnBlJIOxQOx9BJzDjHlVK0oon/DrUOj35/ZeZVLyMNCR6brqbt9jamPKWHZ+GL7BaO75yDwsE4J+HbyuBpfiT2cfu5wswvnhWzB70qHpfIjA2xmPmIY+Ov2+IHFLEH832wYajPxcP7w2MCLmQl+cq1GH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941733; c=relaxed/simple;
	bh=Wg/8vm+DezXU+c6hssPffipfbzeswNnGmDjQwfNjP+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H79g2k+g1RR7Xi/Txy/ar8Ar0Qzsx6mlg3Hffy8FyHUFELkVoCkNCA42aDrFEEkykT/MUGV/Rjcb0W0z7iYIb/aBA6QNhClex82NLhR0A4ujSrqjZ99di5aELu6jLfm6BhpZsiR1LWhO9B2yB479hULMaLqAl1VvOmw8RbKgdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8ZBOx/4; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f8edff35a0so1241716b3a.2;
        Tue, 28 May 2024 17:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716941730; x=1717546530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqWVoMsey0TuP/KwPDZYkNElI8gsVjWsVSRftA51+ZA=;
        b=D8ZBOx/4mXoEoHMrndyH0tGzVJwOV3BHFtpeur0qtEkIprrYUWmN1UNGDsmT50M0T5
         /8FrsdLpiV/xtRliL6axg8DmH4DB9TwYeIah3TOQ42IkT8FRKeWSvU50qS0M85M5V2eN
         f8i/5KZP6E/7rT2x3tPUJ+p2rXer9gsuBabghE92eJXzhYy3LiHCke7YgPCAwRn+43e1
         fiZDJq+awQQuWPgs4VN6E5rJaK5yZYG4k4U3PEECgLv8UMgKE6C3ZDt4dOXT6OAAbYSi
         79JFVi5PF4jZxiTxlj9nzaBosNTMLA7/5W144rYlEIey3uVbP4v1IRhTFZNLTj+RQeBS
         CQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716941730; x=1717546530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqWVoMsey0TuP/KwPDZYkNElI8gsVjWsVSRftA51+ZA=;
        b=DuwEWNkYHSikBVfmGR7apXEyBiN0tb+FDxGvzfUJ4U9fZVU84TQjUR2cEywL1eMFjo
         kT4SaZtQoEs3MGd+HJjrNUixUmnw8QI4v8N2Cz+ZHkqdcgvv2/Rj7GatRi+KuRRDUNHD
         D022CFvNJWVrNhRWFzGXIwEiBRHtOlExWLQna4pyBsaSRY+f4f0QvBbeefnzvEO5jU9d
         tiz7RK2e4MnzhYYXnBuRf0Iu1KPajv9HbfkVQBz/sfnwziIib0PjRjjeemdXRyztpTCG
         2FUAknkhzPmltIiA54MhljnTYQnQ/NqVYcT6MOV0fISznIYx+PXr27ap63Mk9AqF7cXW
         2jpw==
X-Forwarded-Encrypted: i=1; AJvYcCVZxuDB+muiZR6TXbYPs+8C0aZfW16S/L/0dWMPqgp1qpt4kZNo+8f2t/eMy93SvXyHZNCLPoXXjBUG0cOF4Ix51B43jWZZnHb1X5GXuxa9gQy+wAlXNOZOEa2OxJPA+Bu7yDHs9sxiWmbNJJPvFQtSFOZcRTE6khaJ0dFiTqxaPS4wVw==
X-Gm-Message-State: AOJu0YxrCmPQi3wQ/yRJCMGKof2t4pydBR/VBLTBq6sonm9RGvG8hc/u
	//monV4vQx2yBiMPtETbcrh2cr1OXVqp1kJZ8NAmpJEwrq8zZCoE
X-Google-Smtp-Source: AGHT+IH08riTKPmXba88vedO7GUJKrcOgqPIfQWtADHwfH4tjSQ30gTwLSx/QgaDgnNSwWy0nSnW8A==
X-Received: by 2002:a05:6a20:3ca2:b0:1b0:19d5:f400 with SMTP id adf61e73a8af0-1b212dd4446mr15556115637.23.1716941730285;
        Tue, 28 May 2024 17:15:30 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3dea2sm6941433b3a.24.2024.05.28.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 17:15:30 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add ScioSense ENS160
Date: Tue, 28 May 2024 21:14:23 -0300
Message-ID: <20240529001504.33648-6-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529001504.33648-1-gustavograzs@gmail.com>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for ScioSense ENS160 multi-gas sensor driver.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
no changes in v2
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 304429f9b..92a130c8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19660,6 +19660,14 @@ F:	include/linux/wait.h
 F:	include/uapi/linux/sched.h
 F:	kernel/sched/
 
+SCIOSENSE ENS160 MULTI-GAS SENSOR DRIVER
+M:	Gustavo Silva <gustavograzs@gmail.com>
+S:	Maintained
+F:	drivers/iio/chemical/ens160_core.c
+F:	drivers/iio/chemical/ens160_i2c.c
+F:	drivers/iio/chemical/ens160_spi.c
+F:	drivers/iio/chemical/ens160.h
+
 SCSI LIBSAS SUBSYSTEM
 R:	John Garry <john.g.garry@oracle.com>
 R:	Jason Yan <yanaijie@huawei.com>
-- 
2.45.1


