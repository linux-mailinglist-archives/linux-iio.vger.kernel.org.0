Return-Path: <linux-iio+bounces-716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25977808963
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 14:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D2E1C20B11
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767740BF8;
	Thu,  7 Dec 2023 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="yNxvXNSC"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC9D54
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 05:42:13 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 6DF048642A;
	Thu,  7 Dec 2023 14:42:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701956531;
	bh=8HUArkwpi/4avwwbWMYgLn16imsjCvek8OkJHCSRxak=;
	h=From:To:Cc:Subject:Date:From;
	b=yNxvXNSCYbmlw7g6a2sHxIv+JGWs1sIwd5Ji9sVqcwJ9Cki7dfPIco2SAXON2e1f2
	 pMIP4Zg1JMPmHRw7BYlU+p1yIWUYRygbpq0v2ALBXE+asyvAY9PUZgb54un/YChGxp
	 QRjL9NY6y0NA1XJQ10DF5LjuQh3dEMhwaIzBdmAeVbOQRO34JbCYJ5umAWLbQ8x8QX
	 uqnCYa00cr4N4Olt7DqBcNv8jBjzG1S3D09Jt5UG2iUHwezGMuRPxsRGsuD4qpkCIJ
	 IFIdAnR2K6TWz252jhTcVX9V+R/dQQb9sjy7EEGqS0mYo8oSfBK8IzcqUEaBuTPM8c
	 jz2sg+bteBJYQ==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] doc: iio: Document intensity scale as poorly defined
Date: Thu,  7 Dec 2023 14:41:50 +0100
Message-ID: <20231207134200.329174-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add comment about intensity scale being poorly defined and
having no proper units.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 0d3ec5fc45f2f..94b8d8461b7c7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -618,7 +618,9 @@ KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
 		If a discrete set of scale values is available, they
-		are listed in this attribute.
+		are listed in this attribute. Unlike illumination,
+		multiplying intensity by intensity_scale does not
+		yield value with any standardized unit.
 
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_hardwaregain
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensity_hardwaregain
-- 
2.42.0


