Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47BA64BABF
	for <lists+linux-iio@lfdr.de>; Tue, 13 Dec 2022 18:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiLMRQL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 12:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiLMRQK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 12:16:10 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F214D13;
        Tue, 13 Dec 2022 09:16:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKoYl3KNfSXHPcDKEspDmnoVZ1wKuY/mEyR89FegHASQjsgxfEzgvX4FTNXHBFe8nz/xCfO5Dp3zsJUp7/24xR+JLG0j24BvOyfTg5zoHvdBC0dnwyhwqrEp24IYMGuUHte5ZNSfQ6RVSi1hptJHGr8cuKKzpcwGCouzY4iHnaivkm+s8CLWV1Y9MtdAFQoguVrqAqfeq8zEIp7c03WvYWpAj3T61nX4U4csjLOa9UtwmcOjwXdrlx8TG5ccGvHtyJFFGWKBQgsi8Ft3iNITOmSSqDRkl5sSg/AwN/qI3z8Wd7eRcWVFoCwkVjLt1LhUBqJNBJrxsuYTw5r91bFu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ynCUL1UBZ9GrLhLjVtcCEixtglzlSiDA56oWCV5nhc=;
 b=Y5o2kfkgE1hgqMNM1VCSrlOyBAC0hJ3pf/vcjUhLDSosS0k8CpVibPtu/FKD2AXwFORXDqb+l/8Ue8jwmU2Q6a+i4VAVerlwaaUVZVwSfT1uUFncgeimvZRSyC5fYJSijvIe90R6Ar+AEVsYpbl7qGBqDYS27kHSUEBCCZowkUOpCfRYEPKUrCq4X4mNPNp0WKH67+TwrpzUs0MqiTkwAulXdMCaH0Ud1lQcU91M0s22m71Wx48U/vT5K82jRqS8sNHCsLpGyZMclQ0wi0NbAC2Ed1qpaciCQ5eFgy6NKA6+tfoFUJmlPz67ElkC/KTViON35q6QZnrdk+dKbGVUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ynCUL1UBZ9GrLhLjVtcCEixtglzlSiDA56oWCV5nhc=;
 b=iu6mzj4Y4lRQBLosDb0o6SydTJCV1LXQm+jvvFCEZFqRaxrQWgbD5mudpyZfjQtWeVXWbebiOVu9F6rH6Lzpowkkb5GPZ7vLUA4BZnn/40uXkC/2sPJLWTI5eW+J1aNlxOPJL3iP6B+8yJPoYfAXaLVOgU+da14/u613pexfYv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 17:16:03 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::ef72:e2bf:2ff6:a953%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 17:16:03 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, Han Xu <han.xu@nxp.com>,
        Sean Nyekjaer <sean@geanix.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: [PATCH v3 0/4] FXLS8967AF and FXLS8974CF support
Date:   Tue, 13 Dec 2022 11:15:31 -0600
Message-Id: <20221213171536.1880089-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a230d9-9057-4a09-bb4f-08dadd2db55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJ93Zfvt+Vt31xwSToh/Zt5FFzHS9qHrXvg0r6ILId3r0LB3VLCTIdowyD/ng3Q0m7Fm2P/EZ6r13Nxy/PQDmMSsIeShxuQSN/f3q/BEtVYqqpeSpmLh8G9oRRNRtfHM8GyPsYIepAygWOehpSyjDhD2I5RtDhQ3sfR8iD6lz5ObDCo51EblYBEA1AY4wHdqkXS3F+1zGNvPU7h1FhkjPIoYh6SDQS3XXPT6tqKTXfQtNNZbEpFRFfakLag05PVy0Vgno7AWAHvLuI+8b0NPVseI/kMHycxXmZwNXa7G9Dpn52oagVnQoWPOl+8sw7VJeWXemTPsDx+wNzxQ1PVO0Ab+BZZy4Q86oRwbuBHWamSjakTyqZhuNnZhHb6XwIUpTP9adPeq+gR+8ZVgDcmb0YrBomJxag8h8wnj6bbXEuKvRXJ7WszmH4NOAVOvnks++NEDIS7DtsMVHwfS5/ja8eHdC8QAOkRNpbmwYcQ7NoRaNKW3rCdKPS1cob61ULJmgbC5SStGJ01LooBBW5gEQznEG1NLoJ/Efkfu0secXyr5nHt0fdc9ju/hz/upTwHGJt+DzKnZqdLDInixLkxrFlfhH9YPJG8SleL0lXnIA+Bgykzj9Zby/1dBDncN5c+rxLrd1YsSNRdJSlxr4aG6R2LBlhYnxkaZ1zjtXdYVRwUktXWFfgpS1/ThQBwfzg3mNF9whfvmEZzLviAHT0RO/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36756003)(6486002)(110136005)(316002)(478600001)(86362001)(38350700002)(38100700002)(54906003)(6512007)(1076003)(52116002)(186003)(6506007)(6666004)(2616005)(26005)(66556008)(44832011)(41300700001)(66476007)(4744005)(5660300002)(66946007)(8936002)(7416002)(2906002)(8676002)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRGx+QOvyPWqKtfqND45udwTMdlFsMUkvGE/mPBPiz+8owQY96GilGzlNedu?=
 =?us-ascii?Q?Ta84CiYhPACsLvQMalqd8orsr316Sq3RtdNc6Ji0f8TqlR8VgnknBwbQ/JsW?=
 =?us-ascii?Q?452XUBkKBB2Cv1QL6vUSguQ7P2SKDlD0pSvdEWiRP+2AX8IDI1Z/+hyIri3n?=
 =?us-ascii?Q?XJk28grnN9Sm4XKb8THiuv8AXDW0+2rNukSXkT8fy6Dm/MOIUFpOMM6EpeVC?=
 =?us-ascii?Q?PBkrq3SkLS+OHS2tN3oA9kbGqSQYSb4IABXxwjjdtfAuHDTNIreT6ItkhAxh?=
 =?us-ascii?Q?9ETZC4k1YSJFveYJXDeOCqvBBHmOJy5CKC1ymcwwh/zqzo/V+K40usFvZZzi?=
 =?us-ascii?Q?g9PvlRoC9teIUVDQ0sI6QWqKP90eVzgfUiliekjNNqO/8HPDtk0ut4DABCkN?=
 =?us-ascii?Q?NJWkS1WrwYDxkQm8gnUvtO7GdSmBiQI2KXIwvR6KHndFZJ51a1EwTQtVK0c6?=
 =?us-ascii?Q?CpnlA9wO/8dfC7GRT7W9B4XZl1wMN7sdJaKxygfyOexDkJDgLruOxP69EHK2?=
 =?us-ascii?Q?XwNz5fz3D3tTW1hlLyQIvlpFl98R/pSfb+FXQ+laKMQDMOLBCqZAckk2SLod?=
 =?us-ascii?Q?4ge/KqqKKSiaVnF/OMxTwYpAxV8H8n9l+E9eWRyARXaz+gNn8bwkyeCxyFkI?=
 =?us-ascii?Q?nmrvEqKpA2297OSwd7vqqEnVwEKeAAbXAc6f9l0ibB20791mhN8Ou/sdHtom?=
 =?us-ascii?Q?go0pSG6e0LjlL2cTivwA8OjaSIvYeYm+aHPt1cM/izoZ8KJgKBmKjNSrYN8O?=
 =?us-ascii?Q?8HV3U4P2tE3RV22lTHaasfxX8XfIzQ32GjDj6b2T6xoHSWbPXgFlfTHRU/S4?=
 =?us-ascii?Q?pgtdtHo2F2r6Q6xwFs6/Juk/TtIoFiyscGKc0sHJB/OWZFXP0YDKuArkOBRv?=
 =?us-ascii?Q?s2+yPHWy1auMGaahmYSojVCoM1Nfz0LZ8zEd7mOD0/vhnZmkGUSlaxtrUpEA?=
 =?us-ascii?Q?zuzxOn7/qaNHAM+wwBh23tD1GcEhD3oFlv5tR/xTCaTNJjNrVQY8D12qfOKK?=
 =?us-ascii?Q?NDfJZcqhmiojTX8LvhLGXCzVMRYGLXRjQgqtF3QHlQezeQMq6GAg91Onkl/T?=
 =?us-ascii?Q?J6IGnzMX9StNh2v3u0zGAH4cA8ZaK2sX8vnqmPZQr9/9MZ/I34+Np//HwljB?=
 =?us-ascii?Q?etaGQckMQ9B/ESv9ZJNLUauL3RtEfK/d+H9hAqfAz9GV2StJCFhleIRx55Fr?=
 =?us-ascii?Q?XusFLWLxcRM+EvY3b41UesYF1LeX8HKpZyqWHEv0Y6IrmzaocLck0q05Mcpv?=
 =?us-ascii?Q?15CpaPhRIaJMM8NSCpmnZBEA5MJiIohj4/rjWxy0QXlK1VkZzFCxY/cIRKUV?=
 =?us-ascii?Q?56fzq5/Paw6gc0CH59bccFOcAP0vasmpM/wa+u8BfV9/Ut/cAM5xk1skfwYM?=
 =?us-ascii?Q?4CYBnCKBe/PFadakQdQX9I/tkwTmg1oNG4b36FagADEL00/wHRcvEFqFUXEC?=
 =?us-ascii?Q?D60RquCiJuFQS0ioXi29vxMHIgnCdWHxjShitIkwUNiOiWmTU/Jg55P0DjCz?=
 =?us-ascii?Q?9RJV3ztHl0KQn6Fsx1jTFnB1G59/LFJ6hxWB+8AT4chlaoa+Y4uVN2e63sCv?=
 =?us-ascii?Q?kmWwZu/nELmw3cZq3qA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a230d9-9057-4a09-bb4f-08dadd2db55a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 17:16:03.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQD9otw4zCkA+JOFcbALeicW9EszQiVnioZ7fl5pirWMc6GzyHtBH5JtWQm8s0ys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The patch set add two more NXP accelerometer entries for FXLS8967AF and
FXLS8974CF in driver and update related compatible string for dt bindings.

Haibo Chen (1):
  iio: accel: add fxls8974cf support

Han Xu (3):
  iio: accel: add the new entry in driver for fxls8967af
  dt-bindings: iio: accel: fxls8962af: add new compatible string
  dt-bindings: iio: accel: fxls8974cf: add new compatible string

 .../bindings/iio/accel/nxp,fxls8962af.yaml         |  6 ++++++
 drivers/iio/accel/fxls8962af-core.c                | 14 ++++++++++++++
 drivers/iio/accel/fxls8962af-i2c.c                 |  4 ++++
 drivers/iio/accel/fxls8962af.h                     |  2 ++
 4 files changed, 26 insertions(+)

-- 
2.25.1

