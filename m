Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7E18B219
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 12:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgCSLIt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 07:08:49 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:31298 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbgCSLIt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 07:08:49 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JB7Vt6010024;
        Thu, 19 Mar 2020 04:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=tFK1br6EdENiuuVxAE6SzmDBXeXuMoMgZ+xxp0RjnpA=;
 b=Gd1aZc57AAhQvxxWNq6iydvtRPn6cXwFwe5RXm67URW8OSVE5iBqI4BrahX507rAyoCo
 1WJnzpUPkxTGVwSrmMy32KXcyEiqPBgVhcN48kG6f/acS3I5w/4ipFLwWm+qngnofxna
 xNq62PgWB535EgRkRNdgydGNvEznbNSfhaR0SpM1ZmwYNlmIvDnPjDGgilqQyiw6kBxv
 m6k2Y0JjVcIDZqFlVUsmb0LZp54LaG2VHgm9ELyEJoRkhMgpleoOYqNCYLY6kG6CLLx3
 O8sQmKvPV4Lkof6ClPtatsLPg1yJBf8zZp6iPAYVZZ9jaEhyXTDc9jnjsKpGKjLvFwS0 Gw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0a-00328301.pphosted.com with ESMTP id 2yu7ajguw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 04:08:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOUEdZDYyUZnZSCzAlkKV5Eb7bRDEcd+xM2aOEdSg+qQNj/oXoQtBARoT67bCA/hO3XwZEGgMVWtnHIclVGA75uibOVakmoPV29ldgDeYE4oo0eRumhvEBKl53+ecjih17raKA94Gi9AzncWnLonwOEQoCgJR7c5bJm/Erdwcar6+iF66pmhlH1fPpeG8uVojANtJv8fZ+nPXzge604GskZbpex95/QilinWwljJY+0hNcmHwGetPxM23gry8NoGSHfMcUIW6w9SRjwQOIxBvpxfOxgHJ9Bq5/KovEeMsl5RTG+i+orBqD8pHtx8LUpBmyxKWz0mQLM/7f/qZtF9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFK1br6EdENiuuVxAE6SzmDBXeXuMoMgZ+xxp0RjnpA=;
 b=FWpWAlf3r5ZUU+V43P5FbX/paC0dQRaDa2MH2t4ohhIdqJKDmRf/0wKQYPv/q6sHS5Inq2HJmh+CkMHDwkY7T/Q1wC98qw10m8KqsHnanlTP1QURIN/qWnisk8l5OSWI6tlLRWnG7SosaX83fYQFiRTOG/sP3eecPp3vA72JfqzkBFt7QJfsiBuNgDzmK5eQf8UzDb7kbXHHKoyG1gGRKW2CqIFU5Ye2BDoyX2kdwv8Ze6x+hUejLX9new+M7xHL7Q2gQW9ttkIWkv8k6wrjvvlJTLoOz6ZFatQXGY0dIPkXpRa3ENSnfO8wBG5+WOm3X0ZHruy0ddVziQvgoy2Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFK1br6EdENiuuVxAE6SzmDBXeXuMoMgZ+xxp0RjnpA=;
 b=OfbR/FTHp4WyugHBFO9Q0Ll0njYoVajBgLp5ERLwJfKqWIkLJS+ns7YoLW8g1jM8QCw6RUsBTojhFGrxntkTjdt9jaWlcM5yEoPahONn2ww8jM0wobEzsSA8DcvA1YTpUGxEveicp9dP5fhG2KTZvVvl4tJMHcceFui6hmtxOuw=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Thu, 19 Mar
 2020 11:08:44 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 11:08:44 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interface
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w
 interface
Thread-Index: AQHV/bS2NtvR2YaS+UCRrBJpOPlDy6hPtZkAgAALrTs=
Date:   Thu, 19 Mar 2020 11:08:44 +0000
Message-ID: <MN2PR12MB4422876C03060876ACBB4414C4F40@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <5e730c2f.1c69fb81.9eda3.5c70@mx.google.com>,<CAHp75Vf+SA7ptRQRxvMtVfN0MzQeQ_AgzAP7fc3eaT5nmsxo_g@mail.gmail.com>
In-Reply-To: <CAHp75Vf+SA7ptRQRxvMtVfN0MzQeQ_AgzAP7fc3eaT5nmsxo_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a01:e0a:393:a700:dca0:68f2:5693:1699]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd20b35f-1b03-46d7-d3df-08d7cbf5e3ae
x-ms-traffictypediagnostic: MN2PR12MB3437:
x-microsoft-antispam-prvs: <MN2PR12MB3437EBE5F7D9079E4EFD98B8C4F40@MN2PR12MB3437.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39850400004)(376002)(346002)(396003)(199004)(86362001)(110136005)(8676002)(316002)(91956017)(55016002)(66446008)(76116006)(64756008)(4326008)(66946007)(66556008)(66476007)(9686003)(71200400001)(2906002)(81166006)(478600001)(81156014)(8936002)(7696005)(52536014)(186003)(33656002)(5660300002)(53546011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3437;H:MN2PR12MB4422.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GVU0CUDrPIh8Y/ZrYSz6N6SkbvK3YnpcCjalY4dxizxc2JtGoFd4TPYqLc3GH+VyyVh76+127UbKx+hnRuvRLHM33sGZxUEKV/ra0VyzaiktFJrmRpo95rV1Tb7Qmaoqfm+x9HQ7mnCydHfml5IeIjrWzQRU0aD1O46+0xd4V3JZ6gTD+WvsmIGaxvTPhpUzSqE6BXR6lw/wC2RC8X9+VFX1feKj0sR+CPjzcR0pa3osp+cD5QNTqzuAFNFBrPdAefnTOD5ElxS67kKm1/HsxedgpakqpiUa97dx+WKApwf47K8ZbZZNZBXJuGdWhv89sXb6moPuLW6sl6mUJkdmAZWOmtp8SCjz5gl1VToKZoh/7XOzONegU6evBXwHI/a/dsFtPphZHcudSNZgeogDbK+Ewp3CGesCyHAZPky5C76QzF0tWp6g8eKA31lbXvpb
x-ms-exchange-antispam-messagedata: O0ErBOy5j+s1aESSroO09xwWart+N3lXu49FdrTHZN8ygr5u9lMBm6s2YzAHQnUkIeLMJTi/Fclt0NjzjE5Qo72efbOh7APEkXxiZeciC60KmfM9ouLiPcnE74UBZRMAAUjYUlFT5tdN8aF2osGQkGPBlMm2Z04AFPpz3AoASnYjgrsx72IKd9FbL4ZKW3skbMFD/AUxZcdKcqGTLZNiEQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd20b35f-1b03-46d7-d3df-08d7cbf5e3ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 11:08:44.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ss48KbNdstgXPzE7wGhlbM0B6Cg5Jou3Q9/3wPNo+hfTtSxUZvJiDLZ+5bkD4vcvJW/3iZDw3FMR+Z/d5cAPyiothjTcRIv31P73aEYNLCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3437
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_02:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190050
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
iio debugfs register interface is quite handy because we can read a single =
register and write a value.=0A=
=0A=
regmap debugfs is only a dump of all registers, as far as I know (may have =
missed something).=0A=
=0A=
Thanks.=0A=
JB=0A=
=0A=
From: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
=0A=
Sent: Thursday, March 19, 2020 11:24=0A=
=0A=
To: Rohit Sarkar <rohitsarkar5398@gmail.com>=0A=
=0A=
Cc: linux-iio <linux-iio@vger.kernel.org>; Linux Kernel Mailing List <linux=
-kernel@vger.kernel.org>; Jonathan Cameron <jic23@kernel.org>; Hartmut Knaa=
ck <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-=
Stadler <pmeerw@pmeerw.net>;=0A=
 Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Andy Shevchenko <andriy=
.shevchenko@linux.intel.com>; Linus Walleij <linus.walleij@linaro.org>=0A=
=0A=
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add debugfs register r/w interf=
ace=0A=
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
On Thu, Mar 19, 2020 at 8:10 AM Rohit Sarkar <rohitsarkar5398@gmail.com> wr=
ote:=0A=
=0A=
>=0A=
=0A=
> The iio debugfs interface provides direct access to read and write device=
=0A=
=0A=
> registers if debugfs is enabled.=0A=
=0A=
=0A=
=0A=
But regmap API provides at least reading facility. Isn't it enough?=0A=
=0A=
=0A=
=0A=
...=0A=
=0A=
=0A=
=0A=
>=A0 static const struct iio_info mpu_info =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D &inv_mpu6050_read_raw,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 .write_raw =3D &inv_mpu6050_write_raw,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 .write_raw_get_fmt =3D &inv_write_raw_get_fmt,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 .attrs =3D &inv_attribute_group,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 .validate_trigger =3D inv_mpu6050_validate_trigge=
r,=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0 .debugfs_reg_access =3D &inv_mpu6050_reg_access=0A=
=0A=
=0A=
=0A=
Leaving comma is helpful for future development.=0A=
=0A=
=0A=
=0A=
>=A0 };=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
-- =0A=
=0A=
With Best Regards,=0A=
=0A=
Andy Shevchenko=0A=
=0A=
