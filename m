Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC05395699
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaH7m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 03:59:42 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com ([40.107.5.105]:45791
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229640AbhEaH7k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 03:59:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h72UvgSDFXR2z6R1UmkXh75pnPwycKOC/U015azwM0V/FP6w00sIk/lD6wmgiKTAJEkw/n4txwm571Cql1ihDFKNrH5vNDUqTkkfXtq4OsedJJ9P4ODZQ4HcnQtOImHLtsC3MLtVPH1QWXDqR9EfEhe5TQcq4/gL6qYXkSU7e9NRrrLL5FqL40FZvtrqavnIBLh//tlDR6xOjD77R1ZG/73E3CDUpHYTm1JTCGDsnXpRBytdk6jY+Fd5o6ZTxMsNpn7hfksBT+T8HaE6VnPTzM4PMvEWXAogKKL3gejw3EHfzgnr37MD6Bsemi9Ocig22QWrydFM7bFmoPb+PdM4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEM5IEfMmiD8YOwQSCK+4FOYjPVp4SIrMPaEJV9oo7M=;
 b=fYRgef7Zj6om9ClbcEpfdBoXLX3Wp4n2zXKS057/PlK9Sx2W3mIojDsxeegkJ3cXJjUztL7/KHmzMZC/T6JxzjIFQBnFSx28VpK5soRRnzZ9R8RsABpBooyO2qvQ2KsQTdNqylC6NWLu0u1tF3yQXhlzN8t3+NecePKX1FMA9CTTP7aYr4yhpqBjjEwD53Ueg2weXUrn5q0PmLEvuFHSRkeFDq4NEyDhIauzf2qAM9DQmJefoq6/1vts+h67R2KBiJ9uTUhAqzHGd85esz/q4NXxrrdC/mzHQLIeprCBgIZo6sSzV0gNgyopqfdrue2Vpt39M7n+s2/5tcHHS3CWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEM5IEfMmiD8YOwQSCK+4FOYjPVp4SIrMPaEJV9oo7M=;
 b=QLGiaZx/Imb+tkpaa66A5ejDjw33YlCes3wxe8izKBhLEARcNzib1j3VQpfaTTQFj8FzSVCcVv2d7IN5W07ea/4oWjLL7slyoNUbIz0gt3Zo9LNkhWsSLkhZynTTy2+eYw2PndTGDkIfN/CfmBqdhqD9gNwyO/s5Su1cIlIoRTU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4476.eurprd02.prod.outlook.com (2603:10a6:10:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 07:57:58 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 07:57:58 +0000
Subject: Re: [PATCH v1 6/9] dt-bindings: iio: afe: update MAINTAINERS file
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-7-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e33ac217-7c54-a76f-911d-b811a6f24e2c@axentia.se>
Date:   Mon, 31 May 2021 09:57:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210530005917.20953-7-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::23) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0701CA0055.eurprd07.prod.outlook.com (2603:10a6:3:9e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.12 via Frontend Transport; Mon, 31 May 2021 07:57:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77997bde-4036-4ecb-c551-08d92409ce2a
X-MS-TrafficTypeDiagnostic: DB7PR02MB4476:
X-Microsoft-Antispam-PRVS: <DB7PR02MB447667E5331F74DDEA0B0468BC3F9@DB7PR02MB4476.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wviQsLA54Em6kp93oNaC4hP1XY6JLaBvihlkuAt1/jrMG2l9GJOB0Na98yUlMCAkU/a/Bs2fim6pH73E0iFaUyVKsxnQbpSkWqUitsjMnvK4qYTt5Qc8SOIv/plg9o3vSUbcu5U33ymZQ2q3SeCRMymSBDooZTh4zaVvH34SRSCn5nyJ8tbe084Bqxi15r/0HkxV9vfyaORwSliDCRlz9SSWARGpbh/egqGP/vuiZuHjS8286kqRq5BfOc8mp+0USLY0O/0OpRYa0MQFI3GWjCSjCDz7toTqeHXt3yUiDKZGmE21WjWnGRedaeXisdtFPcFNwb5tSytjBs4abmPYdmGQZXXitpaZCRK/22JPtGBds/A24wiOJq8+R9bDkETcLkkpvJSYddgZPij11ugfIrnVfP5gOJ6zi0t5ABDPzz1SCuBsI5IEJTPM1M4uFaq8B2tZQuu7Pc5aZIKNGIYBFdQ58e2g8WfO4/9Gnl8PTGjIwqiz/RbKnJrBGsE4eOlcIfIvNO1KexpCAd0zbnvry8F1akTR2msITTMZbnJ2YtveDTjvQrwkvYcsvFz68qy/8cTeSwMQPoRoY23mbA1jJWCggd90Dh0IbNYJ5fyivwARIHT1DbuIMSMOtiumYtel86P7P6QNq9Waf7ziIE/hJTsSbt0YOrURzIIZZtS2m1ZIVTGvJHMsI5r+/ziTlvnB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39830400003)(53546011)(6486002)(8936002)(186003)(16526019)(36916002)(2906002)(5660300002)(66476007)(8676002)(15650500001)(36756003)(4326008)(38100700002)(31686004)(83380400001)(2616005)(66946007)(4744005)(66556008)(956004)(31696002)(16576012)(478600001)(86362001)(316002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1JXVDZLVGhLNnpLdW9IZ3NlbVdyTFQrN2llbGZrd250NlVCTGVuYkdTRm1K?=
 =?utf-8?B?OHRsbEo3OFVEbUdYTVA4bWhpdThNVVRsMWR5L1BuSytTM2EyaDNnZWdFVmVx?=
 =?utf-8?B?NW16U1pqU29pSDlEOTdQcVIyRlI0VnloaHI4azVzekxQZkZYWXc1V1Y1a3NI?=
 =?utf-8?B?eXJ0eXRBRUpXMmVOUWlwYVpNWSsvRVM5Y1gyY2g5Q2xJQ1R0Yk5rVGVnZENj?=
 =?utf-8?B?Qms4bDdiMTBtdGlWdnFIWVdmZHJqVkxVa1JZenVJNWZjRXliYlJqYmpsOXNk?=
 =?utf-8?B?N2YzWWs3eC9wQXM5aEdoRFZ4N3d3YkR6QytYdWFoeDJNbXZUWVRPZEd5UFpo?=
 =?utf-8?B?NFJ6NzRNZE5wLzJ1aUdsdFZCTkwrNEpBd04zL1IwbkU1WHFwM2lKUTAwMkcy?=
 =?utf-8?B?ZFZLN28wRWxqcnBrUVUzSEE2NjcrUzZVNVdSNTlFVDFsVUExOVNYY2VFbUhr?=
 =?utf-8?B?K0k3R1cxRStsTDFUdzc3NjVacGlYaG9Iem1pbjQ5Q2xmYWJLaUEySmxaTzNo?=
 =?utf-8?B?T1paN1FjaUZBUFQ0WU1sdURiT2NlejNXMU1SNWpFM2hWN21QdVlTWFBiWWFW?=
 =?utf-8?B?NWU2S2hsUmR6WWx2QittMFRUd1FxK0pSdEdKeGpZSFBVMWJQS09IQWliMVRZ?=
 =?utf-8?B?M2dSdHV5aHBZWEtwVmZGZTY4dVY5VHlUOHNnVGg1RWtGRUpNWHAzdVROemxN?=
 =?utf-8?B?Tms3eWtGNUZNMHVsZzZMYnNRYmlIam55c044TGZ2S3E2bGdHeXF3Yy8wKzNu?=
 =?utf-8?B?ZzhacUtaYlJVR1I1ck42Y0pqWUtXSFlSNE9QOFB0SlZIRmczWXNRMW1HT2Zu?=
 =?utf-8?B?SkwvYjY5Z2F6bHM5elJpa3BoeEdjd3cwWm5RUWw1UU1XT0dlSVNFRnZ0QVBa?=
 =?utf-8?B?N1V1Tmh4bkxQMjhIZ3ZaT0QxV1ltQ1Z2cXJhYWVkaUNJQTNzSW9FdnBTY1Ur?=
 =?utf-8?B?aGt5Z2ZpdStEZkRJVTkvLzdNN1FvQUhhcnJZdlJtWThwYThGUURYUHlpWG9E?=
 =?utf-8?B?VUtzRFlaT3hKeUJjUC8xYWlBMlhVM28xTC9hVCt1ZHJMaHNvL0RCT0ZSWEE0?=
 =?utf-8?B?VDdCQW9IdlMwSUQreVhKTlRDcW1CSXpJb2dMa3lVQnVsUVYxeERTYjVjbi9K?=
 =?utf-8?B?eDZvVWx5YTBjT3o2ckc4aS9RcHNNY0t1cGlUSklOUnJ6UnFFaVVKeEVWbWdO?=
 =?utf-8?B?QVVSVzQrdWIzSU9tdTJjMFp0QTlCci9CeUFWamVjaWJLREcvdUUyTm5qcit1?=
 =?utf-8?B?eU53OFJua1A5bVZRYmlTMG4rQU1PUWVYZDJBOFpZelluSXExZ01tUEpwWEFj?=
 =?utf-8?Q?Rc95/qaCv9?=
X-MS-Exchange-AntiSpam-MessageData-1: Td202h+rDkg7XUmdttUedca87+SlXYD+gpLHFb6DTiuz34d9DlVpEAc5iXkIP5QwPtolzkveM11ZFbyvZ17giwk4pTkQw8ItJFZuU3NEp/8XYCxtHPmHDPS6Y7Kj6ewxP2T9IOEW/RmZmBMG2BBsR/gOIxLg+nTLTpIwUTvlfXNlAUxlZMuxupK/MZnuKlKwF7EE+SkPhQvZqN9d70hrzMZOmzqG+pUYcp4Ls9UkkLl11oCkVqhXUu+dPbbXdrtzwdgedGVCxPynIHCCjocjk42DKLQdtdQVmrSPveUtF1PKx2YZ19pBYEsEDz+d64KLV8thb1G0R4pmsXybxi40jNTX
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 77997bde-4036-4ecb-c551-08d92409ce2a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 07:57:58.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3M9i8JoOu4chBPitwgMzQwWFAqDQOXxWtsY9f+RfyH6PEfc5rAYWmlC6jYny+8Th
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4476
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-05-30 02:59, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> The IIO Analog Front End devicetree bindings files have been update to
> yaml. Make sure the MAINTAINERS file matches the tree.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>

This patch can be dropped. It was fixed in 5.13-rc1.

Cheers,
Peter
