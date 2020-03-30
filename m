Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B7B197E4C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgC3O0a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 10:26:30 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:43723 "EHLO
        smtpout1.mo529.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727899AbgC3O0a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 10:26:30 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2020 10:26:30 EDT
Received: from DAG2EX1.mxp2.local (unknown [10.109.156.13])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 03BEB2BB9030;
        Mon, 30 Mar 2020 16:19:36 +0200 (CEST)
Received: from gaetanandre.eu (37.59.142.105) by DAG2EX1.mxp2.local
 (172.16.2.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 30 Mar
 2020 16:19:36 +0200
From:   =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        =?UTF-8?q?Ga=C3=ABtan=20Andr=C3=A9?= <rvlander@gaetanandre.eu>
Subject: [PATCH 1/2] dt-bindings: st_sensors: add st,lis2hh12 compatible entry
Date:   Mon, 30 Mar 2020 16:19:22 +0200
Message-ID: <20200330141923.280226-1-rvlander@gaetanandre.eu>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG3EX2.mxp2.local (172.16.2.6) To DAG2EX1.mxp2.local
 (172.16.2.3)
X-Ovh-Tracer-GUID: 5680546a-b142-4a88-b719-306526a9666f
X-Ovh-Tracer-Id: 18444492275082084515
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvffufffkofggtgfgihesthekredtredtjeenucfhrhhomhepifgrtohtrghnucetnhgurhoruceorhhvlhgrnhguvghrsehgrggvthgrnhgrnhgurhgvrdgvuheqnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepffetifdvgfgiuddrmhigphdvrdhlohgtrghlpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrvhhlrghnuggvrhesghgrvghtrghnrghnughrvgdrvghupdhrtghpthhtoheprhhvlhgrnhguvghrsehgrggvthgrnhgrnhgurhgvrdgvuh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add LIS2HH12 compatible entry.

Signed-off-by: Gaëtan André <rvlander@gaetanandre.eu>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 0ef64a444479..3213599c5071 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -50,6 +50,7 @@ Accelerometers:
 - st,lis3dhh
 - st,lis3de
 - st,lis2de12
+- st,lis2hh12
 
 Gyroscopes:
 - st,l3g4200d-gyro

base-commit: b723e9431b77976b83efb90178dfcada3405321c
-- 
2.26.0

