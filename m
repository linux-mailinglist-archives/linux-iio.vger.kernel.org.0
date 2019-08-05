Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2572823DC
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 19:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfHERTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 13:19:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45193 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728797AbfHERTI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 13:19:08 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75H6gNG020199;
        Mon, 5 Aug 2019 19:18:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=5nNz4VUs15+cQ7emtehAXTZNWmDH8SvkYDFDH/UGX34=;
 b=tgYcw7n5zSOQuAz2cfBviulm7MSp8EGK4roXiRy7yz/zgIZdtlDI05Z7o7TEdBnOubGP
 xJULxyVoWcX3pUl00dtJGGxfj8rxt7nIUeFo7ch4t+9z3bTGG+2FD3tTUah/2VM/bQM9
 FYky8d5pjGienAtOAmKRyVSqZQa5sE0i2J0+1GDp9ldEYWd1yjZMQcI/fiFLr08IcIKI
 CjNZi79WhRjQPdNRbghsLPgpa1W0Q3BFOuiqSecnJJx79beW205FtgaxSQGMi+2L5HDu
 YAryYrnv1dT92wN53M34UIcMZ71CIgVaBhl2fsDkOirrqfzgoksww0zV8Tacx6vMtuGS CA== 
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56])
        by mx07-00178001.pphosted.com with ESMTP id 2u501uvj8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 19:18:57 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtmT8OyjzS1cKXllh8RZm3TOlN2UPr+Ma4tFA+yVm2RU5gZjXo6AUyr42GZd3VhQmwh3xVlNK1XaaA0KSICqUNZHuJjU596m+8hRvkJuV/ZkWM6BgfJX8H7hYQCVlubU05wFqdFq15WFvHe3E8APNn4zF2vpyUFMtlkqMaRBiovZR2w+KPvCGqIs2Y4dA+md6POYFBdbMCyi82mhgdwdAii3DPexiuLCdPYeAxJdQXG7nRTLp55qzXVpPeDZG75eF8u7c+6Nt0x8NMx9kBi8EFN8eOJXliioUuYlS9vbhMbip9DvexeJfD3COBmNdRry0aPEla4seQ4Cm2oyUqXnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nNz4VUs15+cQ7emtehAXTZNWmDH8SvkYDFDH/UGX34=;
 b=BdrAG3QFW7hFF+a1roWPwpHlfIfJQLvTBzQI41Gj9ig3pGuxS7W9SXUNVrHvgJ1lu3EnXOtDuK/bf766Vj8C7gs5aN5ZRj0hS0GGrce1d+rYHhxkA9dLjab90SPREzteWbf6/QKRy+SXUVhHTaHw4gnrO2tYbdWC/2jcLzCWfVIxHaRY+KW4/F4NWr9VyEaBQ6gZc4mAJcCfEgxXuH2Nj7MhRDZfIx15MP/HTDZoqz9sR9j900UTWC44IicusA3MNMBIEzsHWoqa7vez4tVDS6aTYixJMWkk068o1ak6rmivZuxjsH/8k9eIotFA1YWOkk/q/LRqKOiRHqy7qKdQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=st.com;dmarc=pass action=none header.from=st.com;dkim=pass
 header.d=st.com;arc=none
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM (10.255.28.79) by
 AM0PR10MB2979.EURPRD10.PROD.OUTLOOK.COM (10.255.29.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.12; Mon, 5 Aug 2019 17:18:54 +0000
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b]) by AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 17:18:53 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/5] iio:common: introduce
 st_sensors_buffer_preenable/predisable functions
Thread-Topic: [PATCH 1/5] iio:common: introduce
 st_sensors_buffer_preenable/predisable functions
Thread-Index: AQHVR+pRL8pOwf9aiEqTOPg2JOi81Kbl9ScAgAa99ICAAAPoAIAAHBzA
Date:   Mon, 5 Aug 2019 17:18:53 +0000
Message-ID: <AM0PR10MB2897352752FA3F5C6D673141EDDA0@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
References: <20190731215250.16403-1-denis.ciocca@st.com>
        <20190731215250.16403-2-denis.ciocca@st.com>
        <6939dc8b7c28b1f4ed00f33b5ed2cfde17b73d41.camel@analog.com>
        <20190805162135.68dc97c4@archlinux> <20190805163534.68c00bf3@archlinux>
In-Reply-To: <20190805163534.68c00bf3@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.34.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7f55cc8-5db0-4a7e-2084-08d719c8fdd8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR10MB2979;
x-ms-traffictypediagnostic: AM0PR10MB2979:
x-microsoft-antispam-prvs: <AM0PR10MB297984FA44A34C75A7883558EDDA0@AM0PR10MB2979.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(13464003)(199004)(52314003)(33656002)(256004)(6116002)(3846002)(14444005)(229853002)(7696005)(478600001)(6436002)(66556008)(8936002)(66446008)(66946007)(66476007)(64756008)(25786009)(316002)(186003)(76116006)(55016002)(86362001)(81156014)(81166006)(99286004)(71200400001)(71190400001)(5660300002)(68736007)(4326008)(2906002)(6246003)(52536014)(76176011)(9686003)(446003)(476003)(11346002)(7736002)(74316002)(66066001)(6506007)(486006)(55236004)(8676002)(110136005)(53546011)(14454004)(53936002)(102836004)(305945005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB2979;H:AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: st.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yYz9q4gG/wh4O+KiKyIWKKkWaNoDs/MG0TuF4/nJ9z9ya0HfcckwJEAmjnoGC/LIOEEvbDZKHJdoXOc6A2CHstKbbK9soEPn/0lHa5mFVB1Hadt8EY1fuL23Fc+COTKsMVcBQfFxiULLOsfxlQd9B/u2kPErUmrSoBGLsViMrWkBtxIMeUBl/RZHsUNTwbwWTGfcCNOzTGT3aSvF0P1Wc1phcbhZ4qlc1TSxHohC8T0y+YhWFVVd5DyTbY3hOjmlDLxEemHG9HhPJnOsF7nBAFiwp8lD3dbsWywgvtf+6BVBoUUz7KGENaJx4sn+inQxB2D99bKJkD5IQEW3CaAsLIDm1SzM1qO3ymlYGyohLCYwCvFxIPkqmHKZznvsu/oUQWmZmiBG3djgKiUz5P6Sek89pZhs4d2HUuCLmn3Z3Bs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f55cc8-5db0-4a7e-2084-08d719c8fdd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 17:18:53.8228
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: denis.ciocca@st.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2979
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050185
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Your solution seems to be more reasonable.
Not clear about the number of bytes anyway, I should check better but my wo=
rst case:
6 bytes for data (3 axis, 2 byte each) + 8 bytes timestamp =3D 14 bytes

Am I missing something?

Denis

> -----Original Message-----
> From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> Sent: Monday, August 5, 2019 8:36 AM
> To: Ardelean, Alexandru <alexandru.Ardelean@analog.com>
> Cc: Denis CIOCCA <denis.ciocca@st.com>; linux-iio@vger.kernel.org
> Subject: Re: [PATCH 1/5] iio:common: introduce
> st_sensors_buffer_preenable/predisable functions
>=20
> On Mon, 5 Aug 2019 16:21:35 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Thu, 1 Aug 2019 08:24:10 +0000
> > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >
> > > On Wed, 2019-07-31 at 14:52 -0700, Denis Ciocca wrote:
> > > > [External]
> > > >
> > > > This patch is introducing preenable/postdisable in the common
> > > > st_sensors_buffer code in order to remove the memory allocation /
> > > > de-allocation from each single st driver.
> > > >
> > >
> > > Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > >
> > > > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> >
> > As a rework, this is clearly reasonable, however, if we are going to
> > touch this code at all, there are a few things I would like to tidy up
> > about it.
> >
> > Firstly it's one of relatively few drivers that actually touch
> > scan_bytes in the first place.  That is supposed to be internal state
> > to the core subsystem and not used by drivers (see INTERN marking in
> iio.h).
> > It bled across the boundary in too many places where I wasn't looking.
> >
> > Secondly these allocations are small.  You would be better off just
> > making them part of the main state structure and not dynamically
> > allocated at all.
> >
> > So move buffer_data to the end of struct st_sensor_data and make it
> > whatever the maximum size needed is - I'm thinking probably 32 bytes
> > but haven't checked.
> Maths escapes me today, probably only 16 bytes as 3 channel devices mostl=
y
> 16 bits max + timestamp.
>=20
> J
> >
> > You call the bulk regmap API against it so you also need to ensure
> > it's in it's own cacheline.  Use the __cacheline_aligned magic to
> > enforce that.  The iio_priv region is always aligned appropriately to
> > allow iio_priv accessed structures to pull this trick.
> >
> > That way we don't need to do any memory handling on demand at all.
> > We may or many not save memory as will depend on exactly how big that
> > structure already is and what mood the allocator is in.
> >
> > I don't think I'm missing a reason we can't take the approach of
> > embedding the buffer and it definitely makes the code simpler.
> >
> > Thanks,
> >
> > Jonathan
> >
> >
> > > > ---
> > > >  .../iio/common/st_sensors/st_sensors_buffer.c | 22
> +++++++++++++++++++
> > > >  include/linux/iio/common/st_sensors.h         |  2 ++
> > > >  2 files changed, 24 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > > b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > > index eee30130ae23..9da1c8104883 100644
> > > > --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > > +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > > @@ -81,6 +81,28 @@ irqreturn_t st_sensors_trigger_handler(int irq,
> > > > void *p)  }  EXPORT_SYMBOL(st_sensors_trigger_handler);
> > > >
> > > > +int st_sensors_buffer_preenable(struct iio_dev *indio_dev) {
> > > > +	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > > > +
> > > > +	sdata->buffer_data =3D kmalloc(indio_dev->scan_bytes,
> > > > +				     GFP_DMA | GFP_KERNEL);
> > > > +	if (!sdata->buffer_data)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(st_sensors_buffer_preenable);
> > > > +
> > > > +int st_sensors_buffer_postdisable(struct iio_dev *indio_dev) {
> > > > +	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > > > +
> > > > +	kfree(sdata->buffer_data);
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(st_sensors_buffer_postdisable);
> > > > +
> > > >  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> > > > MODULE_DESCRIPTION("STMicroelectronics ST-sensors buffer");
> > > > MODULE_LICENSE("GPL v2"); diff --git
> > > > a/include/linux/iio/common/st_sensors.h
> > > > b/include/linux/iio/common/st_sensors.h
> > > > index 28fc1f9fa7d5..c66ebb236a15 100644
> > > > --- a/include/linux/iio/common/st_sensors.h
> > > > +++ b/include/linux/iio/common/st_sensors.h
> > > > @@ -254,6 +254,8 @@ struct st_sensor_data {
> > > >
> > > >  #ifdef CONFIG_IIO_BUFFER
> > > >  irqreturn_t st_sensors_trigger_handler(int irq, void *p);
> > > > +int st_sensors_buffer_preenable(struct iio_dev *indio_dev); int
> > > > +st_sensors_buffer_postdisable(struct iio_dev *indio_dev);
> > > >  #endif
> > > >
> > > >  #ifdef CONFIG_IIO_TRIGGER
> >

