Return-Path: <linux-iio+bounces-14541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA55A19B43
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jan 2025 00:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FA63AD150
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 23:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0451CAA6C;
	Wed, 22 Jan 2025 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b="gx9MbHAF"
X-Original-To: linux-iio@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020093.outbound.protection.outlook.com [52.101.191.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DE1C4A02;
	Wed, 22 Jan 2025 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586922; cv=fail; b=uVCeas0PjM2X3zEN//56imbB1rVK6eany2YyAty0RqA7Vlfyc3UAATmrzl7fV3BbHE63zG7ckbe9kzEsCU16es7PYpF3eG0jAQujs1iwm+3qqSn6JXDPH3tJF6MJ8Ir5wQIBWi5HNpOxBv1LtxT6pz/DzYpiWUdOZYIN/ni+T5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586922; c=relaxed/simple;
	bh=U7m1TGTe9CMk6X597HH45gLMbC7CK4OnSVRzD7VIoak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y8DnD2AhOkaelyqCtyLacEYvOHCTdBMbG4jHu/TIblHq/sLSAj9lOyO6rz/3hZC8WA6MkUiUXuuOAhFatkfP1FikKBXWn5axmcIdEnxzQWc2CN2G/FIIFn/TXCCVDUaAy2+CPsmHRJibnzsDlAyqpuvm5ampIthn/V70d2uI+y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com; spf=pass smtp.mailfrom=dimonoff.com; dkim=pass (1024-bit key) header.d=dimonoff.com header.i=@dimonoff.com header.b=gx9MbHAF; arc=fail smtp.client-ip=52.101.191.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dimonoff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dimonoff.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMcAuyaX7XQu3Ef1fcj2hVI5pzlFpAEtA2dTg2snaw+LtsLxqpNZVpBRehNHS98qDpdVN4JjcTgCjV8EAq5qaNQllbKFwPh6AEJSpou5Fs6HaBboL8TPh5UiJ//erOj+zbIJh7GBD67dvVHyzcHA9h7KsZfer3EVDAN05PxbbH92R1fYUSli/Al5xEqTbyhUmlgjRHe8TXTqUcwYInWbef69nTjB+SIzsj291ba8AKd8uQP1Tc0NLegMJluyBLUQrt0RYAUVhhIyBfiEX3rv3pk/J+bf/5GxEiRfnCgGfDOxIxvbPAOePIFzEddahTHBCuNUWwnYxy5Xd2b63x7Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOVi23XEpFh3i3ZewcXnfF2+NYH+PPxpyn7u/CKtM+A=;
 b=AjfdmapHVLu/0+7N/Rabjehg3Vvl3zlJr+F61/2+BtphS6r3C+cZpMOW0rvC+TcPrif+PK1cldNsU6ErIhhSExxG0NSFUrAqdwO8ZW12tkND+M8DeIlqjptorab/VxVmonYROlwvTxXQouOCeJ50h+ag2wdQuZQqsWvK/3xm56GZZ4b3f8f4eBfn4Pd58mZcR2ks3KuGUc+wAtJtNB8jGeGNizlNA01A1dGEoZmCuOTZqLlKKR38mG1CGcjMfCt3XDGlHn5I1uGN7NvrwgGyCmb5Hanp/okdAYf89L8rkOBbCX/SQ8vCLIloLVthi5E5vKi4qVl9OvTLkMBJUUWlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dimonoff.com; dmarc=pass action=none header.from=dimonoff.com;
 dkim=pass header.d=dimonoff.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dimonoff.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOVi23XEpFh3i3ZewcXnfF2+NYH+PPxpyn7u/CKtM+A=;
 b=gx9MbHAFjcxXS1ObIqun0xiS7k+y1MV0EgIFxsjMBPHu/C+PYBtVhB+yuPZpjDCuRS1x+H/Nf4v+x53QUC/+20sGFO/Si33eAv3XtnHeiqA6HF06PJxG6MAre4xJOhaniIS+Sh/gnRFbRsOmPTothU2yZHnxi5haThlGihe57mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dimonoff.com;
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20) by YT3PR01MB6646.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:72::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 23:01:58 +0000
Received: from YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39]) by YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9a4b:5f92:57f8:2a39%4]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 23:01:58 +0000
Date: Wed, 22 Jan 2025 18:01:54 -0500
From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>,
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
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <Z5F44pcquHp3qvCK@uva.nl>
References: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
 <20250106-apds9160-driver-v4-1-f88d9fc45d84@dimonoff.com>
 <20250112111059.677f8708@jic23-huawei>
 <Z4UeCyxgbzCUQtRz@uva.nl>
 <20250118114846.78ce0b67@jic23-huawei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118114846.78ce0b67@jic23-huawei>
X-ClientProxiedBy: YQZPR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::22) To YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5c::20)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB9181:EE_|YT3PR01MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7ea08e-b61f-42ed-695a-08dd3b38c5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rS11+p68qYjZQD5AZSIi0KJpX+HJZ0UqCWkUXr3RFNAVoqE3h3jvOvI3ogR?=
 =?us-ascii?Q?HuHkg/qCRqSRJDegwCas8jRC52NCsTgEUuhysyijjKzSUP/N1C9WdwyH7wj0?=
 =?us-ascii?Q?JHdQuo09044/fTrQ1P9aY4YX2fTvBXZ/F3B79aNK1wUaBJxXEFFkbBVe0bSR?=
 =?us-ascii?Q?L/NuTlnJZ/kLdijQYBD2DepWM2awCVFJiZ1nNmCSxU5AuNmRcuiLRKmTRsoS?=
 =?us-ascii?Q?n6ZrfA7tUQBhjI7WMZO00rb8LVpGavbT8WLM25tUdyLxwtvMe/E30wxcHJuj?=
 =?us-ascii?Q?oitMpJ8Mf0dWRZ3vNLEzeBMdMm9Gj4PZekfqSvJMpo1ee7v/Jn5+l4sWHD+X?=
 =?us-ascii?Q?WGScsv1J28pqN60BVsRVPH9igclmQ57bI9H5Cng6NHdIcSbr9mfdJxAlV7ID?=
 =?us-ascii?Q?RQXUqyJEzsRlcPDe1oM53vBFXf0SZW0RcqHQLaW6iQMDN1M4mbaLmzHursW/?=
 =?us-ascii?Q?U54ehGP+JRzkndQIlJaxSFfuFThu0eZnZiLRn55DDy40nFQabQhq/cP+0qXE?=
 =?us-ascii?Q?DopHRf1KJ0udsrHvCm6BR916bBg+1WKQyUPe4LFuAnR9pOq+Y7tS83u4PJOz?=
 =?us-ascii?Q?I0s0CA5Zpvy+zIeq1tQleENfxOUF6LG3NwHWeSYqb1MZKbQPf+Zf+wD68/hL?=
 =?us-ascii?Q?5Xvig4QopDwxToHfqWnqkdHwQ0FOHf9bh+54wy6CV163MfVg5HzVnZZwnQuk?=
 =?us-ascii?Q?tQedSV/NHFRTo7q/fapGT7JEJpsu9SLGQBkvE6fuqBOURnUnEcD7a1fdXGYH?=
 =?us-ascii?Q?m607OpIPS7n8OjDYWFm8iX87IY/9uoj2k/Ke/mZM1HBlTOH8dBqDuvL4acwy?=
 =?us-ascii?Q?uDin0acNB91NqWtzkORe6pGk3do1G7LYxansf0UG9I4P1NsPsJCUy25OFt0C?=
 =?us-ascii?Q?FE3AvwBeZoMCA66utzPfzy+UwMrQN900cyi9f9O/NtDvQ/WZF3hdjQuZQ7Th?=
 =?us-ascii?Q?BtdUJNJ+vBsajj2TzlTsaOaFECY4f42LEezYDl03H7ejak0/KCmlYeoqVcur?=
 =?us-ascii?Q?hRAVqEygl+egybdhi48n/YDtNUohaR1fEY/zfoURs1Y15e/uzRqef9hX1tq1?=
 =?us-ascii?Q?h/M5HSwS9wv+sDwr8FG65Be1hMASeUCA9LmhADIuH0qJXUqY/0M/6UerdNSM?=
 =?us-ascii?Q?1Ze/rqMSeDplGzpYaxHAc9nzGW/g0R979CgAZ+A21iBfMyNpK4+jLliiWesP?=
 =?us-ascii?Q?PSEUd81CC5e1JGRPjP0hcXOxC0X2Ow8SUJwE1spZmznuRlRwhXGPbZ1yaOIW?=
 =?us-ascii?Q?cjUH9bWkhv87EbmsoRov1PKIruXEZ2/yrK8+dT9GRhMqfaPboq7qT2Zxugac?=
 =?us-ascii?Q?kmdHRwCMxKYoPIU4L+93ahGfN1KxFBU0nz2/2H8xWhkuUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RT9u+ajjMb0qKnwNZt6L3Qj9PJmv37FQPfQCE8XyH7dnBC2V8YPwy8UWqhui?=
 =?us-ascii?Q?TxYLyXCknxhbmj06O3NcWQ09IwB8NqxV9q7RB6Ss5nE2wCeJcv6IMmWGZsRC?=
 =?us-ascii?Q?FuGOODLffwVZWkxzWWIJGdGZonI5wfw4bPxsz5SBrXHjxaJq5o2rovYUA0wx?=
 =?us-ascii?Q?rJhq7ZILwrObkoL7KVt8sHsKetZcrG4Tisq7rqmXVQtAO3/tE1hKLSCHJmjo?=
 =?us-ascii?Q?cBKaREHQtbwJwi0BX7PMmJF9eUJ0k+yh+IXusYLKj6dSkislxEmAuRm6HTmy?=
 =?us-ascii?Q?UoeqLJY6B8JtCjsZvfx6mlJ2d1OijYV/FFnmuF7HcaUtgc7HKPgo2HN0I2wn?=
 =?us-ascii?Q?VFfIp8Kl0E8SFQF5IxmLUbMpHAk4iRYsovgO1Skae64ae52RtjhpCdcu8/OP?=
 =?us-ascii?Q?VMlhjmrprjkewZdlFAj0yGagRpg+YS/3d8yt0vmn9eNfvxcurcn7zxEsfj3x?=
 =?us-ascii?Q?6r3m9VmnjpMRHT7Ke/0S1Hy68wZfRqQqz/7hdup+Ro9yUH8NqTJcP49c8bio?=
 =?us-ascii?Q?NC0Z93RJJwUE7id9avQ9HLt8PS2gudL1T/97ZZuzglfF46FrtBr8z0xhbLVX?=
 =?us-ascii?Q?/3BlpA9lU6xmePZDMKZxBD9U4EzoHycNQ3b34k3AViBeszwgKB4dylPQ72V+?=
 =?us-ascii?Q?kA54nY1go9olXog9j0x1rQFSi5ANcHdTrFllbrIpSXAbgtd3+s3JfaacWKT1?=
 =?us-ascii?Q?WKvfFGcU7EcZwKaStUTIB2tIuR8zvyuhw83dTH77aVBQHBpB0qh1FziY8G+x?=
 =?us-ascii?Q?XDSsCbEqAyO3JlHKisY5TDtsSmlJmpbeUhk5/qxh3yZeJUGJx1wd8RQEkCSd?=
 =?us-ascii?Q?+D+BB6xEmOvkGAgMBFjgBQrGTBkD9/HyIQG4HsoSGDgaXhQg2bzcFdZO/h1i?=
 =?us-ascii?Q?ha4GyPiL9G4OsXZTXNeC9B676XyNR4p7tKvLQhXkajbtiEsJl/l6C5SeKZNn?=
 =?us-ascii?Q?Xv3BDytPMIq3Kg0oZwoY3t4CfpQ4hPMJMcpMPUyN/AcAUbjdli8ZXSrpQT4B?=
 =?us-ascii?Q?VnSCpopoM0gx/fqH3MdKNiqZXHaGkTwy8kiIEkvGveW+2KE2fuyMf9neZT2Y?=
 =?us-ascii?Q?jS599Ie9Sm1q5h2ET4e3brbpGnjmzBPn5SBYHFVk0BWrWHpL0rU01R+m7vgK?=
 =?us-ascii?Q?6HJSZjDsuXhBXyg7BfqK6iVi6Aef4yBJ9KxKNziZP4sqfx/ZMym75E/TsRpL?=
 =?us-ascii?Q?5cRU6zlqQySyMC57ADz/XK2zDcuevMLGKA5ldL7naq33zywDUppKvWh1Uot8?=
 =?us-ascii?Q?jtlgV4LFHcLMo0gnOaLfmzUHe1hRARjO5VFEij808gL1oRi8XUdwLtGUIIiW?=
 =?us-ascii?Q?8Mvt2IxcIxGnGBPrPwXANtalAHV/zo+pfmEO3iJa7CCd8noENC6MuCTfTwRY?=
 =?us-ascii?Q?ROG0bIN7rGBwTHSTSlq9M1mLOUt2bpQqBzQArVKdd7l2aXT4abxppEK8fTt8?=
 =?us-ascii?Q?bB8BCFnZ2StwSoGgTA7/7UCBgUS3SyMSppuEAyBsi4Dl9FEG1AtLsHHnL3zh?=
 =?us-ascii?Q?qN1FTKmjErm3bpnPFlNQ9ol+PJRKEXhVznZGhkDmCJ5tFBTWAw6yjzxX1HdZ?=
 =?us-ascii?Q?TDv/ZyUUUHZIm2y6JHUGYMIevwPrJlAqAB1pXgQsuKkTZqRdTHdkv3AzrMeL?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: dimonoff.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7ea08e-b61f-42ed-695a-08dd3b38c5c8
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB9181.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:01:58.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c4063547-e5e6-4866-a386-58c3965da102
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lI0pTdnrqtALPaHvLlRzaC8iIQFpUdDV3lraoPR98q662stqBmjWb4Ov4C/Bnh0JUek9P7H+lITy7b4/VWbX97pYeDLVMnN2z1HJ4Bqsh10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6646

On Sat, Jan 18, 2025 at 11:48:46AM +0000, Jonathan Cameron wrote:
> On Mon, 13 Jan 2025 09:07:07 -0500
> Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com> wrote:
> 
> > On Sun, Jan 12, 2025 at 11:10:59AM +0000, Jonathan Cameron wrote:
> > > On Mon, 06 Jan 2025 17:23:01 -0500
> > > Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:
> > >   
> > > > From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > > 
> > > > Add device tree bindings for APDS9160
> > > > Note: Using alternate email for maintainer
> > > > 
> > > > Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> > > > ---
> > > >  .../bindings/iio/light/brcm,apds9160.yaml          | 86 ++++++++++++++++++++++
> > > >  1 file changed, 86 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..756d46c2edb171da840ee49a7339cb781fe84ad2
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> > > > @@ -0,0 +1,86 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Broadcom Combined Proximity & Ambient light sensor
> > > > +
> > > > +maintainers:
> > > > +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> > > > +
> > > > +description: |
> > > > +  Datasheet: https://docs.broadcom.com/docs/APDS-9160-003-DS
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - brcm,apds9160
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  interrupts:
> > > > +    maxItems: 1
> > > > +
> > > > +  vdd-supply: true
> > > > +
> > > > +  ps-cancellation-duration:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: |
> > > > +      Proximity sensor cancellation pulse duration in half clock cycles.
> > > > +      This parameter determines a cancellation pulse duration.
> > > > +      The cancellation is applied in the integration phase to cancel out
> > > > +      unwanted reflected light from very near objects such as tempered glass
> > > > +      in front of the sensor.
> > > > +    minimum: 0
> > > > +    maximum: 63
> > > > +    default: 0
> > > > +
> > > > +  ps-cancellation-current-coarse:  
> > > 
> > > I've lost track on what we've discussed previously but I'm curious as to whether
> > > we can end up with a cleaner binding for this.  We may well see other identical
> > > controls in future, so nice to have something more 'generic'.  I'm not suggesting
> > > we don't keep it vendor specific though as not sure it will generalize beyond
> > > different broadcomm parts.
> > > 
> > > It is a multiple of nA, so can we just express the combination of
> > > this and ps-cancellation-current-fine as a single parameter, probably in pA
> > > 
> > > The tricky bit being there seem to be holes, so the allowed list would be complex.
> > > 
> > > Even if we can't do that can we express it as two nA values rather than indexes?  
> > 
> > Hi Jonathan,
> > 
> > These holes just have me puzzled on what to do. There's many of them, and the range in value is very large.
> > I thought about just having a single more generic parameter in pA but like you said but I found it was confusing to 
> > describe the allowed values and confusing as well to just round up or down since the holes are so large.
> > 
> > Having two values as a multiplier is more straightfoward for this chip since it's just based on what's described in the datasheet.
> 
> I would like them in common standard units even if we go this way.
> 
> > 
> > If you prefer to keep a more generic parameter, I'm open to the idea of going back to just a single one in pA and
> > log a warning in the driver if the value provided ends up in a hole and round to the nearest allowed value.
> 
> That makes sense to me as the cleanest option.
> Just rely on descriptive text to tell writer of DT binding what values are allowed.
> 
> > 
> > Are you confortable with this plan?
> > 
> > If so, there's another problem with the above. I don't see any picoamp suffix in the dt bindings property-units.yaml.
> > How should I handle this?
> 
> Add it.  They tend to get added on first requirement.  Here
> nothing above picoamp works for us.
> 
> Jonathan.
> 
> > 
> > Best regards,
> > Mikael
> > 
> > 
> > 
> 

Hi Jonathan,

Changes implemented in v5, please take a look.
I also opened a PR for the dt-schema property units change.

Best regards,
Mikael

