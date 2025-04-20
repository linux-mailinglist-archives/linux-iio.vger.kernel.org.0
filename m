Return-Path: <linux-iio+bounces-18373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E91A94896
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E38C3A424E
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2AE20CCDC;
	Sun, 20 Apr 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd9fyc+d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A017A302;
	Sun, 20 Apr 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745171251; cv=none; b=QKl9lJ2QinwIIrqQvPKa+t19Jepul4xSzxTaOgI1/yCpYkeHEgfEGb3EDHxfGbIF0cKo1HRDpwDIjYwpL4aqVZ0rJIjK7B9iesFroXoMK+CYmDZ3ywvrpsCZ8Xz9vZWnalfb7U8qnCsg4OWG+AKrK5uDlm2/q8uOCaUFgDL5gIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745171251; c=relaxed/simple;
	bh=mwayp67UQUi3tBtf1siPMVZZvxax1y3PF6ay8Ji+lDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UcIr3BRi5mw96F8OizspVfmkcAhBOnwIi5n0K0MbSmDDVM8BbXtDGssQV3tcw2SFd2XGLfH0kO7biwvETX6u9p5UKMWPwrLVC5A9h1dyZKTbBTR4JaRssjbrcg8KKuw8OlyFozjqfws7HoVSkaj/SWICDdslfolYtlVUbZExYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd9fyc+d; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so44105106d6.0;
        Sun, 20 Apr 2025 10:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745171247; x=1745776047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tx05U+vRg2gsgwyrSqUs9+tOlnrgkTrKgqo5ZO2arI=;
        b=dd9fyc+dWkZrj8PEXlRcY15mBjrzZUHOSTTYaf0CmFcYgwAe3bqDZd0sX9sI9XtH9S
         9EeqkDRVosGlmWwD0/x7fE+VRCb7qygPjepm3wdw7Q4JWF84tAPbnF5tdpINgN3xSuoa
         oLQ8QnQ0yKF/0CqrfAO5MlMKyFIB2uBUjIB8K0Pgmhypctd4xVIUlFsvnwsIgy62NmQw
         /12urKjqSoE+KAKTOqAd2VrZm1lGzXFS1wbmrX3CYEmkC6E/NFqzerqtEehZrGPRlcEJ
         j7FUIV4aT2KMNkQr/EH34tsixv+o3RD68oL6vJFk3hONSUXY5qw42ZAejDtoh7ICoTYy
         OAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745171247; x=1745776047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tx05U+vRg2gsgwyrSqUs9+tOlnrgkTrKgqo5ZO2arI=;
        b=erIIqHlZq8kCTMGraNVDR42f0gOE4UqykZtnrWBCXDqTnHYoVki1ERqduAwhlLWSTU
         AfZ12C/LyxB8Tl1xrTHjOHdn5tjy41sx927e3P+Bb2bJ061xchd1fZ1uFI6QL2WB7q30
         3v1WOxRfnZzJ2dKuE8un7kc5enEheGJ2Z0fe9CJM73pfGH94KHZ+U6/UymmRrPUOQqul
         pnsnqKRGQkKLkdbA1pWY/evcDosoVL74xrXEhWI2Kl37JvDfD0F5cHyLD7gfyLFGc48O
         YCwDSMnPXszWSPK3Ej75p30n3Vq/KZXy+1nUiM7SE1HOnsA8yO5uICAEb0g7jHwcaKt1
         cypg==
X-Forwarded-Encrypted: i=1; AJvYcCWOcXcbxB/qzpHMeBF6+7azldL16Qo8XQdERDN6MiB9WPv/HR475PR4IbmpaPklFLtQjDyyYqAnbnE=@vger.kernel.org, AJvYcCXmBFqp/BsiXwz/zNldRb/90GJoGS43AX6q4+CMl9OGqzHnFm2nCCHWcWOwrEX4oIcYiXIo7VD8uTBzAPUe@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKTSIk6quf73QDNeu4u1+X8Ru81zPBVG+ZDrfg3kyATscZhyu
	vBhWq4anpSKwgrKeufcsK9OvTTQUlgCUn1DC+N/prhkZ1EL9uJGI
X-Gm-Gg: ASbGncusY87a+LTiY9el5sfvN1lm0kxDgu9ntc6N5rxHC42VGrbcRwAfHJTuOO6s/sh
	5xoxwLQbsJrWv78r1vSfSwK3efPpDgci9MUqam2hMnnRfoPhm3WcdPJxaezwzykic6fEiRCEFov
	eCJtEbgPdR/psp+afDJLKkDB1AehS1vh1PKA+/3zW2Mjk1nOX62CxkwPZv2U2ysmIMNTZO5pwkS
	QfLmZKTATKffnIgIYr2ymQoPSTm5+VEJRmwYJDGyBIPp/5U8xnKuTgY0R8ZZc/Z885+lswiZ43m
	puaHu56lL8g/jcoSPsD60yksiC5XDgJAKFdlexoznguS+wc+CiTkfm4=
X-Google-Smtp-Source: AGHT+IEnyJl//74fr/3CZDnEkerEttve36zVMQWD1LxhiTpbg+os+741RgNwWYFQDOk1ykb48TGRfw==
X-Received: by 2002:a05:6214:3211:b0:6ea:ee53:5751 with SMTP id 6a1803df08f44-6f2c27d0d1cmr176445176d6.21.1745171247400;
        Sun, 20 Apr 2025 10:47:27 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfd3e4sm34110156d6.85.2025.04.20.10.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 10:47:27 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Fix and refactor output disable logic
Date: Sun, 20 Apr 2025 13:47:22 -0400
Message-ID: <20250420174725.887242-1-gshahrouzi@gmail.com>
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

Gabriel Shahrouzi (3):
  iio: frequency: Use SLEEP bit instead of RESET to disable output
  staging: iio: ad9832: Refactor powerdown control
  staging: iio: ad9832: Add minor improvements to ad9832_write_powerdown

 drivers/staging/iio/frequency/ad9832.c | 50 ++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

-- 
2.43.0


