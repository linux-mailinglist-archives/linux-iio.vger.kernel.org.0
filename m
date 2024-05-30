Return-Path: <linux-iio+bounces-5498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CA78D4B47
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 14:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A32847EB
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 12:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066B2183A63;
	Thu, 30 May 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOy+f4dn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A5179955;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070883; cv=none; b=DRp3sS4PjXg95kEn9/mxr+pqoDrlibOX/tZ+e1nCSH8WmDWJTyCmMwAFx3LY2jLuwP2Yh72Yuama6nA9auPdVviLTg88JVOYQ/ori6/GykfkZdjgJZhWoTY+YP/DW+lPxRWiarU8g7oNT8oJw6s7Cr2EKtDeu259DkxK2fEQ8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070883; c=relaxed/simple;
	bh=jDeJ/2LLIq3QhO9uL4NshnL3jZave7YV0UkfwYZ8P+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRNo+fRxTipp7hMkZGH+iXT4v7xuylGlFYMcW4N5S+FozKNfF9ZLRdkJSQub0KH314VsQ6lX7NK1k3r7PZeIyrx0qoZOncZUa3Kq6Nb5HMkofy4OvdiC+f+HcPcCMLmhQnR6zHSVPw0TUDWq6ESZfs+g9b8B6IIsU8oczg3QqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOy+f4dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 588DFC4AF07;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717070883;
	bh=jDeJ/2LLIq3QhO9uL4NshnL3jZave7YV0UkfwYZ8P+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uOy+f4dnG1Roxul3BaWOcsOczqLX51vutErzDzQ9hA3X1Zzuu7+khAEiW06wEp3cP
	 I0ovYTNZl/IktaxAEhIXuSWhYZxOxI64UFQ0LhRpbM8Cb/xl4lvbWpT2w3zqimY+G3
	 OLIUXaRJZYrkFTWNoG3taiJaiWHmFLZp1nz+b7fRqG2iBsBo5XNs75wGIZ6XNl9TvT
	 2MfmNwhX/ZJheylgBzt/j56ip8jczdcG7k2JXv8KbVh75i1yuvn2NMPDXXjno3Ksqs
	 vzGndhAWEhyAFWsj6Fd16eBGjdMS3w2iAXxN/EyEfe2CzkcNODIzzvsCautYpfvlu/
	 WPFV/ufOj2otQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51867C25B74;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Thu, 30 May 2024 15:07:52 +0300
Subject: [PATCH v3 4/5] iio: adc: ad7173: Clear append status bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-ad7173-fixes-v3-4-b85f33079e18@analog.com>
References: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
In-Reply-To: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717070881; l=1000;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=3Lih309+QmE+/CCcvFgIQ2n+1Fi+3MwieGtcQTnVs2U=;
 b=tfCorgq0OSKRQvM2Q3NGFOUZ1X2YYA74t5jLnItpkypqPxNNNi3vR/gUXjZgy9xDWyb8j/uLq
 NDCDOpATRj3CWE2Yawyq8iYYrUX1Tu74KX8etJRApoMR6nCL1zl+TDQ
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

The previous value of the append status bit was not cleared before
setting the new value. This caused the bit to remain set after enabling
buffered mode for multiple channels and not permit further buffered
reads from a single channel after the fact.

Fixes: 8eb903272f75 ("iio: adc: ad7173: add AD7173 driver")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index eb512878c30e..e66a137a76be 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -543,6 +543,7 @@ static int ad7173_append_status(struct ad_sigma_delta *sd, bool append)
 	unsigned int interface_mode = st->interface_mode;
 	int ret;
 
+	interface_mode &= ~AD7173_INTERFACE_DATA_STAT;
 	interface_mode |= AD7173_INTERFACE_DATA_STAT_EN(append);
 	ret = ad_sd_write_reg(&st->sd, AD7173_REG_INTERFACE_MODE, 2, interface_mode);
 	if (ret)

-- 
2.43.0



