Return-Path: <linux-iio+bounces-25743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4045C25038
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229B74225D1
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28E34A3A0;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1OdInq7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC703491D2
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=umFNXG6a/xfx/fJ7So/M2AOHopBu0Ff21GX1fG/KDtYwPVrf3Nc9jG+ov7bz6CD4yDNNAxww10Z/WYlr9QJwL5uAvHmjn+QWLUWxMndw0DODlhr+gUHsST9Oxkc0aPdyO20oacMEgz8FgWm2A2H2JOuQ75iqLF0D6wnc2dq/GUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=MJLcUxITLkioyDM81+h78WeTg5xs2wqFRstLJYhWRQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDEYnLNN9/hjr61Pd+jfuPWrmPKUkwO0XDtOyL10MDz2jeuP+ojfnDVQ/vtGwPx5sdAYvrvEKpVKt2hhP0BcgeSMM1AnDusNdn9iVH5EblxIWwCqgbSiUfHWAz9AOyHn1wgr7ttO6BOs2clWevn0d3X1JPealdXXwSpjFpPoiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1OdInq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE8C0C16AAE;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913861;
	bh=MJLcUxITLkioyDM81+h78WeTg5xs2wqFRstLJYhWRQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z1OdInq70+YEMFJrktmGPkS9YdQZfOwB27akwpc13iVJUprCJ3HuPEWd0lyuDGu76
	 bVDRoAbtG+17zhmYSXjOILc5cVI2dJLPmI8Rqh2gVDItOu22XlYYOxqI9g/iJWUM0V
	 c6FSI38WY3NB47PYpOxDn6rT2ULekZVY6EWvY7OmbwzjOvKx/7fyIAWJyeItFCoAJ8
	 t3DronBK9F8KTVk5oDVbr6DoI/PETwBd5hvPH8vrpl3zEJW6KhdeSSnFrnKz5cgUHY
	 1bKANlRZhh7oFoLHuPcXzZgaJG3G8HvpKXncghUGGBNHrmW+Jv6FKztFXO4Kdz6CfE
	 miKJ5LcahZ9Ug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C35CCF9FA;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:24 +0000
Subject: [PATCH v3 03/10] iio: dac: ad5446: Don't ignore missing regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-3-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=1108;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=79iWfxVs1TX8tdmn9pCr0tJJuCMUrpn41+wz6b5CyUQ=;
 b=9Zu/i1mRQLXLEt/I6qllLVFJSMe/SKeICj4XiH8ahJA+1jXrz2pSvepmncfBByv4dii9YhzqK
 O0S9M4+vLYuCt++W3S3ii/cErobh0I30Eg5c0vp9DCIQWK9UXuYuJOA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

If the chip does not have an internal reference, do not ignore a missing
regulator as we won't be able to actually provide a proper scale for the
DAC. Since it's now seen as an error, flip the if() logic so errors are
treated first (which is the typical pattern).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ad5446.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index de5e4e0e397e..5f9b6f82a981 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -253,10 +253,11 @@ static int ad5446_probe(struct device *dev, const char *name,
 	if (ret < 0 && ret != -ENODEV)
 		return ret;
 	if (ret == -ENODEV) {
-		if (chip_info->int_vref_mv)
-			st->vref_mv = chip_info->int_vref_mv;
-		else
-			dev_warn(dev, "reference voltage unspecified\n");
+		if (!chip_info->int_vref_mv)
+			return dev_err_probe(dev, ret,
+					     "reference voltage unspecified\n");
+
+		st->vref_mv = chip_info->int_vref_mv;
 	} else {
 		st->vref_mv = ret / 1000;
 	}

-- 
2.51.0



