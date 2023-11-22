Return-Path: <linux-iio+bounces-258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CAB7F43AC
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 11:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897A9B20F08
	for <lists+linux-iio@lfdr.de>; Wed, 22 Nov 2023 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6254273;
	Wed, 22 Nov 2023 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="BZ1nnaTS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFD0198
	for <linux-iio@vger.kernel.org>; Wed, 22 Nov 2023 02:23:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f61322fso33193905e9.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Nov 2023 02:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1700648604; x=1701253404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=24ax012WMEMM4FUonPPNS9MbOgLZBi9d6mGqyl9IrhI=;
        b=BZ1nnaTScFhP9Gw03T9ExH9f7p+9HZllkhs1lO+S7zr3IRjzmm2hV86241+xhEjO9y
         bROCHxQxx7uHBJYY59x757Z4rJgabfcVR2DvNaPaM9eELcsYNRKsWlR/gw/ru3Cn/LoA
         GYmxuJw7+FV59qB4DcvxJBJUkAswH33O6hnZ78iCSIYIuDlda5HaMDmsn4FZG3kz6CH4
         aD2Oa4bMWu5FkHGPUWrlX1KveDwc4M1P1OCfm7bNPbiG7jTwP91a04VcX/mY4WJcgIFY
         i2sI2AOP4W8FiDbfacbOpjEtJSH0CibSx99YflORSssRi/gdsxaRahqkJUUDyy5U5Gwv
         iGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700648604; x=1701253404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24ax012WMEMM4FUonPPNS9MbOgLZBi9d6mGqyl9IrhI=;
        b=r3IldxPEQESwf+GVgIXHk9mwMJEraKLBaWRMooA/C/qQTOLYvxT+vTIL80a6GBA3mq
         XS5cZdmM6dXJ0zIFpAjJrLAsvcTk6rOTMk/3RUoSje3kEuxpIMXYEYuLhNAnI0xm7P2p
         pO1EeLl5h76ucRrkeqOXW1Z1KhtanaxnHviKXOeRo4vC0rw4KEwAVN83mCY/BKAascXY
         wYpEtVeKwxjpWYJt9vP5/UdHASTaNce/WlEnEweOQifDPYyNK6DSwnjXbTa02dPa1KBh
         KpMVs2jLuVLuTQ3vaOPjMUmraAf/X5PJC32vkRDwl8pmgGngWOFNk6w7bWBAY4C8woVC
         eb+A==
X-Gm-Message-State: AOJu0YxKTBkNpqsiVq6+HhLB03fP04V5xd1Ci7H2W1t1p+9auVGTA1Ro
	/P2wdfa8EawuN8xoqJ75+3HsJQ==
X-Google-Smtp-Source: AGHT+IFWAIlMEC43UhV7Pji8JRcvxELt0MfpwGRHxrjpQijlN2jzXiFo4DpO/Xe5fOYNjugEaOLTRA==
X-Received: by 2002:a05:600c:510b:b0:40b:32fa:d8a3 with SMTP id o11-20020a05600c510b00b0040b32fad8a3mr685774wms.18.1700648603635;
        Wed, 22 Nov 2023 02:23:23 -0800 (PST)
Received: from localhost.localdomain (d54C3956F.access.telenet.be. [84.195.149.111])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b004060f0a0fd5sm1729282wmq.13.2023.11.22.02.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:23:23 -0800 (PST)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Crt Mori <cmo@melexis.com>
Subject: [PATCH 0/2] iio: temperature: mlx90635 Driver for MLX90635 IR temperature sensor
Date: Wed, 22 Nov 2023 11:20:39 +0100
Message-Id: <cover.1700648164.git.cmo@melexis.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everybody,

There is a new contactless sensor in Melexis portfolio. MLX90635 is just
1.8x1.8mm in size, but with factory calibration offers instant usage
in every project. It offers wide refresh rate range that is configurable
between 100ms and 4s.

Driver currently provides temperature calculations, power management and
changes to the refresh rate. Since sensor is aimed towards the consumer
market there is really low number of EEPROM write cycles available, so
driver changes refresh rate only in run time registers to avoid writing
to EEPROM. Reading EEPROM is not available in Sleep Step mode, so I am
using caching at the driver initialization to ensure that measurements
can still be taken in Sleep Step mode.

Crt Mori (2):
  iio: temperature: mlx90635 MLX90635 IR Temperature sensor
  dt-bindings: iio: temperature: add MLX90635 device bindings

 .../iio/temperature/melexis,mlx90635.yaml     |   60 +
 MAINTAINERS                                   |    7 +
 drivers/iio/temperature/Kconfig               |   12 +
 drivers/iio/temperature/Makefile              |    1 +
 drivers/iio/temperature/mlx90635.c            | 1099 +++++++++++++++++
 5 files changed, 1179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90635.yaml
 create mode 100644 drivers/iio/temperature/mlx90635.c

-- 
2.40.1


