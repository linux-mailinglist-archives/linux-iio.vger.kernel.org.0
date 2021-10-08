Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17E426C3C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 15:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhJHOBC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 10:01:02 -0400
Received: from mail-vi1eur05on2119.outbound.protection.outlook.com ([40.107.21.119]:19265
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229529AbhJHOBB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 10:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfh2JqlEtOw4ZOFIgyX//mdGoi0Lk0HisNpVPHhq7rMmQna0BygVRyfmBA8bpkXmvulrttccS8HpdkZ63L6hn5LLDXORBeqdGO3ddlgrKtVYm4gMuk0FAKXD/Bg7zlNipD8lVZ21qvO2vjK9DxyRHDGU1M8/AiCNhS43xZy7wFi24TPG9QZ5eBRW9Eiqvv6oH1CcwG2N0V4Z1jOPIzb+l/EdEKi41PR5biZtbVA6NzoCOU9QYsumop3pbwMWuTTN7NJtJSQihuMfEz0EZ7n/D/BKfCbPndmIWcQp2cxP4h4iMz2x1JYYM9GpaSUoLCOYMQZtJDVCBgbyaSGYbLWUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYNGQekqgy0uBwAF2FcEc5aWGEgyiRFOBAzcatQ8enk=;
 b=ZslUe9ecWmK8irzw71pNaIiIfmeGciyDB/ugk4pKI2J7U3AzxpeD31e0t5ZKOZxvpJngPd2aBSi0rjfk1go/97OylyIIRMzSN24BncDC8ArZszbdSkuv1w5FTgRrwwkH0SeF0gn2SL0YdLJ8MHIR3AfIhwD4wtZv/r6zw/q5fU6XhFuu04c9NBAqwibmR2XP/J1coliw+hCpE1EBwphe8A7MjlAMDz8eW0EnPCVUeJTxXEtBSNt+U1kvnBwJK9dsryfSeqRe4TM1s/qpIgGEI72SwLPqHexfnWYUO8rcazt+5AfX3Hu+PB1R3Cwq5EedZHxtpKpMqjwV7AlPygLNsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYNGQekqgy0uBwAF2FcEc5aWGEgyiRFOBAzcatQ8enk=;
 b=VCRjWl55xT+/wkv5HT4ZmSReXn7tIRp2iJtA166/uJUM7lLb1gmOGF5xSnLeRNixUCsJfRPsnrPV9qsOlv/7J6dBy3YYwxBCjaIPIFHl+I9RxPlEqz5N2YYpyKCwdgciDAj4hu6+p6t0pfun1s1m9/jvPhTJE31e19v1cDD+h30=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v4 0/1] iio/scmi: Add reading "raw" attribute.
Date:   Fri,  8 Oct 2021 16:58:41 +0300
Message-Id: <20211008135842.21896-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0060.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::31) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71964c49-4b13-4f3a-c51c-08d98a63c8a1
X-MS-TrafficTypeDiagnostic: AM6PR04MB4309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB43090689F910CAB07D86B922E6B29@AM6PR04MB4309.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpw0ka8uOYgpZsUb5u+mgwMZBYECZvb0+BzKjAZODZ7/LQisEYs4xRIekVYLlXp1FERe+j/7FhgKZLeYe483YsfLVS9ezXpuLUvl/gHNSPUywIxjXjGDZvI5HO/dwZJGvVfjDV1Qq8E0G9Rohh7H4dkzvAcneVdm8P95baItJf+a0KbIPjmyYClbcG33F22rnH/rj1yE1FwXKH8nPG/8fE8nwjbLiN2rVsOix2SNedggXVIs92DC5h7/N2HtrnoNcpqwyWp4F2LrOfDFSeGaqbz1yb0bdEysflSqK3ujlP/BZ+padx1bgKwrgQzRreG6mIDbozB++mfULfRGohbZNWMfNgWAljcWgzOKO7xnVYQBx0VxbG0qVl1olHBA7mUJ8rK3RelQ7lo5OK9NdvVMinPP0ajfYL/Yy9t75WA9di7ZoHMdtrqr2NquJKtIgP9UUQzrx8BX2fVjycmx3mzoP9l2PDkH8u/n74BYmYyPrU9LR09Qor5RePfdl18Vk8XZZN/seE6lFoxEkQQffS4MBVIaCZmWPxCQLcRuCJ3lP66LN2x5pn1ql7qOJ+BHQm0rwntOFvgU/b1hat3/OBfrgs7kEx/18ch82Fv4j9UxNhNA+GsxWfbbLSVKREkSvoO/CdgU5sMkMraLWJ/prSUABrr21x8mkcmQDzQlC/zOOQkB800JsYPebqFrPbVGD//2Kkj3P/B+ORTiDC36hEY5eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39840400004)(396003)(2616005)(42186006)(5660300002)(107886003)(316002)(186003)(66476007)(1076003)(4744005)(44832011)(8676002)(38100700002)(38350700002)(66556008)(36756003)(4326008)(66946007)(83380400001)(52116002)(2906002)(26005)(86362001)(508600001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PJOxFtUcmBoqb2ZTvh9qjOfOCN0I25DjdxqjsBPBfKrLQg7mah9xPCArGoea?=
 =?us-ascii?Q?QNK/nqCIKPqVM2Yh3SL5aWhxlHf7JF2v1T+Vk0Z8y0gOt++h5GYEo65GJMyX?=
 =?us-ascii?Q?RW2y/Bffply842Iygq/Hh3HelaBwoHdOYJGGsFtjUV/XM8wJ6ZH15hYF1iD+?=
 =?us-ascii?Q?nU0UZJ9u1sJ3/iY+aSxzxFKVpH0CZmkoInbmouKXdmgofl+fUivbLfgrd9td?=
 =?us-ascii?Q?vqFaUZRdo/HPKxRfF4YPaOWB2+8EKvQsdrf3ODnRVIUavnKB5hBXP/8U4fIR?=
 =?us-ascii?Q?rw41bWEgDnclluiCXy+bDpfNlmPPmr+8+ZfGxeSiLLFAF2mLro7t1XEnguH0?=
 =?us-ascii?Q?yNLpT5hJ8Uu60t7CdFvx320UxXkIsaaAVDq9FYberJJB0c6iMin/lKGAjFYB?=
 =?us-ascii?Q?XRAM5bnfhIM2HbbHTHk5Gsj37yNjRsVGSw9HDEE9ANTnsTSrRd1gfR2oNOEM?=
 =?us-ascii?Q?D4uRK/8OtaZp0eA5ZjnkoJ+SSwZCshq0KDtkxsVfEBuQq+CcMAp8E2IGdCye?=
 =?us-ascii?Q?P0F0yBVqcsvDtchoAAOWA/oxGceB0BlRW310bTgHvGY6anigOhSwjnbnPtR4?=
 =?us-ascii?Q?A16us/v4f0Gw5WIxGag5k7LJMsqhtJAbVbD8EQyVtVbPpRB89FSUaN9a+sWk?=
 =?us-ascii?Q?IE2+Ry7JWQl6bkdS/qW+9r8YvMApwF3j+MQcevdXaKGCaFQTR5tcrF0OBA9h?=
 =?us-ascii?Q?qhVyPsN74FFwbVcfK1o63JiNH1kQsH4IIlpNHrK6/Q5M+Z7dIGN2xQq6d8Bf?=
 =?us-ascii?Q?D+n/3YXJYqIL+Kj1ZaKMQie9uQIMhoeNapBmweXXsDtpkehXPxqq4SgsMeeF?=
 =?us-ascii?Q?Do/fZHoG6Xycr8/joiRGG/QTM2EKIKQ2NluwOo3wLvPTIR3T5oitq2z7/XYw?=
 =?us-ascii?Q?QMRsuKUOCX4nvi+cRp4OmIEAI0aAxyjSOz2ZbpPPeFmIQd+dAK+R0g7YpWMj?=
 =?us-ascii?Q?lrrSGNjP7GrkK9z0tsutSgw1zik1biRVOCgIhZiyZO40f+Z/Mt4SWfBOpgG8?=
 =?us-ascii?Q?QFY1UwcY2RFifUfkGPfu86UuxFwaXbFSXrzvO+wbVjYrSXDYCDjiy2bTJKtC?=
 =?us-ascii?Q?U7+Ll5wcrwssMJDWUgOEp53s0XWVo8lYdo0aDfkvSubNi/JDXxjrf5SyAliF?=
 =?us-ascii?Q?xUNtl7+oqThN4CiJeezmmSIehcE98cobqtqg+OMOUGZ+6VDoNdhZQXy/Lbla?=
 =?us-ascii?Q?5z5OfvMb74Mvqhbkfh/u6TY3iW+1fn9JuDxhVRnCDbVRjVYop7M2gKp6Odlf?=
 =?us-ascii?Q?YklrgJdEYYNKzxCx99k0IzDzkR1I4rKPdTNFJiU5lA32MAjBGaX3+bFGh19r?=
 =?us-ascii?Q?6ZuGO4UR/8aOV309mh5Gvowr?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71964c49-4b13-4f3a-c51c-08d98a63c8a1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 13:59:02.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnzHiHlH08UoraebYU2cBwh5fZS/8pbeXZ/9clOluUDrheo8GoZSG5dj/wS+mLXqDCps8nDGAwSCcf9KXwo6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4309
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch implements reading "raw" attribute.

The patch is based on v5.14.

Comparing to the previous version it has:
* do not use scmi_iio_get_raw() for reading raw attribute due to 32bit
  return value limitation (actually I reverted the previous v3)
* introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return 64 bit
  value
* enabling/disabling and reading raw attribute is done in direct mode

Any comments are very welcome.

Thanks,
Andriy.

Andriy Tryshnivskyy (1):
  iio/scmi: Add reading "raw" attribute.

 drivers/iio/common/scmi_sensors/scmi_iio.c | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)


base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.17.1

