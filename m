Return-Path: <linux-iio+bounces-10680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A09A2021
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 12:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170411F221C1
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C510D1D8DEE;
	Thu, 17 Oct 2024 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXYbZDQR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AEF1D270B;
	Thu, 17 Oct 2024 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161484; cv=none; b=hyNRHRcddHhH8cg3nmsLnL/xGC6Fz1gkgGTahhn+tndks6qrFecxuYxiy0h+sGz/kxHqlMfn4smIzcnGIQ+p0JwlLa0NPU5/60HeJ3W61SNQHxgZH4sEhPy5lnQB9li1imgutojgtxj/22Dxy2hxlQvg4hIW6GCF383QGVFtsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161484; c=relaxed/simple;
	bh=xvy8QYUo0YSyjxJgjQdwvoTCrWBXm6b95/ydl1O85og=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r+MopmFrvunZHzLKw/YRbeT8w73uvFFYqq0rSgO8I3vyTkd3yg5/0eqqR4YRnxedAiBJfrxhoWCgMye3ztU6KlE6kKvxf9uL9YbYxqXz48Dnekkfp+h0SL5LyB81fLuzuTZ38FBa4ZMzZQNrwBgXZnqvbWIjF7UM8PQxutAenpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXYbZDQR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b533c6865so158655ad.2;
        Thu, 17 Oct 2024 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729161482; x=1729766282; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJQFaU9PYKDrUfwWE8Dyr8hUKo1FhUF9LzWiqIbRd8s=;
        b=UXYbZDQR7N9+OcRnDfKtsgyswxxHplpWBN6cIFleQJleXOPvQym2+vsUhQMBnkDuB8
         ayfJ8Uf6bHR6itvpBtgGUpWJrtEM6Bt18bKXTIFvC6nbZNiR9sIrZMpxWpKfXBbPAxlD
         OKzEJi4jbWbx+SL3l+CllslHSrfjyU1sTZxbzPHPjeBTcy1zpgmW/ggXgvaaTqT+bzEN
         vrwKJuJs0gVV6K0rOBzfOlP+RE+bJkNSUscWeK1bl+OWJjIQNCEr9LfrIUiPi7YIgl9U
         QsSn+F7QOzZ1p78AkGrX1jFTAgzzyJWzjQFLgzthEqZL5UaWzdoUXkiqyObtE/iTlv/U
         /+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729161482; x=1729766282;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJQFaU9PYKDrUfwWE8Dyr8hUKo1FhUF9LzWiqIbRd8s=;
        b=fr/4yaEdHRrQnCJ0xBHl3aVFHrsOepkUArUIeqEdY9EcCmUMX+tlRzP0A4EZlZ23S1
         m9H/Ij+c3++fm0WeOo/QqpaOoBfmXuyNYfMAKDWMVIZhy2ZmfxtAdaMMBdze34XPkIqU
         ojkU12b9cK+6qxywtKG9kkwhQX2r3jI4dWu7LWECmDh7NcNU67MPyomGccxf971eYGvY
         CUtvqhoSBh60JkP+IIMn3e0xYXn/sDLTY+6mIra/VE9Qpl82+zqnaPh7Ej8Kj91qU9x5
         6q5bKydxpFfkcX+hGIylH1YXUuvVi6UJgluH+PHbwLfU/ptadj7QRQuJh7cc+4WpnEE4
         mzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+moQiaZoBDlyce6rV9a7MPSShiBPtCl7aMx0CWSlOxxGldaLGQTC6/sLIggN5+tyig8CgqN+G3bJUaOzL@vger.kernel.org, AJvYcCVWlwfjVoNfwpCQpnQSEMy1bzWvcFshqQSVteobIuOFLuGEsEJN055rZ30ydng/qsFseCcqKI6KqWuU@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaCtEXXL6bFk0z23Fdyd/D+TfYiooNtl/w7qU48RAZmHDgOq1
	M4ObBjtk9OQvloaX75DdlopL1HOLV5TvTNNM/bMeFa2DjHnwIRff
X-Google-Smtp-Source: AGHT+IGyGn2AOOUh3MpR3jBqCRzIX9fVl91xqa1PifHlX+dSApMhtMPDdJB9mUxD60nuUASNIab5bA==
X-Received: by 2002:a17:902:db06:b0:20c:876a:fdac with SMTP id d9443c01a7336-20d47d13fefmr15666585ad.0.1729161482324;
        Thu, 17 Oct 2024 03:38:02 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d51esm41899025ad.104.2024.10.17.03.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 03:38:01 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH v3 0/2] iio: proximity: hx9023s: Add performance tuning
 function
Date: Thu, 17 Oct 2024 18:36:43 +0800
Message-Id: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALvoEGcC/5XNsQ6CMBSF4Vcxna0pFyjo5HsYh9Lewk2kJS0QD
 eHdLUyMOp4zfP/CIgbCyG6nhQWcKZJ3aeTnE9Odci1yMmkzEFCIK+RcGcMHDNaHXjmNfJwcuZZ
 r7yy1U1BjAjiCyCQWRqIAlqghoKX3nnk80+4ojj589uqcbe+fgTnjgpd1BSB0rVDjve0VvS7a9
 2wLzHBE5Y8oJNSappFlYctKVkd0XdcvWs0V7i0BAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=xvy8QYUo0YSyjxJgjQdwvoTCrWBXm6b95/ydl1O85og=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDOkCL07X/a08+Nxp/2O1oP2NdmzhkgVv1WYv9VQXlhTKK
 34Q/fB9RykLgyAHg6yYIsuZ129Y81Uf7gn+7ZoBM4eVCWQIAxenAEzEzoDhf8ab4JycorZXGbM3
 Lts38+LNCbv7xcNXTrp466B/rXN+XhnDf49Pvb9OXvopuKvJYmNTT/Y735nKDV/uMHMduSQcxek
 aeQsA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Changes in v3:
- Removed global register block configuration:
  - Replaced global tuning blob with individual properties for each configurable setting.
- New properties added for individual configurations:
  - tyhx,odr: Added scanning period configuration.
  - tyhx,range: Full-scale range configuration for each channel.
  - tyhx,avg: ADC averaging number configuration for each channel.
  - tyhx,osr: Oversampling rate configuration for each channel.
  - tyhx,sample-num: ADC sample frequency configuration.
  - tyhx,integration-num: Integration number configuration.
  - tyhx,lp-alpha: Low-pass filter coefficient configuration for each channel.
  - tyhx,bl-up-alpha: Baseline filter up coefficient configuration.
  - tyhx,bl-down-alpha: Baseline filter down coefficient configuration.
  - tyhx,drdy-interrupt: Added interrupt function enable configuration.
  - tyhx,int-high-num: Proximity persistency number (Near).
  - tyhx,int-low-num: Proximity persistency number (Far).
- General improvements:
  - Improved description clarity for all properties.
  - Updated examples section for better clarity and accuracy based on new properties.
- Parsing functions added:
  - Implemented parsing functions for the newly added properties.
- Link to v2: https://lore.kernel.org/r/20240926-add-performance-tuning-configuration-v2-0-fdbb654f5767@gmail.com

Changes in v2:
- In the YAML file, boundary constraints have been applied to the `tyhx,performance-tuning` property, requiring the number of elements to be between 2 and 512. The description also informs users that the number of elements must be a multiple of 2.
- In the function implementation, boundary checks have been added for this property, ensuring that the number of elements is even.
- Link to v1: https://lore.kernel.org/r/20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com

---
Yasin Lee (2):
      dt-bindings: iio: tyhx,hx9023s: Add performance tuning configuration
      iio: proximity: hx9023s: Add performance tuning function

 .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 195 +++++++++++++++++
 drivers/iio/proximity/hx9023s.c                    | 234 +++++++++++++++++++++
 2 files changed, 429 insertions(+)
---
base-commit: 7f6f44a9e58cd19093b544423bc04e1d668ec341
change-id: 20240923-add-performance-tuning-configuration-e2016e4d6e02

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>


