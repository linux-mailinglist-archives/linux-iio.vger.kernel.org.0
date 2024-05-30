Return-Path: <linux-iio+bounces-5496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B58D4B45
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECDF1C234E0
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9361822EE;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An3Upmex"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996F71586C8;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070883; cv=none; b=VaBiGP0QrT8hK8MZbKlvKKpSQ0YzccVJpa3L6Ss+ut5IBmMlxpc1Pr6d0wz/dtZm24z43Y4P2z1pyJ9d4t4JJpzxWSf74DnuBzqUtIMkmvk/mdP3CpFbePgBL6+/T+fe/A3RhiHCOMDUzkumm1Mo9wvUqjFN/akWTEfB1VnfGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070883; c=relaxed/simple;
	bh=C5v4/fLzS6Bdo8dJf1AM1vOKlChKS52Cq8X9QRh1u/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pvl+522L4lZ7VzuRUzD0BJ+lUudEVwcEdux2b4g/j4Ctojz3mkidAi8kudjRxp6IwSSuTfHhGAmYd/wPFpbam15Tu9hoei/9VBWhRjM0lPcwQ2hi1TWOzumgmQlFiXJi6geUqGBUGoPX07VrkrDrGOL8k5F/DzDKtwOBTYMOK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An3Upmex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50D1DC32786;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717070883;
	bh=C5v4/fLzS6Bdo8dJf1AM1vOKlChKS52Cq8X9QRh1u/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=An3UpmexAyQUMe/fqa/Pj1UpvI6rhIzmThA7emAxMtOeRHYbttqBMQjdZxPxB66al
	 HdpHe/MSYpna8Q5MDbvUGFlv4KITyYO1z2gsR9cbmWZnfRJk68a0oxSazsVO3N1GYL
	 iSPBYZQCxaDga1FT6J5B0Dp3y9mCZZ10s+gnJLat729Q65COw+fUKSlAw6GI2lisFm
	 XSnzHl+RYRIG+zs+8a2xk/xYH/9YoQRQ/5WY+JLQSTQVRB73OLBwSk1snK6UW9lxAE
	 GvOjQqvqHm+u5TmZiiux9+998hLiYN51ENA/uOAYsIbNVVnmmaJJqS5JpyKozMR183
	 M9ILUvjAOEzvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4304FC27C43;
	Thu, 30 May 2024 12:08:03 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Thu, 30 May 2024 15:07:51 +0300
Subject: [PATCH v3 3/5] iio: adc: ad7173: Remove index from temp channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-ad7173-fixes-v3-3-b85f33079e18@analog.com>
References: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
In-Reply-To: <20240530-ad7173-fixes-v3-0-b85f33079e18@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Dumitru Ceclan <dumitru.ceclan@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717070881; l=851;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=qHzAb3Lr8QOhPoRlBg0Itkn9NRPMWDsCz2unbRqp8RE=;
 b=/16b4nMtXcLOu4ow4Fo36AISvbGQFYNZfcH6Ew8bLJc677ALZIM/4O0JxSjII5wclXnV8aT2m
 nWG7G+MZxNRCAuXDy3y7k7xXZJy0ST3XJcydCTvt7PkOv1o7cfGWCwC
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



