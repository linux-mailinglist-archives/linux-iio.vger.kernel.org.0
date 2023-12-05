Return-Path: <linux-iio+bounces-649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B736805AB6
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 18:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C331F219A9
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1357D692B2;
	Tue,  5 Dec 2023 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knwV4FNa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD726929F
	for <linux-iio@vger.kernel.org>; Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03984C433D9;
	Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796006;
	bh=9euPM8fcQcmDfI+ietptv8VMBXvl4pFwlJit+YP43hY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=knwV4FNaLnAaQl/xK8CWaLx1G7Yj//jbQJrbT8/H7DU7STbtdsbNCJGeLUp0GPs4Q
	 zH02FjN5IMkY4qQ9kEjZKZEpNiLloiIDBq4ztN3o+6hOquckcYlsPkvNYl3UkMIOA6
	 WZm0HN2OESQkqxnJrWyYhoLKBEFakI2t7ghMUJNPbOvT7hNdB1lG65PCUj7A/m1tSm
	 zo4aJSr0mqdPqOTfdHsVjxNaCOFkm8tc/+NyxXrRIaKPEencgDOuaob3wg6V42h410
	 ISzDKFVUXn/o34TFXHxw2lbvwv8ftRRXMWArvyC/dlbExgS4uaVp63js262mlFRDCF
	 5ap/fZUCpkMqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B4C4167B;
	Tue,  5 Dec 2023 17:06:45 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 05 Dec 2023 18:06:45 +0100
Subject: [PATCH 5/8] iio: adc: ad9467: use spi_get_device_match_data()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-iio-backend-prep-v1-5-7c9bc18d612b@analog.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701796004; l=686;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KwOoDJbfeKxv+O783O7duvsC7KCPDrH8MqqvCh2j2jc=;
 b=ACyqsphlXIDuXvqbAJcHv8gAMEISv6L/6J5c3+Urd4EdPSovL+SwSa9MknGlfJAdB8AN+7Xaf
 Zqvq3Q5WI5/Ah3xg5/nR3TdYz9RHKMFPLGMic3kZFe3DDmPI+N0p39E
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Make use of spi_get_device_match_data() to simplify things.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 3c8bd6c821a4..6bdbd0ea8d6c 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -456,9 +456,7 @@ static int ad9467_probe(struct spi_device *spi)
 	unsigned int id;
 	int ret;
 
-	info = of_device_get_match_data(&spi->dev);
-	if (!info)
-		info = (void *)spi_get_device_id(spi)->driver_data;
+	info = spi_get_device_match_data(spi);
 	if (!info)
 		return -ENODEV;
 

-- 
2.43.0


