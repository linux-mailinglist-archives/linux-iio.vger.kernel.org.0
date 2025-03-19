Return-Path: <linux-iio+bounces-17119-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B409FA69A66
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 21:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C3F8A62F3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 20:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312C215783;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqh2XRon"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788D2135DE;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417985; cv=none; b=gId5BCO7iC6FurmN3SB4g7byehIZpyNV330ffB9du6yu3fru4sxZDLYkHD2lorMVnp1M9snzzH2alBDUONd+cCQ6u32zlTqtWZkXs2M0zglbyD7qkXwpEigvUa0fIsbund3iX3kf3KXXCCoTat269kuoPMCIMI3qeYQdesezqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417985; c=relaxed/simple;
	bh=euz6il6nXV6p1paK6FZ1GDbp+BIc+6JBLiJ8M+pD1yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kE3rwT6t2CAHZVsEYnfAkCsGztdBYO/ZXx4sjN3rd0DPd0WyPYsUahJh3oPlxmtQKWDaHusqMXlnkZcoEh5xh20sy9gk7cM0VGhBU5GLNLynA259p4b11i2cD99opIKvHhD/5j3ObElBkiVKB+abwdm/y+rmfSyGsNZ4b4rkTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqh2XRon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A186C4CEEA;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742417985;
	bh=euz6il6nXV6p1paK6FZ1GDbp+BIc+6JBLiJ8M+pD1yQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Hqh2XRon0kWo1EEfuMoIEwOAYWGC3e9QqRnAv+RrWwpYY88Gw+eCuqeQk7EH2TU4g
	 V98n8D8IF1ByZp8iBN9YT7zRco9RViRRb/2VXgi7AG95TojSrDR9Gypd8R+cB8dYKY
	 54vVaP6/CSxtS7Jgw+ALZrt8nYY+/SD8WdMzDN3BA+x0C4R4tMaWSB4ePJycNozZeV
	 fZjFn4i70eOLsEWihoX4oTMlJgIlIrukke3RdmGtCoe2jOYgLNLesat9x/hCOl7WPR
	 b6RYI4IVqwSXaRcw9YeAI5p4l8EgzkE2Y1yROgdhGWmNDJG/ugAFQVeZNQSDN23712
	 5hhnIzU/HrxKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A6C36000;
	Wed, 19 Mar 2025 20:59:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 21:59:40 +0100
Subject: [PATCH v2 01/13] iio: light: al3010: Use unsigned int for the
 indexing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-al3010-iio-regmap-v2-1-1310729d0543@ixit.cz>
References: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
In-Reply-To: <20250319-al3010-iio-regmap-v2-0-1310729d0543@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=695; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=10RW+w/I6ilKLev9SA61EnDHTOc4Fb07ecKF8eR6P2k=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2zA9nvfVsg54dt4iRBKJw7MJR9M/9KEpGtost
 aKxsPesBrKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9swPQAKCRBgAj/E00kg
 cjiVD/9/dzEsrY+MLXY7m/lJf+McDISs1NNYlOQTF0sQLMx+jQueAxoG6UVqyrPN2O6w5zhISxt
 Zq92t+hu3JqLGS9sAMx974Kpeix1Ja4MFblYtXygFd4XEYEWI+gcZYzHZl2KbE8xKBlyc/mEN2+
 oD67aKLjyJg6/G6v5IfbPc3B7vJzBf2/lMNUO4B00wuwUWfeaCyFhCurPTHMvdaT61IBo/6m12n
 IY2FLCU1yokyDskmoOEDUDGd3Q30mp+sSGlZ4fsuy34fvYMksEkFmL1EsyhgYLeVNcN5DM1C4jO
 n2dVJf1HDHpgQSYrvOVx/PxXpvmqglUuQCe6fedNzqSCqD6bSHxWYbQPzEVg7CTb5bnHYOu4H9S
 Lb3W+oOf4hpcIfoNDlt4O3oCPdr24whirSwtFnrEYmy3kerS5N3FnapngONcJGiWbASdRNfsNhu
 6H8MqY7WF3jnKSSbhQYPIaLasr6T5NJ+3OXwXV/udEqlNDB1HEHshI9q80Nyt7n8K90jR/qwQYT
 JeZfwk6YypAwGqM8zeuPVO5Kn3RhSAnPL1Nj9IyBZ6RZCViLaohKrCaWcAC1suExEy1mPyvsei3
 rJ4k2tO2MTi5sJ8OooIb9z5SDwacIJZW1B2CX8Lvs6juNa8+yYzncc+LTI057Qz59ZF5KU6bn77
 rew6XGe6F7cTOHw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The integer is used as array index which cannot be negative.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 7cbb8b203300907a88f4a0ab87da89cabdd087f3..4c2fd88ab32cd73f4735b0fa3014af084037c94d 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -145,7 +145,7 @@ static int al3010_write_raw(struct iio_dev *indio_dev,
 			    int val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int i;
+	unsigned int i;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:

-- 
2.49.0



