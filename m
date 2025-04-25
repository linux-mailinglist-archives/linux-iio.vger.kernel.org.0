Return-Path: <linux-iio+bounces-18666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6DBA9D3E8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 23:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A563BB0B7
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65DD2253A5;
	Fri, 25 Apr 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bu4fwo37"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B62221F2A
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745615383; cv=none; b=GpL8en50yjWn6kt7lXU+ug39C9c/sYTVDLnJiLVE3hiz98tgsw0dtjNBOz7h5yNdXzAiwUYxY8x/LBKkqv2b2duqVUwrrof2oZX83E9o8VFNSBL53zqqSaxBd4RBueez0vJ3GiFsixqOlDqRHYxg067PQ+6G/KsxBa5cJURcBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745615383; c=relaxed/simple;
	bh=J4aWhg+jCqZDPjq8gAC6cdfS6rEoLENhaBlAy0BO4RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3o88WVQJYP3jYZxQCV7n/fhO2Yo+3CLoMBNcptk5ob8MsZr+TMmrs/y7Wz8CUBG6dIfp3qemPDkKthSr0jZ1BPaqZUfL+f6C4QYDndwN4bOS4xnDPFQ0sNX9qpu1n8ZGXm3IUxKMiJcy/Sw6PjZpnOYGhFbDe0l15jlb7MkORM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bu4fwo37; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72bd5f25ea6so774770a34.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745615381; x=1746220181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTje6aj5o1aqilClKP/XjHDRm21nPtMuz4RymFa7ygU=;
        b=bu4fwo378sJunVsKlzrGzCsleLID3A46KCck6gxLWoXDsCwQZkMS8P9YSo+MRVkFAe
         cOVOjrFQCppBr28iUFVlV84WrFf+cJYXplBIcEVgUWymsTMTwWy3qT5OD9wioVH2P2GM
         v2vQ3YkUPCHr9U9nYfJXFwBJAxXc0K4DxSxizNvPyT0liKZKFLfNaHUtllztQhE6Bntj
         /kLFk33nUQ1Ur6WNeo2BaegeBf9EiiKxugkQcIvGpCo4Qv/dBLM68BPZJef6krrtJPcX
         LPRp1RzETKGZD30k1BS3AX8Zb8Mf73uVpUpZ9JlYe201SEvZWdLmjDGhA1al71opzqH8
         a7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745615381; x=1746220181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTje6aj5o1aqilClKP/XjHDRm21nPtMuz4RymFa7ygU=;
        b=YEpU+TCSjls2XBDMXM2ydJuDjnxKdVhokQAzItP8nnPmQroTSi3ccdDKNWvO+hg6mk
         YejUV+8Km+ss35sSp59DLBjNSkyeXkDqw/53hcOn3bZvRDWzh30pVCv/f2FZ1Mxq8OwN
         qmp2xEyHiqj7Kv+v5xTaw/tMztvZagH3aO57bEMp7FVGBrY/RH2JCiolKl/q+INTGsJO
         JEpfkhxsM1JyYAM8WLNM4Fn4hcFBJZIX+QyvQVr+kJEvgTMvTMzmk/iDwz3ZKIWWTpfb
         V4MOj+5Z5cEBTU4AlOBc9UlpnPtwOZvpWuIBI+/7MqT3YUehIn1h3FZ3Ano/h5IVLdq/
         8C6w==
X-Gm-Message-State: AOJu0YyKqA6htIt91AcKy8G2FQeWwprn1A1cGukeN7g2oQLoo6CJdPzS
	OfKy8Ut31HYLc4PHhWlru0zNew/9EDu50Fr6FlyPrzcNMBZwRjYJO1Ggmjs2WzE=
X-Gm-Gg: ASbGnctD5zM3XUzDLCH+p7mnAdI6F1P06nwIEwMsKvQvZyn72YCCvzmRFMs4+feBXEl
	62UTMRmIquL1LFVfj0XI8hoJU9xK+uHdnZByIeA5GQDzVuIEVnuro+NQp3ASe8seCn9A3FBCbHT
	JDZLt9WiqaqOsx+TYFvR23J2k83fcOjnkEBOXjj7wQFX2Ycz6usu166Gbuse/mQ+vipmgRP3yGy
	19AU50MzYo/FwVtwvhPyZY6+VmvBA0/OXlfHaVU0gjIyxHEknFlRWcIXSpJIv2EhFYMVclgcIJg
	aOsfhOuoNbmxxhY9+988JZeDw2SA1ouPOOTZFgPhl3yJ
X-Google-Smtp-Source: AGHT+IEcQjGHfz0Vi3BvNBX48+ecmEcPhmsk9/MYoCP6D6pdFOSfKrM1FruQndnBcm94B+h/H2rZ2g==
X-Received: by 2002:a05:6830:6c16:b0:72c:3289:ab9e with SMTP id 46e09a7af769-7306528fbbamr856930a34.27.1745615380993;
        Fri, 25 Apr 2025 14:09:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f188052sm847673a34.8.2025.04.25.14.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 14:09:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 25 Apr 2025 16:08:45 -0500
Subject: [PATCH v3 3/6] iio: adc: ad4695: use
 IIO_DECLARE_DMA_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-3-f12df1bff248@baylibre.com>
References: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
In-Reply-To: <20250425-iio-introduce-iio_declare_buffer_with_ts-v3-0-f12df1bff248@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=J4aWhg+jCqZDPjq8gAC6cdfS6rEoLENhaBlAy0BO4RQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoC/n0uazZp0mcIAzLz3ELaYXnTAaEE8b6z76v5
 3lgVH0/dBSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAv59AAKCRDCzCAB/wGP
 wE0UB/wO2o0M3Ij2ucEK4asG4o5GLQvawEfQD4eAcTlSfGKy0hEFnUV2QpnV3Dirc1dIuIPdPfE
 3/JAM7GHw/EnVXqb1DGA7rO7sRns+9orKw98lIt2llIRHyzUrxlbqMxdI7Ujxm3w99YhuStdHh3
 DOkCSYK9azmC6DfAIcC04TxnvXBa/Bq9RjfXy5LDvFTBNOcf9W52RI9sLIlO49GmBpFlCcN9o8H
 Mncbxr/fGo0L+38XEIcYXHUOCnx/MJozw0Wg+hLA8HOhm9r5JlJFln2hfBI9cJ3qwNp0tSJdW57
 0hTAqvyhB/HJX42GIhLlbj/8qnhuv4PcrCZ0t4oaZCsdAUTV
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_DMA_BUFFER_WITH_TS() to declare the buffer that gets
used with iio_push_to_buffers_with_ts(). This makes the code a bit
easier to read and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index 0c633d43e480d5404074e9fa35f1d330b448f0a2..992abf6c63b51dee222caf624e172455fb9b9900 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -160,8 +160,7 @@ struct ad4695_state {
 	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
 	struct spi_message buf_read_msg;
 	/* Raw conversion data received. */
-	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
-		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);
 	u16 raw_data;
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;

-- 
2.43.0


