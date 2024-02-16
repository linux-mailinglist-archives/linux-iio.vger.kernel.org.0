Return-Path: <linux-iio+bounces-2667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B1858499
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9081C2129B
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E01132C0F;
	Fri, 16 Feb 2024 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8vx6R9s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99771332A0;
	Fri, 16 Feb 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106019; cv=none; b=VN2u450ifWgBBO2jf6m0jhSyaUt/1OPxAaJqNEsrTA1/sEv7ulXunFvOz03u2aQtquPW03X1D9YU62ujI5VI/gGwruWdCboHEIr2Mb1Xm3IfT+A62ymzmNRCMiAZHycVVbOTvKakC4qXD/6BhqIOvWlBX1+Fu8S08+dDngAsAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106019; c=relaxed/simple;
	bh=Ds74Qrbcn3I42aYg16TeBAqLINL89sm7BvmJAC5S5nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRKnVoho9xaLtbYmPsz2Nk8d/t7oOZAT3kZBNblDYyICfa+yMgCKXYpwrg+7/ctDdYyiIr0BuQ7nKZSTc9udqo361N53Oc5oZY+rqUeWtZGo4usZvyElQzDtJcsslEuVc6O85YfaZQJHkaIlpSfikbt4ARD86znFGrEYuEOGInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8vx6R9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A139C43394;
	Fri, 16 Feb 2024 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106019;
	bh=Ds74Qrbcn3I42aYg16TeBAqLINL89sm7BvmJAC5S5nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8vx6R9s2ybzlSVLB6QoCkZItvF0rR21gmxvRPQW9/wOpWbeGRQK9G4yEMJSR/cZS
	 CBDWUp+183qCQ52RODgNIpBhzlsod2i6IXYLzEmhfw+g7qVug+YSg8/5k4dluAxbZN
	 KlMvmdH3JRubXRgpyfeiGy8BMmiq5G+QexUC5uKEsar+WL3ZRgmNbBiJNHjkksh8Kd
	 olGwaJL2r7Zi396H0IMOmdUtKUKilQcDgYHpdSf4EsONWEr4jegBUj4rExXXxrqUIh
	 A1bJnzvW67/feg/aGoTq3LiuLTaJCSotKJpSElbQ55uC+i3apBfWF6DWlkKs6n1dBW
	 G3rK4ALkatQzQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 10/15] iio: adc: ti-ads1015: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:16 +0000
Message-ID: <20240216175221.900565-11-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
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
2.43.2


