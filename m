Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0431864FE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 07:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgCPG10 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 02:27:26 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:23490
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729581AbgCPG10 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 02:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wweOoA+HHMR5KlVVai9C2wHVk6uTz71eluIgPS2VsdY=;
 b=SqZQZCEext56vwzpGwPWkhVJKdQCxiJBJLO90Y7IzszkrqeFNyECNepAHDcaGnQ/uh+SjL0XHTLmv5EpEv5iVZ44989IGSMmsLEFadqO8WyPNR8VtIY01WU77EZApwIRJGVj/EGj71vMrMMrrp5ziMlIhDSKiOMwrIZnepztZro=
Received: from DB6P193CA0015.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::25) by
 AM6PR04MB5512.eurprd04.prod.outlook.com (2603:10a6:20b:99::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Mon, 16 Mar 2020 06:27:20 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::c) by DB6P193CA0015.outlook.office365.com
 (2603:10a6:6:29::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend
 Transport; Mon, 16 Mar 2020 06:27:19 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; pmeerw.net; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;pmeerw.net; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 DB5EUR01FT055.mail.protection.outlook.com (10.152.5.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 06:27:18 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.107) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 16 Mar 2020 06:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XC9UNPhl7hHeTDeN/Ei8R1WN9kcg6IIBlI7YF8xLoFR7EUzafi04a5OQejvaT2Oi/H6iONVvyYKOWPwooYyo0WB9V/YaIjPTUfzv1H3cgo6aMQ9sP5i+WJGUmQ0762DC/U1p8/8HMUL8Ch+S3xt4Y8kn2DWQbfTl3FQfsjFy25wwwQD7DrHqcUfhqZRbfTE0JP4XtL8aTAkq43Icty9gI9O2hyDBg5lcXrjdjegglY9kHDwDZtP/NCrbfnEOKezuEutV5DeXMjv1+r1J2nUA0S2KC5QbOfi+uBebgp5UbU+y7fEriP1vhCNoQA8PujOgqLNKxIRuARx5CsK2GykZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wweOoA+HHMR5KlVVai9C2wHVk6uTz71eluIgPS2VsdY=;
 b=W+NZ3ltXkhL1yFlndLww/5nlJJ55Ye4BqdZRTmL/LI6yOSLgvwd/XncoTRtPR8q0aruqprKMIvQUaGgBi3kTSHcSmBne5g0d7TZmjQBFKuQyBMQLF9FHcHnWy3ZK/3t4FeOQxrKDtD1/6NhH8JMsBumSQjeXTClj/xHi1WN4i27HDnret0viGmFAdQ6pVETPrhrkJ1CkbyQ5aqICXmvajK0yHJIBsOEbFm5fZBf0bFrcH+6KDfiOMiqcHtylNW9wr4TSyy0kubv+9/++4bwBkO27TfC0XoOt7x+9VdVCQi3DnmGB+vuYDdKLbYrYRH6UOjFR/yt6OBy45slMXh/PVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wweOoA+HHMR5KlVVai9C2wHVk6uTz71eluIgPS2VsdY=;
 b=x4fwsdb1vc8NT7mSkRbJP7sscjyOKgr/a1x+vsePRdZL/pInXnnGH75Cvpvs9fppSEzlMJJnXD+YuAdGw5jzkWmAgr7mm9ud5AWgGiuhXdf7c/sWYbLfLfzDMk5lWgt2ITOcF5Fa/VtSCvEvHICD5yuTrhu27Zdh2AZVG/ZS+Gw=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3882.eurprd04.prod.outlook.com (52.134.72.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Mon, 16 Mar 2020 06:27:14 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 06:27:13 +0000
Subject: Re: [PATCH] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
References: <20200313140415.20266-1-mike.looijmans@topic.nl>
 <20200315120238.18c10af0@archlinux>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <cba4a7c9-68a0-f268-bc78-ad6ab07fc70d@topic.nl>
Date:   Mon, 16 Mar 2020 07:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200315120238.18c10af0@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0049.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::26) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR02CA0049.eurprd02.prod.outlook.com (2603:10a6:208:d2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend Transport; Mon, 16 Mar 2020 06:27:13 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38caaa10-5c34-4986-1db0-08d7c97313ae
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3882:|AM6PR04MB5512:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5512A7FD6E98AA6AF6F9981096F90@AM6PR04MB5512.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(396003)(366004)(39830400003)(136003)(376002)(346002)(199004)(81156014)(2616005)(81166006)(8676002)(956004)(316002)(26005)(8936002)(508600001)(31686004)(2906002)(44832011)(31696002)(5660300002)(42882007)(4326008)(6916009)(16526019)(186003)(52116002)(36916002)(6486002)(66476007)(66556008)(66946007)(16576012)(53546011)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3882;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /7WA0Z0IpxHCK15i+TyvcBdzT1IlYP3tmL/ODFqKJ9lnlZ0vhRFgCUgj2gaC5y+GibkQUxtD4VD/9ojgEPBizZEGpW8tagbbWXnrcSQn3sI2EBFL0yS+cyDmNZOL6epqn6loi3ym2xtHNBoxq0PzAwhT2h9mS/0IoHa+VOKs5/lLnA1Hac0T38eOjRKukflLhx0Jf4L+k/IbLsIdSmqkS7IfCAJM0rOBXwEno9wi+zuUue+tlzszkB7bP4ccE3vk2R6T/ex9r7hDh5yDO54SkW/CnX6DMBO8JRFVHi1zS1Ko9RrTtgmLtDopFKQCLqueJdQq93MhRwUXOiK2S7ZwCOnBFiNj8H5gKbx/GhDGmPmtUhamPAyu2Wi95impzkh2wJvPKgdoSzaC22UWzpr7LjgtsZub+Oy67CgYnGbDerAWI8slWubx9xUV1McWCRcx
X-MS-Exchange-AntiSpam-MessageData: 2jG4XdRTRyrxP27b04Ff5bwey+BGd3sr21AGBBLHAHiNoI66uT/OhQq06P8/Bf32HKmfMMT/Ao7PxOmaLRdx5ygFdU7v1G6ddTeUQ1WK+Q5R6cQVw8Se7ks0+Qqd2yfipwremYwZVuB42xH2192zCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3882
X-CodeTwo-MessageID: 37af8ea3-f726-4300-a197-55172622b90c.20200316062715@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39830400003)(396003)(136003)(346002)(199004)(46966005)(356004)(4326008)(47076004)(6486002)(5660300002)(7636002)(7596002)(70586007)(82310400001)(53546011)(70206006)(36756003)(36916002)(316002)(2906002)(246002)(31686004)(2616005)(956004)(16576012)(44832011)(16526019)(31696002)(26005)(42882007)(6916009)(186003)(8676002)(336012)(508600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5512;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7a702bf4-07fe-4504-f5b5-08d7c97310c6
X-Forefront-PRVS: 03449D5DD1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJa59KoLpuyztm3jhFXRkklb79xs0bvkRHGudbTCRAVUEa9CW/wHAOYOVXILBjl4gkEo+zIbSA0puy4pFkAVcWsV5Up1EOS2ak/QBvPul2TU7ikr5BRk9F9XiF7jQwAvaqWA8FR0cZcHv8vfILy7JY8n2/u4/JVP/56iVDL2ilBNuOFxs9SGV0pZy3vGdRU59/9/heU5mHjKSsb/AZbi3JkFfvWrUoZoCpxBvv8V4b//TMVjk8s8ZoY19O6ocdjgK++r/9OEDU/VyiTjsXRnxf9DQ944Flrx292zV5mRG9g+O28RMhi9iqMQvulAqbV5J9aSA3lClMxkwufe7VyEXAEA5gBbkoADYajYSUox55Ew3fRNMzZ838I5c8rARwfcWDNNDPVPbeVvxvvF6r/ZefqMr5RPvdG6Zln8GYT1eipPzmlThz10hyV4bAF2mowwSEUVPearYk/kSzUva8H91fiKNnYl24y78ibYBMS6s6uu1MGIRFTyzWPAXrewjfjMlQqtdTzFMEp09P8wt7lrJg==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 06:27:18.3601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38caaa10-5c34-4986-1db0-08d7c97313ae
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5512
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15-03-2020 13:02, Jonathan Cameron wrote:
> On Fri, 13 Mar 2020 15:04:15 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
> 
>> The BMI088 is a combined module with both accelerometer and gyroscope.
>> This adds the accelerometer driver support for the SPI interface.
>> The gyroscope part is already supported by the BMG160 driver.
> 
> There doesn't seem to be a specific compatible entry in the bmg160 driver.
> Perhaps we should look to add one?

I actually have it already, I'll submit it.

> 
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> For a modern driver I'd normally expect to also see DT bindings.
> How are you probing this?

DT bindings, should I submit those as a separate patch?
They're pretty trivial.

> There is a lot of half implemented code for features that I assume will follow
> in later patches.  Please rip all that out for now.  A simple initial driver
> is great but must only include the stuff it actually uses.

I'll do some cleanup, didn't notice that.

Mike.
