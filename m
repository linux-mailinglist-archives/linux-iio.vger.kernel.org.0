Return-Path: <linux-iio+bounces-17127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB12BA69A6D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 22:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE968A53F4
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B221A434;
	Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pixjo4KT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CE215F76;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417986; cv=none; b=Kyj2qi0PT7MyNUQS6eHN5IBmW0FCVIG+yKrtbdW7kLr4tXuja4Vl7Ik0MrYHU5yciLKiMmbIYWlxsxQQlpxzmwKsnAMs8xWCX9THu1pMugX+QKjtLyfzQwoHgSolsNZ/UhiiSm5wPDpqXIrlhHarSzX0FNiTITvOIs0xYHjJPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417986; c=relaxed/simple;
	bh=gnwvgtMN52Pwrzg0aedlK+V9BrQs7Wx7efOOAr2gKvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZBtyb2R0sA/pnsKkKAldw4ETMybm/qeZS1I5sXSYN2+bPMlW88zIPqqy6BaZOGNkEYNbQZjBl6p0tQ5iaOUfNm1qziX3GFPWRCHqPQ7UrpQ5YWRaEJdtyIZbTuEJGaEDJ7pcX77bNTnK+1u+whK/wvsJGIo1nWkKmrNdeZS+6wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pixjo4KT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D0DFC4CEFC;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=gnwvgtMN52Pwrzg0aedlK+V9BrQs7Wx7efOOAr2gKvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pixjo4KTEufcmpXB6JwW9OPQly0GJXLmAKRbZxCIm9yRUfCotbNW9ig4yRAVV9ydW
	 slozjkw9EiS89dSAJxpb1F5C6nPdTTIsopTyPhnWh+WBnyT+VFMQG/0RYDNrgNNwMw
	 V1vwv9l9GwvJaUAgHwtXnFcyZLEif5ESdLmBsgq17K2hwe2gcnTDKzCKlTjpp6enBA
	 vN1J3ai0fcQKYsvECXJ1T5jIWo2j8jn+316D13TgXtRlbD5YXZLijzA1bbwGZzEvvu
	 VNP/goh8DSgpQqd4f/liKfjw3vPFz4add9U2HN93o5t/KbE9Kysa0oOGzUBBjfptP9
	 Nrgnc897mQIlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94560C36001;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:50 +0100
Subject: [PATCH v2 11/13] iio: light: al3320a: Improve error handling with
 dev_err_probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-11-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=986; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=ZDkoBVIulq1cvMnCXDseiCDdnOJkjxiu1pAE5heNCiI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA+9HVHS3Gw6TUynM2zoj665kSVRiBUCkb9H
 ihXRUBd0keJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPgAKCRBgAj/E00kg
 cqWNEADLu6eFtloKSuyFWtEppBrRsu1TKUXzpTfpo/P9eGjGYtMmCY0Jvm8naaouakGmp+nQkqa
 lzw0DvPSztb4ztCj69KIRtOufEq1grItt1iH15FENy8c1a8UK4r9MDAoeFWz3/XlgTHIyFvtm9g
 SDA269/5WKaOMn2Key85mDl8oED1heoTyjHsQC5SnAs/auP38xZakWlTDPEFrAjGluUpV9Gxi65
 9bAXXb2V98w6s+VvsQ45Lo5j38XglCvnslweAjfdyH6iqOEHqzKDtqASNlzLoEmX46AlYDMjKTe
 1V63VCeYVjifmVlC6nR+lkT5FXgW2tR8rgWqilsqieFxbpuqz2ny+KHgLPcQjaFU6UQqJnfKuGq
 bYWafQz3UCMpYZ/n5N9xEFelOnfIeBsHBXkV6vs2mT3dMCBHQ1IP8byxt34xelrKjHarDHPGPmi
 Wv0zr8Qz/Q7nhj3TtjyG+CiYamj1MIO93igJ2W8PWLC+WFPMGN4ujaq64jNAk0VYGDRgcTMlDJm
 xSUbtAVvJV+p6JGqrxuQflqdLFLLa8H0bIc/LGJBCqxllMcVhv/9q8NKbEDFJOOMQvKqkfWWYO3
 PJQHj4QJZjmN4yUbkwRparMw8qhksECejnPDuCp6z9CVsWZCPFj8YfjtSRhpaMM7j/Xios2QfHb
 0dwlvYQo9SuSueg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Slight simplification of the code.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 1b2b0359ed5dad5e00d2fe584f8f3495c13c997e..1943e6f34a70b00b5d732dbf4ae6ccb4376303b7 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -206,14 +206,12 @@ static int al3320a_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = al3320a_init(data);
-	if (ret < 0) {
-		dev_err(dev, "al3320a chip init failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init ALS\n");
 
 	ret = devm_add_action_or_reset(dev, al3320a_set_pwr_off, data);
-	if (ret < 0)
-		return ret;
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.49.0



