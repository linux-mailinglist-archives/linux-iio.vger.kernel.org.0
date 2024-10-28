Return-Path: <linux-iio+bounces-11448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2096B9B2C6E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 11:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F0B1C21778
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711A1D2B28;
	Mon, 28 Oct 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y59vsHYe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84191D0F44
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110348; cv=none; b=ZmKOAoOXj9A7lel48uZQnZito5Pepm6zyxhD7aWgjgvKKGTvDV1euiDrBCFx0R8D+1JdxPbktBvZw1YnF3bBobUSnCjbVBSOixdwxHRooveDghkR2T8CsIRBc+B8Qg5V4b0hhpmApM0nc4TRA40dqxSFev1Bh0Upm1asbQt9nAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110348; c=relaxed/simple;
	bh=E5IKpWlBrs6BrNxKGj8gL69lGAFGxkNE1Vi/39M/35Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUKndPGCYV6RNUG4aeIKfMlC7Jw39YbbOdTFheCcI5pTz3UAJu/glYqT36yyDkwEKvApiZDr3OMrRiVLHDYxk/Teyjf4+vVMjmh+fdhAXNRiT5AliRKASx3unJSlsSwaYIc+WtyRjNQo2cN9p4bqKUPbTlW9hTEPgUwYrWPtfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y59vsHYe; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b154f71885so399029585a.0
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 03:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110345; x=1730715145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRIQcTwMhYqGctEPu/xoF4uEWBP35j2ZdxAtYHSbb2E=;
        b=Y59vsHYecOLkSWgZLMMjGcvS6rtWiYWPwkWp/UtBM2/+2/K1eeS7nRhcpxJ5FBqxLU
         fJNqw4hGZuJRDiCoNfOour4uOP6iYVMluRQy2rnZUXXE8DQOnC0M7LfmgFP1GR+g0DNO
         pgq9Rktkud2RsBaYUNC33C1O1tnkVbWZZbZP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110345; x=1730715145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRIQcTwMhYqGctEPu/xoF4uEWBP35j2ZdxAtYHSbb2E=;
        b=QZMVzSk/NVRRbX4/zOQEzNW4zKxGOBEr3WfkVo85TJ19ceZsi76VjyKXf1aGadB1DX
         6jlUVrbqi7/RSmimv02sj20xemTO4bcdHiyVQAwfbipTZcpeORZzspti93iS4C6E5iif
         rbxXtpb73rJzrinuBQGdlHXg8l4CfjYfT8C1VH+f2GL94FiRGxElc6i/c5Zpo/KbS6E8
         vZytkR5v8AxO485+wZczeYeI2UmYjds9jSZ2RCb06Y3h3PVeHSsYP7hrQ2MFf29q8SSV
         8pEJzxuG/4Yavgw/CtiFXhj5i28etDOkVHQOWnaQkZiyyKYI4+W6eB+Mg+KBKeFMqZh/
         NMgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg7gDMm3VTVWR0zlLzzmWYVdaJFZxVFCuOehlmZwcLvfEiLXsR+SF+Ox1c64fh6gHcOnO8cVPRGI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6YwzMdm/du6xC9NX9zsM2lpjgbizUS6HAjOBVYnzg6mj19mM
	HMCK756a+qpTRVdGyWrIAugZimvquq+FuPVc33GFEGmESRmwbPs0w/DDjBBkdZfU7UrkZu45AL4
	=
X-Google-Smtp-Source: AGHT+IHsZfrL95wV+H91XB+R0gfoIc0eDU5H8YGXxr3YjqWTDf3Oef34MoOXLotCH0ugOLZSOTidVw==
X-Received: by 2002:a05:620a:2482:b0:7a9:d14f:2374 with SMTP id af79cd13be357-7b193f3e043mr1206071685a.44.1730110345653;
        Mon, 28 Oct 2024 03:12:25 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d279126sm305483385a.9.2024.10.28.03.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:12:24 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Oct 2024 10:12:21 +0000
Subject: [PATCH v2 1/5] iio: hid-sensors: Add proximity and attention IDs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241028-hpd-v2-1-18f6e79154d7@chromium.org>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
In-Reply-To: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The HID Usage Table at https://usb.org/sites/default/files/hut1_5.pdf
reserves:

- 0x4b2 for Human Proximity Range
Distance between a human and the computer. Default unit of
measure is meters;
https://www.usb.org/sites/default/files/hutrr39b_0.pdf

- 0x4bd for Human Attention Detected
Human-Presence sensors detect the presence of humans in the sensor’s
field-of-view using diverse and evolving technologies. Some presence
sensors are implemented with low resolution video cameras, which can
additionally track a subject’s attention (i.e. if the
user is ‘looking’ at the system with the integrated sensor).
A Human-Presence sensor, providing a Host with the user’s attention
state, allows the Host to optimize its behavior. For example, to
brighten/dim the system display, based on the user’s attention to the
system (potentially prolonging battery life). Default unit is
true/false;
https://www.usb.org/sites/default/files/hutrr107-humanpresenceattention_1.pdf

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/hid-sensor-ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 6730ee900ee1..8a03d9696b1c 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -30,6 +30,8 @@
 #define HID_USAGE_SENSOR_PROX                                   0x200011
 #define HID_USAGE_SENSOR_DATA_PRESENCE                          0x2004b0
 #define HID_USAGE_SENSOR_HUMAN_PRESENCE                         0x2004b1
+#define HID_USAGE_SENSOR_HUMAN_PROXIMITY                        0x2004b2
+#define HID_USAGE_SENSOR_HUMAN_ATTENTION                        0x2004bd
 
 /* Pressure (200031) */
 #define HID_USAGE_SENSOR_PRESSURE                               0x200031

-- 
2.47.0.163.g1226f6d8fa-goog


