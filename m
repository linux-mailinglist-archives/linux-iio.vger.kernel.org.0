Return-Path: <linux-iio+bounces-14047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CBBA069A1
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 00:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C55188812D
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 23:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1F204F78;
	Wed,  8 Jan 2025 23:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmqFPOLf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0792204F6E;
	Wed,  8 Jan 2025 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736379934; cv=none; b=txfq7XCyIj+zOsowghmVRLKegwCuwhNqLXY+twGrqmUYAjJ4A7kfcKdVUA7mYPMxHW9QO9X0nkvYX6hG6eJKwxuISDFoy05U1QyZQ9XgJYmeRwpgU6ZWMRKWOnq1sMoaTrthBr5m/iM+Q2jnYvXbjr155gUFfeVfsbWE9B9pJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736379934; c=relaxed/simple;
	bh=pCRonceF+3kKidCUGHFBSWeegu0kSBwKhIfjOTWr0HY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=naa9hmfI/Qx5/6v4FkwpqZg87licvZHvqsM46QjpU3spATtGq+6XsWFE5pE66+H4LvKNrUlh2HiUaOX8Dk1Fx4vjpoALArJQQvgToiNRj+ACZ0bj9K8kMPyygp6F4ivBgBVpzXYNAvwqP4PsgzOkEkeakLInLrXR6DzfI+shsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmqFPOLf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d8c1950da7so452470a12.3;
        Wed, 08 Jan 2025 15:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736379931; x=1736984731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SECkPKJp7olf8hsN2/MKwLopk2Qt5x7gzI2g06FByEs=;
        b=PmqFPOLfHKwWYtQ90oerl3BjJ6IqNIBunR83w/1hXHBzUaVq1gkDaNg/iFeQO8lBcw
         ynsmxXUQJVU5wzJxbXC2TcXR0n6rbqiuCektb+zyQwZoSApuvVdiJhYSxRAZdNlQw7Vy
         o1J9+fyafoaNlgfx1lM+yx/GG68Hgfb5n9ja/nPMUlJLkXXwNJe6kqd2BJPBwEhqTLc2
         6NGB3lvqKXlDFIBsLWLUArzGTKxLfuKLxwocy9MKXV7IsIyeA0Fv4TkDzqu1qb5m1PWG
         mtfMeJWjvY46sgV6zRua65eTrKlnazwkXqL+5QOo7K8ICsMi04/pcZHwgMmq5Hj/F7Y6
         bA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736379931; x=1736984731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SECkPKJp7olf8hsN2/MKwLopk2Qt5x7gzI2g06FByEs=;
        b=YUpIqWclDQ4cpOCoEV7ZiqM6EoF1UBnfq4cnC4TrpaX2GAdGIpFRJRpilLj7OsdF9g
         i5EzjLF4huf456u/1WaWfTJrZBQpyacRLHwLxmlP97BXEhx7cKPxBPJapGoWd5VStkrP
         H0WIY9dxUtSO+otj208ezGC/isMh3vMbCzwXmsWCHiyWgHLutnQZ5IhNrag0DtfIKInv
         bE5ERjV+DekgGa8WYseJsaxT/zSbVn8y4eC8ED3H2fXc0j02mqb5BOJ6pW2iSGUJq2ZH
         rYv++zBHLm0bWyfCVviq1ApTg631DfCJKf9oxqdFxQrazAK25ZIa0+rhb3LWNP5pDNpz
         Lp/w==
X-Forwarded-Encrypted: i=1; AJvYcCUR6pcpKZ09lGQDdrpasdFxK7TrC9zhEV+YMdMmXIAw0QGR6HdKXGkRMBAhcPO+/Hvb8+kfeLijZjIRlVWT@vger.kernel.org, AJvYcCWzum23krVDVAXOFt+JeXqNfFxt1xfDGwuOxfGISGt7Pikptlqm88d8HS4AZ+XcTTh45Jt5s1gchtfR@vger.kernel.org, AJvYcCX5B9lMQ1ZNkxAMGJUg/Lm9Nst4ZDT6fKxavMcC6FRbaUcYNrEN2xPSMbUPwCuspDiWVzIw8UI66M43@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cj15+H9K0NGG0ARsjjafhM4qnJUbHZTsNudaBB37r0zxp5H0
	UAX0cV8WOE6j1KXWlQQNwIfuIhfJWWi5Z3Zpz6ryzt6I6UHwAhrI
X-Gm-Gg: ASbGncvUCdyGRS1A0p+HZDpclA+6k9Q5zs8CHs2ALS/5ket5X64c9VcCDq9YxF//J4I
	NBAr8CPFjGhOVJDwr2lwhX2IMnN1zSwMy1zNbjR6GAiAnUAFtSVZ6WbrRg/Uu4mSOAJIT0vSLHa
	Yy7VI8W2+aBfCsqX9LO2J3mdXYxXCmTnWaYQlhpdglGYLrVTe0IXaM1Q5/hb7a1hWImPSpShpvg
	Fzv40xdYDEF9aUSD878vZ6iw3MboRTEpbqRdMl9Psai50GptWCJyw==
X-Google-Smtp-Source: AGHT+IGChRua7rl+mRK+31YnwCUUW6Svgbv5KjGhWy5soOEQjoWl94wrDlLAsfLDYMmdeA6iy73IAA==
X-Received: by 2002:a05:6402:5205:b0:5d2:7199:ae6 with SMTP id 4fb4d7f45d1cf-5d972e04bbemr3756490a12.9.1736379930871;
        Wed, 08 Jan 2025 15:45:30 -0800 (PST)
Received: from localhost.localdomain ([37.161.103.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c32a0sm3108a12.44.2025.01.08.15.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 15:45:29 -0800 (PST)
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
	and@kernel.org
Cc: apokusinski01@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] iio: magnetometer: add support for Si7210
Date: Thu,  9 Jan 2025 00:44:09 +0100
Message-Id: <20250108234411.882768-1-apokusinski01@gmail.com>
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
Hello,
Thanks for the review. In the v2, I implemented all the necessary
improvements, the most important ones being the `vdd-supply` in DT-binding
together with a regulator, changing the temperature measurement scale to
milli-celsius and removal of the `otp_lock`. The lock removal could be
done since we read the OTP memory in probe only.
Best regards,
Antoni

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


