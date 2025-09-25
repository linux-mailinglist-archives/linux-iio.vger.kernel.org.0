Return-Path: <linux-iio+bounces-24440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4298BA1681
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FDE1C0284B
	for <lists+linux-iio@lfdr.de>; Thu, 25 Sep 2025 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4FC320A22;
	Thu, 25 Sep 2025 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDot24T6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA7323B63E
	for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833155; cv=none; b=Fs4yOpdnvtzexKbl6d8xf4Du+H1Qh79MuVloSzZxNtgk4wPWs8s9pJxbEv+CEkgcchi/Q2TBLbfW6/gBZI30g7o4IPcJA7/RTwDAHf9j7UNL1IlsPZVcgBHdqXHJD5wapwKmjbqFjC22Hog42rN04z4k8l/I7kWFmUz/Tl26UNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833155; c=relaxed/simple;
	bh=6/fVemqx0boFHVf8BglV+KY7l1wA+KVgHJ6A3PVERVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J1myI82Gk23OHDtvnwLoZDLyoJri4ayP7SA0aCfY/bQsbDzYfeQCsdeHUazfGwzLGgl3lfomjn8qUdQMFL7SrwFaiAVMKp4XvxHyf7SepLcIwUZ+3wkC+jpW0pHdc7Oudn0/l/oD1tk+iGmB9LKg2cxrgMAy4H2htdp6uq5x624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDot24T6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so11766035e9.1
        for <linux-iio@vger.kernel.org>; Thu, 25 Sep 2025 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833152; x=1759437952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FawQ9LId3cga0DodGg9MhmIp2lk7tl7dCQ1MCM1JQxI=;
        b=jDot24T6cXDlqEuqT9WlAfFM8crSHKQQqdowlonaStGaiWGulPDsnostmO5y1ZaB6O
         WcO8uaF6hoCSj6PCSwrBGANE16c2wcePGspSZCFfQjiW39pVwpJ01kj61vs6mSfIvSRa
         5J35tFQQiROItEFLHPooSEiOswI7FyO2JypbXRLYU7StnMBOdrwjZXgYg6RqW8kyoxO/
         e0TEtcQfAbI1WqWXzDUePM8QiCwOsWCAoATJIQQbLY5ELbM/zumIHKI9VI9M4J9kgROY
         EbYpr8B63mbfy0dVTrWIfmUxjGLJkaQucI1m2H/Lqcuf81dBZUGWSXFtePDWk8cip3H9
         9+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833152; x=1759437952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FawQ9LId3cga0DodGg9MhmIp2lk7tl7dCQ1MCM1JQxI=;
        b=ptgwNxMGB/HsXhgHFgBiC6Xg6yW/YaMD9UHMGZ94zLmMB2fDT0MJK+Rw0li0/3ij2J
         zxo5D6lh8fwsdzLqYLQ9ohTh8DvqCU8GggbacZYJz1mnfVs20vt28J2qpwTvP+O9smjo
         b3+R/KYf3Fo4PAiPN7TKUcNpV+wt6P8/eUtDfsooGFA3DVtL1LueBKKLvkRamL5j998K
         DrdtBKP+KWgIlBCzprxT6HvhHxxUObgg00ne27zVSnyug5SwZXdY62bYE7H/flmoezzt
         xenItyduiBdE3Yv8NX+OGu1VGrwah8B2YTZWLnfBJzomT5QpsGY5MMM19tIZirbZ/kTh
         yxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMxBc7/NkKm3DcKwlGLOyc7YKe2VEv32tWFViJhk06r7qX45T5skqKN8pjOZQtSSVrKkAYBvtL9UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xedPXJXOD4m8ps6/n/jcl7o0adDPLgQ78zChVxVrjUTNpkjL
	e1T1KXgOD/s4JdsRiYBRcWhRwF5wZ0tfFPDCn0P+DafrnZL6mMQG65kz
X-Gm-Gg: ASbGncuMDDr9ZyhhCTU61l2CC/CRhVRvJMo9t4gZFWJQ3A2MxAO3BNztCAIqbGxYwjj
	+XKxDGz7csx7uko3TZWESUM8bW+660UHwpFPyZU3E5A8ZSHi6yjXlOKMqr0NUV2YfNm00IKl9og
	jcIW1/EAksdWL6oMw3axb5/JyMzXzqBJebiW8WGx+I+EbQaeL/z0TvGQoEUyhOBTWACCft1GIf5
	OSQz0fPzCulJec4ep5XgkaIps9vkA57Ps+/miTFi8tQaT3pp6a4S56e3XkmG9EfiTYyoJAKr9iQ
	R1B7ggkcPjw0WgILqmlLWk96HFegHtpIL347ujpgZA42UVPBu+HyIr/snXGWUd3SHNRGoBkRufr
	ItnBPNVxoA0fxHu0xdLNx3k2t7cKrBIPhU/9zxTc=
X-Google-Smtp-Source: AGHT+IEHiCxXo80MoGqRQ4HgceWd3FnDtzRwnXBD2L0CdoGsZPj/nAU+IAdeObX5HfW52mzD3aiY1g==
X-Received: by 2002:a05:600c:c83:b0:46e:1c2d:bc84 with SMTP id 5b1f17b1804b1-46e329eb10emr51861395e9.17.1758833151386;
        Thu, 25 Sep 2025 13:45:51 -0700 (PDT)
Received: from localhost.localdomain ([78.209.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm91201395e9.1.2025.09.25.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:45:50 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 0/4] iio: mpl3115: add support for DRDY interrupt
Date: Thu, 25 Sep 2025 22:45:34 +0200
Message-Id: <20250925204538.63723-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This set of patches adds support for the DRDY interrupt in the MPL3115
pressure sensor. The device has 2 interrupt lines, hence the new
binding. I also added support for the sampling frequency which
determines the time interval between subsequent measurements (in the
continuous measurements mode) so it's obiously tied to the DRDY
interrupt feature.

Kind regards,
Antoni Pokusinski

---
Changes since v1:
* P1: add `vdd-supply` and `vddio-supply`

* P2: new patch: use guards from cleanup.h   

* P3: change macros of control register bits to convention
      MPL3115_CTRLX_NAME
* P3: MPL3115_PT_DATA_EVENT_ALL: use GENMASK
* P3: trigger_probe: do not fail if dev_fwnode() returns NULL
* P3: trigger_probe: use devm_iio_trigger_register()
* P3: trigger_probe: introduced enum mpl3115_irq_type and 
      changed IRQ setup logic accordingly

* P4: MPL3115_CTRL2_ST: use GENMASK
* P4: read_raw: samp_freq: use FIELD_GET
* P4: write_raw: samp_freq: use FIELD_PREP
---

Antoni Pokusinski (4):
  dt-bindings: iio: pressure: add binding for mpl3115
  iio: mpl3115: use guards from cleanup.h
  iio: mpl3115: add support for DRDY interrupt
  iio: mpl3115: add support for sampling frequency

 .../bindings/iio/pressure/fsl,mpl3115.yaml    |  71 ++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/pressure/mpl3115.c                | 314 ++++++++++++++++--
 3 files changed, 352 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

-- 
2.25.1


