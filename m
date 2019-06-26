Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8BE572EC
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 22:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZUpq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 16:45:46 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21296 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbfFZUpq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jun 2019 16:45:46 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QKf4fL026364;
        Wed, 26 Jun 2019 22:45:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=GZm3/ki11Fx3JKwMJZVo0AZ33SbIT8fnpVtNFISQQts=;
 b=08Xf8ZtG1k4QctaqCMuxFPCjlwaKdQEqTmdE9i7TZjXWn2Mm5zmUSeQZPhodoxZE3E/X
 hIKIau56NehxwdS26xzx4KR+vReXu0hTZHZCPm55Sin7/iGnVK1DYd4aE6bibOUc1dST
 23/cOR8SHDTf3OAvRHtEkrSq4dFZNqZhc0Hiuo9ofTVcosMG3dUQE3ry+WYLOoYLjKvK
 oU82d8xJSfvjv6/xO0XyMgsDroPVgGk8HGHJ4WDCGNPQIZE7Dz77BSVIUTGB/02rTCv0
 9Y0YE/TvVNJTsIjIDeJ+c9yvRWjijbyMTeNaiJj+5K+4YE5sQVczXghB/D544Hn6jq0u gw== 
Received: from eur02-ve1-obe.outbound.protection.outlook.com (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56])
        by mx07-00178001.pphosted.com with ESMTP id 2t9d2gjba9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 22:45:38 +0200
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM (10.255.28.146) by
 AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM (52.134.84.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 20:45:36 +0000
Received: from AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d9a:940b:9368:7943]) by AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d9a:940b:9368:7943%7]) with mapi id 15.20.2008.014; Wed, 26 Jun 2019
 20:45:36 +0000
From:   Denis CIOCCA <denis.ciocca@st.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
Subject: RE: [PATCH 6/7] iio: make st_sensors driver use regmap
Thread-Topic: [PATCH 6/7] iio: make st_sensors driver use regmap
Thread-Index: AQHVJWdvBg8/3ZQAA0SL30pm/oZKVqanhRUAgAbvdxA=
Date:   Wed, 26 Jun 2019 20:45:36 +0000
Message-ID: <AM0PR10MB28970AA0C0A0135AE543E2BEEDE20@AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM>
References: <20190617234943.10669-1-denis.ciocca@st.com>
        <20190617234943.10669-7-denis.ciocca@st.com>
 <20190622114754.1ef64c64@archlinux>
In-Reply-To: <20190622114754.1ef64c64@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.225.34.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5baa383-2f71-42aa-e60a-08d6fa773db1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM0PR10MB1939;
x-ms-traffictypediagnostic: AM0PR10MB1939:
x-microsoft-antispam-prvs: <AM0PR10MB1939B7A2E49E6D58FAEB4B64EDE20@AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(366004)(189003)(199004)(51914003)(86362001)(52536014)(14454004)(4326008)(2906002)(476003)(71190400001)(5660300002)(68736007)(71200400001)(30864003)(478600001)(11346002)(66066001)(33656002)(446003)(6116002)(25786009)(3846002)(76116006)(66946007)(73956011)(54906003)(66446008)(66476007)(8676002)(64756008)(486006)(14444005)(305945005)(6506007)(55016002)(316002)(8936002)(6916009)(55236004)(256004)(74316002)(7696005)(26005)(99286004)(7736002)(53936002)(6436002)(81156014)(81166006)(102836004)(76176011)(53946003)(186003)(6246003)(229853002)(9686003)(66556008)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB1939;H:AM0PR10MB2897.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: st.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ycpFuaujtX4IhU0kTQM8z3my4T9KnIS2P++wPcQ9x89SqULtISL+9BtND9roPGfqs11+f7Vx+sn38wHx0yO+r0YXcBIrCFyam1dVk91rONGrD92MupnDVr7zAqC/341tldZokQiViOyz4XhV3p2U7x7VLWwA0cYU5RZVZisWU0zV+8NhQvJV8DAJTTQ2ChX/WoyahWtFYVmkKpMvfYLFIHOW0Va6bKlHUJ6RvlPiTbWLXYhhso+NtO9s6pfRO9JrQWKB1zT2GNBdsDP1IigoazdILSzSZy4RbYdmouDacveiBM07a+ZrosZQnOmm0DrKgDxrFoVF4ItmHrfpMfX3jZ8sX1AqNh3kp8KLm/HA51hCO0qnx2f1Pwctxj2x/1hVLMpiFigPvcvOykOZrx1lO7uCPc7vib5ds3FJAcALKFo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d5baa383-2f71-42aa-e60a-08d6fa773db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:45:36.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: denis.ciocca@st.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1939
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260239
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for the review. I am replying to this one only but I agree with all =
your comments.
I am changing the part as suggested (it makes totally sense) for the spi 3-=
wire initialization. I will submit new series as soon as it is ready.

Thanks
Denis


On Mon, 17 Jun 2019 16:49:42 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> This patch remove the transfer functions of the driver and make use of=20
> regmap. Multi-read bit is checked during probe at first in order to=20
> configure the regmap and not copied anymore.
> The multi-read bit can be set also for a single read.
>=20
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
A few things inline.

There is an existing oddity around when the spi modes are set that I would =
suggest cleaning up in a precursor patch to this one.

Jonathan

> ---
>  drivers/iio/accel/st_accel_core.c             |   3 -
>  drivers/iio/accel/st_accel_i2c.c              |   7 +-
>  drivers/iio/accel/st_accel_spi.c              |   6 +-
>  .../iio/common/st_sensors/st_sensors_buffer.c |  10 +-
>  .../iio/common/st_sensors/st_sensors_core.c   |  47 +++-----
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  65 +++++------
>  .../iio/common/st_sensors/st_sensors_spi.c    | 103 +++++-------------
>  .../common/st_sensors/st_sensors_trigger.c    |  10 +-
>  drivers/iio/gyro/st_gyro_core.c               |   3 -
>  drivers/iio/gyro/st_gyro_i2c.c                |   5 +-
>  drivers/iio/gyro/st_gyro_spi.c                |   6 +-
>  drivers/iio/magnetometer/st_magn_core.c       |   3 -
>  drivers/iio/magnetometer/st_magn_i2c.c        |   5 +-
>  drivers/iio/magnetometer/st_magn_spi.c        |   6 +-
>  drivers/iio/pressure/st_pressure_core.c       |   3 -
>  drivers/iio/pressure/st_pressure_i2c.c        |   5 +-
>  drivers/iio/pressure/st_pressure_spi.c        |   6 +-
>  include/linux/iio/common/st_sensors.h         |  37 +------
>  include/linux/iio/common/st_sensors_i2c.h     |   5 +-
>  include/linux/iio/common/st_sensors_spi.h     |   5 +-
>  20 files changed, 126 insertions(+), 214 deletions(-)
>=20
> diff --git a/drivers/iio/accel/st_accel_core.c=20
> b/drivers/iio/accel/st_accel_core.c
> index 5029b399efa8..5b8c1ef43ff8 100644
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
> @@ -1175,7 +1174,6 @@ int st_accel_common_probe(struct iio_dev=20
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
> index c3c8f2e73c2a..f2162f8cf2ac 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -150,8 +150,8 @@ MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
> =20
>  static int st_accel_i2c_probe(struct i2c_client *client)  {
> -	struct iio_dev *indio_dev;
>  	struct st_sensor_data *adata;
> +	struct iio_dev *indio_dev;
>  	const char *match;
>  	int ret;
> =20
> @@ -165,7 +165,10 @@ static int st_accel_i2c_probe(struct i2c_client *cli=
ent)
>  	if (match)
>  		strlcpy(client->name, match, sizeof(client->name));
> =20
> -	st_sensors_i2c_configure(indio_dev, client, adata);
> +	ret =3D st_sensors_i2c_configure(indio_dev, client,
> +				       st_accel_multiread_bit(client->name));
> +	if (ret < 0)
> +		return ret;
> =20
>  	ret =3D st_accel_common_probe(indio_dev);
>  	if (ret < 0)
> diff --git a/drivers/iio/accel/st_accel_spi.c=20
> b/drivers/iio/accel/st_accel_spi.c
> index 474742e35d92..a121755d6d8c 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -114,7 +114,11 @@ static int st_accel_spi_probe(struct spi_device=20
> *spi)
> =20
>  	st_sensors_of_name_probe(&spi->dev, st_accel_of_match,
>  				 spi->modalias, sizeof(spi->modalias));
> -	st_sensors_spi_configure(indio_dev, spi, adata);
> +
> +	err =3D st_sensors_spi_configure(indio_dev, spi,
> +				       st_accel_multiread_bit(spi->modalias));
> +	if (err < 0)
> +		return err;
> =20
>  	err =3D st_accel_common_probe(indio_dev);
>  	if (err < 0)
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
> index 243b2097c57e..3ddab3ca0a4b 100644
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
> @@ -558,9 +546,8 @@ static int st_sensors_read_axis_data(struct iio_dev *=
indio_dev,
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
> @@ -608,8 +595,9 @@ int st_sensors_read_info_raw(struct iio_dev=20
> *indio_dev,  }  EXPORT_SYMBOL(st_sensors_read_info_raw);
> =20
> -static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
> -			const struct st_sensor_settings *sensor_settings)
> +static int
> +st_sensors_init_interface_mode(struct iio_dev *indio_dev,
> +			       const struct st_sensor_settings *sensor_settings)
>  {
>  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
>  	struct device_node *np =3D sdata->dev->of_node; @@ -620,9 +608,9 @@=20
> static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
>  	     (pdata && pdata->spi_3wire)) && sensor_settings->sim.addr) {
>  		int err;
> =20
> -		err =3D sdata->tf->write_byte(&sdata->tb, sdata->dev,
> -					    sensor_settings->sim.addr,
> -					    sensor_settings->sim.value);
> +		err =3D regmap_bulk_write(sdata->regmap,

As mentioned below, I'm fairly sure bulk_read/write require dma safe buffer=
s.
Though why are you using bulk_write for length 1?

Even more interesting this is spi specific. I would move it to before the s=
pi regmap stuff is setup at all then just do a normal spi_write.

> +					sensor_settings->sim.addr,
> +					&sensor_settings->sim.value, 1);
>  		if (err < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to init interface mode\n"); @@ -667,8 +655,7 @@ int=20
> st_sensors_check_device_support(struct iio_dev *indio_dev,
>  			const struct st_sensor_settings *sensor_settings)  {
>  	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> -	int i, err =3D 0;
> -	u8 wai;
> +	int i, wai, err =3D 0;
> =20
>  	i =3D st_sensors_get_settings_index(indio_dev->name,
>  					  sensor_settings, num_sensors_list); @@ -683,8 +670,8 @@ int=20
> st_sensors_check_device_support(struct iio_dev *indio_dev,
>  		return err;
> =20
>  	if (sensor_settings[i].wai_addr) {
> -		err =3D sdata->tf->read_byte(&sdata->tb, sdata->dev,
> -					   sensor_settings[i].wai_addr, &wai);
> +		err =3D regmap_read(sdata->regmap,
> +				  sensor_settings[i].wai_addr, &wai);
>  		if (err < 0) {
>  			dev_err(&indio_dev->dev,
>  				"failed to read Who-Am-I register.\n"); diff --git=20
> a/drivers/iio/common/st_sensors/st_sensors_i2c.c=20
> b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> index b1c9812407e7..c8e03a63b17b 100644
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
> @@ -26,55 +27,45 @@ static unsigned int st_sensors_i2c_get_irq(struct iio=
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
> +static const struct regmap_config st_sensors_i2c_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> =20
> -	return i2c_smbus_read_i2c_block_data_or_emulated(to_i2c_client(dev),
> -							 reg_addr, len, data);
> -}
> +static const struct regmap_config st_sensors_i2c_regmap_multiread_bit_co=
nfig =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.read_flag_mask =3D ST_SENSORS_I2C_MULTIREAD, };
> =20
> -static int st_sensors_i2c_write_byte(struct st_sensor_transfer_buffer *t=
b,
> -				struct device *dev, u8 reg_addr, u8 data)
> +int st_sensors_i2c_configure(struct iio_dev *indio_dev,
> +			     struct i2c_client *client,
> +			     bool multiread_bit)
>  {
> -	return i2c_smbus_write_byte_data(to_i2c_client(dev), reg_addr, data);
> -}
> +	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> +	const struct regmap_config *config;
> =20
> -static const struct st_sensor_transfer_function st_sensors_tf_i2c =3D {
> -	.read_byte =3D st_sensors_i2c_read_byte,
> -	.write_byte =3D st_sensors_i2c_write_byte,
> -	.read_multiple_byte =3D st_sensors_i2c_read_multiple_byte,
> -};
> +	if (multiread_bit)
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
> =20
> -void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> -		struct i2c_client *client, struct st_sensor_data *sdata)
> -{
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
> index 2213843f02cb..bf3627be4b8a 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_spi.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -11,12 +11,12 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/iio/iio.h>
> +#include <linux/regmap.h>
> =20
>  #include <linux/iio/common/st_sensors_spi.h>
> =20
> =20
>  #define ST_SENSORS_SPI_MULTIREAD	0xc0
> -#define ST_SENSORS_SPI_READ		0x80
> =20
>  static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev) =20
> { @@ -25,94 +25,45 @@ static unsigned int=20
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
> +static const struct regmap_config st_sensors_spi_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> =20
> -static int st_sensors_spi_read_multiple_byte(
> -	struct st_sensor_transfer_buffer *tb, struct device *dev,
> -			u8 reg_addr, int len, u8 *data, bool multiread_bit)
> -{
> -	return st_sensors_spi_read(tb, dev, reg_addr, len, data, multiread_bit)=
;
> -}
> +static const struct regmap_config st_sensors_spi_regmap_multiread_bit_co=
nfig =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.read_flag_mask =3D ST_SENSORS_SPI_MULTIREAD, };
> =20
> -static int st_sensors_spi_write_byte(struct st_sensor_transfer_buffer *t=
b,
> -				struct device *dev, u8 reg_addr, u8 data)
> +int st_sensors_spi_configure(struct iio_dev *indio_dev,
> +			     struct spi_device *spi,
> +			     bool multiread_bit)
>  {
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
> +	struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> +	const struct regmap_config *config;
> =20
> -	return err;
> -}
> +	if (multiread_bit)
> +		config =3D &st_sensors_spi_regmap_multiread_bit_config;
> +	else
> +		config =3D &st_sensors_spi_regmap_config;
> =20
> -static const struct st_sensor_transfer_function st_sensors_tf_spi =3D {
> -	.read_byte =3D st_sensors_spi_read_byte,
> -	.write_byte =3D st_sensors_spi_write_byte,
> -	.read_multiple_byte =3D st_sensors_spi_read_multiple_byte,
> -};
> +	sdata->regmap =3D devm_regmap_init_spi(spi, config);
> +	if (IS_ERR(sdata->regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap (%d)\n",
> +			(int)PTR_ERR(sdata->regmap));
> +		return PTR_ERR(sdata->regmap);
> +	}
> =20
> -void st_sensors_spi_configure(struct iio_dev *indio_dev,
> -			struct spi_device *spi, struct st_sensor_data *sdata)
> -{
>  	spi_set_drvdata(spi, indio_dev);
> =20
>  	indio_dev->dev.parent =3D &spi->dev;
>  	indio_dev->name =3D spi->modalias;
> =20
>  	sdata->dev =3D &spi->dev;
> -	sdata->tf =3D &st_sensors_tf_spi;
>  	sdata->get_irq_data_ready =3D st_sensors_spi_get_irq;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL(st_sensors_spi_configure);
> =20
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
> a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c=20
> index 84a014fdcad2..5223b3118221 100644
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
> @@ -392,7 +391,6 @@ int st_gyro_common_probe(struct iio_dev=20
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
> b/drivers/iio/gyro/st_gyro_i2c.c index f2a8683db7d9..fa560f68e022=20
> 100644
> --- a/drivers/iio/gyro/st_gyro_i2c.c
> +++ b/drivers/iio/gyro/st_gyro_i2c.c
> @@ -77,7 +77,10 @@ static int st_gyro_i2c_probe(struct i2c_client *client=
,
>  	st_sensors_of_name_probe(&client->dev, st_gyro_of_match,
>  				 client->name, sizeof(client->name));
> =20
> -	st_sensors_i2c_configure(indio_dev, client, gdata);
> +	err =3D st_sensors_i2c_configure(indio_dev, client,
> +				       st_gyro_multiread_bit(client->name));
> +	if (err < 0)
> +		return err;
> =20
>  	err =3D st_gyro_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/gyro/st_gyro_spi.c=20
> b/drivers/iio/gyro/st_gyro_spi.c index 93c48248bea6..9bb58d2d72ed=20
> 100644
> --- a/drivers/iio/gyro/st_gyro_spi.c
> +++ b/drivers/iio/gyro/st_gyro_spi.c
> @@ -81,7 +81,11 @@ static int st_gyro_spi_probe(struct spi_device=20
> *spi)
> =20
>  	st_sensors_of_name_probe(&spi->dev, st_gyro_of_match,
>  				 spi->modalias, sizeof(spi->modalias));
> -	st_sensors_spi_configure(indio_dev, spi, gdata);
> +
> +	err =3D st_sensors_spi_configure(indio_dev, spi,
> +				       st_gyro_multiread_bit(spi->modalias));
> +	if (err < 0)
> +		return err;
> =20
>  	err =3D st_gyro_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/magnetometer/st_magn_core.c=20
> b/drivers/iio/magnetometer/st_magn_core.c
> index 2d8919eb5ada..4aa118e72ef6 100644
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
> @@ -494,7 +493,6 @@ int st_magn_common_probe(struct iio_dev=20
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
> index 4d014fd1aeb0..52e9be5088be 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -69,7 +69,10 @@ static int st_magn_i2c_probe(struct i2c_client *client=
,
>  	st_sensors_of_name_probe(&client->dev, st_magn_of_match,
>  				 client->name, sizeof(client->name));
> =20
> -	st_sensors_i2c_configure(indio_dev, client, mdata);
> +	err =3D st_sensors_i2c_configure(indio_dev, client,
> +				       st_magn_multiread_bit(client->name));
> +	if (err < 0)
> +		return err;
> =20
>  	err =3D st_magn_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c=20
> b/drivers/iio/magnetometer/st_magn_spi.c
> index 0d47070611b1..80c32a1720cd 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -63,7 +63,11 @@ static int st_magn_spi_probe(struct spi_device=20
> *spi)
> =20
>  	st_sensors_of_name_probe(&spi->dev, st_magn_of_match,
>  				 spi->modalias, sizeof(spi->modalias));
> -	st_sensors_spi_configure(indio_dev, spi, mdata);
> +
> +	err =3D st_sensors_spi_configure(indio_dev, spi,
> +				       st_magn_multiread_bit(spi->modalias));
> +	if (err < 0)
> +		return err;
> =20
>  	err =3D st_magn_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/drivers/iio/pressure/st_pressure_core.c=20
> b/drivers/iio/pressure/st_pressure_core.c
> index fb3bfaa00e85..9160ccfbef59 100644
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
> @@ -690,7 +689,6 @@ int st_press_common_probe(struct iio_dev=20
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
> index b7d9ba706abc..97468ca16dd5 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -103,7 +103,10 @@ static int st_press_i2c_probe(struct i2c_client *cli=
ent,
>  	} else if (!id)
>  		return -ENODEV;
> =20
> -	st_sensors_i2c_configure(indio_dev, client, press_data);
> +	ret =3D st_sensors_i2c_configure(indio_dev, client,
> +				       st_press_multiread_bit(client->name));
> +	if (ret < 0)
> +		return ret;
> =20
>  	ret =3D st_press_common_probe(indio_dev);
>  	if (ret < 0)
> diff --git a/drivers/iio/pressure/st_pressure_spi.c=20
> b/drivers/iio/pressure/st_pressure_spi.c
> index ef61401c41d3..ae2fbcb2169e 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -73,7 +73,11 @@ static int st_press_spi_probe(struct spi_device=20
> *spi)
> =20
>  	st_sensors_of_name_probe(&spi->dev, st_press_of_match,
>  				 spi->modalias, sizeof(spi->modalias));
> -	st_sensors_spi_configure(indio_dev, spi, press_data);
> +
> +	err =3D st_sensors_spi_configure(indio_dev, spi,
> +				       st_press_multiread_bit(spi->modalias));
> +	if (err < 0)
> +		return err;
> =20
>  	err =3D st_press_common_probe(indio_dev);
>  	if (err < 0)
> diff --git a/include/linux/iio/common/st_sensors.h=20
> b/include/linux/iio/common/st_sensors.h
> index 17fbf3e9b013..edd7a538f58c 100644
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

I'm slightly interested to see this go.  Note that the bulk reads in regmap=
 still need dma aligned buffers I believe.
Looking above it seems like there may be one problem case.

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
> @@ -243,7 +214,6 @@ struct st_sensor_settings {
>   * @vdd: Pointer to sensor's Vdd power supply
>   * @vdd_io: Pointer to sensor's Vdd-IO power supply
>   * @enabled: Status of the sensor (false->off, true->on).
> - * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
>   * @buffer_data: Data used by buffer part.
>   * @odr: Output data rate of the sensor [Hz].
>   * num_data_channels: Number of data channels used in buffer.
> @@ -264,9 +234,9 @@ struct st_sensor_data {
>  	struct st_sensor_fullscale_avl *current_fullscale;
>  	struct regulator *vdd;
>  	struct regulator *vdd_io;
> +	struct regmap *regmap;

I'm guessing this should be in the docs?

> =20
>  	bool enabled;
> -	bool multiread_bit;
> =20
>  	char *buffer_data;
> =20
> @@ -278,9 +248,6 @@ struct st_sensor_data {
> =20
>  	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
> =20
> -	const struct st_sensor_transfer_function *tf;
> -	struct st_sensor_transfer_buffer tb;
> -

And these have docs entries that should go.

>  	bool edge_irq;
>  	bool hw_irq_trigger;
>  	s64 hw_timestamp;
> diff --git a/include/linux/iio/common/st_sensors_i2c.h=20
> b/include/linux/iio/common/st_sensors_i2c.h
> index 5ada89944698..4d8f44d32ce9 100644
> --- a/include/linux/iio/common/st_sensors_i2c.h
> +++ b/include/linux/iio/common/st_sensors_i2c.h
> @@ -14,8 +14,9 @@
>  #include <linux/iio/common/st_sensors.h>  #include <linux/of.h>
> =20
> -void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> -		struct i2c_client *client, struct st_sensor_data *sdata);
> +int st_sensors_i2c_configure(struct iio_dev *indio_dev,
> +			     struct i2c_client *client,
> +			     bool multiread_bit);
> =20
>  #ifdef CONFIG_ACPI
>  int st_sensors_match_acpi_device(struct device *dev); diff --git=20
> a/include/linux/iio/common/st_sensors_spi.h=20
> b/include/linux/iio/common/st_sensors_spi.h
> index 6020f7167859..77c5f4d18cc6 100644
> --- a/include/linux/iio/common/st_sensors_spi.h
> +++ b/include/linux/iio/common/st_sensors_spi.h
> @@ -13,7 +13,8 @@
>  #include <linux/spi/spi.h>
>  #include <linux/iio/common/st_sensors.h>
> =20
> -void st_sensors_spi_configure(struct iio_dev *indio_dev,
> -			struct spi_device *spi, struct st_sensor_data *sdata);
> +int st_sensors_spi_configure(struct iio_dev *indio_dev,
> +			     struct spi_device *spi,
> +			     bool multiread_bit);
> =20
>  #endif /* ST_SENSORS_SPI_H */

