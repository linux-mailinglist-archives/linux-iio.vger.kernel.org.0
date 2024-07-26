Return-Path: <linux-iio+bounces-7920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C693CF8B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25E7B2260A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBFD178374;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToXL54IP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2181369B1;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=NvQAxIy//jx8/we8YM+eie+LRQG0S/JZXCD+v99Fod2V1A5O3HfzpauyMaLDpZF4oH9q2YxzPkHPSyYeJsyQd6GhXYaJ/opBD6nyQxGf/66fW0JDPoHbgta7NQGNFF6d/4Lpyg5B1+a7qyRWqtYNDGsvR6J2ZpLz5bceDysii40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=5lWBN3x7yzmJzI21qdeZUQEtQmV1CWl/qAfX28wS1m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McXIbEmzqjMrKIrlV7vIfwB5f2Ce/vnR5y0Sz/eS+wWaUXWNolRtnmA6Wdy9FIZNu9lO8yv6TRcXzKK741xRkTK2LrdhV//0xH4JX+sKvrqTKia3E80uYpxpEONPd8Idk7Ne5QZ5/dX+cNL2FJ8VhoV38Zj0TCwUSsEXKdyK2ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToXL54IP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFFA9C32782;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=5lWBN3x7yzmJzI21qdeZUQEtQmV1CWl/qAfX28wS1m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ToXL54IPqtPoxYWXSTUfO+Sg0e81zbStINhnC3eK89B/LbKbucMaE6TRpw86trtGU
	 YvxhEeyd0t2p5fjV39Dh22uwsdbto7/+C+IdxfeHMwd16m2JeWyT9EYy7ymObKMzF1
	 1pFq29LqCCTSao+0rtekht/j7nWc++BIHvVmWL4AZ9zwp98rPqq4s5g5ej1F4W8XLD
	 uUOnzhZL6+CWJkYMqiVhPjMQ7LcUeFHO5xcsL9PifepzxTRnGgstjjuMiE2D9h7390
	 IXc5Q1k7rCEsK+EPUcY4k4cNQ/ic/Jv39gCpBxuD2cNBeZ0l/izQYmQF/oMfswARyL
	 RR5n3BmcYB2gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7464C3DA7F;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:01 +0200
Subject: [PATCH 09/23] iio: adc: stm32-dfsdm-adc: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-9-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=891;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=aTgdqh0aJ1pDba+LtwcspxT4H9yCpKDHYZJ0iNZrIwE=;
 b=qTE3TyReW61ZawmIaxnS8JEFNUS99QanZ+9aNsvDcl5dqwoWeW+TXGjOqN0MLDIUIT6EWuKte
 luKnQ1LkDdyA47LQ2ebBiOd5gkHs808gjk6oHb5PyogY8P7nLgx84js
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
 drivers/iio/adc/stm32-dfsdm-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index fabd654245f5..15b8a4c0b272 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -987,7 +987,7 @@ static int stm32_dfsdm_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 
-	adc->nconv = bitmap_weight(scan_mask, indio_dev->masklength);
+	adc->nconv = bitmap_weight(scan_mask, iio_get_masklength(indio_dev));
 	adc->smask = *scan_mask;
 
 	dev_dbg(&indio_dev->dev, "nconv=%d mask=%lx\n", adc->nconv, *scan_mask);

-- 
2.45.2



