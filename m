Return-Path: <linux-iio+bounces-8271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC93949052
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 15:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57461F225B7
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF891D0DDD;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di1llGDQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1801D0DCE
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949843; cv=none; b=UWwsWPk7+ZowAoOUQx2vzRkWde2xgHXSYEmYnB08BL4UHa/7YozoZSHZADLy7qL4kl+z7F33Z3D569fZUWrgYn/wsvBg/xMQdPwBTPNZ1Tcj3Ehj+NK4lyx3jzhT09gqWvaP2U4ts8F+p1EmiIrW21VTeY54noQg4H99unFDQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949843; c=relaxed/simple;
	bh=3A+fsnM2eA6XiRaYuuMCpWl/HZKVgh5Is1URSGtxg7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvLwTMfK3UADLez2ltgjLY+sNxjzbkSaBjE1dxOXrlD+RYhelso5gF75vrBlavPXrZFD0PI7xYz0+nRtj4747ZyzrO07vKI1p+wnI0qh/G5mJL51S50VgmRa4CkVtHtdKlk6WqUdDzMuh1ztrjZmgrSBoa79pFKVfUrrrAo7vtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di1llGDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46F09C4AF09;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722949843;
	bh=3A+fsnM2eA6XiRaYuuMCpWl/HZKVgh5Is1URSGtxg7I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=di1llGDQhh2I8kkU6pGuO7JKMiNU3wU8RMbeQ2gk0eWium+VtptaBAnpb6CEPNB+y
	 0G7fxFwAfdMRJezUQ9sh4HQb6L6s+hBMP7bR1oKwJo3Q883OGbNKlaVGOT1wB0X7OA
	 qS9umgHiY2Qeo/sgMyJAI42GJTVev8G7ZpKdJmmbnoEgWNuFrt5Bv9+6VASFVJjZVS
	 wWwuw6havqdc+uAUqB0HRN3MS+TWVe/xdUUazSSBRPCqIQORlzIvreuL/MSxYTzz5Y
	 T6mMfMexSCNDqzC+2AnN9+IRnSh95H5Xiw0DsEZvWlplthP1PU0+lC+LORoEtislKN
	 e11KSfKWncMCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C83C52D73;
	Tue,  6 Aug 2024 13:10:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 06 Aug 2024 15:10:40 +0200
Subject: [PATCH 2/2] ABI: debugfs-iio-ad9467: document the debugfs
 interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-dev-ad-debugfs-doc-v1-2-153b882a3f01@analog.com>
References: <20240806-dev-ad-debugfs-doc-v1-0-153b882a3f01@analog.com>
In-Reply-To: <20240806-dev-ad-debugfs-doc-v1-0-153b882a3f01@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722949842; l=2199;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=aJKe8f0BemREu/qLk6HbULLoyWom7koS7AvKrSH6W5s=;
 b=n8a62MGDGOgydg//SkXZSt9dVk+ZFTiotI05PbndAky6+X3cngiM0ztzIVmwL1L/0jIc7a8Li
 pD4NghPo1emCXtggD3Wa40NhWDQsI5r7QhMkpb/YHLFiRHPVqA0pK/I
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Document the debugfs interface for the IIO ad9467 high speed ADC.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/ABI/testing/debugfs-iio-ad9467 | 39 ++++++++++++++++++++++++++++
 MAINTAINERS                                  |  1 +
 2 files changed, 40 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-iio-ad9467 b/Documentation/ABI/testing/debugfs-iio-ad9467
new file mode 100644
index 000000000000..0352fca1f7f2
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-iio-ad9467
@@ -0,0 +1,39 @@
+What:		/sys/kernel/debug/iio/iio:deviceX/calibration_table_dump
+KernelVersion:	6.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This dumps the calibration table that was filled during the
+		digital interface tuning process.
+
+What:		/sys/kernel/debug/iio/iio:deviceX/in_voltage_test_mode_available
+KernelVersion:	6.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List all the available test tones:
+		- off
+		- midscale_short
+		- pos_fullscale
+		- neg_fullscale
+		- checkerboard
+		- prbs23
+		- prbs9
+		- one_zero_toggle
+		- user
+		- bit_toggle
+		- sync
+		- one_bit_high
+		- mixed_bit_frequency
+		- ramp
+
+		Note that depending on the actual device being used, some of the
+		above might not be available (and they won't be listed when
+		reading the file).
+
+What:		/sys/kernel/debug/iio/iio:deviceX/in_voltageY_test_mode
+KernelVersion:	6.11
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Writing to this file will initiate one of available test tone on
+		channel Y. Reading it, shows which test is running. In cases
+		where an IIO backend is available and supports the test tone,
+		additional information about the data correctness is given.
diff --git a/MAINTAINERS b/MAINTAINERS
index ff62a4c2ce9e..417c6751c0dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1316,6 +1316,7 @@ M:	Nuno Sa <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/ABI/testing/debugfs-iio-ad9467
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
 F:	drivers/iio/adc/ad9467.c
 

-- 
2.45.2



