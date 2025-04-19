Return-Path: <linux-iio+bounces-18320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53473A9437B
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 14:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDEF3B88A0
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731C1D8A10;
	Sat, 19 Apr 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP0tfeou"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D472AD0C;
	Sat, 19 Apr 2025 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745067259; cv=none; b=uKSbyunadzb7MmUjyrlwGxeh4M0Zc37VgsOsJ+s33XjRGZ0vEEm9V5XM+dso5g2E3LY68Zf4TZTtZ54TaQua/CeHgMSCWpRGvNDl/OQOuLAgD4HTJmzWl3UfSb2yixfoFWW+eNdEZ1YplT5Cd5NaB5tjMFiZ4ufY6glEVvNFIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745067259; c=relaxed/simple;
	bh=09owqr+dWFhTVcQC9RS2HCR+GPzSZgd6dQgqjlLBPrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=egB8nt63F2kQGvQGMT+joH7LBfzCGQ3o9qTwcmZjDgmOTmWtRl8+U2dbHL0PSOVcHWsMeIZLTd0mWc8uGNVSd2yXDUc9DHTtJ6HwlUpad745UPpy4zD/Sg8iUSba+OUNsz9+EbY+dYIVLnGz7fW4NH2twyK0JoJEhDijOdHmpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP0tfeou; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f7019422so26098846d6.1;
        Sat, 19 Apr 2025 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745067256; x=1745672056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZCVXeMvwtO+XgfUIIlEKPWYpKv+YaVwsaTpEWQ9aCQ=;
        b=KP0tfeou14B3vc5MhUReTH9EyVnt6/l/Kri1QDn85PJSz79iDpvb7sElkZJPlIfmFH
         Ibqb7BK9OAExyzx7ItPkD9pdeJ2Z4jp+sGGOnG8htYEqpYiMW+ANadxxaYMihqHmRt96
         h6sFutUQSwzQMaxIph0f+Ywvtn+1YQNLUdkhqiPdCbkEJqxlXLS9bekxUQESfzbDmuJZ
         KJxZsiCjrOQ8gWi7YE439NdNFwDME1KU+HT8UwMqhGSPEDnfyBdamH8V9xVXb2tIfdhZ
         160lN+bB1xEhkYNKiRAFgvyY9YeI4ud9r3lt/8GdQODCpJKa0aiw+UWolUhTyjJsxTAz
         5GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745067256; x=1745672056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZCVXeMvwtO+XgfUIIlEKPWYpKv+YaVwsaTpEWQ9aCQ=;
        b=Z73pgHef/MFiHglIXjOfJFU3RNgyGL86CSkZYifZQr72MRLV8fKqpRgdRpgT3V1aJe
         wwCCsT64/7uumxZK45IXCNoMYqcnhX3ZhEViVqZBB0WEfS/1kQd8hlNEGsu62ETq5tYj
         TRqSVEx8dtBX5b/7TjdbnuA9S7iRKnR4dL8AeFHVAQRToIvcwfft1lq666a/4nHfi4VT
         S5aweRMb8C+2o2LfMVC5GupdJodqri9sWZQQHBPr7kvWXDp8m0MdR3CypgCQMJXlCjah
         SV8/TA0JjiSP8UGXgyzWSW+ln3c2Wt0tDAU86KBheqhYztqsvjHhYy61emMPHEB9deim
         A2ew==
X-Forwarded-Encrypted: i=1; AJvYcCUVOVhUvFoV12jezHphr0oM2jHB+nyGOYAAlaCAipA1rGoMt/H/m0BbkwpUqpQn59c/vxVacY0EssA=@vger.kernel.org, AJvYcCWRXzS1/we5m51D1G8BaIZ6fjmf26MFzsUgY/k6KpDOwv3I4yjgQ/ZqVNB7ZsUfjTGFAFhLoRG1@vger.kernel.org, AJvYcCXzunlqktiQGkmPQS9zGbVu2n9MbAfRhOhplOFyTUYSA7ko3yOiQdLLReHQ1IaNqNbFzKFcq9dVMTWltYP2@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3FbKaKQSeHZPtGjW6u+qTZAt70GCHKv0YVFqAcOmcsBEZ9tO
	l9pFw9MDmuoz0Sb+5K5UtdBsOzMe5tEHnSS062u3IHnnA7xSwIKRWlqGr+NwtHU=
X-Gm-Gg: ASbGnctJCpYfvWmb8UCMx6FKHDlkg966pdn71xH/qo8NzzzgggpW6CeZumOmIQHSMYg
	vYPgFT9ZNMs2OboNHNAz4CqsBvBr9+d3+MK9S3dH3IxDHdIen/DIK/e3qkWWkghfwSRnw+uZPcw
	9qTqkbphWbKXPUtHA9ujq/G0BXsRZYLfg6BjbrOjVkk+28T+ZO1qs4nkNmEJDbAXnyxFAinqtCl
	vHVdUnpZe50Rs1VceV5dSFNmzpXpCOpUjFEG43BpbtlWInS4P8j1dQRVRb6pm8hz55/2j6mHtQJ
	a8yFEkcIyQOUa0DvrEPXtY6CSepfkNAelj8amcCUOp00Z8Pas+m6EbA=
X-Google-Smtp-Source: AGHT+IGw1aI7q5f08oFeWoBF3nOTUTLN1Pe5Qft5/kDututuRDrqfq1HMpqJ93njQaIEUiILACZDkA==
X-Received: by 2002:a05:6214:19ec:b0:6f2:aefb:948d with SMTP id 6a1803df08f44-6f2c45394efmr79362116d6.15.1745067256203;
        Sat, 19 Apr 2025 05:54:16 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9c3b485sm21296421cf.27.2025.04.19.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 05:54:15 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: himanshujha199640@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] iio: adis16201: Correct accelerometer scale factor
Date: Sat, 19 Apr 2025 08:54:13 -0400
Message-ID: <20250419125413.679290-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The IIO_CHAN_INFO_SCALE previously reported for accelerometer channels
used 0.4624 mg/LSB. This value matches the datasheet specification for
the offset calibration registers (X/YACCL_OFFS_REG, pg 18).

However, the scale should reflect the sensor output data registers
(X/YACCL_OUT, pg 15, Tables 7 & 8), which use 0.4625 mg/LSB. This is
also consistent with the typical sensitivity in Table 1 (1 / 2.162 ≈
0.4625).

Fixes: 57f9386405a2 ("Staging: iio: accel: adis16201: Add comments about units in read_raw()")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/iio/accel/adis16201.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 8601b9a8b8e75..982b33f6eccac 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -133,7 +133,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 			 * 1 LSB represents 0.244 mg.
 			 */
 			*val = 0;
-			*val2 = IIO_G_TO_M_S_2(462400);
+			*val2 = IIO_G_TO_M_S_2(462500);
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_INCLI:
 			*val = 0;
-- 
2.43.0


