Return-Path: <linux-iio+bounces-8143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CB1945F61
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85284281B61
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E83200114;
	Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpKIV+Nh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12248200104
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608832; cv=none; b=H2X+NfPrhCEEbNY/HWD4wugsXvrlwX/qPB9d772LyUDIN6ocNYLwczpj/jSONcK8Go2ub16nmsIssUHbtD3XPTNqVvnaPsMz3X5ZXQ8IXH10YnkZ1pFwsljb/t+cGe8DR8MzUVkyqJE7R0gpS3Lc5OVR5074PKM/qnT1G2WDhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608832; c=relaxed/simple;
	bh=SBfWwwEKEbxhEP03T+hS+zyaiCVkXdIESQqdbANX59E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIjqeNIbi3n7GA0gkY0af9FMbBttSNvkU1hZgqzDpqfr67Sbc3wwYwglx2y6WE6jiBi1/JEblXHaPG9JymOHIQtL3jGEp80gXHVQ4F+v7ClsreflkSUr6OtkgTl9CXSKpVzwUReOdkbEIfY4+O6ahgE7XMFxNwnj/p/3ri6XyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpKIV+Nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B746CC4AF11;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608831;
	bh=SBfWwwEKEbxhEP03T+hS+zyaiCVkXdIESQqdbANX59E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YpKIV+NhIibIM42KmIIR+Cye/zy+CySSfJbF+o/6GMQodafw1hzGf4ar4G0UDo2U/
	 XropLOeDVAa/foK4QvZajpQfdlj91ovUxniVTxFnNmZZskValZGXM+KC1Wbh5xScQp
	 8P1i2nEuHVzo4P7CXGCwNmV70Al3SG7hfHKmJjNKJgSkpRunFMD2K7vqVS4702TsWl
	 qlXTfhElpfj6VCudY2I2VE9Di+aWyUjlq2loH34AgxL1Wod3R0H6draL1Ds7Z3tG+D
	 0q/S9aNQQa1mhy0OVdfjjnZdX8PKB/MtlIObMKTFoQiK6lvNiz01z6z2UYyBsZczqG
	 LHsjLaoq8lAcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEDCC52D72;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Aug 2024 16:27:02 +0200
Subject: [PATCH v2 4/8] iio: adc: adi-axi-adc: support modified prbs23
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-4-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=882;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=EQ5g4pJjEx9y5MLKCN3xwUb/Fi6/zxslXRaMN+MVLzQ=;
 b=j0mb6dHbN5EOar75CK9yfPLWGQhPtPzcVEPFb+edAGwsr3a3LM0k3/a1/hr2/W4xiFy0bCIcA
 PI9ucU1pRjvBN9NHhZRiz0z2GGxUFJM1ZxUhlGbpicYoFpeCtou8JU3
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Add support for configuring the prbs23 sequence.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 0a9d7433da30..f4cdfcca865d 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -199,6 +199,10 @@ static int axi_adc_test_pattern_set(struct iio_backend *back,
 		return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CHAN_CTRL_3(chan),
 					  ADI_AXI_ADC_CHAN_PN_SEL_MASK,
 					  FIELD_PREP(ADI_AXI_ADC_CHAN_PN_SEL_MASK, 0));
+	case IIO_BACKEND_ADI_PRBS_23A:
+		return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CHAN_CTRL_3(chan),
+					  ADI_AXI_ADC_CHAN_PN_SEL_MASK,
+					  FIELD_PREP(ADI_AXI_ADC_CHAN_PN_SEL_MASK, 1));
 	default:
 		return -EINVAL;
 	}

-- 
2.45.2



