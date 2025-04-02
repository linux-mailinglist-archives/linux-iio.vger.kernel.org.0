Return-Path: <linux-iio+bounces-17555-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B7A795E4
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0F21892B11
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E41EBFF9;
	Wed,  2 Apr 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb7TQ8eR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE765537FF;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622412; cv=none; b=CjwhN428J/yXvYnWb3lhlmMZ5P2zdJoO+/MGicTuBGSCpH0dYEhFFjqxTv94w+kYIyqWMYoDMagrDstKmltuC4NexuuxfXZw61XTThLevv6NLE+5sd4bzQzgy1a6z4NFj9ExCkGTBteNeImv85Woxd/NCMGzkS/qNIEd/e/XmkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622412; c=relaxed/simple;
	bh=y8pgi5JtduylthuSaY0K3q7nUbMsc3wf6FBuvAUREpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=foBkz7px02xiWmlazXAbagQtB6vUZ9USerbMypVvnNDExe7Dd3go4gLtTMFxiVsIL6AzU3cViOT/LK1SBFXA9IZrE98GKYkqikX06+AL7kE8RGDbnLyg0K16Ll5e/zAOH8lzGFBCPW4z9+lK3VPM4KtbjFZmj0GJhJh2pmCOlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb7TQ8eR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EDFDC4CEEB;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743622412;
	bh=y8pgi5JtduylthuSaY0K3q7nUbMsc3wf6FBuvAUREpk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tb7TQ8eRPy9sdmFdTjdw28t8oX7M8LBrdmH1ZBHmKoBSMB6sA3oPZ2hZLGR7GavJh
	 AWjW/4a8WvGTk9zzvDg30gJjO/TPIu33zDi13rUqRlcvLg5hKHQzaYsKjS76asVN/x
	 RAwNTy7GhNLp2y1aMZMdaOxZdS8NxyAEyN8a1ZVuN9clIUMca2o8UCsH3+5shohqVX
	 +37DfsAGEtXdUf9F3srgMO7NuV+SDZWQZJtD0XFpLiHvpfmTJviPCEpyoiHZUY0cf1
	 rQBb22lvnFd29G9Wa+11ia7FvIiTn9M8CBbfZPTPTZGr6AjWsVV+hz4qyesQvD4Hm9
	 PO/m06JFToKfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415A4C3601E;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:33:26 +0200
Subject: [PATCH v4 3/5] iio: light: al3320a: Fix an error handling path in
 al3320a_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v4-3-d189bea87261@ixit.cz>
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=mTCyccBifllmHJInqLXe+hdaL4JlCXkaIIsicpjyZMI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7ZEKD01cnC8iLLj/aKn9pjzrLDbyH8bXtPAtv
 DYzhSepiJmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2RCgAKCRBgAj/E00kg
 cn40D/4rxElhV51cdYCOw82WrQd5fsVyC4nEuiCh6arve9ful8lyPDhnPhg6MetJKlLfbs0WajM
 3CLobiP4r+k/hpdQDGdWp5tEaWKjS2V9jIwaUcH+YPRTDthrELoonuiuz3jQs9DUEE6IdYlED3m
 K0mZYyZE9McWqU4dflZnSL94SdQ0PUyCqdA6gO0OMg0/9NHcW6UF8dawdpUQg4WEEw618Xux2b/
 FLm2bRHHJd3Ex8gpmxe/bX/vxo3KNRG7YZpEeXX4Y6YNlyRQ7mT6bjAiN1BrmfEs9DQa07+WKa+
 1tnVXBGrgNDWheBD3V0L1u5GOfJxN6nXZEC8c5uRFsMGNEr+BSDRZYv/CPmE4tNjyXRIew1XR2J
 MnLWn0rM6XaqEjF64qz5LNaHCkHXJdUdMJZaNnIfRf64u1Acz4s4U4UQjkJEBLad++BYEsMmXat
 n1Br9SUN7Djazuzk0HIb3ToFHxl/OxxmGA5GT/wRSXJ3/wCAhCS3emABlcJc3XCnxYo0D2KNA7N
 g1f1sJO/NTko0v/N0W4atSQj93rGZmz7HTe6wRHBsxcT/ofVhVaDoFXSI07ApYztjxblVXd9eiU
 5rYS+IaxRWEis0D1cTP0k/XZq6jxe6Au8KpS4+E7IXbF2INLTCgsuXBB04thIDA876bJkmxgybW
 ivarTCdU7lFr+Bg==
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
index 1b2b0359ed5dad5e00d2fe584f8f3495c13c997e..1fa693d54ae2a6e5ead3a9c7ac7018afeba9b760 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -101,6 +101,12 @@ static int al3320a_init(struct al3320a_data *data)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(&data->client->dev,
+				       al3320a_set_pwr_off,
+				       data);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "failed to add action\n");
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



