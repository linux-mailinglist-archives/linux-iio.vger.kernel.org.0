Return-Path: <linux-iio+bounces-18086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F308A886C8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D4758542A
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2482472BB;
	Mon, 14 Apr 2025 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JaxqYAPb"
X-Original-To: linux-iio@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013022.outbound.protection.outlook.com [52.101.67.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D260539A;
	Mon, 14 Apr 2025 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642578; cv=fail; b=fQtYAwr6bMo1vU3A9qb1c2ShPg1KzauN0IMubah+hEh5lQ0OoCVkSVq4agKHJzhQucPVj5HWEdWjqo8l6FMSnNFEEDm9gavQc08/2usQcd9TvldCYuOF71E9/HxsVqiRtxvSjwboLJvWnn2waemQ3zuY7/VpPvay3AzlbrLGaas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642578; c=relaxed/simple;
	bh=iLzn8ttjJugvFiE7V/ht2iTXHj2dPGdXHlPSklvHR/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kx6ZH9DjUZZS9mVfhrl58R0IYD10fW8Cvy4S5x3WRxnZypU2fITNBc7BzVB/Lp6tBgDWeVqbQciH8b3sdXUut9G+QSq0Gijh3ceFkHTF/9EENWdgGJ04L6QNBONhq8TxFRNmBvM11udA8K7iElwrsQJ8qqsIHt9cPQO9FlCjAiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JaxqYAPb; arc=fail smtp.client-ip=52.101.67.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lImUt1ZLgjoFg1YakYWbKgS/vB9G1vq63I+7C0u0lsYcSYjwSuIyGkH4ErTWyO7XdG+tnvsapCnvmT1kOcny0aGpxKVXVYtm7XK9jkZTgKN+PxpnlLXyOUb3lAnV1vwK75rEcnxi6NztO1dc0ez0B8vaVAoftaIdhdz1QdM+YMvNL2kDyA1fYxBV0KdjFbmiZm7+ABzucno2PDHrv62/+55F6dBctHU9xtX8Dz1gwp4S9ApWm6iZu1Tn9KUrez5wbqhSR7bpFIjfY6oGTByVAPiVXroq5Q3dKd0zsLVKF+wBcnDpwWjqe4hS8RLZrtt4m1kMNi1MQvbG24lPTph2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGDzh7JRZ5F+Kjk1GInhB/j0vpCc4ack2sxFKapcwYw=;
 b=zWuVTT0dIkhBjT2uKDcX9wiV40zohJW/MImpQ8DyjDHHAevPEwk2rYBLrPuqwh3JxMjLN/D+y5sgCmDtBJmt4ZTpiZsbcELBeyW5xfx2mG4FzUgtdfbDOCEk5M6GvIvhOM9l8yVkFox/HWmdZBzWeWQvSkIXAzpjpeaEKHaujBNbjXRksfjPm1F5EGCNXfg4WY0NuJcqxP22Mv0svbg5Ju8UqXVk5hBlkKwoAZ/BIRmObBI6I2fL0rrr9GLtDhi2SS9K/Etd3LqPPrP8KMgRqboB6wo8nQvPcK36CyZm9idu8ask+epK/R5RDyi6vvwiEy+Wkhiy54tB+HgmWkGreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGDzh7JRZ5F+Kjk1GInhB/j0vpCc4ack2sxFKapcwYw=;
 b=JaxqYAPbmg/3eJX6lx5GPTvpb6ZTOUSwyZPp/O3bm7mLPlzQIpNPvrkv7sCfnVw72oeWxtZ/oyZ2txMsfor1AsxVNQ1boa3rhGKo2Ad1BLNSz86l6itjs0A9D3zoKWvHSOntG2PklXFd9kkZYTdH6QGfgnKSS3KyuGsViBZrdpV18c/kxyrh9QDlaGbmThGNInSfVUOnJgc5sWZt4ZfKFI+1v8ZLCAc0kodsGgLfGJa+fWzV3jztE40bfkPg5qPeI4WJ8q7DqqskEELD0zuiS4RaJmuHT2xOJ6OOehxRnN0+325XvJRN6AF/ClEt623ksD7FSiP5Ovm2uwkcGTfTsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10861.eurprd04.prod.outlook.com (2603:10a6:10:592::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Mon, 14 Apr
 2025 14:56:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 14:56:13 +0000
Date: Mon, 14 Apr 2025 10:56:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Havelange <patrick.havelange@essensium.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in FLEXTIMER FTM-QUADDEC
 DRIVER
Message-ID: <Z/0iA9Et7MlviJTv@lizhi-Precision-Tower-5810>
References: <20250414093124.19683-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414093124.19683-1-lukas.bulwahn@redhat.com>
X-ClientProxiedBy: SJ0PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10861:EE_
X-MS-Office365-Filtering-Correlation-Id: 1075cf9c-fcb0-440a-189b-08dd7b648010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LFPYBAHK4VVQC/06cQdXYzvaC/H8+Fj4Ot04t1HMK1VHyMZLF2wVxZrOtjgd?=
 =?us-ascii?Q?i4xeX2DT//zOJS6C4zNfP4p+OBwLebbmWczF6CafYbdNRLnzbHPPcrj56Y53?=
 =?us-ascii?Q?P8eRz3FjWPDD3PN9gV8XHHjc9o1/8tLFYKEXBUNiy/OZu1U/5MYeVdY2dIsv?=
 =?us-ascii?Q?1Y5jjLni/dGHIG/vUiO/gq6aoX87pn6/TNiT7f0Fgm2IFzcaEIiJ1453Bd1I?=
 =?us-ascii?Q?U7iewPOjQJ5eZcEp+1j3elIVWmXHcv1BhMfWqXsoD0bSjFGp2bU2CwlGn8R5?=
 =?us-ascii?Q?zBlFnRacXEr7FaQSDVOUEk6pNGrw4wgRGaOSD8OAsF//qVj+IDKO14vTVG5M?=
 =?us-ascii?Q?1cDRrwjc1ipEi0aDQp/Sbfrp/loT2SQINqx59D2O9r/mucdpkWDPA3cu50NU?=
 =?us-ascii?Q?f4hV0JvR//ko3xCGq/IR72iHGDH6lIbIPPf5DJcMpZFUObcFG+yLIHTZm/nX?=
 =?us-ascii?Q?UuvvXoR0GpXWZgiJFvoxLQs/KXgIeuAcZqxvm5FKwYWbWdN790fQBOrgKWKq?=
 =?us-ascii?Q?7TyY0EfVSNIdRphEH5iyQ7ML0QyPHL56PhhRhMHo2NqEY5o6h5BS9bzMYmJm?=
 =?us-ascii?Q?ygkpq1voNE6ClIpnmr7EiV4gUpuu3vUr3dnLg7f/q7gDx7aM/mxsv51ptsv3?=
 =?us-ascii?Q?v/2a9mAP4tD9K5uzD/wxh/W5VecESNqWNU4COX4rzNoYvq4HPfrCRrBcZM4j?=
 =?us-ascii?Q?zzCTsbusMnrMWgemTqVHt5xWXQsHB34JBCLq3uWixyxu40C6nfEydteoDECW?=
 =?us-ascii?Q?p9S3f9VUGRGgQ9T+HWSVdmcmPZ9E5CtwEV32Pp1nJQ4oJ1MNowtdlwqFVZDU?=
 =?us-ascii?Q?QHhUoDC7YfaNjTPWGKIV+3d7pD7dcuhLB5ESl4nENLcQtA/M0s0mqIIU/kMc?=
 =?us-ascii?Q?2uHRIyZW6f1FQ8QQpNDeiXgN00OXaS/BD2hZVIQrwfYCZfRRH6NVm5gy2Caf?=
 =?us-ascii?Q?w+XhqbtXp8ey8aZN50dTJqsrTxPbZ203kVequHENjkwW7WGcaYiksuujklTj?=
 =?us-ascii?Q?sWgaE53AXTB2l/TcRJR/qKQ+kCQ5ysDOpKYShzSK5AbOICjIzFXLW1UqVY/L?=
 =?us-ascii?Q?ovXj2PKmhaHDkTWW5rDmHMIjj7R7tA3M5V4T4ip8N4PsgR1zFa71x0Eg0exA?=
 =?us-ascii?Q?z0LVCQYFRpJZQeIWpqjEZsoHiYkDRggjKmEoWTQL7fGKy4c1YH1gJTwPdg9R?=
 =?us-ascii?Q?EK1PBWFKzzUisjrZ+DuSjWkCE89efHtPnV4AzJ30hSf2BMMo/Tj9mpzTs0tB?=
 =?us-ascii?Q?EUA5L8e1U2cSwfz0bag7AKj0N2zyqZ/x1VJivjiPgjdqFDk5J3qrpEkhX05m?=
 =?us-ascii?Q?lmZgqMXIDo4witrDjLpYzNCJh3QAXszWrX5PX0fMAPFK/MRSlrphmmWjEenx?=
 =?us-ascii?Q?Qz7JNGiaCQBUj6CbBi2Pe5R7+cwk17y1x4Ife1LxZaopYmR+qqQsXpWcyOdK?=
 =?us-ascii?Q?DQa5viYRKcu25trGhgLN7mHf39u0gHP6Sz8KRtst466Y+PyNdDcNfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QYR1DULc+gd3ddOZZymjsqZM4iJfDFbGNQ7q0wFJIxk880OwxWhTkW8yiNdT?=
 =?us-ascii?Q?hlLlWbKJpBufXlXrcO0X6Is4JVKwxFV7a2OSZPUB2JlaYNJ9Wj0Sh63xbZhz?=
 =?us-ascii?Q?cU4t7oqAIpWl3/aU6mWkSSwwS4PyO+JS+e02oST2BiQoy6PzpdQ85guR1DJp?=
 =?us-ascii?Q?cUYAMiCZQPd7L2T61jTHqbpNvBjjDJUWOUCo+LbO4+/YhBVXkkWtWfs+RUWc?=
 =?us-ascii?Q?3AvxbvHPTfyI1rb34v1zq44XfDS6lLVyMcaxVwfaSMdNoRHvzxZZ4LzTzIjG?=
 =?us-ascii?Q?xAq5Oaz8TaTP+sr58Zty5g6hwfSQJWOTCixT1oqJhSqVtvHyCHZH4/rorRj1?=
 =?us-ascii?Q?64Hj/Sm4jy7u5o7c8kOArFJ82Buabwm+Wz5HnOyYOlJA3DJlOqQP1U4sw302?=
 =?us-ascii?Q?RmpgrNO7I6wUODbqqlbyUnU9lhks16EFofItK5NjMlsDzz0YYT+dnAzkbaZM?=
 =?us-ascii?Q?1krBvKFgjWMJST/sEa5+2IzcpRL2QM+lAvIbjddCyO7jPLCA3LnB43DK21zO?=
 =?us-ascii?Q?uxWu5FUr3GD+P93UgKRckG9VqorovE0UjNexHq/DaV5b1RiOeTD6rG5GZhsF?=
 =?us-ascii?Q?3Cq2h7fhBy5jfHZD8ciHx6S+UkesUufd+SV24yeECM8cXzZdL9xqArjw2XYt?=
 =?us-ascii?Q?ECCSLGZIYGRbC6H4wufMC/suTapbD9wb95FODR4gzQwLnMy5X1vwf7XsltKT?=
 =?us-ascii?Q?0y/+wPyqs/eWdVSs6H+XyM1RF7YbAn8CLx1TMCGZNc67OPR0E0pnZrLsezc+?=
 =?us-ascii?Q?Z0I3i0lT0KD0Ag24y+mg0DzXajc3ntF7HSWc8iRXiDTtV3wLiqEEIgvoiY5a?=
 =?us-ascii?Q?C5U/Os7aTpisJDuxjKq/QNvUiMZTh0lFYx5f/DetJFa3leFaGuga6YShWKQi?=
 =?us-ascii?Q?QF5RoGvc0YRs2l2sHtiBiqWppHUjUBg7j9UXRwb41u65ijd9+ap893ZZ4I3r?=
 =?us-ascii?Q?EZ1Ei9GqW0Nt4UzGo99K+9NCIMf22dl+B5sFKSfmuytdDJrEbC9RJuDomyef?=
 =?us-ascii?Q?NoLzh/tnZG2pO4XVgy49IAlzytzuAfQhi84dmCr5HX1SfFbh+F61ShU7YNI7?=
 =?us-ascii?Q?0xtoyoLDMNGygwbXofn8xHANvFdpC7m2N4OtxLs3o5WAD6Vj5mpIfGdI08mZ?=
 =?us-ascii?Q?JzNfgLhheJFSgqJudLoi6CjGraSrRgNE31S5HlZnccUsiIAvrdsNfO0vQciz?=
 =?us-ascii?Q?HQc40qrjp67qI3rAUNHPxwUE9Y/o7IoCad88Phmic+Yulskf8+cmDLEaC5oj?=
 =?us-ascii?Q?V6iJS8xtS0o3SoIGvzig/h6oUDL50Zyrc0I75yhjsGbDl6Kln7bVVWpIf5cK?=
 =?us-ascii?Q?izCKlZ8pAQJhL4vtrSsgrj2Fmx8l8cnv2prjppwpgmCsc4o+UJnq3BpfaCtV?=
 =?us-ascii?Q?W2r4vlWUaFLQZ65F+5ldihkcH6jH+n3kTdqXb0qvwcAU3kGRgK9XVoq64SZi?=
 =?us-ascii?Q?q5ypLbAsO/4s3WAzWM8WlpMjy87o0JyLyO8h3TanHkkI1ZZKQDB9kNi/J7n+?=
 =?us-ascii?Q?pTGpU3aygF4N8Z2mHi7WeaHlX+ur2HUIJECBr1idmMSxPqY9RtRtpK9mJuQl?=
 =?us-ascii?Q?NLcutWTFmzvIwAyqYdM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1075cf9c-fcb0-440a-189b-08dd7b648010
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 14:56:13.5498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4/oCMREk+yLlmPnipZNk0kZtvQbzNzlrN+YKuTtqYBr4ywjabYwcqHywayNcPLBAVuKS5wcGD/H1NEs8p8g8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10861

On Mon, Apr 14, 2025 at 11:31:24AM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit b7549ed5edc6 ("dt-bindings: counter: Convert ftm-quaddec.txt to yaml
> format") renames ftm-quaddec.txt to fsl,ftm-quaddec.yaml in
> Documentation/devicetree/bindings/counter as part of this dt-binding
> conversion, but misses to adjust the file entry in FLEXTIMER FTM-QUADDEC
> DRIVER.
>
> Adjust the file entry after the conversion.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af3537005de3..661419d7c71b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9216,7 +9216,7 @@ FLEXTIMER FTM-QUADDEC DRIVER
>  M:	Patrick Havelange <patrick.havelange@essensium.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> +F:	Documentation/devicetree/bindings/counter/fsl,ftm-quaddec.yaml
>  F:	drivers/counter/ftm-quaddec.c
>
>  FLOPPY DRIVER
> --
> 2.49.0
>

