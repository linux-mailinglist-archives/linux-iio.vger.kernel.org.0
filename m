Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380541C2E41
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 19:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgECRW2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 13:22:28 -0400
Received: from mail-co1nam11olkn2043.outbound.protection.outlook.com ([40.92.18.43]:10184
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728859AbgECRW1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 May 2020 13:22:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwJrMpv7fo9rtjyS/Q9zc+tQUOFRil+DxTzFglwurfdveIxzc/+H29f7JBtAmLqXoW40lc60d6C6CTzkyibahaYARR0Rlg/Eji1CDX04i7l0by6J/nwEVc+j7AwUo+/ev8e926ND49NTQouRNXGHz42vEvajoGA8oeHmUZmOqvCj3LlaP5o45jZ5yWD7iG8vGzND/4GY2tRF6plWSwcsOA0PtOu8Ybif8joiTuVkJUYMNwzcZGVWz97Q4jfOyzkVBozpab1hgoxPVilS2ElwFnsYBVPaXCufrVxd/mzt7dCJll7oHUOewfhN/xDlKHJdjlaGYFVuzIOV2kkknznIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSR/dwvt++l2Oi733usiHVK2Wnj++y0bEjxSjwaF94Y=;
 b=XkpIiOn6hEKO9Xpt3UBae7Xj9Fb98NG8YoxufuIgbb0khjBdD906q0TBcM77RJr6btkv7L90bWbjIwl9aaMysC7WLeiwr8n9EAfkUnYhd8jdpfJVBKpBOr0i3YjaTebkY5WD2uWFLxu8y5UIxOeIyqjcA3DRcTvqqC0SOe/c2rjwufmHjNJF5vRtvwLefuJowrYQoFzWO+geyOugBPQWHuDSYvMSSg3bxNyCFNzwHJPdm/e3pvmVTA/JFa55VVVk7M1nEzoMGayKs5YlBRAEJUja7q8lJ6OFLRBZVDfbmYPH8JfRNSDOfwZChmPOflcmqkGvLrHeQfNxDz3pYu765g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4b::52) by
 BN8NAM11HT065.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4b::76)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sun, 3 May
 2020 17:22:24 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4b::42) by BN8NAM11FT054.mail.protection.outlook.com
 (2a01:111:e400:fc4b::358) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sun, 3 May 2020 17:22:24 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B6EE349BD92D333ECC97541A81CD710523ECD37DDD0DCF701383AFCBB6EFCE12;UpperCasedChecksum:397A0D960BB03C25E65094B9F5F3B67BBD0C23249853D2BDF6FEF1FEBC407BEB;SizeAsReceived:7902;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.2958.029; Sun, 3 May 2020
 17:22:24 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-input@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 0/5] iio: accel: Add bma023 support to bma180
Date:   Sun,  3 May 2020 10:22:01 -0700
Message-ID: <BN6PR04MB0660046ABD79433EA94A85A9A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR14CA0047.namprd14.prod.outlook.com
 (2603:10b6:300:12b::33) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200503172206.13782-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR14CA0047.namprd14.prod.outlook.com (2603:10b6:300:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Sun, 3 May 2020 17:22:22 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200503172206.13782-1-xc-racer2@live.ca>
X-TMN:  [EdMbrvaaOG+gsyVIbiZXMTT8s+9h73WbHNM15p+Fd7a/N7OevFswW7Bq0MqA1HBj]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4f2964f8-777d-4534-18f9-08d7ef868b37
X-MS-TrafficTypeDiagnostic: BN8NAM11HT065:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4GXgfNIJMzs8tUAmV36GGEjHlYqVOBsg7V90IFjVbHeZGRsqsETlCaNF/GfDMcA57XpxfcVd3uG/KAiKhEIXjlw1qWTUyn05Qi1e5W4J7jWipccMVO0O+b7sf+fIFtgOYN5Apf8h1JyvnZMnrpw96aS4Y5ljoQHSYkAOLFu31qNYmZ+T4PkYGzm5mU/y/+bYz0ud1meOlBxPHDBEQnPP9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: rz2n1nsLByM8AFdRhGML+9OsB3dLX+IuN8NcciOFbZsOd+pd6kppRmH6zOm9Ix2mNQV997aw+Yc6Fg3MyOGMGhrGnjkcgRLR2KYl3/z+ODColLXIAzFO6RdJGbjvSh8mSsaOzshpOGXpRdLgg8I/U7LO9dt/FiX+0JYBad/hxwPUnKsfqwdEr2ivtU9npcnMw8SqoW9CxaR3Q8nbvovEXQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2964f8-777d-4534-18f9-08d7ef868b37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2020 17:22:24.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM11HT065
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for the bma023 three axis accelerometer
to the bma180 IIO driver.  The bma023 is found on several ~2010
phones, including the first-gen Galaxy S series.

The bma023 differs from later chips (bma180, bma25x) in that it
has no low power but still working mode and no temperature
channel.

The bma023 is already supported by a misc input driver (bma150), so
when both are enabled, the iio driver is preferred.  The bma150
is very similar to the bma023, but has a temperature channel.
Support for the bma150 is not added in this patchset.

While I was at it, I noticed that the dt binding doc was missing
the regulators, so I've added those in.

The patches have been tested on a GT-i9000.  The interrupt pin
is not connected on this board so the trigger was not tested.

Jonathan Bakker (5):
  iio: accel: bma180: Prepare for different reset values
  input: misc: bma150: Conditionally disable bma023 support
  dt-bindings: iio: accel: Add bma023 compatible to bma180
  dt-bindings: iio: accel: Add required regulators to bma180
  iio: accel: bma180: Add support for bma023

 .../devicetree/bindings/iio/accel/bma180.txt  |   5 +-
 drivers/iio/accel/Kconfig                     |   6 +-
 drivers/iio/accel/bma180.c                    | 131 +++++++++++++++++-
 drivers/input/misc/bma150.c                   |   3 +
 4 files changed, 135 insertions(+), 10 deletions(-)

-- 
2.20.1

