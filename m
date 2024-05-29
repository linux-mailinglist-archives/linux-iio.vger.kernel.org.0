Return-Path: <linux-iio+bounces-5432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796F8D3406
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 12:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3AF1C20FCA
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82A17B4E5;
	Wed, 29 May 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QfIFY27M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839717B427
	for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977287; cv=none; b=TGy23pL+hocCzLffHIGoKh/iu06ldfUXBUd45g9QhjUBPZ6oCmTuEx3uN3h5QJm133qWfg3LUj3FKif4Gtg3s52nBleekDD7pkiLyccSzRjiT9Zk5BO6mWUMTOPJ6cQwKpZCLmEgh6XUMzdhbvCh6rGXPXzWmfVZ4t4e2CScCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977287; c=relaxed/simple;
	bh=eIo0R35t2QY5j32or05kaLotbvyI4Ohy3UYxx3Q7HTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qfHPW1MvvCNSKvXPcIksYaamCBhXAKJyVKxYYE3o6v2m0SND5mcuc/BrnzaamzRykHwSADGTp3uvCF20Hc9rwdpeWJEyP49pisAagh43Yhy4FvD1ssSorFuLaXGFiyjXhkKgSNlhgS/hwhm/VKGfXuRfOQ/w5E39j5Y9Wz8pgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QfIFY27M; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52961b77655so2155202e87.2
        for <linux-iio@vger.kernel.org>; Wed, 29 May 2024 03:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716977282; x=1717582082; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4js5JtrO0IQ/vCKIVy0e2SFEkJXg+1uQwnGJtlQuqAw=;
        b=QfIFY27MVk124mZcpBVuGVTorwdSFoghRxbcl7nf+LSsx0L3PdlWwJ/iCpwxjMv6Gj
         cmn2MkOKmMeL9wrVp+KA8TFUdS5+St/JBDcEA9BeS0iQuSrcmvY3nQFcSiJw6z9h6gLL
         R4K/8PtZ3Alz4Uz0ghM9NrLNisTG5tuwKpXc4rViPM87GsqhD64ka7OQbBZhBSoXiOBF
         x4zVGFaa+CsSBxZexFEIzZFHxGVs52QxKB0a/2yxDi7SMa5qf8hYGd9NJxKOKvIeAoEa
         xrtldU10Pe6uqwe2F44cpOCj7t2FI89wDi6KAXLY/7vFu/3I+mVC7b91cqnid5gV8A+I
         jbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716977282; x=1717582082;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4js5JtrO0IQ/vCKIVy0e2SFEkJXg+1uQwnGJtlQuqAw=;
        b=sFCJcQk+/+XBd3/DZcaMQuolTXk5iTA8aX782aStpkVgrWNvmJGOyg3TLdR2E7RQGP
         IlQf+VSadR8QRP4tT0YHfZ2v1Lt+srn24zcluaRSDD3rxJphhVO2vpyBKbPi02CP8d9x
         cdJTrPo8yTQf8auV9mVbOj8aJ7p2fOf/IDhsJpL3zceAqwvdqWzTnCixRsYoMixOugiL
         qqTcEwxTR197UyNwBBWy+kqDL9o8IeMZDeL/COxoQ4oZI4nW9hiRP1zuKXlAZ1YoYH/Z
         nDyxkIvJ8qvzvkkZ4aIAZmk/qLYmWKng0I0rhAuTd7GZmHF26ozVUtoxZhD19gHcGV5+
         ZM6w==
X-Gm-Message-State: AOJu0YwS49zZXvGFt95H0yNYgggcxgjfZiHpUF4TCD1MQwkgEDs21Szg
	zrUaoRGLlAnG/KDMdGbMDXcXN2b5zXWAFNQqNWySI51HlzB0Pzees+l5S8d7qyydvzFW4UbAPPM
	mP31VIw==
X-Google-Smtp-Source: AGHT+IGGe4/Tn5GgretW7j8tNRIXvKGnvpePrcKM5iXg27Qz9sqU2UPT+SDc9TWUfAQxua/O66GT6A==
X-Received: by 2002:a05:6512:eaa:b0:51c:d6c9:e9a3 with SMTP id 2adb3069b0e04-52964aba890mr10432981e87.17.1716977281883;
        Wed, 29 May 2024 03:08:01 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1410csm207019115e9.15.2024.05.29.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:08:01 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 29 May 2024 12:07:58 +0200
Subject: [PATCH] driver: iio: add missing checks on iio_info's callback
 access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-iio-core-fix-segfault-v1-1-7ff1ba881d38@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAH3+VmYC/x2M0QpAQBQFf0X32S22FfkVebjWwS1Z7SIl/27zO
 E0zD0UERaQ2eyjg0qh+S1DmGblFthmsY2IyhbFFZRpW9ex8AE96c8Q8ybkeLFLbATUAK5TaPSD
 5/9v17/sBTipsWmcAAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

Some callbacks from iio_info structure are accessed without any check, so
if a driver doesn't implement them trying to access the corresponding
sysfs entries produce a kernel oops such as:

[ 2203.527791] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when execute
[ 2203.535795] [00000000] *pgd=01e70831, *pte=00000000, *ppte=00000000
[ 2203.540822] Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
[ 2203.552078] CPU: 0 PID: 1286 Comm: cat Not tainted 6.9.0-rc5-ad7380x-mainline-g9bf895a40063-dirty #226
[ 2203.560079] Hardware name: Xilinx Zynq Platform
[ 2203.563300] PC is at 0x0
[ 2203.564523] LR is at iio_read_channel_info_avail+0x48/0xd8
[ 2203.568716] pc : [<00000000>]    lr : [<c07b52e4>]    psr: a0000013
[ 2203.573672] sp : e0bade60  ip : 5e861799  fp : 00000001
[ 2203.577586] r10: c2dcd298  r9 : 00400cc0  r8 : c2dc6000
[ 2203.581501] r7 : c4339008  r6 : c2dc6000  r5 : 00000000  r4 : c1003fc8
[ 2203.586718] r3 : e0bade70  r2 : e0bade68  r1 : bf00ac88  r0 : c4339000
[ 2203.591935] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 2203.597761] Control: 18c5387d  Table: 01db804a  DAC: 00000051
[ 2203.602194] Register r0 information: slab kmalloc-1k start c4339000 pointer offset 0 size 1024
[ 2203.609520] Register r1 information: 2-page vmalloc region starting at 0xbf00a000 allocated at load_module+0x704/0x1954
[ 2203.619016] Register r2 information: 2-page vmalloc region starting at 0xe0bac000 allocated at kernel_clone+0xb8/0x368
[ 2203.628417] Register r3 information: 2-page vmalloc region starting at 0xe0bac000 allocated at kernel_clone+0xb8/0x368
[ 2203.637808] Register r4 information: non-slab/vmalloc memory
[ 2203.642166] Register r5 information: NULL pointer
[ 2203.645559] Register r6 information: slab kmalloc-4k start c2dc6000 pointer offset 0 size 4096
[ 2203.652886] Register r7 information: slab kmalloc-1k start c4339000 pointer offset 8 size 1024
[ 2203.660211] Register r8 information: slab kmalloc-4k start c2dc6000 pointer offset 0 size 4096
[ 2203.667537] Register r9 information: non-paged memory
[ 2203.671278] Register r10 information: slab vm_area_struct start c2dcd280 pointer offset 24 size 80
[ 2203.678951] Register r11 information: non-paged memory
[ 2203.682779] Register r12 information: non-paged memory
[ 2203.686607] Process cat (pid: 1286, stack limit = 0x354430a3)
[ 2203.691052] Stack: (0xe0bade60 to 0xe0bae000)
[ 2203.694105] de60: e0bade6c 00000019 c105fe40 00000001 00000002 5e861799 c4309ec0 c07b529c
[ 2203.700979] de80: c411b200 c051f1e4 c0b48d30 c2dcd280 c411b200 c02c1fb8 c2dcd280 00020000
[ 2203.707853] dea0: e0badf20 c0b12d88 7ffff000 c026c944 c1003fc8 00000000 c2dcd2a8 e0badf08
[ 2203.714728] dec0: b6eaa000 c0206480 00000001 e0badfb0 c2dcda00 c1003fc8 c1e46d80 c02c0ba0
[ 2203.721602] dee0: c0b12d88 e0badf78 b6eab000 00000000 00000000 c0240114 00000a55 c1dbadb8
[ 2203.728476] df00: c1dbadb8 00000000 00000000 00000000 b6eab000 00020000 00000001 00000000
[ 2203.735342] df20: c1e46d80 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[ 2203.742208] df40: 00000000 00000000 00000000 5e861799 c1003fc8 c1003fc8 c1e46d80 00000000
[ 2203.749074] df60: 00000000 c1e46d80 b6eab000 00020000 00000000 c0240a80 00000000 00000000
[ 2203.755949] df80: 00028008 5e861799 00000003 b6f10f80 7ff00000 00000003 c01002c4 c6716e80
[ 2203.762814] dfa0: 00000003 c0100060 00000003 b6f10f80 00000003 b6eab000 00020000 00000000
[ 2203.769680] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 00000000 00020000 00000000
[ 2203.776546] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0 60000010 00000003 00000000 00000000
[ 2203.783416] Call trace:
[ 2203.783429]  iio_read_channel_info_avail from dev_attr_show+0x18/0x48
[ 2203.789807]  dev_attr_show from sysfs_kf_seq_show+0x90/0x120
[ 2203.794181]  sysfs_kf_seq_show from seq_read_iter+0xd0/0x4e4
[ 2203.798555]  seq_read_iter from vfs_read+0x238/0x2a0
[ 2203.802236]  vfs_read from ksys_read+0xa4/0xd4
[ 2203.805385]  ksys_read from ret_fast_syscall+0x0/0x54
[ 2203.809135] Exception stack(0xe0badfa8 to 0xe0badff0)
[ 2203.812880] dfa0:                   00000003 b6f10f80 00000003 b6eab000 00020000 00000000
[ 2203.819746] dfc0: 00000003 b6f10f80 7ff00000 00000003 00000003 00000000 00020000 00000000
[ 2203.826619] dfe0: b6e1bc88 bed80958 b6e1bc94 b6e1bcb0
[ 2203.830363] Code: bad PC value
[ 2203.832695] ---[ end trace 0000000000000000 ]---

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/industrialio-core.c  |  7 ++++++-
 drivers/iio/industrialio-event.c |  9 +++++++++
 drivers/iio/inkern.c             | 16 +++++++++++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index fa7cc051b4c4..2f185b386949 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -758,9 +758,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
 							INDIO_MAX_RAW_ELEMENTS,
 							vals, &val_len,
 							this_attr->address);
-	else
+	else if (indio_dev->info->read_raw)
 		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
 				    &vals[0], &vals[1], this_attr->address);
+	else
+		return -EINVAL;
 
 	if (ret < 0)
 		return ret;
@@ -842,6 +844,9 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 	int length;
 	int type;
 
+	if (!indio_dev->info->read_avail)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_avail(indio_dev, this_attr->c,
 					  &vals, &type, &length,
 					  this_attr->address);
diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 910c1f14abd5..a64f8fbac597 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -285,6 +285,9 @@ static ssize_t iio_ev_state_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	if (!indio_dev->info->write_event_config)
+		return -EINVAL;
+
 	ret = indio_dev->info->write_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), val);
@@ -300,6 +303,9 @@ static ssize_t iio_ev_state_show(struct device *dev,
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int val;
 
+	if (!indio_dev->info->read_event_config)
+		return -EINVAL;
+
 	val = indio_dev->info->read_event_config(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr));
@@ -318,6 +324,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
 	int val, val2, val_arr[2];
 	int ret;
 
+	if (!indio_dev->info->read_event_value)
+		return -EINVAL;
+
 	ret = indio_dev->info->read_event_value(indio_dev,
 		this_attr->c, iio_ev_attr_type(this_attr),
 		iio_ev_attr_dir(this_attr), iio_ev_attr_info(this_attr),
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 52d773261828..74f87f6ac390 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -560,9 +560,11 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
 					vals, &val_len, info);
 		*val = vals[0];
 		*val2 = vals[1];
-	} else {
+	} else if (chan->indio_dev->info->read_raw) {
 		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
 					chan->channel, val, val2, info);
+	} else {
+		return -EINVAL;
 	}
 
 	return ret;
@@ -753,8 +755,10 @@ static int iio_channel_read_avail(struct iio_channel *chan,
 	if (!iio_channel_has_available(chan->channel, info))
 		return -EINVAL;
 
-	return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
-						 vals, type, length, info);
+	if (chan->indio_dev->info->read_avail)
+		return chan->indio_dev->info->read_avail(chan->indio_dev, chan->channel,
+							 vals, type, length, info);
+	return -EINVAL;
 }
 
 int iio_read_avail_channel_attribute(struct iio_channel *chan,
@@ -917,8 +921,10 @@ EXPORT_SYMBOL_GPL(iio_get_channel_type);
 static int iio_channel_write(struct iio_channel *chan, int val, int val2,
 			     enum iio_chan_info_enum info)
 {
-	return chan->indio_dev->info->write_raw(chan->indio_dev,
-						chan->channel, val, val2, info);
+	if (chan->indio_dev->info->write_raw)
+		return chan->indio_dev->info->write_raw(chan->indio_dev,
+							chan->channel, val, val2, info);
+	return -EINVAL;
 }
 
 int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,

---
base-commit: 409b6d632f5078f3ae1018b6e43c32f2e12f6736
change-id: 20240528-iio-core-fix-segfault-aa74be7eee4a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>


