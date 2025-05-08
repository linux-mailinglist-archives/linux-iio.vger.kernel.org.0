Return-Path: <linux-iio+bounces-19304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1C4AAFAE6
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075659E5803
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 13:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2F522B5A5;
	Thu,  8 May 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b="Q7iqUnl/"
X-Original-To: linux-iio@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBBF22A4C2;
	Thu,  8 May 2025 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746709649; cv=fail; b=nghQgET1UnRWO2J3GRoY9avDpAgQvLdAG6H9nZ13lziWinKu2DTq/qdB7XZ7D1ajca/D/iPMHEYImQuYkmnVYXq+80766VNglhFWMM8UWUBelnPOYib1+P0+K/vQ6MJOO8NJ6F7jh2KagtlaH08C/2xVSK0bLhN8PrmD5ekVzus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746709649; c=relaxed/simple;
	bh=k3qmuFbx3gvQ7U5zcCnqGrIgIz+CGXRezJ7gP45djbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzF3EkkrsQ0FoYAcXGwLG5rhlsP14PTyJxtOJlOCg8I3RVHJiQQTjrDcRyyk77OQ/JKT/QvDxdUlk5y+Lfg9j26ekNWzlMazWER0aGKyWQWspoarDvj6kG24hnZMu5+dd4KxJFVWSkxNJhRRSQFRr7ctKHhEP0AcRfiwp/4LbcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=pass (2048-bit key) header.d=mt.com header.i=@mt.com header.b=Q7iqUnl/; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7Wti1pL/KCYa5CsEtMV+npD87s/lz/qSX/xvz9lKkfP+rHFEDXV3qN/rdsb1nUIw0wozxl9Tgo7XljZT6i6JckjRMeFsGaeRPYgw0f9g8lTRLn7dUZHHG8UFIJ91LZRYxPOeNtLeZSxzTjynyQfBqnCLPKfnvRVtaW+QWfboINEP4pRHoKTRvqW43xkiX6g5NtdeKumwGoeRysa6LZ+xTMPdOw6/xpzFi2euL0jNitN2C0xtDY+HHi7DuS5SG+j5X6BWlL3djP7JpBH6QOqd419a27yW5h+feHSSiNbkTne4NhUt+QygJHYG1UagFv5D87z6OnJ2e1fQo9rP0yeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIGtlYx8sUULB40EzptwYcsfYMEHKtMC/ayoi+9SbU4=;
 b=tKE1wpkxxUZxgO+Dumil5x+2aLqG7Ugb6RTSsViU50gCIO/Y445NZSKyqgExr0JTdBj0rPXyBTvANlFbgKr+XuxE1/gHZixdFKq4wFXy6WnR9jYz/PzDEDS7NbPnBR+QNQN1FApGHmnqLcE8yLRELnzK1LlZNz6cZJSHnDFXKsMnp6Gr2fP9pcjfc8j3Q48E1OD2daXSWfHnPS91gDGShvsmo156v+cVAvmjoDENA8AQRi6U+vFgqxjerzpRWg+ZQqI7RcKeR6zJlaBvHw85oXnhV/3kZ0gwyc1R135ViW9XwYrDJr+9mrwDThJcUkuddUgfWf3z3kcscYbburkcdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIGtlYx8sUULB40EzptwYcsfYMEHKtMC/ayoi+9SbU4=;
 b=Q7iqUnl/x2EGI+BT/BQDSek6bR+/DuUfnqLEGbMAIYhN4Dgs25FX/m26kAXY94xwwMhzaa7sJ9+e5MQ+a/TMEE+iMGhyymOLPJk3St00fTRqCuRd1Y/YLpGU6FgYbvNDVI16cNf5qyX+gwdfHTpbDQh070gLrhjZWbU0vGlvGJuTFgBMgVWxNK+szLjbM71JvnlLkTVSUe/lxjJ/WKz3L0mmlZWBKhSFOgK0Jps7NTnnZqohaQ3bqe6BJ+0tLRPH/88Y4tGLsaSOsX3yk2PnSAxht2UTFUFn97mvoMjURHS9TdGqgmJSYkVaYaAaTNveI8TXFKpU44KKx316hn7Opg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB6PR03MB3062.eurprd03.prod.outlook.com (2603:10a6:6:36::19) by
 DBAPR03MB6439.eurprd03.prod.outlook.com (2603:10a6:10:199::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.21; Thu, 8 May 2025 13:07:25 +0000
Received: from DB6PR03MB3062.eurprd03.prod.outlook.com
 ([fe80::b201:e423:f29:53b]) by DB6PR03MB3062.eurprd03.prod.outlook.com
 ([fe80::b201:e423:f29:53b%4]) with mapi id 15.20.8678.033; Thu, 8 May 2025
 13:07:25 +0000
From: Markus Burri <markus.burri@mt.com>
To: linux-kernel@vger.kernel.org
Cc: Markus Burri <markus.burri@mt.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Markus Burri <markus.burri@bbv.ch>
Subject: [PATCH v4 6/6] powerpc/eeh-powernv: fix potential OoB
Date: Thu,  8 May 2025 15:06:12 +0200
Message-Id: <20250508130612.82270-7-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250508130612.82270-1-markus.burri@mt.com>
References: <20250508130612.82270-1-markus.burri@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To DB6PR03MB3062.eurprd03.prod.outlook.com
 (2603:10a6:6:36::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR03MB3062:EE_|DBAPR03MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 4592d554-f108-446f-0e9d-08dd8e3146ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7SZaQ8TkhOK4bFFwSqb/uODb5nWsuV9f/qHWg9cmBgUasYN+JQZKVhetcsEX?=
 =?us-ascii?Q?OgPCvFQqRgMVby2JltO01Rtt4czWsDWOXLhyayVpcIAHaXWZ9C5+fXf6HLsf?=
 =?us-ascii?Q?c+WY2BvewlYYvnGrmGFuhcDG7aw7Ic+ZAfjSxLNS6c6TotSD2+kQljcum8MF?=
 =?us-ascii?Q?0V+xl8gYsdjgm0V3cjLDbNOpAcJJQXhWCpmX0rBRYSk228w+7OJcgwEIWCEB?=
 =?us-ascii?Q?Be43PrKyE5/9a+w+y8NiHqbyB78aoFyTtWfXzroFensfVstB4ykL0ZCD+yjk?=
 =?us-ascii?Q?Cy0l0B44WuBptcVxpd4ccsHfafm+8bv/ADMJDmEO+xDXKvRFe+gTlv/fxyNg?=
 =?us-ascii?Q?kyU1JD4ceBCUa25cx3P5vMcLKyQZKhgx0lG/lwCFMvW/jvhhq5AcMnh/9dMr?=
 =?us-ascii?Q?VAD77Fu9IUEe6SFezp7VOaBjnq2MREytUtyFb1Jf2dHnAPea+mY4Gf6MJ+jh?=
 =?us-ascii?Q?gkjp0xniG7+itoQ3QuC8K0qaWl4d+ih/6NvtsYP2pJUeAwLtikHDEfV3Fg7T?=
 =?us-ascii?Q?T1rhWdi5COgM22qKBfyefLtus426jgZ5LJ0/hTrnyo8P+7OU1Z7zdPrfw/kU?=
 =?us-ascii?Q?o99LTx4uz+svIvdoTPFrjUtMbTfyHZfkLPXQh9cO/yeeH4looFqBhKkl4fBF?=
 =?us-ascii?Q?2nCrnxeBYFdt56PQop/2hf1oVuKs5LIbkMPTPUc9ZnG9qDVUz0u9VbU7ROsa?=
 =?us-ascii?Q?bJ3lAtwIODhtar+R3a9QH3yYWVNWYK9itJWW0Z+KiOcR9cdKc2EGx60eSOUH?=
 =?us-ascii?Q?cwTR+uajChs/yX9V5iTieLElZLXjc8D2/EjnMtohRZ2x4boPWFlcs5frHExO?=
 =?us-ascii?Q?js0jOtCGupwUxqrwYmxhKyVxCu5n5Us96bC7JVnWjRTZm2c9y1+ACFF8rX8X?=
 =?us-ascii?Q?6EIxEwxwN3TdrUgBJoirE+/An08bo0i3snTGVKuSXshA71+F95/CdJGVDxMd?=
 =?us-ascii?Q?fFRZQ69zz7cD+lgZ6f8K4M6Msyusa5JF032y14Rv39jsEASeBHCpz7iYoWQP?=
 =?us-ascii?Q?/Y2dgBTOwEBczkClj2Wovc0rBnzazJSkRKw2Q4OlpTKp5mjy0lAz6GsnkXiq?=
 =?us-ascii?Q?MGbOkCgoJViz1ko3GcEgDGOrpI2ivIK8h7GghEMaoEW6quhvuMUk7Bl7n0ug?=
 =?us-ascii?Q?sXAwPDhEHre5qasbousHwt30filCv1OqNlPCfiad9FoFyFnDjBajAicgJ5/7?=
 =?us-ascii?Q?ziUGnsJnGDd09l0Yjz66r7lzK+inDbxlwMrFMA8XmwdnjgzS/v7LdZvg2iJr?=
 =?us-ascii?Q?wEy3H4h6q9xys/pgNo7FeyxgJ19FQ9s7tNdtngYF3kUSO4Zb65gBfMWV433e?=
 =?us-ascii?Q?S9aUTu2c24VCDjPTz/J9HLZCnHhXmXxqtwtKApLS1TL7Cd8pe1dd9zm+JoGb?=
 =?us-ascii?Q?H8bPvBxQEcLP5pCmrIMFm7+BMVkQ67jCnQ6XkXGnJ0WgCVWe64D/9NWGcWkg?=
 =?us-ascii?Q?9JlAFZcLQnQ3yCQVSiMn/a8i00jC9iM6rT34zbVP518+hferqzO9PA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR03MB3062.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7lOeTXHGVdKAynQp6Km1nH3pzWBBVYMY4/UdgbSD3N7OyeH01V/wx+OqCps?=
 =?us-ascii?Q?9m7+/H9ItpVv9eVsXT/y9TrmlRDXtzwLDLvND0ncU8dN+yHyWHdoMD4fjwuJ?=
 =?us-ascii?Q?V+7bhPStzAROVxp6+B4z0eHnPIyl2bbJgb7F3REeUKIY8u349XdUxgKQrS7x?=
 =?us-ascii?Q?WnKcYdH7xcKvL4/iYjQ4DA/8uGT+a7ltgIY3JfaVuQDqqLcLNkkk4fTeS8Hh?=
 =?us-ascii?Q?cuMvmxUvcdHmi32aSjO/vNLub7EBCnUalM1nv8WA3atQSe0OgXPmzFg+//YP?=
 =?us-ascii?Q?Z3TtvpcRVHqS2giK8AtuNor/A+q+UE3fJiP62+YF7cZlkuq/N2u0OQ7GxcVH?=
 =?us-ascii?Q?kyczPdXlXG8JTDRsTkF/3cQqQn/ShxxwLEMqtA7F4HJemYP0SLSdGEjNUZyR?=
 =?us-ascii?Q?SE7tNt/dS82Oi/mgbd0gcWX4zef5/te7PCIwQ2Qeu3WfxOBcmR0gJQVhDFqM?=
 =?us-ascii?Q?CGoD49gxDhRVjVdUiXenQdvvFAfhvBMl1Jqf+tNuRIcUE0ZEH633ug9IygQR?=
 =?us-ascii?Q?UXrvofNd7vi+QqxytUMFINZgw2BeVl8CDuJ2TITcEVe7W4KTLKtjqlwz+dAb?=
 =?us-ascii?Q?oTBabSrAekAJ0O+YIaXaSauWaXvDw1kB8HQrxRJ5rkSIejYmPT4pLjM7XXN1?=
 =?us-ascii?Q?dXLJmNN8MHXds3tylkQELJg/4pblGMi2BvTp9fKc5IZDuIeS8l5NJCSuY6JA?=
 =?us-ascii?Q?zHjF0zQjDBof56/LtSPYAiDkf2R5OHS855tlNsiYCQOnb4Fappedhk+l5NPG?=
 =?us-ascii?Q?zsW2EyFb2R8VqP/vxgoV2JCd+cyZSfi/lhxmGzSxRweIUfQ7baKuORlC5Rn2?=
 =?us-ascii?Q?AahsSm5OD2Nx2oDFBytlmBHDyhUxwoN0y6mmwGbNh6pr6qwH5UsGf7vU+5n3?=
 =?us-ascii?Q?u5Ok81g/xK/gjazAXOUix+QJ2KmRE10YocPDqUhYEEZlQeMHsEInze6QAuaO?=
 =?us-ascii?Q?o8nNkoneWrhIgsQ4xbf9AcFoUsf4vY2s5pgX/Ixur1iGI10bkqB18sBRV4Ql?=
 =?us-ascii?Q?z9rfVZb+9DzbW8PFYmctJjpKdhRtas9IJzPpYcIxm5SrNmnkgA3OpbNwklIw?=
 =?us-ascii?Q?yDZq06vdBzRQctoBSU78Hbh6Pqj/8GCQjIP7LvdmiOP69IjsbHZjEqT6mXfI?=
 =?us-ascii?Q?DDK85EqTDG1jiGjlw+Yj1xV5zCmmAh6l0Zd8HC7n12M2Kz09XscSNKUdpCTw?=
 =?us-ascii?Q?GpNIY8mhvNm7XveJh2Trd4cbpxcoHrouyyLeugK+gpgqs2UIKncbZbIvhCTK?=
 =?us-ascii?Q?g4jvnP9SBi2RA7ltsj/35d9zQK6SLPwa2UYMBlgmStlSwyedPiVysp8/Wx7m?=
 =?us-ascii?Q?MhacyK3+xDFTu5K/wSUb1ULmtkPrg1R4VVBb/j/3t8m890DvbcWRR6fl5511?=
 =?us-ascii?Q?hYGcm8QHJ++1dpYw/mLaqD8TgiqwE6yTOXX5BVfzDKnoozVW2iYgqTLSweza?=
 =?us-ascii?Q?iCfG8/8nqvG8ULueC23wEdCTyDYK4O1B6OY8z5WniQKDD/t0mF3A/F5VdIsq?=
 =?us-ascii?Q?k+nyGA2LyzGwY9VKuCk0vbSKqu3ZAgUakpQd1lWbz5d8PFOO2qhXyaL7QTri?=
 =?us-ascii?Q?s1ZLKoK6b5jcKKns4dcgHQjN0pbdX+M4j/xVNxF+?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4592d554-f108-446f-0e9d-08dd8e3146ca
X-MS-Exchange-CrossTenant-AuthSource: DB6PR03MB3062.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:07:24.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFlEBF3VXZ0KRjyKSd9RbjhGlkA4537GiJQR0F3r4dMKQOPqpKZwkncxN4EeT6TiNIjmmP1362DXzZ0aLelxag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6439

The buffer is set to 50 characters. If a caller write more characters,
count is truncated to the max available space in "simple_write_to_buffer".
To protect from OoB access, check that the input size fit into buffer and
add a zero terminator after copy to the end of the copied data.

Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index db3370d1673c..3abee21fdd05 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -73,14 +73,19 @@ static ssize_t pnv_eeh_ei_write(struct file *filp,
 	char buf[50];
 	int ret;
 
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
 	if (!eeh_ops || !eeh_ops->err_inject)
 		return -ENXIO;
 
 	/* Copy over argument buffer */
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
 	if (!ret)
 		return -EFAULT;
 
+	buf[ret] = '\0';
+
 	/* Retrieve parameters */
 	ret = sscanf(buf, "%x:%x:%x:%lx:%lx",
 		     &pe_no, &type, &func, &addr, &mask);
-- 
2.39.5


