Return-Path: <linux-iio+bounces-2663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93614858492
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4F283ABD
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1371332A0;
	Fri, 16 Feb 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhSRBsmG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D12132C35;
	Fri, 16 Feb 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105996; cv=none; b=ErNtSMTj2fEjMskJ58UdowJ1qrqxr3xP0bWcHx+dD99zjOEDXqSFzuAixnRA38rlBd0ysXxVizKh2vx7oZHA3yVF6b2LSAOBmozSaWIX6c5ZvaPhMuNwk9bxAthUVAxlmbj+SamDcjs+qoF5BskZjLVCmdcxNYEf14JlUvN/sAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105996; c=relaxed/simple;
	bh=aVEHVNZLRW+7hOZXFm1bFqSgnqdVSQ6FtHIyAf/1FKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEEgxBN9rige0On0AGnjqCTnQBD3th3HxEbUlUbfXmrLZtftZQjmON1IJze01VSlzYWhBjzaKTf9jEnP+PQ2AJQnEyDK0+B/9Q4BrhLrD3vH2M1j4dHLxbhO1H8skWN8B16yGDcPJM5rB1Xr4ktMaxtJM7/tPorHVxldSxGM9FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhSRBsmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5982C43390;
	Fri, 16 Feb 2024 17:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708105995;
	bh=aVEHVNZLRW+7hOZXFm1bFqSgnqdVSQ6FtHIyAf/1FKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhSRBsmGMLfCkNxhEPI4VtSVRyvNSCuxxrN3AM4rW8Pgs8TDRflv/XhD4+wxQ9Qwq
	 QBpousA2fbSfxf3GCzSk/mKamt8TuXnZ7++kMGwc1ex27ss1ANLA6qtdDIQ9kpNIab
	 BSIw9+bUZPpYhe6w7R78PKzTed6sHbfj7EbLRgdZwV3Jq6+W+Jc4HRMH3pGYngUaPR
	 wZUhfiyl7y0YFqSJ1eWBI0Sg87zvjl/8oI3fqUNGOX1j4TfWgeXRdi+6r7wjMyUnfI
	 hRFpobgsLvy3GGFQhXD1puivbZ60Wp16IaVr5aw55FkrCVKrqvR+iXxAOIuClHSNuw
	 NwdHFrzCu1Eng==
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
Subject: [PATCH v3 06/15] iio: adc: mcp3564: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:12 +0000
Message-ID: <20240216175221.900565-7-jic23@kernel.org>
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
2.43.2


