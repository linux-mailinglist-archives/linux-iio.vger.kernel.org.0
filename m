Return-Path: <linux-iio+bounces-12428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592369D4302
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4C31F21F25
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4091B0105;
	Wed, 20 Nov 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="DRlWcLAQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022079.outbound.protection.outlook.com [40.107.193.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D683E145B18;
	Wed, 20 Nov 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134381; cv=fail; b=HsJvxWkm4p6tLZmkKGkKG6s5BEuUkmCMhWPfyDlbreK2WkarK3tEJGu9SgudM/za3zDg6ejP7Ecyd1C2z7Yzj77nJrUu/hiHEkmD0Gn62xv3Oz50xSUgbgxS2D3gip+q6ptOUXwbRwIUfshyMoMls/dlmOnEp2HU1yoF+4Pj1Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134381; c=relaxed/simple;
	bh=vh2oRTLFgu+nLtoNlVOB5N0t9Entg6OFZHSjF/rMVKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o6peHo2nedaBQ85lgz/JKPllaiS2f4LfJB2LSHwI7QvRSzX/IecVtQKm7e0XqVb5dICE8ysGvUjFU/yFjB0TisCwoTkzbr08Ig6JKeITdGyuu7TUMM26HUTf4f5+oeU2rO4R+cTfXTBrCG+OY6RMx6eHgWg4pWbjdPsszMnyj3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=DRlWcLAQ; arc=fail smtp.client-ip=40.107.193.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5z5EoFTdv2TQSFHtPaZRsw5QJXr67wNl0QBFo2VCohSuPaxugSrKj8vHWqNmZsfE7pt+ei1ZWOsDPJftdw2Tj+JeqDDsmBdcaxKX83wnuN8jZIKk6BjLg2M+4ctBpA6kc4vb5TMmCIB/Ve3p3S7691L0Jh2HHTw/C705coasjUCM4G3gwxNn4Dlx1MRvNBHk6ZialHlyVpedg4NGpYJiGLnBuO4KHEA8RU3mLVi14dXIqSmTrgQc2pCRbfTSwO09w7xN6l6yg9A6u5VdXq8CS1HGSzS5esh1FcvsDOPrmIW0QMgJ7wy2VMO4PpaB0JY0DgqC5EcMApMIdxHXP/xSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dDK8zG+DZZRMwYpWei2zWM7BCPmafabx5ZdNM1rbVI=;
 b=Bjn8GGeeUiB6XsOQR6yw2Z7SmHketQBgOKtLFVQBzA3NNyQP9ZuxEDoUG1a0ASkfLuqaGUkQ/R6h+o9HLxcbCf+5E25yYlOOgMs9nWCNI1/nvglZz3dNv6g3pGNOnNROM1sGhu5UlGa0TsFOLYayCCph7S1qtjl6qHq2VAgzEr2os4T3o5+CKXpOM30Y2UX3h0JzmvS0X99d5KJ1adlwuwBcjn4uL01Yq6DjPnMSY4988uCHQjh3sTl5uRb5khKG24Eat+li5Cbwdu9Xy0MEVsow1LBhdBCuCXF3EeRi/Yq9ZMt8eCZD4WaSlUmFedcNrOEfmmX9O3Uwi1Lu2uc+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dDK8zG+DZZRMwYpWei2zWM7BCPmafabx5ZdNM1rbVI=;
 b=DRlWcLAQCAr65MYb9/AcKq0yFblrOMMmADmQYskbFLgIrpIykxwInaRmlTubM4BioAmfgl7JuzY4E/M2UOZtg6bAKue6vrTZQtN47q+OA+etq1yXPIbalFtwuHrsG5JMsKgxUP7oI6uf2yVhHWRudXGHzqaTilLk+9v1AoXEjug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YQBPR0101MB5848.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:33::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25; Wed, 20 Nov
 2024 20:26:16 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%6]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 20:26:16 +0000
Date: Wed, 20 Nov 2024 15:26:08 -0500
From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <Zz5F4JQVxA/AgNva@uva.nl>
References: <20241119-apds9160-driver-v1-0-fa00675b4ea4@dimonoff.com>
 <20241119-apds9160-driver-v1-1-fa00675b4ea4@dimonoff.com>
 <20241120-case-guy-7456f9f850fa@spud>
 <769d80cf-c4ce-48eb-964a-e5963f2ed138@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769d80cf-c4ce-48eb-964a-e5963f2ed138@kernel.org>
X-ClientProxiedBy: BN0PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:408:eb::27) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YQBPR0101MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c49823-2f2a-412f-28e7-08dd09a195af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rESGp6WBdXYeoFFjO3iWS062wT6sIR/sTLZu9Qldd+vkqmjR1wyHTobUGIz/?=
 =?us-ascii?Q?CrP5B2986rNlvSezVoG7QbRlzbL6gfODsU9Ceoc7aaVNKbGEAwQk7vX3z+JN?=
 =?us-ascii?Q?m/V+69mPax4KfwKC1s/Mt5Sv2dInm4QXWQuYBIsgW/vBsze+8g83GnCudKAC?=
 =?us-ascii?Q?JS9f0MCXmROEsjtDYXhcTOHMdOWlIvgMM2KdM8k4Fcq5HcR/fJOSG8Ec7lP8?=
 =?us-ascii?Q?f0vQgmAASNTUAznggstwV3GCsEruRXJXi/v2NGW34a5+VmlKSspS7qaqCf+u?=
 =?us-ascii?Q?g/qlbABtMK/OPDkA1NSlv1Hw2RTMQ8XkWpyn46Ek+G8beYSlIWx5Ni97gcAN?=
 =?us-ascii?Q?yF0425VXbxPUeySrJLm8EfR5cNotfYRAsGTsTNkA0MIMSaBTN+YIRvjpaxtf?=
 =?us-ascii?Q?6yjj09FrzCYyVql2W6XqnOQrwOF9Q2mdJnTaJaMSLIi9vw7UGvqOLfDV+ct2?=
 =?us-ascii?Q?C5O3uv95gux7cL8wqKmZkgwR1xMnGm5pwwMfWFOZlV6iiRB6FI1+w6cgfKSp?=
 =?us-ascii?Q?9LqaKuDqwyhTQL8TR06gOhVzHJBQMFUHtxJ/j4g0g2t2oYwEUGXoXCAkxoL1?=
 =?us-ascii?Q?pCf9YeHbSeya/LErrW3bjXCI4s/mvmjXaKn0cJHoEA1DM0f2clqqfy7vXDIO?=
 =?us-ascii?Q?oRnf6OGfD/A8BRSr9mCtsOf4bed2PYR870UMc5CJoXpWh21VLsftUnrzHeI/?=
 =?us-ascii?Q?tqKFO7TWsky9JHDfaN3uUuxfu+N6pJ6AVPZRjxiQ2WB6/GKBguKvV/gCte50?=
 =?us-ascii?Q?rlc6dp4WbaW51X1/rjEOyxRirRfWJ5GqGV9Nyl2DM5bwttoCLfkMkFj86jW5?=
 =?us-ascii?Q?9Wx7Gh0FQ96tZ/PQJQXNpx8bjR+sIn+NXHiH+ss4HrWDO6Ii3UD33zoFsrWV?=
 =?us-ascii?Q?dBNQxPNUVIVZrTXrTu2JmXvV5kRHjxalfWaiqWJFIWfWgN8+OYTadqlStLq8?=
 =?us-ascii?Q?79jj/gQwz+iH6mbHyJG8Oxdl4ORXBpgPO3c26BmM7EK7iH83MbsRuFYIomeg?=
 =?us-ascii?Q?N4plOMn6FoE4tYmZ6CKv1GwTO0Uql3thWYLhWA+RYBjqKiDRwV/rJgqh01se?=
 =?us-ascii?Q?RydLCXkn2+mbCEJQRIsh2G8EepHry86rl1LEIA7j022bJR36UI0R1PRwYc3A?=
 =?us-ascii?Q?loUvIWDEDtAFW+MHDArHoYA3/MsfMaAUL7F0+s1tc4aoJr0MDfCq5E1YpL1m?=
 =?us-ascii?Q?06Vajw4x+9Lwvzsba+uVRnD3akYUMh3RZypi3cpKYeOGAVOPPMVX6Hr15fYv?=
 =?us-ascii?Q?yCZpcFa/+A+UfY41bTGP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ReUJ3jt4UzqjmYzbjdvXL43iW2ZvGP60S0LO5YtJeJtkH8lro7IFv0M7P5SC?=
 =?us-ascii?Q?oQDBpxmUgX1spz4kTplI6PN6wg5nKexhfXiDhj6vCHNwbz/NbDS3rxYGZVp7?=
 =?us-ascii?Q?m5eVsMGqway5X+5LsmDwbJY82v5micB1P/Dhb1pYWbhSxrU8j1pqPWKXC+fc?=
 =?us-ascii?Q?eadpZ9dSNY4x9vMPQ9VRDVMGcJGVKqSjpFANVGvWV3jRi7FUxcZaztxIDn9a?=
 =?us-ascii?Q?1gCRUr+iZ4PJ1VFaf1q/bge22f+Ca7J+9bfe8xwz9kA2kKsphmv09iEO9RDO?=
 =?us-ascii?Q?oUZjvtcl1d2FB/Eel87sS4igCzDKPL3q7yui9K/FXuVuWYSQMkUws7n9qb05?=
 =?us-ascii?Q?qe3+EBIqj5ytjcUWWKBm+BLq2Xa6HRaYUsjgi+S+rZspBYMaZ9cR9DJ59fJR?=
 =?us-ascii?Q?0QhpOvOEuydAiJos383QzMsHlt3f+M+Cmlw2sR2ZtFeYdoSVX6jQddfJL2SJ?=
 =?us-ascii?Q?u2AkIoeFv+GcT3xMAqtkOa+vi91cCX49wFZYtLwGgyP9F+DLLzyOrytCL77o?=
 =?us-ascii?Q?hloQHwC8t7iwWCzfDpB5VCyMQayJZ41aYc7dWetdNnqi95OGDlCdHQBG1dXc?=
 =?us-ascii?Q?axtPjsG3thd83nElyPIO5OpO8Vc/cwqJJdd3pd9m3R+kVIHzbYQPhofKzB1I?=
 =?us-ascii?Q?Ch2/vzvj+VNR8nxS4oQCdApJDlMQbkSgeBCKGMBYuVB9/RlSISXwu2iUMsLp?=
 =?us-ascii?Q?DQ84vfJF9IgAF8nyOhcKxmBYKE9l+s/yJ14S+brw5GLW5m4asmP1A7Sy1T79?=
 =?us-ascii?Q?e6CMRoT2Rx48JOOhRceryPWcjj3ITzapBjhU86jyUFMs2f3lc34ZtHBUhr6Q?=
 =?us-ascii?Q?Jpkdar00gM6aPw7xbNQ95goGnXlFgZC16Ml0dwBugthhhdtf7761/QcquAPc?=
 =?us-ascii?Q?eDOhsy4cxdpF3IgcteriEgBalTgsox9kyOJnAQ45ue02cP9BP3NPmSdzLJRS?=
 =?us-ascii?Q?RBs1/1vNgG9BB+6i0t6DUyyAUOcLPcakD1MFjDM2PyNA6fF7dnkOxWxMgWdt?=
 =?us-ascii?Q?bICnZQpTKSZZoKQdPSXbAHNFfV5pwOHsXqdA9Vx3/F/qlySBYog7RqXlidWL?=
 =?us-ascii?Q?Li7KT5i1NiSYDhfpCeURhSAknzLh7rtXlquXEH+lRtASD5SKouX/zk4RDAfN?=
 =?us-ascii?Q?1wWypa8lWsf/6w1j6GvqsiRHFqZxiiqJNIZFYW8qtfl9m+Gx70VKNaDJGFqi?=
 =?us-ascii?Q?wtZuMKjKHUOldw/3gy45tp5jRIJc8CJcIRTdSod7uKkag/FvC7noK0MgTLsE?=
 =?us-ascii?Q?msCNuEp0e2P+QusUAPv9Ct45hy30JghUGJipW1HSjF2ypGaP/Znx3xjdpfKa?=
 =?us-ascii?Q?WXXbXqO/kLpMWvBBs6JH/LGy6KmN68rzpJ8O3/Mew2MAx2j3K4qPH+0Vge+2?=
 =?us-ascii?Q?VpQNcI7mdAnosW16VmVCN99yNxx+tePW73IrKteFcXZToQe4Lw9dee/U+p87?=
 =?us-ascii?Q?mw4HVd9UeA+hUlIm27NRI6Z9nhHbg0iHJffFFmm0luHnyDQNeFzibe6ySK4s?=
 =?us-ascii?Q?6yNBEZe/V/klp6/OAXMqWxsr2Ub/8pXR83/KXlI3Dkph2NRPNHeHqD2pOSQk?=
 =?us-ascii?Q?G7t4KGESmdC8Tr63YnAlYXS0qCNcFAuqbG9nXaKbKfiSYkrh+JOaoatwqgI1?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c49823-2f2a-412f-28e7-08dd09a195af
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 20:26:16.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlLdDhMbB4uK6C31knK6WhSe2gVkob2b5XD/0Xrwym34lLngwKROc+9UkR6cm7vEQ90TI0eufILIySVNP7QbWvBESJr/IZ0XwnLm9wA9p8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5848

On Wed, Nov 20, 2024 at 06:23:11PM +0100, Krzysztof Kozlowski wrote:
> On 20/11/2024 18:18, Conor Dooley wrote:
> > On Tue, Nov 19, 2024 at 03:36:56PM -0500, Mikael Gonella-Bolduc via B4 Relay wrote:
> >> From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> >>
> >> Add device tree bindings for APDS9160 driver
> >>
> >> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> >> ---
> >>  .../bindings/iio/light/avago,apds9160.yaml         | 50 ++++++++++++++++++++++
> >>  1 file changed, 50 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..12e196b297fe523e4d324156041ef9c6900676eb
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml
> >> @@ -0,0 +1,50 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/light/avago,apds9160.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Broadcom Combined Proximity & Ambient light sensor
> >> +
> >> +maintainers:
> >> +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> >> +
> >> +description: |
> >> +  Datasheet: https://docs.broadcom.com/docs/APDS-9160-003-DS
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - avago,apds9160
> >> +      - broadmobi,apds9160
> > 
> > What is the difference between these two devices? There's no match data,
> > makes it seem like there should be a fallback going on here.
> Same device names suggest this is some legacy. We don't take new
> bindings for legacy stuff.
> 
> Best regards,
> Krzysztof

Hi,
Thank you for the feedback.

There's no difference between these two devices, it's the same chip using two different names.
There's two names because the chip was first released before the Avago & Broadcom acquisition.

The datasheet available has the avago name in it and it's referenced using both names.
I did not know which name to include so I wrote both.

It's old but still being produced today and active for new designs.

Is it too old for the driver to be mainlined?
If not, which name should I use?

Best regards,
Mikael

