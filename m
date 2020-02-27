Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5BD172795
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2020 19:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgB0Sbq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Feb 2020 13:31:46 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:51266 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbgB0Sbp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Feb 2020 13:31:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kYbgF5wLMHYGoUGMpbR6APlFhRJk8IuOMtZ3W/gt6tM=; b=lxwUyawgBxjwNXAStywCS9QLLI
        /YwqJQlKmjISXpF3Dx+V2drrZRiYxBK53krU2h9x26d/nR5FLRXFtOZVEULn0hnzqpoC/VDL48CBY
        WqoDH0Ux3M7v81dlj5CO56NJfiQu5Yhja5rklMpK53QJAe+CKU6EmtKVDO5O4MoWNYV0=;
Received: from p200300ccff13fd00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff13:fd00:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j7NwZ-0006ya-N4; Thu, 27 Feb 2020 19:31:31 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j7NwZ-0003oX-2R; Thu, 27 Feb 2020 19:31:31 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v6 3/7] mfd: rn5t618: add RTC related registers
Date:   Thu, 27 Feb 2020 19:31:08 +0100
Message-Id: <20200227183112.14512-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200227183112.14512-1-andreas@kemnade.info>
References: <20200227183112.14512-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Defines for some RTC related registers were missing, also
they were not included in the volatile register list

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---

 drivers/mfd/rn5t618.c       |  2 ++
 include/linux/mfd/rn5t618.h | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 849a33d64860..30fed9ab3d04 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -34,6 +34,8 @@ static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 	case RN5T618_IR_GPF:
 	case RN5T618_MON_IOIN:
 	case RN5T618_INTMON:
+	case RN5T618_RTC_CTRL1 ... RN5T618_RTC_CTRL2:
+	case RN5T618_RTC_SECONDS ... RN5T618_RTC_YEAR:
 		return true;
 	default:
 		return false;
diff --git a/include/linux/mfd/rn5t618.h b/include/linux/mfd/rn5t618.h
index 739571656f2b..fba0df13d9a8 100644
--- a/include/linux/mfd/rn5t618.h
+++ b/include/linux/mfd/rn5t618.h
@@ -139,6 +139,17 @@
 #define RN5T618_INTPOL			0x9c
 #define RN5T618_INTEN			0x9d
 #define RN5T618_INTMON			0x9e
+
+#define RN5T618_RTC_SECONDS     0xA0
+#define RN5T618_RTC_MDAY        0xA4
+#define RN5T618_RTC_MONTH       0xA5
+#define RN5T618_RTC_YEAR        0xA6
+#define RN5T618_RTC_ADJUST      0xA7
+#define RN5T618_RTC_ALARM_Y_SEC 0xA8
+#define RN5T618_RTC_DAL_MONTH   0xAC
+#define RN5T618_RTC_CTRL1       0xAE
+#define RN5T618_RTC_CTRL2       0xAF
+
 #define RN5T618_PREVINDAC		0xb0
 #define RN5T618_BATDAC			0xb1
 #define RN5T618_CHGCTL1			0xb3
-- 
2.20.1

