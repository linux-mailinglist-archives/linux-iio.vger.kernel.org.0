Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB00E1A940C
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441151AbgDOHSk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 03:18:40 -0400
Received: from gproxy9-pub.mail.unifiedlayer.com ([69.89.20.122]:44979 "EHLO
        gproxy9-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441150AbgDOHSg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 03:18:36 -0400
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy9.mail.unifiedlayer.com (Postfix) with ESMTP id A008E1E12B3
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 00:56:15 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id Oby1jdXnBxgMWOby2jNfTt; Wed, 15 Apr 2020 00:56:15 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=Pc3ReBpd c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10:nop_charset_1 a=cl8xLZFz6L8A:10:nop_rcvd_month_year
 a=oz0wMknONp8A:10:endurance_base64_authed_username_1
 a=5KLPUuaC_9wA:10:nop_rfc2047_subject_charset a=vU9dKmh3AAAA:8
 a=rDOURMCgXqsJhrHYUaYA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=rsP06fVo5MYu2ilr0aT5:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Rqx7SWX0ElvMw3PKSm/3X+3YoK5opsIfnN8zy7zmyOY=; b=lSpsOpNyctFrxvrgLN+a6fIG/c
        kIj9gL7IfRewPIcNKNB2IPO6Oayq3zcU/h4/KuibLFkm1FbYfKvWF0ncgqFhhQI0aO/nt7CVmCfdU
        tiJOTIMEvLzd+bsdFRIzMg0H5+dr/dxp7QaYJhbpB5JDw+PCT2/Og9PaxeVp84ADfOfqICkZI8pfT
        E/g8+5HA8e/CSPvG6qiZVNFWHgn7bXn6QiCCUxpW9KUpt6oTR9DXB4VYmKP9/27IO23bS1CsawVE2
        9v+X6TnktE51K+Mfs4E5+PpRj8Tsv47ZWFSP8S/wpudPRk4j3o78mLHtQfLlF56+g7e9HAiNBihId
        HS0KCwqQ==;
Received: from p5b3f6ccc.dip0.t-ipconnect.de ([91.63.108.204]:49262 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jObxz-0000eI-TR; Wed, 15 Apr 2020 06:56:12 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/4] =?UTF-8?q?dt-bindings:=20Add=20an=20entry=20for=20W?= =?UTF-8?q?=C3=BCrth=20Elektronik,=20we?=
Date:   Wed, 15 Apr 2020 08:55:32 +0200
Message-Id: <20200415065535.7753-2-saravanan@linumiz.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415065535.7753-1-saravanan@linumiz.com>
References: <20200415065535.7753-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 91.63.108.204
X-Source-L: No
X-Exim-ID: 1jObxz-0000eI-TR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5b3f6ccc.dip0.t-ipconnect.de (localhost.localdomain) [91.63.108.204]:49262
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 11
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add an entry for Würth Elektronik GmbH, we

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 23ca95bee298..a9ca88ac9ad8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1078,6 +1078,8 @@ patternProperties:
     description: Waveshare Electronics
   "^wd,.*":
     description: Western Digital Corp.
+  "^we,.*":
+    description: Würth Elektronik GmbH.
   "^wetek,.*":
     description: WeTek Electronics, limited.
   "^wexler,.*":
-- 
2.17.1

