Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4225022C8E7
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 17:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGXPXk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 11:23:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33312 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgGXPXj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 11:23:39 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OFNNC7000995;
        Fri, 24 Jul 2020 11:23:23 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00128a01.pphosted.com with ESMTP id 32bx04jf8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 11:23:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6ON6SRP1iVoJDMtp81qFcB6fvpzaGMnn7fU4fe7yRwrnr2TqRWQp1SqfMBM8cU4XYq0ORBNud8FQob6e/YMYOU3JhK8PPMd8QO1yn7tsgHZlFGZm9zjPaVUtJdjEftxJA0e7gjkmUvx29NTHx+VavpUhdCIrbAyOaUQgS+lLLP4HV7pNlt7tdErwOs44mloMHwoROxvgL+pE+QYpX+e37kQW433ll/DYLvtAR7xebZzc+29EO8T61MqO5DWBV2JNar4yj7NOez4Y60tWKdcT2iJlyKXM7PLuMNvAZOf+tTIKPmrxT38zBxwoMLJl4AB8WuczXjYiBdSqfCQIVe2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEmjfZBL0qMQRQ28GYbe1wYrFsFuii8h9IbhA8oEebk=;
 b=Ko9BNFgFdMyREBqF7SbuuCTnOlQgH5PnHvArHtwopMHc+T/OLX1hHcgNtCFpA8Uo+M6BliYpKBB3eUXRHiN4+7tZF9DjfdTz1+fHSPGwpTfYi+A+EuEB3OTpYFoDxRVAI53cgmwb38uFPTeQbjHRoVGhrw6FoyakN7ZoemHy2yzns0tkcANZqwzMt9nMMHJp77HuAwtwydmCajhPvP42KpHBMY8ABioImQWJJgr0CKQiaZZ0fs47OFgMtu5U2jbP2G2GSVVzvTsehhl8lCb1n0UvwODf5Kx9ysLqZoRWDR3PT3yF5hFWqaUVpVNXpa2GwIgjuUGk9+Q7L1C+uW+ypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEmjfZBL0qMQRQ28GYbe1wYrFsFuii8h9IbhA8oEebk=;
 b=S6yidAR8qCQCZbLQHJtW6EVPJpfHw2QNyDssKptJkS2aYW2F4ekLvS8NQYAWQqGBTb6radIwBVQiApLn4r0qSdZPjceN2VM+xoGaNtifEga+XAS12bujwoUt9qqZyVqK5BFx32SOWINZjYKpWfEhlTEp7ukp7j8UjfmGkrhapx0=
Received: from SN2PR03MB2317.namprd03.prod.outlook.com (2603:10b6:804:d::26)
 by SN6PR03MB4558.namprd03.prod.outlook.com (2603:10b6:805:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Fri, 24 Jul
 2020 15:23:21 +0000
Received: from SN2PR03MB2317.namprd03.prod.outlook.com
 ([fe80::9519:b0cf:9d40:b512]) by SN2PR03MB2317.namprd03.prod.outlook.com
 ([fe80::9519:b0cf:9d40:b512%8]) with mapi id 15.20.3216.026; Fri, 24 Jul 2020
 15:23:21 +0000
From:   "Pop, Cristian" <Cristian.Pop@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH] one-bit-adc-dac: Add initial version of one bit ADC,
 DAC
Thread-Topic: [RFC PATCH] one-bit-adc-dac: Add initial version of one bit ADC,
 DAC
Thread-Index: AQHWW0JTA3aqb5CuhECQCRTQAzQghqkJ75sAgAaT34CABk8VcA==
Date:   Fri, 24 Jul 2020 15:23:21 +0000
Message-ID: <SN2PR03MB2317AC79D13C3A89882534F4E7770@SN2PR03MB2317.namprd03.prod.outlook.com>
References: <20200716072737.9535-1-cristian.pop@analog.com>
        <9bd0363c-e8fb-a36f-a107-0afd8f7851d0@metafoo.de>
 <20200720145225.4f5d552b@archlinux>
In-Reply-To: <20200720145225.4f5d552b@archlinux>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY3BvcDJcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy0zNjBlZjIwMC1jZGI5LTExZWEtOTQ0OS0xODFkZWE1?=
 =?us-ascii?Q?NDZmZTBcYW1lLXRlc3RcMzYwZWYyMDEtY2RiOS0xMWVhLTk0NDktMTgxZGVh?=
 =?us-ascii?Q?NTQ2ZmUwYm9keS50eHQiIHN6PSIxMTI4NyIgdD0iMTMyNDAwNzQxOTYwOTUw?=
 =?us-ascii?Q?NTkwIiBoPSJWbmhRdHlqUCtiQ3pmN3hNbEk2V0NpVi9mdk09IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUEr?=
 =?us-ascii?Q?bzVUNHhXSFdBZWZYTFQ1NWFVWFA1OWN0UG5scFJjOERBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQXpEZitTUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.24.48.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bd680c8-4bd2-454d-6c4c-08d82fe57ffc
x-ms-traffictypediagnostic: SN6PR03MB4558:
x-microsoft-antispam-prvs: <SN6PR03MB4558C9E86B16660FB4AA0E6BE7770@SN6PR03MB4558.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKVZVkym+/YaUQMnGr8hXoUSxDW956Jc/WnWJUrFYl76QhhbWMzZdXveWXL65LOC0uAg7/yKTinDZ705r+Sznslf69iSAiB4Tvz7f5RhbSPw4Jf9Tzg2Xc1S7TV1C1DubKiLfETqOxotXCqJdk1urE9XchPkxZAzGk9epV07UMd/Q9uTuK+50krvy6+SLtOfvVa6CBLOegMaEmxnLsxAyKKqTkLWeZXFzhI+JzEjDhZ2Y4XeDnrWmDsRgW5Rcqm4/hZg6rDj1iRBv9gH9H/bsnwiSIeIzvY8jzHPvr0qjALY0jzvO0IqzatNIFsOY3pJ0j2qswqRlUey4xBl+G3ilw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2317.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(346002)(366004)(39860400002)(136003)(54906003)(110136005)(8676002)(33656002)(9686003)(4326008)(71200400001)(86362001)(55016002)(8936002)(7696005)(64756008)(53546011)(66476007)(186003)(83380400001)(30864003)(5660300002)(52536014)(478600001)(26005)(76116006)(2906002)(316002)(66556008)(66446008)(6506007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EwUjKWdpKQbMPsHo8e+Gpn3ZvoAGluFB4Z0+t50pQQGIUvgCFVVj1ImnuPar0PEb0viITX/ogJ2eH5U3mYWGIxILySvoe30NGhQ4QDwBy/7DdIs4p5w3AmICkYai1DEVE4hyZo7rYxg6/+FecBe94YYhGduv+VAFDcM/BH6cK4udo5mFwXUJ9tT+6UUh9gckQtqUpLSRS1LgQVS8MO0CxPuzzIsOVyXUNYl52MWqsKDoF/wfC34VNP7qmJVtKZt/odwhV/bjoklQqoAR7bTlgEDEi1gr59Cq0Oej80xqS8dFv4opdFJL0jOIxSNtiYFN+ITcQpnpcTLROsDfsveMTgMWRen5mdKBGFbTH0ZpeWWOyxtfBVIaixh4a/V+v2YX7gdMZWtBvpyY6GBM8VAhlrRdaBv4UOsk2itfeOeVRGixB1q2m4ZeiQQlRCPcxxAjif7quh2l6hqPiIxix2CEG6RZZjKvwvEBnuL80j/9/SM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd680c8-4bd2-454d-6c4c-08d82fe57ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 15:23:21.2861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MM462fhb3d00cicSvgTg6N/pdrjvBOGV4cJBlk4QgJfz//aAB4vjaOdeZeQzdihmg8xdzznz8QFI6Zq/Ud9CgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4558
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_05:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1011 spamscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240120
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Monday, July 20, 2020 4:52 PM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Pop, Cristian <Cristian.Pop@analog.com>; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH] one-bit-adc-dac: Add initial version of one bit =
ADC,
> DAC
>=20
> [External]
>=20
> On Thu, 16 Jul 2020 11:25:36 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>=20
> > On 7/16/20 9:27 AM, Cristian Pop wrote:
> > > Implementation for 1-bit ADC (comparator) and a 1-bit DAC (switch)
> >
> > Very sneaky way of introducing a iio-gpio-proxy driver to be able to
> > access GPIOs through libiio ;). I'm not really a fan of the whole idea.
> >
> > But either way I think this needs a better description of what 1-bit
> > converters are and how they are used.
> I'll second that.  If we want to do this, I'd much rather seeing as an ex=
plicit gpio
> to IIO bridge driver.
>=20
> If there is a comparator on an ADC pin, then the analog characteristics o=
f that
> need describing.  There might be some argument in favour if that was done
> and hence we had scale etc provided for the channel.
>=20
> Given this is really just putting a new interface on gpios please cc the =
gpio
> maintainer / list for future versions.
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> >
> > >
> > > Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> > > ---
> > >   drivers/iio/addac/one-bit-adc-dac.c | 229
> ++++++++++++++++++++++++++++
> > >   1 file changed, 229 insertions(+)
> > >   create mode 100644 drivers/iio/addac/one-bit-adc-dac.c
> > >
> > > diff --git a/drivers/iio/addac/one-bit-adc-dac.c
> > > b/drivers/iio/addac/one-bit-adc-dac.c
> > > new file mode 100644
> > > index 000000000000..8e2a8a09fedb
> > > --- /dev/null
> > > +++ b/drivers/iio/addac/one-bit-adc-dac.c
> > > @@ -0,0 +1,229 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Analog Devices ONE_BIT_ADC_DAC
> > > + * Digital to Analog Converters driver
> > > + *
> > > + * Copyright 2019 Analog Devices Inc.
>=20
> Probably update to 2020 or 2019-2020
>=20
> > > + */
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/module.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/gpio/consumer.h>
> > > +
> > > +enum ch_direction {
> > > +	CH_IN,
> > > +	CH_OUT,
> > > +};
> > > +
> > > +struct one_bit_adc_dac_state {
> > > +	struct platform_device  *pdev;
> > > +	struct gpio_descs       *in_gpio_descs;
> > > +	struct gpio_descs       *out_gpio_descs;
> > > +};
> > > +
> > > + #define ONE_BIT_ADC_DAC_CHANNEL(idx, direction)
> 	\
> > > +	{								\
> > > +		.type =3D IIO_VOLTAGE,					\
> > > +		.indexed =3D 1,						\
> > > +		.channel =3D idx,						\
> > > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> 	\
> > > +		.output =3D direction,					\
> > > +	}
>=20
> Macro only used in one place, I'd not bother with the macro.
>=20
> > > +
> > > +static int one_bit_adc_dac_read_raw(struct iio_dev *indio_dev,
> > > +	const struct iio_chan_spec *chan, int *val, int *val2, long info)
> > > +{
> > > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > > +	int in_num_ch =3D 0, out_num_ch =3D 0;
> > > +	int channel =3D chan->channel;
> > > +
> > > +	if (st->in_gpio_descs)
> > > +		in_num_ch =3D st->in_gpio_descs->ndescs;
> > > +
> > > +	if (st->out_gpio_descs)
> > > +		out_num_ch =3D st->out_gpio_descs->ndescs;
> > > +
> > > +	switch (info) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		if (channel < in_num_ch) {
> > > +			*val =3D gpiod_get_value_cansleep(
> > > +				st->in_gpio_descs->desc[channel]);
> > > +		} else {
> > > +			channel -=3D in_num_ch;
> > > +			*val =3D gpiod_get_value_cansleep(
> > > +				st->out_gpio_descs->desc[channel]);
> > > +		}
> > > +		return IIO_VAL_INT;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
> > > +			    struct iio_chan_spec const *chan,
> > > +			    int val,
> > > +			    int val2,
> > > +			    long info)
> > > +{
> > > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > > +	int in_num_ch =3D 0, out_num_ch =3D 0;
> > > +	int channel =3D chan->channel;
> > > +
> > > +	if (st->in_gpio_descs)
> > > +		in_num_ch =3D st->in_gpio_descs->ndescs;
> > > +
> > > +	if (st->out_gpio_descs)
> > > +		out_num_ch =3D st->out_gpio_descs->ndescs;
> > > +
> > > +	switch (info) {
> > > +	case IIO_CHAN_INFO_RAW:
> > > +		if (channel < in_num_ch) {
> > > +			gpiod_set_value_cansleep(
> > > +				st->in_gpio_descs->desc[channel], val);
> >
> > How can we set a value on an input GPIO?
> >
> > > +		} else {
> > > +			channel -=3D in_num_ch;
> > > +			gpiod_set_value_cansleep(
> > > +				st->out_gpio_descs->desc[channel], val);
> > > +		}
> > > +
> > > +		return 0;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static const struct iio_info one_bit_adc_dac_info =3D {
> > > +	.read_raw =3D &one_bit_adc_dac_read_raw,
> > > +	.write_raw =3D &one_bit_adc_dac_write_raw, };
> > > +
> > > +static int one_bit_adc_dac_set_ch(struct iio_dev *indio_dev,
> > > +					struct iio_chan_spec *channels,
> > > +					const char *propname,
> > > +					int num_ch,
> > > +					enum ch_direction direction,
> > > +					int offset)
> > > +{
> > > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > > +	const char **gpio_names;
> > > +	int ret, i;
> > > +
> > > +	if (num_ch <=3D 0)
> > > +		return 0;
> > > +
> > > +	gpio_names =3D devm_kcalloc(indio_dev->dev.parent,
> > > +					num_ch,
> > > +					sizeof(char *),
> > sizeof(*gpio_names). It might be better to use normal kcalloc, kfree
> > here since you only use it in this function.
>=20
> Definitely.
>=20
> > > +					GFP_KERNEL);
> > > +	if (!gpio_names)
> > > +		return -ENOMEM;
> > > +
> > > +	ret =3D device_property_read_string_array(&st->pdev->dev,
> > > +					propname,
> > > +					gpio_names,
> > > +					num_ch);
> Take advantage of the new longer acceptable line length (100 chars) to ma=
ke
> some of these more readable.
>=20
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	for (i =3D 0; i < num_ch; i++) {
> > > +		channels[i] =3D (struct
> iio_chan_spec)ONE_BIT_ADC_DAC_CHANNEL(i +
> > > +							offset,
> > > +							direction);
> > > +		channels[i].extend_name =3D gpio_names[i];
> > I think we want to avoid using extend_name in new drivers because it
> > makes for a very clumsy ABI. We should add a label property like we
> > have for the device for channels to have a symbolic name of the channel=
.
The current dts looks like this:
one-bit-adc-dac@0 {
				in-gpios =3D <&gpio 17 0>, <&gpio 27 0>;
				in-gpio-names =3D "i_17", "i_27";
				out-gpios =3D <&gpio 23 0>, <&gpio 24 0>;
				out-gpio-names =3D "o_23", "o_24";
			};
Resulting in channels:
in_voltage0_i_17_raw
in_voltage1_i_27_raw
out_voltage2_o_23_raw
out_voltage3_o_24_raw
If we want to lose extend_name, please provide an example for using labels.
How the dts should look like, how do I use it in the driver?
>=20
> Agreed. It keeps getting talked about, but no patches yet IIRC.
>=20
> I'd expect separate indexing for input and output channels.
> The in / out distinguishes them.
>=20
> in_voltage0_raw
> out_voltage0_raw etc
>=20
>=20
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int one_bit_adc_dac_parse_dt(struct iio_dev *indio_dev) {
> > > +	struct one_bit_adc_dac_state *st =3D iio_priv(indio_dev);
> > > +	struct iio_chan_spec *channels;
> > > +	int ret, in_num_ch =3D 0, out_num_ch =3D 0;
> > > +
> > > +	st->in_gpio_descs =3D devm_gpiod_get_array_optional(&st->pdev->dev,
> > > +						"in", GPIOD_IN);
> > > +	if (IS_ERR(st->in_gpio_descs))
> > > +		return PTR_ERR(st->in_gpio_descs);
> > > +
> > > +	if (st->in_gpio_descs)
> > > +		in_num_ch =3D st->in_gpio_descs->ndescs;
> > > +
> > > +	st->out_gpio_descs =3D devm_gpiod_get_array_optional(&st->pdev-
> >dev,
> > > +						"out", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(st->out_gpio_descs))
> > > +		return PTR_ERR(st->out_gpio_descs);
> > > +
> > > +	if (st->out_gpio_descs)
> > > +		out_num_ch =3D st->out_gpio_descs->ndescs;
> > > +
> > > +	channels =3D devm_kcalloc(indio_dev->dev.parent, (in_num_ch +
> out_num_ch),
> > > +				sizeof(struct iio_chan_spec), GFP_KERNEL);
> >
> > sizeof(*channels) to avoid accidentally using the wrong type.
> >
> > > +	if (!channels)
> > > +		return -ENOMEM;
> > > +
> > > +	ret =3D one_bit_adc_dac_set_ch(indio_dev, &channels[0],
> > > +					"in-gpio-names", in_num_ch,
> > > +					CH_IN, 0);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	ret =3D one_bit_adc_dac_set_ch(indio_dev, &channels[in_num_ch],
> > > +					"out-gpio-names", out_num_ch,
> > > +					CH_OUT, in_num_ch);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	indio_dev->channels =3D channels;
> > > +	indio_dev->num_channels =3D in_num_ch + out_num_ch;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int one_bit_adc_dac_probe(struct platform_device *pdev) {
> > > +	struct iio_dev *indio_dev;
> > > +	struct one_bit_adc_dac_state *st;
> > > +	int ret;
> > > +
> > > +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	st =3D iio_priv(indio_dev);
> > > +	st->pdev =3D pdev;
> > > +	indio_dev->dev.parent =3D &pdev->dev;
> > parent assignment should not be needed thanks to Alex's work.
> > > +	indio_dev->name =3D "one-bit-adc-dac";
> > > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +	indio_dev->info =3D &one_bit_adc_dac_info;
> > > +
> > > +	ret =3D one_bit_adc_dac_parse_dt(indio_dev);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	platform_set_drvdata(pdev, indio_dev);
> >
> > There does not seem to be a matching get_drvdata() anywhere so this is
> > not needed.
> >
> > > +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> > > +}
> > > +
> > > +static const struct of_device_id one_bit_adc_dac_dt_match[] =3D {
> > > +	{ .compatible =3D "adi,one-bit-adc-dac" },
>=20
> This is definitely not ADI specific.  It also currently looks like a poli=
cy thing
> rather than truely defined by the wiring.
> Hence I'd kind of expect to see it instantiated via configfs rather than =
a dt
> binding.
>=20
> Note this would definitely need a dt binding doc if done this way.
> My gut feeling is that as it stands, it would go nowhere.
>=20
>=20
>=20
> > > +	{},
> > > +};
> > > +
> > > +MODULE_DEVICE_TABLE(of, one_bit_adc_dac_dt_match);
> > > +
> > > +static struct platform_driver one_bit_adc_dac_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "one-bit-adc-dac",
> > > +		.of_match_table =3D one_bit_adc_dac_dt_match,
> > > +	},
> > > +	.probe =3D one_bit_adc_dac_probe,
> > > +};
> > > +
> > > +module_platform_driver(one_bit_adc_dac_driver);
> > > +
> > > +MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
> > > +MODULE_DESCRIPTION("Analog Devices ONE_BIT_ADC_DAC");
> > > +MODULE_LICENSE("GPL v2");
> >
> >

