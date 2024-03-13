Return-Path: <linux-iio+bounces-3476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7589C87AAD0
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 16:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119BC1F2257C
	for <lists+linux-iio@lfdr.de>; Wed, 13 Mar 2024 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6797747A7C;
	Wed, 13 Mar 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idEHHaCS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79D647773
	for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345460; cv=none; b=F0hAeI02YHkoqIUftXju5N+OvqV1yrl2Zmo9sisZ3xVhmIe7TVMixYBOmWxHtyVA4CbcBn8oovwWPRi67wfyb2dSmihAkPKLn73dJhdkuzSoiHJnGLpqlUSLs6pt/yheqIxBE5Tuw3rYyQETrXSnoxmv62WzDW3JvhBNpOc8/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345460; c=relaxed/simple;
	bh=BPArv5NoUX8Fj5BRtzyZFuNDzAw3ImSQ0YAT0ihV+L8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P/HiMRql5oXPPDFWjor6m7vDmmRCHoDTAKf6aOUN8rBzpm25FvIIhB365oeD+ufIam4kaQG9txgh9SSmzVobY6rYUoQyaCzhOCh8EUlC/MBcMrhyrjJLNyDuxyRhLUZJYJHjIHj5SnhFefRkguhv+9xR4sl42ERHdylWEK5igf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idEHHaCS; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d40937216aso457756e0c.0
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2024 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710345457; x=1710950257; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mT+/uAxLp21QUk7m+YOp+tT8W7eg2pTjaL+cu+34HY8=;
        b=idEHHaCSK67mVxK3JmmxPkAs2MBgtf7hTgmFw5dtooAAGPYTkfDz8l8BBnz+raB4cY
         tx5/AXdNynvbXn3Za5HUe07t9bUkljL9opFxoIIgAHkdIUou0zBGUMnsujIzG95qsC41
         4oY3dpK8+yQGIk9qEgmxqg8qjmudUgp4z1BMGXs1YD4LeKn5ojDugSmQhJgPVu5x8mtl
         NmUSkGD2pzLzBm03oJekA8Lf0eX03yQXoe1ielByYCgGSpyeGKGKTeNKW8PNikpyxnYR
         pIozCbzTwra67PgN/PKP8heKzdbKKyFSX2TSzmPK9RCAkilFbnA7TBf9SYQoVLYUaJcP
         Bz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710345457; x=1710950257;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mT+/uAxLp21QUk7m+YOp+tT8W7eg2pTjaL+cu+34HY8=;
        b=b34ZcDs4Kidg2C/QGLMnkLHUhQ54pnsceXhnSJS+yNGuDqyjjQtNzeyyvF7n+99sGh
         KuovBOuyck63w+fPFWbX8ebKhGSvOMnlZ8lXv7RM1s5Dvkzb7r/6kFg/mabsJlIWz4ZP
         cMFC8C47Zrj4PZ7obEDwoIJQINgF5WSFtP2d4ugKXfeBgbTJs7zTK20hMX1i2ujnQf9I
         QuDJe4K86q5DIgjhdqQoWGxTIzWxN4tEaiPeZK13DUDNTN14cUFufUrxkvmtwdY1853Y
         jS2PPE5iEP95LFd9Dk7wM/zbpdKLj3Iyd6w0/DQBtFPUnFNEL+xTk562/Bbpk1jz5fQS
         LEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX30eqBpGgsi+RRy1bsCewzEHfNVSW4ShMkpaQ60uPtA12h8CYXPz/poG7yDRt850LQmoAiLhHziqFYuMEbqxV+PwYHtaZJCYtT
X-Gm-Message-State: AOJu0YwDcWeT0ds5tusB1Qx9dFbFKE9ekuJQhRvkByyGG4ZdAF3rAxNL
	b9JNXHChOoe7SEFIrLfaB0jSoJftxuN2kXk3MGyXHV+PbRIpniwKzJXQYVA=
X-Google-Smtp-Source: AGHT+IF/7H2kGvkJuSWoFwma5TzEMBIk+8oghnUWQY7Z5TrHdFL8acXC/ctOjGAqQDIjEgBgYiXRtw==
X-Received: by 2002:a05:6122:4319:b0:4c9:f704:38c with SMTP id cp25-20020a056122431900b004c9f704038cmr415279vkb.11.1710345457531;
        Wed, 13 Mar 2024 08:57:37 -0700 (PDT)
Received: from cy-server ([2620:0:e00:550a:a7c7:98c0:f322:31b])
        by smtp.gmail.com with ESMTPSA id n13-20020a0cfbcd000000b00690bb839b5bsm4855086qvp.135.2024.03.13.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:57:37 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:57:35 -0500
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: mazziesaccount@gmail.com, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Message-ID: <ZfHM73ZqgnCp6CZv@cy-server>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The sorting in iio_gts_build_avail_time_table is not working as intended.
It could result in an out-of-bounds access when the time is zero.

Here are more details:

1. When the gts->itime_table[i].time_us is zero, e.g., the time
sequence is `3, 0, 1`, the inner for-loop will not terminate and do
out-of-bound writes. This is because once `times[j] > new`, the value
`new` will be added in the current position and the `times[j]` will be
moved to `j+1` position, which makes the if-condition always hold.
Meanwhile, idx will be added one, making the loop keep running without
termination and out-of-bound write.
2. If none of the gts->itime_table[i].time_us is zero, the elements
will just be copied without being sorted as described in the comment
"Sort times from all tables to one and remove duplicates".

For more details, please refer to https://lore.kernel.org/all/6dd0d822-046c-4dd2-9532-79d7ab96ec05@gmail.com.

Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 38416c28e16890b52fdd5eb73479299ec3f062f3 ("iio: light: Add gain-time-scale helpers")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 7653261d2dc2..61714a8d5717 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -375,7 +375,7 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
 	for (i = gts->num_itime - 1; i >= 0; i--) {
 		int new = gts->itime_table[i].time_us;
 
-		if (times[idx] < new) {
+		if (idx == 0 || times[idx - 1] < new) {
 			times[idx++] = new;
 			continue;
 		}
@@ -385,9 +385,10 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
 				memmove(&times[j + 1], &times[j],
 					(idx - j) * sizeof(int));
 				times[j] = new;
-				idx++;
+				break;
 			}
 		}
+		idx++;
 	}
 
 	/* create a list of times formatted as list of IIO_VAL_INT_PLUS_MICRO */


