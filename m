Return-Path: <linux-iio+bounces-21939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABBCB10816
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E25A5723
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785626B096;
	Thu, 24 Jul 2025 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3zlI7h5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F75213E7B;
	Thu, 24 Jul 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354099; cv=none; b=XZkwU7j5YGRuZFTlFQgaNUTGw5a5IKT4Rz3limi3wOTNpNMpVDSWJ7Q2TfRCOWniiMTMJOuxXQrqhvFWrHzyTZ+9OhF+eHmAKmXjE+Sxlsop8boVwN2AbLp5ZqobFktIMnqNc20f3p3qMwmSg7Q2uIyvd/VmbV+G7jPUN07lE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354099; c=relaxed/simple;
	bh=0r+c0H4Oa2YbTVXkH21anzADfU6e0RpmuRgOU1H3T2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tubkJxdftsp7zmyRyiu0Nc3DWT5gYUMCSz5IIKnHqjmxAXvo1E9xte+KDmF2EQE7x/j+tV2bgMx6GDh2qRwN8oOCUQkchBXt5tmFX6FXWhKm0Zvv5NumNyEr7SVkUnG6V8N+w+nlpvgiy+n49qLhJ1RINq8MqtXRA7vOnnIR4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3zlI7h5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso749526f8f.1;
        Thu, 24 Jul 2025 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753354096; x=1753958896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epKJDnncojFJAB4/ScTCie0+aqU1iYFXS7qoGiODn9g=;
        b=R3zlI7h5epS8H+mQ/lpNJKw++EOlWH2ZLNdTDDniyFNwD4+eTVDOy/Z0BE8DubD3w8
         GK66/bp3QMqi3cxlRPDBXwa94tl22/aq3hfo2aDgCHdCYO1INkjPPeIUdJwAroiMX2QP
         aArZ/WGsQmTJbvdB0ShyZD0Y9LJaeZS5hJlRgstnfueOqBW3BKy56k8CsjbZeLmZ5/Pu
         kJPwkPeoQUQnthaFfwKFl3UiTRUbZPP4D7wARe8SyoO9gDMd6Kqm9Os1IDe1lseWlCio
         OKgN16F/0zgdJ3wBfQD0hQssxRCkkSGxVgNeBfNWdJwxUEZt1q/vgKJJCMkMLAEAzKyJ
         4YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354096; x=1753958896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epKJDnncojFJAB4/ScTCie0+aqU1iYFXS7qoGiODn9g=;
        b=npDtMrWrR1V7bMHxNafbgEDsQO+RTqHpRMa3BBIQwjkSnMD1+mbhFhyWeajKnP0S0y
         kZMzFgvgmmaF6LfWG+R71rwWfEFLQVtcfUzy8Xhd4KlYGRMHkp63IkTYQLYmSDFNLyDf
         sUgYb2MmA8E0eucshXp0u4siaK+/QO/4F0UJ+dyGrsjfzbv1o8/E79TKQrvcvIlzdNM/
         Gz2VcNF8Ip9MUdV1QPs/2ChllFjSoaoJyqX8jmGWWxsy26y44uiZ70YUaSd9JelGyGEw
         R0BhwhPvuHnwn007W8dLgx/O89WgziUq1pF1dp0wHHeewimNEwq8fOLPa1Qg9E0NT/8R
         lMkg==
X-Forwarded-Encrypted: i=1; AJvYcCUrHlXWWUMJjN/rCMR75YUbGuVQ6Z3VE1ZYXGO4gCMZKY7ISvjkq3dlFHhBPTfI1n5g8TU5OMOARQw=@vger.kernel.org, AJvYcCVJhSbxFmFNoKlcgQRgjp8hhI5YQe7O0XUfIQx4hre7wx+XbcEzYg2O+jFgNBow3yeQEqFajya8gBbuEsU9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3u0qTn1CyQAfFpk3DUHS+tNamkyZ4156nu1YeoUpg/eMDVuxf
	5C+ifA7sGa+sDZ1sZbuySo5IaI7nRFWJqA2L+rOuQyWGeQd9SYkLBEQb
X-Gm-Gg: ASbGnctlQPXUGNH2W0DrsSu/wi5VRK9e+0LVePzgLMbkmfD/Y4XinojAtNqPuSTD707
	Ol2sm8p+oLH1PWo0EWBr4sxx+IUOjix1ULxp6Ll/bhDAZZo7aLsCifYaN2jH77XkCvJEEm05p9m
	tOVqC7ofa8LHf9ZjowDjrRvxsOuiP6BoKFVKGWdGluWKS1idD0lJf2srPnOTSnHfumb8m/ypSX3
	LXyFOUhCSvBRrybBHTkHwWRhCuOB+2fIjKtIJ3dMzl7qX67kRWe1motfq/02LhtTeZF6vGxo5vD
	oAoYlyU6sCQRw9tyfl7jlDbs6LapQrfDNP5f+XSoNSLpf2ut/4Y3pfFpi65VLp+jZoQadzbBKBd
	8kUHi/j4aZb6p/x/SjPbh
X-Google-Smtp-Source: AGHT+IHkldGVGsG0ep8JlAtN9rxk5nIv0yCoIjsz2etjlXZP5GLYxklMv9H0B7ipr0Tyun6POO86Xg==
X-Received: by 2002:a5d:584e:0:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b768eedf78mr4968159f8f.22.1753354095752;
        Thu, 24 Jul 2025 03:48:15 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b76fcad29dsm1759726f8f.49.2025.07.24.03.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:48:15 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: magnetometer: Fix spelling mistake "Magenetometer" -> "Magnetometer"
Date: Thu, 24 Jul 2025 11:47:43 +0100
Message-ID: <20250724104743.139892-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in the HID_SENSOR_MAGNETOMETER_3D Kconfig,
fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/magnetometer/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 3debf1320ad1..c7809e5aa3a4 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -123,7 +123,7 @@ config HID_SENSOR_MAGNETOMETER_3D
 	select IIO_BUFFER
 	select HID_SENSOR_IIO_COMMON
 	select HID_SENSOR_IIO_TRIGGER
-	tristate "HID Magenetometer 3D"
+	tristate "HID Magnetometer 3D"
 	help
 	  Say yes here to build support for the HID SENSOR
 	  Magnetometer 3D.
-- 
2.50.0


