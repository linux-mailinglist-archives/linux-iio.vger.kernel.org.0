Return-Path: <linux-iio+bounces-1378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210048214B2
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB71D281D4D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52988C05;
	Mon,  1 Jan 2024 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MChxfWoX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC298F57;
	Mon,  1 Jan 2024 17:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAFEC433C7;
	Mon,  1 Jan 2024 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130055;
	bh=77tTrrVfmsUBTrWwC6V0+Xdf77c6pc7aTaAov6cMClg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MChxfWoX0C8mViGHXRHOuDGrUiwsmWLGjjasCiu6lQY5EDXSIRjvawkqB+Pg+ViWg
	 L0YBPNdLk+3tuq0ArC/L1bqMtOe/4fKk6uSZqQhFdrNR2UaXzZWwpuOl/2eyrElICu
	 l2bgpJIP2aTDDhBZzg2GwLv5EETGQIIIY8IebMjO2C+eFnL1Uh921ZjGix2zEskWS+
	 rd89/36KziskVS8/gAcl2Pg+ZE0aUGIpU1pcswvXrIYxzWZCoixibVpnJY+KWrk6cj
	 Zqi9g079prUTwi7qGR0gZ0M9aYwqodp3rIVAF0Aqx6UqjWZRnAqUjPMLT6s8q1nn+3
	 AmveDCg4jG3zQ==
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
Subject: [RFC PATCH 09/13] iio: addac: ad74413r: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Mon,  1 Jan 2024 17:26:07 +0000
Message-ID: <20240101172611.694830-10-jic23@kernel.org>
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
fwnode_for_each_available_child_node(dev, child) loop. On normal exit
from that loop no fwnode_handle reference will be held and the child
pointer will be NULL thus making the automatically run
fwnode_handle_put() a noop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
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


