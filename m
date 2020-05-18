Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7DD1D7CEA
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 17:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgERPeC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 11:34:02 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:3286 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbgERPeB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 11:34:01 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IFTIfR026200;
        Mon, 18 May 2020 08:32:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=08ejfTGKqTVl193uvtOMEBv5wRcKQ3WfiUlZ3nawVe4=;
 b=a+auZfOXbDTqW9TEDEhj1RKAdkBAFSYKX1s5giJiblV5yCCbIqbNrjReSS/RmXQ1UHqQ
 /NgrsftGvzJBnuuDE+sJIi2aWVzYwOCuv2YVZ+VWjXTcDKpsotitfyaT7gHgmlKUaGBM
 Ud0YwJBQqm84ZyIeyLU/c1ylKBuD4K2+26xBnh/BROSIkGjDSUAlvSZpMyH+K+1DZ+NX
 RdjV3f3CHlF8klccJRRz/aJPQbHgv4qsbA6VfnTtGYAnsgFe55NR9WrD5Zu3+qeW2Qf/
 1soiVZ54CUz/lJtzyceDMaQFP/eoxpcZFbCpIe1wraeMwZ6qvKswns7kHb126MCwpmSB HQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0b-00328301.pphosted.com with ESMTP id 312c4pgqqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 08:32:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfbzuM5IVNUGc1kr/zfvFOU7pN35WMi2CxZcxtck7nbHTTNTJhGVwR37OcCXetai7Knp/BOPbeXQdmYpGRdkc3mriPd8HuWGYQ/cDud1QpTg3M446ZcdFSiomupVGDlXNBro6muE22ScXEAf+Dftw1ript8HS/VpdHK7LC4yzZlcPYBdNyzZFtEE2qjhTZ80UabD9e/7sbaf8ewGjrXH9V3qrwfn9k3X7EiJWPruucKVj56gb+Hsc/Qq5chLYrXDNQKjRAKn6FbmA5mW7N67R401m4SfscCUi7bMJRWwjmLyvGJ8ZD5CGa41A7FNWevzwITDcuS8VvuhqbkOFKh3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08ejfTGKqTVl193uvtOMEBv5wRcKQ3WfiUlZ3nawVe4=;
 b=ZkN6NDYCPmYJ/ml2buvq9R9kE071FKaTjSw5s4SSYPxgs8Ipv3hg5wE03K6SmU8SiwAukt6ZoJ5YYgcbbsGFClWNL9q3T8kW+Y++VVtX+i6Gb/awDEVLXK2PCNtCTvHHWgxCKT5vEiOcT09XFyarBQcUpx7AMBmMh5FiNFX2SBtdir879QiHbFp97NCsKDfQOT/z3sIRnw7zkMOPu8iZJqwOJ+Tx2EhNCP/c6vc/041MtjXcN6q8lkMm2LaQ9tljlfYRIWD4zadenpUb1Xxju5lmM3VNplv0hbuKTlBFHYtXgbq3+CqKr7DDLJ6LjNT95UPOsMa/H8chapWC1ZhqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08ejfTGKqTVl193uvtOMEBv5wRcKQ3WfiUlZ3nawVe4=;
 b=Of3HGzt+iA+q01UlRZpAZW48s2cOql8Q1Apq8sFcZ3GjWR6/K/telio5jagyt18oRmGAqAEXfcJy6Erp7odfjCxmWHpVhSXyCooboRDnad1gyibRWY4VfHlnQ3QUC1X64oimRmsSSMBKX4eqJ65eQ1ioJpNE3VKs86P6JZwqYq4=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3101.namprd12.prod.outlook.com (2603:10b6:208:c4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 15:32:27 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%9]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 15:32:27 +0000
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
Subject: Re: [PATCH 09/12] iio: imu: inv_icm42600: add buffer support in iio
 devices
Thread-Topic: [PATCH 09/12] iio: imu: inv_icm42600: add buffer support in iio
 devices
Thread-Index: AQHWJH3cvq+lvfRS6kCPI5E+7ofFb6iePmeAgA/KjLo=
Date:   Mon, 18 May 2020 15:32:27 +0000
Message-ID: <MN2PR12MB4422FF4727BB2D8344B9CAC8C4B80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
        <20200507144222.20989-10-jmaneyrol@invensense.com>,<20200508151933.00007d56@Huawei.com>
In-Reply-To: <20200508151933.00007d56@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4760e63a-22a0-45d0-24ec-08d7fb40abbc
x-ms-traffictypediagnostic: MN2PR12MB3101:
x-microsoft-antispam-prvs: <MN2PR12MB31016411B591F49A2F154FA5C4B80@MN2PR12MB3101.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:178;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lwDs27sI76/r7kKUp9fPRvofB9qx8aXHZ5e12Ix6ldKdDoKWuGA1l/45q6RbT94Nn5+/NhED2+r7ucFwa24vCSAmX+Dc5VOnqES0sXy+UJkubjpqagq3TEnjG5Kmz2/Vs3v4jETD9H/ztcRGIGiM8DhqlJhRSZdj9mjh2UhzMbiZK5+4LAQ5SVgpvTiz3l18bu1dh8SLnxqBCrO7BMGGARrGwSUCm1+n0mXs2vTMpT6mSxhRLFn+zcBYMzcmSyX3f01EopWyWt/apa18SC6eZG6AQbyWWhnsEy45yOJvtjJIcME3LJTfm+GVQ0wYuT6kIL91at2WOyZL/oWaDPrV9jtt0TjrrkOz9kEea3GDybCG6HGI6L9vwQMOKM2cvJ3WvfWHC9F02VKIR+pQ2+PY2Gqr9NgrrQ2LHl5grfwaGaKj4BDJfCZZmcPzQpK+w8U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(346002)(366004)(376002)(396003)(186003)(5660300002)(54906003)(53546011)(26005)(7696005)(8936002)(8676002)(6506007)(86362001)(71200400001)(4326008)(33656002)(2906002)(66556008)(55016002)(52536014)(66446008)(91956017)(76116006)(64756008)(66946007)(66476007)(478600001)(6916009)(9686003)(30864003)(7416002)(316002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CSR4szeXB8mvNn9NDvyM3i/k4Tiqn7MVxwh+aVGqKVLWHnc2t+Qp5+3rfGpT+lZJ0PigyfPsUTP4++wShtl3XuduYMvBfKA7FKd4Kg0vTzrSBilX/L56fRQAFC/9E8EDymvcNhMxVlJrL4jwdzT0UGPDSO7+lGUwFIyo0rP3SWoucfIm15uLGSxXcTmXbYXBKCW0wiuHvACnuC4WvEEKgF5HhgM8v3DBvpc8AHbsdnbraRB3AynWZcnxu5AZWOodc1qyjfwHaNC9SjCnBJvP+4diffNb/oHNprz24gZZxTNODsFKf5tq1Q3Ck9rYIF3UhvcPR0Ey2gNEpT0OGhAUOz71Qu90UwiMCXRpC9CEjPvAeo/To17NGdtR+j30Asq3iLY3w30EX57i/hYI5Ntr/OsU/8worFoQkPrsE0MA+4CodfxAvC4BeHk0yjCw27Xe9IDolY2z90lRmf/cQ5iJkTgF3PoHmX5ih8onRHXTXIA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4760e63a-22a0-45d0-24ec-08d7fb40abbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 15:32:27.2971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0t9lvIT2gSIoiGrLqm1vsznAPJgFfgL+J6BBYEc6Y+HKlw5ctKwbcxUWmsMTXfM8nk1jcyanh+l++sVA0IorqPxufLr76kLbv5VDJHQOlnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_06:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180133
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
no problem with the comments.=0A=
=0A=
fifo_decode_packet will move to source code,=A0=0A=
=0A=
For the following sleep comment:=0A=
> +=A0=A0=A0=A0 if (sleep_gyro > sleep_temp)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_gyro;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_temp;=0A=
> +=A0=A0=A0=A0 if (sleep)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 if (sleep_gyro > sleep_temp)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep_gyro);=0A=
=A0=A0=A0=A0=A0=A0=A0 else=0A=
                msleep(sleep_temp);=0A=
=0A=
I am using an intermediate local variable to avoid a call to msleep(0) whic=
h is in fact sleeping for real for 1 jiffies as far as I understand. So is =
it OK to keep it as is?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
=0A=
Sent: Friday, May 8, 2020 16:19=0A=
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
Subject: Re: [PATCH 09/12] iio: imu: inv_icm42600: add buffer support in ii=
o devices=0A=
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
On Thu, 7 May 2020 16:42:19 +0200=0A=
=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Use triggered buffer by parsing FIFO data read in device trigger.=0A=
=0A=
> Support hwfifo watermark by multiplexing gyro and accel settings.=0A=
=0A=
> Support hwfifo flush.=0A=
=0A=
> =0A=
=0A=
> Simply use interrupt timestamp first.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 3 +-=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/Makefile=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
1 +=0A=
=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 |=A0=A0 8 +=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 183 +++++++++=0A=
=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_buffer.c=A0=A0=A0 | 353 ++++++++++++=
++++++=0A=
=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_buffer.h=A0=A0=A0 | 162 ++++++++=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 |=A0 23 ++=0A=
=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c=A0 | 183 +++++++++=0A=
=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_trigger.c=A0=A0 |=A0 15 +-=0A=
=0A=
>=A0 9 files changed, 928 insertions(+), 3 deletions(-)=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=
=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h=
=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_i=
cm42600/Kconfig=0A=
=0A=
> index 7b3eaeb2aa4a..8c0969319c49 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/Kconfig=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Kconfig=0A=
=0A=
> @@ -2,7 +2,8 @@=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 config INV_ICM42600=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 tristate=0A=
=0A=
> -=A0=A0=A0=A0 select IIO_TRIGGER=0A=
=0A=
> +=A0=A0=A0=A0 select IIO_BUFFER=0A=
=0A=
> +=A0=A0=A0=A0 select IIO_TRIGGERED_BUFFER=0A=
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
> index e1f2aacbe888..d6732118010c 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/Makefile=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Makefile=0A=
=0A=
> @@ -6,6 +6,7 @@ inv-icm42600-y +=3D inv_icm42600_gyro.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_accel.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_temp.o=0A=
=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_trigger.o=0A=
=0A=
> +inv-icm42600-y +=3D inv_icm42600_buffer.o=0A=
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
> index 175c1f67faee..947ca4dd245b 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
=0A=
> @@ -15,6 +15,8 @@=0A=
=0A=
>=A0 #include <linux/iio/iio.h>=0A=
=0A=
>=A0 #include <linux/iio/trigger.h>=0A=
=0A=
>=A0 =0A=
=0A=
> +#include "inv_icm42600_buffer.h"=0A=
=0A=
> +=0A=
=0A=
>=A0 enum inv_icm42600_chip {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42600,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42602,=0A=
=0A=
> @@ -124,6 +126,7 @@ struct inv_icm42600_suspended {=0A=
=0A=
>=A0=A0 *=A0 @indio_gyro:=A0=A0=A0=A0 gyroscope IIO device.=0A=
=0A=
>=A0=A0 *=A0 @indio_accel:=A0=A0=A0 accelerometer IIO device.=0A=
=0A=
>=A0=A0 *=A0 @trigger:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device =
internal interrupt trigger=0A=
=0A=
> + *=A0 @fifo:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIFO management structure.=0A=
=0A=
>=A0=A0 */=0A=
=0A=
>=A0 struct inv_icm42600_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
=0A=
> @@ -138,6 +141,7 @@ struct inv_icm42600_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_gyro;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_accel;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_trigger *trigger;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo fifo;=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /* Virtual register addresses: @bank on MSB (4 upper bits), @address o=
n LSB */=0A=
=0A=
> @@ -378,8 +382,12 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip, int irq,=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);=0A=
=0A=
>=A0 =0A=
=0A=
> +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts);=
=0A=
=0A=
> +=0A=
=0A=
>=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st);=0A=
=0A=
>=A0 =0A=
=0A=
> +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts)=
;=0A=
=0A=
> +=0A=
=0A=
>=A0 int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 int irq_type);=0A=
=0A=
>=A0 =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
=0A=
> index 74dac5f283d4..4206be54d057 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
=0A=
> @@ -10,9 +10,13 @@=0A=
=0A=
>=A0 #include <linux/regmap.h>=0A=
=0A=
>=A0 #include <linux/delay.h>=0A=
=0A=
>=A0 #include <linux/iio/iio.h>=0A=
=0A=
> +#include <linux/iio/buffer.h>=0A=
=0A=
> +#include <linux/iio/triggered_buffer.h>=0A=
=0A=
> +#include <linux/iio/trigger_consumer.h>=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #include "inv_icm42600.h"=0A=
=0A=
>=A0 #include "inv_icm42600_temp.h"=0A=
=0A=
> +#include "inv_icm42600_buffer.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> @@ -46,6 +50,7 @@ enum inv_icm42600_accel_scan {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_ACCEL_SCAN_Y,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_ACCEL_SCAN_Z,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_ACCEL_SCAN_TEMP,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_ACCEL_SCAN_TIMESTAMP,=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_info=
s[] =3D {=0A=
=0A=
> @@ -61,8 +66,100 @@ static const struct iio_chan_spec inv_icm42600_accel_=
channels[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42600_ACCE=
L_SCAN_Z,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_accel_ext_infos),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP)=
,=0A=
=0A=
> +=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_ACCEL_SCAN_TIMESTAMP),=
=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
> +/* IIO buffer data */=0A=
=0A=
> +struct inv_icm42600_accel_buffer {=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data accel;=0A=
=0A=
> +=A0=A0=A0=A0 int8_t temp;=0A=
=0A=
> +=A0=A0=A0=A0 int64_t timestamp;=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 (BIT(INV_ICM42600_ACCEL_SCAN_X) |=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM42600_ACCEL_SCAN_Y) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM42600_ACCEL_SCAN_Z))=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_SCAN_MASK_TEMP=A0 BIT(INV_ICM42600_ACCEL_SCAN_TEMP)=
=0A=
=0A=
> +=0A=
=0A=
> +static const unsigned long inv_icm42600_accel_scan_masks[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis accel + temperature */=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SCAN_MASK_ACCEL_3AXIS | INV_ICM42600_SCAN_MASK=
_TEMP,=0A=
=0A=
> +=A0=A0=A0=A0 0,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static irqreturn_t inv_icm42600_accel_handler(int irq, void *_data)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_poll_func *pf =3D _data;=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 const size_t fifo_nb =3D st->fifo.nb.total;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* exit if no sample */=0A=
=0A=
> +=A0=A0=A0=A0 if (fifo_nb =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_accel_parse_fifo(indio_dev, pf->timest=
amp);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->map),=
 "accel fifo error %d\n",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret);=0A=
=0A=
> +=0A=
=0A=
> +out:=0A=
=0A=
> +=A0=A0=A0=A0 iio_trigger_notify_done(indio_dev->trig);=0A=
=0A=
> +=A0=A0=A0=A0 return IRQ_HANDLED;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +/* enable accelerometer sensor and FIFO write */=0A=
=0A=
> +static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const unsigned lo=
ng *scan_mask)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int fifo_en =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sleep_temp =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sleep_accel =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sleep;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable temp sensor */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_temp_conf(=
st, true, &sleep_temp);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_en |=3D INV_ICM42600_SENSOR_TE=
MP;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL_3AXIS) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable accel sensor */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf.mode =3D INV_ICM42600_SENSOR_M=
ODE_LOW_NOISE;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_accel_conf=
(st, &conf, &sleep_accel);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_en |=3D INV_ICM42600_SENSOR_AC=
CEL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* update data FIFO write and FIFO watermark */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->f=
ifo.en);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
> +=0A=
=0A=
> +out_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 /* sleep maximum required time */=0A=
=0A=
> +=A0=A0=A0=A0 if (sleep_accel > sleep_temp)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_accel;=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_temp;=0A=
=0A=
> +=A0=A0=A0=A0 if (sleep)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep);=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
>=A0 static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *s=
t,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec co=
nst *chan,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int16_t *val)=0A=
=0A=
> @@ -250,6 +347,8 @@ static int inv_icm42600_accel_write_odr(struct inv_ic=
m42600_state *st,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 conf.odr =3D inv_icm42600_accel_odr_conv[idx / 2];=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_accel_conf(st, &conf, NULL)=
;=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_fifo_period(st);=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> @@ -512,12 +611,51 @@ static int inv_icm42600_accel_write_raw_get_fmt(str=
uct iio_dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> +static int inv_icm42600_accel_hwfifo_set_watermark(struct iio_dev *indio=
_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsig=
ned int val)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.watermark.accel =3D val;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (count =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_hwfifo_flush(st, count);=0A=
=0A=
> +=A0=A0=A0=A0 if (!ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D st->fifo.nb.accel;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
>=A0 static const struct iio_info inv_icm42600_accel_info =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D inv_icm42600_accel_read_raw,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .read_avail =3D inv_icm42600_accel_read_avail,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .write_raw =3D inv_icm42600_accel_write_raw,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .write_raw_get_fmt =3D inv_icm42600_accel_write_raw_=
get_fmt,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .debugfs_reg_access =3D inv_icm42600_debugfs_reg,=0A=
=0A=
> +=A0=A0=A0=A0 .update_scan_mode =3D inv_icm42600_accel_update_scan_mode,=
=0A=
=0A=
> +=A0=A0=A0=A0 .hwfifo_set_watermark =3D inv_icm42600_accel_hwfifo_set_wat=
ermark,=0A=
=0A=
> +=A0=A0=A0=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_accel_hwfifo_flush=
,=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st)=0A=
=0A=
> @@ -525,6 +663,7 @@ int inv_icm42600_accel_init(struct inv_icm42600_state=
 *st)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const char *name;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-accel",=
 st->name);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!name)=0A=
=0A=
> @@ -541,7 +680,51 @@ int inv_icm42600_accel_init(struct inv_icm42600_stat=
e *st)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_icm42600_accel_channels;=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42600_=
accel_channels);=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->available_scan_masks =3D inv_icm42600_accel_scan=
_masks;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NUL=
L,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_accel_h=
andler,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &inv_icm42600_buffer=
_ops);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->trig =3D iio_trigger_get(st->trigger);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 st->indio_accel =3D indio_dev;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return devm_iio_device_register(dev, st->indio_accel=
);=0A=
=0A=
>=A0 }=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev, int64_t ts)=
=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 const size_t accel_nb =3D st->fifo.nb.accel;=0A=
=0A=
> +=A0=A0=A0=A0 ssize_t i, size;=0A=
=0A=
> +=A0=A0=A0=A0 const void *accel, *gyro, *temp, *timestamp;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int odr;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_accel_buffer buffer;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* exit if no accel sample */=0A=
=0A=
> +=A0=A0=A0=A0 if (accel_nb =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* parse all fifo packets */=0A=
=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < st->fifo.count; i +=3D size) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D inv_icm42600_fifo_decode_p=
acket(&st->fifo.data[i],=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &accel, &gyro, &temp, &timestamp, &odr);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map),=
 "accel packet size =3D %zd\n",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* quit if error or FIFO is empty *=
/=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size <=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return size=
;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* skip packet if no accel data or =
data is invalid */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (accel =3D=3D NULL || !inv_icm42=
600_fifo_is_data_valid(accel)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(reg=
map_get_device(st->map), "skip accel data\n");=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.accel, accel, sizeof=
(buffer.accel));=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.temp, temp, sizeof(b=
uffer.temp));=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timestamp(=
indio_dev, &buffer, ts);=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..b428abdc92ee=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
=0A=
> @@ -0,0 +1,353 @@=0A=
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
> +#include <linux/pm_runtime.h>=0A=
=0A=
> +#include <linux/regmap.h>=0A=
=0A=
> +#include <linux/delay.h>=0A=
=0A=
> +#include <linux/math64.h>=0A=
=0A=
> +#include <linux/iio/iio.h>=0A=
=0A=
> +#include <linux/iio/buffer.h>=0A=
=0A=
> +#include <linux/iio/triggered_buffer.h>=0A=
=0A=
> +#include <linux/iio/trigger_consumer.h>=0A=
=0A=
> +=0A=
=0A=
> +#include "inv_icm42600.h"=0A=
=0A=
> +#include "inv_icm42600_buffer.h"=0A=
=0A=
> +=0A=
=0A=
> +void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *s=
t)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t period_gyro, period_accel, period;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (st->fifo.en & INV_ICM42600_SENSOR_GYRO)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_gyro =3D inv_icm42600_odr_to=
_period(st->conf.gyro.odr);=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_gyro =3D U32_MAX;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (st->fifo.en & INV_ICM42600_SENSOR_ACCEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_accel =3D inv_icm42600_odr_t=
o_period(st->conf.accel.odr);=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_accel =3D U32_MAX;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (period_gyro <=3D period_accel)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D period_gyro;=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D period_accel;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.period =3D period;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int fifo_en)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int mask, val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* update only FIFO EN bits */=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D INV_ICM42600_FIFO_CONFIG1_TMST_FSYNC_EN |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG1_TEMP_EN |=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG1_GYRO_EN |=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;=
=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 val =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 if (fifo_en & INV_ICM42600_SENSOR_GYRO)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_=
GYRO_EN;=0A=
=0A=
> +=A0=A0=A0=A0 if (fifo_en & INV_ICM42600_SENSOR_ACCEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_=
ACCEL_EN;=0A=
=0A=
> +=A0=A0=A0=A0 if (fifo_en & INV_ICM42600_SENSOR_TEMP)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_=
TEMP_EN;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_C=
ONFIG1,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.en =3D fifo_en;=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_fifo_period(st);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static size_t inv_icm42600_get_packet_size(unsigned int fifo_en)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 size_t packet_size;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if ((fifo_en & INV_ICM42600_SENSOR_GYRO) &&=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (fifo_en & =
INV_ICM42600_SENSOR_ACCEL))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 packet_size =3D INV_ICM42600_FIFO_2=
SENSORS_PACKET_SIZE;=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 packet_size =3D INV_ICM42600_FIFO_1=
SENSOR_PACKET_SIZE;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return packet_size;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t packet_size)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 size_t wm_size;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int wm;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 wm_size =3D watermark * packet_size;=0A=
=0A=
> +=A0=A0=A0=A0 if (wm_size > INV_ICM42600_FIFO_WATERMARK_MAX)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wm_size =3D INV_ICM42600_FIFO_WATER=
MARK_MAX;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 wm =3D wm_size / packet_size;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return wm;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)=
=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 size_t packet_size, wm_size;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int wm_gyro, wm_accel, watermark;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t period_gyro, period_accel, period;=0A=
=0A=
> +=A0=A0=A0=A0 int64_t latency_gyro, latency_accel, latency;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int mask, val;=0A=
=0A=
> +=A0=A0=A0=A0 bool restore;=0A=
=0A=
> +=A0=A0=A0=A0 __le16 raw_wm;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 packet_size =3D inv_icm42600_get_packet_size(st->fifo.en);=
=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* get minimal latency, depending on sensor watermark and o=
dr */=0A=
=0A=
> +=A0=A0=A0=A0 wm_gyro =3D inv_icm42600_wm_truncate(st->fifo.watermark.gyr=
o,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 packet_size);=0A=
=0A=
> +=A0=A0=A0=A0 wm_accel =3D inv_icm42600_wm_truncate(st->fifo.watermark.ac=
cel,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 packet_size);=0A=
=0A=
> +=A0=A0=A0=A0 period_gyro =3D inv_icm42600_odr_to_period(st->conf.gyro.od=
r);=0A=
=0A=
> +=A0=A0=A0=A0 period_accel =3D inv_icm42600_odr_to_period(st->conf.accel.=
odr);=0A=
=0A=
> +=A0=A0=A0=A0 latency_gyro =3D (int64_t)period_gyro * (int64_t)wm_gyro;=
=0A=
=0A=
> +=A0=A0=A0=A0 latency_accel =3D (int64_t)period_accel * (int64_t)wm_accel=
;=0A=
=0A=
> +=A0=A0=A0=A0 if (latency_gyro =3D=3D 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency =3D latency_accel;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D wm_accel;=0A=
=0A=
> +=A0=A0=A0=A0 } else if (latency_accel =3D=3D 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency =3D latency_gyro;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D wm_gyro;=0A=
=0A=
> +=A0=A0=A0=A0 } else {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute the smallest latency tha=
t is a multiple of both */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (latency_gyro <=3D latency_accel=
) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency =3D=
 latency_gyro;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency -=
=3D latency_accel % latency_gyro;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency =3D=
 latency_accel;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency -=
=3D latency_gyro % latency_accel;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* use the shortest period */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (period_gyro <=3D period_accel)=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D =
period_gyro;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D =
period_accel;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* all this works because periods a=
re multiple of each others */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D div_s64(latency, peri=
od);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (watermark < 1)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =
=3D 1;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0 wm_size =3D watermark * packet_size;=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map), "watermark: %u (%zu)\n"=
,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark, wm_size);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* changing FIFO watermark requires to turn off watermark i=
nterrupt */=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN;=0A=
=0A=
> +=A0=A0=A0=A0 val =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits_check(st->map, INV_ICM42600_REG_=
INT_SOURCE0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask, val, &restore);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 raw_wm =3D INV_ICM42600_FIFO_WATERMARK_VAL(wm_size);=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_write(st->map, INV_ICM42600_REG_FIFO_WA=
TERMARK,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &raw_wm, sizeof(raw_wm));=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* restore watermark interrupt */=0A=
=0A=
> +=A0=A0=A0=A0 if (restore) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask =3D INV_ICM42600_INT_SOURCE0_F=
IFO_THS_INT1_EN;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val =3D INV_ICM42600_INT_SOURCE0_FI=
FO_THS_INT1_EN;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map,=
 INV_ICM42600_REG_INT_SOURCE0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sensor;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int *watermark;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sleep =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (indio_dev =3D=3D st->indio_gyro) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sensor =3D INV_ICM42600_SENSOR_GYRO=
;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D &st->fifo.watermark.g=
yro;=0A=
=0A=
> +=A0=A0=A0=A0 } else if (indio_dev =3D=3D st->indio_accel) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sensor =3D INV_ICM42600_SENSOR_ACCE=
L;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D &st->fifo.watermark.a=
ccel;=0A=
=0A=
> +=A0=A0=A0=A0 } else {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~=
sensor);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 *watermark =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_OFF;=0A=
=0A=
> +=A0=A0=A0=A0 if (sensor =3D=3D INV_ICM42600_SENSOR_GYRO)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(=
st, &conf, &sleep);=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_accel_conf=
(st, &conf, &sleep);=0A=
=0A=
> +=0A=
=0A=
> +out_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 if (sleep)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +const struct iio_buffer_setup_ops inv_icm42600_buffer_ops =3D {=0A=
=0A=
> +=A0=A0=A0=A0 .preenable =3D inv_icm42600_buffer_preenable,=0A=
=0A=
> +=A0=A0=A0=A0 .postenable =3D iio_triggered_buffer_postenable,=0A=
=0A=
> +=A0=A0=A0=A0 .predisable =3D iio_triggered_buffer_predisable,=0A=
=0A=
> +=A0=A0=A0=A0 .postdisable =3D inv_icm42600_buffer_postdisable,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 unsigned int max)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
=0A=
> +=A0=A0=A0=A0 __be16 raw_fifo_count;=0A=
=0A=
> +=A0=A0=A0=A0 size_t max_count;=0A=
=0A=
> +=A0=A0=A0=A0 ssize_t i, size;=0A=
=0A=
> +=A0=A0=A0=A0 const void *accel, *gyro, *temp, *timestamp;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int odr;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* reset all samples counters */=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.count =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.nb.gyro =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.nb.accel =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.nb.total =3D 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* compute maximum FIFO read size */=0A=
=0A=
> +=A0=A0=A0=A0 if (max =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_count =3D sizeof(st->fifo.data)=
;=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_count =3D max * inv_icm42600_ge=
t_packet_size(st->fifo.en);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* read FIFO count value */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COU=
NT,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 &raw_fifo_count, sizeof(raw_fifo_count));=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.count =3D be16_to_cpu(raw_fifo_count);=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(dev, "FIFO count =3D %zu\n", st->fifo.count);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* check and sanitize FIFO count value */=0A=
=0A=
> +=A0=A0=A0=A0 if (st->fifo.count =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=A0=A0=A0=A0 if (st->fifo.count > max_count)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.count =3D max_count;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* read all FIFO data in internal buffer */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_noinc_read(st->map, INV_ICM42600_REG_FIFO_DA=
TA,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 st->fifo.data, st->fifo.count);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* compute number of samples for each sensor */=0A=
=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < st->fifo.count; i +=3D size) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D inv_icm42600_fifo_decode_p=
acket(&st->fifo.data[i],=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &accel, &gyro, &temp, &timestamp, &odr);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size <=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gyro !=3D NULL && inv_icm42600_=
fifo_is_data_valid(gyro))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb=
.gyro++;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (accel !=3D NULL && inv_icm42600=
_fifo_is_data_valid(accel))=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb=
.accel++;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.total++;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 int64_t ts_gyro, ts_accel;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map), "FIFO flush %u\n", coun=
t);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ts_gyro =3D iio_get_time_ns(st->indio_gyro);=0A=
=0A=
> +=A0=A0=A0=A0 ts_accel =3D iio_get_time_ns(st->indio_accel);=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_fifo_read(st, count);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.total =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_parse_fifo(st->indio_gyro, ts_gyr=
o);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return inv_icm42600_accel_parse_fifo(st->indio_accel, ts_ac=
cel);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_init(struct inv_icm42600_state *st)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int mask, val;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /*=0A=
=0A=
> +=A0=A0=A0=A0=A0 * Default FIFO configuration (bits 7 to 5)=0A=
=0A=
> +=A0=A0=A0=A0=A0 * - use invalid value=0A=
=0A=
> +=A0=A0=A0=A0=A0 * - FIFO count in bytes=0A=
=0A=
> +=A0=A0=A0=A0=A0 * - FIFO count in big endian=0A=
=0A=
> +=A0=A0=A0=A0=A0 */=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D GENMASK(7, 5);=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_ENDIAN;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_C=
ONFIG0,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /*=0A=
=0A=
> +=A0=A0=A0=A0=A0 * Enable FIFO partial read and continuous watermark inte=
rrupt.=0A=
=0A=
> +=A0=A0=A0=A0=A0 * Disable all FIFO EN bits.=0A=
=0A=
> +=A0=A0=A0=A0=A0 */=0A=
=0A=
> +=A0=A0=A0=A0 mask =3D GENMASK(6, 5) | GENMASK(3, 0);=0A=
=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD |=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG1_WM_GT_TH;=0A=
=0A=
> +=A0=A0=A0=A0 return regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_CO=
NFIG1,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 mask, val);=0A=
=0A=
> +}=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..74b91c0e664b=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
=0A=
> @@ -0,0 +1,162 @@=0A=
=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
=0A=
> +/*=0A=
=0A=
> + * Copyright (C) 2020 Invensense, Inc.=0A=
=0A=
> + */=0A=
=0A=
> +=0A=
=0A=
> +#ifndef INV_ICM42600_BUFFER_H_=0A=
=0A=
> +#define INV_ICM42600_BUFFER_H_=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/kernel.h>=0A=
=0A=
> +#include <linux/bits.h>=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_state;=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_SENSOR_GYRO=A0=A0=A0=A0 BIT(0)=0A=
=0A=
> +#define INV_ICM42600_SENSOR_ACCEL=A0=A0=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_SENSOR_TEMP=A0=A0=A0=A0 BIT(2)=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_fifo {=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int en;=0A=
=0A=
> +=A0=A0=A0=A0 uint32_t period;=0A=
=0A=
> +=A0=A0=A0=A0 struct {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int gyro;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int accel;=0A=
=0A=
> +=A0=A0=A0=A0 } watermark;=0A=
=0A=
> +=A0=A0=A0=A0 size_t count;=0A=
=0A=
> +=A0=A0=A0=A0 struct {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t gyro;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t accel;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t total;=0A=
=0A=
> +=A0=A0=A0=A0 } nb;=0A=
=0A=
> +=A0=A0=A0=A0 uint8_t data[2080];=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +/* FIFO header: 1 byte */=0A=
=0A=
> +#define INV_ICM42600_FIFO_HEADER_MSG=A0=A0=A0=A0=A0=A0=A0=A0 BIT(7)=0A=
=0A=
> +#define INV_ICM42600_FIFO_HEADER_ACCEL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 BIT(6)=0A=
=0A=
> +#define INV_ICM42600_FIFO_HEADER_GYRO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 BIT(5)=0A=
=0A=
> +#define INV_ICM42600_FIFO_HEADER_TMST_FSYNC=A0 GENMASK(3, 2)=0A=
=0A=
> +#define INV_ICM42600_FIFO_HEADER_ODR_ACCEL=A0=A0 BIT(1)=0A=
=0A=
> +#define INV_ICM42600_FIFO_HEADER_ODR_GYRO=A0=A0=A0 BIT(0)=0A=
=0A=
> +=0A=
=0A=
> +/* FIFO data packet */=0A=
=0A=
> +struct inv_icm42600_fifo_sensor_data {=0A=
=0A=
> +=A0=A0=A0=A0 __be16 x;=0A=
=0A=
> +=A0=A0=A0=A0 __be16 y;=0A=
=0A=
> +=A0=A0=A0=A0 __be16 z;=0A=
=0A=
> +} __packed;=0A=
=0A=
> +#define INV_ICM42600_FIFO_DATA_INVALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -32768=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_fifo_1sensor_packet {=0A=
=0A=
> +=A0=A0=A0=A0 uint8_t header;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data data;=0A=
=0A=
> +=A0=A0=A0=A0 int8_t temp;=0A=
=0A=
> +} __packed;=0A=
=0A=
> +#define INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 8=0A=
=0A=
> +=0A=
=0A=
> +struct inv_icm42600_fifo_2sensors_packet {=0A=
=0A=
> +=A0=A0=A0=A0 uint8_t header;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data accel;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data gyro;=0A=
=0A=
> +=A0=A0=A0=A0 int8_t temp;=0A=
=0A=
> +=A0=A0=A0=A0 __be16 timestamp;=0A=
=0A=
> +} __packed;=0A=
=0A=
> +#define INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 16=0A=
=0A=
> +=0A=
=0A=
> +static inline int16_t inv_icm42600_fifo_get_sensor_data(__be16 d)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 return be16_to_cpu(d);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static inline bool=0A=
=0A=
> +inv_icm42600_fifo_is_data_valid(const struct inv_icm42600_fifo_sensor_da=
ta *s)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 int16_t x, y, z;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 x =3D inv_icm42600_fifo_get_sensor_data(s->x);=0A=
=0A=
> +=A0=A0=A0=A0 y =3D inv_icm42600_fifo_get_sensor_data(s->y);=0A=
=0A=
> +=A0=A0=A0=A0 z =3D inv_icm42600_fifo_get_sensor_data(s->z);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (x =3D=3D INV_ICM42600_FIFO_DATA_INVALID &&=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 y =3D=3D IN=
V_ICM42600_FIFO_DATA_INVALID &&=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 z =3D=3D IN=
V_ICM42600_FIFO_DATA_INVALID)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return true;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static inline ssize_t inv_icm42600_fifo_decode_packet(const void *packet=
,=0A=
=0A=
=0A=
=0A=
Bit big to be in the header..=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void **accel, const void **gy=
ro, const void **temp,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void **timestamp, unsigned in=
t *odr)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_fifo_1sensor_packet *pack1 =3D pa=
cket;=0A=
=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_fifo_2sensors_packet *pack2 =3D p=
acket;=0A=
=0A=
> +=A0=A0=A0=A0 uint8_t header =3D *((const uint8_t *)packet);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* FIFO empty */=0A=
=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_MSG) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *accel =3D NULL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *gyro =3D NULL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *temp =3D NULL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *timestamp =3D NULL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *odr =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* handle odr flags */=0A=
=0A=
> +=A0=A0=A0=A0 *odr =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_ODR_GYRO)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *odr |=3D INV_ICM42600_SENSOR_GYRO;=
=0A=
=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_ODR_ACCEL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *odr |=3D INV_ICM42600_SENSOR_ACCEL=
;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* accel + gyro */=0A=
=0A=
> +=A0=A0=A0=A0 if ((header & INV_ICM42600_FIFO_HEADER_ACCEL) &&=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (header & I=
NV_ICM42600_FIFO_HEADER_GYRO)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *accel =3D &pack2->accel;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *gyro =3D &pack2->gyro;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *temp =3D &pack2->temp;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *timestamp =3D &pack2->timestamp;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return INV_ICM42600_FIFO_2SENSORS_P=
ACKET_SIZE;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* accel only */=0A=
=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_ACCEL) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *accel =3D &pack1->data;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *gyro =3D NULL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *temp =3D &pack1->temp;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *timestamp =3D NULL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return INV_ICM42600_FIFO_1SENSOR_PA=
CKET_SIZE;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* gyro only */=0A=
=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_GYRO) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *accel =3D NULL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *gyro =3D &pack1->data;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *temp =3D &pack1->temp;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *timestamp =3D NULL;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return INV_ICM42600_FIFO_1SENSOR_PA=
CKET_SIZE;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* invalid packet if here */=0A=
=0A=
> +=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +extern const struct iio_buffer_setup_ops inv_icm42600_buffer_ops;=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_init(struct inv_icm42600_state *st);=0A=
=0A=
> +=0A=
=0A=
> +void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *s=
t);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int fifo_en);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st);=
=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 unsigned int max);=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count);=0A=
=0A=
> +=0A=
=0A=
> +#endif=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> index 1102c54396e3..689089065ff9 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
=0A=
> @@ -14,6 +14,7 @@=0A=
=0A=
>=A0 #include <linux/iio/iio.h>=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #include "inv_icm42600.h"=0A=
=0A=
> +#include "inv_icm42600_buffer.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] =3D =
{=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=0A=
=0A=
> @@ -515,6 +516,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip, int irq,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* setup FIFO buffer */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_init(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* setup interrupt trigger */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_trigger_init(st, irq, irq_type)=
;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> @@ -559,6 +565,16 @@ static int __maybe_unused inv_icm42600_suspend(struc=
t device *dev)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* disable FIFO data streaming */=0A=
=0A=
> +=A0=A0=A0=A0 if (iio_buffer_enabled(st->indio_gyro) ||=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_buffer_=
enabled(st->indio_accel)) {=0A=
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
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_=
SENSOR_MODE_OFF,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_O=
FF, false,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL);=0A=
=0A=
> @@ -594,6 +610,13 @@ static int __maybe_unused inv_icm42600_resume(struct=
 device *dev)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* restore FIFO data streaming */=0A=
=0A=
> +=A0=A0=A0=A0 if (iio_buffer_enabled(st->indio_gyro) ||=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_buffer_=
enabled(st->indio_accel)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_FIFO_CONFIG,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG_STREAM);=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
>=A0 out_unlock:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> index c0164ab2830e..dafb104abc77 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
=0A=
> @@ -10,9 +10,13 @@=0A=
=0A=
>=A0 #include <linux/regmap.h>=0A=
=0A=
>=A0 #include <linux/delay.h>=0A=
=0A=
>=A0 #include <linux/iio/iio.h>=0A=
=0A=
> +#include <linux/iio/buffer.h>=0A=
=0A=
> +#include <linux/iio/triggered_buffer.h>=0A=
=0A=
> +#include <linux/iio/trigger_consumer.h>=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #include "inv_icm42600.h"=0A=
=0A=
>=A0 #include "inv_icm42600_temp.h"=0A=
=0A=
> +#include "inv_icm42600_buffer.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> @@ -46,6 +50,7 @@ enum inv_icm42600_gyro_scan {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_Y,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_Z,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_TEMP,=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_GYRO_SCAN_TIMESTAMP,=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 static const struct iio_chan_spec_ext_info inv_icm42600_gyro_ext_infos=
[] =3D {=0A=
=0A=
> @@ -61,8 +66,100 @@ static const struct iio_chan_spec inv_icm42600_gyro_c=
hannels[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_GYRO_CHAN(IIO_MOD_Z, INV_ICM42600_GYRO_=
SCAN_Z,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 inv_icm42600_gyro_ext_infos),=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),=
=0A=
=0A=
> +=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42600_GYRO_SCAN_TIMESTAMP),=
=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
> +/* IIO buffer data */=0A=
=0A=
> +struct inv_icm42600_gyro_buffer {=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data gyro;=0A=
=0A=
> +=A0=A0=A0=A0 int8_t temp;=0A=
=0A=
> +=A0=A0=A0=A0 int64_t timestamp;=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_SCAN_MASK_GYRO_3AXIS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 (BIT(INV_ICM42600_GYRO_SCAN_X) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM42600_GYRO_SCAN_Y) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM42600_GYRO_SCAN_Z))=0A=
=0A=
> +=0A=
=0A=
> +#define INV_ICM42600_SCAN_MASK_TEMP=A0 BIT(INV_ICM42600_GYRO_SCAN_TEMP)=
=0A=
=0A=
> +=0A=
=0A=
> +static const unsigned long inv_icm42600_gyro_scan_masks[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis gyro + temperature */=0A=
=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SCAN_MASK_GYRO_3AXIS | INV_ICM42600_SCAN_MASK_=
TEMP,=0A=
=0A=
> +=A0=A0=A0=A0 0,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static irqreturn_t inv_icm42600_gyro_handler(int irq, void *_data)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_poll_func *pf =3D _data;=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_dev *indio_dev =3D pf->indio_dev;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 const size_t fifo_nb =3D st->fifo.nb.total;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* exit if no sample */=0A=
=0A=
> +=A0=A0=A0=A0 if (fifo_nb =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_parse_fifo(indio_dev, pf->timesta=
mp);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->map),=
 "gyro fifo error %d\n",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret);=0A=
=0A=
> +=0A=
=0A=
> +out:=0A=
=0A=
> +=A0=A0=A0=A0 iio_trigger_notify_done(indio_dev->trig);=0A=
=0A=
> +=A0=A0=A0=A0 return IRQ_HANDLED;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +/* enable gyroscope sensor and FIFO write */=0A=
=0A=
> +static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const unsigned long =
*scan_mask)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int fifo_en =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sleep_gyro =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sleep_temp =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int sleep;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable temp sensor */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_temp_conf(=
st, true, &sleep_temp);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_en |=3D INV_ICM42600_SENSOR_TE=
MP;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_GYRO_3AXIS) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable gyro sensor */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf.mode =3D INV_ICM42600_SENSOR_M=
ODE_LOW_NOISE;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(=
st, &conf, &sleep_gyro);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_en |=3D INV_ICM42600_SENSOR_GY=
RO;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* update data FIFO write and FIFO watermark */=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->f=
ifo.en);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
=0A=
=0A=
blank line=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
> +=0A=
=0A=
> +out_unlock:=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=A0=A0=A0=A0 /* sleep maximum required time */=0A=
=0A=
> +=A0=A0=A0=A0 if (sleep_gyro > sleep_temp)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_gyro;=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_temp;=0A=
=0A=
> +=A0=A0=A0=A0 if (sleep)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep);=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 if (sleep_gyro > sleep_temp)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep_gyro);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 else=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep_temp);=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
>=A0 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st=
,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const=
 *chan,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int16_t *val)=0A=
=0A=
> @@ -262,6 +359,8 @@ static int inv_icm42600_gyro_write_odr(struct inv_icm=
42600_state *st,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 conf.odr =3D inv_icm42600_gyro_odr_conv[idx / 2];=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=
=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_fifo_period(st);=0A=
=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
=0A=
> @@ -524,12 +623,51 @@ static int inv_icm42600_gyro_write_raw_get_fmt(stru=
ct iio_dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> +static int inv_icm42600_gyro_hwfifo_set_watermark(struct iio_dev *indio_=
dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned=
 int val)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 st->fifo.watermark.gyro =3D val;=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static int inv_icm42600_gyro_hwfifo_flush(struct iio_dev *indio_dev,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 if (count =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_hwfifo_flush(st, count);=0A=
=0A=
> +=A0=A0=A0=A0 if (!ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D st->fifo.nb.gyro;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
>=A0 static const struct iio_info inv_icm42600_gyro_info =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D inv_icm42600_gyro_read_raw,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .read_avail =3D inv_icm42600_gyro_read_avail,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .write_raw =3D inv_icm42600_gyro_write_raw,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .write_raw_get_fmt =3D inv_icm42600_gyro_write_raw_g=
et_fmt,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 .debugfs_reg_access =3D inv_icm42600_debugfs_reg,=0A=
=0A=
> +=A0=A0=A0=A0 .update_scan_mode =3D inv_icm42600_gyro_update_scan_mode,=
=0A=
=0A=
> +=A0=A0=A0=A0 .hwfifo_set_watermark =3D inv_icm42600_gyro_hwfifo_set_wate=
rmark,=0A=
=0A=
> +=A0=A0=A0=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_gyro_hwfifo_flush,=
=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st)=0A=
=0A=
> @@ -537,6 +675,7 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state =
*st)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const char *name;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev;=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", =
st->name);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!name)=0A=
=0A=
> @@ -553,7 +692,51 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state=
 *st)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_icm42600_gyro_channels;=
=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42600_=
gyro_channels);=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->available_scan_masks =3D inv_icm42600_gyro_scan_=
masks;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NUL=
L,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv_icm42600_gyro_ha=
ndler,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &inv_icm42600_buffer=
_ops);=0A=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 indio_dev->trig =3D iio_trigger_get(st->trigger);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 st->indio_gyro =3D indio_dev;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return devm_iio_device_register(dev, st->indio_gyro)=
;=0A=
=0A=
>=A0 }=0A=
=0A=
> +=0A=
=0A=
> +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev, int64_t ts)=
=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
=0A=
> +=A0=A0=A0=A0 const size_t gyro_nb =3D st->fifo.nb.gyro;=0A=
=0A=
> +=A0=A0=A0=A0 ssize_t i, size;=0A=
=0A=
> +=A0=A0=A0=A0 const void *accel, *gyro, *temp, *timestamp;=0A=
=0A=
> +=A0=A0=A0=A0 unsigned int odr;=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_gyro_buffer buffer;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* exit if no gyro sample */=0A=
=0A=
> +=A0=A0=A0=A0 if (gyro_nb =3D=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* parse all fifo packets */=0A=
=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < st->fifo.count; i +=3D size) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D inv_icm42600_fifo_decode_p=
acket(&st->fifo.data[i],=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &accel, &gyro, &temp, &timestamp, &odr);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map),=
 "gyro packet size =3D %zd\n",=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* quit if error or FIFO is empty *=
/=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size <=3D 0)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return size=
;=0A=
=0A=
=0A=
=0A=
blank line here.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* skip packet if no gyro data or d=
ata is invalid */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gyro =3D=3D NULL || !inv_icm426=
00_fifo_is_data_valid(gyro)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(reg=
map_get_device(st->map), "skip gyro data\n");=0A=
=0A=
=0A=
=0A=
Very noisy logging. I'd drop it for the final version of the driver.=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.gyro, gyro, sizeof(b=
uffer.gyro));=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.temp, temp, sizeof(b=
uffer.temp));=0A=
=0A=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buffer.temp =3D temp;=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timestamp(=
indio_dev, &buffer, ts);=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c b/driver=
s/iio/imu/inv_icm42600/inv_icm42600_trigger.c=0A=
=0A=
> index 7a5e76305f0b..5667e0204722 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c=0A=
=0A=
> @@ -13,6 +13,7 @@=0A=
=0A=
>=A0 #include <linux/iio/trigger_consumer.h>=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 #include "inv_icm42600.h"=0A=
=0A=
> +#include "inv_icm42600_buffer.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 static irqreturn_t inv_icm42600_trigger_timestamp(int irq, void *_data=
)=0A=
=0A=
>=A0 {=0A=
=0A=
> @@ -45,8 +46,18 @@ static irqreturn_t inv_icm42600_trigger_int_handler(in=
t irq, void *_data)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev, "FIFO full dat=
a lost!\n");=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* FIFO threshold reached */=0A=
=0A=
> -=A0=A0=A0=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_THS)=0A=
=0A=
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_trigger_poll_chained(st->trigge=
r);=0A=
=0A=
> +=A0=A0=A0=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_THS) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_fifo_re=
ad(st, 0);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev=
, "FIFO read error %d\n", ret);=0A=
=0A=
> +=A0=A0=A0=A0 } else {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.count =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.gyro =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.accel =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.total =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 iio_trigger_poll_chained(st->trigger);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 out_unlock:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
