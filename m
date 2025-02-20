Return-Path: <linux-iio+bounces-15878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D20A3E196
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 17:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FB23A85F4
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355C1DFD85;
	Thu, 20 Feb 2025 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juv0yxr+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4AD212B14;
	Thu, 20 Feb 2025 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070216; cv=none; b=gNpMNaXD4bymAOF6b4q1Ktaq8/P0b4at9Zf+Np9Rmzhj5CVp+HKnh0X0BF0gTtl2CvcWv/JCTJIvU8IITOwECXwPXbe5Qktv4+IPd5oD1C1T0y7+ZHtIGDqkOentFdvMa+TsOKK+8I6q0z13hxmP+y601O2q3nUOudyUCSWh5Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070216; c=relaxed/simple;
	bh=+HC9QMvR8vysJeTH/xwHBeIEAWKsrKoqP7CwYdl5hgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZL6wIs60tCcZ8AhG0VCKQU9ni2rONlUHp2ZgNybcod0LZe9K8kJbsys565e8vfeV4HEUGCnZGh4pps+1xA42RRdlMEKSLpLwVdkaSjhCjck2PkT72jjLWAdfJAJ+Bk91QEyaOdY22I156DYIQdLd63gLtv7mj6SD5VqObmUGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juv0yxr+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c8cf98bbso24841585ad.1;
        Thu, 20 Feb 2025 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740070214; x=1740675014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bxc3Pxu8q4ngPD/02ugz12qs2E/R4ww7P0K3RFpHjH0=;
        b=juv0yxr+mpa0WjToZ7Ss38YJqfpfzbyUzCj7zP67SpmzBzO9GrIy2I7SE3i68FmLGN
         8gBpDedUGFj3ih9iDtKBy51cQVIgChXHut2sM9iVcvyP3AhWgoFCpT31jI5OmoAF2/tQ
         7EwpjVo0YrkQHotbhzyszzIeGFXJ5AQHcK+Ksx5ND92dynW4bBjIoKugWQ+5pTN6ASup
         B+P2b9G5Mqkza67qNo4fHoZhGi0z+fn2DUVs6ULjNQaeALbGtiVRJNy5Eug9X8u2XDUd
         CdMR1ynPOUkwAoPRbXSkugtT34y6zgUzVBqgpT8BGA4Inf03UeY40kUKudPj2KvMZBOk
         mirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070214; x=1740675014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bxc3Pxu8q4ngPD/02ugz12qs2E/R4ww7P0K3RFpHjH0=;
        b=ADHsUrLowEIz++vJKJ94K8XOrORikGCopO2dlL234au/jVtQNYhwvLEWbIUyQv4kuE
         vwjBoQfmGewo/XIZMbz5pvIKkIe5sO+G2Zlp6uTpMk9iplljwF/8dNlUjeVp/k2xorp7
         BKdZHLFNUrS8jLLqIrBWQLrQKOCli39jENHqs8E1KCefEDrL18e77MxGckLmqsDfSfnh
         ao6eQ/DxPDDzw7FeU3hPoAAGtKUfq6a+C8qEqSpCrYbQReM7R1mdvLhesfh8hjLehZ8c
         B5KXfXQ+617l/8XXqgBP+rtGCEISu64HRqZsK6YDRhl+IAlvTLGJjN3Pre9Cv/NXwiZQ
         NPMA==
X-Forwarded-Encrypted: i=1; AJvYcCVl1ipUy4yj2EJLbUtMBzAcNRPL6Ggxv3UVq2ko9ZD9D7H0mJGJA9FkVdP6mYP1fE4c2tauij9wT7g=@vger.kernel.org, AJvYcCVx8XVsvvRQmKVz6PNkoqjoIaXo9xVP+WP4OX/SRqloSU05hyoEwOrmASx/u8tECuUmDBvsOm9DP+QIgQs6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7GWeA6pd7DGYO+oZBLkg/Rrirha2SPaHFZlLLP8zPh5kTS9S
	8+i4Tnoh4UI18+6CrTRxZZv3M6IdmDVIeTFFIkVbF8mVFTqmw5uf
X-Gm-Gg: ASbGncsofeg6WPHy7YUIyy8juY1QvGRN0BmuBJMSSpzgjN5I4fI9bxK86wKYHLL3FSt
	dtDShUwpN2CeRKsMT6X7V1VCN5p462J4szOPb1fth9f3GHoH7TQHyYXz4L/0pm4BBHTWsmW5nBS
	aXS/8RIHOyXFRSTDExmd196jfu5IDlFeC9FIfddxJ33lDQW+Lrr0uHjYFzeuy1d1PLGOyZBV5Ae
	8cH8rp1TbWw3dAsPeQGze34HVfjYvI5YAXgOLErcjkQwCK407Jy4p0iCoKb8XKwnHr0cC+6Qcrt
	FNeZnQEj7IaLhEZ6
X-Google-Smtp-Source: AGHT+IH2ksNWyTKN9I2DB8zyRKGvrv/FMBo21GjrNiy5WJAqRpd15pIwLsUzCvy10usK8HLvd3MWbw==
X-Received: by 2002:a17:903:2b0f:b0:21f:f02:413c with SMTP id d9443c01a7336-221040b18a4mr349033335ad.42.1740070214388;
        Thu, 20 Feb 2025 08:50:14 -0800 (PST)
Received: from arch.localdomain ([2a09:bac5:cb26:1caa::2db:85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d558fe46sm122454895ad.239.2025.02.20.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:50:13 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>
Subject: [PATCH v2 0/2] iio: gyro: bmg160: Improve BMG160 driver with of_match_table support
Date: Fri, 21 Feb 2025 00:49:59 +0800
Message-ID: <20250220165001.273325-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set enhances BMG160 gyro driver and improve device-tree compatibility.

--- 
Changes in v2
- Fix a syntax error (a missing comma after the .of_match_table = bmg160_of_match).
- Fix the style issues found by checkpatch.pl.
- Link to v1: https://lore.kernel.org/linux-iio/20250219150254.24664-1-jerrysteve1101@gmail.com/
---

Jun Yan (2):
  iio: gyro: bmg160_spi: add of_match_table
  iio: gyro: bmg160_i2c: add BMI088 to of_match_table

 drivers/iio/gyro/bmg160_i2c.c |  1 +
 drivers/iio/gyro/bmg160_spi.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

-- 
2.48.1


