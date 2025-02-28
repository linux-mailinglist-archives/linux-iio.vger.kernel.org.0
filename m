Return-Path: <linux-iio+bounces-16211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522DA4A66D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 00:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670181892934
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 23:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0F1DE4FE;
	Fri, 28 Feb 2025 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZOxRYTI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F723F372;
	Fri, 28 Feb 2025 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783838; cv=none; b=oouLiBNwkTo5dU008PRaNE/4OvmTKU4y5vecP9Ej4IjaaEHDDBIEziatbjxpo7XafN3Vop6XwmYh4PYdmnSeyPojhlEnqsAsPAqQTJ9ybbjMO4YjQWcboTK+LhyZ5c/zZFtFXgKz2xOh9uEvL1UciIQ22f7xBs+krCljvkHy6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783838; c=relaxed/simple;
	bh=HuoDKu8oWhsbb02agi0QM3ODicADQvb3frWE7+N4Yi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NKVvpY+oesVvqrY6cvbnZP0znTmW2v4dpSFTMcx5ePuV+UGoi9rsBTMLLRkOXQ3gKnQf4ih1LW78dcdvH8pR1/Tc1vz8SH1NZPI6Ro+ASjKpSRkxX4gxba0dInUYOF5NgjH9+foK61inlNt+rA1l49/gP8W/GGI21DJJ97qa40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZOxRYTI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22382657540so3551775ad.2;
        Fri, 28 Feb 2025 15:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783836; x=1741388636; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxRs7vpliND5ZFPz559p/qXP+L2Z4Elvy6BRWrTj7DY=;
        b=QZOxRYTI0sysj0cHFBay20vKzpks0lymWYMFPNtL0qqOAxI2RwRTgZj1By76dNfcce
         O+evI5I0Ek47Jxey5g+fwebVPXNazYIbbfo5EaHy+zNtrrin+uBaCfXBlfP7bPEhmy+q
         eM6SbMx3ILzVnxGqXeQdv8n1+H7CSW04/1TDmO8IGRZygJ0CEvqotH77YWBu9TSy8SOR
         YvBZlvQDqsTkTIdA0tcWdzqDQl16Oy3v7JlRn/t8f4R7O3z0yaNKRnnvNGTX4HvDmWta
         A1sI8Nr2XJ/TVuDMn6EvGebSvEURG5APOwhfRLq8TcQBGSdIBPvu9VXxjGVTmshl/18S
         ji8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783836; x=1741388636;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxRs7vpliND5ZFPz559p/qXP+L2Z4Elvy6BRWrTj7DY=;
        b=itrP9wXKCloTtpzX2P/cxbqzNCC6WT8z4mxJ557+58fKg17wHPbS2WMsxMOyRupLMZ
         pjT/SKj608Bz4+P6tIk4LnMwzKRtSObMIOkOkCGvul25wpGa+AjL1Ob5WhVHsu/kRdmb
         5YZqvJPbAfGMMt71MgfIr1Wzz3EzhfZpDS3/iTLkRK4WGmrniM4vAocf2CnGxK1pUufe
         DGspGEUBzSn3n6G+q6F8iR783x2jx2f5kNyJrx2Bfu3X+NaDcHsZIKP8R6T7KlEZzvIq
         vq5NLbtQJRVAbWia/VdaV8DwLpAfZZrs4xEuHHSvf4wIyuifM9f6DQ5X3szwcXUjwVMZ
         S8gw==
X-Forwarded-Encrypted: i=1; AJvYcCUUyhWEZJtnyPz9g5GkzTT7Ttei+hIuo5Gp8zeyz8iv0nm+yZJujeK3Z8LvDiLmUfFPiyZcl9xfwucU3CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeF3YyHrq2qGVWOa+iLK9eac6l9zmrEUdM3T2qye2roZSwxccC
	3KCsqUXxJlwiluANcxTAzAz7N4+TFi0DsntuKDY3yI2bt8L9so5L
X-Gm-Gg: ASbGncv+CbJHG9h0CCvvDjE9sqOPLT64IKK4XBVANU7Q38HgLfXk06VkyMpGiLl0s9f
	lENvBnKzeRE0hEyboy4/u+moCKdlyJHhTH52cRjKvTYqo0OFNrT8GXtdlLSJaouptsb3VgxiJ4y
	Ni9r/94z2TQmIiFV+Dn82HtfA1MBBj7Rz3+Lv3JW+bPpH8j/Du/0uYYO1r9EhJ51nsojzac4GHw
	YuSVgBrzVevoJ9TdWJbmbCADzkJDTvzNZPKTtxuj6VyQaK+c7k/ltpD+tJ18KJTqv8A1KAUNYxR
	GCrIwC36jais2pJEIxrD5VKa/8V/Z83f41N+cA==
X-Google-Smtp-Source: AGHT+IELQB8FCur6rZ5C84nSUjHDY+0Dehzm+1KmH2KHYP0gUaQXaKSJMmM86XXytcV9TslFwUmpWA==
X-Received: by 2002:a05:6a00:3d47:b0:730:8e97:bd76 with SMTP id d2e1a72fcca58-734ac35f72cmr8010670b3a.9.1740783835524;
        Fri, 28 Feb 2025 15:03:55 -0800 (PST)
Received: from [192.168.0.107] ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf230dsm3974875a12.8.2025.02.28.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:03:55 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Subject: [PATCH v2 0/3] BMI270 data ready interrupt support
Date: Fri, 28 Feb 2025 20:03:47 -0300
Message-Id: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANNAwmcC/23MQQ6CMBCF4auQWTumHSAGV97DsGjLAJNYkNY0G
 tK7W1m7/F/yvh0iB+EI12qHwEmirEsJOlXgZrNMjDKUBlLUKtIdWi90UShhw86QdY0eDXMN5fA
 MPMr7wO596Vniaw2fw076t/5lkkaFumkHRdY6U9vb5I08zm710Oecv9y1qTGkAAAA
X-Change-ID: 20250219-bmi270-irq-9a2bc41faee3
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740783831; l=1149;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=HuoDKu8oWhsbb02agi0QM3ODicADQvb3frWE7+N4Yi4=;
 b=J34qorUM5/RM1gXGI7dE5favI4WtiFEMtUhuVOYIihni69UZ5FwlxGP2nCh+wic04Gad1o+I0
 8Va0d/8JNzDBWcGfkndEQPpDx2uUFhcmNwxDczAe0DA7xA0vFauR/rA
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

This series adds support for data ready interrupt to the BMI270 driver
using one of the available interrupt pins.

Additionally, this series includes some cleanups to simplify and improve
consistency across the driver.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
Changes in v2:
- Patch 2: Updated the commit message to clarify that the variable
  'bmi270_data::data' has also been renamed.
- Patch 2: Fixed some line wraps after renaming variables.
- Link to v1: https://lore.kernel.org/r/20250219-bmi270-irq-v1-0-145d02bbca3b@gmail.com

---
Gustavo Silva (3):
      iio: imu: bmi270: move private struct declaration to source file
      iio: imu: bmi270: rename variable bmi270_device to data
      iio: imu: bmi270: add support for data ready interrupt trigger

 drivers/iio/imu/bmi270/bmi270.h      |  17 +-
 drivers/iio/imu/bmi270/bmi270_core.c | 332 +++++++++++++++++++++++++++++------
 2 files changed, 283 insertions(+), 66 deletions(-)
---
base-commit: c0f115a8d97599623294c8e9ec28530e19c1e85b
change-id: 20250219-bmi270-irq-9a2bc41faee3

Best regards,
-- 
Gustavo Silva <gustavograzs@gmail.com>


