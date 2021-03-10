Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B462333F44
	for <lists+linux-iio@lfdr.de>; Wed, 10 Mar 2021 14:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhCJNbd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Mar 2021 08:31:33 -0500
Received: from mail-eopbgr10083.outbound.protection.outlook.com ([40.107.1.83]:57054
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232727AbhCJNba (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Mar 2021 08:31:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hebhu92r5F9U00l/lHQS1tMASXpc09B00gWTA3qEmiGb7O6ZZdAsJSbOBdFIMe5TwpkxF88I6RwIKWKDOTPOb9yW0NsUVgMjEBtmboaDAYKojOEO7+WChjkKmisTrzo74AoJ/IWaqSlQdES7pLqw2W3eMpx7xbPNZaUORphlpzN425CDdqm6n2ndCc1m9xXmwnEN5gkFP9hw+Ob9wQ+lAfRcw8uMRmhf+H/xOIPVWCXMQtBQqj+j3ZTja6CWHcID+sTUdmDA5o+yOpCVAiZjRXmmVfxzvxkLJS9JswRcvIYpIWmntWpaXtAMOzmRQd/JrUINJNXfXWcNyo32hoN82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgHTKHc9LfunL4YoMQVRahtl8os9OMadTOsjabm6+PI=;
 b=lyFbsM7SNCOYJAXh/8dWF0uhQezUW9uR+Vh2UxmexbTmHFsq1y6In0eA+jC2yZXZywz+vyfZihe67wPiN+j6xfZ8O8jXUfRvNfmnSSmB8nwcz6GsmC/lACRGoIY2ZympxC/U+I0BamJQACzG6+pwxhIcnmkctYN+OSA4ne8eNLBppKbNFS3rwMbB1yem+leJoDdCOVKPngoRP40Y5aogGadSRhOVIRlMZBmpQD2xTEzKSdcCfMCYO7lCprm7wGMUBBWPDmLjdd7jvy2QjcBQXXH4BoTbD0iP0ABAmjBOvzrhNUNO9PbxJCihJ9KUFCO9NVba/j/rovkCCiUDL/OaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgHTKHc9LfunL4YoMQVRahtl8os9OMadTOsjabm6+PI=;
 b=PK8iVm54YoOuZwUp9EedCzLGhms65N8g1bvfUQ8YRLZ9DEYAqa6a46GodfmdIzhdw1c0b+VJr62E4Fm9bXE00eENTYkWVld0NNJU4kHRUVLozsERBi2EcR4OsZzvd5F0tLahH0G251N26QzmDcQw9Z42ybA3jTZzEjF2xDRH+BQBz9BY29QehE8umcXvFN7ZE5D7Oe6IwIkk/Xnf6Bn8NxDJEBEo/SLCkXw6DUKeGzX7KDuBCugoEUBhnzv0n5KZ2bTF5nt8vcwFDZRQUxDwES2Lutn0mk/czNpui1TqUV3zr0okcbtGYzt0eKPnzWKo3Id0w0y/l79WriBW6dI8CA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR0601MB2110.eurprd06.prod.outlook.com
 (2603:10a6:800:2f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 13:31:28 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 13:31:28 +0000
To:     linux-iio@vger.kernel.org
From:   Tomas Melin <tomas.melin@vaisala.com>
Subject: shared access to gpio pin
Message-ID: <d1de620f-b2f5-11ab-5451-962150518f3a@vaisala.com>
Date:   Wed, 10 Mar 2021 15:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.156.166.133]
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [85.156.166.133] (85.156.166.133) by FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14 via Frontend Transport; Wed, 10 Mar 2021 13:31:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 356abbdc-9626-43c2-f8f3-08d8e3c8cefc
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2110:
X-Microsoft-Antispam-PRVS: <VI1PR0601MB2110FF10CAF8E331FD9169EEFD919@VI1PR0601MB2110.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWdD7fxK1uxq7VnhxL5qwu/uEeaek/zSWHakwZ8UFJ4Hd1wxoCQ1P7X/EWDjYReeCyWi7BMGoK48g/zsNzLTOQlB39yB+FzEr3uHIcut3H0pvS4UIRfNCOdx5BHw5chvemBOueACMiNmKsLhr6LF2i5Hw+cCAqxwvCnqmV81AKLuwnMs3ohYs/j1ggJv1evn/jTVvDdMQbCr/NK9T3m+trz7sglVOhurR8s3JXMTkjISCB9mprl7wz5tPqMwsHH3etGYu6VVjIBkkLVw83Ve1Hxgpc0QMRD8Xw41ccjKrFlqzi9I/dwhvc6ivKsMPRAhHuHJynzBeEwU9aFc137iHUOfp7AmpIYEfwCuqGeBvYhyngplDDujX0TvGNkh7TZF7yYhTKnx7mCO/CziYqSIBlxOOP0rWV8g/p6MQlnLhw6cRRSPbneQdUNd79Ob4vsxGA7B28wRHN7Xk4HCIfuoy8ZknWsQMp7Qj5Lbv4DHNt7t4dSf07A8mRTQ9ikf2DuUghwuUGykS7O2SXcTK3nCGsI2lWPUfd99plZ22EQYYHkLlIss0OXHgbPZHdfojhkOkw3SlUWKtSEYB5y1TLdK6ZaWyCdyh6+UB0Cdc0f24wMW3BpbLf5skm82/ik4m9ghmsfV7x/W0AyKI+GXmwDV7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(346002)(376002)(136003)(16526019)(186003)(66476007)(2906002)(26005)(2616005)(956004)(44832011)(8676002)(31686004)(8936002)(86362001)(316002)(16576012)(36756003)(6706004)(6916009)(52116002)(6486002)(4744005)(478600001)(66946007)(5660300002)(83380400001)(66556008)(31696002)(3940600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0hkaElOQVB0VWxibDFWalZrK1ZkT0U2US9WeGFZaDJiOVlzMnZnQzVBMGJZ?=
 =?utf-8?B?MTU4RHJ6ZFJ6WS9DWHFvUno4NGxrMWxzemlZTW9abFpRSjZVblRldzlDVU5O?=
 =?utf-8?B?aHRaRVlFWkd3NWlXb0tFVlZMZU1td2ZwUndaUDE3UjVXbmM2am8xaWZXZ2x3?=
 =?utf-8?B?NStUSDJ5dVV1aEQyYzZQRFAwK1BGSEFTN1Q3QWdZQUFxeHpuZ20yQ0FLK3ZB?=
 =?utf-8?B?ZDZkdFBHVHhNWkdDM0k0Q2NqallYZGlJVHA4c3BHTWE2K3p3elBNZkQ3eGk4?=
 =?utf-8?B?bkhLcEswOG5TMkVyQ0cybDFLbE9IUkVJOUpLL2t1VFo2a1RhTElRQVdkS05o?=
 =?utf-8?B?bC9yOVdaaFBwa2J1UWNWRC83OGVCNm1teTBpVTlhSWk5QnpuWnh3RjQvK0FL?=
 =?utf-8?B?R3pub0xveW1uSUY2bFBxdmlWUk1Na3F4WEVyanpYOXUvcGlSSVhjMjIvb1RV?=
 =?utf-8?B?VE0xOEtFclYyaUs0OVBuRXM3REI3RWRvYVI3R0UwOG9RU0srZHd3UTlQSmt2?=
 =?utf-8?B?YUxDNHc0RVRJbTJsUFVPbTFHVHAySnRPa3VYbmV3aWc4OTNST1VWWDFKOFg2?=
 =?utf-8?B?WDQ4TjM2ZXprekpNUHAzS1ltZUJnZmpuV0s4TlBKY0hZcnIrbGJsMmsxOFZr?=
 =?utf-8?B?SmRZUTlHRnNxZVFsWGVDMWlnKy94YzhMak53dmp0dktvVXJvejZUSTJkV3RN?=
 =?utf-8?B?b0R4c1JvYWJzaXpPaC9mdjA3b1J5eGl5QVJwYXZGREhqN1U2cFBJclFmdjZt?=
 =?utf-8?B?anIwc0wwbGhPLzBlRmFWMGh1VlZGalZTQnAzQ3NYUk1DR0Y5OXRoV1lhc29F?=
 =?utf-8?B?eDg5U08yUVZEU2lJeTc5SlkzMlA5SEZnQ0ZHYzFuY2JWT2YrWXNFMjR5VlV6?=
 =?utf-8?B?bkdwSVBoY3pyZ3M0cmNDZ1psNDErNFlyQnBXdy9nWVpLa1M5NnN0TkVoVkho?=
 =?utf-8?B?UUhwMkR4QitDOHhjL0Q0Y2RBcVVrSzRxM3hVcVN6dFJXOUJxYzRDeTBhaXRa?=
 =?utf-8?B?Q29ncjMzZHkvMVI5TDNsM3dOTm9relFaaGVQVGU2L1l4ZUR1cXArQUJZNGxI?=
 =?utf-8?B?NGlJTi9OUU03WDRvZGVHeEp3ZEQyYkRuakFmaHdxY29LT3htQ0g1akRZOWh3?=
 =?utf-8?B?ZHFDK1dzUHNlNFpTYzRxUXZtekRWZ293V2N2c21FVnREWHM3QndFZlpKYkg1?=
 =?utf-8?B?cllENWxHSnA4SVBMSnJLbVg4cGMxTjZqSVJXQnkwbVR5RkRlS1pKN1RjMTdD?=
 =?utf-8?B?TmtRWmEraFVjL1MvSW85aDhMc2tDOTZ2WTQxdmJJOEpBYnVOT2FmMk1zbmhX?=
 =?utf-8?B?YlJjNHpIbUs3aDlCNk9pT2kyME5mOHlGYXRUS2pDeFJ0ZW9FVHpTTTZkbzkw?=
 =?utf-8?B?M2xiMFlpODY4MHFUT3Y3VG9DeVdlMVFVbEZTalJyU3E2T1IzTnUzT3ZhK0JP?=
 =?utf-8?B?TVhkYW1iZ2hiTTcxMHRFU1dzVlg2eW8zK1piUlhxRHU2K1F5VlZ5Z0ZVQUV1?=
 =?utf-8?B?OWlYNnRpcnRWc3J0NXlIditOWlVjSFkxNGJST3VLbWtaamxNa0c2TUdydHRt?=
 =?utf-8?B?T2pRaDNFUzZZd2RLaW5kUW5ORGZvSUVBZnduc05DYTgySC9xckMwR2FQKzZU?=
 =?utf-8?B?aWE1cmZndGdDWmRNSjVwOENlTktEblExUTBRZVcvR0U5NGFKb0J4aTBsMDY0?=
 =?utf-8?B?VE9ETkxZaXlkVnFJaW5aUlE3L1Q1bjRGODRhblltTGJCY0pjMmd0YTB3b2RP?=
 =?utf-8?Q?0ldSDICejR3GahEcfwOuJL8EG8Uvg64QGkYvYSt?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356abbdc-9626-43c2-f8f3-08d8e3c8cefc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 13:31:28.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RM6Fkq8Wxmk4/mNt+L8XNbH1qOhfja7jukHAZWQr69DhMxZ37dFZ+B8/hHsQASplUZMvirHv4fZmsE9rEvSkkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2110
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Is there a preferred way of providing shared access to a gpio pin?

Use case is such that there is one application which only monitors the 
state of gpio pins, while another

actually controls those pins. It would be enough if the monitoring 
application could read the state of those pins regularly.

With the old sysfs approach, it was rather easy to share read/writes to 
a certain pin, but is there a

way to provide similar functionality with gpio character devices?


Tomas



