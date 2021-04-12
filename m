Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C575335BB48
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 09:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhDLHvz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 03:51:55 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:63973
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237006AbhDLHvy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Apr 2021 03:51:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auZcfpHZicWJcjJZdXJVeABsHcr6IJP1PixjzPd8ReSBx9VcqwP7zl4QaqIQohsG8enEZi2IJaQjtFeDIZuqFd/OgownsL+5xxFZ0yVrqwDOnV0qWM7ZGdq2HLHHIBTnEa+z5yKbE/xO2HNNL7eVTOtCYouT/xkSmI3r4UZTwxvXPdNeBtj8Jnz7OCuNr1DCh1rGTXW7GoWfhEB+Kf9ppV6jcbx3ZCjebK11a0keG9Zvy81quH/IhbCPLMpblZ9qmoCyHNRhqQAfPwwAckVc3Khh8KiHP5i+Q0PmVsFas98AfKb6NJp8MfngDiNG4oEaiF1NCkkP4G/c2VsQ7unOcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4LUqqZnkYd7MubbOBcjWTivNsHJm1uehMajJXwZY4E=;
 b=M5npSeQLBbWMp7rsZcRgRd5NGMe+2wrLGBTLhflGtIXf2pOBsoNMegYKmNxJNj8USLLSJ0g5Q9GzncgICmziCGeIo8F1+VVpcq4FT1iWpyH75mZpobIzmr6SNoQNJ/iCeSMHgiE92FSaeZkDb9O+tbwVUgGjPiVspYoXLV8odPkrVoa00n0wp4lpXIOskNNKN0qlRt8PBsRZlRcNxBKAa9wsZjAKjCgo7yhZxdu1+SvSw2K0mUWqZ8ca2tmaAz93AwHmhA0ZyRREgFdh3OeX6kecKyRm1fCr8oTiI2UTlHBBt7n+29D8cXx6AhRG7tDbubGUFQC5BKfqQBzPTZNIiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4LUqqZnkYd7MubbOBcjWTivNsHJm1uehMajJXwZY4E=;
 b=uF2mMQvOAVkB+xtuzT8JItnm7b5sOBK3xYYkyRiTMudsdc8qt4EyWYZ4TANAJ6/UBBfj9AmGQDbVdq315YQH+/WBJUYAVY0sNgbjeuWd8UypTu2pbiXzb45fzEEGMA/wd9MITSnYDq+OuZsfIu9FhDK9jMWG6kHkIlG//4PrHBNJKap07KoXpE/ymLNQJpjSBGn0u+yesxn2wzLf7ISKfTGSIGIfVE9+etlcP7gorRIhIEcpgQucAs32NevhW6j5Iu9Z8KhmQG9W8LRmOmjkO8/94gwPwl2mBCYka1/cFre7K5f6PH8sdVQZwh9LRxpeoC7zVXcgxdKnl3A9J2iO/g==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB6800.eurprd06.prod.outlook.com
 (2603:10a6:800:18c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 07:51:34 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 07:51:34 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Add support for Murata SCA3300 Accelerometer
Date:   Mon, 12 Apr 2021 10:50:54 +0300
Message-Id: <20210412075056.56301-1-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR0901CA0054.eurprd09.prod.outlook.com
 (2603:10a6:3:45::22) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.vaisala.com (85.156.166.106) by HE1PR0901CA0054.eurprd09.prod.outlook.com (2603:10a6:3:45::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 07:51:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21291301-fb03-4516-f408-08d8fd87cb1a
X-MS-TrafficTypeDiagnostic: VI1PR06MB6800:
X-Microsoft-Antispam-PRVS: <VI1PR06MB6800557A35D68A3388D085AAFD709@VI1PR06MB6800.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Shl20OwQhsBdHkBTvjGTn0oGs3fgf4zZnmpjoWXr4bL4V+WbyEPvagS4CJgGf3gAeSrAjIgh6qm3vipm6bExLU3Ty/BCo1Uq0bAZTdvl/sNqTsKTVFgOMp1hlMedUz0rEZav67TSBS11G8Ef9nOAOQrqGVozHVgt4SMO7jUVZECJfcerTz+co1j2BWeFCBqGwJI/7klXt0hMFfK9/BEWhSIwl05xgVIkMUXOX/aSjZNV87gn45qmzKIZUlyIBVKgRY+KRaSyh9UImEJi5DxA2LXJHVvGSnC4e/AAb/X2i4mLdZUtrXu9MyuS4qC+SHcvew4S1I5PffcBFS6rQsF7xRXfwkBNpxg33gsXv2fYcH3uVMhx/UDk37muSOe6qVq7VtJEIe5HB2SwMqX9hzMVKZlj3VsGMz3PVbrFJO5skARElueppSVdPT5oAdnh5ikQOQm8gmPY8eYJw6i0yySgYItkUk87MhU7DxCMrLLX/HTNj6vY420VNhOloPvnloo8i1OUEtO3Lboyx42YTcK3vIQ3y3yTM3dXLmkg60DasM6D73Erl8MTAqw3j4Xea0udkN+l125yKS+9YY+OdpoSE6n0N9RUwSgsb8gsBDMGCxpERdqwq8AtHc3+dl79UkrZ7SZ3mABL/+2FKwDqEUPwvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39850400004)(36756003)(8676002)(478600001)(8936002)(6666004)(5660300002)(1076003)(38100700002)(26005)(38350700002)(86362001)(6486002)(316002)(4326008)(66946007)(66556008)(2906002)(956004)(2616005)(186003)(7696005)(44832011)(16526019)(52116002)(66476007)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/bmixmK1CO8GzPwp6ccQ/WtO1RltgH3KRuxW3al0AhkcrmsZ/SHpIcQVRzYG?=
 =?us-ascii?Q?BIcfRRqMLH9Al47SZIybvQWsFQlzCxpL2kL/LSwKnZWjigN7nvHgTtMaHZsr?=
 =?us-ascii?Q?e+1dnajV6tK7sLSBFGJbIqAhIuva/+Zim8K4pL87EM5p8pYG508m2pLQ76Dz?=
 =?us-ascii?Q?28KNLd0DEU6xIvjosRhHzbX14MJ9dMdBks7h/pE6/bY8XjEX9nE6C7o0SKvp?=
 =?us-ascii?Q?nGPDxa3mBErryLqGjSeLLXNSX8Q32gp0SNmSLObJHxy1WeAX0B4CymfdY1yG?=
 =?us-ascii?Q?iWMpWyNgJiYAd5xWrLdlUOcCeJ9XO4v4cuEMzfe20Wt+nKu9XLOI/qJLJGtS?=
 =?us-ascii?Q?C63KqrhBCzTIo0rd6uZy50Y2x3M8lN+9f/YEPrO3QDqPWFMPoLLYJqD/AYHA?=
 =?us-ascii?Q?ayXucIZDCnvE+1F7JVs3VGZjufnYL6ixv1WE6Jy9RMYz79Hoh7f3fEhX96G1?=
 =?us-ascii?Q?XYQi487LOIlKp+cTPIfV5uaEo6f6kQOfBw8o/CnQd0cZQZWtrCeqLnVcFium?=
 =?us-ascii?Q?2hZNZXcHPW9sXIMmx8lCrj2MuYvOugNMK5dg+QzrmOFBtc/GaK5RxAMjwGYe?=
 =?us-ascii?Q?jZ2jLD2WW5b9J11QeUUjwzHj/fEfXv2XBgVwH2kOikqbFA/R/egHGkknR1Vq?=
 =?us-ascii?Q?aNVvVMZEUWsswmCxuk6rSCBtmjcfjmMf+7vNCK2yIaGst2+EKI6YF24mk4kv?=
 =?us-ascii?Q?VM5wqhUv/bAaPqAidi0nCE11xWqBbYveBAXNfimIBVzxXZ+xazaktRpu6bj2?=
 =?us-ascii?Q?Sh2qgY3HnFrLe2SMP06E8Bq9YZ6tca8epPHKKgsGkq5ndA7TMRQbL1yLQVaX?=
 =?us-ascii?Q?sPl40QDrm3rlGgIZ7zxaDa93UmKmcXilYc5iQsCaSYJaf/pfhh+cIqnO969T?=
 =?us-ascii?Q?v68uqWSfO33YO/HEhjR0TExTCTUfK3d//ZcKIddZl7GQT04A7wXsqsamePsC?=
 =?us-ascii?Q?Ik4SSuzQBc0JqVVDUS2WN0L0b4bvSgd7OXPy6dWoWEROSUDsWHb2txamF20J?=
 =?us-ascii?Q?kTEXmXQqho/eaBVUuxz80lDXl0IpilP6E0v0lOQftxvMtfIefRSorpG1uNhS?=
 =?us-ascii?Q?g0e/8eIs3qAwxJM9xzAd5VjToFYzrtE4Uv81IpMnXWL/xw4vpP7lA40yR1LA?=
 =?us-ascii?Q?z08991KRm9KjAbakOy1AHr/AjB5KiWB5IS3X5Yj0ocn2v/X0xxJ12OVC0xg3?=
 =?us-ascii?Q?3udq2Q9/0ml4NX0Y2c8VOhZ0K9lwO3G/ehYrMcbbd2mIeRa6aY447RcxFYSb?=
 =?us-ascii?Q?JGP5jicXN372O3Jep7iPmBqjDwz7qew11RX9bTki9gMyCkp76qePPlB1H6lJ?=
 =?us-ascii?Q?bhnuuWvMQ+YTpVEMBmBgkxs+?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21291301-fb03-4516-f408-08d8fd87cb1a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 07:51:34.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkLsac9EwqrI5oQ4PW1YNPk/p/BW2LmhoC5xQGm1j1lBe1oYxakep21VcOyL9JXsTbxtBZEi7vWlyKPwgimGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6800
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
Patch series adds driver and dt-bindings for Murata SCA3300 accelerometer.

Device is a 3-axis Accelerometer with digital SPI interface.

Patches are tested and based on linux-next.


