Return-Path: <linux-iio+bounces-13789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE89FC49D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 10:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AD0188311B
	for <lists+linux-iio@lfdr.de>; Wed, 25 Dec 2024 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477A4157E6B;
	Wed, 25 Dec 2024 09:56:42 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021138.outbound.protection.outlook.com [40.107.57.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDC13B7BC;
	Wed, 25 Dec 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735120602; cv=fail; b=ZU8IJjiADmR0dOLvnNiB3AYu4BiCTMF8BmBU/jQzO/kdzNeA85SDvsfilD8oAX0WgOlZ/WagfXUON2zMot+30fuYTouA9RS8CxlXf/XDPR5sZp7hd8VSIm3fbRcgG1tamc3tmpCXW4ZUIEPl41GpIJ6fbqjkx2PFHoY5iVIul2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735120602; c=relaxed/simple;
	bh=VbZ63G05L1bQP6Dj+UxyczKWHC+0HFwJDQnYwhRBc34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mADI3OtuMVyuUudokjikKPalkYKyiewm4eMivjw4Kddl7INr5UQOaTW1jA7Rd02+kV9nT/srWm3/TXXAA+CEGbuvJkusKDc4zhJ6lk2FhiuvqjO7E/4ZYPJN/NYKJynUjoeBA6HLlZmlQeHDoV8uL4fat1NFjMLyElBSe8YOxsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.57.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmQt44TatmUeBCjOomCwtPggSVZXCy6jI7AL1GUHcbq80CGmN1J9BZ7gH3TlaysBWQiJ+67xqI5nOMd4xRxYCtVjKGkNX7LQe26qWLWYHX7mXScvBhiCvCNd7bTypg2vg7LmXG+7bpPwvroYXRP/GJC2g3AnWqTpwUFN211O4Ytjy/6a10PZUYD7A9S82D//t8TViE4N0OYZTV5HU+vz35prcDroxWrtlSUbxd+ZKn9A+F3Grr1XMi8S+RpMiLuhMFXHEAtkQD84CzYsgnUYMB3zgOom1nIzFHr7zx9sAG2WWpVeBraSGNyGYprya4PkVVVf7Y9lpGUh94HfgUq+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC07Ar5u71soU0bsQeEZoIm0LxFZZfLtXyI0S19dfzc=;
 b=hnvnoGtane8+Hd7tqA+6GA2ELRFuCmgNzqlb6UfDo7z1RSutGiHwmTBRUrtexfc7HH7+o3iEf4APPZJh8eEfyROG22xdq0DtybBoZv+JLScOy86Yke8RZs2umbkOf62vS9lrRdBjmGlmLRT9IQ7H1tQaAWr3i+ukJNlE1slSfi/Luji70PPSi1WI03ndvwCUOM8AHT4mDhO4af/iSv3NyRSMQ/8iUxlzCpn5qOccqYu+N/CNtVOANJ3L/OQMh88TjK+X8sPwZEKaKX3rmFaFQhLEyR5LEyfcCc66tRjkA895qnc91l8s62pVSd6Te5DSby94lB1kPzxVzCa1BGtwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN0P287MB0326.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Wed, 25 Dec
 2024 09:56:36 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%4]) with mapi id 15.20.8293.000; Wed, 25 Dec 2024
 09:56:36 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "jic23@kernel.org" <jic23@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Emil Gedenryd
	<emil.gedenryd@axis.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma
	<muditsharma.info@gmail.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Julien Stephan <jstephan@baylibre.com>, =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>, Andreas Dannenberg <dannenberg@ti.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light
 sensor
Thread-Topic: [PATCH 2/2] iio: light: opt3001: Add Support for opt3004 light
 sensor
Thread-Index: AQHbVcsY35Y+fTs14EO6Y2d3pmBa7rL1g5YAgAE24a4=
Date: Wed, 25 Dec 2024 09:56:36 +0000
Message-ID:
 <PN0P287MB2843562E6C965196D05E2BCFFF0C2@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20241224061321.6048-1-hardevsinh.palaniya@siliconsignals.io>
 <20241224061321.6048-3-hardevsinh.palaniya@siliconsignals.io>
 <Z2rRnBGd4qqJXAb5@smile.fi.intel.com>
In-Reply-To: <Z2rRnBGd4qqJXAb5@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN0P287MB0326:EE_
x-ms-office365-filtering-correlation-id: 6d9e097e-4dde-4acf-4d46-08dd24ca6b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7R5YTyeOiirVQh+jGo3VJN5s55zsajb6pLxLGsNFRUd07QBOORtkx84tYP?=
 =?iso-8859-1?Q?lTANhZ8OKuse6WQM7IvndX1FeP4iwHJFzlm8s40h881kSeweZmt+T4EyXL?=
 =?iso-8859-1?Q?DNY29OnL05E9uKWxAIMnAJIOVYuL58i5MY5DGYfOtSlV4BLBF/ovjkVkAW?=
 =?iso-8859-1?Q?VD8C3dffAptwwvmGoDYvPJgStjJIqTLztKYbKsqoFoH7RuGL75BczERBHk?=
 =?iso-8859-1?Q?pdHODlKTqguIF9dFvX1/oezqNRzU5ircvkGv30hKW72DaPw6npuzRBifc1?=
 =?iso-8859-1?Q?4jnfch1In9EWAmwQnaY/t7tiBb/uMOZ3Xa54jNq71wD97dB1VEafrFrNQ+?=
 =?iso-8859-1?Q?pgTIalCs+3Hc95PsDj4Ls4MfkvSOOeiovynCUVKFKqZcl8VOkc2DgM2U3V?=
 =?iso-8859-1?Q?OTxErZQ8m5OaZc7UGs0KsdlwXdpvT5p5eEmNC/8v6Y2AQEuY/aA/8ivKeW?=
 =?iso-8859-1?Q?pG6R49fROzgJKdgm6eYUp2OT5QXRFyDXssSvcnl7Y7A+xrbdqap5TFvINa?=
 =?iso-8859-1?Q?F1L6KDBuo8A7yFW4TsONPYfaRBF1MpFPlPBhDf2n+g3NwnmLP7zBI2bMNs?=
 =?iso-8859-1?Q?/OdbzBu5q4OZqs9exUBQ+mKs1vCxuNZ6hjIbOeKju7ccjgVxsvfylvhIfO?=
 =?iso-8859-1?Q?j4eCau3/5+3VE/EE4yuLGazgM7JeS8veLd9OitYXu0DAUTjFX/vsO4lclf?=
 =?iso-8859-1?Q?AkYwTjw1NYNw81d8oatwHxk0Aut04BkhRjK4Vi6f4YvepffTkUezDORw0U?=
 =?iso-8859-1?Q?qi/jgqzcIvrSgBIS4riLu2rMdwnyI4dmOlljAAC6tuTxKHLdv8zIQyyzNx?=
 =?iso-8859-1?Q?vqQ2PXwbfKITfxmV4IaoDTyHsmhTgoKpposU9T736jL4KF90bowHNtXz+3?=
 =?iso-8859-1?Q?hiQCmddfyFr+jBgnPZcIKy4TU8pwe5l/mLAWhvoVyc3GdyMXIDUmhv37tn?=
 =?iso-8859-1?Q?2/uePhn+RXn29YPpcsXYxwb5nwkJ377NdDnBo/3Is4LVJhu0AKJAA9ktRQ?=
 =?iso-8859-1?Q?mrJadcAMiLBc/iUlpK4ymj8dz0XW7VZkSTxcVWDTP1Vzut51nauGA+IGje?=
 =?iso-8859-1?Q?DGWzG67yy/S/Ak/CHZiiLHzEJUAaE56sm0OiK3lxZb7kIpy20tfR2KMfZp?=
 =?iso-8859-1?Q?GAPl+U2Uy8OmzOaN0M8zh5VNKUE/y/GvrR9PEBQ5wjZvbPq39kDHzUNOPp?=
 =?iso-8859-1?Q?RgK3RsnTi+8KoLuekQLENIMS3dh1KBhyZBGf6k31t93BWl+OJ/Zl27OD1V?=
 =?iso-8859-1?Q?HDWJI7ptirW/zwNWAi2+sXR/S6d81H+lh37WT1XfxZpadLG7KSp1V06DFL?=
 =?iso-8859-1?Q?MskE5QgMeysh2OPxArvLQBYtALmkyUq9ArewBX3dHduRLvmo/1W0fkgH6U?=
 =?iso-8859-1?Q?k4UHeFKuCnTnQC5vEGVtn1QJmx6aZgj3m7xVl5D7v6yGMRoxmzlRDwy4eo?=
 =?iso-8859-1?Q?ZjHGdS8TjD4YHXH9GQ92OQwehqopRB3pUgSYhCJrdFuoIbSu46ej6ZcZ2L?=
 =?iso-8859-1?Q?+LN9NPBgnDKeadpPssGYPB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aSfs8kyexbFI/Myg/c+P9AUh4UI3ZdvQG86bT8X1nl9/w5qGnI+TaRVCPk?=
 =?iso-8859-1?Q?twLaWWz451utkHEU9OVSp5M1jBv/kjEbgPytqpnJvNYst8B5KRJSTqcTDA?=
 =?iso-8859-1?Q?0soA5G7P6gvhxdDT8fMooQhvaCd93di1TUfjRmMXfmALHlWIFGk0mvNH/b?=
 =?iso-8859-1?Q?ckd9L88UNSKLIggc4uH1J0IaaovNSABrSHJPjuyDzGqQInCpQUyzN68v/G?=
 =?iso-8859-1?Q?2fRPShUwVDdcu7nnG50U5M+4fjc013tLTj2r/CiVODYW0Y1f/XYdEVAujC?=
 =?iso-8859-1?Q?RCF9GRrwcu8cONJbMcfeXus3L9uWjD4ygg7OOWKr45AIP/ih4Jtrb8NCSK?=
 =?iso-8859-1?Q?E8rJYWf98neoQfK7XtV0y3Tvp3lHkCe9245NySbzbA8yT+tyKchB2rNxza?=
 =?iso-8859-1?Q?uMsY8a24YGLP577TxHulDmh67WC6wYmrJ67dJ5NT1v2YqlgTFA8p/t2tiy?=
 =?iso-8859-1?Q?Z4sSDiRtcEeYCk4HR7GXuEs2IO0GBqIRIK4A4V21JwJEXA40N+QQjK555n?=
 =?iso-8859-1?Q?7TQ2y6Xe5M6+XTSvnKqX/HnxMLieZ9gPfiCAYu3PegSRL93CnmO+nNObaZ?=
 =?iso-8859-1?Q?CgOTM3QpTlp6uL2Er/DX7us4aOyQHUGPC2Ekv20fHSOgo8Bd3Ic22+IFoi?=
 =?iso-8859-1?Q?/Rd45QHUjGIJLD+wNP7l+VOwxdkNsCNCgnJDCs87oUIWsat8s42i0dpanM?=
 =?iso-8859-1?Q?9AJI+b3UnapPfeo3/KEH5givwZzjLVj5mnKXrERiC5swzctZwRX027Sa0l?=
 =?iso-8859-1?Q?mA+ag4AJ+RzXEtFj2GXjMjwD50K1js1KPzb4w6bkYM+jQTgDNl9X+7bRDb?=
 =?iso-8859-1?Q?STkGj+zmJrFQ5cmjPGJNguURoY9mPrd6peQKhXn3FBDlfe7o2sMDmInVMG?=
 =?iso-8859-1?Q?u7simfWZPyxFprZBbdLOIFWbpAJXkKtw9+dWqRsxOnFwSbQaKYwQ8LC/Cn?=
 =?iso-8859-1?Q?KnICVFahDxfNNtJuEKTSR9sDvow5jF7TSyLP4lP4PbLPDC3ueIK2s1pFY/?=
 =?iso-8859-1?Q?X4dB5V2XdH1+9t9mtFp/fGplUptiMktuLHZ9lWyEuAsf5tgUHNM+BAHfVI?=
 =?iso-8859-1?Q?bIERpCeXkvCZE7dtZ61YtBPXDjuZ0en35z+MmtoU0dS6qgZp/46u+XVsOG?=
 =?iso-8859-1?Q?6AALu+IPsMMZVbMtBYxIC8F1MFibndihSJ8TvvYWFS5TQzwZlH2XVwerbQ?=
 =?iso-8859-1?Q?uP+s61J4f0dU4kIVapwPEAOSvfY8jaxAYL02EoWZXBF618HEtMrUlVdt7M?=
 =?iso-8859-1?Q?n9W4uSaCYWlA95fCYLZZwz9u+828AF1u+E3LVzmW7Ie9afZwrA/WyYxD2L?=
 =?iso-8859-1?Q?jbkNQ0n9ktFiKDfqkBN/Ypt8oa3ImciwarxtytD6WdRXJns5Qnrg7iwgpt?=
 =?iso-8859-1?Q?2+royzcwZh+UX+czXo0w9UHzYERemuz+IS/xA9ygQvXqx2U0LVHZ+nuDDn?=
 =?iso-8859-1?Q?SUVGcTbqWiQQCv7/ds88wDupnht7GExQA8q2nlXCpRwSGZ5yz6p0Ye47wO?=
 =?iso-8859-1?Q?fzm6xXHwxhy6cBN5rp69fUewUVxMNonxr34+G1ptwjsLZNHhMtsB5SQXyH?=
 =?iso-8859-1?Q?w12VED8sSz9iZw6uAPQsFdyLEKy1BWCbgG4AkDCjafvTsZx32JI5mOo4hb?=
 =?iso-8859-1?Q?SfqlQiibQ5MjA83lpvK30t0fXIrwxmcnNh7T2X2Sgem5G98/a30AFdkyUx?=
 =?iso-8859-1?Q?KSPuWjH+hpN0kWeA/4A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9e097e-4dde-4acf-4d46-08dd24ca6b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2024 09:56:36.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EVDlAq9VOrXn5NNzdGnWWzu7MJQmJ6jW+Nj9EpymkCosF83xPuGz+9rRvNlJGurqc8tOM6rHhMDJ0QGeZhhhfU/+mh+JBty6zf7hBOIjVCYhe6648aFx0+FQ6vKd8lfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0326

Hi Andy,=0A=
=0A=
Thanks for the reviews =0A=
=0A=
> On Tue, Dec 24, 2024 at 11:43:16AM +0530, Hardevsinh Palaniya wrote:=0A=
> > Add Support for OPT3004 Digital ambient light sensor (ALS) with=0A=
> > increased angular IR rejection=0A=
>=0A=
> Missing period here.=0A=
> =0A=
> > The OPT3004 sensor shares the same functionality and scale range as=0A=
> > the OPT3001. This Adds the compatible string for OPT3004, enabling=0A=
> > the driver to support it without any functional changes.=0A=
> >=0A=
> > Datasheet: https://www.ti.com/lit/gpn/opt3004=0A=
>=0A=
> >=0A=
> =0A=
> This blank line is not needed.=0A=
>=0A=
> > Tested-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=
=0A=
>=0A=
> This tag is superfluous, it's assumed that author testing their code.=0A=
=0A=
okay , i will remove =0A=
=0A=
> > Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.=
io>=0A=
>=0A=
> ...=0A=
>=0A=
> >       help=0A=
> >         If you say Y or M here, you get support for Texas Instruments=
=0A=
> > -       OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor.=
=0A=
> > +       OPT3001 Ambient Light Sensor, OPT3002 Light-to-Digital Sensor,=
=0A=
> > +       OPT3004 Digital ambient light sensor.=0A=
> =0A=
> Can you rather convert this to a list (one item per line)?=0A=
> =0A=
>          - OPT3001 Ambient Light Sensor=0A=
>          - OPT3002 Light-to-Digital Sensor=0A=
>          - OPT3004 Digital ambient light sensor=0A=
=0A=
Sure , i will =0A=
=0A=
> >  static const struct of_device_id opt3001_of_match[] =3D {=0A=
> >       { .compatible =3D "ti,opt3001", .data =3D &opt3001_chip_informati=
on },=0A=
> >       { .compatible =3D "ti,opt3002", .data =3D &opt3002_chip_informati=
on },=0A=
> > +     { .compatible =3D "ti,opt3004", .data =3D &opt3001_chip_informati=
on },=0A=
> >       { }=0A=
> >  };=0A=
> =0A=
> I'm always puzzled why do we need a new compatible for the existing drive=
r=0A=
> data? Is this hardware has an additional feature that driver does not (ye=
t)=0A=
> implement?=0A=
=0A=
OPT3001 and OPT3004 sensors are functionally identical, and there are no=0A=
additional features in the OPT3004 that require separate handling in the dr=
iver.=0A=
=0A=
The new compatible string for the OPT3004 is being added, which will allow =
the=0A=
driver to recognize and support this sensor in the same way it handles the =
OPT3001.=0A=
=0A=
Best Regards,=0A=
Hardev=

