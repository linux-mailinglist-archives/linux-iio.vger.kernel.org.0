Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8800D82420
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfHERk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 13:40:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:50929 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbfHERk2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Aug 2019 13:40:28 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x75HViHA006425;
        Mon, 5 Aug 2019 19:40:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Ky2UWzPiSTWMIj1v1yl88gIyMOTmH9pAa8LG7XSs8+E=;
 b=PceN1ppETRnaPyZGIGzW/O3LyE6bqqi2Dbzal/dOJGHYfsRlHeD1z+tHKwd14J526pXQ
 1p8Cssws7FWMu0TNmnoVaY1vW91uzbgGUNb6HHQEH/b4xITYFUXf2NncJ9fF6YWu9jaF
 QcMxShdQ29y77B/zLFhntQ6meXB5MO5V0q7hyxikUfiPleIVTWnIEzO+HtMdNYlaaXmE
 LNlXkU6GbRDYLQ7VK0Dudj/Qw5+u6AoviuRN66O/pi6yopnD7brCH87NhUofknx1+Sbw
 8dZkVdnvhxDN4FTNNK6+H+1fLyvjVns8VcI7bwDK2DNQgllHlM8CqJbOgj2AuMdDK2ef Sw== 
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55])
        by mx07-00178001.pphosted.com with ESMTP id 2u501uvm7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 19:40:17 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrt7S0XC+P9xE+MpkXFXxhFXZMuGtu7bGvWQ2DGmM2AA9zJaflwX83v5rcD3Yf0fsd1bVWkprvhgq8PBJU3kd+fJUcUZu7oZ69xBMIbUDIxkH/ZbyWX5BBUMwhz91pHYNOff2XFSmvcgdF/HNQNEc7G4OxNHkUi26/9awfc/Ig2Ja/7S5d7g93qBX62DM6jnuDBCovV+UOKmaxGTKL662n+EP1Cjm0L/Y0UheTdGluHUY4KrJUFTJ7eWIXYGGAQMNUXZsH/5uhIP9la9FOQ6AeztMCPJyFTlrH/LEpIzZJi2NCHPsIr6rJpcRJ5QLsfi73ck3Um7kOJjo8UrQvRYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky2UWzPiSTWMIj1v1yl88gIyMOTmH9pAa8LG7XSs8+E=;
 b=daVKW47x91jGlNRQ2KJzq7vZqS42EjFZGu3dYmquaA/KH5a0eZerUdeoTlhFlA8lS9QoA3URKkMHTkCFztmaGVEbE1w2zZ/dv5U4bJCjhSC6J/nWZ0niZDox1up6qQjVDf+h0gvwdsCuU7lSHGOsVlu65nSHAZ9wnmO7cLPg8Jxz+Fd+DFb2NKqC+HUKXYn9JAh83OTOCJS9jpc2yZq2g8k7+/bk1ZB1bTrq2eed03/xiCF23QaQ58Dc4Vx/SRjJ528DWEennbl4GrTQq2LMYYrX5PBiVW8kCV+tPhKzLmcmAMJvv50IoB/e9RBUXoFVdeYT04xiWJhCMZYHNvzJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=st.com;dmarc=pass action=none header.from=st.com;dkim=pass
 header.d=st.com;arc=none
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM (10.255.28.79) by
 AM0PR10MB3651.EURPRD10.PROD.OUTLOOK.COM (10.186.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Mon, 5 Aug 2019 17:40:16 +0000
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b]) by AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b%6]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 17:40:16 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/5] iio:common: introduce
 st_sensors_buffer_preenable/predisable functions
Thread-Topic: [PATCH 1/5] iio:common: introduce
 st_sensors_buffer_preenable/predisable functions
Thread-Index: AQHVR+pRL8pOwf9aiEqTOPg2JOi81Kbl9ScAgAa99ICAAAPoAIAAHBzAgAAGmPA=
Date:   Mon, 5 Aug 2019 17:40:16 +0000
Message-ID: <AM0PR10MB2897F9B35930C416F2381DF4EDDA0@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
References: <20190731215250.16403-1-denis.ciocca@st.com>
        <20190731215250.16403-2-denis.ciocca@st.com>
        <6939dc8b7c28b1f4ed00f33b5ed2cfde17b73d41.camel@analog.com>
        <20190805162135.68dc97c4@archlinux> <20190805163534.68c00bf3@archlinux>
 <AM0PR10MB2897352752FA3F5C6D673141EDDA0@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM0PR10MB2897352752FA3F5C6D673141EDDA0@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.34.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ab39c2d-a0e3-4b60-1a01-08d719cbfa3c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR10MB3651;
x-ms-traffictypediagnostic: AM0PR10MB3651:
x-microsoft-antispam-prvs: <AM0PR10MB3651249C31188B19C924E051EDDA0@AM0PR10MB3651.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(52314003)(189003)(13464003)(199004)(66446008)(64756008)(7696005)(2940100002)(14454004)(71190400001)(71200400001)(476003)(486006)(74316002)(11346002)(446003)(68736007)(86362001)(4326008)(316002)(478600001)(25786009)(6246003)(55236004)(6436002)(33656002)(305945005)(7736002)(26005)(76116006)(3846002)(9686003)(55016002)(110136005)(186003)(5660300002)(66946007)(6116002)(229853002)(66556008)(66476007)(53546011)(2906002)(66066001)(6506007)(53936002)(102836004)(52536014)(76176011)(81156014)(81166006)(8676002)(99286004)(14444005)(256004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB3651;H:AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: st.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zpRFYzZndnlF8tKN+iDBvcVyNcr/KbJVDos/X1gk5oIdIeiYW2Xwix1Cd9k8M8tmLDll4zJqeR5A/9aaoeABX9S7mQIJym7wVmQ/fwjzglyex8oQy75ZGHSkNnS2tPNgtNKP1QUsC9e/5HEW4Mv4GGPMWG8aEWGmbziqn95kTwIyjR4hRCqhvgyDFX+tZ9CXkgGVkP963W/ewFQmWHmQ/DVDASejtNDoGA/wXipUXkqd34LjPV0i6kdIcTqStzpymF5VdForBr73IGHiBZMgmcdk9AP5q/N0ofOFu6Czogd6DxkMuCzthZs/3Mv+q7GvKYHPx+EwXrvRR3jW7ZOKHXMcQWxiW0eEFmvlklaywn5TSv9YGnEsgx62Ah9DREYPvQo2/cLsN2vIt8mvPx+ScmUvw/s0CfG/0GKsrOaoVWg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab39c2d-a0e3-4b60-1a01-08d719cbfa3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 17:40:16.2433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: denis.ciocca@st.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3651
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050186
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ok stupid question, you were considering the align already.

Denis


> -----Original Message-----
> From: Denis CIOCCA
> Sent: Monday, August 5, 2019 10:19 AM
> To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Cc: linux-iio@vger.kernel.org
> Subject: RE: [PATCH 1/5] iio:common: introduce
> st_sensors_buffer_preenable/predisable functions
>=20
> Hi Jonathan,
>=20
> Your solution seems to be more reasonable.
> Not clear about the number of bytes anyway, I should check better but my
> worst case:
> 6 bytes for data (3 axis, 2 byte each) + 8 bytes timestamp =3D 14 bytes
>=20
> Am I missing something?
>=20
> Denis
>=20
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> > Sent: Monday, August 5, 2019 8:36 AM
> > To: Ardelean, Alexandru <alexandru.Ardelean@analog.com>
> > Cc: Denis CIOCCA <denis.ciocca@st.com>; linux-iio@vger.kernel.org
> > Subject: Re: [PATCH 1/5] iio:common: introduce
> > st_sensors_buffer_preenable/predisable functions
> >
> > On Mon, 5 Aug 2019 16:21:35 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > > On Thu, 1 Aug 2019 08:24:10 +0000
> > > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> > >
> > > > On Wed, 2019-07-31 at 14:52 -0700, Denis Ciocca wrote:
> > > > > [External]
> > > > >
> > > > > This patch is introducing preenable/postdisable in the common
> > > > > st_sensors_buffer code in order to remove the memory allocation
> > > > > / de-allocation from each single st driver.
> > > > >
> > > >
> > > > Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > > >
> > > > > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> > >
> > > As a rework, this is clearly reasonable, however, if we are going to
> > > touch this code at all, there are a few things I would like to tidy
> > > up about it.
> > >
> > > Firstly it's one of relatively few drivers that actually touch
> > > scan_bytes in the first place.  That is supposed to be internal
> > > state to the core subsystem and not used by drivers (see INTERN
> > > marking in
> > iio.h).
> > > It bled across the boundary in too many places where I wasn't looking=
.
> > >
> > > Secondly these allocations are small.  You would be better off just
> > > making them part of the main state structure and not dynamically
> > > allocated at all.
> > >
> > > So move buffer_data to the end of struct st_sensor_data and make it
> > > whatever the maximum size needed is - I'm thinking probably 32 bytes
> > > but haven't checked.
> > Maths escapes me today, probably only 16 bytes as 3 channel devices
> > mostly
> > 16 bits max + timestamp.
> >
> > J
> > >
> > > You call the bulk regmap API against it so you also need to ensure
> > > it's in it's own cacheline.  Use the __cacheline_aligned magic to
> > > enforce that.  The iio_priv region is always aligned appropriately
> > > to allow iio_priv accessed structures to pull this trick.
> > >
> > > That way we don't need to do any memory handling on demand at all.
> > > We may or many not save memory as will depend on exactly how big
> > > that structure already is and what mood the allocator is in.
> > >
> > > I don't think I'm missing a reason we can't take the approach of
> > > embedding the buffer and it definitely makes the code simpler.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > >
> > > > > ---
> > > > >  .../iio/common/st_sensors/st_sensors_buffer.c | 22
> > +++++++++++++++++++
> > > > >  include/linux/iio/common/st_sensors.h         |  2 ++
> > > > >  2 files changed, 24 insertions(+)
> > > > >
> > > > > diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > > > b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > > > index eee30130ae23..9da1c8104883 100644
> > > > > --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > > > +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> > > > > @@ -81,6 +81,28 @@ irqreturn_t st_sensors_trigger_handler(int
> > > > > irq, void *p)  }  EXPORT_SYMBOL(st_sensors_trigger_handler);
> > > > >
> > > > > +int st_sensors_buffer_preenable(struct iio_dev *indio_dev) {
> > > > > +	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > > > > +
> > > > > +	sdata->buffer_data =3D kmalloc(indio_dev->scan_bytes,
> > > > > +				     GFP_DMA | GFP_KERNEL);
> > > > > +	if (!sdata->buffer_data)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(st_sensors_buffer_preenable);
> > > > > +
> > > > > +int st_sensors_buffer_postdisable(struct iio_dev *indio_dev) {
> > > > > +	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > > > > +
> > > > > +	kfree(sdata->buffer_data);
> > > > > +	return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(st_sensors_buffer_postdisable);
> > > > > +
> > > > >  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> > > > > MODULE_DESCRIPTION("STMicroelectronics ST-sensors buffer");
> > > > > MODULE_LICENSE("GPL v2"); diff --git
> > > > > a/include/linux/iio/common/st_sensors.h
> > > > > b/include/linux/iio/common/st_sensors.h
> > > > > index 28fc1f9fa7d5..c66ebb236a15 100644
> > > > > --- a/include/linux/iio/common/st_sensors.h
> > > > > +++ b/include/linux/iio/common/st_sensors.h
> > > > > @@ -254,6 +254,8 @@ struct st_sensor_data {
> > > > >
> > > > >  #ifdef CONFIG_IIO_BUFFER
> > > > >  irqreturn_t st_sensors_trigger_handler(int irq, void *p);
> > > > > +int st_sensors_buffer_preenable(struct iio_dev *indio_dev); int
> > > > > +st_sensors_buffer_postdisable(struct iio_dev *indio_dev);
> > > > >  #endif
> > > > >
> > > > >  #ifdef CONFIG_IIO_TRIGGER
> > >

