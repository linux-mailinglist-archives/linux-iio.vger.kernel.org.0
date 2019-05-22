Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB60266A1
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2019 17:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfEVPHr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 May 2019 11:07:47 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:48280 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728466AbfEVPHr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2019 11:07:47 -0400
X-Greylist: delayed 2001 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 11:07:47 EDT
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4MERv1n017305;
        Wed, 22 May 2019 07:33:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=1D3p2QGFlx61/OrK3HDJrrIET1t6DWli++qK2So29Ds=;
 b=vnnUEI4770wiHHR73cw3CwLV3PEarDQ3VpoJ/A+dbVMO2sopwR7h82JU1mQHLaBBDY4s
 YwiSkObbyMOYfs3EcgkDKMZWvakWRB+c95IGm58vh93YdJEl2+EJpLeKkV2g8bOqQPJc
 oXgwra+qyHGAP+A+zoufLYh+qjRXhZhYXZCH4fXzAGw/3toXLMbDUpz0+6QQLDmggh4E
 5S1yHErQ+cOwdO3C/efz9Q4fIAQCog5MFFACKS1+DYe2qR7QqFga7hNCQwmcAZ38SreM
 prb5opa1HKctulfw/Rn8bz3xTJzWotWXVpWYQOUEKxG1RGlqiKIE2aunlDO5C1/X/bsU eg== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2056.outbound.protection.outlook.com [104.47.40.56])
        by mx0a-00328301.pphosted.com with ESMTP id 2sm6t30y8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 May 2019 07:33:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D3p2QGFlx61/OrK3HDJrrIET1t6DWli++qK2So29Ds=;
 b=NTxNb6QhTLXHUA6Q9uRGqpm1s9u9MRUsPenyTAf1+cryQ1mXuzUgpQ9NtUe1O7DtKCq+MYujyyS1kXcpeyVGc/Rl+wExihvYBDJ/Be1zGhRThPsCbSypaTe5/vRzlK+h5VhsByv8kELQwWt4J85Mobx6VWr+B+K3JIIourljPRY=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB4029.namprd12.prod.outlook.com (10.255.239.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Wed, 22 May 2019 14:33:44 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::7db0:192a:1d72:94c9]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::7db0:192a:1d72:94c9%7]) with mapi id 15.20.1922.016; Wed, 22 May 2019
 14:33:44 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Andreea Lutac <andreea.lutac@fixposition.ch>
CC:     "stevemo@skydio.com" <stevemo@skydio.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ICM20602 buffer issues with the inv_mpu6050 driver
Thread-Topic: ICM20602 buffer issues with the inv_mpu6050 driver
Thread-Index: AQHVD8GjTipz5tzQVUSj/IxhuD+TzaZ3NPiE
Date:   Wed, 22 May 2019 14:33:44 +0000
Message-ID: <MN2PR12MB33738DAE3CCA829C2046CCE4C4000@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <42bd-5ce3d580-2b-ca9e8b0@181689754>
In-Reply-To: <42bd-5ce3d580-2b-ca9e8b0@181689754>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c4934b-97ba-4158-b525-08d6dec27e54
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR12MB4029;
x-ms-traffictypediagnostic: MN2PR12MB4029:
x-microsoft-antispam-prvs: <MN2PR12MB4029919E15B45171C51CD3C6C4000@MN2PR12MB4029.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(26005)(71200400001)(7736002)(256004)(14444005)(5660300002)(68736007)(186003)(80792005)(6246003)(25786009)(99286004)(66946007)(486006)(52536014)(8936002)(81166006)(8676002)(91956017)(54906003)(76116006)(81156014)(73956011)(33656002)(66476007)(66446008)(66556008)(74316002)(71190400001)(64756008)(76176011)(305945005)(102836004)(316002)(4326008)(446003)(7696005)(2906002)(6116002)(53936002)(3846002)(11346002)(6436002)(9686003)(72206003)(66066001)(86362001)(476003)(6506007)(6916009)(55016002)(14454004)(229853002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB4029;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KfBacmk9vtv2Ki38LYpp+HL6Mk6dclWgzqLbmWulqHTESOLUgaS/Cjkhi44kGR2m2nJQufflw4cJVMm44pQreGA6w4uT1164bMSnwd9DSxsNDmr1bPV7K4MuPciYJItW4b2d7Ci4MMuixmDW17XLEKK0VWh36DnrOusxNU1YSpQQ7yjfb8qrb7NuDBR4t5tExSZWgsXABP/I7+Au0+QI8yj1hmAghsFdt9MO9+XzBm081jtbyrYjfO+pOMf6OIXBoHguYZRZjjI7PjVPCkH9rG6jdBpLSmIJ14EywnaDbiGBmlSSHaXKdRp/6aYxk4VoYXs7/ZKBG6ARQvLkVlQ43aCJyZR7htDBIsuAKToEyjDb0kNeuRODLniZeZC9tuj0AXKNOdBaC0R1/aSm87nRPZus4BmYW/vFLURuZK7OY7E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c4934b-97ba-4158-b525-08d6dec27e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 14:33:44.0278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4029
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
I had a look inside the driver to verify the buffer implementation. It look=
s correct to me. I don't see where the problem can come from. I am sorry I =
don't have a setup currently to test in live.=0A=
=0A=
For sure you can have a different result by reading the buffer through the =
char device file compared to reading the raw sysfs entry. The buffer is tak=
ing the data from the FIFO and the raw sysfs from the sensor data registers=
.=0A=
=0A=
You can perhaps test value 1 by 1 in the buffer, and verify the correctness=
 of every attributes. If you can also send a complete buffer log that would=
 be helpful.=0A=
Every data is 2 bytes long and in the following order: accel_x, accel_y, ac=
cel_z, temp, gyro_x, gyro_y, gyro_z=0A=
=0A=
Best regards,=0A=
JB Maneyrol=0A=
=0A=
From: Andreea Lutac <andreea.lutac@fixposition.ch>=0A=
Sent: Tuesday, May 21, 2019 12:40=0A=
Cc: Jean-Baptiste Maneyrol; stevemo@skydio.com; jic23@kernel.org; knaack.h@=
gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; linux-iio@vger.kernel.org; linu=
x-kernel@vger.kernel.org=0A=
Subject: ICM20602 buffer issues with the inv_mpu6050 driver=0A=
=A0=0A=
Hello,=0A=
=0A=
I've been trying to get some data samples from the ICM20602 IMU using the m=
pu6050 driver which recently added support for it, but I'm encountering an =
issue with the ordering of the data in the FIFO.=0A=
According to the specs of the device, if the accel and gyro XYZ channels ar=
e enabled, then the hardware FIFO is filled with 14 bytes corresponding to =
the following channels: accel_x, accel_y, accel_z, temp, anglvel_x, anglvel=
_y, anglvel_z. However, when reading out the buffer, the value I get for an=
glvel_x seems to actually be the temperature. This=A0 occurs both when read=
ing with iio_channel_read (via libiio) and also if I read directly from /de=
v/iio:device with only in_anglvel_x_en set. But in_anglvel_x_raw reports co=
rrect values, which made me suspect that maybe somewhere in the driver this=
 interleaved temp channel is not accounted for in the buffer structure.=0A=
=0A=
I had a look at the driver code and inv_mpu6050_read_fifo() in particular, =
but I can't identify anything amiss. I've applied the recent patch that add=
ed the extra 2 temperature bytes ( ), but the problem persists. So far I've=
 tried changing the size of the data buffer, defined in inv_mpu_iio.h:=0A=
=0A=
/* 6 + 6 round up and plus 8 */=0A=
#define INV_MPU6050_OUTPUT_DATA_SIZE=A0=A0=A0=A0 24=0A=
=0A=
from 24 to 32, according to the intuition that 24 corresponds to readings w=
ithout temperature (i.e. 6 bytes for accel, rounded up to 8 + 6 bytes for g=
yro, rounded up to 8 + 8 bytes for the timestamp =3D 24) and thus another 8=
 bytes would be needed, but that doesn't seem to have solved it.=0A=
=0A=
I'm quite new to driver development though, so I think there might be somet=
hing I'm not getting. I would be really grateful if anyone could shed some =
light over what's happening here or give some advice as to what I could be =
doing wrong.=0A=
=0A=
Best regards,=0A=
Andreea Lutac=0A=
=0A=
