Return-Path: <linux-iio+bounces-7300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6092892723C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1651428AC78
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C77C1A4F3E;
	Thu,  4 Jul 2024 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ia0xS2E6"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2051.outbound.protection.outlook.com [40.92.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB71A4F0B;
	Thu,  4 Jul 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083351; cv=fail; b=Fqsk/VTwDhpIjtCUOd9MS05+JIyGppl1sykL2P4edxtRLe2rz8WOPq26Aexk6X5ofxmsJ542na6u1bw4o8Voe2PDNcuaoh0+YJKOxKyPc0x+bJufH1uLsDUlB3VrwalClAiBu+NNNnupPfeDuFjV03jvLC7PpSUw9bzaq77GGb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083351; c=relaxed/simple;
	bh=6dTUfzeW442yaWW6nsCaMbNw1CgCasD7zfsOK66Rers=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h89ue2BLEDWuM1WLpnLkq6nzESZ0nG9d4IKx0l3onL7e8GVee6HjowrDBpMyh5HcBHbQFUTtfM2a6yoNKUK2kgsjQd8NIrGJjRVOeQCDnNwJreeIkHS4hIfbL0acrnjf7D6/QugfNzIMpnmYWwKl+RiZl8UerX6VmtB6FwW9Omg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ia0xS2E6; arc=fail smtp.client-ip=40.92.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bABLGmuSRsErFA+LFK8UwJkFVdOtQLRqkMwMzdfwiLm6en+9vZTIaEBSsFr20I7UqxDM2UB24vmTYmbVXqx211loae36fG2URXTMAC2K0+BtxglfQubiZHw9wv5lQi3/OSVfToRXHw3CJXbFung73x1Mb0vz5br2RjnLK4VVEiqiQXNoFbTrBEi0dZGtGTuUsc13a41QLCfCS9cxIq5SgIBYjnrO5LlSQCVuaH/VtlqS0Y3AbWrqB7pIll1efajN8DCL81/6/al5cIbcZPES0FmPtvZgRXYy9mS8kd070U5pFWZ5t+DGgrpkh7Hio/Z5UghNu4Ile8VdvfnEIT28sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY/ljmvIM+/b0maTM+NjMSvwhx/FvMaiUxzkdJAxnzY=;
 b=JiwCul0mxbO7wmY0trVs8o7YnbeG8Gvy/fRZGUTeaDC6Vn9BPsSea/AGZ6fuVTX5LGcWiHdZ0ip8cs56mW3Tfvodn8dyuvSHXfreOsNlkoaKwhj0F0pl7FSvvEKCOIlz6/uwSmTmC/upAiogefw9J2gskDSkjOKBGan0aPd3z76poY/j1mzRNZFLuHIuFChy8hL1ypgA9XrpvYi4JWakrQxFJj083SRqhMZ9zT3JoUp0EmhA4QwRZrUJkMAybPhz5Ht6rkKR9cjhkE+tAcG0hd5ZJ5+PANEXXZXWoybC8Wwt5rux6Q/VxJLqEUTN0JqjPunIYZuo97PNgMu9MzZfQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY/ljmvIM+/b0maTM+NjMSvwhx/FvMaiUxzkdJAxnzY=;
 b=Ia0xS2E6SWn9/5pip6SFKy/mnaw97jdqOmjeiqhLpClKcoqitL6p2q7hQxULFv5dNXVH+OgJrHCtsi7wR6EfiYrGYYP95ptL7qNXTkRuo3RZ7L5/bwQWcihcC29qTZE7PhGjh7f3EwH+iz4oWEu3lKOE7dqM/ando36FMPq5uKuU30NGbRwvzePo61KMg1hV9a4QVPoVDKPPAhicKcNqrbbrpgcYRVH+1I/TYSujM7WcQ/Dan855tUXhXvjrv+xmb8iXNeW4GoeGMarvq7XUJhOW4rwP9tKGXJsm7pttroyUgAaUJpVvJnA8IVHXSdpYqJKe00LDqeQrDJ2cRrz5Lw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5456.namprd20.prod.outlook.com (2603:10b6:806:2bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Thu, 4 Jul
 2024 08:55:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 08:55:46 +0000
Date: Thu, 4 Jul 2024 16:55:12 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml:
 Add Sophgo SARADC binding documentation
Message-ID:
 <IA1PR20MB4953B17C1EC2F2DFCF2EB034BBDE2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
 <20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com>
 <b7913f90-7405-4a77-9c57-97ef124de6e1@kernel.org>
 <8d368347-7cee-41af-a033-c495eeb62e2a@bootlin.com>
 <577a5623-6dd8-4229-9c07-61e131a01aa8@kernel.org>
 <0d50df10-4b4e-47c4-930f-cd8f645a7e2d@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d50df10-4b4e-47c4-930f-cd8f645a7e2d@bootlin.com>
X-TMN: [lGVHKs/lmqsxD2DPP/7Q2hkOAZ9Es6oxki4enZtRAkI=]
X-ClientProxiedBy: OS7PR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:604:24d::16) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <c7ngvlgvd2aa5dgq5bekhkys5vfmau3wgrbktfnuxaldpzaizq@cxx3tr34oof2>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5b1e5a-8e2e-4682-e3d0-08dc9c071822
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|440099028|4302099013|3412199025|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	EPWMC7LV4xxIvWS9Y8Yl+qTqJOsaODo9heLIN8aYvM1vNVdzF71lF2hFhokSTeg8G9H+fzUSdj+pcvsPYWMwTDijW1JVWg1Ovwq2IhH+mIPYtdG0slLuh88R5pLD4I0QHbAXn9unBWcLIlLWAcMGNL8pOCHTFusJ+JZqztPTNkBuMUqdOiKurGowxBNqLrL5djphL5QemBVDKsf6WZGVEbGvT45dSXD84rpLIbVfLoPKAZGhkN0bfOLZJBA4WjFCm0uv5CSAB+IE+ppWUNucihLsWOoamjINWvXE8ccHJ0XfHVtGe3VS1RLtKQYRa59/Z8Bzn/9ktGXjQBp5AI16TULpGalHO+t3RG07dS9I683CodJyjqsIE7MWGek/gPpnktkNr9wRfK4722Wy2U+xsfE8+JQhKmrDbEeYrATjoE8fkcpGmtzi4zKTyKadq2YZ17GBz36x2rvISL8bYvyAJLctZXePEe1VePaqX198iMh3SX3xbut+RQ2gYdldSdYgA8jwyvwHvn9dKbhsbRa0YYQJETppwJRVupGsEuimgAu1IiYwGL3KdVJizlAJINifg2kit9oxpL0k2i1w2zJZ6YUrJjpls/DipBZT7rRYtxQ9gk2VX9da3eJ3m7z0oJjaiwi0QKdqKhs+DlQMkBYE3FoKKmipfEzcyC4d0orIDE0FdaaD9OGSyx3Ms/oa8NXVHk+yV1+P5ASBmwrzVFNxZMzTySsv+JZ7xA6GrMYovmzmdvXu+yZFivFYVldDz/9Tbx85jtd9uikyB8SG6xTqSg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E1Yu7f0+aSHz1Jj5HHaQ+0rqDMD6ZmcV4SUZRSHKHZ0P9U3h8lbKE4DuqUsm?=
 =?us-ascii?Q?MDUcsYHIJ97RL2jHqGN6PnmyRkKX2aIZWUrqAO6mOqeJEZellOmngGXQu+hm?=
 =?us-ascii?Q?1Sn7mjy7It0rRUkZgw8FnpAcBWNaiDHp290K6BL5mUC70UbzZ2ZH7hNBNaeA?=
 =?us-ascii?Q?4je7YUkU4UkbMJtEUZ5ZOnSTVR2aDkNHDmfUQ9eFh+yMg5k0RLrV/qAOq4Pw?=
 =?us-ascii?Q?gcw/o3u4rSScTT6Bt7IVodbLCgTDE36gpHKb7ecQq/Y1smjGxW9V/s6qyMn/?=
 =?us-ascii?Q?nugY7+QFklF2LvKKhE2diHsQkGmRQ7CnYW2+V4C8e11jrGO7jbopCBSNmk1d?=
 =?us-ascii?Q?At0n43fgJajc7MN/pL1i/lxipyhs/kwsgYXBwQZYRrDP2rdzGXxVreNlzX0R?=
 =?us-ascii?Q?vCeSlc3XGri3093+hjpNLufUtMq+tXVvGmYMTQLmFpbhhvRav4IQ/FRbyC5A?=
 =?us-ascii?Q?Yq718lEZWYVSUO4KttmGLwgnt2L4ThqB/N+evbJgJ1XFCqMY05F5VBkgsj/y?=
 =?us-ascii?Q?Bf+OF96OkO0fBy5nx3VqhJQeTivSgF4YO9Ah+VES2RuIo0W/u23rdyYl0Y4Y?=
 =?us-ascii?Q?v98T5wZ6yhMINsdUfOEO7CHLFwagO9KoFQSqtuR6KzdfN23c6/+K2U6tA1Be?=
 =?us-ascii?Q?GMggPIHiEzt/knGsJi4wpE2Cln2nBBG3S1xeKDRQoPbEUg/ejwZWlzYkHAb5?=
 =?us-ascii?Q?/M9IXp27vhWNOnfcRpBcFg5OY7VPVYH5kd1gRffJbQKqq97tyR7/QrZVOvrI?=
 =?us-ascii?Q?sKtv47ICUODMgZ+bfHSqTxPV4b5W7sCPKV7y3NBUF4ZT16GY7srvKWbPuqhH?=
 =?us-ascii?Q?q+/Yfmg1clBPQn3ulRDEtVOxiTPFubW/Ef5pnNyv5W0K1cB7vQPUa+JBEph6?=
 =?us-ascii?Q?xgwP7JxsamINWzjj8JCTyTuS+TTO20kPdt2sYwaGwtpYYqR4SSbKfA8xNqso?=
 =?us-ascii?Q?Zla4cPf8CJWGiAYdWdNdcYMpNRu7HPWe9m8GaoOt5HYXNPynwZ5qtC8EhtAo?=
 =?us-ascii?Q?YNZlUkPbdVv2BuG2RW6S/0ekEXATrsq27DwtYVTxwz/W2jbe89o8Gtc9BNbo?=
 =?us-ascii?Q?m9Uz68ZLysxhigD9t4cNK49WbTTcDjZ9gpR8BXHB1U9nbFQVYHPOI4LUtyr/?=
 =?us-ascii?Q?c2Bc8H38Il5IKp4EGza77u6mfU+sZ4AJ6FIhU/fZxQQSIQ/JN7QebFPpTN8l?=
 =?us-ascii?Q?yY2Q/RLnnYr0vBYV5KK99QGRQR7lZJQ9ZaHDwkKkp/O63J4nxFoxjSiGRC1c?=
 =?us-ascii?Q?4zgIhGNuP6uud1WOQ6nu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5b1e5a-8e2e-4682-e3d0-08dc9c071822
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 08:55:46.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5456

On Thu, Jul 04, 2024 at 10:52:05AM GMT, Thomas Bonnefille wrote:
> 
> 
> On 7/4/24 10:39 AM, Krzysztof Kozlowski wrote:
> > On 04/07/2024 10:35, Thomas Bonnefille wrote:
> > > Hello Krzysztof,
> > > Thank you for your feedback
> > > 
> > > On 7/3/24 7:08 AM, Krzysztof Kozlowski wrote:
> > > > On 02/07/2024 13:52, Thomas Bonnefille wrote:
> > > > > The Sophgo SARADC is a Successive Approximation ADC that can be found in
> > > > > the Sophgo SoC.
> > > > > 
> > > > > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > > > ---
> > > > >    .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 51 ++++++++++++++++++++++
> > > > >    MAINTAINERS                                        |  5 +++
> > > > >    2 files changed, 56 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..21fd5dc8e24e
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
> > > > > @@ -0,0 +1,51 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-adc.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Sophgo 3 channels Successive Approximation Analog to Digital Converters
> > > > > +
> > > > > +maintainers:
> > > > > +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > > > > +
> > > > > +description:
> > > > > +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: sophgo,cv18xx-saradc
> > > > 
> > > > Except that this was never tested... wild-cards are generally not allowed.
> > > > 
> > > 
> > > I realized I made a mistake when using the "make dt_binding_check"
> > > command, which led to some errors in this dt_binding. I have now
> > > addressed all of them, but I'm not sure I understand your comment.
> > > 
> > > I don't see any wildcards in the YAML file. Could you please provide
> > > more details on what you expect?
> > 
> > What is "xx"? Sounds like wildcard. I do not see such SoC compatible.
> > 
> 
> The point of cv18xx is to have a single compatible for all SoCs of the
> cv18xx series from Sophgo (cv1800b, cv1812h but also sg2000 and sg2002). I
> used that as a reflection of the cv18xx.dtsi used for all those SoCs.
> 
> Should I create multiple compatible for all the SoCs of a same brand ?
> 

You can use cv1800-xxx as a base compatible. 
Add new compatible when other SoCs have different features.

See the tutorial I have wrote:
https://github.com/sophgo/linux/wiki/Mainline-patch-How%E2%80%90to

Regards,
Inochi


