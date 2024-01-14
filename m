Return-Path: <linux-iio+bounces-1655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2B482D1A3
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655E91F2157A
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FECC63AF;
	Sun, 14 Jan 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtUxWXDp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D2610E;
	Sun, 14 Jan 2024 17:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B70C433C7;
	Sun, 14 Jan 2024 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705252855;
	bh=TY2UOViAZEQSO4rcD1JIFoUH395EUpJCQCSBRKhzoP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtUxWXDpshiFNqbukjvB+dmtY9lbsd8dYjM+QP4JVEt30GAut0VRGCqDipw0TKmJb
	 BZoQb4qizk5xHCBe4gnkRR2cc2Y6Iddtvfhpnav+uf8l71uAv9w3kiGQnML02q8vZ5
	 7b+MdRbRWLt12CLveQg2TmF0HV2Dmnm3JqoayOOFnDpadoUMEEA2wonl4qoR7UtoVA
	 GPXZPhIesdBNkPzaS0KodUUmF/xWCSHkTaMNRItwD61wByoAARIQ4k5ToDYUk4ssNz
	 VnCoPKqe9Icrtf2qn4VieOC5Y9sBNKEpM1i/3SGcNlCyFgknXhuUzRWhfU2SZ2JB1J
	 oAM59SxNughOg==
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
Subject: [PATCH 04/13] iio: adc: qcom-spmi-adc5: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Sun, 14 Jan 2024 17:20:00 +0000
Message-ID: <20240114172009.179893-5-jic23@kernel.org>
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
device_for_each_child_node(dev, child) loop. On normal exit from that
loop no fwnode_handle reference will be held and the child pointer
will be NULL thus making the automatically run fwnode_handle_put() a
noop.

A slightly less convincing usecase than many as all the failure paths
are wrapped up in a call to a per fwnode_handle utility function.
The complexity in that function is sufficient that it makes sense to
factor it out even if it this new auto cleanup would enable simpler
returns if the code was inline at the call site. Hence I've left it alone.

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index b6b612d733ff..36d3912d36df 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -825,7 +825,7 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
 	const struct adc5_channels *adc_chan;
 	struct iio_chan_spec *iio_chan;
 	struct adc5_channel_prop prop, *chan_props;
-	struct fwnode_handle *child;
+	struct fwnode_handle *child __free(fwnode_handle) = NULL;
 	unsigned int index = 0;
 	int ret;
 
@@ -851,10 +851,8 @@ static int adc5_get_fw_data(struct adc5_chip *adc)
 
 	device_for_each_child_node(adc->dev, child) {
 		ret = adc5_get_fw_channel_data(adc, &prop, child, adc->data);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 
 		prop.scale_fn_type =
 			adc->data->adc_chans[prop.channel].scale_fn_type;
-- 
2.43.0


