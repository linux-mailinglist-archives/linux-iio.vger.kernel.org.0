Return-Path: <linux-iio+bounces-9419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64732972897
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 06:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959941C23C6B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2024 04:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B9B14A0BD;
	Tue, 10 Sep 2024 04:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFPcV3l/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B023C2F;
	Tue, 10 Sep 2024 04:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943897; cv=none; b=WsIuqJbPtKpSi/YPz05sZJ9X7o8xC8SeDCbIUEHjL39l+GQEeDDHkCHIZfROuQGYWLX/ez5fOMhVNonfvDKDrcG/CCNPs15YZO/jilKMyc/mmkkdA7DtQIEQ9IClYFdn9nVQkLdnuUO12fe4wpNGdhQmVHs4gOcX3w9MJiw/qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943897; c=relaxed/simple;
	bh=TsS82rlpqmzGX421x1xpzqOXEpKqPWiI6F6cnPqdhbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sT8lvQV7Oh+VMQ4//QHC8ft16sBpru8GPeY/F67Ugug/bduGP5n0wn5mI0GXyQwPzbBKJIBePtwUKS0lLiCjYhPErPsW9KDHSrcjTPOA4gDDBFe86lcChPMloT+JObkLUcI+5omk7XVPkEL+jAcPE3GyqugjISTKgfavV8mOUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFPcV3l/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20570b42f24so3461685ad.1;
        Mon, 09 Sep 2024 21:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943894; x=1726548694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7OIOFYUXdV0WhosYJRDfjMThGwiC2VKXv2im3pjeTWE=;
        b=IFPcV3l/1WFnG10Igu1PxR0F22afwDPaRVXmD1Kc3QZ6lZZwpJ3dkJ74bx4WOyuSiL
         s6fYoRLxT1YBWl79h3mVbV31c0qx3k4IRHj62Vd31DKsX3WVQTvRTH55tDQR3FKs3I7S
         +buqA417rfUfYIZxKwI948E3b5avTOAy4Y5eDxRPNv88LUI/BkmDGDWuCAPRiGjMdebL
         bJqTybQ2jh1tAhbMlId4P47vWQpZIwlqt8MI6whS8Ifs/j6yE04Y+GYgkN7o1drM/lFl
         BX25nHV+y6ykpeTYsOo3hwWLbc7VqSboMHpbbOkTdtO/v+TNYBQrxQHRnENFFJBzdokB
         UtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943894; x=1726548694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OIOFYUXdV0WhosYJRDfjMThGwiC2VKXv2im3pjeTWE=;
        b=WeiOo5WfK/PMSqc4/UxJAFKylFklnzGZBPNdD4nnNv52rnXuYFFUz3fTsw4qIsPYS0
         f//brfCUPXZXK8oFbBnlXjLOc6ayowlsnjpDgDCzwmncw5uRuvjCKquFJIRTjkouef5J
         T0JIz3b1270V20GAwYng7sG+Wv8X/XS8CVtA7S7gGBy+Vmc+JXUJ3/tpNsWhscJwHyB3
         i2aZyXuPZdr7fGaPKOpAhMuLiZ4hQzWJe1mwf/G/L3WfBEwV3MUXorj8UI2G9KPIHKvL
         wznerHuC6dfH1dECrQsekiHErhq8sna/U5WaQ6tU7jOvHZJ2urrpZFgOWkYhpl9juDk5
         lSdA==
X-Forwarded-Encrypted: i=1; AJvYcCXg+igFaV2+KcnLRnnQJLmuKi7raeNpFyyoyyT/XUgaaVRGynaA/nGSvu+QLMM6Nl8SRQrKWuoYcpOy2qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolYxg3Y4ihqN64gh3w2ODjDzLYwt788wsNlQNwl0gXMi7dL7Q
	E+Cko0TI+GLe0MNJ0i8jQAbjJjNtd6f7T3sdhOKulGEmHTqpq55TCm7FEhymiC8=
X-Google-Smtp-Source: AGHT+IESuJBuBZ+CrmXR26aG67o7i/qlfXw0b+StpnXg1uoC63TW5Z7TQC4m+a0dyz4Dowo53ihl6A==
X-Received: by 2002:a17:903:41c9:b0:202:2cd5:2095 with SMTP id d9443c01a7336-206f04f6845mr129643015ad.18.1725943893956;
        Mon, 09 Sep 2024 21:51:33 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20710ee70a1sm40882965ad.121.2024.09.09.21.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:51:33 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 0/4] Threshold event and Sampling freq support for LTR390
Date: Tue, 10 Sep 2024 10:20:25 +0530
Message-ID: <20240910045030.266946-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for configuring the Sampling frequency of
the sensor. The available values for the sampling freqeuncy are provided
by the `read_avail` callback and they are in miliHertz.

Then the second patch adds support for suspending and resuming
the sensor by providing the necessary callbacks. And registering
the ops with the driver.

The third patch in the series adds support for Threshold events and interrupts.
Exposed rising and falling threshold events for both the channels. The events
can be configured via the write_event_config callback. The desired rising or falling
threshold value can be written to from userspace.

The fourth patch adds support for threshold interrupt persistance.
It triggers when the UVS/ALS data is out of thresholds for a specific number
of consecutive measurements.
Exposed the IIO_EV_INFO_PERIOD attribute by which userspace can set the persistance
value in miliseconds. The persistance period should be greater than or equal
to the sampling period.

Changes in v2:
- Added "linux/irq.h" include to fix `-Wimplicit-function-declaration`.
- The above error was pointed during testing by kernel-test-robot

Thanks,
Abhash


Abhash Jha (4):
  iio: light: ltr390: Added configurable sampling frequency support
  iio: light: ltr390: Suspend and Resume support
  iio: light: ltr390: Interrupts and threshold event support
  iio: light: ltr390: Add interrupt persistance support

 drivers/iio/light/ltr390.c | 363 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 361 insertions(+), 2 deletions(-)

-- 
2.43.0


