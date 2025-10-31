Return-Path: <linux-iio+bounces-25745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73643C25026
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20577351176
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0DE34A3AA;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBRKIDYQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DA3491F3
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=Cp/GINogVKyB1lFLX3PSvL0uLtghuFAlbkiRKm7XTPXIGUUqxhcmmfoCzcTm9HMT1QXd999LHd51PLzbZbfoz4gXAWOSxfAKqX5+IguJkLlNLLkyvaCd6IlSjr5sokXevlFrbRY73Nb0+LTJPQC46t0jIHCCWDq4TeWMWjmA9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=A7qCJDCCd+bEoao/92lebSMWr0zSjdqa8tgziqMono4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V71lbAixNAYjOQV3f7e6UFPKvxjmo8o1ClOD4m/BP+VCUUYVf/I+egZbJ+ByD9pepGT+6GIx2Dl4OOLGKt6oKJ7+Lno/21H2hVZPakIWRQCYN+0GVr/C9G8naqTO7bN5Bd/4PfRgRybthTIHFxWrujxHznaf+NpV2NcfD7i13q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBRKIDYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CA0FC19422;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913862;
	bh=A7qCJDCCd+bEoao/92lebSMWr0zSjdqa8tgziqMono4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sBRKIDYQCsNSiyNgHirtl9bAoSMUCldihrNft8rPyyGrGtg2ALPMSKMIATSTd7wdN
	 nwYD8uv8ltexfbOgHpdl/TK0ILx7gq02miR3/8EMxmReXZnJWljoudwfRKZ+HglcJg
	 U7FSMFhTZcqP9/YxjPv/vhK+wxDgTGYcMCnRx0i8P0xfsUtRdlHBPSTkEdf5O3tK3I
	 20y2rCWo2hV5HJgNt7ndjzolmmwFHbQy221qTHLWEm3kiq56xxq0BO03xSk3OHsF1D
	 /jrVhQ4+1ExxNafmFAtfEyxkxgM5r1NqlfpW/94gPvde6i7ZE/4Oc53an3c2ZvFgNd
	 qVor763N6YsIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3272ECCF9FF;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:30 +0000
Subject: [PATCH v3 09/10] iio: dac: ad5446: Fix coding style issues
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-9-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=3170;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7Bk6gr6kX1KvGZP2pdn9aUjTDyH/Zjv7dQ0xWxsPdY8=;
 b=Hl0igyCfRO6obXdMPlhEVaOhTNhnnrZgymWxfmYOWV9iIlqdxfLmnDptFxeepjwcuhN5Jmq4h
 Eh0XQSc6HWDBz0ZN5GXKG1ASF+QfdmsZubehGkZfCV/bzUGQz32h2Wz
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Fix style issues as reported by checkpatch. Additionally, make sure
include files are given in alphabetical order and that we include the
ones that were missing and remove the one we don't really use.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index d288fb56e324..bf9f7edb1a81 100644
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
 
@@ -32,7 +28,8 @@ static const char * const ad5446_powerdown_modes[] = {
 };
 
 static int ad5446_set_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, unsigned int mode)
+				     const struct iio_chan_spec *chan,
+				     unsigned int mode)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 
@@ -42,7 +39,7 @@ static int ad5446_set_powerdown_mode(struct iio_dev *indio_dev,
 }
 
 static int ad5446_get_powerdown_mode(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan)
+				     const struct iio_chan_spec *chan)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 
@@ -57,9 +54,9 @@ static const struct iio_enum ad5446_powerdown_mode_enum = {
 };
 
 static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
-					   uintptr_t private,
-					   const struct iio_chan_spec *chan,
-					   char *buf)
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 
@@ -67,9 +64,9 @@ static ssize_t ad5446_read_dac_powerdown(struct iio_dev *indio_dev,
 }
 
 static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
-					    uintptr_t private,
-					    const struct iio_chan_spec *chan,
-					    const char *buf, size_t len)
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  const char *buf, size_t len)
 {
 	struct ad5446_state *st = iio_priv(indio_dev);
 	unsigned int shift;
@@ -151,10 +148,8 @@ static int ad5446_write_dac_raw(struct iio_dev *indio_dev,
 }
 
 static int ad5446_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       int val,
-			       int val2,
-			       long mask)
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:

-- 
2.51.0



