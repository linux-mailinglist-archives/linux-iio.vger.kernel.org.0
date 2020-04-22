Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8221B471E
	for <lists+linux-iio@lfdr.de>; Wed, 22 Apr 2020 16:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgDVOWL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Apr 2020 10:22:11 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:54955 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbgDVOWL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Apr 2020 10:22:11 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2020 10:22:10 EDT
Received: from pro2.mail.ovh.net (unknown [10.108.16.54])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 1039B4F477F5;
        Wed, 22 Apr 2020 16:13:09 +0200 (CEST)
Received: from arch.lan (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 22 Apr
 2020 16:13:08 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     <linux-iio@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <jic23@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 6/6] MAINTAINERS: add myself as a SCD30 driver maintainer
Date:   Wed, 22 Apr 2020 16:11:35 +0200
Message-ID: <20200422141135.86419-7-tomasz.duszynski@octakon.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 5833568894880275479
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add myself as a SCD30 driver maintainer.

Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c900a82f7434..e11c5594199d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15001,6 +15001,15 @@ S:	Maintained
 F:	drivers/misc/phantom.c
 F:	include/uapi/linux/phantom.h
 
+SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
+M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
+S:	Maintained
+F:	drivers/iio/chemical/scd30.h
+F:	drivers/iio/chemical/scd30_core.c
+F:	drivers/iio/chemical/scd30_i2c.c
+F:	drivers/iio/chemical/scd30_serial.c
+F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.26.1

