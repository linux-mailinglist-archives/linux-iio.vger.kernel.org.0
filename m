Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8422C70A1B
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbfGVTxX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 15:53:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9660 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729271AbfGVTxW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 15:53:22 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MJpXPb003842;
        Mon, 22 Jul 2019 21:53:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=Dd4o5wLtFlikyMeVDamRhQmk1O7o0Ob7a2LTcV170Xk=;
 b=vAj1NTht8EsxAWZRqSqh5GU2+/BfTtr/2y64dJ+aX5olqtWOxM+4qgCYRS2aETefsVcT
 mxr8uRUs/436aJqnv0UOegCQWQ+iv21sFxLkf1T/LIKxUDn5iUYuifnSJoUhfutl8RMM
 4moUq8D7g3L/7fUles+CSCLfAb0Kt6wNFbFd+24tuOuBkA14+FBx4jH8yS0mUbLsgoxR
 9+uRaTd/lGaxondKak1tdljKWusJB3SE2qnw/uVwzmDbbwdfKHSCe89vzPzSX2jUzbq9
 l8oogQXtgOL/5GBaXnS1A7hbPXi6E1ONwX5FN9PoibrmDtDFM24QRF9qt18d5u35wBjq Vg== 
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2053.outbound.protection.outlook.com [104.47.2.53])
        by mx07-00178001.pphosted.com with ESMTP id 2ture1dd72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 21:53:15 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWbYTJgVCOu35/+53GCrfhpgWSnWTBHCfDJBSHUMZiif8thTp7Ilp6/vCkRhXYuFLRLZY00WAS+b1J4z685mWdhSOlatgyj4IKgr/9bp7KGdLFXnrd0wb+rXoo43O70MPlodZabhDUq3KOzKZOb6L9PlMC9UzOUFpY7nY5ptzv/i7GCt+BHvoMOapaNhfF8WuKSaaLoyc2ZmTa6IFCA8PRM0/ItH9WsNcyJBUDkIQbUxS1lGTsg6bQXEt3wVgNlHgPbDf7sHDPi/P5fvFjbf3Ot9uq8P1plAm1uzef1/51SszNSK21aXiiLVa8fGnA5gOe5v2aFR3wk0Pkh16ghbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd4o5wLtFlikyMeVDamRhQmk1O7o0Ob7a2LTcV170Xk=;
 b=OkOheK6Fm0R3yqln+sVjnY1Qwh/qtNIr9C7COtje4MUkH0iJQ7PDnvIpk/4m2X/s7KI+0zZIIgkaOLKNXRSwqfJnQqfTiSlQrn2xqnsSgQoWrSi15gGFU0riI0Kle9P60kRZRpeDfxn9vApo1woI99aBADppIwz+UOBqNH1Cy/y19BGJ66frgsmjzRn9t46Z73InWjJkRCSkaeS/XphTKJYy+SrVqycI7PFEpagxYkKyBnAg6hBbnNb8MGmc0FnX8fQwzl3KUHWr8YzAeWPDw3z2X/w/TgaUT+oz+290+n48aytACpNdAz9SVblpc2yr9M+fjv0B6j1Yp5esXVpYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=st.com;dmarc=pass action=none header.from=st.com;dkim=pass
 header.d=st.com;arc=none
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM (10.255.28.79) by
 AM0PR10MB1907.EURPRD10.PROD.OUTLOOK.COM (52.134.85.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 19:53:13 +0000
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b]) by AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 19:53:12 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v2 10/11] iio: move 3-wire spi initialization to
 st_sensors_spi
Thread-Topic: [PATCH v2 10/11] iio: move 3-wire spi initialization to
 st_sensors_spi
Thread-Index: AQHVPbvaWebUqeNNPE+WOK/hdmbec6bVYF4AgAABPoCAAbDNwA==
Date:   Mon, 22 Jul 2019 19:53:12 +0000
Message-ID: <AM0PR10MB2897829DA4339DAE8B28622BEDC40@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-11-denis.ciocca@st.com>
        <20190721185836.7063ba7b@archlinux> <20190721190303.3c61b867@archlinux>
In-Reply-To: <20190721190303.3c61b867@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.34.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fd3d0a8-6adc-458c-f720-08d70ede3ae3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR10MB1907;
x-ms-traffictypediagnostic: AM0PR10MB1907:
x-microsoft-antispam-prvs: <AM0PR10MB19076AFDF144A49359C88727EDC40@AM0PR10MB1907.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(13464003)(478600001)(76116006)(66946007)(25786009)(256004)(55236004)(74316002)(76176011)(64756008)(66446008)(66476007)(66556008)(476003)(446003)(11346002)(316002)(99286004)(486006)(53546011)(6506007)(8676002)(102836004)(7696005)(305945005)(7736002)(186003)(26005)(6916009)(52536014)(6436002)(55016002)(6116002)(2906002)(81156014)(81166006)(6246003)(33656002)(86362001)(8936002)(9686003)(30864003)(229853002)(66066001)(14444005)(5660300002)(71190400001)(71200400001)(4326008)(68736007)(53936002)(3846002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB1907;H:AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: st.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JG4u8scqzuzxBpF/0XHOaOMuQK7mCkHrVFyCUcrlZGB5nKAhu0ki3xOjHxu1buL0yyK9VM9yYm9/ZtwlXLYP5K1vMLDb61E2DFkbwphW3l8T6r+7at8tbefyMY8YUenWjqwvUejVfeFMhcHRtV3hNwaMVU7IZlcwMYx7biMLIlbFIlyRBcdv6du9+KOCwuzzocNPHnsW5ypS1BIcLZA7MaiVYcDqdTj2ZD/rrKzs3/I5cABGmlOz/sznCVzf6l3dhX/ba6KREDDO8r78PLYbwUjf18ApHF2TubtW/Jj9bKQhEo4vloMHvYGgqLn/LOX1Nrp7NaPR4n7O+ks6hHquO9R3JuZsN4TE7oPcT16KSFEDSvXdlecSjmzVl9ul5lZkFexP71PDwQ/nmuVB2NKsYpUMSlxGDY4QfpPbKOPUfww=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd3d0a8-6adc-458c-f720-08d70ede3ae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 19:53:12.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: denis.ciocca@st.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1907
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220217
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Comment inline

-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Sunday, July 21, 2019 11:03 AM
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 10/11] iio: move 3-wire spi initialization to st_sen=
sors_spi

On Sun, 21 Jul 2019 18:58:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 18 Jul 2019 15:53:52 -0700
> Denis Ciocca <denis.ciocca@st.com> wrote:
>=20
> > Some devices need to be configured with special bit in order to use=20
> > spi 3-wire. This was done during device identification phase.
> > Instead, let's move this part as spi specific.
> > Doing this the check_device_support function becomes a simple device=20
> > id check, so let's rename it.
> >=20
> > Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> A sensible solution so applied to the togreg branch of iio.git and=20
> pushed out as testing for the autobuilders to play with it.
Actually, your split between this patch and the next went wrong.
I've fixed up around line 651.

>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> > Changes in v2:
> >  not there in v1.
> >=20
> >  drivers/iio/accel/st_accel_core.c             |  4 +-
> >  drivers/iio/accel/st_accel_spi.c              |  4 +-
> >  .../iio/common/st_sensors/st_sensors_core.c   | 64 +++++-------------
> >  .../iio/common/st_sensors/st_sensors_spi.c    | 65 ++++++++++++++++++-
> >  drivers/iio/gyro/st_gyro_core.c               |  4 +-
> >  drivers/iio/gyro/st_gyro_spi.c                |  4 +-
> >  drivers/iio/magnetometer/st_magn_core.c       |  4 +-
> >  drivers/iio/magnetometer/st_magn_spi.c        |  4 +-
> >  drivers/iio/pressure/st_pressure_core.c       |  4 +-
> >  drivers/iio/pressure/st_pressure_spi.c        |  4 +-
> >  include/linux/iio/common/st_sensors.h         |  3 +-
> >  include/linux/iio/common/st_sensors_spi.h     |  4 +-
> >  12 files changed, 97 insertions(+), 71 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/st_accel_core.c=20
> > b/drivers/iio/accel/st_accel_core.c
> > index 6fc490ffef7e..630909702a19 100644
> > --- a/drivers/iio/accel/st_accel_core.c
> > +++ b/drivers/iio/accel/st_accel_core.c
> > @@ -1183,9 +1183,7 @@ int st_accel_common_probe(struct iio_dev *indio_d=
ev)
> >  	if (err)
> >  		return err;
> > =20
> > -	err =3D st_sensors_check_device_support(indio_dev,
> > -					ARRAY_SIZE(st_accel_sensors_settings),
> > -					st_accel_sensors_settings);
> > +	err =3D st_sensors_verify_id(indio_dev);
> >  	if (err < 0)
> >  		goto st_accel_power_off;
> > =20
> > diff --git a/drivers/iio/accel/st_accel_spi.c=20
> > b/drivers/iio/accel/st_accel_spi.c
> > index c0556db9d60a..8af7027d5598 100644
> > --- a/drivers/iio/accel/st_accel_spi.c
> > +++ b/drivers/iio/accel/st_accel_spi.c
> > @@ -124,7 +124,9 @@ static int st_accel_spi_probe(struct spi_device *sp=
i)
> >  	adata =3D iio_priv(indio_dev);
> >  	adata->sensor_settings =3D (struct st_sensor_settings *)settings;
> > =20
> > -	st_sensors_spi_configure(indio_dev, spi, adata);
> > +	err =3D st_sensors_spi_configure(indio_dev, spi);
> > +	if (err < 0)
> > +		return err;
> > =20
> >  	err =3D st_accel_common_probe(indio_dev);
> >  	if (err < 0)
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c=20
> > b/drivers/iio/common/st_sensors/st_sensors_core.c
> > index 3610ca9eaa87..40977d2ee400 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > @@ -608,31 +608,6 @@ int st_sensors_read_info_raw(struct iio_dev=20
> > *indio_dev,  }  EXPORT_SYMBOL(st_sensors_read_info_raw);
> > =20
> > -static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
> > -			const struct st_sensor_settings *sensor_settings)
> > -{
> > -	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > -	struct device_node *np =3D sdata->dev->of_node;
> > -	struct st_sensors_platform_data *pdata;
> > -
> > -	pdata =3D (struct st_sensors_platform_data *)sdata->dev->platform_dat=
a;
> > -	if (((np && of_property_read_bool(np, "spi-3wire")) ||
> > -	     (pdata && pdata->spi_3wire)) && sensor_settings->sim.addr) {
> > -		int err;
> > -
> > -		err =3D sdata->tf->write_byte(&sdata->tb, sdata->dev,
> > -					    sensor_settings->sim.addr,
> > -					    sensor_settings->sim.value);
> > -		if (err < 0) {
> > -			dev_err(&indio_dev->dev,
> > -				"failed to init interface mode\n");
> > -			return err;
> > -		}
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >  /*
> >   * st_sensors_get_settings_index() - get index of the sensor settings =
for a
> >   *				     specific device from list of settings
> > @@ -660,36 +635,30 @@ int st_sensors_get_settings_index(const char=20
> > *name,  }  EXPORT_SYMBOL(st_sensors_get_settings_index);
> > =20
> > -int st_sensors_check_device_support(struct iio_dev *indio_dev,
> > -			int num_sensors_list,
> > -			const struct st_sensor_settings *sensor_settings)
> > +/*
> > + * st_sensors_verify_id() - verify sensor ID (WhoAmI) is matching with=
 the
> > + *			    expected value
> > + * @indio_dev: IIO device reference.
> > + *
> > + * Return: 0 on success (valid sensor ID), else a negative error code.
> > + */
> > +int st_sensors_verify_id(struct iio_dev *indio_dev)
> >  {
> >  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > -	int i, err;
> > +	int err;
> >  	u8 wai;
> > =20
> > -	i =3D st_sensors_get_settings_index(indio_dev->name,
> > -					  sensor_settings, num_sensors_list);
> > -	if (i < 0) {
> > -		dev_err(&indio_dev->dev, "device name %s not recognized.\n",
> > -			indio_dev->name);
> > -		return i;
> > -	}
> > -
> > -	err =3D st_sensors_init_interface_mode(indio_dev, &sensor_settings[i]=
);
> > -	if (err < 0)
> > -		return err;
> > -
> > -	if (sensor_settings[i].wai_addr) {
> > +	if (settings->wai_addr) {
This 'settings' variable doesn't exist. Next patch uses
sdata->settings->wai_addr so I'm assuming that is correct choice here.


Your assumption was right. My bad during rebase!
Thanks,
Denis


Thanks,

Jonathan

> >  		err =3D sdata->tf->read_byte(&sdata->tb, sdata->dev,
> > -					   sensor_settings[i].wai_addr, &wai);
> > +					   sdata->sensor_settings->wai_addr,
> > +					   &wai);
> >  		if (err < 0) {
> >  			dev_err(&indio_dev->dev,
> >  				"failed to read Who-Am-I register.\n");
> >  			return err;
> >  		}
> > =20
> > -		if (sensor_settings[i].wai !=3D wai) {
> > +		if (sdata->sensor_settings->wai !=3D wai) {
> >  			dev_err(&indio_dev->dev,
> >  				"%s: WhoAmI mismatch (0x%x).\n",
> >  				indio_dev->name, wai);
> > @@ -697,12 +666,9 @@ int st_sensors_check_device_support(struct iio_dev=
 *indio_dev,
> >  		}
> >  	}
> > =20
> > -	sdata->sensor_settings =3D
> > -			(struct st_sensor_settings *)&sensor_settings[i];
> > -
> > -	return i;
> > +	return 0;
> >  }
> > -EXPORT_SYMBOL(st_sensors_check_device_support);
> > +EXPORT_SYMBOL(st_sensors_verify_id);
> > =20
> >  ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
> >  				struct device_attribute *attr, char *buf) diff --git=20
> > a/drivers/iio/common/st_sensors/st_sensors_spi.c=20
> > b/drivers/iio/common/st_sensors/st_sensors_spi.c
> > index 2213843f02cb..a57cd648975c 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> > @@ -102,9 +102,68 @@ static const struct st_sensor_transfer_function st=
_sensors_tf_spi =3D {
> >  	.read_multiple_byte =3D st_sensors_spi_read_multiple_byte,
> >  };
> > =20
> > -void st_sensors_spi_configure(struct iio_dev *indio_dev,
> > -			struct spi_device *spi, struct st_sensor_data *sdata)
> > +/*
> > + * st_sensors_is_spi_3_wire() - check if SPI 3-wire mode has been=20
> > +selected
> > + * @spi: spi device reference.
> > + *
> > + * Return: true if SPI 3-wire mode is selected, false otherwise.
> > + */
> > +static bool st_sensors_is_spi_3_wire(struct spi_device *spi) {
> > +	struct device_node *np =3D spi->dev.of_node;
> > +	struct st_sensors_platform_data *pdata;
> > +
> > +	pdata =3D (struct st_sensors_platform_data *)spi->dev.platform_data;
> > +	if ((np && of_property_read_bool(np, "spi-3wire")) ||
> > +	    (pdata && pdata->spi_3wire)) {
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/*
> > + * st_sensors_configure_spi_3_wire() - configure SPI 3-wire if=20
> > +needed
> > + * @spi: spi device reference.
> > + * @settings: sensor specific settings reference.
> > + *
> > + * Return: 0 on success, else a negative error code.
> > + */
> > +static int st_sensors_configure_spi_3_wire(struct spi_device *spi,
> > +					   struct st_sensor_settings *settings) {
> > +	if (settings->sim.addr) {
> > +		u8 buffer[] =3D {
> > +			settings->sim.addr,
> > +			settings->sim.value
> > +		};
> > +
> > +		return spi_write(spi, buffer, 2);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * st_sensors_spi_configure() - configure SPI interface
> > + * @indio_dev: IIO device reference.
> > + * @spi: spi device reference.
> > + *
> > + * Return: 0 on success, else a negative error code.
> > + */
> > +int st_sensors_spi_configure(struct iio_dev *indio_dev,
> > +			     struct spi_device *spi)
> >  {
> > +	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > +	int err;
> > +
> > +	if (st_sensors_is_spi_3_wire(spi)) {
> > +		err =3D st_sensors_configure_spi_3_wire(spi,
> > +						      sdata->sensor_settings);
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> >  	spi_set_drvdata(spi, indio_dev);
> > =20
> >  	indio_dev->dev.parent =3D &spi->dev; @@ -113,6 +172,8 @@ void=20
> > st_sensors_spi_configure(struct iio_dev *indio_dev,
> >  	sdata->dev =3D &spi->dev;
> >  	sdata->tf =3D &st_sensors_tf_spi;
> >  	sdata->get_irq_data_ready =3D st_sensors_spi_get_irq;
> > +
> > +	return 0;
> >  }
> >  EXPORT_SYMBOL(st_sensors_spi_configure);
> > =20
> > diff --git a/drivers/iio/gyro/st_gyro_core.c=20
> > b/drivers/iio/gyro/st_gyro_core.c index 5cc63d41d855..4b87e79aa744=20
> > 100644
> > --- a/drivers/iio/gyro/st_gyro_core.c
> > +++ b/drivers/iio/gyro/st_gyro_core.c
> > @@ -400,9 +400,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
> >  	if (err)
> >  		return err;
> > =20
> > -	err =3D st_sensors_check_device_support(indio_dev,
> > -					ARRAY_SIZE(st_gyro_sensors_settings),
> > -					st_gyro_sensors_settings);
> > +	err =3D st_sensors_verify_id(indio_dev);
> >  	if (err < 0)
> >  		goto st_gyro_power_off;
> > =20
> > diff --git a/drivers/iio/gyro/st_gyro_spi.c=20
> > b/drivers/iio/gyro/st_gyro_spi.c index bb7082055f85..b5c624251231=20
> > 100644
> > --- a/drivers/iio/gyro/st_gyro_spi.c
> > +++ b/drivers/iio/gyro/st_gyro_spi.c
> > @@ -91,7 +91,9 @@ static int st_gyro_spi_probe(struct spi_device *spi)
> >  	gdata =3D iio_priv(indio_dev);
> >  	gdata->sensor_settings =3D (struct st_sensor_settings *)settings;
> > =20
> > -	st_sensors_spi_configure(indio_dev, spi, gdata);
> > +	err =3D st_sensors_spi_configure(indio_dev, spi);
> > +	if (err < 0)
> > +		return err;
> > =20
> >  	err =3D st_gyro_common_probe(indio_dev);
> >  	if (err < 0)
> > diff --git a/drivers/iio/magnetometer/st_magn_core.c=20
> > b/drivers/iio/magnetometer/st_magn_core.c
> > index 43a49a52c81a..3f313aefece6 100644
> > --- a/drivers/iio/magnetometer/st_magn_core.c
> > +++ b/drivers/iio/magnetometer/st_magn_core.c
> > @@ -502,9 +502,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
> >  	if (err)
> >  		return err;
> > =20
> > -	err =3D st_sensors_check_device_support(indio_dev,
> > -					ARRAY_SIZE(st_magn_sensors_settings),
> > -					st_magn_sensors_settings);
> > +	err =3D st_sensors_verify_id(indio_dev);
> >  	if (err < 0)
> >  		goto st_magn_power_off;
> > =20
> > diff --git a/drivers/iio/magnetometer/st_magn_spi.c=20
> > b/drivers/iio/magnetometer/st_magn_spi.c
> > index a3045afc6b53..fbf909bde841 100644
> > --- a/drivers/iio/magnetometer/st_magn_spi.c
> > +++ b/drivers/iio/magnetometer/st_magn_spi.c
> > @@ -73,7 +73,9 @@ static int st_magn_spi_probe(struct spi_device *spi)
> >  	mdata =3D iio_priv(indio_dev);
> >  	mdata->sensor_settings =3D (struct st_sensor_settings *)settings;
> > =20
> > -	st_sensors_spi_configure(indio_dev, spi, mdata);
> > +	err =3D st_sensors_spi_configure(indio_dev, spi);
> > +	if (err < 0)
> > +		return err;
> > =20
> >  	err =3D st_magn_common_probe(indio_dev);
> >  	if (err < 0)
> > diff --git a/drivers/iio/pressure/st_pressure_core.c=20
> > b/drivers/iio/pressure/st_pressure_core.c
> > index 35d80ff27464..a783fc075c26 100644
> > --- a/drivers/iio/pressure/st_pressure_core.c
> > +++ b/drivers/iio/pressure/st_pressure_core.c
> > @@ -698,9 +698,7 @@ int st_press_common_probe(struct iio_dev *indio_dev=
)
> >  	if (err)
> >  		return err;
> > =20
> > -	err =3D st_sensors_check_device_support(indio_dev,
> > -					ARRAY_SIZE(st_press_sensors_settings),
> > -					st_press_sensors_settings);
> > +	err =3D st_sensors_verify_id(indio_dev);
> >  	if (err < 0)
> >  		goto st_press_power_off;
> > =20
> > diff --git a/drivers/iio/pressure/st_pressure_spi.c=20
> > b/drivers/iio/pressure/st_pressure_spi.c
> > index 3e8c1ffe001e..7c8b70221e70 100644
> > --- a/drivers/iio/pressure/st_pressure_spi.c
> > +++ b/drivers/iio/pressure/st_pressure_spi.c
> > @@ -83,7 +83,9 @@ static int st_press_spi_probe(struct spi_device *spi)
> >  	press_data =3D iio_priv(indio_dev);
> >  	press_data->sensor_settings =3D (struct st_sensor_settings=20
> > *)settings;
> > =20
> > -	st_sensors_spi_configure(indio_dev, spi, press_data);
> > +	err =3D st_sensors_spi_configure(indio_dev, spi);
> > +	if (err < 0)
> > +		return err;
> > =20
> >  	err =3D st_press_common_probe(indio_dev);
> >  	if (err < 0)
> > diff --git a/include/linux/iio/common/st_sensors.h=20
> > b/include/linux/iio/common/st_sensors.h
> > index 17fbf3e9b013..566b955e2980 100644
> > --- a/include/linux/iio/common/st_sensors.h
> > +++ b/include/linux/iio/common/st_sensors.h
> > @@ -338,8 +338,7 @@ int st_sensors_get_settings_index(const char *name,
> >  				  const struct st_sensor_settings *list,
> >  				  const int list_length);
> > =20
> > -int st_sensors_check_device_support(struct iio_dev *indio_dev,
> > -	int num_sensors_list, const struct st_sensor_settings *sensor_setting=
s);
> > +int st_sensors_verify_id(struct iio_dev *indio_dev);
> > =20
> >  ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
> >  				struct device_attribute *attr, char *buf); diff --git=20
> > a/include/linux/iio/common/st_sensors_spi.h=20
> > b/include/linux/iio/common/st_sensors_spi.h
> > index 6020f7167859..90b25f087f06 100644
> > --- a/include/linux/iio/common/st_sensors_spi.h
> > +++ b/include/linux/iio/common/st_sensors_spi.h
> > @@ -13,7 +13,7 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/iio/common/st_sensors.h>
> > =20
> > -void st_sensors_spi_configure(struct iio_dev *indio_dev,
> > -			struct spi_device *spi, struct st_sensor_data *sdata);
> > +int st_sensors_spi_configure(struct iio_dev *indio_dev,
> > +			     struct spi_device *spi);
> > =20
> >  #endif /* ST_SENSORS_SPI_H */
>=20

