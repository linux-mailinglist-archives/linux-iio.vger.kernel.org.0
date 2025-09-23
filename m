Return-Path: <linux-iio+bounces-24383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F5B9780B
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 22:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081D84A4A05
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 20:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4114830ACF7;
	Tue, 23 Sep 2025 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X9jYXv3a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0572773C1
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659614; cv=none; b=TK9gj9QBznZxq6GuMgy8m/lMBg8vFJc/ixS9kObj/R7ABAwGGgw0CdF8uEBYu/cXnBxNxEKzR/kyWsNynEJMuHnNNxN0kVmgDMIV6DtPC6Mz5i5d+SGpW8eEjWTuKed6OnbF2adM1iYMTKkvvhqEmw8lr4fIiS79g3VJJxTL/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659614; c=relaxed/simple;
	bh=+DhdgqQltkw2hScFiBAxkQGAjQ2e6q78cMhqyHEpH7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u0W+qQoV0dZ5srt2IK12B1sc3yZcofAUmOQJ5MOoyk05FRycNO/NbAwkQf3jPsXFXTPJShxj7ZIpBnyCJ4dfPdJF5ggI6FATN6FdTXgh1L5L0eB/iFDIJMMjd3GeR5ghcylUXom04fMLCHzJLpFNdDl25VwBeZeK+IYh1uM109g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X9jYXv3a; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-31d6b8be249so5538628fac.0
        for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758659609; x=1759264409; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZSTjKSlX0R0kFR5RB8/EHp0gnnUio4a77VM37necPs=;
        b=X9jYXv3ah00+V/ZZFqqYEmN9QvePOWznc2l3BxtJzBwLFid/HIn+SqJ/BP8qH67oAQ
         9Ci0Fn+05VO4hrEIVQiKcqKqGy25x942eRD9j9skteN/hE65076iI3/1Y7huOLfvLqjq
         h6xwKSXZpP/hcXBuGIGeTbgkEerU1bbufSQnh6CIydxSBYKJX1H/Bcuc3/vGwVkv9Lnt
         i8BAR6EV/TBqGDhPMvQLVh3/RHD5jS6Nmkb2w/xFd4kX7MyMSv7TMETzkLRPko6JJPpJ
         X/jDE8njINGg7ERRCmzvHZFiYcGsUfxFDF/hOAT8jFSL7rkqqu/lxdfrEyazzOs/IHPZ
         BLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758659609; x=1759264409;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZSTjKSlX0R0kFR5RB8/EHp0gnnUio4a77VM37necPs=;
        b=pbhkyb681mnajbjRx8pE/fHtRIgY8XXTyL4r/c6PFTKL2apc8KM2biKFqlBuNFXJ/p
         o7wZIT3i4jeDMrWKvHavchv/X1iSFCU/q52W/jgGa0HLuoY8IkqZP0amlGEQxd45SWHq
         D3CtYlHu1HFlfH7mxDZNIUynqM5utzhTUgIIZEaZh4gx11qdKlo7K3cQbdOnmDZ+FLzf
         +7grELA4MnFQ45gRHNq0I8MBeK06Hp/3am1iWc1sf0bZwEacYSOOhPOqCoxuzGl4uj4d
         qDv9fd/oY3Z8w4CvhVDIy6qUY9Bn6GpneKZmVhRLfm6UkqotFGxlE32vxKWboF3a6ROs
         tO2g==
X-Gm-Message-State: AOJu0YydtTx7RX+vQqUPOkKHBo8eNMwWEnpnEUmAvNaUgjY5IJGTh3O4
	T3JZc/e2DgczY3N6VOvsITrzrA2I1JLEJbJhDnbxwyHWlLy3/dOdksVPe/Vxp92veQI=
X-Gm-Gg: ASbGncuyRnuxMB6ooTBYsLpAsdOMSk82l8lCsHyRhifwrjfJeJ5mZ6v6rBfuLso9N4/
	BaESx+QqHqoACBK0Cxdjm0MEMrxO3BKgivDJ2/C0z3hE0f7M7aQcCNMq1whPbyLONcTxVggPEYl
	a/lhyrnQyBWUtJ+7ksn/L6P7Dkw/U6hbVQqXFy8Zm+4gY+xUz/N/MRU2QJQ5jfb+IhJ+saN7deh
	IId49wcYiPWjDbjsAjiLYpuKsw1OToTTakFZWqqxqEZ8aVlwfikC3VlGddjsl2y3b34Ykpw2Lbr
	AsJgfNQOAZz9Cg5f8oTDVO5OWZGM8ZjceyVwDg7ByYEdjCpz8OVLquBxAfFnSJJS8LDy+btSB7I
	WDg6700cR1v2jQAWF8v/4ZE35MqfI
X-Google-Smtp-Source: AGHT+IHcw0owZw1fn+XSOe1OAyBiZr3BP++yAhZpjUvMDxjLzrwigsK04pPk5tdeb9uhj5lMfsfDjA==
X-Received: by 2002:a05:6870:f683:b0:315:b264:f221 with SMTP id 586e51a60fabf-34c807ef85emr1887144fac.24.1758659609094;
        Tue, 23 Sep 2025 13:33:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e5a2ab2esm9453116fac.17.2025.09.23.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:33:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 23 Sep 2025 15:33:18 -0500
Subject: [PATCH] iio: adc: ad7124: add ext attributes to temperature
 channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-v1-1-173baac28169@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAA0E02gC/y2OzQrCMBCEX6Xs2YU0tUp9FfEQm1EXtK2bjRRK3
 934cxiGbw4zs1CCChIdqoUUL0kyDgXqTUX9LQxXsMTC5J1vXecbFhk5xL5oX/ttsciYjYOZyjk
 bEtvIhscEDZYV/KkZcOcYu11Tty4idFTqJ8VF5u/08fRjxTOXB/YP1/UNlVWb4p8AAAA=
X-Change-ID: 20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-dd963150dea9
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+DhdgqQltkw2hScFiBAxkQGAjQ2e6q78cMhqyHEpH7Y=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo0wQQeh8R9pqHoBfjPTMxGPyrY91yBOail7dSW
 NRDMPo2qd6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaNMEEAAKCRDCzCAB/wGP
 wESDB/97N29ff+hTa6KyBgItw87M2niMaRLBtSezsIUxe8KolSICaxBNS58szW6IRLXJzHqAl2r
 A8Kpq7TNo1Vwn7hUpgwC6aShxp10unK7PcPmKkh1NfPc2FL0RUyZmwCsy9UvjDjc55Y3ReMexSE
 NJ2cw992bpZ3BLlrlbdEw7KYPwzg+AGwtzF8aFlOBJOhCa42KBmtl2/u3cSfPX9N3kJK+irnd1a
 ZO++tR9PHMhPIoaUwjoW+9VqDYQEUsm1izfktk2hl/c4/PtFKU0GodoRdnE/vS2C+NPvEvHOzyg
 02Ykj6w4nNKuNTqlT57UWuMPxozM3ns4rUqsTvtGB1AjOWR/
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use the same .ext_info for the temperature channel as for the voltage
channels. In the ADC, these all go though a mux to select the source
and otherwise operate the same.

These attributes probably won't be used much, but since it is trivial
to add this, we might as well include them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 374e39736584f55c1290db3e257dff2c60f884d2..7ed31399a875b76be08491f56acff55032c95ced 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1348,6 +1348,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 			},
 			.address = num_channels,
 			.scan_index = num_channels,
+			.ext_info = ad7124_calibsys_ext_info,
 		};
 	}
 

---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-dd963150dea9

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


