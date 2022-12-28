Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F06574C1
	for <lists+linux-iio@lfdr.de>; Wed, 28 Dec 2022 10:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiL1JjP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Dec 2022 04:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiL1JjI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2022 04:39:08 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ADFE0F2
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2022 01:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3oIwsgTAMG54t3GXQ+uK+fVUuenwrn1wLdMVuOyBFcszVuIcEbkJnH1cE4WAYadKvbxQ291DVzNXODyNSfUNSYwlJyMKECIVwBXNfc9G5a5M1Qe6+8TRXaQg97UXUCm+2E5A2MA5IhJcN/PfDVU7uAiyyFWvm4GHwYvzUaZaWYu/ewI55mfcl8CxeESaRvvcbwIAuBW8SLxXD5H8KFYJKbei/dwDCg+7ij5G17uM9UTu3kNpUOvX5dKyfOrTwkKnTThxK/ZjHk5P25AIM5DiHiARi5nYOzbX49r+qZGXkacF2PpxEmvET2fejvwWIs00UqcAuocwkPR7Uf+7vlT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeeMuOfgwoVKS32Ij6HHgS+Gxcduurc36nUOd/WgReE=;
 b=GCLcQZiyWU3vm1591zFGuI/xMvXVfmzgTUzO6z6SIdiU0jzZBiXq0j+2spBr0jcJ4z8Vt3zjscyOcImU+aJqeQzurgWIifeVRS3XS8NL3OBWm9q4VPBOjPPjtPGlNwCpBir7rB+tJajHFPpTwO7HwuloDpez4gXR2umJmOjfvK2Q1xTk+GL3B1FZpjoaWQkBsHGRrcgfZuxACGxDoaSSzCNGwBglpb5ViK33gzdc/rEWl9ZvbEs06zhSiDCMgn5nCKSoN3ia9I1Y9PJ3CCCEV9q+57s9xLWuPmJq+mFfy2QMoVqq32zAR6S+U/spmBmLmDWNglmaxeVctAE8Kvk+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeeMuOfgwoVKS32Ij6HHgS+Gxcduurc36nUOd/WgReE=;
 b=RMfgkPNnpHTRqzGy1zL5Qh1zxkkGz3BPquU7e0M7KPZ8liXUPuiDOp+sMkR28VsQSSCJo+AIXEk0WAQf6nnZLenLG14A2daQL8cqIwHwv9loyTiAp78QTjjzSlZiphg05XrDJQRiVEJZFMGCh8iEzd1efiniNgHBFCa1Nt+SGOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8177.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 09:39:05 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5944.014; Wed, 28 Dec 2022
 09:39:04 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v4 0/4] iio: imu: fxos8700: fix bugs about ODR and changes for a good readability
Date:   Wed, 28 Dec 2022 17:39:37 +0800
Message-Id: <20221228093941.270046-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM9PR04MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b2dd0f-472b-4341-f408-08dae8b75bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WOW3S6D6fLsFplSFmy6qogSQ4ZolWJRVQVTySZ3Gc2frEplsQuubSsX7o8/idkeY6c3LRw35jJboF1QPgzeUsiyAp2LvDzzKw88c8q+YSJW5xjLQce0PZz+VR1mTSbpRqiEW4UXMAzzKRUqiMy/zrlCBsi8vZIo0g2K5KNffTrCPiPkp/F+1cD9P2pABEkNq8havd5NK7dqI+RnmanEw9qRHnnyDiwnuD3vYqqSkbVXeRcTHb+ZJClTSm84L7I/UlEdkzso/0bFnIworXbJz6UcpGn5lYUnHfK7KRm94sASic9KPe6j6JTPwyKAGOzmsoFKHKvywrTPG1pBtJ/4sHz4MmoYiEW2QSk+fnrFbopezaAOFFJEK15Lf79it7U962+2sZDyqhby9u0iZdHl47krHBrxnkix/HrpROzqxr7NribpjZgSG6D7j870JaYuLjU3axAsYPgsSPDeeFu4Hg29hAwXvlwjGc6paVUgtGA9YIJ5DrVSx37mTyB62BLAmMCn3GlzAvvCZ0Wh81DrZDInAaRCu5oTB/pRcvy0/q0h4T3QA3DMW9Ks9CoivxdmsTTRB5nSky/DYYWjE9u8vEhOivjdZBlAR+7vegUbnHt71O7vwv+IXhqZzxadxfybMcXR6SAJGixB0pzGXg3tubWB/cLwOpHQGfG9x2azLIsuY773MfuGgpAXkB/xHIrh+PWinuQu78ruKYyTJx3Vxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199015)(66476007)(66556008)(4326008)(8676002)(8936002)(86362001)(5660300002)(66946007)(41300700001)(66899015)(36756003)(316002)(2906002)(83380400001)(4744005)(52116002)(6486002)(478600001)(1076003)(6666004)(2616005)(6506007)(186003)(26005)(6512007)(9686003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VeW0RXT4luuHSbltqq/Pds+OX07WWq+ucFvcUjqMPC/rMDfOxT08vHxFANor?=
 =?us-ascii?Q?DYhwPA22dvSDNXnn5ZNi83DFogO8YCIbkN3AGrmEKYpxpcGJcVoWwKMe9Q6C?=
 =?us-ascii?Q?d1X8WzwRH+u33GJ2GJQBwJ8BlUxBb3K97FSvUVJSMY20VH5iW4f3KrDy7cnM?=
 =?us-ascii?Q?MCNAhx34mv1Je0Z6j5eulh8S4p0KGibWWHLpGIFZugbFNq9XnvI3V9EPcntS?=
 =?us-ascii?Q?6/Hl+cy3ecN+89Gs57vx6XxHGcgic1TOdcYQLLV3aqbgE8YIcSJFQs3W/q9f?=
 =?us-ascii?Q?QIvWBpJBK1WWUy8v7WrZ8nIJg9h1xrW936ju+Pwox1Qypq9RxIyt2nys0d8V?=
 =?us-ascii?Q?6iYRGjIdEl596pT0UQAvZ3UA4+Zmw/60C5dbK8hcV/yi9X+3OUCjxHirIdZw?=
 =?us-ascii?Q?zp4wYpBCDD5Aj2BRaYQLepFUhVd4nXqKaSPI7rCmNJOdXlyCVXislI/bWAEy?=
 =?us-ascii?Q?WgeeRfFecLpytDRk2I9ocve617/LdIjZsKcohTzliZe773Pkst0PTc5+cv5H?=
 =?us-ascii?Q?Dck0JgSlO4r6GnRuG6bBnHOJ4E0LViuHixhxzTT61fT16RicWhwe/Ql7zABG?=
 =?us-ascii?Q?upWDDio5Ko4c3ByK8w20P6zwiouLrPNe/iaLZvfbXWaygfEzO05rd7klZjDM?=
 =?us-ascii?Q?5D0N4WopxlBrdd71BKpQHQC7CVrf9sshD2vgQY5dEW1Rd76n87TGWNTiYfON?=
 =?us-ascii?Q?zJgHiLobVyzyZKmWSRrQPIx70gi8lJk3W6Kg9DN+dEHw5YC9xGh1lxjuJgYT?=
 =?us-ascii?Q?ZWzQNNCW5Ne+/FPfP78jGU1Jr6AUrwvotXpk8FcADfTKn+eMQRqD4+WlHi4t?=
 =?us-ascii?Q?//mcRaz0lGNJ+aNswtxtEO2IkbBGYUPBbcxeWJZfvpuaQB//mc3Ck3zB+HtI?=
 =?us-ascii?Q?XOAKKOaUdVbk4xo2eRgVP7k6z8SNV27MB+9lYbue4EGKRSI95sGirrv7NAOG?=
 =?us-ascii?Q?xDh2mTw4OV9ZUKMM/ceVb8qQdxqShy8/Kc52qmx/Oo8LlFE7W/MjpEpZY9ED?=
 =?us-ascii?Q?y6dIYBjVZ+t+hiJO8Pz4zXmRZTFM79NrcyPJkdURDFq5Cp/zx9buSpA43B3c?=
 =?us-ascii?Q?bLyFmmqk8Iv7qg4cH4z4bJ7O8Fv+iPFJ1AQmg6DyCNNr5OENBvaNq/vHnF25?=
 =?us-ascii?Q?kU4LxM7hq8NvNtiygnxRFqcYMXPK9Bc2J4meBu8fzBcnMeyuq4S2r2ZfyMnv?=
 =?us-ascii?Q?Prad3h67XntQS3L3PhT/deF5FES7D/Xl25O6tNMYk7EK73TTNB5gZCSdlbxq?=
 =?us-ascii?Q?RPfUMksaJ4YNhY5NImeYl5l5AIfoxr/THhJitU1HN2WDgTvDbZD7QbarDgim?=
 =?us-ascii?Q?nwHm+t+Xn8GihmhgLGUA0bLFPeIHnEg19Zm6h1JXkHXILkgsQ/qJIwxco9V7?=
 =?us-ascii?Q?UndRAaaXETdZLKHYWoi4r7Ur+NLY80JXBufOJjxOUvFBRVhGqk8eD7B88Sm0?=
 =?us-ascii?Q?50utGD02pAWV8jW3BxsIQmVFuYVXDfkHYXdbBiYuL3UBgsgIByU/c8vD6ZgQ?=
 =?us-ascii?Q?VF2GrF9t+/VVIpVkCiYvMvdBQQ6BuwE/p7Gkn0pm86Yj1dJYFaBfXyjUHJsg?=
 =?us-ascii?Q?HJpBHwNOZnAq36TGF+Wa143LZkAPworjR0hgmO8i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b2dd0f-472b-4341-f408-08dae8b75bef
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 09:39:04.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0t6D32PE7yy5okB0GZ4K22tAD+o6nzNnF3TBgQCYWm9m2GS+7t+KzhycHHYhThxhgekApfBqY3o1ZF9B5RPUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Carlos Song <carlos.song@nxp.com>

Thanks, Jonathan. I have to admit that this has bothered me about how to
modify it reasonably but at the same time make it have the ideal format.
In patch V4, I use ODR_MSK in the first place that I merged the first two
patches in V3 into the first patch in V4. There is no change on other
patches. And sorry about forgetting to add the dividing line above the
changes in V3, I have added it for every patch this time.

Carlos Song (4):
  iio: imu: fxos8700: fix incorrect ODR mode readback
  iio: imu: fxos8700: fix failed initialization ODR mode assignment
  iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
  iio: imu: fxos8700: fix MAGN sensor scale and unit

 drivers/iio/imu/fxos8700_core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.34.1

