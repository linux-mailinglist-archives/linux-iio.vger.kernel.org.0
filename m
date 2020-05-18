Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A001D7D1C
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgERPmD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 11:42:03 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:62258 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbgERPmD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 11:42:03 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IFfpWr022722;
        Mon, 18 May 2020 08:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=OLC1t+Hoa8xiNUZ4ag4tjISrlThSLKZr/pRbaGpuJiA=;
 b=eKZGiAPlthxvlKCVaT92yoAeDYaJsBui5eYwr7a38lK31OiSH2ZGD7pv5esDQ+3hbcPR
 4iCicNyxt7PsUoE+Y/P8Mm6pVcO8M3tVP/92xEZ2dX9dLEQnEIjLy8PG3kNnH2xxUdM9
 rCyfeFNFbN6uZxEpOdPVnmCppk5EUo332gGnemAtQG9Mxg0bvUVQfdzXQBcX57yK40p1
 7sAxhZMJFCO97Btzjqo0xMPjuLIywBTmeVV10L6KEE6gqn4UBfCGuTRDfpGJSLGtsL1q
 xmGZWeTpwSDu3WAdQV6fql5LI18hTrSe6HFF/sOiiL2ha9SNEQZLDzJlyANP1Xh+U5Iu pw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-00328301.pphosted.com with ESMTP id 313dph8aut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 08:41:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShSl29GDkxx3Gm6cGEmSn5AGwodYYPyMipgcEAMTtZypgq/nJR3yKlbfvEvDsru97b9SKySyy1xsV328CJ7DMCga87iva9wjSm/eYyPyqCApliorYTfLVKExNlAXCRn7vK6yD50UZm7rNkrrWscZ52NSP4iEpaWCY/JeBjxjIOeRdWSe5qwqcU7yhjHDbgH9KknZWM3We2LaBoCmmbcNzBSwrwAD2WRWiadLb3OaDO70REJbu3FJwZL2Y+gJt61GguOFwPgxTeKUclXPSW2UCX/cEYr7JdRVs9LErCeiX3m49N924HtEDuBdkvz8OhQU5jfWaDI7ElAp17SxErJ3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLC1t+Hoa8xiNUZ4ag4tjISrlThSLKZr/pRbaGpuJiA=;
 b=Qmms0s8uVoUTtZwfZ36Ev9odY0KfMjbSFHHUAq8s399UAjE0IRc/wqNNyYEk6BHMYg2UTunndtTIzpM6pHpjLgt6ZsvtJRo92eyvwXVAXDvtliw2LUqvjylXbzpmB7B/1G7g9waxVi9g/WPSnLocF/VvfVEBOhNUZlFk5JqxUjpHDXiUw8iPtmcIMdnWdKrDp6eWw9Z06ijPDoBiLMi1KoyeWBrq6yqfgpsXhgirRkuu718MoYS8G3Tv2u1GEzhmHZTPZgjlr656PbJ2vI1d2rQCB0CcWcInD9cMr82aJpNcIql8r2DlJCBOmPA2xlqVzKVb+SJ+DlrkU9cEQkei1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLC1t+Hoa8xiNUZ4ag4tjISrlThSLKZr/pRbaGpuJiA=;
 b=UKpj5M+us1XqoZ1GSLo7SNt8sXiBaJ0KINjvOsLWiFuj77aq5A/UeMgN7LA8qlUJxqzB4NOzKsKkKjOEnyyUKNxoF2hl+Qdix8CjfZGjvYfPGCatQQC95EoWnqYOxdhB63KGuiZCr/6i7jdeAVdoFgQAPsGVROCC+d9IPTMfLT0=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 15:41:47 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%9]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 15:41:47 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] iio: imu: inv_icm42600: add device interrupt
 trigger
Thread-Topic: [PATCH 08/12] iio: imu: inv_icm42600: add device interrupt
 trigger
Thread-Index: AQHWJH3aGzQU9Ogi5k+nRS7WyMfRO6iePzmAgA/MWRM=
Date:   Mon, 18 May 2020 15:41:47 +0000
Message-ID: <MN2PR12MB44223D2E27FCA3FE5D9D945CC4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-9-jmaneyrol@invensense.com>,<20200508152229.00005de2@Huawei.com>
In-Reply-To: <20200508152229.00005de2@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc324b14-84f6-4214-ebd4-08d7fb41f9d7
x-ms-traffictypediagnostic: MN2PR12MB2909:
x-microsoft-antispam-prvs: <MN2PR12MB29092C6BB1A88FE21DADC7E3C4B80@MN2PR12MB2909.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1iVzlTyS3jAfTljKgnfny+Hu9FSdBR5ltxJflMAGEERunaq70IJSLRvhpCKPDxlxvhzEO1QRm7HeeECPgO4b6PqBlNvhao8R0GiFxCcYithMZqFsx22Jx9zPDIzAd3+UCgJb6ZXwLpZU3HBmSX/0DRmWIpvBNcimDPMEgRWh7NNqDoD37KLeU6Vwm9skKkgEfQ/jLITP3Ffj6TX/ety87xhnHfIOUntUPLvuCoPfZb8a3BICRc6IZkz2sjH/MTxKCnb9SrpFqDw4Z+jON0vhLgeCtPfIkX5EJukCP+aeWj1jmqt/BCsy33WhjGIt8VKRf+whLao5v/rotF22eZ0z/1Zd+nDsduCIM8Tsiny1qTyiUauOPEv4+GHPybZzYqnmYcgzvYm+VHOwUtZ6w+8ac6TZiZxkxxslzoUlyJqiJhosd/ROHyrmTJy0n6YIeZm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(346002)(376002)(39850400004)(91956017)(30864003)(7416002)(55016002)(316002)(71200400001)(76116006)(66446008)(6506007)(53546011)(26005)(54906003)(64756008)(2906002)(4326008)(9686003)(86362001)(52536014)(6916009)(186003)(7696005)(5660300002)(66476007)(66946007)(478600001)(8676002)(33656002)(66556008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: z0HXnnPkykphTTOu9bvosEttBzr06mevSdqd+FH0rr0ksSgplixdr0tedHaJTE68gpAGMHw6BWIJoOZIH9Oy5h9KDGNEaAa/0g+8YDU9MiL/5NnvYIIkS4xS8pFoT3OCJ6UtlYzQA3yM3bgvF3CjEhASw7+7+59HjRRDEbRy5cmvQ6y9KkVMDdrJeVGhaNqwY8gWOBk3ikMXzPL3bLwiUa/VLv9u7A4YtunIAkvYrABsmaTetAIyU9/k5D3zVL5e4+tFPgMOYGnizMn/I0vTaUu+STVRouKuLS2W+kxdngDFlUCEWhGQ9cAdEJkYEuJeMmuO0rPfRFa1lo8Q7ogUZpwhXPf02e1aGlM5+MznWS8KClyiYoU62C6R1isR8AnnE3JrxRR4hP+esxZ8RyFnmwGbMZwMEhQlVBQAS4wcL4ND+eAQPHc7IP36tFK6+WsDOk6VhRTaaV0J8n1lbbIAxSUj0ovzQ4QKRcxRpSfKMUA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc324b14-84f6-4214-ebd4-08d7fb41f9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 15:41:47.8700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkDnD1m+EMjL/Gnehgj7ZUk+BtKXn76msosNI6QV0m309XcnXji4A6ycthWK5/HtYNSZSbVuRUhon2hZbOH/boYcuTaO4sgX6IWkmcxRTvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 cotscore=-2147483648 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180134
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
you're right, making a trigger is not very useful.=0A=
=0A=
I will move this code to the buffer file or rename the file, and replace th=
e triggered buffer setup in iio devices.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
=0A=
Sent: Friday, May 8, 2020 16:22=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: jic23@kernel.org <jic23@kernel.org>; robh+dt@kernel.org <robh+dt@kernel=
.org>; robh@kernel.org <robh@kernel.org>; mchehab+huawei@kernel.org <mcheha=
b+huawei@kernel.org>; davem@davemloft.net <davem@davemloft.net>; gregkh@lin=
uxfoundation.org <gregkh@linuxfoundation.org>;=0A=
 linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.ker=
nel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH 08/12] iio: imu: inv_icm42600: add device interrupt tri=
gger=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
On Thu, 7 May 2020 16:42:18 +0200=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Add INT1 interrupt support and use it as an iio trigger.=0A=
=0A=
> Support interrupt edge and level, active high or low.=0A=
=0A=
> Push-pull configuration only.=0A=
=0A=
> =0A=
=0A=
> Trigger enables FIFO and will be useful with buffer support.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
=0A=
So it's an odd trigger... But you check its only used for the=0A=
=0A=
device itself which stops that being visible to anyone.=0A=
=0A=
=0A=
=0A=
The open question in my mind is why we need a trigger at all?=0A=
=0A=
If there is no advantage we don't need to expose that.=A0 Can just=0A=
=0A=
directly call the buffer functions from the interrupt handler.=0A=
=0A=
=0A=
=0A=
It's perfectly acceptable to not have a trigger exposed if:=0A=
=0A=
* It would only be useful for the device providing it.=0A=
=0A=
* You don't need to use it to select between various options.=0A=
=0A=
=0A=
=0A=
For some of the other fifo devices IIRC we do support other=0A=
=0A=
triggers but if you don't provide one the local fifo is used.=0A=
=0A=
=0A=
=0A=
Here I don't think we actually support other triggers though we=0A=
=0A=
don't prevent them being used? So even simpler.=0A=
=0A=
With the complex interleaved fifo I suspect it would be hard=0A=
=0A=
to support other triggers anyway except in a trivial poll like=0A=
=0A=
mode so probably not of interest to anyone...=0A=
=0A=
=0A=
=0A=
J =0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 1 +=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/Makefile=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
1 +=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 |=A0=A0 8 +-=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 |=A0 19 +-=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c=A0=A0 |=A0=A0 2 +-=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_spi.c=A0=A0 |=A0=A0 2 +-=0A=
=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_trigger.c=A0=A0 | 177 ++++++++++++++=
++++=0A=
=0A=
>=A0 7 files changed, 206 insertions(+), 4 deletions(-)=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c=
=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_i=
cm42600/Kconfig=0A=
=0A=
> index 22390a72f0a3..7b3eaeb2aa4a 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/Kconfig=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Kconfig=0A=
=0A=
> @@ -2,6 +2,7 @@=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 config INV_ICM42600=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 tristate=0A=
=0A=
> +=A0=A0=A0=A0 select IIO_TRIGGER=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 config INV_ICM42600_I2C=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 tristate "InvenSense ICM-426xx I2C driver"=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_=
icm42600/Makefile=0A=
=0A=
> index 48965824f00c..e1f2aacbe888 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/Makefile=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Makefile=0A=
=0A=
> @@ -5,6 +5,7 @@ inv-icm42600-y +=3D inv_icm42600_core.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_gyro.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_accel.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_temp.o=0A=
=0A=
> +inv-icm42600-y +=3D inv_icm42600_trigger.o=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 obj-$(CONFIG_INV_ICM42600_I2C) +=3D inv-icm42600-i2c.o=0A=
=0A=
>=A0 inv-icm42600-i2c-y +=3D inv_icm42600_i2c.o=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
=0A=
> index bc963b3d1800..175c1f67faee 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> @@ -13,6 +13,7 @@=0A=
=0A=
>=A0 #include <linux/regulator/consumer.h>=0A=
=0A=
>=A0 #include <linux/pm.h>=0A=
=0A=
>=A0 #include <linux/iio/iio.h>=0A=
=0A=
> +#include <linux/iio/trigger.h>=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 enum inv_icm42600_chip {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42600,=0A=
=0A=
> @@ -122,6 +123,7 @@ struct inv_icm42600_suspended {=0A=
=0A=
>=A0=A0 *=A0 @suspended:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 suspended s=
ensors configuration.=0A=
=0A=
>=A0=A0 *=A0 @indio_gyro:=A0=A0=A0=A0 gyroscope IIO device.=0A=
=0A=
>=A0=A0 *=A0 @indio_accel:=A0=A0=A0 accelerometer IIO device.=0A=
=0A=
> + *=A0 @trigger:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device inte=
rnal interrupt trigger=0A=
=0A=
>=A0=A0 */=0A=
=0A=
>=A0 struct inv_icm42600_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
=0A=
> @@ -135,6 +137,7 @@ struct inv_icm42600_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_suspended suspended;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_gyro;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_accel;=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_trigger *trigger;=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /* Virtual register addresses: @bank on MSB (4 upper bits), @address o=
n LSB */=0A=
=0A=
> @@ -370,11 +373,14 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_=
state *st, bool enable,=0A=
=0A=
>=A0 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int r=
eg,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 unsigned int writeval, unsigned int *readval);=0A=
=0A=
>=A0 =0A=
=0A=
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip,=0A=
=0A=
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_bus_setup bus_setup);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st);=0A=
=0A=
>=A0 =0A=
=0A=
> +int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 int irq_type);=0A=
=0A=
> +=0A=
=0A=
>=A0 #endif=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> index 4e33f263d3ea..1102c54396e3 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> @@ -447,11 +447,13 @@ static void inv_icm42600_disable_pm(void *_data)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 pm_runtime_disable(dev);=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> -int inv_icm42600_core_probe(struct regmap *regmap, int chip,=0A=
=0A=
> +int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_icm42600_bus_setup bus_setup)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(regmap);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_icm42600_state *st;=0A=
=0A=
> +=A0=A0=A0=A0 struct irq_data *irq_desc;=0A=
=0A=
> +=A0=A0=A0=A0 int irq_type;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 BUILD_BUG_ON(ARRAY_SIZE(inv_icm42600_hw) !=3D INV_CH=
IP_NB);=0A=
=0A=
> @@ -460,6 +462,16 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* get irq data, set trigger falling by default */=0A=
=0A=
> +=A0=A0=A0=A0 irq_desc =3D irq_get_irq_data(irq);=0A=
=0A=
> +=A0=A0=A0=A0 if (!irq_desc) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "could not find IRQ %d=
\n", irq);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 irq_type =3D irqd_get_trigger_type(irq_desc);=0A=
=0A=
> +=A0=A0=A0=A0 if (!irq_type)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 irq_type =3D IRQF_TRIGGER_FALLING;=
=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 st =3D devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!st)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
=0A=
> @@ -503,6 +515,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* setup interrupt trigger */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_trigger_init(st, irq, irq_type);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* create and init gyroscope iio device */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_init(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
=0A=
> index b61f993beacf..b1478ece43f6 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c=0A=
=0A=
> @@ -70,7 +70,7 @@ static int inv_icm42600_probe(struct i2c_client *client=
,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (IS_ERR(regmap))=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(regmap);=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 return inv_icm42600_core_probe(regmap, chip,=0A=
=0A=
> +=A0=A0=A0=A0 return inv_icm42600_core_probe(regmap, chip, client->irq,=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_i2c_bus_setup);=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_spi.c=0A=
=0A=
> index 835ced68a3a3..ec784f9e3c2c 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c=0A=
=0A=
> @@ -70,7 +70,7 @@ static int inv_icm42600_probe(struct spi_device *spi)=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (IS_ERR(regmap))=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(regmap);=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 return inv_icm42600_core_probe(regmap, chip,=0A=
=0A=
> +=A0=A0=A0=A0 return inv_icm42600_core_probe(regmap, chip, spi->irq,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_spi_bus_setup);=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c b/driver=
s/iio/imu/inv_icm42600/inv_icm42600_trigger.c=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..7a5e76305f0b=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c=0A=
=0A=
> @@ -0,0 +1,177 @@=0A=
=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
=0A=
> +/*=0A=
=0A=
> + * Copyright (C) 2020 Invensense, Inc.=0A=
=0A=
> + */=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/device.h>=0A=
=0A=
> +#include <linux/mutex.h>=0A=
=0A=
> +#include <linux/interrupt.h>=0A=
=0A=
> +#include <linux/pm_runtime.h>=0A=
=0A=
> +#include <linux/regmap.h>=0A=
=0A=
> +#include <linux/iio/iio.h>=0A=
=0A=
> +#include <linux/iio/trigger.h>=0A=
=0A=
> +#include <linux/iio/trigger_consumer.h>=0A=
=0A=
> +=0A=
=0A=
> +#include "inv_icm42600.h"=0A=
=0A=
> +=0A=
=0A=
> +static irqreturn_t inv_icm42600_trigger_timestamp(int irq, void *_data)=
=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D _data;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (st->indio_gyro)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_pollfunc_store_time(irq, st->in=
dio_gyro->pollfunc);=0A=
=0A=
> +=A0=A0=A0=A0 if (st->indio_accel)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_pollfunc_store_time(irq, st->in=
dio_accel->pollfunc);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return IRQ_WAKE_THREAD;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static irqreturn_t inv_icm42600_trigger_int_handler(int irq, void *_data=
)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D _data;=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int status;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &=
status);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(dev, "int_status =3D %#02x\n", status);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* FIFO full */=0A=
=0A=
> +=A0=A0=A0=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_FULL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev, "FIFO full data lost!=
\n");=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* FIFO threshold reached */=0A=
=0A=
> +=A0=A0=A0=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_THS)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_trigger_poll_chained(st->trigge=
r);=0A=
=0A=
> +=0A=
=0A=
> +out_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 return IRQ_HANDLED;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_trigger_set_state(struct iio_trigger *trig, bool=
 state)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_trigger_get_drvdata(t=
rig);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int val;=0A=
=0A=
> +=A0=A0=A0=A0 uint16_t dummy;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /*=0A=
=0A=
> +=A0=A0=A0=A0=A0 * IIO buffers preenable and postdisable are managing pow=
er on/off.=0A=
=0A=
> +=A0=A0=A0=A0=A0 * update_scan_mode is setting data FIFO enabled.=0A=
=0A=
> +=A0=A0=A0=A0=A0 */=0A=
=0A=
> +=A0=A0=A0=A0 if (state) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* set FIFO threshold interrupt */=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_INT_SOURCE0_FI=
FO_THS_INT1_EN;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map,=
 INV_ICM42600_REG_INT_SOURCE0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
=0A=
=0A=
blank line after each block.=A0 Makes it easier for my tired eyes to parse =
:)=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* flush FIFO data */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_SIGNAL_PATH_RESET,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* set FIFO in streaming mode */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_FIFO_CONFIG,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG_STREAM);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* workaround: dummy read of FIFO c=
ount */=0A=
=0A=
=0A=
=0A=
Work around for what?=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, I=
NV_ICM42600_REG_FIFO_COUNT,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &dummy, sizeof(dummy));=0A=
=0A=
> +=A0=A0=A0=A0 } else {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* set FIFO in bypass mode */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_FIFO_CONFIG,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG_BYPASS);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* flush FIFO data */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_SIGNAL_PATH_RESET,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* disable FIFO threshold interrupt=
 */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_INT_SOURCE0_FI=
FO_THS_INT1_EN;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map,=
 INV_ICM42600_REG_INT_SOURCE0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val, 0);=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +out_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_trigger_validate(struct iio_trigger *trig,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_trigger_get_drvdata(t=
rig);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (iio_device_get_drvdata(indio_dev) !=3D st)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static const struct iio_trigger_ops inv_icm42600_trigger_ops =3D {=0A=
=0A=
> +=A0=A0=A0=A0 .set_trigger_state =3D &inv_icm42600_trigger_set_state,=0A=
=0A=
> +=A0=A0=A0=A0 .validate_device =3D &inv_icm42600_trigger_validate,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 int irq_type)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->trigger =3D devm_iio_trigger_alloc(dev, "%s-dev", st->n=
ame);=0A=
=0A=
> +=A0=A0=A0=A0 if (!st->trigger)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->trigger->dev.parent =3D dev;=0A=
=0A=
> +=A0=A0=A0=A0 st->trigger->ops =3D &inv_icm42600_trigger_ops;=0A=
=0A=
> +=A0=A0=A0=A0 iio_trigger_set_drvdata(st->trigger, st);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* configure INT1 with correct mode */=0A=
=0A=
> +=A0=A0=A0=A0 /* falling or both-edge */=0A=
=0A=
> +=A0=A0=A0=A0 if (irq_type & IRQF_TRIGGER_FALLING) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_INT_CONFIG_INT=
1_ACTIVE_LOW;=0A=
=0A=
> +=A0=A0=A0=A0 } else if (irq_type =3D=3D IRQF_TRIGGER_RISING) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_INT_CONFIG_INT=
1_ACTIVE_HIGH;=0A=
=0A=
> +=A0=A0=A0=A0 } else if (irq_type =3D=3D IRQF_TRIGGER_LOW) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_INT_CONFIG_INT=
1_ACTIVE_LOW |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_ICM42600_INT_CONFIG_INT1_LATCHED;=0A=
=0A=
> +=A0=A0=A0=A0 } else if (irq_type =3D=3D IRQF_TRIGGER_HIGH) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_INT_CONFIG_INT=
1_ACTIVE_LOW |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 INV_ICM42600_INT_CONFIG_INT1_LATCHED;=0A=
=0A=
> +=A0=A0=A0=A0 } else {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev, "invalid interrupt typ=
e %#x\n", irq_type);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 val |=3D INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_INT_CONFIG, =
val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* Deassert async reset for proper INT pin operation (cf da=
tasheet) */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_CO=
NFIG1,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_ICM42600_INT_CONFIG1_ASYNC_RESET, 0);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D devm_request_threaded_irq(dev, irq,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_trigger_timestamp,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_trigger_int_handler,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 irq_type, "inv_icm42600", st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return devm_iio_trigger_register(dev, st->trigger);=0A=
=0A=
> +}=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
