Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF7961413E1
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2020 23:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgAQWBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jan 2020 17:01:02 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:38362 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbgAQWBC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 17 Jan 2020 17:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=txK711xVT2FClEAldfopb3dlqvKdPJUxZlgvaJsxe+I=; b=MyI5A+xB99uOPsjzd6vtiBsWRA
        2l4waYncLKoooxr/+29thTb+AxHalIbPFcF+Z94UDlqosLT0IoPNOqyq99F4rArHmhTEFxFf7oqoD
        o3JOICKRS28OLVymCAKetIYThITWrnLas6Jn6pT44KcmziZnN5rjW7IkG1w5/9fGfkUk=;
Received: from p200300ccff371b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:1b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1isZfk-00077b-Vk; Fri, 17 Jan 2020 23:00:57 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1isZfk-0003ya-ML; Fri, 17 Jan 2020 23:00:56 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org
Subject: [PATCH 2/5] mfd: rn5t618: add ADC subdevice for RC5T619
Date:   Fri, 17 Jan 2020 22:59:23 +0100
Message-Id: <20200117215926.15194-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117215926.15194-1-andreas@kemnade.info>
References: <20200117215926.15194-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds a subdevice for the ADC in the RC5T619.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
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

