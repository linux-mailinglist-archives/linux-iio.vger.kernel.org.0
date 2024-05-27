Return-Path: <linux-iio+bounces-5345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D858D0600
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C6C296822
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25567344D;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI9AzbLH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112A61FEE;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823216; cv=none; b=TYqW+ncpX16EG6Ryv3SgYyIpniaM4BYyY4Xm9akGockBj+jv0sx6t4zBUgv+APWtzluNXmqeWUEyWYOf2lou3JLS88FMqwVSMmSZQjTp+I64My59jjyxV0daWM78P+0Gn+V/TMO4ZLPBrkwZg0Hiy6Dg7FjdNmzu/soVD5/Bgnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823216; c=relaxed/simple;
	bh=j8i6rPIxaLoMN9Ud6/vTWt11Mmg5pOxCMWSuFPY9J38=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EWW4udpIHQFGsa6aXDfiYkd+fQF1BVtrhNDZckw4XTGFwSWfujDhTjAj4yTczB1V5vmzPWgwYRwbACTee6f+W4vQWqLRa3A1cSPQV+Y6HSOqvVaiG+Dbazroi8NXYkUw1zFVK3dhk9zQOq8S2DEr+X19EYeVGVoCMB6sYu1Iirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI9AzbLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A6C9C32781;
	Mon, 27 May 2024 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823216;
	bh=j8i6rPIxaLoMN9Ud6/vTWt11Mmg5pOxCMWSuFPY9J38=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OI9AzbLHmX4oqKXw11MSq10BmFcoG0YCfXdeCAbUOzAL56T3aMsMn54h/qVQzwocw
	 Khi/7CBWeExNsGn7v13ePDo26yEregCkdm+RD16mOLRKWo7ukDpprL8QmCwfCWRLKM
	 VgeaCEkDBEAzdtAzaXCUP/+eKbl7H9cH6I/Rdr235bSQfcwSVpso8l7IbfsMGLgMaI
	 9th7OCuBgoBWjJz6cmKv32aitZwU0zSB1SoP4T+x7f2WQclwpyHJlKoYBHFjmIcQBc
	 U1UqwT9/WddwO7polPsc2efx/s4RQMg0EGCaRfze3KGQOUqFDa5OcRp5H9YsVJeBSw
	 JCcMEryJfLuhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D7BC25B74;
	Mon, 27 May 2024 15:20:15 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Subject: [PATCH v2 0/5] AD7173 fixes
Date: Mon, 27 May 2024 18:19:48 +0300
Message-Id: <20240527-ad7173-fixes-v2-0-8501b66adb1f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSkVGYC/3WMyw7CIBBFf6WZtRhm+sC46n+YLggMLYmCAUM0D
 f8udu/y3JtzdsicPGe4djskLj77GBrQqQOz6bCy8LYxkKRBjoRCW4WqF86/OYuBiUctJ2RH0JR
 n4uNoxm1pvPn8iulz1Av+1j+hgkKKC05ojHK9tjjroO9xPZv4gKXW+gVY93PUqQAAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716823214; l=1276;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=j8i6rPIxaLoMN9Ud6/vTWt11Mmg5pOxCMWSuFPY9J38=;
 b=UGbJxCz+LFACCSr4m4Uwl7rRZDZP+jxcQuRug+EDFL82OqyOBz2zwLTWD7ZBLoIFb4Gh2BvQf
 3E9AWCdCqKgDVvetqcrRUBLITbjYwV3WpN8WnbP7pFa5No3vdGurBMl
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

This patch series adds fixes for ad7173 driver that were originally
sent along AD411x series. To ensure that they are included in this
current rc cycle they are sent in a separate series with the Fixes tag.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
Changes in v2:
iio: adc: ad7173: Fix sampling frequency setting
-Patch created
iio: adc: ad7173: Clear append status bit
-Patch created
iio: adc: ad7173: Remove index from temp channel
iio: adc: ad7173: Add ad7173_device_info names
iio: adc: ad7173: fix buffers enablement for ad7176-2
-No changes

- Link to v1: https://lore.kernel.org/r/20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com

---
Dumitru Ceclan (5):
      iio: adc: ad7173: fix buffers enablement for ad7176-2
      iio: adc: ad7173: Add ad7173_device_info names
      iio: adc: ad7173: Remove index from temp channel
      iio: adc: ad7173: Clear append status bit
      iio: adc: ad7173: Fix sampling frequency setting

 drivers/iio/adc/ad7173.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)
---
base-commit: 5ab61121a34759eb2418977f0b3589b7edc57776
change-id: 20240521-ad7173-fixes-4e2e5a061ef2

Best regards,
-- 
Dumitru Ceclan <dumitru.ceclan@analog.com>



