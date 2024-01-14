Return-Path: <linux-iio+bounces-1660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96082D1AD
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271E71C20A0A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4B6AB9;
	Sun, 14 Jan 2024 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyrY0fSv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56B7472;
	Sun, 14 Jan 2024 17:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62716C433C7;
	Sun, 14 Jan 2024 17:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705252882;
	bh=NBRWPxAsv0p1+ik3CPg3McHiDTSVOihxBd46Tt4L1gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyrY0fSvXSmFEfHH7s6M5En1E7DlTOGfPpH9c2EdKIoWLd1I6Qrk5frPgkH4xyfYg
	 nUMXapvqPogwI5rnfsRrxvz4jX5zx8OMFvgSCrcLD7NR7sz/PNJlD8ucNBrZS04eFq
	 UIPz606nVL566NDoZs0j2cNnfbIbEd3Aw2i6h7AOuId33cG+rnpWuDlaMVGyQXKWua
	 LmjOg5GosrHbnsML8M+feoDj7SfssRf4yQ4Bi+M+gDpiszGv2BEnPOsnrokoHo3/Tz
	 cAEAJ5sceltgCckDFJEFdRtaX6ikBHtLI7C6N8J6/ePj4FRgImtEiiVO645QLqIEVU
	 ld0V2h7R9W1EQ==
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
Subject: [PATCH 09/13] iio: addac: ad74413r: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Sun, 14 Jan 2024 17:20:05 +0000
Message-ID: <20240114172009.179893-10-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114172009.179893-1-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
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
fwnode_for_each_available_child_node(dev, child) loop. On normal exit
from that loop no fwnode_handle reference will be held and the child
pointer will be NULL thus making the automatically run
fwnode_handle_put() a noop.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/addac/ad74413r.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 7af3e4b8fe3b..ec9a466e118d 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1255,21 +1255,16 @@ static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
 static int ad74413r_parse_channel_configs(struct iio_dev *indio_dev)
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
-	struct fwnode_handle *channel_node = NULL;
+	struct fwnode_handle *channel_node __free(fwnode_handle) = NULL;
 	int ret;
 
 	fwnode_for_each_available_child_node(dev_fwnode(st->dev), channel_node) {
 		ret = ad74413r_parse_channel_config(indio_dev, channel_node);
 		if (ret)
-			goto put_channel_node;
+			return ret;
 	}
 
 	return 0;
-
-put_channel_node:
-	fwnode_handle_put(channel_node);
-
-	return ret;
 }
 
 static int ad74413r_setup_channels(struct iio_dev *indio_dev)
-- 
2.43.0


