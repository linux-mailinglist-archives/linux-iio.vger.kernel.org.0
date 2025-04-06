Return-Path: <linux-iio+bounces-17691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E43A7CF1C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 19:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD325188D612
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1A17A306;
	Sun,  6 Apr 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJGUFkXa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3041487F6
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743960026; cv=none; b=C8MkJygvYp95/G1KRXVnzu2DfZcW/AkPyRZ25kJc3hvpRozaVZJUjQCGvH4TiN6OOuO3oc4A6VvcnwywSrRJN5XQ2I5TIIXEX+WokGDxFdVnvmSiK/lyYsKgpwfHwYmmcSNl7cNBESHWtu8drkF6g85VKy7f7d2C8a5uxoGFEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743960026; c=relaxed/simple;
	bh=1D1Wx0khjbmdz2WHj7erW3C12LGblykqws+vP1NgRJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7ngnjf3XwDNzl3/ibxfmF2WACOoRfl7JH9xdONPJ+Tq3IYqx+1uyKQ8xg0pXjgtyj5s2w8E6j9cPIaG5l3rxyJyYyIR5D1WJ3+mw0zWUExhrr8UB6FIVTBkXMNwOg+OhKW0zkXoKzQ3sO4qBkGDmZf9C5KLnzGZP+fZGKnab7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJGUFkXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B1DC4CEE3;
	Sun,  6 Apr 2025 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743960025;
	bh=1D1Wx0khjbmdz2WHj7erW3C12LGblykqws+vP1NgRJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KJGUFkXalYyun/sroIDwZBy0q3aFpP/g/z+bG69mH4rZsPYFwBIOgyQ4bSyu5rPP8
	 2x1CUhnktROlgqAeUZtHMGSw5sg1N1QSKC7tu2dPnUW25s8rPYfTAOucSWAwsU9CEd
	 /FeIQm92yl+evomi9P0tTa1EI4v2jK3tAd1rKQdl82YCJgxx6BE5LANSLVTcindugR
	 roVcbtSDIQRnz+3Xu9u4xOk5F0quXiGFsvZdqZtWmJtMF+e0D5Q+dXMdFFVrBZIfkE
	 jhuFbsBvm1NxWGcQiC4KkBuM5hyZnUCq/cptfwlco5NaBNWCE60xQx58XY/gQUhVpw
	 6Aw7/UieuijhQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 03/20] iio: adc: dln2: Use aligned_s64 for timestamp
Date: Sun,  6 Apr 2025 18:19:44 +0100
Message-ID: <20250406172001.2167607-4-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406172001.2167607-1-jic23@kernel.org>
References: <20250406172001.2167607-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Here the lack of marking allows the overall structure to not be
sufficiently aligned resulting in misplacement of the timestamp
in iio_push_to_buffers_with_timestamp(). Use aligned_s64 to
force the alignment on all architectures.

Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/dln2-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index a1e48a756a7b..359e26e3f5bc 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -466,7 +466,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct {
 		__le16 values[DLN2_ADC_MAX_CHANNELS];
-		int64_t timestamp_space;
+		aligned_s64 timestamp_space;
 	} data;
 	struct dln2_adc_get_all_vals dev_data;
 	struct dln2_adc *dln2 = iio_priv(indio_dev);
-- 
2.49.0


