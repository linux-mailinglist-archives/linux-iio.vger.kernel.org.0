Return-Path: <linux-iio+bounces-11996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BCD9C0CE5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 18:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53FD1C22B33
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B7217308;
	Thu,  7 Nov 2024 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hS+9Ntbe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995721315C;
	Thu,  7 Nov 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000665; cv=none; b=dYZ1a02i1oXjdW/1YCjuQjxhHIXIjCoTWXElFKvgUhBsYVJoA8XAK4wYzjengEKbGBwGjCh9mZB2PNfLhHEHgpFRuv66yPDQEUa1QPZa0h/UDMF3shBiDELvr1n9qugZAyySXxSoKudoFN0EySwnrK1h9lPCxIL97N0KBvRSwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000665; c=relaxed/simple;
	bh=BwjFGaw+4nmam3HpqYea3paas9g0vq5E6hqSbuNDetk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/Z+MQW4dlN3f6q0te6NEJNUFhVUi5phjZmOhnbRxw2y4FvN5LAcqNxFX51+/rtZb/g3iGFzg7hN+E/Tec9ubv+bq7BoRdvAdb8+Ejt3kHMt0Wm7hfMro3jZwW+hdOgyZ1vvDwCbu4y0/L4khEg3NfOA9uH40quik3FAX9iPd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=hS+9Ntbe; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731000662; x=1731259862;
	bh=BwjFGaw+4nmam3HpqYea3paas9g0vq5E6hqSbuNDetk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=hS+9NtbeFQHdtWUbVUN12YPx4UUxTNi73yC10EBVyFUanxtcH88NQgWwb6F5mtjS1
	 wrW0nzKLEWHhCf90Ns8vMKNy84rX/eBltfwzgbihL89Yes0OXpoV8Hb+AoZX1xXtLn
	 sw+/NZVPiVACP4/Fq1bXmyNwECdCal2qYCrDus0CsDaHq6Ud9cWsikqbYp0j9yI8d0
	 mknl7/lDGT0ZZf+7vn+wlsug7NvtWlwyIrEM7XfYk5C3Oq86NTnoOuE7Rli4vN0Ikg
	 27WGk4xIgdq9ttm6Idoy7KVn34xTSmtokqKv0h+SQDPfBjOoNUKL+Izlw+IytDCxxq
	 1/zL1kOJTg6LQ==
Date: Thu, 07 Nov 2024 17:30:57 +0000
To: jic23@kernel.org, lars@metafoo.de, gregkh@linuxfoundation.org, parthiban.veerasooran@microchip.com, christian.gromm@microchip.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 2/4] staging: sm750fb: Remove TODO contact information
Message-ID: <20241107172908.95530-3-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
References: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: c950f1fdc6c123f5e69c1aff40369bb6a367959e
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove contact information from TODO file, as it is redundant and can
get stale easily.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/sm750fb/TODO | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/sm750fb/TODO b/drivers/staging/sm750fb/TODO
index 481409eb3fb3..9dd57c566257 100644
--- a/drivers/staging/sm750fb/TODO
+++ b/drivers/staging/sm750fb/TODO
@@ -12,8 +12,3 @@ TODO:
 Note:
 - This driver will be removed from staging after the drm driver is ready
 - The drm driver is getting ready at https://gitlab.com/sudipm/sm750/tree/=
sm750
-
-Please send any patches to
-=09Greg Kroah-Hartman <greg@kroah.com>
-=09Sudip Mukherjee <sudipm.mukherjee@gmail.com>
-=09Teddy Wang <teddy.wang@siliconmotion.com>
--=20
2.34.1



