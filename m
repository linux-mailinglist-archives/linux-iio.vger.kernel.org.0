Return-Path: <linux-iio+bounces-19012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F901AA7B42
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 23:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65527B8D5E
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF0F1DB125;
	Fri,  2 May 2025 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mt.com header.i=@mt.com header.b="YQ8Xr27I"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D201F585B;
	Fri,  2 May 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746220301; cv=fail; b=A4lz/1T23fB+oRah0zEyfSfaCC2I6fF7cQ92thhByY1F6O6dO6HBUVS1fGvEg5RoIVWZHzAVyy3RgcdVn8eZevVhahfU8owjd87dYd5K0bBwIaagu8t6kt6Z2nZC1EevE4494hO16d/A7O/IC2kS0rJPUhEzEsOGa8mEin7eR88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746220301; c=relaxed/simple;
	bh=ty6Ra7lWJFRo3ZOwUgfn6RFn4685DacXYG+rIkzV0rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DI7NGtnfYVMqyOLPECxZX8k5H8Oh5wIVuk2DwpX4+PBq2WmYntm1wMhqvpVMwIdJnABt5TXtgUwiGD+sSb/aqS2jNJ/t7GmQxfAgD49SBB8wK3iPiCM5mymAoOCjhKl+0fLV+ZgZZAYZd9jClPqlwZM3MCkKC04ckJw2EXCwPj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mt.com; spf=fail smtp.mailfrom=mt.com; dkim=fail (2048-bit key) header.d=mt.com header.i=@mt.com header.b=YQ8Xr27I reason="signature verification failed"; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mt.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mK+iYUji/+d5VatpyvO9HkdMxcqJ7J4mujU4NMdyXdcqO+1vgGag6mYqxXN1qRSJllGbWOvU39m4zaEWfZ/nLOIf4ETLsN4P9Ywg2QeSi0PU4jQ4vPgjRfzjaXdkNUEHBRswEja80AbmOTdycs0KjuKRr6t+MZTjqJZ8v/qHyJxePnC9zWg15IA5TZortPwj7b/aDBCX7C3h/hk5SNF2fm/cSqx/gp9C6lKBbtVUUlsmWk09bX2TckFrW8cYE00ty4IKoo04MBZhZ10FjpP1uCEiPQ3IaI320UFVfG7Ye56OIiPTPYqRrsQu3C7tWzj2PNsOJkYKaOfWmJ7uWyV41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+DFLFfV+LZGssWTED/slelBgMxPTOeuvrYcT1YxB1Q=;
 b=qPfD7ADRP8RIm8cfyWR5/+xnruZG6nrcUwoic4XH21i219jWJGDqrAnx9CJ/h6AeonmCR3dAG2vXrKuzyLeD1DCEkpzJO7NB3rXCSEHC20hBwk61H+YwfaPxZRZx+clDs+1xkgJ1D2SENMMkqPSe8L/z6NWfqlUk805Qk3H9UH0io9Y6bTTINqLzGC128gOkSVfm3ImaPtDmF/c5OkRVXVPoHMxi9HJpdVM4bXfZIvpWp7E1PabP+ytVIZs8B177qLZ/66n7qgJW0fgLkpGWLfIedEqGREIBe0RHD6lEJxPkpjeRiSgIW2n/s45rKia0pUEdSll7wZ65ET+XVCJ4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+DFLFfV+LZGssWTED/slelBgMxPTOeuvrYcT1YxB1Q=;
 b=YQ8Xr27IAyAYK/Zh3Myhsqyc71q30k0pMrTFsas+Ih2yS9D9xAp5o5qYQ7+IIaZqrw+JOcwjkmslJldjM69w+FFhDxRY47k2LGib3BZJD2O8EeSGcVEYvNs/b3r5/6he69mcSZ9fOrOba/CEXd91+5hpWu30v8eCpSnWiYSEvFwfm5bEXv/+ozoFKYtugjg5RXRX+LsQeuy0+Aa48xCiZyjh5VqVv57j7tyot/+niC68uFoDJ0o+wBBgZ14hFFJped1uT4iHJykIQepaJaSevDa8fUEnWwkfHKd+xtuuKLb6H9OX0dQ+gkk3dQ4zCAMIcK2gDH16ENO66xl1O2xUBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from VI1PR03MB6285.eurprd03.prod.outlook.com (2603:10a6:800:137::14)
 by AS8PR03MB9893.eurprd03.prod.outlook.com (2603:10a6:20b:637::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Fri, 2 May
 2025 21:11:36 +0000
Received: from VI1PR03MB6285.eurprd03.prod.outlook.com
 ([fe80::e290:ebac:cbe4:198a]) by VI1PR03MB6285.eurprd03.prod.outlook.com
 ([fe80::e290:ebac:cbe4:198a%6]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 21:11:36 +0000
Date: Fri, 2 May 2025 23:11:21 +0200
From: Markus Burri <markus.burri@mt.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: linux-kernel@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Markus Burri <markus.burri@bbv.ch>
Subject: Re: EXTERNAL - [PATCH v1] iio: backend: fix out-of-bound write
Message-ID: <aBU0-ZChCrMCWWLu@Debian-VM-Markus.debian>
References: <20250501063240.25295-1-markus.burri@mt.com>
 <c3a792558b7d35f7342a53c94810861cb0eb0b8e.camel@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3a792558b7d35f7342a53c94810861cb0eb0b8e.camel@gmail.com>
X-ClientProxiedBy: ZR0P278CA0200.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::11) To VI1PR03MB6285.eurprd03.prod.outlook.com
 (2603:10a6:800:137::14)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB6285:EE_|AS8PR03MB9893:EE_
X-MS-Office365-Filtering-Correlation-Id: 717ab214-825b-46e0-5f77-08dd89bdebf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?F2s/39L5D1KzPcXvM7JrXKG1xxarzYCiPaeM4X0c3xIgI0sQlXXyqNpg7U?=
 =?iso-8859-1?Q?oaraRaqPR1LNh3UjTFyFUumsRnnS7ZN/cZ6NYY/70k+1RMsh5IakpTWsjm?=
 =?iso-8859-1?Q?yOSWBoeZn7stFSHhTj/qJgeKRNOLYB863HqTjhDpl4M1068JmpiuBrANhM?=
 =?iso-8859-1?Q?2X2ZhtCw2lFbPMaCeYWn8q2nBz3EyKKK1eUhgGxAQnvrsgTxygfmjOtfGZ?=
 =?iso-8859-1?Q?k4YJlg1rnR40teM4yvQsIS9XVUDgtKbnr2zBzQY837e1GQFBXGm+nmqrzw?=
 =?iso-8859-1?Q?nR9vD45r0Aem9kGNKv5xPLnczKgHQnsNyduHzrKKat1bodlXQjdEn9RAFb?=
 =?iso-8859-1?Q?RwnxSX/KtmUPg1fMEA6AiKU6mO7wi+McP1EekuXgUJJu1rlgboRvY3B/7X?=
 =?iso-8859-1?Q?K8r7Lx2sPlM69zsCyvm0/mYZ8vwrQt+zKEyhTFEI2XoP/iMdjIkv2aorZ9?=
 =?iso-8859-1?Q?ZQen+O4AxYPo6/pPAgVx5TagaR7g1K9pOWUQsTAyrpg3inPEwrhxyEUifQ?=
 =?iso-8859-1?Q?I/ZtkGQXZ1vw957tvfu5fxpog++2OGK7xWnfnrttsK0kZrqJ55d3pXaEZ7?=
 =?iso-8859-1?Q?YzOzkuwubhWHWPUdAEzdnIEg9Wfn5Mxy0ZhWl49rLqm+DuxmN5U/j9F01Z?=
 =?iso-8859-1?Q?ANLp/I6ib1uEHfuI69NB+BFQTEqyL9LfmUVl/jabl2PyLlzAAzUUO7mvcQ?=
 =?iso-8859-1?Q?JH0/m1sTRt38b/W1s+0/yoBfj8BNucQy27FOHyaC57VSP1/Hbq82vrA0eb?=
 =?iso-8859-1?Q?mv4ISHuus8eNTT7vAYyGV/rCNHQlFJOL0mFPp4AMzUkJRbgZEfo6gaIteC?=
 =?iso-8859-1?Q?fdfvxSOIkJWZ2euj60A/vJ3mfVknr1V1DThHqPZ6826NPsmLc5Aq8bTXQn?=
 =?iso-8859-1?Q?z55fPiQH+uJAlkFNDZ7tgmd+cQqjFpofcIsVVh6aHDi5Qse12I+Ev9JrGG?=
 =?iso-8859-1?Q?nfAipAqDGvhdkbf8SQs5K3ZxjdKGn0Q6z6+WHEAUFcfRlwtIZI1Xq3pHSs?=
 =?iso-8859-1?Q?6KAAta9pfheXMY+eQaV3GKzyueRKo7GaH8Jlb35S3t0WXbnU9e5gixZApT?=
 =?iso-8859-1?Q?fqhcLCbjqrB8O/n138IgUk62fc8BOFHNUvkAhvm4Ibq+MrRf0DPXXWSB35?=
 =?iso-8859-1?Q?QL6kkTV05FdrFTX1rvZ8sdbGJt4Bm7yXRXKGd8IaWL3FeOCLgXZGbdKS0T?=
 =?iso-8859-1?Q?3zdhTxLzrPBdIPWJBvLozfj2bDYBjHkd5Zu2apJAI4TCV7BTyzPPU+re1w?=
 =?iso-8859-1?Q?g2tx7Kq4EQZUtTWREIZoA0d2evpQls8r2+m8rwOR6XTdyFa36Pf2DFf4pp?=
 =?iso-8859-1?Q?olR12T1eHizqPRVkT6EFNYgOeJVBc27GCLws1LVBSNQSpr5B/OU/sbj8Lk?=
 =?iso-8859-1?Q?fLeAv+CtAM8Bp1pW5/pOPF4bxQQLqxf7yPPejkmocOEd2qzm9geoZee58h?=
 =?iso-8859-1?Q?EN4XqlVQogjAhMmoSETxltTDwi3MMgcG+OwWzVVgkXVDS5VRMDMucTNvSm?=
 =?iso-8859-1?Q?bDfOMEcPImXWqacConzMW4oJF7sYM4uH+T29op2rBXfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB6285.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?D6cdcRCPraGzbIU8EORhpXgv6sDYB07Ssp3wIeLRIuaE6Nt/UJxNMXd39F?=
 =?iso-8859-1?Q?Ea1Jkv9aDXTGMY0e0S4CHonPRDVWOrRE773VKJYKdIvHPkdrAmRmi5JA60?=
 =?iso-8859-1?Q?kut4DRIeyvaOcnVv8lilrQ4UHfa0n7fs2i5C4+D7Hkpg1RWrtjzEmPwGSb?=
 =?iso-8859-1?Q?s40HgAFWSqM5Yhh1gdhAZ7nHWMqxBUOUWhu2zIi665Ok1AV03tzrekojtx?=
 =?iso-8859-1?Q?GN1eKvWwoEGRM0ihIfz1VI0HQtKcCO8x5BpGiRGa+Xhy+3uYHbkSLAYA5H?=
 =?iso-8859-1?Q?n+kuh4U5SR/2bFxiNlfZKVcwr6z5xZ4IfLilshnJGQkLeHK4uTY12RxAp+?=
 =?iso-8859-1?Q?cRkMLmkZOyutzL1f4lA21eSK2Q12dXTPEgPh4kfv3S5QGwLYBYmisq6Hlm?=
 =?iso-8859-1?Q?FXis6lhq7ERDwnBOheqUE8wp0iFTC8rg4+xrupOYTPnPamqOeGgIJ20NNh?=
 =?iso-8859-1?Q?GYoIcS+QC7gwVuqNGuxLRibhCGmbxo7P8vuiS37dq0xpTT5CQAoA/9HbrT?=
 =?iso-8859-1?Q?Bjn+sMhdUxjNnPfyK/KbRBqDkKMBkTcp0HX0sYskgO6CzRqzOXu/7rVQ/a?=
 =?iso-8859-1?Q?N3XqzeQ+IDvoClywXSP9rI+t1+oIlR+G4s55Ki+CNPz+/XSUGmnuAQYODT?=
 =?iso-8859-1?Q?RcCs/gEp9oViT6zn9sZPhIhgSvisIYCtwXpr/no69wn+9Xi8yBqdkwoMI5?=
 =?iso-8859-1?Q?W9mDLl5kT3FUvwOYluA973MKXouQcwTg7PhqEFOms1YKU8akPuf+8b+jy0?=
 =?iso-8859-1?Q?aCrNlqyL8YD9zZZEEkDUd7SscAnEmVKrgWrBJ7WZHIE3G7cEyHAeYMPJr8?=
 =?iso-8859-1?Q?cqPxt2s6PF1W0b8MWuXvbBgUzoF4oXnT0TbdA9EtfMttMyBo4Qv+7CGUAd?=
 =?iso-8859-1?Q?CVdMAdHh5qdLRwt4017Y7egtmF0TH+p4b6p+j0HrszxSrv/W5F/d7ICMOP?=
 =?iso-8859-1?Q?ELJnvET4yLbxjvJiYDIHxdh/7unvPqx9XpUe8vcCEK797xU2HZhylnoTpz?=
 =?iso-8859-1?Q?VdmDLjGRCIjfwJT1zhJVWK4ggZSCkjkHJ5ZvgPWIagos21e2O33Bq+3TEg?=
 =?iso-8859-1?Q?u2HBf95z6FNfnuOntbh4OxKobOWwfunAcV7+V9FnXk9pdlOFwiD7MHJVt/?=
 =?iso-8859-1?Q?U4bukJGGhRCW0IXfCIKRUMLPM7xSwWgfuSIjnmIjC9vbibjJxNacY4cQG+?=
 =?iso-8859-1?Q?nGJ9gh/jHd+L485PeFkenKopjyKqA+wJkrk9+nIzgzGdJH+XVQ0DDxF3dj?=
 =?iso-8859-1?Q?vdMqn8p+WBDBfsNWy2CDEbLV/t8jbuxc29rdMFuAvTduJTZTcctnGIw5A9?=
 =?iso-8859-1?Q?+1HyQj1I6gQq9tLdpd62K6oGCye0rSCvZB/S1eQFeY5Ru5BpYxjqRtEvyN?=
 =?iso-8859-1?Q?ylKJbP0Vra+LfKk9LYcmD52spCaxWCmmbArg4nVT+D9FOm0/FDNuxxCs1H?=
 =?iso-8859-1?Q?ZQqdhGq7DX5bP1fG4G70npduqdwGzpCF1Eh4uU4wJc7aRWoSpoJCRzlqoU?=
 =?iso-8859-1?Q?maVh6EaM3+SCWPiTcR2uN1v+HwvbBunhyBAOCSKKQF/M7Uhel97jNXRbH0?=
 =?iso-8859-1?Q?68N1Yztxf5V1egG2TwpRcLIkTl/rVGgeIoGU+PXLPmOyP9QRH4FoBhNjb7?=
 =?iso-8859-1?Q?MIBI3Edlzb2inV0M4b01iKs/xS1JSCN748?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717ab214-825b-46e0-5f77-08dd89bdebf9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB6285.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 21:11:35.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szbYL2bDPGoXxfwvtp4FtlcW3/S1bchJ2MvauU1+bZaPlBALX1oRkR3vqm+xSTwh2BGJEafttmNTMD3Lz1Yh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9893

On Fri, May 02, 2025 at 04:12:04PM +0100, Nuno Sá wrote:
> On Thu, 2025-05-01 at 08:32 +0200, Markus Burri wrote:
> > The buffer is set to 80 character. If a caller write more characters,
> > count is truncated to the max available space in "simple_write_to_buffer".
> > But afterwards a string terminator is written to the buffer at offset count
> > without boundary check. The zero termination is written OUT-OF-BOUND.
> > 
> > Add a check that the given buffer is smaller then the buffer to prevent.
> > 
> > Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
> > Signed-off-by: Markus Burri <markus.burri@mt.com>
> > ---
> >  drivers/iio/industrialio-backend.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
> > backend.c
> > index a43c8d1bb3d0..3878bd698c98 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -155,6 +155,9 @@ static ssize_t iio_backend_debugfs_write_reg(struct file
> > *file,
> >  	ssize_t rc;
> >  	int ret;
> >  
> > +	if (count >= sizeof(buf))
> > +		return -ENOSPC;
> > +
> 
> Oh, this can indeed easily lead to an oob access. However, I would likely not
> mind in early returning an error. This is to write registers so 80 should be
> more than enough. Meaning that to trigger this, it has to be intentional. That
> said, of course we should not let that happen but I would still truncate things
> and let it fail afterwards (keep the code slightly simpler with one less check).
> 
Thanks for your response.
I would prefer the upfront error check. The code is cleaner and simpler to read.
As you wrote the buffer should only contain a register and a value and
therefore never extend the 80 character.
If there are more, it must be intentional or by mistake. In both cases I expect
to get an error back, instead of try to handle partial/wrong data.

> So I would instead do:
> 
> buf[rc] = '\0';
> 
> Thanks for catching this!
> - Nuno Sá
> 
> 
> >  	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> > count);
> >  	if (rc < 0)
> >  		return rc;
> > 
> > base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e

