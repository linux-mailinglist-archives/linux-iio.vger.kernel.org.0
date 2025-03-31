Return-Path: <linux-iio+bounces-17437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A6AA7657C
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C40188893B
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166C1E3774;
	Mon, 31 Mar 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/ISQ8AK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12391E32A0
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423259; cv=none; b=JgYWKhKeZQu9LJcowoIMxLqmvvrrjC4dBBuqjPQhPNoetL3YNnC/O3CnrUf8G+pTpDWv2ucOCxavuYiExXj8/Apl6tE+i4V712mb6duMY52DafSVpMwEB1AobEtV7SX07zlhH9piDE3Jg8hcXXTXuhKOfdy/OWjtm80QD3bIdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423259; c=relaxed/simple;
	bh=Ob0O353xdKJM4VuAfqQkzmXiz4hl4zoxauKuKmY56+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyvBCGSVGDFkYIg1iZtyAmqMMStg7WRZGUt+5TQM7R/+GLPdIM9mGWoO0jA7+pfZyab5SytpOBaQebCubggWvQVWFLrhuCy2E8TCBegvdqgx2tgjOMGt7bFFbC0dzwFrlSaJVwx/x79yPflQxei2SZU9/gSIC9s8nfXdN/WnYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/ISQ8AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1F9C4CEE3;
	Mon, 31 Mar 2025 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743423259;
	bh=Ob0O353xdKJM4VuAfqQkzmXiz4hl4zoxauKuKmY56+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/ISQ8AKyVaZLe+xh4Rik6p4SHGYO/6UvvbOWLwbT6fdtS73UgK+MMZQItW2sOO4E
	 M4Tj+/Ga6yLZMtcdoMLjnum23SYm3XbOXwr7aJki2WeCVGF6g+jvX3qCpHhEAM1xHD
	 SqSfMAKw/RcmJ1lvJ/IuRhlBoPA6dQhBvnO1IHkXa4j1vW03apHOma5l9nFUdHDqnJ
	 GVyZ0NwxATlHL9anaYhCk3ma7Is9JIdXa0QboiAvgdA3vwaP0S8QElV3DkWCj/4tyf
	 bFw4QZfuw1RhMwiJ+rB2z8H+ugafiOx4NnH5XVEJk7wvTUHPqXvA1BE5iFVzk9RbQr
	 jS93euW+cGUEA==
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
Subject: [PATCH 07/37] iio: common: st_sensors: Switch to sparse friendly iio_device_claim/release_direct()
Date: Mon, 31 Mar 2025 13:12:47 +0100
Message-ID: <20250331121317.1694135-8-jic23@kernel.org>
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
 drivers/iio/common/st_sensors/st_sensors_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index e4f5a7ff7e74..8ce1dccfea4f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -530,9 +530,8 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 	int err;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	err = iio_device_claim_direct_mode(indio_dev);
-	if (err)
-		return err;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	mutex_lock(&sdata->odr_lock);
 
@@ -551,7 +550,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 
 out:
 	mutex_unlock(&sdata->odr_lock);
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return err;
 }
-- 
2.48.1


