Return-Path: <linux-iio+bounces-5794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67E98FBF5E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA40284544
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360F14D2A3;
	Tue,  4 Jun 2024 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma3zsg+4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A710143C4D;
	Tue,  4 Jun 2024 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541880; cv=none; b=pnxBfOl2feNEURYFD9YDiZWnngkDi2EYG3Pl53SxUfS+7ySWcN0Si0XZp47ACG/8qZ7x8psUJuwlq+mSS6gHjvDgsx0HMj5HJflcgf3kGE0kbf0wGTgrfTZTPvL6Xom4TFyI8xgnnd3h+YMyeN7yaYPnoEMLLHShtoR99dYhJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541880; c=relaxed/simple;
	bh=q6QttMT0QnlZmTYPcl5tps5BMdSvD3LXdoYxFvShM6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtDRxdbuy4W/rv3fvRHdtCYiZM3U6u9kCG4MBjKgrUvud0FnK9jy9lVTLSx4fIgqBn0ejGK6++7KUp//i71Fwm9NwocKyuLOB92Pr+adoCVZ+UdOaTX3EXEwlw6c93iHZ9cKO7qpbctJzOt7FLg97GkKTCmuSSnMJkCsSefTYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ma3zsg+4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70109d34a16so5515986b3a.2;
        Tue, 04 Jun 2024 15:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541876; x=1718146676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=psvNRs8tsboEOt7EZf9jnS4Q/OaNZ0LHvdOY9F4uv04=;
        b=ma3zsg+4oEruZp4JJxuXHlOPQu5I5gv90Z/ZdwBZS80Pb3gZuRkJHP+THKoERVJWUZ
         He0iTGanaGAe12X9XhFmSawh8QI1YJcn9O5qMaF8SzHDj8KBl/4cZcY7kEdQIqIXqrtN
         lD0IsiDFkvCwNaq9dDPuQxjTtEuqvfTZZvPQ9qunIewV76LjZLwrARvGQaWQQdE+BYfw
         YEY3CsHJf8BM9Kgu5aS1TXLrzv+7mp/xvZOV+XCP8zMCOHeJvZLv4cidKIW9VoJfMfWL
         O9G1Af7eq5WYdDezz715Nc+kVj3/X8AR+dMaWSDo0NG55GTarRzUth7Q2SphRbeVMiGI
         CtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541876; x=1718146676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psvNRs8tsboEOt7EZf9jnS4Q/OaNZ0LHvdOY9F4uv04=;
        b=cptH7BlSMpLuv+JYuVNjojZBFjJT7Kdm2mhtXWkTjxbRFle6GJLMWbfEKjVACHdyXX
         lwPM1P4FkLrG8r9OTkUzip7fbpY5DfzKSGmf3k4yYfbAMprn5WGU+GoJ7VxA30PcvfIH
         gNCV6JXO6HcP5J8mspdfCk/vlwF7Uozpz1K9jq7/mkc+dOU7rDl6fseqnFFu/7eY3OL2
         MlnOPNJpuM16hZy3sz1+PrAhzeIz59sPlVEZhjSldN/6Q+dqov0benU4eAZ15bliBVYO
         dAB1vPJDI27zBlrAqdWVngAbREfExDHAOdLEyITn9KaTEa/60T/X4tTlwmXJLTQ6ri+f
         uKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzp0Dr3II2icnMBoV0kCsFylv70OxriSEv5h+1VRpYpavjDKPL5d1zFTsnUuR3TpGXVoZQnmUYrPkUZoj0jcCcvIztF8MVtapZAmtOTdiM29JKunphRGENUL5II0fnRXBoe/bvn6RUvYTzopz+Q1nArx9FRfZvVydXGEplrdG1qux2bA==
X-Gm-Message-State: AOJu0YyzWo1Sjtgpju/ZeTwjSyTI3hDeDO2G0CRA59NPxQnVuu1xadgR
	oFTtyhjV+aB2fGDUVS2MrRKue+Z9qcC3i8G58L0FCeeAeyhl/TY1
X-Google-Smtp-Source: AGHT+IEqlz+UPnIrq0ReN0soc6cwQbqBS53f4gH3Emrb5GooG5LkCFRYSsCmU8/AFNbCQreNZiDatQ==
X-Received: by 2002:a05:6a21:18f:b0:1b2:2e3e:42e0 with SMTP id adf61e73a8af0-1b2b7483bf1mr1139434637.37.1717541876390;
        Tue, 04 Jun 2024 15:57:56 -0700 (PDT)
Received: from localhost.localdomain ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a955dd1sm5312125b3a.64.2024.06.04.15.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:57:56 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Add driver for ENS160 sensor
Date: Tue,  4 Jun 2024 19:57:24 -0300
Message-ID: <20240604225747.7212-1-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches adds a driver for ScioSense ENS160 multi-gas
sensor, designed for indoor air quality monitoring.

---
Changes in v3:
- Add missing `$ref: /schemas/spi/spi-peripheral-props.yaml#` in
  devicetree binding
- Move the devm_add_action_or_reset() call to right after setting the
  operation mode to standard
- Remove "_spi" and "_i2c" suffixes from device name
- Add a comment explaining what data the mutex is protecting
- Format register address macro

Link to v2: https://lore.kernel.org/linux-iio/20240529001504.33648-1-gustavograzs@gmail.com/

---
Gustavo Silva (6):
  dt-bindings: vendor-prefixes: add ScioSense
  dt-bindings: iio: chemical: add ENS160 sensor
  iio: chemical: add driver for ENS160 sensor
  iio: chemical: ens160: add triggered buffer support
  iio: chemical: ens160: add power management support
  MAINTAINERS: Add ScioSense ENS160

 .../iio/chemical/sciosense,ens160.yaml        |  70 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/iio/chemical/Kconfig                  |  22 ++
 drivers/iio/chemical/Makefile                 |   3 +
 drivers/iio/chemical/ens160.h                 |  10 +
 drivers/iio/chemical/ens160_core.c            | 367 ++++++++++++++++++
 drivers/iio/chemical/ens160_i2c.c             |  62 +++
 drivers/iio/chemical/ens160_spi.c             |  61 +++
 9 files changed, 605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sciosense,ens160.yaml
 create mode 100644 drivers/iio/chemical/ens160.h
 create mode 100644 drivers/iio/chemical/ens160_core.c
 create mode 100644 drivers/iio/chemical/ens160_i2c.c
 create mode 100644 drivers/iio/chemical/ens160_spi.c


base-commit: 084eeee1d8da6b4712719264b01cb27b41307f54
-- 
2.45.1


