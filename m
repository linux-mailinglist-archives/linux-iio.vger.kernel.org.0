Return-Path: <linux-iio+bounces-9888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E5989681
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 19:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC782848B5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52753225D7;
	Sun, 29 Sep 2024 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQW11nqa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F22231C
	for <linux-iio@vger.kernel.org>; Sun, 29 Sep 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630479; cv=none; b=ku4m4K+EJUX9yMwKj8eiiTDE7GzTGnkdnA6d9wqGTTwi++t/76/Yh8nxtyCYQg0kadA5p7yYWtY1S12nPZfyJsX5PvddnLb2aLB/X1ihl4qF5V7fzxgHqVUL1/F5Ei49ZYFsslG/BBQb9SnM8UmvrTx/jrgu3qgjgWtg95pRlAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630479; c=relaxed/simple;
	bh=/pL+B7zuKTXKfgz0ewVnClg0iCFv5ahq7ZGkCtlBy78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aL9l6kSOo1Nzi8wY3LQYJoiX6N47XW4jl91HWbwX99qh89MiLTctDx9K1v+ZFPck31295jNVRRUuq1gvokEu0MPLFwBaU4dXAfUoV+662u69WL4aYGw7jiq06jy3Vt4OjBXeRby4G1sN8DOoDetIgkgEHrZGgplEZR9Qs0HFvpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQW11nqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953BCC4CEC5;
	Sun, 29 Sep 2024 17:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727630478;
	bh=/pL+B7zuKTXKfgz0ewVnClg0iCFv5ahq7ZGkCtlBy78=;
	h=From:To:Cc:Subject:Date:From;
	b=uQW11nqa8FNyWySrdMKnlVR0wBPQEu0HL0UYRLXwgprnPFhLHqzVU1/UGb9UE6gxs
	 wG9lccZz2XweNkCinmB+gj88VCs7tK5Fq/i5Xkep2md1dxVWapZqikKVzlvhxmfGsA
	 rN3NXM9Cn1e0Xtix/CbrX6AtljTFpbWTSl4+sRfrv5gMTbEfdChyzsUrd5sRYOoCwR
	 AP4hkdqikLVOSIs1WfuUHU4QpGZDklCI8oEvVkfpAXiQCVBp1VCYYf/7brnjuvT764
	 W3JtUdq8WuXCJecgknrLbJ1HkOWhZthyaEuXAd4N9J2ZHecceDyk0Hh149I4knzBoO
	 StZOiEjCfyw5A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Petar Stoykov <pd.pstoykov@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: pressure: sdp500: Add missing select CRC8
Date: Sun, 29 Sep 2024 18:21:05 +0100
Message-ID: <20240929172105.1819259-1-jic23@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fix:
   sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_probe':
>> drivers/iio/pressure/sdp500.c:130:(.text+0xe8): undefined reference to `crc8_populate_msb'
   sh4-linux-ld: drivers/iio/pressure/sdp500.o: in function `sdp500_read_raw':
>> drivers/iio/pressure/sdp500.c:74:(.text+0x200): undefined reference to `crc8'

by adding missing select.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409271341.0dhpXk7G-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index ce369dbb17fc..df65438c771e 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -253,6 +253,7 @@ config MS5637
 config SDP500
 	tristate "Sensirion SDP500 differential pressure sensor I2C driver"
 	depends on I2C
+	select CRC8
 	help
 	  Say Y here to build support for Sensirion SDP500 differential pressure
 	  sensor I2C driver.
-- 
2.46.2


