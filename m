Return-Path: <linux-iio+bounces-1376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5C68214AE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E051C20CBE
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB368BF8;
	Mon,  1 Jan 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj5HJ3sy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81B8BE5;
	Mon,  1 Jan 2024 17:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E79C433C7;
	Mon,  1 Jan 2024 17:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130040;
	bh=oPmhAyw26DlLhdgx6/VziQcd6PYA7TxqUM1BF0j3Kfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dj5HJ3syfP30MNKaEoBcA3UvkYPzyC/ypir2jnHJulXHeg7VC9m6EJlkH0crfDFQa
	 Ua14fWj4LwGoLPpRBcZTilwp+2GPKL2QflI5mbiDPt+quOwwK+vQookFre+/wX4WQj
	 MhMedg4KHMU1DTLAN3hEjOx247cRQXcsn6PEaRvqmvdftoP8vEH3kb27DUUuDngMO/
	 Dk6jjKcXjatFUHFZCaVTrnrEXXAtibQ9RX6afGmbd/XQDnOzVaVfrzironAnfkpNGB
	 jrPHZUMwzps5optKdnxHcAUPaZvr6Q80FIfnURkW1sCz2inkapXENoaXxpLKywPk/L
	 Hs72jykBE/8Gw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 07/13] iio: adc: ti-ads1015: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Mon,  1 Jan 2024 17:26:05 +0000
Message-ID: <20240101172611.694830-8-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101172611.694830-1-jic23@kernel.org>
References: <20240101172611.694830-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This use of the new cleanup.h scope based freeing infrastructure allows
us to exit directly from error conditions within the
device_for_each_child_node(dev, child) loop. On normal exit from that
loop no fwnode_handle reference will be held and the child pointer
will be NULL thus making the automatically run fwnode_handle_put() a
noop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/iio/adc/ti-ads1015.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6799ea49dbc7..098912b871e6 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -902,7 +902,7 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device *dev = &client->dev;
-	struct fwnode_handle *node;
+	struct fwnode_handle *node __free(fwnode_handle) = NULL;
 	int i = -1;
 
 	device_for_each_child_node(dev, node) {
@@ -927,7 +927,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			pga = pval;
 			if (pga > 6) {
 				dev_err(dev, "invalid gain on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
@@ -936,7 +935,6 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 			data_rate = pval;
 			if (data_rate > 7) {
 				dev_err(dev, "invalid data_rate on %pfw\n", node);
-				fwnode_handle_put(node);
 				return -EINVAL;
 			}
 		}
-- 
2.43.0


