Return-Path: <linux-iio+bounces-18538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED5A97A1D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8733E3B8CFC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C8D2C2AAD;
	Tue, 22 Apr 2025 22:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SCUn4hoZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D052C109C
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359730; cv=none; b=m7rUTbcQFaWxkF5kw2RdzRHBxY4nF93m3lubMHptvtZbIBE2BPFM9DEfMHzYtT6axJvweKhVuqUCOp/802Hiri3zJsmLdOvoWOg1YEPpvp3T3ySnxjtlbk6uptnXuLx3DAXN1eobjp0iCvqySA/IRRl83XNDQu1zBgV2Ti9HWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359730; c=relaxed/simple;
	bh=NrHDY/s0Q8dzJXv6IKAEg8Tm8DyekgOKnNJSWC3747I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBS0ABBJlC5mrqmeuw4cvF+dwsEWhwPj/El5XRi0OwJFlcoCLoKi2AoIl32UN+Fgkfc94TkRUqqfPEk4VQvhUreQikkB/knUPDALleBzUKuT1yXrKOz25C7JG7y9SzHD78zky4L5wX5CzOT68aJotWyO4tbxOyDLuEEabosftVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SCUn4hoZ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72ecb4d9a10so3446901a34.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745359728; x=1745964528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyqEc2A1DVG0wlj0as96NOrenir8mMhhJ0tJFCy/DAk=;
        b=SCUn4hoZYb5wL0VdOlglKIksz30UAw6s2ASfYZ+TS1CAbxPCYrD1XV+++lHxbhPuAi
         uxzlr2dwy3JrorR4zMrBjhh44YL8LJ79Vi3OJ2+IopP24O+L3Q/lyhAwINkmscVf/zHf
         vQvIvd4PsFuQwJfAOdZgTEHX1vXGlhKhi7UegL9pIBIfkEbt3OuTCxGHzeCpwCG/R1dm
         cA1/K23e2UWCqAOohKQ7sP2nAYdXuMms6BJgdW/YZELkrTRQwvtGMmQ2yjV02/hMdUNf
         1s4p2azTHryEqBNE/t/DD9seusdQuhx/+Zl/f9mGR4uMR0aEVmGSICSSJXrUkxBhUwmq
         uJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359728; x=1745964528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyqEc2A1DVG0wlj0as96NOrenir8mMhhJ0tJFCy/DAk=;
        b=tiv5pZFA8Q+YP1yMVYNz31pyr8JAhqQB7JLWBWvjM6vv0UU/u+HLt2yq3kfEzzvJZD
         G9nbYBFHMuKVPD5UmXhG1oauxSx+kHoY0zHzSpz/tfhreMIIc8nRbCRst/gjEJPhbyV/
         WYpGwNGVCmRhPtN+L5VmaouHLeIUFztnJQrcMT4teyXx0SC3a9EPvf75zlfhUUQawNkR
         vLA3vRPicqlHmJPnwNMuBgWv0sTnVWc5V/IFV0u4nNsAxOhN4k2FpRKJ0JGU0ozT0z9r
         XLRiktJK8RfCqeyGar4SqUwUt1HQecUVN2AhW+81r7HkftBiWJDkUNA9PS7MgTAEnGMp
         ot6w==
X-Gm-Message-State: AOJu0YyaSchfOz8/gNFkQ3fEmnlYgtRfsYtndETtQ28mfLswEYiHf0gh
	+cyErDUxaxj2yuIYqrx3rD1MyuSPiH+bqv/xmlrG+xa+QVJ/tXCXh5puu+oyg8Y=
X-Gm-Gg: ASbGncsnjgGhGA73D4p/RXumfdu/s01XjJHYlRulYagCx7mZtj/TJU6i0ibYGEVMIN5
	nFKtuyGfzaIECol/Io9GXvW65LQjnLU9lMBOPYBr+LVd+oo7Jm73q1KAVfX7zLCSf+lWxCPpWnL
	5eQjNefz58Iz68C83guM1vv9psS9b7z3dl9vt2cAvbwnGwmlTLDGTlFl7yTnvAmWZGg0w3u4yvp
	b1m4SqJshL9nEX1Dx4bfXgA4NL2KVVdQTqs6SnUUMvDo8PErMtFAtB3KwPYv8rrhplSF668vQqS
	iobjKNUyFAUVimi7pdu3h5RY/wFwE0Pf05PkndygOy8IUnE=
X-Google-Smtp-Source: AGHT+IEwuSSEoXlMTOYuepjnaQFx4CQHYKXQ+tl+tvq0S6my8j7uhxkWwjCkcKQdGsBjFpysXR3rjg==
X-Received: by 2002:a05:6830:3693:b0:72b:9316:d596 with SMTP id 46e09a7af769-730061f15a7mr10959124a34.3.1745359727937;
        Tue, 22 Apr 2025 15:08:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730048848dfsm2265938a34.52.2025.04.22.15.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:08:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 17:07:48 -0500
Subject: [PATCH v2 3/6] iio: adc: ad4695: use IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-3-3fd36475c706@baylibre.com>
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1015; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NrHDY/s0Q8dzJXv6IKAEg8Tm8DyekgOKnNJSWC3747I=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoCBNL77G6l8A6/bF//fY7ZeTEg8wbGvyZFhMTD
 6IADhTu2bqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAgTSwAKCRDCzCAB/wGP
 wH2AB/976GCXJlNczBYNpuoqzA3QSldjyAoLBUjnc98rGro5CMS2LYb45sJ2n0Imtc0rqRArxHL
 w6jcfJEO4D9RR5471sgm56n3vimrEmNiNoJX5Go0VLqd24YLaCCIzi5LfAw+2bIQvGpqIs9OMz8
 y/F14BplhIVtRU25Ncgcfmnwa+ZIo52uWrQFI88i3mSkHVKvLktfZz1VlUgWrcavbCNCf9Rt1jo
 f7U2Ca8mfA7CF2AEgiz9OCIc0XzDEH5SiKpp5T5tPCByU7j71MzT7C8nBRSubav6SCqRIWisv1O
 LCl2DRu4gvDq3NuXQandle0Z6LC8R0WdvHNaXPvlbITyoWz3
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
and understand.

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


