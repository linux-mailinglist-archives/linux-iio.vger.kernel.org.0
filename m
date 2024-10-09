Return-Path: <linux-iio+bounces-10368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50F996D66
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 16:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB29B285A9C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55716199FDD;
	Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcU+7pEc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1635C224DC
	for <linux-iio@vger.kernel.org>; Wed,  9 Oct 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483405; cv=none; b=bvWtafiTLhuooz/F756X5rrUgoMwdff7xVvBdHLmwZ+YpQW8/J/pXGbXtEjspistcBdJhu5oRuM/kUcUYP84iCCGNbTC4GJgUH4Z+CPbBr0Cfxc+0KbdUfU6paDITC+oC2akvXEcXbrei/V/c8nNfnqx8H90QBSh8ZsUx4N4exI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483405; c=relaxed/simple;
	bh=kaJf3xPAMqT20DAZ3PsVm0G2BLo82JR2Rih1UG8HKyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKOxWx+RDo7kPN7R/BZ7hHMpmA3EnQ8YPMCcV1wy2lb9HtVmGvGr3SN2r9cS0fBOD9DeRjf6F7Z8eaTYwx+CGCCX5CI+3E3QBN1W/U01iytKlnc60bL8bMYph2jZufX6aBANmeDzshw7RKYzJhfXSpuJmFipO+XPGfa56mi6eoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcU+7pEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E71B9C4CECF;
	Wed,  9 Oct 2024 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728483405;
	bh=kaJf3xPAMqT20DAZ3PsVm0G2BLo82JR2Rih1UG8HKyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fcU+7pEcoMjHQpmTTMDWmQA0H0LB2wyyizal0vGYqna7VMymWrHCCNDtLOWuxa6fp
	 kBwmt1+MKTxR0WKZu8HUtnNOYYCVIh3ojZKOJhGUX3KE5nSsVuoZhAM3QsXQGAskRo
	 6Qs34YOb8kQVDqBMaIg0uAnFm79nR60UD/t5EpCGg+RMdZWRVj9zUQJKxO4L7xIzLJ
	 fsLpas+SDuahMROLt5Tx2Pl51k6tSpEgusHXN8e+OGrwg3oVF1pWdxrPLoqiwcmPKD
	 NCwTBycoiWtdTHRldXf/U2SUPGhkCvtK/k4iA8zC1w6H0OYFywMoPHTKnSLDQxFOUj
	 iKWQvaanUlicw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE576CEDD9E;
	Wed,  9 Oct 2024 14:16:44 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 09 Oct 2024 16:16:44 +0200
Subject: [PATCH 2/4] iio: frequency: adf4371: drop spi_set_drvdata()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-dev-adf4371-minor-improv-v1-2-97f4f22ed941@analog.com>
References: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
In-Reply-To: <20241009-dev-adf4371-minor-improv-v1-0-97f4f22ed941@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728483403; l=635;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=c8IXZHd6rce/m7P5wiE54syNc8oDjduP+uF8+b2rhUc=;
 b=IB87rW+qOzKKtO7GHOve2HEtyGEcN2xSuQwTVBrazpZXrWjpYl8y8HUt0pcU1laY29yvXfN21
 2dPj1aEKxl9AAOZsOD0aBGpvUr5E0ddtZPtENsziPw7Y6B5wvPYSv6V
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

spi_set_drvdata() is not needed as there's no spi_get_drvdata() call in
the code.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/frequency/adf4371.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index c8bf37f1679c..eb31f442566c 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -561,7 +561,6 @@ static int adf4371_probe(struct spi_device *spi)
 	}
 
 	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
 	st->spi = spi;
 	st->regmap = regmap;
 	mutex_init(&st->lock);

-- 
2.46.1



