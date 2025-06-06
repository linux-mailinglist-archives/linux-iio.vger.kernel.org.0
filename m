Return-Path: <linux-iio+bounces-20269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA56EAD03E4
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 16:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA053B15D2
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BD070800;
	Fri,  6 Jun 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xl8zDuQg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9901991CD
	for <linux-iio@vger.kernel.org>; Fri,  6 Jun 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219646; cv=none; b=m9WykXjjZekcvkb3NOtnVXoKTb5KYCrrHHYwHTKvMN4GhJ2pEJNNytHpoLxRBtHbdwH+j6inMf3KPJMz7WAAwVQLCmXrb7xWF1Z+dzh8uLEHtrxZf8E1rdp4syan8HdI3B+rUcFPz2SSTm+ooEwTir8UXp3CycXHY3/b96gOpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219646; c=relaxed/simple;
	bh=gYfEpf2B0eWfEeN9J0NWkVxgQeOXhE0vWQqSI1AdL6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0P9nBLBKlpH9gNj9Q4lf3lvL1kJ6dCOjzE+ccOz7cnimr2O3tWgsgAoen0s5+SCdhXzNT0DMDCROogobk3Y8zAEXSdBCX16DNN3PeJ8UQTrx50ZgUsrT3WWmXAZRWGxQGhJm7zd/+b6LsU6D0PCaXQgOJhVgIPcX0WFlk8lw70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xl8zDuQg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cf214200so19583645e9.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Jun 2025 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749219643; x=1749824443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1WuSemWPuN4SdNDyJuKtWMwJnRcINbePcyuYFAeNSg=;
        b=xl8zDuQgOcvXr26pndVTz9RWxSiJfigwaOWDjUCCUw52d27jJEQnYgTocxzmfC2Uwo
         900ElBBmYlOzi8NeBJoHUsZ7w6mKaPDyJEDPJUaWgO1bOpm/oZRnoyC0WIlL7dLzQg9S
         ZI1r+ZBKdT4QF1zAfNB8BOZLo/SfrqYpnvIdursH11lOLSDrmUYJXh25v12npT40okEE
         A2WWcLv345N0PNBY62VpXLKN8ni4d8PHNHn4dsCr7KSjssjBp9UnKoCm5aKhDdH3bgjA
         5V4Jj7xjRpYOcomRJj9A2o9EH9dYJmtWsFByvR8oqhW3ol0BhwCPW8Rej6B/xahn6Fy+
         aPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749219643; x=1749824443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1WuSemWPuN4SdNDyJuKtWMwJnRcINbePcyuYFAeNSg=;
        b=OEm8huMXaB8oZGcC2QN3JuP8oov+Gd3PMAEdnGfbcxmA5MuBlg9xSO+BU7Y4U+hU/F
         rRJb477oCpahCbJqMplsJt4MGZ2hJyzxwNV2tREhhsBMFAt1JR2w5cPrt7k7MrpTsxMa
         GCs8TNnecee41PV4lt7l8ecA4NgapMdenpCB+wkjooK3oAaR7SnTdufI6RjNTmr2MyYe
         2T6omfRDXjPcAzaGKhoOKgBV50uuWQjCYSs/nJShI1qdpO/JaIf1lY3/3WhhzqSGFw69
         l/UO8QtK9lA9rmX2c/a6RjUZHciM0acFi+oxy52dxpsVBmidyVVuvZ1PoUmUqaIqPoVv
         Ehyg==
X-Gm-Message-State: AOJu0Ywx3BIs3QRGbkD+aPVCyvds/ApJSWTuOdgw9h2jtEJhXRoLy6xX
	WnDGRSICshDilFQ2GvU+IoOiVYPyYVMg9maCEOEztQuLJ4j0g7LzSGxUpc0BteAvoJ4=
X-Gm-Gg: ASbGnctVr1a2ReHxQViT8t9/mNYwkCOYux34LIfR+Qy8toWU0zu1A/FRj0gGTIXGOIZ
	EkQ8V5uNB0fR6wwVjSL7ZOsZ7PEXzT9Sl7mCo6C8nhj66/d8MxlpQmU51IIdHg2nIhYWVBanxO/
	TFoGQP6JBKRc+9SXyrBx5qNN5UM0lTopgCnPR4giiAHa7M+7Xkb6ffT39+AX3jsAlZjH2lIjXK9
	Zny33HAx+Vc3vUvog70ezonuGV2QVSXo0F+y3l4/l2j+UTUj3QM9UDk8TCkmVliu3VBSpEW2Puy
	vFPCPKApXLRINf+NnMoHAdwn+olrjXdDKUMFbnl+QpE/D7+ffqBzvyTG34qON867hk+648IXQPx
	51EN5xuqb0agU61lqLri95ZUzZrTVhAU=
X-Google-Smtp-Source: AGHT+IFtlzsfvKdrGidMqXsh4h0hFXBsNFDQ1/vkDgbyZn8qf/GpmYhHZbaV81p1vbt2rpfR/6BT2w==
X-Received: by 2002:a05:6000:2288:b0:3a4:f8fa:8a3a with SMTP id ffacd0b85a97d-3a53188d961mr2814047f8f.18.1749219643145;
        Fri, 06 Jun 2025 07:20:43 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45213754973sm25686345e9.35.2025.06.06.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 07:20:42 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 06 Jun 2025 16:19:20 +0200
Subject: [PATCH v9 5/7] iio: adc: ad7606: exit for invalid fdt dt_schema
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-wip-bl-ad7606-calibration-v9-5-6e014a1f92a2@baylibre.com>
References: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
In-Reply-To: <20250606-wip-bl-ad7606-calibration-v9-0-6e014a1f92a2@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=RXow6w1uaNfMkBVbDyKeZVZMYqn8OBoe2df7BYhUk/U=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYshw+vHse9SpmdYf179kvjN5/seTMywr79gmJh3gnBwbK
 pF668miZR2lLAxiXAyyYoosdYkRJqG3Q6WUFzDOhpnDygQyhIGLUwAm4uTIyDBpwyLzDUkNLtua
 7j08+P22bl+43sTQnbIHNP4UZh+48bCf4a80x7GdF/Rj1i77ov0u/d6vGTIef2xfB5w48a9jU27
 goxw+AA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ad7606_get_chan_config() fdt parsing function to exit for error in
case of invalid dt_schema values.

Idea is to not proceed when there are values that are not allowed under
the dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index f0c22365f23fa2bf00edddcdd7d608bd1393bf28..e5878974a28293664dd8dbded5fffcea6db31ef3 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -319,15 +319,13 @@ static int ad7606_get_chan_config(struct iio_dev *indio_dev, int ch,
 
 		ret = fwnode_property_read_u32(child, "reg", &reg);
 		if (ret)
-			continue;
+			return ret;
 
 		/* channel number (here) is from 1 to num_channels */
-		if (reg < 1 || reg > num_channels) {
-			dev_warn(dev,
-				 "Invalid channel number (ignoring): %d\n", reg);
-			continue;
-		}
+		if (reg < 1 || reg > num_channels)
+			return -EINVAL;
 
+		/* Loop until we are in the right channel. */
 		if (reg != (ch + 1))
 			continue;
 

-- 
2.49.0


