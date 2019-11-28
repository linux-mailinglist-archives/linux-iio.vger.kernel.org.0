Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6591A10C5B2
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2019 10:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfK1JKe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Nov 2019 04:10:34 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:47488 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfK1JKd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Nov 2019 04:10:33 -0500
X-Greylist: delayed 1407 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Nov 2019 04:10:32 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAS8h614021819;
        Thu, 28 Nov 2019 00:46:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=esmbp9TSTJS1vYVgo0wRrW1EJeicG5VRGZF/O6xEEkA=;
 b=ux2O++xo52dAA+S/kBAnP+DxeYepsmutAXNT4HuSmt66X17G/Riepw7LHHRLuTSXpqIV
 jh+mWlvXkT/y0NKtvjZxE8ZUSs4fE/WWuYAa2UDl0uZ4fQQhZPd+pxEHG8PzaNHSO1TS
 5yN1uiMxgOM552hP8dKHLkzftkFJDFRrIQ/OCv3rgeuMHwYe7+smXlZWWfDDp9JZWENV
 tGWTgy+IvXtrYXyva0qhUCVBNu7TVA7jpFCRPid2mAIB8QJfWpWscS/lviMrQG7fSUj+
 9JxsBtlh0qzHWn95JnlFfGfe6D1TNi9x3oLJKLn3rfzc05HkIN7MoMsxHKbi/UPH+E4o vA== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0b-00328301.pphosted.com with ESMTP id 2whd3b8q91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 00:46:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/AKMp0Fthp84aneWTahGrLUC6IgKqqfpJNFA4rPsjpkRbSaZwTH3cBX1IoOcCXR5gMnK03f79A1DNVbleTM7JdBSKkMWfXO3MALqAhzc9GYaUi/WScIn6O/2k3fxHSqonfE1PcOxnJbxASqK/HQq2Qqgtng+apWa1p/PyNuGtaxM0j87uYktQDedAZSIbgFezBjGRoiw1wfYY5/pMFxrwX5M1RSEQEWiEKG0dBp6eMTiAhGELQeoX77kAcobP9tYBf8RNKpCOsNVp7zM5x9eeScNQMK2K3WejKC6r0Qe6slxMa5J6UpmmgkWPFTtns5DiXW01uC08yZo3yAItPxXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esmbp9TSTJS1vYVgo0wRrW1EJeicG5VRGZF/O6xEEkA=;
 b=ZLvzmPhoxKPDkFfQ22JWr5FVkKKntQowVr1wF1wr0WyOzv62dRV5gaKNfqe4UJUtNBK+kixQVsJfD/1iOvIUsfN7gv2kRB/Cu2H+D1A4Wbpv2qf8Qt3xBc3shljR+6CoycWPxHxnN+gDCsy63DePQxJnBMGBclUUTLX56d5UpyH5Qj/zoSWYdSUxOWZ00wCqZgteSWUT3x0AXMvUE4kfXT0vE0hf8THAmkNyogib6KXlRvfVUkn3Q1lhIIFlZM8vkc1lry6Q+48D0mVEeUXj1W9RyDRP61rA+8y1vdhdP3uWG/zmSS1k9T7/DEBiDj4KJ210DgEE3polla4DmAAd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esmbp9TSTJS1vYVgo0wRrW1EJeicG5VRGZF/O6xEEkA=;
 b=VReGricvX18FMKJ2DWLWb5h1N9FwB42G5ssLUrp3ZvnRtmrSUGWB25kVTxTbpkqfL7r08pKrJNkqSb7w5ZI4BrAYKUDISfBJYClSK6O0CLKX4Yys1+dV+avRtF2z/tqsx0SaMHZV1xQ6RzoKlpLVgxjMXrxNCgT4BdCzpOOdrCA=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3454.namprd12.prod.outlook.com (20.178.242.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Thu, 28 Nov 2019 08:46:29 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 08:46:29 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Richard Weinberger <richard@nod.at>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Select I2C_MUX again
Thread-Topic: [PATCH v2] iio: imu: inv_mpu6050: Select I2C_MUX again
Thread-Index: AQHVpV+8ZsMFCg8oSUmJR7hYsaHcwqegRRpf
Date:   Thu, 28 Nov 2019 08:46:28 +0000
Message-ID: <MN2PR12MB3373EF36E242B4F463D6BF71C4470@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191127201738.1234-1-linus.walleij@linaro.org>
In-Reply-To: <20191127201738.1234-1-linus.walleij@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdf4d85d-0316-4b0d-22cc-08d773df7607
x-ms-traffictypediagnostic: MN2PR12MB3454:
x-microsoft-antispam-prvs: <MN2PR12MB345462E3C985082CCFAE902EC4470@MN2PR12MB3454.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39850400004)(366004)(189003)(199004)(54534003)(11346002)(7696005)(2501003)(76176011)(66556008)(80792005)(71190400001)(64756008)(66446008)(99286004)(91956017)(33656002)(229853002)(6436002)(110136005)(6246003)(71200400001)(9686003)(66476007)(102836004)(55016002)(52536014)(6506007)(66066001)(14444005)(53546011)(86362001)(76116006)(5660300002)(5024004)(25786009)(14454004)(54906003)(305945005)(66946007)(316002)(256004)(74316002)(7736002)(8676002)(8936002)(81156014)(3846002)(478600001)(81166006)(4326008)(2906002)(186003)(26005)(446003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3454;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Y1uQjipmatfS3yB2c+wcfLw6N2wcPSkzGzMZJn0bOl3CHLkmAjQTXL6WKeB2MLtUZxxlUN73m0T9mV/TVslNOKSwJMDpU7dhRSsCUVdGp3c+hF4CR68WQG0E74yskehSdremspTDRoP+1MbfbqK37DxrjVx3647Mgw1KnbUcsqzdwzJ+okKR+s+ohrsloniZdt5OXB+8JH+KLLs4wpHffb7PTBWVRNsCSkiPJ+9KSZt9x4YkVuceUSslgOBM8NSTwYkLSMBJfEs9NoqPWu5ckmZH0t1FmlCUPCSiARVzNM0AqvIvcVwXZvUDZMMVVYAio6lXQuzk+3osrG22PSJFd2uNJkxvgYJ1zxm3b8+Hi8XCfFzCcCmTqSZ47zOpJTYI6yXpXdZN498bM/hfuW1MCgTbjkTVgV45pNkuz7+RNIo5AV3qRo0KbWG3BNoRk0K
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf4d85d-0316-4b0d-22cc-08d773df7607
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 08:46:28.9665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UIhPzarIFD5dG3lfSmwiATxV923lLMWwX8S3acOi+Kh8p91rYZVyowRRugTmw3uVgP95XfuUQR6gHVv4KpBPgybBUEYcnKaVGHhXazLmN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3454
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=908 spamscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
very good idea, I was thinking about it recently.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Linus Walleij <linus.walleij@linaro.org>=0A=
=0A=
Sent: Wednesday, November 27, 2019 21:17=0A=
=0A=
To: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org <linux-i=
io@vger.kernel.org>=0A=
=0A=
Cc: Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>;=
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Linus Walleij <linus.walleij@l=
inaro.org>; Richard Weinberger <richard@nod.at>; Stephan Gerhold <stephan@g=
erhold.net>=0A=
=0A=
Subject: [PATCH v2] iio: imu: inv_mpu6050: Select I2C_MUX again=0A=
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
commit f7072198f217 ("iio: imu: Fix inv_mpu6050 dependencies")=0A=
=0A=
undid the explicit selection of I2C_MUX previously=0A=
=0A=
done by the driver, because I2C_MUX implicitly depended=0A=
=0A=
on HAS_IOMEM.=0A=
=0A=
=0A=
=0A=
However commit 93d710a65ef0 ("i2c: mux: fix up dependencies")=0A=
=0A=
cleared up the situation properly and drivers that need=0A=
=0A=
to select I2C_MUX can now do so again.=0A=
=0A=
=0A=
=0A=
It makes a lot of sense for a driver to select the driver=0A=
=0A=
infrastructure it needs so restore the natural order of=0A=
=0A=
things.=0A=
=0A=
=0A=
=0A=
Cc: Richard Weinberger <richard@nod.at>=0A=
=0A=
Cc: Stephan Gerhold <stephan@gerhold.net>=0A=
=0A=
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>=0A=
=0A=
---=0A=
=0A=
ChangeLog v1->v2:=0A=
=0A=
- Depend on I2C instead of I2C_MUX, it's necessary to=0A=
=0A=
=A0 at least have the I2C infrastructure...=0A=
=0A=
---=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/Kconfig | 3 ++-=0A=
=0A=
=A01 file changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6=
050/Kconfig=0A=
=0A=
index e4c4c12236a7..d9dba6b8abf6 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/Kconfig=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig=0A=
=0A=
@@ -10,7 +10,8 @@ config INV_MPU6050_IIO=0A=
=0A=
=A0=0A=
=0A=
=A0config INV_MPU6050_I2C=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 tristate "Invensense MPU6050 devices (I2C)"=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 depends on I2C_MUX=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 depends on I2C=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 select I2C_MUX=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 select INV_MPU6050_IIO=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 select REGMAP_I2C=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 help=0A=
=0A=
-- =0A=
=0A=
2.21.0=0A=
=0A=
=0A=
=0A=
