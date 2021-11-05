Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E624461EB
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 11:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhKEKH5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 06:07:57 -0400
Received: from mail-eopbgr00131.outbound.protection.outlook.com ([40.107.0.131]:40677
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230110AbhKEKH4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Nov 2021 06:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL0jJoAKqxR2bcWMiEtHj/4QS6sujQ2GM7vV68xTO2lxb8CEaZ+IitsE6yNSdpmeql0BnxwZTDzSxzpBprpSM6rOH3C69Eh4hEyQuMCl/EDKQTtJab6jFvEB+UQcgqP0QvBkUCPc1YEQFDR1pRAoLcabls+/UYpSFHzCf5xMHRtvoHB9EHpkor6ps4UydEdxN5b6PF2ni1SPWCj2oKOwbfLg/jLGD3tKxqvLZf+wuvsPvqVAVRA9iztzSYLMkfTr/rqGg3sd05+SfMA+3pY/aoWdr7TV7UdVbW6yu+b17bsGVxZo+DTOfgmlJ0KRsAe1o56eBe+J1tVAyfYPBAx+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJIKx321dXfzlohJiaY/g6yu7zZh35h04f/W0DgxFpI=;
 b=mTCl5qxgq91BgQAOwTkEyb0v6htJYk+HqHvOkEr71bNT21kbCtexYodHDc+AWM3tH0VAD986ZVg87LUNA8Iq4GGcmluCL0nb1DwKicjHTlrS5JT7vh7lsawWFRRHwTIPrwga5EW5Jh8Sdnrs6G9XmtIGd6slaVaHjC29Xptk2ASxHlZewrf6nfR4Sx+Ln8S6ciNWFisCfcLmdb+dOEs+3R3NxyvCr3CeOekVc17lmGdYOtv60NZHrRxlR+zUqoHL3Date62S2D/34bG6kDd0pkryYXMIBtPpigEoVfxPDOMSwjinKY0g+SQBdEub7UbdR8ssHB9ew4FLz3rQ364hWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJIKx321dXfzlohJiaY/g6yu7zZh35h04f/W0DgxFpI=;
 b=H0as6YZvHOrQBXMivpnJgy/TQyD69WyIFoHSLc4vWLHy5MstD9ZsAkW8mhQayvriAyNSjhE0guJ0LblW+5Qg/Xd7aamRYODuR5PKxAoTPlJrScdRDFGTc5RFma7nsOegjXLWTGeHx1XXMbbtm1AjrMgKtomGQ/52FpntYVtOSqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com, andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v1 0/2] iio: test: Add test for IIO_VAL_INT_64.
Date:   Fri,  5 Nov 2021 12:04:59 +0200
Message-Id: <20211105100501.1904-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0006.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::16) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea15e4aa-1af6-4f02-d06d-08d9a043c35b
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2467:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2467206658291239DB09405AE68E9@AM5PR0401MB2467.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:316;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhHgI4t8BZelPY3mqjo7NcX9vY+5FHSUfztHtCFIpmqHKVDwQ2iP2RhSpIVjFBtAPk36ZXPqdH5fWe0+bVKgTy8qfGjjC7xxdEcF9mUdV9BYMq5ZSWQEXXLL1EoVxQFQ3u+Rikn4d8gE9cMsyXCbBQUeMyU2wqg8tNfP+FD4h1rCYJHSvxi4z3xnPhAzD8r3y6zxyp5hnSyOY9zYNhU/xdX5p+OV0EMGl1zo7pcNV3ZAY7z/3GQyc9UjgRm9t4oMDN9IccFXGvcUTeDcKRYFWAmXQTIrmFLvcZwd5zhIbjiRU7oJxATWmbrWh15Lpj94t248JqooxWz9TqQCShOtC0MjD67mrVKSTMF5y7bsIuFwecnEot3ZrRCoOUnXv/W7GYPxZGFHbDvRX9AtSrfQM8U3Ym2HQLTQdQTaPpeJ71yLehUuKA3NJCc3TTkV5DaYH1dETuy102CD3vaIjqOwkP+mtazMkxwYkdx5cZOus5qhSOWToETFsiV6AHyBm+3G4A6ipP2+wxv6vF/h70SsjGNzP4rtnz/fH7G2wBffIsAwJt3vYISX+sGHN2bUgpJfqW9Mjhwpl8WTGGtBwOxJ6NCZYLD5vLhI3QBhWFM0yiGKGobbJ936OBvXNPwO5l0Pb1UFosa0EOS/BGu0gBvBczDNc6AJDXTBLGzENvqnlSNs96HgLq1N+jyMxmcyK4aCqyljyd55pLK+/Ea+3fFliQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(39840400004)(366004)(66476007)(8676002)(4744005)(66946007)(66556008)(83380400001)(8936002)(2906002)(316002)(42186006)(107886003)(4326008)(55236004)(86362001)(5660300002)(186003)(52116002)(508600001)(38350700002)(38100700002)(2616005)(1076003)(44832011)(36756003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIhztm8goYiUeyK88rorxh//Z6QrqTTQ9v0NJNHHLUUE2rrSRI3vO6AEOjHG?=
 =?us-ascii?Q?9Un2niQfpPquA+t8WTSy9ELr1iNkN/5SSStqODmz7wgg832Vb5ZFH1Au1jQk?=
 =?us-ascii?Q?KTgDUOpU9zT1Hq4ZFfnEKPuh5mcg+4jzjnRfCO/BIrj+2yCykr+TqXClcZYx?=
 =?us-ascii?Q?rff+DZcP1EGUg0U2a7UVDba8lUEbxkOlqJlkeepUS40I51QRXzS4E9HSUL/2?=
 =?us-ascii?Q?oUQzS0uOF6sCbpSeVDFhYxe2V8AqxosfR3ZoWUxpwputOYrpfQ78CFeg+lwA?=
 =?us-ascii?Q?JCduPotI210B2b4lCfifLdBD6XDjBPZ8VbSUmlX//G+G7veqEj/LSnzzFyTX?=
 =?us-ascii?Q?DYJPquc3mssthoU7kidN/0aXOdwA0y6XxZlM0F+JIcH4Z9HKXanRCwpHTdXn?=
 =?us-ascii?Q?bCXSPScJ45l8GDZxA2Fgp/ML5DPoxdgSFqIwEH3Rt9FH+jcsVDa+VdESOo9/?=
 =?us-ascii?Q?ROjJzw6Wz1oDpiMofWKy+5re4wcvXgP50TH4wtAUFYtgDyeEjhvhA7xjobmI?=
 =?us-ascii?Q?ZwSpNpT4OlnPBlClPrmPjQ8Wu22Qj+YmOlNbOkZsxF0Fzst6I+BS5pq406An?=
 =?us-ascii?Q?zRTNi3rzSTJowsJdTGLI2k3/melDkdgq5ycZxIYCZGrWrARVTHcPl5qxy3E8?=
 =?us-ascii?Q?3BDc6znxw/vsqpkkk8Zm6n7X/f/s5T9Au0FqPUIGZV0TYqvOp69wWpuVxKPl?=
 =?us-ascii?Q?qksqugQl9msQLgI9SRFvhNySWQbKmSdNuQFfT7VZ7C2L5SMdu1G3iTHggZDO?=
 =?us-ascii?Q?XOvNsP9TU4r10V0meEXXfnd0GTfWRiJdALhLevfF+heUravG13aOtHuj4xCp?=
 =?us-ascii?Q?IwNqwH2PqsG3oR5YVQfgDlBiKR+UDEPrPaIpVF+QwiuWB+PNG7IeUwDghhRv?=
 =?us-ascii?Q?M6sGQQtWdCiLyW7SNAz5jJqTlHbafK/RfnhAPIjHUIou+ohv+2+Q+xA0w7tf?=
 =?us-ascii?Q?7/dZxbUo2hfhWafme/yWCHFIj/s6ncvn7N1Zwk2h8hYK2b94+//idBiKE9R2?=
 =?us-ascii?Q?JhkrH2G/6ijGn2quPmpO5VUCC832HyI+dnHQapb2BaT35Ta5fp4rqn17hNae?=
 =?us-ascii?Q?dNRg+jWxeAi0Dv+4F3WQN9GouCsd/xI8ryK9YgeHAPBy6Y1uzLTIBzDQ3JIX?=
 =?us-ascii?Q?UmtBrHYywmcmrdP4IVeUvBtxWSkgc59jnbSZhuE59zATrxnB46MuFH2itRVf?=
 =?us-ascii?Q?TKBTK+YyKaIPJfwydRUXFHDJdIf9tEQ4ryM3wPnxSnrox0SR92odF7Me6eoD?=
 =?us-ascii?Q?aHmpyIT/FS8cKnObiudF7V+d5zbmm3BYIjWje62MXVM/GLP62sqC9tXqFhOH?=
 =?us-ascii?Q?JcQ5/oHuN0buHTLxfkGKmtR7i+CNkQHuqlDOseA59qw3Lj7H6uLy5XN7aL1J?=
 =?us-ascii?Q?R7UY7obb6Zacoj0oUulirAe8mflwEaVw555q+m2MWnV77XIV3uI+U/q988SF?=
 =?us-ascii?Q?/6GIzZtFF58zf/Qd5sD4lq+P0E4oh/1oO+eJ6aW75rvhVx02/59aDScQ51tj?=
 =?us-ascii?Q?SFCKgFvGlgYWKApLswSjBgLHJSgQsiwox85o4bREeDhYJoEGtrqgbPEcGmFh?=
 =?us-ascii?Q?ldUkPCAIkwO7yUBb/uk9HVqJt1K6Qgz59x6/B3xV2nwKoWJUlCZ/s4zHMTes?=
 =?us-ascii?Q?Q1jNtQQ3ldGPjKTCALbZkkw=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea15e4aa-1af6-4f02-d06d-08d9a043c35b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 10:05:15.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZTpPrzFNvSuynz27A7HLMHTcVtSCuuNWy0Pz7wHAJzHkaa2OB5WtvNpFfPu7i9KpPDEehOSbKuL0ZOUl0OidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2467
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add test for IIO_VAL_INT_64.
Add check against NULL for buffer in tests.
Use ARRAY_SIZE(values) where it is possible.

Andriy Tryshnivskyy (2):
  iio: test: Add check against NULL for buffer in tests.
  iio: test: Add test for IIO_VAL_INT_64.

 drivers/iio/test/iio-test-format.c | 123 ++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 27 deletions(-)


base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.17.1

