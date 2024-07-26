Return-Path: <linux-iio+bounces-7949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9342293D8C0
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 20:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A56282587
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E91413A40B;
	Fri, 26 Jul 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lnOyXQNq"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD463BBC1;
	Fri, 26 Jul 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020035; cv=none; b=EvBjdzWsv4fteRnW+IpKc0uy4wVnq0VzUYRnF0SzV63E39Dk2u5DD5lfR3j8s+8LoOw/ENnhrBNk5UpDsMXklbJv8/6UAy0xHnCXQz4H7vFqZf+VYn5Iek8RBTqe2odwdG9teHz0HOh0CzeMY2CjIZjjAyUb8i1MZ+5OLCYjocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020035; c=relaxed/simple;
	bh=QsPikQLZceYAGuxVlGoupF72mEFVrVlCn8xSmyVaK5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MESHkGchSWiOsuwf5C4ToKkRHhi1bLLm9JLzPaQ04Epi7d58C1L0/PT2zzsll5lgpe/DhkynYYRG9HOdIKR6iFgnnzRdFJ02KviDGlBCaa7MWeNe/4dOF5AFoxW84FEB61rKDMGyZqNoFT+wgcGXD81uLat0/857UxbV3+582qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lnOyXQNq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 17D3944D56;
	Fri, 26 Jul 2024 20:53:51 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aCL0c7f_gfgm; Fri, 26 Jul 2024 20:53:50 +0200 (CEST)
From: Kaustabh Chakraborty <kauschluss@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722020030; bh=QsPikQLZceYAGuxVlGoupF72mEFVrVlCn8xSmyVaK5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lnOyXQNqj8fGBjqeXnYJ6mDQcvHO7MxIHIaH2A/vGjrvngM2DPfuX0KzJKVaIQ6Bh
	 PBca+3Yahg4Qx7+aC5l6Ck9ybOjhYn57qNdAjUBa/zA3TgILKIzoUFSxXwqsFFdppS
	 4Wv/Wr4NfpWV3/hvoHH1POYj6BEPEpwwPCeI8DAns/z+ozDQXDND9hbxJM6WDplNE2
	 qzj2RmMUGpvPTqLMMZjOtaKEU8vv1qkZCCCslcjs8uB71MN8d9KHlYj/YGCc8cOdOd
	 RM1NB8aMS6aMJUhlbRpQklvcJ/HXaRe5ohM1fyNBP5PBf8P+/eRNOgeODcuREg8Sg1
	 BqXDy+UZtX7FQ==
Date: Sat, 27 Jul 2024 00:23:31 +0530
Subject: [PATCH v4 1/3] iio: light: stk3310: relax chipid check warning
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-stk3310-v4-1-02497b1407ba@disroot.org>
References: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
In-Reply-To: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

In order to allow newer devices which are compatible with existing
sensors, issuing a warning for an unknown chipid indicates that
something has gone wrong with the init process, which isn't ideal.
Swap it with a friendlier info message to get things right.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/iio/light/stk3310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e3470d6743ef..48a971de6a04 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -496,7 +496,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	ret = stk3310_check_chip_id(chipid);
 	if (ret < 0)
-		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
+		dev_info(&client->dev, "new unknown chip id: 0x%x\n", chipid);
 
 	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
 	ret = stk3310_set_state(data, state);

-- 
2.45.2


