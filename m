Return-Path: <linux-iio+bounces-11998-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C39C0CEB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 18:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D73C1C233EA
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83E216E19;
	Thu,  7 Nov 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KB8taOvK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84021733B
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000674; cv=none; b=cu/xBBXKZp8NgbyHcAEL4p4fl+XZ83qPwg+bRra3n8qhbKmTCLf+ElMQyNpQyG4ohvDa1x1PV2p5G/MxqO96Z5ZRcH0CMxgfxxqzL1/WwZcBpQHIIw9UMsXxy0zfzKLGzMHjR9OK//rB8hLGykUUIt4yD9uyUm9HVRcp5VLglUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000674; c=relaxed/simple;
	bh=Q7qmklJAg39I2fpUM2q0jas6DuUYKzHr1XIy3Rj1NxI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ry5C2cOi+xWaeASZJKa56QkEpdvUZ+s+RAEdQ80GMaLydhOjI4/lsoU1h2SxOJITJ5dhGTP3Z63fZ64xF1sRNmmFuffG/I+ej53Z+HgxXNEl4FU6BdjF5bqDdf9NBM8Mx5KXezRJv80kypl9h+ctWQ9O+i0Ua2L7lnDfYLt73t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KB8taOvK; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731000670; x=1731259870;
	bh=Q7qmklJAg39I2fpUM2q0jas6DuUYKzHr1XIy3Rj1NxI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KB8taOvKQECYV8IH/DX2mi+PaxgMalZ1S01xCwe6kHSXvtAxjN1r5xxqOTWk5Ddvl
	 ti246+Vz8hKidYg5We81HKIYoTBfNRGpPYiqIww1mrkieyHuxQgua9CZoelvLnJkoD
	 hHqaZxVKqPzaSO3zpvn/8dk7Jp5JwnMF5SLqgZdorelNhEWIviYue5+dWbFi7YvcF/
	 drJBpkrn06ABVyaSILn49vE4FEihgNyG6rvAY4AoD994/h9vT5Hfot6q0BVbz/Ea3s
	 QLWrhizXpqhrfX+DDnVU1s28U3GKq+NrK8mamdSClbgiT6JSlqm0jD+8OQyQbQhzV4
	 2i1BZp8OPvyFQ==
Date: Thu, 07 Nov 2024 17:31:07 +0000
To: jic23@kernel.org, lars@metafoo.de, gregkh@linuxfoundation.org, parthiban.veerasooran@microchip.com, christian.gromm@microchip.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 4/4] staging: most: Remove TODO contact information
Message-ID: <20241107172908.95530-5-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
References: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 04ab167b3a5d4f134f23f67a7c28045d62bffbb3
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
 drivers/staging/most/TODO | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/most/TODO b/drivers/staging/most/TODO
index 4fa11a9d2cf7..a6448a05ed46 100644
--- a/drivers/staging/most/TODO
+++ b/drivers/staging/most/TODO
@@ -1,8 +1 @@
 * Get through code review with Greg Kroah-Hartman
-
-Contact:
-To:
-Christian Gromm <christian.gromm@microchip.com>
-Cc:
-Michael Fabry <Michael.Fabry@microchip.com>
-Christian Gromm <chris@engineersdelight.de>
--=20
2.34.1



