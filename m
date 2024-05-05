Return-Path: <linux-iio+bounces-4804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C298BBF58
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 07:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4A31C20D72
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 05:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D42901;
	Sun,  5 May 2024 05:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll6ej+NL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499F1878;
	Sun,  5 May 2024 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714887444; cv=none; b=PioK/YySiTN/k8Q950vUYGFfiIGmsaDi5OoRg0xlmF+MjPlifQVSlogATuQz2Ay4MNcLi9Kmb54TH6EsnKyN04yU8qXp3OTRdTAzYNZ/QnH8LZXDA/w4HmETtvI6y0R/5vZ5Fau8CxwNUuqst2i/LGF0j0iSbuhhdnUK3lvp7lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714887444; c=relaxed/simple;
	bh=A5nODOLSli5V7F6Mz5u6XoiTZeNafnfsiBZ/DsLy1ek=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HGL+5ILhYHNiPWNUcWj6nMB+8E6uYEH3Uh4rdeGWjfTob7/PlqB4Q8Wwcvn80pF7QdUlFQxDBNPqPS2LFzbcnibhIObd/032ojGx/JYVd7+w6bMlbSV5gaYsWaAz7jPxADYllnvGEy5ETr7zicU57KQ1H6a8Z7fDjfpOA53w83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll6ej+NL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so7492915e9.1;
        Sat, 04 May 2024 22:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714887441; x=1715492241; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AOJOmoHVAZq86+Q/R6H9fMbgkb1KdxJ80wkb3FviG58=;
        b=ll6ej+NLuhKCklhp01Xv4me9b35woOcGwELYLbNBW8iQLVPcyDWNr5JClskrBs/SG/
         y+HqjvZQAqzetJndZ8aF7g8oEvYchMjdf3MapU1B70HR/6yG3lIgpVnl4BYX9E2nerAk
         qn9EjqjJQy8/mG87DQtM4WFV9t+SSgJpD4j1xnK3xua+L39XJmajZHc1MR8RPWg/FYTj
         5RaJ4skk7Sbi0zhudJ0YFm31akhBIp61/7DlOUYA4bQ//35jqqFghGEv3zFKOkQJAtw7
         qPF9SnWJUk6CCETm8IhX4FEQInsktRGUFYun2M4CxqwAv7JtOxwPocfsefndJ2pYAHFS
         4p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714887441; x=1715492241;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOJOmoHVAZq86+Q/R6H9fMbgkb1KdxJ80wkb3FviG58=;
        b=KbeM6VIoKOaCUZIrd9I5DrjlHZzygn09DlsZp55x4zUuPEwV0n8qLUclNmJC/+wCA4
         wDnC8BGeUSVPeMpsR5dHS35cCHXeEcQ83s3sQ/SSgNL2UbeMv6Oz10yphC1r9GBPlJP4
         be1u5EZ2TLqCaKJ9NYlwjaRlkO4S/4gEoe8xlC+TmpKbtlmwHetJj9ynVmrVDovVCUEf
         exdS6+s+KoWnrMbP/JnzbJPqIZlABPolf0wIFoSY1iCkyJQQlMxGqB+9iAueyJRatIx5
         z9V0tJBKHI9vh2LZ+YH7IumRvmxF9iZijKaSTM0E+lN7lnwr4y8vtuO/RgJVjXCDpFkZ
         3xgw==
X-Forwarded-Encrypted: i=1; AJvYcCUiQqa4l+sza5fbXiuXr2ALVnaUFs1x5nQ3dUZG03tOcMCZMA70WjQTLnfVRNqOF0OUUqaVfZ+XUKtTtwZTl+6DbAwFG4xGk5lasM7D6P1VTZmReLqONbCTh3+HYd+tM//eZ/YPVbFKrA==
X-Gm-Message-State: AOJu0Yxn5eAgesZCQCjqf7eBtcblgN+ogjIlq4EZPy2AZlb54pyopqbU
	AhCV45riHyP6F3CZ9LyPElh7viL91K/qrxpDYCE5MkIHSXpicHRy
X-Google-Smtp-Source: AGHT+IEGfbdY2vLr1/1vkwRMhijMJiJaSh1ZLsK4T0C1NBd1bLeiDNO6PS57hPG+cfcr+XvuKJnvZw==
X-Received: by 2002:a05:600c:4f0c:b0:41c:9155:fbe6 with SMTP id l12-20020a05600c4f0c00b0041c9155fbe6mr5514648wmq.17.1714887441182;
        Sat, 04 May 2024 22:37:21 -0700 (PDT)
Received: from [192.168.1.130] (51B6DCE0.unconfigured.pool.telekom.hu. [81.182.220.224])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b00418f72d9027sm15050957wmo.18.2024.05.04.22.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 22:37:20 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Subject: [PATCH v3 0/2] Add support for bosch bmi120
Date: Sun, 05 May 2024 07:36:53 +0200
Message-Id: <20240505-bmi120-v3-0-15cee3d0b2ef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPUaN2YC/22MQQ6CMBBFr0K6tmbaKdC48h7GBQwjTCJgWtNoC
 He3sDLR5fv57y0qchCO6lQsKnCSKPOUAQ+FoqGZetbSZVYWrIMSnG5HMRZ0h+R9Ry1CjSqfH4F
 v8tpDl2vmQeJzDu+9m8y2/iSS0aBd7V0NjS+h9Od+bOR+pHlUWyLZ/5rNGrZIXLEhpOpbW9f1A
 3RS+sjTAAAA
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
Changes in v3:
- Make chipids static.
- Link to v2: https://lore.kernel.org/r/20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com

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


