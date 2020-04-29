Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD8B1BDF15
	for <lists+linux-iio@lfdr.de>; Wed, 29 Apr 2020 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgD2Nkb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Apr 2020 09:40:31 -0400
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:57924 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727915AbgD2Nka (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Apr 2020 09:40:30 -0400
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id 8DF3121675F
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2020 07:40:29 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id TmwtjOPxWrO3uTmwuj4Vtg; Wed, 29 Apr 2020 07:40:29 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=dbOuI0fe c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=cl8xLZFz6L8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=VwQbUJbxAAAA:8 a=zKD5vtlRtLnuLDy9xr4A:9
 a=sfIEtMYjypgA:10:uccc_2email_address a=rsP06fVo5MYu2ilr0aT5:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Jq/MMu6L30dsLWRddLaNxkvwFcbee6RqmoIFiQYoC14=; b=iRH/fvJ68raZFp/QLSn0oo2x7m
        olazxcq2tM1L7Vxou2ciatH+Rkr3WHGUj3t4sYnH76n9hvgg9GwzRfNcLcYZv6fyrTb7qyFyashiw
        SqVH4vRmOzrLL3ijVt05qNbaJ2LEBd9HFCS1Heya1ZKrJTe1kWiQahlgbiSrECCecFldSIyuM4x72
        c7Uz87S4iv9YcNyEJSr37memTn0pEqqXM7yBm6rJNXvN6NwW5rSCHiHGCnf5XeHbLERNwxhdxoBwI
        ca8c3WXbOHoM2H3k1U5no7Wl4sXhGnQ6a5A4Qz7cI49OeMTDnr/aQgKO7FBm64OSKgDGPJKONezfg
        5SGP7O5g==;
Received: from p5b3f6bb1.dip0.t-ipconnect.de ([91.63.107.177]:33262 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jTmwr-0009y4-Iz; Wed, 29 Apr 2020 13:40:26 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 3/4] iio: accel: wsen-itds accel documentation
Date:   Wed, 29 Apr 2020 15:39:42 +0200
Message-Id: <20200429133943.18298-4-saravanan@linumiz.com>
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
X-Exim-ID: 1jTmwr-0009y4-Iz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5b3f6bb1.dip0.t-ipconnect.de (localhost.localdomain) [91.63.107.177]:33262
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 32
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation about device operating mode and output data range
supported according to operating mode

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 .../ABI/testing/sysfs-bus-iio-wsen-itds       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-wsen-itds

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds b/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
new file mode 100644
index 000000000000..5979f2b8aa1a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-wsen-itds
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio\:device0/in_accel_samp_freq_available
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading gives range of sample frequencies available for current operating mode
+		after one data has generated.
+
+		Access: Read
+		Valid values: represented in Hz
+		- range [12.5, 1600] for high permormance mode
+		- range [1.6, 200] for normal/low power mode
+
+What:		/sys/bus/iio/devices/iio\:device0/operating_mode
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Represents the device operating mode. High performance mode gives high output
+		data rate and low noise compared to normal mode. Normal mode consumes less
+		current.  In single shot device enters to lowpower after one data has
+		generated.
+
+		Access: Read, Write
+		Valid values: "lowpower", "normal", "high_perf", "single_shot"
-- 
2.17.1

