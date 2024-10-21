Return-Path: <linux-iio+bounces-10876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32619A698A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A7C281F95
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C317C1F9A85;
	Mon, 21 Oct 2024 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kIccRN1d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A41F8EF0
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515766; cv=none; b=nKXsigmvqowKb7rNuT7LQYBw9hQ+5WvLHxEjzQsNkwHoOx5FpdajQnzWQMxGfYgjUvhFBQxSiG9Tej9UjbFbdbX05dkuec+u8q8tPHfnBQ+2GPqvCD8ZW4ttRKIcoLSM1FUIB5dmYGWlgnk82R665HQ0jlsikqIuX/jyTMP8ZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515766; c=relaxed/simple;
	bh=WKgeKu9BKiyFb382szdmwaGYbhsRt+mpw7oK76e+Juw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2LnTbmbbfAUgixOAHioFBfu048u77bRY9FTCpzZ7x3PLnezangFpfCVHJclzutRmVuVdMVoqZse43TKebbZg6d2ZO9ZwDdyBlr8lwPksUwOLqW269vlgD2ruwRZfqakji4sKhFSt4zeteS1p2zYQem/nlS2X96iHDanmsgbOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kIccRN1d; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a998a5ca499so563707166b.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729515762; x=1730120562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exnou0jkm74QB50DFbZVtG627VNG9ugvQrtDOKEght8=;
        b=kIccRN1dXFGNOrUonzPxNsWrlUQsxVZXbDOPOQzCjVWZqzqU5oZg8TCNAH/ojV8aKr
         +8LlP5h7K8G6Ycjj6bTTiCD3P2agVnZHAWCzFpFGJNCB80E7irBACDLobRfBIxjVQtPD
         sQNzoDTzXjmWtNUm2X/QMPiTxo85hdCdUfnXg2ffta6yc3g3FCMjT3cNCta9CKALXi93
         4gfvS8JwZbl8eKVa6FWVZZolB2LEHW8ZrssylPxnsOXS/xw41EP6+/bCbpcpPtzRUQCm
         P8XjHBNF1WMlZG0t/qzCbbG62ivxWqEJPXajoN0YH+uaI4avWqqY3d8C/nl+eeEyyVbl
         d6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515762; x=1730120562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exnou0jkm74QB50DFbZVtG627VNG9ugvQrtDOKEght8=;
        b=PLJdb6W/OuJKmAB/gr/+ZyHWbSdRu2wsGyTj9pN53Ols4FaSj6bvU5GUCtGydCpM9J
         3tyFS02+UiM7vKX/cmiH0LDq0hashVEdGTVBqlwJxZrcQ++IYGCxtXKMagqwK2MNm5no
         dxO76I/JAHvVNcE5UjPd+NUKJ2V1b+Ds+FkzZ/vL6qx7awAafo31z/MF1sXPDIRnMGlx
         44rXHSw9jgWZniCHmvCBXj3R5aMqjwEgZ3wW5j/xvKUpizzZ9AgRAaBMX7NxroW4CprZ
         ALVFZje0ug1vxfBcvhDVy7j88ek4vBk6TjQj3wjjV52Zx+5MBPa4H171kQX4n3vEWdbt
         RQkg==
X-Gm-Message-State: AOJu0YxkxdSp/z/sttcKiM/Bw+rSEtlSOKpfHlMiNOBqLOsB2SQQn9Zv
	wNmWSOKimfKL8K51qNIANlJAgkbxBeLbDKQjXiDV1n73p0PqjI251QQTS/UqFYbKuTGtdIhUDJz
	Nkmc=
X-Google-Smtp-Source: AGHT+IHpgT9Fnvdd8Os6CvbTIWJb/pht/ROcNHvodcKIAP9VYk00V2IhRdT7gRJOIpwjFKL4MBk0Hg==
X-Received: by 2002:a17:907:6e89:b0:a7a:9144:e23a with SMTP id a640c23a62f3a-a9a69c687d8mr1274360966b.43.1729515761922;
        Mon, 21 Oct 2024 06:02:41 -0700 (PDT)
Received: from neptune.lan ([188.27.132.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e33sm202310366b.120.2024.10.21.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:41 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 3/6] iio: adc: ad7606: use realbits for sign-extending in scan_direct
Date: Mon, 21 Oct 2024 16:02:18 +0300
Message-ID: <20241021130221.1469099-4-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021130221.1469099-1-aardelean@baylibre.com>
References: <20241021130221.1469099-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the 'ad7606' driver supports parts with 18 and 16 bits
resolutions.
But when adding support for AD7607 (which has a 14-bit resolution) we
should check for the 'realbits' field, to be able to sign-extend correctly.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d0fe9fd65f3f..a1f0c2feb04a 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -568,7 +568,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 			      int *val)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned int storagebits = st->chip_info->channels[1].scan_type.storagebits;
+	unsigned int realbits = st->chip_info->channels[1].scan_type.realbits;
 	const struct iio_chan_spec *chan;
 	int ret;
 
@@ -603,15 +603,29 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 
 	chan = &indio_dev->channels[ch + 1];
 	if (chan->scan_type.sign == 'u') {
-		if (storagebits > 16)
+		switch (realbits) {
+		case 18:
 			*val = st->data.buf32[ch];
-		else
+			break;
+		case 16:
 			*val = st->data.buf16[ch];
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 	} else {
-		if (storagebits > 16)
+		switch (realbits) {
+		case 18:
 			*val = sign_extend32(st->data.buf32[ch], 17);
-		else
+			break;
+		case 16:
 			*val = sign_extend32(st->data.buf16[ch], 15);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
 	}
 
 error_ret:
-- 
2.46.1


