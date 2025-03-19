Return-Path: <linux-iio+bounces-17115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07284A69A63
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD7E7AEDFC
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02D2153C1;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNLXQdTu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E620C003;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=eDgqyeVstr5JE0Soe5E59G9F5AAiHo5FE6yxMHYQpC5TbTVBYRXC/tKNLyLNrYVNAquFLlrtOa3h+64XtbA7hLOfGbD2Y7X5m7oCoPDsubzaW1cHgRgaw1br6Z5vsvuVAL3pf+Z29++k7vMbhlfKBEjTCIIKns9zIRDTVNQq8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=CT7ZJ/uDIYrIVA8eQYfKWvBAY6EzcaAv4fqcrOVsHQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uob9lL1QNS6gpko+WclydouZKH3zYpewqTik9LYTFsgaWvvn+f/GMIVavsKQ5dM/O62xiyl6aVAW53kTL0zKlMErmXUXE8t5oo0+iP/y7cx7dpu/L0KuKWk/l62pudq8nB63i7UxwxG8Hvbfmohd9NKbFeqgznN8CDcI6JJs+gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNLXQdTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BB33C4CEE7;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=CT7ZJ/uDIYrIVA8eQYfKWvBAY6EzcaAv4fqcrOVsHQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eNLXQdTuT3CO1oGsuYUNUnN3MpW4+lRMQDGQDeiOh9hV9EA8IGHeqV64aOngfnLfs
	 rpa2dejB//oDQu/yPP/4F0pOnP0uTPHJ4+3gd+SrWIFk2shyZsbf9N8e4tw0oNTvHP
	 QMbYhR8z8Ha9oIb7t34aghxXwO9bDuJQt43HGkhcxVlbPUHzGXMbZmZGL06w56IqFK
	 iQmxik9Sgs+uHN4BrZAc/9nxkv0KV7CYlZxtuFoQg/9nrjYqbAtM4Rp5AJq/bX569R
	 At1VBhKFu4cxvNB+mS3dQHz0DZ5ZFFpFQeB4OVRc2vLqvHeQQ7iveS0cC8hUmBnGkr
	 0+W6zotV6EQMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A15DC36001;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:41 +0100
Subject: [PATCH v2 02/13] iio: light: al3320a: Use unsigned int for the
 indexing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-2-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=703; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=ynRSZu6nJx2UyMC/JZCn2Zq/vADVq3GqxbyApWvpw90=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA9h4KIyY+7mFaql0PaaN5PNdcRvG54s2agu
 Skraz0efHKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPQAKCRBgAj/E00kg
 cgB0EAC99yluiJrwzBdA3295VR1ghmmPqKqo3Kl7bxmKVdCv58MD418/Olkv3lQsF+Q5vbaktUw
 d5E6TaZG3blEcVIVU3XVzDHzE2Dss3vsVlngwO8m71fNCvPr2q4b5xo95SvHDL2i/8ihveYdgbd
 avPvXf8PlcAS2uxpsGAhPUkY9D/3qOjkyI9xZF7t9WMqgyMvAUsCZK5TIijGMGTA82Li5G3qYER
 IPTrkKnthER17g5HNdNXvYm94RWaMZ9q4xzP0zhOiTi7CfZr14s4vwoJes0k32IWfqsmvq3yxSt
 S4HaBucpBGazvYHriPStmCbKMqz+9Ey0Apq+vcNhYmAqMTNY+zgJduWt0LllHg7EQwkMdG8I9WA
 ZfxsQaQYx721hQygeRkrWSNTfVVUQXSCBlSqEoDfsYojOJMjuhE4K+oG34cpq5veQmSo9s/NlvH
 afBMNExYEqLUWWLcOh56qms9IFASDKmR/GuVooFQButX8KIcZm3DaAHBN591+3WhU5JWKpAX6gd
 bSkY+/h02Yuv7c36of7FsHw0EzZpBpedWhR4Yydn5xkdGTVHoFpP89aR+DwBhAtyzl8rNu0Zf2q
 G+d5+nJY1kPvgNQ3bC2CYkePeZ3BDhiZ/gWdps8uxwhoN8L+7ygbd6E1NqrlGZ8gM2MvfxoIO+w
 EfKmAaDyuAFsxVQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The integer is used as array index which cannot be negative.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 497ea3fe337775b07efdfc56c80beb1aa55e394c..bceda71517c8180dff76db311aa3591ab9846156 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -163,7 +163,7 @@ static int al3320a_write_raw(struct iio_dev *indio_dev,
 			     int val2, long mask)
 {
 	struct al3320a_data *data = iio_priv(indio_dev);
-	int i;
+	unsigned int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:

-- 
2.49.0



