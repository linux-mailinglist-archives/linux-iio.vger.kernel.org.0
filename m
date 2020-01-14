Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6B13A41A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgANJq0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 04:46:26 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:49700 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726169AbgANJqZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 04:46:25 -0500
X-Greylist: delayed 1398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jan 2020 04:46:22 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00E9N3UV007696;
        Tue, 14 Jan 2020 01:23:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=QzxhXSscXbYRKaqUQltuTdprpiPRR4/gZeCcMED7cJI=;
 b=q/2/fM0JekM31lweYfYBQ/IHi6DH+64eHveT1hgvAJ4yeY/UgpgUs7Y1JJjrg4wI8Hk0
 CEprCwY5Y7hCeoELDuoyULAj8Ch4+eQSrJJCoBQTJFRZleCq6U+NpeZM8YfPiyPpCe86
 rS1lTBBInlFCAiaZhqpVeSJa4mE453fk5WdyohkRnfJ5uRsrEtagNzbnDfPcbEDKFRne
 6Lx/xxYSeDIv8ZLszUgm7dZWtfrAF+EM+d8t+7mTxepMkzlfiv6CFsMqouHP+VYHTDig
 E/XwshMpq2e9hrk/iyeIeG89iLU0bbV5BeqcZGrIjpVjW28QJ8DSA4TBpENbInmglgQI cA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-00328301.pphosted.com with ESMTP id 2xga510s12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 01:23:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njtVASjO2QqIQlUqRReCTEarfB42iDuZhflEVaNaPD+Y3W2+7Z4Q2nM99HZ88TzC0kctHoP4sXu7zJMgxMzcQYlEPfg7UbIwrVaoq61qBxhLvsLgzv9dxRy5iHoM1LktSiBana6GO88iy1MQjKS2M97Ihs6jsdb+itPJUr0weo4l2M8Y5GPrNHzCfxWAUJnTLPMCMfvOCvzlkqk2dGWaZ9z0pDjBfiY6Mm9A6iVaHhVd5lwEewBr+mQk3csRq6aJCawtgqtTpB9unedcz8X//lxFJ2ZWAd3u+5pcbCcJt5geNHarhy9Fgr24+JPRFEFdVf7oI8p5mEtPfrWBlDGVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzxhXSscXbYRKaqUQltuTdprpiPRR4/gZeCcMED7cJI=;
 b=Znw0so9S959ZUJu2dQUN7cgpLpID1YDkrzlqDh1/CrBnKMWy7ASWA4s/QAe/Xi4O1n+YoKAlxBoqd3DVleNqvr2IYZBK6/X5s/NyRvkyXXEzrUXM0nC1PlT/T9O1lyVtwm1LUt58Ycqe/eJxwmUh45hw0J24zNfXORfNIlZ4o22lZH0TxjveEiVRX27/3FsnsjQCaARWlcWeoOFGOw7uuLkGywgSU9SaGXnSN9lfNXcnrAwURY15PRUTeGgg66kF1ddeIwpQhYzmdNQbcu3cHrmivnfMIMaYlZsJBukAkMiO+6K1vw8OLU2fDOwlJI6xbJqOj+4fGp9ugMi3/xs9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzxhXSscXbYRKaqUQltuTdprpiPRR4/gZeCcMED7cJI=;
 b=lofcwvSm+J5T0of4GQDc1CbbR6cZUxdCftiCxkcf3/lhRiHppEmADGbHndZokQaLyLb7NlZ7WRzKqngqwClvS3G/nIh7f0gppCeM92wW05iDf3atyyXjWWsfNiltALd5UMBCb3Vh3q0o4Gpgkra+tzFiXKwCrZu1TzlOU36gUX0=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3343.namprd12.prod.outlook.com (20.178.240.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 09:22:59 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::4028:892b:b405:59fa%6]) with mapi id 15.20.2623.015; Tue, 14 Jan 2020
 09:22:59 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data
 support
Thread-Topic: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data
 support
Thread-Index: AQHVnfvN1ETmvoI+DUqfeddhP/8856eY+I8AgA36P9aAIkZwvoAJ5qgAgBcb+Hw=
Date:   Tue, 14 Jan 2020 09:22:59 +0000
Message-ID: <MN2PR12MB3373CA90D67E5B17DCE76A8BC4340@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191118103406.9353-1-jmaneyrol@invensense.com>
        <20191118103406.9353-2-jmaneyrol@invensense.com>
        <20191123162256.386c085a@archlinux>
        <MN2PR12MB33739BF5EA2C9E402EDF4684C4430@MN2PR12MB3373.namprd12.prod.outlook.com>
        <MN2PR12MB3373B2617FAD6FB24EAC0787C4290@MN2PR12MB3373.namprd12.prod.outlook.com>,<20191230162648.505bb0d9@archlinux>
In-Reply-To: <20191230162648.505bb0d9@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3cae3bc-e379-494f-2d14-08d798d35924
x-ms-traffictypediagnostic: MN2PR12MB3343:
x-microsoft-antispam-prvs: <MN2PR12MB3343BFEA6A316DE2DA7C492CC4340@MN2PR12MB3343.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 028256169F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39850400004)(136003)(396003)(346002)(189003)(199004)(8936002)(6506007)(86362001)(186003)(7696005)(71200400001)(26005)(30864003)(64756008)(66446008)(52536014)(66946007)(53546011)(66556008)(5660300002)(66476007)(6916009)(2906002)(76116006)(55016002)(81156014)(91956017)(478600001)(316002)(9686003)(33656002)(4326008)(8676002)(81166006)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3343;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tAAd5Y/+wXdfX0aYOZy+i5npvdE2r2aHpgmezrRgnM0IbZF1/I8qaTKfxFALf8SM9WVWCZ/Uj30L4QtsniyCI5lUjQK4lHUbGAuBkyU+g9e0FdVBoKKo31ySkUN5MQjDhuyVhP+r0cY1PXLoP1YQvjqS1pT1BW38fT6xQAmHGy5lXj5zIYwnNnI+wfUTsFUzClfa6N2BNX7F64D4m3lykpEZcPjjODtSB9UmiBF3PHXHw+InYG4xuIfN5Et+ChjboKF1gZOjXTv8mbDFEa9hNlVv8GXEZjbNXZYvaTJ1IDpwlU/4X/rkYm1+7N8acfDjRMFr6zu3i8wG4XCVT+pWaAQdWaZNVgEooVp7aioJ4QwiRUgCoKQWQy7+IQf8QtTEYFXkZ6MeL/NLc+B1PuGfB3wamaJQbiKOb8jjqW3QBKPUFVInx3fnyTgGxdoD1LB6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cae3bc-e379-494f-2d14-08d798d35924
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2020 09:22:59.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVA7XMf5Jg05QeZ51NaDQPE6lIZpsc611UXE/UIawdM2aZppLxEnzOBWW+jM90pUrb6eUQgLfEBphiXTjbhMKBl/sS/0Qex8MtRDJ7SlI74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3343
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_02:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
a kind reminder about this patch still waiting. Now testing branch is ready=
 for it to be applied.=0A=
=0A=
I've got a good number of other patches just waiting for this one to be acc=
epted before sending.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Sent: Monday, December 30, 2019 17:26=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data s=
upport=0A=
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
On Tue, 24 Dec 2019 09:17:05 +0000=0A=
=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Hi Jonathan,=0A=
=0A=
> =0A=
=0A=
> any news about my 2nd patch ("[PATCH 2/2] iio: imu: inv_mpu6050: add fifo=
 temperature data support") now that the 1st is included inside fixes-togre=
g branch?=0A=
=0A=
> =0A=
=0A=
> The 1st one is still not yet available inside testing branch.=0A=
=0A=
> Should I resend it now or wait for testing to be in sync with fixes-togre=
g?=0A=
=0A=
I have it flagged in my email so in theory at least I will grab it=0A=
=0A=
without a resend.=A0 I think I'll do a pull request for togreg later this=
=0A=
=0A=
week and after that I should be fine applying this.=0A=
=0A=
=0A=
=0A=
Things got a bit slowed down for the holidays :)=A0 Too easy to put=0A=
=0A=
things off to tomorrow!=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> =0A=
=0A=
> Thanks,=0A=
=0A=
> JB=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
> =0A=
=0A=
> Sent: Monday, December 2, 2019 14:50=0A=
=0A=
> =0A=
=0A=
> To: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
> =0A=
=0A=
> Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data=
 support=0A=
=0A=
> =0A=
=0A=
> =A0=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Hi Jonathan,=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> just a reminder for not forgetting this patch now that the first is in fi=
xes-togreg branch.=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Thanks,=0A=
=0A=
> =0A=
=0A=
> JB=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> From: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Sent: Saturday, November 23, 2019 17:22=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: add fifo temperature data=
 support=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =A0=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =A0CAUTION: This email originated from outside of the organization. Pleas=
e make sure the sender is who they say they are and do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> On Mon, 18 Nov 2019 11:34:06 +0100=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > Add support of temperature data in fifo for all chips.=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > Enable unification of scan elements for icm20602.=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > Add macros for generating scan elements with and without temp.=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Looks fine to me. I'll pick up once we've worked out what=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> we are doing with patch 1.=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Remind me if I seem to have lost it.=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Thanks,=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> Jonathan=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > ---=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0=A0=A0 | 194 +++++++---=
--------=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0=A0=A0=A0 |=A0 22 +-=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=A0=A0=A0 |=A0=A0 6 +-=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |=A0=A0 3 +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 4 files changed, 84 insertions(+), 141 deletions(-)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > index 268240644adf..7c2f6951364d 100644=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -104,6 +104,7 @@ static const struct inv_mpu6050_chip_config chip_co=
nfig_6050 =3D {=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 .divider =3D INV_MPU6050_FIFO_RATE_TO_DIVIDER(INV_=
MPU6050_INIT_FIFO_RATE),=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 .gyro_fifo_enable =3D false,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 .accl_fifo_enable =3D false,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 .temp_fifo_enable =3D false,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 .magn_fifo_enable =3D false,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 .accl_fs =3D INV_MPU6050_FS_02G,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 .user_ctrl =3D 0,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -856,19 +857,27 @@ static const struct iio_chan_spec_ext_info inv_ex=
t_info[] =3D {=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .ext_info =3D inv_ext_info=
,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 }=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +#define INV_MPU6050_TEMP_CHAN(_index)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_C=
HAN_INFO_RAW)=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D _index,=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .sign =3D=
 's',=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .realbits=
 =3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .storageb=
its =3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
\=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .shift =
=3D 0,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .endianne=
ss =3D IIO_BE,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 }=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 static const struct iio_chan_spec inv_mpu_channels[] =3D {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP=
),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 /*=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 * Note that temperature should only be via polled read=
ing only,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 * not the final scan elements output.=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_C=
HAN_INFO_RAW)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D -1,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 },=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6=
050_SCAN_GYRO_X),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6=
050_SCAN_GYRO_Y),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6=
050_SCAN_GYRO_Z),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -878,22 +887,31 @@ static const struct iio_chan_spec inv_mpu_channel=
s[] =3D {=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050=
_SCAN_ACCL_Z),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 };=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +#define INV_MPU6050_SCAN_MASK_3AXIS_ACCEL=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 (BIT(INV_MPU6050_SCAN_ACCL_X)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z))=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +#define INV_MPU6050_SCAN_MASK_3AXIS_GYRO=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 (BIT(INV_MPU6050_SCAN_GYRO_X)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z))=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +#define INV_MPU6050_SCAN_MASK_TEMP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (BIT(=
INV_MPU6050_SCAN_TEMP))=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +/* generate scan mask and a duplicate with temperature enabled */=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +#define INV_MPU6050_SCAN_MASK_DUP_TEMP(_mask)=A0=A0=A0=A0=A0=A0=A0 \=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 (_mask),=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 (_mask) | INV_MPU6050_SCAN_MASK_TEMP=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 static const unsigned long inv_mpu_scan_masks[] =3D {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 3-axis accel */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_ACCEL),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 3-axis gyro */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_GYRO),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 6-axis accel + gyro */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_ACCEL=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU=
6050_SCAN_MASK_3AXIS_GYRO),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 0,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 };=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -917,17 +935,9 @@ static const unsigned long inv_mpu_scan_masks[] =
=3D {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 static const struct iio_chan_spec inv_mpu9150_channels[] =3D {=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP=
),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 /*=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 * Note that temperature should only be via polled read=
ing only,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 * not the final scan elements output.=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_C=
HAN_INFO_RAW)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D -1,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 },=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6=
050_SCAN_GYRO_X),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6=
050_SCAN_GYRO_Y),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6=
050_SCAN_GYRO_Z),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -944,17 +954,9 @@ static const struct iio_chan_spec inv_mpu9150_chan=
nels[] =3D {=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 static const struct iio_chan_spec inv_mpu9250_channels[] =3D {=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP=
),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 /*=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 * Note that temperature should only be via polled read=
ing only,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 * not the final scan elements output.=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0 */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_C=
HAN_INFO_RAW)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D -1,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 },=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_TEMP_CHAN(INV_MPU6050_SCAN_TEMP),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6=
050_SCAN_GYRO_X),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6=
050_SCAN_GYRO_Y),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6=
050_SCAN_GYRO_Z),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -969,98 +971,42 @@ static const struct iio_chan_spec inv_mpu9250_cha=
nnels[] =3D {=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_S=
CAN_MAGN_Z),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 };=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +#define INV_MPU9X50_SCAN_MASK_3AXIS_MAGN=A0=A0=A0=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 (BIT(INV_MPU9X50_SCAN_MAGN_X)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 \=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z))=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 static const unsigned long inv_mpu9x50_scan_masks[] =3D {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 3-axis accel */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_ACCEL),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 3-axis gyro */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_GYRO),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 3-axis magn */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_MAGN_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU9X50_SCAN_MASK_3AXI=
S_MAGN),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 6-axis accel + gyro */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_ACCEL=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU=
6050_SCAN_MASK_3AXIS_GYRO),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 6-axis accel + magn */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_ACCEL=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU=
9X50_SCAN_MASK_3AXIS_MAGN),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 6-axis gyro + magn */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_GYRO_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_GYRO=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU=
9X50_SCAN_MASK_3AXIS_MAGN),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 9-axis accel + gyro + magn */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_MPU6050_SCAN_ACCL_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_ACCL_Z)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_X)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU6050_SCAN_GYRO_Z)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_DUP_TEMP(INV_MPU6050_SCAN_MASK_3AXI=
S_ACCEL=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU=
6050_SCAN_MASK_3AXIS_GYRO=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU=
9X50_SCAN_MASK_3AXIS_MAGN),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 0,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 };=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -static const struct iio_chan_spec inv_icm20602_channels[] =3D {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_C=
HAN_INFO_RAW)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D INV_ICM20602_SCAN=
_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .sign =3D 's',=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .realbits =3D 16,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .storagebits =3D 16,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .shift =3D 0,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .endianness =3D IIO_BE,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 },=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 },=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_ICM20602_SC=
AN_GYRO_X),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_ICM20602_SC=
AN_GYRO_Y),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_ICM20602_SC=
AN_GYRO_Z),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_ICM20602_SCAN_=
ACCL_Y),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_ICM20602_SCAN_=
ACCL_X),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_SCAN_=
ACCL_Z),=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -};=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 static const unsigned long inv_icm20602_scan_masks[] =3D {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 3-axis accel + temp (mandatory) */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_ACCL_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK=
_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 3-axis gyro + temp (mandatory) */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_GYRO_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_3AXIS_GYRO | INV_MPU6050_SCAN_MASK_=
TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 /* 6-axis accel + gyro + temp (mandatory) */=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 BIT(INV_ICM20602_SCAN_ACCL_X)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Y)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_ACCL_Z)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_X)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Y)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_GYRO_Z)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_ICM20602_SCAN_TEMP),=A0=
 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_MASK_3AXIS_ACCEL | INV_MPU6050_SCAN_MASK=
_3AXIS_GYRO=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | INV_MPU=
6050_SCAN_MASK_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 0,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 };=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -1363,8 +1309,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int=
 irq, const char *name,=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_=
masks =3D inv_mpu9x50_scan_masks;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 case INV_ICM20602:=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_icm20=
602_channels;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY=
_SIZE(inv_icm20602_channels);=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_mpu_c=
hannels;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY=
_SIZE(inv_mpu_channels);=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_=
masks =3D inv_icm20602_scan_masks;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 default:=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > index b096e010d4ee..6158fca7f70e 100644=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -86,6 +86,7 @@ enum inv_devices {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0 *=A0 @accl_fs:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 accel=
 full scale range.=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0 *=A0 @accl_fifo_enable:=A0=A0=A0=A0=A0=A0 enable accel data outpu=
t=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0 *=A0 @gyro_fifo_enable:=A0=A0=A0=A0=A0=A0 enable gyro data output=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > + *=A0 @temp_fifo_enable:=A0=A0=A0=A0=A0=A0 enable temp data output=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0 *=A0 @magn_fifo_enable:=A0=A0=A0=A0=A0=A0 enable magn data output=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0 *=A0 @divider:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 chip =
sample rate divider (sample rate divider - 1)=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0 */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -95,6 +96,7 @@ struct inv_mpu6050_chip_config {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 unsigned int accl_fs:2;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 unsigned int accl_fifo_enable:1;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 unsigned int gyro_fifo_enable:1;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 unsigned int temp_fifo_enable:1;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 unsigned int magn_fifo_enable:1;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 u8 divider;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 u8 user_ctrl;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -184,6 +186,7 @@ struct inv_mpu6050_state {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU6050_BIT_SLAVE_2=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
0x04=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU6050_BIT_ACCEL_OUT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x08=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU6050_BITS_GYRO_OUT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x70=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +#define INV_MPU6050_BIT_TEMP_OUT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x80=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU6050_REG_I2C_MST_CTRL=A0=A0=A0=A0=A0=A0=A0 0x24=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU6050_BITS_I2C_MST_CLK_400KHZ 0x0D=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -268,8 +271,8 @@ struct inv_mpu6050_state {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 /* MPU9X50 9-axis magnetometer */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU9X50_BYTES_MAGN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 7=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -/* ICM20602 FIFO samples include temperature readings */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -#define INV_ICM20602_BYTES_PER_TEMP_SENSOR=A0=A0 2=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +/* FIFO temperature sample size */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +#define INV_MPU6050_BYTES_PER_TEMP_SENSOR=A0=A0 2=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 /* mpu6500 registers */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU6500_REG_ACCEL_CONFIG_2=A0=A0=A0=A0=A0 0x1D=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -298,7 +301,7 @@ struct inv_mpu6050_state {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_ICM20608_TEMP_OFFSET=A0=A0=A0=A0=A0=A0=A0=A0=A0 8170=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_ICM20608_TEMP_SCALE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 3059976=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -/* 6 + 6 + 7 (for MPU9x50) =3D 19 round up to 24 and plus 8 */=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +/* 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus 8 */=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU6050_OUTPUT_DATA_SIZE=A0=A0=A0=A0=A0=A0=A0=A0 32=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 #define INV_MPU6050_REG_INT_PIN_CFG=A0 0x37=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -344,6 +347,7 @@ enum inv_mpu6050_scan {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_ACCL_X,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_ACCL_Y,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_ACCL_Z,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 INV_MPU6050_SCAN_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_GYRO_X,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_GYRO_Y,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_SCAN_GYRO_Z,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -355,18 +359,6 @@ enum inv_mpu6050_scan {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU9X50_SCAN_TIMESTAMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 };=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -/* scan element definition for ICM20602, which includes temperature */=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -enum inv_icm20602_scan {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_X,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_Y,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_ICM20602_SCAN_ACCL_Z,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_ICM20602_SCAN_TEMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_X,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_Y,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_ICM20602_SCAN_GYRO_Z,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 INV_ICM20602_SCAN_TIMESTAMP,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -};=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 enum inv_mpu6050_filter_e {=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_FILTER_256HZ_NOLPF2 =3D 0,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_FILTER_188HZ,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_ring.c=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > index 10d16ec5104b..3755577dc449 100644=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -142,6 +142,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)=A0 =
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d |=3D INV_MPU6050_BITS_GY=
RO_OUT;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.accl_fifo_enable)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d |=3D INV_MPU6050_BIT_ACC=
EL_OUT;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 if (st->chip_config.temp_fifo_enable)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d |=3D INV_MPU6050_BIT_TEMP_OUT;=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.magn_fifo_enable)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d |=3D INV_MPU6050_BIT_SLA=
VE_0;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->fifo_en,=
 d);=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -200,8 +202,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.gyro_fifo_enable)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_M=
PU6050_BYTES_PER_3AXIS_SENSOR;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0 if (st->chip_type =3D=3D INV_ICM20602)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_ICM20602=
_BYTES_PER_TEMP_SENSOR;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 if (st->chip_config.temp_fifo_enable)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_MPU6050_=
BYTES_PER_TEMP_SENSOR;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0 if (st->chip_config.magn_fifo_enable)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bytes_per_datum +=3D INV_M=
PU9X50_BYTES_MAGN;=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_trigger.c=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > index a9c75bc62f18..5199fe790c30 100644=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > @@ -24,6 +24,9 @@ static void inv_scan_query_mpu6050(struct iio_dev *in=
dio_dev)=A0=0A=
=0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 indio_dev->active_scan_mask) ||=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(INV_MPU6050_SCAN_=
ACCL_Z,=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 indio_dev->active_scan_mask);=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0 st->chip_config.temp_fifo_enable =3D=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(INV_MPU6050_SCAN_TEMP, i=
ndio_dev->active_scan_mask);=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 }=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0=A0=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> >=A0 static void inv_scan_query_mpu9x50(struct iio_dev *indio_dev)=A0 =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
> =0A=
=0A=
=0A=
=0A=
