Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1312768AC
	for <lists+linux-iio@lfdr.de>; Thu, 24 Sep 2020 08:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgIXGIk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Sep 2020 02:08:40 -0400
Received: from mail-eopbgr760054.outbound.protection.outlook.com ([40.107.76.54]:44516
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbgIXGIk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 24 Sep 2020 02:08:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dP3+BA+4cOhM0T0v0lLNgxJxVHyjmMOpNJK1EZ7HbEFhDWEkzKWoNi+rZcgjidwZilG0UkODvjieMw1tLHrtpm3r8pv4Pu18rwx4kcKGR6T0+0CGXQN+u8d14m8ajmRCQjnqDVD9M1Lu6MrqaXmrvVdL23fPlUtdHaNm7AmQq9cqJuRHlyhe9yUk0TjT4/9lf+gZVZGDuzOK0AYjvWYdjTnHMd9UUSub83FPAeyTad8Cc2/8uCkxHTv5GPSe0jAM9jiRY5jU+bXwgYHPP/zKj/gLzq/sw+f7JEupTT+e4y55exrM+qqzluhpFjAS3EyKfzjNwX0cpnBtYaRGBJ5ycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+Zp1hFk1xz9Ta/t/7q4Q8CmTsLCEljtGcXcY+f31gU=;
 b=S0QHZ+OMo2RCOQ1dV1rC20wDM8xk7t2JPKoYsSQGNJRiKXyJMWMTxRJhuOMPLCiF0Iz7XRqqu24oIwK5ELUzD0inpeoBvj6boIdzSf9PCDpFnPBnhJkkmaX7tIJobME4l2/flhbB4zLWGpVphM9RG41GyRG2WPlQLtXL4h8dOmmeQg672tii/ZF2iRO3tr1JH3LD7sF2rm6IHjKWa2ZkA7fc0TunJ+GDK/nIWNfmD2GV1FMZvOeyYD6vTs8GI+xaLCfA0CvbnJu0FZOWClB3dmnnL797ovLt9KzatHya1LeMzD9x2IFkOteyB+/s4P/0a9UzcUkIfS9zQSJHoRKH1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+Zp1hFk1xz9Ta/t/7q4Q8CmTsLCEljtGcXcY+f31gU=;
 b=hwi3snmHKHdw2WUbC5ToC98uPlYVCLW+af1/jfXA/YGY1INBWQLYMPltjsdjZwD1TpJpwbsVR0e7eSv260nT1/iHcULnlZFj6kv/sSxW4r/3zLiDiZi35U38sBVFKdfxLUaX40wAAbGpj0iRqJM5rovTVeFzzOhj/YzNkPWCTuc=
Received: from CY4PR13CA0040.namprd13.prod.outlook.com (2603:10b6:903:99::26)
 by BY5PR02MB6210.namprd02.prod.outlook.com (2603:10b6:a03:1fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 24 Sep
 2020 06:08:37 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::71) by CY4PR13CA0040.outlook.office365.com
 (2603:10b6:903:99::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.8 via Frontend
 Transport; Thu, 24 Sep 2020 06:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message
 not signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server id 15.20.3412.21 via Frontend Transport; Thu, 24 Sep 2020 06:08:36
 +0000
Received: from [149.199.38.66] (port=43685 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kLKQV-0006o0-Pz; Wed, 23 Sep 2020 23:08:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kLKQm-0004Q6-B4; Wed, 23 Sep 2020 23:08:36 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kLKQj-0004PL-7T; Wed, 23 Sep 2020 23:08:33 -0700
Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
 System Monitor
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
References: <20200922134624.13191-1-lars@metafoo.de>
 <20200922134624.13191-2-lars@metafoo.de> <20200923214728.6e0c07b0@archlinux>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <fb8db604-0ae3-1736-67bf-20a1dc8bc008@xilinx.com>
Date:   Thu, 24 Sep 2020 08:08:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923214728.6e0c07b0@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a9636e5-2e6b-4eac-74a7-08d860504649
X-MS-TrafficTypeDiagnostic: BY5PR02MB6210:
X-Microsoft-Antispam-PRVS: <BY5PR02MB62108A5D264C045BF79B243FC6390@BY5PR02MB6210.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfINXkd8PXGG5e7/Lq1VGusDMzC+YUNbJdXNEkhieXplRwrgMnxKpI06ghnsmQM4i4jT0AnmIn5O6F4qUThcNUescUThhCmVYCmAWBgOcKT6ZM0DJUdT9+S42LoJF+IQ119h7c6ltEmM01sa8pVO3VK6LigQx48zYEGSJlo0Th4AzmRGfdRhc+tbDiA9JFcWt+hJoEt+LcXTZ0RrYaX0oMFdZXTbumbAeLZTvoJ5xDrQo+Ss5CqGQV0T6Pvb6PcNcc3tpKUvPJq7xExOqxZcsbcTzePOmP1gT5SKtjrDDmPjtjCSgtd/SLFbPrzzcZFyQKL0bDvkB6Af3p5oX9DBrF7atABIGlKpS+ZoNlBxj149Is+vLt+IbSRJcDpyQwWBMiKZ96A8IZxYT23oiZwuwqZB//dyMmYfkXvhwx57e2HhHeHcLbqOj4rM8XZd8cX+msBMXmImxOcDQ51Gk9Sd+iLnkAKKsebBXLhjH9MRUlk=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(46966005)(110136005)(107886003)(316002)(2906002)(70586007)(31696002)(81166007)(82310400003)(356005)(44832011)(54906003)(5660300002)(70206006)(83380400001)(478600001)(4326008)(336012)(8676002)(36756003)(2616005)(8936002)(426003)(63350400001)(47076004)(31686004)(9786002)(26005)(186003)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 06:08:36.5744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9636e5-2e6b-4eac-74a7-08d860504649
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6210
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi, +Anand,

On 23. 09. 20 22:47, Jonathan Cameron wrote:
> On Tue, 22 Sep 2020 15:46:24 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
>> The xilinx-xadc IIO driver currently has support for the XADC in the Xilinx
>> 7 series FPGAs. The system-monitor is the equivalent to the XADC in the
>> Xilinx UltraScale and UltraScale+ FPGAs.
>>
>> The IP designers did a good job at maintaining backwards compatibility and
>> only minor changes are required to add basic support for the system-monitor
>> core.
>>
>> The non backwards compatible changes are:
>>   * Register map offset was moved from 0x200 to 0x400
>>   * Only one ADC compared to two in the XADC
>>   * 10 bit ADC instead of 12 bit ADC
>>   * Two of the channels monitor different supplies
>>
>> Add the necessary logic to accommodate these changes to support the
>> system-monitor in the XADC driver.
>>
>> Note that this patch does not include support for some new features found
>> in the system-monitor like additional alarms, user supply monitoring and
>> secondary system-monitor access. This might be added at a later time.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Very nice.  Will let this sit on the mailing list a bit longer
> but looks good to me.

FYI: I have asked Anand to take a look at it and retest.

Thanks,
Michal

