Return-Path: <linux-iio+bounces-14158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2944FA0A856
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBE6165269
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 10:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1221A23B0;
	Sun, 12 Jan 2025 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnI244PB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7261465A5;
	Sun, 12 Jan 2025 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678737; cv=none; b=XmEIU4fXd6HzV8qSZZHrqi0PQwbsf/swF9ldkN2T/ibRgZ8GW7l/aQo04auAhFDxh8bE5/jq7YNRq+G6W0iMJZ/vddBLDyTeHFx5fAcayvckGv60OSzPqUa0MJcXvgAAyNa6wjmwh45cb1/BvLH+7ZPPtuncUUcNPjy1Cljiiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678737; c=relaxed/simple;
	bh=zK1x++ysUBmorCDIrR+n3VDLWp9TumK8oBRwvwBxrQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XLdJsk11vkLZANR9xCKBSje0wSsOBriBL0RaIsnA6lGmCS1srk2E3QceRecCC9wBj5eTRftbDV3WxRAOTg8YuhQCOHn3tXdjUOOjy5l4I2iI+Dq5zFoErMYQNGa6GyDdT8qw0Q1LPdvK7c2DWSBuJ7xcHTALSdqVOlfZGSEXEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnI244PB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso5607409a12.0;
        Sun, 12 Jan 2025 02:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736678734; x=1737283534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9L9G7n0TV7I2OnTl6kkf/pJM8K0CLAoeCtAKCwMD64=;
        b=XnI244PBEovuwHs9aE4t0cWG5Bkk61AzQek5mn8iStG1cLjUR31tANM8fJhazmaTQC
         5xOT0lrgTIPyNTv0zCADA9gISagCrdPBVWdSqQiYWBZn7h2DB86zid1+ZFJfGlm5RW8+
         /4fQNDP2QzOYhYSljhFYD3SZlMvhj5AhHb192QG4hnRTtoDQCNGDTI4J9oVp3zETs8aL
         JeDQiyR/6wLX8tAKpfTTJmIFIru8E6nf8t78OYM5pkftjIdEfSdmdeIwI++WJ3d0u6mK
         89maus7waFFhx6YLxLoyl78r7sY7M3KT7DdQmqY1oGGCsqEO0fe0993S3E3JuunKBs0d
         pQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736678734; x=1737283534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9L9G7n0TV7I2OnTl6kkf/pJM8K0CLAoeCtAKCwMD64=;
        b=elI5QKEsnLpEH921RG371ISxTRKUvqyi/O/9vLoLPxf10S6vR9rNy2A9iIgikYJ/HX
         DMNkUfNW4/fQ6irdc3nqD3Iz98UeKC6lrj4K5Cm8w+UXw9Bv10ag4eaXjPGYmeaZhjtm
         b4pkoda/dti6tH7MVPJfnCUTh22MkR3x8hE6/2pj//9LQm2tur9ZpqGxKNNUNBQsFaPX
         Aw3WePwaXThCeSL4DqESgwPKYjvATaJ7m9MX2hVH7R+O8jyrbcGSwBZVYPOb73Z4eyke
         9JvIx7MOvnpf/fRZYSJVOfqkY1MoojWoZfSxSXNyICgw1jDJXw1sHJk7GRn+LB/1Erhx
         Y54w==
X-Forwarded-Encrypted: i=1; AJvYcCU9PzsTAeZdQsPUMtrLgvredIvNjROt35FVtUK0EQCCPylPM6A6UfDJsOEX6ZxDEWVJslK20zS1JPc9@vger.kernel.org, AJvYcCWaCL1rjZ+k0iK1ulcPtAUUcmn1JWuai8ud2Wos739ARFPIJyjrRPIq1/rVA5MD5g3scl4+0ooibuGJMuFk@vger.kernel.org, AJvYcCXdcZwVO8MjAe9ZNM8V+E9XAqwcCdC/+G2jcrHF7XEPvedsL50UbHP49YXLmOH3gaE3vynM7lHUoMXY@vger.kernel.org
X-Gm-Message-State: AOJu0YyexSmBV2uvKyTRt06rFxQyJTmsM6A+TEpC07mkLOAvhg++xKi5
	Se2p3ezN6Rv5UbFT1CMfxiwcffuQpVpRQhYjRVWi9TZGQXXoWIPe9PvD4Fhx
X-Gm-Gg: ASbGnctdl9FeTJm9/9Zn+Dc5Qt+kJ/rVKH6mwmZR9kw7jgve8Y8L6YrWdjCntQdlVyU
	XZ5zCHmHV71jB0CsDMx+8G/h0KSqlAU+r2w/uDiAKOScEsCwtxYZicWj+Gkb+k2RGYFgE6nOZrE
	WiUM5C7C8qcGHTyrnX51T+eAuZyEkzqBkDKFGP7Mkjp6+1xNtxViV5SfKeQq1K2+/9kAncIn2Sg
	mMb5g0LPHRFcPAi/Xb6Wo6zHsl/MduGevzQIQUumaORd4wreQzFaQ==
X-Google-Smtp-Source: AGHT+IEDc1A+EK3x60FuigXbf89jcY7ErP5KUabJHovzaNGNjDaI7X04mWsm2IRvL5kFDtyx7wN/Uw==
X-Received: by 2002:a05:6402:40c6:b0:5d0:b879:fa36 with SMTP id 4fb4d7f45d1cf-5d972dfb3cemr15511225a12.7.1736678733508;
        Sun, 12 Jan 2025 02:45:33 -0800 (PST)
Received: from localhost.localdomain ([37.161.61.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c4b2fsm3511822a12.29.2025.01.12.02.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 02:45:32 -0800 (PST)
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
Subject: [PATCH v3 0/2] iio: magnetometer: add support for Si7210
Date: Sun, 12 Jan 2025 11:44:51 +0100
Message-Id: <20250112104453.45673-1-apokusinski01@gmail.com>
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
 drivers/iio/magnetometer/si7210.c             | 428 ++++++++++++++++++
 4 files changed, 489 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
 create mode 100644 drivers/iio/magnetometer/si7210.c

-- 
2.25.1


