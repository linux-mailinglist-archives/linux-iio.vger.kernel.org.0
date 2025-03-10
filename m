Return-Path: <linux-iio+bounces-16677-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF92A59781
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 15:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C862188DEAF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA3E22C336;
	Mon, 10 Mar 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="dty+Ss8l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AF22157A
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741616720; cv=none; b=EBuTJCVbgc1Thc/A4CYq5TOPyW93Ti1fxFfizIeKulbCEtfWp9aUjbEKaFBphrYtY1lt+BuMxQviW2ISCcJ8zPItoFAF0xb5zsfeiMm9LQDhM55huwOdD+LoG1LjU3XTuiQR6UsbJNpNC91ZCHTzlvR0ItDeeOiGWI5kEJ8NWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741616720; c=relaxed/simple;
	bh=RvgBhmSVcfRiCq0Lux2A/AMSwo9aNXNH4wQ3F3+UYNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfZgkW1O3mB4Popi072b658m7F92RWgD0tDHIVoQyGYqyZcPST758MyM0QDD7htzo78mRwiSyzE5LE3B3hKrI+aNDAO572VGViT73tdEPWIFAW6UgCasdYhak07hAPy9HB8pPRkCv2XCD0tGnx3NBkbFoLwGb3OSQ/kmWy9XdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=dty+Ss8l; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39140bd6317so1192448f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741616714; x=1742221514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kW/pm4MavsZmqqFiY6ttCOniK97oiQCgMeDYqCM9/LI=;
        b=dty+Ss8lPPcfuPySSV6m8vpXVLdwP+T42El5fBz7sq6c/PP2qm658I6OgyuW1pYlMY
         ZUEriS3Jmeaj0zONyY6K0vwr3WJm/YWPTaDGnep9i3S0j3TFUDmHNSj6pW0pcMZViCkV
         jsWThC3KGKtpAkZ4BU8KhwhfpFYEPAVBBGhls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741616714; x=1742221514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kW/pm4MavsZmqqFiY6ttCOniK97oiQCgMeDYqCM9/LI=;
        b=axBofzss/75RHJ4BKPq+IEt5AZcQOaxU/90jJ40vX0KQAWKCOJ0EXzA2uEwsso8Jgh
         Pj4/MA+UXzgKc9YT6MB7+M/e2nx7n/5+TLbq9qEQf//gwq3GMrQi0m77V9sQeBRQwTyr
         KqCXheYHqqLYe2s2fMrYK2zYtqbKfN3tluITDjOg5nLFG8mhQkoK/vTBANq0ejz+DLl+
         Jp9ZV9EHmP5fKnDlkLfex7PxRAQAPfljXnU+oFEGuR0L+/I2p+MT/ySpHjCwV3VJiGsp
         OJ6vjApou2doG1ePwqOukRL9NywdUQRf4qaWTaYvw4VacQELjwi34f5P6fmyha1FpFqt
         9dEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD9PFzN92wted/oqsLZUjysaKFbFd3Xz+Hi7s9gA3IU9iJjmi+FkQg4LrIEQ4w7iCgGbQQDme12rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKL1Gv8xuOt69U8NhBNkPXnx6iADhDHEOX5B5I37Arc01G7TN
	iljZvsEnPEAETGpYwoa/5NBCGGW9vKCf4Vb9l9yQeT0s0+N+0sbcZWXJO6XG1w==
X-Gm-Gg: ASbGncuwH2T952scMrPr1m58EVc/GIOfoqEOlFfSqRZvchk3FD2CgDPvoYmZtKHq/4g
	PGPzA/BWxJUZzFMMNuuMGQZZWpDGIYNGrQrqN3HlnMhiz7yrgCf3cCGE/30wyHu+ZTPpQkYhmV2
	DUQosIPSq9KPsPvKk0EbcJOaXRKpUsqfFSorl65zCj+requtk4KjnQGxRpy4HYhUixvw5aNH9Fc
	VpuVsJsCT4Zd+BTQRWfUdFmWG/GL5rPTS0IwqBu2Iu1AXavupK/NGMPojI31sNU+6VzZQEHl80S
	+I6G/bLxWwcADUakMxZ/QkQ4yEFE/jhhWdF+9mDTVcF+rcA1GfomZe9ZhZYCA/ZvI5YjV70zQug
	iQHmMR1Y=
X-Google-Smtp-Source: AGHT+IHVGeWNFLhTxxSByXr4IsPKYCfOogvrHznEpaw7DcTPiThSqxKiTivX5c0n9iRBv6Rs9+WbZQ==
X-Received: by 2002:a05:6000:4103:b0:391:39fb:59b4 with SMTP id ffacd0b85a97d-39139fb5e40mr5830285f8f.27.1741616713993;
        Mon, 10 Mar 2025 07:25:13 -0700 (PDT)
Received: from marvin.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm15395492f8f.53.2025.03.10.07.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:25:13 -0700 (PDT)
From: Silvano Seva <s.seva@4sigma.it>
To: lorenzo@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
Date: Mon, 10 Mar 2025 15:19:17 +0100
Message-ID: <20250310142501.29535-1-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
from falling in an infinite loop in case pattern_len is equal to zero and
the device FIFO is not empty.

Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
Signed-off-by: Silvano Seva <s.seva@4sigma.it>
---

Changes since v1:
* st_lsm6dsx_read_fifo: moved check for zero pattern_len before fifo_len assignment
* st_lsm6dsx_read_fifo: dropped check for zero fifo_len
* added Fixes tags in commit message

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..8a9d2593576a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -392,6 +392,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
@@ -623,6 +626,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
-- 
2.48.1


