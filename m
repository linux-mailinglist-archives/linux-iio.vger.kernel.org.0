Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28F71D3F2D
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgENUti (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 16:49:38 -0400
Received: from mail-dm6nam11olkn2012.outbound.protection.outlook.com ([40.92.19.12]:35069
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgENUti (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 May 2020 16:49:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds9KAoNuN03iTsxp5QM4K5cnzn8b5TAuc/LqyvWLURzldOEbdsGTjXzXGbIGaFlLHcYvrtUX8DWHXOUPdTeUPCya8ZWd3VsjeIp8tU47Jdf8yuP0pxIa9te6+ygiR0tA5nJnz/VJCsszAp3r0mhgGiRfrudXNxC/JulsZxzjbZ8UbvZmo6PwCbRGBzOK6d6MMd8NKyKBGUsoiw4kCyQ6z297rRkDhrnohdhz2nOQ0FgN61Ak1AKq20eCKUtNEr4XdWxYYZhwQhObfevD5GA3cdFHV6QhpR+h+MxOyXGGjnh2FVuhBVkgk0ZMdJeQ2mXhtPOFK4unzsdmWHok5iw/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gQb/mLFCP0Ax6abw0Rx/iFeUK7JPMc6LgqmOY43Qj8=;
 b=e9MnUdLQlJP2YzB3Y4Cd+LBjVTW62kH4ffGymft5cNJEVPZEg0kHBjKlnSZdhboQhp6unIoe4+OoBxL+k9q4whF9qZTqjtQInnNhGDTuLR4KCq3QBMawtT1aV6CAHWhsJS9ixASqkvobLm2YhocsaRxUMPpwnlhSQaKTrAHAV4ZyOFzp3vwgBRVd8fD0bzbaTXx0FiH+Hi+oBtHz0KaqOrhCp6lLDl5jvgG8GUpN+2QDDfsePTD6HplIizXkQ63iTXNXHuJpgAL9A32AuPCzY5PhEWWMCz/XQrO8IEdH89dGr/mvtF57yzHD5ugn4DhkItHwCwxN1Yf4Hxip38X24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::4c) by
 DM6NAM11HT176.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::215)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 14 May
 2020 20:49:36 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT024.mail.protection.outlook.com
 (2a01:111:e400:fc4d::159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Thu, 14 May 2020 20:49:36 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:4EAEA0836819E73F787C1291744D01E778C02E5C445F7792A09E7B5B056A8DA5;UpperCasedChecksum:8DB64853B47B2D4C9C2830E46BADC6666A8719CB60A42E1F9C4246D268464EDF;SizeAsReceived:7790;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:49:36 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH v2 0/7] iio: accel: Add bma150 family support to bma180
Date:   Thu, 14 May 2020 13:48:54 -0700
Message-ID: <BN6PR04MB0660D19DC149EB425A0D7F64A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514204901.3199-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR1701CA0009.namprd17.prod.outlook.com (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 20:49:34 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514204901.3199-1-xc-racer2@live.ca>
X-TMN:  [/olKf3xRIrsp2pIo8i6t2nG6YEz29elr6ra5GAvGUcqrCjmTm0wvydpo94SMj8YO]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: e6ab7dbb-55b0-4fa1-9e60-08d7f8484fcd
X-MS-TrafficTypeDiagnostic: DM6NAM11HT176:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSUAR+NN3ZeX4o1osNTryYlmypf+dWXPeIEnr0OpiHZi91N71zuXQG3ZogiszK7NbCINHgTG5PEmeBBLj1sr5fWhPDgcb6S1O9V7pygfNISwcr11UbZ/hNvQ1h/yJm3AcyFLiB4ey34S1WUBHm0lF7+fQ8SXd6oZ5hT3EnewUVsGHGDR9DEyrSkyC+CxRHN3076hKthLMavT5aTlvlXlrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: KBnnuhLZ7OK3SOp5h84En3iRDoKqxKi0tqN+jiPLTcmiisEr34rQR9FuQGpVYIHlHAvAsVnHgqObfxuFC1zDeKJpGrKBihdTVAwyqcgN/SKZyufoAgiuVDBHJ+08e8TiAGri3q+THIBTE8qMPZK2k/2TssY31xR8Q7wpTKNs2Nwwe0ho6+Gy4WgSYYn6Pcx9kaPtFE7C6eBEz/dJufvAuQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ab7dbb-55b0-4fa1-9e60-08d7f8484fcd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:49:36.2401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT176
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for the bma023, bma150, and smb380 three
axis accelerometers to the bma180 IIO driver.  The bma023 is found
on several ~2010 phones, including the first-gen Galaxy S series.

The bma023 differs from later chips (bma180, bma25x) in that it
has no low power but still working mode and no temperature
channel.  The bma150 is very similar to the bma023, but has a
temperature channel.

As these chips are also supported by an input driver, the bma180 IIO
driver now explicitly conflicts with INPUT_BMA150 in the Kconfig.

While I was at it, I noticed that the dt binding doc was missing
the regulators, so I've added those in.

The patches have been tested on a GT-i9000 with a bma023.  The interrupt
pin is not connected on this board so the trigger was not tested.  The
bma150 was only tested by changing the compatible and confirming that
the accelerometer channels were working.

Changes from v1:
-Added patches for bma150 and smb380 variants
-Add R-b and A-b tags
-Change so BMA180 and INPUT_BMA150 conflict rather than removing
 the i2c ids from the input driver when the iio driver is enabled

Jonathan Bakker (7):
  iio: accel: bma180: Prepare for different reset values
  iio: accel: Make bma180 conflict with input's bma150
  dt-bindings: iio: accel: Add bma150 family compatibles to bma180
  dt-bindings: iio: accel: Add required regulators to bma180
  iio: accel: bma180: Add support for bma023
  iio: accel: bma180: Rename center_temp to temp_offset
  iio: accel: Add bma150/smb380 support to bma180

 .../devicetree/bindings/iio/accel/bma180.txt  |   8 +-
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/bma180.c                    | 208 ++++++++++++++++--
 3 files changed, 206 insertions(+), 18 deletions(-)

-- 
2.20.1

