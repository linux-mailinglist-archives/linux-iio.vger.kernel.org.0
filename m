Return-Path: <linux-iio+bounces-16581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD47A57DEB
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 21:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CD41892B0E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 20:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2302120D503;
	Sat,  8 Mar 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYGmCvHP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58AB206F2A;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464150; cv=none; b=uWGVNblt8lLSmYSkqXrASt58hsKaCvCHe1lV6NZVfM8AB9KX1exszAS0F09iYEFTJNtYSGKwd0fof6wLifHKhPUGgnNb3LVOGz7tTkuIa9TOKQmOrBtSycq4K1jOOECAb0yz0iufPGEFy8tmOzVqiKbb24RHgpbr7CsbqRQ0Qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464150; c=relaxed/simple;
	bh=Vxi1aNedGR1p/1yUmMOJhh1VooIf3jj/6Tq+WoUcTG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rfSA8XGfRdr644WjqSr7uhj3YL6QWZXbbE/eqbj9f3oKEaH6gth18tuXVFwyT7u5hhKTImnIV8VsyBhhblc7n4EcMYWow4e735b0Z9gsI/E4XNapiQfEX2tAWv0qHJKIY41+igCwL8hgBfGvGDMoarDUWWg5Ndekk1vCvLJMLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYGmCvHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22532C4CEE7;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741464150;
	bh=Vxi1aNedGR1p/1yUmMOJhh1VooIf3jj/6Tq+WoUcTG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BYGmCvHPtZQzIGiLA3+bEXVWg7WIndlfpyvSGysU/qVf/Rh8SVZ5uBo3ThhiKdeRd
	 CpS3/VaUw5sEgkFQ5IljQl10EG6kR9D3QdiNyH5B+bkEgY1Hpxi1odp4Q1dY3gRNkm
	 32jCwgFqkozsF2KKeQp7NhB/xeiaMBpJl3DlK5dWJKb02lnhY81yu2j9YBxxum1o+e
	 5SfUdAGKhmcb7XNqgAzRu3lXCceSeO8NVohWyfxb8Z6wzCalQ8436urD18Z0qpf/MZ
	 745tkSGxzOvDsVSMVO+PXRamrH9EvmYqaJBcFmQY9uasQ+En5oORYO92xJJWe2ohdY
	 vuxlq0hVo2MTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00770C28B28;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 08 Mar 2025 21:00:58 +0100
Subject: [PATCH 1/4] iio: light: al3320a: Drop deprecated email for Daniel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-al3010-iio-regmap-v1-1-b672535e8213@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
In-Reply-To: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=718; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=MXlQAzTdWxMSPXOYvO5LE/IyoymDgDTuIpV9wQjHRSE=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBnzKJUrpA+Vsl85k9Ww3JP+vnbuBDlJARo0UKqw
 1vhlvIi0N2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ8yiVAAKCRBgAj/E00kg
 ctATEACy4Yq7TFEh4DDq8NTYkhFhK6h18KSZ0BvGfh5PmB+ooHFDyjK5j7ylSBs/Mlw8iyEwFIG
 JBV3ENRfcGYFM+LeoD7cSKUfNH67TKv+GPJljp0LD4YEj8iMPQ/fg21lZG9hqez6qdqGqQxwPej
 XK8ijqON8qhuSXkVDR2Bn5P7+70M+nztt6UkRtDrZSBN1NmhqT7aB2AVrVUF65qjS8HtJRcETgF
 VzEqEz/neDPTnBjfI99ZgVOV0bm5naIbWnWUzifMpVe21gG4Vhv3UmjIuwwi/nQJs5NMUT1L5Ee
 liPypRACoJxYYzP2aezFLRZs25Jq8r+LKbWcbTVOOMQ5VUAmtHfW7hFAX5CiZfLvgoN4vitPY/X
 3++mTV1n9TePORRA6f/HCSAcDiqeQ4XeceRK2IIr3S7w10dKFiJ/bQFkPmyCupccvGbeXy2vhMF
 NIiUj2POZr5z1CtsEygeEY75tt2Gbl2RlJ4M0fKKmeXUHekF7wLBh33kv/zg0b3BkDZ16zsU6o4
 NpPSLpgKwlgRFOq0uRV52IPD8bnGdzzl9V0ONgj+0nAdn6TUtiPuULAoc3AkyeoAh3CEdtvAEAn
 KHMiVBhSRKtc3pBsY4Ck9rAj/LID2pQ66yhAGEAQ7ok8xuMfZIeS2+hyfn7YP3oqohIziRGJI+u
 x+Pbx/diuiXI7YA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

He no longer works at Intel.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 497ea3fe337775b07efdfc56c80beb1aa55e394c..d34a91fdafa0affad4665d995e1f66d2aaa0373b 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -266,6 +266,6 @@ static struct i2c_driver al3320a_driver = {
 
 module_i2c_driver(al3320a_driver);
 
-MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
+MODULE_AUTHOR("Daniel Baluta");
 MODULE_DESCRIPTION("AL3320A Ambient Light Sensor driver");
 MODULE_LICENSE("GPL v2");

-- 
2.47.2



