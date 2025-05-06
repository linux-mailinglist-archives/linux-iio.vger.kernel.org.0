Return-Path: <linux-iio+bounces-19213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF4AACF2F
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 23:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDB91B66D16
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41751217709;
	Tue,  6 May 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cglRShN1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B84F21578D
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746565525; cv=none; b=n9dhqMXM9ukmes/HwXPmlimmygr0bnM9bU+Ny6UhIntsAjZgUffZvQVnGnvdy/dRkl17NFYg+sho19JQKNBkruMDvrn8OYM2FAEtJwB7oEPLLg77UHCzLu9IXP4nNSIY6qOhzBHG6iu/HTG/DwbKI0GGGM7xrJqfJfLARHFW7p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746565525; c=relaxed/simple;
	bh=c34LXBKOq4PSMyWSsSO+ts9OsCRuGWRV2pACF1PcxII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJ7LVPTzXPzrbSpp3u5XjgiZ5j8iCFvu0FNa2CMnBYJcabi1Q0/s/74FhChZ/ikw48iS6iuUTon/c61CB7/VLqgTT5QjRFpOycg0PGceSezLpDlpLykklNz3Jud4x52Zg7/Q1+OLol3uvLr8ZUw0MmTEJz+pivozBpUAmQX/lLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cglRShN1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so35330075e9.0
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746565521; x=1747170321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MqbGpHAL54CKQrNSXS159TQ/VcIh5UIaMuWVdpOfj8=;
        b=cglRShN1iKHpMwZrL0Tl2tGB4HD9J/qgalp26S5nZTJvRJ9iLZeDL1NIk3R8EPOPJS
         /Ka/qsptGPF4PucW7AXzlV5zTfYW1FEPKX48qODipEckL+Bbva6uywVytnhsjH8wMGP9
         DznGag8Uj4WVS/gTFxEMicmF/mFhJ2MKOpKXO26YiR5FiqPspTV9mH2rolHf17pITdfp
         Oqw6gGtqFlaEP8uPPCiYhWeYiJ7MLgpcHVAQup1p+kA7OqFp++Zn382sq484DGW7qj5A
         Wk4jMHmvhn5jvEqcdFEPemLr5wTtZ9kIJnBUa2TRiEsqxRykbjmgv3TNh7t9du/LJ1pu
         uSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746565521; x=1747170321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MqbGpHAL54CKQrNSXS159TQ/VcIh5UIaMuWVdpOfj8=;
        b=RErvkcuVY1J/xK2x7ql+p03G7XnY3hN9fgjf2HILdvFI8QrqqtvtsGP1IImKRaRsK6
         Kyeu6cSZMSxkd9DYm+BBPz7XvGWlR/XVFuDdmk576q5LQeUWeipgRDhH96tXSKUrP4Dw
         w29TMB/s1dahS64aWe6ke+F23Y9osqWsh7zc/fXiP3wjanzXPjt5ccf75vZGn+9t83kN
         G8n/gw0SBGs9SwqFN9zZyeBoyrrBWha6d9mszjhk8hZEZA+WCLATJNH30XfSPmjnBea3
         nh4iNJLzL5HmESxMcMqss9RFXAn3CIrt/CJ1Di5jhSnZqomyvWfFrfpZw+VfCWMLVpjj
         YbqQ==
X-Gm-Message-State: AOJu0Yyn0WtuUd4KJpSZivL5aQbacxSDzlCkI1v0WW3dlw73uQ1Bfjyx
	aZDoJDVjpeMNy0Q+twB9bU1BHbYFn5Q0D0V3/ORQ5CyYFOschX24su9fex+L0pU=
X-Gm-Gg: ASbGncvUKPKBQehtlbY5Hc5fA7x8KOQLQk6MmRLOoG0tu4buPqawy6fl1M8gpplT/QL
	qNpHDhSiry+zZ7fJS3aMjgFBnY2yUYQcbxkFuY+XZC81QG6g+iTcsjv6fqM5KQuSQ9HSN+Gf9FA
	+t0MeSF0NNASAkKF5jeGCS3Yby+H5Qo3JE+6fs0rJebmMgUT7oA6kvFsTGdfpLcXyCc9Fv6h3mY
	QVuJ87Qx+slGDvj+Tc8KQmehzTZu7085mq466OqiOvizi8TroupWARSr75faSiUT4QHHRL920nX
	WsKdk9XQBDntLtdNzeVGA6/UK0usv85m6wLk//BYBBpy/F4zWMuKBYHLeLWO7SP79jmxgBqZ3p6
	zXbAsHoX9ePlB
X-Google-Smtp-Source: AGHT+IFlUTNk00U/jOod4LoWdgj3uhED7W4B+2ckuAXgwyDyPponiM8zC2OfHdl3IjRP7wkbTjSvKA==
X-Received: by 2002:a05:600c:3d05:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-441d44c75c8mr4539225e9.15.1746565521351;
        Tue, 06 May 2025 14:05:21 -0700 (PDT)
Received: from [192.168.0.2] (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d4351abdsm6794475e9.23.2025.05.06.14.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 14:05:20 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 06 May 2025 23:03:47 +0200
Subject: [PATCH v3 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-wip-bl-ad7606-calibration-v3-1-6eb7b6e72307@baylibre.com>
References: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
In-Reply-To: <20250506-wip-bl-ad7606-calibration-v3-0-6eb7b6e72307@baylibre.com>
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
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiQqnT/5zg79e//urexjcsPrzU7UmXRvdBHa/dT5WlRd
 1Ot76YXdJSyMIhxMciKKbLUJUaYhN4OlVJewDgbZg4rE8gQBi5OAZiI3QGGP7w6jXO9/NPfbXN9
 sWHJzuQ7f+afWbf/8Cv5yObz13S5zn5gZNj9dMclxYqJIV+PszkEdu6Om1Jg7H7M3OjUj/MeQSU
 rvDkA
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


