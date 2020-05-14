Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5241D3F36
	for <lists+linux-iio@lfdr.de>; Thu, 14 May 2020 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgENUts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 May 2020 16:49:48 -0400
Received: from mail-dm6nam11olkn2093.outbound.protection.outlook.com ([40.92.19.93]:48058
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728003AbgENUtq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 May 2020 16:49:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcOmOW8zA1feULF53AcRbXjIJstUUBtiEh7tnPtjGoPJ04qITaEqpx9wzESDr2P/XzwAOEEShWVgGtkeyT7b9UpSkVridkCFqK6AqUmomkbl8ZTJY8OsUvnsJTeAKhoHJd0jYMPjQzb6iqPFrO9GjjsLeYGBP0Qloe+HOQPZdHGHo4ImNlKAsXJUS7VSZfA57ZwQA5dNI0RXftCqWSfR7uikqLjZGIkNABk2JUgfdDv9zjlIuEAHHBTISgaKRLEQdNl7E5iJeCQoxQZhtv4svaicNdraeq2x5+SzGI9rWbMvL8NoyTF0ecK1n7AhatJiAXF1ePW7L+FMvbLNa4enhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsEikIOzJN2KycAeXhRu+tBV0xRUZUbNCQ0DCyMIZUE=;
 b=NRY5PEtFP+lTSMowznJSSPYJ1EKE2T+Qn7OUW7zzugiclYaa7NlT2v67D++ImOFvRk+qeojTHA/BCvkrLRlugx9vqxbtQcelnjm9eWGvR5ZjnMpnfk+TjUSRnxzIOTehQz3e8dKFvyvdwb4UHdDHBRH7XuZxfnv0lha0rfh2fqyhZUvIM7NPobpL1fAKfusje6r/ljq7VAdGlWUzRyiNOt0A6l5pDFew12mcrAX0U2fE97tdsKMj5WirHXNfRAofMchA8udPsOeymKx3SLs628TND84CBvF8sClD7RXPk4dhJbObC4Vz2QhqQDFCzDqpFdcBbUycAjmxXABKokJBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.ca; dmarc=pass action=none header.from=live.ca; dkim=pass
 header.d=live.ca; arc=none
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2a01:111:e400:fc4d::47) by
 DM6NAM11HT016.eop-nam11.prod.protection.outlook.com (2a01:111:e400:fc4d::318)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 14 May
 2020 20:49:44 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:fc4d::47) by DM6NAM11FT024.mail.protection.outlook.com
 (2a01:111:e400:fc4d::159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.19 via Frontend
 Transport; Thu, 14 May 2020 20:49:44 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:28633F0303056D566FB772015C9B2A5FF4795E81433F76C27336099CFF12E5BC;UpperCasedChecksum:C5D5CE817A689E16DD0152159F1B48BDDDEE8DD7AFCA5B77A3EBA36078800A4B;SizeAsReceived:7960;Count:50
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::ad10:4127:4bc8:76fc%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:49:44 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 4/7] dt-bindings: iio: accel: Add required regulators to bma180
Date:   Thu, 14 May 2020 13:48:58 -0700
Message-ID: <BN6PR04MB066073FD4A47219484D9C258A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514204901.3199-1-xc-racer2@live.ca>
References: <20200514204901.3199-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR1701CA0009.namprd17.prod.outlook.com
 (2603:10b6:301:14::19) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200514204901.3199-5-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR1701CA0009.namprd17.prod.outlook.com (2603:10b6:301:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 20:49:42 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200514204901.3199-5-xc-racer2@live.ca>
X-TMN:  [8c870iym5EcBr0ghbNkOHaFOsTMF5sMgb0kJzzciGAYyp04V6XYvMvpSH/FY6LKv]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c2131170-5491-4b13-43f2-08d7f8485499
X-MS-TrafficTypeDiagnostic: DM6NAM11HT016:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: df7HjPx3RdsRwkxbSyDsGmGX8IeVYj7MpZLbmrjjGE817mQSXO18QxMGw4OraQgJcGakH2XEVDzgi3EcWmBtLP7He/n15mSN2HMy9uclT4UxcUqoSTo4RB5vY5P+Hgd+AdMSYKY88QObxHbtHVIRz05StyVHJ4x0AuTvrzp0N0QJhZrtNsB5LGl4in2kW7U8Hnj0EMDkHwXT+wN7YNoNjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: sbGAwNrDlBydH45auQolmi+icC67xd17RMSFOIqZY5l+fGl2PRXwzDVUu36tj/1JBe9954yHkGjWE1/AitiEqRESE7ivhUfVRdtFlTZuWi2ujEZ9HXfywCLJ8ClUr4YIK0lN9m9+bW6a1Gz+0TLU/Bq8X0QGGQrqktc/a+mFmvGlG2mSxBFch1SUzD2cX5yCTKVIaadAnDXzNg+j2YSedw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2131170-5491-4b13-43f2-08d7f8485499
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:49:44.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM11HT016
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bma180 and related chips should have two registers attached to
them.  The IIO driver currently uses them, document them here as
well.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
Changes from v1
- Added A-b and R-b tags
---
 Documentation/devicetree/bindings/iio/accel/bma180.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bma180.txt b/Documentation/devicetree/bindings/iio/accel/bma180.txt
index cfbfc6276b3c..33da4a6fdb39 100644
--- a/Documentation/devicetree/bindings/iio/accel/bma180.txt
+++ b/Documentation/devicetree/bindings/iio/accel/bma180.txt
@@ -14,6 +14,8 @@ Required properties:
     "bosch,bma254"
     "bosch,smb380"
   - reg : the I2C address of the sensor
+  - vdd-supply : regulator phandle connected to the VDD pin
+  - vddio-supply : regulator phandle connected to the VDDIO pin
 
 Optional properties:
 
-- 
2.20.1

