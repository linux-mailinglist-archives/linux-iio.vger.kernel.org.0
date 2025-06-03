Return-Path: <linux-iio+bounces-20186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD8BACC944
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 16:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1A3188EBB2
	for <lists+linux-iio@lfdr.de>; Tue,  3 Jun 2025 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC35239561;
	Tue,  3 Jun 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YuZxYJUE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF4239E80
	for <linux-iio@vger.kernel.org>; Tue,  3 Jun 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961477; cv=none; b=dSRyGSEy7T4T+oqL3jTYq5FYCtVwCl/XGSoNSi0ZX9Q37Qb77JE7oxDpzbYTP7msmA2TXJCMDgWpffV8+OZZ8/GXLevzXrvBvuh7Y87OghS4OeBt3mm7Ys3GFU7K3mYAZWsDINPoP51PlmiZxUtpg2Op4uy6Gc5j/dBxwCR9Xug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961477; c=relaxed/simple;
	bh=vFlQmUYfvlbdocc1660HFvFkLaTTtU9EJLRp4LGDp64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MtQ8m2wMQHbXFcX8Symf7WrPzQudomJt9HEyJwWhUhDdZjhOG81eL+JOieQ7sR1iSlNYqVXU0YyXIqlGPjYc3QNQqI0EJePh0mr+dVDIr8Swa/XQEwQ/rvuC/4b3pJW6GvZrgO65V2N63EsfSye+Qf3jqcNCNRfoB7UzAiMfmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YuZxYJUE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so24229845e9.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 07:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748961474; x=1749566274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q8aakW4/a4S4nlb27SNIiYOlQ/gC3M9NtCJYtqbcxPc=;
        b=YuZxYJUEsTYaEQowAoQreEgKrVEYlLdsiESbNeXAk9mbartslzVjXmw8pE0wC1QpBa
         7EaZcdTjS8/vPwlEkSvEFrE4RqxY71DuxZ/L0BzbZXF9zHomH+aD5QdlScuTMOoy0+9t
         +If7qpyQ7tfHXLuv55hNfScXz1Uh/ZqHjnmeN5pQoTjokw2O47n7no3Kr7XD9uiJhFpx
         PHjKwOwd7EdCy5Tcs2ymScXKc3OY8C2M0MJ89Zripu5ob5rEWLEX48agpXEQ6nj1Ux8D
         AJ1JXh+E2Cgus7p6+/AhcEFqM8Xr8h4oVlBC04lQ09j+Obf3v15/59sU28wwJZyBOk2P
         JQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748961474; x=1749566274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8aakW4/a4S4nlb27SNIiYOlQ/gC3M9NtCJYtqbcxPc=;
        b=gVPv6XWHTGZye1QX2d1Ub0RIhGMux9/TQP6GQq1/njtzj0STBrwBW9VBq9OFnv8Wfz
         n0F3LHb0NEUNRrc2nmdKfQpMpZU1LIxSWYiLTNlvdtY+qppS5JEVptOggEUeMP/ZXnC3
         Xr9d3go1QgsAUouj4yfD2Ea6SBJu80P9eY50CLF2Y3p5mkJlbM6Jffrvg25cbNDD+geY
         XE9OFMc8bp8SZ0SPeBYx1cP5YwZHHhSeNqXUNXejGcMATO3s9y7sQXzkhoO4DVw2CVPt
         jT/KJSHt+eympaCF2WJNheFWDlgAPabTC9LWTEsKNi8RcgV0L0V8wleqDQ9XdxJk8Ysv
         EkDA==
X-Gm-Message-State: AOJu0YxSvuts5cQ8fF/a9x9nHPBheIoZh7MeTDyJD1zYsdKFM53H4waf
	OChYVF3NwuOscCdp8npCQgvIVFtqiWs+Lp8lezTTPDpCMdEvUubwkn/84huuFUIMygc=
X-Gm-Gg: ASbGnct9B5vEVRKl/F9gxSID9wdN4lWfxouIAxAiOlOToFXTldoA3zqmjsicvSNWkdx
	ARZuZJjk/ieNFUY24TuWbKB8UxhItg7N5pAJ4QY4x0OofB9w5AXKSbPnpHj6Jz7IS0zOmBvfRtw
	dHIqN1ADGcsWRoPidtnr6YNCWXk65GvSv1e1yDLWAkuMVMrvQFc4bsh9ql6BAZAPO2vZZ+PLYfM
	3gdKkOp6rvVCrruPD2vRvBCO/C4m/ZfEWPHYtpnTEksioyvP6r4thHAjuFTnYcS0g44E465vvPO
	QpO8Hj9YZeonqfIfWhA5rJvZKjwUSuxoTSFvAEav7e8+lv5n3oPNzoc6mxOjfsJNhqlTVRa0LAe
	hAb7vyHjDfO43zstzxv1YqOYGXQFzBGunk6SJfEJ/0KqtBA==
X-Google-Smtp-Source: AGHT+IE63ru04iF+eA9B9ePzkthoe1PsuUeCbzbIdwhycOn2XyNJ7zYSmtNyfiB44EQBSpSKYQ6V4g==
X-Received: by 2002:a05:600c:8b11:b0:450:d4ad:b7de with SMTP id 5b1f17b1804b1-4511ecb9cd9mr125640035e9.3.1748961474126;
        Tue, 03 Jun 2025 07:37:54 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f1afebsm164430945e9.0.2025.06.03.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:37:53 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 03 Jun 2025 16:36:23 +0200
Subject: [PATCH v8 1/6] Documentation: ABI: IIO: add new convdelay
 documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-wip-bl-ad7606-calibration-v8-1-2371e7108f32@baylibre.com>
References: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
In-Reply-To: <20250603-wip-bl-ad7606-calibration-v8-0-2371e7108f32@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=m1V9a4luyCqmxst4hAeMv2hk5LxVMC81ZTSMIekPDQ4=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiw56h49tXVZsOVs7u3tdiwdDf/nZHMUv2H/8LtpwfEv
 /EGfIxX7ChlYRDjYpAVU2SpS4wwCb0dKqW8gHE2zBxWJpAhDFycAjCRg1UM/z3k71Qw8J28dkH3
 eMmC78z5T+fOubQioWfO24vVc/LXbL3F8M9U6MrctPkCW7pqfZ/Zn1ob27zxJeesj0UPdIzabVl
 /JHIAAA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add new IIO "convdelay" documentation.

The ad7606 implements a phase calibation feature, in nanoseconds.
Being this a time delay, using the convdelay suffix.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ef52c427a015cf47bb9847782e13afbee01e9f31..7e59cbd5acb85fd0909c1d56f9d76a84933d418a 100644
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
+		E.g., for the ad7606 ADC series, this value is intended as a
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
+		If shared across all channels, <type>_convdelay_available
+		is used.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale

-- 
2.49.0


