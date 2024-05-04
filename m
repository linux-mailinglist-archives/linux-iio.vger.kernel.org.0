Return-Path: <linux-iio+bounces-4799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BDC8BBBAB
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 15:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A806A28132D
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ED922EFB;
	Sat,  4 May 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAxEZL+T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF071C695;
	Sat,  4 May 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714827646; cv=none; b=YTz1tJTA2cDxFHbtGQTPt0jo7sVNBPXfX50C2QBSE8GtU8H5UAdvoWcCw5MDV/nCbXYK9H0DtrCZ3O9SKGFlvIqCvi2KqSxqG0ykJpHXZ4tJEV4KneGc4L5v6dLi0ds/6eY1VpfBqHKbRNbdrRi3iNneyO0i5ZWWVLqsX05PkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714827646; c=relaxed/simple;
	bh=7/3OtnSHAyD3qTbszB6IfmzFsOdjHJ1uU/CM/XsGx+o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OhtkeHzWRpcwLaOm6uEgPn9OBVarY1WmkQTjUULNSIWQI7m+CVMTBNi6eCJiPL7dFfQd0XTUyQTn8segQlSkdEs+aeERdojjoPw5vjET5Vg456ddrPVF8K1R2rgQ/zR8ILo9jJRcE8hCP1FfdKZDZuezTwnFg3KKRHa1Q6wVtyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAxEZL+T; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b79451153so4816615e9.2;
        Sat, 04 May 2024 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714827643; x=1715432443; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Lwjn8KsCvdrP2xnUzN7gMriSg/L6gIVm79An9kGBc=;
        b=EAxEZL+T06IqWQK8XuUN6tn1Gm2uadbcRFhmFT7iH8tZ6mudvNksovGnzhoGI2JoaL
         SUZmcG2CN27XQ30zVV1rp3zNeGXotdLFCEemSiGgPZgPPZKFAmLVnOtB3MbF/4C1KMpN
         nQQI5FpCqTEAZyD/t6VZdRwb8Gi2nTkjiMmtGwtWdbQAjoo+ysphG1DlmyjlrTJrndRR
         iSwo2JLh+eYFv6kCm3pIlfHzu9cuV8qOzmD+AgL25nC5cDSRyhYJ0RVA2iRruzgDDOht
         kJZIyaGIcBhwcW7eHqncOAvM/Z7SX+pauoK92/F6wAfYersRM8yEHTmnU+ow7GF+GyQo
         Wm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714827643; x=1715432443;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l0Lwjn8KsCvdrP2xnUzN7gMriSg/L6gIVm79An9kGBc=;
        b=UumVF4RcGrhiGcYDi/Xllx4YBdzeXO/xg49b1TIQ11HCdnUciEbXz5q5TjJ89TWoY2
         mGSJIRCw1Xt83WP0kx8MKpf98FCmaMwN9wUrXTjekdKOvJn1l5ELgCa+8aHcTYm+nSvD
         0npT+mKONNPeZ7608lYrGmAT50AxXEoJo9bqiwZUuGQ+kJXmZbe3fk/MujqQRhuiCrra
         0EU7JljY335YvV1pHpKL4aomuFWukTWSk90NYUzGs7ToEz43TOip+dJuAF7v0xce0Zp2
         62zh3UwSLhyNm3tIBSBnPReTUcGYFN1ZKAFVs2pStqHb2o9Akfam8LYHvWaJyR5PXh22
         7baA==
X-Forwarded-Encrypted: i=1; AJvYcCXeDY7mbM3AVzZ7e8QyuruDDGCqI/8HKamZ5RAbPc6CfA5F1sEpm40eBAZIYUrXf17hrkfyyXeE+9n05b/G9JmMchlhsrrD1h6ZrIgo9MrN+LVUWt7aFJPKriDO6HJ54mI/WT8uxMXp3w==
X-Gm-Message-State: AOJu0YxC6CMIOMZ8+Yf8yBpwCMYdx+UCR2S9/QnKvbuovd4cD1feifvm
	NUISeJIbC3syIKNAw9n/BuqpzJt9qK70X9dTBKo2vovVI05tZaPw
X-Google-Smtp-Source: AGHT+IEJECZV506GaoLg5Cox7eO7SRlK/BVcsGQmHR2EbCEVvRO4NBowuZTPWSoS9FOd//V6+6ij7Q==
X-Received: by 2002:a05:600c:1d26:b0:418:e88b:92c3 with SMTP id l38-20020a05600c1d2600b00418e88b92c3mr4235722wms.2.1714827642482;
        Sat, 04 May 2024 06:00:42 -0700 (PDT)
Received: from [192.168.1.130] (BC24954B.unconfigured.pool.telekom.hu. [188.36.149.75])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b0041bf45c0665sm12888998wmq.15.2024.05.04.06.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 06:00:41 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Subject: [PATCH v2 0/2] Add support for bosch bmi120
Date: Sat, 04 May 2024 14:59:47 +0200
Message-Id: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEMxNmYC/2XMQQ7CIBCF4as0sxYzUAjElfcwXVDAdhIpBgzRN
 Nxd7Nbl//Ly7VBCplDgMuyQQ6VCaeshTgO41W5LYOR7g0AhUaFkcyQukPnRGePdPKIeoZ+fOdz
 pfUC3qfdK5ZXy53Ar/61/ROUMmdRGarRGoTLXJVp6nF2KMLXWvmxbKlucAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>, 
 Danila Tikhonov <danila@jiaxyga.com>
X-Mailer: b4 0.13.0

Add support for bosch bmi120. 
BMI120 is an energy-efficient version of BMI160. Despite having a different
CHIPID value, this variant seems to be fully compatible with BMI160.
It could be find in many phones like xiaomi-vince or xiaomi-tissot.

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
Changes in v2:
- Add bosch,bmi120 as a fallback compatible.
- Remove error path if chipid is not found.
- Link to v1: https://lore.kernel.org/r/20240504-bmi120-v1-0-478470a85058@gmail.com

---
Danila Tikhonov (2):
      iio: imu: bmi160: add support for bmi120
      dt-bindings: iio: imu: bmi160: add bmi120

 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |  6 ++++-
 drivers/iio/imu/bmi160/bmi160_core.c               | 26 +++++++++++++++++-----
 drivers/iio/imu/bmi160/bmi160_i2c.c                |  3 +++
 drivers/iio/imu/bmi160/bmi160_spi.c                |  3 +++
 4 files changed, 31 insertions(+), 7 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240504-bmi120-d3c88dcb3073

Best regards,
-- 
Barnabás Czémán <trabarni@gmail.com>


