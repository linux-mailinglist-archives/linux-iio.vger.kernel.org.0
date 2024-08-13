Return-Path: <linux-iio+bounces-8430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CFD94FB5F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 03:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A33B210B9
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 01:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F057494;
	Tue, 13 Aug 2024 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XDknPbq4"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2017.outbound.protection.outlook.com [40.92.19.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606385661;
	Tue, 13 Aug 2024 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513884; cv=fail; b=Tywu2OFL0Qw/q2wPVX4+4ydJdKuo9vvdA5+i8VXgSL8LnQcDxmyZwL+KVLPfEPrY1r93mJgmMtOLqhpwUu0mRfMGFlNKVNS4GEu2le4jmwehCGVCWFbmMB4Qh1U9I1SjVvATIHa8jHROO9R9lVScDhEqN2nkozG7C5f6Bo3UrgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513884; c=relaxed/simple;
	bh=syOJGy/VWt1TtfKzUvNHlH4UkrvbXSc/z79RJ0Q58k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dohTNNvlpNF3wLk5op/GFRMtzrSR50eZd6rmpPSHNfsdnQ1AWbv/sI6ZrIyHHJX6Vfp/W/IHpcQxlZxhoNKuTBrghNWX+RA1N47Ee5i1gaNCcBEbNAI02sPZBv2QtK+m/6d99OhUV9/wSolKgIwBMapFamvobeO0AjWNWhP6dss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XDknPbq4; arc=fail smtp.client-ip=40.92.19.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/n4hBT1iVhRtqJkvqDZbE7ScNtKoIoyfrTuP8ShGFzqJnvWgWut9YsP8QQyXwbLvzyMgo50EPjo3EN6svbjMbAl2nwICvHMNSHfwB5a3XfiTR1huU1qdiRCqfAcjAtdde5bOsPV4B0U37vS39Xoe8Ee2K1vWOjD6cOGTU9RKPL5eBwh8E9s6r4/edt06tFVljL+g82fkwcNbbgakWvrIinR1JdQz6F6XOW9AAJ+auWLGr7+4yhc3z9zoNJaS1b8Kd/MOHjnd2EXZw4BSV4TfuW9bUnYGNNlhdl+Z+KE3h53vtQRP1Ib2tn/AP+cBw+e4+QNOsM2M+lzOGH9Mv6uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mf1pB5F7pVkHM34HlSgzuYk3Jayj295XL3jN16E3KFM=;
 b=GdfEz9IJCrpBHkBSI6lhC6en1nEEmqlEA0bp2El2NnzUYDZ5IgKtmtVy+v5blKChV9zgFC916pIE3KyUyMdu7+cOEyNtmIcXLOuJ9DYZJ2wp7FgoPHARZV5/brIUsX8Xqqyv1eVkHALwxKAQ9YNwfdHH1+YzUBUR6MfhsiIBxsKMao1lIwRVrvGoDSMe8u6EovA6mkA1jFB3Zun8NuNJqS53npoUuWbBdZCdvu2iFfojspygtJnFLaOgb0CqXVBtPBM8P2IOtakLJ2v+YlO6FnXm8sGLrvBd66Rf1H/Ohqil79dTn09SeiRik38BxSh9WqX9iD0XvTdefAuvFj6rCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf1pB5F7pVkHM34HlSgzuYk3Jayj295XL3jN16E3KFM=;
 b=XDknPbq45C1g1agWA5AzTEkDUdm8tRF9LpW0VH0VSOdQpegCUDlBMaCbHhiOu2GeCOko3i9s4+KhbRfUoe1/g0futVSUVxaL0zcirlkUxELcagWCBF2r2zME5KMA18vpS/g0yiZBTHmDdRzZVHGVUFm7MV2kOqWLL/CEyhOfZ+t1bc+3L65tCVC5CKDVC8mYN5P4lgG5fBPULVtvsqvS8T8MFadzslt0S/6xuVTN+j+puSEMkdpCA7Vvzxg34PPDUJ407XMJlBQD2EMUrAUCvB7Vm3Lmtn9KY8++uS23KzQAGW9SxI5tUiQNmrGLnPCK6v0hZ2V0jmwfu5J08UzIOQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5217.namprd20.prod.outlook.com (2603:10b6:510:1c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 01:51:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 01:51:19 +0000
Date: Tue, 13 Aug 2024 09:50:35 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 3/3] riscv: dts: sophgo: Add SARADC description for
 Sophgo CV18XX
Message-ID:
 <IA1PR20MB4953ACCECC151ABCC7E0E49ABB862@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
 <20240812-sg2002-adc-v4-3-599bdb67592f@bootlin.com>
 <MA0P287MB282209542C6D70839466B733FE862@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB282209542C6D70839466B733FE862@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
X-TMN: [AFE5Szog8iWcdsuN6y/XaqdHXGJcT8OGE02YCJRK2ag=]
X-ClientProxiedBy: TYAPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:404:29::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ly2yi2g5nrisquhuhbbebeowfkv6yko6afglcutoghbtv46xqo@kgcdbfxf6gsl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: e55b38d0-93b9-4123-822d-08dcbb3a6cd2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799003|19110799003|461199028|8060799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	h/brfwJD1/qahipJB6td7RhaG9Er/JuE4q3aS9nwcHCNbnirgDuTv5XhAfqLBYOjXQ9VNoIXDtT//mO/F6e/PgVaX3AXQhsByQfK3do/DCQSlFV1zLMG1+xhK92xZsPqDDnscSLNfINM0f6SdryaH5ICWtg1CjeC3dy/pHMi8OnRtEN9YXxSNWyfwx6Cwq29giidErONU+Yvxwy2UTfcrzCqous2TonvD8FzPXffKvTFLsVzNrog6vvHKrdXmUyz2oLM/gATnbLRGGH2WnyUbwbNJO38iQynNhym6ZrsoBBKkPrPShz/vWquEsNuKWGViIFoGJhE0yU6Rmc0dHdyuZaVq/D+8n6ImZJXHMzcyvQ/q5zHNdEwjZSXC4fR1RM+asaB0s7tcG65t6aPQI/OupFWKVg9i86Jsd7Vhu6D5k8zclqswHAgs2jzr5OGc6sTLN9cKaz7zVpu+bgykgqvwVO5Uaw+9jQuXV+fDXekJHaw6LSFnClgdVfXdHSWQrBf5NgGtdMCfffhSHx5bjsrxgLdURBOuh5pXrN7Nfd1TZ+UlD964vLQqOHc/MWEsmI6xv55dWkmTgBVY1tr0a/VJIaI+C/+bFGqyp/MXpiTDbs5ukfqozt/UrJS1+SbXwc7vHEi3dK+lRWFhccav7coc9WAbtO3ghRDN5xKxSituYUfPKc9kbCgl3KZmvMhTkoYARTPIlF0NLvdgHSbFsIP6gYux9f54DXw4Go9faW0V4Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHIVwZUBxBu1RUfU8TkuxvuO3aODTHu7Noo4OWoiGJ7Iu8VGYjrLIwQFnyJs?=
 =?us-ascii?Q?OP4LwtUxCySuD+lxa2P1gd9Wabhrk+CTGrVOq9862qcx4lM/g0PF7uYQj3MJ?=
 =?us-ascii?Q?2OeBq3reSAIaRL7ulLlRmrQCm1uRVOyEP1hDvV9WUEBwC61kOch8+yAItUhl?=
 =?us-ascii?Q?AbNxxXr4LDGNjWnJprg0eon1WmXDnSsmq1Gvm4i0LF7H7vEKtBU3Gkfk4/Ye?=
 =?us-ascii?Q?BsV8oTbjVKvgh8nM/572rk+sDZh6D1iJtbJ49SzcTVaa2rXOCVcjToqmm1kH?=
 =?us-ascii?Q?eJVslFqXw9Ru0KNM7H2EvcF5U6kvk3MpiLCsvheioJNoRE4NcK8MbLDUxnKs?=
 =?us-ascii?Q?wLJS4/mpitg7w03QeLMyrM7HosBHlPJISJEKrpR9JR2lu0t4ZU/DV+aYUmrr?=
 =?us-ascii?Q?uzR+ZaPI3gzq701uPXNe77HprXdV1IJ5ARTm0bN9lIVnZszqw9HgDHv7MrcN?=
 =?us-ascii?Q?zY6pAP19HwJQxLQNYVbuWnKL7IBnZdUvxQR21uNjWp2La+7UJSGa+3yic7uP?=
 =?us-ascii?Q?HcjSMT3ROh7qtsuc4D9dIb4W9bp0x+dv9G3KDdcf7+h7iUtfsdK7QZU24RND?=
 =?us-ascii?Q?/AzHxghfc7if5Qqm3LrdRiN8a1Xml2ty5F+KCKBh06Z32/xAu5Iq5R+pcXbR?=
 =?us-ascii?Q?BNsLiUDhDNB7tITHcYVXzjLQ7nHe2De9QpNA1RjDvsEz+rLxs+fFzlQTBp2j?=
 =?us-ascii?Q?ZTDBUS63VX+vGsu+bh0I5hG+WYwAqKVHc/rQJtzMjcLQnZ5F6DFK6NAt7V8f?=
 =?us-ascii?Q?Q6h+ttgmP9lCR3Fsx3BTl4qXumuxNoDKhQ7MFzQ5X8ZEID2hgpzDPgdZaAFH?=
 =?us-ascii?Q?+5vC3nJdEcRJTLQePUgWSNrrjXb4CS3Q3TCnO7e6rve6tnhLYlchCpNBAe9l?=
 =?us-ascii?Q?KXl54d9+XWTbIoCI19EPtlp3PRLLNeeQWHB/UpjZaaOEU9JVyPDGS3IaWjgP?=
 =?us-ascii?Q?XVNnqmsYz8GjkmMGYV3fwLwwJOOpK5yG1T9QKVvPE9YzdNl4jwtC1tTnFu+d?=
 =?us-ascii?Q?cKcZxZv7VDSt/FN80eq2GoZ+mXPji0zJEPn8Lao9cMixNiDEC77U+pZ0CTMF?=
 =?us-ascii?Q?JSq8StPJfIE8VlTOW2ht75LoVAjtA5Gpcx9vIXCFbNci3TClSyzPEycufUik?=
 =?us-ascii?Q?3qFpeQaea+B+nnDfcdDi3IgAvTjR6HN3+SSA3X/IEgBv2tz/CCzHvMbrAfFN?=
 =?us-ascii?Q?Jh6FUzcaW/nxeooerHK6hsk6+pF/NlFyK4rm8WCjEJYZX7o7FXHZXJc4Oo/o?=
 =?us-ascii?Q?1sI4WvZNrDipK++k1jUZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55b38d0-93b9-4123-822d-08dcbb3a6cd2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 01:51:19.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5217

On Tue, Aug 13, 2024 at 09:45:53AM GMT, Chen Wang wrote:
> 
> On 2024/8/12 23:00, Thomas Bonnefille wrote:
> > Adds SARADC nodes for the common Successive Approximation Analog to
> > Digital Converter used in Sophgo CV18xx series SoC.
> > This patch adds two nodes for the two controllers the board, one in
> > the Active domain and the other in the No-Die domain.
> Where is the node for the No-die domain?

I have suggested Thomas not add the node for the RTC domain.
It is not clear that which clock is used for the RTC domain,
it will good to add this node after the RTC is implemented.

> > 
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > ---
> >   arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > index 891932ae470f..71a2618852fa 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > @@ -133,6 +133,26 @@ portd: gpio-controller@0 {
> >   			};
> >   		};
> > +		saradc: adc@30f0000 {
> > +			compatible = "sophgo,cv1800b-saradc";
> > +			reg = <0x030f0000 0x1000>;
> > +			clocks = <&clk CLK_SARADC>;
> > +			interrupts = <100 IRQ_TYPE_LEVEL_HIGH>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			status = "disabled";
> > +
> > +			channel@0 {
> > +				reg = <0>;
> > +			};
> > +			channel@1 {
> > +				reg = <1>;
> > +			};
> > +			channel@2 {
> > +				reg = <2>;
> > +			};
> > +		};
> > +
> >   		i2c0: i2c@4000000 {
> >   			compatible = "snps,designware-i2c";
> >   			reg = <0x04000000 0x10000>;
> > 

