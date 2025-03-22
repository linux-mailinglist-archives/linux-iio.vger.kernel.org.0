Return-Path: <linux-iio+bounces-17200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0436AA6C83A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 09:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC47189687C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C665F1DB13E;
	Sat, 22 Mar 2025 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYwPFdHd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1E1D9346;
	Sat, 22 Mar 2025 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742631079; cv=none; b=q9XPet5PJyu+C84v3NgPEze8U0rWjd35sCnqMkfMrM+JoUvbDto9ccgdTb8H6rJr/Ho4xFWv0Kj1/qRUyFnQY5ZbeQwWN4jaMBlt4Fgs5awQckIvvFhcu5c9ZktRAtsWXyQJ4+IiMa7OiGcrP94eMEGhTOv2Ctip0rBWdvOiwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742631079; c=relaxed/simple;
	bh=EMXlv4ic5fl8PS+RPv8silscyyAIYSdykCBSgcPPdNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQvVfrezAK5Al08lZx7wxI31rnnNjC8M2Wag631FJGVMnhfEtZKw03P3BnCQokJf14fYDm0ciBbIMMP4NcAY6mQNAgzSw55K+mkwfCfH7s1DLeKtRSROuF3rwIWkgI8D/pobvDTFjUcWHR84OjKsIaDO/wjBpr3dANAGLE79m7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYwPFdHd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2255003f4c6so54984735ad.0;
        Sat, 22 Mar 2025 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742631077; x=1743235877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxQ3FviK2kzacgD7SuLAezYZnCdIW/riaKpvcF/c7M8=;
        b=KYwPFdHdSv76eiB98M1GJ1G0duH23nX04HlAzw2O71UCmjTAbS4nN+dbbVdty2/2XT
         Y/qB4ne84pb/OaeICCEnrKRKZrqe05JgbTY08VUKkPjiLfAZCqyNSyxGO51xAJzchX1+
         2S8BDNP4a5GvBqHKeXbxLEUGchMRz+t+lusrUVrwbwpEmzZz98aU0VON4AVrTS4y61qg
         Ag82smHHP7oIj2KANGjiM1O+yOHkeqHaxm6oHy36/VDYwuF3bbl+12SkcVhrC1g5xbCM
         phAFnI4qCQ5FFdSt11cRI6TTa5+KM0I7AubMKHIrNz76lU7yphv3TXJ4t1qAOMzQgt7k
         R19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742631077; x=1743235877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxQ3FviK2kzacgD7SuLAezYZnCdIW/riaKpvcF/c7M8=;
        b=NBStkK1VSHiezTO7zvLa0QMU60Y8tKXmXu1V8jsNHDiuhqofKI0mAhq90H3K+Q6Zsj
         iRxdgPJACEG0LOBdCnOcg09bv6lOENm4le62d4l90dheZGI33OpI2NwhUdlL4V2pZ/rp
         wABOCgU/JSVdcHqwQenioUxo2d1W/eo9Gi6zt4HE33RfXWWuob0MRsU7ueorA2CNWLrO
         MiPmvjiheG7VUhT3cOapK6AgDi//DvPw2GhjtXpEo9UIqJqr8s1o3TCc+3M/KYq4QlaG
         Zqw/iA6tvAmS+YH8+2ujmP2ntMlrSzzZZ1fAKPyAd9VBYBHEn2PPtnrHHlzqzp4QtI4w
         T4EA==
X-Gm-Message-State: AOJu0Yz83PSt9PBM+z0qdgSwFE3wDcs6Vq5KlxrOMntIfy0YrEQZX1lV
	u9ExeWUozixcO5Ytksk8I+fHTkrbTMSlpRsWrueSPKKkr53crfVkpeozSJWtM1c=
X-Gm-Gg: ASbGncv1psprQ5+6Ae9vwr/EjNXRbFww1lruunt+IBB9ufxnkqjnKMr0Ba75VXICzdm
	5bQNnFNyaUhje36KIh98FpUiREkc3NiL28XVtG7z6YADRJJL+OjMFM5Vgu9q+YhW+/Jodrszap4
	lnuBofITYg+fRcuYj7mhFbbvl4orwXJ6he5zo3NY4iN5VoUG57l+a6SYiEzbIP75bdzufKgVvSx
	qD8ZCRhFgDad/ZnGJGeeYke4xsXocNy+xPkyzq+8SemTlpYAhCK51GSI1DOWGIJyXo0x2KhwgJj
	Y5Xdo68IYyHe7LO8njpAZpkWHJi6vcG70BbUrvh1CbhvfwKguTZ0HejZbVmxd0T/WwE=
X-Google-Smtp-Source: AGHT+IGXVGrhCfAgzl8PH74PCvBmx8kO7jjtdW5onn48zvWslZ4YS3oA6WzT6aineM6+BOoJJIAhhg==
X-Received: by 2002:a17:902:d488:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22780e29ebfmr94634775ad.48.1742631077110;
        Sat, 22 Mar 2025 01:11:17 -0700 (PDT)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f651asm30395385ad.209.2025.03.22.01.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 01:11:16 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	marcelo.schmitt1@gmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH] iio: frequency: ad9832: devicetree probing support
Date: Sat, 22 Mar 2025 13:37:45 +0530
Message-ID: <20250322081108.202654-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce struct for device match of_device_id

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 9a27acd88926..506478ddede3 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -439,6 +439,13 @@ static int ad9832_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct of_device_id ad9832_of_match[] = {
+	{ .compatible = "adi,ad9832" },
+	{ .compatible = "adi,ad9835" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ad9832_of_match);
+
 static const struct spi_device_id ad9832_id[] = {
 	{"ad9832", 0},
 	{"ad9835", 0},
@@ -449,6 +456,7 @@ MODULE_DEVICE_TABLE(spi, ad9832_id);
 static struct spi_driver ad9832_driver = {
 	.driver = {
 		.name	= "ad9832",
+		.of_match_table = ad9832_of_match,
 	},
 	.probe		= ad9832_probe,
 	.id_table	= ad9832_id,
-- 
2.48.1


