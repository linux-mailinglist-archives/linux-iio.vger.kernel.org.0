Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3956B1A9422
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 09:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635112AbgDOHVF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 03:21:05 -0400
Received: from gproxy7-pub.mail.unifiedlayer.com ([70.40.196.235]:45998 "EHLO
        gproxy7-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635111AbgDOHVE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 03:21:04 -0400
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy7.mail.unifiedlayer.com (Postfix) with ESMTP id D60A02160CD
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 00:56:27 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id ObyDjdXrHxgMWObyFjNfXv; Wed, 15 Apr 2020 00:56:27 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Pc3ReBpd c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=cl8xLZFz6L8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1 a=vU9dKmh3AAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Y28-TRqkxeyTFcY-HFsA:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RHHw8W6Lmjf4Hc7SmIWpD/+CyVsKAyN8CN+edQFhdwA=; b=SNPy7jw2H46nN3+WcPpKV6lbht
        hqufwm30P1ikISQQa/VdMdqQpfUnIHCgRLlcRIVVC3G2VvojJnt8Fn9CldjrJjRaU2okWzuxE16yX
        /NRZNkZ28IEF1OTc4y/MqTirGspYrFO/HgepgK04LngbIVPzMXOcsIG8YHiCvJvBIVMvJ3hx56tkl
        luYRe/lmuUMvomvVKgCMXTbelX0whAP0Ash4gBMUnAZ/unge196Ydl28L5rX9NAo9XsrxHrUlcuH5
        UTWBY2VWBGk7rluA86cCxown+g0mivYVKgTzu7vl/6FHaO3w1r/YAk8gngRa2a8t+LoPx/rnYbuOP
        EHtoBcZg==;
Received: from p5b3f6ccc.dip0.t-ipconnect.de ([91.63.108.204]:49262 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jObyC-0000eI-4P; Wed, 15 Apr 2020 06:56:24 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 4/4] MAINTAINERS: Add entry for wsen-itds accelerometer sensor
Date:   Wed, 15 Apr 2020 08:55:35 +0200
Message-Id: <20200415065535.7753-5-saravanan@linumiz.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415065535.7753-1-saravanan@linumiz.com>
References: <20200415065535.7753-1-saravanan@linumiz.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 91.63.108.204
X-Source-L: No
X-Exim-ID: 1jObyC-0000eI-4P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5b3f6ccc.dip0.t-ipconnect.de (localhost.localdomain) [91.63.108.204]:49262
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 41
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add MAINTAINERS entry for wsen-itds accelerometer sensor driver.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32a95d162f06..0cb5dcb4d787 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18167,6 +18167,12 @@ F:	drivers/watchdog/
 F:	include/linux/watchdog.h
 F:	include/uapi/linux/watchdog.h
 
+WSEN-ITDS THREE-AXIS DIGITAL ACCELEROMETER DRIVER
+M:	Saravanan Sekar <saravanan@linumiz.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/accel/we,wsen-itds.yaml
+F:	drivers/iio/accel/wsen-itds.c
+
 WHISKEYCOVE PMIC GPIO DRIVER
 M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
 L:	linux-gpio@vger.kernel.org
-- 
2.17.1

