Return-Path: <linux-iio+bounces-17548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF0DA795AF
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 21:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB063B3BD6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874501E7C03;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7y9aN5O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB21442F4;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743621305; cv=none; b=tQ3eQ31XvnScXkC2yb2IyZ60qYJXsQ/bS1pof2/cYeLcC8p0SbhpyY4ddwY3lc1kUyaQVBbxZTVGo9MmKLrHqaE0OLOpz/DYuZrx8638dZjQoSdZU09+OpJgqreiEuzUKvOhTgBRo4vF41fuERF9W7VgBQGBQHwr7cwT/kxzW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743621305; c=relaxed/simple;
	bh=E9c72WfQkYT4uA7LVMOrVPyecs4XR7gyDQxCccTo4vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OhosoB/Ty6HPZxt8jjbtPPz300j4Ho6EhI/frSy8HBn2DayRS2ZAAwJWrxjSWBMYBqbGnqIJjuY1tmtn637jKZkTfkWHoxC6RnPDQdImRXRDQ+27N+UBPBl1Gyzc0v9Qx2HA20fob7gKnGr8j8AGgIafpE2zv5Tjv/8UhUMPFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7y9aN5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 161CCC4CEE8;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743621305;
	bh=E9c72WfQkYT4uA7LVMOrVPyecs4XR7gyDQxCccTo4vc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E7y9aN5OAPKA0CTtEDsSa/BZx1m0y6UlCBhWCs/ptW6fmsjY9CQ0hX1mG8EkopSwZ
	 w5DUXtqQH2sMDhrLFzhQQsYtGd4MmCK5uOSJ2HKbdUGD7kMGotGPVPpPgFIBdw4jKr
	 bxVMRtqgNBg6TnjBCIxakMzlWApwREfhy8qC/BD86wio4drcxDA66u2f0yWD+CfN8s
	 nQzP2Duyu7FulppALEVFHfUXkGIaTisqkeHsVXyNr0nFUkEKycJZ6BZAULAFGlVB2e
	 0nCdmL+uW8Rb3OFio9dBBEzS7SrPuJh7Zpom6sB/1Tyvlb6Bd/CRNXMYBi7b3M/pF8
	 NvXyphlNO6TVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B79FC3601E;
	Wed,  2 Apr 2025 19:15:05 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 02 Apr 2025 21:14:14 +0200
Subject: [PATCH v3 2/5] iio: light: al3000a: Fix an error handling path in
 al3000a_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-al3010-iio-regmap-v3-2-cc3da273b5b2@ixit.cz>
References: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
In-Reply-To: <20250402-al3010-iio-regmap-v3-0-cc3da273b5b2@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=qQvDrqw+rZNARjQEY1+9cVvczIiceT4fSIl/q8P2uWQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn7Yy31DPx1wXYhRoVsBn5uORAwDaRgaCShuFJV
 JL6J1pc50OJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ+2MtwAKCRBgAj/E00kg
 cvYcD/0dByWa9SsXZP2okc2RI8wXLHViKiH3fw94LHQj4u+vaxOxffQunlUO+WFhK4adgWHuKgO
 rKM80wX+TJPzqwatOGycNRU8OkToFIOIjKAwN+YXIGkYE+dz9X071MRKrp+k2HHN7KFyVUm7zfq
 PLsnv7gX5g4VtbEQ0CIZrP0KD48P0xxV5eyUBuijiasz3G+LS/G+L1QIpkdCzlarnd6r2+GZ+oj
 IQnRy5Kk0zOmX9euaNty73QuLGKXoHWX9E8NctDu77wHVzZCQzhWlNPsOWrvgvM8Zx2k4lpXvbP
 Udxbg3q10uByIiX/co+SwtaFEnnQbkNAJOB7waW2Wsy5cpkadMHGRrYFMmp54Kcu6DjmXZWL93N
 XPw2CeCytmMZjWF51q0QZRRb+1emZQm3OreZo+EeTaCk3u36f+Qao1+qWvJ52WH2QO/0o4j97F/
 aYsEM1TWb1doyhj/NjC9QP7ClyoAfYELDlFYtGk60tVnVVqUqi5HeDoRVhIIMdweaAqWk4r7JKE
 usgj0VfEzLoENT8ajWBWdYTBrO0F3bMkjzz/XbgIaFHfDBqhyJAyNOOgMVFfu1t3V1IsIT1wZep
 R4W84Qak9Fx7alNLvb+Hq9pg3O7Ltu+083faecfCU9dLFJabamMNMHwOn1BlllZUfKTaSiICZ7+
 Aop13hKPWeMvfqQ==
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
 drivers/iio/light/al3000a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
index e2fbb1270040f43d9f0a97838861818a8eaef813..e6208bfeb3be9040364463ef6d59a15d31e8700c 100644
--- a/drivers/iio/light/al3000a.c
+++ b/drivers/iio/light/al3000a.c
@@ -91,6 +91,10 @@ static int al3000a_init(struct al3000a_data *data)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(&data->client->dev, al3000a_set_pwr_off, data);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret, "failed to add action\n");
+
 	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_RESET);
 	if (ret)
 		return ret;
@@ -157,10 +161,6 @@ static int al3000a_probe(struct i2c_client *client)
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



