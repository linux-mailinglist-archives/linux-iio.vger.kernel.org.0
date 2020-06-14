Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048E91F8AB5
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 22:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFNUfd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 16:35:33 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:8446 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727870AbgFNUfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2020 16:35:32 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05EKXWmi001358;
        Sun, 14 Jun 2020 13:35:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=dq67KSCrUgmX8Wfj5CNkaYAjOY/aIAmbwyr1Q8jev1s=;
 b=yWI9wiHDsxGNlqlvaSDc3GGYBkj2hoi4oDqZ3xtOcfow2VtkI0H4s8UAiNlBDCudcu5u
 Eg6i7VbhOWVdQaBliUfeP3RreiPAsy/GbxRGIspLbdOMEPn2e8do/f+PiPfHFcWLzSr9
 C/J83oqUqsPHy7ESQjmDzEJrkpfK7GhLn0vIUi0E8s3kquh2KHeyDGlPMKUxFnwDhwsU
 G+49qYqsCIFQi3Vva7oFScMzxJMLD8+KLyTTs5S46a4UawOIpbS0YVNmHJCSyn/Kc8Yq
 1otyk8kVZrsbwgwv/JwdEWhhpcoItXCBOZQaReld0Px6MJBIsDkHRQWaJm+n+aHw3eqS vQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by mx0b-00328301.pphosted.com with ESMTP id 31mtrn0gdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Jun 2020 13:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L52TsSV51DfZ+QUsumVSgS7Zo/ACdXNBuMv80Dkva+x8aIHuIhl713jmiGN7DTzyj6qUhwGyx3rKIBVz2KpF462h8SIJVSKAE13jcUItEZz4ncdLGrqS8qOwvSCwTUHCcKEgcVKxzxXH/CvBHN9xkph8UdHyvGlmyRn9hw+rxnYIo9b2fnR2MNwy+OpcY9h9MT3Fly+c57qjXceZhx3fdNOGFbaKRoZcP2yIwg3GNy0uk5DKQqlH34hmKlD7JXVaCR3SUKaoORoxWivtC/CG2q2sTyi9rk0THuajF5q6lVkiopBZZBOiMdQpzHDs7A3Et3MqLbe441e8JIS3R/r7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq67KSCrUgmX8Wfj5CNkaYAjOY/aIAmbwyr1Q8jev1s=;
 b=bEMIobkb8EEjTOHu+TuODIR6EwMGu2ImTaZ/E/cNvCvSdAB6oSeQRe9IKMg0ALYoTEpHBBMH3Me6X8raVc+SsWG2oKfxodC7UGUIlCDs5GgD4CVBN/uj+ChismPcbYGwmRmCY/lBVG9sno9wZh56T1LRmpJ/P6Z1kTKYoqsz3vuneq2CqnDint+I2s6bN7JnqG4y4DClDLz3g6M+wGa7qVzL5ci4gLrjKWRgcBK0EhN6KJBNPSFeP6OnHUj0UIp+r/RcjA8Z/lyetMOF1NDnptebiY5v7zGySZz2F9FHfRYok9IZ+tbJLDhQu5CpGVNHoqK2OgvLPzTdSVuFT9YNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq67KSCrUgmX8Wfj5CNkaYAjOY/aIAmbwyr1Q8jev1s=;
 b=iQDYZOEPEtNT9AsLZz7d++ul72cqSIKlQXU3eq1J8vqkV6Hlx06guqFRLfh6YZuojP+0QKMXt6GQA0BcmPB++aEXhIoRwuVHW4VbdafyIwyyfSP0Qfr0UU2rFbQcG82fdj7gO3bybW7g8Bhhx03HupXPA01b8H8Rg0twpxiBNP4=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sun, 14 Jun
 2020 20:35:14 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%9]) with mapi id 15.20.3088.028; Sun, 14 Jun 2020
 20:35:13 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sensor
 support
Thread-Topic: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sensor
 support
Thread-Index: AQHWPdWIUjAhv0WNM0u1pU/hnDKuy6jYQFCAgABZXLc=
Date:   Sun, 14 Jun 2020 20:35:13 +0000
Message-ID: <MN2PR12MB4422148948CF6FC7953A6D2AC49F0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
 <20200608204250.3291-7-jmaneyrol@invensense.com>,<fd4918b6-a55f-4047-7f18-b796a8ccd020@metafoo.de>
In-Reply-To: <fd4918b6-a55f-4047-7f18-b796a8ccd020@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: metafoo.de; dkim=none (message not signed)
 header.d=none;metafoo.de; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:393:a700:5eee:e32c:7422:df0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6677bfc3-3a55-4a47-7958-08d810a270fa
x-ms-traffictypediagnostic: MN2PR12MB4270:
x-microsoft-antispam-prvs: <MN2PR12MB427027E9433A9A88674AEFA0C49F0@MN2PR12MB4270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04347F8039
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7Ho9fEqvKvztL6JblIUyXZEOvgTOsVPI6HBh6RZZaWoEUqOL3lHPqqtLrpDOXesinsV4txpXOb21ROAjOZ0zcpmSKG0733H4CWMUrb5Yrzk453SZcbvLxRzXdimtlmIsQkqM/OyviTtd7auQ6YjArgWnKy3P3/BnsVtX389u9U++pJ5fejIsX5pm7ooSVsilxokOM6ZCTHJWFnWgMyMSU8wMtL2fw0DxKiD4vPLqv860QuHbnIYuWjK2Qmxywj36sEN7IFo8T9g9/1zFGDgBqdttTqeFwX6UPlJez4LI5kSJxWtu48uXsxKCIGce9ItY7/t3mG0BYuKTjaG71UxIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(39830400003)(346002)(366004)(136003)(7416002)(66946007)(66476007)(66446008)(64756008)(66556008)(33656002)(86362001)(91956017)(76116006)(4326008)(71200400001)(8676002)(186003)(2906002)(8936002)(54906003)(110136005)(316002)(53546011)(9686003)(478600001)(55016002)(6506007)(52536014)(7696005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7id103ksoa7cyPiWUT7RO5CF834MNz6IE+cfOc0Hl4zztCy7mwt8Zpa6iItR06cSeI8CZ9n8aEI+3miicqjBByHMGKjnZwDwfeTN66pO4AHOG1k1GpChWkmDxVBNf8wiy6l+So/hrNFx/Xe5Bz+DQ8lDX+6jR/XtKgUBRwLeUMUnk4rjmxODQsZ5lFZtAFP2S46cCKM38CVqvn3EV9/sJpoVhQsB19KgZkt1rZrX55o+Ur1lGh2qR6P5kyh1R3NW/Gy3RsZSeYFeSLdjk10ZsmRhI/HNUwzBLdgDrOKKYIxzO0xXgakw8CCUTCkLKHYoCMRRvahWotp2xozHOWUigBvZNOlE7iUvClLFzqQM1GmbcHuUDwQqOB97KdexCx182z6GlIv0/VJRxfDMAgd8TPq3sjafLI5CZHFvETD/c7aho6AnJqzjavivHhqKO9SgI6qbr4RwuQZa5aUhMOIeeIzsY4mfRCPUF3GcwpPHYqI/Uz9tG9GbttZ6nKn4dSX9e9o18gufri00mxBGJWhs8Hs+CDTcwHkZ9BbTqcvzlmg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6677bfc3-3a55-4a47-7958-08d810a270fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2020 20:35:13.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAelbfR9xOPbmO9way8Gy8UD9rekn/wzZKbfkEIY88dZHCdkM6FzVN7f5kJ/Gyff64elLGEyfMdZPfpMyhajjCiRzPKzeH66CX+HDuAX6Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-14_06:2020-06-12,2020-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 cotscore=-2147483648 suspectscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006140184
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lars,=0A=
=0A=
for the temperature data, the problem is that temperature in the FIFO (used=
 in buffer) is not in the same format than when reading the register.=0A=
=0A=
Reading the temperature register return a full precision value on 16 bits. =
I am using a PROCESSED attribute for it.=0A=
Temperature data in buffer (coming from the FIFO) is on 8 bits in lower pre=
cision. It is reported as raw data, thus the need of the offset and scale v=
alues.=0A=
=0A=
So offset and scale values are only for transforming the temperature data f=
rom the buffer, and direct read is a full precision already processed in m=
=B0C.=0A=
=0A=
Thanks for the review,=0A=
JB=0A=
=0A=
From: Lars-Peter Clausen <lars@metafoo.de>=0A=
Sent: Sunday, June 14, 2020 17:10=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; jic23@kernel.org <ji=
c23@kernel.org>; robh+dt@kernel.org <robh+dt@kernel.org>; robh@kernel.org <=
robh@kernel.org>; mchehab+huawei@kernel.org <mchehab+huawei@kernel.org>; da=
vem@davemloft.net <davem@davemloft.net>; gregkh@linuxfoundation.org <gregkh=
@linuxfoundation.org>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetree@vger.=
kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linu=
x-kernel@vger.kernel.org>=0A=
Subject: Re: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature senso=
r support =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
On 6/8/20 10:42 PM, Jean-Baptiste Maneyrol wrote:=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_PROCESSED:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D iio_device_claim_direct_mod=
e(indio_dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_icm42600_temp_read(st, =
&temp);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_device_release_direct_mode(indi=
o_dev);=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D temp;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_SCALE:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D 483;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val2 =3D 91787;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_MICRO;=0A=
> +=A0=A0=A0=A0 case IIO_CHAN_INFO_OFFSET:=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *val =3D 25000;=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return IIO_VAL_INT;=0A=
=0A=
If the data is returned processed there is no need to specify scale and =0A=
offset.=0A=
=0A=
But since the transformation to turn the data into standard units is a =0A=
simple linear transform the preferred way to handle this is to return =0A=
RAW data and specify scale and offset.=0A=
