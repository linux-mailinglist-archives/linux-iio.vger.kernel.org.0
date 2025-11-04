Return-Path: <linux-iio+bounces-25871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C0C31DB1
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 16:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8F189BA2E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58F23191B9;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovg+u4FM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C026E711;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270474; cv=none; b=t2tbK3Tm4hpDpDWhZTdNlSiJKx3/nG66Jd0dONLJKWZ/BQEx/YgpeVF/QtpMUmMOLk6PMHLf8PzSNTk5QoljuM/L/LENSZXJZuyznSFSC/l2ln6oKEWZlqHbQ4h1PtuIIky+7qh6QiS6dY4gLx3UXogEKbns90cPYPCIPX1Vrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270474; c=relaxed/simple;
	bh=kI0ICAUDioiU+0h8yB6fOl+rRXtjBS0tzNhQaUkmK9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbNiZS3M5hCfEpNAL1shRaInV4N2e2Z4D1OaH22QPjqkw8sV5Z6FtNrG3gW0Z9p/x7x2e0uYRj8jEANY4kR2yXq2WwUsaabz/qC+ST39z0Mqt+em3QyXIWlYuwu0Sz3oCxC8WBz+t/BzwTV8j3kbbDeRIcI1gjm0UHvnstfrQZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovg+u4FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C94EC4AF0F;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270474;
	bh=kI0ICAUDioiU+0h8yB6fOl+rRXtjBS0tzNhQaUkmK9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ovg+u4FMdP+HwDe16lJCnL7FbSsFNSMPQTTTUaLsyeDFYCsolMe52rDuZ5fEnVZXD
	 wNbR8YRhj/00d/1RQqQWIL7LcaLyl6A9uMr8oTQPpn+LCUkGMv6hG9liONL/IeyUNG
	 B4pJ0VXSurBEZVoC3OwPP3nCaxfgznI7/6e1G4DpnRH7WkonqPuGqzVF9ff91R5o1I
	 LMUflgB2kmX5uWfCtFxx8CMfpv58GNweZA8FzflaJweO8dRqHPp4P33ijJM/2fcJik
	 TOKYHxKGc6Ias9KLjNXF8lytlWVr9E1RBNrem25U1o6Ae8tkEQJtclinZWsbw2qnrw
	 6ZgCt73ZFOERw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1367ACCFA12;
	Tue,  4 Nov 2025 15:34:34 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 04 Nov 2025 15:35:09 +0000
Subject: [PATCH v4 04/12] iio: dac: ad5446: Don't ignore missing regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-dev-add-ad5542-v4-4-6fe35458bf8c@analog.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
In-Reply-To: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762270508; l=1108;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=okuknmDZ8VnobvB5MdfQlpCEFH0waLrFc7eKB4aMwI8=;
 b=9t96c7asVOUQZb8RdHLBsepPuro1xeLexBVTVuuqtkEfKw2LterBxkynt0MfuPixJcYqKHZpO
 e1ctjkKfH1qCCkTqVeI7tFhhIzLp7CDDNNxsetxCVBDZS5zzst/BLBw
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
index c0a38f642451..cbe2a6862f10 100644
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



