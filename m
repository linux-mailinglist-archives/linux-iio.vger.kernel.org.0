Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A281C2E46
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgECRWm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:22:42 -0400
Received: from mail-dm6nam11olkn2090.outbound.protection.outlook.com ([40.92.19.90]:60384
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729024AbgECRWl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 13:22:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHGLTs9MXFfIWyThKlYuf9v6sn44rqgdVW+V+eL1ZXehDZjvSrAE9o5n+l6kqt0VvCwuSJ1pwqCJ/m4QSGLFR5EZykHZB9DwYgjEL4sBeYYBklDnDXjeOP1Cbu0NZnj+7QentvEN0098CwCGdo1FrEcyI/zzHzBxwU9eIZnqyT79B8FuO2os05VtlCwtzgQK7uc3+f2wq+xCatds2oNCNGWiAv2Tv9O7olGlhVISnVKmZuaYwthdCWUtOuDSnnES2HJNbTBkf4mv4lrJDL20xGU3H5yYMFsQoTosZt/izoR1Y6D0gN20ypfIjAGPoWEL1DI8wPujDCttC0sHKFr9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eRxWgh7LKcjtFr5w4VvhR7gwYQN68bC1s2l8MuETE8=;
 b=lomPgSNWUGFj4NaR/U44nRt5QGni80M6CClgkRrcNUbg0TpKZjPD7kYHd5l3/NGDPbq7vGb5/fty9YPbzC4Z79Ia+nb8ZFOnKvm5/s2YXO7HF0tWGctP4mC9ZXQge/pp3ycBJvs4pKTOnk5wpcPaVDtBbavzmegzpYfXoxUMhwpvV4EvOYfUmqWGxiyam6AlSOlX/uhtGg5e2IgRpGfcO3lEdKGAbGZ3URR8hbFqrUfjbSAkhKQVjKB15HYje2jjb6z2jT6fW9npCvTqKc58FizD/jI2pTrSFUInSYv2NBDQicpM85yPWTC8Pg29dSWZXriSi7sA605d1R0bvQGAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::4c) by
 BN8NAM11HT050.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::177)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sun, 3 May
 2020 17:22:38 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::42) by BN8NAM11FT054.mail.protection.outlook.com
 (2a01:111:e400:fc4b::358) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sun, 3 May 2020 17:22:38 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:CCA0B2BBF4270DE7710937906A791CE11FA4BE0660D53D0770BD574DA042BF7D;UpperCasedChecksum:1C0F01E0B3F65744F25782ABB286EDC601B4B1A66B46D2EEE782924FD37CC8B4;SizeAsReceived:8017;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Sun, 3 May 2020
 17:22:38 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-input@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 4/5] dt-bindings: iio: accel: Add required regulators to bma180
Date:   Sun,  3 May 2020 10:22:05 -0700
Message-ID: <BN6PR04MB06609033B2E0AB157A228989A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200503172206.13782-1-xc-racer2@live.ca>
References: <20200503172206.13782-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:300:12b::33) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200503172206.13782-5-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR14CA0047.namprd14.prod.outlook.com (2603:10b6:300:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Sun, 3 May 2020 17:22:36 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200503172206.13782-5-xc-racer2@live.ca>
X-TMN:  [hjaUikFZWNubrA/C41NkCidd0DAwbksf3UHSDNhzzT56t0Q1ZoryHAwkSHdDZwu0]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: a9a4080f-6f69-4ed3-8f23-08d7ef8693b0
X-MS-TrafficTypeDiagnostic: BN8NAM11HT050:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqhL8/X6dgfc8xVnmjCsbZXy8CtnAxp3YfLRRAhevioBNRRzNxKPjgi6cMuu7b0GXPrgyZYu3bantF80v4v0OhQc1D2KMdms5yCilnhwTWvnhXX/7cy/U5WItyp6cjlKkFmOa3bfUQPI7nwNWLfzBW34zdJQqjQLXUk9J/MnztZSpUvIEGgZu8pOUcgOgs52bREhU/F8NnFjwSM9kaAsNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: RCmwKfly+V7JVxVGZGxYC/cOMePMKZbpsiRzezT//BiVftGGr7QOdqywrWXMG1C1210XhlwL4Ti+XP+K8mN+fxRhtdbMdXAfMaH8Cp10qtJXNcLHSyD++rVQ4Q0ktbRGVhQ7bSkiq8s7Tt4Y9cZ4QQRvrAWuy0yfhui5hpa5OaCpfgZaZP/DucLvRaVwv+JOpQFdPYvszo09CJ/ytOWb4Q==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a4080f-6f69-4ed3-8f23-08d7ef8693b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2020 17:22:38.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma180 and related chips should have two registers attached to
them.  The IIO driver currently uses them, document them here as
well.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 Documentation/devicetree/bindings/iio/accel/bma180.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt b/Documentation/devicetree/bindings/iio/accel/bma180.txt
index 48bec35f452a..af34f4fe410d 100644
--- a/Documentation/devicetree/bindings/iio/accel/bma180.txt
+++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt
@@ -11,6 +11,8 @@ Required properties:
     "bosch,bma250"
     "bosch,bma254"
   - reg : the I2C address of the sensor
+  - vdd-supply : regulator phandle connected to the VDD pin
+  - vddio-supply : regulator phandle connected to the VDDIO pin
 
 Optional properties:
 
-- 
2.20.1

