Return-Path: <linux-iio+bounces-18352-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94597A945FD
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595FB3B64CA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 23:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4091B87E8;
	Sat, 19 Apr 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK+DL8RZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5045E13635C
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745105070; cv=none; b=dQ19wCv9mFiIp4HUuMWOOO9Ji2eU3ekEJzpeSaWSVcaA3IcpyN3bpS9Nl2q0K6E1/wK1FHkhtcZlzmPHNdp6W+Che/mnv+zA0DTkvEIgSmVnNiLsSVWqjQ7RDRK7rfj8+RAzPpfWbGz+SbBSpjqADJbykirVParGuubmFNANoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745105070; c=relaxed/simple;
	bh=pCubm2uoRmYedgzJ+j0up1sqQudxLBxhzNbaR2FSzkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifcKxz8SLmlRu7lNG3QDnpPHy/9FxJ3l1U/6UpATMwzCnpbp6O5IVHPzOjiyCRPhPPIk+L48U+5qCbogwpJp2qGf9OmCZ05LmSAEO+SXvlK23aqS4hqkxJy1hOgyp+XG0c0tOQGINRzt5U/hPTPBCVa1AZ+G3oilCaT4lJENEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK+DL8RZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so2357604a12.3
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 16:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745105067; x=1745709867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJMBBR16MIz7dRenW/Hp2INZR0aisPEq4DDLgaMgLg4=;
        b=cK+DL8RZfYSr8oTzH0wBVXIHUq1+A4JmOSO7nn2ES/OjJHjUQTG90dan5SMDOOTVKQ
         ty8ZnBKhPmxar+u94JZ14dA5CS2wDHXBsZUr2OKDz0saiEGy+1r6zkCm3QLHUQkUHpfy
         jKVXfzuLnYqubg3iPxej+VbWUapqeYFSkXTU99p3I4y9TB2jsdynyv3ARyOxlO6B2AbG
         J5E2bVCxFVcq8tdztp7Nb/LEwHVMsmGFxfFexcYuQPSSO4Q51L4LAwK42JysbcZqSj05
         a6RkByHuj/COPwYSOlPibaxplymxVhSpZfeRFgnYAgCQjCUzGNZwgCmnuhDCNHB+bMuB
         qwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745105067; x=1745709867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJMBBR16MIz7dRenW/Hp2INZR0aisPEq4DDLgaMgLg4=;
        b=ATBS058/PJxVUK5EtrpUQH8ZnhBDlpaANqHQIP9sYZxjjk0rxxp8xlIVnXS5PYKiRD
         arJ/VJGGcun2BDT8WzYs0ECZb0RSj+cF8+39JV9ZbRb4Ie/Dew2ID3vu7Huxhdh6p3hG
         lsEHtMjaqi8ThNgs8XPruxDEa1PmjY3bHOvBFCOa0Ce/ZH/s4zsjV59iY5FZQ/NAj9Px
         AyH7GAUsfEp4SVzp84qX33q46Sep4ka7JyXl9DgGeY8CUoZpKKSEZ+HeytTghqiktnlc
         pZomaHr33mEnfEC5cMGsylOARansatE63fI+iWjtoSOe81RvtHmiktJA0fWQivtRU9Yq
         PpWA==
X-Forwarded-Encrypted: i=1; AJvYcCUzNgXfOyyf6F7WGFZyVdew6stEUmStzcoySEWME4UpbQMizHxJKPGVX8go9DT9VZMa3Z++KtCRkUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZdKc6ZIttHMWLuS7eoE/SKbZChu0TcL+715RBMmb9f2IWZml
	1KY4VL3Pe3lsMrezG6x+EEv3XbO5KQKh5woaSIh/GbZJ6WutKVyB
X-Gm-Gg: ASbGnct/FFtxsx9UDsn+aa6hHIMYe8W+Z1o9Ze7uDtBjmsjw0QvwYk72d6VrwQ2sOQ0
	qrgDKh1ov6Q1dcfhd3jApu6Ik0kC4mFdCfd5zn1QEWiUgKhpx64r7NOpusjKdGK6+8wW1Wrybyz
	sD9QHfCs41tXe+tgKxpR18rW0ASstyNow7gK4ayZGII1Ei4O/zVhmyl7xwcCP5tn+xeZsb8+HLW
	2ggV8irFBWfe95F/iVZvQ3JCyZxrgBJgN+M7crq/goj5/FeTTdosM+VFQU8iFdCo1wyqvabhf93
	jUQWMbddIStfLcz/cwL7qpSm612nX0ovv/AtRTxK9+Sv2HhpXvykWdbYg7c0m2MBoISagSD5wl7
	B52ouLZ/JmPOw0rU81+opA1IYkaledLUeXkd8
X-Google-Smtp-Source: AGHT+IHycWs61AtMP/o2TLGGEmB1zV2+c/ow/vRBL05lL2A25rjWprCca9DHRo7ioOaVHRvAWVDznA==
X-Received: by 2002:a17:903:1d0:b0:220:d257:cdbd with SMTP id d9443c01a7336-22c5363005emr108792905ad.48.1745105067370;
        Sat, 19 Apr 2025 16:24:27 -0700 (PDT)
Received: from mintNaitss.meuintelbras.local (187.103.56.177.redfoxtelecom.com.br. [187.103.56.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa58333sm3829011b3a.118.2025.04.19.16.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 16:24:27 -0700 (PDT)
From: nattan <nattanferreira58@gmail.com>
To: francesco@dolcini.it,
	jpaulo.silvagoncalves@gmail.com,
	jic23@kernel.org
Cc: lucasantonio.santos@usp.br,
	Nattan Ferreira <nattanferreira58@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads1119: Prevent concurrent access during
Date: Sat, 19 Apr 2025 20:23:16 -0300
Message-Id: <20250419232316.36002-1-nattanferreira58@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nattan Ferreira <nattanferreira58@gmail.com>

Use iio_device_claim_direct() to protect register access via debugfs
from conflicting with buffered capture modes. This prevents data
corruption and ensures correct device operation when users access
registers while streaming data.

Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
---
 drivers/iio/adc/ti-ads1119.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index f120e7e21..273fb8e35 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -405,6 +405,9 @@ static int ads1119_debugfs_reg_access(struct iio_dev *indio_dev,
 	struct ads1119_state *st = iio_priv(indio_dev);
 	int ret;
 
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
 	if (reg > ADS1119_REG_STATUS)
 		return -EINVAL;
 
@@ -421,6 +424,8 @@ static int ads1119_debugfs_reg_access(struct iio_dev *indio_dev,
 	if (reg > ADS1119_REG_CONFIG)
 		return -EINVAL;
 
+	iio_device_release_direct(indio_dev);
+
 	return i2c_smbus_write_byte_data(st->client, ADS1119_CMD_WREG,
 					 writeval);
 }
-- 
2.34.1


