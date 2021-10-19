Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF46433050
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJSICV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 04:02:21 -0400
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:43847
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230365AbhJSICR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 04:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjkgqY/LwinGLuSTlZLd+i8gE2pCECZaim/8X9HT0NSHTftcBpdO1fQUCeqc0sRDORh04mL6htepNIo7QQYAD+wSJaP8CDwoNa13wefamq2uTVRNXG2kU6b4edKR4X2FGQpGRNLaQQaXs5Qu6sLz+i2ZZgj4TqRRv1Q9Vnl60OedrENWQg+pQnzGPOdCkCeT+xzVvc+4UFj+3JIZTqoPAbGw3ZIwLbUyhkxPpW1N0pKJtpOJoAJ7u30EBIuql17SSKu+TJ9Bg3DyHyAB9IczHMLnOn1eG/sM5i14sjJkqBn8JxYNjM2pFrGxiDrI33dj3939/FPP9yABlNTRzJNIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58+0n4A/DLQ6xZIdV2mn9JjiIVlJhTOls2tA6dZNx+U=;
 b=DX4wZsItQNP1Xcrgcm2rVwgFGFms5117QeUQKnZoXhJ3bdMrU5AFz4baKPYM1ylyiGaohzA/njRntVLbEoc6FXy/skdtEEQy0JE9orPFcv/7uc954mWjCEeGHoyU+HbF8yYteyjZM4SLC5Gp47oThj5e8s4ITG6356J3PgOYYSAqFsZ2bCUp6pYIYO1q9OtLONC9Vm21wZ+UJCEdwY7+HgkHvXjrphjZqXlFxCG1TVSfCbFjiLBHYPVzEQr79yRMQ0RmbeRQN646/0s+1WDfuVXiDcUe2OgsTbdZ2Cy9pMkEwzanVemafw10f3i49mb6stCjkYuO+LKsqmsNR1hIzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58+0n4A/DLQ6xZIdV2mn9JjiIVlJhTOls2tA6dZNx+U=;
 b=lwc3HA6W3tO2Ri8TJERZOkdH3pBiFnOGcpoP0sBGVHj9g11jLzMYQ9/BgJe+RBUvCOncIncZXmtlpKRqm4irm7fx7l+p4AVJXKpTrrvwWdzjgdi1x8UzmOfll+Mh3okQWWUoaZ9ZazhdnA8xwvt58uVPQstoWh+NYziepxzToXE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v6 0/1] iio/scmi: Add reading "raw" attribute.
Date:   Tue, 19 Oct 2021 10:59:48 +0300
Message-Id: <20211019075949.17644-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a35e4eb8-ee61-459b-bc75-08d992d673fc
X-MS-TrafficTypeDiagnostic: AM6PR04MB5159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5159630E33778304C74964ABE6BD9@AM6PR04MB5159.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zH/1EvA8w5AdFWZIJPUx4MknGmRefIiAmZvX963Eypzcj/YM3+oqmHF9Hgw0hawpfehuIBLYzALfDL8lHCqJYNf0pmgMFYqeEklGC8JgjSCaZh+YxKhKlRm1S2jzD2aYcM1xGZgPaRK/4yz0e1FusRhjvNIgSj2+pfzmaABIU0iXUEEgVLj8KaUZIV/fWBk1YJN32lYp4gwoO4A46eIj6az1gGXXN7oi7yjlaM9NuLlzui3szqNvmgH0LTNytaaKfTd8bHufd0Nlg2NmFzmXhS6WYlefkVwyt1OWdAuUN09O8ipYTucwLUQLwPJI33TYEghTTcza7ibPEBdJ3uaJJ0jS6belWHuv0zgKhyC0w5DYZ4Kg2gtuIeKCL+loj8A+KcXVo9l+jOkS+ufvCVbJBkk8gTmwlvs26sK8GvHOtSackQwEzluwDxW6ezB/gBPqLeWRP8oHtFcacnWi3B+GhRanckt5biuEGIs5/wa+6rUYIg7qf3bdwc2Ojsy2OzDbmAbG4ZHMK3EeqyW2dWgSgimWgls6mBPGBRtBAG4cStef9opfDPRdOCYDg16Nn0rcoqqzYEL+n+ONS3Kf6YUij9Au0Jwc6kWRAax3j8TZAhZFjlPESg9uzajk1bnLU70Gk0M9ieFGyJKdUUWjWBgizDNxT9BnCqBATjED63d0z/XgeX3M7A3TOW/yHONVCZPH+f8c7mZZb/vKohgNpyPnqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39840400004)(366004)(52116002)(107886003)(4326008)(66476007)(2616005)(44832011)(83380400001)(8936002)(42186006)(38100700002)(1076003)(8676002)(2906002)(55236004)(86362001)(66946007)(316002)(26005)(5660300002)(66556008)(186003)(36756003)(38350700002)(508600001)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JgFv8heJ2JHCRzPYRni0pWd/ecn41lts35C7wTv1LvDFYxbFfHLQ+xz/CnVl?=
 =?us-ascii?Q?E2fyqYUtwHJDqOLYogs8GqKLCBPPc1Hu4KtUWvWU+cCOwx5GJos3UBZ9rlP5?=
 =?us-ascii?Q?W4PkfPYFYGb4h6zpbjzZEYk6ayBS01nGOzlbACPpeeJbHJkP3U2bKDT0KAyF?=
 =?us-ascii?Q?EOe+9xepcCwiNeTOKQ9emDkEh99IOQHeZx2RmiOfraHJJNSB/SyPXLB78zGa?=
 =?us-ascii?Q?a6RujY2VabQXgThouo5dWvbCvwBfOFx1qtLityv0KR20p6d0eJBty7RwsmHz?=
 =?us-ascii?Q?WZNkhH9699xU3nXfoHo+rMfTROW6JzUOJjQ3376VV7fcaZMtFz/UBG3P+01k?=
 =?us-ascii?Q?+Z1N4tQDzv/uUR0U999xCmSVWsaDbhwJIyZsNE6H7tAmDN5wj4sK0G2vR+5j?=
 =?us-ascii?Q?m5zyjEyBP4DmYJkHAqTGz/LplXVY6AydFE8QaIEmlxkGsa+oZ2Y/pJKQWZF7?=
 =?us-ascii?Q?A6e4HM+qSen4qHBny8G5YcHy+AlmxTPoo99lgYBDZ0H6n4yPjcKzlGILvfhB?=
 =?us-ascii?Q?4vyoajPPe0pMxta1famJrRkQRF8ICqKZhjAdoEn4yQFzE6R4ioaXg9+LRA/2?=
 =?us-ascii?Q?WTE8MTfs79zDqcD+7ctzESajwyiGtZPZb3/tqUx7s83xXvSjwiISM7dy2Z4T?=
 =?us-ascii?Q?s9gadEUd96zIHEMNdq0wwBxtDF+/rceorB4e6hUlXWoXDZR5J3rB8kjEwe8T?=
 =?us-ascii?Q?kQG6uZyr7FylD+R0owXVgWcmy0zIFfIDq2nR2kRk2tvOgaXIgR+xsZFh5JH3?=
 =?us-ascii?Q?o3RWxntZgjJyaeoDTZ2IR7Y4S0Y6GsCdy2NBu05n1B+hbevFmbOZuWx60pBr?=
 =?us-ascii?Q?rnDi2qgD/RJeq5x73EPlD6PSdTpuTo+NiMKk7g1txnmaR4mY0yy/y+Al4sAS?=
 =?us-ascii?Q?imQ0Ec06M7afcwTYC07h0kTt8xqQ+78V8KOgFbTPPmXkrWWGrcqBVIZEsWhb?=
 =?us-ascii?Q?/KGUBS+LERJ06EYuUOJAAyCCnz5pueUk5ljjQd6TCyCtx5Xmcl2qChiHwOOx?=
 =?us-ascii?Q?+lFmOGOhKhVVBAkWX2E74WNXDEO+DqO4fKRAA/XAXWmFPsxsPoIpjAVHQ0NQ?=
 =?us-ascii?Q?n/vNKTvaTqI16NmtowE4Jvt8eI5gyDKFsrBnS4RPkYTGKw0bGjKfgcnPfWRe?=
 =?us-ascii?Q?axgPjmE4pr9XUgvFehAKmMumuY18vhFg0tSL2zSpFYNGjNGLUm+VVhqpkQKI?=
 =?us-ascii?Q?amR4TQ+P56TO0EzawxLxmyCNg7vDMGq88SsBPAPr6e+oicx0qDagCPSQ6/+N?=
 =?us-ascii?Q?jy8Alpy19br0wszwjBRmvRXeyT29t7NQx+8i1GVraBX9Lro9P9RKwxQOBNEM?=
 =?us-ascii?Q?BJcDlLU0YdX3MlIgFQ1b3VbQ?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35e4eb8-ee61-459b-bc75-08d992d673fc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 08:00:01.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glat@opensynergy.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5159
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

iio/scmi: Add reading "raw" attribute.

Add IIO_CHAN_INFO_RAW to the mask and implement corresponding
reading "raw" attribute in scmi_iio_read_raw.
Introduce new type IIO_VAL_INT_64 to read 64-bit value
for "raw" attribute.

The patch is based on v5.14.

Any comments are very welcome.

Thanks,
Andriy.

Andriy Tryshnivskyy (1):
  iio/scmi: Add reading "raw" attribute.

 drivers/iio/common/scmi_sensors/scmi_iio.c | 57 +++++++++++++++++++++-
 drivers/iio/industrialio-core.c            |  3 ++
 include/linux/iio/types.h                  |  1 +
 3 files changed, 60 insertions(+), 1 deletion(-)


base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.17.1

