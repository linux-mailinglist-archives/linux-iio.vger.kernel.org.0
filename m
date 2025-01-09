Return-Path: <linux-iio+bounces-14050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D64A06C9D
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 05:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22ECB165F47
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 04:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6B1836D9;
	Thu,  9 Jan 2025 04:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaI34gTW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588E1459EA;
	Thu,  9 Jan 2025 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736395217; cv=none; b=m9qoMWHRGMfkub26v08UyvPMFdz3YbkPdGvoQqwUUsHNFXx3sVHBzsq1L7qRANTKNhcVJgwux3a+/fgg46jpznAQkAMejW50pQNktSCJ8KXRZCSKrFY1msKMiXsae2Q7+Hx17b7bCXKP1i5hZdMb2SRpr7KyVPZUYg16g91Ig2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736395217; c=relaxed/simple;
	bh=qqQ+FrBMoZPeUByYCFGpY0veCO3ZMhIOBnj/AB0R94Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dpr1nnhtAi9uuxhJx8R6B/9sSonWf1vDlBOlljhTLOxAdXPO6NDOjnOeiqE/jKMzJ23NQQ+eSFwr3jHQssCsce/htYqBhnf9IRPq/mwa3fRM06Ip9nZ+8ESrRVF8u0DbKQD0xDxJdVZR4v+kiM6M8BfiVTEvz5+uy3nbdxU/mAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaI34gTW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b7041273ddso35766985a.3;
        Wed, 08 Jan 2025 20:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736395213; x=1737000013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1d4Hqkp4O1rQk5DhN4/3wnLF6dvmRTfllO0SFLIbkHo=;
        b=PaI34gTWln0VJfIXuyLt3S3HP3Av2GfpkXBsX3onFHzJU4lx4HLJIBTckdB3hxZwNy
         f1/r90x6V+fDYt1VuXd4vkrRfrzLFM11S0a7gzNPsF909bZ9iXHnvf4iVLANS01UTCsO
         Syr3+3fgwSXhbZOeWwZBYYwBGbSBAsZwhHLB1fszXZLtzEW0RuE1+FFb0r27C1WiN7Cd
         Cq0ga6X++oWbrEqB8RAcT/3aj+SOpq0+R+OXvIMVZcZ8uIpDuqy3rNJv8WSIjUa3GLd0
         t5Zvo/GQ+vOKSRCiwYNFtAVpHnUdX4tAxYPtWS6TiWlTmCM0meGYfZPaL3nTYGaPQ62M
         5jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736395213; x=1737000013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1d4Hqkp4O1rQk5DhN4/3wnLF6dvmRTfllO0SFLIbkHo=;
        b=T1LBISiJwZGdS31pyxg4WJs2XLw2NOnUxVwIeUjcvVWG3WLw9ArTo+tpEI//TL7hS1
         HONRQSMG2ZDlYXGPBooyncn7uhGxyQyv2gt+pA/F63vP4MbUtTXjcOusjXgZo0823oCT
         rEfY7esVYRVFW5wnZT7uQVo+8onXdmSFXNCTAyLc0NzF/5xlbZy3elCSahDcK+hK0xJW
         TrHkkDyioeEPPxHxtU3e1v1joihdtA46OhsRfpijPOqJa19BnurSqiF8VGCCFPXpoD4r
         5pqGV2eEGUDYeWKp2hGL9WqocGhlx0gNu9q0z6oUo9G9IRTQ0BoY+uFlG2sa2j0ebfBz
         WLyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR6CD8UQHGQGz/3GOKLKSoUGhoN5gLagi2GNebb7ixYW3MMLdfia9pUSqaJ/1xgtG4nlBCB4teXgg=@vger.kernel.org, AJvYcCXiBb7buvFZCTv0a7h4Ypm9203n8B51YX/SWBfcLwGA3UwangOYgMqCRkowU7ZgnKY5ZR0KBIqwiVQS1/KA@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdcadjqPt7F9GZjkECeK58nWn+sRoygRm/pkzyVbVum+6Arpk
	7aiaUEPIJLFsEaQkQNTD8G9q087SIfqtUaRh8ncXdjMciStw2TyW
X-Gm-Gg: ASbGncvMBAJgn/ZQdNSSnerXmX9ZpeMkZDL5ofJn5xRB9jVF4ipzs9C+Ytxt2LzZopk
	MT4KQ74V7U4aBckyJwoUsuc50SIINLi4TnpsiEja53msFGyGL48tiPLWdasfgZAbkBtqGYZ6dw3
	+3LLGte0YX6JaxNpheoHvk4VrtoosJcAu+aW+R8Iw5k5ZihrrMN5d2YLqp1XVVWhRb5o4fkED2W
	jCXx8ye5ymu7vRUm6alpnA3hW7W+M1+SJT7qfg=
X-Google-Smtp-Source: AGHT+IGVKt1uAPt1VT+MRFBBCBt02WfpVHrsigAF4ACw5slvp4FjmJpgphtIOwENXQdf7eFz/SlW+A==
X-Received: by 2002:a05:620a:1910:b0:7b6:6e7c:8eee with SMTP id af79cd13be357-7bcd97aebf3mr722433485a.45.1736395213131;
        Wed, 08 Jan 2025 20:00:13 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248c94sm28131485a.43.2025.01.08.20.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 20:00:12 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: hid-sensor-attributes: validate sensitivity attributes
Date: Thu,  9 Jan 2025 12:00:06 +0800
Message-ID: <20250109040006.1273797-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An invalid sensor device was observed which provided valid index and
report_ids for poll, report_state and power_state attributes, but had
invalid report_latency, sensitivity, and timestamp attributes. This would
cause the system to hang when using iio_info to access attributes, as
runtime PM tried to wake up an unresponsive sensor.

[    2.594565] [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
[    2.594573] [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:1, 2:1, 3:1 ffffffff:ffffffff ffffffff:ffffffff
[    2.595485] [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
[    2.595492] [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:11, 3:11, 1:11 ffffffff:ffffffff ffffffff:ffffffff

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 .../hid-sensors/hid-sensor-attributes.c       | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index ad1882f608c0..b7ffd97e6c56 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -564,8 +564,21 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 	} else
 		st->timestamp_ns_scale = 1000000000;
 
+	ret = 0;
+	if (st->sensitivity.index < 0 || st->sensitivity_rel.index < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	hid_sensor_get_report_latency_info(hsdev, usage_id, st);
 
+	ret = sensor_hub_get_feature(hsdev,
+				st->power_state.report_id,
+				st->power_state.index, sizeof(value), &value);
+	if (value < 0)
+		ret = -EINVAL;
+
+out:
 	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
 		st->poll.index, st->poll.report_id,
 		st->report_state.index, st->report_state.report_id,
@@ -573,15 +586,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 		st->sensitivity.index, st->sensitivity.report_id,
 		timestamp.index, timestamp.report_id);
 
-	ret = sensor_hub_get_feature(hsdev,
-				st->power_state.report_id,
-				st->power_state.index, sizeof(value), &value);
-	if (ret < 0)
-		return ret;
-	if (value < 0)
-		return -EINVAL;
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
 
-- 
2.43.0


