Return-Path: <linux-iio+bounces-650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5849805AB9
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 18:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB49BB20F69
	for <lists+linux-iio@lfdr.de>; Tue,  5 Dec 2023 17:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281A692B1;
	Tue,  5 Dec 2023 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IugFukPu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70911692A0
	for <linux-iio@vger.kernel.org>; Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC2EC433AB;
	Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796006;
	bh=lCObtoTpSqkaFQwyOFhNJ1ryAu4Gcs5xCQOhbPA4SMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IugFukPuXBBRW1lreAmzjRw/SWxikJQjbilwC8Cf1WtTUh4ejHVk4pGGQAEIh0fJu
	 imlxEBHFQOWbqgMn+E5u98C93rRsaJfvJHxRWauhsN/wnm9aL5tu5nMk4yibFBMOk0
	 Z188+4t8lPwybxD3C9WIGPB5ncCVFA2kfzRq/diUT9NXO9FDF37cG0rVAj7nx4E/lK
	 N5VRV1eCyrrjwWzfKO63BwaSZkR0g3XqUDyoflMbWR4hpd/7qXZsYP7JXromzczlME
	 j1Ib+EtmkNOL6mpNRXDGcIAMcx9Ce4d9oxiN/xmxzG2LTN/41QQMpDYozxDVA0epLy
	 9VCp8PZW5SkKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9EC10DCE;
	Tue,  5 Dec 2023 17:06:46 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 05 Dec 2023 18:06:47 +0100
Subject: [PATCH 7/8] iio: adc: ad9467: use the more common !val NULL check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-iio-backend-prep-v1-7-7c9bc18d612b@analog.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
In-Reply-To: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701796004; l=707;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3jM1tUSsUENHFVqpXxzR/Yo8ri6HTO5FowZWdC38P+c=;
 b=puuU1b0SdAO4L8t9ZAspVLPBtIUt4FOZedOvK6dpK0P7rCQwwtLtNKdQu+4P/hQ4K8yvkT1GY
 Ez+SKlkCjXqA4JyGY43Xoc/SDvd2DR8yWhZ8ghLHkOKavaOPMm/X0lB
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Check !val instead of directing checking for NULL (val == NULL).
No functional changes intended.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 0d075e6b6248..637823de712f 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -158,7 +158,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
 	struct spi_device *spi = st->spi;
 	int ret;
 
-	if (readval == NULL) {
+	if (!readval) {
 		guard(mutex)(&st->lock);
 		ret = ad9467_spi_write(spi, reg, writeval);
 		if (ret)

-- 
2.43.0


