Return-Path: <linux-iio+bounces-23693-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F4B4295A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 21:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1049169E0C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936572D29B7;
	Wed,  3 Sep 2025 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="haDmpr0F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916F929BD96
	for <linux-iio@vger.kernel.org>; Wed,  3 Sep 2025 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926069; cv=none; b=AnOtAWJZWuEdlySO24chMsUI4jxMp2atLhhMZ3Prxwb3Q1tIfZiCU/J4s/k2CL8wulsjPR77egdhzskkhiV3xTE1GMn/Oe9fHoKbq7KERIjtF2JSiXSu9WLCPh1NNAYnrTSOsyMub/8reZT3i5WE6VAcu+z8NwibPmnfj22Wsf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926069; c=relaxed/simple;
	bh=xODGLZ9Q+1m5yw6J5GEe7EMwMLa+qa7Zhi6EYDdMSec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G7VFyrB+WpC+pzmkw9vbP0CmNp7tKRc5WgFswXQt3fIwPsksd0X0Bh36RRvuxa2qhdOASitNkiWyOFlxcMeg4s4NV08P0yszX5hthnWswx9YuuwoCKf2t3/uxzp4smGD1FU26ouXxsmB6HOostvg4Wwpd1Mk3vwYLFMH2Nb+ipA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=haDmpr0F; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so104853a12.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Sep 2025 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756926067; x=1757530867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9zm25MUhrKlRPESzXD6p8pratl9QRA/8mwXbQn2w/AU=;
        b=haDmpr0Fs76AHvjckeqB5d/iUuGiu9lZd6PgvZAjKCmENX6Qu52LxwigLOFzlD306L
         sfLDcX8qaaTeGu1KfSzCu351D/tZ1cxatspT3vH480HseOU6vjOe/n43+TVRceh3VkIP
         5Wr3VSuT0aKaROyTPciOQ5nm4BjSG21mbiQW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926067; x=1757530867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9zm25MUhrKlRPESzXD6p8pratl9QRA/8mwXbQn2w/AU=;
        b=M14HKIO5uhlyURAZvTGmzn058jfJAhA5P95bk9XCqmTTs6YhSJ1HxXYJK22AWhe7A/
         710yG3jAIMhRCxswOQcDOzrfpbRdFyutV/i+8Ekc3So/r9aXmTANTfkJqqWcjSIHYqjj
         clVf0R3IZkusw8zDHwaNPvEfXI8ivXnIgqWIGAXKkBX5vSQDCG2eoUJyGycvyAig3feD
         O0vFuj78wbwRjH0LgdySKio+VJI4XCdTTu5OboPIUIu/uIguYdwD5O+oPfLdNJhepmhO
         W3KQLYVo32r/GPJLB/NL2B2mEnBk8cR0LxJhk3UFMfwHj4dJqcxC1lCS6wWgyOXOExK4
         2C7A==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7tTochXFgRc7mYK3AH+FdhGHCk6E3pj058keW8ZY/lkUedKJkaB5WmBYbsOLOIwEhrlbcaRgpiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywse2M1MBlgEkAI8N/g66BwECvaof0ZXt/KYZvOIwWyaubOYRoc
	S06MZ0QGUuLsrzhOu2ob3+dHJWcbQNwXwWFqN0Zg2WNmHlcosOmNe+OsADzvRVRVHQ==
X-Gm-Gg: ASbGncuK/qSieXLS4r17B9xC/i0cQzwLXABp3RgUeVhYmN+LtcjaEZJvxGULByTA7yJ
	xvw8LGd6d5q842fU98kjgalcHZ/gw4b+1wK3HdtmT6mcWT13T9YPQpfqIcSnKCIltuo+/Gbj4y6
	f6RYENcPhZxgzaeyRSdKAN+8B4ieih77HEdzs5QtCT2YffgXxP69dmk4IPu78Y8GybFTkGzPpP4
	RsMjL3puRTwI2qNXalYqEQmPdOdBE1DoxaFIC2P1+1brCdHmPWHPyGoMmn+uS9ORkem4HsJppF/
	3KJnYChNONUtCgJc88H7MrzuxtUiJ/rHPxdIs6wMapf+vhU9FScGMO3u5rNTFzbsonGM/oZZ/8k
	ShVUXl2reSIedZct4C8ZGWlTn+Q==
X-Google-Smtp-Source: AGHT+IF6RJ3VWh8pBV8nB/HBuNwbzt9XTbo+IwHS2AZQXF4GDbKt8c1HFhojNQPLHiVMQ1tXgO3K7Q==
X-Received: by 2002:a17:903:37cb:b0:242:9bc6:6bc0 with SMTP id d9443c01a7336-24944b73618mr220103835ad.55.1756926066474;
        Wed, 03 Sep 2025 12:01:06 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:bd57:efc6:8cb7:9d2d])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24c9304b7eesm24969275ad.102.2025.09.03.12.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 12:01:05 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: jic23@kernel.org
Cc: tzungbi@kernel.org,
	linux-iio@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] Documentation: iio: Remove location attribute
Date: Wed,  3 Sep 2025 12:01:02 -0700
Message-ID: <20250903190102.1647098-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros-ec specific |location| attribute has been superseded by the
generic |label| attribute.

Fixes: 7cbb6681d7e5 ("iio: common: cros_ec_sensors: Add label attribute")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Documentation/ABI/testing/sysfs-bus-iio-cros-ec | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
index adf24c40126f0..9e39262437979 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
+++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
@@ -7,16 +7,6 @@ Description:
                 corresponding calibration offsets can be read from `*_calibbias`
                 entries.
 
-What:		/sys/bus/iio/devices/iio:deviceX/location
-Date:		July 2015
-KernelVersion:	4.7
-Contact:	linux-iio@vger.kernel.org
-Description:
-		This attribute returns a string with the physical location where
-                the motion sensor is placed. For example, in a laptop a motion
-                sensor can be located on the base or on the lid. Current valid
-		values are 'base' and 'lid'.
-
 What:		/sys/bus/iio/devices/iio:deviceX/id
 Date:		September 2017
 KernelVersion:	4.14
-- 
2.51.0.338.gd7d06c2dae-goog


