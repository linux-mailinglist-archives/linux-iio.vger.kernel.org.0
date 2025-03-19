Return-Path: <linux-iio+bounces-17118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6F9A69A65
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9477E8A6029
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F6215770;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyUnKf16"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97832212FA0;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=JODHDH9uDMCDhun999pOVt36HODUbO2NIXHWBZFCoz2mZKf5GwtEkSpikjlcn0Sb6SLsN7WirWSRPQFpiFKuhavtHWLhT4cv0WXxky7NXMKZZuuUZtzF/hXlwAanuqaUFtEWgRrcmVrOQbfR0IIFS620ekRapzip/gyQ2OZ33rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=74QYptDcZNP8BaAZ/7MDrHdtgAQUOZcKjmL3HZn5Uk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9p4RahNgrCoIHVR4OG462iHaf5OHq2fupj7GwJ8bZVCJs7y4A5LJObiPeb+jSQzicI7UDTMnAFCnO13kQAAWHC0uTDn6VIx3InYNU4Ams9JZ6KDHT/zX/K4fnPVkwN9UpZTdBSabMMck1tg3pa9ZhhD5qHwym386Ysl7mWvoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyUnKf16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 309F3C4AF09;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=74QYptDcZNP8BaAZ/7MDrHdtgAQUOZcKjmL3HZn5Uk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iyUnKf167lC/tdyndLz8CKiRo96Tj22uXH3pB6B21RtlYbLoqwW+mQPcQCkMkCXCX
	 mEsYK03K+XtD9u4oYYV/T+rQOElde0pzbfziBUXGrWRjaKjFbrYLL6le2U2Zd3+RO2
	 5FIbIEng/CZgX/2pDCVrErX/GvoNn8L7z5HXy0Wb6MMjGH/jKoePaRWAKJQuNqc6j7
	 ybUD9aqdTG82+JS5wa0zxtmGQ9sIaBibrp52Y1AVpK54STEIsqks3TsM7OaZreN1f2
	 QwOtrm3ygx1Q2T0izQDM6vfvN5zMQ674Lk7qYmvi8dWhiWZVqm4dW1Uk1T/XMpVWML
	 uVy2zk17ilpGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FCCC36003;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:42 +0100
Subject: [PATCH v2 03/13] iio: light: al3010: Remove DRV_NAME definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-3-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=rjD7NN5hHGkzdwx0H9EXzCR9U7T+XzOGq1m3plbXlAM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA9al3AYypMpivfMaBR1hM1f2Y7pM8bS3dry
 CzxjkJTbj2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPQAKCRBgAj/E00kg
 cpucEACjlvOHIMuHfuq5nzpaSfeMcnWUsm5WePgke94UZjrUunMzIVhjS7MpzSKu5Kq7YNSiOI9
 n5PEZNW/bq4tAme726JfDF4A9hveQhHEOwJmj3pa81Or8SBXiA5pp2PJY2IfoYM6KN/rh7W9Rzf
 x6XsfdXq0NI9m3X1zztyK/oK5VGYA/67UaShLtFKH6s4r/gxp+iyHvE86dO88NBtZQnTngQGXVR
 FNC4fKZK/Plt7ImP66lhFxbqmHW3Jg4PV7dktE7Vf0+g2pz4H1tG93Uq94UzIHuh0FK94x/Fifp
 MZjEdOowVt9bDYakZTfABwVUO3CYpgTe/DUTvp/Gt2rxr3aMDqkvUIsvLJDEIfRDBfcLLez98lA
 EjZ8UCNdpJX6MxBoUkkuJWC0F2Df8dytkngAOzSaBYULlXO4otgwxoxvwty4jMZ+Y/MER8wEY7Y
 iBomR+fWFX8s1eexbUj966X21OVtUj8HjNPsOy7XdVYUx502pmBrxszX1ApCoT2ONv+BD7kBa1p
 JdtkCqMDkt8/03bAhKvh2PO0P7HLaTXBaPNWR79oG52ZbIQK4p5aj55YXy69RxMkBRoRJilcDej
 dPR84mpC+wYUuzJ9maV7hJurJFNoR0HDuh9r4qAIq+OMhP9iu3AWijzRtkT1ccVP/5nCPaS7GNP
 56GijoWPvme8d3A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The driver name should be passed directly.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 4c2fd88ab32cd73f4735b0fa3014af084037c94d..7fe91049b55e57558aef69d088d168437a6819ec 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -22,8 +22,6 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#define AL3010_DRV_NAME "al3010"
-
 #define AL3010_REG_SYSTEM		0x00
 #define AL3010_REG_DATA_LOW		0x0c
 #define AL3010_REG_CONFIG		0x10
@@ -184,7 +182,7 @@ static int al3010_probe(struct i2c_client *client)
 	data->client = client;
 
 	indio_dev->info = &al3010_info;
-	indio_dev->name = AL3010_DRV_NAME;
+	indio_dev->name = "al3010";
 	indio_dev->channels = al3010_channels;
 	indio_dev->num_channels = ARRAY_SIZE(al3010_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -224,7 +222,7 @@ MODULE_DEVICE_TABLE(of, al3010_of_match);
 
 static struct i2c_driver al3010_driver = {
 	.driver = {
-		.name = AL3010_DRV_NAME,
+		.name = "al3010",
 		.of_match_table = al3010_of_match,
 		.pm = pm_sleep_ptr(&al3010_pm_ops),
 	},

-- 
2.49.0



