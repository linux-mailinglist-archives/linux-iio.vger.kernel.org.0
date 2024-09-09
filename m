Return-Path: <linux-iio+bounces-9374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1CF97151A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 12:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309D728350E
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE991B3741;
	Mon,  9 Sep 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XePFzW3C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3248176FDF;
	Mon,  9 Sep 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876965; cv=none; b=G067ADkbvHuD29ZgvAz50QbmH2JzBRKYoYxLUHcmgHHblfi+UJwHGn5FLp3O/46tkCg/LIpJkok0GOAHzKvYH53lqyGqmkTlCHQ+0Xv5rbiByEOobfN5rHSTkIoVqJPXUFzMzRSI9Jt4QqXXcWVZwhKKf73VSdeniZuayggMUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876965; c=relaxed/simple;
	bh=4ApHHy0FhFRT+3qqx5DEpYivN6cipZGLA4wDAZDNJY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPqKvrBDupc0rj+9BEW8ZOtMQrydaYA3fltUwpb65oJcclT+aFTdOnP1ZOLQCg4dgN3rWV6DW4QQj2m9rlX4p7F2+EXeUYClcka8Mcms4wkIMdfY3pu7yxDOg5Y35j9GpE+QNobtrn+SH5j4pbS44Z27hH+rnY5ui9omEROAaeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XePFzW3C; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2055136b612so49455545ad.0;
        Mon, 09 Sep 2024 03:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725876963; x=1726481763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvEMJ6/8O/qOGcpjfVTiHC2xWm0Huc/5UEOiGlnQCsU=;
        b=XePFzW3CN0YvMnMk6esPIuIShmzxnvaJMe5pG7KQ8qMVS+g/wZdVowaBk/RI1PcNFP
         ueu43VuYr/xy+Zl4j2iIyOczUTmeRU1Y5m8d6umsh2eAcl9oM/IimLjLzKjisy90ITwv
         NuDKAMsXw7bFNj37CAHSqU1CeOYVZ9llbrICle0O0xCNjBODzQl3DeY/P9+RqbN0UYNo
         t7eCnFNU3REv0L+vFSQPU+o/UXd/omLuQgiWE7Ay0of9OiI4TaLkHAFMSOWFutLPkpzD
         0VnqaG3B97IkcKGZ62eDScnMLmp86W+MBVEZPzvB4CsLUMYUJozGLRK1zCiEWjnDsuN8
         aG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725876963; x=1726481763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvEMJ6/8O/qOGcpjfVTiHC2xWm0Huc/5UEOiGlnQCsU=;
        b=Dnvs1v0D/DBVdLyc0t2UcwnMZvDpfxzg3bMwcQmQ66syTkoz75+HTCbobWM0ENu+dn
         H3BOi/qLk8KkNiwfeX4NgMPU1GDQ/0Z1DJSulJqE83VcyZ0BC3NGCjfbnfpZjX2f/Z8m
         cGNfWoxVzXkhvWfTbKND7tungE/EMxWcvc6YL5eGV3vYZc4iTx/NgCospDPAVjpxScTk
         3e5ywBSIxAeqSdtz4Qv/xdIGgIiX/bplV7sGy3F63xOkdNFhl+g1kDOJEUIv4QdSTasX
         0Mfqj2GrTs9DMjm0cbTnRoo5c30R2NnGLdA4lKdOesi1oEExK1cgQBSa2ibQ+tAk9hr7
         9rSA==
X-Forwarded-Encrypted: i=1; AJvYcCW0zrcvu+Rz4IBhsn5mVZDAdW0fERANSklkl+sQ/V98640KHkTTRR9jMDsTM5iN/7wjuLrs28lDI2Qfl+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaY5Gpktni32hJeHXzON2FUSJMYrgzqahUyMQiiie3gQHzSftm
	5+38wAya2W4b4owr4CDeAf7GVEg3yoP8ebRHoxSSJJiMjrUFP/gQ/UBe249CPDc=
X-Google-Smtp-Source: AGHT+IHJDWRSkSOu4B1+I2gi1OxWgJlDzNPNQe+PeoGA7haLwDxnsVix6PcP46iXUswzwtOTnZbhbg==
X-Received: by 2002:a17:902:ec84:b0:206:aac4:b844 with SMTP id d9443c01a7336-206f04c9142mr144331285ad.6.1725876962589;
        Mon, 09 Sep 2024 03:16:02 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710e33456sm31219885ad.99.2024.09.09.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 03:16:02 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v4 0/2] Continuous mode support for VL53l0x
Date: Mon,  9 Sep 2024 15:45:05 +0530
Message-ID: <20240909101508.263085-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for checking the sensor ID by reading
MODEL_IDENTIFICATION register and seeing if it returns the value 0xEE

The second patch adds support for continuous mode in the sensor by using
buffers. We enable the sensor's continuous mode in the buffer_postenable
function.
Replaced the irq handler with a threaded irq handler in order to perform
I2C reads for the data. The continuous mode can be disabled by disabling
the buffer.
Added a trigger to the device for the continuous mode. Also validating that
the device uses the internal trigger provided by us.

Changes in v4:
- Added `validate_trigger` callback to check that this device uses its own trigger
- Refactored the vl53l0x_clear_irq function
- Minor code cleanups

Changes in v3:
- Added "asm/unaligned.h" include to fix `-Wimplicit-function-declaration`.
- The above error was pointed during testing by kernel-test-robot
- Link to v2: https://lore.kernel.org/linux-iio/20240902122557.129013-1-abhashkumarjha123@gmail.com/T/#t

Changes in v2:
- Added a trigger for the device
- Added a poll function for the triggered buffer setup
- Performed the data reading and pushing to buffers in the poll function
- Minor code refactoring

- Link to v1: https://lore.kernel.org/linux-iio/20240830201627.298264-1-abhashkumarjha123@gmail.com/T/#t


Abhash Jha (2):
  iio: proximity: vl53l0x-i2c: Added sensor ID check
  iio: proximity: vl53l0x-i2c: Added continuous mode support

 drivers/iio/proximity/vl53l0x-i2c.c | 174 +++++++++++++++++++++++-----
 1 file changed, 146 insertions(+), 28 deletions(-)

-- 
2.43.0


