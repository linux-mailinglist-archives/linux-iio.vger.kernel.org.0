Return-Path: <linux-iio+bounces-7476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA8492C1AF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 19:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF8E1F21A51
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E71B6A50;
	Tue,  9 Jul 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="lvzWx5O0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD91B4C5F
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542979; cv=none; b=m8gqhctCRZmYM41CICtdDjstW49sM/Ub0Nsgozil3XHaRLB7inqPGdyswvlHsvurH6nWqIElXVR9qDT7TqBTkDOErrtj+vSPYP4mbj8z8OKw0cZL/zww4GcemXZBQAY8rfYJwQW6OFpybDv1T6lYcz9HazX3mWYA+vhlGUgqCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542979; c=relaxed/simple;
	bh=gfuBjzaQL9gTYODlRQx6yFrgftBRvfPKkRJDUxKB4SU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dz6j536ESNYMn26759y9vevbKaqMIcuAZ+V2L9s2c5VvQ066/MzKGP+QtZKuP523lkQ2f4R9cW0V7svotK3aEns8+l99Vot+At/7Qkp0tFKUF8J07fNx1LfPeW1XxRZ4Y+r5qY867Krft5i6y4QDClsb1bcCScv7uHOq2XOkIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=lvzWx5O0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso64418711fa.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Jul 2024 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1720542976; x=1721147776; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9MYJUKCZJqpXesGhM7neSV7GESDWq919aeqPs6MM58=;
        b=lvzWx5O0H3ZdXvs5RUmt5flpOHMNF5YFAICSl0boQ+tPi9XaI4r/lswnBgGFVd8eWF
         3y9KfZaAc8gcePsZG/FuSa7S3XwNBjL0Q0LetHa/ILU6p45DpTZt3/+UJw6qE4m0t0nF
         94rqgSaQHG9S1GSBo6a1c0iuVtOeoCe+fhVmpcoVXVXEV9bP19pWukFB3XXXINwEvjln
         fEKYPANnKmd+skfQ0QmlpA+zhecAyX2OIn1KO4wxkbQuQSVp6ZwD71TPTX4vGXhRlU1s
         gqclynI/digOtRb5cDeoS+MCf71KdgLdfxF4UOWPsBwrhDa2YZ6gQgdz2gwEJJwOLS7a
         Q8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720542976; x=1721147776;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9MYJUKCZJqpXesGhM7neSV7GESDWq919aeqPs6MM58=;
        b=wz7g4/ahnwj7IiJsFT3Fm7CrCvHQF4fwYnQDAxEzrsFd5SwKSIZCFqoMf1S0sAJ9Fs
         pDuZv8nwgXktV5EQqOSdObazKXOFoJTBbtF67XnBUAo265KD8s+CXKoFzsuehBkm0Ta/
         GBCQSfHoxTfz9UQwurIq7FCGgA3yo4yAEKKixKJcxunWHpHEB+O3/gxugodfcgPWhLDE
         Q4U1Sqlvhly4efGMVfvQsUKSqHUQycMJe+5SIxKHiQREJ/hQ7X/8Wco433p/yPAhpu/h
         z8BAX6Gj6La2FUmhSr55/IFxusL6I3mGJj+pjW8RHr/vM76RY+mIOrmUhy+Yskk05p5i
         CtkQ==
X-Gm-Message-State: AOJu0Ywocc6Ts4LD+U9qYI1fQ5W1V6+RPRCaB0x0HBKIRjhL1K2FKI1B
	vaWs4+Xpbg9Lwrvt74ksqftcPTASz0H0f1KdwR8aPZHhmlRye/+IccVsCaSL5pdSbvKxQMrgjKg
	C
X-Google-Smtp-Source: AGHT+IF2kTry7mVZy8wNL9+hXKmtByo6R5klQmpio5TGpcq8XeZkhMImhKEomb+u/Obf3niL5ZY8pQ==
X-Received: by 2002:a05:6512:10ca:b0:52c:de47:b317 with SMTP id 2adb3069b0e04-52eb99a0805mr1684871e87.39.1720542975452;
        Tue, 09 Jul 2024 09:36:15 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f5f25sm48897745e9.26.2024.07.09.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 09:36:15 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Subject: [PATCH 0/2] iio: humidity: Add support for en21x sensor family
Date: Tue, 09 Jul 2024 17:36:09 +0100
Message-Id: <20240709-ens21x-v1-0-678521433cdd@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlmjWYC/yWMywqDMBBFfyXMuoGYPvVXxIXVazoLk3YmLYL47
 w26upzL4aykEIZSY1YS/Fg5xQLVydDw6mOA5bEweecv7u5qi6i+Wuxj8tezq29lQUV+CyZe9lD
 bHSz4fEsvHyc9e4Ud0jxzbkxOQRCo27Y/cLtgKYIAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720542974; l=916;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=gfuBjzaQL9gTYODlRQx6yFrgftBRvfPKkRJDUxKB4SU=;
 b=UPDKdoiVHDUupCbcU10xRQso7vvKmh3tWU1eFOts+m/t6rLYecJWfFxLao1pg3dq9psg11s6D
 JfPM4It7kCmC43aB39RZ07HHPgVnbpjXTgB29APGt5tCRgBVW6vHGer
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

This patch series adds support for the
ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215 temperature and humidity
sensors.

Patch 1 adds the required device tree bindings.

Patch 2 adds the driver, providing the probe and read functions.

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
Joshua Felmeden (2):
      dt-bindings: iio: humidity: add ENS21x sensor family
      iio: humidity: Add support for ENS21x

 .../bindings/iio/humidity/sciosense,ens21x.yaml    |  50 +++
 drivers/iio/humidity/Kconfig                       |  11 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/ens21x.c                      | 348 +++++++++++++++++++++
 4 files changed, 410 insertions(+)
---
base-commit: 1ebab783647a9e3bf357002d5c4ff060c8474a0a
change-id: 20240709-ens21x-8f2530968f2e

Best regards,
-- 
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>


