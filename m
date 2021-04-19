Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4285336443A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 15:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbhDSNZz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 09:25:55 -0400
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:12610
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241115AbhDSNXW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Apr 2021 09:23:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7zaHRLRI1MEgB4NwSx3+JhfyvEhLwyMC0BeAV5gQgpSnQY7UZ9nbo0ZJZr96LoEbBvC3Ku+nO4UeZV6gLB6U9uUWOOvdbIlHSE0ppGbhm9ycM9UD/izwO2ohkFvay2IiOYyPtV4b23+kis/2dW/ltLupHtuyLf4Ya9HzeBH+5jhWHgzdCdmh8s0mNa0Jb3pdAfCRpr73vpq1w+o/TUYMS7Br83MdZPuClBDBghzDwNhBJuHnwK/uMBvVo8Rjnl7i6UeACV7NW0aQszBX1WfejmlcdhhevAlIGmurpFdoVlAg6IU4TKEHNGDVYAwRCe3P0XBv9hRiEZQO8hPYs0BXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJCjI957nGK17dqBxAGK9n6eItbIlAXbki9GoJOfHaI=;
 b=bLofsXf2sA4j+JZjSISmJVjpK7jPx/lQBlzKrsYzyi4Crwh4zsDVuPHlDu2Kb5ikX5pTPybbH6kDOCCvvDJ3jg3mVpvBgZXgftQSP5ausfdZH5G2BH7OanPE5+OA/GIwO7qo5kJmTqexfmd1ntGBha+KR9C4xLtLbvIfbXZuo6z4oKL9L2nCRQoQMSdc3WsOVhrr0VGwon8GU3bwrr9ezOdTS4UU8zlI5C9WhfHm21N1IyCUhrqRnsmHCcu/8KtYl45woG8WJHbt6jM2/fKaqC1Sz+ND7QyNCSk1u4FXfFPH5MM0y5OK+jEcKvF7xJ+zsZn9GovS153+WuedkwKJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJCjI957nGK17dqBxAGK9n6eItbIlAXbki9GoJOfHaI=;
 b=xW5fBhmf/WnD2vRpsRNiDvAyWB71xAziW59v2c3S7n0a3ejldKgvuE0DlJGg/ZSLEfPMwSDtYxMOqYY+uCmMc6x0f4JlQ/XlTUzwAy5PNZVPUqljz4dHb2IZdiddUD7V4V9aI+ytS+Gj33ygxhoQkCOAc19o6HvDU6B6jTQBEEwx60RojBZV0kFkgCUUOUnf4hWkQlR9fX7YZtdMek7BVymBP88C0TxzvN8QO3OmgAMEQ1fRZaCDa4F3EBaszojIwpqg2tY8BHpaE6uNxcdcUqBcKyVzDqxCPPwfnfEKX1VtrOwGEujIubV4DsodFdM55l+pExlswyPbpKnRECNLBA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR0601MB2109.eurprd06.prod.outlook.com
 (2603:10a6:800:27::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 13:22:45 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 13:22:45 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: accel: sca3300: Accelerometer support and binding docs
Date:   Mon, 19 Apr 2021 16:21:57 +0300
Message-Id: <20210419132159.4450-1-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.localdomain (85.156.166.106) by HE1P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 13:22:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5a8f7e9-d535-44a7-4658-08d9033637e6
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2109:
X-Microsoft-Antispam-PRVS: <VI1PR0601MB21096BE7FD60306C33EA20D1FD499@VI1PR0601MB2109.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5H2ofc6mUleryffUQLsqWqPczvjcLDzz8iBfRXm5dDYxtOhvv5rwQ6V8RX7QZEz7jDTV6PSxfx175FzlxufGGxZyXxKmvC6FLCndu/BBWpvLuNGYWbO68af2Ap6jymb5ai3EOkZOU6pLEcvcFviv2ajqTIpCxpsA64ygInV+dwjhDgAx2WpPc4N9qcidIzRkWROHHc/S/H6d4tpgyEGB1Ib3reAOknrjYgdgA6/stY0ICT86cHXVHRUFbTuU8h5J54Zldu/LCI09YHzpzkJM9AOLLEQ3BIF1uiDrLrRCj1AtPF9XHN6YWJSmvkzgjWwOxJppg4RYeL5GCww72xpTqIBOg9lK6UQJT3pnz8Mg56UNpOymUioF/drQBAVkGZoE4+i3NqnTw8IL5Y6X1/qupy2M2I6BjRFDA4o776yZmoCm0oi5xr47Gy9GmYGSX4G0My0gOv+qxcXXH5/pGZOyYcRqNBxx+m7rjKIza5gliST3yOy8zYEkzpUPjV3XlDOiY+cSWrRo1oJ0FE/i8SNQDUCb0Bg5xuJZOYCPlY7wTQWjZX7TjYdDssGUKBD6ONR839XXf6ru1Q63Tz9jqXKFF032VVZjVq8Y4pvtB9Ge2fDY+629qC3WBESj2KGfpWqYavICgmR0kQObp1QbW0NAI5EWq7jP5XgoV5z0UAIm9Kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39850400004)(956004)(83380400001)(2616005)(26005)(1076003)(86362001)(6506007)(44832011)(6486002)(478600001)(36756003)(16526019)(5660300002)(186003)(52116002)(6666004)(66946007)(66556008)(8676002)(2906002)(6512007)(4326008)(38350700002)(66476007)(38100700002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HRGkfVXS1BjoLNyfnMFuIurYX/Pp4cATW0cc1RP/rYCyWIzAESe8oRoWckdZ?=
 =?us-ascii?Q?8xTJ15GPtL7XhAmQFSBc3/4d2QzcJZqx8SXibG9EC/01DcO/fh+65HtEf+dA?=
 =?us-ascii?Q?jO2CeI3zEvFCe7r3VtLpOYbHYmYKi7t0JDO94xavDOzPXFdLKTVKAiMa5OnE?=
 =?us-ascii?Q?pUgjVPSwxH2QS/TFuQG06yK7OJuNvK3DDCXRdb5Z/CbAzQzYvM1B9LPbbNqi?=
 =?us-ascii?Q?mY8vswMOa7lTITV2HmnUXm48b5+a37W2JZRKkxh0UYGXyMolE3VCeNB3bjiP?=
 =?us-ascii?Q?vCwpqZwKO6Dr1qip1jBYoQdrZkorIFHp7JQMHqOlNSLSdLvNf2jxqMwIepEd?=
 =?us-ascii?Q?WlIjMfUUbD+zpGWJuEG1jwKEbobyBsvvTMSR/bP9V5mXIaXOZcgwvya0BVan?=
 =?us-ascii?Q?wV1MCdA760bJs9h+nfCsoXukj07W/Dh48u58KdXvkKHKS4bAOUCQHvkKh615?=
 =?us-ascii?Q?4ZS8X6YmWPaOKFs9v55f/OMESWFOJnqaUtukfL/hJzDEcgxcO18CT5XEz41x?=
 =?us-ascii?Q?I912jP3qQQImhHeWZNnF+e6rzgB50ze51d2+o+T0LCiKUY/1dX1Ssk6Hqpzk?=
 =?us-ascii?Q?c61W9wiHk1qvKdvvEi/UmtlomiBsQfJ/m4HOOOLJ5Th7/vDfO43YmlIvX9KL?=
 =?us-ascii?Q?UUSquwLA7q0Wj1kpheXqZ2W9cZz0oK9Ra1F1ZsrNNACHWIn8a1jysqbDjT4t?=
 =?us-ascii?Q?m4qVZKjtAxJsLxP9vwB3vf3MEhIMLgRVk79NQPehqHf7I52i3NSN7lymxRlj?=
 =?us-ascii?Q?AzszjyXR7D/ubJJl7DSnOoeVylJuv39p9mB5J7qFqn5t9XMvw8Od7JKjh7Mt?=
 =?us-ascii?Q?jKDtmYEKGXSBC6VFBDGlo27D2tkuHxtWaBZbe+LOgUMCo2ChGqsOlNDVgYeP?=
 =?us-ascii?Q?5ESKnupMMLksqE20JMlf6WryOCBXP6pd4aHYR9yhs/1lzJYhul5z4xWDFGk+?=
 =?us-ascii?Q?CKwv5Ur6ZerHxf2S2FBGJvF/b2M7I6PRHsDdJ7yzH6bro6GSHmELXdISMKD9?=
 =?us-ascii?Q?1hQk5cRqqfu6e0++je7CElV9BvvInxn6oWgmkzPr9wgm8o1hm+yLDgmK2g/2?=
 =?us-ascii?Q?fWOMWmeS5RlyrhdMHFS+DeaBqqrz9Fi58l+Kt2y4IEh0WYsH7mYSrFP0rJoI?=
 =?us-ascii?Q?v1S5xgUki4CLjCR6VkFi/v2ANp5lyaC1zkbQRBRLhsK4Z6UXYyzo2n/R8xj8?=
 =?us-ascii?Q?+sl5bG2q3D/fJo1wk+QiCyAf67NB5qqw2h1OKnWJzUxYtfNgZE/u+z+PjUv/?=
 =?us-ascii?Q?2eLq2X6HucmwsM7Dz13HbXrMNVCSfo3p1y2zPANvr8tgq9XxS54BdDPt9IRK?=
 =?us-ascii?Q?UHg7+24dwI+ZIEyUGUU6yivX?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a8f7e9-d535-44a7-4658-08d9033637e6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 13:22:45.3089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbigfEPKUyH1IjMwMf1RBxCX1W8VneQyD8gtXLngHltsm8SNGPlnqvlwwOZuBvwJnEpaJN89VuXMBkmJ3hXtGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2109
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Patch series adds driver and dt-bindings for Murata SCA3300 accelerometer.

Device is a 3-axis Accelerometer with digital SPI interface.

Patches are tested and based on linux-next.

Changes V3:
Addressed comments from Jonathan Cameron and Andy Shevchenko
- Grouped include statements
- Revised SCA* define naming and grouped statements
- Changed to GENMASK() for masks
- Indentation fix for ACCEL_CHANNEL define
- Remove field declarations using default values
- Change to if(ret) style for checking return values
- Add defined mask value SCA3300_MASK_STATUS for return status
- Remove redundant type casts
- Clarify comment wording
- Refactor to remove variable idx and redundant else branches
- Unify sleep in device init, separate sleeps not needed since operation mode change dropped
- Drop redundant memory allocation error message in probe
- dev.parent is set by iio core, removed from driver probe
- Drop of_match_ptr()

Changes V2:
Addressed comments from Jonathan Cameron
- Add manufacturer name to dt-binding file
- Update spdx license statement for dt-bindings
- Remove murata,opmode devicetree property in favor of driver scale + frequency properties
- Add copyright year for driver
- Remove X_READ and X_WRITE defines
- Add _available sysfs attributes
- Fix errors in documentation formatting
- Use ARRAY_SIZE where applicable
- Use get/put_unaligned_be16() helpers where applicable
- Factor out error handling to separate function
- Return only negative values from transfer function
- Fix INFO_SCALE to return multiplier instead of inverted value
- Change INFO_SCALE values to be actual scale instead of mode value
- Do not provide INFO_PROCESSED values for user space
- Add error message for failed data read in irq handler
- Move trigger handler timestamping as part of pushing data to buffers
- Document startup sequence, providing reference to data sheet section
- Convert iio_triggered_buffer_setup to devm_iio_triggered_buffer_setup,
making remove() obsolete

Tomas Melin (2):
      dt-bindings: iio: accel: Add SCA3300 documentation
      iio: accel: Add driver for Murata SCA3300 accelerometer

 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml |  44 ++++++++++++++++++
 drivers/iio/accel/Kconfig                                       |  13 ++++++
 drivers/iio/accel/Makefile                                      |   1 +
 drivers/iio/accel/sca3300.c                                     | 462 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 520 insertions(+)


