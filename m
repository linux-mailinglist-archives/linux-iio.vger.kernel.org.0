Return-Path: <linux-iio+bounces-22205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE81B18F72
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 18:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE4B17EEF9
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FFB242D9C;
	Sat,  2 Aug 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+3R4BrG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BC256D
	for <linux-iio@vger.kernel.org>; Sat,  2 Aug 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153140; cv=none; b=V2zVC0c3DRj0XE74GQssyeblHwYCw1Yyk1BqYOyKNsaTyc8QXoE655ioxTcyiHbYuWnIMuaiqTZL4mEL9luTd5tlMEnv6BORkR7qpMv4ao4Gt4+Ikmp7RihKn+9RT3zakh6CCAmkorCGXyIn6h/lp3El7DaQFOV365mUY1R6Xbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153140; c=relaxed/simple;
	bh=osW8ZX+XLjWRemlEKX2ihnIdD3p/g2QfMP9fS5+ID5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ygh13nRoQ8Ly6S+9NDYvePZBaDDI0ic5XTbAJexOPhzY8N2M++6lSPVrLbghJ1n0PMAwQGVxVzdMIcduIOZof9CBtDGzUFwKd4j+jn2JWil4gz/ks5vLkPUUZNLoCGr9rJ8r00OxFrAsfG+oMHwE5/as5DmvUrCOwQ5F2rOtE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+3R4BrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EBFC4CEEF;
	Sat,  2 Aug 2025 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153140;
	bh=osW8ZX+XLjWRemlEKX2ihnIdD3p/g2QfMP9fS5+ID5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+3R4BrGrboPCp3p7Phk1CpmLNmxY6qLai3XC1MQthR1UpGLgSQKXvp1m8O2Qswfo
	 Uvvzt2R6fY9Irt2KDNAyz3v/jJqceawhJKVry5HNkVFItHm4J3hH9LN29oXpbRsB1f
	 lT04cjD5ltzl7xtLCWPNt9TMcxeao+aYS5jsjxdJ/3b7TyuezN0BDQ762zv9QL/TVT
	 3KgP5ZQMMPC7RiSjFHxUtymngOrQatVe5nvQq33+ggXEUjgz+Hvn2kzpundtk0+DNC
	 J7tcTTGpEJyCHXmaJv9SlxLN2cpix7NOw4WmJCXRSGxsSeBaLp4g9oV6T+YrKIT1y9
	 /YLQxVdq0L/4g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	=?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Christian Eggers <ChristianEggersceggers@arri.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/16] iio: light: acpi-als: Use iio_push_to_buffers_with_ts() to allow runtime source size check
Date: Sat,  2 Aug 2025 17:44:27 +0100
Message-ID: <20250802164436.515988-8-jic23@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802164436.515988-1-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This function allows for runtime detection of undersized storage which
can be non obvious due to the injection of a timestamp within the helper.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/light/acpi-als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 511ed37e783e..d5d1a8b9c035 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -167,7 +167,7 @@ static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
 	if (!pf->timestamp)
 		pf->timestamp = iio_get_time_ns(indio_dev);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
 out:
 	mutex_unlock(&als->lock);
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.50.1


