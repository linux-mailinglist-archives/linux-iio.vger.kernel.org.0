Return-Path: <linux-iio+bounces-14509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9817A17463
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 22:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93F616AC08
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 21:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A8B1F0E25;
	Mon, 20 Jan 2025 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J60H2TdW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952ED23A9;
	Mon, 20 Jan 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737410205; cv=none; b=SAypALKeoKEZ9bkfHRMmePV7RvDjrgwtew7tsUNRK/tovvWgmXhqLjpMdEu0b6mD1A5N4ETCAtGjUFWwwL2cZGR+fYBWgxZsD+yaxTHYgji3sY3SCerdChOvYFfNBYAtKgICch3yXkTHOkdN9mj1X3k9fQdk2po1yQ+KnbGaiSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737410205; c=relaxed/simple;
	bh=cfZatKSOwb4pRrTvfqqmxov6qxiGqxrxQE80O61kZQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KfNPV0XUcRYRBctZC/UmpmzrgiK1QCGW0J66YzuAl+/51m9Q0TmZhPG8wjWuXJTPswhRCxtLwcVHsSBfI/fSan79pOP4uxgYH/xWNXZgZNPessBhNlmCgPTlklzd9eN0fFE5Gkelh+9SSCmrNuMc8Grc2Cn2WsQ1F7WMIZPzGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J60H2TdW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso37129235e9.0;
        Mon, 20 Jan 2025 13:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737410202; x=1738015002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gy+qLl8gGznrzLuj2uSpvMqnS9BDhuVxamnKKVaP/AA=;
        b=J60H2TdWJABh6V6pfFR8w6yFPaRPPaI/J4KoKIlCHsqCbrLqLqeyx8nQYjEQSvhEcI
         6JYRLlmvgykLAdU+By3emyPMBvUMjQHXti3ZaYI5yosb4G3EKRU5TSvHz0ep0U44lbsg
         eoYA2Kl35H4K3LkaxxaIuTR5/UpJcBD4Fh/BhV06jerldZJR+xh+Oj7Thm9mOVdc9GBO
         kZtTlsZ9+2mNUiQzxahLzKEpIKCmORf4W/Dr0sRRxIuEnkiCXxVJ5vPdrKsHUcCI6DQH
         pV+ejhHzFiGTqCgUtHXYC1VpOMIi6x1KPrdcfV6ntEl5kN4EvvC1ANEobkyBMKXlR9dN
         /ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737410202; x=1738015002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gy+qLl8gGznrzLuj2uSpvMqnS9BDhuVxamnKKVaP/AA=;
        b=T2Elvz5KwUv9FKYC99FwUTMuzJZ2eDaZBz1oGID3C67+6+p5VRFi4yNHCztCwcd6K+
         6LhulIhgYdUGfG4vZC//2W0UwVyXxcHFutYf02cdnPHw8L5IPQ//NXklSGlNzVpWYCmi
         RC8MS6EIa58jmyc/8W//ToPTs1r8lbQWhkY65usMLUq6x0uNdg4ga82JTXm3XqPYfDxq
         saudmaOk04RIfkjTTfEg+cMDMvXN+K48Qd095DDaW65f0Z5+scTsRKD1msz/I9PKImHZ
         LflG9jHASt1GnaMQqF3pN2LrXIvgWdCkAgFHLdu/zPgR1V8zSNdkVbK0GRvrX54bLpiw
         KO4w==
X-Forwarded-Encrypted: i=1; AJvYcCUhO9+5AOOWGh/wxeuBM+oVupAox0VF/Q1MVDdhXRJyuUUfxhHfIRhTqZk7+/eu3eyRgjYQib9kQ1eg@vger.kernel.org, AJvYcCUoYYVcRgffyCwjybeyQSch8PglF70KVcvnt1iOoboRfkPQr65JLy3akr71WR1qSu/BVrbZgSNWegxf@vger.kernel.org, AJvYcCV5H/RBi231Ueyl4vxelznIvomsqZ5Hn8vRATBOaswSp1mOhFW6QHCLG9UlL+FyjkG1mJZlEgNMeaDKkmS4@vger.kernel.org
X-Gm-Message-State: AOJu0YziTDHCunBHsSneNrs+BOTtIor43mUrUmPyTbad0HcEVQFtapKE
	H9NjxPYcnkf+txCdU01nNf0RLPW9avMrmVIWVgDODkanfx99rOGv
X-Gm-Gg: ASbGnct6D4kTsxi+hdCAPHjCVq0M/szYfbZzBJI9Il2q7AaoiM1uWZJJF28fgocVQ8o
	vV7bOKS/czlLNPFj3+qVtIWHo5Ahm0AQeBs9LZCtJF7W0vMkyOSpVlR/G8FGZ3YWHLYbpKHrlNA
	ZS3em2UzFUUQOqydc7KyD+ADec4X8aM44H4cGR4sqECeWExY8AJ3jw/hkxOYjr+AVS1F/4KnDV5
	JlH52w0e7AeZjuujbwIK2fsO3jglqkmT8HMoCfHFn+bf/xg2JzQQeSRZpvIXfMENEyy/H7T0kdD
	kJHVWsKLPw==
X-Google-Smtp-Source: AGHT+IGHClq2XeoJ6TqmBnz/xzk2mEU0lDVEtFDHKPW6e6a4lLz/Wf0PPseArn8wV9z+doY3tFt+Uw==
X-Received: by 2002:adf:9cc4:0:b0:386:3afc:14a7 with SMTP id ffacd0b85a97d-38bec4fb4ecmr11750249f8f.7.1737410201562;
        Mon, 20 Jan 2025 13:56:41 -0800 (PST)
Received: from localhost.localdomain ([37.161.88.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327dd34sm11374345f8f.83.2025.01.20.13.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 13:56:40 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org,
	icenowy@aosc.io,
	megi@xff.cz,
	danila@jiaxyga.com,
	javier.carrasco.cruz@gmail.com,
	andy@kernel.org
Cc: apokusinski01@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] iio: magnetometer: add support for Si7210
Date: Mon, 20 Jan 2025 22:56:18 +0100
Message-Id: <20250120215620.39766-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the Si7210 Hall effect I2C sensor.
The driver currently supports the basic functionalities (i.e. making
temperature and magnetic field measurements and changing the
measurements scale) but I plan to add support for some other features in
the future as well (e.g. the digital output interrupt).

---
Hi all,
In this version I add only some minor tweaks and comments (for the
temperature calculation) according to the latest review.
Everything else was left intact.

Kind regards,
Antoni


Changes since v4:
* Makefile: replace spaces/tabs mixture with tabs only
* si7210: includes: move asm/byteorder.h to the end
* si7210: read_raw: add comments for temperature calculation

Changes since v3:
* si7210: fetch_measurement/read_raw: fix issue with endianess
* si7210: replace `if (ret < 0)` with `if (ret)` wherever possible
* si7210: read_raw: use SI metric prefixes (MICRO, MILLI)
* si7210: si7210_data: swap i2c_client with regmap
* si7210: read_otpreg_val: remove unnecessary cast
* si7210: minor formatting updates
(add missing trailing commas, spaces etc)
* si7210: probe: use devm_mutex_init
* si7210: add missing includes

Changes since v2:
* Makefile: fix alignment
* si7210: fetch_measurement: use temporary variable to read the
measurement instead of reading directly to `buf`
* si7210: read_raw: change `tmp` to `temp`
* si7210: read_raw: adjust temperature computation to match the spec better
* si7210: device_wake: do not init `ret` to 0
* si7210: MODULE_LICENSE: change license type to GPL
* si7210: minor improvements in comments

Changes since v1:
* dt-binding: add `vdd-supply`
* si7210: reorder includes in alphabetic order
* si7210: add comment for `fetch_lock`
* si7210: remove `otp_lock`
* si7210: fetch_measurement: change result type to __be16
* si7210: use guard(mutex) instead of scoped_guard
* si7210: read_raw: use FIELD_GET to get raw temperature value
* si7210: read_raw: return temperature in milli-celsius
* si7210: use regulator for getting the voltage
* si7210: si7210_device_wake: remove unnecessary cast
* si7210: si7210_device_init: use fsleep instead of usleep_range
* si7210: si7210_probe: remove i2c_set_clientdata()
* si7210: minor alignment and formatting fixes

Antoni Pokusinski (2):
  dt-bindings: iio: magnetometer: add binding for Si7210
  iio: magnetometer: si7210: add driver for Si7210

 .../iio/magnetometer/silabs,si7210.yaml       |  48 ++
 drivers/iio/magnetometer/Kconfig              |  11 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/si7210.c             | 446 ++++++++++++++++++
 4 files changed, 507 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
 create mode 100644 drivers/iio/magnetometer/si7210.c

-- 
2.25.1


