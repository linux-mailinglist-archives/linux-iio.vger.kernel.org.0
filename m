Return-Path: <linux-iio+bounces-7930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC593CF93
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46449282AD5
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC344178375;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNqUyaS6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A896117838B;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=BMYDZxRo5DFill194hCUVkVYds6yoyrfxi21VnnXhKmfQ7jfToO4B73gspRHMli4yR5SyDNLLE6RqUpQyHiFtlcmZ94e75WY1mj1pUwYuCb1m3i7zsBBpsA0V/YqNVJQQytwZ9zDtD9V0YESs8/ITl64f3g+T+rYivsBzT/UV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=Fc89Zo39U5XhrFVqaThzOFPguhMAMPRG63FLoUPJGow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3CzR9VoszwQ54TPF42//paCayMQew6Ef36o5m8jSI+AVohfCSPAMxTFdWljVksZVD2Abw9DfeYdTEVp8XNFBAB9Tkb3vAcGK18pIIUr8PWpoYRfgCFhkeHAWNMF/M3zA+3bmEHUblc4G1+NNiUtRn/kiVMdwnceIsTQBSa753g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNqUyaS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A3BDC4AF48;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=Fc89Zo39U5XhrFVqaThzOFPguhMAMPRG63FLoUPJGow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HNqUyaS6B8ouep6bbc/kH4LI5cd3oU9FkC3LhNzHnaeTvKIUm0DahqV7nO6UUZDzr
	 8Ee7nq1o+gIbSdlxctn5dInk3IHrEvrhni/H6B/nuuy8UoSb0Es2O/q3ugXmjlrVfR
	 KZ/Yh116Qbk/IHj5GvdJQVU//Hj0Jg6RpJYxs1/bxFVFms0Runi1D9phzQfQE0Nsgl
	 tHWdtfGcqKaSkHKaejujes3Gmm1V228NzSiJ/7g9CJ+NkL+rl0KeiReykV0MGME/Vx
	 32YuvkbnQJBXo7aCuQjnQH2ZSsszaGPs1LhMCyk3jFgVARLh0JZtZi2ZkLGCSNxXD3
	 2jo011z0cWFyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ECAC3DA7F;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:14 +0200
Subject: [PATCH 22/23] staging: iio: impedance-analyzer: ad5933: make use
 of iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-22-82913fc0fb87@analog.com>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=1330;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=c0I9qL0LI7awsPlfCnHRYsDuN3fDHd+WekusA9Lsjrc=;
 b=HamDoKKSvrVM8qMEmKTUmqg2UDsVU3dhHUw4FVGu6oOJp0Ox0ewjR6RrydWg7g6SvnB30CgS3
 nI/mcpH3syUD7fsXKguvB30O3QbtVQmbmeVIJn2Eo4ZQokppKynGUaf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_get_masklength() to access '.masklength' so it can be annotated
as __private when there are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index cd00d9607565..4ae1a7039418 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -547,7 +547,8 @@ static int ad5933_ring_preenable(struct iio_dev *indio_dev)
 	struct ad5933_state *st = iio_priv(indio_dev);
 	int ret;
 
-	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
+	if (bitmap_empty(indio_dev->active_scan_mask,
+			 iio_get_masklength(indio_dev)))
 		return -EINVAL;
 
 	ret = ad5933_reset(st);
@@ -625,7 +626,7 @@ static void ad5933_work(struct work_struct *work)
 
 	if (status & AD5933_STAT_DATA_VALID) {
 		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
-					       indio_dev->masklength);
+					       iio_get_masklength(indio_dev));
 		ret = ad5933_i2c_read(st->client,
 				test_bit(1, indio_dev->active_scan_mask) ?
 				AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,

-- 
2.45.2



