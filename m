Return-Path: <linux-iio+bounces-18310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03401A93F32
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 22:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1FC8E5A90
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E95252905;
	Fri, 18 Apr 2025 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju6sISDB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CB2505AA;
	Fri, 18 Apr 2025 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009434; cv=none; b=btu6D7ABHblud6R+BDz17jJtzLdj+7Y7frHzxARXcjuSLfMAlQBPOz4AZY9I85rG+swm0fXPMrD7WejAfLb2mqJ1HYsIzCYDcV1GmUn808/+dX/cEYbugTVgynCXegJQVpjDT70ZHiRmhL2R4a1wSo+aCtO7wKW8s94L2+mtzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009434; c=relaxed/simple;
	bh=IeGkgU0YBXtfAvHiWobFFEYEFFchmZKYlSuvetJAaME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7T9OL58j875oKY8PJDdA9JnoCJttEL0ttZsenmlWQp0rGgZjjS67HAnxlzHnbn9thJ94mDAUpIi200bQ6/GMhzEncwhu8lamNwPSEQRhaDk15+k4Rp/eekJ7IkjreKhNyWuPpKMz3qzzpkXlj7KWFW1Q+5Wvr985VN+/dlBOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju6sISDB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47686580529so24063221cf.2;
        Fri, 18 Apr 2025 13:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745009431; x=1745614231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWMbB3RCjLtzIka1EeVCBu0jLU/YK5i3+0Q0+aZfr+E=;
        b=ju6sISDBavWyefKtUbY6gfe89dMMcgJ/cdicH0cYF2eqqTO4enGmJ5y0arhNpiL7OU
         vmQZznOyzmysLjKCj1+3MpXbxKmAZIfbBoTFQbsmHilSB3Mud2jn9cXbo9sL4jZQdoUJ
         H06Iusyji82rC09St4LqRLWo8HSHHHwobQMspGO4rbOBX0Lyxeqf9OB20d2q+0gMn/iM
         +++ntywIq76RS4tVWd8lj+AtM/WOgUg+bnxE9gyn8DDfjQ7RWW4I2LW5WK0PF65GJ3Gq
         JTey7OVTFuTXG9lgqDAvcIveOKdcmAuS8Gf2hBTAqMU0yWh67MHZibAduTDBz4KT0E47
         Z24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745009431; x=1745614231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWMbB3RCjLtzIka1EeVCBu0jLU/YK5i3+0Q0+aZfr+E=;
        b=kaZRbjOCaV4pXEsDBsf7+KvsQiziTQyNshSTBvBPbuTTzydXAhsEevGs/OEzMW2sHn
         zsSxwTICkcdX1WZmTeedRYGvf7cLLaSXYDZcyXIrkWzlg/2NoF7JwKxx83NUvKxCLP9N
         SbMn0+00In6XUVtk13V0VFg89tWWpMHLMm8/OWv6pMkog06f0sja3bwSN4l532BID3y8
         lxFr8oQBB8QnBM4J06CJ1eVd6Ve8MnCdHua6aYgw4XYQTVPQU15pjeXJAbTuSf+Z4W9v
         SeVFPivngoIGWc5I6+lH8eehW5fenfjhV/Ty+W0MMZbxwVB89hKkbo/ho2IWokRF5iEh
         Ad+A==
X-Forwarded-Encrypted: i=1; AJvYcCUyb+h+pO0iAPSucTs5weomJ5IDX9dhFvS4nnRLIU8vcthzNPcOsMaCK9+CTF0CwHGJdkPbHz+fic4=@vger.kernel.org, AJvYcCVeWhKNYiu1oX4wJMvaQaWTHoqnh9J0JDZDT5HNoEWFrsZPaJf3GMBL+ze7YgDUODq2YDeoSk7Wg3iBIaWG@vger.kernel.org
X-Gm-Message-State: AOJu0YxUq4QkplrKL797Zprjj+KjJ/K1REyyK52LqF0oYYGXKUu3PFC+
	Sedy8aXACX+qXQu86/r5VfsxXsxyk26UrK4ui4TVh1K62/yaRHik
X-Gm-Gg: ASbGncu5G2Ipz5W4V8QZ02dLiL38iRM2pMEPMlpnXQZyNRUl0BOgaPmhmxeo3yYaMFE
	1zuy7u6uUKC372s8zSahQn/aCqEzca89cWMpPL8fxl0AAW3xyip+LA4WUWHYeERP1n23onF/2BE
	KWaY3HgY+kAcPtn27AHYKLpAC9XOKSCyCISu2163qSfr32j1eLfXlhuveGYWUV1QTaKJXhHa/9o
	0GCVIrvKfpSfRlbY784Q+hXq+p6Osb9QhtJsk7hDa1TSIWXbuYDwf7JLZnoVdLePF/CGl/93IZs
	sCc/4yNHnmbcv/qUaeEJ3J8QEx45p6hY02o9leSJM4+PsbXESSvRmFTlC3+0PJAEoEqefB83xWk
	m5raPc/77Wgb4Hiw5WZNdxSVOu5XbEg==
X-Google-Smtp-Source: AGHT+IElU1Yd0E+W2DyTMMcqARRpEtHiEHdV9D+YUDYwkXUwZpUeb/KR+3XphmY5lzjyf9I57bJbgg==
X-Received: by 2002:a05:6214:21c1:b0:6eb:2e88:d47b with SMTP id 6a1803df08f44-6f2c457c2b3mr62600776d6.17.1745009431639;
        Fri, 18 Apr 2025 13:50:31 -0700 (PDT)
Received: from theriatric.mshome.net (c-73-123-232-110.hsd1.ma.comcast.net. [73.123.232.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af11d7sm14355906d6.6.2025.04.18.13.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 13:50:31 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 4/5] staging: iio: adc: ad7816: Use chip_info for device capabilities
Date: Fri, 18 Apr 2025 16:47:38 -0400
Message-ID: <c7866788ff981077c092aaf53bdb0d905df8bc64.1745007964.git.gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745007964.git.gshahrouzi@gmail.com>
References: <cover.1745007964.git.gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move device-specific capability information, like the presence of a
BUSY pin, into the ad7816_chip_info structure.

Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 39310ade770d0..ab7520a8a3da9 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -44,21 +44,25 @@
 struct ad7816_chip_info {
 	const char *name;
 	u8 max_channels;
+	bool has_busy_pin;
 };
 
 static const struct ad7816_chip_info ad7816_info_ad7816 = {
 	.name = "ad7816",
 	.max_channels = 0,
+	.has_busy_pin = true,
 };
 
 static const struct ad7816_chip_info ad7817_info_ad7817 = {
 	.name = "ad7817",
 	.max_channels = 3,
+	.has_busy_pin = true,
 };
 
 static const struct ad7816_chip_info ad7818_info_ad7818 = {
 	.name = "ad7818",
 	.max_channels = 1,
+	.has_busy_pin = false,
 };
 
 struct ad7816_state {
@@ -98,7 +102,7 @@ static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
 		gpiod_set_value(chip->convert_pin, 1);
 	}
 
-	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
+	if (chip->chip_info->has_busy_pin) {
 		while (gpiod_get_value(chip->busy_pin))
 			cpu_relax();
 	}
-- 
2.43.0


