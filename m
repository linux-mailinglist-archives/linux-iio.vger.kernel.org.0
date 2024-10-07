Return-Path: <linux-iio+bounces-10272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FE992CD2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB161C22A6D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D211D363A;
	Mon,  7 Oct 2024 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YP8LhYyn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68471D3586
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306892; cv=none; b=bjAs2HLhAob22kz+tSpiG3T82QFB+6rGkIr2cWy5Y+IyAiNUisBFtULohjk120SS2A7YPkUsNYtAsluSZ80CszhjLe4+e/OwPqT9JBcP+xmopIt59XhxoU3zmHJBFkEkRGRWvYM8DNoUeQSCPIp8O6MUt+Whhrl71jhOjISnJ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306892; c=relaxed/simple;
	bh=3eAB0MPWPh+F0cNZxuoQ/FJ3ixr2FYDg1y/kIvFp4vs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PmB6dQUokWUXXapq+Wki8BprG1dHF51B7aSmH8KP5Gch3rR0oGRaFIf8LyEGZe/umFiq5//P1rCEdY1x9laI+GsBt1OZ18EFfmwplRbPtznkYjdoN33y5nk+huu9Faj37v7ueYrQsAyIEuQtNrPx1E3WE17/uVvhXX/LYvI4+i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YP8LhYyn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so45794705e9.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728306889; x=1728911689; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLzyiDMY3JmZn9rb/heeAeR0e6N9MqOsLEKShnQDaOo=;
        b=YP8LhYynws9G6nrTZ4d7xhjJ9zBemhoue7hEI0l/ittYGu+CLW5OI9g5iu0NyA+qlI
         to2z95VDIeoahvpjHNnaQDW9nJ6kuzWBbtWOescjjsGp6wrZ+tFfHPtNh0FWvnE8uyfa
         jKLeZ+UIIM1r+j9muPkCWHRN37Gjb/X+Z99SyqpZwHNTZXo92VugOC+9/mRpNaj3rmKZ
         xGkTN2wkvZRtwEymwNJs40jSkYDmMmIfPElsQN0NmutTafPWXMCg7vdysujDtq/2SpeS
         1YhQW948Ig3fW0f1oQ1pL9Mpk9BvhTfPjLsErtGfupR3WpVIyyEz6rLAqGMbC6utV7+L
         UN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306889; x=1728911689;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLzyiDMY3JmZn9rb/heeAeR0e6N9MqOsLEKShnQDaOo=;
        b=vCJfaAsDIXltYfCDCB0sqt3MYzejby2Du0f7Q0j9ojaGNa23hVTxjUjHVYDewCw1sm
         BSeeP8p/xBM4NczaUG6tmJG+fMmV7OaMxjMSmbGgYZWqdaODq6RAd3LvBZQ3L2IrP6PA
         7mDDZWw6mEgVO3Cma7AozlVZKfYbRak7fld0exjhOf/iT3T6M4ylF1WWXlEfEfoEQMds
         rn3XzqITeZHMK2FYJ5jIfkkRAosRhwm8R+tTwDiz6VrZ1Abynr+U01V0rfdsMTpT+6l9
         kv0k5v4CT0JC/uHlAIdPozKhg0vr2NumLtFrxCh3bRZDSdekzzYgQmPswMVe3mz0r+l4
         V5pA==
X-Forwarded-Encrypted: i=1; AJvYcCXTZ52vP5ry9yseVbGThH4OIu36Vz88kbOaeDND/A2DZT2x8UIS4JL+0JLFWMtz3o/qHbl+GKLmHKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRsqOBKGkHC52rdhYGYpENAqjftf76kDAGf2scWf+dR6jPpbyf
	N4IeHnU3NnY6kibX84Eb3Jgguk30sxiVr7Xaxcb1wjTKlGLsAcJw+XEMnaUbRbs2oNyBtNLTLWx
	JppM=
X-Google-Smtp-Source: AGHT+IEHi6hsrv51epGlRQW1mPg5o9RxX76TVIsU8Y6JkFuHSu8eoMHBs0fqQOKlRe28As3DHi/f3Q==
X-Received: by 2002:a05:600c:1ca4:b0:42c:b23f:7ba5 with SMTP id 5b1f17b1804b1-42f85aa92edmr93632435e9.10.1728306889138;
        Mon, 07 Oct 2024 06:14:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec6396sm73916475e9.30.2024.10.07.06.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:14:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] iio: magnetometer: add support for the Allegro
 MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Date: Mon, 07 Oct 2024 15:14:37 +0200
Message-Id: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL3eA2cC/x3MwQqDMAwA0F+RnBdIa2Hgr8gOsYsuoLU0VQbiv
 6/s+C7vApOiYjB0FxQ51XRPDe7RQfxwWgT13QyefHBEHuueNaKmfFQ8stUivCGv1rueCCM/AwW
 ZAk8E7chFZv3+//F13z+V0+FDbwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3eAB0MPWPh+F0cNZxuoQ/FJ3ixr2FYDg1y/kIvFp4vs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnA97GW5SnuC+LWYu/2LYgl14sOhaXCt81PE7PEWBj
 0z0WvcqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwPexgAKCRB33NvayMhJ0UVrD/
 46Gj8uMMpjX/7qNz5BF6Hhz9UKnO3DImwe/MUQiJEkSCXWlAhUttV32+EBr9O3N8a6UCPewGQtTZ1v
 4ciSAubqzulDAkw7J3SkkbD7B9sWUesr6m2eNfWONhDNLbqhAmch7V3jA0E5II1Nce6H/g+Qu8TEXB
 8kltsib/G0XVp5oIBvnGCGg0JNBltLE8kgQ/x3kBcZYQsXEvTdCxTGJ3JlP1L6K2I8veolWk/kjVib
 gh8Nn70sHaR5B5R2hjv5ddlf2gjwQeHSMibRN/oTBC2Mh25AXUC4tOjUgZDWgNqvRUrLCClV1gCA80
 HBjzhkXto5JCTJuBFW9NRZWxQBowDAWx1WQALPxBz5b9LRbSP7FRrxaTLk/tdfRPCA3XeCnoAg0AzT
 8v1L1z1eGUk2HbCssMZBKnucSxrnEwh+LrZetsEUny8ib5zZyY0ImAasBq5ITrn6Q86hdLimKn+Dpj
 uA2VCAcN5if7gsK9JjhX1ljktPR+Zh6C7V7B3BQOPmourdrA/pQdlMmKjnzAaSVKx+2H2rCCXhw56I
 oFAYysvzEc0t3spav6e6OF6lbl14CI3vrbxKvBn6KXUDBX3O0E9rSiF80LPNkljcZWmxij7uUK3Jbx
 xddgKposa67XmgRmxFCmA7AuVIsZ1lNxepd4CV8ARBzZqmcZRrDJx2Jchqwg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Allegro MicroSystems ALS31300 is a 3-D Linear Hall Effect Sensor
mainly used in 3D sensing applications for head-on motion.

The device is configured over I2C, and as part of the Sensor
data the temperature core is also provided.

While the device provides an IRQ gpio, it depends on a configuration
programmed into the internal EEPROM, thus only the default mode
is supported and buffered input via trigger is also supported
to allow streaming values with the same sensing timestamp.

The device can be configured with different sensitivities in factory,
but the sensitivity value used to calculate value into the Gauss
unit is not available from registers, thus the sensitivity is
provided by the compatible/device-id string which is based
on the part number as described in the datasheet page 2.
    
The datasheet is available on the product website at [1].

[1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      dt-bindings: vendor-prefixes: Add Allegro MicroSystems, Inc
      dt-bindings: iio: magnetometer: document the Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
      iio: magnetometer: add Allegro MicroSystems ALS31300 3-D Linear Hall Effect driver

 .../iio/magnetometer/allegro,als31300.yaml         |  43 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/iio/magnetometer/Kconfig                   |  13 +
 drivers/iio/magnetometer/Makefile                  |   1 +
 drivers/iio/magnetometer/als31300.c                | 459 +++++++++++++++++++++
 5 files changed, 518 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241002-topic-input-upstream-als31300-ca7404eb4ab0

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


