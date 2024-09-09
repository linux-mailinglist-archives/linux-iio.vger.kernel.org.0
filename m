Return-Path: <linux-iio+bounces-9402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D7971F66
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 18:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE63B2307D
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ABC166F07;
	Mon,  9 Sep 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdg6Iz0D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB461487E2;
	Mon,  9 Sep 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899891; cv=none; b=Dtxytx3iQOa3+/3Q6AxSwiDC6NxDA+3rykrd8yspQuiGlRj32x+5StxdoXTcB1I274YLX06XaSOzt+i4qhM5yiQFvy1K4d5GZaV3QsJ1/jh4UIqlYWJGdRzBzZy5ptCTchJRoxqlikQ4YItFJ5Rq8ACqoZXpnosnETqovonEotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899891; c=relaxed/simple;
	bh=+w2uc10nohr4sGZItrTrIsH/kjRiwUW6Vy1YZKvOlPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BzD3VkWBELDOgglPQUxB7sJRriNgNwV9wEKgaknmW9ME6XFrcWKrbSKxvwePu4KVz1mzoZQCaT5LmHIXfJJEREqLIos0LfEEk2A+GBlFkwNEcAtFGC6MO8afcnlu47UUOUKTO8GjsXMtpOQucD1SdGMecF9loEBhrhc8M2c+x9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdg6Iz0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E3EC4CEC5;
	Mon,  9 Sep 2024 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725899889;
	bh=+w2uc10nohr4sGZItrTrIsH/kjRiwUW6Vy1YZKvOlPE=;
	h=From:Date:Subject:To:Cc:From;
	b=jdg6Iz0DKMG7z8XkS2YNOT+yVE8HOcGEjDFu8Ff8hA9FR5PtXFBrv5oXh2Z1qOvnf
	 Th3p4Ag0xGQVUybkNkfA6a2Zz6U8+Co94WOCBbgG1BcLU52VE7Fbm73M4ZS710KEo1
	 z8Tsfxt6qIgMtUPn8i5TWRf2y1Thirr1FKPag08C+A3iWebTAaz2umFfk/iSAUWzQ8
	 RSxGJpxERi+0mwaCJSMqmoQLuV9TRy+bO173pMn+xWu+EWb4bKqrEzk7vfX+y2e1zS
	 5wueJ4bR9EgOI7abwb9XjJSunw24PNTTzVHo4ZMO7yFuXfKFJ0sk1wCdk/qEQLq+mr
	 dOAr63pPssCWQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 09 Sep 2024 09:38:04 -0700
Subject: [PATCH] iio: bmi323: Fix array reference in
 bmi323_core_runtime_suspend()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-iio-bmi323-fix-array-ref-v1-1-51c220f22229@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGsk32YC/x2MwQrCQAwFf6XkbCDNim39FfEQNdu+g61koVRK/
 93F4wzM7FQ84IWuzU7hKwqWuUJ7aug52Tw641WZVPQsgwwMLPx4I2nijI0twr4cntnk0qn12qY
 sVPNPldj+69v9OH6h0Q+aagAAAA==
X-Change-ID: 20240909-iio-bmi323-fix-array-ref-a0672a8213f0
To: Jagath Jog J <jagathjog1996@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Denis Benato <benato.denis96@gmail.com>
Cc: linux-iio@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784; i=nathan@kernel.org;
 h=from:subject:message-id; bh=+w2uc10nohr4sGZItrTrIsH/kjRiwUW6Vy1YZKvOlPE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGn3VQqLlDLOf3nzzGV2dWo8v6PR7Exnp2t1x7PuyPoWp
 W73fJnVUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACYSdJyR4XA85w/JGEFmr8J9
 //jec60/P+f3RZbpUQsnb3ptfIDrzFNGhk3PZpx0jJ5e0dfYUO59Nf37NqvXE49MScx4H9EfdcX
 CigUA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang warns (or errors with CONFIG_WERROR):

  drivers/iio/imu/bmi323/bmi323_core.c:133:27: error: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
    133 | static const unsigned int bmi323_ext_reg_savestate[] = {
        |                           ^~~~~~~~~~~~~~~~~~~~~~~~

bmi323_ext_reg_savestate is only used within sizeof() through
ARRAY_SIZE(), so it is not unused, but it will not be emitted in the
final binary because sizeof() is evaluated only at compile time.
bmi323_ext_reg_savestate should have been used in the second parameter
in the call to bmi323_read_ext_reg() in the second for loop in
bmi323_core_runtime_suspend().

Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 671401ce80dcf947b7b64ea3af112d2a42ca5501..64dbce23ce17bcdd11c0d4c454dbeb9de17ef56c 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2199,7 +2199,7 @@ static int bmi323_core_runtime_suspend(struct device *dev)
 	}
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
-		ret = bmi323_read_ext_reg(data, bmi323_reg_savestate[i],
+		ret = bmi323_read_ext_reg(data, bmi323_ext_reg_savestate[i],
 					  &savestate->reg_settings[i]);
 		if (ret) {
 			dev_err(data->dev,

---
base-commit: 5ba0cb92584ba5e107c97001e09013c1da0772a8
change-id: 20240909-iio-bmi323-fix-array-ref-a0672a8213f0

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


