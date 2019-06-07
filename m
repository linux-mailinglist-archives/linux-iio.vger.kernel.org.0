Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6555F38510
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2019 09:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfFGHa7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jun 2019 03:30:59 -0400
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:42364
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfFGHa7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Jun 2019 03:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdiUMiUuY/hvGWG1m1f3xp8LDEFHiJLcjTH3kOGj4PI=;
 b=S/3T/p04Ow9bWs0KRNuVT8FW2ChenfHr1bDu9wsIs3H0HloW86cH1cSyd2n8W/pDFc5yZMCt9x0VZK+BHkOHOHbqEbu0AN5adIsWYkYk4raXWeRM0W3191v/dWlkyYTKpbiAJufXc6Q8Z1BMvZcpVNFQXzL04rnKipXr2M3EU6A=
Received: from BYAPR02CA0053.namprd02.prod.outlook.com (2603:10b6:a03:54::30)
 by SN6PR02MB4941.namprd02.prod.outlook.com (2603:10b6:805:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14; Fri, 7 Jun
 2019 07:30:56 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BYAPR02CA0053.outlook.office365.com
 (2603:10b6:a03:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.15 via Frontend
 Transport; Fri, 7 Jun 2019 07:30:55 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; sedsystems.ca; dkim=none (message not signed)
 header.d=none;sedsystems.ca; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Fri, 7 Jun 2019 07:30:54 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hZ9Kv-0003f3-Uv; Fri, 07 Jun 2019 00:30:53 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hZ9Kq-0005aC-RY; Fri, 07 Jun 2019 00:30:48 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x577UV8B030336;
        Fri, 7 Jun 2019 00:30:32 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hZ9KZ-0005Mc-7M; Fri, 07 Jun 2019 00:30:31 -0700
Subject: Re: [PATCH] iio: adc: xilinx: support all ARM platforms
To:     Robert Hancock <hancock@sedsystems.ca>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
References: <1559768858-1175-1-git-send-email-hancock@sedsystems.ca>
 <379a99c8405b4cfbaa61ac49f9b40d4c577eb2a8.camel@analog.com>
 <95be35ff-2e3d-bc00-8798-7c9f462a96a6@sedsystems.ca>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a96943b7-00f5-288f-fa27-a82f1d6aa8dd@xilinx.com>
Date:   Fri, 7 Jun 2019 09:30:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <95be35ff-2e3d-bc00-8798-7c9f462a96a6@sedsystems.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(77096007)(26005)(186003)(58126008)(478600001)(2616005)(11346002)(446003)(23676004)(50466002)(336012)(64126003)(6666004)(36386004)(356004)(229853002)(76176011)(9786002)(305945005)(126002)(2486003)(4326008)(426003)(476003)(52146003)(486006)(316002)(44832011)(65826007)(36756003)(70586007)(8936002)(70206006)(81156014)(8676002)(2501003)(110136005)(47776003)(6246003)(106002)(230700001)(81166006)(2906002)(31696002)(63266004)(31686004)(65956001)(65806001)(54906003)(53546011)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4941;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5d8c8fd-dd40-4fb2-4606-08d6eb1a1372
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR02MB4941;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4941:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB49410CED3DAE5A60A6A63CE5C6100@SN6PR02MB4941.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0061C35778
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: c+xUZ+IKqNV576XwBzIGtu7nx3ZgTRMr0q6m/RAMafrGOPtnwU+GZ2Ub62okqlERGx92VahaFFD8ObwU1zviY0Wc62dVgHMZ5mQumDqpBsPV5CGHTdTY2IpWB9bid4BWNiF4XWyz8YRzkvDi/z+/1U+xpqJnfwBRD1HYzwlxfsLXhseP9g9Xmmu2puz9vAeZTVl2m5byPA7lN8U6gfKGPyeNv0VQe+ycYgdqnni3NZbyn5Om/kj2jGM8k7g5TbNr7mE+ZhCVK9shpVu8UV6SCAxUFFx1o1SuulzWnOsrqC1mSEllnIcDdeG25oarQqzsAo6tqxrBHicOR3gEkNqFbtGmgehAEykT8Lwd754KwqO5Pd0dKTnRUfgb6g3WXpvjKfCEi2rGjUg1UVbqMqMJweTM8ImaS+O53X9iQB3qXwY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2019 07:30:54.5675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d8c8fd-dd40-4fb2-4606-08d6eb1a1372
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4941
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 06. 06. 19 17:21, Robert Hancock wrote:
> On 2019-06-06 4:09 a.m., Ardelean, Alexandru wrote:
>> On Wed, 2019-06-05 at 15:07 -0600, Robert Hancock wrote:
>>> [External]
>>>
>>>
>>> Since the XADC logic can be used with standalone Xilinx FPGAs, this driver
>>> can potentially be used with various ARM platforms, not just Zynq.
>>> Change the Zynq dependency to ARM in the list of supported platforms
>>> in the Kconfig dependencies for this driver.
>>
>> To my knowledge, there are 3 FPGA platforms with ARM supported in Linux.
>> And symbols are ARCH_ZYNQ, ARCH_ZYNQMP & ARCH_SOCFPGA.
>> For these ARM + FPGA SoCs, it is usually preferred to list the supported/tested ARM + FPGA platforms in Kconfig.
>>
>> I am curious: are you using something that isn't in the above list?
> 
> Yes, we are using the XADC on a Kintex-7 FPGA through a PCIe to AXI
> bridge using an iMX6D platform - not an integrated ARM+FPGA.
> 
> Using such an approach this driver could potentially be used on just
> about any platform, but I didn't want to open it up too much for now in
> case of some compile issues.

0day system should answer this for you.

M
