Return-Path: <linux-iio+bounces-11995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC09C0CE2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 18:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8AF1C22F3E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319C2170B2;
	Thu,  7 Nov 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="XXKhWSP6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF97216DE3;
	Thu,  7 Nov 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000662; cv=none; b=kiXuqLisOWl2h3WSkqYuiwsb00FW+dNbw3kkKuHttdT5sUbJ+o9bb4qiM0dlnbUQnGurL3yvAuVetqm0/iyu7/VlRPARUc3LRqPW+jva59tycsz0rjuphTUcctuCEfN0RGTf/0uojMJRkFWK/iqYB9sTNvOR9+Xg7kb2PXG+zyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000662; c=relaxed/simple;
	bh=DGNFU7sXY8nxTWRDfpiShCdLXxJ7RRd5W4g1wy9oGZA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=N37gZiERK87YKPyWzQ4VfYpaRsNJLCk+j8WXSDJgcucMBHHHp4ULgWZBVe/IN+iZzQCRJ34L/XM3UcSuGwdoX8TWO++PIaZXljjJigkxeLp5BIpcL4eLQiwWfdZK7QfSRwCN1oXRmDix+v1PbRdhNCzygZw0pLX5r3zOnpdNkWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=XXKhWSP6; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731000652; x=1731259852;
	bh=/8djxCnsO+tFNzNR9N609OFJyho5I7jhO1PgaDM6cDw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=XXKhWSP69oy24UtJm5CRY5tin+nuesLYu1XaO6KEb6KaHJ1wjUefqu/5vlZQ8QDgD
	 ns9N+i1nCJY2sOYT8pYiva8Hvzz4Dh1WuCXKe9LWJtmrm4LaK9p9Lbfc2OlDFWUdlo
	 JvdH1dHwdNJhJXCxgCUg4vbfyyhOGP0MhL0NrX1D6tJOBQU2HFhR4raSuWVLtHX0Hd
	 fI05FegkMa02rA3OrV95bVPNZLUtdsql7qM5hrpDq6cU5REWC0vQ2JRPk5f0Z2BlvY
	 pYU7pQtdT1ku+ccldI/pxpCbeF1x6GqXmXtVbntTOdrJYedP8Cfz/g490qevo2qKPu
	 JhzV7chafcmrw==
Date: Thu, 07 Nov 2024 17:30:48 +0000
To: jic23@kernel.org, lars@metafoo.de, gregkh@linuxfoundation.org, parthiban.veerasooran@microchip.com, christian.gromm@microchip.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 0/4] staging: Remove contact information from TODO files
Message-ID: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 2c73f128d512200b086d91bf6c91aa220cbe864c
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Some TODO files contained contact information - it is redundant, as it
can be found in MAINTAINERS file. It can also get stale easily. This
series removes that.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>

Dominik Karol Pi=C4=85tkowski (4):
  staging: iio: Remove TODO file
  staging: sm750fb: Remove TODO contact information
  staging: rtl8723bs: Remove TODO contact information
  staging: most: Remove TODO contact information

 drivers/staging/iio/TODO       | 5 -----
 drivers/staging/most/TODO      | 7 -------
 drivers/staging/rtl8723bs/TODO | 3 ---
 drivers/staging/sm750fb/TODO   | 5 -----
 4 files changed, 20 deletions(-)
 delete mode 100644 drivers/staging/iio/TODO

--=20
2.34.1



