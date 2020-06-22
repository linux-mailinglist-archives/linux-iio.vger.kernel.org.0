Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5667203335
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 11:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFVJVs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 05:21:48 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:38904 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgFVJVr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 05:21:47 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05M9IJWp001983;
        Mon, 22 Jun 2020 02:21:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=klk+aE5baUWQFrUFKtJJ73/Yw6rDl9zaA1XpSQOvk1A=;
 b=pVOARI8JJFquaNLxPUn2VkZAsdYMglc2HD91j8f1tpPzcLzrSTLhUAo+7wngAvWiF/yh
 RCnAcR7BQ3yDMXqgB44MV5LARqFS0TTStsgih10r9p0sIueaxvnxT2vp7smrqXbaKk6V
 VMveQaGz2LpyGSrJ28RzgDePOpC3XF2clAMlH0IbpFdRMBrT1mU9opZzCgNsLe6m3nqH
 UJ2b1nWT9WKLhmFXNZ1/1Cb5oci6BtHQASl2AZR1Ol3UpDxNGGbTbumuYdmI5hKtQ4Sr
 N270Hgfsabuw99C87kZXOAcw3zJ3b+aNu8qp/gfH2j5sR3+s/htv8cy5VVY0De33q16l Xw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-00328301.pphosted.com with ESMTP id 31sedp0pxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 02:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZVFUhyFuL9MuVHbyO3cKrvvR7xzOlpkCCwFR0L4g/7Ncjtd5txyW03Cxb8jZAjLPoqFDwsnnoTKn5sfYPY+ywjI9IU0skXCQ8vSY3+5K+V9P4Q0CBC4HT2vn+nS7wCLufkvCTJUcPMx7MwZiBqMqXqTIKF68EHi0W/Lr2ytg0DA1D4qdt8XJLX5zX84a/H6+arJtNjLcK736An2Yw87iNooQ+b5acQ1/qV2NiHNQYURNyQDOCBR1P494GwJGBXJA6WURXLdsQmTiPCtlF6QSenX7oBv1VMeKuc2IUQX1XfEUPiR1cLz2eZ3K+PrfLwCqWlglGBvy0T/0/XQcfvHcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klk+aE5baUWQFrUFKtJJ73/Yw6rDl9zaA1XpSQOvk1A=;
 b=Lnehak5waUfW+sZf/hM5s2tv8GLQ/1d2kXSWrChT0uoCRMrKn0ISxnQQnQcp6eNI+ZlVtzbx5UVMQsEEoURfle0ETFnBGB2Jn5baSxnOPsSxR0gtz+yBCIoiR3ThU2lbeRyaKrvJTTAJxWUlfRyW5k7Gb+qXcqnfMpg4RXLiMgyypo8XGetwG3s/ba2S/AICixMSNsnH0VnIZ6INQTCR7g6ofSlvD+/9CK1NV62HTJ3gi6mWjL2vD1haQCyxlUs4d0kVhspZr5CjvrEe+5jnzmnFNvFzCcLYpdlGp135yje+TH73mjh7NG4LZklIplCapDDd+WwDvgk5aBsG4xPcgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klk+aE5baUWQFrUFKtJJ73/Yw6rDl9zaA1XpSQOvk1A=;
 b=fDrpV1azUGFVe4VB74JFoNdC/UvLoDyv8my4XyqfKyC3vvpQQJWwXCTPrsUvWAqAZZ7KtlYxZQmms4QoKbOJnfVHdPj7yIEt1cLg+3lFp5n8QQh07e91SGRcBPtF/ZoPVGHn6LjqE/SHvKp7FWu4dIW4HNFIqiVXd3/Tidg8qN4=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Mon, 22 Jun
 2020 09:21:25 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.026; Mon, 22 Jun 2020
 09:21:25 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sensor
 support
Thread-Topic: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sensor
 support
Thread-Index: AQHWPdWIUjAhv0WNM0u1pU/hnDKuy6jYQFCAgABZXLeACSG0gIACtcSW
Date:   Mon, 22 Jun 2020 09:21:25 +0000
Message-ID: <MN2PR12MB4422E5AC39A8B85304058AF4C4970@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
        <20200608204250.3291-7-jmaneyrol@invensense.com>
        <fd4918b6-a55f-4047-7f18-b796a8ccd020@metafoo.de>
        <MN2PR12MB4422148948CF6FC7953A6D2AC49F0@MN2PR12MB4422.namprd12.prod.outlook.com>,<20200620165739.29694b9b@archlinux>
In-Reply-To: <20200620165739.29694b9b@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c97e11ee-f5c1-4c92-ca4b-08d8168da312
x-ms-traffictypediagnostic: BL0PR12MB2465:
x-microsoft-antispam-prvs: <BL0PR12MB2465904EE3EB6692D8E48873C4970@BL0PR12MB2465.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtyn4JALIocPZyZ3zTdwb4ZRdhHphMnokxlzo3pzHLcU4Bpd3FkxAx5qkfMQKnVfLdJnUy1fL6OZwrpWQcLU/EZIapFmSQxHbwJfigqy7ymTAmmfk6bG52trfAIWGL3YVgtNqO4BAqUEoHlfnCuTCocD8A6hgyERCrpuqBcfzfBd0XDneZdJu1x5IfVnmvas2kkgrTWv/TUtRlkCNe7Tg6/gIN5M2pdqc+rFvmLYTppOCZeb1aNZHLumDuXceMQ9ERY8y7HgzKbSMkuZiKnuLd5JLpG4Xnv9OksxVVhRfipeAmEn6T2LpfGU9t+kwj1xq1CQ6EtHR40KwCUN40F8WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(376002)(396003)(39850400004)(71200400001)(66476007)(55016002)(2906002)(66556008)(9686003)(8936002)(66446008)(64756008)(91956017)(8676002)(478600001)(86362001)(33656002)(66946007)(76116006)(7416002)(5660300002)(52536014)(6916009)(316002)(186003)(7696005)(4326008)(6506007)(26005)(54906003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PDHg/XcjQMTrMXLVn4aoSeB1luAwjJAjU8OdP+5zAgZYusf27Bppc9NYQ7iaJQ2Q2ywCOc+FGOjgiZZ2goKoEyhrWrMab+WjtWGH2ww6eEGzNq9RjFiu5UQjAu50HIUg5HNrdEdgPMisjtgQy4AWPjaRkmfY3o8zFOdoFvElsKkzO6kLU3/9KpdP+8INYi3QYcRlZ4HdJVoGb8HqJzKiWK2OzzSadY4SNZ8QG6QeeetN0oVzyPzvdhtL9PCibda3I6hhb0Grzc4NxqoubXVedrG6UPG6cEliYrBeC0/Wue8mu4TX3Y1uDamZ7M5xGlwRQvDc1nfhpQMUrn21ibfTPM2v+TE1TcNUwpWbRApsAJm4FezBa4tdYnY4riJQowFhjKHUurWmNiAK3KpwSx6wAQtRHcEsNNKJqpqECu/zqrVV1NM7Yvb55WRHGXnO4MAvAFVaaKUEDg2ENeW/tF6zgazZHsc3mH84APQNXHTUZD8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97e11ee-f5c1-4c92-ca4b-08d8168da312
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 09:21:25.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wig64MO75UXcSm4dCHBHYRmstnEjFkClY5UkpgcHsI67NbR7rOjQWMlmk2qJnObEJXwzUmD4By/5zd/08iFM6YDpCDzci3uAUEqW6x3ypv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2465
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_03:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220071
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
no problem, I can rework temperature to have the same raw output for both c=
ases (with just decreased resolution for the FIFO case).=0A=
=0A=
v4 series is coming soon with the fix.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Saturday, June 20, 2020 17:57=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Cc: Lars-Peter Clausen <lars@metafoo.de>; robh+dt@kernel.org <robh+dt@kerne=
l.org>; robh@kernel.org <robh@kernel.org>; mchehab+huawei@kernel.org <mcheh=
ab+huawei@kernel.org>; davem@davemloft.net <davem@davemloft.net>; gregkh@li=
nuxfoundation.org <gregkh@linuxfoundation.org>; linux-iio@vger.kernel.org <=
linux-iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.ker=
nel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
Subject: Re: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature senso=
r support =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On Sun, 14 Jun 2020 20:35:13 +0000=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
> Hello Lars,=0A=
> =0A=
> for the temperature data, the problem is that temperature in the FIFO (us=
ed in buffer) is not in the same format than when reading the register.=0A=
> =0A=
> Reading the temperature register return a full precision value on 16 bits=
. I am using a PROCESSED attribute for it.=0A=
> Temperature data in buffer (coming from the FIFO) is on 8 bits in lower p=
recision. It is reported as raw data, thus the need of the offset and scale=
 values.=0A=
> =0A=
> So offset and scale values are only for transforming the temperature data=
 from the buffer, and direct read is a full precision already processed in =
m=B0C.=0A=
=0A=
That is a problem.=A0 We have no means of describing it in IIO.=0A=
=0A=
If the channel is processed via sysfs the assumption would normally=0A=
be that it is processed in the buffer as well. We don't really=0A=
have any means of describing the two separately.=0A=
=0A=
In cases where we've seen this before the way around it was to=0A=
change the data in the fifo so that the scaling was the same as the=0A=
sysfs channel (usually it's just a bit of padding).=0A=
=0A=
Can we do that here?=A0 Looks like the ratio is 1:64 so should=0A=
be possible. =0A=
=0A=
=0A=
=0A=
> =0A=
> Thanks for the review,=0A=
> JB=0A=
> =0A=
> From: Lars-Peter Clausen <lars@metafoo.de>=0A=
> Sent: Sunday, June 14, 2020 17:10=0A=
> To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; jic23@kernel.org <=
jic23@kernel.org>; robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org=
 <robh@kernel.org>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; =
davem@davemloft.net <davem@davemloft.net>; gregkh@linuxfoundation.org <greg=
kh@linuxfoundation.org>=0A=
> Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vge=
r.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <li=
nux-kernel@vger.kernel.org>=0A=
> Subject: Re: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sen=
sor support =0A=
> =A0=0A=
> =A0CAUTION: This email originated from outside of the organization. Pleas=
e make sure the sender is who they say they are and do not click links or o=
pen attachments unless you recognize the sender and know the content is saf=
e.=0A=
> =0A=
> On 6/8/20 10:42 PM, Jean-Baptiste Maneyrol wrote:=0A=
> > +=A0=A0=A0=A0 case IIO_CHAN_INFO_PROCESSED:=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_m=
ode(indio_dev);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return re=
t;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_temp_read(st=
, &temp);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(in=
dio_dev);=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return re=
t;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D temp;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
> > +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D 483;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val2 =3D 91787;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_MICRO;=0A=
> > +=A0=A0=A0=A0 case IIO_CHAN_INFO_OFFSET:=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D 25000;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=A0 =0A=
> =0A=
> If the data is returned processed there is no need to specify scale and =
=0A=
> offset.=0A=
> =0A=
> But since the transformation to turn the data into standard units is a =
=0A=
> simple linear transform the preferred way to handle this is to return =0A=
> RAW data and specify scale and offset.=0A=
