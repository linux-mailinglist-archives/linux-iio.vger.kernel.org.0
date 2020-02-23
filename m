Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF9A1697B1
	for <lists+linux-iio@lfdr.de>; Sun, 23 Feb 2020 14:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgBWNRA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Feb 2020 08:17:00 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:60222 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWNRA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Feb 2020 08:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wnHJQJvBatsB22ok1MvEGsozkXOklyo04LvIQ6utxAE=; b=PAozG3T0/o8TO02AAh30KQzj+I
        byVBt9VsXZoK86U2Dn4EfxEhUNBehQ4+YiHudy5PJ7LYmW1+qDGG8KbMIHD9AMI7A/NJwrcAIayP/
        CvSPfEWpT1ToyfbJTyf4ujUIaFWxbG9DvmWXuUxkIiuYTeHXfvckB2S1j6qlVdevb9B4=;
Received: from p200300ccff47d700e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff47:d700:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j5r7q-0007HZ-Sg; Sun, 23 Feb 2020 14:16:51 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j5r7i-0003AS-U6; Sun, 23 Feb 2020 14:16:42 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Date:   Sun, 23 Feb 2020 14:16:37 +0100
Message-Id: <20200223131638.12130-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223131638.12130-1-andreas@kemnade.info>
References: <20200223131638.12130-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds a subdevice for the ADC in the RC5T619

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
depends on:
https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/

Changes in v3:
re-added it to the series because of
"Oh, it looks like there was a conflict.  Could you collect any Acks
(including mine) rebase and resend please?"

 drivers/mfd/rn5t618.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 073de8e0e78b..321836f78120 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -24,6 +24,7 @@ static const struct mfd_cell rn5t618_cells[] = {
 };
 
 static const struct mfd_cell rc5t619_cells[] = {
+	{ .name = "rn5t618-adc" },
 	{ .name = "rn5t618-regulator" },
 	{ .name = "rc5t619-rtc" },
 	{ .name = "rn5t618-wdt" },
-- 
2.20.1

