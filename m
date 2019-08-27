Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCA89DD70
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 08:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfH0GLL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 02:11:11 -0400
Received: from mail-eopbgr680046.outbound.protection.outlook.com ([40.107.68.46]:35845
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfH0GLL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 02:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvnKCicAZeYfwLP74rWQyJRoMKE45lIM+nYk/CtVZoA3316W5OY7vTiH0XxNniY2YVKgK6hRCmrkAJU/ggATROtAUAU/VmekQ/uVLu4Z9ULt8bW3Q4FhUdJQMXVSjXxLyCgjGQARtqhvjPm1UQmkCpFfGsl5l7A+yLiW2Wpt9lQmh0YaXSn2Jv1YO68F8P0bVxJgfIqb9Al8F6dcTl8nDLz5yM41JJAoDqsbMFbQUIAiXfCe0QhdraCzm3fei5t+6R4Kf6Q2hjPU0trXTrQEORodB5LIGhaNF4KtuwQCru+PkYxEaSDoIHgu/QWOB5Ac4CCicUIxIH1QlQYFxao9Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwKRbvRbARnlRQSCZJNyqmLiu3Lga8GV4ItdB3t0dD4=;
 b=ZOgf2h49oF2TZnUh/w7M3w97lXM8TAmWxsbf7ROTHJ5VvVCIrExHf5X+dkvhRP8riMvf57HLG6lwQivp38dfcVsyBrS4Kbem5g1KBt1saq/0bcHxnI75J2N19RFlJGPKgBlobo1cDENnHlKZcdR+IYidiat9XA9nDMLENxqedR6vscG+e+gkS8hAAiOJ1pnqdt+6DX6mKAKr1SdNuxF1rvS4DAeoPOPGWFPFI/E9xhOKRhEjDl2+qErv5jyy+wvOFaY5bVil2QiZT23VnOGAhsp8WWtQ1hmQkxtIqJhIXjLiuX2JWEkX+FB6PKYgbuIpNxtnDFNeOTgnmdenITiS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwKRbvRbARnlRQSCZJNyqmLiu3Lga8GV4ItdB3t0dD4=;
 b=hj9yT42IC7e6ZgJupnGb0skViyjJxojZLMZhqJNdhW/tqg5iKyLdq5AzjNXrheLHhuGV/ENIUPQ5uKx6jXR1opHlVpzk+eE4GNyh8LCmQ/C9KHoJYKpm4WXry+ZFM9uhS6NPjs5Oj25bEsXy3Tc0rWCRgfl2wD1jmQ+tbjP8inM=
Received: from SN6PR02CA0030.namprd02.prod.outlook.com (2603:10b6:805:a2::43)
 by BYAPR02MB5303.namprd02.prod.outlook.com (2603:10b6:a03:67::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.20; Tue, 27 Aug
 2019 06:11:07 +0000
Received: from BL2NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by SN6PR02CA0030.outlook.office365.com
 (2603:10b6:805:a2::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.14 via Frontend
 Transport; Tue, 27 Aug 2019 06:11:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT057.mail.protection.outlook.com (10.152.77.36) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2199.13
 via Frontend Transport; Tue, 27 Aug 2019 06:11:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47813 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i2Uh7-0002UC-MX; Mon, 26 Aug 2019 23:11:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i2Uh2-0004bR-JC; Mon, 26 Aug 2019 23:11:00 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i2Ugz-0004Zy-Qe; Mon, 26 Aug 2019 23:10:58 -0700
Subject: Re: [PATCH 1/2] dt-binding: iio: Add optional label property
To:     Phil Reid <preid@electromag.com.au>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
 <1566876924-63608-2-git-send-email-preid@electromag.com.au>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b4b8d01f-67c3-2a6f-e7f6-ead6cbaa6d46@xilinx.com>
Date:   Tue, 27 Aug 2019 08:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566876924-63608-2-git-send-email-preid@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39850400004)(376002)(2980300002)(199004)(189003)(50466002)(6246003)(6666004)(478600001)(58126008)(36386004)(316002)(31686004)(23676004)(76176011)(52146003)(81156014)(2486003)(106002)(2906002)(47776003)(65806001)(65956001)(81166006)(8676002)(426003)(26005)(446003)(9786002)(70206006)(486006)(70586007)(8936002)(229853002)(44832011)(31696002)(336012)(5660300002)(2616005)(36756003)(186003)(356004)(11346002)(305945005)(230700001)(126002)(476003)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5303;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fac6f18-b804-4e54-2746-08d72ab558d6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR02MB5303;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5303:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5303A7B98E9D063D1954A1FDC6A00@BYAPR02MB5303.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0142F22657
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wVrhxGVjXYOp6yBImYlSbePJ+fhsCkzTy1KujWD3cJVHjBH3AFj/ohXl2wP87xwZqDOTcm7FBvl6lkjQWokeocVtT1r/IlhHeGr/3okcTMuwRoOLuKGHWWB4MNO6WeH6xu3lE5HB24cY29fHRlHRwZACeR0utlcdeHdNZrzZOzM8YJUxTKE+oQP5WwMwgNZpH6QoVEm9NgrL6UqXEN3gZHC64YZC90uL954e6CbWkFqR0VwuaoaHUeIGkPN18L0K7ckl9lDXlJx1ioL5x1JK3ePrtCxHifh+sAME0+Ke3Uwx1SCXU5pzgTUWSsjKMHl7ejP+EzU9N2WhJl1AisMUvsaFtF9WljoQ74dvcp71OgungV84p3xSGifsLhoi1IlqNDUPeqGps/iYFaDNUeiHYgZa9D8bC3OZAanNvvU0Krc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2019 06:11:06.2360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fac6f18-b804-4e54-2746-08d72ab558d6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5303
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27. 08. 19 5:35, Phil Reid wrote:
> This optional property defines a symbolic name for the device.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> index 68d6f8ce063b..ffeae5aad8b5 100644
> --- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
> +++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
> @@ -18,12 +18,17 @@ Required properties:
>  		   with a single IIO output and 1 for nodes with multiple
>  		   IIO outputs.
>  
> +Optional properties:
> +label:		   A symbolic name for the device.
> +
> +
>  Example for a simple configuration with no trigger:
>  
>  	adc: voltage-sensor@35 {
>  		compatible = "maxim,max1139";
>  		reg = <0x35>;
>  		#io-channel-cells = <1>;
> +		label = "adc_voltage_sensor";
>  	};
>  
>  Example for a configuration with trigger:
> 

Suggested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
