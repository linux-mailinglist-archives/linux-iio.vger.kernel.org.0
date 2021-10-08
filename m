Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADD4270B2
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhJHSag (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 14:30:36 -0400
Received: from mail-eopbgr80127.outbound.protection.outlook.com ([40.107.8.127]:44192
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231328AbhJHSag (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 14:30:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7sIBKqNggKfnZXXn5JrTffL94QELYHYsZSG8qT6PQ8bvfY5kFQ/dl7cR9oc+vvUM9bZD3seeMcnFI2q4Q4yfxWOFfmFDj0ydh/L8VWhxqBm+QSeAIjrHfQiAj3Kpem0Ja1oMt04je41ffbLEV4r6x6vPBMVRKDnYwfEgUQVQQAFaoQopI6i6Cd8byOGqQ3jzX4Q76O3RJpBCnCGC2w1fIbTbn2mX9qHlolP6TPNG+xJ9OmizeVa8cHMikLWzZEL6c6jwUZNZ2fK2nTtM2td7DFmUqjhIHhJK/WiT6pU3o8iT//GqlnTaZyAfEGYUyH14DAhovc4GU5j1ovDcOnCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcmSjnT944HJWI88HxJsYZoaM2wrZyO5bdwmEcztSQs=;
 b=JIaPA9QqGsNs7xysKO0kmrw40t8QGlshTz8tDT9xJcSOJ/PAKRdGFxHef7ddmBJzoW3oleR9CPK4WT6eOjyMHdjL5Qn2Y4BcypnB1GHhSY5GG90oaVSTXslvYlabCluOj+Spz3QOuTA3t7aMoU493paaxUDug0RlQ5nvp19BAFb43gLoDFBI3Y9rCCvEhJzjRy8UPRTANxnWpyFsn4wJCMnOfxSwy+yxHB26XDSqJWIY8QDejghjopoMPM0t/IuGjJOqjWOTPdTZkOhICCeOXIzuK5eH2OVwmbSFDl9rg0ZudirmUkR1KeD/+CwbW8TZIEHB9s51pBw5Rx0KqbzVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcmSjnT944HJWI88HxJsYZoaM2wrZyO5bdwmEcztSQs=;
 b=bt7lX66SxnVa+AG6cBmZWo9JBc2e4e8z5oYUMfLG+uuhyjJ0JamfINTm6mmnxM0FhuQCOcSjdlgITdSuYPh/QOjwKtKkaaXqMTI76qOMacvp2m8UQIGatUShRrc6ND+Hg1ZkUVCbjC0NEJVqnnzimA9tM3sXNeyvl7pI6GC+4mM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andriy.tryshnivskyy@opensynergy.com
Subject: [PATCH v5 0/1] iio/scmi: Add reading "raw" attribute.
Date:   Fri,  8 Oct 2021 21:28:25 +0300
Message-Id: <20211008182826.24412-1-andriy.tryshnivskyy@opensynergy.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0280.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::17) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff9811f6-b301-40e6-83f9-08d98a89728a
X-MS-TrafficTypeDiagnostic: AM6PR04MB6005:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6005CF6172DE3B2CFD72CA53E6B29@AM6PR04MB6005.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /V5/blANX+or5RfFGD0p2u7gJaB8aVi4dtou/aAJc31AW6VW9Tlot5bm95c9rGlf6ndCo67R9Y1E04Tena5s0T9L03D1HBW1d5jCunSULWdMqgSGx8klWJmf58Wx6QHwfPVHilD2myIJ6PL7YwuLFf2WNU+84Ubmneb6nUfQ1ZfYiJKXlkTEWWduR6XPIB9/+nwggvQtHGEsNvv7viJVL53e1XBEbojZYy5jHH06kcJvcxhnwVb5TNkB8y2gcKeKjMkGPaeAFKJH9suWQhTvKU24aj3hZf9z7uixMAs3oqo+ZLxDfGfLXlMJ9/0BKpFfI+/5qO4yyQD8DEOFBJrUtF36EJXjOr3U4yatcaiIxRjYUci8PWo2cOrFnxTeUmb9Yo0/mYMx5jdrHW3E7duTNrok1ojTTiBlYkD08vg6I5mTtNMjsbbk1AmMYxK5ogSoXSAhitzBEt/Ww/l+0BGxCNjKxOjtH7UP2nijSKjYOrmoEyP4qzjJ8B18BNsZs498Siv03RBH1cK/RgxBXTs0D3l5JRtS3qQG4EDchSTv7MSku4T+0t+WO1YqubrNu1ZwROHn15exSq3jL26YN5KwVMlHFbdBjLM1hhvq81+6CVgtPOxzq9wHtrnh4v9KDpYqqtLUjCV38k7rZUPtfvKhDdUvs4pKhlVpLSJLRWROmEORz+nQ2AqD6q19X8CxkcwyFVKgzCbUu7uPgg+MKKAToA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39840400004)(136003)(376002)(346002)(1076003)(4744005)(2616005)(66476007)(5660300002)(66946007)(66556008)(2906002)(52116002)(186003)(316002)(26005)(4326008)(508600001)(44832011)(107886003)(38100700002)(86362001)(38350700002)(8936002)(42186006)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9l+cYr6qJ4FpS6L48jlnJEaA4VGLtcVf5wSDdepIplJMVuQ9nOla/BA3hd3F?=
 =?us-ascii?Q?eNMiA0+Tz1RM1lA+hIRK5EskC0o6QrMrUk5T4G3IA5fZ+P3BuQajORiSDocs?=
 =?us-ascii?Q?mpNNub0A6PGZUXFrVsrDIY1Ve8E1MWH32juP0tCRYTp19eHcGRDse2YBsQi+?=
 =?us-ascii?Q?/EbmXpZGAVah0WAjhCDhLfbRFiGTb5iDHrIXjzTPml1dT6ZfFPz5tjCwsngg?=
 =?us-ascii?Q?2vv7B4AQ50YKEhlreMuKN9OO0xN5wn/UPDjoVgFwvi1eJVaAc6myaHNQf7qT?=
 =?us-ascii?Q?BIG7enFKDGd3ILnRTmHfLOMp4hUVhJMN7kbOEKDbo+w520mcF5WQKVslrzLm?=
 =?us-ascii?Q?DXdBVLNUAoD4YlTjYSMZNRNbBJ9vrfTcGb0V/0RlPHRPicJxIsZez2+0Ci2g?=
 =?us-ascii?Q?IwPcjIcHNzzy9tphdlUndfMfdn36PJYUfx+REqpkGDXLfEnX9Oi6BsCAwHCD?=
 =?us-ascii?Q?VIQSvnbA3SsNDXpCAeuYdbwvea4OW1mk8e/XsMrAMdFucBSe2L7+TqXwl7l6?=
 =?us-ascii?Q?laQB5vpyUH23E9ivY387ZKUcEbIQTu0AF/DqhzxUv7woZFm3QOcckVpBu73N?=
 =?us-ascii?Q?yHEmd6l+v/xqZEuzBYilWYXV46sfmtFE+qt4BU1JN1iSMC6QInX4dk22KGiF?=
 =?us-ascii?Q?iwuf69PuX6GobbSmWn+uVdF2YJRP7hvaCsqF3hsW3ckRxA8XM3lL5DQAM/dh?=
 =?us-ascii?Q?RnKYh+1bjuxcI6IgbSKcP78xoUvEKhU6UHzMT80s6I3A/j2tO2xsU9U0wJ1U?=
 =?us-ascii?Q?sb85i6gdhez1IaGoAS4YrmP8c6X2o+JSmGfeHfkgQS4C8PB/LSODR3G4Tgfc?=
 =?us-ascii?Q?z+QT0f4c1mqMC5sxrJT495fRU3+2sxMjoa+kQDBoAFgK4R2loCKFcBcl4IoP?=
 =?us-ascii?Q?Uj9Ux5cZhlfVb9zPjDG3EoXVfI4K/ZXwyod850sqdHx16PUVQzEV9aZscw69?=
 =?us-ascii?Q?JBGw5sSZqPluBJ30AjjqlbgMtD0qG+8oFPUDXYrg/LiFX4a5CJ46/E1/AQyF?=
 =?us-ascii?Q?uKFouKz+laixFXQlfRVnvqrbYpoEBOhIrr6/IdCxVEB5rj8O0MB4LHjKtO4O?=
 =?us-ascii?Q?sYmRrS9cR8mxFObUJWcJ/1YQ6dsrzwnGViKXOPyry9SSoSBevghrf1FpzgTH?=
 =?us-ascii?Q?0MwUwb29mHXCWbztmAzDjGBciL8ZPoMtyZ8Mhwq77KKeyKkpFSVh2G9dQbYX?=
 =?us-ascii?Q?E7YefjCahEpWbFJGds9P0pYVeOj+77kG7l1BuTbTGaXS2K8XpC/166BxjuUq?=
 =?us-ascii?Q?RhMcSsOiCLsBAwqp/CJOI+uoaBxh2wrvuCN+gVzfZ6tvbH3LNzv20QVHlGHj?=
 =?us-ascii?Q?J4BA3CofQ1fLLhA9YFyp3TXo?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9811f6-b301-40e6-83f9-08d98a89728a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 18:28:38.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXpBSBLk0Jf14tKq3zxgHNcMbGbVxVqGw5jWE2u/qC/h2Gp96BdnEVG6keDb/wB/YoBft5dGQEKlLEnL9o3FWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6005
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch implements reading "raw" attribute.

The patch is based on v5.14.

Changes comparing v4 -> v5:
* call iio_device_release_direct_mode() on error
* code cleanup, fix typo

Changes comparing v3 -> v4:
* do not use scmi_iio_get_raw() for reading raw attribute due to 32bit
  return value limitation (actually I reverted the previous v3)
* introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return 64 bit
  value
* enabling/disabling and reading raw attribute is done in direct mode

Any comments are very welcome.

Thanks,
Andriy.

Andriy Tryshnivskyy (1):
  iio/scmi: Add reading "raw" attribute.

 drivers/iio/common/scmi_sensors/scmi_iio.c | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)


base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
-- 
2.17.1

