Return-Path: <linux-iio+bounces-11899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA1B9BBDC8
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 20:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01311C23142
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 19:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268311CDFD1;
	Mon,  4 Nov 2024 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAomZYac"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49D018D642;
	Mon,  4 Nov 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747337; cv=none; b=YxGbq8+wRv6JSo1n2suUjen/3Q2rgOguE/+sfE3N9eV0KHxfB/xpAJxeQjs3gxr8crWisXgApoFByETLiOw/6wOpe1fFIikJ/okxF67asRmDpqG9QF5d3pr+pC8H67Bg49gAU7/MU2AmoANfuVYSe7OQ+h87ZtxYgzaFefxs638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747337; c=relaxed/simple;
	bh=r55W5L8ATrLR6WUSatifGaaRs+SAe8J4+623y6OD2Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJJ9taBlPZYNNTSW8IT2BNu4Wd+cpvUdSU8scf6v0/+HxvbVYc0p2wSubbk8+FiDku/LY1f2MOHwdTPvv7PRP79v5Ep8TUhjyLE84sKbqyLnUhPg/aQYHJO5/0AQ4GCSg4OoJ0RbJKkAddgcP4X36O7S7eQ75laPEPbdOKogkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAomZYac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AC0C4CECE;
	Mon,  4 Nov 2024 19:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747337;
	bh=r55W5L8ATrLR6WUSatifGaaRs+SAe8J4+623y6OD2Lc=;
	h=From:To:Cc:Subject:Date:From;
	b=pAomZYacLrvS/rbe9p5p5uzdYFKVDn6XrcbLnfy3AGtpoHmo4aWpBd6wf6S+s9mPF
	 k1cQTWIJzZFJJyJIi3Lu3z98b/6/vJP1OWWnRqyoaG5WJVSWLGaVUh1UUi14PNC3uI
	 0mUjko+v8bE/mZ/6P1PFAsCX4lSt+v1ahheZe2YBrcQDMKBFaDYMaYmPYpCE5UZruh
	 88gQlj+I0mFLz2g3DuQTh3/lUyMMhy5fEXOUdM70n3cTDhHrq0UGZSaW5vwr64hcMp
	 mJZXY4lidxhvoA/atJktMX2OMiJ5U27a7wLOmTTvZUn2Qwnvx7gO/odlBizhLdtQ3x
	 G4KadXN1SFYZQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: mcp4725: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:08:46 -0600
Message-ID: <20241104190846.278417-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/iio/dac/mcp4725.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 25bb1c0490af..1337fb02ccf5 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -379,7 +379,7 @@ static int mcp4725_probe_dt(struct device *dev,
 			    struct mcp4725_platform_data *pdata)
 {
 	/* check if is the vref-supply defined */
-	pdata->use_vref = device_property_read_bool(dev, "vref-supply");
+	pdata->use_vref = device_property_present(dev, "vref-supply");
 	pdata->vref_buffered =
 		device_property_read_bool(dev, "microchip,vref-buffered");
 
-- 
2.45.2


