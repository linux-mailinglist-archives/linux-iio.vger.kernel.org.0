Return-Path: <linux-iio+bounces-1840-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1175836533
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816A01F23AAF
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE713D388;
	Mon, 22 Jan 2024 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADEV+DxP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEA1DDC3
	for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932949; cv=none; b=HXz5bYV94IOs6j1Ky1f39JOiM6JabdziTnDxxx8vZENnLM+WtoY2UMCeNqGLO2A+TZy6oiVqaW3mb1VigbzAm99IQkvI4jvyG1eImGXI7YdcRD1C/gJAYEQIQPCxE90AwinE0bVeAnwM2V4SRR8dZvHs1zwqewjPmsjBHCcie8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932949; c=relaxed/simple;
	bh=4e5rm2lJLejuHn6//TBJuuxOnMX1H1xC4t7rcVdV4Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YpZ5MoxCxzslB7HkodBiAf+sWb9NEEA472m2Wu2rqfiUzjDj6m7PC3CzV8LwpFnu+T7M+LwG0QelcZ/p6iwBQixyQlmbeuvUC+hNLC52/w2u6Ejpvbu8gJvl5Irhvjiv7V++DPLKCrJ1woieLdeqf95hhdKMian/TheFURqG7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADEV+DxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38C08C43390;
	Mon, 22 Jan 2024 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705932949;
	bh=4e5rm2lJLejuHn6//TBJuuxOnMX1H1xC4t7rcVdV4Gc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ADEV+DxPyLVv7HIUjnGOOmRBO1QCL/sjLuBoyJiNAVBJFCkI0+Bdq9LE9DoYqZObK
	 DZVyiMYKdbbySyd6jgzGHORjtFICza5DoihzR3Bkgy8hkiGVbzUu0EjA5HY3V+Dfrk
	 Ok1zUSZgAQIiuFgKstBnHZ8Pwj8snJspyY/uNgWydPNnpDECjJBlsbbO3vLwn2AZys
	 JmdoVY6/cMLrGU8Ogn4GpAmlk3DOCvrDWbaBzJRvyRBbodu3TwXOhkgxihJvy+Cjfq
	 lVuXwC0nKdFJhggX3+4s3PgMOlg9+i0dKYx8S5+t4NXjjE3NhjocF7QNrsr9unSUyA
	 8rqwDL2SlzJVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170FBC4725D;
	Mon, 22 Jan 2024 14:15:49 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 22 Jan 2024 15:15:41 +0100
Subject: [PATCH] iio: commom: st_sensors: ensure proper DMA alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240122-dev_dma_safety_stm-v1-1-3a021614cbfb@analog.com>
X-B4-Tracking: v=1; b=H4sIAIx4rmUC/x3MTQqAIBBA4avErBPUQqGrRIjoWLPoByeikO6et
 PwW7xVgzIQMQ1Mg40VM+1ah2gbC4rcZBcVq0FL3UmktIl4urt6xT3g+js9VBCuVMbZLPQao4ZE
 x0f1Px+l9P0UNhMdkAAAA
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Denis Ciocca <denis.ciocca@st.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705932947; l=1249;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=9nc0+XuBHPSAJAnQqlzH9FoKWs6rxhh6XjIELsbUJ8k=;
 b=XkTCa2kD81PCT+5L9/nqtyL6c8/7wjsk3pgUGHQbVGGLvtudi/0zBwePsZ3f2i8S3xWvnh9jg
 LZTeCBTwsMjDJ5ecxSwGTVSZz0/NmxwaKL3OU5jUqEB+DLsLSyvM7RE
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Aligning the buffer to the L1 cache is not sufficient in some platforms
as they might have larger cacheline sizes for caches after L1 and thus,
we can't guarantee DMA safety.

That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
for st_sensors common buffer.

[1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: e031d5f558f1 ("iio:st_sensors: remove buffer allocation at each buffer enable")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/iio/common/st_sensors.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 607c3a89a647..a02652cf4862 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -258,7 +258,7 @@ struct st_sensor_data {
 	bool hw_irq_trigger;
 	s64 hw_timestamp;
 
-	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
+	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
 
 	struct mutex odr_lock;
 };

---
base-commit: f9c0358aadcba16d04d139a5412b413eeee87afe
change-id: 20240122-dev_dma_safety_stm-c7016673f4ec
--

Thanks!
- Nuno Sá


