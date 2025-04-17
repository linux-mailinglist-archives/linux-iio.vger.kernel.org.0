Return-Path: <linux-iio+bounces-18205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EC3A92314
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B219E6CC8
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239612550B6;
	Thu, 17 Apr 2025 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U2iutLGm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3801D19DF9A
	for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908821; cv=none; b=q4dP8p1tTzKugvh6v1IbO7ko62gmGy2Dms/EobdPrAKi2RGyVifAW/4qtjp8LHnntOCVcVcyfGi9h8WcsfSHocI45yMt1Wsr6fRkNLyvjhxufuyT919VhSwDDOORKXccYnT42+QLal9uStJxfeRIFxaR2PZ6MwAKu/Cl69qpFzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908821; c=relaxed/simple;
	bh=WBd+USN8oBva7x6dTXqEXzGbksHW+JPbiqt083CEvM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Thn6wnyJ8mRiiiWBX9RD3cu5jPny1w/Mtr2HmhNPVUC545DpcWold0EIhkmYuKF/SbwZ3PLhGp1VJZvCNn/im4AU6ZLWynseEuSxZGbogU9p+2ZSPx59hmt5ZkR7XhhK36sXdYaaF6+slPKo0Pw8jC/IasHkXERgm6vy7MDdH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U2iutLGm; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c759bf1b2eso439042fac.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Apr 2025 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744908819; x=1745513619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nu4943dg2Pk+bcmuLvvHqjkr3/0Uk0VMgvuphC7zY3o=;
        b=U2iutLGmQCOuxzFgUWNHQ93S20xcmTlg8qqdfujAqR30EYG1dbUcBLKQ3sAuexkDey
         FoK57/wTfZ6iF8T0XkSXsqN/GKfdNMlRf59GvkiMm6mI3Vwa3Jx7ehvoWwsS9pRZjKWe
         PbgFLFjvGRV5xvjuxAYfMTtzJ6t9qJ2AAJnOYYfkZyfHjDWJKCPZ25UEY0zlcmLg0WgA
         iHlniahZjWYog9CWDAX6Tq6mSkIVXe3f3QwDrGN9VmvD5+otDpVdTfNzuGdlFb0h6/y0
         yrDH/s9Xtrm8ztfoir50JMmUWtXjuqH7wqH2oXvc30QugDvFLfE4rgcJ643HS4K6q52l
         k9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908819; x=1745513619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nu4943dg2Pk+bcmuLvvHqjkr3/0Uk0VMgvuphC7zY3o=;
        b=Jk17gHHd9PrJdRcPd8Tjq2LuiCwmZj8usZGwkbGRl75L3pKbDW30oierTrXA/g5Diy
         ZxNzA+v/00bH+Vji5dDO1VrqNEYzpowQv1e6bQqgQ2qDfQep4Pfx9LkbIpwijqC/Jkhb
         P4NexU75IWzKTs8Xwea47yLJ0k1KWs9qPEq/ZGG9aQYxId24MiAFNuSXqT++q1U3q+Sa
         bhjuTQ3Biu399UmJwfaMm/pUmvCQOET4+yYOzBJc5aB6gnzBMg+pKgDh0DRJcvtr9UeU
         iwpnG0KY3Iu7KIga5a6y5fg/74do4iBHKdlsqosmRENJq8/zZzwJuIdIZRQ2EuxF8wN4
         MeMQ==
X-Gm-Message-State: AOJu0YyRXpcyBURBzulWcUTRxJESBOXM352KvXHKSr3Crz8qjekbQQ21
	5z17OCx+yz/+/k6qQYsuO9CDrk7G9YBuKqlQNb6dlYV0OqAr3Fitf+J83wgtI+GHoa4afQs2/R6
	Qbk0=
X-Gm-Gg: ASbGncv4nq9fN0YLFeRsJ4nb5nHzy8ibR/lftYkvp4s+G4vVl+el579XRhJQ82Pl46+
	zDWiLwTUidKEz8IBFwmhg3y4Ybrk/WZ3+f68ef9EMns35GMRX4QMvw8jjNB9xHeRuqIO/E8UIyo
	B+D73vuxUo5G6KagE46nuIyts+Xdj/cfy+EZmR+TjM72ORALt4QJLGNmaaIwSSo4H/oI3SXaMRp
	27zc8iLSEo3ojsq0wIqYtAmcoyl8IvMn5xS2FcCFm02b4I5/aO2OPf01Ta7vTNZC2F8X6qE3k3E
	N8jkXOrMTN6VmmILjJ3jQw+orRrvYbWyn9D4T7ajSr4HyB3kHZIWflxuUA==
X-Google-Smtp-Source: AGHT+IGwEsmY3NyPkCPBCO1td4MKsKQCaHFkR6HGlUIvu5S2DBjcqDrjeSVGpeTxzrXMhy/9DDR21Q==
X-Received: by 2002:a05:6871:d80a:b0:2c2:d2b8:e179 with SMTP id 586e51a60fabf-2d4d29cc3f6mr4240604fac.4.1744908819277;
        Thu, 17 Apr 2025 09:53:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c91b:eea3:7afd:2dee])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5218248b7sm15812fac.47.2025.04.17.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:53:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:34 -0500
Subject: [PATCH 2/8] iio: adc: mt6360-adc: use aligned_s64 for timestamp
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-iio-more-timestamp-alignment-v1-2-eafac1e22318@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Tomasz Duszynski <tduszyns@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=WBd+USN8oBva7x6dTXqEXzGbksHW+JPbiqt083CEvM0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoATHgh/KpCPdMfDSZdZwO0twpeUH8w6Bp6mw27
 yM9Paqb04yJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAEx4AAKCRDCzCAB/wGP
 wOBfB/4sAtaobNgfH0comXMtYx8J/ZbqnniJM6PBSi81wigpWaU6BQwSLvZ9apGiXVtqYlbncIG
 y7Ip5Rezb3ea9YAeAHCbFjFHPww3jTaKbl9Pglw6HYss+9lIZkjHa9fsAJCb9nlDlWauj1gjBlR
 uhE5aqLGU/KisOj4QWs8TV+EM+/MeutNaGWGrALoVUjG7PvXK525ug7W+N8E7P3cXksK/572yv3
 RJp516+TKyALXADXXpnorGRvP+y5e9QW7JTQTB8gGxopm5ZxtGWVTHDvqosipIbiNH2hXzF+URT
 TkDamo8F67AwrSBmKUadZJxl9wyzUrN4SQJQRHAZV+Pp4mU6
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure that the timestamp is correctly aligned on
all architectures. It also ensures that the struct itself it also 8-byte
aligned so we can drop the explicit __aligned(8) attribute.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/mt6360-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 4eb2455d6ffacb8f09a404df4490b5a11e49660d..f8e98b6fa7e923c6b73bedf9ca1c466e7a9c3c47 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -263,8 +263,8 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
 	struct mt6360_adc_data *mad = iio_priv(indio_dev);
 	struct {
 		u16 values[MT6360_CHAN_MAX];
-		int64_t timestamp;
-	} data __aligned(8);
+		aligned_s64 timestamp;
+	} data;
 	int i = 0, bit, val, ret;
 
 	memset(&data, 0, sizeof(data));

-- 
2.43.0


