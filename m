Return-Path: <linux-iio+bounces-25880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFA6C31DF7
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BAD42290B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46463277011;
	Tue,  4 Nov 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skfiJ4B9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8631D379;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=VL0o7DuF6VnnL+mG64FjBTR/x8Ku2X7ahBJJ66kdB5x7+XJXjppJ3YSu7PHEeLjOQQGsq0u+DA/vKyx6i8cqwONeLadp/aY1B7T8nR/eu9o6/DiFqQqBAMzyyCcObZqyxqbLfguw2JHJNqxaPcv53HcIJhQfGo+MCsdyVSuhDJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=KDOMNGRHI5yizhwmP2C33zlojgUpeSgQLxDxZGERFdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8MgPOPPtTsr0nZUdT2hTzLyytVItkIi88Sxn5XX77OEHriBh0BNGoSWbW7ktz865iStNQyTo020z1JdkDWJpivOmwe0qVK/k8iK8ae8zLKrm2s6W1ut2JQ5/R8rdSwMdYaXcybxdciC14YDmYekcv3GiZnW7Ean7Ivh461lgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skfiJ4B9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B08C2BCB4;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=KDOMNGRHI5yizhwmP2C33zlojgUpeSgQLxDxZGERFdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=skfiJ4B97qn5TuEFJvqxx3Bg5wM5enLDYNxqq3eM77OTTsKGzluRJq9cR6NLXwLge
	 pmUVaenZzaDlDzAWDDHdxkdYPGMQbVkiOBEDKgDilEla6tfA9tzBF/OdzzTI1CiWvk
	 65clBvTCb0ZYYQJGloKlcpdOyrsjtVwWyWYfYGBVw1DEa3rGr1zkrNZqXzRJnGQXRr
	 UvTTPColPMyWyzdLKCxBeZ60JeNjVM622Ap7j13zNSM5edMjRGgcseZfLWtW97i5Ki
	 xsg4cnBsOSWMppC1fFK1tReS3IVZzBt3fsgcrpVRdEbAf+E+ruOpVjpx3w2Wjt2nuC
	 t+uvZAup2+Mng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695B6CCFA0D;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:15 +0000
Subject: [PATCH v4 10/12] iio: dac: ad5446: Refactor header inclusion
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-10-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=1206;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7C0UVf31WzfqNv7L6REiRCtSkEXLZj16kckBYexNtTE=;
 b=pge2lvMbktdrZHRURX7wjAa1HfFNg6U4jQUamMzgft+u7cauDLuloCSw7RKx8YgWtOHlv7cIO
 W50FxGTCP7dCb+vitjmxyY6FcGRP9HqbG8MVmcqFSAuroul/H3UOeXP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure include files are given in alphabetical order and that we include
the ones that were missing and remove the ones we don't really use.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 1943e8014990..0556ce78c2f6 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -5,21 +5,17 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/array_size.h>
 #include <linux/cleanup.h>
-#include <linux/export.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/regulator/consumer.h>
 #include <linux/err.h>
-#include <linux/module.h>
-
+#include <linux/export.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
 
 #include "ad5446.h"
 

-- 
2.51.0



