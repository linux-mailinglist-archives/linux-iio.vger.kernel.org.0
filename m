Return-Path: <linux-iio+bounces-27579-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78646D0BCE1
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 19:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A8B8301D157
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 18:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E958C363C6C;
	Fri,  9 Jan 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jZtxaFQC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80F1A9FAF
	for <linux-iio@vger.kernel.org>; Fri,  9 Jan 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982535; cv=none; b=g0zNU/eMhrRoaPHcHvVFCACD0vaQcw6HSdsVulBi/YdRCWqcEATiSPglOwfPKlXsIzq087KYNKzl3bmBs1Pa/DKpvAkqQGo7ZFIv+0J/Hk9fub2W3VCQTtVfEDgYmZqTN2zln4FzK9+BceYlo5rG+Aq5pk79lXI8bvOELy3oXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982535; c=relaxed/simple;
	bh=Rzu46KxvulxHtFTeqNQrxawp5cJcOzu7sDnlEvvPnas=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mTQ2nfwcDGscrpmTZkMAC+p4s7iGc2WjuRkvpX6GuOPNNlaKXYRXfR4Pq2iBQlDUDumPo0Mutnv/4AlSv67Otm0iDYR4yoQXgs5K5JOjtF75peQI1/JLkMp+MwgtHBmUSqXZZ2JY/faJIR5xybS9VklQ7HBnYT8Tyt21bX750EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jZtxaFQC; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b728a43e410so812801066b.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Jan 2026 10:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767982532; x=1768587332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8KJcoxKNGI5ophIhKupAa0bc/5AP4ZQrV8vwxlDCe94=;
        b=jZtxaFQCtztg14LTGk1NAEq5USPXJlOrpw9ChH+EtlJzbDCKm3bx66wntKF4uwWjAu
         ZG3+b0XIepD2A7v2diNZHaBoBsnKLAP2gT/gaPVNV9enlJ9TOhkulxk/3k/TIroaV5Ll
         GXF6WoQHsnqMixv6yDtM/88K8esrOEW43HtPCW/T8D+yxbWyUP54BcK0AYQDqU44YdkS
         XFtDdOjNMEHMcMcJ6TxXnSlJImw+K9V2szltvMBJ7YWv0p8n4genTQUmE9rpmANsG1gI
         AVEt3+OAayzHyIeNsSOEVZAUDwVDt3vzMm74krlZsLt9syzcOubpr24Nz4Qa9i+xuaXS
         qQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767982532; x=1768587332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KJcoxKNGI5ophIhKupAa0bc/5AP4ZQrV8vwxlDCe94=;
        b=tkqPykVqI3DTAggO1hna+QvrlseNFOfemb/0bTWxK8+LcbTDoWM4JBhtVu4vg1JNjK
         an6eS4rZ1p9EIdrI7RkA/bzIAH/3s+24t+EHhcAFTfFbDFG2zAWvGlWXYqTnbKdWWehD
         JxsKlyrkAsu+h9l82dPMNdqJKbL1jLi5D8rwWWkQvAyay46LBn5buef2lv7qQc8tNeQE
         M71i9rePWOpfoCUZLsl9Z4ZYkcc9yuLj9eG0y0efMUDZx5cRG3nn7Db4WUGhKNggl6ID
         3LfjUq+M5dCqGvjqntpxWoGf04WVPUSaIBvp1r8+5nragHyfTLOEDZyAuCKXbvsT4RQ9
         dmGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAAIOMIpzRt65mi25BU0dJZ147YJU41xSL7fUCP6ooEy31AsXyt/6/HPM8Gb0uY1aTS+xoRNXFoKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywR2pJqNYZnaFZSEaevdkpKY0hVnWnoWCKl6Yw7YnSfGCzpBIV
	yjMyATMSzyYDpN6JqlMr/Yjsp8zmDENH7WDgGsXLZKBVHd+rtt8qHR9+qJYq0ZoPoxg=
X-Gm-Gg: AY/fxX7OqngvxNWjmhM/duSLCzcBaufiHN8lsGIeC9IHEsh5SvKMx+sCC0WoFw9m6+W
	Jwtov9oudo7NTGKAIDN9EEO/GyIhNXO7rAqeB3hJ3owSx4YyghU+MA08dGjd2gfyySgpDwwUxzm
	Cie0xdHAn6D3hPzJ7KKi+2UE9zKRMNKx1beVDK6H1kqeW5EaJqZciHFsryKFozkoRTgw6dJJxf7
	LeYNpNjW8yfRvs2RzTRwq2p6q5VTbO7WRvSXqfnihGfMMJINxQkKryfsfK/52sSU3ctZon+6l55
	cxBAMjPDlJ+VxCACMvic4C3BLN1haSPw9jsIffB0JXVFYAl1H5bAdHdvZTz3x0OCPE6nA/qUGrx
	6ON8EzxFxIxv55Wo9M0FJxJSEQCpRzG+kA4tOZeLOyqIX/QLi2uM9mDakTEr3axFHezqx
X-Google-Smtp-Source: AGHT+IEHCqEAU88Vgf7Lnan3mHRz/qSw02C7bEKuveNX5PaBWUr61WmiE2YT0N77Ub807kMhGe21PA==
X-Received: by 2002:a17:907:3e83:b0:b7a:32:3d60 with SMTP id a640c23a62f3a-b844518a88dmr1069157866b.11.1767982531461;
        Fri, 09 Jan 2026 10:15:31 -0800 (PST)
Received: from localhost ([151.47.174.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27bfcasm1208191866b.21.2026.01.09.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:15:30 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] imu: st_lsm6dsx: Add support for rotation sensor
Date: Fri,  9 Jan 2026 19:15:25 +0100
Message-Id: <20260109181528.154127-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118; i=flavra@baylibre.com; h=from:subject; bh=Rzu46KxvulxHtFTeqNQrxawp5cJcOzu7sDnlEvvPnas=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpYUWBX50qy43YLQ7CvypW721dszisXEmexPfmK bwsbsDEKfCJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWFFgQAKCRDt8TtzzpQ2 X7gSC/9n6igFOzWuUDOwnY9SkRtgE48lyS3QFGwlY0hKZejYZMdbXZZFlWxIviKmVlyH0NwZPvG IyuyHQb/E+y2bAe0w0Kel2w+HczhIRATLbkvA3w4XG6W61jFRe+uA4z6ya8R/ao75D84gMQw7KN gG7XOtMC2yfYMXiOc1fRO0nJksrpFvJasrGpIy5L+9oI9Cs59SqkQtEko4TiExPYiiZ6V1SMI9r dSLsUk6FJcZd1F3gllhItr9SJFohCu+wfekmNP9miFhL+SyYs2if07shhvjIfd4ffNP/0LYDqz5 zVkqnqq0EUyJfkiqsGRZnV0S2Y6/5Ams3deLufCjAZnIc3Vs87i44vQ54EbYUrc1Lj5GBwDRKXJ dqSjBw+622QUwUoN8jBxggP/gdbahpGJGD5bui4+/oZ8Xpa02PJM4FyTN7Z3oyuTnpkAW/tUmfg Dk4Ev2VnOVH5m4pZCFlArqkPt9Hd8TmsOULC0S5HdOIA/CDsr5T0whczw+AZjfSSYrP1s=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The first commit is a fix to a previous commit of mine [1] which made it to
6.19-rcX; the fix technically changes userspace, but this should be OK as
long as it goes in during this release cycle.
Tested on LSM6DSV16X.

[1] https://lore.kernel.org/linux-iio/20251017164255.1251060-3-flavra@baylibre.com/

Francesco Lavra (3):
  iio: imu: st_lsm6dsx: set buffer sampling frequency for accelerometer
    only
  iio: imu: st_lsm6dsx: set FIFO ODR for accelerometer and magnetometer
    only
  iio: imu: st_lsm6dsx: add support for rotation sensor

 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  26 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  28 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 224 ++++++++++++++++++
 5 files changed, 331 insertions(+), 7 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5


