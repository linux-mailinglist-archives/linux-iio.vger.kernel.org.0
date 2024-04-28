Return-Path: <linux-iio+bounces-4602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 953218B4D4C
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 19:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BE61C206A2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0077317F;
	Sun, 28 Apr 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAuGkSMr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC91F9D9
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714326039; cv=none; b=r8x+3S0BNR7US32K1EV2RXNgB+7aIo53WI1JTql4+tlxM3tMNpn+TCJSO83rD7gDbTQkKFbeKRGPQQvuHH7joiwKzsEcgxmA4DUjZskfe7zWY05M9zBFFK00/Q1KOUo78XPXzT2K5QvWfiFI8TL93QI0EHppebi6uoIUcNUYBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714326039; c=relaxed/simple;
	bh=m9bHBC6aPtg+HNstAk3kQ6vbYkbeec+pVBvkWAQ5pCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q36624KXPtGHRJouIGKxqt2aM9444C8FCdCFyZq+QQOfzqn+2ZDexQATdzY8zqWglGAzJ+8enKmPPvxdSTkcneyZIAHNBwFYD8O/rAIlV97yBToplPekbVOvCIGVN1QrS78k+gFZkKTYIDpnmaN44v8P+IDgepdUbPw4Uw0SOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAuGkSMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE8C113CC;
	Sun, 28 Apr 2024 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714326039;
	bh=m9bHBC6aPtg+HNstAk3kQ6vbYkbeec+pVBvkWAQ5pCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAuGkSMr8qsT+bf/SHqavzWzRHuEpkVqS7125a7L5MRU9MQUY5VvGpfJZdD+ZUtqW
	 QIqJOhJeHA4p0reSKUt+6I48mwMWzX76a8G821TOhA1Lbh6aZx/NxWOXYn9bCOcaZq
	 gzQvEYvWMcA/bo4b3hXLLgP47BDQjx/i5TN3KPkxvBAqqG6ZD9Eb1Z2vUVctivqmIa
	 Bn8LRIFbXV4yf596lX7Qa5a4UIhEuTXFdsLUTFaglBDl0zwqy5qaZPWB/3i+INEEoY
	 W09EJBiDJX112indPJLKOpOqJQ4VdFHk5e5pudWn5aH3e2v3unp4RydxLDEftRAtMw
	 cEhLAKXY4c/7A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 2/2] iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
Date: Sun, 28 Apr 2024 18:40:20 +0100
Message-ID: <20240428174020.1832825-3-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240428174020.1832825-1-jic23@kernel.org>
References: <20240428174020.1832825-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

Cc: Marek Vasut <marex@denx.de>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1015.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6ae967e4d8fa..d3363d02f292 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -902,10 +902,9 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device *dev = &client->dev;
-	struct fwnode_handle *node;
 	int i = -1;
 
-	device_for_each_child_node(dev, node) {
+	device_for_each_child_node_scoped(dev, node) {
 		u32 pval;
 		unsigned int channel;
 		unsigned int pga = ADS1015_DEFAULT_PGA;
@@ -927,7 +926,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			pga = pval;
 			if (pga > 5) {
 				dev_err(dev, "invalid gain on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
@@ -936,7 +934,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			data_rate = pval;
 			if (data_rate > 7) {
 				dev_err(dev, "invalid data_rate on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
-- 
2.44.0


