Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9545287F1
	for <lists+linux-iio@lfdr.de>; Mon, 16 May 2022 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbiEPPFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 May 2022 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiEPPFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 May 2022 11:05:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2773B3FD;
        Mon, 16 May 2022 08:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUi8cUTNntVxKwjPaPUN1V9aE9pqNbzjar5ZMLdx0x4GWgh3ljUheDKnoirGCYKLOLWE2fnhV1WL2PINEi1pNE63KDC5MaaR3x5HFolnAFH9hIUHD3KXGbj4xkfQAmX1y/EWplDxDy8/eU/0A4c31PKlhOJ//WxusDR/kJ62ZP30NFLxPhHTjLEhWTz5l8jDb8+alCBjk15KOkGtCZSIDyEmk4GvppZenXkypcDAz+NjoACOThTwftksJ19JsvAgD+zFYqDM+5ncSAuds07cYdnvtB6edp61PePh5egM49hcEepknvZSZxTWlNj5xEXejjrnGkdXzIe4CpqksUfOvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+zYq/Hs01upoKgteZLTTbjnLABGBiqj98+i0kRHOPw=;
 b=ZmIpj2hnNUgaV2K8oETRg3oC1iD9i0ilf+CReVsnjkkxk7mXMGxDWRRZyzYprU+Dr9v/qr8pHMUZUfgzXtx9CYdebddeHXB9Jf1cLr+M0p+/V7vTyl0IYYYJPd3p0Cymniyf7ypHGtLWhRjC98t395JEtgApwyFQvoHf0wbCxz9u92ZtBEriTTPlGT0Ft63OjGwOnYJL1WHRoj0RDAn2+wGSthcc5RWk6IoQRgVGp7A2m4e/IwjVmJ227Yg3LMEpJaJ/cntLBcaCt/i/cLRe18pgjtkbo8+/hJjpzCAN+oNqU4YA3jwYTSNxjB3hCGfGbrCW2LDx5AeWXhzGq90OjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+zYq/Hs01upoKgteZLTTbjnLABGBiqj98+i0kRHOPw=;
 b=cX3hYqOGiFGwt+cwELOscMDbXP/8J4+uQc5zGfCmT5qS1RLgSEeiAUQpJ1sOpiaYTKUYOlCy4C09Rb3OAknmAA9jFl897VypMhgZCDpPWgWkVNZ0HI0t8Ocl7ghV1AIxBW+xI/JBMgmD68EIpRak93SINP67Ny46wDO3o0Rhlfk=
Received: from BN9PR03CA0912.namprd03.prod.outlook.com (2603:10b6:408:107::17)
 by DM6PR02MB5194.namprd02.prod.outlook.com (2603:10b6:5:4a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 15:05:30 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::90) by BN9PR03CA0912.outlook.office365.com
 (2603:10b6:408:107::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Mon, 16 May 2022 15:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 15:05:29 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 16 May 2022 08:05:15 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 16 May 2022 08:05:15 -0700
Envelope-to: m.tretter@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 kernel@pengutronix.de
Received: from [10.254.241.50] (port=55364)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nqcHb-000G74-ME; Mon, 16 May 2022 08:05:15 -0700
Message-ID: <37a56b41-fa9f-832c-0aa9-80ecb5017259@xilinx.com>
Date:   Mon, 16 May 2022 17:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v13] arm64: zynqmp: DT: Add Xilinx AMS node
Content-Language: en-US
To:     Michael Tretter <m.tretter@pengutronix.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
CC:     <anand.ashok.dumbre@xilinx.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <manish.narani@xilinx.com>,
        <michal.simek@xilinx.com>, <kernel@pengutronix.de>
References: <20220505094356.670158-1-m.tretter@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220505094356.670158-1-m.tretter@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e0623a7-ed47-4d80-5a0b-08da374d841e
X-MS-TrafficTypeDiagnostic: DM6PR02MB5194:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB51942F906F53380118A92689C6CF9@DM6PR02MB5194.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOE8aUzd4mjI5kttSI8RrRK9rjsGROzpiWK27G4WZMYtPwvgmB8MFH7Cro75V+KhxpFPgF/k35Eyi2elJs9pt06JIFJ3hsvu0wjtfwamU5XYQmwnqlxIl03rw2k/VbTdzsVaD6TTSPZxGXJ98dKyL/DlS5w+HlqT2LWgJp0TrqWlHRnpmqPp6QCbM1cKsybBxLC+yT/0g/AGRINEPlGQ+kpq/hSEz7C33bchopg1XKAvkxX22WGNyd4eqCQbl+Pkiywew0P3DiDwsSjztiVKs4kHh/GelBdHVYnMqn9VN+1dIut1CrhDyYJHlhzO+Bfg1KF8++5CFhkSsNLqmeGTwxnpRWslSF7JolFX66TJBvB4h0+1aWmtwrZ+VcfRMvERUT9QQaWcxbFlGTDLWdDilPegr4CDiUnyxsNsOPBbp2ME+dFTKtP74jt/7DbWXLz+kDlwH2whOXWXs7RzlbiT4GSew5kf/UP/W1472QaJ6dTA4DT7qK/hLwvH0NoQ3l84IwjIogoO9yeOt3SWbOE2UM2/WlhH/ng9Y7lh839DhiO1C6WvjqZUW6p44OyT3jOQLZYOWYzBv2aRhtObag40RFoAI4h/TiKbm8unrg4IVuUB1EmaHmxwu8FWtzIpHJrN4bZALEWP5kmNyZsfD5O/XVFI9CCpIBckZIJDiJgV1dplisCOlxerqt+Y2Sp1cAPvQRVNxStyiSlvtCODICjGEnOEPvhx4O3icFpZ40BUYQrVouysgL8ffo9j603FFK4nE1HycHTcI4vl/cTY7xPOiVbAZwBF+rZARKOMBASb50A3BAODjn10TlGqr+yJo3v0li1oqQYQ4y56uTmLHrcNrw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(6666004)(36860700001)(2906002)(26005)(186003)(2616005)(53546011)(47076005)(426003)(336012)(44832011)(40460700003)(8676002)(31686004)(110136005)(54906003)(31696002)(316002)(356005)(70206006)(70586007)(36756003)(4326008)(5660300002)(508600001)(82310400005)(9786002)(7636003)(8936002)(966005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 15:05:29.3531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0623a7-ed47-4d80-5a0b-08da374d841e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5194
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 5/5/22 11:43, Michael Tretter wrote:
> From: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> 
> The Xilinx AMS includes an ADC as well as on-chip sensors that can be
> used to sample external and monitor on-die operating conditions, such as
> temperature and supply voltage levels.
> 
> Co-developed-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
> 
> The patch series [0] for the AMS driver was applied, but the patch to
> add the node to the device tree was skipped. Thus, the driver is not
> probed at all.
> 
> I added the xilinx_ams node to zynqmp-clk-ccf.dtsi, too, to allow the
> driver to find the firmware clock as mentioned in my review comment on
> the previous series.
> 
> Michael
> 
> [0] https://lore.kernel.org/all/20211203212358.31444-1-anand.ashok.dumbre@xilinx.com/
> 
> Changelog:
> 
> v13:
> - Add ams node to ZynqMP clock controller
> ---
>   .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 ++++
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 24 +++++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 8493dd7d5f1f..e172fa05c9a0 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -239,6 +239,10 @@ &lpd_watchdog {
>   	clocks = <&zynqmp_clk LPD_WDT>;
>   };
>   
> +&xilinx_ams {
> +	clocks = <&zynqmp_clk AMS_REF>;
> +};
> +
>   &zynqmp_dpdma {
>   	clocks = <&zynqmp_clk DPDMA_REF>;
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index c715a18368c2..573afccfda6a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -874,6 +874,30 @@ lpd_watchdog: watchdog@ff150000 {
>   			timeout-sec = <10>;
>   		};
>   
> +		xilinx_ams: ams@ffa50000 {
> +			compatible = "xlnx,zynqmp-ams";
> +			status = "disabled";
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 56 4>;
> +			reg = <0x0 0xffa50000 0x0 0x800>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#io-channel-cells = <1>;
> +			ranges = <0 0 0xffa50800 0x800>;
> +
> +			ams_ps: ams-ps@0 {
> +				compatible = "xlnx,zynqmp-ams-ps";
> +				status = "disabled";
> +				reg = <0 0x400>;
> +			};
> +
> +			ams_pl: ams-pl@400 {
> +				compatible = "xlnx,zynqmp-ams-pl";
> +				status = "disabled";
> +				reg = <0x400 0x400>;
> +			};
> +		};
> +
>   		zynqmp_dpdma: dma-controller@fd4c0000 {
>   			compatible = "xlnx,zynqmp-dpdma";
>   			status = "disabled";

Applied.
M
