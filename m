Return-Path: <linux-iio+bounces-8144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43936945F63
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD211F23793
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0BF20011E;
	Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/9pe9qf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2B20010E
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608832; cv=none; b=Rlr6wET/WqT9UcWynlsJFWTut5JtwzDjzLBDJTHr+2nEp9nDFo4OhVD/oqaB9g+12Ihuc5VKt8cixp0TdzI/Eu+KJ14i2slLIMJ0InX++wSA0cqIXjd1RmrDWjRmgnwBYa9sKJGxkyKXRKVksmtZr3sN1hcNQxi7N7XPAtZxPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608832; c=relaxed/simple;
	bh=M1MIaenDjeFqdFxVMPAcbmSJNMS6m1sWab9MRs5zFrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0sH5vz/D6+zVf1hKJPV8i7stBAyJG59FHuvH8uAMhd3V+d+ZsN82IalvuKgVPwGTqe8oEBnPNo5RCM2VIek0/5bKmBlDRxST0+OzKNF2eXbtdEspjFteg2qeJS+ET9P4CNf/oq8pvDShsaDbXZl1A6z/Va/ECVFO/rhIqmad+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/9pe9qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C31CFC4AF12;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608831;
	bh=M1MIaenDjeFqdFxVMPAcbmSJNMS6m1sWab9MRs5zFrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=W/9pe9qfUcYJ9TPqTgRYWgii/hP4zYqwVG9eb3DM/GrJlH83ybvuhHJ+wKRFI3Pkj
	 G/Lr8NebJjS5FwPmmBJYlKUTi9vKVRSsiySFPqHdjoPn+z86tabZld1hDbHbcIJ/yI
	 7+Z6nHv77umo5HLiIvLr++u5WmA0dkopcFmeJQVdgK6ob+ZKG4sEVmegQUPfpelBHw
	 VvJgd/Ht8UMaNpvDGEFzetja3RnMCged2JdWB9QRDgiH+FNFhrc0XB/to5f5voEdky
	 MJnAY2aj+NoUPP3xvN6o7FmTZMDhaV+uQGbP4V3Z3H9/cBha+5IxNeqOaVKCCGE6ht
	 9bquHc/Y6MDxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAD3C3DA4A;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Aug 2024 16:27:03 +0200
Subject: [PATCH v2 5/8] iio: adc: adi-axi-adc: split axi_adc_chan_status()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-5-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=1692;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=V0ifC8BkhpqXxH/+MuvvxC8gC/RczC5y3WDjHB0pmiY=;
 b=APYikaO/jqUxR4xJ5wdlIuD5H7uWkbeMGiiXyFbxn4srU4q6/3cg7rHtyiiwTqeILeerAwpdP
 iZkTYxVOCEIA8RYIVWNhWBi3mEDaa10/qcuM7Ii21arDiZJRMLVSQE3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Add a new axi_adc_read_chan_status() helper so we get the raw register
value out of it.

This is in preparation of a future change where we really want to look
into dedicated bits of the register.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index f4cdfcca865d..442a87024e1a 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -208,12 +208,10 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
 	}
 }
 
-static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
-			       bool *error)
+static int axi_adc_read_chan_status(struct adi_axi_adc_state *st, unsigned int chan,
+				    unsigned int *status)
 {
-	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 	int ret;
-	u32 val;
 
 	guard(mutex)(&st->lock);
 	/* reset test bits by setting them */
@@ -225,7 +223,18 @@ static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
 	/* let's give enough time to validate or erroring the incoming pattern */
 	fsleep(1000);
 
-	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan), &val);
+	return regmap_read(st->regmap, ADI_AXI_ADC_REG_CHAN_STATUS(chan),
+			   status);
+}
+
+static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
+			       bool *error)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 val;
+	int ret;
+
+	ret = axi_adc_read_chan_status(st, chan, &val);
 	if (ret)
 		return ret;
 

-- 
2.45.2



