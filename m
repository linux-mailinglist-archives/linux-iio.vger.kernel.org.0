Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2977F41422C
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhIVGyZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 02:54:25 -0400
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:57248
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232799AbhIVGyZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Sep 2021 02:54:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cELEm0XBVE6PF/PuFTTL8frNwCJlsPcC/JW8kGgPxXd+zCH7z0HHR4OOong8zvoSj4r+DuxRIiW8AusLWe5W2KAVLjVNv0/AiYgEluH99yiLMj5i7ZYmwa0ZnBi6yUGlxco/Hev9aM5yyGPQiI/kkx5zb3Azd1LKW2DPLwARgqI32eaWgvKP8T+yFAxrkqqKeo6d4WquT7JAOtyGqnhJ3bln1FNQwo1aTHnVnMjv/f1aTsxRIV1eiXb0nWiYojbt8egkxWLUVn2SkjxrQPXnaZTYVrpivnp8OAGreVzWGMbt4FgqyuZBR5t8HQRa9smIGMsT38o1R0zpmvLu19mJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xAfJpOmomzHeMbt6duIporV+ziPq5yHy99URg9eq7qA=;
 b=gegujq9j66hw0BOxODBJiOmC15nNRWPsN6bqVEqQmKFN+TMELfo0Rn+i/MzAneBUNKeR/uZf9y9fykycnUgNzeXz2reFFoNJ6dNLZP2k/afCkPSu0Vg3Eri8JPxY58uIPGMmVnA1A+qv+o5jgDfJUzB+4NJnNKknIlXWPyeku6EMZ4ncehcBpu5hALs18qLtZLlG6/SgX30h8g9/xal89xx0hlDZ789rRaDnNwiqk37Krn9qpz+vP5yAlehbdeyGcxPxhzmMXdsRKa+JFZYXK7afAK1iXMdZDD2ugcA8GjIbXtnAP5cle9egoK4+cGRAmtV1MNYBnHgLWYW5dei0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAfJpOmomzHeMbt6duIporV+ziPq5yHy99URg9eq7qA=;
 b=OVk9o4jHIk1NwuOSEjqezaYOBnS2cmv05ftNpGCLd585zcO4XHsBKHa/9C0Kj1VDf7Nv8+yRLJtAt/wHJ5UjD2AnHW9xFK/jq6hXpPqAA+xx1knbf6naRDqI38uUtXpEmdbihK/9Fgu5fFdvW5JZ1zN/YDOEO7UmT+n0fTOj6C4=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH 0/1] iio/scmi: Add reading "raw" attribute.
Date:   Wed, 22 Sep 2021 09:52:34 +0300
Message-Id: <20210922065235.12891-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::10) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea8aebb1-e14b-4a16-0486-08d97d959973
X-MS-TrafficTypeDiagnostic: AM7PR04MB6949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB69496E269937BE20D2E438D3E6A29@AM7PR04MB6949.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65SGVZ5o9kwUaCWvppXjVXhW8O+pgHpigY6G1B4JSt0RHre43uWm4hEF+ck61PRRbztnhc4vWG8jozaD9UQqjGplN0uyieHGhogPIDu94E89b5U0PahjD5jzr0bT1M+8fyyHGFeHVPdY0LYgXkvP46TLT0yi6RBSPHJTBftpkx4nN3U+5fBS+yGFWNyWs78DzGOdBqg4p7ybp8rKO+jJjtC7gbL7fUXbB14Qbqg1AmZwMVoiQAq0smLyRX2SkH2PWonrQJ8K1NAuJOC9FnUAVGoHvUV0IR+0s6O3eyRL9F2HAe9C+EAP5Fwd5aQYuylASMnlkZhegRlT7i++F2KnBSeoCDn2Hxc2ut1mhiMX4v1LdHrDPrZwpL6LhIp5ua+/x5dDGiHLEXWVIZiWjAcEbAwJAJzTo5Nblp4lXIfCqRVB6FJ2ovIPNst+hUi6enK+g87hO3vAZOHmvQATryYvEE+6NqW9q+uqLAp0CPPI82W2Gg15TbmV/Mbnd0UneUG7PCFW+6oIMlcKf6BLDJ3S9wvtddU5MQD/66duZ59edLCgkEp+6BK0JN6LNOlDW2l9j+RfywZTc2u6bzfStXOAY9JnEF96Yhdmai35HZ2KgpSj+BGF+tioZ9RFn8ng8vi7XLvJ8qEt5seEkepLoNcKsGdP+Mi0th1HVYCarJEKXB/hFUmQ64ILPnookXc56Xo0zs3vNOZiDT0bkiaBEJDDxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39830400003)(38100700002)(4744005)(86362001)(1076003)(107886003)(44832011)(2906002)(5660300002)(8676002)(36756003)(2616005)(38350700002)(8936002)(66946007)(55236004)(26005)(508600001)(186003)(66556008)(42186006)(83380400001)(316002)(66476007)(4326008)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MwAKzS0o5TX7+yAB4YWRR5C6Vy0UknMhknLqUcvdg28BJLneBq0+lBaZ3KdC?=
 =?us-ascii?Q?6nVYXrXw5vs7cXVQnjPBLuU1QaoImtsFY67eKC2PU2TOWcdoosgiWzoUnKbr?=
 =?us-ascii?Q?5r9UY4uazQQWIO4KUqVSCPb/M8Hj5HFwJQogUcGDlDO7sUOEp1wdT7fFc8WR?=
 =?us-ascii?Q?j0ZjUZokWLopxUrFuEXiGhR9Mji0wcZI/dQ5zTwHCTmoCm/9Xnp1gYuHFLaH?=
 =?us-ascii?Q?EjuKNJX/Uto20cKZ8y1W4Cx4ourFEQMDIMd8SZmNKXhePnSV8L3dHRQ8qQgT?=
 =?us-ascii?Q?4QZu/7Dgp1XL+tsy0wWoiukJ3zBZZ4+ldAgSDbxXuY7xD0VdZ6PaewMf4CCK?=
 =?us-ascii?Q?4Q0GhA0fNLq6smCN59/mF964/JX9oz2memMnKGT++XXvnVEkbZsavzjzaoMd?=
 =?us-ascii?Q?x+8/5xKUFWNK1f311Ja+emo4XwcwyNxWnc3xJzqriOZs0nhGm9NQ0bHwSm/3?=
 =?us-ascii?Q?bjT0FVA37NCFXoBSEWF+IZe7Q/msM8LkuPdmjv9xqw2UrtL2pcm00nkwF+v6?=
 =?us-ascii?Q?jR3PCnIeFZDz+hPPeQOfg9x4SWAhP5mG5hv68hQg8rlaYkQRcHOkMFLyCMh2?=
 =?us-ascii?Q?v91CVlKjCkfF74W5yEyA16nreRAvzw8bZrTfDmK74r0IFfNAOnrOQeE3uOh4?=
 =?us-ascii?Q?EvfjvXkZDIOyM/CYNpZLJlZCA+HG+smsJTpenYYN3yepfigYihAvjN30QrhH?=
 =?us-ascii?Q?uEwBfkQh05r6m+nXfUyIJbW3uX1pkqx/1+tgY4y7chwVf7VnTqeskqtsKVvG?=
 =?us-ascii?Q?kjOlLgUVBzZ5RRRgAX7QnBpI/7sbonKgyCsataeYwPs7Jc6hKHGuXJS5yiEz?=
 =?us-ascii?Q?l76LhCeoEyJFtUQQkHQ5gRgSvPFTQntCc9l8Nq4pI1tt5UUyNXmU1Xd3soAR?=
 =?us-ascii?Q?2Eu4RqbY9m0MILt0gq0OXfUMGWKMQNiepsLlmokgmlEpbLL2ZtdeiBRGvJ0O?=
 =?us-ascii?Q?4Qd9zYWDltXz2XyZXgD2sa5I+FR68ZXRf3OsvzAyg0HHyWyl9hZ1lvwjIKac?=
 =?us-ascii?Q?zYxeuRAqxkEd0uKrTB77GqWEB21KSxJMkcEuTSLX3IvVl0NX002YFyD/gm99?=
 =?us-ascii?Q?AxHURPTE2W7iFkoAut2LeqOVofy3/+72X+I6JvsdxxQMbGzCO9GL0yk/+thM?=
 =?us-ascii?Q?zYxfXFHXLXvgsszHRwkOOdjgtACz+cJkYsrmdql8o3y8z4bUhQkyVNLTg0iz?=
 =?us-ascii?Q?g/MUF1PlLmG3XjGVPqOd54krLjCBi5hulKr3Mb/IhA67t4tGlPYbyS9HO5cY?=
 =?us-ascii?Q?ukBUritfExaVTDiFWqA6OPBJPLuTAspgSu/o7lLwZGqXrNSO/tH40j4gtSQc?=
 =?us-ascii?Q?GFQaRDi3OmkpRUWZG/zUj/rw?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8aebb1-e14b-4a16-0486-08d97d959973
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 06:52:52.9245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHT3Hh7s0n/QCk/8NgZbUB3k+wagR21U3oW0FPuFHFlenoSn8lyYHJksBIkyCVdjwXEBkq6zTPzlnALfiMAeMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6949
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch implements reading "raw" attribute.

The patch is based on v5.14.

Any comments are very welcome.

Thanks,
Andriy.

Andriy Tryshnivskyy (1):
  iio/scmi: Add reading "raw" attribute.

 drivers/iio/common/scmi_sensors/scmi_iio.c | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)


base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.17.1

