Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6DC1D5DE0
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 04:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEPC1H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 May 2020 22:27:07 -0400
Received: from mail-co1nam11olkn2076.outbound.protection.outlook.com ([40.92.18.76]:19968
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726290AbgEPC1H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 May 2020 22:27:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWdb4MedUs9MfF++V/t8/afUnIG+rvHaVYwE4MmrsrNqCZzZjZjXv2Kr9xREpiVl7BQ2lZPQGvqynaNxvYoHIELn0Vl0HO5Xs+JFaWeuDLQE2+HJ25h/tog73Nd7OQrLMI9Dce4KtZdT93WLcDjhvF0p4qE8pj8iUhMMA7hvwxys4ycldMWgxEK9IWiTIDIYmjs93yvAa1TchgdvNJbujAtqHaRmBXXjfl2vmJPdwbynTyXZFVbKA6ggz8BWEkIFq6DhZdG6UMi4MpdjgLOqHRyOEX35yoBtaf1vN0plpLyn+7JggrcMyEWH6euZ4zcdNg40q1l+aAykzMEedMJebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVNVAFZTOwwJstyvvvTWd1OVamYABilzzRnXPGpGgy0=;
 b=a81KHgupWVNQ07w/i2ryLfd+jyNwGjnXyqqSJyjocXOX/m2JJq7L5Q1kjxGOiPCQFOAffs/TibdNwa3hKInXknN6rXHHthqy4WmqtwYvXkgHJ3EJPiwtfrLZENMmAQ1EBd6RBJCpb863+M2SoUyivksPNp9jSGXHM3EXY9sDamvi6YP3J7CYgiOfMVlVtVpJdxIOfzbhJLqguFdOqwPbJNr2iZx/xOmme/7PjLhBrk+smw7BE+KtMwFln7Fprk0eyfbnOo6NZIWIqjvzkX1eTD2+wV3rdg1KepAL38DPYhiRTAiTzi2TLIRcn91xLjlmD4v3+NizMqcm7ySjcKYa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::4c) by
 DM6NAM11HT164.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::410)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19; Sat, 16 May
 2020 02:27:05 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT026.mail.protection.outlook.com
 (2a01:111:e400:fc4d::161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Sat, 16 May 2020 02:27:04 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:80D9C4A243D668029C106F8882BA89A3D640E3D714831245CF8A3B6235BC8041;UpperCasedChecksum:7B22B67EC8BA4662BB2D87F0E04AC806088E427130B4962702CB440BFF59835A;SizeAsReceived:7724;Count:48
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 02:27:04 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linus.walleij@linaro.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 0/2] iio: adc: Add a current from voltage driver
Date:   Fri, 15 May 2020 19:26:17 -0700
Message-ID: <BN6PR04MB066014AF936EF8ADCBF011A1A3BA0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR15CA0057.namprd15.prod.outlook.com
 (2603:10b6:301:4c::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200516022619.30779-1-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR15CA0057.namprd15.prod.outlook.com (2603:10b6:301:4c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Sat, 16 May 2020 02:27:02 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200516022619.30779-1-xc-racer2@live.ca>
X-TMN:  [tL/xLgLgJ2O3QdbhqOTdZwNdQz695nJW7IbzECOR2en4XLfB5mysbCNdkPKSvcj+]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6723c0b7-49ee-4890-d4d7-08d7f9409f06
X-MS-TrafficTypeDiagnostic: DM6NAM11HT164:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnS+r/wuVll5o+L96yntVdua15SJDqP2Mk8JXYlSHluJf4YRiAuNR7RRytxmvvKV3sBa9GYHJv6ki1ynHx2YcG/lR8DbEFRbBUaBPuvwG0cd/tdXsHCNFHaXHNhSLDvqTq8IpA81IEiMff/MLbx58DCxXVIWt9oepHvN0Hp/PLjShvox91b2I/6lG576eqk0BTy2VPW6JFEw2OJPAz7BGKLyeT2UHHOaDDT+tVx8diizhsX4jfT/CZgGJ8Ffkfh7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: gHFkulm66YAOBXy7bTR6XqsD0CS3+SHeyZjWvhferfnQ2Uz7w8+MI9WJF2CpeXUHASb/hbKPICCgz0hFLKXT1q2e24pGNmlX/MNIaTvzJTbr2B7Ph9HF1q4yY17mIsZvQYxBF9ifNh15pzkJrIpY1+VdgLBQVuiiWQg+fq253Kgz+VXiqOW7aRZaBhcyIyvRMGaFM/RiSmewXcPcB3ICOw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6723c0b7-49ee-4890-d4d7-08d7f9409f06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2020 02:27:04.4789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT164
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the discussion around adding the GP2A002 light driver, there came
up the question of what to do when a system emulates a current ADC
by using a voltage ADC and a resistor.  Rather than adding it on
a per-driver basis, it was suggested(1) to add a minimal IIO driver
to support this situation.

The new driver is fairly simple - it simply takes a voltage ADC and
a resistor value in ohms exposed as the scale and outputs a current.

It has been tested on a first-gen Galaxy S device which has the above
mentioned GP2A002 chip connected to the voltage ADC resistor complex.

1) https://lore.kernel.org/linux-iio/20200202150843.762c6897@archlinux/

Jonathan Bakker (2):
  dt-bindings: iio: adc: Add binding for current-from-voltage
  iio: adc: Add current-from-voltage driver

 .../iio/adc/linux,current-from-voltage.yaml   |  47 +++++++
 MAINTAINERS                                   |   8 ++
 drivers/iio/adc/Kconfig                       |   9 ++
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/current-from-voltage.c        | 123 ++++++++++++++++++
 5 files changed, 188 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/linux,current-from-voltage.yaml
 create mode 100644 drivers/iio/adc/current-from-voltage.c

-- 
2.20.1

