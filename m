Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858CF9FA2E
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2019 08:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfH1GJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Aug 2019 02:09:44 -0400
Received: from mail-eopbgr710045.outbound.protection.outlook.com ([40.107.71.45]:31763
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfH1GJn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Aug 2019 02:09:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksD+D9AguQjyofUopBZs62qPZRSLiqadNSXyRtPS+oAXQ9nmtUvE4heU/Z9KQ39C4mymapyWhG5lFwodEvSeBNu1i/uRzjfQSAop+lcDRcKIKGVfplQYoj/+zNb22yh2bOroc41mMWe1HGRDBCD4qjjSTMiuyRxwjxKNS7yKS15ZSEPM2PV454WU28/1/c7CTBs2akqgZH61Rhlg0Vs/u+waQfw/x8Z3u9S8Xak1nv6qphw4BzeOKprbkwPMC/niX8le8PaFXD7q65uYP8e5iPnWlgFEfMpdJxqQ/SDcCq1D6MuPoee4naNTaUY42g8rmgvuBYgTX/Iv5G2lQzVGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msJcnTnsJ/ntq0daoKHBzBVoYgdT+SwxBLigDzJ0BO0=;
 b=AmHk5VsTJS1MV+Nr3tkclZCae9q8OkcnYVJmZkTqt2NK70wPpdk3aObz9eCW0TxA/TE4pI5/RS9lGBFpnVESM58AYVJlxaSdx83dIyG1Vjm4m0Y9yDx41wTmqBKoRj4r1y2bvD7wrqtROQDCgdti7/bVcMTj1sUA8M3CghqdnXSH7MmGeZf0AhC7iOV/FOWTTuHK98i/vMjf0nFgx8iRpYbRPLE/3ibt9qp2wnAQF2uxrkW5AfELSzln/dzymIMqgChPKWjiZZ/ikChG/keuv84Bnl3BXFwQK5ofxQ84A9BDtSe0dL4PwQBQ4d+3KUW4sG25oYXIuartDmgOJeeWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=electromag.com.au smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msJcnTnsJ/ntq0daoKHBzBVoYgdT+SwxBLigDzJ0BO0=;
 b=Tf/5/Lc7De9X3Kl6D5OlJz+UsyziujFl9V5a6ONEmvJ4AVvcTebBN3zVxLigr1/HHuiF6rbp4TQ2/Q3pKuIaTevwIw92EG1WKNlR6lP5EyouYPzY78FkrYnh4h4QbRmw469D6XQljHTi/AZ0EDRYt2KTJaEkHXSs+r3Y/C8v0Fk=
Received: from BL0PR02CA0059.namprd02.prod.outlook.com (2603:10b6:207:3d::36)
 by BN7PR02MB4036.namprd02.prod.outlook.com (2603:10b6:406:f2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.19; Wed, 28 Aug
 2019 06:09:40 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BL0PR02CA0059.outlook.office365.com
 (2603:10b6:207:3d::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.16 via Frontend
 Transport; Wed, 28 Aug 2019 06:09:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; electromag.com.au; dkim=none (message not signed)
 header.d=none;electromag.com.au; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2199.13
 via Frontend Transport; Wed, 28 Aug 2019 06:09:38 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:58923 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i2r9G-0006xL-5a; Tue, 27 Aug 2019 23:09:38 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i2r9B-0007O3-2X; Tue, 27 Aug 2019 23:09:33 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x7S69MZn016906;
        Tue, 27 Aug 2019 23:09:22 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i2r90-0007N6-7H; Tue, 27 Aug 2019 23:09:22 -0700
Subject: Re: [PATCH 1/2] dt-binding: iio: Add optional label property
To:     Phil Reid <preid@electromag.com.au>, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
 <1566876924-63608-2-git-send-email-preid@electromag.com.au>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a30b6dca-c598-135a-0559-1018dd5f5fde@xilinx.com>
Date:   Wed, 28 Aug 2019 08:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566876924-63608-2-git-send-email-preid@electromag.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(199004)(189003)(186003)(229853002)(6666004)(8676002)(6306002)(70206006)(70586007)(31696002)(230700001)(478600001)(966005)(6246003)(305945005)(106002)(426003)(11346002)(2486003)(52146003)(23676004)(446003)(5660300002)(316002)(81166006)(76176011)(81156014)(8936002)(58126008)(44832011)(9786002)(2616005)(50466002)(2906002)(476003)(126002)(486006)(47776003)(65956001)(65806001)(31686004)(36756003)(26005)(36386004)(356004)(336012)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4036;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 110ffe61-d628-40a0-d6f6-08d72b7e4f1b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR02MB4036;
X-MS-TrafficTypeDiagnostic: BN7PR02MB4036:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <BN7PR02MB4036D206383D9A6788A8D64EC6A30@BN7PR02MB4036.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 014304E855
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: s0uUs/Nn1oIZpcGVgOZbFSpxp5KUK77w96WQ3Z9NSga85b4l/er6SKDuWNHeSFa39MdlFu3KPJWEtpbhIp7VCrzgh0UBw4bIJpJd9VsgCXhIUmhOdiA3qjkQ1Qw0lkC0WSWc6GIIkZX+sLo3fzJ2pMR6BRR/5gwDMLuKUjcCnGwS6jtcb+T8Udk5yhU8IIXEtTbaYt+GqdHlEamEVvlCql7i7AQJ2H37EWZxJpWNZ+KIBEiVDu5LEyK+GBXGWoDOJenIpPnQn6WD02JdOmqlJHEbcqidkq6UDtcurKt1Pd/GEeWIovP+1HyxnJ6EQC/U5lsn+IyqMPwKllBYKpDVSODa8s+e7l61SOecdeePj2wnun1bd9GtNwH/GOscwuR3JKNISvY3Gzrur8N/ptvW9HC8j+Iz9P0pQyoEaAPVmBw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2019 06:09:38.5549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 110ffe61-d628-40a0-d6f6-08d72b7e4f1b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4036
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

Just for the record. This patch has been created based on initial
discussion about label property. And Rob had not problem with using
label in connection to ina226. https://lkml.org/lkml/2019/8/27/1213

Thanks,
Michal
