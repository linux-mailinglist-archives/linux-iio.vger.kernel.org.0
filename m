Return-Path: <linux-iio+bounces-18854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53BEAA112C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 18:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC0C7A3712
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0CB24290D;
	Tue, 29 Apr 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbgkBcMB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185CD217F27
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942747; cv=none; b=SaLinVdwCTDtxvsooAZgOqP95/+OEeKkNlRFHg9gSulA6M+RnOdZz4O0A50QAHFT/8nEdW6zCuxCfW+umo9/KmjGrFKqqnqQZJ0Ye1Pug9IVJ6bGJSGkCuSvH2HGK8wl8BeCV1sQWycQIqg9y2uyg6yi5iJY2CnaDWhRTszrWcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942747; c=relaxed/simple;
	bh=hSpt2pZDJn6oNd7SHfcOaQlmvA1WoDmBnW9c6oHnevU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhjpBsW30ifSl5X1pprG5WbQTjRQg1hBdlvsMRSWoVRWY6+wHXNX+37ETUVStyMOGKkiG72/9a7ddGRceN3Yi4pTRu+ZMtDIJhs+vaFUP9n9GMkL0tRHaeHTJ0Qf7sCjmjMmZnQ/QqNMLsnx+o4HCLMYUyZxC32T7ku1VEu+3ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbgkBcMB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso8841722b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745942745; x=1746547545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CfH2++QQa8ojQrejaSWuTzHR4MNckGtQYrMy+WpL6hg=;
        b=hbgkBcMBwhT+MumlV3YtnHvKRdOeJ5LOBt6Dxdnu7Ku+51JU5QmVkzzfjJM8mxJu80
         44Fd060h4xTTlCxAf9Gr/hjBBiK6HGj8caiAf+VfDf3R0ZNDPUw7YZFceXKnvc5AiSMK
         3s8DNY+qCNsQwmmeE716Lh8sj9Z/zXrNu5O4LTj6QPvTnWGyrkcBUeuJFD6Elh5XpU1j
         FRIhmeRfjSe88GLnghPN5YwkMDlJbJaA87rd0Io0m/cetF5GHGCRe5HzpoDvHhQcTCfS
         ugPpyz3wTDHQIdJNr1szsRYGR7odbqAIlVai/Rt8YS8XiOV/bYqR2l1m+kb9fHgNcLWn
         lbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745942745; x=1746547545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfH2++QQa8ojQrejaSWuTzHR4MNckGtQYrMy+WpL6hg=;
        b=sctbnPBPBfaiatQU3Yl2Eqg1pLLt+uAtlcqjEciRIGwCh4Q3gIhscjKGKnLKmo3//I
         Tp7zDN6lTI7GrX1jC8iTtydHoW/kufTVlVnZaqlHvs2HzjjtJF083R4jlOuwxCcb0KIm
         pvy49aws0NxOEZTdKpcYV5iAGf8ddJPsc2yTP49stfK71N2Sq17KYfUAi5jcKA/oOIWW
         4BNZP1BJYfllVHDvvTFszba32FURkBJs2f0WNqhhjRuendA9eR4Vhp9U9Tbi0scfrvQ1
         hluoR7VnRfXcCq5xBNhW2Z2G8d9Adqny7I8OBK9j2rFBm7D5ccDrCmBVABi6w1n/CvVc
         DLgw==
X-Gm-Message-State: AOJu0YwQuo0c34fFPxGEkeAFUsCXim6NVmU+BS+JOVxbkG+ZV0GJY/MC
	wHFBneX3uK9rH+EcYidDWn3PbKalHOrUfoFAGsiEb1f2tnEyQJpg/puDkk/AynY=
X-Gm-Gg: ASbGncuZOqfF85Me2nOlPV1WrJfaYtRtl/SRQLNB2Z2AubFq9QHGUyhaQciiovt1aef
	QD5Wv1XinHmd3OjzR5KzI99C5eSx6NE7Jw6fJZzU1yN49+AAXAue1rvSJh28qMhbjmE8TFDjdoG
	1aNSzC/1uFaK/TWVBEGYYHkfrf8HGJ8yJcuWNKU0Dttkay0r87f7mZ4Oo4x7SCLYhN4MK9ZuWPa
	gz5ZNmqCOH7s0s3fEWCpJZWB+kqByLPrV3/AVDkjgREo4lwlx8QS1GTB6S8yT3q3dt4ty8Na1KB
	e2LkwOf/T3bM2cO2krxDeQwRcdRmjd8fb9xcqoo4hWdzt6KM7atulFYAsSHnCN3b
X-Google-Smtp-Source: AGHT+IHzSaX7BlSfsWY7hp1rf/FqQJg4wJtbpRAoyGdMm1dOpDb+JcVM695B2R+ERxw9hgqCZaPSjQ==
X-Received: by 2002:a05:6a00:986:b0:736:46b4:bef2 with SMTP id d2e1a72fcca58-73ff729d47fmr17669872b3a.6.1745942745125;
        Tue, 29 Apr 2025 09:05:45 -0700 (PDT)
Received: from c-sar-augusto-LOQ-15IRH8.. ([2804:14c:73:90b8:20f6:60ab:5d7f:2c50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6b18dsm10400888b3a.95.2025.04.29.09.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:05:44 -0700 (PDT)
From: Cesar Bispo <dm.cesaraugusto@gmail.com>
X-Google-Original-From: Cesar Bispo <cesar.bispo@ime.usp.br>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Cesar Bispo <cesar.bispo@ime.usp.br>,
	GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
Subject: [PATCH 0/2] iio: adc: Modernize legacy regulator calls in drivers
Date: Tue, 29 Apr 2025 13:05:17 -0300
Message-ID: <20250429160526.5934-1-cesar.bispo@ime.usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace a single instance of legacy regulator handling in each driver
with devm_regulator_get_enable() or devm_regulator_get_enable_optional().
This change improves code clarity and aligns with modern kernel APIs.

Signed-off-by: Cesar Bispo <cesar.bispo@ime.usp.br>
Co-developed-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>
Signed-off-by: GabrIel Ferreira <gabrielfsouza.araujo@usp.br>

Cesar Bispo (2):
  iio: adc: ad7476: modernize single regulator call
  iio: adc: qcom-pm8xxx-xoadc: modernize single regulator call

 drivers/iio/adc/ad7476.c            | 6 +++---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


