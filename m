Return-Path: <linux-iio+bounces-16580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1666FA57DE8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 21:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AC83B2A0D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 20:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171F920C482;
	Sat,  8 Mar 2025 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLm2++jd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4374206F0B;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741464150; cv=none; b=XZV9btYF3DoI1b9YoiBqB18E1t6d9WdbwtfqS8pRIgBLjn0CH1alb9Mg76oO0gGaxGfpGRLA3HG4PR2262RkfAEjDvLDN5/JQjnYgwnYictN0JmMwGpa3wa15txbdj0j8QPqQImfrVwr0OjvOYVDWjgr/YPp6WWVzC8JD4+JxXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741464150; c=relaxed/simple;
	bh=e/M1KcFrTfIKFEzZH5CjLPVwQnJcCPmkrwdiZwKmFT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfnusLDBzgR76Egms5TOiGPEh0EL9lasOUs984hcM0SyQE3OEjLIxtujDht1ABR02c6lnNgasaCAIx7ltnZnBOUxZw/MaAjWwLLcf/GOTee/49hPMfo07dsBj5J60UdcPXW6Sh/tJetL2TSSHHTHVhH7UJhuJMah5U/obyFnIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLm2++jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26BE9C4CEE3;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741464150;
	bh=e/M1KcFrTfIKFEzZH5CjLPVwQnJcCPmkrwdiZwKmFT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uLm2++jd5oItQkirHptb84L+yr9rhtZnncQR6glJdq9l2ZN20TXt2GcSD5qn9qyzc
	 CyudSdC8bd9LBIJ5vN5VCrF4U9udwLnARf0WOOYdq4s7+yCt3mzglXhcjqqI26HKP2
	 fWsmMAsVYNeyXS/JhIYpSDCLuXDgLflL1Qf37oFv7eGL9Pf7WvodOXBLpReUXnCUJ2
	 EFqxqOUvXZyaC3Bvnk7uyueEWiWmM5Fb44oQH+C3ieSwoCV8SKZkjC0VNWE2Vwi/j2
	 aL3iggLitx+XPRqo1GcUPjhwqFv3ic7W+a8RjTh9VZaFlD89sT3ZFNNcI+CngPPld/
	 fvoCteRiIp1gQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120F6C28B30;
	Sat,  8 Mar 2025 20:02:30 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 08 Mar 2025 21:00:59 +0100
Subject: [PATCH 2/4] iio: light: al3000a: Use DRV_NAME
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-al3010-iio-regmap-v1-2-b672535e8213@ixit.cz>
References: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
In-Reply-To: <20250308-al3010-iio-regmap-v1-0-b672535e8213@ixit.cz>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Robert Eckelmann <longnoserob@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=OztXp4B+Ou/RwdPOQioIug1hZ1oOyPA0zbFHMaWwpTA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBnzKJUrEM0E1z5B6zdsevZMBPtg5f0lVFPsD1Jo
 IU2gNgblVmJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ8yiVAAKCRBgAj/E00kg
 cmqDD/49ajNvfw4bP7MWvD/QQ0yRsdD47903cCoa5kt/iuVpdL+E4m9TsUnBoNqV9P877afkspN
 xWyDbnm0w04tenzbVNKduFOwU5gFOzFkXA62PVGjO7K1EbaPzbojVcmwTwz7eNXIa+dtkdivyMR
 97ucGVvT9awYNRobTo5IL1Y8swyEXtcDtHOdxovY045POFdaCyYylii5OXl2g7658aWcJmV3ZMK
 mQ25VT9EhTxjfJMDtKjSrrEqUoXXBymQRo1rVl+wBH9m0rZqih/fdJHGttGjeimTnRFRFOz6gHY
 c/5ROacg0SHHmUip0N+oftd+Q5zvm1loaaKSe/kxeG64Q1S8NGGNzv6+zlcnXbVU7hrMuBY0q7G
 7MidBjLn8BSTyGQ7sWOrvKmKlixhVbzpDXMZflX5bwbYKfozBk5T2H02CXaMlVki/p55bzLWUPA
 LW29MT8XkZLYm7hSaBN4SttCp5D7ZNA+XpYzz2st8a0RVLfWgguNo2PJAO4Tyvy+5B6nNffgYCu
 RSdJUvya5hNvEJrCSpVHvaBoX1K+rsn6G0ACFxSR9+Le1dEvqooi0x+sQPbSReabF2+NU4odnW4
 lKrjG2ztrvVxj2JnbgUoU5xXUvsy15dKCMrtihIpZblG3hAUcBm8BFCez9HMhaqXCQYTAkkAPT0
 swYCZDFrIFJlEww==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Sync syntax with other similar drivers.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3000a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
index e2fbb1270040f43d9f0a97838861818a8eaef813..e1fa4543f336cec61140b5c44d3794df1fa485cd 100644
--- a/drivers/iio/light/al3000a.c
+++ b/drivers/iio/light/al3000a.c
@@ -13,6 +13,8 @@
 
 #include <linux/iio/iio.h>
 
+#define AL3000A_DRV_NAME "al3000a"
+
 #define AL3000A_REG_SYSTEM		0x00
 #define AL3000A_REG_DATA		0x05
 
@@ -148,7 +150,7 @@ static int al3000a_probe(struct i2c_client *client)
 				     "failed to get vdd regulator\n");
 
 	indio_dev->info = &al3000a_info;
-	indio_dev->name = "al3000a";
+	indio_dev->name = AL3000A_DRV_NAME;
 	indio_dev->channels = al3000a_channels;
 	indio_dev->num_channels = ARRAY_SIZE(al3000a_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -195,7 +197,7 @@ MODULE_DEVICE_TABLE(of, al3000a_of_match);
 
 static struct i2c_driver al3000a_driver = {
 	.driver = {
-		.name = "al3000a",
+		.name = AL3000A_DRV_NAME,
 		.of_match_table = al3000a_of_match,
 		.pm = pm_sleep_ptr(&al3000a_pm_ops),
 	},

-- 
2.47.2



