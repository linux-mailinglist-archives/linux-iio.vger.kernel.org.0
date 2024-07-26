Return-Path: <linux-iio+bounces-7914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C593CF84
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50921F2164C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F07C1779A9;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJtFYKq4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F6176FAB;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982180; cv=none; b=PBDwcB3PTjjtzTXqtoILhryMTOcEy9tO/k/9L1vnhLycw8t4XPYi4IKweNdMkYx9uL85/oDWTxqLywrla0LsRGA6YsgWSOMTxMPo/LH2qvgxbSQd2cFD1sA/1vHILNg06niUZkyNfoqpQRPas0P+QaTBHzGjtEts0TbX3fHdKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982180; c=relaxed/simple;
	bh=Gwn7ZTUHlECfhYYacHALhwZsJ0rmOVOb9dtKY6d6B8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSj/nIq6qImyDD5ZF7Iz4HhbkYK7HwQV+teEI5I5Nnax30L7pa338/huE64biN+bX6jPNViiymIkg0tcGqou/ZLz+whvIyV35bTQqHBYNrhRjA/zyT931awmcgN316GAB+Da+l/c9jliOSMi9p1bkMNm7uG0JzDHpaBLs8srvaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJtFYKq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FFBBC4AF12;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=Gwn7ZTUHlECfhYYacHALhwZsJ0rmOVOb9dtKY6d6B8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qJtFYKq49obdq9Yz7lRuhsjNZ466aeW+X+vdF9qKXe5OcAFByC0N9kQ0QUANm9VmT
	 Nxo1QF5iuaWermckxeI9jbzDOLU3VwWojGgyHLbIyTDf29+nYANGlbglGz9e4HLpOv
	 3OKEj4WM8c/XASsp80xzAfAizWXQHfq3QJ+ln0+Dovnbtd48+VpoesNVJthfTCKqpR
	 73VT58GOOiKODrjo4/UZxTPwnth9OZ0TnVcL6wi2vdFguwEo4CK/MMV5u6wwWdp0Ew
	 Up+gpmiRlUnbdOQhCNHohj20/jcBg4w74Cu6ZkcJwpf9qLyb3BB9HexgB2XpvcSMkv
	 Ky4AHuCu4qFdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666A0C3DA49;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:22:57 +0200
Subject: [PATCH 05/23] iio: adc: mt6360-adc: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-5-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=948;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=taLxe9Vc9oQlWigvEjOpJItzkkFm/mOSh+oraOTypJU=;
 b=extdcZH9h4D5owPJaeCrVkF5FRVuEYGg6WbJK9beg7bryIg+ygmXm/j2ykUISALFdDeQnTfaa
 IsedS9SScB/B2t79pK0aTzgi1Ux1+hLmhPK15J4yRJbpOIbfgW9ZJrc
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
 drivers/iio/adc/mt6360-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 3710473e526fc..f74347663ad80 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -268,7 +268,7 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
 	int i = 0, bit, val, ret;
 
 	memset(&data, 0, sizeof(data));
-	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		ret = mt6360_adc_read_channel(mad, bit, &val);
 		if (ret < 0) {
 			dev_warn(&indio_dev->dev, "Failed to get channel %d conversion val\n", bit);

-- 
2.45.2



