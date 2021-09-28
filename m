Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3575141B3A7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbhI1QV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Sep 2021 12:21:57 -0400
Received: from mail-eopbgr80104.outbound.protection.outlook.com ([40.107.8.104]:10304
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241662AbhI1QVx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Sep 2021 12:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCIqtdJW1lGNJMHyq+9Juq654AnCplmEws7++8Tx/X+ExO/DcnTGOqufUEgXz2gKlyNsadsAHMOzwQ7UiOcBh2sZKNQbClUhRJKOfSAfUftBRephg32eHQFF+Cm6SeUrANjKGkjcrmYAuoQmhLdn4ZUmJt7cbmHkL+RscGyc+e+A6kUO8cNEu+w87Rr/+ctOcOfsKVd0/UO2ibIJOv/QFzgkmiZQbyl2KmDShDR7RPGMxPzqNSV+u2Gm3mGUO/bqDJeZgSt+8MDIa/4/IrYZpQshl6yr+24YnIRY03a9q2j98xSVdEaas3eGqSA+ZCpk18sQH2WfgXLcKW+XdTvziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=drgKpduv1gmpoK7T7V5e0xst3ZyMiH9N/lOTF5uLvjk=;
 b=WfPQ6nUk9+dtojgNBb3S5Zeo8lsfar5kJUqMyWo0Bdj2YN2T0qVlRvFpDcaymQB4fzj4Cs0ODpEl0JXmYUIbgLVe5T7hsflyOYECoAc3pUJeGRc2KVTX4qn79B/98J7fxLm+ZnuY5yjg9DtcxMDVkcqux495GrlcJPqH6vI1qY4O8WOd+LbdtSOYM2q+l4SygIAdNcjw4tvdZgcogPxMM9h4oJbdhprAYXwTPZwCPBQYL9oj6JnKJjEUSsXkNhRHvfgboJ8xrFKn653sUpFjOEitJ4DAtorvjgn9w+ACMLeQt+XCyc8kHIM7GuSW38o0w5ZB/uZcWI6QFVXA8hZGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drgKpduv1gmpoK7T7V5e0xst3ZyMiH9N/lOTF5uLvjk=;
 b=NyBB+tGh7awvaZg8QJhUECApwf6rn9iA6IFhAKK6NnyQOC18wpnfDBCeIIxTyV64Nc7qf5iiJdQEH8fPP4kdgUYNyHhq1ruSD0AOx0LackvI5woYueR1/0EI4SuWgeyh/2xTTq0VcNVl5xcDFeSmxNjoA1UIzwIMDd6ZNYW32dA=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v3 0/1] iio/scmi: Add reading "raw" attribute.
Date:   Tue, 28 Sep 2021 19:19:56 +0300
Message-Id: <20210928161957.24628-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0273.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::13) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a1bb39-0ece-4c17-c60b-08d9829bd907
X-MS-TrafficTypeDiagnostic: AM6PR04MB5879:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB587936F47507ABBACAEA4BA1E6A89@AM6PR04MB5879.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0s3w6fSuO0/VRR8U+QX9CdkBgGlEYqY90t3N81/pOF+07OLI/seTJ9s6QxC6N2Y6/nh3N0ovsuPWC85SvY7tPg4yZV500s2wRgJpgCr5DyztgbGVuYOXTkcZ3aFcHhhjvECPNiDcMz10lytfZaifmJFnqsHTQH8XswI+no0dXCemLkFddMUKibabJMGk+gtJJDScYglGW4lII8zOETCtfgmkJdP+qfqTyQWjYcfv7/8wGK7r5og/nIgtN+LYs84z7YKNOCWrTNstyBdtCF7pbGJ58tFvhxHkj33QPcLIB2u7eY9o4SxIYJed5RKnbyqJALCAtNAjxLdUA8Dfv3iezDN60hpTX5PaijMVWLP/FtzRjLUnXaJkOW2tu7GFVhIZXpjb2RZNq88ykB0TdzCoMm6zwXPQHQQFGos3K1dSaSBxLUnUMVYvZ0AS40DHQADz8zP1rWYGuBtzq+2++5fZTIQpcRL9gS3BdUWxqay52LoiL/qroCwi/iqwrNDywH/B4kha53YE1jZHi10JERx2agI0BgaKHc9eXXNxKkUj1X5rswZ+BnILpSceHvs+bjxjkU8NDpFIuTrVao0jl17PdbTXUkYDV20hYDia4vPSWLAdADb3VsDVtPgpOU+lHrPO7wkCLwhRukcI3aw83SlWdJQ8I2SsX8Nhjw2gB1iLrBGuDUXtImmo+BbCAR0aBEEHfV4LuJVTWNT3Zolv3K64Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(376002)(346002)(396003)(366004)(4326008)(4744005)(8676002)(52116002)(55236004)(186003)(1076003)(83380400001)(44832011)(38100700002)(38350700002)(107886003)(26005)(2616005)(66476007)(2906002)(5660300002)(66946007)(316002)(86362001)(8936002)(66556008)(42186006)(36756003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6WVTvetdDMxN6uP3NdZfPnWUmUIYxPUResDg03X2RtxxyZ/43kwrTsIa2Mpo?=
 =?us-ascii?Q?Y3IYDTgm217uOCqXYwDPBCVjXrubeBInXL6eYVEkv1Qo9Csy7KYXIJZYa4xy?=
 =?us-ascii?Q?110c41oVtQBTY938B4GA6zA/4eIgWkhm+H0+R7EiBKJkGjTNHo0xMR4Sgvg/?=
 =?us-ascii?Q?zJRgEdBTkwEEOI5MapBeeFO+M2O8KRXyPUOPisYS8qCc8geiv1Ihw6zHzovZ?=
 =?us-ascii?Q?2PcqnUuUiRHkMdRKsGcUhJD3k1xoAi9lQ0Eo7+76/ayiOhFxT1yK0p7yybR2?=
 =?us-ascii?Q?MdSh0nXjXXr+LbpNuNiOgsvxFXvfq67ZRRggXXK0eNQapgwmUtCqpIRboK5l?=
 =?us-ascii?Q?jTiauvnEsWAhp4paG1Dvp67Duqoa3ZN+8z2DeVFNNxUkwlemjZUVoVX7VKdX?=
 =?us-ascii?Q?5dUMKmPjWOryBZuoFf8YnvjYR4K58ZZmhCEUH1qzZ7C4l/00sqZ/JQoBDh9H?=
 =?us-ascii?Q?ZB46flZxJ26mxWqVVmduFYCGNKl70j6g4dCUwdyc5RSQYMeFJJ9RtUcTNjtD?=
 =?us-ascii?Q?GgxC5bN8zDAKGDyD9DxW6flTlKE8gL0mgSFffND4SW+eSNTyj3NGIWO+LmiB?=
 =?us-ascii?Q?umwMH1IE7zpb2/Qn3yAu7/RSrJkeNHeUhIQUv/8U3R9qTVv43zV+gSg9pxj/?=
 =?us-ascii?Q?T8F90dFexM2VpWNOzjSuWs5rIV1FvqA7UR4DHRSO9u4v/aGKfI8tIF6WiqTU?=
 =?us-ascii?Q?LJ57f2lOztsdUsLsRuQ9eyXoA4Z19EQv5Wf/9Nh2Ny/305/viioxoUAvlcDw?=
 =?us-ascii?Q?xUYeZ7ZTaqfhqBorOCu5dQ5Hjy/tLDT4SVaYfV33yuMI+ChZLXpssPvygk5d?=
 =?us-ascii?Q?ap2I3J6lo9UZcDGde4E4FJfp8gUMO0sQ6ASuNNmyvLeEHf4oN7U3EmAA/u6o?=
 =?us-ascii?Q?1TwkczZF4qBAXbhTgKAuX5xd18fODMrfwba9aFs+MM73P2j2omcbsnJkvnsB?=
 =?us-ascii?Q?Wz1C0cBEXTdLVeVODab2rjtOKQMnbW9Dc1qAYBk/yFCEfrt+vfyTOO+vMlC/?=
 =?us-ascii?Q?zeW4DdOPLdOAtXt9FItyFDZa69Sbx8dUBo+XCUiOQryl7JZpMfs7+PaylmRp?=
 =?us-ascii?Q?+b8wZNMGHRyHWQdjo+ANEP0BYq/bN2TG7cJlgxREaiJ9kthFGk8FwFRPnWF0?=
 =?us-ascii?Q?Zb+WL6xMBwU4Lzvz1bFGLtsMK4BbigJidfZo+5SrHp62H+jf9TM6cItYoe9y?=
 =?us-ascii?Q?e34fvJzM6HGmlWOSsgI/WV2UHLqMe7Hj9+x8juGdCSFuQOW0umU/a08+SdCg?=
 =?us-ascii?Q?8ehtOPWjHo8jz1/PfCuxSh71GK+btCKLzm0TeymRhlZ7eixgfXNrHf8Fg3As?=
 =?us-ascii?Q?ODuxwAmzsDatMT6DBC//Weo5?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a1bb39-0ece-4c17-c60b-08d9829bd907
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:20:12.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah/MYtqL/4hPAAqzIHlNP7hgDn0tk8/x1iE0kyfs2VACxHtXvoBGEygKmxOJ2qtP38qGUIzzG3bvTUT+1GxjYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5879
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch implements reading "raw" attribute.

The patch is based on v5.14.

Comparing to the previous version it has:
* adaptation for changes in structure scmi_iio_priv (no member named 'handle')

Any comments are very welcome.

Thanks,
Andriy.

Andriy Tryshnivskyy (1):
  iio/scmi: Add reading "raw" attribute.

 drivers/iio/common/scmi_sensors/scmi_iio.c | 45 +++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)


base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.17.1

