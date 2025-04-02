Return-Path: <linux-iio+bounces-17558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7973A795E6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F26A3B1934
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE51EDA24;
	Wed,  2 Apr 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ylh3FAwH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8551DE2A5;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622412; cv=none; b=ljkG5AIgDgF3Ss/lQpO4WwwwuA5lcj7BiA9UOVJa3gAXTasQJL4knEkr4HLlJE8+y2NPHuTzkfEDBJvSmfMg2V3gL1V4we+MDH8vyOJuHZCIyjXl/nAMh/hufgZVAGEwiGMWDgGhwFIjUgX3XL8Lo2F4BSDkUPslGdwlNvt3AWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622412; c=relaxed/simple;
	bh=O2TGhCtbwyCv/uYpcbYa8vSxgrjrVO0TZfOd0YOOx3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFaUlgvyRW8fEXCHHKEizTIPTgJ9YdZnDDiQpci/+CMbG+mxn2fef+ddhWnE5hga4OltnRCDTFydw06w7aF3w6FDjiOPYY+TBrddIEvsbOTEF2OcQs6VPsuZECRNEEVW7jalb+OEyc+6SJ4MLz0J7mcKQPRYoAXG8GKWDjGqvZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ylh3FAwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B7FDC4CEEA;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743622412;
	bh=O2TGhCtbwyCv/uYpcbYa8vSxgrjrVO0TZfOd0YOOx3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ylh3FAwHKqfvQqWS0sJ8IBlVVpFClyqENkowpZHP70CHvuaBM/fK04OiaYHo2tuU7
	 lJmxZq57ksDFFMBsJhv/NhLdXBCHovf4mbUm93gCx2tN3sAl6aPk6DYeChc4lE001k
	 yMQs71M0u+LefhQja54UTEgM+w4VlaXT+UN7NLU4RbmWkl+nmle1SerBgF2bUV3WIF
	 TzFKv/aLB32sE+wHR05Nkbx2Qa2a4w6a5PMCBPdn9cT2DhRztF/uC/hPXJPrHV++sK
	 df7+DyIcCm4NFbFjraXytpCYnRYITJIOcbJgOQwvLoNhrnsv8w4FHj1ZN6i69vevDg
	 pMLEIl9gxjhAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D52BC3601F;
	Wed,  2 Apr 2025 19:33:32 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:33:25 +0200
Subject: [PATCH v4 2/5] iio: light: al3000a: Fix an error handling path in
 al3000a_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v4-2-d189bea87261@ixit.cz>
References: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v4-0-d189bea87261@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=66tuh0qra+186i8PqZ9MH09vmloKVLdmfLyT9O7NZJA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7ZEKK38jVBmHNU7CFYig14RDpWa0ZY1lj8pTo
 eVvHE5NkY2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2RCgAKCRBgAj/E00kg
 cpyqD/0cFgarWExeX/tExe5FTLgYJPq0Xq/kck8yd71Vru/LfC7yA9BE4BFt3NlSei5tUJQxpmj
 O1WY8H3w5psDaJWwr2sfyEknwDwb66cXaQiX2cG7dQ9TOFeOuSbjEGTuJGlfs5ezPnQBSdyYeKp
 R4wdUo7vJ7fQx9AWhSiuw5IbhCsoSW81QzkFrCsJYw7DA961cT81OYXdGZcVqP1aiZ9c5fL5J+1
 0ETI6JxPm7Vn0AxfiiRxpKaWEtQiR9O4OSIE4o/i95svsqMKMEb9ydJUEUssq0tovzzyTfeyPsU
 aiosITW0pjausm2HFfR51+Mp0yzjY4kOat6jWXBxtE4akF5dce5gtaBlxVbdNnQHxB5/C0CvY/m
 LBniBGgCT9TGk5mwVB41NyRWGv+n4KTuJs57qVNrM1WU1BECDlM3CKOT+6bm/azv5CmW1uKtz6l
 bEO1XPNUo8OEYFnWFALsHmMWEIQl1KW9YIyPx72tQYfq01r3sPnzF+P7j6iud1Z8YgNb3lg1LIe
 7D7lHzKIe/wFWEFnQyC9MRvc1q3DnKZDzpiziZaMW/iRJ/2WIUfyYQkbsNJoCbqPh2Vo5FnbMJ2
 Krxg39SDlLW5EHMLo9wVab5OqosY98PV4D5jfgv+DyQ3do/lMfpLgxdDdOvjVl8VX462e4xLy5g
 lkUx24OLatH7t0w==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

If regmap_write() fails in al3000a_init(), al3000a_set_pwr_off is
not called.

In order to avoid such a situation, move the devm_add_action_or_reset()
which calls al3000a_set_pwr_off right after a successful
al3000a_set_pwr_on.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3000a.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
index e2fbb1270040f43d9f0a97838861818a8eaef813..6d5115b2a06c5acce18d831b9c41d3d5121fba12 100644
--- a/drivers/iio/light/al3000a.c
+++ b/drivers/iio/light/al3000a.c
@@ -85,12 +85,17 @@ static void al3000a_set_pwr_off(void *_data)
 
 static int al3000a_init(struct al3000a_data *data)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	ret = al3000a_set_pwr_on(data);
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
+
 	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
 	if (ret)
 		return ret;
@@ -157,10 +162,6 @@ static int al3000a_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to init ALS\n");
 
-	ret = devm_add_action_or_reset(dev, al3000a_set_pwr_off, data);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to add action\n");
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.49.0



