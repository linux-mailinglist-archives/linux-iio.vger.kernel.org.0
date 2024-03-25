Return-Path: <linux-iio+bounces-3794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60288B181
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 21:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793BA1C3E790
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD9D5EE64;
	Mon, 25 Mar 2024 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VsvUqZSs"
X-Original-To: linux-iio@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA9D5D49A;
	Mon, 25 Mar 2024 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398785; cv=none; b=JLdFUVnbRn3KVhHFZN+3/hmDXvM8FbhxPDd8P9IhoHU5XaYKsku+xbgRobd+KtNoEYnlLmvOs0TsNfYpsgTtLDaMuapqJuXApsZkKPKOeMQ8/Pm6YGbRYiniAWZKd6uhMfpLkqkNpvGJdm4h526P28xY3Cp2Rulj07ecoqu258k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398785; c=relaxed/simple;
	bh=ycHRYiTS2rqX1z1nXX5amVUPfjf+7hjHKfnWrEZ6N3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd1k0gNv8vhusn7oFVq2aADQVeEDIHkTNbzUHNqezq6v5lRjLb+ufd+5Ta3kQe5/nZulFIqMkxWyQWrBcfU3tYwcdEBIwzZ+yJEHEjztKWWaPlQVwvGDC1F8BXTIY9kExjfdigoBENAYRqu+aaRgb2PUL3GYFdJJcS8nrT+9CFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VsvUqZSs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BFA5D3372;
	Mon, 25 Mar 2024 21:32:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711398745;
	bh=ycHRYiTS2rqX1z1nXX5amVUPfjf+7hjHKfnWrEZ6N3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsvUqZSsTZi+5i9NNix0N6qTQIAkVpfOmm95jAqDYNqLNyptBrHIvwWQfO3BDG/Ju
	 0W40DT/w81FyvlsesfcuLqgxcBAsfM5m4fiQjMC9QplgysIVHs07zyFuEGlPA9h5Dq
	 38QdIBALcKAysbsIowLO93z33fPPpwVsKOOksEh8=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Trevor Zaharichuk <trevor@au-zone.com>,
	Greg Lytle <greg@au-zone.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/5] iio: dac: ti-dac5571: Add DAC081C081 support
Date: Mon, 25 Mar 2024 22:32:42 +0200
Message-ID: <20240325203245.31660-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAC081C081 is a TI DAC whose software interface is compatible with
the DAC5571. It is the 8-bit version of the DAC121C081, already
supported by the DAC5571 driver. Extends the driver to support this
chip.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iio/dac/ti-dac5571.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index efb1269a77c1..c5162b72951a 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -13,6 +13,7 @@
  * https://www.ti.com/lit/ds/symlink/dac5573.pdf
  * https://www.ti.com/lit/ds/symlink/dac6573.pdf
  * https://www.ti.com/lit/ds/symlink/dac7573.pdf
+ * https://www.ti.com/lit/ds/symlink/dac081c081.pdf
  * https://www.ti.com/lit/ds/symlink/dac121c081.pdf
  */
 
@@ -386,6 +387,7 @@ static void dac5571_remove(struct i2c_client *i2c)
 }
 
 static const struct of_device_id dac5571_of_id[] = {
+	{.compatible = "ti,dac081c081", .data = &dac5571_spec[single_8bit] },
 	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
 	{.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
 	{.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
@@ -401,6 +403,7 @@ static const struct of_device_id dac5571_of_id[] = {
 MODULE_DEVICE_TABLE(of, dac5571_of_id);
 
 static const struct i2c_device_id dac5571_id[] = {
+	{"dac081c081", (kernel_ulong_t)&dac5571_spec[single_8bit] },
 	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
 	{"dac5571", (kernel_ulong_t)&dac5571_spec[single_8bit] },
 	{"dac6571", (kernel_ulong_t)&dac5571_spec[single_10bit] },
-- 
Regards,

Laurent Pinchart


