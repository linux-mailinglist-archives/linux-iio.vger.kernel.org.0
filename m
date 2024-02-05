Return-Path: <linux-iio+bounces-2195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD7849F21
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 17:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7B61F23022
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654823C08E;
	Mon,  5 Feb 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T69MVZm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA43A1CC
	for <linux-iio@vger.kernel.org>; Mon,  5 Feb 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148697; cv=none; b=RnTXeez/3NlaVdXSNvXq682rhgkWmTOtDoy03btcsPkiew4+MzBV3SDiQj29FK6Vu9wWMWyuJ/bejj95Qf/FcZfMENEGYcqwo0MQdRVhsfQJGW1rhSt/4pmrFb+rYWvGo4C0TjyOBAtndmPMDpWdqjPiaUOqhWiL6ZhV8gpBDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148697; c=relaxed/simple;
	bh=Y5iiYvh+eGK6e9MKiShQZcAy23QSTFb3pqJ5SwIfvKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CeZKROd5t+Q/3JzUfyAqzcuMlbjwgFk7TbtSdhaZFhq7AYA7F6l8m+XZ16FuM9Yknun7BTbVnWvfV3qJtzatOO+AbMCNOSqQUIKOLDOYWKYFoqAiuSN3uLpC0Xyzf0vPE3IQURD/1pezoKelMBcJFlwz4kEFvssbQm7MYOzfzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T69MVZm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C790AC43394;
	Mon,  5 Feb 2024 15:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707148695;
	bh=Y5iiYvh+eGK6e9MKiShQZcAy23QSTFb3pqJ5SwIfvKo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=T69MVZm/NRydhN6FHxdiw8XDmQ5GReLP75LEJrMxSaBV1+5QogQnWpnrv7Vie8cuH
	 LQH6Ehb8l+J1BzGlcv/EzJElpUC+//kUToR4QFKb23zR5BqLec/kTEoCckJwTYXUHf
	 tBwbOv9mj5BzNGQ75iIbrfKzPZ/Y+Hw2cSvLVMBBtPUUcl0vC8fJ2QJzPmm2S9Ymog
	 33C/XUlqlT4tND69I+O4ARBLq31CGzaE5jkjMFARnYQ+lidYU2b2cp4IX+kBJVzvHN
	 nATPaIy1dC6XP1YWqOFca579avSf0JxlDlkQdto5cwFvz+wPfx6Su7TpWRY7PcNMJD
	 0XptQ2QBi4NLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2DFC4828D;
	Mon,  5 Feb 2024 15:58:15 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 05 Feb 2024 16:58:14 +0100
Subject: [PATCH] counter: fix privdata alignment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240205-counter-align-fix-v1-1-4821ced960ab@analog.com>
X-B4-Tracking: v=1; b=H4sIAJYFwWUC/x2MQQqAIBAAvxJ7bsEsCfpKdLBabSE0tCII/97Sc
 QZmXsiUmDIM1QuJbs4cg0BTV7BsNnhCXoVBK90prQwu8QonJbQ7+4COH2ydpdnNptfWgXRHItH
 /c5xK+QAL+cZwYwAAAA==
To: linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 William Breathitt Gray <william.gray@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707148694; l=1491;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JL+X9g5gr6vuqR5+sLDCtbqSByJMt51WufOmdlrZIjQ=;
 b=M4MdFlfCwoupYtvp/5nltEXUhtZHeVJwQrX0B+cfrKVKkXMrs10ywLLdB8q5vo3+FhV5Z//ks
 yS3T5yn4aDCBg7U3E+qKYy30Gm2TPz2R2gU9au9VPprFq9pKtLuwcz0
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Aligning to the L1 cache does guarantee the same alignment as kmallocing
an object [1]. Furthermore, in some platforms, that alignment is not
sufficient for DMA safety (in case someone wants to have a DMA safe
buffer in privdata) [2].

Sometime ago, we had the same fixes in IIO.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/devres.c#n35
[2]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: c18e2760308e ("counter: Provide alternative counter registration functions")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
William, if you prefer, we can do something like in IIO and add a
specific COUNTER_DMA_MINALIGN define
---
 drivers/counter/counter-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 09c77afb33ca..073bf6b67a57 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -34,7 +34,7 @@ struct counter_device_allochelper {
 	 * This is cache line aligned to ensure private data behaves like if it
 	 * were kmalloced separately.
 	 */
-	unsigned long privdata[] ____cacheline_aligned;
+	unsigned long privdata[] __aligned(ARCH_DMA_MINALIGN);
 };
 
 static void counter_device_release(struct device *dev)

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240205-counter-align-fix-3faebfb572af
--

Thanks!
- Nuno Sá


