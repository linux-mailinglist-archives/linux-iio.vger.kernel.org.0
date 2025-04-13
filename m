Return-Path: <linux-iio+bounces-18047-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46FA8718B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECCB3AF503
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A097199FAB;
	Sun, 13 Apr 2025 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeWyWf2a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD22AD3E
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744540503; cv=none; b=hOd32RxDaT+oBT2DDXbBwF3YMmEua7kt3By/nU1QvvSSjrFEbrNYP+gWR7A9CT8wLUkqPmXo7i5tRhmtSDGHChuOSzMQR9rn+iFaGkiz6iOmRxFPC9B1+PI1fSEoJJ68JXFAn4qng80qjuGlDPyD7uxL04YLBgR7yGrs/+RdE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744540503; c=relaxed/simple;
	bh=sAaG4defa1B+hGxK3KsmnOZtHKqZuDffagtj/moxLEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0NRbtmPHLhNYvH63Krn2AnoBrhq2JjgtK38ekT2r1D9lIo05Oe/09z5pkJqTz3P+ENVX1l5ib2V19JgfEezNLqKTVbahYRijBGfjaV4ZaJAQhtfU1D84+biEv90pA01ooUJVhwoEdfDnu5plM6FS3DyqVKqUg0f0IFOBsvN6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeWyWf2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4395AC4CEEA;
	Sun, 13 Apr 2025 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744540502;
	bh=sAaG4defa1B+hGxK3KsmnOZtHKqZuDffagtj/moxLEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeWyWf2as5xkeZDiqCzCV9iC+TWQMyJnJG9fmqmBWbzN1Y6afH1g2gnNnVBjs1h08
	 c3VH1F9u2+i1SQ6P6xG+Y5Wx49GkDm1FgosZLLlV3XbvUASFEhADZMFF5+YzB9nSSv
	 aQ5otkuz0K4HPM38piFaOjOU29DgduM0HQEyfidIh4u5rUNK3T1MxeJ68Af6EUs7CY
	 hZ/eNrsFtiERXpHCPS0sNxCFVWRyOJZE5/C1j31Pv43N04VqnlQ1OJdloG0B3QQNQZ
	 cDUFT7o85ETobC6oGB5GDpWnoSu2cpf/fgTk77LLjYlu1cT0ALrUIVhsHb8U2MCTZN
	 lRqtVivHwfqIA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 03/20] iio: adc: dln2: Use aligned_s64 for timestamp
Date: Sun, 13 Apr 2025 11:34:26 +0100
Message-ID: <20250413103443.2420727-4-jic23@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413103443.2420727-1-jic23@kernel.org>
References: <20250413103443.2420727-1-jic23@kernel.org>
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>
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


