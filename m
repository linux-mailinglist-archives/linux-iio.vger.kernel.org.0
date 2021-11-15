Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759FD450169
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 10:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbhKOJdw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 04:33:52 -0500
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:49857
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237098AbhKOJdO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Nov 2021 04:33:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXrluDYid9i0zt9hIwAAQpXhkBT/Tf0qIyT5wfBqsPrbY7eVYs3BmHOxCp8rRHard9LBICkbjNY6xKcNkZ9eLoFVqsESjVF8UUjHYI4vOkcjs8b6u9bmbvJdZgEi6CtiUHWGQ7Unl7AE9L4l9Kt9PgXWs0bgkXvM2O4dxxS1uiRwjjVRFg+iyviLY1nPnIHGcxkvkbXqosb2e7c8vcw9HGuQt11n3A5J7vfV7IEk61oRrmwKW4wRotyRh2vUDM7Ok3uajCVIOaww/N1Wbg86zPaU3K9XTsdAwSKU/TI2kXbU6Q5gHX0/0TgnPD7Y5TNSn5zBpGl+O6GidkySVLrh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Z5L9bA8034Ns2ZSPwtvlBpRN7LN7UV0ctSf3f2nR4c=;
 b=XO4lTaOaHTiOJQY79MbIwWcxDy8owG0NYp11rXWtUiSMMMt2RvjBA31Yu9H1oZebWzo9VAL6gX2nuwhsiEIHmcM1tjJWCGiNvgwQJ6rg8EFIv+qnO9PGZ1uYi9mqqqbPLYFXVFefXUJDRvynu3PmS7yajk+bGmXxidLGMYiPM9aT7w/e9/PvwlLzbP9djp3cyOKXeswuBWDc2i5qz0k8qGMCMwjTT+5Bb5hW/aTQPJinbsFONBSafT5SZ962bZ3aTkc9nJb3xa3GUj48ntT6dwYoeTsvQpWX6dKW4rMhF38MV4aSuc1hUDjO72vxbFGNb18upOH3IiSbaMEKG6TxXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z5L9bA8034Ns2ZSPwtvlBpRN7LN7UV0ctSf3f2nR4c=;
 b=ZcYt/MSs8bfzsQuNtzUqasPA7sKDrsOqGrsUEqVDTmWXJxRNLp0wqvZ1co442egwjWZlfQP3XdS3ndAhvNDlIZBmF9wRkG+EyaiMeEKeGAP8Xf0q5AN/R06guluBoQyQ1vXZvVqdXDdIMUw2C/Zzc4vWvqkRo9ggYyPrGkKk114=
Received: from SN4PR0601CA0007.namprd06.prod.outlook.com
 (2603:10b6:803:2f::17) by MWHPR02MB2206.namprd02.prod.outlook.com
 (2603:10b6:300:5d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 09:29:54 +0000
Received: from SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::70) by SN4PR0601CA0007.outlook.office365.com
 (2603:10b6:803:2f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Mon, 15 Nov 2021 09:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0018.mail.protection.outlook.com (10.97.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Mon, 15 Nov 2021 09:29:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 15 Nov 2021 01:29:51 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 15 Nov 2021 01:29:51 -0800
Envelope-to: git@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 pmeerw@pmeerw.net,
 devicetree@vger.kernel.org
Received: from [10.254.241.49] (port=57586)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mmYJD-0008CM-I8; Mon, 15 Nov 2021 01:29:51 -0800
Message-ID: <5876573d-66aa-620e-538d-36a287900c7e@xilinx.com>
Date:   Mon, 15 Nov 2021 10:29:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 1/4] arm64: zynqmp: DT: Add Xilinx AMS node
Content-Language: en-US
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michal.simek@xilinx.com>, <pmeerw@pmeerw.net>,
        <devicetree@vger.kernel.org>
CC:     Manish Narani <manish.narani@xilinx.com>
References: <20211108210509.29870-1-anand.ashok.dumbre@xilinx.com>
 <20211108210509.29870-2-anand.ashok.dumbre@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211108210509.29870-2-anand.ashok.dumbre@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de65a4f2-8f9f-4e96-921a-08d9a81a7b34
X-MS-TrafficTypeDiagnostic: MWHPR02MB2206:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2206864A68872615A2714D87C6989@MWHPR02MB2206.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exrYYrxCM1mm2WHWCrGerFXE7OyqxpLpLuR+n6uk9aaL51URe0KEFA64PIXuWyxsAd4kQ7T0lco7gogBpSXYYli9B5kTCWhPGgrkMR2X+8oU9FLYD6f8Kuep6tpePSbQ2f+7vRUk7vkzSENqMpkfzc0HjRxsRGiamBgQpXCcNQyAjzAnKlWPcoJNWUQ7pDtn2gGZas6BNgYHkNOi15jgpNZizzb8W+Dm2VUlIftYRsJNOILSHCJ5qTOSDzsOvEQII7IUddVfHEIliRoXp2eUn87LwIxD8jT8o2D2eKUJORw2FRcetniYVFcjOyGqhqWv/SJgovBRVJnRC7mi8gxlWCtklYVH5fi2AQIJVklWXrqoAYwwaRd9kYykQPUgkEY6HffBTCTbw+BVqMmTTobh3HNOdwIlW8tZr3vhVhBEHL3WpY0Xf3y7PsSTqlXqJT2toKuR5koz3H9L0xAov92CJ/oamvKUxRqzeY8+ar40IsHGZhIdXoEqUwlOZSivZlN+WiqJ2E/0oFpM1VFWUSHwfvCO611ty2V5iMoiqpXjw7Ru62zcq6mHROaWAKI3jJi2dSImqZABI9vvIicfW4wPi8wzx/J3+RLb69nK+skuPJoK7NrdfoRyBzgThbdgDadhkd8Wyrkt8iT0dTSfb4jZJWAhoX3v5uTOIVzsODCT6Z/u1N3kGf5nFwLJQf2vcA4ZsbPL3q4J8u4GcF7fld6qHOSUngeaqQMpBLF3yo0GtaOp7ydGW8y7WbIuWehZpv5tPNqsJWg2nNN+u40ecCAGKA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(8936002)(36860700001)(356005)(70586007)(26005)(31696002)(186003)(9786002)(8676002)(31686004)(107886003)(4326008)(5660300002)(53546011)(2616005)(70206006)(6666004)(47076005)(44832011)(2906002)(82310400003)(36756003)(316002)(7636003)(36906005)(336012)(110136005)(83380400001)(508600001)(426003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 09:29:53.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de65a4f2-8f9f-4e96-921a-08d9a81a7b34
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2206
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/8/21 22:05, Anand Ashok Dumbre wrote:
> The Xilinx AMS includes an ADC as well as on-chip sensors that can be
> used to sample external and monitor on-die operating conditions, such as
> temperature and supply voltage levels.
> 
> Co-developed-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 28dccb891a53..b12e0cd0adfd 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * dts file for Xilinx ZynqMP
>    *
> @@ -849,6 +849,30 @@
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
> 

Please drop this patch from this series. When driver is applied this 
patch will go via my xilinx soc tree.

FYI: And dt binding patch should be the first.

Thanks,
Michal
