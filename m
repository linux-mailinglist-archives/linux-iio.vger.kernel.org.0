Return-Path: <linux-iio+bounces-19175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D6AAA6AF
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 02:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A835F5A2DCD
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 00:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7D5291169;
	Mon,  5 May 2025 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niM801Kn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205663272D6;
	Mon,  5 May 2025 22:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484484; cv=none; b=ORbKFTQ1il0GWTzRXSflAQnc5YVhd84IVSmdNjaPyqVlCap6NoKFf5uxwN1YQP4e8uc21P3spcLMgf39N4CW/ZJmCvxctepw/P00Q2T2lgnalrNbjLo/pr1da/lsuPTA6fEtRGo5C4bFpLOj0+aAfsxzKkrEv2NJ3qgL4S08E0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484484; c=relaxed/simple;
	bh=y4du74TKn+X96QeimtPntdcuAS8xlZ9guu7x0q8AqmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xptw/cphfUdq2LXI7Lx31jqwoYM4xMMx4lJ7JukZcQxetI4fs5ZMYtJTCgp9gs5Ge5YfEv+///sp8aS3uLX5fIK6FmJcDdPg2rquhWgs0wUzLBAxpdl3HRLNDvIefuY306q7BznRNLr0TqP3iAk/U+YHnEAKT1NUjyukGDIgLgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niM801Kn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87F2C4CEF2;
	Mon,  5 May 2025 22:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484484;
	bh=y4du74TKn+X96QeimtPntdcuAS8xlZ9guu7x0q8AqmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niM801Kn28TE2aSEKtRGHxOUObxGnF7iVPRKtzHT+L5zZf+a3JAWqg5DHhTMK/XBF
	 Vd6ZEb3VGXDspa8dfPf+FqZrcFw/tmi/6bAQSG2xRX+qV6+kWFFPRq5JEbfZ4MTXFH
	 m6gM2AqY7tjSgXN8Oru2AXzJryDyHyuRvwPnIuHf/Kh0UtLqDrxVQuk7BGba9LUTjF
	 3VduyqzYw75hNcCJyl39Ov+OBWg7FgZdJb7nK3y+mBvHDp86ESRrdLb+kMOt586OPi
	 WxzUSuEBJFZb5Q2nWX/Lnsal3mx6gJE+n+0NG7oXebXXM0zZZWMhXcqZzcDnB8lrlU
	 mIZylBk+xuLbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 493/642] iio: adc: ad7606: protect register access
Date: Mon,  5 May 2025 18:11:49 -0400
Message-Id: <20250505221419.2672473-493-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

[ Upstream commit 0f65f59e632d942cccffd12c36036c24eb7037eb ]

Protect register (and bus) access from concurrent
read / write. Needed in the backend operating mode.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250210-wip-bl-ad7606_add_backend_sw_mode-v4-7-160df18b1da7@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7606.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d39354afd5394..2b0725449a6ab 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -852,7 +852,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		}
 		val = (val * MICRO) + val2;
 		i = find_closest(val, scale_avail_uv, cs->num_scales);
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
 		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		cs->range = i;
@@ -863,7 +868,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		i = find_closest(val, st->oversampling_avail,
 				 st->num_os_ratios);
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
 		ret = st->write_os(indio_dev, i);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		st->oversampling = st->oversampling_avail[i];
-- 
2.39.5


