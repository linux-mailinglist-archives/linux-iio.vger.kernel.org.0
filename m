Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC704354C8
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhJTUvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 16:51:25 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com ([40.107.7.94]:11299
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230317AbhJTUvY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 16:51:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyw75ejCcWnXTXP35kML/5ZpMOLr07rNVGohLCMxUYJaho8Y65SaGtCNbJRmKbhrvcst1bawJb8RWrWA9liefW4YbUivhOojLIvjM3ti8IhSLG/0D5OZvMlftn4C2hbf9jRcpYGtyg0MbjZH+PwAdq6dhM+5fKP206MvU2UFZW3YGuNZif3kJckUSgp4CAoLetH9cC70veBoX9Md8bn3yf5Isg0uriH94tKTG9wTzjCW+6SjNn4jh7j7IQrz4LhbB+TxwjEbTOeykw8f9oWt8Eez7Xt7ajPLJ4qCgF101XeHFaA0rrf1zHx/m/5FKWWxzaaTF1N7F8izQAv7VtxMIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQKKCtqmJaww6wFSq4C4Bjlz/DzmiNcdEnRn53XBPmc=;
 b=odGZsqEE9ZvBdEoM60qBPk+cZZ6SG6Qbiab90ef3MS4N38sh3q+X9lEjZi40lu+wOqtORDNcx+T2modCQdFGp0Rr4Jik/V1sQ56SYzGGHjTCWsuWhVcYdlxxhYTvpqtC0O71lGkaakTEVbna8BSOEfPGbhtRonaaD6HkzXFjN0G6MS9cKCv2f3I/6Q2BueeNfAEJhmpvGx8xOwxt0Jyfs98Hw7MB7m8jZdIgfJ3qye8e0xsHmEjJA/HcdB9iHadGil4zZ2WZ0jXHAa00b8UiJemuZElINHI04BZ5mbI82x59Hzak8L9R8LGrb7eLooT3yVxr8XZOsl642qHERjSvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQKKCtqmJaww6wFSq4C4Bjlz/DzmiNcdEnRn53XBPmc=;
 b=PNSTZoe02y6Kx1WNQryJJcYAYLWKV9Tz5QH8cSYNYW7VnhWoUODPi39PuX3H3VLP6k00wfITlD1ro1MXO62YEYm3CxSMQVryy76kd3NX9sj8XhOxOCxDkINDLHGfkCN5wB45rhT7eQ6whVmbN3LPdpWID6BOwyfzQPljBqfULLY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB3818.eurprd02.prod.outlook.com (2603:10a6:5:b::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Wed, 20 Oct 2021 20:49:06 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 20:49:06 +0000
Message-ID: <72e43201-e419-8fec-09f6-e3a169c086c3@axentia.se>
Date:   Wed, 20 Oct 2021 22:49:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mux: fix kernel doc prototype
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
        linux-iio@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
References: <20211019064521.18113-1-vincent.whitchurch@axis.com>
 <f8282455-9d8c-31ad-f722-6a59c6d97d20@axentia.se>
 <20211020212741.4855df03@jic23-huawei>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211020212741.4855df03@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P18901CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::19) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by HE1P18901CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:3:8b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Wed, 20 Oct 2021 20:49:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4124ce82-9732-4ed6-c806-08d9940b0e74
X-MS-TrafficTypeDiagnostic: DB7PR02MB3818:
X-Microsoft-Antispam-PRVS: <DB7PR02MB38182D58AC76F06B69B08826BCBE9@DB7PR02MB3818.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgcQXQed3NQal0QiY9+txIxxqZMNezvp6vT+pMhnzsMV4sXIih5vDArn/B/iviexiccNUXa1yG1VbygvKhPkBjMuB83dQ66UA1IcCsMn8/UR5tGV+buRQzGbpwkTW2zmhUekLQ88xnpiXAwQBCLZinkHP/cxrEo9ADaDB3X9BF5LCXuRJELDvfIudpbNy+Xc/l/5L6Uw5WyKrDpfUjp9Js8F51k1wAH4Gwu+q75kET3Ldm4dJUGEwKLN9pBd7UzkjaE3sAr8FHSZCKGgtosfpesO2A36GjvjbXPk93fftifk/NiPMNsvavqL+a7gWykQ4Q0cPjz4Nyv3JlJXTMdVV443BoiUncdmgy0IjkQXkg7ZrWMhqdziTfHFB6yhyMV6IjrFxXnEaNNErV2NzvSI+ogyBdJbCDbTJmF62t2EAgx+YitrRiyfIGPLjQssv3nT0oQIbt3SJeno4p/vD1LL0wBEZewg6udtepXEWzB6aMY24YxwA2UuYwlQRFzWqSJnlc1Z5F48+8G10oNuEXQa3rDeF1YQ4XPhK2kSoeflH4/GSq6DX5p/5gNXnZl0kAOSZH5crYaNAGJuCdOGec+zaSeLl+Ut8QuFBwOPTRTg6ZYIAQiD/3GonV348Orzw5alP2CmdFLlrkOEbWv8mlMxAGAhv6BqpQqQPtzlB3989zdK9IaHqCj8mQJtLgE0YpgA5dBsrzScRdXu70nDT1Jw3r0VLJ6RjwQkYn0YbrxNK5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39840400004)(376002)(366004)(136003)(53546011)(36916002)(36756003)(31696002)(54906003)(8676002)(4001150100001)(508600001)(6916009)(66476007)(6486002)(956004)(4326008)(38100700002)(316002)(16576012)(83380400001)(66556008)(8936002)(26005)(186003)(66946007)(2616005)(31686004)(5660300002)(4744005)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmt1ZVc0TE1rSDVybGFFanp6bUp6QVdQMmRXYU1jL2V3OWdYWCtGYU1mRkNt?=
 =?utf-8?B?MVBjbU1QL2tCSTVrbWNUM0x1WjVGNEhwZkJQT0ozdmVGZVkrNmlEN0tqK1NG?=
 =?utf-8?B?UU1QNFZHUDZLRDhkRmdPRzBSMTNQdFowaExHcFlmTWc5QVBUNnRSbS9EWEtY?=
 =?utf-8?B?bUxhY1Z0MWRMUys4U29kWHRYdGVLakFCemtTMnNtaENucVhGK0hnMUs1cWVh?=
 =?utf-8?B?c0JzUzJESzhGN1AvUnA5QU93cjNkUWlMend3OGNweXNKeFNaRWx2UU1YTVNW?=
 =?utf-8?B?N1RjdDFEQ2l6NGRQa3BabDZlVHFlYVhxLytoNThGOFhMZ3NWL0E0aldhOXJn?=
 =?utf-8?B?U3d2OHlrd1QzeHRvUVRwdkMrNEUrSXJWcjEyTkZTWjZDbnFoWVY2dGgyemY1?=
 =?utf-8?B?Z1R5cjMxWm9aQ0xqNktxK3E0ZnlsYzAyRFRFOHliWG00V0RvR1RJcFBYN1Fs?=
 =?utf-8?B?eFA3QXpnaVBQM2hUaHFhci9Rbnhha2FiRTlPQTR0ODdQamJDNS8yY1JVMS9l?=
 =?utf-8?B?QXhqeS95MzA2QmsrYTZXWXVPSVhqR0kvTDBSMURwb0RnclFZaE8ybEhHNzFH?=
 =?utf-8?B?QVlYWGZoN3kwcmgxQTdkQWpzcGN2TlZlTzcra0dCNHBPUnIyQU5wNjNiQU5y?=
 =?utf-8?B?SjdWcjl3Z3BHVVdydEhnNE90ZVQySDF1azRUbC8wMlM2eXFBUUowNjljbmQ5?=
 =?utf-8?B?WGNEREw0N1hFOWdRUVhZZ01PSllXOHF1Y0pSVVZMSytzV05McFYrUk5WT1Y2?=
 =?utf-8?B?amVTanVqcHA5ZWZodE5ORWpHOGxrWmJjSjZCdTdib1V4NWRyUEVLZTFuL0py?=
 =?utf-8?B?R3dtOGJtUmNOK2s3azRYZENPbmtxc3BDZnNUMSs2c01nU0NXeG1xazFPVndU?=
 =?utf-8?B?aW44RWRlSTNYemZ5N2padVhrUTZVMnFPTUJpdG15TENDbmVBRENuYTc3TjM0?=
 =?utf-8?B?WkZyZU9ZV3VKYU94Yjh3Q1JuTk45a05FbTFCWnZ1RHQrYXVGYThvckNGS0Uy?=
 =?utf-8?B?QUhUQURJTEU0VHBpc1RScVo2NkFYUjN1WkhON3B1bE9MbWtROUFBYTkzZkFs?=
 =?utf-8?B?OEsxdFFmL3pMZkp3a3J5NTIyaFdQNkdZWEFEa1dTM1Q0WkNDTXZMckhnOGZH?=
 =?utf-8?B?cC9vbnNMV0RKVEVBemNGUG90Q25OeWgvVi9RUnZ5RnprL1gyQjJCdWkwYXVU?=
 =?utf-8?B?b3RLVWx3d29hSENxT1hQYU82RzdwVVZzRituemVYZzAwOFF5YVcrM21CYUxl?=
 =?utf-8?B?Uk1tR1hFNUxraTNLejlXaWJWNElDb216c1d5bjZRT2tlTWRJS1hEOFJzd2hn?=
 =?utf-8?B?ZEQ5YTVJK0R5RzlqOEtQT0JNT3R5aVUvYkZBMXZmdjIxam1YTXd2QXRyZGtJ?=
 =?utf-8?B?blM0TFhLdWk5QWZzVDBDenljY1lmTExzOHN1TVNoRGViSDVPQ1FPZ1N3RWtE?=
 =?utf-8?B?bG9WVWh2NGJEWW1ZcUZmTEQ5SE0vUlgwZUNCUDM5eUZOWFJTQVYrc2c0VXhL?=
 =?utf-8?B?OEIwWmNreEZOSmh4RU0zNlFMWUh0UUNqak5IclFKbS9PZDZtcXJLRVFKWHV2?=
 =?utf-8?B?cURJVWRyWm4zMmg1bXFqYTJrY1BpdkE3TWxWS2NjcHJrTU5xcGxoUXVQaTVB?=
 =?utf-8?B?a0hueHhwRDdVcDZ5QmFGQ1VxYWRMSVMyZ2tHMXJVS1hRaXdqSnNVU0w1YWRV?=
 =?utf-8?B?dmdHVmpLQVdvR3p2Ylg2d2Z5N2xiVUY5dW1jMWhpRnl0SGlWS09rbEJTdFJi?=
 =?utf-8?Q?qvKyYoD1KGBAhpHD3cPCCCEarLUCLqzCe9fXbcz?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4124ce82-9732-4ed6-c806-08d9940b0e74
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 20:49:06.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peda@axentia.se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3818
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-10-20 22:27, Jonathan Cameron wrote:
> On Tue, 19 Oct 2021 09:17:07 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2021-10-19 08:45, Vincent Whitchurch wrote:
>>> Fix this warning from scripts/kernel-doc:
>>>
>>>  drivers/mux/core.c:391: warning: expecting prototype for
>>>  mux_control_try_select(). Prototype was for
>>>  mux_control_try_select_delay() instead
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>  
>>
>> Obviously. Or, just squash it if that's still an option?
> Folded into original commit.
> 
> Thanks,
> 
> Jonathan

And I would like to say thanks for a nice series from Vincent and
to you Jonathan for taking care of the mechanics. Much appreciated!

Cheers,
Peter
