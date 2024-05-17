Return-Path: <linux-iio+bounces-5086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D58C8270
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 10:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C763428330D
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0057D1AAA5;
	Fri, 17 May 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iS/Z4/ob"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3568516415;
	Fri, 17 May 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933457; cv=none; b=HA37HtuyWpdfORm115Q6S1WWx4slzMyD+esvNt/C+pYuKOLMhXODt0+JInGws5fvinG8dKl7gCEVq6FozrSAbFsQ/e7b8+ACNzDY/vDGUKSIpCtD2IkXxoMzc5jLFj23+1sz9uLGQBk28+vpTa1c54Fn91EPKN0jZtywlfuzNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933457; c=relaxed/simple;
	bh=2jUER4iVF4Ci2sbFwXRZy9Fy49bUQFnHWIEQp5KneL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dWC2cXFa0lnpoGN25u4ycH/fEt3FJBo3ude3ZoQrcwq3ignOZj6TH9zFurFLuYEE34cqQWS2gCSUZxmx7X/R+mgUL/kfIeDsKpwzwbUXr4GupKEM4U8YTgB2rmLUgVbMjnC9gPIIPIqtt5eYagw8b5g2MS3HitZEYfuZTaexFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iS/Z4/ob; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-523b017a5c6so2555667e87.1;
        Fri, 17 May 2024 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715933454; x=1716538254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/BiBMbqhJzf7qFAm8xRj3DsNK6Or5mWWpiqpUg1D30Y=;
        b=iS/Z4/obar9h9Dpk5H1+38e8Y4NgTBTCw/8grjTTx39QV/johl0MT/vjdnt+spm0qK
         C/PHZs6vIAU8l69kkdnzjsT5OhFNfV/nB8eYjyqGO6rnKR4vB5wcYOQkcgwAlKLwpERV
         etnmCea+uhZp5OI//9VN5f3+99hMX2wgPo8k3/Wj/Q7f2d+UqXbYI0Aj0kKnwky3f+B0
         9cw9UY8lvtouGoDcJhw5lh7nXKuOPYbvcd2nGimKBfHRP068/aNsHkBhaysJXMxcnQid
         ZgISafu1L/ZZYaYxFPWV7uJyQgJWdn3iH38++Te+a2BRv3U40V2U5+BtComGct7oRH9C
         WDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715933454; x=1716538254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BiBMbqhJzf7qFAm8xRj3DsNK6Or5mWWpiqpUg1D30Y=;
        b=Cu6zzpuX6jKePYutA6FzlPY3z+BOEgzBifHyzZdAw+w9jRPbKnjBhfTOvpu6z6myzQ
         LgCVMY9klcuz4UaRknbfbWNTLlbNFf2UIeDuo0hCDR1KWIgYsqL3aveKwgRAZLvkhZtT
         4A3m/00ar0Cz7C528IKa+Hq/Co1Qa7Fu4b+mB5AclBgVnt/GrK4qvMeKyXmh1BNkvWJR
         atItFrl4xFMUnAXmgvzAV6N0DwpBdcjKFf5XJizDCuvjnUta4w8UmP3qzh3JmhLwvAB1
         xUNbdJJlJrV9IZfttCYb7eOYXQ5od7x+sl/bPx78ocNDfYb8oV9t6A+OYuoPs80wsG/M
         TOIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6LLlMQOqBfkMrV4MND0crDMxxdMbILufA8wdAmb+y+XoFbKQ6W0ATSYl02ODd4nVF9nICfZ94mpzB8zKbuNO7Oa83hk7mBvtK6XYrv6BCqJXhzuikzkIwEMw3npkm6cQRL/YKWvPg
X-Gm-Message-State: AOJu0Yxdd5Y0mu0n2TTQ6lR23/s5xdLSVVrVKoee3eYKvsFX2A2Agpbh
	TArwmRzvSk8ttcpx1RWRV8hDSz5PxejRYSa/bD0mVu5bkt1E7F/H
X-Google-Smtp-Source: AGHT+IFicIEMWV0V0nY1tIQ3C7/YiUadLI/iVH/Sb7RhqMQtYImLofB6/nHkVT4U/mhl5JopQ0AwGA==
X-Received: by 2002:a05:6512:1087:b0:523:78de:11a3 with SMTP id 2adb3069b0e04-52378de12bbmr10921766e87.2.1715933454045;
        Fri, 17 May 2024 01:10:54 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a90d0e919sm360867866b.85.2024.05.17.01.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 01:10:53 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add threshold events support
Date: Fri, 17 May 2024 10:10:48 +0200
Message-Id: <20240517081050.168698-1-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add patch for providing index for both channels and add patch for threshold
events support for the MCP9600 device.

Changes in V2:
  - Remove pretty printing patches from series
  - Add patch for providing index for both channels(ABI change)!
    Suggested by Jonathan, hope this okay.
  - Remove formatting in a precursor patch
  - Add lock documentation
  - Add define MCP9600_TEMP_SCALE_NUM and use it instead of MICRO. MICRO is
    type unsigned long which we have to cast to int when using
    multiplication or division, because we are handling negative values.
  - Use switch statement in mcp9600_write_thresh
  - Replaced generic interrupt handler with four separate interrupt handler
  - Use one lock instead of four
  - Added error check for mcp9600_probe_alerts
     

Dimitri Fedrau (2):
  iio: temperature: mcp9600: Provide index for both channels
  iio: temperature: mcp9600: add threshold events support

 drivers/iio/temperature/mcp9600.c | 398 +++++++++++++++++++++++++++++-
 1 file changed, 396 insertions(+), 2 deletions(-)

-- 
2.39.2


