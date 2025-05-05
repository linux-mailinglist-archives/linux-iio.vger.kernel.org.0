Return-Path: <linux-iio+bounces-19161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB64AA9C82
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17AC162A22
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DE276027;
	Mon,  5 May 2025 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NRT3g4Yb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640602750EC
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472954; cv=none; b=TYmkY5hkeUhcyY/qsndCLcpMvzcTaNFgo8n96cWO2p02WtcvvpvxvTo+1N3iEEyiV/DoTWrHV5DCT/6TspTtUDecC9cXNNsKGZ9EOVPdlQRzJQ6WNnmth5YXZi/1D2vr9cH7IGwKvlq+j9xGNvzs4/D1/TzwgJaFcEcaZB8lfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472954; c=relaxed/simple;
	bh=dpNYuGn7Y514sf1VJraufXNOQk+UtuKrBSvwhBZtups=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuUnVFqO4jUKf+i1FdYSDWPGkcgp9QjI4d/1iFg2p8OCpFOoOZ0FWM0An11OoFE5h8v8pgF/raCte1U8lLKMjeyoy7SQJaL7LKFNey2AiUaJ5FuxBXk+F84wHJB/38v2P7BeeFSX+sgc+bUl3/ROtR/3wHDaSKrVpt3DLaorsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NRT3g4Yb; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c7336ed99so1165730a34.0
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472951; x=1747077751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YshWpf1FxBsh73RdxUKeKhzDqOZcrz4zqd3LmlcIjnc=;
        b=NRT3g4YbgyZN9s5Y1LX1U4Ot1tQ2lEsORWesAg6xnv70eYb5HC45srMVbdFr0M2nd9
         4duTqlp1Ld9gKfVhBz47D/8EuCjb//YKJn7r8SZNTVtzIKhJyaXoQE4sT87paOdY/NFi
         jIKp9gq6NJzazfAk+NmaSTU8dw/0y8pEX4q1KPgWVU2pyFtOB1ZUnzMz7CZEYQYgCEpI
         ZjhagS8/NeJX4vAyziQGIREuS2ufgu9j44ETmJInanaLRZgY6+VUjS3L8bQ2Dzu4Vimf
         uPSVotpwKvSArEhC5fgIoCrAJMAvdkPmjaBhTbFKNy48mwqD3UlxKosNzJtbB/KwmiTL
         RcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472951; x=1747077751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YshWpf1FxBsh73RdxUKeKhzDqOZcrz4zqd3LmlcIjnc=;
        b=nUzKkyRLYmp9r7nEXKSgBuDtz7M+FTqhEb1093X1ZqOrKR5bJAmEiPiDPfoGZS4zaN
         pU1BbYCoWutFmEk52FQE7oU69Uy44lGQLm55SXV96cNIESDmTsqmaubVSLzpQzUwF56i
         5uZlLEGmjSQZAiKARr4tLafZaJuLrBRy+nDMM3RXBz3OIkOHqzS/5UGMgGyi5vyjqPq5
         7gQ40MOt84U+JKJH4m3qw96OkGq7/TPDAbFst5CWZS08IBXQdu4ZFXbVIF8L3dDMBDQA
         NBndMMhX8mbpke00WVai7qO87mNwe4+QgNGrHuQZAVlshRlSo5YAKGWr4yZjTCeqMJlz
         jbVQ==
X-Gm-Message-State: AOJu0YxsqKjon7WNdfDJeQV63a+Ooa8wUI1f5McbKwj0miFk/qo8EON4
	b3MYX4TcGSOWeA3h5GuYDTI3VbUIWNpNmJyObr3A3XeTw6UANv/FN6XJogyOBWc=
X-Gm-Gg: ASbGncvIiOgpRdSanZdJYpv19g2YwMbtuuk4arrQMaGxq8uYjqzO8GSsgEQrAkVS+Zc
	h6GudVJjCtKJeBerpfuL/1E100OVaD4vw+kP2HMdVeWI3wjplwMrwL6ncgvnFAZL6dQjj/Ryn/q
	E2tAvZ700CZH7Y6SkdQ3EWffE3AU0ybUxyS+eaOq7A3XYARlriVfyhodHSuU1UYs0KAjt4f2T6f
	UZxk1u/RZoibKg+WGOAc0HuClTAVYQhDYG0YNhvilYjyJm75r1QZiVW/kdQ1fikYNCuo6E1gP8P
	NnWw2s9SzrrshB2f+0CzeK3YpQETCJS34LIIn6FcmIZ/3A==
X-Google-Smtp-Source: AGHT+IGCV8uJBSBkCHou4letYsnwGXYc1cdmAE/9CRy3xAv01oUt3LNOK1PaUpCjZydbnysxI9wttQ==
X-Received: by 2002:a05:6830:2815:b0:72b:9d5e:9429 with SMTP id 46e09a7af769-7320624bbfdmr476010a34.12.1746472951384;
        Mon, 05 May 2025 12:22:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:34 -0500
Subject: [PATCH 07/14] iio: dac: ltc2688: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-7-341f85fcfe11@baylibre.com>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=dpNYuGn7Y514sf1VJraufXNOQk+UtuKrBSvwhBZtups=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ+3nNp5+QaDuoSGNQzF/tELjxev2xwcYHoex
 ewpo5MDil6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkPtwAKCRDCzCAB/wGP
 wLP4B/9ITjPg1egaCOMT/sh9kFEnTuRrdgGX24GyrYUvccqU25KloXujivOZldfSQMkgf+KFSs6
 kptSm9N+K5WRGcrkMLwfuelAtlc0PfiGn6CZAxhGW5lypevS8wwcekWEBXOLzO94znan5ZZ4Jaz
 XKpGGLepVqp3FDgkG4JfHpVvuzdFvn8BzG8oVYUdQD77H73RJt82YCnn53sWVRtS+3kwAlBq/Yt
 r1dzuWPoo/VC+3e6DbEd3OkYRFTBTtzjVEOpnFdLCA/fQH9b8L86sfoXsFkQM7C2TmXzlS93CMF
 AmhcnK64pdpbRcoUWPjuczBn0UVjWUgJgv41T6NG//I6s1b2
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the ltc2688 driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ltc2688.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
index 757b4831dc3e7c14574e3d811ba9a48d8350213a..1f24f07d1ad24ac1730da0e03b65207ca5f07884 100644
--- a/drivers/iio/dac/ltc2688.c
+++ b/drivers/iio/dac/ltc2688.c
@@ -104,13 +104,11 @@ static int ltc2688_spi_read(void *context, const void *reg, size_t reg_size,
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = st->tx_data,
-			.bits_per_word = 8,
 			.len = reg_size + val_size,
 			.cs_change = 1,
 		}, {
 			.tx_buf = st->tx_data + 3,
 			.rx_buf = st->rx_data,
-			.bits_per_word = 8,
 			.len = reg_size + val_size,
 		},
 	};

-- 
2.43.0


