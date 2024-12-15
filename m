Return-Path: <linux-iio+bounces-13506-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13D9F2549
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 19:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61EC163D40
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27A1B4F09;
	Sun, 15 Dec 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrrL2fIq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E513C8FF
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734287373; cv=none; b=iVPqxw09n54LTeSo2iFFnAawmWhSPcWpaOhoqHXbhRA93pgqzREa5TCdBGSHpJO4al46xlkRe4eqOlDuIHFwbfhfwGXOqVll0udxJKxujjZVB1famCb5WT+Q8Iapq/TFmT2N3aaoEhaAEDFnxfCscf2scrAhDGmNOzX0c8OOtcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734287373; c=relaxed/simple;
	bh=srMjROyKEUkASEaY4+Hspwa+SL2XyaFApsZ9uHmC964=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vprh2ubDfDsoA7Nx6L7/erkpsen6jzFqcrnSCwbFA9P6dfFgV9D58l1aJMGNowSS1dzRX7Yxf4H1fU6sV8qwmx+NvCcWprQO6NRSFsNi6V1HPvgGOVGPExAeWJL5fvfdMezXbKygfLrf0OqZqeo84GkIsb+nawJT/smwHyNvbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrrL2fIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D2DC4CED3;
	Sun, 15 Dec 2024 18:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734287373;
	bh=srMjROyKEUkASEaY4+Hspwa+SL2XyaFApsZ9uHmC964=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NrrL2fIqtNyB40A/0ZeObBzQS5UpY1o+dPomucVVi49XiEli25j5wKP/OH6YSonBv
	 akiMu1TNF5gp7ewyyQ6Nmu+4nSBCFRHxE9paPnUJenf+R9lyY7XqU0xziQ+W722aEY
	 nxi3zU8blGhS3brsYkphZEsYQdgKmVFWDWlDxVMT7QapbKnGvKh8xm2VhFeusmiEj7
	 vMawdTcl0NEk6MC36ftehSokVUs34nVlhW+RQ2i8Mx+9/sYRhlpM7sffWHZtRBnM1U
	 QrA/IaIn0qL5UPvoxVEE5c/BpYdEDTJ5t8PheuQ2c8maqgJxxps3+TpXWfmAYFK0Ys
	 ULTO2hkWsqLWg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/20] iio: adc: ad7944: Fix sign and use aligned_s64 for timestamp.
Date: Sun, 15 Dec 2024 18:28:52 +0000
Message-ID: <20241215182912.481706-2-jic23@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241215182912.481706-1-jic23@kernel.org>
References: <20241215182912.481706-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst it doesn't actually make any difference because the code
that fills this field doesn't care, timestamps are all signed.
Use the new aligned_s64 instead of open coding alignment to avoid
confusing static analyzers and give slightly cleaner code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7944.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index a5aea4e9f1a7..0ec9cda10f5f 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -75,7 +75,7 @@ struct ad7944_adc {
 			u16 u16;
 			u32 u32;
 		} raw;
-		u64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	 } sample __aligned(IIO_DMA_MINALIGN);
 };
 
-- 
2.47.1


