Return-Path: <linux-iio+bounces-13180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4449E79BB
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 21:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FC8287A9E
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAD120457D;
	Fri,  6 Dec 2024 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="sy4amenv"
X-Original-To: linux-iio@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021094.outbound.protection.outlook.com [40.107.192.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03178204564;
	Fri,  6 Dec 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515410; cv=fail; b=aOz/zbhktF1M2+F0jCSYg3/OBnaFzlbe3RKdQrBQV8ZK0Uk9/p4vSqM8yNFDS/Ne8FasBGUT4d0sJLPMBtuwhtRbddmm8Ly+uG/0GYy+jyJXoP0v7RpxcIYR90BaRlBUjC87pjo8h7Fel1ZE6W33Numc6Z9TuEGBVDF0asF84Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515410; c=relaxed/simple;
	bh=8023PRmSf1ZLooioVDZJUVZFVyfl63oqa2myR5Qo2L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UefN+uFb15QaLMZ1WbVR6g+lGid9prYn7g7B+vdAvVfs2pw0jQdE7KymVV5XuQOC16pKf4SOFHN8rEPa14Uirfbf172U4uZIS7juT74duiSW/EYwkAdYnpEvmOG408zLJZRjRjpZ3PX2Qw93S18h3QZqq7z6QOLjvRgM/QTri0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=sy4amenv; arc=fail smtp.client-ip=40.107.192.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC95TrpzSm3gA3zJ54vTJkNH9lrjTN/7E6W2KvVlu51csSoPYQH4nJc6hGMVsqb5YiPLwj92iNjjTFLCqRqi7XiTDS3Z+joi1Rs45OLMGuIw4ahsBLYGxrq7xH9p5In0qKa6Il8SsUVLPxX6RrHzJYyuA76liFrM3QLm3lIriybDVdlyn9B04C89XUfG+a71M5mGd+Ggth+EtprOSkzAxvBGMMnHtLYBNXeloXqjkO+Gv5wh/IijZQyTLxbtlixf+qbnFBwk9RI6ud2G6JLjBlFk8ALRrNZWf7cxf1SQ3oJ/44HPBm/Uw25JAfEEJ/UY+z5R7FfAOIkTdZIaXPITHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gFYjvEVlEpEramPUJ041Y1RLrxODUQv1TZx/sB6yMk=;
 b=nfu6Gd/yrbdXKfFYlTysBixh+4alpU7d3e1lxpIBxxoxhJdNvpil82r4ObxXvi6yyyJET0Q2wu8OB5NSWccydeTO1ilxj24EbVQOUzTykZ1iyRGSUTGQRCXmbHH+qXrlDe0x8hsvGhNlvxhzoLhANQRsK5iB8d5mj6lbiRET+MZZABSVgZ3+G24X/RRc2oP9F61Sl7SgpMT0Pi5ozt+9J22pXAzLKSgRheaFluuYsUpa0670PHztm3Hh2VUcA+KD7HhJamFWT4TGQ/OhMFNMVUFLMZn+Y53vJTKvMFaOsy2mAkfpeh/SV53cRof5uPEtJjZ+Th8O1uVG+qff/83O1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gFYjvEVlEpEramPUJ041Y1RLrxODUQv1TZx/sB6yMk=;
 b=sy4amenvwoRW+sROSi+IkGnMpyI5HBcSwtg5x3nRQ0GFLAWBtkiJNviEYiQIidNXv4FxPtr4rL1lS6y1x1wZKg92AqTySo0HRfvH2HZpjybBpHg5nztUaL8i0Aqj0jZ1QraK8r/RqGGQqNPQ4aW/HlgLrArNmmyUWLk+7rfSLTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YT1PR01MB8555.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:c6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 20:03:26 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 20:03:26 +0000
Date: Fri, 6 Dec 2024 15:03:17 -0500
From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
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
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <Z1NYhR9Y9T0OUCHV@uva.nl>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
 <20241206-apds9160-driver-v2-1-be2cb72ef8f4@dimonoff.com>
 <20241206-comment-tissue-7964de6bdcd3@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-comment-tissue-7964de6bdcd3@spud>
X-ClientProxiedBy: BN9PR03CA0905.namprd03.prod.outlook.com
 (2603:10b6:408:107::10) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YT1PR01MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 047d8a2f-fd39-476f-0de4-08dd16310b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESxEeJbLgw5mwzK5S6irH7KUV/W342Xh+2dK8K49cSFZZwZDI8JAnp0jYln6?=
 =?us-ascii?Q?ka4Ih+QR9wWuFufWBuKpYhYJARJbHS7j/RmYx8epFO6dkx/fkdss/7GVoZEk?=
 =?us-ascii?Q?heaSzk8XosEkyEDv1t8IqxkFruEv/4nksw/ml1W64MBeBZlUoHfTKxZwZ/sd?=
 =?us-ascii?Q?IC5HC4oY+Bvm8NXGmVRfuoJK8ikFHPYoqWxQ7msRX/aFHX3NHxnPZ3opybv4?=
 =?us-ascii?Q?UTkpwmtaNQNI4W24rMHtI7VbsxIS/QCBMLG1zLzCin33hVRY2FYunhcUPZoX?=
 =?us-ascii?Q?EjLDQJx3zh9eZi5HU4JC6cPE4+4sWXu7HUEx3bXrOJZUyKTLKz+kqVdlG6DU?=
 =?us-ascii?Q?Bc8w6hvZXW6uTcL6jMJ9aO4GEE4tn52hkNdovLDptKYpaI7m4DlvoSTQFa4h?=
 =?us-ascii?Q?Je6CG1iCFfpCGp0MGnpUIndPBPHKFU9XRDkf7gaIICO5Mm2RdpNzTIurAe1L?=
 =?us-ascii?Q?toTPSfN3QNTdNyhHpyTKImzZInfdVCn/hHOf45qiXr+oNE3j1iPSxuzweiGy?=
 =?us-ascii?Q?fLhsdb5OauCTybaaGBmeXoPpvKe6D5sdl85MEp0y1qA3yXivF+yaAky0JCpH?=
 =?us-ascii?Q?9+Ajeccq96bWq+uVC1NUYeAp/vKFlW4ChvymVn40nZFjMqr2yS1FxnPibDU1?=
 =?us-ascii?Q?0xbN11Ll1yk6bTbWQO1Orx+VlMnPpaZwUuOLqsp98peS0dJ5/wBLm8HHTD1k?=
 =?us-ascii?Q?z8S1Z4x8b3Ni9Z8I6mH2ntqutgbHYq3R/oFMpho0M2fAX8XloM+k1BEKpvQ+?=
 =?us-ascii?Q?WhFbiGlOG9EDphHrkGyzy9NaiMF8dIpyafDuQgV1xKAxryhipBtY3R0EQYji?=
 =?us-ascii?Q?rZwtYMP8tXbo1zE/tyNmsYwgvNtr6LPFgSCwiAQ9bu27To0q5r+vAfuX1/EN?=
 =?us-ascii?Q?dO1mDn+hdiN4ZgzqmuZJonibAuv2uTnQtSNAanjle2iQAkQ1hErz5EhJeUeO?=
 =?us-ascii?Q?FXcqOhKSR5HYxY/Wvil6rS75WXCPG/do1/izna5om/Cxlkw8+zqshGotGApn?=
 =?us-ascii?Q?YqojhkUDRza8/njFybGF18bCi4UPcVOxWo4yZUoW+Zds1wLQtJgCVM9RsctM?=
 =?us-ascii?Q?HvHa5lVsf7v1UwqDIIUMDpbEEyOgv8mz2dwkExJez0ebYG6c3jijmndO9ACC?=
 =?us-ascii?Q?IlgGVA1Ov5L8q81llvrHyCkEoWc5D0bUyx0AcPscvCbmS+O05stPcqESotOZ?=
 =?us-ascii?Q?7P4oROFjcL4Or0xR9z74LpRSbwETIBKN0gWbU678BO3HSStZUJUXU8nXih0J?=
 =?us-ascii?Q?YGSp0ykvR4zxoQobw2+3NqwIPAOG1xRcppicpLLKHEwuQdDyCCP5hxQQ8NwS?=
 =?us-ascii?Q?eOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WZMy//nT8aW6JbWQBQaqFJBhhTiLnheXPkzTpI06QuOwGAkdJTTlf4RKQ+Xs?=
 =?us-ascii?Q?AgCfXItsN/VTIXxjb5ZSy7tBMX3t8H2Q3jJFiMfyMlTAntuuPCNzGfYfUNO6?=
 =?us-ascii?Q?T1TCKx6yxt15eXkAnqbSD798HrzzE1j3O6F3S79/QXfNG2mTelhyvjiXWFJK?=
 =?us-ascii?Q?Khd5l2tsJJulzQ4ezi/yY16Mm8E3kYlRvE8bQ4BdFNNkj5doTzOqDJCKggf1?=
 =?us-ascii?Q?Uen56Am1zmUttfc/G3FlxGatLM5W9bFfEPeHD1TGY4Tjyjn3kqQrOEtl4t67?=
 =?us-ascii?Q?hXfFcTMzkX3dPT+VSQ1qtUZ9jFpGln9ezqqPvERV1iPLvy2TTBJSHGalZgds?=
 =?us-ascii?Q?fE0w5VsWYkLeOEtHd/3AZzSEKwNbaH3WMkGR70pmv3l/8k6HhlHNj4SdNLmo?=
 =?us-ascii?Q?mhxAFKSPClOrmepirWrCFJL1RHGJwMBvQNgicU23Ih6uLbOTU3yBh4gexl9E?=
 =?us-ascii?Q?SPYO3VH6gGuh9DKOiqWMiL5dbRuGKL+E6d8vRcJqGBkQXFfj2lZq5n1cAL3m?=
 =?us-ascii?Q?WOd/XraPiozNz3kYjLbBGKFLHLXMG3T0LSn3Zgl77uFx9zPD9vQnw3OqAa5x?=
 =?us-ascii?Q?LHmhu+xHcz3fCZBaikRsY/i9D4LOBMgYVfPR1BsDQLX0+wfeCI/bgA4lgdO+?=
 =?us-ascii?Q?FZa3/fcRcaKKFGU5CSx0BcXz5L8Pdvm264qTO1V5iZyjLvsmDf7755Wv+E5Y?=
 =?us-ascii?Q?QGRaeX0ua3mr7nPWDx/VZy34uK1SlrBqLp/h7ywuAzR77D1OpTH+FyiRIZxW?=
 =?us-ascii?Q?zzrh//4+PYz/SnHIJ3zBVsQ0mk+NyXY9balARnm2dlL2HAlysWqq+i6Zc3R+?=
 =?us-ascii?Q?ThMWMzYl3nB+WAkl09O633MTEpYp+YcPiX8jSxZex6ER7NYuBlFa0vXmjvbC?=
 =?us-ascii?Q?hJluRbUoCL17QDYGQ+vX93rbc5vwexJnqauclvXzgqc+s3VNRIwj9WDf4lNY?=
 =?us-ascii?Q?PoVe68820K02Qwff/H66LyaLe+ws0vNEJtbTLC2rNlXytp4f18nYevzb/O+E?=
 =?us-ascii?Q?SWKpu8E4pX0/krH/kfv8JNGtZX7l3Tv1G2Tv63Vkd0aL84J6+qHazB5Vs8Ip?=
 =?us-ascii?Q?vyxHHnfCGIV5f78KgReQPagp4gsks5cUBBggud0B6wt+DWxfE1IR27/XycU8?=
 =?us-ascii?Q?7qN65JkswumTbEWdCfFntSpbs6lLVgiXm+x7BUwaf6hGjT6rjH5OLJBPzeBD?=
 =?us-ascii?Q?xrgZhgSsgKXg6VyV89+EhyYoFZIEs875Ug8IdnU+J1r7fx9cn56OVM315KEV?=
 =?us-ascii?Q?aqV4amYFR6uR1g2AkMtSLxk0h9K+qx6M/D+Hnyrlm9MmKwPuzA5ByYC/NaLE?=
 =?us-ascii?Q?bs6xfnf9fDNsOsacPfn6k4PLR6uv2xU+U7/fc/VjzydpNlf7NCjPk3nCwSFi?=
 =?us-ascii?Q?uPBAa/utQxcO9d/8KwYfD/pPHVc7P1jPflhSuQRkiorSurkODFXINELByrvr?=
 =?us-ascii?Q?AsnoRyRsbnEFxPpZQE9zF8l7sK/EUwl2B8dXo6sOBAOzB1O6oWAlQRzos7yL?=
 =?us-ascii?Q?eEX2Y2nmMk5UTfhRCGt4jNDjYl/VwnSVTFwJPkfup2Op72psx6+LiTDTOdtM?=
 =?us-ascii?Q?BNDf3gf7TAq+u0Cqv8jHI4g7JBw5EoL2QHuNfnGrN1CChoI+GSQAY7iA8QLq?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047d8a2f-fd39-476f-0de4-08dd16310b84
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 20:03:26.0529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9ED5YD8y9euEYrYR1ZaD78eHy5WRxZ8pDABkODT8tQts9ADG5MpMrON03+5KTgIrWUPN9Bx0Rx4z5AZZFM7/+wR161olkk2w1a1ZtyuWdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8555

Hi Conor,

See my comments inline.

Thank you,
Mikael

On Fri, Dec 06, 2024 at 04:33:36PM +0000, Conor Dooley wrote:
> On Fri, Dec 06, 2024 at 11:09:56AM -0500, Mikael Gonella-Bolduc via B4 Relay wrote:
> > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > 
> > Add device tree bindings for APDS9160 driver
> 
> Bindings are for hardware, not for drivers.
> 

Indeed, should I change the commit message to remove the "driver" part?

> > 
> > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > ---
> >  .../bindings/iio/light/brcm,apds9160.yaml          | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..525fba52f156df3b78e24d7d0d445fe9d882eaa7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom Combined Proximity & Ambient light sensor
> > +
> > +maintainers:
> > +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> 
> How come this differs from your author email?
> 

The author email is my work email, this one is my personal email.
The first one might change while the other one will not.
Is it required to have the same email here?

