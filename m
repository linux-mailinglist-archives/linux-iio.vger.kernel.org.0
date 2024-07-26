Return-Path: <linux-iio+bounces-7918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8588393CF88
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB3C282B5D
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B060178369;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLhCL9hQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DA1176FCE;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=CJJ+4uItK2rUL7MFwywDTANMVfWxVriEqNtfBSDzV/WyJCj/xC76kz+TPZFrGtu92gyvuOhwfrOBygNUhJhnx07xR2FPhes2++tfaNWVjttDy8JUVfZ7yK0pGTfleeu78LXfncInTxLEM7c1Z1gpO6Y8hPW1CWZX4CpUImKGMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=402Dwm9EJynx+1mrrqvRMo6y3W805dGu4Xm3Y1Jkk8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bUZTU+S2mzGIsRap1BnhiKzWmu5qCgrhtDe4V+jQpcIVDpDGs0K8ru4Ok/wO6ijY8EWOmeBBm++UDdod5g0ypJD/kLbd1Pn7AtYEUNQU3LfpMP6RCCZM7lZk9uNi1F8K46MMAOAg3ycqlqpyb2El96aecEOrCppZgwbjeD+/Vjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLhCL9hQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E807AC4AF1D;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=402Dwm9EJynx+1mrrqvRMo6y3W805dGu4Xm3Y1Jkk8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pLhCL9hQS0tN2qW7GRNfr0b2xdwWk4/aPz+ka9eZJEgyu6L6aA84wqAqJHfFJkphW
	 rdTRsXJBHSJrXPYEcm8ZRVq1EYsVMXltuDDdS8COTFnUF7GnPJYChz8vnh5ZHqwhH/
	 AXJpzEMX0ZSqcZAvg+7mlT4bq9at6fwYu67mOqd05UZZSmeSQA0tzSjRtX6cBNw/p2
	 uAqSLdeXrnYxLaBhNPfAibrl+wAN2YtbHxC07/is0Nc9tLoWBwmotIcgxlSiHuSYbf
	 vRLUiGQ1983oLnVB951AHZyki+T7i5rSdQffU5aLIsN0o3+SgiEcd/j1BAXZaK7wi4
	 D9K/Ji8iUedMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECACC3DA7F;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:04 +0200
Subject: [PATCH 12/23] iio: adc: ti-ads1015: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-12-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=817;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ros0/KTpvpHjj+SLIUp8X2OMblmp93RuOlqoJiAk9Ig=;
 b=EFOEra5KEDEFHNMAogNGWW6BAHZEP+AErylMLRgjYMLPvEtxCl20KZysf3uMt+w6KOvC2xT+Z
 KjYzaiTPUYGC7DNU6n0QAT6ozK6qJJKYFnJSpPf5tt3qTiO9P6NUNeS
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
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index d3363d02f292..ca432c49eab1 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -456,7 +456,7 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->lock);
 	chan = find_first_bit(indio_dev->active_scan_mask,
-			      indio_dev->masklength);
+			      iio_get_masklength(indio_dev));
 	ret = ads1015_get_adc_result(data, chan, &res);
 	if (ret < 0) {
 		mutex_unlock(&data->lock);

-- 
2.45.2



