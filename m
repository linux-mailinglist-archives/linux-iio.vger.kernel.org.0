Return-Path: <linux-iio+bounces-7927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E84693CF91
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607AF1C21EBC
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3754178393;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrcQ4CZ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1817837D;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=rqYoLdDWofmDRtDaH5xfEeoV1o5EULmDhjezFdNADwCEkzlyWjizJAtM2njck+MPkUU2zUQ1+zDDB29x/boyIgorh5wBUuWYpRBStgNMmaVeT1QazSeD97MEr4Xge8oMPctNA3IooKaqjnBfzePWr6VwS97FKYF2vM4WB1cs9ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=NUM6O8zPs13bNzymkJdQAGtu3+DKEG0qTUf7Jmm8pXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJAo4qHxXw4/GjBi3IoAJhpWMBYIlIZzxmTGclVMogpbLUJ7YMsJpxgCbayJ6WL2X0+9V+wbzg3FrXpK/0sGbRVWy0i4ofOtzsvrlL396hFmjJFp2zfM/6DOxq7Rxt0HsKD1BrOMs3xcain1CyVkSOHXQTztQ5oEtg9J+STpSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrcQ4CZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E494C4AF53;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=NUM6O8zPs13bNzymkJdQAGtu3+DKEG0qTUf7Jmm8pXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RrcQ4CZ45aOOd8pt4F/0+Abgf8GX8NabmgM4Q9JpPCGypinNTYTSlHu22gX40K2BZ
	 zLwfa+Hqhe4lcODcj4xEi8eO5bUM5HlNqMGrXBb70+ya/4VbBnhJ5/t4Ymxkp/NiN5
	 FUAaacgYPho9It8GW6HtDq2dnCgNAj3Fnu36JBpl1rD+6WVx8IWrHgp45/zx/CBKKo
	 7BZN7ILvMUaA7YYozf7wBjpM/cRXNwVLl2Xn0VH+ntZoeS+eKt9dUhmA5+5bx4I1dy
	 QMbYn25mJug+RrgKCa2hsRwyEjHe1EBg9EWM6QQmd8yH5eaojkVpx3RZX89jxa4D2U
	 p8UWV8ae8tPsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576DFC49EA1;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:11 +0200
Subject: [PATCH 19/23] iio: adc: vf610_adc: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-19-82913fc0fb87@analog.com>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=796;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Wc4AtyYctfc1fH2X+PY3+8UsRic3aqsc8yZI2tY6HWk=;
 b=H7FUJUGsG0/4kDxReOD9Jx8MTUahTsFWzcVC8s5r8KykUlmApEdYH6mTuKTT3WWJJBsQfksKC
 W8B8phS/tBkA7Wb7tkDTDElLZC2u9Ls/n1C0Yr4XS1zyuBhvQvCcGdB
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_get_masklength() to access '.masklength' so it can be annotated
as __private when there are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/vf610_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index e4548df3f8fb..5afd2feb8c3d 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -752,7 +752,7 @@ static int vf610_adc_buffer_postenable(struct iio_dev *indio_dev)
 	writel(val, info->regs + VF610_REG_ADC_GC);
 
 	channel = find_first_bit(indio_dev->active_scan_mask,
-						indio_dev->masklength);
+				 iio_get_masklength(indio_dev));
 
 	val = VF610_ADC_ADCHC(channel);
 	val |= VF610_ADC_AIEN;

-- 
2.45.2



