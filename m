Return-Path: <linux-iio+bounces-17128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD4AA69A71
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF3C189753E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5819521A435;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McREUvBj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34B215F78;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417986; cv=none; b=Jq1kdDUqdD3XR4EESWejX5ft0sNQBN5iF+XdP7LUgMBjsZgJGniSqkdUUADIKmE8MXw40BdzlLFzzw0gMY/7/OMyoYAvgiw0IHmfTDKe9tmSIxny7TeJzYQNnHOFDJ3fhCCPGSZo5+dflcRKUVsmnZwf8b3ZOuUZQ2rG0Fl5dEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417986; c=relaxed/simple;
	bh=dcbJNZwgOgHVewbA7jxz5V0OKX/waleHhfwZA91/I1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7XfYIIjeYg53AENJnZBc1azAdfCMvhaAGNDxQvxFRduqtX1fF2K0ZhPMYaOGA22Ef9xh2eS9TKs9qP2AnsCJWfkWKDZiAgA1tGUvvWeTacRZ4xx1jLnoRk7mF/oMD21O0ttL9UlIqRU+Exfd742AW7I2A0QZG2yalUcsDXKVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McREUvBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 912C9C4CEFA;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=dcbJNZwgOgHVewbA7jxz5V0OKX/waleHhfwZA91/I1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=McREUvBj8O2I/I4KZXr0OS3FD/2sr/Nj0ax6EAOtd2TaDPgwkKRE6Nh+x29NmLbnP
	 vjV8rdfY/nGkMTlRxRxJXUuJpUp8labbvd8CZ/I8kezM9+mKqTmNk8FQvpwTst3UAP
	 vSyA/Rnw9lCvMBjEgOW9as8lQffU/Tc5K23R6YWWfZtMvF+7cfaaqN+J8urddJ3eyu
	 G1WmV/ktzbD3HPeTbBnsoD96MQHOj6yLnN7VO8jwo7BM1vtYH/ZvYQ3LfU2YGD/s/F
	 tPyWfIO6GzlC2Rs2/K5gsJaY96uIQiPVpojDQV/q8095IvUUS4hpCAlfu6gC8z5QQ0
	 2RnAG0rLzP67w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87649C36002;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:49 +0100
Subject: [PATCH v2 10/13] iio: light: al3010: Improve al3010_init error
 handling with dev_err_probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-10-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=U+gyu2giS4hLLAaP3knPJNMAi2dd0lLS/xGNscKmGCc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA+6UW4pTZ7TSIE2lofczNz+g9UJ/qu6PDg5
 aBmh+cDYR6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPgAKCRBgAj/E00kg
 co5NEACXcv0zPgnlpV8JIFGudofxcsi1tp9n1jUHFFlcZ9D7hvRgidJZqmmX6P1/XMYvaHW0PLM
 0kg8ZEFUy4YmewBfM/FUMIygQLM7HjiwyQ3VP/TOelKD37GA6CORJ7WLo7WifL5oRuNjWcAmS/X
 3Lz7/Lr3rCG1ohB8KCRIituClAVaJD2V/my1pxNmkqlmec0U2pFRo7fbeDn1tmlmPtyYrUw7M48
 SlIsv1kQWukdo/zvIBadYuIzE4H415FlTKDv1mzcKzW5syFsrzMgbAeKOZCixZhMJyjToch5vmv
 mdGAsXiuHIZjNYCVUrAksdSeOsJzFViBMBaUfgdW14fj2iFttJ811vIxFheMYiOggTGpeK/zZDP
 wDZ3Q3269sLlwbP472fOl1RZ56G1lz4cKcQhB4pUN5vdWIH/ytWMoKzANcJb39lg7xffpJaHgoh
 0j3xSAtyoWofcYxToFYCtl6WZJfwO3rW+Pets6Dw+jHlHk3ZOGx8jK7QkFIvGpXDezprWWhKafD
 +7WSUCET5aON3NPOpynrSp0YZw4eTCdQqkyNHiVE5iCGVRw9cGcCWGulO5rdnkKcINfbWQLKwZ2
 JrcrL9CR7vQjTxqeOQkM+bcp1k/kJDe68r3TdLN4mejN+XORme3kA2gINXte9Z7HDBUEix7IRoP
 AhMxf/nKn9vArUQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Slight simplification of the code.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 8098c92c9572befe92d00ef0785ded5e1a08d587..af7ed028259837f2232f30072b87cc0da7c77f37 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -184,10 +184,8 @@ static int al3010_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = al3010_init(data);
-	if (ret < 0) {
-		dev_err(dev, "al3010 chip init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init ALS\n");
 
 	ret = devm_add_action_or_reset(dev, al3010_set_pwr_off, data);
 	if (ret)

-- 
2.49.0



