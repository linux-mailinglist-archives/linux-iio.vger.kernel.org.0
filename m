Return-Path: <linux-iio+bounces-16608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590FBA585FC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CBD3ABCE1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8531DE8B8;
	Sun,  9 Mar 2025 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndrIvdJD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25141DE4CA
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540015; cv=none; b=fi4V7XZnvs7FbetCtysNx1yU0+ukrhwsS6KziaatXQzyF+0SMNLWjWhQmQqNdOj/lZXmt6bWrBl34HqfnPZjwX/Ty+Sf0BWE3JDE/fWYbFL/2FFIE83jjZX956ySTC3p5R8VUWRALlexOp5Dpnpa7l8XmVUofeILO8p1296ZoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540015; c=relaxed/simple;
	bh=YVTk/NADw0S7PmJCxQqiE9c6y7fLriCnGfUa55G7ME8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjVOYPnWvAEbCpJLXRZAFmawDtHC6hq27vPAR5hnxDUyLyToXsfTNKdK/Zx04uu9Qunu/XU5KQ+/XgEu5FeKMsj/fNKNUmkrPgfTrD6N/ssxy/eDFAhCWTerpx3Wlrv56hGfxRvM+g/YhC3uiJ+rX0pqnATyZG1ZyQdvvO2gSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndrIvdJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16739C4CEE3;
	Sun,  9 Mar 2025 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540014;
	bh=YVTk/NADw0S7PmJCxQqiE9c6y7fLriCnGfUa55G7ME8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndrIvdJDL16g+jPzDXM6rpWdZ9v4b8DeVeiJFUMrx+gxFX8wuRgLFb16niWC4gphM
	 hzM1zQ0D0qSYJIGktSB+j+KeBEct+zTO13VIhG3ZrFXvWeBsRlsdOoIijMP//XTSfP
	 uBVMDQkkAsteG9cmxagiTEr5QiFLn5ITrUzBaQxeK2A4GhpadTSnztsxxhWC9+HYDR
	 vBPqt0aPPP1WHxF1F5+mq6sYIrSdcZP+tFbg7sdLocSX3+etIIZZRJZ8hZob7g5P2m
	 JMV5hcWpZNLKh/CziThD+gC7zAh29u1HBQQ+EyDfiIGK8fVEwbrVQcDWabjAmdLAvA
	 gCYdu5F5zKwjg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/18] iio: light: gp2ap020a00f: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:17 +0000
Message-ID: <20250309170633.1347476-3-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
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
 drivers/iio/light/gp2ap020a00f.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 1a352c88598e..c7df4b258e2c 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1283,12 +1283,11 @@ static int gp2ap020a00f_read_raw(struct iio_dev *indio_dev,
 	int err = -EINVAL;
 
 	if (mask == IIO_CHAN_INFO_RAW) {
-		err = iio_device_claim_direct_mode(indio_dev);
-		if (err)
-			return err;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		err = gp2ap020a00f_read_channel(data, chan, val);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 	}
 	return err < 0 ? err : IIO_VAL_INT;
 }
-- 
2.48.1


