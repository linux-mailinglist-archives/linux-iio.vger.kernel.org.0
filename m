Return-Path: <linux-iio+bounces-2991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F808624F7
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E52B21907
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8AE3527F;
	Sat, 24 Feb 2024 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHbtwH0g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FA325750
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777963; cv=none; b=qSPBbDgSXjEUZB2Gq0/i/i2jwfY++kK2AYZBvhhppNCvpKvoBxruib9UR8Qh2ZA/TCSPLrMkBs5RBjVl2Z943RMUhv493Tn2ZNGQxc6SJ0MtKXKq+sHctPQkGGwVaqxvDhCe3aBzpwyS1PsubKxuuHZF811Fswvg1OCA9tHp9YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777963; c=relaxed/simple;
	bh=t+c4BrYzejAt75RJ2Qxn/cvI2ZbHxIHAKbFEFaGQriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL0sliia8Pk4IycsVQHXtQMl9IYOkprZ4FDBk0PwlNKYRzk7IwLDzLwUqxT7SXNgr/zN85Qmxnfys76usFD9dsbYCT3fAEwYhrDG+cda4lSJ/98p4d9Wy5pDOiF0rJqX1O+WB8NBuuHBlvSRBVDH2OzPiNsp9i+id7R+k9lCXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHbtwH0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B37FC433F1;
	Sat, 24 Feb 2024 12:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708777963;
	bh=t+c4BrYzejAt75RJ2Qxn/cvI2ZbHxIHAKbFEFaGQriQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHbtwH0gBbUspXnXUD87aqkbifjZVV1oGVDPhiTPxX6xQXKxBWQGYiWyuxKVwizQt
	 GLUR0gxdXKbhWn2JJRmOa760WI8P3JInvc/u0iuSSbFJsuwjxKAoPa+WIDJuZaylx7
	 1FBph2IjVbsr0tIyPAhfb16lKdpH6+pfboP+uX2QlPd09BHKicFlK6IF7M8yKzpvuP
	 HWL2Uv2RtlJNY56S1ldnLlahqio1uOSPG9POp/Agwo4UC0XHC5X/8z2QDk6+2BYs9T
	 ZiBOsg/BEiCE23jwFHYz79FZbzHAMdvtEWgMvvbJAZhoxc7TsL/6H5Qtu3QmRL1kFu
	 crTFmU56yRaGA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
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
Subject: [PATCH v5 2/9] iio: adc: mcp3564: Use device_for_each_child_node_scoped()
Date: Sat, 24 Feb 2024 12:32:08 +0000
Message-ID: <20240224123215.161469-3-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224123215.161469-1-jic23@kernel.org>
References: <20240224123215.161469-1-jic23@kernel.org>
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

Cc: Marius Cristea <marius.cristea@microchip.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/mcp3564.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index 311b613b6057..e2ae13f1e842 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -998,7 +998,6 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 	struct mcp3564_state *adc = iio_priv(indio_dev);
 	struct device *dev = &adc->spi->dev;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *child;
 	struct iio_chan_spec chanspec = mcp3564_channel_template;
 	struct iio_chan_spec temp_chanspec = mcp3564_temp_channel_template;
 	struct iio_chan_spec burnout_chanspec = mcp3564_burnout_channel_template;
@@ -1025,7 +1024,7 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 	if (!channels)
 		return dev_err_probe(dev, -ENOMEM, "Can't allocate memory\n");
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		node_name = fwnode_get_name(child);
 
 		if (fwnode_property_present(child, "diff-channels")) {
@@ -1033,26 +1032,25 @@ static int mcp3564_parse_fw_children(struct iio_dev *indio_dev)
 							     "diff-channels",
 							     inputs,
 							     ARRAY_SIZE(inputs));
+			if (ret)
+				return ret;
+
 			chanspec.differential = 1;
 		} else {
 			ret = fwnode_property_read_u32(child, "reg", &inputs[0]);
+			if (ret)
+				return ret;
 
 			chanspec.differential = 0;
 			inputs[1] = MCP3564_AGND;
 		}
-		if (ret) {
-			fwnode_handle_put(child);
-			return ret;
-		}
 
 		if (inputs[0] > MCP3564_INTERNAL_VCM ||
-		    inputs[1] > MCP3564_INTERNAL_VCM) {
-			fwnode_handle_put(child);
+		    inputs[1] > MCP3564_INTERNAL_VCM)
 			return dev_err_probe(&indio_dev->dev, -EINVAL,
 					     "Channel index > %d, for %s\n",
 					     MCP3564_INTERNAL_VCM + 1,
 					     node_name);
-		}
 
 		chanspec.address = (inputs[0] << 4) | inputs[1];
 		chanspec.channel = inputs[0];
-- 
2.44.0


