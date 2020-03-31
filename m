Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5DF199F65
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgCaTqo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 15:46:44 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:6694 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727768AbgCaTqo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 15:46:44 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VJcaQc010792;
        Tue, 31 Mar 2020 12:46:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=Z8WwJAa4WyZdByVL1MCqM4JMkTrC8Ts3k/6ySjRbh9o=;
 b=dMug8tB/AnQI6LORuvQNrT71kU1joVNoyjNNBHJak+6af4k8YojriuQV0DKAaOF7tpIW
 03YwoRs4pkMufMdCzEhehh/Bs8tr6ndsoW1a4u8RGyR5TK1aVhowKAvYjDT2rOMhSt42
 mo/c2EUpBwya2mZVyg2qn9g2ylaZIZ6Rp7dNvktxIt2XALUP4DQzR/4+1aN6qn8y+itS
 lSiJkHepGlaPEi/cQHtOWQfxbOGgUQBLXQi8sL5PpwrNicocN9KUp9GZfBlD9WcpsJQd
 4HGsfq1aXzNf56kFyVA0vAtfrVcoK8Uw7tyASS5xn9qKDDVKkndhURNbZYRd7sjUGeYK kQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00328301.pphosted.com with ESMTP id 303rc28gpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 12:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC4BwQxq3WfMBp5zUSF1nM0rXUVxcFr61IH4yIPEle9SsCQzqjXci9Vu9+4e6rwsc3mNIFcHrbg4q/X8b9JkvSxRKSEVQSfDoo4A4aRY35Hj+332gC74YudV/OfpuE+PJCGfMbOG9bnWkSIW9ohBZ/pQmrMJaBzEBrGXpHL/WFOvDMDyeHh4rwPFJ6GgG6c52sgs5a5ANhJP4SPd5veogIHTfUGPQNBOamEn328wYkPjnF+ht70EAA/2najZe4G6NloFI2OXVh/xcAz4esfGYd+A9BeAs3iFoT37UkA3MJW2t9t3TU9Slo4RMGuhj8iICpbZPbNpNu6DtVK89DNioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8WwJAa4WyZdByVL1MCqM4JMkTrC8Ts3k/6ySjRbh9o=;
 b=F4QWXeiYiRunCSW2562StOzFhjo8WS/+PBvbzvxJXtFweOHz3Q06jY6TaBoVb5TO6VP8lcgW0SyF76rP/FCcaDnWIBcC6JZNV9OjPaAdUpfzQzZFRuonYAVYw50h1vC/En7R2l2vQHUGySFP9/8yH8hqV1kBlSb9XccHOT2cCPfvTd+rtbEOmYI7kWSTxawonL4IxBQTeACgqOL+F2xlBU/8TZHqGGiYyXPpMXhJdiFvvp6Dklni5UDDv/XAgRTt0Fp1tUFEAMeajZmWGz8ySVe+p8vZK2IYAJ84uu+JQ1N7b9k9ubAhC+sX1sh69C0ff8NRsp9dweuz6eCW7FPhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8WwJAa4WyZdByVL1MCqM4JMkTrC8Ts3k/6ySjRbh9o=;
 b=LpooCF8sZej9GFuRnELrJNzNtM/wZCk2GWhbgcwjSZ7Lr/BeCv9L1QYsk3dQsDNGEn+0NE3NMdmqaqqOba+hafxBJ6UMZyerDJSIswuh+rg4dP2q4U6uMKNu0V7QVJWcIPEuxb8JOnOQaKWOc0h1isuwBsU8o8nGpTyoY1r6Glc=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3629.namprd12.prod.outlook.com (2603:10b6:208:cb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 19:46:38 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 19:46:38 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime
 power
Thread-Topic: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime
 power
Thread-Index: AQHWB2HEfG9pP8WIw0etsswWO1hkTqhi9Q2AgAAkvjA=
Date:   Tue, 31 Mar 2020 19:46:37 +0000
Message-ID: <MN2PR12MB442295EC389A438B13D4BF1CC4C80@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200331133850.23757-1-jmaneyrol@invensense.com>,<CAHp75VcSrej_dXeKBXXoVBg-3scUHrZuwRDrdB0Qy4vOGHbLag@mail.gmail.com>
In-Reply-To: <CAHp75VcSrej_dXeKBXXoVBg-3scUHrZuwRDrdB0Qy4vOGHbLag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e9b9e7b-8eb2-4fd8-ca27-08d7d5ac3a00
x-ms-traffictypediagnostic: MN2PR12MB3629:
x-microsoft-antispam-prvs: <MN2PR12MB3629BA9CD63E10232F28E443C4C80@MN2PR12MB3629.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(39850400004)(346002)(376002)(396003)(366004)(52536014)(66446008)(6506007)(2906002)(64756008)(478600001)(53546011)(66476007)(66556008)(5660300002)(7696005)(86362001)(8676002)(81156014)(76116006)(4326008)(81166006)(91956017)(54906003)(66946007)(186003)(33656002)(26005)(8936002)(71200400001)(15650500001)(9686003)(6916009)(55016002)(316002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXKRMm9wB4XgNomje/E2eYY9dOOD9oibzRRWvbBm6Vg7KgPPIXmOldh8qKjsqWqHu8REK0u6pxeWdQKCtrSDXhYs3mOr4Od8HJEvBYXPOGuNOR9X6FBhfGhpuDCZ0v1z/2qcDncvqirLGzbpUQfzytsxdRuxiFP1/fhLyjzuii7Xn69v3KrfaNGJ1XBdQQRKtz8VmCEwPkgXuVBfInPzvSaNbIxtv0ZESuYOQxASeZAaLkpgUJ7qGqAOFjmLGTpy2SlegeV/4o6hf+sJYAthAvtQUGaJg0abmE/0qXQpgLD1rTkCy6eLVdXjhMqFxUT1xP8Sc+k59nZC38cz9hFNxhsnhMzkigmbxPtAj2HzQGTWSaCORX/cXvTbDBTvjBHWPDDZLPDwu7zNDMxpYn/pxSXK+zPrJFLedVpzrxTPrdyG8hXKGR55IRhEnoGobEFm
x-ms-exchange-antispam-messagedata: vTrTvq8wbWu7jZuQGbXzgB0Z0TUe0eq602RBfQ5Sp7WwYXZVQnb2BiFXEJf08ymr9u4rS2mhuX76Th8J5W8MvF9RKMzKxle8sOODdXByGa4Zou/fpn/IG5jixZvLpBa0WwMjty89YzIDvYNt0vHkcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9b9e7b-8eb2-4fd8-ca27-08d7d5ac3a00
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 19:46:37.9639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZJUnndQLKDIvUI5o/OQ2hifoohp1cJ4+PvkZsWXydryJNIa5YDf2d5ynBMJ8vPAAiHzVfZ0NkgYAwFZeAn9RgBHeBBT7+aSNGI18z5fKGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3629
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310164
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
by reading kernel documentation, I was thinking that PM was excluding this =
possibility.=0A=
=0A=
Quote from power/runtime_pm:=0A=
"The PM core does its best to reduce the probability of race conditions bet=
ween the runtime PM and system suspend/resume (and hibernation) callbacks b=
y carrying out the following operations:=0A=
        * During system suspend pm_runtime_get_noresume() is called for eve=
ry device right before executing the subsystem-level .prepare() callback fo=
r it and pm_runtime_barrier() is called for every device right before execu=
ting the subsystem-level .suspend() callback for it. In addition to that th=
e PM core calls __pm_runtime_disable() with =91false=92 as the second argum=
ent for every device right before executing the subsystem-level .suspend_la=
te() callback for it.=0A=
         * During system resume pm_runtime_enable() and pm_runtime_put() ar=
e called for every device right after executing the subsystem-level .resume=
_early() callback and right after executing the subsystem-level .complete()=
 callback for it, respectively"=0A=
=0A=
The 2 suspend callbacks are also locking the device mutex.=0A=
=0A=
But I can totally misunderstood the situation. If you can confirm if it is =
the case or not, that would be really helpful.=0A=
=0A=
Thanks a lot,=0A=
JB=0A=
=0A=
=0A=
From: Andy Shevchenko <andy.shevchenko@gmail.com>=0A=
=0A=
Sent: Tuesday, March 31, 2020 19:29=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron <jic23@kernel.o=
rg>=0A=
=0A=
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix suspend/resume with runtime=
 power=0A=
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
On Tue, Mar 31, 2020 at 4:39 PM Jean-Baptiste Maneyrol=0A=
=0A=
<jmaneyrol@invensense.com> wrote:=0A=
=0A=
>=0A=
=0A=
> Suspend/resume were not working correctly with pm runtime.=0A=
=0A=
> Now suspend check if the chip is already suspended, and=0A=
=0A=
> resume put runtime pm in the correct state.=0A=
=0A=
>=0A=
=0A=
> Fixes: 4599cac84614 ("iio: imu: inv_mpu6050: use runtime pm with autosusp=
end")=0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0 st->suspended_sensors =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0 if (pm_runtime_suspended(dev)) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_unlock;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=0A=
=0A=
AFAIK this is not enough to guarantee that device *will be* suspended.=0A=
=0A=
That said, in one thread you may get device in the middle of RPM=0A=
=0A=
suspend, while here you are checking if it's okay or not, but after in=0A=
=0A=
the other thread you will get an error and roll back to the resumed=0A=
=0A=
state.=0A=
=0A=
=0A=
=0A=
-- =0A=
=0A=
With Best Regards,=0A=
=0A=
Andy Shevchenko=0A=
=0A=
