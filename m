Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FA61BDF8E
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 15:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgD2NvJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 09:51:09 -0400
Received: from gproxy1-pub.mail.unifiedlayer.com ([69.89.25.95]:60622 "EHLO
        gproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgD2NvI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 09:51:08 -0400
X-Greylist: delayed 652 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 09:51:07 EDT
Received: from CMGW (unknown [10.9.0.13])
        by gproxy1.mail.unifiedlayer.com (Postfix) with ESMTP id E8F8257A48326
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2020 07:40:35 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id Tmwzj5RFZtoKZTmx1jiq8d; Wed, 29 Apr 2020 07:40:35 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=EoeilWUA c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=cl8xLZFz6L8A:10 a=oz0wMknONp8A:10
 a=vU9dKmh3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Y28-TRqkxeyTFcY-HFsA:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pEKOK3Lv6LD/BXwJYHMx/zOmO+8v4qp4eXo9co8fUiE=; b=YsKgMsJsHxQB8uLYXRjy7n8kFo
        m7s7y3jW8OQLxYu54Egng9OloDLNvm737Mzl1usYU7wQmMVxLW7YoWbTiEagTVOSJqP4XDMUEPuq2
        tHwpQACSevBm+tLNv/fVnpJ/8iNpQfloa3KuuiGZTPCW/Qac/ja5s3dtkzUp1Z+4PbHuJUfQ884By
        c/mFy/vpCXtyxo1ONE2Hb5cHKDUSOU2PPa8vsTf8wVtJwk0Jr24zA7kvegHfoXm4BXDIws/ZLDEQe
        WF+nEf9d395h6Qu+xX7n+YcjpWxX6aJ8bZGoix8TNgyIipTQ4IksqavASJG5iQgIL3+RxdkuJmLJz
        AxyB+hCg==;
Received: from p5b3f6bb1.dip0.t-ipconnect.de ([91.63.107.177]:33262 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jTmwx-0009y4-UG; Wed, 29 Apr 2020 13:40:32 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 4/4] MAINTAINERS: Add entry for wsen-itds accelerometer sensor
Date:   Wed, 29 Apr 2020 15:39:43 +0200
Message-Id: <20200429133943.18298-5-saravanan@linumiz.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429133943.18298-1-saravanan@linumiz.com>
References: <20200429133943.18298-1-saravanan@linumiz.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 91.63.107.177
X-Source-L: No
X-Exim-ID: 1jTmwx-0009y4-UG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5b3f6bb1.dip0.t-ipconnect.de (localhost.localdomain) [91.63.107.177]:33262
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 42
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MAINTAINERS entry for wsen-itds accelerometer sensor driver.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32a95d162f06..d70b31910cdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18167,6 +18167,13 @@ F:	drivers/watchdog/
 F:	include/linux/watchdog.h
 F:	include/uapi/linux/watchdog.h
 
+WSEN-ITDS THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Saravanan Sekar <saravanan@linumiz.com>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
+F:	Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
+F:	drivers/iio/accel/wsen-itds.c
+
 WHISKEYCOVE PMIC GPIO DRIVER
 M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
 L:	linux-gpio@vger.kernel.org
-- 
2.17.1

