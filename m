Return-Path: <linux-iio+bounces-18377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9103FA9489F
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA643AAC1F
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2B20C48C;
	Sun, 20 Apr 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiqHPSPM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A118FC74;
	Sun, 20 Apr 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745171663; cv=none; b=mOBkdaxeYA1nZ1jktuppWHPlQTMmg/KOwMLzZs6tThRU6Ars1ydrfJylAj1v0cDEa+3UIufO8XPv17KWljhStw18lDw2c9aqA3JrLpZ94GI7O7FmpHfbR0NabLZ6Ij9Go1JeAd/tMljx38js42EbBaCbajojFgxonOxKG91f3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745171663; c=relaxed/simple;
	bh=RqVt2WFmO3wJYDzEsI6ciJWqvB67TcVke0eEZbzkVX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkZXWhi37GQ6RtF92qgDxaoEqsFkHe+seTKQKBFIGhcel51vHxH6N84dbiHToUiUtIvUHWeK6HVl1V7Ol2hX4KL8PF67/n2PWzTQihJM4cBHjyYhQyxcDiD/cDddKMIYedybmSSpIsZhIfxxk/ASnx31MOk0LCGZRT3ed464k9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiqHPSPM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6eeb7589db4so37786946d6.1;
        Sun, 20 Apr 2025 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745171661; x=1745776461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAfeP15i3YW+W8/KE037qPO6i/TTvbryO3NCuADreMA=;
        b=QiqHPSPMbY5nZxx+M+rFz8asKZndJTzjx7RgLiUXxc4StYvpJXUyAlGfFzMYE1mbGZ
         InRt+5kf9BtJ04Ov5YkiUZcBVfepdGdUr0sqQeAJkK7dQhITCkf8ol0MuR4sH9tb7CSC
         iK5v5LCq/eLvmNEcYLD/wpOdDXwtsv5Z6s9e7kQel4WfDXLKdD54hOlFcVlrJKPS0/rQ
         1L5v4mUMSArLZGW9u7ONsfFyeZFrQgKQaQReLwsv7CnEcio/75RqteW7bJFsTUtv6cPy
         WNpaIVMZfiBXOECupRo+TwCPDnq2pE5A54BUb/4g0n3LoVyKHIZLncdRSCcVvn4/mszX
         MwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745171661; x=1745776461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAfeP15i3YW+W8/KE037qPO6i/TTvbryO3NCuADreMA=;
        b=suSChm6pkw9vWMhxV/M69PdzXyfktXjRcN8chDUzAinXjJXL8K3b3D4LRX3vyWVWv8
         5hYB5vx0Bi3lmiy0/h1bIY+8vhHIm4uggpubQ7VD4K+5bUwTe2JK5SRqG5DZ+CaN9Rid
         2FmM+SGxMbIQUqLbzp0WYrMa1qpT/fUUF6N26Lc9CAg6g4HmAZwLfSAN87/5J/U4Sffd
         nHeln5UGHee4lVChjtNyZGNUpB2bAZk6BTKJuQndtaatS/kKVwbNwbhN1/sOCXjyfJqz
         cgjXdQXxfbIMCMziHInsksQt8cgJOfYLjbhz53yDlOxIJOWxo/Dm+7PqVN18H47Paok+
         cagQ==
X-Forwarded-Encrypted: i=1; AJvYcCV47Y4Ccq/tHLPWReMpD/geAWN/WWR/WkycHWqXh+rw0fAWFNjNQT8HgiHVxj28a9xiJFy54ZDRkV8=@vger.kernel.org, AJvYcCWl1iYTxVer5xSk2+FJHiZZq0XK6CForSqakkK5BluKAkzQYlsbR5kUPBrV2NlfXjVkXlgzdw7JyHd9NaL1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9d2hMD5EQ5EpDEert8bkOtM5Z89zA4q4oi3GS8fyGrRQM32QN
	GilP95E9IC74BYDz5t5XC9Ajv2ZfJNxefWk6cP56xJ+Pn2qqYlkOibAiCgrwj8o=
X-Gm-Gg: ASbGncu+c4BIl4dYiS3I3STmTvKVpSzGYl6Uz3Np/R6T15AJSwjufLs38J0Y6KtyJlp
	M+nVB0eL12DM98/bz8x9KDbcWgdZRnRt7p45IOXMcTEI7ihsjvkqHavx8TBzpU9zwm1u4czwsM1
	0vOUVMeDGIu4GK0SWTD8mK/xhwL/qTplrgVFsVFPxMo0QnMU/UBEtGe5MkUpBbVYeHWYTxpODLR
	gO5jiGnk7mzu35gN6QfMsQAFKnfCizlz633Bh/8wIfJRPWEXISSBr+cTsI7Lt0p2se286oGvFov
	kOaJ54b+Y1FH0lCohs7bDd9vwWobUaqrsV0lGDwUSY/HcPrN1nhyBrg=
X-Google-Smtp-Source: AGHT+IF9XjLuqEIcAOVLiN4J9h7liEeZZq2HnnH1SmZ37PEj0/DzlZuvwjCtzQhWQSD4ZTleVGUVmA==
X-Received: by 2002:a05:6214:e6d:b0:6e8:ee68:b4a1 with SMTP id 6a1803df08f44-6f2c450ce0bmr208025546d6.8.1745171661192;
        Sun, 20 Apr 2025 10:54:21 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0c1bcsm34801286d6.26.2025.04.20.10.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 10:54:20 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 0/3] Fix and refactor output disable logic
Date: Sun, 20 Apr 2025 13:54:16 -0400
Message-ID: <20250420175419.889544-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 includes the initial fix.

Patch 2 refactors the code to use the out_altvoltage_powerdown ABI.

Patch 3 adds small improvements by minimizing the size of types and
doing a redundancy check.

Not sure whether to include a read function for powerdown as well since
all the other attributes only had write permissions. I can also do this
for the other attributes to help modernize the driver.

Changes in v3:
	- Include version log in cover letter.
Changes in v2:
	- Refactor and make small improvements ontop of the initial fix.

Gabriel Shahrouzi (3):
  iio: frequency: Use SLEEP bit instead of RESET to disable output
  staging: iio: ad9832: Refactor powerdown control
  staging: iio: ad9832: Add minor improvements to ad9832_write_powerdown

 drivers/staging/iio/frequency/ad9832.c | 50 ++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

-- 
2.43.0


