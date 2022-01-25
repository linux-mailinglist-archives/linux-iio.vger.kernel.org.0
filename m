Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08CC49B0DE
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jan 2022 11:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbiAYJuR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jan 2022 04:50:17 -0500
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:18406
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235603AbiAYJmu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Jan 2022 04:42:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltdhWDQ6TGGq1izuz4uXV6xQXntiMuLLGn9p8kYxMUIYeJrkBOsXOJaEMRvzGugjziOyXK4ob2ZxKnyAFMsUmOgWxIiYnXkm5b02dLYiFwbqRHtkY9gGv/S0uI4a08qORhLMbt6OMvk+rloHbzXz6hfhN26EunRnOEljlr1jMfL0oZPSefJQveqeeE/GmfBUBA1P3AhC7FLEmdh1nWTxv0DDuXcX1p+oLL43/ehB95cfClmwAHonBDxEEEf/lk+Cc4Qc6pDAZPAu/aBDewPvlLM80PYlNVqHs5NAYpLaggxUFL9Rqrz+hI1d8b3hlC3g8I6e+PFHnPpQ3YkFVe3IWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lkfam1ZM96DltPXjKqRzhRX397sI12lIdKArqOiKBwA=;
 b=B6PGNwGA7JW9VHZ7AAqGhc0RkYFxAm+oRm5zGbjWhMbwzirFgV3jU1QKnkCaBEbfFMic2wKd+In8vtO55y5RWyR8Sy1e1daNfCfjsrlImfFUdCxQ44CBoeM/xeaPtB/OQgAqAz3TCRmj1BjAxTo5GS++ZjV1CzsuTzj7B8GVt9bN8M3xs5DarSjdtfLbcr2P830c9GDET0Geja6d9meOkhATEQfFFTta13nBORCIncN1BOsKPQCycuVuS2cuoVi1754VQzwbZTCbY/ulrWk1xdG16r016M48hoHXsnyW88jUFodIZ6RDGQVRjcMUi9S4TqZGmzLeZlCOnu7pmfMCeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=calian.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lkfam1ZM96DltPXjKqRzhRX397sI12lIdKArqOiKBwA=;
 b=flusAsSW2etpzIe5jp8DryjvFxUTLwql9sYJAkxzPvT9/hptPldV+8vkrvWqBhdRl/q9+kZ8btUlksOomYMG4/Wxj9s+nbRSPHnWLAUBXlKVArzb4SLIT+XvL5FVzOYYxi4Fh3fjrsd36t4qxxN7s+E2cmuK5tMAqIMJeWv0Jw8=
Received: from SN4PR0501CA0131.namprd05.prod.outlook.com
 (2603:10b6:803:42::48) by BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 09:42:46 +0000
Received: from SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::c9) by SN4PR0501CA0131.outlook.office365.com
 (2603:10b6:803:42::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4 via Frontend
 Transport; Tue, 25 Jan 2022 09:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0053.mail.protection.outlook.com (10.97.4.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Tue, 25 Jan 2022 09:42:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 25 Jan 2022 01:42:45 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 25 Jan 2022 01:42:45 -0800
Envelope-to: robert.hancock@calian.com,
 linux-iio@vger.kernel.org,
 robh+dt@kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Received: from [10.254.241.49] (port=35380)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nCILd-0001OJ-70; Tue, 25 Jan 2022 01:42:45 -0800
Message-ID: <03258e6a-3623-0123-ade1-0635fca351e9@xilinx.com>
Date:   Tue, 25 Jan 2022 10:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] arm64: dts: zynqmp: add AMS driver to device tree
Content-Language: en-US
To:     Robert Hancock <robert.hancock@calian.com>,
        <linux-iio@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <anand.ashok.dumbre@xilinx.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <manish.narani@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
 <20220120010246.3794962-2-robert.hancock@calian.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220120010246.3794962-2-robert.hancock@calian.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 446502a6-9873-4335-7046-08d9dfe70a99
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB8217BB405B2F63F1E107E453C65F9@BL3PR02MB8217.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMhfdszyXzeXvfrBeobdhBa7cO9R3AKYbERP7bqHd1uZzm47ITfSdQ92PJuUCLjmF1/IoC5kOnRhfP4MMAqwwWLr9nwoTrXFjHGp9iIJSSSVH0tN0d/t57lPtfDS7RpADCQtOUlAvccxxwstTck+2AS5BKguBW1GTmQbIvgBoXSio5RpK13D/mFtSjUTZIVbPqKz2NhIxzXjggt1p/Z6gZj4CHPYOtYgyIvWD0sSG8bhyhXxtoa9Fkoqn7L0xKB/y3aWB7JdSbbToiE/v2SmZkcCqf6wkap+3GY2oZThGD/oBzWiySADg7DmsFzIJmAzZtFntpF/Obxk1j5g6ATdxlZqGxv58N4PRncQ2v8bA2kkPtCMsm9hfvvFr3LdtfnJdkvNrp5aFes0DOt/RrdqutECNOIZaceZ4vDPUyBZKMaQKWRmTinnnhk4rNnb41ylUERlIGel1Tgx7WQssswlKfuwUGIhwgvdOt1pIMQsgbInTAc0YWuozCaCa0n0yHkEOkEACEbKUGQFfRlsjZUYTx7xZbwp1UTR+1Ms8y4LKH0+insBe4sgGNgmy3xpoYETBmSLFvPiO5idDr3zCKeA0G6uFNyuFJUHM7NVWUftZEwR6zZsFk3kK7vLOmoCGwRW3voHFJNYgLyGOwzZy1v7bbSVI5KEVKstgiSnq0CE/6nfVaZrJcPi7kAP5fdYSFDErqUw2xCdu00TCW2plngKcsOE/O1VnLIFdXyixeJNMOg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(82310400004)(110136005)(316002)(54906003)(31696002)(53546011)(83380400001)(40460700003)(7636003)(508600001)(47076005)(356005)(2616005)(336012)(426003)(186003)(36860700001)(26005)(31686004)(36756003)(8936002)(5660300002)(9786002)(44832011)(4326008)(70586007)(70206006)(2906002)(8676002)(50156003)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 09:42:45.6965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446502a6-9873-4335-7046-08d9dfe70a99
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8217
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 1/20/22 02:02, Robert Hancock wrote:
> Add an entry to the ZynqMP device tree to support the AMS device which
> now has a driver in mainline.
> 
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> ---
>   .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 +++
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 26 +++++++++++++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 1e0b1bca7c94..108592104a1b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -239,6 +239,10 @@ &lpd_watchdog {
>   	clocks = <&zynqmp_clk LPD_WDT>;
>   };
>   
> +&xilinx_ams {
> +	clocks = <&zynqmp_clk AMS_REF>;
> +};

Please send this patch out of the series. It should go via soc tree not via iio 
tree.
And unfortunately clock is not listed in DT binding document and needs to be 
added there.
Can you please send that patch too? dtbs_check reports it as issue.

> +
>   &zynqmp_dpdma {
>   	clocks = <&zynqmp_clk DPDMA_REF>;
>   };
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 74e66443e4ce..d1fe1e5b46c1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -878,6 +878,32 @@ lpd_watchdog: watchdog@ff150000 {
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
> +			ams_ps: ams_ps@0 {
> +				compatible = "xlnx,zynqmp-ams-ps";
> +				status = "disabled";
> +				reg = <0x0 0x400>;
> +			};
> +
> +			ams_pl: ams_pl@400 {
> +				compatible = "xlnx,zynqmp-ams-pl";
> +				status = "disabled";
> +				reg = <0x400 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>   		zynqmp_dpdma: dma-controller@fd4c0000 {
>   			compatible = "xlnx,zynqmp-dpdma";
>   			status = "disabled";

And this second piece is completely aligned with dt binding that's why it is fine.

Thanks,
Michal
