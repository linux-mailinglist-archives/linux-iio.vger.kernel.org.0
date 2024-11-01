Return-Path: <linux-iio+bounces-11743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB49B8C33
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 08:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD3D1C21F84
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CED6155330;
	Fri,  1 Nov 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EouYWk0K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D5154BEC
	for <linux-iio@vger.kernel.org>; Fri,  1 Nov 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447193; cv=none; b=TXpfJzYWNTFpNT77F8XfY4i9c/Y1RPMxSj7RWqb5Q3LWFmAnc+MABQF/24Dg9D0zhqB2XpUR4IRzDCo/0/QOhP9MgJk+NoIAoTVqgmH9A9CkvOem3VfWwv2qbdnBBAR1sTv1WmESjU4OAtJfYUrAkD8tny7MyYGZ9qbu0Rwo4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447193; c=relaxed/simple;
	bh=7oyqoYAZJ0gGfbJjT6X/Fu83uh1qveXspIJipeFQvcM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WEswcC12/aQ5gYi6InMFxmGnq3v5Pcf0HdOAaxY4R+7Zpq0PwgTh4D0Bt/yZmPY8awnGQd1J1Sw0BW3aTUo6Nd39FOxDaSj9C41vJSGwJRziJnoKDFngg1iSTtQ7/LlW0QrondFzB5AylgiUjvnYRl42ICl6Is2aiLUg2i8YfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EouYWk0K; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e390d9ad1dso14731367b3.3
        for <linux-iio@vger.kernel.org>; Fri, 01 Nov 2024 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730447191; x=1731051991; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3aKq6CnvOZI2TVkmKTbWKWHY8LJPTSe8Jutza5MdE4=;
        b=EouYWk0Kt6MmXM4jynRnZPWLkEahQCW99d5/iu+Nbzw7I4Gm1fj7NrQ6ksELFtSe7L
         woEtAQYgO1qK0lRlfkvYApjnm2jMfvm1xp2H+UNtf85TSloUFLjfvcaDSJv3KbEbh3mz
         6sjlgzKTHIEymmBLc2xthYD4YBc36W9MVMEbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447191; x=1731051991;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3aKq6CnvOZI2TVkmKTbWKWHY8LJPTSe8Jutza5MdE4=;
        b=gNSePzf4st4UI8bv/rcmpqfEUdAG84pJ99jzAz+qXWrxkNiNo1OI8KuWpeoqM4l3WB
         Yfj3t/tQyCQc3Y/r/lw+kpPrZQV7U0p7vmaVHkfDrDnKDixuiWdGY2Fj1Yggxt5edWCY
         KIDwXdEdiHRbP+kQbBXqzbONXlxadF8HvonWEoERSbuzgyJ4GpbFfBL6F8SefTWSjTMj
         dR8lZASk1Tjqbhy4b9SpQkPVrKSblWofozRx6siUiBnKPIO4D5ZXIi+UHtIv3DnS0CpG
         ae6PX6qctVVJ/4qFACpd/mnSg2y8zjCFNBJwJWmMSbVacLL0bCQO/DeAWrFdMow5IMAs
         IxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2NDMXMY54WycUipe7ryxJ8filTaM2Y7oj3DtUNr7xTa/R6+lyz+nQTITnrNUUWklpEFv8Aya4kXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Uh52sxy3SoqkvavzGWLP84fcl+tF8T9TvKaTKG+CWCYKPXRw
	68+TdZm3g4JUadhCzqDFcWCLHmg0xLOoeFbjQMcB/VLKK6Xzc/B7XY1Kt0ruLQ==
X-Google-Smtp-Source: AGHT+IH20R7XRxWI1RSTumQ0lC2tj6dVSIE7SoL2mi9HjVgdEmX6PF6aQq/YAwxBUE/8KKjA26yrtQ==
X-Received: by 2002:a05:690c:6506:b0:6dd:b9d4:71a1 with SMTP id 00721157ae682-6ea52378522mr72312107b3.16.1730447190788;
        Fri, 01 Nov 2024 00:46:30 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b1casm16444236d6.78.2024.11.01.00.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:46:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/5] iio: hid-sensors-prox: Add support for more
 channels
Date: Fri, 01 Nov 2024 07:46:26 +0000
Message-Id: <20241101-hpd-v3-0-e9c80b7c7164@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFOHJGcC/13MQQ6CMBCF4auQrq1hhiLVlfcwLpBO6SygpNVGQ
 7i7BWNiXL7JfP8sIgWmKE7FLAIljuzHPKpdITrXjj1JNnkLLFFBiZV0k5Fk6FY1FqztlMifUyD
 Lz61yuebtON59eG3RBOv169XmE8hSYgtYa405o8+dC37gx7D3oRdrIuEv0x+GmYG2B2qOUCvT/
 LFlWd4kZroG0AAAAA==
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

EgisVision 620 provides two additional channels:
- proximity
- attention

Add support for them.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v3:
- Make attention CHAN_INFO_PROCESSED.
- Fix comment style.
- Multiply attention by 100 to make it a percentage.
- Link to v2: https://lore.kernel.org/r/20241028-hpd-v2-0-18f6e79154d7@chromium.org

Changes in v2 (Thanks Jonathan):
- Create new attention channel type.
- Improve documentation for HID usages.
- Link to v1: https://lore.kernel.org/r/20241024-hpd-v1-0-2a125882f1f8@chromium.org

---
Ricardo Ribalda (5):
      iio: hid-sensors: Add proximity and attention IDs
      iio: hid-sensors-prox: Factor-in hid_sensor_push_data
      iio: Add channel type for attention
      iio: hid-sensors-prox: Make proximity channel indexed
      iio: hid-sensor-prox: Add support for more channels

 Documentation/ABI/testing/sysfs-bus-iio |   8 ++
 drivers/iio/industrialio-core.c         |   1 +
 drivers/iio/light/hid-sensor-prox.c     | 195 ++++++++++++++++++--------------
 include/linux/hid-sensor-ids.h          |   2 +
 include/uapi/linux/iio/types.h          |   1 +
 tools/iio/iio_event_monitor.c           |   2 +
 6 files changed, 122 insertions(+), 87 deletions(-)
---
base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
change-id: 20241023-hpd-edeb37f1ffc4

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


