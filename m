Return-Path: <linux-iio+bounces-14382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25198A12C61
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 21:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AE937A2D3A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156C61D934C;
	Wed, 15 Jan 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BF/oHRri"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33D14B959;
	Wed, 15 Jan 2025 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972214; cv=none; b=JsvLJ9RC/691+us06LevfKXXSd4CoQV7fp026lCeadZ+7Oz4918a9OfzUBzwI4Yqw7RDYsbO6emqCAfFsYr93SHNQrx4OWJwkFgEIyZ7xrU770TUuuBMlwMUck915vITeFam/4hFWRoGWbirARpYIyT2yJ1svbujzyStR8SzmHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972214; c=relaxed/simple;
	bh=OfKvVenTWgyY5jrKSeMk7EtiNZxRSTQm4Fd0esr3HxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FpLVu/n3SxVsamwIx+FwCAeW/EOWgEp+f99ldbxMbae4/+ZkL+5Dphf3EgJ+Vk0RCkdWCrCaHyNsKmhZ9gVFrAy0CnL5+x/DtgSOfuo8mGrHlw/KbU70XqPcIh7+avqXuK4Cbb3vcAHFyLNzs+xEy+Ab5L8ItAWge6kqu3tG4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BF/oHRri; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaeef97ff02so36665066b.1;
        Wed, 15 Jan 2025 12:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972211; x=1737577011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ3tWXahCaQRStvfHnSmG39c+4v0pNaMUd6j5ximL0w=;
        b=BF/oHRricep3xYGCN8Q4jMtBUQiDiKDFw+XGF8zQWRjwgLYltoOAeNp96vie2OhyW2
         hVAi9LADm4iD1IRWrQl0CujrHOl59Gta3aKwKkkAB0C6RlUw0699ErTA+xG+38jOBOWk
         jyZ60eGdIvrtTSYw4HD1FPUpYYQO5RyE3jAQpe7TFT5xZyhEexf4OBTxo07UqWEea1eC
         bJNDDo7LtZdPQKBZMN/8e3dhw2NlLcrR1a9SVifOIyoh8NQ4rsImUpncSJoMNvm8cOSg
         mVwDtnrBqjP1u1lfuGddDGN+dBNs2qxd13vTBJP+IT3HSz1wgU8iwlNSRdtghx/5TrlQ
         dMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972211; x=1737577011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJ3tWXahCaQRStvfHnSmG39c+4v0pNaMUd6j5ximL0w=;
        b=Y9rzDOmFOWZoto35ZTvx9dcIEfQGRLSspkDyq+prsXP8s7aFMfFaBKhAx1bhnbwcpe
         y1Yy3XRK0sC8cOBcQdZHbeFoU10uIgaegy6q8HaUp2/RcDjgbuTnM1y/PnqCH6p5O4T3
         wQ3bPErPPLwjyi61xyzqsqSfOF9TLmVeQYNSv3KiHnlCm0bx11wqHDEsohYOKS/EG8/7
         bvnLb547ddrDOVVD/dylwoobvns3y508eRAmKiO6pbBHPLrhaJOo/wn6CdVp1DHVMnCh
         NgRoB/q/a3/6ggRoTl33YsvWggbASJNjVFvSCTnZrFoxhX2o1EfNzEEwn4WaEQmFU6nH
         4Wfg==
X-Forwarded-Encrypted: i=1; AJvYcCUsXhlccYR+MZ+pulcPTJpvRxF1HWZw1x+81s8SEaDU3w0eYcze++61CATHz9Ru2lunvUKTolsysNwy@vger.kernel.org, AJvYcCWSKVG9370IyV1QGwFJt5pW5LeQ0mGEhUc34r+UQr1bpSJIQxlQ8LipGaeiwsyrFpOSx64yD2JAOvsf@vger.kernel.org, AJvYcCX/H6y5SZs1qtxWEWzJURusPU9smJxSjLzvMtWT9U2V2HqNVeg1J6bkqxUypPYPSIbP7hhVqsehnPSkjNqj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2n9knqWc3m7PNhzuBUcQwniiX9AmUJNH0v4uV76vRxXg0IVky
	9T5kEY7mHoca2Xk6Y3TpG67iFxNzVzl+FAn0Yi04DOHflXKSQAys
X-Gm-Gg: ASbGncsDVxnOPMS8K1e4RbjtsyufFiUqJ7JPmpKRPzTNWRPSWyDlcaUMluyZQTpyXY/
	Fs/n99oMrxTSTEysgyVxwanvEPo5joQ/gfkaq2nGIkXK4/cBCxQdlwfU2ZyWr3ufw5Sq8S3/28p
	xnZ56TMHQZWkzbOoyJwccechP/xoqVj20Vs14MMX5t5rOICqRZ+R4bpsBvo7TnE9Rv00qhoguqd
	tM6Cyq82FjgPpYsJnCnQyqUz6y/3yVWoejtdOwKzB2vBHIMYLMPPJnxxAv5idDRXzs6jMfIp/8=
X-Google-Smtp-Source: AGHT+IH2BEbOnyG0gINaLp2mp6Egx4vBLtHPvTZImFkY7DQvHzKraKHLBXcYDdGjY3BIURwBc1Ifsg==
X-Received: by 2002:a17:907:d06:b0:ab3:61f5:13c7 with SMTP id a640c23a62f3a-ab361f51473mr100377366b.53.1736972211082;
        Wed, 15 Jan 2025 12:16:51 -0800 (PST)
Received: from localhost.localdomain ([78.210.102.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c90dc101sm813697966b.56.2025.01.15.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:16:50 -0800 (PST)
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
Subject: [PATCH v4 0/2] iio: magnetometer: add support for Si7210
Date: Wed, 15 Jan 2025 21:16:20 +0100
Message-Id: <20250115201622.270130-1-apokusinski01@gmail.com>
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
 drivers/iio/magnetometer/si7210.c             | 444 ++++++++++++++++++
 4 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
 create mode 100644 drivers/iio/magnetometer/si7210.c

-- 
2.25.1


