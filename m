Return-Path: <linux-iio+bounces-14997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA56A27C54
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 21:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD961886449
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 20:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EF203710;
	Tue,  4 Feb 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8OjJBhE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC814B094
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699398; cv=none; b=sGGOtDJS7p2QpEnYlgEHmwpZx1Nqp2EwRXZHaTN6QYjmNqS8o1YyHQtwiMgtsqZSQJOhMF5o9zTPGpD817woG2C8llAlmiZ1+3spH4s9kma2GQvmpmOJuiZ2s39rLdzjPMVTVQCXRlKuYi2nq/kAxGIMo7ZAcP+U5sLSDHKo6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699398; c=relaxed/simple;
	bh=71NqriHyNtjrjorq5YuMiGlNrNWo4FgWarmoj+f4WZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI5eCgCMch24Q/Xc0CsuolTZ/8Xl+h6xMP0Q+HElkaEx+VpurNZNt5K6QFj4BbXSIAvtJb2kQ8o/rV2R/69V7/CK2k2Hr+y8FY4h0gWY3UiJzmCMZc2qnsRw9Z9zdKYQemEJ94e6UJ60Uh2Cge9lT8LfCk3SrpJyV2pVSjVugOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8OjJBhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E390C4CEE2;
	Tue,  4 Feb 2025 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738699397;
	bh=71NqriHyNtjrjorq5YuMiGlNrNWo4FgWarmoj+f4WZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8OjJBhEje+h1df5LTpMuWwD4mH5KXnOIvvCbFCNcOAlNAZXaHnUJ3y7X9wCU3waJ
	 wJY9Avy34UQ7Iyszzy0+V3t28RM+Q3bhCJo0c59UIrmfgYKduRKfXTitHH9TSeZfpi
	 kIV54eIXnRtFfJGWgB5v51idoywQC/ALAZZPVh070B3lc+lJRT/fC9qBaNVx9fCFLP
	 2vHEmNu9xwvgAHNlM3MoMHQq2SnfJ/LtE0D3DtJmqZReS268PwKIgdXD2wpnzH8Apt
	 YPvq+smsvlzzs5CIfaFYGTz1Qv4mLzlOsaYI8ZFLZkEjrXs6daPM404kWnSJ+1fu9u
	 HZ0lVXWszV9QQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/27] iio: chemical: scd30: Switch to sparse friendly claim/release_direct()
Date: Tue,  4 Feb 2025 20:02:25 +0000
Message-ID: <20250204200250.636721-4-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204200250.636721-1-jic23@kernel.org>
References: <20250204200250.636721-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver caused a false positive with __cond_lock() style solution
but is fine with the simple boolean return approach now used.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
v1: Adapted due to new use of guards() in previous patch.
---
 drivers/iio/chemical/scd30_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 7a864b52adf1..82859a66c91a 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -211,18 +211,17 @@ static int scd30_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 			return IIO_VAL_INT;
 		}
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = scd30_read(state);
 		if (ret) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 
 		*val = state->meas[chan->address];
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-- 
2.48.1


