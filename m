Return-Path: <linux-iio+bounces-7908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9493CF7F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51141F21FF8
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8958176FA8;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtqGdrzX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7042A8A;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982180; cv=none; b=MisDuQkkyjFr2/zGV9C1hxzoImed0IW5MvpgAVx1gUP0a9gJvBCbqMooBh7+2cNNbSqKrDvNZ3Jr3eURECC/W6Z215TSpbF59hPyn9GL3mPDM6NiKdhmyNxyZ6PT1nzKyotq63bo9XeRPrmkosOz/K6DQj1SS4C5YzVuo5DCuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982180; c=relaxed/simple;
	bh=LzvDFFB+TelTfSCAfgpCsKNARcocA43Ip7WAHqdgf2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/Wv24rkpEmnimaX4YrLWMn60HYIC/jSsF4/lJBfuvuDf9QyGkG++y9PtQAmNf81lypttsR7AjOmTQ5M4SuwdLNq18891wOzXReyQoWZvvnJpW6Wbi+iUxjH/bTr3oFTeSBQWUF/KXnOamiCg3tkbgGQsFpuYAHA1vpmm0mpZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtqGdrzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FA88C4AF0A;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=LzvDFFB+TelTfSCAfgpCsKNARcocA43Ip7WAHqdgf2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qtqGdrzXIOH1iyZ2aH1z8tK08hnfZ0TCwyNJP/XZg85kvgf69iTwDeAPnHKa0NqCV
	 lsP+E5wuFRXPeevETdxpi+iVzo6gOVVEZJ3OZleT5G+SV2O2Th4aUB8nhVAKJwbByA
	 2woHqFA5Lb88TaMVuhIE05m2AENXvocq9SFQipOZULNiiLAkkhJSdD/mW7RPS1cqmt
	 kidWTBynJDe2jCq30DL9PR5mDwIlVQpP5oSEzkb//0t1hJZ4Vgp3042SV+2oaONxAz
	 wumCPvcfw8HAAqzAdlorEgcjrw5ZN068eZxWGbWaw+dPJkq7/Okvosu1sEAq7F6eBv
	 xa+QjP3DFuv9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B435C3DA7F;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:22:53 +0200
Subject: [PATCH 01/23] iio: accel: adxl380: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-1-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=837;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=4H4gd1mTf71nKs//tKbiKvw51/pe/swi+OU/DwsYlO8=;
 b=UhNwEc2LqguPS+kPVUDA3jFFCWJYp2ygQzUmLt4TUoc4j/3SCy796NjQe2DVNWwATHkADS92n
 /ts7cNrtSGSDG6wZF7Jo7VJ+3xKUGw5HwS5ljjFkj5TFmWOq+0aNNl8
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
 drivers/iio/accel/adxl380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 41b01792161c..98863e22bb6b 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -1110,7 +1110,7 @@ static int adxl380_buffer_postenable(struct iio_dev *indio_dev)
 	}
 
 	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
-					  indio_dev->masklength);
+					  iio_get_masklength(indio_dev));
 
 	if ((st->watermark * st->fifo_set_size) > ADXL380_FIFO_SAMPLES)
 		st->watermark = (ADXL380_FIFO_SAMPLES  / st->fifo_set_size);

-- 
2.45.2



