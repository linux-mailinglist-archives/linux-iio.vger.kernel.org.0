Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11BF4387CB
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhJXJTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 05:19:08 -0400
Received: from mail-eopbgr140127.outbound.protection.outlook.com ([40.107.14.127]:14414
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229638AbhJXJTH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 05:19:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rh47TM0tSALRwZxWhfDxrUu5zMyagqGaxTjq5GvCxajBh0zpdtf0ErJXSHMnmhIonyCshUGCNMrQ8d0MFs5Gm7JcsN9sXS8uZvjRgwR4pDhx96em2oVwr+JoFujThJ/wdUtdcTxctPmUS9I1hVaeqc53DAzYbWRWOfBIN1LQxzpKqX+oE/ywSfSVwexXftNVBt4N3coG5fO8hOa42iTb1tFgVaz8Z+9/fnuHhiosiwta1p0moTRaBIukvB8Cw8Zedn3CwNI7nYGsDIXR/fm0fxPQEvtvxxcJmi1ux9YPEcdukAd2oZ7wz17sNdgu0Lh8a/kpNdEbbVMRyoN4DQToyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu2T80M/EaknlX9p0bLRRQKbYVdrUFofE2g3b1uypws=;
 b=Naq7tuYqiUh3LhbDdgUJVj+sl6HFHjP2TRed8lw6x83nMF28j56f3dt1IAjWoXigNerYx08237UEYUTqtZwY7Lm1fUZuhXwteTjWRDgQLDYAdLuXkQK0RdY4TTs4j7i+9COLvGNTjtz6Z2n/nMSU4bXDR+qgrTH5LDe7bVIBU/hUXOhZV8OVomby5N6k9ZNUMPEthowyOefh5MFvzrG8ArJTiVVJ3gMJ7wgla0mjnNHSDYr8ivaTOYUHi6mp88w6gXDWH3l9NDFFw7ZbeUWyLEDoo/l43bLsBro231qyGJHbRSujUrflnEsO8aK6bTn07PbVGcXpUoIuKAtceeJryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu2T80M/EaknlX9p0bLRRQKbYVdrUFofE2g3b1uypws=;
 b=QLutZQkZ0XE/9CeKFNm9jvbybguy5zBUD4QEgdsiIAlJW+RDSdpd1zfMlglWN8QD1O2vIeXLT6DzuKC4QGB+RcuIyAU8+O0OSfMb5XPa3BBgLhy9ba0fblDWKXZPp6dfTHdpG/CEG00Ej8ILvdkMnoSm5024bbzarQtcoDY7TfQ=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com, andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v7 0/2] iio/scmi: Add reading "raw" attribute.
Date:   Sun, 24 Oct 2021 12:16:25 +0300
Message-Id: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0035.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::15) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ea2a81-8f24-4c72-4d93-08d996ceff68
X-MS-TrafficTypeDiagnostic: AM5PR04MB3011:
X-Microsoft-Antispam-PRVS: <AM5PR04MB3011031E11E22EFA93190205E6829@AM5PR04MB3011.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJsyABD2yAcN/ehrMAUBAGkLDj1qG9mvSnp33846lwd8zys8+WYYVrUPtz+ccRSnMdIE+L1hjQU2Q6D/JQJ0kP4v/hqsxrPNcWQjS2JxMw759ygoLCDPTFaD8e9EvlOaNBFw7Igcn8VZC+tbAtUDejmQkD2bZknRbP8xCzEP06NYLEl+fXZc1NvKD141anlZBLVXrkCwoH91JnNM+csGY6psuykx+05PDg3228bRWD1vdnzAsTb3TeUrR66JYcTBEFVtbNqUDYj5I8KoVNCL2Kbc3f+UnN8QaY10FZyNlUJaW9KLpE8IpEyG4EsNgJsBXZzoh8lzyusycab26Ok7HlgPsIqtlX7vCAyIclvlJXBX1hT+0prg1c98QJZ/o9on60lmcv+NoqLwb1gWn9Clml6FjZdkPBchYdTMIj1L5yDdgPNCxulMkZnnM293hHi9w/nFB9PmI2HQEbfV65D52iJjmSLIKKxYxwH19yBnWvrt1xMBWf1e3+TIPdHQ736V/dCnPKg77Dge3S/nX/EpIBKjKa+NtqRhOrxTQ9VX7Cts3+30rLr7zg05iB6/jsM0+m/Rb4Fp1e/niTj6XAr5ARN+Jv6rPbeorfGRTKckmZC2pMqgFBPxRptG/IQvomc+fErORT1CpisJEIo4K7HBkBFUprlktE9jtTDOqr7mSG0P4AttarIH7ielaDbDDob9BgxsfVpNic+f8BI98Zd4pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39830400003)(38100700002)(26005)(66556008)(5660300002)(2616005)(66476007)(38350700002)(42186006)(66946007)(36756003)(55236004)(86362001)(316002)(83380400001)(44832011)(107886003)(4326008)(508600001)(2906002)(1076003)(186003)(8936002)(4744005)(8676002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6YttaIsl96i2DFLMyYeb10KQEN54ZNhEd1lcy4wvJbGgZ2NN/ydOTCwZsy/s?=
 =?us-ascii?Q?eftDsgvPxEXaFqWkEZbVTaZM2MCDD48nb3iS2dhN3WOrCXlSeKDjvxU9GueE?=
 =?us-ascii?Q?BLwaJuAIFu6XE+jyv4HkjWvV24AMBcvgiRU7dCYNKTtd8fMfSKGYYApHBIxQ?=
 =?us-ascii?Q?EgvvPTHDeMED5wh1rIlfYnOiGV/kEOvN+TdOxHUtk6otbHM4nXRqrXbGu8S4?=
 =?us-ascii?Q?bl3iyjICNt86NMHUjp+30gVZjPPazNyIWWipQ0D3N31bYpF17fF6m3cUvl//?=
 =?us-ascii?Q?PMrBbfD4OQA7POb/3fICwo4jPL3YpH1xBt5mMOb/41oxIh1u2lvq5I89cH2U?=
 =?us-ascii?Q?QPiku1OTjVJ0GWa6+CnboZeigzV0CITSF5ItW/TgYecGa4h/g3OFbhOHPe+N?=
 =?us-ascii?Q?IoAFuyi8Ip4vHq73hgJhA/hGjESgd2J2u6v9VHgSITcLfbbb/GLT2vCfZbhZ?=
 =?us-ascii?Q?c60I7L9avA/aF3l6iJrGbTpgSzhOXw8+BkrtInb8w/BZ1mtHGmSU0jYABbPW?=
 =?us-ascii?Q?AlAn249QYMquiyErmM6+9G4FaCOGQmjKmWtH4+BoGKcMkONjsfYtd9rBLwmQ?=
 =?us-ascii?Q?NygQcL7hs8sWUPf+QGCZ0R/z4NwmdIYWQiHYxvlcC8C6eOcFt9gMgHvPKQQt?=
 =?us-ascii?Q?hfIWFktvrLojNQ58vSaFojNiPkdnvmH4PQeO9CU1M3HOnt+IKsZkkDWFhzF0?=
 =?us-ascii?Q?SlPTP+Z//Db7xqxGWq9ieUBOswQukkj7QfeatLszvmEnWW1oz9F9iRYnRc8C?=
 =?us-ascii?Q?DOOus8tVN0FhQdeXphufLI6xRpndg+m9KKmIIeBXM6d1SvVWhrzOgxvH7zB1?=
 =?us-ascii?Q?cYCS5X5BDAf3dZO97IsD8tKo0Nqg03729eSQKLJcB4G1/DYdhbr7u1WcllP7?=
 =?us-ascii?Q?BOKcmpuHiHxkHTSZ8GCZONLnKTfrrUaPKRq13p10r+D0CDDXe7k/I2OhpMif?=
 =?us-ascii?Q?znvXP3Wf0KwZJNOzWwStMyxp6PA17wjVD99HRF2E0XJq/gF38s7JPBLR5qaT?=
 =?us-ascii?Q?Kjh5IBcXgPpjmP+BVJIDG9W3GfXLjAXQVff859J58JkQRcZMurIH4s+kuZ/b?=
 =?us-ascii?Q?DEnHl0HMk29nT3/bV0uFRMd/QIyyKIBN5J8io82HchCQv9+RJtweHh72078L?=
 =?us-ascii?Q?br9Lt7aP/4xQ+D2NV1viwRWHtzNzODsCFPKvyjAVi1ToeLiaItHP60njgQLs?=
 =?us-ascii?Q?oenXRCCgP0z38wuJh4qhb/NEhkLtY0odrJKuyzz5KleqBFcT8tdFuqGOGaOO?=
 =?us-ascii?Q?x8iX4Q9BDcakXgJRoyjlz51CUb/DA9C3RlZ/Ye0+tUSXde59uhXJcI4IjviV?=
 =?us-ascii?Q?jJSRMvghg/lnIuBJ4y3dFt1k?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ea2a81-8f24-4c72-4d93-08d996ceff68
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 09:16:44.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eby5KMjVDLaV4o90GXQ5LRgO9KsSx0wRLBjRSOsgzbO8wtprmqCTL/FKRtHiovoisDG0c4j3j2uY5C1ZVuYKPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3011
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce IIO_VAL_INT_64 to read 64-bit value for
channel attribute. Val is used as lower 32 bits.
Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
reading "raw" attribute in scmi_iio_read_raw.

Patches are based on v5.14.

Any comments are very welcome.

Thanks,
Andriy.

Andriy Tryshnivskyy (2):
  iio: core: Introduce IIO_VAL_INT_64.
  iio/scmi: Add reading "raw" attribute.

 drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
 drivers/iio/industrialio-core.c            |  3 ++
 include/linux/iio/types.h                  |  1 +
 3 files changed, 60 insertions(+), 1 deletion(-)


base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.17.1

