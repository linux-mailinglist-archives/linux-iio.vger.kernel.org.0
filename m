Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4851D70A2A
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2019 21:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfGVTyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jul 2019 15:54:03 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15982 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728062AbfGVTyD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2019 15:54:03 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MJopKl029851;
        Mon, 22 Jul 2019 21:53:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=LFuFCYKXKcacWfL2owtNwq6RHtDjf6tb/JgrPYMZyPA=;
 b=npLPx3EPTUSt9N+QpHwqGtckvcGoM0Sx4sqvRntW7KWoBdN8+ah2Qo/RJA9JYVLtdorG
 HwPll+PSYyTdWl+U5EpUFkyAcuz11X4CNr1iGaauKGpdKqEw/km8aZcLl+TEOIOUzpvC
 8gX+O+uM6Y0CFDuGg+oJB6XyYCDO3k71PoyXGsFMY0LnlORA6yS8nWS8XnvQaVLFxvQv
 DSTNWB6mEkQnEgRNiOsxqHK7O0J6fhPIV1b7TSdfxbCdNe03+1LGfStIaE6sDFBDTVHU
 nSKqozgAK3Q/pmILBI+Z824/cXRCuZRekGdKwMZScynQlCNVaB2zo1ZOiE2K4ApwSm+Q uw== 
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51])
        by mx08-00178001.pphosted.com with ESMTP id 2tur39djdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 21:53:56 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5/dc9YW3AOMDkBY7Kyuk191GF9dm/G1YlkOrS4cGSJskl04KvK+/r+Oa1/0odeEFdBgj19LmBBIY7zoh1vCxgMjyJd0Gcg1imnv62WvvzjTGJxCFS1w8bOVx3BLArnOjERxbuNPdKsbr1b+kCzRi84JoHhKIE6H6vm4MGJhfFEZn4uuHC/RAXm+1ETeAOhAfp8LGeoFl6dXqiHoP5zHLmATjKS0JEvicpWD4mV16xud55W0kNeaIjtYURtY1PyOgFGYGnlVMbsYaNb6f+8VHaMJEUywdQIR/qZ0ScXv1LC2W1/u/4/+EKOoTBVWHPNmubAZSKNNeiZpgxD9Y9O3rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFuFCYKXKcacWfL2owtNwq6RHtDjf6tb/JgrPYMZyPA=;
 b=fxZ2wcHMeVx1OP2he6fQnt0KFtUgR1f3L68XMGXs1L5OuEDnGPHFPYu5upzhWr8lNzG5xaXRY6ORhQfSezScfMpx9ZGv8bVj38/lj/RHe1wrhs2U5ubu6DU+xeX8yaV8LTISiDH+HRBkamJ1Hb24WodUU4ECieSUFceA1kE6a/y/zT68jjf/N/DDkj7SfmGPiH3lAhcCrv9i+XThKD9OCdfL0Q6tWMQpXhhSOxJ2/eT9qdJbScFZkP78b+qkk+HRBw5iXQEKdnnnQTglAi5hOCmpF5RnTkrkw2gYUt7WMeuwv0zH7U2Zqg9MPn1KH7Mo4tbvMgT2JFQOFIyofnMy6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=st.com;dmarc=pass action=none header.from=st.com;dkim=pass
 header.d=st.com;arc=none
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM (10.255.28.79) by
 AM0PR10MB1907.EURPRD10.PROD.OUTLOOK.COM (52.134.85.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 19:53:54 +0000
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b]) by AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d1b5:b9a3:30f6:c95b%6]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 19:53:54 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v2 11/11] iio: make st_sensors drivers use regmap
Thread-Topic: [PATCH v2 11/11] iio: make st_sensors drivers use regmap
Thread-Index: AQHVPbvfsPwK2yip5kyDDK+//Qohb6bVYloAgAGvoRA=
Date:   Mon, 22 Jul 2019 19:53:54 +0000
Message-ID: <AM0PR10MB2897F7F4743391B297C55094EDC40@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
References: <20190718225353.2078-1-denis.ciocca@st.com>
        <20190718225353.2078-12-denis.ciocca@st.com>
 <20190721190542.6414682c@archlinux>
In-Reply-To: <20190721190542.6414682c@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.34.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7540fb2e-8f0e-4ee3-d12a-08d70ede5375
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR10MB1907;
x-ms-traffictypediagnostic: AM0PR10MB1907:
x-microsoft-antispam-prvs: <AM0PR10MB190784423A769080AE72C075EDC40@AM0PR10MB1907.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(13464003)(478600001)(76116006)(66946007)(25786009)(256004)(55236004)(74316002)(76176011)(64756008)(66446008)(66476007)(66556008)(476003)(446003)(11346002)(316002)(99286004)(486006)(53546011)(6506007)(8676002)(102836004)(7696005)(305945005)(7736002)(186003)(26005)(6916009)(52536014)(6436002)(55016002)(6116002)(2906002)(81156014)(81166006)(6246003)(33656002)(86362001)(8936002)(9686003)(30864003)(229853002)(66066001)(53946003)(14444005)(5660300002)(71190400001)(71200400001)(4326008)(68736007)(53936002)(3846002)(14454004)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB1907;H:AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: st.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +eawfEA5M2UJ9YDaC2CXnw8BrtxYyM2nH4zrHICxhaxteCHz33dPCIxvhENhntN+pNH0RtqUpE4+s195gHKgl9jSccLZOOLWJn9J+TMxFWKmmFqUOiVYHq0DOUu7bdp0btuKHSQoAQDrNHtpNgQ1L/EqomEGZnF62acgQPwCN1jSlLIueskTpNdAao2L47MhJ8xYBwV3cy7Vxj3L0o1LREvrZWEJk/Jk/yA6DCxTKm4wVkQyJfrmZdV/YGntkNfyR/HhBxGlTPrYSPRVvO0s3W0c3ib5tCGh2F8fybwl51lzYfHi+vtqunM+pgr2rr0Di+J0DAaf5I7oIqWuooeOAl58qxqiuTrUntpyYPSe6cdpmdl1/BbYsMwLVWcmXaLto/EN/EsfHFwmvgVgmO0Jp0RWGnNhKTgSm9o7p3qf+u0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7540fb2e-8f0e-4ee3-d12a-08d70ede5375
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 19:53:54.0973
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

Just checked testing branch and it looks good to me.
Thanks!

Denis


-----Original Message-----
From: Jonathan Cameron <jic23@kernel.org>=20
Sent: Sunday, July 21, 2019 11:06 AM
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 11/11] iio: make st_sensors drivers use regmap

On Thu, 18 Jul 2019 15:53:53 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This patch is meant to replace the i2c/spi transfer functions with=20
> regmap. SPI framework requires DMA safe buffers so let's add GFP_DMA=20
> flag for memory allocation used by bulk_read functions.
>=20
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>

Applied, with the appropriate fuzz fixing form the fixup I applied to patch=
 10.  Please take a look and make sure I didn't mess this up.


Thanks,

Jonathan

> ---
> Changes in v2:
>  memory allocation uses GFP_DMA if buffer is used in bulk_read  fix=20
> struct fields doc
>=20
>  drivers/iio/accel/st_accel_buffer.c           |   3 +-
>  drivers/iio/accel/st_accel_core.c             |   3 -
>  drivers/iio/accel/st_accel_i2c.c              |   4 +-
>  .../iio/common/st_sensors/st_sensors_buffer.c |  10 +-
>  .../iio/common/st_sensors/st_sensors_core.c   |  41 +++----
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  73 ++++++-------
>  .../iio/common/st_sensors/st_sensors_spi.c    | 100 ++++--------------
>  .../common/st_sensors/st_sensors_trigger.c    |  10 +-
>  drivers/iio/gyro/st_gyro_buffer.c             |   3 +-
>  drivers/iio/gyro/st_gyro_core.c               |   3 -
>  drivers/iio/gyro/st_gyro_i2c.c                |   4 +-
>  drivers/iio/magnetometer/st_magn_buffer.c     |   3 +-
>  drivers/iio/magnetometer/st_magn_core.c       |   3 -
>  drivers/iio/magnetometer/st_magn_i2c.c        |   4 +-
>  drivers/iio/pressure/st_pressure_buffer.c     |   3 +-
>  drivers/iio/pressure/st_pressure_core.c       |   3 -
>  drivers/iio/pressure/st_pressure_i2c.c        |   4 +-
>  include/linux/iio/common/st_sensors.h         |  40 +------
>  include/linux/iio/common/st_sensors_i2c.h     |   4 +-
>  19 files changed, 105 insertions(+), 213 deletions(-)
>=20
> diff --git a/drivers/iio/accel/st_accel_buffer.c=20
> b/drivers/iio/accel/st_accel_buffer.c
> index 0205c0167cdd..05f9aea431e2 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -39,7 +39,8 @@ static int st_accel_buffer_postenable(struct iio_dev *i=
ndio_dev)
>  	int err;
>  	struct st_sensor_data *adata =3D iio_priv(indio_dev);
> =20
> -	adata->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	adata->buffer_data =3D kmalloc(indio_dev->scan_bytes,
> +				     GFP_DMA | GFP_KERNEL);
>  	if (adata->buffer_data =3D=3D NULL) {
>  		err =3D -ENOMEM;
>  		goto allocate_memory_error;
> diff --git a/drivers/iio/accel/st_accel_core.c=20
> b/drivers/iio/accel/st_accel_core.c
> index 630909702a19..0b17004cb12e 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -13,7 +13,6 @@
>  #include <linux/acpi.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> -#include <linux/mutex.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> @@ -1177,7 +1176,6 @@ int st_accel_common_probe(struct iio_dev=20
> *indio_dev)
> =20
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>  	indio_dev->info =3D &accel_info;
> -	mutex_init(&adata->tb.buf_lock);
> =20
>  	err =3D st_sensors_power_enable(indio_dev);
>  	if (err)
> @@ -1188,7 +1186,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev=
)
>  		goto st_accel_power_off;
> =20
>  	adata->num_data_channels =3D ST_ACCEL_NUMBER_DATA_CHANNELS;
> -	adata->multiread_bit =3D adata->sensor_settings->multi_read_bit;
>  	indio_dev->num_channels =3D ST_SENSORS_NUMBER_ALL_CHANNELS;
> =20
>  	channels_size =3D indio_dev->num_channels * sizeof(struct=20
> iio_chan_spec); diff --git a/drivers/iio/accel/st_accel_i2c.c=20
> b/drivers/iio/accel/st_accel_i2c.c
> index a92cf776031e..50fa0fc32baa 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -174,7 +174,9 @@ static int st_accel_i2c_probe(struct i2c_client *clie=
nt)
>  	adata =3D iio_priv(indio_dev);
>  	adata->sensor_settings =3D (struct st_sensor_settings *)settings;
> =20
> -	st_sensors_i2c_configure(indio_dev, client, adata);
> +	ret =3D st_sensors_i2c_configure(indio_dev, client);
> +	if (ret < 0)
> +		return ret;
> =20
>  	ret =3D st_accel_common_probe(indio_dev);
>  	if (ret < 0)
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c=20
> b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 4a68669dc555..eee30130ae23 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -17,15 +17,16 @@
>  #include <linux/iio/trigger_consumer.h>  #include=20
> <linux/iio/triggered_buffer.h>  #include <linux/irqreturn.h>
> +#include <linux/regmap.h>
> =20
>  #include <linux/iio/common/st_sensors.h>
> =20
> =20
>  static int st_sensors_get_buffer_element(struct iio_dev *indio_dev,=20
> u8 *buf)  {
> -	int i;
>  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
>  	unsigned int num_data_channels =3D sdata->num_data_channels;
> +	int i;
> =20
>  	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
>  		const struct iio_chan_spec *channel =3D &indio_dev->channels[i]; @@=20
> -36,11 +37,8 @@ static int st_sensors_get_buffer_element(struct iio_dev *=
indio_dev, u8 *buf)
>  			channel->scan_type.storagebits >> 3;
> =20
>  		buf =3D PTR_ALIGN(buf, storage_bytes);
> -		if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> -						  channel->address,
> -						  bytes_to_read, buf,
> -						  sdata->multiread_bit) <
> -		    bytes_to_read)
> +		if (regmap_bulk_read(sdata->regmap, channel->address,
> +				     buf, bytes_to_read) < 0)
>  			return -EIO;
> =20
>  		/* Advance the buffer pointer */
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c=20
> b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 40977d2ee400..4a3064fb6cd9 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/regulator/consumer.h>  #include <linux/of.h> =20
> #include <linux/of_device.h>
> +#include <linux/regmap.h>
>  #include <asm/unaligned.h>
>  #include <linux/iio/common/st_sensors.h>
> =20
> @@ -28,19 +29,10 @@ static inline u32=20
> st_sensors_get_unaligned_le24(const u8 *p)  int st_sensors_write_data_wit=
h_mask(struct iio_dev *indio_dev,
>  				    u8 reg_addr, u8 mask, u8 data)  {
> -	int err;
> -	u8 new_data;
>  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> =20
> -	err =3D sdata->tf->read_byte(&sdata->tb, sdata->dev, reg_addr, &new_dat=
a);
> -	if (err < 0)
> -		goto st_sensors_write_data_with_mask_error;
> -
> -	new_data =3D ((new_data & (~mask)) | ((data << __ffs(mask)) & mask));
> -	err =3D sdata->tf->write_byte(&sdata->tb, sdata->dev, reg_addr, new_dat=
a);
> -
> -st_sensors_write_data_with_mask_error:
> -	return err;
> +	return regmap_update_bits(sdata->regmap,
> +				  reg_addr, mask, data << __ffs(mask));
>  }
> =20
>  int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev, @@=20
> -48,19 +40,15 @@ int st_sensors_debugfs_reg_access(struct iio_dev *indio_=
dev,
>  				  unsigned *readval)
>  {
>  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> -	u8 readdata;
>  	int err;
> =20
>  	if (!readval)
> -		return sdata->tf->write_byte(&sdata->tb, sdata->dev,
> -					     (u8)reg, (u8)writeval);
> +		return regmap_write(sdata->regmap, reg, writeval);
> =20
> -	err =3D sdata->tf->read_byte(&sdata->tb, sdata->dev, (u8)reg, &readdata=
);
> +	err =3D regmap_read(sdata->regmap, reg, readval);
>  	if (err < 0)
>  		return err;
> =20
> -	*readval =3D (unsigned)readdata;
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL(st_sensors_debugfs_reg_access);
> @@ -545,7 +533,7 @@ int st_sensors_set_fullscale_by_gain(struct=20
> iio_dev *indio_dev, int scale) =20
> EXPORT_SYMBOL(st_sensors_set_fullscale_by_gain);
> =20
>  static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
> -				struct iio_chan_spec const *ch, int *data)
> +				     struct iio_chan_spec const *ch, int *data)
>  {
>  	int err;
>  	u8 *outdata;
> @@ -554,13 +542,12 @@ static int st_sensors_read_axis_data(struct=20
> iio_dev *indio_dev,
> =20
>  	byte_for_channel =3D DIV_ROUND_UP(ch->scan_type.realbits +
>  					ch->scan_type.shift, 8);
> -	outdata =3D kmalloc(byte_for_channel, GFP_KERNEL);
> +	outdata =3D kmalloc(byte_for_channel, GFP_DMA | GFP_KERNEL);
>  	if (!outdata)
>  		return -ENOMEM;
> =20
> -	err =3D sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> -				ch->address, byte_for_channel,
> -				outdata, sdata->multiread_bit);
> +	err =3D regmap_bulk_read(sdata->regmap, ch->address,
> +			       outdata, byte_for_channel);
>  	if (err < 0)
>  		goto st_sensors_free_memory;
> =20
> @@ -645,13 +632,11 @@ EXPORT_SYMBOL(st_sensors_get_settings_index);
>  int st_sensors_verify_id(struct iio_dev *indio_dev)  {
>  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> -	int err;
> -	u8 wai;
> +	int wai, err;
> =20
> -	if (settings->wai_addr) {
> -		err =3D sdata->tf->read_byte(&sdata->tb, sdata->dev,
> -					   sdata->sensor_settings->wai_addr,
> -					   &wai);
> +	if (sdata->sensor_settings->wai_addr) {
> +		err =3D regmap_read(sdata->regmap,
> +				  sdata->sensor_settings->wai_addr, &wai);
>  		if (err < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to read Who-Am-I register.\n"); diff --git=20
> a/drivers/iio/common/st_sensors/st_sensors_i2c.c=20
> b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index b1c9812407e7..9240625534df 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -13,6 +13,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/of_device.h>
>  #include <linux/acpi.h>
> +#include <linux/regmap.h>
> =20
>  #include <linux/iio/common/st_sensors_i2c.h>
> =20
> @@ -26,55 +27,51 @@ static unsigned int st_sensors_i2c_get_irq(struct iio=
_dev *indio_dev)
>  	return to_i2c_client(sdata->dev)->irq;  }
> =20
> -static int st_sensors_i2c_read_byte(struct st_sensor_transfer_buffer *tb=
,
> -				struct device *dev, u8 reg_addr, u8 *res_byte)
> -{
> -	int err;
> -
> -	err =3D i2c_smbus_read_byte_data(to_i2c_client(dev), reg_addr);
> -	if (err < 0)
> -		goto st_accel_i2c_read_byte_error;
> -
> -	*res_byte =3D err & 0xff;
> -
> -st_accel_i2c_read_byte_error:
> -	return err < 0 ? err : 0;
> -}
> -
> -static int st_sensors_i2c_read_multiple_byte(
> -		struct st_sensor_transfer_buffer *tb, struct device *dev,
> -			u8 reg_addr, int len, u8 *data, bool multiread_bit)
> -{
> -	if (multiread_bit)
> -		reg_addr |=3D ST_SENSORS_I2C_MULTIREAD;
> -
> -	return i2c_smbus_read_i2c_block_data_or_emulated(to_i2c_client(dev),
> -							 reg_addr, len, data);
> -}
> -
> -static int st_sensors_i2c_write_byte(struct st_sensor_transfer_buffer *t=
b,
> -				struct device *dev, u8 reg_addr, u8 data)
> -{
> -	return i2c_smbus_write_byte_data(to_i2c_client(dev), reg_addr, data);
> -}
> +static const struct regmap_config st_sensors_i2c_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> =20
> -static const struct st_sensor_transfer_function st_sensors_tf_i2c =3D {
> -	.read_byte =3D st_sensors_i2c_read_byte,
> -	.write_byte =3D st_sensors_i2c_write_byte,
> -	.read_multiple_byte =3D st_sensors_i2c_read_multiple_byte,
> +static const struct regmap_config st_sensors_i2c_regmap_multiread_bit_co=
nfig =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.read_flag_mask =3D ST_SENSORS_I2C_MULTIREAD,
>  };
> =20
> -void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> -		struct i2c_client *client, struct st_sensor_data *sdata)
> +/*
> + * st_sensors_i2c_configure() - configure I2C interface
> + * @indio_dev: IIO device reference.
> + * @client: i2c client reference.
> + *
> + * Return: 0 on success, else a negative error code.
> + */
> +int st_sensors_i2c_configure(struct iio_dev *indio_dev,
> +			     struct i2c_client *client)
>  {
> +	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> +	const struct regmap_config *config;
> +
> +	if (sdata->sensor_settings->multi_read_bit)
> +		config =3D &st_sensors_i2c_regmap_multiread_bit_config;
> +	else
> +		config =3D &st_sensors_i2c_regmap_config;
> +
> +	sdata->regmap =3D devm_regmap_init_i2c(client, config);
> +	if (IS_ERR(sdata->regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap (%d)\n",
> +			(int)PTR_ERR(sdata->regmap));
> +		return PTR_ERR(sdata->regmap);
> +	}
> +
>  	i2c_set_clientdata(client, indio_dev);
> =20
>  	indio_dev->dev.parent =3D &client->dev;
>  	indio_dev->name =3D client->name;
> =20
>  	sdata->dev =3D &client->dev;
> -	sdata->tf =3D &st_sensors_tf_i2c;
>  	sdata->get_irq_data_ready =3D st_sensors_i2c_get_irq;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(st_sensors_i2c_configure);
> =20
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c=20
> b/drivers/iio/common/st_sensors/st_sensors_spi.c
> index a57cd648975c..9c0661a283d0 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -11,12 +11,12 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/iio/iio.h>
> +#include <linux/regmap.h>
> =20
>  #include <linux/iio/common/st_sensors_spi.h>
> -
> +#include "st_sensors_core.h"
> =20
>  #define ST_SENSORS_SPI_MULTIREAD	0xc0
> -#define ST_SENSORS_SPI_READ		0x80
> =20
>  static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev) =20
> { @@ -25,81 +25,15 @@ static unsigned int=20
> st_sensors_spi_get_irq(struct iio_dev *indio_dev)
>  	return to_spi_device(sdata->dev)->irq;  }
> =20
> -static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
> -	struct device *dev, u8 reg_addr, int len, u8 *data, bool multiread_bit)
> -{
> -	int err;
> -
> -	struct spi_transfer xfers[] =3D {
> -		{
> -			.tx_buf =3D tb->tx_buf,
> -			.bits_per_word =3D 8,
> -			.len =3D 1,
> -		},
> -		{
> -			.rx_buf =3D tb->rx_buf,
> -			.bits_per_word =3D 8,
> -			.len =3D len,
> -		}
> -	};
> -
> -	mutex_lock(&tb->buf_lock);
> -	if ((multiread_bit) && (len > 1))
> -		tb->tx_buf[0] =3D reg_addr | ST_SENSORS_SPI_MULTIREAD;
> -	else
> -		tb->tx_buf[0] =3D reg_addr | ST_SENSORS_SPI_READ;
> -
> -	err =3D spi_sync_transfer(to_spi_device(dev), xfers, ARRAY_SIZE(xfers))=
;
> -	if (err)
> -		goto acc_spi_read_error;
> -
> -	memcpy(data, tb->rx_buf, len);
> -	mutex_unlock(&tb->buf_lock);
> -	return len;
> -
> -acc_spi_read_error:
> -	mutex_unlock(&tb->buf_lock);
> -	return err;
> -}
> -
> -static int st_sensors_spi_read_byte(struct st_sensor_transfer_buffer *tb=
,
> -				struct device *dev, u8 reg_addr, u8 *res_byte)
> -{
> -	return st_sensors_spi_read(tb, dev, reg_addr, 1, res_byte, false);
> -}
> -
> -static int st_sensors_spi_read_multiple_byte(
> -	struct st_sensor_transfer_buffer *tb, struct device *dev,
> -			u8 reg_addr, int len, u8 *data, bool multiread_bit)
> -{
> -	return st_sensors_spi_read(tb, dev, reg_addr, len, data, multiread_bit)=
;
> -}
> -
> -static int st_sensors_spi_write_byte(struct st_sensor_transfer_buffer *t=
b,
> -				struct device *dev, u8 reg_addr, u8 data)
> -{
> -	int err;
> -
> -	struct spi_transfer xfers =3D {
> -		.tx_buf =3D tb->tx_buf,
> -		.bits_per_word =3D 8,
> -		.len =3D 2,
> -	};
> -
> -	mutex_lock(&tb->buf_lock);
> -	tb->tx_buf[0] =3D reg_addr;
> -	tb->tx_buf[1] =3D data;
> -
> -	err =3D spi_sync_transfer(to_spi_device(dev), &xfers, 1);
> -	mutex_unlock(&tb->buf_lock);
> -
> -	return err;
> -}
> +static const struct regmap_config st_sensors_spi_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> =20
> -static const struct st_sensor_transfer_function st_sensors_tf_spi =3D {
> -	.read_byte =3D st_sensors_spi_read_byte,
> -	.write_byte =3D st_sensors_spi_write_byte,
> -	.read_multiple_byte =3D st_sensors_spi_read_multiple_byte,
> +static const struct regmap_config st_sensors_spi_regmap_multiread_bit_co=
nfig =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.read_flag_mask =3D ST_SENSORS_SPI_MULTIREAD,
>  };
> =20
>  /*
> @@ -155,6 +89,7 @@ int st_sensors_spi_configure(struct iio_dev *indio_dev=
,
>  			     struct spi_device *spi)
>  {
>  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> +	const struct regmap_config *config;
>  	int err;
> =20
>  	if (st_sensors_is_spi_3_wire(spi)) { @@ -164,13 +99,24 @@ int=20
> st_sensors_spi_configure(struct iio_dev *indio_dev,
>  			return err;
>  	}
> =20
> +	if (sdata->sensor_settings->multi_read_bit)
> +		config =3D &st_sensors_spi_regmap_multiread_bit_config;
> +	else
> +		config =3D &st_sensors_spi_regmap_config;
> +
> +	sdata->regmap =3D devm_regmap_init_spi(spi, config);
> +	if (IS_ERR(sdata->regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
> +			(int)PTR_ERR(sdata->regmap));
> +		return PTR_ERR(sdata->regmap);
> +	}
> +
>  	spi_set_drvdata(spi, indio_dev);
> =20
>  	indio_dev->dev.parent =3D &spi->dev;
>  	indio_dev->name =3D spi->modalias;
> =20
>  	sdata->dev =3D &spi->dev;
> -	sdata->tf =3D &st_sensors_tf_spi;
>  	sdata->get_irq_data_ready =3D st_sensors_spi_get_irq;
> =20
>  	return 0;
> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c=20
> b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> index 630c8cb35e8b..bed7b8682b17 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> @@ -13,6 +13,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/interrupt.h>
> +#include <linux/regmap.h>
>  #include <linux/iio/common/st_sensors.h>  #include=20
> "st_sensors_core.h"
> =20
> @@ -26,8 +27,7 @@
>  static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
>  					    struct st_sensor_data *sdata)  {
> -	u8 status;
> -	int ret;
> +	int ret, status;
> =20
>  	/* How would I know if I can't check it? */
>  	if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> @@ -37,9 +37,9 @@ static int st_sensors_new_samples_available(struct iio_=
dev *indio_dev,
>  	if (!indio_dev->active_scan_mask)
>  		return 0;
> =20
> -	ret =3D sdata->tf->read_byte(&sdata->tb, sdata->dev,
> -			sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> -			&status);
> +	ret =3D regmap_read(sdata->regmap,
> +			  sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> +			  &status);
>  	if (ret < 0) {
>  		dev_err(sdata->dev,
>  			"error checking samples available\n"); diff --git=20
> a/drivers/iio/gyro/st_gyro_buffer.c=20
> b/drivers/iio/gyro/st_gyro_buffer.c
> index 6e362f735e92..21360681d4dd 100644
> --- a/drivers/iio/gyro/st_gyro_buffer.c
> +++ b/drivers/iio/gyro/st_gyro_buffer.c
> @@ -39,7 +39,8 @@ static int st_gyro_buffer_postenable(struct iio_dev *in=
dio_dev)
>  	int err;
>  	struct st_sensor_data *gdata =3D iio_priv(indio_dev);
> =20
> -	gdata->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	gdata->buffer_data =3D kmalloc(indio_dev->scan_bytes,
> +				     GFP_DMA | GFP_KERNEL);
>  	if (gdata->buffer_data =3D=3D NULL) {
>  		err =3D -ENOMEM;
>  		goto allocate_memory_error;
> diff --git a/drivers/iio/gyro/st_gyro_core.c=20
> b/drivers/iio/gyro/st_gyro_core.c index 4b87e79aa744..02e42c945181=20
> 100644
> --- a/drivers/iio/gyro/st_gyro_core.c
> +++ b/drivers/iio/gyro/st_gyro_core.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> -#include <linux/mutex.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> @@ -394,7 +393,6 @@ int st_gyro_common_probe(struct iio_dev=20
> *indio_dev)
> =20
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>  	indio_dev->info =3D &gyro_info;
> -	mutex_init(&gdata->tb.buf_lock);
> =20
>  	err =3D st_sensors_power_enable(indio_dev);
>  	if (err)
> @@ -405,7 +403,6 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
>  		goto st_gyro_power_off;
> =20
>  	gdata->num_data_channels =3D ST_GYRO_NUMBER_DATA_CHANNELS;
> -	gdata->multiread_bit =3D gdata->sensor_settings->multi_read_bit;
>  	indio_dev->channels =3D gdata->sensor_settings->ch;
>  	indio_dev->num_channels =3D ST_SENSORS_NUMBER_ALL_CHANNELS;
> =20
> diff --git a/drivers/iio/gyro/st_gyro_i2c.c=20
> b/drivers/iio/gyro/st_gyro_i2c.c index fa71e94b76f4..05a1a0874bd5=20
> 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -87,7 +87,9 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
>  	gdata =3D iio_priv(indio_dev);
>  	gdata->sensor_settings =3D (struct st_sensor_settings *)settings;
> =20
> -	st_sensors_i2c_configure(indio_dev, client, gdata);
> +	err =3D st_sensors_i2c_configure(indio_dev, client);
> +	if (err < 0)
> +		return err;
> =20
>  	err =3D st_gyro_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c=20
> b/drivers/iio/magnetometer/st_magn_buffer.c
> index 11d7806655bc..9dba93539a99 100644
> --- a/drivers/iio/magnetometer/st_magn_buffer.c
> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> @@ -34,7 +34,8 @@ static int st_magn_buffer_postenable(struct iio_dev *in=
dio_dev)
>  	int err;
>  	struct st_sensor_data *mdata =3D iio_priv(indio_dev);
> =20
> -	mdata->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	mdata->buffer_data =3D kmalloc(indio_dev->scan_bytes,
> +				     GFP_DMA | GFP_KERNEL);
>  	if (mdata->buffer_data =3D=3D NULL) {
>  		err =3D -ENOMEM;
>  		goto allocate_memory_error;
> diff --git a/drivers/iio/magnetometer/st_magn_core.c=20
> b/drivers/iio/magnetometer/st_magn_core.c
> index 3f313aefece6..804353a483c7 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> -#include <linux/mutex.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> @@ -496,7 +495,6 @@ int st_magn_common_probe(struct iio_dev=20
> *indio_dev)
> =20
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>  	indio_dev->info =3D &magn_info;
> -	mutex_init(&mdata->tb.buf_lock);
> =20
>  	err =3D st_sensors_power_enable(indio_dev);
>  	if (err)
> @@ -507,7 +505,6 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
>  		goto st_magn_power_off;
> =20
>  	mdata->num_data_channels =3D ST_MAGN_NUMBER_DATA_CHANNELS;
> -	mdata->multiread_bit =3D mdata->sensor_settings->multi_read_bit;
>  	indio_dev->channels =3D mdata->sensor_settings->ch;
>  	indio_dev->num_channels =3D ST_SENSORS_NUMBER_ALL_CHANNELS;
> =20
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c=20
> b/drivers/iio/magnetometer/st_magn_i2c.c
> index d5d565639bed..fdba480a12be 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -79,7 +79,9 @@ static int st_magn_i2c_probe(struct i2c_client *client,
>  	mdata =3D iio_priv(indio_dev);
>  	mdata->sensor_settings =3D (struct st_sensor_settings *)settings;
> =20
> -	st_sensors_i2c_configure(indio_dev, client, mdata);
> +	err =3D st_sensors_i2c_configure(indio_dev, client);
> +	if (err < 0)
> +		return err;
> =20
>  	err =3D st_magn_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/pressure/st_pressure_buffer.c=20
> b/drivers/iio/pressure/st_pressure_buffer.c
> index 4566e08a64a1..f21b630abaa0 100644
> --- a/drivers/iio/pressure/st_pressure_buffer.c
> +++ b/drivers/iio/pressure/st_pressure_buffer.c
> @@ -39,7 +39,8 @@ static int st_press_buffer_postenable(struct iio_dev *i=
ndio_dev)
>  	int err;
>  	struct st_sensor_data *press_data =3D iio_priv(indio_dev);
> =20
> -	press_data->buffer_data =3D kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> +	press_data->buffer_data =3D kmalloc(indio_dev->scan_bytes,
> +					  GFP_DMA | GFP_KERNEL);
>  	if (press_data->buffer_data =3D=3D NULL) {
>  		err =3D -ENOMEM;
>  		goto allocate_memory_error;
> diff --git a/drivers/iio/pressure/st_pressure_core.c=20
> b/drivers/iio/pressure/st_pressure_core.c
> index a783fc075c26..9ef92a501286 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
> -#include <linux/mutex.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> @@ -692,7 +691,6 @@ int st_press_common_probe(struct iio_dev=20
> *indio_dev)
> =20
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>  	indio_dev->info =3D &press_info;
> -	mutex_init(&press_data->tb.buf_lock);
> =20
>  	err =3D st_sensors_power_enable(indio_dev);
>  	if (err)
> @@ -709,7 +707,6 @@ int st_press_common_probe(struct iio_dev *indio_dev)
>  	 * element.
>  	 */
>  	press_data->num_data_channels =3D press_data->sensor_settings->num_ch -=
 1;
> -	press_data->multiread_bit =3D press_data->sensor_settings->multi_read_b=
it;
>  	indio_dev->channels =3D press_data->sensor_settings->ch;
>  	indio_dev->num_channels =3D press_data->sensor_settings->num_ch;
> =20
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c=20
> b/drivers/iio/pressure/st_pressure_i2c.c
> index 466e7dde5eae..71d2ed6b4948 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -112,7 +112,9 @@ static int st_press_i2c_probe(struct i2c_client *clie=
nt,
>  	press_data =3D iio_priv(indio_dev);
>  	press_data->sensor_settings =3D (struct st_sensor_settings *)settings;
> =20
> -	st_sensors_i2c_configure(indio_dev, client, press_data);
> +	ret =3D st_sensors_i2c_configure(indio_dev, client);
> +	if (ret < 0)
> +		return ret;
> =20
>  	ret =3D st_press_common_probe(indio_dev);
>  	if (ret < 0)
> diff --git a/include/linux/iio/common/st_sensors.h=20
> b/include/linux/iio/common/st_sensors.h
> index 566b955e2980..28fc1f9fa7d5 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -16,6 +16,7 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/bitops.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> =20
>  #include <linux/platform_data/st_sensors_pdata.h>
> =20
> @@ -169,36 +170,6 @@ struct st_sensor_data_ready_irq {
>  	} ig1;
>  };
> =20
> -/**
> - * struct st_sensor_transfer_buffer - ST sensor device I/O buffer
> - * @buf_lock: Mutex to protect rx and tx buffers.
> - * @tx_buf: Buffer used by SPI transfer function to send data to the sen=
sors.
> - *	This buffer is used to avoid DMA not-aligned issue.
> - * @rx_buf: Buffer used by SPI transfer to receive data from sensors.
> - *	This buffer is used to avoid DMA not-aligned issue.
> - */
> -struct st_sensor_transfer_buffer {
> -	struct mutex buf_lock;
> -	u8 rx_buf[ST_SENSORS_RX_MAX_LENGTH];
> -	u8 tx_buf[ST_SENSORS_TX_MAX_LENGTH] ____cacheline_aligned;
> -};
> -
> -/**
> - * struct st_sensor_transfer_function - ST sensor device I/O function
> - * @read_byte: Function used to read one byte.
> - * @write_byte: Function used to write one byte.
> - * @read_multiple_byte: Function used to read multiple byte.
> - */
> -struct st_sensor_transfer_function {
> -	int (*read_byte) (struct st_sensor_transfer_buffer *tb,
> -				struct device *dev, u8 reg_addr, u8 *res_byte);
> -	int (*write_byte) (struct st_sensor_transfer_buffer *tb,
> -				struct device *dev, u8 reg_addr, u8 data);
> -	int (*read_multiple_byte) (struct st_sensor_transfer_buffer *tb,
> -		struct device *dev, u8 reg_addr, int len, u8 *data,
> -							bool multiread_bit);
> -};
> -
>  /**
>   * struct st_sensor_settings - ST specific sensor settings
>   * @wai: Contents of WhoAmI register.
> @@ -242,16 +213,14 @@ struct st_sensor_settings {
>   * @current_fullscale: Maximum range of measure by the sensor.
>   * @vdd: Pointer to sensor's Vdd power supply
>   * @vdd_io: Pointer to sensor's Vdd-IO power supply
> + * @regmap: Pointer to specific sensor regmap configuration.
>   * @enabled: Status of the sensor (false->off, true->on).
> - * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
>   * @buffer_data: Data used by buffer part.
>   * @odr: Output data rate of the sensor [Hz].
>   * num_data_channels: Number of data channels used in buffer.
>   * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
>   * @int_pin_open_drain: Set the interrupt/DRDY to open drain.
>   * @get_irq_data_ready: Function to get the IRQ used for data ready sign=
al.
> - * @tf: Transfer function structure used by I/O operations.
> - * @tb: Transfer buffers and mutex used by I/O operations.
>   * @edge_irq: the IRQ triggers on edges and need special handling.
>   * @hw_irq_trigger: if we're using the hardware interrupt on the sensor.
>   * @hw_timestamp: Latest timestamp from the interrupt handler, when in u=
se.
> @@ -264,9 +233,9 @@ struct st_sensor_data {
>  	struct st_sensor_fullscale_avl *current_fullscale;
>  	struct regulator *vdd;
>  	struct regulator *vdd_io;
> +	struct regmap *regmap;
> =20
>  	bool enabled;
> -	bool multiread_bit;
> =20
>  	char *buffer_data;
> =20
> @@ -278,9 +247,6 @@ struct st_sensor_data {
> =20
>  	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
> =20
> -	const struct st_sensor_transfer_function *tf;
> -	struct st_sensor_transfer_buffer tb;
> -
>  	bool edge_irq;
>  	bool hw_irq_trigger;
>  	s64 hw_timestamp;
> diff --git a/include/linux/iio/common/st_sensors_i2c.h=20
> b/include/linux/iio/common/st_sensors_i2c.h
> index 5ada89944698..01e424e2af4f 100644
> --- a/include/linux/iio/common/st_sensors_i2c.h
> +++ b/include/linux/iio/common/st_sensors_i2c.h
> @@ -14,8 +14,8 @@
>  #include <linux/iio/common/st_sensors.h>  #include <linux/of.h>
> =20
> -void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> -		struct i2c_client *client, struct st_sensor_data *sdata);
> +int st_sensors_i2c_configure(struct iio_dev *indio_dev,
> +			     struct i2c_client *client);
> =20
>  #ifdef CONFIG_ACPI
>  int st_sensors_match_acpi_device(struct device *dev);

