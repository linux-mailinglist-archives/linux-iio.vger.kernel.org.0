Return-Path: <linux-iio+bounces-17188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0931AA6C431
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 21:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7B01891817
	for <lists+linux-iio@lfdr.de>; Fri, 21 Mar 2025 20:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA67233134;
	Fri, 21 Mar 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EmqRGcaN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF3231C9F
	for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589012; cv=none; b=mCNS0rJ2AN5hZndGHqt1pMzT6MU+nJD3Hh1Z8epA2O0NmtDjelNqsZWze55SjY7bI9n38Am2QsgeiAOJNii8WXTYVuoUuHRwpI9nfQ7gGct1I7QK5Q1xC+7+JbZrUS6mtd8VYurpQLk5u8hH0V9/nGkUQVCTwxOgdO9bbl80mWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589012; c=relaxed/simple;
	bh=v4x4imsy5YbeHXwQ1xMUyqRuJG1xvnmjMKbMtujlpgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e+m7mkSRKMwnUh1NyAiQwlYQ5qrxQlkIVzE7k7NTJxeL4rHNiC/mxOjb4DpQHkrzaHJk4y6DGOdwrBZNaFAB/P10b/pz625PfVMrgBQHDqCPH9fnZmxaKgd3S16g1PBn6I4TyDxDbaoAZW1tRJMK6pNDmkmGgbm0GsWrDVY66j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EmqRGcaN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913cf69784so1968718f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Mar 2025 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742589009; x=1743193809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eD3Dwg/bosoHeBveeP0hmUHF2AuEcJYQ+8dX6IEYkU=;
        b=EmqRGcaN09z1fnbzxCHLqoEAFqstLrW4cMfGTBzpr25pRDZheRRB+HdkctrAID+Qnz
         iYnceBbqlfRpvdig78rOrF1TjRnji5C70c8UX8SsRmbTL/tjsl0C2Www30K2Mi6GQ5+U
         a8t5hHuKpcJo0Cty3PHnB5TkfLjX3fpie2wZZWlIs/TWQ5T4/BXCX3E0FvaVwmRpGURE
         D3YxQNCBHdoe6sqFrY4izU0ldj0j+vMf5StXabp4ir6ZBGQlNZTFjRhoHd5GTWVOcTSh
         1pVu55yI5HAfQ01eR/5Ac/8eqjr5sDjCVruO1RLigFlgiFHdCKAVyI7Ilola/PjVM8sj
         VUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589009; x=1743193809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eD3Dwg/bosoHeBveeP0hmUHF2AuEcJYQ+8dX6IEYkU=;
        b=rA5Uuio/LuGxCLqM2ZdAQSwmLiMFOgCRxFq225MfxiubVyxZWPeaEQgUSxu7z7F0Je
         /W7bPbKhT0D0CYRXE9a20a3TkcCvRoG6wLrHi29wF0Biv0lO1tiMCiivJIjZYLbddyDe
         ZvJOKDpczlTLPreTC044Y5YGjSoqszf9ap8Lt51j4gafboyL7SyKG9+UQCv3U2HhJ/Xx
         aOvWq5IQcETlJv6TpBLE4rZXpiPHdwdSBl38Fpe41aBcgGgFz6sYSF7NWrqAKr3WIxEY
         lEaeWFcrs7OVlUvA2gnB32kf03op4Tea/yj6q0hMMTtDx9FNkpjcR4mEdaj8agdLWIiO
         7kOQ==
X-Gm-Message-State: AOJu0YyFFoJzGCJlId4EBVDRm473RFSXgSlwNEau5ODUUnhzpGN+n8Kk
	lJ5UinwyAsZC5iGSgEwvZ93OTA0swcAILdLHXBI33mP+M+QfmPDcNsAmGRaynnw=
X-Gm-Gg: ASbGncu7l7NkxMkprtW1jCNKNVjteZFNpwRqek87+6yQ534UOYOqnoq5N6IINogSrzC
	oqEQCm1QA81VR7VoBxZ53YJSn/gQtfHnPP3kiQcd8qjayW/Suwhlr94L22sAzSqR0gxXoUc6LHT
	Rv7qgz1bRWFLUCNIfbyrp5MHw4635cHv9C4v/XpQj1jRCPV+8SNtrSgnfzMGwN1URkQ5pIRRGR3
	oY2lYkYh4SIaIp+evhNwnaAT5ytXDcAvKzU569vv0upbFQa8mJvq1OMiP2oBi9uOiWLQMg4fk1r
	rvvU3254/5paE/tQKNZRzNReGplZ+P4Rv/bj4KV8OqG7gea9UM5bM9NPqxETAKNQETcBYt4LKW9
	5cdc75nTqvUMCSA==
X-Google-Smtp-Source: AGHT+IELd83dYCLpu4krqWNQj9A+sofZQSmerqTYYZH1bItX2o5eghXCKYp/HNm41o+hSItzK0uPeQ==
X-Received: by 2002:a5d:5f92:0:b0:391:212:459a with SMTP id ffacd0b85a97d-3997f90ff74mr4849355f8f.22.1742589008556;
        Fri, 21 Mar 2025 13:30:08 -0700 (PDT)
Received: from [127.0.1.1] (host-87-8-62-49.retail.telecomitalia.it. [87.8.62.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9955c0sm3258380f8f.3.2025.03.21.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:30:07 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 21 Mar 2025 21:28:50 +0100
Subject: [PATCH 3/4] iio: dac: adi-axi-dac: add data source get
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-wip-bl-ad3552r-fixes-v1-3-3c1aa249d163@baylibre.com>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add data source getter.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 892d770aec69c4259de777058801c9ab33c79923..a6abd828ebdb34800cc08a2151e52a9acda9eba1 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -514,6 +514,32 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
 	}
 }
 
+static int axi_dac_data_source_get(struct iio_backend *back, unsigned int chan,
+				   enum iio_backend_data_source *data)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret;
+	u32 val;
+
+	ret = regmap_read(st->regmap, AXI_DAC_CHAN_CNTRL_7_REG(chan), &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case AXI_DAC_DATA_INTERNAL_TONE:
+		*data = IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE;
+		return 0;
+	case AXI_DAC_DATA_DMA:
+		*data = IIO_BACKEND_EXTERNAL;
+		return 0;
+	case AXI_DAC_DATA_INTERNAL_RAMP_16BIT:
+		*data = IIO_BACKEND_INTERNAL_RAMP_16BIT;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
 				   u64 sample_rate)
 {
@@ -794,6 +820,7 @@ static const struct iio_backend_ops axi_ad3552r_ops = {
 	.request_buffer = axi_dac_request_buffer,
 	.free_buffer = axi_dac_free_buffer,
 	.data_source_set = axi_dac_data_source_set,
+	.data_source_get = axi_dac_data_source_get,
 	.ddr_enable = axi_dac_ddr_enable,
 	.ddr_disable = axi_dac_ddr_disable,
 	.data_stream_enable = axi_dac_data_stream_enable,

-- 
2.49.0


