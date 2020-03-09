Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7EF17D8C6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 06:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgCIFOc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 01:14:32 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:49443
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgCIFOc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Mar 2020 01:14:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPwNpSgb9dy4E4BesDzlv8DPq3QC/olU2a8FYWPkcp7iX5605yHwkiE9joeKEQf6q1k/h3QqsxPp9pWDUA7bAcInaj4eWgE2B/Xq6/h/bZTZy0xYyo//DnA+USaWZyXXeSNqgd2I1fWhFMOt2oeHWghJoIgS/yYupk7RGImcBV4JLRkQHgsSaamEMJAEL6celqDNjky7Oto8trqKpV7gsH4mUbPjBwhJaDVlMDlr6L0JZutyEVmyUSLb/SJyQNMahaREA8G+8feL1YelaIDx4piiF9al3Cl67UU+yzIXL5MyYibA7MB72I7bErqbAazGz9gfp1NEJ3Wjxx+C5FHzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFSeNqHzIMmqfoq/yXYweZIkTjdhcmZi5AR/wTJl0fo=;
 b=JtPFYr5/WjRSSf4FTtsiaix9QXgXDS5v460rAt8wGcgtKV5sTf7JumZEvoqXacChV4Wwxxbd+QfiKL1g3bJP7t4P0KFHvqJYEGAcZPRct1825F8+Aq0i3cJDbyusRkVlaiGSVBk35ZWblsheT9GLLv/NqozMT4x8iwoAMlBnvFtmFdkLFdBzZHL+l8IG6NC0D1y6MjZPE1XVdokidQzoDapgDaoTTuENtNNdwKbwlB2giplPJkjTobMQZcNqTDo+nRL434NGUQWQxBZBSobJ1TBiS43gqZcdP4FisZ2KPCOh9xMIvIYmU5c20yTBdbJ8LSjpN/Jo9URjRy7E6A6kfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFSeNqHzIMmqfoq/yXYweZIkTjdhcmZi5AR/wTJl0fo=;
 b=Q7GvAiWLmtaOxBGF5++qxgTpwaeYEXM1EA9er9jktjNq4s8TOCLguwn3Fm4FSYIjxvEZQd9bg8QifVXVRnPyprxYrjY4kYLnGiaSJi5EIfahtiwWmwn1nV2cbOzoct3eZhNesYvNMcNVZlDGGnnvbwfnk7q7OcCszrW+rLIKtdg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sandeep.Singh@amd.com; 
Received: from MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 05:14:29 +0000
Received: from MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::3963:fef3:d764:bdc1]) by MN2PR12MB3598.namprd12.prod.outlook.com
 ([fe80::3963:fef3:d764:bdc1%6]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 05:14:29 +0000
Subject: Re: [PATCH v4 2/4] SFH: PCI driver to add support of AMD sensor
 fusion Hub using HID framework
To:     Sandeep Singh <Sandeep.Singh@amd.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        jic23@kernel.org, linux-iio@vger.kernel.org, hdegoede@redhat.com,
        Nehal-bakulchandra.Shah@amd.com
Cc:     Shyam-sundar.S-k@amd.com
References: <1582779537-25662-1-git-send-email-Sandeep.Singh@amd.com>
 <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
From:   "Singh, Sandeep" <ssingh1@amd.com>
Message-ID: <33a1ba86-de83-a9c9-2f36-093f8c036e0a@amd.com>
Date:   Mon, 9 Mar 2020 10:43:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <1582779537-25662-3-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::26) To MN2PR12MB3598.namprd12.prod.outlook.com
 (2603:10b6:208:d1::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.136.6.166] (165.204.157.251) by MAXPR0101CA0040.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Mon, 9 Mar 2020 05:14:25 +0000
X-Originating-IP: [165.204.157.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea6c44d6-8c6a-4dd8-4e33-08d7c3e8be32
X-MS-TrafficTypeDiagnostic: MN2PR12MB4392:|MN2PR12MB4392:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB439208B6F3273819ADE8C299E0FE0@MN2PR12MB4392.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(6636002)(6486002)(4326008)(2906002)(6666004)(52116002)(4744005)(53546011)(26005)(2616005)(16526019)(316002)(16576012)(66476007)(66946007)(31686004)(66556008)(5660300002)(478600001)(956004)(81156014)(36756003)(81166006)(8676002)(31696002)(8936002)(186003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4392;H:MN2PR12MB3598.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETnAN4uaq/ackggtemMF6sVerHiJhsKuNDjhVTz7OcLjuzDXfhgKKXFqydcPE/+MiKvQ53CKaslp69Zs8qekYmttHar3TdBuFJhK5fJvt69nZVvw7DQ0ChRh20GqkVFjnk+PH1OwJVqvpG9IUFZmwnhfkBO9DL81/nANeImaCWrsLdJGIhYn7Rq6fmitkvY9HJ7lTx8TvefySgoeMihXgsqn4LFk24lU+Bq7yqDuIrMflOqVtpDtnjVEMjEbe1bpp/MK7P4GAJ9Da6qRVNebLlk9C1N9sBM2qxCMtONXi3Ba29+h0WVNnRotNi+G0tCd+Pk/YtyZktNEOp8DqCXiSfIQaVl3EaVMaRUxkcxe/PN8OW3ukHWRBNO5gqN5atNWv6HenMQ7CmM3GvzmhREl48lfIZ1QTX5OnbCqwz9pJkoqcb58z6X7GznSuvpGhbXWXqzVnt2xfLBnFH4TZF7OaANAjX92oe00QOzwjUSwVdp0YCJ+VuUGEUXH+cd9FkPs
X-MS-Exchange-AntiSpam-MessageData: zLX312llIkmobMeZ6haAJUcIiNdvUTgf/uv+tyI5blygbeLd/4s0c4lJgDL1L8iNVPAmKKmZ5fAvnh2asdlp1bCMP36DNZPj0+nTpVROxFBjmN9c5xi3iW04ECwYfgGCIoNXEKqQmnne1deD8vedVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6c44d6-8c6a-4dd8-4e33-08d7c3e8be32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 05:14:29.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEQJuh2qJpLOrAarUeCtyYQ8s7/wEMItz9hVJfnfeoqI1hik0jPjhMh10UFgBJ0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[snipped]

On 2/27/2020 10:28 AM, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
>
> AMD SFH uses HID over PCIe bus.SFH fw is part of MP2
> processor (MP2 which is an ARM® Cortex-M4 core based
> co-processor to x86) and it runs on MP2 where in driver resides
> on X86. This part of module will communicate with MP2 FW and
> provide that data into DRAM
>
> Signed-off-by: Sandeep Singh <sandeep.singh@amd.com>
> Signed-off-by: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Guys ,

Do you have any updates on this patch series? Can you please make some 
time to review ?

