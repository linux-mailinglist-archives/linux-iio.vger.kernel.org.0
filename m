Return-Path: <linux-iio+bounces-15843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3020FA3D755
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F7E3AF386
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70531EDA04;
	Thu, 20 Feb 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVHEoTgg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606D1AF0C8;
	Thu, 20 Feb 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048694; cv=none; b=l8ynQSeamHmuRq/Bl2i+rTJ1aVIWekBbr2UwGiviVu/JVNmGgsjuOAvfyEFZFXMqNvAW/rqHlaWNruzwKd3fy57XXYMGL3EMyotTXR0VbFNeZq4r/KsE3udDgoIiBWKFYF3Vc419Vw5WepdxWp8nIb37Cf3cbxMRqrBTuUmssfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048694; c=relaxed/simple;
	bh=kugZ4ICQ6eJujuYRRoD5lTeRhWACX+VCNrkorfJW3uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S+16FZ4PJaBifaQ4r7XHU7yLPfKcfeLZokN5MyM+xwxwMsFMAPmQ9OJOYH1UBImjuI1XV7m8miTxRHGGHhmw9DDSHEOCxxLGDxsnBsrcA43FCKDZvhFxI03Chhea217pKlHCHprPYuORzdPPNEtQNGAje61yGeXmTPEd4VAxCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVHEoTgg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb9e81c408so13325666b.2;
        Thu, 20 Feb 2025 02:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048691; x=1740653491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRd79G85Q0LlojAdRFjUNytWpgLl02au24VSRlRs2qk=;
        b=KVHEoTggEtAy4mx5CbZ1I9Lr3OyqWGZDDupIZybcE1n7C8MPOVGOxcJsqhmyyNl913
         SqX8fmb1gADcJ8FVVjRN1q/A5joyareaLX+XlSOVud5F+hCAq6o3omkSRFYo6ZAg1VOo
         HWs3UPe/4JbxXm30INlbLTbqThzJ6ACUtkk0odp8TwPcEEpnU5UkPHEg0wsgN2HSYysw
         qjJ7qoD7SWjyh40L5C1SN6WnGFV5TfuB0boYwjdcpNx5v7eMK8zZ5+Q6GlDa+/TZO6N7
         oW9Pt9NqeVVEXAt+gH8Ec+Jc0tRFJ7HWz4qeuYMSjnnUE/JZkYK7rrPgl97pbO5BRr3v
         Z0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048691; x=1740653491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IRd79G85Q0LlojAdRFjUNytWpgLl02au24VSRlRs2qk=;
        b=r7VJFlkIQ+oyCJJzsv0cSL7Xg0GItdwJCD0YMxexCs9aXnw/ltzY72fEI0gTOLUePH
         Ek90AZYPkbMF5PT0SeIfcpmC1azoxHzRj1VpWMW8ZsGlhyeD4+FtMZqb9r0b1Bi+jLIR
         TPtZrWAnlU9gyMAnl/2WdRdXKqNre68WFi8zyBR4LWUNnfQte7e/VhVNJARaDgQX4Hfo
         XGpeo40yIG2OJjwiZIdd12MFgscP18uMUF19wzJZBHCXQrLe/lIpDJdn8XAgLuEIkCQ3
         /jng/AyU5NFRMd8qXFuNB8PAWRrUbzc2wQTqgl0lxEJrq6guqNBmV+bg6cxtioXniEzx
         6qAg==
X-Forwarded-Encrypted: i=1; AJvYcCWPWH4FqO58dthp5t8g8FOw9XTMjVEC9dG7I013hckSP3e8kr4ss+DpX3tVIymQDyTmuJlraAe1xY8IsIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWusrpL1ut9LhehJTjOqyoKu7gPo5OoPLS5xYGt+lADT8Kjs50
	cDMVriBub59bYf0B+E4iWLlu+S5jpiHEmfw9sy/Ojh3TNThyc/IlNM42XPYn
X-Gm-Gg: ASbGncuEpgsL7Eb93cXXAAST38jh4PF+esY9jYVO/jRtmG9oN8b9xUR0MaczjGtouAA
	r1KTr1ecgmVvJExPnXTvDTNr693HFGcS9OIkuvKiyfaohSq1ylvOvizVEPK0LHhLXe22rUuRpuU
	oTwQXljQtw0GNJh8f3Pgqh8egS6gQvbvYfhW0Z2RR6OTBoj2rbhqgOB37V8K5pnl7dU649XR8EX
	Dyl1pZcWe/AUYt4c0KYwt9pb26TtMqr+HEzOr/gDmmwVlCmYbP16NsRiLaFufDS0p4jCQQFfWuU
	blVG5ngvg+UK/OJsL8nyxc2t1Qb0cr25lrOuv9+JXRTOAmux9SFRy7/WUUj3u6ue0orqxA==
X-Google-Smtp-Source: AGHT+IE4hqobH8+b7LWMRSgrP9ZbrPbi2D5lsBSzNGgOgZ4XGJj2X49htf2Noo8lcu0wjPkadcjwWg==
X-Received: by 2002:a17:906:dc8e:b0:ab6:ed8a:1593 with SMTP id a640c23a62f3a-abb70b49b86mr880405166b.7.1740048158395;
        Thu, 20 Feb 2025 02:42:38 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:37 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 00/15] iio: accel: adxl345: add interrupt based sensor events
Date: Thu, 20 Feb 2025 10:42:19 +0000
Message-Id: <20250220104234.40958-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add several interrupt based sensor detection events:
- single tap
- double tap
- free fall
- activity
- inactivity
- sample frequency
- full frequency g range approach
- documentation

All the needed parameters for each and methods of adjusting them, and
forward a resulting IIO event for each to the IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v2 -> v3:
- generally introduction of regmap cache for all directly stored 8-bit
  values, specification of volatile regs and cleanup
- moving thresholds, unchanged values and flags to regmap cache, in
  consequence removal of corresponding member values of the state
  instance
- removal of intio and int_map member fields due to regmap cache, thus
  split of set_interrupts() patches in two parts
- rework documentation
- rework of ac-bit comment

v1 -> v2:
- implementation of all events (but tap2 suppress bit) by means IIO ABI
- add sample frequency / ODR configuration
- add g ranges configuration
- add activity/inactivity using auto-sleep and powersave
- add dynamic adjustment of default values for
  activity/inactivity thresholds and time for inactivity based on ODR
  and g range (can be overwritten)
- add sensor documentation

---
Lothar Rubusch (15):
  iio: accel: adxl345: reorganize measurement enable
  iio: accel: adxl345: add debug register access
  iio: accel: adxl345: reorganize irq handler
  iio: accel: adxl345: use regmap cache for INT mapping
  iio: accel: adxl345: move INT enable to regmap cache
  iio: accel: adxl345: add single tap feature
  iio: accel: adxl345: add double tap feature
  iio: accel: adxl345: add double tap suppress bit
  iio: accel: adxl345: add freefall feature
  iio: accel: adxl345: extend sample frequency adjustments
  iio: accel: adxl345: add g-range configuration
  iio: accel: adxl345: add activity event feature
  iio: accel: adxl345: add inactivity feature
  iio: accel: adxl345: add coupling detection for activity/inactivity
  docs: iio: add documentation for adxl345 driver

 Documentation/iio/adxl345.rst    |  406 +++++++++
 drivers/iio/accel/adxl345.h      |    7 +-
 drivers/iio/accel/adxl345_core.c | 1449 +++++++++++++++++++++++++++---
 drivers/iio/accel/adxl345_i2c.c  |    2 +
 drivers/iio/accel/adxl345_spi.c  |    2 +
 5 files changed, 1762 insertions(+), 104 deletions(-)
 create mode 100644 Documentation/iio/adxl345.rst

-- 
2.39.5


