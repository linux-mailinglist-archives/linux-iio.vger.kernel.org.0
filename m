Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7145575CE
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jun 2022 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiFWIqX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jun 2022 04:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiFWIqT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jun 2022 04:46:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2091.outbound.protection.outlook.com [40.107.20.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204284926C
        for <linux-iio@vger.kernel.org>; Thu, 23 Jun 2022 01:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDsCOaSAPYcf73zMx6uwxxNk4xIMmhHkO7sskEsvF3bExXZ54Z7uwdL33Ze4eeuk+xSciudgfxEEAZ+WbXoYXwYZKcWTNgNZS7SoOVa65sFzT5MyZZi/U1tV3+uYPpZ98m2TijZyDbnoOEKdOZD8D3tRyUus2gZk9SfI52Rzq+hHs+4YQo3RPke/PVJqBcrROjPmX5TZ5j1JNa3JtVHdgmHRkFz+P8tUHgF3+MTG+HL32CGIfSh4gcsGenSh6d5bi7HrWOEPpaW/hfqKdB0JvDGvHwkIrORqcIe79mjTN3C3sh14uXNjAOHPWeWxmK7kLIdhFJX7jgHr4/dg83mPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJKx1XdLHaOShPDCyjtD9s3qdN/wXnDDQZjv/dRX+yM=;
 b=HuwIavv2lUNMoWRZaFkWL8GKx4sB5mrAPdc2nycepZ2JFZPPst8aQj/xRmz8WV489BEq8K66zWSOH1qbyU4uuHS5tCi3/ohzipVjapndnIJrRaBULsx8rBiRPMae2pDm7hL08/OqF8QC0of1H33rCaDY3Tigzn/cPPOazRA4bnboA+qDhEiWPJeioX5hSRUFvJZ6lHH+ix4bK9EJx0b/bFvVr9nnkbAs42jyYUwnRYS9N4UM0CC2FlV/zo7LGmKV9T8z9MTu3a4yMwxZgR//L8aZsjRH852kiJpivrmztncvKMpkj0D/iokdthRuGNa5qOGs+VD1NPoVi62l3l9iZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=none action=none header.from=arri.de; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJKx1XdLHaOShPDCyjtD9s3qdN/wXnDDQZjv/dRX+yM=;
 b=lQFssErx8ivQTpPQVpI1dDXRbFkjKp+lxSg+FmelXBT1meHdB15+hPfD2UjRb4Mh2fonmW0NlfrI/Zs8jPMnpU0bdnCLMuNpDVkf2L1Do1mcZ9ZO2mEUvVVrKckuUcH5S8br4h2PSGekRnSa8LNanJmGMHUYicEg+BtzalQo9vU=
Received: from AS9PR04CA0086.eurprd04.prod.outlook.com (2603:10a6:20b:50e::24)
 by AS8PR07MB7222.eurprd07.prod.outlook.com (2603:10a6:20b:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9; Thu, 23 Jun
 2022 08:46:13 +0000
Received: from VE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:50e:cafe::bf) by AS9PR04CA0086.outlook.office365.com
 (2603:10a6:20b:50e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Thu, 23 Jun 2022 08:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT004.mail.protection.outlook.com (10.152.12.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 08:46:13 +0000
Received: from dhcp-192-168-0-35.wgnetz.xx (192.168.55.18) by mta.arri.de
 (10.10.18.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 10:46:11 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <linux-iio@vger.kernel.org>, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Brian Masney <masneyb@onstation.org>,
        David Heidelberg <david@ixit.cz>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Joe Sandom <joe.g.sandom@gmail.com>,
        "Ismail H . Kose" <ihkose@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rishi Gupta <gupt21@gmail.com>,
        Roan van Dijk <roan@protonic.nl>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 21/36] iio: light: as73211: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Date:   Thu, 23 Jun 2022 10:46:11 +0200
Message-ID: <2649547.mvXUDI8C0e@dhcp-192-168-0-35.wgnetz.xx>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20220621202719.13644-22-jic23@kernel.org>
References: <20220621202719.13644-1-jic23@kernel.org> <20220621202719.13644-22-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.55.18]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb00b1e9-9f17-4995-3219-08da54f4d418
X-MS-TrafficTypeDiagnostic: AS8PR07MB7222:EE_
X-Microsoft-Antispam-PRVS: <AS8PR07MB7222E65E7B5BDBB3ED62B048BFB59@AS8PR07MB7222.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iN3iNbtzdsmxINbrgWbJ8QuuIbsWwsOl1GXUd4sCDX0sHU1SOZaH4DxOYr4CVYI3CEAjvwKSwlbgwHnpYUrGaiyO5R8CNozfUQFbnEN6oQGWVWCkW60D2RlO48BeGprtZUKZSAefoIu/mMicEFdaJas1MutLVw8mWAlsxzB8+KFFor6IdeAGPlVv57WiaC+mMnXgsrYPn5MWw4ZyO26omro7WKAoJFoqr6PJYhnRnbRKzXjGrf8m77YcYBdMncdb3TqVFxXHu6M/GG4zaXJbhBx2RiSXys7Csnvbd4j812FIwWpuxMJG4hB/Uc9u5OzpkWpMzV4ZBLcts+vGYM5DM+YuGYYLPOgGNxKvPdOfoDa15565QsGV7lRANEPSYsFf1O68uZLKe8TRjbraPrO7P4fgEYG2A7Id01d9vFcgZz1lrg1I3ME04bc8xxFW8kU/WCOBxohI97N0bjaPH3pyYGGTBCSorygZ9adOsFo27lzxZDjdSkISNG6f+hti69WsHcMpaYqOZrXaUnDgqyCisA4huWKDeZB38vdWwLSxjoEb+UMO+DfQm/iyBiDxF72cPKmTF3tgqHyiURDDgCFVqBoHILV5QIoedqqy6wdwUSuj0Cl890hZwhKLCReWYqXEB0E6Q6WKPjfmv7BwdJ1bc2OFbGIm+8017Jwlvc2OHY12Tm0YLu4DpTzw7b+f9bKFYnKZam7ya16LoZ9ay1VyWdOFIUjN/zK3b6PcjWCBWam0kXLmy8sp+7/2sAuV6B2F3tI2WvbRWShA33UUGY4KAZRwG+JEUdtqZL82n5oQwqEA39HjjLrvevkf07nWeEFES8isZ5ubYdZ4Qdfj7DxoDDXECcjIySqvELlb9UWFCI2hTG1vqPwW7E8XiN5FFMKE4p6Jd9jsBrCOit5Y/wlRjw==
X-Forefront-Antispam-Report: CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(70586007)(5660300002)(40480700001)(36860700001)(40460700003)(110136005)(316002)(8936002)(54906003)(7696005)(186003)(336012)(8676002)(426003)(82310400005)(4326008)(26005)(9686003)(86362001)(47076005)(16526019)(82740400003)(478600001)(7406005)(81166007)(356005)(36916002)(55016003)(7416002)(70206006)(2906002)(41300700001)(4744005)(39026012)(102196002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 08:46:13.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb00b1e9-9f17-4995-3219-08da54f4d418
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7222
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tuesday, 21 June 2022, 22:27:04 CEST, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Christian Eggers <ceggers@arri.de>
Reviewed-by: Christian Eggers <ceggers@arri.de>



