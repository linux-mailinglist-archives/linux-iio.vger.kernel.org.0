Return-Path: <linux-iio+bounces-21591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB6B025DF
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 22:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB280A437DC
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 20:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD2420DD52;
	Fri, 11 Jul 2025 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FIOs47Zy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA21DE3CB
	for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266685; cv=none; b=ciBp4yzXPS/8ag5ti1UI58vGFIh84zAXAq038HruZawzQ3wi9AXr4xa7SsVQ90Z3c8Jt445obDfqdUZul8frdW4eS2g8lElZnE89Wjidu+DUAEYxpCzquDvSkjexBe1X+tqA4GHm7z1N4UK8IPlaqxYTVUlvJ86Phv7ZDV+QdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266685; c=relaxed/simple;
	bh=jRPzFACSniA1kzYqYaW7+P2QzYJ7Rs5qV1aSy2hpEX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lVJbfZ9WMmyRU8yMj31fREKk6F7qlxVTMlrnNpYEEZGzDajc980wETmYnGdWkUE4G0FqdGwBWEExH+GQzU05MXBl+RhwVVqCtj6fWy8YGcY1VO1seRM4zlIkJoxiQUmcCQ+Aw091QUj3al1vUp0wcjiZSvmEtLsMozCecoqg02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FIOs47Zy; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7387f21daadso1889531a34.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Jul 2025 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752266681; x=1752871481; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yoRA2UoxavhqErjNvvDt8joe62BXJO8rlkyVJ8XdQbc=;
        b=FIOs47ZyTjP0MUGFbCKdmJmc8S27IFE7EEI8a+b2fXVPTrRa3H1HQ/EAAGeiNXA7/M
         c0U5QSOPqibsGMeul/nLhRAZCbED4/kS2Jgk/ZFhdb35WeH8aWbh6/JcUQBViVzaNDRm
         H+kubwCVQKRIjSgwfMnD2BZp3mwQrn1MNGGBsRJzaHlzJsKI/xoaGXulimTWQGsvrTaj
         fQOEACPDpI2z50apiA01ip2/DDgqp5id48JwhJqIm4tKVbg6Mo2+vAbvwoJKFPuJd+nR
         ssv///Q0vNMvLDBxIq7oNRyGccBkLrSeIY9ptFoQqMtC8INjA50P0O61MEyWscqRov2Y
         EwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266681; x=1752871481;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoRA2UoxavhqErjNvvDt8joe62BXJO8rlkyVJ8XdQbc=;
        b=Tl0fyUKSKGT0xhRo/ds0muKaeNJjZEaIDsdnCrTRR3RO7XcCxNgCp4ZksqMaeVaQvd
         Myfb0BQjuKsMAWqtoJ2Dpiy5qJoJRwnGt/mJYmUAvTBj1GY4c9FuvBNmM939ZUSPylAa
         Q0mO4nOzgOnfcsNe7EHQ9L3bZRPE0ppjRtL/ZGCppITs3biIrY0ebN/cgXK/yFE1rsJF
         aqrBcYQke5LDitLliKesCiAyXOxcoI4OgWhNgNF2YBK2r/gUgNZJH+UofDLncpp+BFAl
         hPN48Ncd5VHwcbTuNG7UvTsfMHYiO9eWuM2RNbw9tOnY7UX7bvKSrchEC3Riwj6zXQaA
         5N5A==
X-Forwarded-Encrypted: i=1; AJvYcCUeSo80gP/9l3s9BSDHFbllgq1ofL7Wn3073gpJW/dtDA59dbROTDwjWTCgmJNmo4lTcnWYFG1QMz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMx610KCvRUVs6V0WcsOtYyEOMgcBEo48ER63WH9dL2gO59jon
	49bI5jLJ6xqlbs1G4EfvvMGloEpEDGrU/UMKiv3+Dtumhfwivuhz1W1uZH9r/RY2cjPVbMtpPGC
	Cmzib6Rs=
X-Gm-Gg: ASbGnct0m9igCrIwyOlklifkP/FxQYyTKllCBB/Wbd63gH11hAhtLj0Pijww4RUuQDA
	5CJ+Ha/KcB/rK2UzUAvO9BS+WY09OKzvLx4oF2xCCLx5oAwcZqu7tuAMatV91aOsT/Yxo/hd0y5
	UexeVwQurV4a1fNRYgTwhq8QFRKBsPDgST5SMV6HhRnQTpayQAw4UeiGZzZUdraXJvGcqSp8Wpb
	p3jkEa9KmSRdT533vLlKIE4OBThLYYOlcdO/NShVUhTXmQh5ucUFDeNMCyWh81ymHFd+KwvJ2Ik
	RaSIu646IRudzyRX5sEF48EkOqTMorSb4yIZQFvHcBuiAlXr54D/jCUucHEhP+EjURYEedgedTf
	L/zrTME15sDjBVWJef8Sl/iGn20jG
X-Google-Smtp-Source: AGHT+IEe7NLUj0bPED6NI3MqirO5nLtQzveSYBgdGMAdjUySl/64B866Ixps2AtuU5iD5OmXVOP33Q==
X-Received: by 2002:a05:6808:308c:b0:40b:66de:2dd8 with SMTP id 5614622812f47-4151f24c297mr3431673b6e.9.1752266681389;
        Fri, 11 Jul 2025 13:44:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141c1ac488sm660719b6e.36.2025.07.11.13.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:44:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Jul 2025 15:44:31 -0500
Subject: [PATCH] iio: ABI: fix correctness of I and Q modifiers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-iio-abi-fix-i-and-q-modifiers-v1-1-35963c9c8c01@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAK53cWgC/x3MTQqDMBRF4a3IG3vBSP3BrRQH0fe0d9CkTUAK4
 t4bHH5wOKdkS7QsU3VKsoOZMRS4upL15cNuoBZL27RdMzgHMsIvxMYfCB8UX7yjcqOljMXZo1f
 VUftByuOTrIT3/zlf1x9RZBpUbwAAAA==
X-Change-ID: 20250711-iio-abi-fix-i-and-q-modifiers-b1e46ddd8d67
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11830;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=jRPzFACSniA1kzYqYaW7+P2QzYJ7Rs5qV1aSy2hpEX8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocXexakPotFVKs4IQKVwiEHa2jb1oFbP2xv8gC
 WsnxYsZL+eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHF3sQAKCRDCzCAB/wGP
 wJazB/9KnzMa+9SIN46y5VxrWF6rUD5+CrWihU5KEi3JoxbTE3JcHs8N1ZaTn+fzOrt/G7Luyfg
 kf6grnMDhPZaDvwULlpY36deng2Z3qaegs+um81oJU1LUh9peRd/ZJ2sOfm48kX4r38jE8GFro4
 vPnsOM6IY1Ji/NP+4KtxBqZj3FaZVkYHVthvIS2hAIPXjMEVY3kKOU/Xmd3bby7zRKMSnM228xt
 F+XlsE6iJocNGrTLNosNW4Xgas10yNmL9scXytg9dih5k6AL8DuE+TIKhP/hud784Tme7nJpTfK
 ASibNm9hlKxQubVmVPoObtkHDkBrwI0fw7RRl4IRcUIVCfLT
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Update the IIO ABI documentation to reflect the actual usage of channels
with I and Q modifiers. These are currently only used in a few drivers:

frequency/admv1013 (kernel v5.17):
- in_altvoltageY-altvoltageZ_i_calibphase
- in_altvoltageY-altvoltageZ_q_calibphase
- in_altvoltageY_i_calibbias
- in_altvoltageY_q_calibbias
frequency/admv1014 (kernel v5.18):
- in_altvoltageY_i_phase
- in_altvoltageY_q_phase
- in_altvoltageY_i_offset
- in_altvoltageY_q_offset
- in_altvoltageY_i_calibscale_course
- in_altvoltageY_i_calibscale_fine
- in_altvoltageY_q_calibscale_course
- in_altvoltageY_q_calibscale_fine
frequency/adrf6780 (kernel v5.16):
- out_altvoltageY_i_phase
- out_altvoltageY_q_phase

There are no _raw or _scale attributes in use, so those are all removed.
There are no currentY attributes in use with these modifiers, so those
are also removed. All of the voltageY are changed to altvoltageY since
that is how they are actually used. None of these channels are used
with scan buffers, so all of those attributes are removed as well. And
the {in,out}_altvoltageY_{i,q}_phase attributes were missing so those
are added.

The differential channel names for admv1013 are fixed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Note: the admv1013 calibscale_{course,fine} attributes are already
documented in a device-specific file as they should be since we don't
want to make those standard attributes.
---
 Documentation/ABI/obsolete/sysfs-bus-iio           | 12 -------
 Documentation/ABI/testing/sysfs-bus-iio            | 38 ++++------------------
 .../ABI/testing/sysfs-bus-iio-frequency-admv1013   |  4 +--
 3 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/Documentation/ABI/obsolete/sysfs-bus-iio b/Documentation/ABI/obsolete/sysfs-bus-iio
index b64394b0b374f2479bab69218f6ad17c6ac651f2..a13523561958b7faf85ac42d965f78b99993ffda 100644
--- a/Documentation/ABI/obsolete/sysfs-bus-iio
+++ b/Documentation/ABI/obsolete/sysfs-bus-iio
@@ -48,10 +48,6 @@ What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_en
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_en
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_en
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_en
 What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
 What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
@@ -73,10 +69,6 @@ What:		/sys/.../iio:deviceX/scan_elements/in_incli_type
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_type
 What:		/sys/.../iio:deviceX/scan_elements/in_voltage_type
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_type
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_type
 What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
 What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
 What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
@@ -110,10 +102,6 @@ Description:
 
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_index
 What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_index
-What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_index
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_index
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_index
 What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_index
diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index fcc40d211ddf388ad70f489177ba2fcebdb9f8dc..7e31b8cd49b32ea5b58bd99afc2e8105314d7a39 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -141,8 +141,6 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_raw
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -417,18 +415,14 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_q_offset
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_i_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_offset
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_offset
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_offset
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_offset
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_offset
-What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_offset
-What:		/sys/bus/iio/devices/iio:deviceX/in_current_i_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
@@ -456,21 +450,15 @@ Description:
 		to the _raw output.
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_scale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_scale
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_scale
-What:		/sys/bus/iio/devices/iio:deviceX/in_current_i_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
@@ -603,11 +591,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_calibscale
@@ -829,7 +813,11 @@ Description:
 		all the other channels, since it involves changing the VCO
 		fundamental output frequency.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_i_phase
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_q_phase
 What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_phase
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_phase
 KernelVersion:	3.4.0
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -1458,10 +1446,6 @@ What:		/sys/.../iio:deviceX/bufferY/in_timestamp_en
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_en
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_en
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY-voltageZ_en
-What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_en
-What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_en
-What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_en
-What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_en
 What:		/sys/.../iio:deviceX/bufferY/in_incli_x_en
 What:		/sys/.../iio:deviceX/bufferY/in_incli_y_en
 What:		/sys/.../iio:deviceX/bufferY/in_pressureY_en
@@ -1482,10 +1466,6 @@ What:		/sys/.../iio:deviceX/bufferY/in_incli_type
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_type
 What:		/sys/.../iio:deviceX/bufferY/in_voltage_type
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_type
-What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_type
-What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_type
-What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_type
-What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_type
 What:		/sys/.../iio:deviceX/bufferY/in_timestamp_type
 What:		/sys/.../iio:deviceX/bufferY/in_pressureY_type
 What:		/sys/.../iio:deviceX/bufferY/in_pressure_type
@@ -1523,10 +1503,6 @@ Description:
 
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_index
 What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_index
-What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_index
-What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_index
-What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_index
-What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_index
 What:		/sys/.../iio:deviceX/bufferY/in_accel_x_index
 What:		/sys/.../iio:deviceX/bufferY/in_accel_y_index
 What:		/sys/.../iio:deviceX/bufferY/in_accel_z_index
@@ -1716,8 +1692,6 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
-What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
 KernelVersion:	3.17
 Contact:	linux-iio@vger.kernel.org
 Description:
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
index de1e323e5d4741177e58a8c4058fa00271ea3b29..9cf8cd0dd2dfd5b0b67b5dbf28bbdb6bb4a4ce7f 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
@@ -1,10 +1,10 @@
-What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_i_calibphase
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-altvoltage1_i_calibphase
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Read/write unscaled value for the Local Oscillatior path quadrature I phase shift.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_q_calibphase
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-altvoltage1_q_calibphase
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
 Description:

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250711-iio-abi-fix-i-and-q-modifiers-b1e46ddd8d67

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


