Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA2331353
	for <lists+linux-iio@lfdr.de>; Mon,  8 Mar 2021 17:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCHQZO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 11:25:14 -0500
Received: from mail-dm6nam11on2109.outbound.protection.outlook.com ([40.107.223.109]:62592
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230078AbhCHQZE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Mar 2021 11:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu4vKf1V4gftVcybzAjvOtA/avUya/YorCqrgT6ZCKeZUuVJeRUeOcbj72MsNWjDazFtOGOQjzV3CicsIWWZ8zyFVLOGyKrMIA5liBvWxgkQzVOcdSEeU/nLJzyBP4fe1dLcr0CfEDmhKvRcG0KJZ/sy/Wq6xyrtL3daQvfu1gRmoW1VyatTiJ/idpw6RpBh4MTgOkttjB0rZdbOXnfGZQtzQSWpIthtFcVBzh+WhSD0XV2yi7xYj5jHFAoK5Z/Gc9F/UFwTd+5ZO9X6vvsFIet/Z/93trDTSxeqtB82/lEpNNvHtpdKKICdNSFyjSAxp8kDU3Qr87a3dqkXG4IXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT8zuoKXIt381uP9PD5fAJvX7JEune8YkxN9nDf+z9g=;
 b=dbWtiQ2xUm+ktw9UKUUC73JzBsqSPLGTCnvHAAPsUWWgwL0TonYxeEaruzgGgERzp6hirGWE2ieIYDmIaXXAROd8qxYA1+RpAqQVYyiNoz89EUqYmkmPgUrd83dyz8rf/64Qpx3SsHKd2ZMQrDyFdew1bw4kVsDrJSCQFvE0xbJA/rjlMJlsPyU8x/K+r0OWLzFo4JoZww0Mq05aC1JAwqb5TxvMBtpQujfo35njRewYM1+UBQonrKyVclTSMgX29s5Fxx4KyP8WCdlWIneLuaX9oxxsrfski/APzBwFAXCOVkAcLRBhfIrXTz2g9VlKrfz23asMkfmQFr9QOIN+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT8zuoKXIt381uP9PD5fAJvX7JEune8YkxN9nDf+z9g=;
 b=LAiV78Yg4zlBdzW65Xw6hEX8SmCwSra2XLNZIE3+EkmHnSC1e9Gl84dWT3cjAVfRWILZMjmv1DEN4q9b/iD1qTSv9l6npVx2EL8u/ltQA7jjzFhpzfBKrZLn+lfEX/HLRWtsggsLQHRak/U86kI5jCLo0wPYh+36VkyZ24XBIig=
Authentication-Results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=licor.com;
Received: from SN2PR0801MB2223.namprd08.prod.outlook.com
 (2603:10b6:804:11::21) by SA2PR08MB6571.namprd08.prod.outlook.com
 (2603:10b6:806:119::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 16:25:02 +0000
Received: from SN2PR0801MB2223.namprd08.prod.outlook.com
 ([fe80::6db1:be5f:79f4:17a2]) by SN2PR0801MB2223.namprd08.prod.outlook.com
 ([fe80::6db1:be5f:79f4:17a2%9]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 16:25:02 +0000
Subject: Re: [PATCH 2/2 v4] hwmon: (ntc_thermistor): try reading processed
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        linux-iio@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20210308100219.2732156-1-linus.walleij@linaro.org>
 <20210308100219.2732156-2-linus.walleij@linaro.org>
From:   Chris Lesiak <chris.lesiak@licor.com>
Message-ID: <c324e064-2795-a3ef-0dc4-0977bba1b219@licor.com>
Date:   Mon, 8 Mar 2021 10:24:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210308100219.2732156-2-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2607:da00:300:7::2]
X-ClientProxiedBy: CH0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:610:76::24) To SN2PR0801MB2223.namprd08.prod.outlook.com
 (2603:10b6:804:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bee.licor.com (2607:da00:300:7::2) by CH0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:76::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 16:25:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4836e3d-9fd5-48be-25d7-08d8e24eb945
X-MS-TrafficTypeDiagnostic: SA2PR08MB6571:
X-Microsoft-Antispam-PRVS: <SA2PR08MB65718033B9070037E4B8DEAC9A939@SA2PR08MB6571.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygZf+dhf9v8GEbPIZ9z6ZfiwwG6nX7EL5fpSc3hBr1Og2UXylsnlQbPFRUW7NqHVvK/2hWqr9GRfEnGpJ/N37GGdh2TrXeO31jrcH4PmrVheQEiALpeKfJ7Kd3oiPAxh8K79YC3gKs8hKWzg+VtlfSTfQuNhCm9/raBjOgkCA7UIQuxYZp5D5Dc7j9Ix1tRWWNlBpKHuENbtbkgsUbSBeMa1N/v92FbcRaIIr7SQqR/Gjcg6bVlN6E/fHwVFf8iw9eljqXB98Bc2pdLjBJk7I2RD1DxyUSHH00AuUA/fhPwN8cxIjJBYjNPOlQ17d+B2QmnDAa4EqyQpcPP9q9y9pbJO6T650pVKioZCiSwQFzr+odlnEow0wtu3RSE9PgEAYa3m8iSk1ceoH52P7pa2e12+3wqekAk8icSa3M+7qdiyIHHl7wMdZxggmq0a1PY3gmSFJWqg1xHg/D737dmoWDBXNFapIal37xTWE9ERkSQnggDg4KF+NKx/YxIkYC0D5i8nOZLe2tDaMZQsykFUFRP3CVIQngayIyxjEa5FeJqH5YVgFzC484t7WdfqevRNfzIGTL8YYlLSU//56scoQIYup0UZZr+/AlKGCn5tIVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR0801MB2223.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(6666004)(8936002)(36756003)(86362001)(8676002)(186003)(7696005)(6486002)(16526019)(52116002)(66476007)(66946007)(66556008)(316002)(6916009)(54906003)(31696002)(2906002)(478600001)(5660300002)(558084003)(4326008)(44832011)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MjlxYkZDWEV6TjZvS2JYcGZaMWIyaHgyeUVXOFc3Wm1IM0lDVjM5RVZUN3lo?=
 =?utf-8?B?b0NQY0RjenFDSEptZUttNkxhbTRDckc5UTFiNG5aWEtOM1pPTnZnREYreTRq?=
 =?utf-8?B?T3RzRk1IK05lRHlTVjFlb0JUc0R5RXJTOVRMekRCTGFzRTZBUGFDWEdHUzMr?=
 =?utf-8?B?Z0wvVDliYzVqMUd2NFBZWmk2RTJGNGNEYTJPbFFycTl1U2N2YjJyNDJQL09h?=
 =?utf-8?B?S2dEVG80Q1Q2RlJHVC9TUFlwUEUzUnUxVUcxV1NnRENuMlA1cXRnVDZUNTcx?=
 =?utf-8?B?SUdhVXd1RXVjek04cmM2YXZDd0g5RllPOVh2c3J5UklaOWFnNXlTNnJxQWJK?=
 =?utf-8?B?VmFmeU96TTJCQWUvdnlEQjdRZFhYVXNvbFpKclJxeFJoRnA0SjFORm5pb0VN?=
 =?utf-8?B?NUNKVlJEaENOSEk3eVdWYWp3YUJ1bkxiT0EweVpSUk01WlJkSUREanl5R2NY?=
 =?utf-8?B?NUczOEFraVFTSFpNMnRPTFlCRmdxWVVhQXhXMEV0WHpnYVlQNWhoTEErUzJv?=
 =?utf-8?B?R0h5aXVIa3ZXeGFVU0taT3hRcEZJcXl6RTg5TDhMdm9CeWZRY3U3OEZzMmoz?=
 =?utf-8?B?d1dQSGxRVTRUYkFzQUV3VVhPdXhXUk5aSFRESW9qTVFwQytCYmJNRWY5THBw?=
 =?utf-8?B?dTZidjBXWGptTHRRVVJOKzBaWnF1blc2bXRTd0dNZHB4NHdZeHdaSVpOVk1L?=
 =?utf-8?B?NlhQTmFJelBnajNESXhBTFFWMkk1M2dzdlRLbWVTOGlCRzZhWGp2YmFFdDRk?=
 =?utf-8?B?M0ttQ1RERndPOGtBUmFhYUdYbGw0aU1wUzMrYjhSajc3ZkJCbGtOUk93Rk8z?=
 =?utf-8?B?NCtBQnAxSEwxQmRRNTJsbWlueVhXbFpLbW1sL3RmWTl4VDBNWWRQZHVMaS9N?=
 =?utf-8?B?SnFESHdIV3NCWFZTby80R0pSeWE2TG9sbnd0N082S1hiaGVGSlVRRUVZMUE2?=
 =?utf-8?B?QmdEMisvUE9EbGVBalVmRFEvaXFZdTRtSkVST0JFZ1ZRTjgxaFc3QVJZT2VO?=
 =?utf-8?B?Wkd4c1VKN3d5LzdLc2dQeWdLY3hYTHVPcGtXZkZhU1UwdGd2N2UwMGxpWjlj?=
 =?utf-8?B?TmYwdkkwRFJ3K3pyVlRmMGxjQVJ0WHpoQ0dGMGtDTjA2UGR1YUxZc3BxaHU1?=
 =?utf-8?B?Nk10RGU4bC9wYnZqcGJhWjhZaGRjS2JQditubURWWWJQM29kMEFsRVZPU1FE?=
 =?utf-8?B?NDNFY0JobitvQ2EwTENGM29kTm9wM1lwaUlPUTBpQ2M2bVl0bmh4VVJ0dlNu?=
 =?utf-8?B?aXpRUGJWNWJQb1VnLzJsS0xzRXJFS1I5Yk1VV0JIeUp0Q2crem5ZbVZDZmJC?=
 =?utf-8?B?eTdGYitiWVZHcGU1ckFTSGhSRlpXL3gwU0ppRlYrRDFVbW50TmVNYjEzcEJ3?=
 =?utf-8?B?UEo0emg3WitUREoxR0RZNjdZWnQrdjR3dHlvSTN3M3czNEdKVnVZMzZlZ1lS?=
 =?utf-8?B?U3ZlaFZ5ZlRCOGt2MHNVRkFvMmVEdVRNaWVZMDJWeWJ5UC9FVjRpc2tFWVVy?=
 =?utf-8?B?VEM2cUJ6akhpWEJ1OUtRSkpBcDFoNTlVRjI3OVJ5UjFJWkJpYjRDRUlxSnpn?=
 =?utf-8?B?QWNrR0ZLcTB4WGFCWFBjMXZDaVdCZ0V4Q2s1NjVJLzYwaTlNaHp3aWtUWU1U?=
 =?utf-8?B?bEwxd215cHhacURaZDBJYUpsSWgwVjB0ZG9GWG5RQmFqSGNrZmllckM2MkQ4?=
 =?utf-8?B?Z1RqbFZDNG0wN0VZTHd4WldJaEZ0M0plK2pqdXAwOG1nQXJENWVOVEtpWEtS?=
 =?utf-8?B?SXpVSlhHemNqa2c2M2MxMmZJeTJ1TTJKVThsNVlaeHIzWW44bjQvRVRvWC9z?=
 =?utf-8?B?TllWMDQ4UVR5OGdzelpmQT09?=
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4836e3d-9fd5-48be-25d7-08d8e24eb945
X-MS-Exchange-CrossTenant-AuthSource: SN2PR0801MB2223.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 16:25:02.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fFLdbvbNTTW4PRyxKYqutjm8IBjdkQoyoRsmkM+T3zLE3zTwquXddZqBJ+xsyFfO7oIw4sVKFMjvSAYY63ZFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6571
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I've tested this in a 4.14 based kernel with two different out-of-tree 
iio adcs, neither of which supports IIO_CHAN_INFO_PROCESSED.

Tested-by: Chris Lesiak <chris.lesiak@licor.com>

