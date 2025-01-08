Return-Path: <linux-iio+bounces-14028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2BAA0636A
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E7F3A45A4
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768CC20125D;
	Wed,  8 Jan 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QB8ttpc9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759B201015
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357438; cv=none; b=MlG/xYFT2yxNVQKV5japYMSQOlpKYYpJ+dzoO8xkqBqs/z4z+9/FeZjLltDuz4uMzbS41PBlRCqO8DhRbDYgxDITrabHu3Up0Sit8WnIjUXCka1JK9NsICPsMgQtoKp/nJBXCDlniedqxiIXcEF1ZQmSf3hTE0Pvw1YlRLl8TiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357438; c=relaxed/simple;
	bh=+lZHZ4OM8rTY/dhezSlahZGVnk6ol0FvguLhf0YmUqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bn/u48SfzYccrYE6GhB2lZKTjYl9QjdBCIwpRH3YwWLJIycOUUBdLEq5nVAzs7a0ZloIsW60dSNPTV3IgdSbrJgbfXzS0n4wVFR3c1ppY0xIWwJq/LiiVvdir6QUBH7AhSjJSzBIB6ohZW23ROHpyn+ntWCmWUT2eubrouPWcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QB8ttpc9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385eed29d17so25111f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357435; x=1736962235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfrMkIY9tbM1sPwHCNYu/jKLHOMpHgwU9OMNQ7g5My0=;
        b=QB8ttpc9lu5kIPW9y5IGzWfWIaxC4JQzHb63R6JpfCAEKIGO6c4DvBWKYnY5biJ+aq
         NSlFi54pPO6YZg7HqLGrHTASLkab6A/hW+YgCGX8MpGr2jk42nKwdFbDpUhughsl2pfT
         yAOdypOo2JPocecoo9FhJWUU+2sDvEKfAUCZLKYZa1NjaFPRItvRouJhuzS12s06jQpq
         +WyUAfWzFKhLGTdw3+TFKIWlGmVLe+wn0VxIIILYjopzaswt1SGUpRl6hhGAq0jBuIso
         97hSfVc75ensKGDGJoP4lROmgaC4Tuv5rGhjZOUkCTZXHfCwSz61Xx8/3qX1zGilPQK7
         E1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357435; x=1736962235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfrMkIY9tbM1sPwHCNYu/jKLHOMpHgwU9OMNQ7g5My0=;
        b=aY6ykoUxD43USLxu3M/57F0PRe+SYDhc7CW/EJVpd9RR4JG10Th2maQCrWMaI6rW2k
         UUmzzJyIZlWp2dvZ6GzMQy4aUgbEDaoSzeqUVRWI5JHtjRMAOEHfVDoweC0jRbPfDYZJ
         80gLhNf2r9jggyAG1BpOpLSiXPnXBQrwPOxokYa5DrjDGGXEU5VyudGQjFZxafexdMKM
         KzmMP/XBIiUTW4Aeo9sSQJMXPbDE9Tm/F4u0swjAHKM0/eubcOYNXQSZg8UU3YNAZJ84
         NnyTdKfEJpSqnW5Jg/7dw+I3uj+ePP+yvGI8K+/LkHTyrFgDgVHBvOoQW5U5B9jl2bEv
         sEOw==
X-Forwarded-Encrypted: i=1; AJvYcCX64ALuhxdpSfKXOD8MHXOzZNqiCvKLH6/gYowqktROSidfuY+xJshejRREQS9tv+fC6R5WBgk1B5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfoJVLyPuWiK8cvYPgjMaXKuqnWnn/QjHHpcSz09DjbQt/1ZV
	An2ES/SwGfwkiexNhD1Fv/PKbbOCDB0SMVcLraKkfOnqNKVYquimkrq/uw3U8Rg=
X-Gm-Gg: ASbGncu0ulrODr1cmddkkSoqtCmig2p7cQzYvlRdwr7ImC2VHohBmfjZ7e/i82S5XWA
	FIlldgYMGlzBn7MSamBP0Ip4b2J75TB28XyyMP0g3J6lFhYV2oKmC5owKDvmC52VR4U3fJ7MFLj
	v7f5dU5fCTfK2ZxBuW57XrMDygbI8yuFl4bEZ6z+xH9wDLxSZyVLZv7JHLVG3H5XW79xv8RBSs7
	7LFoE9VS2fuzZ2vNwWuC5ZRRlpB5qnRqiW4LZAwpnHSu0dMtQFa/8gjkwg=
X-Google-Smtp-Source: AGHT+IH4qbFI51oPuAFstB6iigZ7tk+yDzWm7fy62GK+mJysZx+iajrKN/1HnJeyNn4/bidfamGMWw==
X-Received: by 2002:a05:6000:1f8d:b0:385:f6c7:90c6 with SMTP id ffacd0b85a97d-38a8730687emr3515425f8f.20.1736357434494;
        Wed, 08 Jan 2025 09:30:34 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:33 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:17 +0100
Subject: [PATCH v2 3/9] iio: dac: adi-axi-dac: modify stream enable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-3-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Change suggested from the AXI HDL team, modify the function
axi_dac_data_stream_enable() to check for interface busy, to avoid
possible issues when starting the stream.

Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index b143f7ed6847..d02eb535b648 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -585,6 +585,17 @@ static int axi_dac_ddr_disable(struct iio_backend *back)
 static int axi_dac_data_stream_enable(struct iio_backend *back)
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret, val;
+
+	ret = regmap_read_poll_timeout(st->regmap,
+				AXI_DAC_UI_STATUS_REG, val,
+				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0,
+				10, 100 * KILO);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(st->dev, "AXI read timeout\n");
+		return ret;
+	}
 
 	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
 			       AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);

-- 
2.47.0


