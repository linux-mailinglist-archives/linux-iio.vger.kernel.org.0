Return-Path: <linux-iio+bounces-2433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F2850B32
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09001C2264D
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0E5D8EF;
	Sun, 11 Feb 2024 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0U7t3O+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269433CD2;
	Sun, 11 Feb 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679654; cv=none; b=O4hDgkV2plJ8mZay8b0SFzLjNHtd8LkSix3Am0psrfdlDl4JD3CMWZM5zs9Bf5/ojGn9wPyNMd1I3pUEG/XkAvq1WFAMOlpywMLyZDl+Mny70ZPeHKyv8bszqZ90QTsYiwx7z6xNUDpbT6x8d2jb32M4/e3fxJs9RD1N8zqUMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679654; c=relaxed/simple;
	bh=Ew72D0ROr0xyyVBPfQdzVifZd7Uqo5BIrbLTQOaAPrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXuCa0InW6CUBd6P8Qw8yEFv3cUY+ni+tKkbfHZAhaCYuMU8sAtLCyi7JVJcUTleZvyXnfOoNKbPNjCUdY1Dgi1mdiR9E1vKPaadSFIWppv0qWc+Qb0BB/iqOg+7CeibjQOW9mnoyDfqURZkDQJgYLz7lhTyKPWmag9CZPkqq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0U7t3O+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB986C433C7;
	Sun, 11 Feb 2024 19:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679654;
	bh=Ew72D0ROr0xyyVBPfQdzVifZd7Uqo5BIrbLTQOaAPrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0U7t3O+uLn9HAscSjJQTp4cbrUJVK0+Z8Wh00yb7E3uFa6+4YuOzsJ85qP1opW54
	 PruPBg4JR+IFj3Iw4JfjfSyigacKx0ckYUjv9orPCn/aQQ1YalcXfN0cW9t37HXscL
	 xcFc7qixuPnEyCEJByzrg1cDgoYbb6MiyFn4zOGvGcuIb+8hUijW+w9HOlyASPkfsB
	 8CX28j2W3cKmfxvNAp6hFLnV/cPdYATurgWVHmmZ4gBnoMeIYVKCCsCqlqUvxv4saC
	 FYp9urPAJFY3DsfgpQRHfZuVjsnNXBz9gmTer1bHITEKyJI+X8KrKDFQPbs+OQd9ut
	 ELiIzAWbQcd0g==
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
Subject: [PATCH v2 11/14] iio: addac: ad74413r: Use device_for_each_child_node_scoped()
Date: Sun, 11 Feb 2024 19:25:37 +0000
Message-ID: <20240211192540.340682-12-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211192540.340682-1-jic23@kernel.org>
References: <20240211192540.340682-1-jic23@kernel.org>
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

The use of fwnode_for_each_available_child_node() here is assumed
to have been down to a false assumption that device_for_each_child_node()
doesn't check avaialble - so this transition to the scoped
device_for_each_child_node_scoped() is equivalent.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/addac/ad74413r.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 7af3e4b8fe3b..cd26a16dc0ff 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1255,21 +1255,15 @@ static int ad74413r_parse_channel_config(struct iio_dev *indio_dev,
 static int ad74413r_parse_channel_configs(struct iio_dev *indio_dev)
 {
 	struct ad74413r_state *st = iio_priv(indio_dev);
-	struct fwnode_handle *channel_node = NULL;
 	int ret;
 
-	fwnode_for_each_available_child_node(dev_fwnode(st->dev), channel_node) {
+	device_for_each_child_node_scoped(st->dev, channel_node) {
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
2.43.1


