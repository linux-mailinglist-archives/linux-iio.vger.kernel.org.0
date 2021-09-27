Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21F4194FD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Sep 2021 15:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhI0NXz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 09:23:55 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com ([40.107.8.118]:54460
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234158AbhI0NXz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 09:23:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkSWvqFexIgjBkfm8iO1pXtDBcRSFYaPZRFSFPzHMxg36pCJnQabZ3J/H6WmjVw+CL5Xlmbd0jYJI9HegkAf7/tSA+3mAdrhuFC3NyvGc57LvfW09B+JEV2apGWyCHy69f//iDdCzUKvNq9rbEF+VeDoPVMwRo9pN1KBpdquIlnrD2plKly4EePxA3dkU+uOq/FFRMkudfYvKiXk5PiNjBdAMX/rceHP6J1fH+4oTP9VkfLmMMJwODNJDR99PUBsTgXFmQ4fvtiwxh05rUHXapGbtlQTLpyCklk/97uEqI9UdifopHbZ9JU0Is1Ab15SQUDcTwnMWStk0qwng9VSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Y72iKfecoVXuMjWhiVPqdMkisElM8H3XIo3Qd76zmQE=;
 b=QudaJoQTKaUm3w4qYHm/IQ9J8S3CKsS/IiNbaB29/9IKBSrEv1GsLKBvP4XH/z0dIZltUD5HhHaNmIYlSnjv+aWxtIzP7Fgff6jv8HW8Xdko+GFwdU+PzXaziIwqn4iD90+KkxMjWWMDWTrhb7TYhHbgZ1J5yHOW7zkMZO8yV8njUNeodudhD5Sob/tK1WrtsjpyOp40T1CkT9AUuT/kK63X0IBSNFFiomy7IvDNvwEgpzSzjuGmyxgdbsyt7ceqzHsSyXSYgwG0o5/DXcf3GfAAyH4BsqlOdDEajLvlRpfSlVCHkd8yape7OJmDwS2hori99k9UIuUyU37I5O4O+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y72iKfecoVXuMjWhiVPqdMkisElM8H3XIo3Qd76zmQE=;
 b=l3epd0LW7bxs6+wPR6EFWxmYNKKfiu6sPmalYMioFuC0BmJ/Zee7MVVkuoDj5TqjZcvpuOd0upE9idHoBsSf3/E3VOEb/G3EpDfiK4VAcGDSMxCQ3xuW23AKhTgiZWCkhFVQKZHNx9m1JeqKxcvY86x5lJBWEucAXRjmaPeQAvk=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v2 0/1] iio/scmi: Add reading "raw" attribute.
Date:   Mon, 27 Sep 2021 16:22:01 +0300
Message-Id: <20210927132202.17335-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: PR2P264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::24) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3062795-41d4-4ba7-ede4-08d981b9d2a7
X-MS-TrafficTypeDiagnostic: AM7PR04MB6950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB69507167DB174DC427BD999FE6A79@AM7PR04MB6950.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tin7N+ZpEHzElBKJdQKvU7i20ikV9Nc82bmskyIValUtXvy8bULbUAGjxlQkLbxTeMYkz+J3QnCB47nC91BBwY78+pCcfIps9D4N0SBPdyb0oSktbszg7QOrngEP33TUnMZGuD9TIp9bFpw1APxpspntsTMVwdW3FssdnCsJsdaMt46ufsh2XF12SbPJD2GFoMRxGih420dj5CKx07ZAYSaRFARcy9vvxSLrrXKBl54VA8F+zqSZguAMS8wiQLA6IkBLJxQJP0fjV3r1FJ88m5LzRcU+qCmWK8/GbtW1VcVXEuL8U0LNxpVh0/HDwuxsNrOIHZ6FN6rGgRPgyNk1mMPZFyMbjFLAAyFbKTo5+yXuaBKZMij7tn6z66I5HYB9AQRgsr8lqwZ6Xo23lV1eWyIyxf61L4kxbT0ZrI0WPwhUsrqRlPbWwuhmNuPEWhSMPG1OqwMmtnYVlVD/cJlHvSisB35zn8ir5KiPEVjpupWYGkeAZltDilgn7On8GBmjbHbbuKFsSVhHLYcXN6mJNEZ6pnR+2zjL9YRoIVHcgIJsWsnVU+6KSfC/jlqtzDQA+hrTm1JzDNd3Od0s6zGEQT7eRZjryTXYwYVP3mUjmE7SIYhnnvM2kzZ2bbqFvLvfI5iVWq0f+QZhq+HgLqRmPpadw8JykBHR8eyr220PhK4omFQPYJNv/1jWeByXTrIKf5KlDCtjD2Rxb8g+7s4j8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39840400004)(366004)(136003)(38100700002)(38350700002)(4744005)(26005)(508600001)(107886003)(186003)(8936002)(44832011)(4326008)(2906002)(52116002)(66476007)(42186006)(2616005)(5660300002)(8676002)(86362001)(316002)(1076003)(55236004)(83380400001)(66946007)(66556008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IhFRNakxvjhxQr0optTPR9S3UjBZY7WGXbZ8AGcbw9oTsFnT+ZEx0eZhebcI?=
 =?us-ascii?Q?Tg66/9BOSEjMFncHexe1g+NYpCIOTYOhKX1Oph1EhoXrot6wPXV1bC93gDid?=
 =?us-ascii?Q?ZIBrs9xoyFM6vhSfPRYWit2/8DM7gnJoMTnHaIpURjehhZCHKzUcA8nT3rv6?=
 =?us-ascii?Q?/bdGWwOUHMZaShEaxBgCnpk0z+Q03UYeM0uRzE3DhB5+S1QtKCaVkxELS0Jy?=
 =?us-ascii?Q?9dfy/hhCyXYcEpKySeMFC9l9aKQmRIWduG5YEI/UKVnrR+l9mTOoO0ky6Jd6?=
 =?us-ascii?Q?r/7r5C2ayi7RXWf+ZM0CjFkFbjoHXHJgeVBPX/Ex4KVXYJ0uNKAJmkmfYbTk?=
 =?us-ascii?Q?eBWsRIiiZhshZhe0SugyhLKaWp1k3k++MXMAynrROZtzXVHuz1tdFf7Toxgd?=
 =?us-ascii?Q?mMP8+X3xlH6dJxmHRU51SqJKIS/OWWQsQoayL/XygemlKfTUUmdO3WjvoCp9?=
 =?us-ascii?Q?/GrbEdtuXGgHYkd12Wv9T/uB8xaCGNis6gVEBZT/8uxnWw4C37E5YXtD38AR?=
 =?us-ascii?Q?ZwK6j6t+kH7eu/xnp4Vk4g75+rhKwIibdcfp7x4ykZ/cJXibd/o9W84D8uzX?=
 =?us-ascii?Q?GLCMtnq3iHw2kZdsrhdGnR6hn44eO1PPc3smgX0P8Jbjpm8oMSw6rEeLcoQj?=
 =?us-ascii?Q?b1PAppLiZFW1ozXyCENisq9k7uSYFWRQ5eJGuE6aLHAeXIQwK+xUS6LBLr8q?=
 =?us-ascii?Q?rPGR78gw0HO7c8/pyLDIdPDCvu3tbvolsT9n0uzlwH+1TGALm6U50moTzzbo?=
 =?us-ascii?Q?Vtl7BsECVsjjDZx2KUh3PnTH84NZB6zlTpTCqGM68aWLb81ItLVrrNhB2Qqq?=
 =?us-ascii?Q?LxXMXevYyNfSR2dy24fz7a7UCycHZ07vy72WNmbCaz6GSqrz9wXbLJAMRZEl?=
 =?us-ascii?Q?JAaRdbv6rv8jlHtaxQO9l9HmeKANRk36wEI+mCpKNLLXGeWIiM5jP7RPXb87?=
 =?us-ascii?Q?4NKAaNr6Xe/K1uVP5BVRG+cTEmzFYoU52ZgwGGqFXgJ6VOhM0Jd0Ke+jW3LJ?=
 =?us-ascii?Q?3dIsrlhwP8vzFFX3+LBID5xq+xG6As4dcz5ZOE3JNJDXnit2tt6T9lAh+J0p?=
 =?us-ascii?Q?KUpONkCdCbozQfo0KglTamvLUgfKAAzzY658XyTUJWTU50TTYRLWlnePLQf+?=
 =?us-ascii?Q?9ll+YI2ntCndp2xioPVVtTCXoBiL+iIIjav/mAu6SP7SG0clUGMarr49QZJU?=
 =?us-ascii?Q?CrkJpT3JPxRXs2fste0WcburHPriWabSdh5gPd4czrEFZMXLZPNJKqI4Qp7d?=
 =?us-ascii?Q?BBPdtzqDxqF3rSfOgk+oH/VrkB8OjBsXmBscFfhBzhytHIvrBFaUh30LZZUi?=
 =?us-ascii?Q?drKOP2UUciIWbOeke1fwpXn2?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3062795-41d4-4ba7-ede4-08d981b9d2a7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 13:22:15.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jxc5x0VoQtMy/xqc7vl9W732XMAZWJmfLIufW6BssMvRnk5r/re25rqkhvaAYJddN8D3IzFSoqA+MFCsEWdPRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6950
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch implements reading "raw" attribute.

The patch is based on v5.14.

Comparing to the previous version it has:
* added an error return when the error happened during config_set
* removed redundant cast for "readings"
* added check if raw value fits 32 bits

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

