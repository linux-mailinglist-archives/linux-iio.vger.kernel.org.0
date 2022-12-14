Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC68764C29E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 04:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbiLNDPL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Dec 2022 22:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbiLNDOs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2022 22:14:48 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCDA27CDD
        for <linux-iio@vger.kernel.org>; Tue, 13 Dec 2022 19:14:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9uWxBmByKorWZiXmFagt3GD/bssPAjILAQGHsHUfLJ0aO7CADjZchUUU2Eoxiwch8Jf1hRd4SzQnuBd+NhTM/pj0bKqKqD4odJ1tdYeLEb9GCM67MspR4L96imXM6w/ETsWufHaYBgGENgzsk/DkVChsn6orzgo8p+6cguw8gd+Y+6B72OAemdZjDB2VQRDhfDLQ/D+JBPDmRsZ68Fnjy7ic/XgOLoJUn4kAWX8ZYrDepGwKVwAqo29DT7+vjfUY7vzsE21djjy6ne5ulSWCiQbl21jgl5HXLjiVuFRXFBX99DIN2qKstMXHO4lNbKWHp+TD19G6/6uhQz0PopEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjm2fhYLgXwS6yH9n15Sw0hNWOX7kyg8b2XImVT/Uhg=;
 b=NjWF4LQX2euKSxx27YM5eo9kpKlGX3T89aK1nrIT0/vzxDhp3gHDBjuN//11DW3RI12m/xgefigsfT3eDvQjcOcbwo5Reauvl9/nhhXX0krX07aOs6BaRlve4al0eGZz87UO7cxnerywg2/ZUFQgqRJCrFbimHtU7Ya5UnK+aZIf8MKLMB8WqKOJmsVAu1x2KM8SX2zv30X5qJI3xmotcPQyChpbdw7o83S2o+x9dHbK8WaokrDObX2k7mZZVUcnM9IP9vOGRbB19r/mnThKXd6XdL+OnnvQhiOg8Y//V13C05COsnptaehDcUM42HTfqdBO0VdcfFHySgjcqChmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjm2fhYLgXwS6yH9n15Sw0hNWOX7kyg8b2XImVT/Uhg=;
 b=FOMg+cF/OCdwCPpzTuI2y7DOekna+pQG/gTcNtavDUOHzOKREZWPuHiEJSWCthtteRDz4Quc0UMlWhpFm9PEzQAJWzVq9ArsbThFgttr//LknbradBrtEMnXBydBqd97BEo8WIV96hWPeMwexCofhHds5fSuANjZ12cc20TuqKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Wed, 14 Dec
 2022 03:14:35 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::e2d1:cb8b:dc57:8749%3]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 03:14:35 +0000
From:   carlos.song@nxp.com
To:     jic23@kernel.org, lars@metafoo.de
Cc:     rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, carlos.song@nxp.com, linux-imx@nxp.com,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 0/5] iio: imu: fxos8700: fix bugs about ODR and changes for a good readability
Date:   Wed, 14 Dec 2022 11:14:58 +0800
Message-Id: <20221214031503.3104251-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM8PR04MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2a5cd0-29bc-4709-85ef-08dadd815386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9kvbhbEdtnFbzpPikdpH595BPQ37cVNuJjDgF083vAPd0GlRWm0r8YX5eEb0RFF6xYN9LwMEY8fE6uzikp5cJfB6fZ2yL9roF2aq6ezXCuDRNYDjKW0/t4O9MdTMz2ROiKhNf4chtjfNDgnYPb0FDFfuLRxvflIXKrDOar52JcjQoUEgjLlOHKFp1VTCEv4MEVzRcSBHzFiGS5Ztpeay2U+M9hvlzEQW/z06yX/X6E0MpF4iKvrMUr0bGQcT7GVWQqcDoT+2Lxl2Hv51BQXdAslMwPl9xxQoaWKQW0/NfRjQT8t4uyixdW9QKCTXYt3QWRAuxn4rXLzskvshXX8pZwkgcnQxURDDeCAOYDRv2dYQdsGFuGubfcZIUGhhBlNCEEnGXtBDroOXwcFiZFtyHRrgFgRXSoAOtD7IBid099pJF5Ei1NQadx3bHK+gfXVzknUrO7VG/Ye+y1hOv2zFc5UHL1XyfamubbOOxqJI5CqOspzPKSsi1W7+UI0rQCzCgED9nk+WY0apTF6NjtvBa3DEGHildcuMfWzKTkqI5E2QeQbM78QSIJfKxnp1cX52VV0JOMasXDnOPSfNIWfbE1bmRV+8AYf2/U/4Amr7M+ow8lHFMxGM4cDfNoNVH44QksWx4JqUGhiOAUmpcXbljCnca2g7IwSY9dyKI3/LQQ6Ur0+sWZ3SivdlzTNeE5qhf851qE+1jjp033yNMnODOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(66556008)(4326008)(36756003)(66946007)(41300700001)(66476007)(8676002)(316002)(5660300002)(83380400001)(38350700002)(38100700002)(6666004)(478600001)(6486002)(6506007)(186003)(1076003)(86362001)(2616005)(26005)(9686003)(52116002)(6512007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OB++EWpLTnK3/PKPQvBML2ZpAh/jV4NggaDNnAtXSOwq87wYuLB+IbicHvuH?=
 =?us-ascii?Q?AmGbrRl0HzQo4bTcJ81gBfdxJStJi+8ljI0k5OQ1I86trOHa47JFNk1KzqEv?=
 =?us-ascii?Q?t4CihPNquRvnOWFm7Pr/gKPAf3cuDTtG8ZGQnP0ZpneaAHJaw+3mbDt3gUAz?=
 =?us-ascii?Q?gjfg/rjlsOWEgm88QuPf0Tmqii4Lxid7Isjg63WyhUiCwzC1qiFlZvl3w4Tj?=
 =?us-ascii?Q?37RNeQ7Sf4nCBtu309mZNapHpD/5pqPBuFBGMYCPczZRmMWr367K+Whx6fzX?=
 =?us-ascii?Q?h8zaW4JvWzOQ/4MBxTlPOJj7u5D0FjDpN68W2mZFzfJZXq6udCZjxTKdX/ju?=
 =?us-ascii?Q?/17rT9nRJjZFlxa8mg1upvXzMyrOKcwe/CRmXTt1AQGnNnYRReyT2+13t/4K?=
 =?us-ascii?Q?RSdgwbhezEQrEV7UWcDpDDuvQUWcAettgr6mkuUzF5KNAc9H/ilFqKVeZDkA?=
 =?us-ascii?Q?3ec3kXqhCJUuh9WkK+VxJr1F8LdkaWtGoQq3Yj59Y0ZqybZf/9Rp6TW63cBd?=
 =?us-ascii?Q?Ps+LytypHLS9z3G/+UbsxgVDEIKAkPAvM/FWrFK3YrCRn/W4G5zAY27eaJMx?=
 =?us-ascii?Q?jx9ljgQeoYizXxZrqjmWMgknouqX+8KGHB1amgFCoibDTeRyl0sT87Shhzwd?=
 =?us-ascii?Q?K3lIWUzin1FpMertdoVdKuZXoqGQcj+f4ZEsorzmOS9geYSEi3qsxVBEZj8A?=
 =?us-ascii?Q?0ekgygL3onhRPtAwD+C8K1oyme2Q1CdMOT+3y1oDdrNc0fo1ZegZxFAA6cu/?=
 =?us-ascii?Q?J3+y8UjH8WWP12Vkgy5zZW83Ipnx+J234SMc8/nkew4uTTgV7Q9JnNXisQTn?=
 =?us-ascii?Q?HtMZtZG2d7nTbbjJ3uMXIFUv2fpClxeoXk8G6O1Z0ZEjnEE5gUUNfHMmQ/7b?=
 =?us-ascii?Q?Q9ire8b3F/kHQA5aMODPZHSblGUY++Aer5Ru3Tnn7l/SfLX8GIHDhMOVQ2mQ?=
 =?us-ascii?Q?tmDePx8YHWsIAj1Mh0PntLy7DF/3bNTWKWYgXXAFgOKmv3jMwSFiyuh/4Olz?=
 =?us-ascii?Q?mMG3t3UVtvBnI6FjR2qVKnSy9BPykKlGzEU5y41fQcDlo86rsPRpVnfBnmIm?=
 =?us-ascii?Q?M/EL2w7mNCUkCn190AJyRPqeGWT+JdRlGNWVla89PIzl7/A2L/NM5B4Kmvou?=
 =?us-ascii?Q?RNWSe6btR3suMCZNhDS18IixZeVXOa98ay4IyPm4jq87gviaff5rwML2mmh9?=
 =?us-ascii?Q?2miFuf3LKTXuK3bhzBxryohXbjeIbVu42pg1e8QmpI05v8QfXQm/SQpOz7cR?=
 =?us-ascii?Q?SNvNDxtxwthe5k7SDZtxW3M2ESGY2vrp34SuoJh5FEoWYNplE8zj0v8B1dv7?=
 =?us-ascii?Q?hq/ij3BQf3KMuGcysgwC/Q1qc0ieFGNleQou071poeiqHHuFcN3MT7znBm7Y?=
 =?us-ascii?Q?0+mI6JO53GQwLzV4aXegbB0NsQEUL1nfZfwHILs2/sCQrxNHHACJQ2NPz12c?=
 =?us-ascii?Q?TpAHdryrRGPZpt29SxREnwbzoFUXFEnxx71EtoXk2Y7K9smBoF85UqBtyWJc?=
 =?us-ascii?Q?TIQZjnhBMmLH25pNGhmOnytupdVouL6WyOW/KXIp/xSBskKRp5h7LS5XWlxC?=
 =?us-ascii?Q?x5YOjrIPhTifklw58Qw1GmOcdUv2KKAaivHncsrS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2a5cd0-29bc-4709-85ef-08dadd815386
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 03:14:35.1315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfiP6ViwM718+xXzNAEx4tw9/GC8Hixe66lDDHanrUBOeJ0fH+UwSpUC9jbQkFi95/b72FF206doZDnPJ2paqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761
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

In patch v3, the main work is fixing the bug that mask bits out of an
uninitialized variable. It caused by improper use of filed mask and
FIELD_PREP()/FIELD_GET(). Meanwhile give a further fix based patch v2
and make patches to optimize codes and clean up useless codes for a
good readability.
- Patch v2 [6/7] is split into three minimal fix patches:
  iio: imu: fxos8700: fix incorrect ODR mode readback
  iio: imu: fxos8700: improve readability by field mask and regmap_write
  iio: imu: fxos8700: fix failed initialization ODR value assignment
- A new clean fix is proposed:
  iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
- A further fix based on PATCH v2 [7/7]:
  iio: imu: fxos8700: fix MAGN sensor scale and unit

Carlos Song (5):
  iio: imu: fxos8700: fix incorrect ODR mode readback
  iio: imu: fxos8700: improve readability by field mask and regmap_write
  iio: imu: fxos8700: fix failed initialization ODR mode assignment
  iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
  iio: imu: fxos8700: fix MAGN sensor scale and unit

 drivers/iio/imu/fxos8700_core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

-- 
2.34.1

