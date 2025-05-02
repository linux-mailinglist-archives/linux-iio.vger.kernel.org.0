Return-Path: <linux-iio+bounces-18954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466DBAA67D9
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 02:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A185D7A3640
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 00:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2946101F2;
	Fri,  2 May 2025 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfq1mdc7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB14690;
	Fri,  2 May 2025 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746146309; cv=none; b=cxASQFkVj+S4bf1kFv4OiM0TNc4LSrd+M/mdy8px3XnHQa6f9QbrZGBxqgZdVIgCZqukkv+S05ZWaq+ms6sThhfNZluKsJ7kQFmqCRF7mGl10VEjT60Q+XRS0mM5a+Brw2vEE0Qtrp7R3cugj9BLZUy/y+Lj4FP7AcWaQj5tPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746146309; c=relaxed/simple;
	bh=9BRCat8r+vuC3zFcnT5qPCWYyDB+d1ea1M/4s1NtMS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFFQ6pQdb7VPZeRLR30TBY0ffwXSePEP0X/iu4O74IIyX1QrWDIoeDfGiccJIkBnATXDHdMtHqMefL/K+mvX8Z+0VeNiKOiA5eXjRwHpAVLK9wj2HlbaVtCNghqU4b4eiPOmj5h1HjyN/i3y/PaipACmG0KNcsQ3b6GpEF+7Bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfq1mdc7; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-477296dce8dso18805421cf.3;
        Thu, 01 May 2025 17:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746146307; x=1746751107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/4Dcf1oSbrIBqG8XkSulM6ZAB/ekKgKWI2E9CbLk9Y=;
        b=hfq1mdc71YW+LQSJRNDefkxzfcz9zUEYFRcxFwqia470+d/70WMzJ+wdBZhOsJQ+qr
         kZgFVNi+x+5MRbV/X4s0aCdzokUgfelhi9rufRqD4y+Xsr/A3aL/WuIUHftFlWeFybTN
         EebvO7pLKjAZ43QN4Q0RLp61a9tNhK/VtWXM49AVOkATediE1ZJ248JP5riPVRn/jmcu
         3GKtKRiVqhJsHB24PcJeEMKwx4xdzOBon98zsPaxFpqEthZo720KFOUuAPNTFuj1IC+T
         37armaVwPlOPaKI/vC5ABe0QU1lDp5IW3kbEy5IxUVuvwkyZOAueAcgtOBItj81jIcuE
         B88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746146307; x=1746751107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/4Dcf1oSbrIBqG8XkSulM6ZAB/ekKgKWI2E9CbLk9Y=;
        b=rIDVB6mHU1T+x1aUqmPbR6Fvt2msCrO32/bFC8w29tTI83kV0agCdBtEJQTijOd1/A
         mnlmNfKuo4CfkleEs12iSaqT1DKhoSkhecQvZbI0e0WkOlUrOGI75zxeFLV1goSkjklo
         g2jZzXLaH3Q0tStMT/wkF5oGAD5XZDcKCCvGnMda0I5Azf1NSF9HSRXijPep29wre3bm
         W/MRn1tYc5PLRNHwSEJrp3G7sTAWtprWkkE326a7QOx1xGV+XzIDPR06TYsveUxsNCA6
         r3VfT+bzFoLOBzsY9aIDMaBZWM1tTCvoAcCHbf9inhGe9kqlv0H7E4CswS9xOfZBFIRg
         ki6w==
X-Forwarded-Encrypted: i=1; AJvYcCU+wNdBhsE/n5ExjKAMHvIQpzDHQzV+K77O9u2SAJHzeeNnu43QSboDw+nE446TzYdsqdCu4KPCvlM=@vger.kernel.org, AJvYcCWUm95d57dpUaKnHdPe1kk7EPgsiOsa0A27XJ4ZX4JomWSvR5MYVWHPhDZXFmVT3Lcja01QNFm2PkO9zMNu@vger.kernel.org
X-Gm-Message-State: AOJu0YzILtPM4pcb4HJWxPrX6GsNJa+DVtS84oxPNAVN6NRHKS9NBJ5s
	7S+1g6pG3+EqV8BVVggTzEFchyZKxI7gtlqjwTgmoLlvVuF1SUDI2m1TY0N5tHU=
X-Gm-Gg: ASbGncvdov0xCoSElkMttnlXQosaAC0XhsuwYjeAVosFbRKWRN9Vv2F8oEDo17GdGjW
	LJlXWZ+dCxnkesnIDbZxs6cam2nd8fxPaGZSHE5Mhigv37MYlKyxO7qsC/omi1YyEsKBpZ+lYq0
	HGbahsq8rLr1c2O3rF9zEpv0AK+CeiOH9T7f4zot/8nuh/AFJg2hG8a+2bDmv0tUUYmQJYMpEEf
	bpmwGH4os98AS+/l1jJ47vGlZCLa/qXzYMT8Z5scHzY+fEnkUvZwf+qVDuK6B1aARFzndJoR2gd
	TIcfpWgmJVFFQODvrSHOMtXdSUAulv8tDQ65fyxAWQ9CI1L9V+pRYmMVAr2GaQ==
X-Google-Smtp-Source: AGHT+IHHjvwbX9asQMv+qeXiYd/hGSJHbjjzkhnYuDriAUr1aWGuRFDsfXZ9fSq67ooRhTpwcP2fJA==
X-Received: by 2002:ad4:5bc9:0:b0:6e8:f949:38c6 with SMTP id 6a1803df08f44-6f5157f0e06mr18291536d6.33.1746146306891;
        Thu, 01 May 2025 17:38:26 -0700 (PDT)
Received: from c65201v1.fyre.ibm.com ([129.41.87.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3d2e56sm11572286d6.62.2025.05.01.17.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 17:38:26 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	dlechner@baylibre.com
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v2] HID: sensor-hub: Fix typo and improve documentation for sensor_hub_remove_callback()
Date: Thu,  1 May 2025 17:36:55 -0700
Message-ID: <20250502003655.1943000-1-chelsyratnawat2001@gmail.com>
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

Fixed a typo in "registered" and improved grammar for better readability
and consistency with kernel-doc standards. No functional changes.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
 - Improved the kernel-doc comment for sensor_hub_remove_callback().
 - Changed "Gyro" to "gyro".
 - Changed "usage ID" to "usage_id" for consistency with kernel-doc
   style.
 - Updated the comment to state that only one callback can be removed
   per (usage_id, hsdev) pair.

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


