Return-Path: <linux-iio+bounces-5153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC548CAA3D
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 10:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9371C20B9A
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 08:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4257CB1;
	Tue, 21 May 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKMEV1re"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED55676F;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281187; cv=none; b=JvpnCT0CcjcRIf5OSCh1xLtHBGeJrnzHKP5ssLPjJaEv95HzZ0Sl/TocZjsFqXxmaHXrjodkZ7+JfvC6DWl3JXyfVZcqSlEHktlkMsyfcTiAHF2woe/8XkFOK4IyXBTk4kI/Dr1io4rmcgcg0cj0UVfoNePdIidiwQURMQYYfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281187; c=relaxed/simple;
	bh=C5v4/fLzS6Bdo8dJf1AM1vOKlChKS52Cq8X9QRh1u/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZWMzEdgMaBdpY9nJJXmevqZfDIK2PRG3KdWXqEjegysMdnTuIf+WE2rhFYWh3k+C6cNIrmuPy0+59z6bTJZhSXLzbjxiv8nPXtr1ksRrJy/slVH2Eo0CEARJ1bT0m3lrswrDkvFUrOiEHOIFJ2E5Dt8hHS9ArU2DDB3DDlvbro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKMEV1re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F905C4AF09;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716281186;
	bh=C5v4/fLzS6Bdo8dJf1AM1vOKlChKS52Cq8X9QRh1u/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hKMEV1reeeKSM6fSCtgDFn23jtW7WBSlf6PVbq3Y7+B/epl0vHGglZwr5ngzy/i7h
	 GDEBXbsFqeVH3QiSvdMw+Ol4BAa0+Y/XRzUXt+Z5s2WlxRku93o7ESz2EclevsTPcx
	 oAPCsSrrmhTD3q8uFucqUpWt6gLULkSJEyjlzz28wt4wpLPPvfuSCg39gFz2XB//QU
	 OyAP7Xxw5p1teU4zshXOFbjhzLsWr1DsVh4CSpon9Htg0RX7r4aShJ3I7OtMzUjkKi
	 ZkGKgYQc3X7Z8oF6ficEet92QCxijVXYfrxD02OQPZGTLMc0N5ciVHL0IGCQMEYnuV
	 s7uqP+m6n8unQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276EC25B7D;
	Tue, 21 May 2024 08:46:26 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Tue, 21 May 2024 11:45:41 +0300
Subject: [PATCH 3/3] iio: adc: ad7173: Remove index from temp channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-ad7173-fixes-v1-3-8161cc7f3ad1@analog.com>
References: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
In-Reply-To: <20240521-ad7173-fixes-v1-0-8161cc7f3ad1@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716281184; l=851;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=qHzAb3Lr8QOhPoRlBg0Itkn9NRPMWDsCz2unbRqp8RE=;
 b=zxXiZsq7aw1ZMWgq02220Luc3U7UtU/mZVkZapTEiP+gmlZk+oA/AvL2vULuakdmQeil2AEGB
 glgGrhonwrwAKUgtuRVvx0+bB1OgM1EzTT3cTkGAKHvLv37iFmmxK6H
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Temperature channel is unique per device, index is not needed.
This is breaking userspace: Include fixes tag to be released within the
same rc cycle.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 58620be41ef5..eb512878c30e 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -815,7 +815,6 @@ static const struct iio_chan_spec ad7173_channel_template = {
 
 static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
 	.type = IIO_TEMP,
-	.indexed = 1,
 	.channel = AD7173_AIN_TEMP_POS,
 	.channel2 = AD7173_AIN_TEMP_NEG,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |

-- 
2.43.0



