Return-Path: <linux-iio+bounces-18950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52BAAA674D
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 01:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7DF981BFC
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 23:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6249F2367AD;
	Thu,  1 May 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0/6SEDk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B65221295;
	Thu,  1 May 2025 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746141601; cv=none; b=nj4YK2TJZjX8dPG7S8LZX0RgwPvvtdT2LyAHERxnVFKmB3nZ9Oh1ADPE2ZYsHfPoi+qBDpORxzNQT4wTYEzG4LYc86awFxou8qAY9L75X98R7OxKp7yGsS4pzuqRAfRYm33aNnl9bGWMUtIZ4XyLPuXs3AWTStBFw4+ZkYCZB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746141601; c=relaxed/simple;
	bh=upXGYedG9dObgZEt7Awma7NEoyqq6iE9y7L58AQfvA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RehHT8xcjBjqj2Kl1pps0fbcjNApUcCBwlC4Aew+Mf54wwJRCfGXDrurAw4CIo4xrK7Rsp6g/pMazqkLu9q62Q4CZ1D8daa3cNiLmrUVGOqz7wCQtAmFVCxP7JeTb7o+8k2fXYPIBWtgjNUra2CFE/qQTTLTfWypfQLz9bf+TCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0/6SEDk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c56a3def84so146186385a.0;
        Thu, 01 May 2025 16:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746141598; x=1746746398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaNPQeUwNVCkcCz4v/kLToCggdZ9DJpb46F67TpGc4M=;
        b=k0/6SEDktLBzvMFRa4OmNEbDv0gixLUJUdcXNKQrhU/jzSYeC1fzo3a9pLspZW1sZR
         GACuWHaTD1+bYRxXoeHC4/HwCSUrQfgOLQBLnvPdgoCFh2kpKl+pVntFbcRgPxizsDIl
         VFNKFgnolez0MefgFRT/ucQQXjik+/n6fDXKKdE1X0NaKLdmuFj6TZzuoux2gdACopEJ
         QcOHpNgiUh300twnpkYXz9aJ2b+LOsJAhbdMcHeTIsCnuCzZMY6Kk3J5ujXV4+xHpUMe
         ULcrasLwHIfleHJe6QrdT3gjJVnJgG820ozbY63GxhyLV5T+bo96mWavax1e1lyKwvgW
         03jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746141598; x=1746746398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaNPQeUwNVCkcCz4v/kLToCggdZ9DJpb46F67TpGc4M=;
        b=KsZbxf/uphBtu47fF+SgSKIY0xJbx1tQsI1cZsqAVs3QG592cDwGVayWq1ZPDDuQeS
         foMbMHMRvfQ2vHnQ+6f8y8loRTSwbBJ6E8pDbm+0ygi1a19mlfruQLbi6/UiPrmTwwES
         htZ1KG/z6L8OOz5877+jRMC1znq0Pywh86Fzk4DO+05426mpVmA9qGmYRV3mv38gMH/G
         aV8ZWjTgLzd9ebNJksXEGoDxT8HIxD9KQs4FBkVU3gQzzyPZRQ+4zp/+zO0C4T51ZxQf
         sfhF9U9DOAO6e0cE7743KSw7uTkhdYYgFxypvFJv11KTJTnV+VxnmBB9NZWjLrLOcGz4
         jCBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv/FmfPJPwtaTRlZt4WX186m3xVA1XhTI9vBkTFzmFVcbXzgovizThLAn8mfggwGRkjcKmuwiOo4Jp8lKt@vger.kernel.org, AJvYcCX0v0iPI8kysbIGfuV5VKS45dxIp1D3FrIJa5uQQaTAC2vI7RyWES83wEPwpnrWx9m+g5Gt6+pyy0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8jv98tX6ugA3gwE38BBwVSi2IhxIc/aXZJTUrmqRhjWgqHPs
	cPHgI9kLgQxaJbmLCuizJtK67W8dt9OGpXKzlJ6HepS+B+Kjn6DOKlZzrS/w1eY=
X-Gm-Gg: ASbGnctc+x21bXqMktqKz/u61vHGjEkNSiw2hxeS8TpJVj+ClpYtZNy8Cb2fNwTZIjY
	MuHQfDaE5zGq/VihQ4WskQdUpCsAQenbiY908ob2g2OAPF/c48tNoJXf+Z/Zz0SFAetL88DKGlI
	Wm6jPNrtCHILRqTfYPLymXR60KPjoao/iuzpg+40tJ69goiOTN3jQm88kI7sYqWFhv0xEOerE0D
	z76lU85mzmisMzm0y+bSnwtl5dqqbVAMRNu8RkHEfG53f8i5QFT479tKJgyIgxpsqhs2XyGFU4i
	nTGBS6HkHMIE5wZbo7HzKO254cM0IIMS2qj8v0f2ukb8ThapctpHqxewzijv1Q5FVg/2knqE
X-Google-Smtp-Source: AGHT+IFVkWiSnTlfxvfyosBhEypJ2fEQVO4pxxUsq+Ip/wRWRQj+aTx2n+st+gPaPFlYqmjayLwaMQ==
X-Received: by 2002:a05:620a:4056:b0:7c5:f6be:bdae with SMTP id af79cd13be357-7cad5b4371amr115417785a.20.1746141598324;
        Thu, 01 May 2025 16:19:58 -0700 (PDT)
Received: from c65201v1.fyre.ibm.com ([129.41.87.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23d1ca4sm104600285a.59.2025.05.01.16.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:19:56 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	dlechner@baylibre.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] HID: sensor-hub: Fix typo and improve documentation for sensor_hub_remove_callback()
Date: Thu,  1 May 2025 16:19:31 -0700
Message-ID: <20250501231931.1865276-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
References: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Improved the kernel-doc comment for sensor_hub_remove_callback().
 - Changed "Gyro" to "gyro".
 - Changed "usage ID" to "usage_id" for consistency with kernel-doc
   style.
 - Updated the comment to state that only one callback can be removed
   per (usage_id, hsdev) pair.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 include/linux/hid-sensor-hub.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index c27329e2a5ad..0f9f7df865db 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -128,12 +128,13 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
 			struct hid_sensor_hub_callbacks *usage_callback);
 
 /**
-* sensor_hub_remove_callback() - Remove client callbacks
+* sensor_hub_remove_callback() - Remove client callback
 * @hsdev:	Hub device instance.
-* @usage_id:	Usage id of the client (E.g. 0x200076 for Gyro).
+* @usage_id:	Usage id of the client (e.g. 0x200076 for gyro).
 *
-* If there is a callback registred, this call will remove that
-* callbacks, so that it will stop data and event notifications.
+* Removes a previously registered callback for the given usage_id
+* and hsdev. Once removed, the client will no longer receive data or
+* event notifications.
 */
 int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 			u32 usage_id);
-- 
2.43.5


