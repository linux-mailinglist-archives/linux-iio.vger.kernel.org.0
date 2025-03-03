Return-Path: <linux-iio+bounces-16283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E5A4C104
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 13:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C36A7A378C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D9B7DA6C;
	Mon,  3 Mar 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+OPJNyT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C293BBD8;
	Mon,  3 Mar 2025 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006382; cv=none; b=r+LV5I192YShQkDcRJcjRrJBS8ds7fruBbXGgrfcx0cNzUjovq5NH2OCO8yx0YuVn4/m+JRlqUOTnYtzkf5SMIKl4+29QOUCvWrK2i+Ued8yfRIxIXbTiAe6muHFNzT/36NBXHg0MpYDAPOcRyc43RCNiWX7UUHMyOfhASl3IYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006382; c=relaxed/simple;
	bh=utD4m9KxZU2qXxJGpfZMJDAIaQB3fI8qf3jyLQewJIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sT1LlCBUTi2/EbA7Cdr7fTsA0f3PUWhstH03mcdJqgM6ANGzbBGshhQNuMfVa0AY1yPgSSSDgQ16tJsE5n2ni4sqVCSfCHmyFoa4h7oTGONZ2SEDgHnu7n1TOTt/zpSKlSUjqPSmjkcEScfJhbk7JBcz/EziI5WmMD6MiYr6YiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+OPJNyT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2239c066347so22441015ad.2;
        Mon, 03 Mar 2025 04:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741006380; x=1741611180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g7nF4G/QoMSbEjpBCaNBZjiOr+K5P7XYwcdTcf4W28Q=;
        b=R+OPJNyTr0dseAovsqCjRMfxbuJUtiPycPyZWZbrn18qK2lPRAsqPKCynDidE2+9TV
         Z0+ByTLE7kagdZozuzow6T/1ldwzaK8bqL9FmMkInCkHnCT7LqTyy7uBWbD9Ta6TbpYx
         N0vwGVX5jaeYsZc9MBBvR8kiOqK+6YmVN+2DyDV3FVgV9MlQeFMTlTTjV0EvQ8XHshiU
         YAXQTdSd0bz6Nwv8v9YZ2YEceG3mcQJsmFoG4lxcf8iO+hB8VYy5gnHEHMEsKbl/sKOh
         9N/0CGxUIPaFR1lKtcyCC+Wgr41+eHUY7FrtcwANcpha6rFk1hOlrque5NqK2PPbI1mp
         OaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741006380; x=1741611180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7nF4G/QoMSbEjpBCaNBZjiOr+K5P7XYwcdTcf4W28Q=;
        b=JxKf1/KA3d5n2agKKnZ1R/RsNJ0DnLB7S9/t8nlkMdW9Q7un1m4qVEUW+z9ugj4pZs
         2BFI9S5eATPDG/mT+5zNzL4COxb7jIUu0iA2PFVJHhjitFEqV88rEr5NvMDf1DymxUNx
         kxtN6Oh3zqEI1FgIKcK7QLtqMRQ4OxneV6nHFbh0lbWUv/GHF/AEFsR8vaK14cUNzh+w
         X2e2SfXVcuenP7YtKLd/X8p1wsY3WjvghvFp67nUXXpfUpQwAuqhyP97c+uhTasWYvY8
         5zHmoO6sbk0VTnfr9d7aBRplCWtU9PMW3eTcaFPTx7hp/1Dv8mgYyF14In5z2xGufbG4
         dHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSv4Y5vH3uKGV8wN9JUmrfH/b/cVf53GUlj56JSi23pd/EzuU/7dNHRmwfpa8dXpw9PDRFRLifmAs=@vger.kernel.org, AJvYcCX8G/AqoWDRcUgRHKwgmNqA4t9fhCvIlEW0KTKjL8hXWkXgRRMos5rMEozzvBF0C0ZkfJ3SvPe6TLuVz58+@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/NZe7Co7yTxdoSYelRNizlg1GvCzp5alFj3/5bvoQ2cRzVPu
	v3ZleCWGDH1QCMC5itvsu85Azpeco/U3c4q7uL0KMsEUgoVXaa3K
X-Gm-Gg: ASbGnctd/2+QGY1fsVJ8KOyXH7KQKpH6/tnOK3fLm/NSTscV6WlSfwo0JcwRednx2rC
	9wL397k4JB77dP0armU17j7pmQvArugkUZq8c/shD3kISQrRHOYF+DTUbjI7lEG1yOEGMcC0no7
	VwOAgfAM0sR68CLRCbRr4gNuS7LlAG+FHGC3H2x7BBAZd37j2ScZi4twc0gqzYDL0ei9uEUfohT
	MJMQb38iz0VYMEgs0JOg7tkW7ZoO9d7q95ELEg2wimZyKQszyaUHu/KvDdgVSXxpPHJTONZmzjh
	QQxd+IkYzHWEow6G1sJHiGlgCoNZblPpyxF4jpH3CUlq12U60j/Bxbl9vqoXLk+Rkg==
X-Google-Smtp-Source: AGHT+IF1rgR/bzCyH/MBlhqBNS9tlfKghtSxJphh7ZXwoa+zdyxUgqJSdsvP8GW9uDtbgiIC8Ss9sQ==
X-Received: by 2002:a17:902:e54a:b0:223:4b8d:32f1 with SMTP id d9443c01a7336-22368f6360dmr208146755ad.1.1741006379784;
        Mon, 03 Mar 2025 04:52:59 -0800 (PST)
Received: from danascape.tail34aafc.ts.net ([2402:e280:218d:2e5:dd9a:b4a:c5e:4e48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fa5a6sm77291805ad.72.2025.03.03.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:52:59 -0800 (PST)
From: Saalim Quadri <danascape@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Saalim Quadri <danascape@gmail.com>
Subject: [PATCH] staging: iio: ad5933: Fix CamelCase naming
Date: Mon,  3 Mar 2025 18:22:46 +0530
Message-Id: <20250303125246.342704-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by checkpatch:

CHECK: Avoid CamelCase

Signed-off-by: Saalim Quadri <danascape@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index d5544fc2fe98..a1a5eee4f736 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -43,10 +43,10 @@
 #define AD5933_CTRL_POWER_DOWN		(0xA << 4)
 #define AD5933_CTRL_STANDBY		(0xB << 4)
 
-#define AD5933_CTRL_RANGE_2000mVpp	(0x0 << 1)
-#define AD5933_CTRL_RANGE_200mVpp	(0x1 << 1)
-#define AD5933_CTRL_RANGE_400mVpp	(0x2 << 1)
-#define AD5933_CTRL_RANGE_1000mVpp	(0x3 << 1)
+#define AD5933_CTRL_RANGE_2000MVPP	(0x0 << 1)
+#define AD5933_CTRL_RANGE_200MVPP	(0x1 << 1)
+#define AD5933_CTRL_RANGE_400MVPP	(0x2 << 1)
+#define AD5933_CTRL_RANGE_1000MVPP	(0x3 << 1)
 #define AD5933_CTRL_RANGE(x)		((x) << 1)
 
 #define AD5933_CTRL_PGA_GAIN_1		(0x1 << 0)
@@ -68,8 +68,8 @@
 #define AD5933_I2C_ADDR_POINTER		0xB0
 
 /* Device Specs */
-#define AD5933_INT_OSC_FREQ_Hz		16776000
-#define AD5933_MAX_OUTPUT_FREQ_Hz	100000
+#define AD5933_INT_OSC_FREQ_HZ		16776000
+#define AD5933_MAX_OUTPUT_FREQ_HZ	100000
 #define AD5933_MAX_RETRIES		100
 
 #define AD5933_OUT_RANGE		1
@@ -302,7 +302,7 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (val > AD5933_MAX_OUTPUT_FREQ_Hz)
+	if (val > AD5933_MAX_OUTPUT_FREQ_HZ)
 		return -EINVAL;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
@@ -695,7 +695,7 @@ static int ad5933_probe(struct i2c_client *client)
 		st->mclk_hz = ext_clk_hz;
 		st->ctrl_lb = AD5933_CTRL_EXT_SYSCLK;
 	} else {
-		st->mclk_hz = AD5933_INT_OSC_FREQ_Hz;
+		st->mclk_hz = AD5933_INT_OSC_FREQ_HZ;
 		st->ctrl_lb = AD5933_CTRL_INT_SYSCLK;
 	}
 
-- 
2.34.1


