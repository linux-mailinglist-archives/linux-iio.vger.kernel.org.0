Return-Path: <linux-iio+bounces-19280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F37AAF775
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11521BC409C
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 10:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10A1F473C;
	Thu,  8 May 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IVnx+0yg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BA1C8616
	for <linux-iio@vger.kernel.org>; Thu,  8 May 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698847; cv=none; b=A/6r6hIHfUZEEDeuKGKFWiQMhDMnIZ9dX/05SBZbboTam6sbm8E/blaGv92NXv+BvKkdxjm+mWbNRB8y1zLMj+9fidiIIv4xreVduROvst1rBQ4jOcM9Lyp4XCAXUzWYQL9ugwlAQqLB3YlnH6mzx60xTIOzo93AXPWYpHG9Zpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698847; c=relaxed/simple;
	bh=c34LXBKOq4PSMyWSsSO+ts9OsCRuGWRV2pACF1PcxII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j7vIQtASB/UOVbajmQ//4OA0Ryz4+VAJyz5PmCKTnVLv5cChub7G3v7mIzk0Dnwu1ksl3cCHT29rhHrm3n3+A+t2xWixkPdxae9qNVhgPRB/cm9n+/vUfSM5dxGoU5ew/MytDUf1uso2Cv7nTs55kfvpnw+OI8Fw3rtChD+Gvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IVnx+0yg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso8640695e9.1
        for <linux-iio@vger.kernel.org>; Thu, 08 May 2025 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746698844; x=1747303644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MqbGpHAL54CKQrNSXS159TQ/VcIh5UIaMuWVdpOfj8=;
        b=IVnx+0yg12oASdeDgBUhQKcJOMQb8gWYJtWoK8iQBh8edA7J4uGnd1dXrkiXKj5QL+
         pB6djt+N8EVtKIAeytrYa+9iFVf3EagW4yVE5cZep8znTk6DL6+9d48zFxxwA7p3rk4t
         +aoGq5c2WMlEAbSyXl/szh4V1nbqLhjPAT/ZIDLnJwOlazAWrIlEiqmidzTYOFYGSPbs
         3db/vLpFB/9SCVhcV4kPMyvftH5QD/Ep9H3TVy0u2tDFqciZfBfqLghqzNpEhqcODz8T
         MaJBd4JHX5HOZDre59GnRNpnaYQeg6UyDYLZn6Qqv3vzO6RvuwX5b21jwMARPxy5QYIA
         dMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746698844; x=1747303644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MqbGpHAL54CKQrNSXS159TQ/VcIh5UIaMuWVdpOfj8=;
        b=euA8Ypdo3bs22xduW1V+mOaIdIBibUQjVvrLSO8dF8Vfa0Yg6JhkKI6k8h3CI9+Nhu
         1rIAfYB1A5T4MsyOBaLbnlTycjYr+5nrJc73wvkJP5NRwoL2dFMCT7jB41lPd/LWSGsA
         nJCUbnu+2qhAwNMZbzujqs3hPRB4ozFWLxB2aaqCtL6c6E7EuOhF6PjnDe7WvF+wbGe8
         029t5fjPr1WG0NICvHT/o/hY3OhRCcnlgts+1+mIg6R9YfJxZSqO78L79VaDeVGJJN8c
         lRUQKadawXKJoWS4pyu1rbaguLsrpnK3aiQyk/YuIUCDxIimOXl/k9kapJSukpTrSUz9
         eh2w==
X-Gm-Message-State: AOJu0Yyj0jm7iMyUbYgeqiRbdD4yeJGvDDuCPFSUPLSoU+Hwx9t07cIT
	2JpZBeuu+L/+I5YKYBeP7Gd3+cC6kdSQXtsLSQq6MZNzB/7Z9EKD3Z3aa3mD9kA=
X-Gm-Gg: ASbGnctzMjPT8QTZ/Oqa/O0ePmOyoUJgLWU/n0KAictxykNvZzZ1hZjeYqEPDNRQCX7
	iJ5fT2b22B1QL9r1FQYX82alPsaYrEHCROBu9bd/Zc8kKOTlxTqRiWcoil4IGh15aJZnLj+KGAa
	USKdErR+zBYqfOotHKUO+ncOdlQMCXqhz0YktTsip8Qd39lhKmfThecFv0IR/xXJ0RCOHERK3wT
	UK5BCOf5ymqNJqK5xhKatYw4/+QwihYOlf1GdzT0CfyWriS3ZZTmICUVe2oUj9b+A0SKYNhyYLp
	Ku4k5MuXu3vDv7wv84wgAW6Go+zYOPFmslAA8Gv9vhQeCe2o2bl8ANW/57GLmOiYAhEi/SXqTvF
	LbV19tgWopzw/
X-Google-Smtp-Source: AGHT+IFNZHHC+9WQcUwQsj8mNUTrpnqqQYktIGb1gLgA3T6EU3BtAN3Ag2Xvgj8RBKHTo6i3d/WjUA==
X-Received: by 2002:a05:600c:1394:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-442d034bcffmr29776775e9.30.1746698843521;
        Thu, 08 May 2025 03:07:23 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd363940sm31699665e9.25.2025.05.08.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 03:07:22 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 08 May 2025 12:06:05 +0200
Subject: [PATCH v4 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-wip-bl-ad7606-calibration-v4-1-91a3f2837e6b@baylibre.com>
References: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
In-Reply-To: <20250508-wip-bl-ad7606-calibration-v4-0-91a3f2837e6b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=oTr2y1KzI44sJPbPH4SmBsKovzD+NKhk9SBNTTYhjpc=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQaeJXEP2mWPkgsFDgmEK/6uYUhUV7bh0v5c0LfyxQn
 PHR9+D3jlIWBjEuBlkxRZa6xAiT0NuhUsoLGGfDzGFlAhnCwMUpABPJaWJkuBzOtcj4a19uVtaG
 xZ3u87R3rhSI2y41teLHR1bneIelUxn+V7E6v9rw6qbZrbSdHLtPG1pM/KDzoL5lrfgKjq/9BxY
 4swIA
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
index 190bfcc1e836b69622692d7c056c0092e00f1a9b..9ced916895fbef146d46d17b5fdc932784b4c1df 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -559,6 +559,30 @@ Description:
 		- a small discrete set of values like "0 2 4 6 8"
 		- a range specified as "[min step max]"
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_convdelay
+KernelVersion:  6.16
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Delay of start of conversion in seconds from common reference
+		point shared by all channels. Can be writable when used to
+		compensate for delay variation introduced by external filters
+		feeding a simultaneous sampling ADC.
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


