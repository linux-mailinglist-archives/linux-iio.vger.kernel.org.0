Return-Path: <linux-iio+bounces-13566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875269F3E3D
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 00:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B999F1630F6
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51991D5178;
	Mon, 16 Dec 2024 23:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="thxwnVMw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE877139CEF
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391783; cv=none; b=Majgy2WHix6aO5QGTXdAgmSqkBFEA2Nzotkizkj9BsSBdeVAC8UqxeZK+PdMEiFHTiYW8FebFyzvZEhBXfFC2n704j9WnnGqC0DmoQ8tol5jJbV9Wc4MGNo0rO52JHSkmWcIzt+T9bfEnNyZ1cGIrw8emzqKTDGYStz5dGNVy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391783; c=relaxed/simple;
	bh=wgy+DGz95rLXZzGMLpViNOWP4xCIogo/C9prc+0HeWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lhuZLNUcmUlQ49SvwWVbYkWKg4f/UeqqX/OrBkdSXp6XVFUXSYUKUDFdalRWBAcmHnR1s/eVtJgydblWyI1wPAPtbRCU31hTkwJQsNfjhfVpG9bMv2ADltW+ZkztWjszqpH9cpp2REJq1wTEk1RbELnuXdVSNBgQqdQ2dTOHG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=thxwnVMw; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29f7b5fbc9aso1075711fac.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 15:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734391780; x=1734996580; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZGKlIdzleOQOgogKiQHG+rlJ4na0K8drn/gaT8UmDI=;
        b=thxwnVMwr2QT4Uzm6cLzgrvzQQwM9PpcpxFMdWwTLXHp6K59R+n+Btr4F5dEPmxTA3
         jiLziBXJBu9sLA7ZjJD6o9dK/xr+mwWJYByNStEoLqSdBOmAfxqFHEN3wdB3Hor8Be4g
         d0j1dw9OWSXvZyaUsymCdq1B5iq8Yvs8jzE57lWVqak/ipmuj9qxF1Z4lY23/Pn1rPaF
         5520Iy8KH9ln2yaF+0bjT1AGbSU8M7YkKZqKEssPm/uLFgaTvtk/3J4wZygh0V6rfoyj
         NA9oblHcFw3L7qXEY5e2H7o3X7uiCRxRbqZQZXn0l9BPzdJT7hCtIsqOX/nmmDpxDLUN
         p4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391780; x=1734996580;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZGKlIdzleOQOgogKiQHG+rlJ4na0K8drn/gaT8UmDI=;
        b=FE30oBuNWclgmIrhDTdD2qXLkHQx2SMFjb1XWFmdJFrJ1RQ63+aHj9DMWdooMfraQC
         AhUrrelI/ah5fucmMbrE/P453LUVGbcgfR3yAi/DEHicxjcUfznBEnDMekwPxeEqtWzw
         4KgtbSjtmf4mxvyG7bzmziGQlCX7lEtcfYsJLzcqakb51207Xkf8Gf7sNBqwLXiUjphw
         737i5lo8twj0YK0AbkCbc3/dDOdfORlseu76XDSX2xLKqsIjR9VXj5DNbi7bp15z9cLg
         G4PFcAotlA/A3llyEYLKaS99EeOgdr+vOEVuscjY5mbH/IYovTckFRI0iR3I1QOkBgwr
         xb6g==
X-Gm-Message-State: AOJu0YyiF2s0hTRirCFGxm+m4SGOB95fEb6RttLQ9ketgzT2njt1N3Wy
	iIFE8bAmN6U1wjfTKCfdfcBiP7cMzWfRoeYW1F7JpiXL1AyiO7GadiZ1iCnjgg4=
X-Gm-Gg: ASbGncv/mbawX33TK/Jy2/Nclq/g3YVPRdt+vvf0pDIrNKK3dTpad/LrThO2U8W+1IC
	hPTMVK/1OaTPWxgIzCx1p4AMpIvIYURBzH1N8FW/+fnvODq4M8t+yLYtv3cGX+kmpgEBjZJG3qK
	Plh5jIZdrAOzuKtcHcF1ARl5Nnuh3LBjzV8nTB7hZAG6OJag0ARjnlrkVHxupUWkmRubzLczylw
	XMHBhHM7X128grSvBWr5L6iRPejox2ZPYV9KKhtbM0fBwd9igJJKGS9i+Zq9EaYPPjb4X9aGJH/
	4c3OBmNX2Lpz
X-Google-Smtp-Source: AGHT+IFTFZDOtZk5gcZZblKIymNzVXbS8q+btxlxMRcxZgFwith2AML98Xc6t+7AlU6rzTJT6WlQGg==
X-Received: by 2002:a05:6870:d106:b0:29e:766d:e969 with SMTP id 586e51a60fabf-2a3ac62d68emr7841252fac.10.1734391779730;
        Mon, 16 Dec 2024 15:29:39 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d29cedb7sm2352080fac.52.2024.12.16.15.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:29:38 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Dec 2024 17:29:36 -0600
Subject: [PATCH] iio: ABI: use Y consistently as channel number
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-doc-iio-use-voltagey-consistently-v1-1-9e34a72133bc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAN+3YGcC/x3NQQrCQAxG4auUrA10hlrFq4iLmv6tgTKRyVgsp
 Xd3cPlt3tvJkRVOt2anjFVdLVWEU0PyGtIM1rGaYhu7EEPPowmrGn8cvNpShhkbiyVXL0hl2bj
 FVS5Th/55Fqqdd8ak3//j/jiOH+JnSJZzAAAA
X-Change-ID: 20241216-doc-iio-use-voltagey-consistently-0e8c7f4e6b5c
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Change X to Y when referring to channel number in the ABI documentation.
There were only a few cases using X (and one using Z). By far, most
documented attributes are using Y for the channel number placeholder.
For consistency, we should follow the same convention throughout.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 50 ++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f83bd6829285cd507c493cfff088158228388b67..0e45996625cfea8bf7bbee30382f432273cfbbc4 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -227,7 +227,7 @@ Description:
 		same scaling as _raw.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_ambient_raw
@@ -416,11 +416,11 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Scaled humidity measurement in milli percent.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_X_mean_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_Y_mean_raw
 KernelVersion:	3.5
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Averaged raw measurement from channel X. The number of values
+		Averaged raw measurement from channel Y. The number of values
 		used for averaging is device specific. The converting rules for
 		normal raw values also applies to the averaged raw values.
 
@@ -448,7 +448,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_magn_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_rot_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_angl_offset
-What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_offset
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -660,10 +660,10 @@ What:		/sys/.../iio:deviceX/in_magn_scale_available
 What:		/sys/.../iio:deviceX/in_illuminance_scale_available
 What:		/sys/.../iio:deviceX/in_intensity_scale_available
 What:		/sys/.../iio:deviceX/in_proximity_scale_available
-What:		/sys/.../iio:deviceX/in_voltageX_scale_available
+What:		/sys/.../iio:deviceX/in_voltageY_scale_available
 What:		/sys/.../iio:deviceX/in_voltage-voltage_scale_available
-What:		/sys/.../iio:deviceX/out_voltageX_scale_available
-What:		/sys/.../iio:deviceX/out_altvoltageX_scale_available
+What:		/sys/.../iio:deviceX/out_voltageY_scale_available
+What:		/sys/.../iio:deviceX/out_altvoltageY_scale_available
 What:		/sys/.../iio:deviceX/in_capacitance_scale_available
 What:		/sys/.../iio:deviceX/in_pressure_scale_available
 What:		/sys/.../iio:deviceX/in_pressureY_scale_available
@@ -1562,7 +1562,7 @@ Description:
 		This attribute is used to read the amount of quadrature error
 		present in the device at a given time.
 
-What:		/sys/.../iio:deviceX/in_accelX_power_mode
+What:		/sys/.../iio:deviceX/in_accelY_power_mode
 KernelVersion:	3.11
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1691,13 +1691,13 @@ Description:
 		Raw value of rotation from true/magnetic north measured with
 		or without compensation from tilt sensors.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentX_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentX_i_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentX_q_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
 KernelVersion:	3.18
 Contact:	linux-iio@vger.kernel.org
 Description:
-		Raw current measurement from channel X. Units are in milliamps
+		Raw current measurement from channel Y. Units are in milliamps
 		after application of scale and offset. If no offset or scale is
 		present, output should be considered as processed with the
 		unit in milliamps.
@@ -1864,9 +1864,9 @@ Description:
 		hardware fifo watermark level.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_calibemissivity
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_calibemissivity
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_calibemissivity
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_calibemissivity
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_object_calibemissivity
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_object_calibemissivity
 KernelVersion:	4.1
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1887,17 +1887,17 @@ Description:
 		is considered as one sample for <type>[_name]_sampling_frequency.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_co2_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_co2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_co2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_ethanol_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_ethanol_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_ethanol_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_h2_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_h2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_h2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_o2_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_o2_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_o2_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_voc_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1905,9 +1905,9 @@ Description:
 		after application of scale and offset are percents.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw
-What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceX_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_raw
 KernelVersion:	4.3
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2096,7 +2096,7 @@ Description:
 		One of the following thermocouple types: B, E, J, K, N, R, S, T.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_object_calibambient
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_object_calibambient
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_object_calibambient
 KernelVersion:	5.10
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -2172,9 +2172,9 @@ Description:
 
 		- a range specified as "[min step max]"
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_sampling_frequency
 What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_sampling_frequency
 KernelVersion:	5.20
 Contact:	linux-iio@vger.kernel.org
 Description:

---
base-commit: 01958cb8a00d9721ae56ad1eef9cd7b22b5a34bb
change-id: 20241216-doc-iio-use-voltagey-consistently-0e8c7f4e6b5c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


