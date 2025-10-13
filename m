Return-Path: <linux-iio+bounces-25027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B8DBD1F46
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 10:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03BAE4EC4DC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Oct 2025 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17D2ECD3F;
	Mon, 13 Oct 2025 08:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxpONl8e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2824B2EC0AB;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343148; cv=none; b=ZMjNDP7ANDMt8ni62ox4i31AHlVnU9nr0sRIfCF7eOo+HTCJMgQsrV6ILCx8VZWkO0FjnmBlEB2Uh7nNmYy+B55k8CXGr/Ye3AnbHBRrQmxbfy32mlKwFzdpDK5Yactof8P/Lx4bqA/Yb2ETzLeWcHFcAMaYWMEphCVg4/td+cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343148; c=relaxed/simple;
	bh=uG5to/T0U1UD96nleEjz0+yJxBXGU0jPV7BnWgLdI1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5joq+NJ6ZwiZ2Yk9g4yZBvLVh+VwkdCfBc9RYIZ/8UJnBimxistK2XU2jYhBBjoTqZIC5eIY58sZDrUBGAblVVMgz8j4MOYsjcesbr9+0sMVRm8Yrqm/ERyHKTLPTmKq0wUqz2w5D/kmxsxpn1IhlHP1oGHPN/dkaOlbmE6JyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxpONl8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A386EC19422;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760343147;
	bh=uG5to/T0U1UD96nleEjz0+yJxBXGU0jPV7BnWgLdI1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pxpONl8e6gG/TPd+ca2Ky6o+rLcnJpWXvIrjIwsMar9YH6C3RPgZbNqDLXTqlq7ty
	 zOe0Jytu1TEVtVuZmtjrp4kn2n0ByXxs2DtwAK9j6fee8lkVhUBIMT3V8zj6URqmD8
	 mMAf5az4HAB13WgglfjzyIqsrftdDEO5SYOb1mSMw3SehC8PXw+hCnx+00n7n5eU0D
	 QxRwIMfvXXWBZ0mRfL725qntqP0V8+A1PpxBlv2LGMRDg5bh2ykDFbO8Q+8pHJIIxw
	 +vhOPEHhGdJs9bPJC0uFpPyzf7fKrQLJYhhiSGrR6qdLbQkPq8NxTw8EJ7nfbBHLLa
	 P0fmRSU3unmqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D7DCCD18F;
	Mon, 13 Oct 2025 08:12:27 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 13 Oct 2025 10:12:25 +0200
Subject: [PATCH v3 1/2] iio: humditiy: hdc3020: fix units for temperature
 and humidity measurement
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-hdc3020-units-fix-v3-1-b21fab32b882@liebherr.com>
References: <20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com>
In-Reply-To: <20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Chris Lesiak <chris.lesiak@licorbio.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760343146; l=1338;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=1Poi65ufYWSrgXpM9TeB84HDWnd8hM9UVI5WIoXbC1w=;
 b=s8LClymFEp1kf0mUNZQXxOPLSgpCZB00Z4q7LsFJFhPs5OYF7J0Cl8e6ofHXyXS+CYBj4Orkl
 tkFFpO3ev62DBXC3+p4bqo2wzz8O+KHKQ4XhyNoiEXzZow1+qlsxwn5
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

According to the ABI the units after application of scale and offset are
milli degrees for temperature measurements and milli percent for relative
humidity measurements. Currently the resulting units are degree celsius for
temperature measurements and percent for relative humidity measurements.
Change scale factor to fix this issue.

Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity sensors")
Reported-by: Chris Lesiak <chris.lesiak@licorbio.com>
Suggested-by: Chris Lesiak <chris.lesiak@licorbio.com>
Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/iio/humidity/hdc3020.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hdc3020.c
index ffb25596d3a8bad01d1f84a9a972561266f65d76..8aa567d9aded9cab461f1f905b6b5ada721ba2f0 100644
--- a/drivers/iio/humidity/hdc3020.c
+++ b/drivers/iio/humidity/hdc3020.c
@@ -301,9 +301,9 @@ static int hdc3020_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		*val2 = 65536;
 		if (chan->type == IIO_TEMP)
-			*val = 175;
+			*val = 175 * MILLI;
 		else
-			*val = 100;
+			*val = 100 * MILLI;
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OFFSET:

-- 
2.39.5



