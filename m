Return-Path: <linux-iio+bounces-25419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D0C069B3
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F732503EF6
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185631A572;
	Fri, 24 Oct 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nczI1X6z"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CFD186E40;
	Fri, 24 Oct 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314616; cv=fail; b=hu/5DjbZZKc6/W6XHqgItasMsnZYHf9BRtsmdNyKTrL8uHnsGxK1tF03bQqtiCCxA7QP+cky3ze9ek04HXXs/DRifdtii6cWE/1BlXZ/osaLw3mpBHLDgx5eXwQrlePBoB2iJIWWmtkrTbHkW7P1JfwgGHylJWQcpc2+1l99/Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314616; c=relaxed/simple;
	bh=P5k4RhZPIU1PEPZ6wziwU8dPGBpd2XqeQQtiF63GRNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DN7L/cLPm74+W22Hp6Mz9KUcy1yquvf3QfVwjNGpwIWTzx5X8mF6X4jYY5IMxfJ9QvyisTsX6TF7X9d/GTp4pNEv8JEdr6a7zTseKDwT6NGCClUGBtv+OV92b0I0HZF2VrdYSu0Spd4NE96oCDd25x6WtprKMLEi3piOEgAT1Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nczI1X6z reason="signature verification failed"; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPslb19Tzg8O0jGCyw1lf6o7X/pI38Qp/twOaQfL00lHxQDpG49hpbDrJwm6wNsn87psZFoAFaNTDP92rqrpzr+HAZcgiojOgoxlG3K5LOwrl6zHRE0bRIzgfu8+Uqoj7StAA1P1CTQ3TtC8ftYBINR9Y/g1TOn5JqeRzKVnGV4gpn2uGlYFFI0m7bQfzO+ewCVPgS3/hgXxx/rhavn/vR8VqMboEU7Mut9Jta7NrRx+rXyhzV3+ulDiBmzTQfefc+3tDdFWrdqrvO2FwAzpYBhGr1VQ7vJFYkVyTzkOmeb2nMvygYnCVw9k3RX0Y8MpiihfXuYOcxSYPYKwSfg4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMEzb4rF5XLDLUEsM9tO8uf7Uxr5zWqTwCYoQXUsuUs=;
 b=Dq4MpnhR9Bnw6wnq3AcMSGFBdTzOu0sd0sVXNfAmoahxpU7yuNl/Pl//sCNrFliKZ1YIKLkR+Ragn73J3lkduFHYbKWmG9XgVIYgcOcGkpBn2JQdRerMeZ2uQ+FrNeL6DMw9jKciJQ0tByTwwk6UpAQ6OmGpREsanEnOOJWaEsrIRFtpbuzMuSmDZpz7NrmrWICDfsMWzfGPa1qqd1YnNYcjycZJTpN0zcvuApIpd4EmEZ6PD6PI/A7R/yCXyWSAXxEtJ458KKyO0fRCcvsfcbam6ZOXK2eICK283PJI8EiQ7xROLp8VP8Jap6zUkhcQm6ylUvHEoeG58QgOQrjIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMEzb4rF5XLDLUEsM9tO8uf7Uxr5zWqTwCYoQXUsuUs=;
 b=nczI1X6z7EoNwnRfhIno+e6zyu5bPjc2ulWmtgw8c3bcAe5MozkzXugTt7258fLol8u4+nMtQxfGmUfAbk/ssSTe9HGoerI6+yWCCabX04qDqPcx7OwWHKCLgVHh/obzlYrdowclP2bsSrr1A/oXEWeFspeGQ56AecgT9El6uAkbEsB4t1sOj6G34/qhnxFe28ZMnX1M+vkHsP4L1Dqnm9L8HQwXiw6fplf7ZiK9bT/iKLNdIxiBCJUDEZmZ/sea8AolZWYjf4dEtbzWMLHEivOu57T2QPoBWSIqB3FYKDP2CiIasqwYPNj9VUaBXDUqNA7aKGLpxOrb1JJTstsufQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB10428.eurprd04.prod.outlook.com (2603:10a6:150:1d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 14:03:28 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 14:03:28 +0000
Date: Fri, 24 Oct 2025 10:03:22 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/5] i3c: Add HDR API support
Message-ID: <aPuHKs3u344zoI2+@lizhi-Precision-Tower-5810>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-1-3afe49773107@nxp.com>
 <aPnmCwwZVZ5egqkP@smile.fi.intel.com>
 <aPpHTej/vKfiN68k@lizhi-Precision-Tower-5810>
 <aPpyf1xPmU_koEXH@smile.fi.intel.com>
 <aPq/6/+63sHuq/qy@lizhi-Precision-Tower-5810>
 <aPsZB44qXR77jNHF@smile.fi.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPsZB44qXR77jNHF@smile.fi.intel.com>
X-ClientProxiedBy: CH2PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:610:51::23) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB10428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a9d885c-a089-4da5-5f6c-08de13061b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?w9hDbfoPAghGu+9r0fugAFSHKoU8HQ8/Dvs2g2A/CeOZ80uPX8/hG1w3sY?=
 =?iso-8859-1?Q?cAE99NMMOyISnCDKwqfoWawYBJ+WJbaVQXOBgp69Zye8pKyReSBl4dzXOL?=
 =?iso-8859-1?Q?oXSg8uZCMY2Kxw70thyPktcVv/N6QCRrk8pcNAFBc4T2q1AfedxGSYPsxn?=
 =?iso-8859-1?Q?urxef9d2/q30ZGgSHSLIYoiv/25EHhcXC0kazSpBWCIvwyAX1EmEM/iDYo?=
 =?iso-8859-1?Q?FdHMOsevaGbr7vYqDN+8wUzFQw/0o7fFDnf0mS1HAI2dGO7JikWAIVnCpP?=
 =?iso-8859-1?Q?s3CDZkZfnIDRQm+kAsZEsSdSSjDSawQW8LAc7HPVrXiuT65RUTfIOpNW9E?=
 =?iso-8859-1?Q?OhNniav4ER1aAt9tygVFkmOvQpCi/hidR4PS9jjsSfniF9Unz4kdSORgJ+?=
 =?iso-8859-1?Q?ljmI/CGcsGZJjJ27IG8e6YA+4XWo4dMZXqxZLUpCjAKNfpt70sv6TM/9pZ?=
 =?iso-8859-1?Q?y8Wt1CB2Dd4iL4GtwYdSd6PaH5oDdgP32wIMLSfQ6H9XN/RbM10bGjsAUV?=
 =?iso-8859-1?Q?PE0/ukqofPaCft17uyyNZsaDOmYn1kPLoJkf6atGnFZAm/GP9VOPDly/76?=
 =?iso-8859-1?Q?2TIdhIz9zE78X6PgeTINVVTO/fk8oSP00WzQUOzxVAc+PdO1+dujA+Tl1C?=
 =?iso-8859-1?Q?smEYnmT9dYfU3vo8yY88381/goNpPlNTRLHQw4sMoe63uZYcPhpYFVL8rd?=
 =?iso-8859-1?Q?zz/zOrzVqK5tl8UBUShnY0Ou8bfCA7wuK98smI5qdgEwTU7IK/MF7fUQIP?=
 =?iso-8859-1?Q?ic+S0thkDAGqxc0sfmh5P8H/iLJsSuXmWV/nI0R77XvXUHnCGIV7S8U/oL?=
 =?iso-8859-1?Q?pZf2IPnZb5oaEfEomWmJIXXRD4iHFVh/E7uziNXu3g2zpaNr9EPf4aCs/N?=
 =?iso-8859-1?Q?bymSSHBbNILTwMjBrFzk+K9pXddPn1B0YdV9qCJW7eZpSUBjX6HcGnHiN3?=
 =?iso-8859-1?Q?BzQKkMVYe601FRClQmb4iMBNyHoPy9UqwkWGHLfgT6H2BO2hCQ4fKjpM4L?=
 =?iso-8859-1?Q?6V64j7aMSwQQwfmx1m+gNIXG+3KfyUrwfPqf3DR05Y/fTILHOf8jxV5sBO?=
 =?iso-8859-1?Q?VXR30KTTvNpj/BzcQ42Qwq2qtTMR4tBhv9vwhuMxhR6O97DpCl/se/F/sZ?=
 =?iso-8859-1?Q?AcM8U9dslJb1N1YM3ZKke2dtuqS2tyZE/s4iryE0wnXwSX5xfl4PElsvID?=
 =?iso-8859-1?Q?IRziWI2vAFWWIIOtlI2lHzo+F8DoXFUY5YaK5MhSHFdUGxQw2udXw/F8Kp?=
 =?iso-8859-1?Q?SmC7/A1PgzTF3z7VAnsHK3qQMCY23eD3yjemZ1uhVIPsCa27/fDAxGr+aM?=
 =?iso-8859-1?Q?Q6EIgkb6RQ9K01CrRXTc7ywmP1tnVnqcjEHxkjBEsUc/lwd1JX2AtuqBpo?=
 =?iso-8859-1?Q?zyAQoivS2y8gJz0nVvnfzP+sTsZCLzlEOautxFfe9xkzOEfMJGCtA3yGub?=
 =?iso-8859-1?Q?s/ys4gKIwmMVwR3qVFukFupHD7Ztt0P1ypqddv+GL7qDuGhQ6fDjkAeihe?=
 =?iso-8859-1?Q?XzheLC8RZo3fJaY6b/d8ANBJN52CtFivUpczVESnM385QXno8jJkY65DiT?=
 =?iso-8859-1?Q?HO0e3U7QEACSRw679b17S2exsKUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?6anVn7WTTGjpK1slIU8m6Yzj6aLT4lNqKJGGJfKTocTV8My0WaeqNp4/VO?=
 =?iso-8859-1?Q?jo5O1BrQTiXNGeCHycU2FXGs5lYnHQa4agH4SQfqTCuaomdRAobYO9PFak?=
 =?iso-8859-1?Q?mCJPQ/rCCgh7PESYYa2VNbJ97im349Xgt2kMMsn2HM0K78w+Ql6kGaIPt1?=
 =?iso-8859-1?Q?l2Xf0yQLH8sNKg6j9pLcZo8MaItRCI34DGR/zYGKtkm98dEVZbwGazOrue?=
 =?iso-8859-1?Q?UGw/m3VdQH7Z1598+MfHizl2n1B5+AkuDZ8nvFZf4wjpYqF6x2Zs6DE5nh?=
 =?iso-8859-1?Q?McKg8FS23uPigmvPLg3l5fPZcfFRiMZw+xH9YPs1yNiswNBonx1xXmhF8X?=
 =?iso-8859-1?Q?H7AgqZK1yNRiDbMCcr6f3ymst2CPhIJSRA/e6quTNZZNFhptvuxQ0ti9wD?=
 =?iso-8859-1?Q?iCDlkvXryDBFaKYWvNRo/UwqMNQGFIZh/vkGojOExCr1F8oriYAn32DqyB?=
 =?iso-8859-1?Q?qfQ7X/JzNrhE/XlnYKeGJg1mwOIhUax2ELWzaZTQmktOaodnPHUxbLObwh?=
 =?iso-8859-1?Q?BWTOoptF+cHCuu7IxIzDlNLwl+zabwPx5R8Pr+LzpJayJpPxDlbNMRf4Js?=
 =?iso-8859-1?Q?TrJLU2rZFI2rItukucpGZ5WfsZFVXc4YXIsS2mLj6z2HSj0xsZRboWN126?=
 =?iso-8859-1?Q?hp8Bif4YujAKaRTOj2GXn8HLTUggPHqi+br8mpJsTo8FpwynVtj0KcCNhi?=
 =?iso-8859-1?Q?u5CLsUf8WdBGCVNGK+O5JLpBM2UNGaig/Ve6C7HGe23QQy6by6wNKEGY1D?=
 =?iso-8859-1?Q?jDfcFGR7t8Ac2By0yQBYqwLvYoKh64ysHIjK4LwST1xOMbbzPjTPlmmrN4?=
 =?iso-8859-1?Q?UOU01IFcBRQ82p1necege/aXpgHURnhHh5ZtuGCwOyRRXWgwi7Y3BWJ19K?=
 =?iso-8859-1?Q?k7mh0NW4KzDLSDXsve5tard3wjQ2uSIXoNlRtlyHW1sEiXLPTPYdCY81Fl?=
 =?iso-8859-1?Q?9lO03f5UOFIfx9QXE46kjz/XbPLTBFcS7oRbRbCZLH6hiOTxowDiMws4AS?=
 =?iso-8859-1?Q?q6uShrHQQnATYZxNNXE8ogTXkIq8n4tGdFtKo8fxXRDgAqbsiKg08RPvGp?=
 =?iso-8859-1?Q?RPWn3Il31yseVXIKbf1KFieLLeblGIzRLVPgFmsl+Zd+wr8e9EoTySKdyH?=
 =?iso-8859-1?Q?zF/cA5P4Bu1P5H7ZzuO+bRnohJaHmfy9RgrQSvXPJhbDfJskJ4hsxFoqDA?=
 =?iso-8859-1?Q?c+hIHVgBlcaKADw8a6cPTwU2NB1X2JPuXm2HQFxoTAuyyOZnjLVrv9Lby6?=
 =?iso-8859-1?Q?rwJNu5E/etquyzEyhVafzFtVwBav03tc3GTrAcaXFkzzFJfCKz+T6N2Fh6?=
 =?iso-8859-1?Q?CJyi4IjofBLxu+EJnQJicqXGi9m08QrtH7jzkryMqK/FitGn5nL8wTV1iZ?=
 =?iso-8859-1?Q?+ALZBMzWc92ZrZ3Z1q4LUS54SV73/Uh+UQMX14sAXmoKGi0RQ/V9FtfDQE?=
 =?iso-8859-1?Q?OKzWuuZ1r5n8rCMPY89ynFi3G9ttnymJSp32H5Jgt8/NpWVJVcCe1fN3NV?=
 =?iso-8859-1?Q?FGScDRlgG0/gccG//bdrtQNLMZ789mFzj1SreqGoZJpEqKsQ3ztwXBIi7/?=
 =?iso-8859-1?Q?OlXhzSgOe2pS/LTSQCiBvXAd0mUfP25lSylXAN6YuIsTwZwZm/u/Z4VxKJ?=
 =?iso-8859-1?Q?+bNoAYYjLVeyYElyMErdmT4ecpu7VF7b+n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9d885c-a089-4da5-5f6c-08de13061b4e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 14:03:28.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSGocn53+avgsHuW6Gx9oiniA9P5vrrrAQpoQrK+VhSAdKm5ScUbwvO9TmXh08KVYcKsUJo6bp/WMw6AOangxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10428

On Fri, Oct 24, 2025 at 09:13:27AM +0300, Andy Shevchenko wrote:
> On Thu, Oct 23, 2025 at 07:53:15PM -0400, Frank Li wrote:
> > On Thu, Oct 23, 2025 at 09:22:55PM +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 23, 2025 at 11:18:37AM -0400, Frank Li wrote:
> > > > On Thu, Oct 23, 2025 at 11:23:39AM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 14, 2025 at 12:40:00PM -0400, Frank Li wrote:
>
> ...
>
> > > > > > +/* keep back compatible */
> > > > > > +#define i3c_priv_xfer i3c_xfer
> > > > >
> > > > > How many of the current users do this? Can't we just rename treewide?
> > > >
> > > > git grep -r priv_xfer drivers/
> > >
> > > `git grep -lw ...` is a better approach :-)
> > >
> > > > drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[] = {
> > > > drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 1);
> > > > drivers/base/regmap/regmap-i3c.c:       struct i3c_priv_xfer xfers[2];
> > > > drivers/base/regmap/regmap-i3c.c:       return i3c_device_do_priv_xfers(i3c, xfers, 2);
> > > > drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> > > > drivers/hwmon/lm75.c:   ret = i3c_device_do_priv_xfers(i3cdev, xfers, 2);
> > > > drivers/hwmon/lm75.c:   struct i3c_priv_xfer xfers[] = {
> > > > drivers/hwmon/lm75.c:   return i3c_device_do_priv_xfers(i3cdev, xfers, 1);
> > > > drivers/i3c/device.c:int i3c_device_do_xfers(struct i3c_device *dev, struct i3c_priv_xfer *xfers,
> > > > drivers/i3c/master.c:   if (!ops->priv_xfers && !ops->i3c_xfers)
> > > > drivers/i3c/master.c:   if (!master->ops->priv_xfers)
> > > > drivers/i3c/master.c:   return master->ops->priv_xfers(dev, xfers, nxfers);
> > > > drivers/i3c/master/dw-i3c-master.c:static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > > > drivers/i3c/master/dw-i3c-master.c:                                 struct i3c_priv_xfer *i3c_xfers,
> > > > drivers/i3c/master/dw-i3c-master.c:     .priv_xfers = dw_i3c_master_priv_xfers,
> > > > drivers/i3c/master/i3c-master-cdns.c:static int cdns_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> > > > drivers/i3c/master/i3c-master-cdns.c:                                 struct i3c_priv_xfer *xfers,
> > > > drivers/i3c/master/i3c-master-cdns.c:   .priv_xfers = cdns_i3c_master_priv_xfers,
> > > > drivers/i3c/master/mipi-i3c-hci/core.c:static int i3c_hci_priv_xfers(struct i3c_dev_desc *dev,
> > > > drivers/i3c/master/mipi-i3c-hci/core.c:                       struct i3c_priv_xfer *i3c_xfers,
> > > > drivers/i3c/master/mipi-i3c-hci/core.c: .priv_xfers             = i3c_hci_priv_xfers,
> > > > drivers/i3c/master/renesas-i3c.c:static int renesas_i3c_priv_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *i3c_xfers,
> > > > drivers/i3c/master/renesas-i3c.c:       .priv_xfers = renesas_i3c_priv_xfers,
> > > > drivers/i3c/master/svc-i3c-master.c:    struct i3c_priv_xfer *xfer;
> > > > drivers/i3c/master/svc-i3c-master.c:     * at svc_i3c_master_priv_xfers().
> > > > drivers/i3c/master/svc-i3c-master.c:static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c_priv_xfer *xfers,
> > > > drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = 1, .len = mi->mrl };
> > > > drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> > > > drivers/net/mctp/mctp-i3c.c:    struct i3c_priv_xfer xfer = { .rnw = false };
> > > > drivers/net/mctp/mctp-i3c.c:    rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
> > > >
> > > > After this patch merged, I can clean up it at difference subsytem. After
> > > > all cleanup done, we can safely remove this define.
> > >
> > > I counted 9. I think it's not a big deal to convert all of them at once without
> > > leaving an intermediate state. But this is a call for the I³C subsystem maintaiiner.
> >
> > There also are other cleanup works. The key point is that everyone agree my
> > HDR solution. Cleanup these is not big deal. I am not sure how to avoid
> > build broken at difference subsystem.
> >
> > After this patch merge, cleanup will be easier and safer.
>
> Then leave that renaming to the cleanup series. No need to use a define, just
> use the old function name.

Using old function name for HDR will be very strange and conflict with
spec's name convention.

The term 'private' transfer in i3c spec is specific for SDR transfer. It
is neccessary steps to complete whole naming switches.

Frank

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

