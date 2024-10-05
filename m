Return-Path: <linux-iio+bounces-10172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47179917F6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6D62842AB
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACB0156243;
	Sat,  5 Oct 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR8NJ8k0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB761547D5;
	Sat,  5 Oct 2024 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143580; cv=none; b=MguViSzv4hs8oZXuaeV/TYxkY95sPEKzQkbpWdtQggug+9uoWn4Mw0g+bjc9bWK4yklxj00GOU8LKvIX6aPBd+mQpQV7zVS8n+U2+NkpOf5I8OljJmCvUnqPdnGQ/OpNpTqimtf44SaObPiCv8sKu+w851Nr0hAkcnWxgeLC4eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143580; c=relaxed/simple;
	bh=tUbAh3S1A/hWL8BJvkJC72A9NL9PRGDzEmnO6JnHjPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X2kqBVWMHPsS/OX7DNfLc6YM4x28wJOyrvyIXJ1wuD9YMvpLfPa0/719V3rUXoIngQOod8MkUyi+laZ9DhZudVNpwPpQl6tBDzpTm4tbBS5eyXuRVco0v4lguXqi9NFLpzv5yw9kiO5+GuMkWJIRIO5sIRbWm3m7q6W3DJpDtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR8NJ8k0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e09fe0a878so2231455a91.1;
        Sat, 05 Oct 2024 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728143577; x=1728748377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROxzB/xHdP8Hy800T/tHG5OdHpXWoCC/AQWQSzk6cuw=;
        b=dR8NJ8k0hyftcCjR02brUAw1IjHXPddbkIJnad37fRp9zEg2qIUrB3rDM/tZMDB5oT
         REPLsEOdiM92sdwtUTG0j6hPseeJOtqZosAabdij/uha8BD7cTzgL5Og3h8AB/cu1014
         L2cRvteIO42Lph+D+ujcrxQ0ii5AXJEavD3pOl/copJA9b6v/E1H4r6+W1hQSuhMPHD+
         YJMWMCPrTyOj9grSvid0rz2jpTtEKYL1tBCN/qOWthjZ3ghfpGaip4taIKCmw2+I0Wf+
         6QTeKZYreDZh0LUl4DVbxLHqEreQ8tdMumAjSAVHdu5enLslA1+yfz6jFWBel977Q77w
         rszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728143577; x=1728748377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROxzB/xHdP8Hy800T/tHG5OdHpXWoCC/AQWQSzk6cuw=;
        b=iHwPZV1gKZbHatekAnjIXj4vraPgqx0b7XtG3Zk3MKNk3A2/tYHOB7BCujkTrLqOeE
         R1trhThA8/QwOHjVTWn3RR6DhjsXFSyOiIbuio4Y25FR4pJPCsOXTEn7Dvf/9z7thiLh
         nWyG6OuMpuHzm/Wuze9K1vFxTahfi6Xc5BRchGvttDXIKdBmZgzTzAXoyRVwHDmVkjoX
         1aiCvF9/s7IQi62fzO2E3/6oQXg9I2/CpS8kLUq7zbiPzm9zyJlZgm5GA+ZPErxQ/B7o
         I0wsJork/Q/WMMBdwvClwzkzEOYuhpY7eJmDEb6KiaMTWqXdfFiIe+5RSUbpMJAM3c44
         AZfA==
X-Forwarded-Encrypted: i=1; AJvYcCV+cqFXZEojKRIcg9MCdEm7BXWmPdWbxVVWSkhbWCi1LPIqf2bOCa6isK1SAC/puLJF1Tlp2BEAtlh3Tno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUT2lB65DNXYcodvHF3rAx3jGxB0tcS+s68na6b1L+EHLzA3Z5
	1qfjwGpCI64qdRWV6HBjC8vi4JjzDMssghRu2d38yqw71+ruvO8l02jBzu65WNc=
X-Google-Smtp-Source: AGHT+IHtauJ0loFDuHBBREuB+JBEKnsJ0balSfkZGEJOHPcBTYRx1EbwC6LJu4WzOfm7jiF6e2ekyQ==
X-Received: by 2002:a17:90a:458b:b0:2d3:d09a:630e with SMTP id 98e67ed59e1d1-2e1e6212e23mr8454240a91.1.1728143577378;
        Sat, 05 Oct 2024 08:52:57 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20aebc40csm2008370a91.23.2024.10.05.08.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 08:52:56 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 0/3] Interrupt and Continuous mode support for VL6180
Date: Sat,  5 Oct 2024 21:22:22 +0530
Message-ID: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The first patch adds support for configuring the Sampling frequency
(inter-measurement period) of the sensor. The values must be provided
in miliseconds. The default value for the inter-measurement period for
ALS is 10ms and for Range is 50ms.

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

Thanks,
Abhash Jha


Abhash Jha (3):
  iio: light: vl6180: Add configurable inter-measurement period support
  iio: light: vl6180: Added Interrupt support for single shot access
  iio: light: vl6180: Add support for Continuous Mode

 drivers/iio/light/vl6180.c | 266 ++++++++++++++++++++++++++++++++++---
 1 file changed, 249 insertions(+), 17 deletions(-)

-- 
2.43.0


