Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD845831E
	for <lists+linux-iio@lfdr.de>; Sun, 21 Nov 2021 12:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhKULaT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 06:30:19 -0500
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:10176
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232729AbhKULaT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 06:30:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAyqPh9xggOWwTp/2mlpVTrRLk+yYF7mqDXNB5U+BTFW+Pz7OLmMmSG141RkhFkXTOyp1UjwTmUWlmfbq9v06p3+Rn/jOQGv0T1gyn4E9hkMkuJ3thsRi72rvi7B3FDI450TcpWw824iANKzVD7bN+joccOsYgWKdJZm1H+RK+7liNtmp3AFixJ3hm5turyFRW6dIfWdOrl3JjVHaY6NiLIP9Lu/czmwTdj4TqGckPhr0dh5dt3dyR4X6wXMYEK4Q1JpaisRB7ku0ypIaOaSk6zUg06lLO8lzjGL3qpX4ZJV2A0NraBPOwFkkbuqNoqrbq7++wUzuCRG3rfr8UB4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufHwOiT3GzoL4aqES0AzdMvms1YKqDkENYeAzEZ0j0w=;
 b=NBgEsrCOBbsYLH8r+JBXCPYrpm/hpY35hedQ1PdyWG4F25daUZTpEcr4rW8K8Zhp81zWc/dCXAN0OquuSrdJN2vF0tgyQLI5vcVHW9fihXrB6skbAmQ3tzo8t/eageUgCd0pblf74bCln9pndic/A80K7x/BAToXVjifx/dREv1R/R2wvjtnbAA5GtAKHvt0eecz4sBge0eoV8L10kFMRaP9aYklch6ld2uZ44TizTdxYenOmkJ70TJFHwtA7oEHImR0cBNi68foLEKoAEkAWX9LMRp76X4r6D6xb2hxK6SkzI/KmtZWV8Dec7gn0B0xu4794+gEGDu0n+DWoF1PAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufHwOiT3GzoL4aqES0AzdMvms1YKqDkENYeAzEZ0j0w=;
 b=VUoDhx1L2PlYLZ1tteiAZC5jbuw3vlA2li7xiIcnS33H9rSMlAwSsLlNenubcb9YIP72lxQHe7pnjJSGgygAp9iWj/iW2Bcpdq9W/fH+f2ncNd5ZgMj4LhdjqLBVp4tTTah8TwITfzA8PBLi6vW0AXqfI5hQpPvOgeCiOV2EpJU=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7245.namprd02.prod.outlook.com (2603:10b6:a03:29d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Sun, 21 Nov
 2021 11:27:12 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%8]) with mapi id 15.20.4713.024; Sun, 21 Nov 2021
 11:27:12 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
Thread-Topic: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
Thread-Index: AQHX282sZu1pJFP81EiVfi9bN2U8cqwMptiAgAE1vgA=
Date:   Sun, 21 Nov 2021 11:27:11 +0000
Message-ID: <BY5PR02MB691607DB15E0EA5417A74552A99E9@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
        <20211117161028.11775-4-anand.ashok.dumbre@xilinx.com>
 <20211120165345.53de0d51@jic23-huawei>
In-Reply-To: <20211120165345.53de0d51@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a53ce64-0905-4849-14e3-08d9ace1dcd7
x-ms-traffictypediagnostic: SJ0PR02MB7245:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB72457CE657785F0B705FE96BA99E9@SJ0PR02MB7245.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XqPqQa/Xbu/hfgucr1QwQixhvLO9+DNUUUjGlEz7m0+E6iy61ydQ0Tskb8ZcFThA/J7o0V6rAz5Quhva4FBVZv4CCZielkRB9YUEJhOm1NBkhs+MNkq8pfTQR/1izgDoWdBio+W9wWd5UY9wSomrqUtkCHFFWFgqYRO9WQjByQB679WQo57dmWmWigBJvK4NElKaHwFTQSho1AEC5OnGkMuxqYg4qTfNQqphNnkM2YvAjhB0ACVmAfLtztwLYa/tPpuYdASKlcmysZEIFUwvC0qlmcDeynlCKCik484/oRe9QYV/QSWelKxUTMv6l4zMbqCHHnO8+5bXKUMF0huUcNV1HQ/hcOOZzhfgG5AAu6rUpbTFqND89jLuvDhpgxyR5oKzw4NUl7RpMF5U19HpDaQbH1cdbVpR+QLR3gBPwulvQze1v+tbJS0jnxBcdIHq0m2M52QAoauUcACIf2WP9NfxM/HyyB7Ethh5NbxZ2dbEFykuuM7wPWRzM/HdEdb9h3kwi2EdBVxhmvgJFv+kYGwzSg8GygRGTGhyplbrKbhhb7dWbHw6ioVsm2G6PHjG/OLjLZ3sckifuUbEb8QdGVeFtGlCK39A24kEcYwEPgNkUKVF1eqR5psdXGOUVhoRzXILnvwzGpbbPqAY3wB2KU8GSlSbAPwRikWwxIOw8whO3rwtAUQ9gGGUs8XueMCZM5SYGPkpm7RqfkXFaKx7BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(33656002)(8936002)(5660300002)(316002)(86362001)(7696005)(83380400001)(186003)(38100700002)(6916009)(8676002)(9686003)(6506007)(122000001)(107886003)(66556008)(38070700005)(52536014)(66946007)(55016002)(64756008)(71200400001)(2906002)(508600001)(54906003)(66476007)(66446008)(76116006)(26005)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kVqyA6XI3biESqc+h0LIv7nGhUJMe5yXpTRBqkHl8B02dpHU9I3crCMI7KO7?=
 =?us-ascii?Q?yxAhvBjb8w8EkmvDjA0BKaovSsu8lSQssMsOcWH4r90wWk1kvqbQI1kBV9FH?=
 =?us-ascii?Q?ZqlqekzUqXO2CEqwvvnY6QF3IXpct274+qzAOB9ZFqw1dHNKB6gkek+LkUQx?=
 =?us-ascii?Q?G3gOj0iTbXTTXkECcV65G0aIoJMqXp41Tp013DBEDSbr6OW2RJpa7BipJhYX?=
 =?us-ascii?Q?X0UKzJ4npYE3NRopcXgYYd7mtTjiIemGtHfwHHqzZZZHeZ5mCc+MmijFpLSD?=
 =?us-ascii?Q?6SvnjOnvXANIw4gVlx3pNEtA4BDBZZuYzokwmEZiGdgjgU7CWnNGP+vP774l?=
 =?us-ascii?Q?mlvQ8Mwmrhgz9knYhX10ZmbrRk8hOdoehwq7FgTRwh84VSo13G1AWz46LX27?=
 =?us-ascii?Q?uMlqlgywQQd8p7Bqbv+Cx6nU6LgKtC86ehYbhYfsnOiA+U5mKE55yCT6k1Zi?=
 =?us-ascii?Q?L27KbJ303pBKIUyju/muDcmqwHrZENQGWsoJK2B1Ni6TjvLgEPOh5XwXnGza?=
 =?us-ascii?Q?wdyxWD8ukf7VK4pAoqL2tk7vEI9rEZ1yzIrLqP3OKIusQ7o7ansZtmTH4EmO?=
 =?us-ascii?Q?AzO7Sjsd2xlOaQ4fs3KGwGQxGnMcE1qDhGP9NfRSEYbfuRLqQtrLwcbG3im9?=
 =?us-ascii?Q?b+Ea3069nr+WTvwNs8SHPv5zd/8NAGrYN96+by9xQwkOG/JLyD7hesKYE7V7?=
 =?us-ascii?Q?lOZJuIvCA9v0sQ1Q7sJk8yp0n465bFOU53S2b8Lq6dc8mXgBpxpW4ns9zfjF?=
 =?us-ascii?Q?TNjfD0PQMo2tOGpQtPHZgHNPXwqyeIWqdhaON1NzRj2Jp4cejvIQ5EyvQjpH?=
 =?us-ascii?Q?hI5iKvZnOdydet/hPf+dUMBkDd79MMBRNOU0MGuedZRSTmUpVYZ1Bch8rjgT?=
 =?us-ascii?Q?YB9/kZDW5ttd0uKfAGXmarO8WfmTk1Qwa9BEbuErze+cm78eZRPqgUCIc4sr?=
 =?us-ascii?Q?DFrXqUWlPod6pno22ddbQ5BikQjauxpldJX1yKGbRWagXJP4sc+7VM/47sqf?=
 =?us-ascii?Q?7qHEp43RfUyi0q5YuKyqd25PZU7oT1G9Jwvu0GkNlVOKP6B8uW1nJWFarWwW?=
 =?us-ascii?Q?Zai1kjU+e97zkLxfbNHIExDY1F+9+0W+UakxcOcEVN9e7mFFO7Z5JIqY5W39?=
 =?us-ascii?Q?IBdNJ786++hK/pcBW3SgJKvbWj8rcp/U9ptETRUDvbuh8VW+VBZDq+W6XgmB?=
 =?us-ascii?Q?hdFeH63iZ9oJWfT/JaD1FGFsyJnMYKMDcMZ/mRLbO9NFnc0RMzOl0e5jx3J8?=
 =?us-ascii?Q?IS75c7ex9LfZbU5aH3Uw6HgdwLGjEoG4hqs3a8z3x/H5ASeDg8VyUh0fuUPD?=
 =?us-ascii?Q?UfVMvQSXZq5aHmuWpcraljUOj3+drhJzKGjtxsw4JTQq6SMzCXwZZcyyKs+5?=
 =?us-ascii?Q?y6zNijgIOojmcAafzVpnWQiZvYbu6giLqJ9issa0Qh/cV9nJV8mQycQcrqB/?=
 =?us-ascii?Q?QiWYM1DWpLDVjICmvnqHgKzMFrhnNjvXtYi1Ac+x3z5F/+ZjJ7V4fLw8+es7?=
 =?us-ascii?Q?PKgtCH7ieY9gZ29Qseeo4g5Pg8lX84TpZ0wQOYaSWnBkuKjJmTBYkIzT8AdB?=
 =?us-ascii?Q?34z3x9AUfS+k9yjBfpg+lIiVZij3I8zjBMcrPR9YNG71f6WG1UUGbqdsJ9CM?=
 =?us-ascii?Q?v/uQmUEpW6ng8U/VlLRx39A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a53ce64-0905-4849-14e3-08d9ace1dcd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2021 11:27:11.9619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDToEQIQZGxc/2JQxEclifQA/Ln14uSOZB3xwD77dpSVikb/a1dmzK4xQmv4e/aLGO5iAem0DxF+2S1MzuyFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7245
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Cameron,

Thanks for the review.
...
> Subject: Re: [PATCH v10 3/5] iio: adc: Add Xilinx AMS driver
>=20
> On Wed, 17 Nov 2021 16:10:26 +0000
> Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com> wrote:
>=20
> > The AMS includes an ADC as well as on-chip sensors that can be used to
> > sample external voltages and monitor on-die operating conditions, such
> > as temperature and supply voltage levels. The AMS has two SYSMON
> blocks.
> > PL-SYSMON block is capable of monitoring off chip voltage and
> > temperature.
> >
> > PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring
> > from an external master. Out of these interfaces currently only DRP is
> > supported. Other block PS-SYSMON is memory mapped to PS.
> >
> > The AMS can use internal channels to monitor voltage and temperature
> > as well as one primary and up to 16 auxiliary channels for measuring
> > external voltages.
> >
> > The voltage and temperature monitoring channels also have event
> > capability which allows to generate an interrupt when their value
> > falls below or raises above a set threshold.
> >
> > Co-developed-by: Manish Narani <manish.narani@xilinx.com>
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
>=20
> A few minor additions from me to what Andy has noted.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile index
> > d3f53549720c..4a8f1833993b 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -115,4 +115,5 @@ obj-$(CONFIG_VF610_ADC) +=3D vf610_adc.o
> >  obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o  xilinx-xadc-y :=3D
> > xilinx-xadc-core.o xilinx-xadc-events.o
> >  obj-$(CONFIG_XILINX_XADC) +=3D xilinx-xadc.o
> > +obj-$(CONFIG_XILINX_AMS) +=3D xilinx-ams.o
> >  obj-$(CONFIG_SD_ADC_MODULATOR) +=3D sd_adc_modulator.o diff --git
> > a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c new file
> > mode 100644 index 000000000000..bb3876b51e3e
> > --- /dev/null
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -0,0 +1,1447 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Xilinx AMS driver
> > + *
> > + *  Copyright (C) 2021 Xilinx, Inc.
> > + *
> > + *  Manish Narani <mnarani@xilinx.com>
> > + *  Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>  */
> > +
> > +#include <linux/bits.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/overflow.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> Used?
> > +
>=20
> ...
>=20
> > +/**
> > + * struct ams - Driver data for xilinx-ams
> > + * @base: physical base address of device
> > + * @ps_base: physical base address of PS device
> > + * @pl_base: physical base address of PL device
> > + * @clk: clocks associated with the device
> > + * @dev: pointer to device struct
> > + * @lock: to handle multiple user interaction
> > + * @intr_lock: to protect interrupt mask values
> > + * @alarm_mask: alarm configuration
> > + * @masked_alarm: currently masked due to alarm
> > + * @intr_mask: interrupt configuration
> > + * @ams_unmask_work: re-enables event once the event condition
> > +disappears
> > + *
> > + * This structure contains necessary state for Sysmon driver to
> > +operate  */ struct ams {
> > +	void __iomem *base;
> > +	void __iomem *ps_base;
> > +	void __iomem *pl_base;
> > +	struct clk *clk;
> > +	struct device *dev;
> > +	struct mutex lock;
> > +	spinlock_t intr_lock;
> > +	unsigned int alarm_mask;
> > +	unsigned int masked_alarm;
>=20
> Hmm. maybe a rename to make these two less confusing?
> Perhaps
> current_masked_alarm?
>=20
> > +	u64 intr_mask;
> > +	struct delayed_work ams_unmask_work; };
> > +
>=20
>=20
> ...
>=20
>=20
> > +
> > +static void ams_handle_event(struct iio_dev *indio_dev, u32 event) {
> > +	const struct iio_chan_spec *chan;
> > +
> > +	chan =3D ams_event_to_channel(indio_dev, event);
> > +
> > +	if (chan->type =3D=3D IIO_TEMP) {
> > +		/*
> > +		 * The temperature channel only supports over-temperature
> > +		 * events.
> > +		 */
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(chan->type, chan-
> >channel,
> > +						    IIO_EV_TYPE_THRESH,
> > +						    IIO_EV_DIR_RISING),
> > +			iio_get_time_ns(indio_dev));
> > +	} else {
> > +		/*
> > +		 * For other channels we don't know whether it is a upper or
> > +		 * lower threshold event. Userspace will have to check the
> > +		 * channel value if it wants to know.
> > +		 */
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(chan->type, chan-
> >channel,
> > +						    IIO_EV_TYPE_THRESH,
> > +						    IIO_EV_DIR_EITHER),
> > +			iio_get_time_ns(indio_dev));
>=20
> I think alignment is wrong here. iio_get_time_ns() should align with open=
ing
> bracket as well.
>=20
> > +	}
> > +}
> > +
>=20
> ...
>=20
> > +
> > +static int ams_parse_firmware(struct iio_dev *indio_dev,
> > +			      struct platform_device *pdev) {
> > +	struct ams *ams =3D iio_priv(indio_dev);
> > +	struct iio_chan_spec *ams_channels, *dev_channels;
> > +	struct fwnode_handle *child =3D NULL, *fwnode =3D
> > +dev_fwnode(&pdev->dev);
>=20
> Where you have values being set, I'd prefer separate line per variable.
> Tends to be a little more readable and we need all the help we can get :)
>=20
> > +	size_t dev_chan_size, ams_chan_size, num_chan;
> > +	int ret, ch_cnt =3D 0, i, rising_off, falling_off;
> > +	unsigned int num_channels =3D 0;
> > +
>=20
> One blank line is almost always enough. Definitely is here.
>=20
> > +
> > +	num_chan =3D ARRAY_SIZE(ams_ps_channels) +
> ARRAY_SIZE(ams_pl_channels) +
> > +		ARRAY_SIZE(ams_ctrl_channels);
> > +
> > +	ams_chan_size =3D array_size(num_chan, sizeof(struct
> iio_chan_spec));
> > +	if (ams_chan_size =3D=3D SIZE_MAX)
> > +		return -EINVAL;
> > +
> > +	/* Initialize buffer for channel specification */
> > +	ams_channels =3D kcalloc(num_chan, sizeof(struct iio_chan_spec),
> GFP_KERNEL);
> > +	if (!ams_channels)
> > +		return -ENOMEM;
> > +
> > +	if (fwnode_device_is_available(fwnode)) {
> > +		ret =3D ams_init_module(indio_dev, fwnode, ams_channels);
> > +		if (ret < 0)
> > +			goto free_mem;
> > +
> > +		num_channels +=3D ret;
> > +	}
> > +
> > +	fwnode_for_each_child_node(fwnode, child) {
> > +		if (fwnode_device_is_available(child)) {
> > +			ret =3D ams_init_module(indio_dev, child,
> > +					      ams_channels + num_channels);
> > +			if (ret < 0) {
> > +				fwnode_handle_put(child);
> > +				goto free_mem;
> > +			}
> > +
> > +			num_channels +=3D ret;
> > +		}
> > +	}
> > +
> > +	for (i =3D 0; i < num_channels; i++) {
> > +		ams_channels[i].channel =3D ch_cnt++;
> > +
> > +		if (ams_channels[i].scan_index < AMS_CTRL_SEQ_BASE) {
> > +			/* set threshold to max and min for each channel */
> > +			falling_off =3D
> > +
> 	ams_get_alarm_offset(ams_channels[i].scan_index,
> > +						     IIO_EV_DIR_FALLING);
> > +			rising_off =3D
> > +
> 	ams_get_alarm_offset(ams_channels[i].scan_index,
> > +						     IIO_EV_DIR_RISING);
> > +			if (ams_channels[i].scan_index >=3D
> AMS_PS_SEQ_MAX) {
> > +				writel(AMS_ALARM_THR_MIN,
> > +				       ams->pl_base + falling_off);
> > +				writel(AMS_ALARM_THR_MAX,
> > +				       ams->pl_base + rising_off);
> > +			} else {
> > +				writel(AMS_ALARM_THR_MIN,
> > +				       ams->ps_base + falling_off);
> > +				writel(AMS_ALARM_THR_MAX,
> > +				       ams->ps_base + rising_off);
> > +			}
> > +		}
> > +	}
> > +
> > +	dev_chan_size =3D array_size((size_t)num_channels, sizeof(struct
> iio_chan_spec));
> > +	if (dev_chan_size =3D=3D SIZE_MAX)
>=20
> Why not goto free_mem for this error case?
> Obviously should never happen, but should handle the error anyway.

Correct. But I didn't realize that kcalloc has this check done internally.
So I will remove this in the next patch.

>=20
> > +		return -EINVAL;
> > +
> > +	dev_channels =3D devm_kcalloc(&pdev->dev, (size_t)num_channels,
> > +				    sizeof(struct iio_chan_spec), GFP_KERNEL);
> > +	if (!dev_channels) {
> > +		ret =3D -ENOMEM;
> > +		goto free_mem;
> > +	}
> > +
> > +	memcpy(dev_channels, ams_channels,
> > +	       sizeof(*ams_channels) * num_channels);
> > +	indio_dev->channels =3D dev_channels;
> > +	indio_dev->num_channels =3D num_channels;
> > +
> > +	ret =3D 0;
> > +
> > +free_mem:
> > +	kfree(ams_channels);
> > +
> > +	return ret;
> > +}
>=20

I agree with everything.
