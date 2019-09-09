Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DFDAD61C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfIIJ4E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 05:56:04 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:49288 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729181AbfIIJ4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 05:56:04 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x899u3kR001284;
        Mon, 9 Sep 2019 02:56:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=7mkKsJ8v3WTsb9qrvyP9db0XnzHV9z/dcS1Yfp+MvHw=;
 b=OksajV6lH7yDqFekji3ZifjChiffN6QVzqjXMrFJFtb1grkk7MQrc66q2RlEpXsWBFUW
 viZBZw4SMo4kW17s3ufxTd8S5nhbxFUMVRUYvHqlG2tWTepY1j1vNJYCOatjyTiHrtdj
 E8TgTx6xY6mXGAAyp1sAq3H/w8rE/amzvWK+GzSJfsVDdzg/PU8wzgNbFApwh2WYvkEK
 2tjBGW4NYCMERmcnCQt7SZ3U8/1B8uLgyVBNXio7AvGbrk0KQUk5fQxd1Q2iJ/dXdNoD
 2feU02bHzcDT+Otx/1eKmAg10oVRr8kneU56F95sQadnrqYyh1097tYBGxy+UbGxVXbT cQ== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by mx0a-00328301.pphosted.com with ESMTP id 2uw1n5gaxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Sep 2019 02:56:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9YgmuisxwYFJ4RU4qiBlw05xnSKqyY5OU/RWFCly+vwYqzmfxSIgBMB8qrKD7DX+7VOPx9kqXlVQbHNCwTe+iHsUPWA9B+rJcZb02orHmWlLftWvG/E4RnpFJ4hP/bqdj9itXH7n6tn3Pt2FiHnFGLvz7CsU6Sg7SLe6mBJo2apn3AsyB01XIh3XVLH6BInedMMmfjcsp9ylS9hPYCjcJDpBQusb1iAjbGTvKuty+0QPWM6pAvXTuJzf+BjUGPoKI10imxEUwjCgfbsz5IXco5dmzcSccrRGNPFj4ec06n/wXS1v+lHyNCFmAZmzUg2WhJ6ngt2X7IsIWznkEPRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mkKsJ8v3WTsb9qrvyP9db0XnzHV9z/dcS1Yfp+MvHw=;
 b=eQNRfh5MOY2/pAnntT56tqpu9q//ZvlQzFGI8B/+4u6T0ZpxsR0xLii1n5mx0m6l/iZKWjijj4aOEu8goZaQH+JsScq+5f56b9u1FMDzkzHu+GAe84c16NfT6GiWzuhjARW6RCO/bc+lkVs8kkemW/vaCv0zgxDp60h7wyEnGs/NMh7UeQLQnsk5gARBfhuXRok8ts5LQM5dWDSkC9fixVqiyIX1siGcmJOESlM71sP/ZU5qAfdiuvEi7GRn24p+NHuur7VphvOUemYgDpwU1XKBCzjjGtev626F3cOXjs5D8YG5/oOFGs4KE9ZIliTMT7LriBDbdPADNvaIis0k8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mkKsJ8v3WTsb9qrvyP9db0XnzHV9z/dcS1Yfp+MvHw=;
 b=SHoOlH7Z/CSAm2PTEimuMjzcG96mjcMpDlFqH3Uego7CIy3qenD2vp1OzNROm8TltPcqJhw0dHt+mRHXAObe5ZzQdyLnXwIPVSFYJcH1snQT423pdyiALPJlG/I1Lts75H9ZJ4Cne+aS3fueRHJHfYL3/tbhunW0CmN3doEqjXQ=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3951.namprd12.prod.outlook.com (10.255.238.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 09:55:59 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 09:55:59 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/8] add magnetometer support for MPU925x
Thread-Topic: [PATCH 0/8] add magnetometer support for MPU925x
Thread-Index: AQHVXn0Fzssnqa4N1USG7L0WWvUwAachuBIAgAF0B90=
Date:   Mon, 9 Sep 2019 09:55:59 +0000
Message-ID: <MN2PR12MB337376A70BB66E8F7A3997D2C4B70@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>,<20190908124242.21669f1f@archlinux>
In-Reply-To: <20190908124242.21669f1f@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 996fd04e-dcc8-4a8a-4e87-08d7350beac6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR12MB3951;
x-ms-traffictypediagnostic: MN2PR12MB3951:
x-microsoft-antispam-prvs: <MN2PR12MB395144485D54518CAE65E104C4B70@MN2PR12MB3951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(346002)(136003)(376002)(199004)(189003)(53936002)(66556008)(229853002)(6246003)(76116006)(66476007)(2906002)(91956017)(66446008)(6916009)(9686003)(66946007)(55016002)(81166006)(81156014)(186003)(4326008)(476003)(99286004)(8936002)(486006)(64756008)(25786009)(86362001)(6436002)(8676002)(53546011)(6506007)(102836004)(26005)(76176011)(256004)(74316002)(7736002)(305945005)(52536014)(478600001)(446003)(11346002)(7696005)(5024004)(14444005)(71200400001)(71190400001)(80792005)(3846002)(33656002)(6116002)(5660300002)(66066001)(14454004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3951;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LsqVd32vIYh5FF9ZQzo9ZMaLEw9xinrn1I0ybP3bHOPCjtF+05gQ18VXnd6V0SKn+1t+xTcoqC2flL8tjGSKKFIhTKS3aR3qFiLjSxrnd5ILqtSzs4/ckFRu9UPiWnd21Nd8eKy/FNLxPNRRC5IePwMgTq1srIgLhRrLVdrAC1atb7fYhgKessExq0nx5QXY/eD7uIc+0+lhhpURM2mPB1ZEyc9ylj7JDXMw2kXT6KLolLEkS0h8FI9Yu6/1PXwbfEHABSsN94gTk69rEA/axFnHthwQWj2iw43CIXDbev41Xvr5GDVH/WB5rOQI/rdZNZ5zErafrzyx66gWY8oSOONyl21y4gugU6Z2liNt6AdRYWrPDageJ6hqX7eg83+SVXNE0PZfqQ1xvzJByHDdHQbny0aegk6PH/l2Z8TDG+U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996fd04e-dcc8-4a8a-4e87-08d7350beac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 09:55:59.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9mIAGm180peFyZUZpt0PQ5k5A8ai9M9zf0EV4nlMEiKhMLvd0cvTZylDzunUxxtdISLlptI9gds8GueKZyxrNK4bJTDOQBvm8aw4Zdeztk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_04:2019-09-09,2019-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909090104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
we could add a check on the DT for i2c-gate node.=0A=
We also need to add a check on the ACPI configuration used by the ASUS T100=
TA device.=0A=
=0A=
In this case, do you think it is still valuable to have a Kconfig option? (=
this can still help to reduce driver footprint)=0A=
=0A=
Thanks.=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Sent: Sunday, September 8, 2019 13:42=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH 0/8] add magnetometer support for MPU925x=0A=
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
On Thu, 29 Aug 2019 15:18:33 +0000=0A=
=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> This serie of patches adds support of magnetometer inside MPU925x chips.=
=0A=
=0A=
> It is using the MPU i2c master to drive the integrated magnetometer and=
=0A=
=0A=
> read data into the MPU FIFO.=0A=
=0A=
> =0A=
=0A=
> Beware that this is disabling access to the i2c auxiliary bus. Since this=
=0A=
=0A=
> can break existing setup, it is an optional feature requiring to enable=
=0A=
=0A=
> the corresponding Kconfig option.=0A=
=0A=
=0A=
=0A=
That's not great... People will fail to set that correctly for their=0A=
=0A=
setup even if there is a 'correct' setting.=0A=
=0A=
=0A=
=0A=
So we need more information to risk that breakage + discussions of=0A=
=0A=
ways to avoid it.=A0 Can we for example check if the auxiliary bus is=0A=
=0A=
in use? (DT binding for example - check for the i2c-gate node?)=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> =0A=
=0A=
> Jean-Baptiste Maneyrol (8):=0A=
=0A=
>=A0=A0 iio: imu: inv_mpu6050: disable i2c mux for 925x under Kconfig=0A=
=0A=
>=A0=A0 iio: imu: inv_mpu6050: add header include protection macro=0A=
=0A=
>=A0=A0 iio: imu: inv_mpu6050: add defines for supporting 9-axis chips=0A=
=0A=
>=A0=A0 iio: imu: inv_mpu6050: fix objects syntax in Makefile=0A=
=0A=
>=A0=A0 iio: imu: inv_mpu6050: helpers for using i2c master on auxiliary bu=
s=0A=
=0A=
>=A0=A0 iio: imu: inv_mpu6050: add magnetometer implementation for MPU925x=
=0A=
=0A=
>=A0=A0 iio: imu: inv_mpu6050: add magnetometer support inside mpu driver=
=0A=
=0A=
>=A0=A0 iio: imu: inv_mpu6050: add fifo support for magnetometer data=0A=
=0A=
> =0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 9 +=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 8 +-=0A=
=0A=
>=A0 .../iio/imu/inv_mpu6050/inv_mpu9250_magn.c=A0=A0=A0 | 239 ++++++++++++=
++++++=0A=
=0A=
>=A0 .../iio/imu/inv_mpu6050/inv_mpu9250_magn.h=A0=A0=A0 |=A0 27 ++=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c=A0=A0=A0=A0 | 191 ++++++++++=
++++=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h=A0=A0=A0=A0 |=A0 46 ++++=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 141 ++++++++++-=
=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=A0=A0=A0=A0 |=A0=A0 5 +=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 |=A0 79 +++++-=
=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c=A0=A0=A0 | 120 +++++++++=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h=A0=A0=A0 | 107 ++++++++=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=A0=A0=A0 |=A0 14 +-=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=A0 90 ++++++-=0A=
=0A=
>=A0 13 files changed, 1055 insertions(+), 21 deletions(-)=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.c=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu9250_magn.h=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.h=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h=0A=
=0A=
> =0A=
=0A=
=0A=
=0A=
