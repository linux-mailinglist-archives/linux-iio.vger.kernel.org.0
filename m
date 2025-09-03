Return-Path: <linux-iio+bounces-23691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ADFB426E0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 18:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A093A7193
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71B2E6CDB;
	Wed,  3 Sep 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NogQV0fa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AFE2D63E4;
	Wed,  3 Sep 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916882; cv=none; b=cOrQOm4VHH2dFeJb1DV4ZxiPYiO3xdwxjn8+T/8ifmz+ov2EO4X5tsIaFyxOc/leTv7IBaCRIUWpXcliU/5Z4Y6yQKa/J9Ee9wSqxI7j/y/SiT236uJobi7J7suhb3N1xeK7QT6c7D+yBQaoQd8ezk8UVv1un8jUSw1da/FviLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916882; c=relaxed/simple;
	bh=ohfi0HqJzhAtGpVR6EnVIzSbyLCb+8C/x27UYL+bpmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npppzDm807AD6a7klC47OKEpkmA0EAvJL6wGHhFvjhuP7g30Xwos0NY9mPbqE70qcXZZgQrnR3XrmREPihIkDJmxMLURse2WRYg+cMbiz+fpDfre4lPTP46tGXugB2Z2DunyH2jOU6Xjw/ewpXx45LMz5xwfV+oNGrUBFVM/mNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NogQV0fa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f76454f69so29930e87.0;
        Wed, 03 Sep 2025 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756916879; x=1757521679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qWfhUQvd7EuaFksqXbpSrvG1yXtKPy9RHczOGQWZB0=;
        b=NogQV0faPsv8OTAii5cHApnVX1HdrWWEJpNv9CVRybAQzciZCvWEQ7/vObroSg1e1a
         1O822NeWN8itZToSGFa1sdro/xR93cn7z+HNCwftSZSNZ3hRhBFZXbHEGG5mAVw9Kf0F
         /N225Wdlo996WciquPMrclYERLOEwW4Sx1Ta3Jg4WQSne2kA1T2Lp4fGTUYuWVusGi3M
         +qzByxLMiQ2tfakteDD+yj64QIhhzFRKY3aYkq2faH/xTPwGWVg89OP+Hi1bld1qmDEK
         1VyJ00QSAlj89HUvmliHaA9uzDKerFhg54HFrBvtlc3XSMw9TzGuYxiTrVRZrPWhAixu
         J+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916879; x=1757521679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qWfhUQvd7EuaFksqXbpSrvG1yXtKPy9RHczOGQWZB0=;
        b=IU5NXQJzknBN+qxATBrhBuGo3rITulr4zizhNsCRKJ2LyQJPjMVPFpLMy2x3bLtJ2n
         9iaLDgUC34fSCnifiVz+B5kcT2PMoLAHeOlXjNsGnmfVjPwAncsHwHUZI2xZbY7EL8cJ
         QwOuJyJIL8NAkYIHQBaWBblI70+QUafjocPXaF1nKk9Dy+TpmgadNhYmPs+IDyhBeaMo
         qxo6jVe18MYceGWp3kBnjOgOavkNCSHkO/eXVVnJrDNawPrTYKeEh3QdLN9rgxuWaDl0
         ukJofoTTlEQu8XZaML+LcbOieEI78pNGnDcc8y5Bn8FWoVOIUFw4NhyYRLLKMNuDGS3p
         cZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCUzAeTUXdXbVUFaXiPO7M6aR8YDDP+v/bOyvZ5Jka0SV0gUL0Umy5S8U4vKS9nfCJ9m965b6cFmP4Y=@vger.kernel.org, AJvYcCWvfSlYWTQXTtdByDDR1/6nH/WD9t4gPZsS/PhZBMVID5VD02RFDqhM703+M7Dsqj6rLXaGpjnId7pKFokq@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvuoz6Aw8FVzuoDDjVHKrUy8iQje0xyExhy3m4+UlfEetG9RBZ
	RUsRqsEX/yqvXP2V5uWOds++lGC51KodzDDHIYqixnbKTyg7rW67rWGH
X-Gm-Gg: ASbGnctGlHVMF8GfjFmRoLxdKjr/NhKuU02uXDTa1uPhXBicRVGRZyijQo9Fq4wNxD2
	0tN8LY/CEDoX4UGCetqSuAh+BjR35nXzxqjlGfA6Cmrvj6/ItdTTRx4aNXY+/A6PWkZUZdxIlDP
	nwZup4oM8Pqieh76p7Tdb7Y9jBJRpR3rYUJO30V737+bjmZw0+xOikWawNPGTe2Ub7lFLb1mn+3
	GSqxGGpWT6OeH3fzvJbaCkmEG3OjQKC/gW49XXQdKBMTh8fIN9jX6aCs2X0Cucqlo51ZfOOG2A0
	0vL1/bcESyd8b2SSsBUaA3HViduUORNmLsOdb9R5+Dp/yrmokqU810uRTj/LUSSYRpuvTixsy6j
	QcQ+vznLnEtOQRA==
X-Google-Smtp-Source: AGHT+IGakqVr9tJwsFTKbRCowF6A+ZKhvH0Q4lwodxjfZqI1A9JwQVEuGRl1OyB6JODyjIgrGAu6cg==
X-Received: by 2002:a05:6512:671c:b0:55f:6c08:a15a with SMTP id 2adb3069b0e04-55f70905fe3mr4044095e87.32.1756916879145;
        Wed, 03 Sep 2025 09:27:59 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9fddsm604665e87.78.2025.09.03.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:27:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v5 0/1 RESEND] thermal: thermal-generic-adc: add temp sensor function
Date: Wed,  3 Sep 2025 19:27:48 +0300
Message-ID: <20250903162749.109910-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid duplicating sensor functionality and conversion tables, this
design allows converting an ADC IIO channel's output directly into a
temperature IIO channel. This is particularly useful for devices where
hwmon isn't suitable or where temperature data must be accessible through
IIO.

One such device is, for example, the MAX17040 fuel gauge.

---
Changes on switching from v4 to v5:
- switched back to IIO_CHAN_INFO_PROCESSED
- dropped schema commit
- applied Jonathan Cameron code improvement suggestions

Changes on switching from v3 to v4:
- switch to use of RAW and SCALED channels to provide more accurate data

Changes on switching from v2 to v3:
- rephrased commit headers

Changes on switching from v1 to v2:
- documented #iio-channel-cells property
- switched to IIO_CHAN_INFO_PROCESSED
---

Svyatoslav Ryhel (1):
  thermal: thermal-generic-adc: add temperature sensor channel

 drivers/thermal/thermal-generic-adc.c | 55 ++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

-- 
2.48.1


