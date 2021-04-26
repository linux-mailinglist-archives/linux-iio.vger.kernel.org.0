Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ED936AF7F
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhDZILn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 04:11:43 -0400
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:10563
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232181AbhDZILl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 04:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAf+rBJVRYcsfMasfTwmhRDVZFreZJh4HM+R2/+J58Uz2Jh8BzFhKW0PoYakNDhT8vz9iHgUIWFrL5VYSXp3lxrGQ0rqXUJiT9JC2YN7rYY19Pw2t+YPpqs7m/Bbt1hBAms5QYDT8oMBZUL/GX7VnzCfsrNr6hJLumGuK/W5ToqrzP7DWHao+gFOeSPxcN1jKdee7NvDI9Sjnx2VGZBZgJQopBHXnD9If90fxpxWl96Kki/ZjjxjhHu09RtC0z1IR1X0Zh6g353otOpMbW+JCUzLWHu7lp9HWaMv0xHOWJifomtgd1b8KKX/zMzMhNAGb0Gdu0V9jPu0M3ELXgHR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AkaWbsal2xSqkH6y8IacLyb6aueTq1eZihvFCkrx4Y=;
 b=N4fhSrnlOPe+k5oyYekTKYq+9nnFVjovsyiZBGOe8fu/onykg3KsbwdXGa3HuEFAGiHzus1ECSfcDbEt0remce9x+EiCa6m9gqzCRVA29pcxDTiz1uzBly7Fp4TY9+S07OaN00+N2M9/N+ii+S21z7rCWTxwzDO+C+RFmJAWPKZ9mG9CeqNtwoMIgz3m0CK3SOoBBOPrVa4CR2YGeEkuMWLvrZ0pqZ7csBSB2/I/O1j4X5zspfcH620kFHjFqsF+4MrW8GzGjkmln3BHq+onXr4m/EetPB23EZJW0zUUERIITm0m3uIeXfu5XM67ZDVL/a4XHt6K8RYCngV+eoix6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AkaWbsal2xSqkH6y8IacLyb6aueTq1eZihvFCkrx4Y=;
 b=CbAluBnf5kvROqbe8TmFmdYZKgEqAxa6UVmQwWDYkeA7qM0n4839EH9MxfagagzDXiWDGvXSK5ayyqN4ANd7NuU/BDyTPFzCXiFjI4K8d/NJ2VTcHEo0N4LiQykx7zNEXSQcs5jxFuxc8V3dsbVCBrW4HV8jtjUQdbUMeeiyzlL0lGxRLjnGJUt7Rm9cxkood5PiACssjrfoMnSAneRvpOQNc07amzIAaPSqn3gTkysiTmlmOLr8oBL2nJEbgoQWto5gJfExMiXDW93Y3DXX8qP9aQjMHWVfW99Pd0FciJfkgiiJHp3sLukqZY3C7k+zfpkzU41/Xk23+yG2fXdL1A==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB5888.eurprd06.prod.outlook.com
 (2603:10a6:803:d8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Mon, 26 Apr
 2021 08:10:57 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113%5]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 08:10:57 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Melin <tomas.melin@vaisala.com>
Subject: [PATCH v5 0/2] iio: accel: sca3300: Accelerometer support and binding doc
Date:   Mon, 26 Apr 2021 11:10:39 +0300
Message-Id: <20210426081041.59807-1-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:7:66::11) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1PR07CA0025.eurprd07.prod.outlook.com (2603:10a6:7:66::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend Transport; Mon, 26 Apr 2021 08:10:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc53f07-5402-4910-e681-08d9088ad228
X-MS-TrafficTypeDiagnostic: VI1PR06MB5888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR06MB5888B67CE53625586A2806F8FD429@VI1PR06MB5888.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgaWK6gwcj9uzOSrp7DKsUu3gcg4C1vLYqvEEVu+2on+YD4Sa0UVTbsCiFHcvDx6/ALLl8Mcqinr/FLtR9+BbmDVDBu8jbaxg6vLxC0k/Lw9yBbtTaIJq8gcVhJAMrfaiYg5AqZg8yrBGqDrfe9YOvcuKZJysCJd7XwGbEhL/R6p0ZaArGLavgM3SSRSazlWIxNKMB78xeuky8DymvrpsEDwbRbmUkyw+W8wIVgUKWHcohvLYkH2h0I8jbo8kGl6/6cwbPbEyRVUFWFTZD49DLmdByf2NTbiUCLdZQqe485gbE9yaZ+/F7alfrLSfdEDyTZRjNuE6NkqkW+WyQHHpQLueI8sBA2hMW06C/OAla/kmp+vFtOT37hZMe4EFGzj4PfMWliWgWZhD9sRa9KEKMV7kFZ6HPbgLzoexPoKyvMNGx7b5BCrho+ccyKYj+Cg76MLf6Sp7KoLQI1vofM6KDpu5hwI3VeRNBJvw0IR6vpujJCbiUg2lK+1q//MCyTrrlqDkFYTAZC0bDZdkpYOv3ftk62OQxkf1WrcSJwBOlQZ5wzGbCJwV1kJXN592QM5wqokGQSMgV0jUNQ9zrJ8LhuWEDc4STHJBiNOHH9x25cXS27PsHQr0V4XYTlExlGfm4HnFo+hykfFZfaOIku4HSXVC8fH4X3I4037J4q/AcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(346002)(366004)(396003)(1076003)(6666004)(956004)(2616005)(86362001)(2906002)(16526019)(26005)(186003)(66476007)(4326008)(8676002)(478600001)(66556008)(66946007)(6486002)(83380400001)(8936002)(44832011)(5660300002)(107886003)(38100700002)(38350700002)(52116002)(7696005)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6+P7KYIcwkE3xutX6wM/I97tUj4wrsY+3c2xpL8j0Ez1kmrBT98UQ+v5/rUk?=
 =?us-ascii?Q?mODC8QM0opN9A1rKCDV1y1VHX8p/ewuU0pDJMNip2d6NZ6BbLJNl1/qfrl29?=
 =?us-ascii?Q?9JkIescYwxJPb6RM5Lp6k8rauhHheYlj0BOF00I6fDtgyA3+AUF6V5FynXZK?=
 =?us-ascii?Q?LkM6apXmFm2S/DcLAvIqF0eKkI7msBf5tijJhtccRVDo1VRK9ge2aMQUqt8R?=
 =?us-ascii?Q?HIhH00sVHDnXL6PfYtEwPG/WsnzgAaNSYcSW+EGzbipUdeWPlF96lB05twkg?=
 =?us-ascii?Q?WTaSFQwridI5JZC/ca6mYbO8tGO6zRhlcLdkg1c7F6PBZdmQvVTLpljpIUB/?=
 =?us-ascii?Q?ag86T02GQVvBLqz5p+pyV5Q4eIjfW1Lb4yvnEfVLJK4sVwBuEc6teWWbxw1b?=
 =?us-ascii?Q?OnvU/YsCNeUBjWRvX0msjROwvvgFhteiwKv1Qo+oO17bMc/J1K/jLo8kSWe6?=
 =?us-ascii?Q?l/I5kcYiUQnaNzCMmZAwCG7FzVF01+NHBaQndF2TkbxGM1s/iP6S3XewkJ7K?=
 =?us-ascii?Q?r5Q5gptEZA6hYxJN+ciT72xY27UCJyrbabQoEh1kPcN6x9RCS7LwLA989hHS?=
 =?us-ascii?Q?3NZMYm15nXHXNifXztfGBAqk5M+4Eb1cDCutmdxXCPn+lNA6B36I7GhR6XZp?=
 =?us-ascii?Q?1+hE6Y2WcHgyfJo3dEsRVgun/GkMH6/HqLlfeAPRW9A68bA+1O/hGxKoswpF?=
 =?us-ascii?Q?wMhF2jceQgPXZMkG7NmDU/p8S19VIvkdJ07oN80HFvpmU2+F/IkMwceaRxOn?=
 =?us-ascii?Q?n17C9AqYCB3ufGAoxuPGWA0/1HAkosjsIRNxAOaXLMJHkUWQlevHpd3CB8xx?=
 =?us-ascii?Q?EKVl+S35uN+4igw4BE25ACr/GvzL3ymFsxg85USJNZSKVVxJCA2SfwhXNqG0?=
 =?us-ascii?Q?9ugOvYJQdiWUuZOUzs9UZOG3tkY1xq0rK2wA0LB8L31iWpBzn8ShvsKpfGCh?=
 =?us-ascii?Q?fZdzNNugHvdeOyGNM6LS0Fa2wDhQkg1B6GOsDrhKJMV5d5+3KpgT1HmH0sEv?=
 =?us-ascii?Q?HkceAXtXiiVkX+xeaA9I6zCtgtZVCIhUnzGrPjq0MHOGYvL2ORYjYjb93wN/?=
 =?us-ascii?Q?J6sjgsPQahndctl3XKYb8qGwwOkN9w39+7sZTi23kKKH/gjttHPNl2ELGUAb?=
 =?us-ascii?Q?W3fqaLEQeLhW4KAZMlMldAYY84qeBltxosmh9Uugou4x5fkJ8+N4GaaU5LRq?=
 =?us-ascii?Q?RujJKH7uwo4GLuotHePqDtuNILsXtRM7sY2zpm9B+Ts0ivoPa84rAbYNgK8d?=
 =?us-ascii?Q?LM21yrbfXtWR3xf2c4RoXYBTNDeGIaKtLUfnAgEemZcOoaETQ/h/kbabnA5d?=
 =?us-ascii?Q?6IqiVnomU6aEKjgVm8a0UZrO?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc53f07-5402-4910-e681-08d9088ad228
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 08:10:57.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G2GHULnCOvbXQq5OKv2+b3PrUpjqb6SAPGFTtnCty790vGYaw80iSMpxW4+qbMa8Wj8FFwvCL3lxtNR7dE9MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5888
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Patch series adds driver and dt-binding for Murata SCA3300 accelerometer.

Device is a 3-axis Accelerometer with digital SPI interface.

Patches are tested and based on linux-next.

Changes V5:
Addressed comments from Andy Shevchenko
- Reversed xtree declaration fix
- Add clarifying comment and spacing

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
 drivers/iio/accel/sca3300.c                   | 472 ++++++++++++++++++
 4 files changed, 530 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
 create mode 100644 drivers/iio/accel/sca3300.c

-- 
2.21.3

