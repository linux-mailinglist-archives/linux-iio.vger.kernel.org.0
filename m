Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED843460A63
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 22:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhK1VwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 16:52:15 -0500
Received: from mail-eopbgr40127.outbound.protection.outlook.com ([40.107.4.127]:56735
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236303AbhK1VuO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Nov 2021 16:50:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xxo2MWWxG0PdmxZ+TktntZPdidOjUJhcvoSps98W7Iyd5rgkXKWojME7xcjsikAa7p9QBIAgm6eSGgL8zr67Gv2/hQl2cK71NmhpvlV5Gns9i2IOrmS1XfzAEpw3WLwu7tpHVLkSrHNSId9nz4Xen+HsRsY24nhRPfmpT4s8YcpH1C3sYhlQCAkQDP0pFBFrSyoXLZ4eEw8GjHYm6OtEQfwT9wz0yy17rUfDKu6LrmR3J/IEwZ6iVhg29UE97BzFDlCN30vo7JD2kwwGQ5N7/EU1dqCKDIjWlNUCdu6SFl0IfhKC1WJvzan30+pOxKu+myYPwS33BOyTA7aaAPn0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWZ00BWaDTfMYcwvQaEWBNfI4c4i7OjE/wHxwnJ7FFY=;
 b=lC2R5zIv/lhXxeHDm96hwtCvq7l38TrkL0wmXoZXWkWo/kqlTDN+ZX9svnH33Ex0HUhM7PU2KiBWKIgHaiR3h3lVYkVeSjRIIvhVnqPXZQyOfu0QUgsHmOT/HZ1IHhD5nuyHIEx9GVhRMd1Ze0h1rywBunaaZIg2H+B7lKuOr2H6NS+CLFODKNdwKAgDii1L4lBXw25gWDjLOcH7rkUVjpfNkUGtD/Fzbq2dr5nGrZen5mErPMjZQLMUAT11vc/5IvCkc+i2CKOa0UIkq7cPLB2LAE0oH2y61gk7/IWILPCOd+vYmQjD1Qs8ItyRX77DvN8z32vFmErnutSzfMy8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWZ00BWaDTfMYcwvQaEWBNfI4c4i7OjE/wHxwnJ7FFY=;
 b=TpLL/MI9t11kqIRTEI4WwEqZgl4AwByKZJcyM6dD7cIuzFBOcrnLNuIyc5ENciJX936OtLf2IMHRlwF0ZAg27HD0qIwkS1Cul5ZPY/4JhHQU3SbqbI1zhJ201++XFEhYnyhsos1TrZN9acc42ZCU/VTHhdQ1vzjkbvQ7fp7WIo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2392.eurprd02.prod.outlook.com (2603:10a6:4:37::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sun, 28 Nov
 2021 21:46:55 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Sun, 28 Nov 2021
 21:46:55 +0000
Message-ID: <76bd70de-2ed3-cb14-79e0-37557b31a8b7@axentia.se>
Date:   Sun, 28 Nov 2021 22:46:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 03/12] iio:dac:dpot-dac: Swap of.h for mod_devicetable.h
Content-Language: sv-SE
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20211128192635.2724359-1-jic23@kernel.org>
 <20211128192635.2724359-4-jic23@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211128192635.2724359-4-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0056.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::10) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0056.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Sun, 28 Nov 2021 21:46:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f57f5ae-79fb-4715-53f6-08d9b2b8987e
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2392:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB239202715B1B042EA3026E01BC659@DB6PR0201MB2392.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrtxFC1owp4NNo1/GxeIy0/3MAA/UHAgkPeXZzq38e5hh6bALEe5tH9Q7hBbMvnM4ie+cGxpYefC7zF+LzmeY14sc/VzcfWpSHOPanZoTTba12CmsGZvlz5oq8srEe8Gbp7Bi5oeOhp75aPjkDzTDa9ruTvcnoKR3g5eWYtAVbfnJDHcTFrEjnuFbRQNLI0mqRpzFJqVkM/VcUsLej73TAddVuENo8GzpVvmZLUGiXGB7nTfS4AaD7+6EJOpyAS45f06hTTISa+5qsKOFWN1R0LMa2lNRxF4JuFJWwgPumWujYQDFN9wV5alMS33LWwdExeQL1zC2U4GXjDRYtURs5NmNnk1DRed4rPsrXYvvN+WRoIs6R6SeWinTj8MYUCcAaXAZhSwpejcELsU6FDWb4Ew4XLGV8hV9gGVqlA0lF1zPEUDzq/02/Ywy2jNpMgd2A98CIM6g7Ol9B1Qm6dHYElRgd9bNUsAhI3KyznPBR1FxKoyiGpOoRqP/2p9TVOILF0JSI/l638JVmTpi9hvZc9kySH5dXqFPll71sMP0W+urbQpYt4MFfir6k+Q+HY9AzjXropjmifEbIi4T4qz8jbxgMfZLupAU/sH7U1L6tJofgpBzM52WVapx9DSC0p7lTbVppYNwZIe5fztEogrccWIhW/9S3GDL3S7RNlRCCAtr2bIZmlVGofHz0D9qyUvTLdP3wG5VgH8i3moBhKo4RZAE87zxomI+0XpCAaG4jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39830400003)(136003)(366004)(66476007)(4326008)(6486002)(36916002)(508600001)(956004)(31696002)(26005)(86362001)(5660300002)(31686004)(4744005)(36756003)(66556008)(4001150100001)(66946007)(186003)(8936002)(316002)(53546011)(16576012)(2906002)(2616005)(54906003)(38100700002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aElZbE5kTjZZZFQyaXZLMWdaa2YwdHhBNEtKM3lFU2t2TnQyNEZUT0pzUzFz?=
 =?utf-8?B?RU5Zck9NSmUzdVhiMllhNUlwcEl2eEc0YW50S0FtcVFQaHNvM0JDalR0V3ZQ?=
 =?utf-8?B?dkVldGVVbW80ZkwyZ05UdEJEL0hHR1dHdkJSclpYRWg2aEV6a3FMc1NsaU9U?=
 =?utf-8?B?R1UvaFdMSXRLTXNPZzl6UTNCaVFBb2JMNEx1VDkySUtWNmpLanB2elJ2MVZr?=
 =?utf-8?B?bk5peTlvUjRIcGplU3hxRm9mcUZaTkhMTXdGMlEvNWt3TzUwUnNvT3R4b0RL?=
 =?utf-8?B?Nlo0STRsSEp2VFBYOHJYa1RzclBQM0dIUHA1cEZiSFJaMGpHSi9pdlUxQ1Zq?=
 =?utf-8?B?RzZFTGVJaXhiblJtdWc2RXpvUitQZlIwcDZVd2h1dVA0OW83YUlkMmM3NDcz?=
 =?utf-8?B?c2tTejdyN0RJK05JRklPSldYM0JzdGFNRTdFTEE4dHh4YThydjRoNy95d3gx?=
 =?utf-8?B?OHBXMDdWRTVrSkNSV2VYRVFXOVlkVFppM2NVcWNKNVJnd1VQQ2UrdnZ6NC8v?=
 =?utf-8?B?Z1VyTVVtMkIrTXVFN2hRczUwU2twWUp3eS9sR1hmTTdsdlVHQkxXMkxEZmVZ?=
 =?utf-8?B?N2dDNU1PVm0rUHNzN1oxTDk2RFRPTmpSUEEzY3VaMHBQWGFlUGMvaHdiMVph?=
 =?utf-8?B?emxST2c0NFVtV0doNlNzd3Y5ZTBoVEJ6SFZkS0tkZDMvTXM2RXF5dDIvZVB6?=
 =?utf-8?B?NjNzTjdIeUwxQUlFMGFlZ0JDQ0VlVEFUSnhsT2d1WDd5cFdqMmVvYXFqbi9I?=
 =?utf-8?B?Q3pEVDVqajFpSjE1MFd0djhzdHF5c2YxeDRNeFVkZlZKOE5JSWxZVEhzZU90?=
 =?utf-8?B?eXExcWxwTUsrU2JweEppNVNIbUdIb0NTeDZqQVUvYWN2TGpabE5JcWh2VWpM?=
 =?utf-8?B?ZWpHcFhtYXM3Njg1aWtpc2ZodDIvNVJDZ2s4UFBhZllLSmc1VkJ0NEMrSzJ0?=
 =?utf-8?B?SnFvZElUUEdwSm5neFN5Q25zdkZ2RUZiMTlUS3E0OTlkSTZYVXJVSE9UaWFT?=
 =?utf-8?B?WjMvSVF4Wm5oVXNjZUVOeEI2aDFBSDFZUDRDMllQenhYTmgwZFl6WkJNNC9B?=
 =?utf-8?B?dXBMZmF4bWxGSDJIRm5teFlmYUkxdU9lN29jYU1NSm85YWVMaEJxWERrNmNq?=
 =?utf-8?B?bUMzMXhTNjZ6TEFxSlZKclYvUUFEUE5uVHQvZm1PQ1ZwNnhPV0hoWXhKUVJJ?=
 =?utf-8?B?dW4rZ3JpQ3RwelpNOFppMzNOVDBhSUtRdmNaVVI1MGZpSnROSUJOeXVDODRz?=
 =?utf-8?B?Q0VGZnlUUEtWaVQ4eU95NS8xTUtDenVzdTNtT0xlc0RjMDJ4TmhLSzlYUys5?=
 =?utf-8?B?UFdxdm5oa1I3WlBCbWZDY2pWUjJQdmo0dnI0b1g2bGdLdmJpcTl3TUFIUEo2?=
 =?utf-8?B?WEtEVEU2eXdmbGJoZXljek9VcXhLdXIxc2VGRHhWQUdqZ1JZU3ZZaXNKbXF5?=
 =?utf-8?B?cmxBUTI2TEpsLzhBM2pVMGNSR1F1RWtqZnhYb2hScWNxZEhtSEhrU0RVT1Fm?=
 =?utf-8?B?U0dLQ2tOTkMrUEp3TWtNVG5Xa0c2ejROeWgxc2ROcXJ6TzVrMGR4cUNoOWtX?=
 =?utf-8?B?WVM2dHFZN1BEeXQ3REIzdFVjVmlPU0pibmlMVnkzaFB0V2ZwbjJrazE1cGNX?=
 =?utf-8?B?V2l1NkJGYm5mNi82ZmZzVDhjZ2dlRlg1cmx0SnFxZk5WYk5XOExjaS81WXoy?=
 =?utf-8?B?UktiejdxS3NRZTB2M3drZFNWdlVjU3NRUzhURVFBUzZOTTh4MTFqM1BqQ0FE?=
 =?utf-8?B?bmdSM2cwNDl3RVZweUFLQjlJbXp5MGZvY2hpTWhSZ1ZWelh5NTBsQSttUkpi?=
 =?utf-8?B?bzI5elF5d2d4SmpXRGEzcW1ra1BYbDRLY0J2TTZQUTAySFpQUUlVcm0zelRh?=
 =?utf-8?B?elVMcVRtdlpMZ2gxYVAvVVJtK2RoTWtvS25rSENFNjkwZHdrZHVmWlVzQThQ?=
 =?utf-8?B?a1IvTm5FYlo1cFVvMFJJWXU1c3E0STQzNTl3dTl4b3F6aXNwamZjTVQ1OWY2?=
 =?utf-8?B?Q0ZzdVBaR0VqREZPUDRxa1RMNDhrT1VoQm9KNkxOTzlqRmlWRkwra2lVc2ZR?=
 =?utf-8?B?QUtYNzY3RzlxUGk0MmhYQjZGSzdwRUpFNWRCOFc1N0ZNemNvSm92M1pjZzJY?=
 =?utf-8?Q?hr+E=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f57f5ae-79fb-4715-53f6-08d9b2b8987e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 21:46:55.4046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huOEOLY9/5Q4dAyefe91Ud9bkub96/aeD3su7sZrr6mPA8FssqbdGh3KN3yOBTsC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2392
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-11-28 20:26, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver never used anything in the of specific header.
> It just wants the struct of_device_id from mod_devicetable.h.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Rosin <peda@axentia.se>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
