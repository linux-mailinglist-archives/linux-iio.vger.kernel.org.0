Return-Path: <linux-iio+bounces-5534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380948D5EA2
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0270B24820
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABD7137C2F;
	Fri, 31 May 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/9szYRS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8113665D
	for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148523; cv=none; b=shF4CfTp6VQPnrHwRkJa0wJSGwa5BGA3eAFUVa6hU2v64CzMvuRn1eJk+8ApKgGdmtjmFTe1ouul5jR7STWWfuxZbKUxfkmvWnJBV6Afaz2Hq2joGPcmxzKnqvJlY3492CP034XlX0BFUE68RSB5nM1LoSMi4+7FOq2X2LOXg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148523; c=relaxed/simple;
	bh=lk/snPjztQ3Pfl1CCDtkWqkZkrNZ/hruFm8R7WcQzBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcjqsF8e6KC1ufyJY/Pk5Yji+cauvEWpa7ZbrfhGRm0UVGKJr9hq6X52WZChbhZxbuqJiFZMXa+rTTZexnfmnQGH1p+3IQGQwZNaspvhLCH/BM4vp9f+ijQeRdWQsuAb+7FqJxbCl+njVJC97sOIoolIybqgn12MwLqTmamIwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/9szYRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0972BC4AF08;
	Fri, 31 May 2024 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717148523;
	bh=lk/snPjztQ3Pfl1CCDtkWqkZkrNZ/hruFm8R7WcQzBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=u/9szYRSe3Z7KzmJN8wx/hFdfxIHdsgKXY0pF2PxpBVVJA7IW3AQvAMGvjxf6Whit
	 f3vZTkL4BG7wqKxjhHKktZ36X0FIa83vij6bUCcKho6B5FYwpLTyRXa+luUy+NO7Jc
	 AOsTG/ZA4sJXMhfg131So48EwYkqNevpER8Xx1N0wo+JjMI3iNwPCnSQ5TwTthBVhu
	 vDFsb/5Pq3StOrQV6vAe5pm3i70n14mk8oR1T3wSj32PmztY3WE4LnYAdj8671msTO
	 CvIm7BZJe8PKxTuRfUb8/XVzQVjUc0v5R5N5JYQx7+rf20I3E88Q32h/001wYJvhWc
	 JC9BJG7x86P6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA911C25B75;
	Fri, 31 May 2024 09:42:02 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 May 2024 11:41:54 +0200
Subject: [PATCH v3 1/2] iio: adc: adi-axi-adc: don't allow concurrent
 enable/disable calls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-dev-axi-adc-drp-v3-1-e3fa79447c67@analog.com>
References: <20240531-dev-axi-adc-drp-v3-0-e3fa79447c67@analog.com>
In-Reply-To: <20240531-dev-axi-adc-drp-v3-0-e3fa79447c67@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717148521; l=1133;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JoueMCiuIGkQcabjP3EvL+lebFySB1NCgLCP/9+LfjA=;
 b=Q9oULb7KbIlafIfeRmO8n+dn4n9jSgM88dKqt4bdGSeb4ceHAD72mFDx93Br21r/pCpbzh5DJ
 kEa0Oyg3v9SBJvHRrTvy3HfQ8Grtq1GF/NABLZDUqQ6wSnMPAj86x0q
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Add proper mutex guards as we should not be able to disable
the core in the middle of enabling it.

Note there's no need to rush in backporting this as the only user of the
backend does not do anything crazy..

Fixes: 794ef0e57854 ("iio: adc: adi-axi-adc: move to backend framework")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 0cf0d81358fd..bf51d619ebbc 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -85,6 +85,7 @@ static int axi_adc_enable(struct iio_backend *back)
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 	int ret;
 
+	guard(mutex)(&st->lock);
 	ret = regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
 			      ADI_AXI_REG_RSTN_MMCM_RSTN);
 	if (ret)
@@ -99,6 +100,7 @@ static void axi_adc_disable(struct iio_backend *back)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 
+	guard(mutex)(&st->lock);
 	regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
 }
 

-- 
2.45.1



