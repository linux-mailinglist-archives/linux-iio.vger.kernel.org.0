Return-Path: <linux-iio+bounces-7911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8793CF81
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0BAC1C20E4D
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192D176FBD;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAeCjuKW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65AC176246;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982180; cv=none; b=OW98YDdZ+WOBxDp7dRcFdMrFreN5jyaeOjA3ngfX7pO3zMmGPZmfttilZzdi2TJ1qS4Ms47hgp6zm4TY/1KSBFPIvRdkIpBvCUPyBrWCWCjDKpZ3XI0fq11zc4PrFTyDq32DfDRdX8izUT5rr2c385FI3+7k7P8vILvm49UXCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982180; c=relaxed/simple;
	bh=dfsq9WXesUjhbKDtpY0RiTZOI95oQv5z6XwXaAoOuH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rck2QB6+QsNRpkFn7hAh3P8pq+9xvzlRtCjVY0E/USDVAXj47GaWbLAOTYS8tXbxvXOW3sc2/tS34XD8O8Tgt7LrqVSgEMC0G4HsN+D8qdhGDrYcftyvdVr7VWD6bz5DJZQL0iUhY6qbBsDYukvoCJhxi49TjUPUkVKAk+IaUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAeCjuKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CFA4C4AF0B;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=dfsq9WXesUjhbKDtpY0RiTZOI95oQv5z6XwXaAoOuH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bAeCjuKWzTG5YdofyfYqWmClLvx5xoqta28cThf5tEcXIkX4pPJzEj0c849G+tjzt
	 hUCM0wVNIKWE4Z4KaPzU8vjbzaCFbqNAfgETc2sgrLyf9VBjNC0Gxkla4YXCPdVlbG
	 bnCbaDhA3KS9vXYvtPJjiicmWWThWGz8mVZFXDRAg6EJc1CjQ5daVhAP5ewL662IP1
	 yR/2gXA5g8LUdaqlpbtmcYK0/6TJL3sPLuOB8Hcg1tYUsvJUHwSIxf0TbhQtnuH+CE
	 HNmHB2yfKm0tq6usnExYN3TaUP7VDSUMS1FvTt3sCe6Exj7kmw5FhsYhQCWGEVK2Qq
	 UHpWAwFVrKQ7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4E2C52CD8;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:22:54 +0200
Subject: [PATCH 02/23] iio: adc: max1118: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-2-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=926;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=nn62DtDibXVy47IeSmUQXIyZlnKipK1U1Mlc06sEa04=;
 b=K7HowwyOrxCHk/s6AK4Sic1wW5+fc03nmNJIDvIQqUlN4gtgX23F5jqgDi+fFn26kmah385Vy
 g6xHmcZlad2CMtUhdMspRvGDY7mECcSV5itDWrXFs0AB1wg+te5bKBm
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_for_each_active_channel() to iterate over active channels
accessing '.masklength' so it can be annotated as __private when there are
no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ina2xx-adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 727e390bd979..0fc24bceb58a 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -755,8 +755,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
 	 * Single register reads: bulk_read will not work with ina226/219
 	 * as there is no auto-increment of the register pointer.
 	 */
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		unsigned int val;
 
 		ret = regmap_read(chip->regmap,

-- 
2.45.2



