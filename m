Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B49D3BA7D7
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhGCIpT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhGCIpQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 04:45:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0BFC061762;
        Sat,  3 Jul 2021 01:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gmpqjeb2FQLuOjby3N4bw5cNgvYtJfKhiZNowCwzojg=; b=AE6c81egYRW8uAmvlFYcDMKz+O
        bx4qtEIwooQs4T9WrZesilrCH0qI7hzQpkNzE5e5B+rtyPru08FrJyTzZVRJJJK0WLsSHSC7MVpsK
        4ux5EaKK2dUVrUH2WE3AoyOuPPyQsyvVjD30YJGinYZWbE8bQtd1TKBbxL6p2c+c5uuo=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbEV-0006O0-S0; Sat, 03 Jul 2021 10:42:40 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbEV-0008HQ-HY; Sat, 03 Jul 2021 10:42:39 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        lars@metafoo.de, sre@kernel.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        leonard.crestez@nxp.com, letux-kernel@openphoenux.org
Subject: [PATCH 2/4] mfd: rn5t618: Add of compatibles for ADC and power
Date:   Sat,  3 Jul 2021 10:42:22 +0200
Message-Id: <20210703084224.31623-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210703084224.31623-1-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This allows having devicetree nodes for the subdevices.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rn5t618.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 384acb459427..b916c7471ca3 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -24,8 +24,10 @@ static const struct mfd_cell rn5t618_cells[] = {
 };
 
 static const struct mfd_cell rc5t619_cells[] = {
-	{ .name = "rn5t618-adc" },
-	{ .name = "rn5t618-power" },
+	{ .name = "rn5t618-adc",
+	  .of_compatible = "ricoh,rc5t619-adc" },
+	{ .name = "rn5t618-power",
+	  .of_compatible = "ricoh,rc5t619-power" },
 	{ .name = "rn5t618-regulator" },
 	{ .name = "rc5t619-rtc" },
 	{ .name = "rn5t618-wdt" },
-- 
2.30.2

