Return-Path: <linux-iio+bounces-9056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30FC969263
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 05:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6ADF1C21406
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 03:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1B419F132;
	Tue,  3 Sep 2024 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A92RHExL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17998383;
	Tue,  3 Sep 2024 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725335843; cv=none; b=uOsjQaGi2504ji3LOh5+96q8Hj1gikZZol7NWYY7+mChqztSn6N8E3cpPIp7Hnpny791wTyRzogIm1JCn7eC1oTTORAXZ1NknkznIOLYvTz9taJOI2ymbHxEUEt678zDzsZaYE8R2NKFg3tcezsSnQI0oQ1FC5y4kNVgxW2FrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725335843; c=relaxed/simple;
	bh=6om9AST2rsmZsprvhdjhpv4RG5zd0DiwHv96r3fWcmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omPsATl6zAXIIrXIBISReIs+82qvV0u9mcWwGIn3GQ6YROlaNiAZMWwoyPxL62T31RdBJUCZfRKWmbdSNpDfLd9Lam1PalzKdEZGLEgqWKM8paubaJofakKtvOM38OAbBQyZf1Ae4nUMMoy8ASSIetRH6U9x2u960EIkT3bHN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A92RHExL; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df0a54623dso2592828b6e.0;
        Mon, 02 Sep 2024 20:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725335840; x=1725940640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMqTxfGWsFsPuQuj6hkm4TSHO/NChkL4tIS9tJnRwLU=;
        b=A92RHExLAq5PSg2xOl4HoEFTwW92FyfBA0+w1PLcNz0Kh5dXmyTe2DQ+D2nCMEic97
         W7/A1Fqmc2dW+BNXwyPt2djCrRjM9JxQJMPBKoskBfsxbzCwPejju0cjQu1H7J6dG7Lp
         DKQjdn+OrWOwST5INKfHckTnXNN9bPGdQkoswup10M74mAUSVESqWJtwcoNu8E4i/dxg
         L/7CJnszBNhK61MORb0duza+/6s+eoRqQHwWMYP2CfdQhOIUmiY5aGBT3tIFWPusB0mD
         Haxk+oy/AlEggZGssPIb1hEsVH5//ZbA7ozBXA85boFNdkozy1cqI3eLKMdrzdxR9FZW
         PmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725335840; x=1725940640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMqTxfGWsFsPuQuj6hkm4TSHO/NChkL4tIS9tJnRwLU=;
        b=lHFeTywiNkdPtmWrJTCNEGjmUfPT8lQXvDpUY1Cl8sO4ejo/1a6CNnPi2IhJbww+Cu
         QQBrerTUuFg0IuZOVgRyoA6NIUQsS4+ksNanFrnKU9HmEenkFFz8C2dUwrSUO2UWjZV4
         Rq8GuvbDobn5B6kdKBwspkYiasqohHNwALdb1awijIrBSwbzTaZCtVPsFsvSPxqUR/KL
         U/z8xu6nA6wdoxxGTa9HRSTSiUnIOSrO13stRrY6uOmbx880fv25vha+UyaXlm4+1/Ts
         4kFIL/re2cn3LuCWKcx9e0NhRfxE08Y+ktlyeOPqTdS+LGrpyBIvgOfl91cF3B3W/4Jv
         Qhvg==
X-Forwarded-Encrypted: i=1; AJvYcCXIm2NRqN+YMBmcBHeCaGIK4XPnq/M/nNukEEQLzojmsqJATVTty8Nq3tsGIzTCA7GGp+jMfDdeuyzgHG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6oo8Gf1B+fTS/47nBgaAaDPAaBNY/N8YIwTiVvTKbn+fR/GWj
	6t0BarnRY4rzRMNPQHbjrJS1chr2SYB6nFe7ffsjjQNUIxOS77yeqW92HYgL
X-Google-Smtp-Source: AGHT+IGMGmkPnvzDi/RcsLIx8HxARXXibx603MI5vTz2eh49yiXYiYi/6CPj/TbDOhhnjVybQqSzBA==
X-Received: by 2002:a05:6808:3a18:b0:3d9:27fc:158f with SMTP id 5614622812f47-3df1c9b85d7mr14239128b6e.29.1725335840140;
        Mon, 02 Sep 2024 20:57:20 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7d22e785333sm8329421a12.56.2024.09.02.20.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 20:57:19 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: songqiang1304521@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 0/2] Continuous mode support for VL53l0x
Date: Tue,  3 Sep 2024 09:26:34 +0530
Message-ID: <20240903035636.9559-1-abhashkumarjha123@gmail.com>
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

 drivers/iio/proximity/vl53l0x-i2c.c | 177 +++++++++++++++++++++++-----
 1 file changed, 150 insertions(+), 27 deletions(-)

-- 
2.43.0


