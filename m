Return-Path: <linux-iio+bounces-8650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 580BF9597A5
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 12:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AABB1F21D7B
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC611C6F7C;
	Wed, 21 Aug 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W61+EO9t"
X-Original-To: linux-iio@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2065.outbound.protection.outlook.com [40.107.117.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092BD1C6F5A;
	Wed, 21 Aug 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229567; cv=fail; b=ZGPjCnCu8/VCHdOjPfHsGAWAora27QzRpyNP0g+NUFMpqoJq5IOsYdQFA7mu+tuwzrnSpgcP7S9EOFK/JxQmJKkDT/w0uOynV9ogAApNCRHw0d9U/lCwas4AqJ7pEyHG2gpSDYP6zKI11jdR1UYLv4gv/HtTHICxGgqdf7/Hzrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229567; c=relaxed/simple;
	bh=fe134SqxAETYyN6MW3JvRCCw9LN4v4JHdlQnRPOb/uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OT/3NDj3vkvLIh/kI/08k/UWyZqWZrEvIsKPJ+olvc0uiq0VabE//zdni++B3nbSPfhc2j8hxoQ00258cLuvUvBetaTrH+E/Hx85jjnZnJo6aRJ0jPXvbTjS4gsMfTkSwXJRlWyk5FXJwjGh7hl2aJ8XKZ+TAD3z3HLPf/HIdms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=W61+EO9t; arc=fail smtp.client-ip=40.107.117.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8PLf8ySSEvtDCLWbLU3a3P5GsRBM8ihB7uAcPbJss7xS4QOJSp1sC1Yxg7tbbSHkVq2O9LARQ58KZP2HYmkrWiP21bNuvroJYWzvo58RTiPQHUUwNSU8VLFXoP7ToHzrdENG3lHGztBbuEFeJ2XKgrLAVv2Yj0XKGD+LuTiLrReH3dNeWC79IajPa77aCryOaXqDBOodW/HtI14l4fhfOdvfCqdFf0+6Itcd6LI9m3XyPonmnm4f3EOnXLqR/cJ2LoQ0aHxnDEl0YpOzNRIGKvtyo4bXmOEX9I9myxUj9kSGp+grYeAWo6Jz66xUm4q4T3PNVJMXmIGWFTa+0PQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRkMdNOsWz0hqzSNzYpVNSMCsvxN/cJgAKLX1kDdsK8=;
 b=IEQi6hhuWWAKQF6jqjdx6IbsZk734OasIRp/CJJJEaqHfemRouikkJMT6UP2Pqk7mlaTcODOFRReFbXCOhc+ImrAzy18joShl1UGjEiUFjzOTsSXD9qthgfGjQUoo3HmhbT1BTDw/Q9gmXoocfPbcX+ueg8uYWBRgPxjHe32NQA8YmQHMSx8kCNnEnag+QlwFcUNol7IwVMaaAj3STb/uvC7tzzKrpAmxkawzKDaR26j+Xb7qRM7U+jf/P5eWh6fzTu3yLRH9xhMXW3iqVc9IwRWyiPrkYRMDFGdpfr/R1cE5549Dp2dW1HMOQYU/VldSzJHUyiMPbtzfcFWa0ibTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRkMdNOsWz0hqzSNzYpVNSMCsvxN/cJgAKLX1kDdsK8=;
 b=W61+EO9tHTFZmI4cekmAAM/7W+vqcX6R+8paSDZF4B3Khd4+XNoxBPir2YdEPpIK8icoKh6j3mfLoTxIixMrElDTI6guMeTy+JR/xf1tdcnkBFbao5GZ43mV+b5h8xcM42Kn50G+TwxppYwp+RYyhGE+/ppqAq53rvyPfdPCfwxA50sBRQlc0yVD8ITlFOAg60A1eBtENkGDWxN0IDFQWO72lmSr/p0/RtCqRusFu3x+ofGFOzJRsqVKlKhxb4cZ+ZZiGyJ024Vx9LN7Z42Lgf1piHfpqXZHSWeIpjLBekzh6XK+0c36kiSiFrSrqR4qXA4rVbCN+RkmvdTlFkgBNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by SEZPR06MB5341.apcprd06.prod.outlook.com (2603:1096:101:7d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 08:39:22 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 08:39:22 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Yang Ruibin <11162571@vivo.com>
Subject: [PATCH v1] drivers:iio:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 04:39:08 -0400
Message-Id: <20240821083911.3411-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0138.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::13) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|SEZPR06MB5341:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ef8157-aa58-410c-4179-08dcc1bcc17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NduPtHTIZBi3lo7BwI/YC4e5EPNEv45yGaZORBBKh5C5MTvRqi58KueamnYi?=
 =?us-ascii?Q?ebUmz++n4uAYQyBc8VlAKyUKOtxmpmBblbG117wmHYLz77/MRJhHpOz7x2mN?=
 =?us-ascii?Q?WBR9iYMlFfq3rKFB1lTbx+cFmYOckNdIIt3TlO+dzCyWgRGL5w263fxg7Z6T?=
 =?us-ascii?Q?Ix9PlhWvKCyU4CR3uUzzL9hOof0UyXw/D9thKY5PKTsohpOni1UmrCJleN6O?=
 =?us-ascii?Q?nu4ugzUIBPLLnrnIousKXNHAr3CBnwjanfLjsbsOol/0OrrXfQGuOOUATw3P?=
 =?us-ascii?Q?+AsarLfvBFN6/z2+hsROp97iAzjyhEAgBxJI74MNnFWIxUiB3HP0LMPwN+mW?=
 =?us-ascii?Q?T9S1I/vxlMKXUBxXbl5ZGwWIP1qJy9hguLbVpWDMEyAS8KizFJ63SC2+f8C6?=
 =?us-ascii?Q?ajuWVbsK8ISs3mwIZfgls/xQzdqCTjo9BK2fWGrfxYPUIPK5ytt62M8xxH6r?=
 =?us-ascii?Q?SJGKh6L7TK3iqEveP9g33WXGLx50x3KDksGulgF1m2Niog67+m9GzU5FCML5?=
 =?us-ascii?Q?Pc9AMcPx5U7dvBtuNlADgyMDfDthjR7hH3PsnF5UuUqHWyzqqed/L6g+Pv6+?=
 =?us-ascii?Q?jRK1938fUaNToPt1bOkgZCtVbLXBOP9thKi6Jj4DS/sgT0QLIp8aY8aPHsif?=
 =?us-ascii?Q?+UB1LQu8CMsweQ+D9bTR2najROaN0I4fI+kXyhTHFMRT5S/gw8Adb8kyqX2g?=
 =?us-ascii?Q?dlhEja+iyTtUdzkKVxgmoGXmKXNlBfNtATiAMHEStPQISW+iXQW7A2JqXaQ1?=
 =?us-ascii?Q?O/CSlZYb2EXrb+35NO+50F7ykU9jVrh75L/nCdrvq3ly6VtSgJkClGKi3UDp?=
 =?us-ascii?Q?e17Y6FfkWG8sieQc5ebtR1TRo/HxHrjOrZZ7fzDy5fTq/w1HaB2TcaWJXrFx?=
 =?us-ascii?Q?aeST8Efph37MksmYVFKvku3jtOA20AsKYylc6XKBy6NiaOJSEExJpTPBHPe5?=
 =?us-ascii?Q?6W5LT7pv80WZ3d+lofdUBOq5htHuGamqZPqwd5eA0+F/44jkav3siRtB6PHL?=
 =?us-ascii?Q?3XrgPUCpPIeId+28+8bzouNnNwwiMcomcNkqqsXtHLs2PkK87nWUu94/TGPJ?=
 =?us-ascii?Q?1u3P3oOVEGom4WGYQ+a5bNufJRw3c1FT8A6hJq3vqkrPbNJchCNCaa9RBfzZ?=
 =?us-ascii?Q?ke+v84dwcAZYj008b3+GARjI35Q13LHpFTMvFQLlBvR5FU8lifUtN08hcSVQ?=
 =?us-ascii?Q?V16JoKVHZo8MI57z6J2c2m/whjpyvt+/VcUhDuNtGISmkQqu1gf4ricDG6uk?=
 =?us-ascii?Q?Gvd/9rGDmaSE+WBIvzQFKe7VLXymQufht1t4gnU7iKRgCwOXVNQOiVQumqCE?=
 =?us-ascii?Q?HfKv4s97syh66ECKrNSzG2EHusIvDC71IWtKs8MxAycJ7KTJFAjJfwFaaMoY?=
 =?us-ascii?Q?bXiCpBywdwCsUUfpxbuzp5vbmRkYqCGSA/dRdAqfNoGkCOrSSqQme4GVvsUt?=
 =?us-ascii?Q?I4U63BiMaeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ZufEq5zPWvCPlXpGhnrYxfmD7YV8PyjGyL3AeGuppa96DoQRHkfzIP6/1rT?=
 =?us-ascii?Q?/hS788rLVKz55LOSGjTREw/yKyMqyISip5qihImFqPCeG911d2MGtcnuZfSs?=
 =?us-ascii?Q?icnz/NdIfFJaa9UWu91GtglvrhEcLknSxduTdaswYAzJbhWQLLhWOB5smAuz?=
 =?us-ascii?Q?NId5+KGQbUWwsMYc/oknnbzXtiBVwTtQRNFhuNWcOKzKymLnFuCnZdbLAsB6?=
 =?us-ascii?Q?mIM2z3QVC93Fcy7mvFns7CM6+qoUs3fKEzoEqEu9wKxIJdabFAfV2VDZMBMi?=
 =?us-ascii?Q?twGXoQUH/wD/JltYAPlYMrb9wC6aiEXGkXBxDsgU225MyhSUljCPpcA8i/dL?=
 =?us-ascii?Q?M8SWzH3HL09b7GN2pYUAP0yM+a9Oo43HBduVZApaTfitdlImREvlTfJqzj75?=
 =?us-ascii?Q?gKKqRVMBbKh1zlMQ3TgYZiKUOtdq6GPBrAj43pibzqrl/YKd7HcJ42P1jA6W?=
 =?us-ascii?Q?xiLkx+ZN23exdGGQOx5DFcyhJpYw2xkL2oq0oUraMIx9uiYG8hxk2Xn+TSRR?=
 =?us-ascii?Q?Gqk9LxGybypv+XfsvalP0PUjjxWIg9MbGvJJJj2DiBJfNsbfJrjvzFvTi7GG?=
 =?us-ascii?Q?HfjT6PPPBtNyxsCK8RiNnPNMJSw0Z4xCbg51khkjmGNJvpvp23vOkGTwex+E?=
 =?us-ascii?Q?ioWYn56aF/yiuhvApqDZOl6Gn7vZ+XpEcyiv/BwyAOTpxKZDGrARDQ/gauo7?=
 =?us-ascii?Q?V5nSs5JATXbbaKzLWEvyljEte1pm4Vy2+5qbSVEj70H+Xesjuf5rfeoz54Uu?=
 =?us-ascii?Q?YXDMoDFed86PbmfLPYGlCdtPwkIy4FOwcxhbLciA1BYa3Y7GeMOZfYRmbal4?=
 =?us-ascii?Q?zcFhK7TNPeSzdFbB3vj+/L1x3DxANzOVj0A8EaOtj6GdOwLCrhUt2uQsswCz?=
 =?us-ascii?Q?teUSJjYsVlwnda2ob74Vc+sgcnL83nk7MttEAqGYjq/j/I3yNygr4iLi4FKI?=
 =?us-ascii?Q?SJabP2LaOIRXqRh0euk2yN38NvbT1U+vyZrxWDgvuMkRgzzZ+68kVF2Mpg0W?=
 =?us-ascii?Q?0XQxIAfbQG0A919ElONy997ZrYTP5WXPDUO6sKqdHINSmEVFzNrfGWWE+PJp?=
 =?us-ascii?Q?uCS3gaGmQAnf5BjfaiGyt6QDKVoTnVeGX0GDgjmA1kp3eAos2DBFSKL+nhnC?=
 =?us-ascii?Q?V4znAb/pM/x2Dhq7GuA9eQDK4A8+XPxi31ODJu7WZ0wVotAojEjtj4ZXFo88?=
 =?us-ascii?Q?pEtdIBarDxR0lm4Zt58KK60DVWbVSFcSwfAh0r/ufkm+cbvyB4aiRgpPkAAe?=
 =?us-ascii?Q?bYPhCkmmR1dSizoiiakvdSUB4lgznsACO1PegSgh7IQKSHyRWuCy/vlPAU2H?=
 =?us-ascii?Q?Sd9BoCEf3Uhc3u0O146VMDUnXDJryNp7E12UfMNoeIq8sHXSeMIPvI//+df4?=
 =?us-ascii?Q?OrZI1QtfMwvvam9R3nu1MbbdB+Yx/s2qa6oNx9R55D7DixlR9pwuCBLowOX1?=
 =?us-ascii?Q?JCb6JueRHhQTbloHxE/c0iegjKEZZ709dpobY2Lojp5dPBGWyvea+inK7DWj?=
 =?us-ascii?Q?THWeLI0XxiaMKZW1Ocb2+Zo9vjtkWL8HVn07Hqr7QdqgDaydWaU3HCT4ksAy?=
 =?us-ascii?Q?+sM0QpDK0DzvPxlGHivBJGNV4lgCIYsxA8ZHYFsE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ef8157-aa58-410c-4179-08dcc1bcc17a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:39:22.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXFDGFVMXefTLLY/XSztRGKtbynGaKKn4fzWHgvPds4S47GhOurmitYAuOjyB51sOJgqXoePhgDYz8D+pwj0Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5341

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/iio/industrialio-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index a52a6b61c8b5..20b3b5212da7 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -219,7 +219,7 @@ void iio_backend_debugfs_add(struct iio_backend *back,
 	snprintf(name, sizeof(name), "backend%d", back->idx);
 
 	back_d = debugfs_create_dir(name, d);
-	if (!back_d)
+	if (IS_ERR(back_d))
 		return;
 
 	if (back->ops->debugfs_reg_access)
-- 
2.34.1


