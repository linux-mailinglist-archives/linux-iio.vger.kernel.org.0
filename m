Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794111ED254
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgFCOsM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 10:48:12 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:7484 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgFCOsL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2020 10:48:11 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053ElG9c024803;
        Wed, 3 Jun 2020 07:47:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=PehGAj9sTs/+geTNb0IiX+UyRZAOV6mB9UBQ31YpJXo=;
 b=PIzmA1eX3yNJ55MAdtwgfsTQlxz3wZlFPEONyHxEdt7V9h3p4Squg82VBhJIzt+vgPvO
 lAiSujp6DQt6VXVOaE9hlfNmI4k4JN5AjrLIqQ08p+1XLFqD2D4D22M1IKuad2VLyLvd
 KAJeyC1ztt2bhLaVB2WnPmd5tMy++PTpAsuXlpLeeF/M41krf+8d61pPA86Svw/RoaKT
 FlbVKAwjtf2VYvSccYqv/h5735cGpweQmQbmtkMQZsZ3RHkrdYegkT0Qp823Szai6jMi
 eKLsSfSMIQ3j+3akc0MPGFr8yrs3AYvuW4YJ1mEYf+irSjx+zugZ8KeLR4Vlnt2Z7o9n BA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0b-00328301.pphosted.com with ESMTP id 31bken1qw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 07:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTxLJqodrK9o/SmqqSJRHRykEhh2HcqkGZJsD1mO149aGb1yfUfxm1YXUkU6rDsoefFPv1xPEEjdhJU+5qICQBw8xWXzAvjHl02ZtE0V9Q7my8IIRnsn4YhUty0nC0WTWGqnwUPmxVXgNdFGKjdAp3Sc6kldGEC1hWR0lDbHDWU8S3VHyZShNOvfXSURicj/7J6bx3aYydYV/xRGn3D8oeSJgTa4nQi9Ub9MhmlwzQ6TmC1PMU+IeHLjOxDS8EGjBSqOj9lo8FFNWvw3cDoIbR1xdPxK9E34F8lO9UzSZpUMfZJriHA5sWfK3ZF6QwdnZom3hneLEsH9ijLBgQ9jbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PehGAj9sTs/+geTNb0IiX+UyRZAOV6mB9UBQ31YpJXo=;
 b=T30rkgGvCGbtsxIwG9UD0iPRR9r/S8plVAUCYxLNkCNZYs0shtRVlHabsUsPuy6KIx709TDnNPiyBRriJpJfMip4LX3LYpV05X7ZzU9ia+wetobaUJy/FjMLN78xmru7ciApwKPT6qDWjOwCWRoXodm24nlEZwmZ3Lw5MBd0ESAif6lHfNYAyU0OroZwAFTfC0UzzqwYPPHwcTeQJ/MsmEi17sEx6D8lBwEw+LT1l1eCFcEsekJmRakOK5SJHZ/ZDCuox9S/jgDEQwMjcjbz/lVY3zeVvaJA1e7PSd0Xdl3imVinwPnyIu+HaplobhHQxiPtWDqyK0abDlNA3bUoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PehGAj9sTs/+geTNb0IiX+UyRZAOV6mB9UBQ31YpJXo=;
 b=IUonKGTCnCsAYJ6jRt4X0MjL3xvio9mQbLNjHjznTm6zFhAJRd/oyM7Ai1pH8tE77/7mquC6ttZGoUL3Yn/GUqC+L10DXFNdK3gg3IKTw4QmEDuAQzP2ILj25QSirg8WFckBAQynlwsPSVyMSLqXexjaH5nE74i+kannrhDZuPE=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB2991.namprd12.prod.outlook.com (2603:10b6:208:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 3 Jun
 2020 14:47:54 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 14:47:54 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: --[[SPOOF or PHISHING]]--Re: [PATCH v2 09/12] iio: imu:
 inv_icm42600: add buffer support in iio devices
Thread-Topic: --[[SPOOF or PHISHING]]--Re: [PATCH v2 09/12] iio: imu:
 inv_icm42600: add buffer support in iio devices
Thread-Index: AQHWNFi6tZLv5q9Ga0evfLk0+jR/7qjCLRmAgAMbqbGAAdtM1g==
Date:   Wed, 3 Jun 2020 14:47:54 +0000
Message-ID: <MN2PR12MB44229D20257EFE54D1943366C4880@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
        <20200527185711.21331-10-jmaneyrol@invensense.com>,<20200531135615.7938fb96@archlinux>,<MN2PR12MB4422CB235D2E2F0C37E86C37C48B0@MN2PR12MB4422.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4422CB235D2E2F0C37E86C37C48B0@MN2PR12MB4422.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57cf07f4-e8fc-4291-7691-08d807cd193d
x-ms-traffictypediagnostic: MN2PR12MB2991:
x-microsoft-antispam-prvs: <MN2PR12MB299129CB665E5FFF3DF183E1C4880@MN2PR12MB2991.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: haG39AgFYUEBilPRGNVXhnNxhNSIZpQ7lRviKd1W9esvApYe4RtpX53R5xxrSyNqN6CsL23Xuy1KoRSN2LJbS9OEhXliA5jyuvqmajxquG4lr+WuhERO17Yo5KyFo8yv5GkXmj6d23scAkX/YBhBbPQLMHgU14PI3CNEa+n8vrr+ntnaCxFiNhkI0n5NYhf3PRHHDN1anadB7eUe2b9LxUsgG61zyEUcTUkpeYjgWGX8RQUOKZS25oHNhQp+vfbp1l2/hVyH88y9jIwYmTMZGLFBZ2aRQUo67BaSVvsbnYQ6tC3MDXGgNN8fSozYDt46S/N+GlA7z3lP+/6YognqOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(396003)(136003)(346002)(376002)(366004)(478600001)(7696005)(6916009)(2906002)(26005)(55016002)(83380400001)(30864003)(33656002)(5660300002)(186003)(316002)(53546011)(66946007)(86362001)(71200400001)(6506007)(54906003)(52536014)(91956017)(64756008)(8936002)(4326008)(66556008)(9686003)(8676002)(66446008)(76116006)(66476007)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SamscQ8KBAFWn4mA5/jfGOOOMMbKPVg60I2q18MmGpLOFtLp6WbyVsyua0DoTf30wJV0xNMv5leLAhBG5dltM1ppFe6Ixz+QoAjmhLM4iR6U34ikdj6obWWwrhsNwaohi3aG4IXRiLqYV9jwA16PDTKry0DZpVmPlKrsGgC/AsQyC4ayOSUdGA8Ni6u2K3+tlP6nVU5cX5rMyLHeuQRufaORuJ0gQ4cG5CvLko0jrERAxr7k8P/6toI4/YwFME6tJOO91ulsuZBi5GnshxYJNubrkASa6KPaA4B55M+LbiHmM94VanHRenjW1M7CkGrspAzNqo6TPkl/I4K8ciyi9pc8afhcvRZ21AETsfLNK+eCa6Nwjpma3YNItSUN2fat4osqC/T0v7+a2bC/+qDnDVrzRNG0P/RTkCaKkiRgSYw4NlN509kuqnOqMGw4R51qDezydLq8mDU6hQtJfiEm/uzyJT6+Y6M6B7gx/dt+IaE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cf07f4-e8fc-4291-7691-08d807cd193d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 14:47:54.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpW7+pWXASIATB7CYbQNYsyQvP9eq9GvTqrMul26qVdnLsZzdP6zS8yKwSI3hCLrOM7Xr2/Yn5xYcvXqpSjjdgqdAy4E/e/yVmBWZ78Ot1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2991
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_13:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 cotscore=-2147483648
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006030118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
something I forgot, about the __packed attribute for the sensor data struct=
ure struct inv_icm42600_fifo_sensor_data located inside inv_icm42600_buffer=
.h.=0A=
=0A=
I added it because this structure is used for decoding the FIFO data frame =
which can be unaligned. It is also used for storing data in other modules, =
but __packed attribute should not change anything here.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Sent: Tuesday, June 2, 2020 14:57=0A=
To: Jonathan Cameron <jic23@kernel.org>=0A=
Cc: robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <robh@kernel.o=
rg>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; davem@davemloft=
.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh@linuxfoundat=
ion.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree=
@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>=0A=
Subject: --[[SPOOF or PHISHING]]--Re: [PATCH v2 09/12] iio: imu: inv_icm426=
00: add buffer support in iio devices =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
Hi Jonathan,=0A=
=0A=
I agree that this multiplexed watermark computation value is anything excep=
t simple and clear to understand.=0A=
I will add more documentation about it. And it also triggered a kbuild robo=
t issue, because it is using 64 bits modulo without using math64 macros.=0A=
=0A=
For buffer preenable/postenable/..., the sequence I am using currently is:=
=0A=
- preenable -> turn chip on (pm_runtime_get)=0A=
- update_scan_mode -> set FIFO en bits configuration (which sensor data is =
going into the fifo)=0A=
- hwfifo_watermark -> compute and set watermark value=0A=
- postenable -> turn FIFO on (and multiplexed with a FIFO on counter since =
used by accel & gyro)=0A=
- predisable -> turn FIFO off (multiplexed with counter)=0A=
- postdisable -> turn chip off (pm_runtime_put)=0A=
=0A=
This setting is working well. Good to note that if there is an error when e=
nabling the buffer, postdisable will always get called after preenable. So =
it ensures pm_runtime reference counter to be always OK.=0A=
=0A=
Another way would be to only store configuration in internal state with upd=
ate_scan_mode and hwfifo_watermark, and do everything in postenable/predisa=
ble. This is a possibility, but makes things a little more complex.=0A=
=0A=
For hwfifo flush, this is an interesting feature when there is a need to ha=
ve data immediately. Or when there is a need to do a clean change of config=
uration. In Android systems, Android framework is mainly using FIFO flush t=
o change the sensor configuration (ODR, watermark) in a clean way. For our =
case with the FIFO interleaved this is a not an issue. If there are samples=
 from the 2 sensors, it means the 2 buffers are enabled. And if data is com=
ing to the iio buffer sooner than expected, that should not be a problem. T=
he limitation I see when the 2 sensors are runnings, is that we will return=
 less data than should have been possible. I limit FIFO reading to the prov=
ided n bytes, so we could read less than n samples of 1 sensor.=0A=
=0A=
Something I have in mind, that would be really interesting to be able to se=
t/change watermark value when the buffer is enabled. Otherwise, we are alwa=
ys loosing events by turning sensor off when we want to change the value. I=
s there any limitation to work this way, or should it be possible to implem=
ent this feature in the future ?=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, May 31, 2020 14:56=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Cc: robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <robh@kernel.o=
rg>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; davem@davemloft=
.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh@linuxfoundat=
ion.org>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree=
@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>=0A=
Subject: Re: [PATCH v2 09/12] iio: imu: inv_icm42600: add buffer support in=
 iio devices =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Wed, 27 May 2020 20:57:08 +0200=0A=
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
> Add all FIFO parsing and reading functions. Add accel and gyro=0A=
> kfifo buffer and FIFO data parsing. Use device interrupt for=0A=
> reading data FIFO and launching accel and gyro parsing.=0A=
> =0A=
> Support hwfifo watermark by multiplexing gyro and accel settings.=0A=
> Support hwfifo flush.=0A=
=0A=
Both of these are complex given the interactions of the two sensors=0A=
types and to be honest I couldn't figure out exactly what the intent was.=
=0A=
Needs more docs!=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
> ---=0A=
>=A0 drivers/iio/imu/inv_icm42600/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 1 +=0A=
>=A0 drivers/iio/imu/inv_icm42600/Makefile=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 =
1 +=0A=
>=A0 drivers/iio/imu/inv_icm42600/inv_icm42600.h=A0=A0 |=A0=A0 8 +=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 160 ++++-=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_buffer.c=A0=A0=A0 | 555 ++++++++++++=
++++++=0A=
>=A0 .../imu/inv_icm42600/inv_icm42600_buffer.h=A0=A0=A0 |=A0 98 ++++=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_core.c=A0 |=A0 30 +=0A=
>=A0 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c=A0 | 160 ++++-=0A=
>=A0 8 files changed, 1011 insertions(+), 2 deletions(-)=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h=
=0A=
> =0A=
> diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_i=
cm42600/Kconfig=0A=
> index 22390a72f0a3..50cbcfcb6cf1 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/Kconfig=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Kconfig=0A=
> @@ -2,6 +2,7 @@=0A=
>=A0 =0A=
>=A0 config INV_ICM42600=0A=
>=A0=A0=A0=A0=A0=A0=A0 tristate=0A=
> +=A0=A0=A0=A0 select IIO_BUFFER=0A=
>=A0 =0A=
>=A0 config INV_ICM42600_I2C=0A=
>=A0=A0=A0=A0=A0=A0=A0 tristate "InvenSense ICM-426xx I2C driver"=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_=
icm42600/Makefile=0A=
> index 48965824f00c..0f49f6df3647 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/Makefile=0A=
> +++ b/drivers/iio/imu/inv_icm42600/Makefile=0A=
> @@ -5,6 +5,7 @@ inv-icm42600-y +=3D inv_icm42600_core.o=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_gyro.o=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_accel.o=0A=
>=A0 inv-icm42600-y +=3D inv_icm42600_temp.o=0A=
> +inv-icm42600-y +=3D inv_icm42600_buffer.o=0A=
>=A0 =0A=
>=A0 obj-$(CONFIG_INV_ICM42600_I2C) +=3D inv-icm42600-i2c.o=0A=
>=A0 inv-icm42600-i2c-y +=3D inv_icm42600_i2c.o=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h=0A=
> index 43749f56426c..4d5811562a61 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h=0A=
> @@ -14,6 +14,8 @@=0A=
>=A0 #include <linux/pm.h>=0A=
>=A0 #include <linux/iio/iio.h>=0A=
>=A0 =0A=
> +#include "inv_icm42600_buffer.h"=0A=
> +=0A=
>=A0 enum inv_icm42600_chip {=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42600,=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_CHIP_ICM42602,=0A=
> @@ -123,6 +125,7 @@ struct inv_icm42600_suspended {=0A=
>=A0=A0 *=A0 @indio_gyro:=A0=A0=A0=A0 gyroscope IIO device.=0A=
>=A0=A0 *=A0 @indio_accel:=A0=A0=A0 accelerometer IIO device.=0A=
>=A0=A0 *=A0 @buffer:=A0=A0=A0=A0=A0=A0=A0=A0 data transfer buffer aligned =
for DMA.=0A=
> + *=A0 @fifo:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FIFO management structure.=0A=
>=A0=A0 */=0A=
>=A0 struct inv_icm42600_state {=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
> @@ -137,6 +140,7 @@ struct inv_icm42600_state {=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_gyro;=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_accel;=0A=
>=A0=A0=A0=A0=A0=A0=A0 uint8_t buffer[2] ____cacheline_aligned;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo fifo;=0A=
>=A0 };=0A=
>=A0 =0A=
>=A0 /* Virtual register addresses: @bank on MSB (4 upper bits), @address o=
n LSB */=0A=
> @@ -377,6 +381,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip, int irq,=0A=
>=A0 =0A=
>=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);=0A=
>=A0 =0A=
> +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev);=0A=
> +=0A=
>=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st);=0A=
>=A0 =0A=
> +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);=0A=
> +=0A=
>=A0 #endif=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> index 6a615d7ffb24..c73ce204efc6 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c=0A=
> @@ -11,9 +11,12 @@=0A=
>=A0 #include <linux/delay.h>=0A=
>=A0 #include <linux/math64.h>=0A=
>=A0 #include <linux/iio/iio.h>=0A=
> +#include <linux/iio/buffer.h>=0A=
> +#include <linux/iio/kfifo_buf.h>=0A=
>=A0 =0A=
>=A0 #include "inv_icm42600.h"=0A=
>=A0 #include "inv_icm42600_temp.h"=0A=
> +#include "inv_icm42600_buffer.h"=0A=
>=A0 =0A=
>=A0 #define INV_ICM42600_ACCEL_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> @@ -64,6 +67,76 @@ static const struct iio_chan_spec inv_icm42600_accel_c=
hannels[] =3D {=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_TEMP_CHAN(INV_ICM42600_ACCEL_SCAN_TEMP)=
,=0A=
>=A0 };=0A=
>=A0 =0A=
> +/* IIO buffer data: 8 bytes */=0A=
> +struct inv_icm42600_accel_buffer {=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data accel;=0A=
> +=A0=A0=A0=A0 int8_t temp;=0A=
> +=A0=A0=A0=A0 uint8_t padding;=0A=
> +};=0A=
> +=0A=
> +#define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0 (BIT(INV_ICM42600_ACCEL_SCAN_X) |=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM42600_ACCEL_SCAN_Y) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM42600_ACCEL_SCAN_Z))=0A=
> +=0A=
> +#define INV_ICM42600_SCAN_MASK_TEMP=A0 BIT(INV_ICM42600_ACCEL_SCAN_TEMP)=
=0A=
> +=0A=
> +static const unsigned long inv_icm42600_accel_scan_masks[] =3D {=0A=
> +=A0=A0=A0=A0 /* 3-axis accel + temperature */=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SCAN_MASK_ACCEL_3AXIS | INV_ICM42600_SCAN_MASK=
_TEMP,=0A=
> +=A0=A0=A0=A0 0,=0A=
> +};=0A=
> +=0A=
> +/* enable accelerometer sensor and FIFO write */=0A=
> +static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev=
,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const unsigned lo=
ng *scan_mask)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
> +=A0=A0=A0=A0 unsigned int fifo_en =3D 0;=0A=
> +=A0=A0=A0=A0 unsigned int sleep_temp =3D 0;=0A=
> +=A0=A0=A0=A0 unsigned int sleep_accel =3D 0;=0A=
> +=A0=A0=A0=A0 unsigned int sleep;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable temp sensor */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_temp_conf(=
st, true, &sleep_temp);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_en |=3D INV_ICM42600_SENSOR_TE=
MP;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_ACCEL_3AXIS) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable accel sensor */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf.mode =3D INV_ICM42600_SENSOR_M=
ODE_LOW_NOISE;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_accel_conf=
(st, &conf, &sleep_accel);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_en |=3D INV_ICM42600_SENSOR_AC=
CEL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* update data FIFO write */=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->f=
ifo.en);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
> +=0A=
> +out_unlock:=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 /* sleep maximum required time */=0A=
> +=A0=A0=A0=A0 if (sleep_accel > sleep_temp)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_accel;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_temp;=0A=
> +=A0=A0=A0=A0 if (sleep)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep);=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
>=A0 static int inv_icm42600_accel_read_sensor(struct inv_icm42600_state *s=
t,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec co=
nst *chan,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int16_t *val)=0A=
> @@ -248,7 +321,12 @@ static int inv_icm42600_accel_write_odr(struct inv_i=
cm42600_state *st,=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_accel_conf(st, &conf, NULL)=
;=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_fifo_period(st);=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_watermark(st);=0A=
>=A0 =0A=
> +out_unlock:=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
>=A0=A0=A0=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
>=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
> @@ -563,12 +641,51 @@ static int inv_icm42600_accel_write_raw_get_fmt(str=
uct iio_dev *indio_dev,=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 }=0A=
>=A0 =0A=
> +static int inv_icm42600_accel_hwfifo_set_watermark(struct iio_dev *indio=
_dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsig=
ned int val)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 st->fifo.watermark.accel =3D val;=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_accel_hwfifo_flush(struct iio_dev *indio_dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (count =3D=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_hwfifo_flush(st, count);=0A=
> +=A0=A0=A0=A0 if (!ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D st->fifo.nb.accel;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
>=A0 static const struct iio_info inv_icm42600_accel_info =3D {=0A=
>=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D inv_icm42600_accel_read_raw,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .read_avail =3D inv_icm42600_accel_read_avail,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .write_raw =3D inv_icm42600_accel_write_raw,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .write_raw_get_fmt =3D inv_icm42600_accel_write_raw_=
get_fmt,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .debugfs_reg_access =3D inv_icm42600_debugfs_reg,=0A=
> +=A0=A0=A0=A0 .update_scan_mode =3D inv_icm42600_accel_update_scan_mode,=
=0A=
> +=A0=A0=A0=A0 .hwfifo_set_watermark =3D inv_icm42600_accel_hwfifo_set_wat=
ermark,=0A=
> +=A0=A0=A0=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_accel_hwfifo_flush=
,=0A=
>=A0 };=0A=
>=A0 =0A=
>=A0 int inv_icm42600_accel_init(struct inv_icm42600_state *st)=0A=
> @@ -576,6 +693,7 @@ int inv_icm42600_accel_init(struct inv_icm42600_state=
 *st)=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const char *name;=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev;=0A=
> +=A0=A0=A0=A0 struct iio_buffer *buffer;=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-accel",=
 st->name);=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!name)=0A=
> @@ -585,14 +703,54 @@ int inv_icm42600_accel_init(struct inv_icm42600_sta=
te *st)=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!indio_dev)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 buffer =3D devm_iio_kfifo_allocate(dev);=0A=
> +=A0=A0=A0=A0 if (!buffer)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 iio_device_set_drvdata(indio_dev, st);=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->dev.parent =3D dev;=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->name =3D name;=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->info =3D &inv_icm42600_accel_info;=0A=
> -=A0=A0=A0=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
> +=A0=A0=A0=A0 indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTW=
ARE;=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_icm42600_accel_channels;=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42600_=
accel_channels);=0A=
> +=A0=A0=A0=A0 indio_dev->available_scan_masks =3D inv_icm42600_accel_scan=
_masks;=0A=
> +=A0=A0=A0=A0 indio_dev->setup_ops =3D &inv_icm42600_buffer_ops;=0A=
> +=0A=
> +=A0=A0=A0=A0 iio_device_attach_buffer(indio_dev, buffer);=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 st->indio_accel =3D indio_dev;=0A=
>=A0=A0=A0=A0=A0=A0=A0 return devm_iio_device_register(dev, st->indio_accel=
);=0A=
>=A0 }=0A=
> +=0A=
> +int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 ssize_t i, size;=0A=
> +=A0=A0=A0=A0 const void *accel, *gyro, *timestamp;=0A=
> +=A0=A0=A0=A0 const int8_t *temp;=0A=
> +=A0=A0=A0=A0 unsigned int odr;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_accel_buffer buffer =3D {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .padding =3D 0,=0A=
> +=A0=A0=A0=A0 };=0A=
> +=0A=
> +=A0=A0=A0=A0 /* parse all fifo packets */=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < st->fifo.count; i +=3D size) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D inv_icm42600_fifo_decode_p=
acket(&st->fifo.data[i],=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &accel, &gyro, &temp, &timestamp, &odr);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* quit if error or FIFO is empty *=
/=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size <=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return size=
;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* skip packet if no accel data or =
data is invalid */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (accel =3D=3D NULL || !inv_icm42=
600_fifo_is_data_valid(accel))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;=
=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* fill and push data buffer */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.accel, accel, sizeof=
(buffer.accel));=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buffer.temp =3D temp ? *temp : 0;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers(indio_dev, &buf=
fer);=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> new file mode 100644=0A=
> index 000000000000..c91075f62231=0A=
> --- /dev/null=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c=0A=
> @@ -0,0 +1,555 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-or-later=0A=
> +/*=0A=
> + * Copyright (C) 2020 Invensense, Inc.=0A=
> + */=0A=
> +=0A=
> +#include <linux/kernel.h>=0A=
> +#include <linux/device.h>=0A=
> +#include <linux/mutex.h>=0A=
> +#include <linux/pm_runtime.h>=0A=
> +#include <linux/regmap.h>=0A=
> +#include <linux/delay.h>=0A=
> +#include <linux/math64.h>=0A=
> +#include <linux/iio/iio.h>=0A=
> +#include <linux/iio/buffer.h>=0A=
> +=0A=
> +#include "inv_icm42600.h"=0A=
> +#include "inv_icm42600_buffer.h"=0A=
> +=0A=
> +/* FIFO header: 1 byte */=0A=
> +#define INV_ICM42600_FIFO_HEADER_MSG=A0=A0=A0=A0=A0=A0=A0=A0 BIT(7)=0A=
> +#define INV_ICM42600_FIFO_HEADER_ACCEL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 BIT(6)=0A=
> +#define INV_ICM42600_FIFO_HEADER_GYRO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 BIT(5)=0A=
> +#define INV_ICM42600_FIFO_HEADER_TMST_FSYNC=A0 GENMASK(3, 2)=0A=
> +#define INV_ICM42600_FIFO_HEADER_ODR_ACCEL=A0=A0 BIT(1)=0A=
> +#define INV_ICM42600_FIFO_HEADER_ODR_GYRO=A0=A0=A0 BIT(0)=0A=
> +=0A=
> +struct inv_icm42600_fifo_1sensor_packet {=0A=
> +=A0=A0=A0=A0 uint8_t header;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data data;=0A=
> +=A0=A0=A0=A0 int8_t temp;=0A=
> +} __packed;=0A=
> +#define INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 8=0A=
> +=0A=
> +struct inv_icm42600_fifo_2sensors_packet {=0A=
> +=A0=A0=A0=A0 uint8_t header;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data accel;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data gyro;=0A=
> +=A0=A0=A0=A0 int8_t temp;=0A=
> +=A0=A0=A0=A0 __be16 timestamp;=0A=
> +} __packed;=0A=
> +#define INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 16=0A=
> +=0A=
> +ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void *=
*accel,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void **gyro, const int8_t **temp=
,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void **timestamp, unsigned int *=
odr)=0A=
> +{=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_fifo_1sensor_packet *pack1 =3D pa=
cket;=0A=
> +=A0=A0=A0=A0 const struct inv_icm42600_fifo_2sensors_packet *pack2 =3D p=
acket;=0A=
> +=A0=A0=A0=A0 uint8_t header =3D *((const uint8_t *)packet);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* FIFO empty */=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_MSG) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *accel =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *gyro =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *temp =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *timestamp =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *odr =3D 0;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* handle odr flags */=0A=
> +=A0=A0=A0=A0 *odr =3D 0;=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_ODR_GYRO)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *odr |=3D INV_ICM42600_SENSOR_GYRO;=
=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_ODR_ACCEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *odr |=3D INV_ICM42600_SENSOR_ACCEL=
;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* accel + gyro */=0A=
> +=A0=A0=A0=A0 if ((header & INV_ICM42600_FIFO_HEADER_ACCEL) &&=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0 (header & INV_ICM42600_FIFO_HEADER_GYRO)) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *accel =3D &pack2->accel;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *gyro =3D &pack2->gyro;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *temp =3D &pack2->temp;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *timestamp =3D &pack2->timestamp;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return INV_ICM42600_FIFO_2SENSORS_P=
ACKET_SIZE;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* accel only */=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_ACCEL) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *accel =3D &pack1->data;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *gyro =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *temp =3D &pack1->temp;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *timestamp =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return INV_ICM42600_FIFO_1SENSOR_PA=
CKET_SIZE;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* gyro only */=0A=
> +=A0=A0=A0=A0 if (header & INV_ICM42600_FIFO_HEADER_GYRO) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *accel =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *gyro =3D &pack1->data;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *temp =3D &pack1->temp;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *timestamp =3D NULL;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return INV_ICM42600_FIFO_1SENSOR_PA=
CKET_SIZE;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* invalid packet if here */=0A=
> +=A0=A0=A0=A0 return -EINVAL;=0A=
> +}=0A=
> +=0A=
> +void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *s=
t)=0A=
> +{=0A=
> +=A0=A0=A0=A0 uint32_t period_gyro, period_accel, period;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (st->fifo.en & INV_ICM42600_SENSOR_GYRO)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_gyro =3D inv_icm42600_odr_to=
_period(st->conf.gyro.odr);=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_gyro =3D U32_MAX;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (st->fifo.en & INV_ICM42600_SENSOR_ACCEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_accel =3D inv_icm42600_odr_t=
o_period(st->conf.accel.odr);=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_accel =3D U32_MAX;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (period_gyro <=3D period_accel)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D period_gyro;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D period_accel;=0A=
> +=0A=
> +=A0=A0=A0=A0 st->fifo.period =3D period;=0A=
> +}=0A=
> +=0A=
> +int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int fifo_en)=0A=
> +{=0A=
> +=A0=A0=A0=A0 unsigned int mask, val;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* update only FIFO EN bits */=0A=
> +=A0=A0=A0=A0 mask =3D INV_ICM42600_FIFO_CONFIG1_TMST_FSYNC_EN |=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG1_TEMP_EN |=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG1_GYRO_EN |=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG1_ACCEL_EN;=
=0A=
> +=0A=
> +=A0=A0=A0=A0 val =3D 0;=0A=
> +=A0=A0=A0=A0 if (fifo_en & INV_ICM42600_SENSOR_GYRO)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_=
GYRO_EN;=0A=
> +=A0=A0=A0=A0 if (fifo_en & INV_ICM42600_SENSOR_ACCEL)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_=
ACCEL_EN;=0A=
> +=A0=A0=A0=A0 if (fifo_en & INV_ICM42600_SENSOR_TEMP)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 val |=3D INV_ICM42600_FIFO_CONFIG1_=
TEMP_EN;=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_C=
ONFIG1,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 mask, val);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 st->fifo.en =3D fifo_en;=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_fifo_period(st);=0A=
> +=0A=
> +=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> +static size_t inv_icm42600_get_packet_size(unsigned int fifo_en)=0A=
> +{=0A=
> +=A0=A0=A0=A0 size_t packet_size;=0A=
> +=0A=
> +=A0=A0=A0=A0 if ((fifo_en & INV_ICM42600_SENSOR_GYRO) &&=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0 (fifo_en & INV_ICM42600_SENSOR_ACCEL))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 packet_size =3D INV_ICM42600_FIFO_2=
SENSORS_PACKET_SIZE;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 packet_size =3D INV_ICM42600_FIFO_1=
SENSOR_PACKET_SIZE;=0A=
> +=0A=
> +=A0=A0=A0=A0 return packet_size;=0A=
> +}=0A=
> +=0A=
> +static unsigned int inv_icm42600_wm_truncate(unsigned int watermark,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t packet_size)=0A=
> +{=0A=
> +=A0=A0=A0=A0 size_t wm_size;=0A=
> +=A0=A0=A0=A0 unsigned int wm;=0A=
> +=0A=
> +=A0=A0=A0=A0 wm_size =3D watermark * packet_size;=0A=
> +=A0=A0=A0=A0 if (wm_size > INV_ICM42600_FIFO_WATERMARK_MAX)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 wm_size =3D INV_ICM42600_FIFO_WATER=
MARK_MAX;=0A=
> +=0A=
> +=A0=A0=A0=A0 wm =3D wm_size / packet_size;=0A=
> +=0A=
> +=A0=A0=A0=A0 return wm;=0A=
> +}=0A=
> +=0A=
=0A=
I think some overview docs on how this is working would be good.=0A=
Set out the aims for the watermark selected and how it is achieved.=0A=
=0A=
> +int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)=
=0A=
> +{=0A=
> +=A0=A0=A0=A0 size_t packet_size, wm_size;=0A=
> +=A0=A0=A0=A0 unsigned int wm_gyro, wm_accel, watermark;=0A=
> +=A0=A0=A0=A0 uint32_t period_gyro, period_accel, period;=0A=
> +=A0=A0=A0=A0 int64_t latency_gyro, latency_accel, latency;=0A=
> +=A0=A0=A0=A0 bool restore;=0A=
> +=A0=A0=A0=A0 __le16 raw_wm;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 packet_size =3D inv_icm42600_get_packet_size(st->fifo.en);=
=0A=
> +=0A=
> +=A0=A0=A0=A0 /* get minimal latency, depending on sensor watermark and o=
dr */=0A=
> +=A0=A0=A0=A0 wm_gyro =3D inv_icm42600_wm_truncate(st->fifo.watermark.gyr=
o,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 packet_size);=0A=
> +=A0=A0=A0=A0 wm_accel =3D inv_icm42600_wm_truncate(st->fifo.watermark.ac=
cel,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 packet_size);=0A=
> +=A0=A0=A0=A0 period_gyro =3D inv_icm42600_odr_to_period(st->conf.gyro.od=
r);=0A=
> +=A0=A0=A0=A0 period_accel =3D inv_icm42600_odr_to_period(st->conf.accel.=
odr);=0A=
> +=A0=A0=A0=A0 latency_gyro =3D (int64_t)period_gyro * (int64_t)wm_gyro;=
=0A=
> +=A0=A0=A0=A0 latency_accel =3D (int64_t)period_accel * (int64_t)wm_accel=
;=0A=
> +=A0=A0=A0=A0 if (latency_gyro =3D=3D 0) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency =3D latency_accel;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D wm_accel;=0A=
> +=A0=A0=A0=A0 } else if (latency_accel =3D=3D 0) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency =3D latency_gyro;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D wm_gyro;=0A=
> +=A0=A0=A0=A0 } else {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* compute the smallest latency tha=
t is a multiple of both */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (latency_gyro <=3D latency_accel=
) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency =3D=
 latency_gyro;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency -=
=3D latency_accel % latency_gyro;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency =3D=
 latency_accel;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 latency -=
=3D latency_gyro % latency_accel;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* use the shortest period */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (period_gyro <=3D period_accel)=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D =
period_gyro;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period =3D =
period_accel;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* all this works because periods a=
re multiple of each others */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D div_s64(latency, peri=
od);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (watermark < 1)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =
=3D 1;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0 wm_size =3D watermark * packet_size;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* changing FIFO watermark requires to turn off watermark i=
nterrupt */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits_check(st->map, INV_ICM42600_REG_=
INT_SOURCE0,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN=
,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0, &restore);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 raw_wm =3D INV_ICM42600_FIFO_WATERMARK_VAL(wm_size);=0A=
> +=A0=A0=A0=A0 memcpy(st->buffer, &raw_wm, sizeof(raw_wm));=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_write(st->map, INV_ICM42600_REG_FIFO_WA=
TERMARK,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 st->buffer, sizeof(raw_wm));=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* restore watermark interrupt */=0A=
> +=A0=A0=A0=A0 if (restore) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map,=
 INV_ICM42600_REG_INT_SOURCE0,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_I=
NT1_EN,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_I=
NT1_EN);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_buffer_preenable(struct iio_dev *indio_dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
> +=0A=
> +=A0=A0=A0=A0 pm_runtime_get_sync(dev);=0A=
> +=0A=
> +=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * update_scan_mode callback is turning sensors on and setting data FIFO=
 enable=0A=
> + * bits.=0A=
> + */=0A=
> +static int inv_icm42600_buffer_postenable(struct iio_dev *indio_dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* exit if FIFO is already on */=0A=
> +=A0=A0=A0=A0 if (st->fifo.on) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_on;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* set FIFO threshold interrupt */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_SO=
URCE0,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* flush FIFO data */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_=
RESET,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IN=
V_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* set FIFO in streaming mode */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IN=
V_ICM42600_FIFO_CONFIG_STREAM);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* workaround: first read of FIFO count after reset is alwa=
ys 0 */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COU=
NT, st->buffer, 2);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +out_on:=0A=
> +=A0=A0=A0=A0 /* increase FIFO on counter */=0A=
> +=A0=A0=A0=A0 st->fifo.on++;=0A=
> +out_unlock:=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* exit if there are several sensors using the FIFO */=0A=
> +=A0=A0=A0=A0 if (st->fifo.on > 1) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D 0;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_off;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* set FIFO in bypass mode */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IN=
V_ICM42600_FIFO_CONFIG_BYPASS);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* flush FIFO data */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_=
RESET,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IN=
V_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* disable FIFO threshold interrupt */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INT_SO=
URCE0,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN, 0);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +out_off:=0A=
> +=A0=A0=A0=A0 /* decrease FIFO on counter */=0A=
> +=A0=A0=A0=A0 st->fifo.on--;=0A=
> +out_unlock:=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=0A=
> +=A0=A0=A0=A0 unsigned int sensor;=0A=
> +=A0=A0=A0=A0 unsigned int *watermark;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
> +=A0=A0=A0=A0 unsigned int sleep_temp =3D 0;=0A=
> +=A0=A0=A0=A0 unsigned int sleep_sensor =3D 0;=0A=
> +=A0=A0=A0=A0 unsigned int sleep;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (indio_dev =3D=3D st->indio_gyro) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sensor =3D INV_ICM42600_SENSOR_GYRO=
;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D &st->fifo.watermark.g=
yro;=0A=
> +=A0=A0=A0=A0 } else if (indio_dev =3D=3D st->indio_accel) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sensor =3D INV_ICM42600_SENSOR_ACCE=
L;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 watermark =3D &st->fifo.watermark.a=
ccel;=0A=
> +=A0=A0=A0=A0 } else {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~=
sensor);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 *watermark =3D 0;=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 conf.mode =3D INV_ICM42600_SENSOR_MODE_OFF;=0A=
> +=A0=A0=A0=A0 if (sensor =3D=3D INV_ICM42600_SENSOR_GYRO)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(=
st, &conf, &sleep_sensor);=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_accel_conf=
(st, &conf, &sleep_sensor);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* if FIFO is off, turn temperature off */=0A=
> +=A0=A0=A0=A0 if (!st->fifo.on)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_temp_conf(=
st, false, &sleep_temp);=0A=
> +=0A=
> +out_unlock:=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* sleep maximum required time */=0A=
> +=A0=A0=A0=A0 if (sleep_sensor > sleep_temp)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_sensor;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_temp;=0A=
> +=A0=A0=A0=A0 if (sleep)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep);=0A=
> +=0A=
> +=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
> +=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
> +=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +const struct iio_buffer_setup_ops inv_icm42600_buffer_ops =3D {=0A=
> +=A0=A0=A0=A0 .preenable =3D inv_icm42600_buffer_preenable,=0A=
> +=A0=A0=A0=A0 .postenable =3D inv_icm42600_buffer_postenable,=0A=
=0A=
We've been slowly eroding the difference between preenable and posteenable.=
=0A=
Would be good to understand why you need to define both?=0A=
=0A=
> +=A0=A0=A0=A0 .predisable =3D inv_icm42600_buffer_predisable,=0A=
> +=A0=A0=A0=A0 .postdisable =3D inv_icm42600_buffer_postdisable,=0A=
> +};=0A=
> +=0A=
> +int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 unsigned int max)=0A=
> +{=0A=
> +=A0=A0=A0=A0 size_t max_count;=0A=
> +=A0=A0=A0=A0 __be16 *raw_fifo_count;=0A=
> +=A0=A0=A0=A0 ssize_t i, size;=0A=
> +=A0=A0=A0=A0 const void *accel, *gyro, *timestamp;=0A=
> +=A0=A0=A0=A0 const int8_t *temp;=0A=
> +=A0=A0=A0=A0 unsigned int odr;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* reset all samples counters */=0A=
> +=A0=A0=A0=A0 st->fifo.count =3D 0;=0A=
> +=A0=A0=A0=A0 st->fifo.nb.gyro =3D 0;=0A=
> +=A0=A0=A0=A0 st->fifo.nb.accel =3D 0;=0A=
> +=A0=A0=A0=A0 st->fifo.nb.total =3D 0;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* compute maximum FIFO read size */=0A=
> +=A0=A0=A0=A0 if (max =3D=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_count =3D sizeof(st->fifo.data)=
;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_count =3D max * inv_icm42600_ge=
t_packet_size(st->fifo.en);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* read FIFO count value */=0A=
> +=A0=A0=A0=A0 raw_fifo_count =3D (__be16 *)st->buffer;=0A=
> +=A0=A0=A0=A0 ret =3D regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COU=
NT,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 raw_fifo_count, sizeof(*raw_fifo_count));=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=A0=A0=A0=A0 st->fifo.count =3D be16_to_cpup(raw_fifo_count);=0A=
> +=0A=
> +=A0=A0=A0=A0 /* check and clamp FIFO count value */=0A=
> +=A0=A0=A0=A0 if (st->fifo.count =3D=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +=A0=A0=A0=A0 if (st->fifo.count > max_count)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.count =3D max_count;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* read all FIFO data in internal buffer */=0A=
> +=A0=A0=A0=A0 ret =3D regmap_noinc_read(st->map, INV_ICM42600_REG_FIFO_DA=
TA,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 st->fifo.data, st->fifo.count);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 /* compute number of samples for each sensor */=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < st->fifo.count; i +=3D size) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D inv_icm42600_fifo_decode_p=
acket(&st->fifo.data[i],=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &accel, &gyro, &temp, &timestamp, &odr);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size <=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gyro !=3D NULL && inv_icm42600_=
fifo_is_data_valid(gyro))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb=
.gyro++;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (accel !=3D NULL && inv_icm42600=
_fifo_is_data_valid(accel))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb=
.accel++;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->fifo.nb.total++;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> +int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st)=0A=
> +{=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.total =3D=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.gyro > 0) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_parse_fif=
o(st->indio_gyro);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.accel > 0) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_accel_parse_fi=
fo(st->indio_accel);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> +int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count)=0A=
> +{=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_fifo_read(st, count);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
Definitely searching my memory for how this works in the core, so=0A=
I may have it wrong.=0A=
=0A=
This is a bit unusual (I think).=A0 The intent of the flush=0A=
is to read up to 'n' bytes because someone just did a read on the buffer=0A=
or select, and there was data in the hwfifo capable of satisfying the read=
=0A=
even though we haven't yet reached the watermark.=0A=
=0A=
Given both sensor types are coming from one buffer, do we have a potential=
=0A=
issue here or under serving even though data is available?=0A=
=0A=
The case I worry may be served late is when an poll / select=0A=
is waiting for sufficient data.=0A=
=0A=
So what should we be doing?=A0 We want to guarantee to provide data=0A=
for each sensor type if it's in the hwfifo. As such we could keep reading=
=0A=
until we have enough, but that could cause some issues if the two data rate=
s=0A=
are very different (overflow on the other kfifo)=0A=
=0A=
Maybe what you have here is the best we can do. =0A=
=0A=
I'm assuming the watermark level has a similar problem.=A0 One value repres=
ents=0A=
the sum of the two types of data.=0A=
=0A=
> +=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.total =3D=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.gyro > 0) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_parse_fif=
o(st->indio_gyro);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 if (st->fifo.nb.accel > 0) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_accel_parse_fi=
fo(st->indio_accel);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 return 0;=0A=
> +}=0A=
> +=0A=
> +int inv_icm42600_buffer_init(struct inv_icm42600_state *st)=0A=
> +{=0A=
> +=A0=A0=A0=A0 unsigned int val;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0 * Default FIFO configuration (bits 7 to 5)=0A=
> +=A0=A0=A0=A0=A0 * - use invalid value=0A=
> +=A0=A0=A0=A0=A0 * - FIFO count in bytes=0A=
> +=A0=A0=A0=A0=A0 * - FIFO count in big endian=0A=
> +=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_INTF_CONFIG0_FIFO_COUNT_ENDIAN;=0A=
> +=A0=A0=A0=A0 ret =3D regmap_update_bits(st->map, INV_ICM42600_REG_INTF_C=
ONFIG0,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 GENMASK(7, 5), val);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 /*=0A=
> +=A0=A0=A0=A0=A0 * Enable FIFO partial read and continuous watermark inte=
rrupt.=0A=
> +=A0=A0=A0=A0=A0 * Disable all FIFO EN bits.=0A=
> +=A0=A0=A0=A0=A0 */=0A=
> +=A0=A0=A0=A0 val =3D INV_ICM42600_FIFO_CONFIG1_RESUME_PARTIAL_RD |=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG1_WM_GT_TH;=0A=
> +=A0=A0=A0=A0 return regmap_update_bits(st->map, INV_ICM42600_REG_FIFO_CO=
NFIG1,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 GENMASK(6, 5) | GENMASK(3, 0), val);=0A=
> +}=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers=
/iio/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
> new file mode 100644=0A=
> index 000000000000..de2a3949dcc7=0A=
> --- /dev/null=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h=0A=
> @@ -0,0 +1,98 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
> +/*=0A=
> + * Copyright (C) 2020 Invensense, Inc.=0A=
> + */=0A=
> +=0A=
> +#ifndef INV_ICM42600_BUFFER_H_=0A=
> +#define INV_ICM42600_BUFFER_H_=0A=
> +=0A=
> +#include <linux/kernel.h>=0A=
> +#include <linux/bits.h>=0A=
> +=0A=
> +struct inv_icm42600_state;=0A=
> +=0A=
> +#define INV_ICM42600_SENSOR_GYRO=A0=A0=A0=A0 BIT(0)=0A=
> +#define INV_ICM42600_SENSOR_ACCEL=A0=A0=A0 BIT(1)=0A=
> +#define INV_ICM42600_SENSOR_TEMP=A0=A0=A0=A0 BIT(2)=0A=
> +=0A=
> +/**=0A=
> + * struct inv_icm42600_fifo - FIFO state variables=0A=
> + * @on:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reference counter for FIF=
O on.=0A=
> + * @en:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bits field of INV_ICM4260=
0_SENSOR_* for FIFO EN bits.=0A=
> + * @period:=A0 FIFO internal period.=0A=
> + * @watermark:=A0=A0=A0=A0=A0=A0 watermark configuration values for acce=
l and gyro.=0A=
> + * @count:=A0=A0 number of bytes in the FIFO data buffer.=0A=
> + * @nb:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gyro, accel and total sam=
ples in the FIFO data buffer.=0A=
> + * @data:=A0=A0=A0 FIFO data buffer aligned for DMA (2kB + 32 bytes of r=
ead cache).=0A=
> + */=0A=
> +struct inv_icm42600_fifo {=0A=
> +=A0=A0=A0=A0 unsigned int on;=0A=
> +=A0=A0=A0=A0 unsigned int en;=0A=
> +=A0=A0=A0=A0 uint32_t period;=0A=
> +=A0=A0=A0=A0 struct {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int gyro;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int accel;=0A=
> +=A0=A0=A0=A0 } watermark;=0A=
> +=A0=A0=A0=A0 size_t count;=0A=
> +=A0=A0=A0=A0 struct {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t gyro;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t accel;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t total;=0A=
> +=A0=A0=A0=A0 } nb;=0A=
> +=A0=A0=A0=A0 uint8_t data[2080] ____cacheline_aligned;=0A=
> +};=0A=
> +=0A=
> +/* FIFO data packet */=0A=
> +struct inv_icm42600_fifo_sensor_data {=0A=
> +=A0=A0=A0=A0 __be16 x;=0A=
> +=A0=A0=A0=A0 __be16 y;=0A=
> +=A0=A0=A0=A0 __be16 z;=0A=
> +} __packed;=0A=
=0A=
Why packed?=A0 Should be anyway I think.=0A=
=0A=
> +#define INV_ICM42600_FIFO_DATA_INVALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 -32768=0A=
> +=0A=
> +static inline int16_t inv_icm42600_fifo_get_sensor_data(__be16 d)=0A=
> +{=0A=
> +=A0=A0=A0=A0 return be16_to_cpu(d);=0A=
> +}=0A=
> +=0A=
> +static inline bool=0A=
> +inv_icm42600_fifo_is_data_valid(const struct inv_icm42600_fifo_sensor_da=
ta *s)=0A=
> +{=0A=
> +=A0=A0=A0=A0 int16_t x, y, z;=0A=
> +=0A=
> +=A0=A0=A0=A0 x =3D inv_icm42600_fifo_get_sensor_data(s->x);=0A=
> +=A0=A0=A0=A0 y =3D inv_icm42600_fifo_get_sensor_data(s->y);=0A=
> +=A0=A0=A0=A0 z =3D inv_icm42600_fifo_get_sensor_data(s->z);=0A=
> +=0A=
> +=A0=A0=A0=A0 if (x =3D=3D INV_ICM42600_FIFO_DATA_INVALID &&=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0 y =3D=3D INV_ICM42600_FIFO_DATA_INVALID &&=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0 z =3D=3D INV_ICM42600_FIFO_DATA_INVALID)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return false;=0A=
> +=0A=
> +=A0=A0=A0=A0 return true;=0A=
> +}=0A=
> +=0A=
> +ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void *=
*accel,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void **gyro, const int8_t **temp=
,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const void **timestamp, unsigned int *=
odr);=0A=
> +=0A=
> +extern const struct iio_buffer_setup_ops inv_icm42600_buffer_ops;=0A=
> +=0A=
> +int inv_icm42600_buffer_init(struct inv_icm42600_state *st);=0A=
> +=0A=
> +void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *s=
t);=0A=
> +=0A=
> +int inv_icm42600_buffer_set_fifo_en(struct inv_icm42600_state *st,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int fifo_en);=0A=
> +=0A=
> +int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st);=
=0A=
> +=0A=
> +int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 unsigned int max);=0A=
> +=0A=
> +int inv_icm42600_buffer_fifo_parse(struct inv_icm42600_state *st);=0A=
> +=0A=
> +int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count);=0A=
> +=0A=
> +#endif=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c=0A=
> index 246c1eb52231..6f1c1eb83953 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c=0A=
> @@ -18,6 +18,7 @@=0A=
>=A0 #include <linux/iio/iio.h>=0A=
>=A0 =0A=
>=A0 #include "inv_icm42600.h"=0A=
> +#include "inv_icm42600_buffer.h"=0A=
>=A0 =0A=
>=A0 static const struct regmap_range_cfg inv_icm42600_regmap_ranges[] =3D =
{=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=0A=
> @@ -429,6 +430,18 @@ static irqreturn_t inv_icm42600_irq_handler(int irq,=
 void *_data)=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_FULL)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev, "FIFO full dat=
a lost!\n");=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 /* FIFO threshold reached */=0A=
> +=A0=A0=A0=A0 if (status & INV_ICM42600_INT_STATUS_FIFO_THS) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_fifo_re=
ad(st, 0);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev=
, "FIFO read error %d\n", ret);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_fifo_pa=
rse(st);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(dev=
, "FIFO parsing error %d\n", ret);=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
>=A0 out_unlock:=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
>=A0=A0=A0=A0=A0=A0=A0 return IRQ_HANDLED;=0A=
> @@ -600,6 +613,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, i=
nt chip, int irq,=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_init(st);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_gyro_init(st);=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> @@ -645,6 +662,14 @@ static int __maybe_unused inv_icm42600_suspend(struc=
t device *dev)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 /* disable FIFO data streaming */=0A=
> +=A0=A0=A0=A0 if (st->fifo.on) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_FIFO_CONFIG,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG_BYPASS);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_pwr_mgmt0(st, INV_ICM42600_=
SENSOR_MODE_OFF,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_SENSOR_MODE_O=
FF, false,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 NULL);=0A=
> @@ -684,6 +709,11 @@ static int __maybe_unused inv_icm42600_resume(struct=
 device *dev)=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 /* restore FIFO data streaming */=0A=
> +=A0=A0=A0=A0 if (st->fifo.on)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, INV_I=
CM42600_REG_FIFO_CONFIG,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_FIFO_CONFIG_STREAM);=0A=
> +=0A=
>=A0 out_unlock:=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
>=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> index 38654e0d217b..b05c33876b8d 100644=0A=
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c=0A=
> @@ -11,9 +11,12 @@=0A=
>=A0 #include <linux/delay.h>=0A=
>=A0 #include <linux/math64.h>=0A=
>=A0 #include <linux/iio/iio.h>=0A=
> +#include <linux/iio/buffer.h>=0A=
> +#include <linux/iio/kfifo_buf.h>=0A=
>=A0 =0A=
>=A0 #include "inv_icm42600.h"=0A=
>=A0 #include "inv_icm42600_temp.h"=0A=
> +#include "inv_icm42600_buffer.h"=0A=
>=A0 =0A=
>=A0 #define INV_ICM42600_GYRO_CHAN(_modifier, _index, _ext_info)=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> @@ -64,6 +67,76 @@ static const struct iio_chan_spec inv_icm42600_gyro_ch=
annels[] =3D {=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_ICM42600_TEMP_CHAN(INV_ICM42600_GYRO_SCAN_TEMP),=
=0A=
>=A0 };=0A=
>=A0 =0A=
> +/* IIO buffer data: 8 bytes */=0A=
> +struct inv_icm42600_gyro_buffer {=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_fifo_sensor_data gyro;=0A=
> +=A0=A0=A0=A0 int8_t temp;=0A=
> +=A0=A0=A0=A0 uint8_t padding;=0A=
> +};=0A=
> +=0A=
> +#define INV_ICM42600_SCAN_MASK_GYRO_3AXIS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0 (BIT(INV_ICM42600_GYRO_SCAN_X) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM42600_GYRO_SCAN_Y) |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
> +=A0=A0=A0=A0 BIT(INV_ICM42600_GYRO_SCAN_Z))=0A=
> +=0A=
> +#define INV_ICM42600_SCAN_MASK_TEMP=A0 BIT(INV_ICM42600_GYRO_SCAN_TEMP)=
=0A=
> +=0A=
> +static const unsigned long inv_icm42600_gyro_scan_masks[] =3D {=0A=
> +=A0=A0=A0=A0 /* 3-axis gyro + temperature */=0A=
> +=A0=A0=A0=A0 INV_ICM42600_SCAN_MASK_GYRO_3AXIS | INV_ICM42600_SCAN_MASK_=
TEMP,=0A=
> +=A0=A0=A0=A0 0,=0A=
> +};=0A=
> +=0A=
> +/* enable gyroscope sensor and FIFO write */=0A=
> +static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const unsigned long =
*scan_mask)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_sensor_conf conf =3D INV_ICM42600_SENSO=
R_CONF_INIT;=0A=
> +=A0=A0=A0=A0 unsigned int fifo_en =3D 0;=0A=
> +=A0=A0=A0=A0 unsigned int sleep_gyro =3D 0;=0A=
> +=A0=A0=A0=A0 unsigned int sleep_temp =3D 0;=0A=
> +=A0=A0=A0=A0 unsigned int sleep;=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_TEMP) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable temp sensor */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_temp_conf(=
st, true, &sleep_temp);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_en |=3D INV_ICM42600_SENSOR_TE=
MP;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 if (*scan_mask & INV_ICM42600_SCAN_MASK_GYRO_3AXIS) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* enable gyro sensor */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conf.mode =3D INV_ICM42600_SENSOR_M=
ODE_LOW_NOISE;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(=
st, &conf, &sleep_gyro);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_un=
lock;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fifo_en |=3D INV_ICM42600_SENSOR_GY=
RO;=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 /* update data FIFO write */=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->f=
ifo.en);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
> +=0A=
> +out_unlock:=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=A0=A0=A0=A0 /* sleep maximum required time */=0A=
> +=A0=A0=A0=A0 if (sleep_gyro > sleep_temp)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_gyro;=0A=
> +=A0=A0=A0=A0 else=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sleep =3D sleep_temp;=0A=
> +=A0=A0=A0=A0 if (sleep)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 msleep(sleep);=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
>=A0 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st=
,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_chan_spec const=
 *chan,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int16_t *val)=0A=
> @@ -260,7 +333,12 @@ static int inv_icm42600_gyro_write_odr(struct inv_ic=
m42600_state *st,=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_set_gyro_conf(st, &conf, NULL);=
=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_fifo_period(st);=0A=
> +=A0=A0=A0=A0 inv_icm42600_buffer_update_watermark(st);=0A=
>=A0 =0A=
> +out_unlock:=0A=
>=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
>=A0=A0=A0=A0=A0=A0=A0 pm_runtime_mark_last_busy(dev);=0A=
>=A0=A0=A0=A0=A0=A0=A0 pm_runtime_put_autosuspend(dev);=0A=
> @@ -574,12 +652,51 @@ static int inv_icm42600_gyro_write_raw_get_fmt(stru=
ct iio_dev *indio_dev,=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0 }=0A=
>=A0 =0A=
> +static int inv_icm42600_gyro_hwfifo_set_watermark(struct iio_dev *indio_=
dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned=
 int val)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 st->fifo.watermark.gyro =3D val;=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_update_watermark(st);=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
> +static int inv_icm42600_gyro_hwfifo_flush(struct iio_dev *indio_dev,=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int count)=0A=
> +{=0A=
=0A=
Nothing to do with this patch, but I realised reading this that we have=0A=
some 'unusual' use of the word flush here.=A0 It's a straight forward=0A=
read function so not sure why we called it flush.=0A=
=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 int ret;=0A=
> +=0A=
> +=A0=A0=A0=A0 if (count =3D=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D inv_icm42600_buffer_hwfifo_flush(st, count);=0A=
> +=A0=A0=A0=A0 if (!ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D st->fifo.nb.gyro;=0A=
> +=0A=
> +=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
> +=0A=
> +=A0=A0=A0=A0 return ret;=0A=
> +}=0A=
> +=0A=
>=A0 static const struct iio_info inv_icm42600_gyro_info =3D {=0A=
>=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D inv_icm42600_gyro_read_raw,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .read_avail =3D inv_icm42600_gyro_read_avail,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .write_raw =3D inv_icm42600_gyro_write_raw,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .write_raw_get_fmt =3D inv_icm42600_gyro_write_raw_g=
et_fmt,=0A=
>=A0=A0=A0=A0=A0=A0=A0 .debugfs_reg_access =3D inv_icm42600_debugfs_reg,=0A=
> +=A0=A0=A0=A0 .update_scan_mode =3D inv_icm42600_gyro_update_scan_mode,=
=0A=
> +=A0=A0=A0=A0 .hwfifo_set_watermark =3D inv_icm42600_gyro_hwfifo_set_wate=
rmark,=0A=
> +=A0=A0=A0=A0 .hwfifo_flush_to_buffer =3D inv_icm42600_gyro_hwfifo_flush,=
=0A=
>=A0 };=0A=
>=A0 =0A=
>=A0 int inv_icm42600_gyro_init(struct inv_icm42600_state *st)=0A=
> @@ -587,6 +704,7 @@ int inv_icm42600_gyro_init(struct inv_icm42600_state =
*st)=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct device *dev =3D regmap_get_device(st->map);=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 const char *name;=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev;=0A=
> +=A0=A0=A0=A0 struct iio_buffer *buffer;=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 name =3D devm_kasprintf(dev, GFP_KERNEL, "%s-gyro", =
st->name);=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!name)=0A=
> @@ -596,14 +714,54 @@ int inv_icm42600_gyro_init(struct inv_icm42600_stat=
e *st)=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (!indio_dev)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
>=A0 =0A=
> +=A0=A0=A0=A0 buffer =3D devm_iio_kfifo_allocate(dev);=0A=
> +=A0=A0=A0=A0 if (!buffer)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
> +=0A=
>=A0=A0=A0=A0=A0=A0=A0 iio_device_set_drvdata(indio_dev, st);=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->dev.parent =3D dev;=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->name =3D name;=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->info =3D &inv_icm42600_gyro_info;=0A=
> -=A0=A0=A0=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;=0A=
> +=A0=A0=A0=A0 indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTW=
ARE;=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_icm42600_gyro_channels;=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm42600_=
gyro_channels);=0A=
> +=A0=A0=A0=A0 indio_dev->available_scan_masks =3D inv_icm42600_gyro_scan_=
masks;=0A=
> +=A0=A0=A0=A0 indio_dev->setup_ops =3D &inv_icm42600_buffer_ops;=0A=
> +=0A=
> +=A0=A0=A0=A0 iio_device_attach_buffer(indio_dev, buffer);=0A=
>=A0 =0A=
>=A0=A0=A0=A0=A0=A0=A0 st->indio_gyro =3D indio_dev;=0A=
>=A0=A0=A0=A0=A0=A0=A0 return devm_iio_device_register(dev, st->indio_gyro)=
;=0A=
>=A0 }=0A=
> +=0A=
> +int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)=0A=
> +{=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_state *st =3D iio_device_get_drvdata(in=
dio_dev);=0A=
> +=A0=A0=A0=A0 ssize_t i, size;=0A=
> +=A0=A0=A0=A0 const void *accel, *gyro, *timestamp;=0A=
> +=A0=A0=A0=A0 const int8_t *temp;=0A=
> +=A0=A0=A0=A0 unsigned int odr;=0A=
> +=A0=A0=A0=A0 struct inv_icm42600_gyro_buffer buffer =3D {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .padding =3D 0,=0A=
=0A=
Might be worth a comment here or where the structure is defined=0A=
on why we make padding explicit.=0A=
=0A=
> +=A0=A0=A0=A0 };=0A=
> +=0A=
> +=A0=A0=A0=A0 /* parse all fifo packets */=0A=
> +=A0=A0=A0=A0 for (i =3D 0; i < st->fifo.count; i +=3D size) {=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size =3D inv_icm42600_fifo_decode_p=
acket(&st->fifo.data[i],=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &accel, &gyro, &temp, &timestamp, &odr);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* quit if error or FIFO is empty *=
/=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (size <=3D 0)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return size=
;=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* skip packet if no gyro data or d=
ata is invalid */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (gyro =3D=3D NULL || !inv_icm426=
00_fifo_is_data_valid(gyro))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;=
=0A=
> +=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* fill and push data buffer */=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memcpy(&buffer.gyro, gyro, sizeof(b=
uffer.gyro));=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buffer.temp =3D temp ? *temp : 0;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers(indio_dev, &buf=
fer);=0A=
> +=A0=A0=A0=A0 }=0A=
> +=0A=
> +=A0=A0=A0=A0 return 0;=0A=
> +}=
