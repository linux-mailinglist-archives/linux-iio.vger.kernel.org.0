Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E69F827AD8
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2019 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfEWKhs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 May 2019 06:37:48 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:60130 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728109AbfEWKhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2019 06:37:48 -0400
X-Greylist: delayed 1461 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2019 06:37:47 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4NA6ht4003947;
        Thu, 23 May 2019 03:12:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=Rz5sxXu1kLvmNPvKmVG9dBy2Bu3kDJUupBND9//E77w=;
 b=AVI13arXPX9nNm5zAvkk1VumHFqy/uIIm6/gYX6uQhOEwB/uw3hc3lFSOxqeYObj1pD7
 1Hx8Ip05wt30cNFD4vKEScNoxaTCdBL4Q6fpYvTvOkpb9d+bpzmGmW3ZsBJ48flvw7Ai
 +6UWYe1IF+m5EwWrhexvb2KR3q5vvJ6e7bkvwmRLkbgKojvhq/nNxDXtddw7tZBGxsuE
 EHd27ZzZ90PWb88gD2lHEFbHTsyMIjeclYJEJscNyugLknI1vo3KjZc2xV2Gh0X36sNi
 1InDN2F/F2IwAyxJdNWYF9BbuBn0wvpQWGmDky03ByhUdqUYq9soRPYDyIO8zKh5LoTL Kw== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2052.outbound.protection.outlook.com [104.47.32.52])
        by mx0a-00328301.pphosted.com with ESMTP id 2sm6t31e4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 May 2019 03:12:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz5sxXu1kLvmNPvKmVG9dBy2Bu3kDJUupBND9//E77w=;
 b=TJy6ft4gU2JWX1NTq0DPaJ21I5IJ5OZt1cpQsE2T05hTNqASmocx1bpqgcoumMHFWEtu+UdDxvwoHxEQgAMj3hxQy4V1k85/6bMTgFxHfxorGMW8qI/GMxBVimzGRhzLXAHlOoJIaRp338em672xVtWvCmA91RYeDVly8dBlgWM=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3198.namprd12.prod.outlook.com (20.179.82.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Thu, 23 May 2019 10:12:41 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::7db0:192a:1d72:94c9]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::7db0:192a:1d72:94c9%7]) with mapi id 15.20.1922.016; Thu, 23 May 2019
 10:12:41 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Andreea Lutac <andreea.lutac@fixposition.ch>
CC:     "stevemo@skydio.com" <stevemo@skydio.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ICM20602 buffer issues with the inv_mpu6050  driver
Thread-Topic: ICM20602 buffer issues with the inv_mpu6050  driver
Thread-Index: AQHVEUwZeOt+jtckZE2l8LRs1yc/BaZ4e4zV
Date:   Thu, 23 May 2019 10:12:41 +0000
Message-ID: <MN2PR12MB337375FCA3AAA2EB5F08B15AC4010@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <MN2PR12MB33738DAE3CCA829C2046CCE4C4000@MN2PR12MB3373.namprd12.prod.outlook.com>,<42bd-5ce66b80-45-ca9e8b0@181725592>
In-Reply-To: <42bd-5ce66b80-45-ca9e8b0@181725592>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8840b2de-2509-470a-ac9b-08d6df6730fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR12MB3198;
x-ms-traffictypediagnostic: MN2PR12MB3198:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR12MB3198124BF43BD03D4B3E7E44C4010@MN2PR12MB3198.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(346002)(136003)(376002)(396003)(189003)(199004)(52536014)(76176011)(81166006)(486006)(478600001)(8936002)(72206003)(6116002)(966005)(4326008)(99286004)(81156014)(6506007)(14454004)(8676002)(11346002)(9686003)(7696005)(5660300002)(54906003)(86362001)(80792005)(446003)(316002)(2906002)(3846002)(25786009)(14444005)(5024004)(256004)(6306002)(55016002)(6436002)(33656002)(68736007)(66446008)(26005)(66066001)(305945005)(66476007)(73956011)(53936002)(186003)(476003)(102836004)(66946007)(64756008)(66556008)(7736002)(76116006)(74316002)(229853002)(71200400001)(91956017)(71190400001)(6246003)(53546011)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3198;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ylxwgoTZ4yrr747Dpb//iaICfHgJnsoB15Jeb/j1pekqmasZctOlJam5bGdLdzj6PlW/WJjqpVo5Pe12eAWFqH7+H/RwRC+2uV1CyNrRJS1nESMMIu77ximyGe3dwaz0W2y/v5x9OKojzs09bHV2VmVUuSj+mgBii6y/9AmliVSKdjiL++FmIoM6bTnfpfgZg52KmwxjjPfVhPJabLTj2edEENB3Du2Ifgz/B+zD/TIJMxlJ37lqMl4FVRMbXUKyJktFSaZTWEKzfqxEQDqxmDOjdnCMePSANQQheSVRx+dxan2DgsjM7kDV0HGYfOafMrfpD9wzajvKwAGPv5tBrrftWevnpa+yb/p07zflojg3NjLt4BLOMHbU8iU4Uz0VR9zmLl4pMLNHLGc0irFOnCLMRDVS2ySgpU+MgZPcBco=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8840b2de-2509-470a-ac9b-08d6df6730fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 10:12:41.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3198
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230072
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andreea,=0A=
=0A=
I understand the issue now. The problem is that temperature data are always=
 present in the FIFO. Even when the attribute is disabled. This is a limita=
tion of this chip and cannot be changed on the hardware side.=0A=
=0A=
When temp attribute is disabled while accel and gyro are on, the iio buffer=
 is expecting to have 12 bytes with accel + gyro data. But the driver will =
still provides 14 bytes with temperature in the middle since the FIFO will =
contain that. Always enabling temperature attribute on userspace will solve=
 this issue, but that's certainly not the best.=0A=
=0A=
A correct solution would be to enforce temperature data in iio buffer by ha=
ving the temp attribute always enabled and read-only in userspace. That wou=
ld reflect correctly the chip capabilities. But I don't know if this is fea=
sible. A workaround would be to add data post-processing in the driver and =
delete temp data when it is disabled. But I don't like this kind of workaro=
und because that goes against iio buffer design principle.=0A=
=0A=
Hope this help you.=0A=
=0A=
Best regards,=0A=
Jean-Baptiste Maneyrol=0A=
=0A=
From: Andreea Lutac <andreea.lutac@fixposition.ch>=0A=
Sent: Thursday, May 23, 2019 11:44=0A=
To: Jean-Baptiste Maneyrol=0A=
Cc: stevemo@skydio.com; jic23@kernel.org; knaack.h@gmx.de; lars@metafoo.de;=
 pmeerw@pmeerw.net; linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org=
=0A=
Subject: Re: ICM20602 buffer issues with the inv_mpu6050 driver=0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
Hi Jean-Baptiste and Stepan,=0A=
=0A=
Thanks so much for the replies and the advice. I've dug a bit deeper into t=
his and added a few printk statements to the driver, as suggested by Stepan=
. It looks like the device is getting recognized correctly as ICM20602 and =
the buffer is being filled with 14 bytes as expected.=0A=
=0A=
But I've identified some strange behaviour regarding the temperature channe=
I. If I manually enable all 7 scan elements and read 14 bytes from the devi=
ce file, the readings appear correct and change accordingly when I move the=
 chip around. However, if I set in_temp_en set to 0 (with everything else s=
till enabled) and read 12 bytes, the buffer doesn't seem to acknowledge thi=
s change and shift the gyro values up, instead getting only the first 12 by=
tes (accel_x, accel_y, accel_z, temp, gyro_x, gyro_y), without gyro_z. So t=
his is why it looks as if temp is replacing gyro_x.=0A=
I made a pastebin here with some of the (unconverted) values I got while te=
sting these cases: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__p=
astebin.com_BYVqDNch&d=3DDwIFaQ&c=3DWoJWtq5JV8YrKnzRxvD8NxmTP_1wxfE0prPmo0N=
eZwg&r=3D4jiDX_1brsSWfCjfA6Ovj1d4h9MF8q7Xk5aBwG28mVk&m=3DsbkHiUlsj8pOWjf2iT=
q5CXEFvv-MNyqBKOqCjxOj9kc&s=3DPmb23R-DoTj9hDwYk3qqiUfOCUWbtfpVQjUZ1lajeFI&e=
=3D=0A=
=0A=
Attempting the same reads with my C++ program via libiio always results in =
only the first 12 bytes being read, as for some strange reason libiio fails=
 to enable the temperature channel, so iio_device_get_sample_size() is alwa=
ys 12 and it's actually gyro_z that I can't get to.=0A=
=0A=
I'll try to look through the code that is supposed to enable a channel and =
see why it's not succeeding via libiio. Do you have any clue as to which bi=
t of code does the adjustment of the buffer values according to which chann=
els are enabled? Is this done in the driver or deeper in the kernel?=0A=
=0A=
Thanks once again for the help!=0A=
Best regards,=0A=
Andreea=0A=
=0A=
On Wednesday, May 22, 2019 16:33 CEST, Jean-Baptiste Maneyrol <JManeyrol@in=
vensense.com> wrote:=0A=
=0A=
> Hello,=0A=
>=0A=
> I had a look inside the driver to verify the buffer implementation. It lo=
oks correct to me. I don't see where the problem can come from. I am sorry =
I don't have a setup currently to test in live.=0A=
>=0A=
> For sure you can have a different result by reading the buffer through th=
e char device file compared to reading the raw sysfs entry. The buffer is t=
aking the data from the FIFO and the raw sysfs from the sensor data registe=
rs.=0A=
>=0A=
> You can perhaps test value 1 by 1 in the buffer, and verify the correctne=
ss of every attributes. If you can also send a complete buffer log that wou=
ld be helpful.=0A=
> Every data is 2 bytes long and in the following order: accel_x, accel_y, =
accel_z, temp, gyro_x, gyro_y, gyro_z=0A=
>=0A=
> Best regards,=0A=
> JB Maneyrol=0A=
>=0A=
> From: Andreea Lutac <andreea.lutac@fixposition.ch>=0A=
> Sent: Tuesday, May 21, 2019 12:40=0A=
> Cc: Jean-Baptiste Maneyrol; stevemo@skydio.com; jic23@kernel.org; knaack.=
h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-iio@vger.kernel.org; li=
nux-kernel@vger.kernel.org=0A=
> Subject: ICM20602 buffer issues with the inv_mpu6050 driver=0A=
> =A0=0A=
> Hello,=0A=
>=0A=
> I've been trying to get some data samples from the ICM20602 IMU using the=
 mpu6050 driver which recently added support for it, but I'm encountering a=
n issue with the ordering of the data in the FIFO.=0A=
> According to the specs of the device, if the accel and gyro XYZ channels =
are enabled, then the hardware FIFO is filled with 14 bytes corresponding t=
o the following channels: accel_x, accel_y, accel_z, temp, anglvel_x, anglv=
el_y, anglvel_z. However, when reading out the buffer, the value I get for =
anglvel_x seems to actually be the temperature. This=A0 occurs both when re=
ading with iio_channel_read (via libiio) and also if I read directly from /=
dev/iio:device with only in_anglvel_x_en set. But in_anglvel_x_raw reports =
correct values, which made me suspect that maybe somewhere in the driver th=
is interleaved temp channel is not accounted for in the buffer structure.=
=0A=
>=0A=
> I had a look at the driver code and inv_mpu6050_read_fifo() in particular=
, but I can't identify anything amiss. I've applied the recent patch that a=
dded the extra 2 temperature bytes ( ), but the problem persists. So far I'=
ve tried changing the size of the data buffer, defined in inv_mpu_iio.h:=0A=
>=0A=
> /* 6 + 6 round up and plus 8 */=0A=
> #define INV_MPU6050_OUTPUT_DATA_SIZE=A0=A0=A0=A0 24=0A=
>=0A=
> from 24 to 32, according to the intuition that 24 corresponds to readings=
 without temperature (i.e. 6 bytes for accel, rounded up to 8 + 6 bytes for=
 gyro, rounded up to 8 + 8 bytes for the timestamp =3D 24) and thus another=
 8 bytes would be needed, but that doesn't seem to have solved it.=0A=
>=0A=
> I'm quite new to driver development though, so I think there might be som=
ething I'm not getting. I would be really grateful if anyone could shed som=
e light over what's happening here or give some advice as to what I could b=
e doing wrong.=0A=
>=0A=
> Best regards,=0A=
> Andreea Lutac=0A=
>=0A=
=0A=
