Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D859F2F60
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfKGNaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 08:30:09 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:45994 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730833AbfKGNaJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 08:30:09 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7DQGDd029494;
        Thu, 7 Nov 2019 05:29:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=ArvIQiRje9bW9iBMVLLySSsHknj2m9/U+k2q8UTbNRo=;
 b=o8iX0UH8D1rU5X46kTO8NDNCrRry5TtHlxcnvcv5wTydzFHZSqO8mMPl0PhQpq0+FoB9
 IMA1U0vVyzxZvxCBDPysTqsB3BZRdThxR4TbLiw4w45mrN+wtvQA1OtYcRrFYFpqmvT6
 Yjp97U/icSd19tRLIDrzwtJK6y3vkHdDZHFX8DdqPF/O/THUE8P9/2O2ZnbyLmdd1cdd
 ei89NXTCmnGQ4C4Au9Gc6W1tyWoyBS0uZP7sWK1jVmkD/int3g4uFecpzMRaSwbGKzBh
 7k3aobOnFmk5JNi6/3x0TY+zcwHA1lrxaT/RSq3ivz5azQMyaqZv2LYnufEmJesIIxIM Rw== 
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-00328301.pphosted.com with ESMTP id 2w41wv8g4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 05:29:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZYqrpzJwOXh0kCcIEqzfya5ZPAoC/X4wpz24kNOQcUfKZU558cC3aQN39pSL2TvofCRc42FSUIW0lwmHBkq7jPTX+ENKgL0BRXT8LGuxTcJLyyGwqG6Ez5ww9j5/XUUU0NbcldovfdneVT3L4izCZKMOBgEo6p+VnvI9pRKTcg/bVTyejNvt4S04QE+OivbLFYZxZ0r+eJ9X9tuGWBNiaDzcvgOf8jwYJMOY+teFTy5ZRApyNtcwFsYHYxSeqYNlqtHukrgKuhfdZ+F80l7unUxIm7P3okiUAX4Nta8NFdY3x73emIoUCwfhIWHquGbhT42+yQR863sigg0PKjnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArvIQiRje9bW9iBMVLLySSsHknj2m9/U+k2q8UTbNRo=;
 b=G6MTdrXDUtqQJgmZIt64tN9orhiOHTgF/fyB7RsEUtuVw1QuDnOg8i04Sv4uGbVtqaoUGUxSklKWdxli7/8fX88pc50rPtmKV1FHvxEZVzYSmQYTmf74JJKc5LGTzpe6SJSl7vmBGapma0jYHWZB9afEVf1FdbupARK0oBUyEozF9105/d5J5zHYzBbK7ShbEXVlqUhkW3CPjnIc/mQeEyXbaaBaEeSHQdJ7C9gFsVvmKyxGe2fJ60UjNxScTyUTlXd15SdpIGOg30Iqh1J1UEZemcLARcbPn5Lpdr0lxhuCmeAuBWDGmt0mY0AWdU5v2BscFgifV+c5wzr8E4h94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArvIQiRje9bW9iBMVLLySSsHknj2m9/U+k2q8UTbNRo=;
 b=So5pf1dt69RRoqd3sL+cR8qavyqam52CwuAO5dhrvweUMMvN3Hw19GeRVrupMKID8jay9Ino3hYxlN3DFybyJYUh+Ncc718duPILn/BQIeoJ47Ct+35pXIcHyTHYiLZL2+hk+nwwzCVb781C4K7PwG5031zLi3u7gVaX9+O/gJ8=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3917.namprd12.prod.outlook.com (10.255.237.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Thu, 7 Nov 2019 13:29:33 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 13:29:33 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Stephan Gerhold <stephan@gerhold.net>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: mpu6050: Add support for vdd-supply
 regulator
Thread-Topic: [PATCH 2/2] iio: imu: mpu6050: Add support for vdd-supply
 regulator
Thread-Index: AQHVlNFPtLyzEyio0k+Y+ApC2k58Gqd+jQakgAAdxwCAAQpE1A==
Date:   Thu, 7 Nov 2019 13:29:33 +0000
Message-ID: <MN2PR12MB3373846E85AA1A396198F46EC4780@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191106183536.123070-1-stephan@gerhold.net>
 <20191106183536.123070-2-stephan@gerhold.net>
 <MN2PR12MB3373CA676226F02BE0C804A8C4790@MN2PR12MB3373.namprd12.prod.outlook.com>,<20191106213359.GA130672@gerhold.net>
In-Reply-To: <20191106213359.GA130672@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e66ed96c-8da1-4a15-0593-08d7638686ef
x-ms-traffictypediagnostic: MN2PR12MB3917:
x-microsoft-antispam-prvs: <MN2PR12MB391753F0B6F5C5873B532FA8C4780@MN2PR12MB3917.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39850400004)(396003)(346002)(199004)(189003)(478600001)(6436002)(52536014)(7736002)(305945005)(186003)(11346002)(76176011)(4326008)(8676002)(66066001)(3846002)(26005)(229853002)(25786009)(5024004)(7416002)(14444005)(6116002)(256004)(14454004)(81156014)(81166006)(9686003)(8936002)(55016002)(446003)(74316002)(86362001)(80792005)(476003)(7696005)(33656002)(6246003)(64756008)(66446008)(486006)(66476007)(66556008)(66946007)(99286004)(54906003)(5660300002)(2906002)(316002)(53546011)(102836004)(76116006)(6506007)(91956017)(6916009)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3917;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d7UY2EUg4CX4gftZwR1otO8Mc9kRpPVSZLM9Ut0V43bs8WixRcnQjCkZ4hg+b9Na4nEUmQUezHVCkK6DmqTwDy0xFdmYA+V0z3fcPTKPNx6A8Kl/z/oX6zZ2QNsT8r5hEJndLovi4qtERQYvxie4J10nj6aS13czvIfT6GOMVRumaB78ngSttzITB1Q7/WZYF+bjnndT9c+v1XPz4AXzZdlDocjDk+af4ikfk1GdW81cJS7VwpJVxqKP4acOxR49FtP4H3J9KM3lm7Y0HUk4T+N1u8/m3BxUxRbnndKDP4UVrBi7hkGDnZnVBztACRkwv9PuGHAYzKj3+rocvMB64wTZv1/Y2Ia86y68TpSeJ/xzumhSgwzL+Ky8N2DvAP7aDUXYaiDlE4pAdcFAR8WH1jsWgRmh/vYGWQXNsv0pYsya7SgH6K9XGJ0dbuSS9HYZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66ed96c-8da1-4a15-0593-08d7638686ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 13:29:33.5114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XtES9Gdf/ghCmm58rSF/kICpk3shLEsMMXt1ul8y3U3ZbCu94YULqyYDzBxV+gBoZdtzwQOtss6kzMkDMKU4UPTjVu3YOrnyhFFTIktB/nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3917
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_04:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070135
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

 Hi Stephan,=0A=
=0A=
I think the regulator_bulk usage is good, and the core_enable/disable_regul=
ator functions implemented the way you did is perfect for the init/shutdown=
 phase.=0A=
=0A=
We just need to change the suspend/resume implementation to use something d=
ifferent.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Stephan Gerhold <stephan@gerhold.net>=0A=
=0A=
Sent: Wednesday, November 6, 2019 22:36=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; =
Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw=
.net>; Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com=
>; Linus Walleij <linus.walleij@linaro.org>;=0A=
 Brian Masney <masneyb@onstation.org>; Jonathan Marek <jonathan@marek.ca>; =
linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.kern=
el.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-ke=
rnel@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH 2/2] iio: imu: mpu6050: Add support for vdd-supply regu=
lator=0A=
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
Hi JB,=0A=
=0A=
=0A=
=0A=
On Wed, Nov 06, 2019 at 07:55:20PM +0000, Jean-Baptiste Maneyrol wrote:=0A=
=0A=
> Hello Stephan,=0A=
=0A=
> =0A=
=0A=
> nice patch but I have an important concern.=0A=
=0A=
> =0A=
=0A=
> We are calling the core_enable/disable_regulator functions when going int=
o suspend and resume.=0A=
=0A=
> With your changes, we are going to power down the chip when going into su=
spend and then power it up again.=0A=
=0A=
> This way we will loose all already set configuration, like FSR, sampling =
rate, init values, ...=0A=
=0A=
> The chip will not be able to work correctly anymore after a suspend-resum=
e cycle.=0A=
=0A=
> =0A=
=0A=
> You need to change the resume/suspend handlers to only disable/enable the=
 vddio regulator, not the vdd one.=0A=
=0A=
=0A=
=0A=
That is a good point, thanks!=0A=
=0A=
I guess we are not able to use the regulator bulk API in this case...=0A=
=0A=
=0A=
=0A=
I will send a v2 soon.=0A=
=0A=
=0A=
=0A=
Stephan=0A=
=0A=
