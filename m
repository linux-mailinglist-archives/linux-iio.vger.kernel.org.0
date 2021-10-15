Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC32642EF50
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 13:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhJOLKA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 07:10:00 -0400
Received: from mail-eopbgr1300118.outbound.protection.outlook.com ([40.107.130.118]:14625
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238226AbhJOLKA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Oct 2021 07:10:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZKA+j6AW0HRi0drmlGaWcoy3A39NUBONlCvdLA+L7ormsT7bcdN15urWTmUl8zDxlAlt+uq1Hm/U3VfWA4Oc+IQa56FJK5mGWXtvENywVIYbQ4TW4E3l7egFmLYWjuIdcRaYHZ115/pEteIQKX22hAuUiTaGlLR/23pdeOP4G7rUAkXTZFfr1geqzgB+w4MDbDhxKszz6RlN6P5UqBE9t2tQublPtyJ7byqIcw7DqJ5AulKH7jPtRWIvCPAzA0nGdrhrJrlr04dAJP2QC+4OQ1T8KCur75Gq61cLU2xvHBfP3FQszkmFA/ZyhReFOjuqWlxLpXPhqiMdZ7O2wPqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvSfJuAAT7wCh36OnWTf9Rb6V3j/2JcRcU/mITV9go8=;
 b=AqLbjKOrxM0sFQYBvmeihObAJ3mcMucepOgpLazssp/HF+tm4qErIrccRELtqYiebFy2xcB47M+AUze/T/WonEBmYJfXgvCHQ1+ClCdelHWtB/o9Q2p2qLkMGOApoiC+I2JnHjQTm2LLFPFFkpZ6XmsXNmtNe8SoEjMsRptr+HtwiAEjHOk285n9vN4OF1TBngp+dQYYKK+I/MCcwJoqzSindOzR7yARSPSSfN5gGVAPO5zeCCu+U4ESWASfR6ZSRL+otGwuuDAgemMoHYBCFukjfsMNEqVvSVOhzyoe94JAQNYsineeaBNSWE5GM+c8Fx2F8jBE924A9H3sEvG9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvSfJuAAT7wCh36OnWTf9Rb6V3j/2JcRcU/mITV9go8=;
 b=im74aStsJaKHd5uRxHkT1jyBCefJ7pvW4zCQHli2Vmtpx30TTdvuwqetYgu2qsAe6S+8e2DWflfapJEBobA5mpxWJL3noAjWi3lZnuNxCtsyf18hpVRsbQtP90XNRtdI/UGOZdsraCjDIGmczYMrzvbUVW9RzxhXej5wfqfs3Ew=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3212.apcprd06.prod.outlook.com (2603:1096:100:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 11:07:50 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 11:07:50 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH V2 0/5] hid: replace snprintf in show functions with sysfs_emit
Date:   Fri, 15 Oct 2021 04:07:27 -0700
Message-Id: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 11:07:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c90caca-5c2c-4915-b671-08d98fcc06e2
X-MS-TrafficTypeDiagnostic: SL2PR06MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB321246E8F25A9EBC905FE664BDB99@SL2PR06MB3212.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEXGBMKHg6UTZWbquFZ33LafLkYV7Rzxfu0jNvxn3wD+RjOb8PYevNyT1l8BpOe+4fmFGirhKEKfoNLkT9JrdWwg65MiFVTrqEnw76ekIoVTHxY84w4GdHw6RKmsXE2dHpw4m9uTwCS9eA8ZnX9wXy1/oTWCGNLTjMFmfYQFZxc+ZhM23vkT5ORvFlpbNjJgypO/zQJqU+le1g2JxbJ/VRI7V2P3suF4QmCbCr735ABxT1Sj0uzS0rVik+nOo0yrIpOV6bwdw16Y+r9X52Kw/l7flufNgaxBgBIH+74So96UB1l2XyP3KyHI07CWFE+N7Qfozkx3fCTUrH6BGUvRoM7JMuRLlF+j4+2EYX70EC+pkVNp7zG2DUzG0KieJEdmDMHW277468nWVQxts2/w0vjcMmIUmOC9cx5vChyXiytxhKvRuWQtASsEVO3YTa2ZwKS8cs7rnQ8+Dynrd0+ik+ckFvN3Tt6lLXkbq/I1J3ppqKRRCli2+8nqAhjazcw8KpbNNKXyiCuDCueumIoMbhF6qWl3jezeJZfRdSpDqvq65jxHAVBgHM85FTHSvCvWF2nkzsNqMHuswDyW/wGM3MI12Qqy1nOgZqjj6dEPyleZwSOawn4fhMIl9vipFox3MK7jKypHMrbHRGLIfOiGphKyY3sWlpVYpjk+UJIFWMAA8MKslgaraCxB/AXn9mX6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(2616005)(6506007)(110136005)(316002)(107886003)(86362001)(4326008)(5660300002)(2906002)(6486002)(26005)(52116002)(8676002)(8936002)(6512007)(186003)(38350700002)(38100700002)(83380400001)(6666004)(66946007)(36756003)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yNyhH2ny8I8QvOJzQD0bhKGUpXOEj5PFNMM37SYcxeiNHJFJThMU59W+niSR?=
 =?us-ascii?Q?m7d4pfveMifkJtRc/NagGU0A9maq8SUAYyhoZPDRSYXWbYKzwtdS5eTI+gpN?=
 =?us-ascii?Q?UawWWe0fLxTJEhH6/Xd5QEDvebbOdr+A6AiLpvdeSEnBokJP75chmKy2/A7E?=
 =?us-ascii?Q?odq/osPcMY2Xs8hGiC04Kfazc7DV4G41soFiRSIiPnISEJx6hASGPmJ5vGXp?=
 =?us-ascii?Q?EusjUvPFAwxGDzNME5hHeJCf2w0a+42Tr5p9I1eoALGbjoEDT6MigrZZzJVQ?=
 =?us-ascii?Q?aVXBrNnLuM83idzZwmO+g6gx+U9neCBIrnU97efbeGYR1rlws+zhSZL7t1lh?=
 =?us-ascii?Q?VIIF4SVRc7mxbrpNLbHVYPVjVYO4u2O2B6edcHGMTs0RQbMq+SYQDUAMtXTV?=
 =?us-ascii?Q?pfPyGQKTbUpvRO5JNotgv7jD4OncaZFt8PDFwBUhMZOLhLjQxfUWu8KpswQO?=
 =?us-ascii?Q?2pVB3vqG+zN0ilL7aASLhgI1KvANNUoe31qQhj3YPwO0Rm/zKO45sawpDBep?=
 =?us-ascii?Q?jAguQH7J4Eh8WASzeO3yf3liDmwFBaRvPrY7i2ECS7O0r3dYx8roGw5IXbBY?=
 =?us-ascii?Q?NbOy/3ydwnyrGcT7TEAoarEJwIbzRl2CA9JzUoyt4ZmESuN0bT+uKVtpDm4H?=
 =?us-ascii?Q?18UPw9MEAv3XHXbbM0jVT6xXcdad/Sr+5koSdDTVijWBeD8Zk5+T2K9e/ioa?=
 =?us-ascii?Q?JAX286paSftQkylO+qaBOEL9AlFFcweWmeQ/lBAFmXEmHtZ1BoADSBX24fSV?=
 =?us-ascii?Q?xsk5B6l9r/C9CllOY5EmJJ1OTKyyAnpwITOhJql80WzmomsDe/VSKUh1moti?=
 =?us-ascii?Q?/Yf4A98h4qvzLbCblWCovX0yKloJEarLdXzAVBz1RrZdSQEdDSYE62SujHpf?=
 =?us-ascii?Q?V6w1Cy8e/6VLnBOD3X4kyOag8Ouet/e0FxcgTwuxqK9xv+vS8EYFr4W2O1lB?=
 =?us-ascii?Q?RZCJkdCLrizg1ddqRvwidwsu5sJwgYyGlDNu/LnnJXnAl6TsSpa5c+1b/DWt?=
 =?us-ascii?Q?VJVsO65jeyqmatfQ8xhCo4gdd8f1WK7dwxQhvVqrL06r0kN+PjIGpDdRLhHo?=
 =?us-ascii?Q?HJdJuWBANo8oqToeoNlncQToASz36Z/BC5/FDARZ3v9gFFDXOVNXNVo4nSu/?=
 =?us-ascii?Q?BM1EOxwqCN68XgjG3ropi9yZW+36bQONL6HK4RpZA+ZB1L41DdkAfTaeV8ss?=
 =?us-ascii?Q?TkUkrnNdmVrdiPUKX1iP3qIIUFJV6HsTS0HpTRE9tHpRLCULX26nv3QJdRRH?=
 =?us-ascii?Q?52c0MSh9Z+i4W7zwXXwco5hNzgfsA2MjunRcG/6v1gl1Fo2qsiGmAkV0ZAhq?=
 =?us-ascii?Q?p1OoHd+E+AFOm2eY04RLkCnv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c90caca-5c2c-4915-b671-08d98fcc06e2
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 11:07:50.3476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pqzm7MLeW2m+ZSlvmwKKHFFXjEvjWgTrIc2u3hszTrnCHlC2bi7lexWilbiuA+wzoRuNlfquFBbrKZE/dhr1JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3212
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

According to Documentation/filesystems/sysfs.txt:
show() methods of device attributes should return the number
of bytes printed into the buffer. This is the return value of 
scnprintf(). snprintf() returns the length the resulting string.

So, show() should not use snprintf() when formatting 
the value to be returned to user space. 
Also, use sysfs_emit directly makes more sense.

Qing Wang (5):
  hid-lenovo: replace snprintf in show functions with sysfs_emit
  hid-picolcd: replace snprintf in show functions with sysfs_emit
  hid-roccat: replace snprintf in show functions with sysfs_emit
  hid-sensor: replace snprintf in show functions with sysfs_emit
  hid-sony: replace snprintf in show functions with sysfs_emit

 drivers/hid/hid-lenovo.c          | 16 ++++++++--------
 drivers/hid/hid-picolcd_core.c    |  6 +++---
 drivers/hid/hid-roccat-isku.c     |  2 +-
 drivers/hid/hid-roccat-kone.c     | 12 ++++++------
 drivers/hid/hid-roccat-koneplus.c |  4 ++--
 drivers/hid/hid-roccat-kovaplus.c | 10 +++++-----
 drivers/hid/hid-roccat-pyra.c     |  6 +++---
 drivers/hid/hid-sensor-custom.c   |  2 +-
 drivers/hid/hid-sony.c            |  6 +++---
 9 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.7.4

