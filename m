Return-Path: <linux-iio+bounces-17553-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB096A795B9
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0331894CA8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57B1EF08D;
	Wed,  2 Apr 2025 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc78sARN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85701EE028;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621306; cv=none; b=Xt866Vs34EjcMiUkugRGc64ANNJScADloPpyRaohOJJUpx1fRVMcfnP8zHqDwUcUGfI3gxWXmwJA0imESM4EgyYUCWjB3WiE+m9m4C1Z3K5f/FKHrwT89KscE8pHlKUnji3qB9WuGGFrWFJdcvj7thSPxwYIat2F5GgQFOgOBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621306; c=relaxed/simple;
	bh=t8SlwYvfr0dVPDmeuPmUptlt1LXH2OgT7yF+9hGe7LY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yzbc5/32h7LIAiOwHBVzPYNvP5JRDxdfJmeQGq0m+VyEdaTTmAw5047E0HvqrHdBMAmgolNYx7MtZEP90AkfG5NQ7L8/9w6f1dwwPLUaknj6stXihVyUHalpUbGXn2x4pW+Dpn7K0otyxcUEdBy9V8VVHRqG3IksegHlE7Nyz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc78sARN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B2A9C4CEEB;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743621305;
	bh=t8SlwYvfr0dVPDmeuPmUptlt1LXH2OgT7yF+9hGe7LY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dc78sARNgxchz/KgHK9dXtQWdCPhhIeHRmGmv5a/McmuVhRgbveu2A4T0YQUVKmJz
	 FFz3/SW2XdggyUgiEETH4aeEHB/o0fcKaW7VD1k0KWjcguRATsAteYLNpqL8d6W/xD
	 6rHgXsr61/zQ3xcYpBJNUB5aXg59AZB9xfz2vY9jN2yrZDi62nrkdbhnmvrR47nSNF
	 pb0fSiufIb/WFs8bkEDBVAxtCvDEkF8fG1JLaHPtmIQviy8OzQvuKg37luQkCxECOf
	 5T+fM3V4oHYNbQNPkoLYD4Bx8wk4VRsVcmL2ponuPCYoDkHvi9O6LCXblxgi9ARJO3
	 eUc4BudRqxcpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20420C3601B;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:14:15 +0200
Subject: [PATCH v3 3/5] iio: light: al3320a: Fix an error handling path in
 al3320a_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v3-3-cc3da273b5b2@ixit.cz>
References: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=xUR9gZOnjOoo0snJLgIn15f7Ro6lut1DvCDtNBnZliU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7Yy3HOIVp0gNPuYuFIC9TWknQMBqKiZtTfBDQ
 NHggVCvdbOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2MtwAKCRBgAj/E00kg
 ci+oEACT4SQ9qhj6AogU5XSeGSWVeoJmSF1/gDjIJFsYEk4x+IMWOilEld9etR8R9AVLgIIUz2N
 M9XEf73ktQ/UQNqq1Y6qRuRvWCOWW7QLYMFR6g0ufFcxfMRwQTpHfEQrTJfWfAvR5iDxuwqW7aD
 AhqQOR0tskfNAd4UTdWkKWqILRrcJW1Md9422fRpwNlFasiCAKMhaoGltqJULcFclEAw4y0eVtK
 6w+LB1dR4R8YOU1kQmMJ6a6BzjpYezVSK6dOIBUw6L0UhO2ZDRWvXXPIntRIHq62Gg5XfCt0cXd
 Y4LIdBmPwonGzkVzGkBXeybA1dd7rDtXvdqv+eB3NRt0Um6+swHgVKDA2/BXkwwt/88/5e8afj7
 ph4GQH84p1GCEeudA5uGU64zN29pbQ8T+UpesfiT3XT2FV5siAuNedItlWrxu6bVJZBiVx/eGAH
 JlfIVjOvS3Qc77l+RODFHHDMySEZuQc8gnqN5isvQpjivajDa49PcikSQqZnHbAq5hhTsdRfGpb
 zJuJAeAIlyPpDH9c7R06S9WVyu9EpEcC7ceiWSQXrBXiaOmatqCvuAIb5NBXjIU+Bsvs24nJw5j
 YHDpQE6BMy8L2TIMAfn+VlR993h+krjuEwYaXVeN2FTjJN9uLTZ9vLqKPPRz3OMeGA8XOJlQqX+
 53gPEkok5JDFmDw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

If regmap_write() fails in al3320a_init(), al3320a_set_pwr_off is
not called.

In order to avoid such a situation, move the devm_add_action_or_reset()
which calls al3320a_set_pwr_off right after a successful
al3320a_set_pwr_on.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 1b2b0359ed5dad5e00d2fe584f8f3495c13c997e..005a7664568667b5cf9419baba6764f7b4e8fc39 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -101,6 +101,12 @@ static int al3320a_init(struct al3320a_data *data)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&data->client->dev,
+				       al3320a_set_pwr_off,
+				       data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
+
 	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG_RANGE,
 					FIELD_PREP(AL3320A_GAIN_MASK,
 						   AL3320A_RANGE_3));
@@ -211,10 +217,6 @@ static int al3320a_probe(struct i2c_client *client)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, al3320a_set_pwr_off, data);
-	if (ret < 0)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.49.0



