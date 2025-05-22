Return-Path: <linux-iio+bounces-19796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE52AC0CC7
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 15:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1D9163316
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 13:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045228C02D;
	Thu, 22 May 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lWdas4wc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0A28C024
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747920590; cv=none; b=NQPNx29OW5AM+V7grCskhxwuYZnYfTL2PQVPnvWEkdJjFv4AezCryaL7gdvYb/heRNCo14WLQMPuSIFOheP0QuoljsXqZ3V8KYfNfAf/Lco3VMA5AaUUzikQRHzZJ+LwYIGLcs1x0JoRNp/GOwQjfZZv342gbXR94sy9zc6XZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747920590; c=relaxed/simple;
	bh=YrwGPle1vRMvNrNyL9LQjc/TjcWTu0zCVNEro4vtr/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJlHQizh6J0rQlZsJibk7cl7TXfKL2f3O+z+/YylQm/VmpSlqIQ0zdLxv6iA/aiSvrVZXT1QX8Oi+Kx+NxoFRYt5OLxR718l1eBdO+skgSod2FGVJdzOAAxizQKd6TD3DUk1p5g32DnFEMcZTofW9Nv/1Hvu1vLT0k2i6HrYsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lWdas4wc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ede096d73so59367805e9.2
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747920586; x=1748525386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWHo0zKDSXKOpTabSxCDlLtRaC1LPKcPJczl49PtBbo=;
        b=lWdas4wcgXox0vIq2oxalscsnmPOMlqFK57Fro6VF4/TSXNWItS+BjcRSx3lvCKmdX
         6PptKIGL6HJMJW0UnR+Y5gbgVIQq+2jQvRGl9rxc9AxQ85CdmpK9KPoJDw/dD2o7lEv9
         1vuLcmOotpM1Mjv/WWEh8zM4g+Ym3XTCOhJMMd7DcysIgKUgMOcxfyo7JuuXiUOUZtcV
         SGimVC44BlN2zxgPXTCA+SJ3U6qF/IRG0fIDTSrqM9czPNPODli5HVPxywtTV3YGP74o
         vyEYeGbucQB8iz3zmuRsVUi1mSytWRFxPsJUXYKN5nFnLOI6nFag/hHu4+xA6O75ejfV
         o6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747920586; x=1748525386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWHo0zKDSXKOpTabSxCDlLtRaC1LPKcPJczl49PtBbo=;
        b=qlZN+0S4sYurVCLy4tLLXzwG4fAeUJ2uoqg10ijiXjLXfwwuOo627zglXWdg18kZVR
         TAAamsOdY0ji27j0m3OwiCo0gOF/SwCFF6nku0c4XNs2H1L6ZHTF4lnPpEkWHNN/kQYt
         NoUFjQke7PaY1qm/QlNOHaKOB3U2veald+HHXAWC9bKuhYzzBuLR3fk+ehPY6joXDTe6
         HiR1Bpflr64C2CaWPsjGqMXFgB46XLMVg2Ef4tkkBdQJ+hZO7k7PmzwwS6EYL78MvniC
         cQGrED1/pLN3sjuLPxrX4LA6V6nsE4oBjmZLSXqTeB8FyY3k1tO2SVMvrT10Pp/a18ir
         tfiA==
X-Gm-Message-State: AOJu0Yye28XwclKx6TtApt118nfdhQ89FFcwH1T/rHJf3qfDUamr24Kc
	iTbCqceCAbjRrOIRUqCfje1stJG0wJM80XxOznAKFyMKmEv/Nm0LTqfVBySdRVORYM8=
X-Gm-Gg: ASbGnctliRcCPtaC0SIepE0EyJczJvh9EJbbNVik32CJd9mMF3ZvNEg/he5Tkp3pnVq
	3h2zzG3pfcuKD9SABt2tam5/vPJFw5LS3gEntcIibyJiH+0yGLKyB1wfPmYf+Wj8sjarAPxz65d
	h+A3jFIRJbP6hqD7Px7/oJmbDdYU/ZOrTluag14z1NWTckPnobnBPsL2qZi9KBoq/tY4Fp23Xco
	WN4mmSUcDZhNTb117FAxR9TI5rbDMFE8elwOc5PzJ+Qp+773AU6+0a2O/kfbDcw5ntvwytJquU9
	ZCAxa/vAgQylZKr0W2T0H0GvlDPdMbjsCtLxnhQp+mvq5SjpG2rdoCYcgLSlRqFOrP3AOTS/U+0
	DFjfYZZ7Y0DG3WrCF6t+RtRDVORP1rxg=
X-Google-Smtp-Source: AGHT+IHQa6LxPe67N/+IRPD2P4wAEMn4wUFXrSblbK1eqdEuW+gSKCrMe35vuj6svYp3ZWgCrVQ8OA==
X-Received: by 2002:a05:600c:1d88:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-442fd64dfbfmr252190045e9.19.1747920586338;
        Thu, 22 May 2025 06:29:46 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef0b20sm109837585e9.14.2025.05.22.06.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:29:45 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 22 May 2025 15:27:02 +0200
Subject: [PATCH v6 1/6] Documentation: ABI: IIO: add calibconv_delay
 documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-wip-bl-ad7606-calibration-v6-1-487b90433da0@baylibre.com>
References: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
In-Reply-To: <20250522-wip-bl-ad7606-calibration-v6-0-487b90433da0@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=MnikOzSRNNhylv/Xr1wy9eMKECvl3Lvhp3h+t82FVuA=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsjQV/PsPPz4yyt1d0XL9WesOP3nzfLqn///Zqeg41ql9
 VqLcm7yd5SyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZjIPSWGv3LtbmferXqZPzGf
 63++a4TZk2QX97OSpeeY702ewS+R0M3I8Jj772/BPzc2T1S55Xozf3o4+77PCfeUXPZd+p396PN
 8Pk4A
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add new IIO calibconv_delay documentation.

The ad7606 implements a phase calibation feature, in nanoseconds.
Being this a time delay, using the conv_delay suffix.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ef52c427a015cf47bb9847782e13afbee01e9f31..cd79c036b2ccdea016dcc17f4e8ac5fdb2d0e465 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -559,6 +559,30 @@ Description:
 		- a small discrete set of values like "0 2 4 6 8"
 		- a range specified as "[min step max]"
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Delay of start of conversion from common reference point shared
+		by all channels. Can be writable when used to compensate for
+		delay variation introduced by external filters feeding a
+		simultaneous sampling ADC.
+
+		I.e., for the ad7606 ADC series, this value is intended as a
+		configurable time delay in seconds, to correct delay introduced
+		by an optional external filtering circuit.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay_available
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available values of convdelay. Maybe expressed as:
+
+		- a range specified as "[min step max]"
+
+		If shared across all channels, <type>_calibconv_delay_available
+		is used.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale

-- 
2.49.0


