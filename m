Return-Path: <linux-iio+bounces-17122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA39A69A69
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849248A59CE
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A92219A8A;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJDsbHo3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E0215076;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=tSh1kUSWePuTkIBoE9ri5SdhD34+hvioCh2DjN1YAvUJNjZJMBxGRwI3fTiXlKTIOhhcp+Wo5mCN4mV/SvnvSgbAR9h/KlOKPqNfHunsuJP1h7At0WdJRK0Sw8KZPkazWlMN7lPANzs5jq/v6JTrwGScu6PoFfHi8gIVMWvwbDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=nue0fWqXOhNi8JxvPMC3lwGb88sVJDfxNM2KXh2T670=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmeiotgqDPv/RQPhCn3gslgyBlW22T5o2CsbFrVENRZ+ugb+DPss+AozvL662GLZDqay/Ye1HGvYzyp7VL6S08AfxUiH0G6FsJEHcPeOQ0NqFs9/qV52s/O1FTxy4TSWcXo4iN4khkUGTXKJNXCkBAP6GhvPjKKtQODpVMRJ8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJDsbHo3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82C4EC4CEF9;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=nue0fWqXOhNi8JxvPMC3lwGb88sVJDfxNM2KXh2T670=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aJDsbHo3M8/6ANZDs+WPbuwUAI8FNg5YVmqZXYrUKIKo/A2ANaxtIPnwpR8/2GAF7
	 tKBKF/oDruqDuxLDhRej5D2ZyEwV/3J+SpsFi032qz2T73DAb967nhT8E8MtPvAV0V
	 JQd+5/gB0g6QGR2M7jvQIu91kmBPxTBwPVa1GGbni0we3klgl0vTAOuxTLt7YkBlsf
	 6E7Qbv820ysLK9IIji5obvWw8L0u37t9P3gT8fs7zO9n3pCKiY78YnFpaG1OPGsE1Z
	 50kZX9UHczDEowzjC+2R9bdQ0ioZkoQJ1+KJS8sHh6ievI4AcKpb61M3fQp/LDos6p
	 PA4eY8/NBuaVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ECEC35FFA;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:48 +0100
Subject: [PATCH v2 09/13] iio: light: al3010: Move devm_add_action_or_reset
 back to _probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-9-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=lxmXVhzbE/KiGpK6qJA+6k8UM9RsJY9i0gVwY5uqpFA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA+2mIlnZ7Ts//k4qsOCt/jeIP0gzh0IYaBJ
 SKZzJPlZdaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPgAKCRBgAj/E00kg
 cm9jD/9j8a2y5krkAfkMDghPKwG65bzMOGiMfuuCIj5JD2TbLRz8zuMrmp7TXNnbecdfO8VVP34
 RkndudsNxfztde/l1Z4vXf0BOTsuBDUYNOsjgvSXS2TxXpodcyP/dzjtgeYAnPSaA6rsdn1QqAD
 NvSEyZ6Z49Ql/tuet6ogK3kJkDg6NsafIh4FrzRsVEAyWowO4kix60tiX/LyNqo6dzcpaDTGuFO
 rGINVyJ06M3+/2FxxOK6ceQbak99dX3k5pOxYhTn30gz5aCk3ZTrG25QisQJ+S8gR8RHJ1QibV5
 ytcFVvdNQCsCwxvng3bWYvH1WolzkTNzBB6QYMxREjMGDDP75oFANs6HhpTYt26WWkkkeyzow2h
 0XZg74JHa4mZObQ+/5TP9XOB5Ep54ZYZHSAJvcfEBNNutKg6ZX5+6FsDDCuQMV49UIu/H0juEuL
 KfgW0qpAFaPGRudUGIhtG3OPjCBchGny1w1AOqizDbTbWof86QxAmsQ58rGMGCgnuuHAS+ZLNR0
 ycIwkUmdkB9LPN25slW8f1e/o1ngR32FcMn8giN7+4mRvMkKcO1VhUsNgxJPahPslfXSaAhV7+O
 dO3V8cqRhY89drdgrTUrDOeeqLxJHkpcQVrj6R/CD9QV0sYO7wPUy7Q5TEH6ZGeAtKnXm4ktDwY
 ijmMGMJqyF8drWQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

In a preparation to the regmap transition.

Improve error handling using dev_err_probe().

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 8c004a9239aef246a8c6f6c3f4acd6b760ee8249..8098c92c9572befe92d00ef0785ded5e1a08d587 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -89,12 +89,6 @@ static int al3010_init(struct al3010_data *data)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&data->client->dev,
-				       al3010_set_pwr_off,
-				       data);
-	if (ret < 0)
-		return ret;
-
 	ret = i2c_smbus_write_byte_data(data->client, AL3010_REG_CONFIG,
 					FIELD_PREP(AL3010_GAIN_MASK,
 						   AL3XXX_RANGE_3));
@@ -195,6 +189,10 @@ static int al3010_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, al3010_set_pwr_off, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.49.0



