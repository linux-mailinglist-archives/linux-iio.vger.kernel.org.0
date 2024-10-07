Return-Path: <linux-iio+bounces-10284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A20993102
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0558D28673F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A41D86E1;
	Mon,  7 Oct 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeI0dS1x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476FF1D2F78;
	Mon,  7 Oct 2024 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314556; cv=none; b=flPuA2GmgJH7K/NzOXowXiU0vTCi1onS0R71yRbokq+nZdfEoRCC6hLpYXt5w0i9MklwRlLMzWpR8Wj/OV5pe2W/Fn9HO8PyeQ8GdvwDY9tXbSRfd1pv7gagLFhDNOoYgc4rCngSvCGHdt1qpcnLleJE6VCeIKF/OiwYV9Daf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314556; c=relaxed/simple;
	bh=0NxSJbsmRsWxjnPcnT/1PlNpBvfah3itMDhGgBV3c1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLhye/qIr+eLwvDgpd001efZx6fekHfsNvA+LOAMff8kIq9dVK44vuzK+XgXOis4t/ThUDHUsQlwoB/Jusy7qCL8zRbl/Zuh1N87h+qxDUS/9xt1wycbCQEssqMlh9FRJH/uMMOKXINJJBMeOkfZi9/yUnjTnK2BHi58+mJkKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeI0dS1x; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e09ff2d890so3857756a91.0;
        Mon, 07 Oct 2024 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314554; x=1728919354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3h/k/Awpu9zvCNdHAmWfi4z2Y/W9GzW6qzFaMWPNcdQ=;
        b=HeI0dS1xwv24CStRZfhusPpoM+d/iL1+Tc8N+O0rQQKdTaaWc/pEek8II2OGTgR6jC
         fXdtjGkxB4Quq3WfcnHeX1mvkQt4TvSK5Gg3ZU1amh9rhnxcwpgouy2krn9lsAHbAYUr
         O76wmiO0LR4zrbAg76aTGKpvCQpLP60FATtXdOBT/KMQtEnAb+bstoBdivglH8HnUFH+
         +0Y1so6h7WV2x5f4bjxbymVG7BIsTI60awCCgntd1izpnFDggPC8hxT4QKO62DhKBFbf
         Oawj5Mfh0Qwc4BrxSL7Bt43YdrB9H7odxZTTliUFBdtcGRuReUP1MP7cB5rm8jcJYV6c
         mpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314554; x=1728919354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3h/k/Awpu9zvCNdHAmWfi4z2Y/W9GzW6qzFaMWPNcdQ=;
        b=nzE0RkhqCy+x/4jQzeIraifgm0kDvX3zjyLJ0JnVK7U1Kb3uLhlNO/AWV85SWcX3j3
         yM3Z97XzQnj5z2j6TrYSiekB8MEwUrwcaNdBjFJFgeUqZSMSZS6TUYLFAO4QvpHv5+4K
         Beb9DWWcNXQaRcHAM6I9VVud//AVWlKFmfHplD2htx8tSllB9/qLAJpYzyVUqhzzPq37
         xIYWDGJXPA+S0WifPWgJFCFGNFig/Sg/YudHoGbMBSAosnATpRozLBoxYyai+7BiNtVR
         Uk4yC/lA+oLHTNqGnKwUOHhL2WwiNSXQ8LAwPjcfI26cpUfEe/mun1mSBR2PMQfatAjP
         tVow==
X-Forwarded-Encrypted: i=1; AJvYcCUk3YqSIR1g7+LCUV3XExlD/GlOj+lzAE4oIg7CqBRhCH90utMvPuM69xHTr4+rINlmY4X+db77vP/2UdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqxmm/82zNl7lsC/A2RG+M4UMI9RYXht1/tWp46+EWidG3Pl5
	9RO7CFbZPxRIpvq7GsTExiYV1b0BgqiD6rC1Fft5eh6WQqDD/fu2k67ae0nMFlM=
X-Google-Smtp-Source: AGHT+IHF+iZJJUcC1DpVlZNcVG+2gWowoUaOATLBae/kivRLSSLVSjP17WlDtxxL90IeSizdlPjCiQ==
X-Received: by 2002:a17:90b:3891:b0:2d8:9506:5dfd with SMTP id 98e67ed59e1d1-2e1e636770fmr14453418a91.35.1728314553901;
        Mon, 07 Oct 2024 08:22:33 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20ae7169esm5573934a91.10.2024.10.07.08.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:22:33 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 0/3] Interrupt and Continuous mode support for VL6180
Date: Mon,  7 Oct 2024 20:52:20 +0530
Message-ID: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sending v3 again because I accidently sent it without a subject.
Apologies from my side.

Hello,

The first patch adds support for configuring the Sampling frequency
(inter-measurement period) of the sensor. The values should be provided
in milihertz. The default value for the inter-measurement period for
ALS is 10ms or 100000 mHz and for Range is 50ms or 20000 mHz.

The second patch adds support for interrupt based single shot reading.
We registered an irq_handler that fires everytime the data is ready.
And then we read the appropriate value in the `vl6180_measure` routine.

The third patch adds support for continuous mode in the sensor by using
buffers. We enable the sensor's continuous mode in the buffer_postenable
function depending on the `active_scan_mask`.
The continuous mode can be disabled by disabling the buffer.
Added a trigger to the device for the continuous mode. Also validating that
the device uses the internal trigger provided by us.

Changes in v2:
- Fixed `label followed by a declaration is a C23 extension [-Wc23-extensions]`
  by moving the guard(mutex)(&data->lock) above the switch statement.

- The above error was pointed out during testing by kernel-test-robot

Changes in v3:
- Fixed race condition related to `reinit_completion`
- Used `iio_for_each_active_channel` instead of manually accessing `masklength`
- Accepting sampling frequency values in milihertz instead of miliseconds.
- Minor code refactoring.

Thanks,
Abhash Jha

Abhash Jha (3):
  iio: light: vl6180: Add configurable inter-measurement period support
  iio: light: vl6180: Added Interrupt support for single shot access
  iio: light: vl6180: Add support for Continuous Mode

 drivers/iio/light/vl6180.c | 255 ++++++++++++++++++++++++++++++++++---
 1 file changed, 238 insertions(+), 17 deletions(-)

-- 
2.43.0


