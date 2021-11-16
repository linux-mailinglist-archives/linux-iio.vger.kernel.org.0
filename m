Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2991A453AF5
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 21:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhKPUcX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 15:32:23 -0500
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:45025
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229553AbhKPUcW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 15:32:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6hRuHIpS7VLwu1PWR9wrrCNOIrxwlbHbvlkYy0Ah/ys+WlahiV3YK4DGgEsvLJAfIog5gn/iNTCHnS/H4E/ojisnLX+P3q3jEdkAe4cl8dRKd1a/LupsZnQVmrzOtg5ZDjjCN2Hx5MKs/rmiSX0NdWGudqLmpyIkIpAU8RWYhx90ymuXOkozOEN8rsLtvpBd9D5ShtrWUS9ytDIcmlMcepaZBarFk7M11/soG49ZCClIwDFK4UvrQA2tGE4jOSYghnTSVmUJzIIZBOeOMuLUiJELbJBqQvlGS5y0soMkVyq3fbmc6aixgcy29jnRhu6S9kK+jeEZh8sm7s7nbp+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGNwzhbHBt7Rpq7VhnwyxASslQHhRAmsif1KmBtl0Yc=;
 b=jbkzuafI8fckXcnYZN7pD51T/sPFlY2DuqtAb/UOhtnP9gI4eyWvPhtsh4pwvbsK2u16kyxlCy0adW1MVAnTG6rsz/fJ6AvSO0G4qe1/CAAhCe066j33Axd2uwnDw1Ur8efZeciusE26UpxS3nL+G+xLHndchQUpTNtqvNsaL8EutlVpcbKWePvSwpyeJzFystGERRrA9ah+dWgk50rwCHNQoGZIjPRUov9rcDn1TCEz7UbAaKk5aTz3ad/sezoq9CPjZZhfWzOZZKKRU9g+F1GZtHnLUQYnD5+6aPNO2RKMzc8Bb8N1r8d3vZx7k77VWICV+3yOnLYQPiDWjZCNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGNwzhbHBt7Rpq7VhnwyxASslQHhRAmsif1KmBtl0Yc=;
 b=fYmIGvqVEQ6WohtsqdkgxTguCTvn4tGMpI/gRB786YnK/oCEZeI2hW+3xqIGrQhwN5WZPauqBZg81YgfsAIRlZeGXtLxBux1Cu/iTuysw5mMHI7W7zwpmmLNoz8L1a2iqL3kqNVAFmN4VqUYeNdj9gpI1pk/oZ8mwn/WuSp9jiE=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7855.namprd02.prod.outlook.com (2603:10b6:a03:322::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 20:29:21 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 20:29:21 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v9 3/5] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v9 3/5] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHX2vvgaPiT9/1qgUiDBOAw7eSw66wGa6OAgAAjo9A=
Date:   Tue, 16 Nov 2021 20:29:21 +0000
Message-ID: <BY5PR02MB6916E4CF9E34190CF7D24AE4A9999@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211116150842.1051-1-anand.ashok.dumbre@xilinx.com>
 <20211116150842.1051-4-anand.ashok.dumbre@xilinx.com>
 <YZPspfolQkDrz22s@smile.fi.intel.com>
In-Reply-To: <YZPspfolQkDrz22s@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37f9381d-0bb5-4f9d-dc31-08d9a93fc5ea
x-ms-traffictypediagnostic: SJ0PR02MB7855:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB78555C595214ECFB223F68C2A9999@SJ0PR02MB7855.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gniDQl1o2J6cAgyWtzFaDT/05GRIURmvYJbMV2YnUD4LVCX+MiIwRIf+ulabkg2WVT+x299R1twt6KLuLqcc13JTBPPgrcnl8owo9lOCaRzxG6H5zWJTH3bVeRn7fEIwbEQBLkO2SJJEjYeDNwlaZnjWz2dNikPHHs4M3z4ZgGA8FTTsBZg4xG43MuzC7F/kxcypcqIwJEr6uo6/XUiPWH6Qc4OMaFOjtoqNUVG4FmcgZCIJjsA0LhX5AMOQFZKvGR9GqZSAGaRSW1KM0PkCTL+Y5S6eRawkekg1dRHWHOZhR1K6pLJhvqZsRrkCdZbrO40My/Zqdrrb6CUkwwbUtks5Nw1N5q4hLUjSorI928z0xLnVH4vBKJSlfJyZME+xOaO25LK86FSa7GAn64iwxXgXrVPSt9B7eYyqa6gLL7i2qeZjWCh/XcE1dLsApS/QylKdKZNgdL46o3kuUt2FgjldcpIuU4CkaIC8zUETdS1ySS7IZ55EdvdJ4JxTF0aDn1mYEhJROCMdP0F+VqgvJNLZ4aOBjJ5PLdZ0JEXP7uNYZPNW9Ji3QgtNqcr4BfC6hcxGl/eDwo78davODqUGw2GIOp4liu0bHc42nFhD1UsLF1DjghpmB6ZXJY+r72CXLIZA6libShzZDx8uNezvhKenulmQ5I5BDCWonvpa1pqb69Rh0l++e9B6zLRN4IsYJ1qi0apfOksTk4vwnpeuVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(66946007)(71200400001)(76116006)(107886003)(64756008)(66446008)(26005)(6916009)(66476007)(66556008)(7416002)(316002)(4326008)(52536014)(508600001)(38070700005)(8936002)(6506007)(8676002)(54906003)(53546011)(2906002)(55016002)(9686003)(7696005)(122000001)(38100700002)(33656002)(5660300002)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CBzzYJHzpCcZWVhL3eEyfRDee/zGqF5OjMRT/2/yf4mclSNhjjnFEFe2D1vn?=
 =?us-ascii?Q?PHqqjDNCdUVQkDcn8VUapCdfdy+DmmV5fDgtRaWikVs2Cqf0bBOKiiDNhVWw?=
 =?us-ascii?Q?guAYxmvoOG0pC9Kmr8JsmqZRPUoDCca2+qrbz0EXswYkrzjyt3SgQrPMT6Lx?=
 =?us-ascii?Q?Bc75owX/VVJm+XF94qfQgD9IEZW8VDphNA2f1YbQF6j4WjkAz4OQGrf3E1hQ?=
 =?us-ascii?Q?C0QHFyyRkk9nW/8av0FrWzLP0BrGwvTv9yGMXixGUy8AAMamv+CDd3gS9wNY?=
 =?us-ascii?Q?ojdUTNs/2lPzi6iwWqHDYx/uJg7cnUnRQg8TonoLMVx4/sP7CZs1L1YzmW6s?=
 =?us-ascii?Q?j9fCGKd5WAGtU8hU+uHJknGzF2jCtsOsN79BLIXNG3ziKnFDNA6y/nuC3Au6?=
 =?us-ascii?Q?8hDh+bGw34rbtHVeDIL5wYuof8FMMWZ8EXVPJdQPL2TUT0l+oJcEVXBqjG65?=
 =?us-ascii?Q?FVQf4pMobuomEdbwaiAjDmTPx9ek/uUI3MSsk+IB8yF1tIkLP+Gt/isMn3zi?=
 =?us-ascii?Q?0hp1VcYiBYGHy8jEUCemIG8cxX0+/scr1ocURaAHRCL0AzUcD7qHUhwYaPTR?=
 =?us-ascii?Q?gACjUSnHETxIJpsRJxbC9mbgbJ9mH45v+Hl180Ck/mCzNprJNCtRXiPvVRQK?=
 =?us-ascii?Q?9pjUB/r9ue0EPYibmUbdE3A3PNMmhaDLgaIhCrhCmwB6jUq8VZQ2EwLpLUzH?=
 =?us-ascii?Q?WJMxACrjeyMKCsFlz+kPEL7vyMjKUmkYq1W9u6SbvuAZCi1oYpdrJNF/mYAl?=
 =?us-ascii?Q?7nHQyeApkcJt9C283E7taBcV0j+8m8Dxzbpu5RgmZQD9IZjeV7Yr/OAxasxo?=
 =?us-ascii?Q?5a+Mhhw70jgnEcQxtTVzL7mjn78/BcM5LZjpX9H54YXqlAxmq5Nl17epV1rP?=
 =?us-ascii?Q?NQ0MBO+sDJn38ECuzvOKaOVZBVwb4ivbvNNOKDdFR5LqDsofoz4x7lDq/GK1?=
 =?us-ascii?Q?kB0p3Z8ZL+Zb3eC8daBSSAfICoJrM5SwmtyT7Kc9awQvUfZTDl7LSk/3nYOK?=
 =?us-ascii?Q?Tx7VHQ0MiwDhZ3cJc+LdWSkYu92KJC39yQSXH4IiFbKvEkFvijwKdGTl21up?=
 =?us-ascii?Q?fqVpJQFekQ6S7tTgmWSQQpJkWAff5gSMsdZ8ZyHnKo3yaKLWGI8sXNGf0B4M?=
 =?us-ascii?Q?4ZaUCZ8VfhZ3X3Aq+Vw2IaOMvXVfXA8cFsTgUqEniU7+BsaTHLEN321ugEol?=
 =?us-ascii?Q?0XPS4q+oQu6QOnEZBq0oYaAfyf8YyBIVYPbn9BL0RJvCQ34DHbX3gjoP1IYC?=
 =?us-ascii?Q?M0rQ72+jNM0+GfwJ2/wBfPeJaNnnqY5GxpaTdqqjkKjPsdiMeqOFwlL/Y3pu?=
 =?us-ascii?Q?SvWZrNtxH71/gtA/u/iRj11wshuYIhRUO5m4kvwJCGY5mYIUWbIRcNnM5rsE?=
 =?us-ascii?Q?DFYl83DHTwPSDTestoWwJqM5znrpoYOkW8BqLhMJKbASSw/QJxkyZguHcrzc?=
 =?us-ascii?Q?6m8/a56CwVJlnHRQF0ktqCDDK8Hzgp5Qfa/W8JHzccrOpvdA4o7xRCAe7b+I?=
 =?us-ascii?Q?zLboSS9Hs8I2Mp4iu3p9Qcf8/l7cOBxws26OsBwQ67TVhh7p3XMxbwIw5pG0?=
 =?us-ascii?Q?yyP97IVyEOCZ3u/x3xZ0VyK7KMou4ojzXTbpZPZwVZA8OeYVaXjfMeqfVSAy?=
 =?us-ascii?Q?XbjD79KTVJbbwa8Rkcj6UwM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f9381d-0bb5-4f9d-dc31-08d9a93fc5ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 20:29:21.6261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ij/Dlkv5gaN1TUzJae7zSj6mtvjbJvTc9/Wt5t79tZbsZR69pksHTEca7km3XPKwU1LMr/DVpMtt2DzMhKwFKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7855
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

Thanks for the review.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday 16 November 2021 5:39 PM
> To: Anand Ashok Dumbre <ANANDASH@xilinx.com>
> Cc: linux-kernel@vger.kernel.org; jic23@kernel.org; lars@metafoo.de; linu=
x-
> iio@vger.kernel.org; git <git@xilinx.com>; Michal Simek
> <michals@xilinx.com>; gregkh@linuxfoundation.org; rafael@kernel.org;
> linux-acpi@vger.kernel.org; heikki.krogerus@linux.intel.com; Manish Naran=
i
> <MNARANI@xilinx.com>
> Subject: Re: [PATCH v9 3/5] iio: adc: Add Xilinx AMS driver
>=20
> On Tue, Nov 16, 2021 at 03:08:40PM +0000, Anand Ashok Dumbre wrote:
> > The AMS includes an ADC as well as on-chip sensors that can be used to
> > sample external voltages and monitor on-die operating conditions, such
> > as temperature and supply voltage levels. The AMS has two SYSMON
> blocks.
> > PL-SYSMON block is capable of monitoring off chip voltage and
> > temperature.
> > PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> > from an external master. Out of these interfaces currently only DRP is
> > supported.
> > Other block PS-SYSMON is memory mapped to PS.
> > The AMS can use internal channels to monitor voltage and temperature
> > as well as one primary and up to 16 auxiliary channels for measuring
> > external voltages.
> > The voltage and temperature monitoring channels also have event
> > capability which allows to generate an interrupt when their value
> > falls below or raises above a set threshold.
>=20
> Something with indentation / paragraph splitting went wrong.
>=20
> ...
>=20
> > +#define AMS_ALARM_THR_MIN		0x0000
> > +#define AMS_ALARM_THR_MAX		0xFFFF
>=20
> If this is limited by hardware register, I would rather use (BIT(16) - 1)
> notation. It will give immediately amount of bits used for the value.
>=20

So ~(BIT(16) - 1) for AMS_ALARM_THR_MIN
(BIT(16) - 1) for AMS_ALARM_THR_MAX

> ...
>=20
> > +#define AMS_REGCFG1_ALARM_MASK
> 	(AMS_CONF1_ALARM_2_TO_0_MASK |	\
> > +
> 	AMS_CONF1_ALARM_6_TO_3_MASK | BIT(0))
>=20
> Better to write as
>=20
> #define AMS_REGCFG1_ALARM_MASK \
> 	(AMS_CONF1_ALARM_2_TO_0_MASK |
> AMS_CONF1_ALARM_6_TO_3_MASK | BIT(0))
>=20

Will do.

> ...
>=20
> > +#define AMS_PL_CSTS_ACCESS_MASK		0x00000001U
>=20
> BIT()
>=20
Will fix.

> ...
>=20
> > +	u32 reg;
> > +	int ret;
>=20
> 	u32 expect =3D AMS_PS_CSTS_PS_READY;
>=20
> (Use similar approach for other readX_poll_timeout() cases)
>=20
> > +		ret =3D readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
> > +					 (reg & AMS_PS_CSTS_PS_READY) =3D=3D
> > +					 AMS_PS_CSTS_PS_READY, 0,
> > +					 AMS_INIT_TIMEOUT_US);
>=20
> 		ret =3D readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
> 					 (reg & expect) =3D=3D expect,
> 					 0, AMS_INIT_TIMEOUT_US);
>=20
> 0?!
>=20
>=20
> > +		if (ret)
> > +			return ret;
>=20
> ...
>=20
> > +		ret =3D readl(ams->base + AMS_PL_CSTS);
> > +		if (ret =3D=3D 0)
> > +			return ret;
>=20
> Assigning u32 to int seems wrong.

It's a single bit register.
Even if I use u32 here, the return type is int.=20
So, is it ok if I read using u32 and return it by typecasting to int?

>=20
> ...
>=20
> > +static int ams_enable_single_channel(struct ams *ams, unsigned int
> > +offset) {
> > +	u8 channel_num =3D 0;
>=20
> Assignment does not bring any value.

Agreed.=20
>=20
> > +	switch (offset) {
> > +	case AMS_VCC_PSPLL0:
> > +		channel_num =3D AMS_VCC_PSPLL0_CH;
> > +		break;
> > +	case AMS_VCC_PSPLL3:
> > +		channel_num =3D AMS_VCC_PSPLL3_CH;
> > +		break;
> > +	case AMS_VCCINT:
> > +		channel_num =3D AMS_VCCINT_CH;
> > +		break;
> > +	case AMS_VCCBRAM:
> > +		channel_num =3D AMS_VCCBRAM_CH;
> > +		break;
> > +	case AMS_VCCAUX:
> > +		channel_num =3D AMS_VCCAUX_CH;
> > +		break;
> > +	case AMS_PSDDRPLL:
> > +		channel_num =3D AMS_PSDDRPLL_CH;
> > +		break;
> > +	case AMS_PSINTFPDDR:
> > +		channel_num =3D AMS_PSINTFPDDR_CH;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* set single channel, sequencer off mode */
> > +	ams_ps_update_reg(ams, AMS_REG_CONFIG1,
> AMS_CONF1_SEQ_MASK,
> > +			  AMS_CONF1_SEQ_SINGLE_CHANNEL);
> > +
> > +	/* write the channel number */
> > +	ams_ps_update_reg(ams, AMS_REG_CONFIG0,
> AMS_CONF0_CHANNEL_NUM_MASK,
> > +			  channel_num);
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +					regval =3D readl(ams->pl_base +
> > +						       AMS_REG_CONFIG4);
>=20
> One line?
>=20
> > +					regval =3D readl(ams->pl_base +
> > +						       AMS_REG_CONFIG4);
>=20
> Ditto and so on...
>=20
It goes over 80 chars per line.

> ...
>=20
> > +static int ams_get_alarm_mask(int scan_index) {
> > +	int bit =3D 0;
> > +
> > +	if (scan_index >=3D AMS_PS_SEQ_MAX) {
> > +		bit =3D AMS_PL_ALARM_START;
> > +		scan_index -=3D AMS_PS_SEQ_MAX;
> > +	}
> > +
> > +	switch (scan_index) {
> > +	case AMS_SEQ_TEMP:
> > +		return BIT(AMS_ALARM_BIT_TEMP + bit);
> > +	case AMS_SEQ_SUPPLY1:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
> > +	case AMS_SEQ_SUPPLY2:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY2 + bit);
> > +	case AMS_SEQ_SUPPLY3:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY3 + bit);
> > +	case AMS_SEQ_SUPPLY4:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY4 + bit);
> > +	case AMS_SEQ_SUPPLY5:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY5 + bit);
> > +	case AMS_SEQ_SUPPLY6:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY6 + bit);
> > +	case AMS_SEQ_SUPPLY7:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY7 + bit);
> > +	case AMS_SEQ_SUPPLY8:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY8 + bit);
> > +	case AMS_SEQ_SUPPLY9:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY9 + bit);
> > +	case AMS_SEQ_SUPPLY10:
> > +		return BIT(AMS_ALARM_BIT_SUPPLY10 + bit);
> > +	case AMS_SEQ_VCCAMS:
> > +		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
> > +	case AMS_SEQ_TEMP_REMOTE:
> > +		return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
> > +	default:
> > +		return 0;
> > +	}
>=20
> > +	return 0;
>=20
> Dead code.

Will remove return statement.

>=20
> > +}
>=20
> ...
>=20
> > +	return (ams->alarm_mask & ams_get_alarm_mask(chan-
> >scan_index)) ? 1
> > +: 0;
>=20
> 	return !!(...);
>=20
> simply shorter.

Sure.
>=20
> ...
>=20
> > +	schedule_delayed_work(&ams->ams_unmask_work,
> > +			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
>=20
> Can be one line.

Over 80 characters.=20

Oh! I just saw that upto 100 chars is ok.

>=20
> ...
>=20
> > +	struct fwnode_handle *child_node =3D NULL,
>=20
> You may drop _node from the name.
>=20
> > +			     *fwnode =3D dev_fwnode(&pdev->dev);
>=20
> ...
>=20
> > +	if (check_mul_overflow(num_chan, sizeof(struct iio_chan_spec),
> > +			       &ams_chan_size))
> > +		return -EINVAL;
> > +
> > +	/* Initialize buffer for channel specification */
> > +	ams_channels =3D kzalloc(ams_chan_size, GFP_KERNEL);
>=20
> Simply use array_size(). Or why not kcalloc()?
>=20
> > +	if (!ams_channels)
> > +		return -ENOMEM;
>=20
> ...
>=20
> > +	if (check_mul_overflow((size_t)num_channels, sizeof(struct
> iio_chan_spec),
> > +			       &dev_chan_size))
> > +		return -EINVAL;
> > +
> > +	dev_channels =3D devm_kzalloc(&pdev->dev, dev_chan_size,
> GFP_KERNEL);
>=20
> Why not devm_kcalloc()?
>=20
> > +	if (!dev_channels) {
> > +		ret =3D -ENOMEM;
> > +		goto err;
> > +	}
>=20
> ...
>=20
> > +	ret =3D 0;
> > +err:
>=20
> Use better naming, you should describe what is going to be after goto.
Sure. Will do

>=20
> > +	kfree(ams_channels);
> > +
> > +	return ret;
>=20
> ...
>=20
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> ams_clk_disable_unprepare,
> > +				       ams->clk);
>=20
> One line?
>=20
> > +	if (ret < 0)
> > +		return ret;
>=20
> ...
>=20
> > +	ret =3D ams_init_device(ams);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to initialize AMS\n");
> > +		return ret;
>=20
> It's fine to use dev_err_probe() for known error codes.
>=20
> > +	}
>=20
> ...
>=20
> > +	ret =3D devm_request_irq(&pdev->dev, irq, &ams_irq, 0, "ams-irq",
> > +			       indio_dev);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed to register interrupt\n");
> > +		return ret;
>=20
> Ditto.
>=20
> > +	}
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Thanks,
Anand

