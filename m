Return-Path: <linux-iio+bounces-15725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E288AA3996F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 11:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5002B3B410F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 10:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B1923C8AA;
	Tue, 18 Feb 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+E4Hc6Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC7B232373
	for <linux-iio@vger.kernel.org>; Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874691; cv=none; b=khbrZrWISxg6YdqanGANA6NexdDWnqdRae7wIFdJQCjGE6drK2pEl+MZmyrQGSYJxX7IADKvDNL2fTiKAR4v9J3Qy3bjk7dSLI33LFbakCNc/ayCAq/G2fpOu+4Vn5fCkg6Xk58mKIK/iIWUGMtKZrRxaFn4vPCQte0coO6mzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874691; c=relaxed/simple;
	bh=ojQS/dinYVQnlCDeRiq9izfymgMJzb8TOocWx75Z1Ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLlHiFTV0FEnwTT9+ZSEeGDBdIGdBfUO5zgBziXW+DIbSkBKlrGIS241yT7P4GYjbU0De55/N7QUPdGgo+7CW9V01oFKRD/OTN04iMyAm8nM1YP7gaR2ICSFBGGj/jeqWdqF1vMQ3qyG0im1g/pvmlU/7/42MXJsMhSFQ9VCGps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+E4Hc6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDB41C4CEE6;
	Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739874690;
	bh=ojQS/dinYVQnlCDeRiq9izfymgMJzb8TOocWx75Z1Ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F+E4Hc6QKbAkFZpG4ju043qV59ZKtx1K4OXJ/F0oNZP1jrcYXulSdr5YmHg1RO5yA
	 pnDqFGcySJPtZdkAJetmBM9xPllIXM5yEtwQCmmCBuUB1sFCDnOA794L/yYZxz+SeL
	 tk7ANCWE0M9uPYVc8CieIpJtvKlyXgIrk+bxfiMPziTvyV7kAKi3SKRAvU21Xik0Uk
	 KWhRoxMkLfzaeeeoOkRM6QHYCVFd2u78cRCLLG+Npu8pdN1Ivi4IP7xnWBz2CRQZD3
	 baJKez1XAddtR3QAQYChEvyxbD9whKXFRGLYwMMHmklBUTgb4y/AiOSgr/7+5/vsow
	 eu93LEtxggY1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEF7C021AD;
	Tue, 18 Feb 2025 10:31:30 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 18 Feb 2025 10:31:25 +0000
Subject: [PATCH 1/2] iio: backend: make sure to NULL terminate stack buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-dev-iio-misc-v1-1-bf72b20a1eb8@analog.com>
References: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
In-Reply-To: <20250218-dev-iio-misc-v1-0-bf72b20a1eb8@analog.com>
To: linux-iio@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739874693; l=1076;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=GWhpZSmFhwwDXoVILtCDzIY2OPcm7moo7iOg8HbVPw0=;
 b=gcjTgcpdLyggP+hspMVta0xX5lJ736ImFTbFr5TUJ2hiq1L+ckq8hBR1y0ahnS10KyT2zLXRH
 GyXXqKY0fGeAhhxVud3BA/2tXOB4nrHy70VoC5gm5XsiD7REgdJrNli
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Make sure to NULL terminate the buffer in
iio_backend_debugfs_write_reg() before passing it to sscanf(). It is a
stack variable so we should not assume it will 0 initialized.

Fixes: cdf01e0809a4 ("iio: backend: add debugFs interface")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/industrialio-backend.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index d4ad36f54090204bf3bef08457d4aa55aa7c11fc..a43c8d1bb3d0f4dda4277cac94b0ea9232c071e4 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -155,10 +155,12 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
-	rc = simple_write_to_buffer(buf, sizeof(buf), ppos, userbuf, count);
+	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
 	if (rc < 0)
 		return rc;
 
+	buf[count] = '\0';
+
 	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
 
 	switch (ret) {

-- 
2.48.1



