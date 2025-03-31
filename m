Return-Path: <linux-iio+bounces-17462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39863A7659D
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E563216A3B1
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FE713B59B;
	Mon, 31 Mar 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtczAyQI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692801E501C
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423417; cv=none; b=iG6ye9rnZhQK7SAVvqy40yo6T7mYHLcCiXDuM6ZkySFj9DlYIxoZZQKBR0YDpMvOLUFkw0eVCXSfClTx84yZxFItuvlZV/4nOJEVWZnXT608I+7yQjCsUg5+IlLuHqHOiUrighqqI+qF6PYhqbshBP54jhmE3QvilFrM2XIPP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423417; c=relaxed/simple;
	bh=tHXW3fpW98HEs9SmLkvRst4eFbAgpU4tqdgmDSr65lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lst+M6LN+SG9LehGtiZcSQajGjQpTspT4XOBGxeW2n8N6XrIKbGsXM6kArxw5Pbg15OhvB0X8lRO/d2ww4cdTqGYSrXRNwrO88Tya0+vIyoxDhcuNfhkYVefhz1FbZ5JM1DJuqUAQP3TlPb+hUCZimMCgAiff5QtaMLK+p1NKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtczAyQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DA1C4CEE3;
	Mon, 31 Mar 2025 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423416;
	bh=tHXW3fpW98HEs9SmLkvRst4eFbAgpU4tqdgmDSr65lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZtczAyQIBOw7/EiSJ7Z+BtPLCOjbTBKR3Xnx+0pfFX+Xlb93U5YXUUvSvsgP/Vpkw
	 qo0o0MpQV+e3N4CfS2RNndO4BhLhgoaO421sdXYZnviS40/TZzIyQkm0finQdnmOA5
	 kL95msN1OZMtB4VUJAEoX6ZP6566qjuIAWnusmiDO6mxVOHiRdCITiTEekzmbnVH8g
	 GZeFwWCl9cp4LXop25+oJFX+bCP2t6GE7kmvYVKAnozkuOMDfMBpLJbjBx8Eona4+n
	 F/86evhBR9X0npXMeNfvIz0DpW1x4E5coUSeLAhoL2zJvkawA6g94Pl4wdBtSsrbsY
	 8iUH1e17F69NA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 32/37] iio: proximity: pulsed-light: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:13:12 +0100
Message-ID: <20250331121317.1694135-33-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331121317.1694135-1-jic23@kernel.org>
References: <20250331121317.1694135-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index f3d054b06b4c..fbf9f8513055 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -208,7 +208,7 @@ static int lidar_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW: {
 		u16 reg;
 
-		if (iio_device_claim_direct_mode(indio_dev))
+		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
 		ret = lidar_get_measurement(data, &reg);
@@ -216,7 +216,7 @@ static int lidar_read_raw(struct iio_dev *indio_dev,
 			*val = reg;
 			ret = IIO_VAL_INT;
 		}
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		break;
 	}
 	case IIO_CHAN_INFO_SCALE:
-- 
2.48.1


