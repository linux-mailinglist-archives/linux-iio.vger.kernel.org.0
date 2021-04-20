Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB343659E8
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 15:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhDTNYk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 09:24:40 -0400
Received: from mail-vi1eur05on2079.outbound.protection.outlook.com ([40.107.21.79]:25344
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232260AbhDTNYj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Apr 2021 09:24:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewY3eBINvRwD5FKackAKfwCPJi1ABAY4C/qK189cT5GjcvyaNqdo3ZoFZbg09jr/X/6exbw0fQ3ImgK89HGqeAa/PTyygVhfPP/RRPHnyTUdkXTnDOM3GvDqP+77cotA02UHHVpltBcf3i3gqRMu9si+5QDl6zVTfPiASMUZewjYMWsbsHW1frX0Nfi75w8I1U1Ff/s0SwJwKf8ed60AC7kvRRix+24+pYxa5PCzLycrBK36+nUc1mFRKTEFZLm/yGEznkGObjPMspO1M7+AAbPFi5mdgdK78+VmezOGaT6e2Fl0LxeaLIirR6K5V0HEzPHnUg9uUhjq0ZPKohQRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsNh2QODgWkOaIEtguQysjbreWqCchDkfN7Tu3/aSe0=;
 b=UPVKewFeIQ9r/kQ3ZJYuBSvIHnmefmKCKQk/SVZIF3XAYgqRb9qKHxRZj96gxK9tMWWPW7AXwcF/QendTuIW11tjc2xYbx/koQpdzmbHn91zFKFXO0pUMSqpqo2SpnIb2aojyn6MVUAp/2wLSCZMZGRph9SdosJ0/mUq9r/esmW+iEHcv745pRM25OD7iiytzITDtW3cbKpwtLKogQZHgG5RpvmNklHxsozPk6vkE9NTHA12koOkjjzuYk5FsfiYnC0jxYr9IgpBc8+5N8cohvHNU2Pf8a2iF1DRrxWjPFKACZc3sTMUpO1TQu+PPtwCw/S7krDI5G44HmvbmLMWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsNh2QODgWkOaIEtguQysjbreWqCchDkfN7Tu3/aSe0=;
 b=Xke9sr7zxddjXrJn7ralEr92HdQcIUWV9/XVieayjchR729xX5Bk9IFPzHsBDZEEzYvQmBgB/T5H7j05/O8hPx8mXfJDFZCdZovzA8HRD644pZ89hm/fIxY1tLHjCmWwLzWTO/hxm2vRxD0HktulJQ1i7tmQrhgNF5J96CYt0G/kqJBidZBV1PFEAvLsWFnH+TuKzOwBwl5itkoNLyN0ekPl+vrcTf1Vwp4M7D1HXFRFkJGOeLKKbxnlv4JyXapAlZDfJnpDZWWRgG/2Dx8WD8uqZCXcBFM4s9HqMoHmOVc54ai3lBTVqWI13Pn1K3s6rxixpXfpiWhaGwEQCl9P2Q==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VE1PR06MB7088.eurprd06.prod.outlook.com
 (2603:10a6:800:1a8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 13:24:04 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 13:24:03 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v4 0/2] iio: accel: sca3300: Accelerometer support and binding docs
Date:   Tue, 20 Apr 2021 16:23:31 +0300
Message-Id: <20210420132333.99886-1-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15)
 To VI1PR0602MB3568.eurprd06.prod.outlook.com (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 13:24:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74c6015d-1f65-417c-2743-08d903ff911e
X-MS-TrafficTypeDiagnostic: VE1PR06MB7088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR06MB7088F8FCF598FE11E6BAE950FD489@VE1PR06MB7088.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AMUULysck2J/xMdcETIyiSs55VR4aFec0n0nOTo71/3Ny/Zm+CTMsg4EbK6qOmYncQU3MKxRlsWmIfVllqY9WjfN1H+EwQW30oNgHw9XDaEm6moNq5AYget0Cd+L0YFEnBOhe7TRtRJ12AtyKJgxbJvFCsdAKT9cqg8q7NBLaYeNZqrMz9K8lo5BUjMldGUuGG47ULXqB4F3QeNZFYBaCYXSiqJBRx3SsvN42gV+jJaDSCp1Fqc0OeWq/+dGK9zxB1Fwy56SRUwnmP8ncCFmPu5H4AGo4ldsZR7vX2BvB90O2HDr9dSdvgdLHErmwgQ4PLQmkWXOy8TsOZeJZqJCKX02oax5H9T0NRJ1i/441Upxdre29n/W93O+d8MqDb5Qg0Nd9D/jartw6A+QSXoz1V3cXAstJbsbPefknAQO8e5UYEt85Kx/+comjfICMjK01jDC4qNA11LIe/3O5e6xC0j/ZhWkfFp0hzXG4li+9VHrL0jI2zrqvByiidD1EDw95DBYGubI3UEsq3fZP0Fupt+r4yoDu4yH432ZAI+uEeoyNL8AzanzJgHndwiiGe0k10o7rPVP1db5R+ZNwjFd46sOiN4Q7sb4D/gN6PRQfmRU509eKP3Hm4G6fTRrzHkKn1zd5kAhzpVHpaDxHz/5tgPfp58o9uBigwJZKgpXZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(8936002)(66476007)(26005)(86362001)(66946007)(66556008)(4326008)(498600001)(83380400001)(38100700002)(956004)(186003)(38350700002)(8676002)(7696005)(52116002)(2906002)(5660300002)(44832011)(6486002)(36756003)(6666004)(16526019)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RQ0o3nAXZOF03/4+zY3sSjrsXhxdAVIM76LW4j3w9etUUFT+nzvJjn8yGqhS?=
 =?us-ascii?Q?DNM+6MvaOILidSo7G8W35g/DEHMJMSBi69jU8krWqhNXkNmweTOAR5Zm2yJz?=
 =?us-ascii?Q?mHHnNOpDMo1m3K1K6zrCAqmDlr+BOTaYnr+H80Bju6bykevsqMaO++DlaKu9?=
 =?us-ascii?Q?d27E7QRBbkXMZ5K4Zswv9bOxXq0+xk2PTKw204fc14wmtB4IuOknqHR6I+qa?=
 =?us-ascii?Q?FQFrHEFaurqZ9W0cF05xml4vpH+pb66TYeA8T0ZPXX/EfuwNzg7YHlvorieX?=
 =?us-ascii?Q?Ycfy86vdxg175FpxXv4jHsMucb6WXNSWEkICY9d1uz3b+lH+6WFWn8H2onSF?=
 =?us-ascii?Q?3ZMB+ULdEB7EX6fI2MLOKKAHpr3eUyBv9g4Zfw36mCqg0YshT5mpZ313vBzs?=
 =?us-ascii?Q?F/LNGJjRascqe4sB5lwMo+6uN31oBapgeK5dkBSTAY625639Ax8XGp1udLXj?=
 =?us-ascii?Q?nxJJkV+O57ksQ6SdLjqsvkWiIQFI0BbMpOJerQ7PklDRz4JLORHDcmzHQvvG?=
 =?us-ascii?Q?4CWi/Vo4AO7FVeZB2e4twNCQuDm8EnEGesV1XgShmH2sfMSlElwFGTG185/h?=
 =?us-ascii?Q?w3jk8hdUzmnHujxcWiKN06S2YZhwXhWOKB4n5KV2+EpTGqlnGjS+plAdlnlq?=
 =?us-ascii?Q?7UOETcylODwqhD26RuAoFvfOebTKzOAHzyAAJful6KUhHqHcX/YNa1LGSav9?=
 =?us-ascii?Q?bnsSjkFYiJTw/J5rSH1sbb5A78BPBnTuQ4mcyION1WUhuVAEOVxJFOmClXyx?=
 =?us-ascii?Q?h5aemgiOoXq03FPhZQ3u2cjiY+vQnrFHxbpPTTNwUT5kZ1LbYl5AhT2r15j7?=
 =?us-ascii?Q?GlLXhA6PfJZxMr/bJzQ86tNX0q4pR2XhBthPTsqtNrpOH3vxo3+KXrnvB/zV?=
 =?us-ascii?Q?KN5HSD8zAVL/vHfPOIYxIJGhKWIOlt2ZbIIQ385/OhA8tGGNmYa+Mrs8TuVK?=
 =?us-ascii?Q?2HbQaz+Do6EYQ2WtnlVc4lPAbnlzxuG1mgXqWu3dB6l6jOLqiTr3Ha5uKJZh?=
 =?us-ascii?Q?mD+RYOD/wR+5lw2MPWbqkrei4a2xVJYK3rvHHKzz/ZoMHIoFluq7MM2ix5MQ?=
 =?us-ascii?Q?7kcU6cfLnr8bcQ4HUtbRrKv4q6+l0gaoQO+pVss7v1vAG4cXt3dnRVn5qOOj?=
 =?us-ascii?Q?8B3kbglhfWBDhCeS2riODuJ71bD+6oxmH7ZyydrAdWtFiQVm3YUigAOcVKa0?=
 =?us-ascii?Q?PCP8dbRxr2wbN2l6VmZ9VbMxvuxPzAbhP3rnykcNIqtdU8z+h2U5Y2FaSIak?=
 =?us-ascii?Q?Ad6JkcMQT7B8hEFcQfApPcX0KfOPsm6Vv5Hk0FJbigEN243zTzTW63o4Rmkw?=
 =?us-ascii?Q?e+tpYfrGv5ZzSsyY2LA2mdgi?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c6015d-1f65-417c-2743-08d903ff911e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 13:24:03.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAODzOpVPH9eay08HTQ6dcBEQDIWR3GPbRKi29967fM6DyjgTMmjjyNHjEeQwXOdLzL2SSuEV1jqpnIZ6ZGF9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB7088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Patch series adds driver and dt-bindings for Murata SCA3300 accelerometer.

Device is a 3-axis Accelerometer with digital SPI interface.

Patches are tested and based on linux-next.

Changes V4:
Addressed comments from Andy Shevchenko
- Regrouped and renamed #define statements
- Added cacheline alignment for tx/rx buffers
- Changed irq handler print to be ratelimited
- Commented use of goto in irq handler
- Removed redundant 0x0 value
- Spacing errors fixed
- Removed redundant return statement

Changes V3:
Addressed comments from Jonathan Cameron and Andy Shevchenko
- Grouped include statements
- Revised SCA* define naming and grouped statements
- Changed to GENMASK() for masks
- Indentation fix for ACCEL_CHANNEL define
- Remove field declarations using default values
- Change to if(ret) style for checking return values
- Add defined mask value SCA3300_MASK_STATUS for return status
- Remove redundant casts
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

 .../bindings/iio/accel/murata,sca3300.yaml    |  44 ++
 drivers/iio/accel/Kconfig                     |  13 +
 drivers/iio/accel/Makefile                    |   1 +
 drivers/iio/accel/sca3300.c                   | 470 ++++++++++++++++++
 4 files changed, 528 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
 create mode 100644 drivers/iio/accel/sca3300.c

-- 
2.21.3

