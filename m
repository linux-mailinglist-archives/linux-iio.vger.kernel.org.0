Return-Path: <linux-iio+bounces-14089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B92A08DE4
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4EA3A653A
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696A820C005;
	Fri, 10 Jan 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CiePnfjm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E520B1EC
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504753; cv=none; b=rzManCAXNF0O1IC+gHjKE0nBfJBECVb0+BnR0yG1SoSLgUCoEm+s9l2S9SzVGm8uRD8Ha0lX3twV+VVEmN40+GyBKaFHU637jH3UqAHtI2HF6lbWUDUm5eDfrYXhELx2jo+Hyb9Le6+UK+bcZJOPogUbhx9b67iGYpBMXNzMe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504753; c=relaxed/simple;
	bh=pJ/8SnERbBF2D7kFoBgho5WN/rZlNOVicoi4/vwnVhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iywtVs/pQrXziX5HFVSdRmcOo/ytbSu7e0GZXEVpiGxEbmlDeRxhQf0hfIDEbYryAPY1FsJKnVzab+gfTe4WZCh2bo6EJuhgP5Wo2uW5wN9UwhxLz9V3wW8M+LyfpiURyBLDQUnObNyzoZSyemu4lTFb0+wv56gxyszEIscPANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CiePnfjm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862f32a33eso859425f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504749; x=1737109549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzGFXpuMS6bd9jRjpgjdc1eSoCWcqwcy2tSSy+G0v9g=;
        b=CiePnfjmXBlsi3uz1h8ADe0hphBU+XVq6p5oJ/CCowW11MXCj6Lr/lIcT0Zfh4+WRe
         VouscVAloQFmMQdiHmiqgBvPlySVYXT7lnBJUi8L3hCtyWg3lvbAK6tT1GfEeCvZN22U
         hHkjqB7qayWMeDd+KNr24Ygxf49rrV7yy2aMOEyezzsyp72Jr6oF/BG9ZY6phMgwpSu2
         TRzOElxot/od8LH6Vr8ep4/nXaGWb0cxE2t3jRY3Uaa1TSc5ZzCCQPwc+Or/gfCKcq4S
         jP6Bwvl0wA8wcmInQzid1oVw5/YdSJqNhodDj60OJ4Zn6aNrPb+IEx15F29Ml5PZfM78
         EtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504749; x=1737109549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzGFXpuMS6bd9jRjpgjdc1eSoCWcqwcy2tSSy+G0v9g=;
        b=ZojdAo+woLImx7HVn6+0wzNMzLkGD5+EeEb9IUdnlmsTUtekuY2XqxXvPBWaWvh5Tm
         PG1aayAYH3G+D8CNziXHM5BPtXxodtGQfTXyctHIIlJo7COa4N8nLmOGAGpkoz1Mzklz
         lnE/yg/Cu7DvDgWhG2B28FNyyBC7JCeIkSP52gUTD6wstLvfZYtBGSbenFRsuQi0s6EN
         ET4MapAiQa3Dn4xuxgPAN/V5ZPV41AbwKdpgap+JGaTaD3N9316EhQA0WhGLmVX/dzkw
         sQiht9qGw5IIucT8dRwWmceRkz1+dgo19MBL8oaxRsJRHnd/LFasxBgycnkJowz3gKCc
         KZXA==
X-Forwarded-Encrypted: i=1; AJvYcCUYtTG97OktLny5PmAPJ8cekZZQIPw4RkwL6LXBkbd5aBIA0CX0Swapox2R8aIu/BAPYwAyAf0dpCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9egEqhKg/HgMwi/zhMFyKOefHSQeZiiu+Ea60Djz2jrQTIAQu
	u0ZZRffzFu98QWD5sQUuOpXGUPTloSERYKsAoqWPOh8gKU7K30VC+uBBQwXMMWM=
X-Gm-Gg: ASbGncuE20NOIdd215fPG22MrqTVoYKt+uDHr7MPmeQmcGKobylwwtcf2DckeVtumuI
	Xfh5ZUsb78qbPPzxCgKEv28RDIpCLOTaM9JdJmyzDWlutPdYga3A6KzfSWt/GTcJK1fJtHbTxMl
	V5kUHI2Yzaa7roI+Hz7hEzXOSPnrcaHuZwYnM4vDQqns1rxicCmayI1DxzpNtKx4DoPBmgsrNRb
	LaSLgEg70Nhg1XQG6ZU9WKUftpS2ahsmjSEgtdjBoZMI67pknKaEFQ3yvM=
X-Google-Smtp-Source: AGHT+IFDoAfC2TEGvWdsgMiIGabTAjDbrdPRG6NL0tEiw6hi8UXbV2vsFwEBCEBl43yYldJWGWPxVg==
X-Received: by 2002:a5d:5f52:0:b0:382:4926:98fa with SMTP id ffacd0b85a97d-38a8733691amr9689710f8f.40.1736504749506;
        Fri, 10 Jan 2025 02:25:49 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:48 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:14 +0100
Subject: [PATCH v3 2/9] iio: dac: ad3552r-hs: clear reset status flag
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-2-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Clear reset status flag, to keep error status register
clean after reset (ad3552r manual, rev B table 38).

Reset error flag was left to 1, so debugging registers, the
"Error Status Register" was dirty (0x01). It is important
to clear this bit, so if there is any reset event over normal
working mode, it is possible to detect it.

Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 216c634f3eaf..8974df625670 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
 			 AD3552R_ID, id);
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
+				      AD3552R_MASK_RESET_STATUS, 1);
+	if (ret)
+		return ret;
+
 	ret = st->data->bus_reg_write(st->back,
 				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
 				      0, 1);

-- 
2.47.0


