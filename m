Return-Path: <linux-iio+bounces-22011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D284B11938
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 09:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297121C8222D
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A3324BD02;
	Fri, 25 Jul 2025 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM32Z2Kd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980514A82
	for <linux-iio@vger.kernel.org>; Fri, 25 Jul 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753428751; cv=none; b=Uz8GjojAm+94ttC1rCnHOPmbS48N5+lCb4KOSPpvyfRVFTgEqySzoVnbpxS+In7Ic1q5aLRQ+B3tw7Lr1d0R6r/trnhZC54KtU3u6nqebaJDb70/4iTVZ/zPmQRK+mJdYy/NTIR2Syt/Hmb6xesP63l771/MQCSwNNjDdChMnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753428751; c=relaxed/simple;
	bh=K7rbXIiS1J+DTa4E/AvPNj5fPQ1p1OowZmpBqbJhh5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bTg6OfNMvUypapwF+Bcv17ISjxxrNV5k8kdg/1qN3b0NYw3rbZZu+3B8Chni1oJn6fMYWHqtUJgt7yVAGjt4iBL0OeDcrFLoZOvUtUpMkRsPPksw/KlaxKGIId4sMRq+ijyohXHJ0y9btp283+ySUbmoZ1ywc7Ws9UU+mcpHrOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM32Z2Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4336C4CEE7;
	Fri, 25 Jul 2025 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753428750;
	bh=K7rbXIiS1J+DTa4E/AvPNj5fPQ1p1OowZmpBqbJhh5g=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=SM32Z2KdYHORl/AYzJ7ssvoqWlpI0OljrhUcHdU50oN+TtpOLHvV9p6vFwXFItZti
	 R/foXX20v/nYcn3iOdIsYeRtqpSN4RJW/1f5WpH8fD7SuLv+dozgKMtblQcq5iG86d
	 xNbrLRgW3AUYZWhQSy3qaHi1N8GCGfXyBsptI+cp9rlLSSt2ARpdhJf03hbkZKrQIk
	 7bt7gOsSHHrIp1mBFuLUrbp2j8r6MGpSTfFm4sT8XS2L2NarmKiTvfTD/xjo6n8IK8
	 7Sdu5p5flCdxoNCRCE8peMOX0s+HB/fPh/RrsJv7cVq0l57Cf+3ivMn0y0i3BJ8loi
	 sLT7ziEO+j80g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A002EC87FCD;
	Fri, 25 Jul 2025 07:32:30 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 25 Jul 2025 07:32:55 +0100
Subject: [PATCH] iio: buffer: buffer-cb: drop double initialization of
 demux list
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-iio-minor-cleanup-v1-1-4e561372142e@analog.com>
X-B4-Tracking: v=1; b=H4sIABYlg2gC/x3MQQqAIBBA0avErBtIS6yuEi3EphooFaUIwrsnL
 d/i/xcSRaYEY/VCpJsTe1cg6grsbtxGyEsxyEaqRkuFzB5Pdj6iPci4K+DQmVborqfVKihdiLT
 y8z+nOecPkuAZ8mMAAAA=
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753425190; l=967;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WZdMjbzA4w28HJI0E9xLfu9MeSAA6z1IDKHR/cf1+5c=;
 b=gE/XGhhk+L8zJrKCpXfbW+99Q0fn3VQa9EBMCNVE6FmNUMi3kjmb6ltwqsze1pt/tqk2J/KTq
 Vqado82/cNVClS+x7a72OMK4Dn6J/6golhyuQX0diavTTeMA6d8pkDS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Drop the call to INIT_LIST_HEAD(&cb_buff->buffer.demux_list). That's
already done in iio_buffer_init(&cb_buff->buffer).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-cb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
index 4befc9f55201e..3e27385069edb 100644
--- a/drivers/iio/buffer/industrialio-buffer-cb.c
+++ b/drivers/iio/buffer/industrialio-buffer-cb.c
@@ -68,7 +68,6 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
 	cb_buff->private = private;
 	cb_buff->cb = cb;
 	cb_buff->buffer.access = &iio_cb_access;
-	INIT_LIST_HEAD(&cb_buff->buffer.demux_list);
 
 	cb_buff->channels = iio_channel_get_all(dev);
 	if (IS_ERR(cb_buff->channels)) {

---
base-commit: a10185367eccb4d79efdeb09eb59c964ca7659f7
change-id: 20250725-iio-minor-cleanup-94a31748efc5
--

Thanks!
- Nuno Sá



