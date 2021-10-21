Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928F9435CC2
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 10:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhJUIUb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 04:20:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20720 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231153AbhJUIUa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 04:20:30 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19L63kDS032407;
        Thu, 21 Oct 2021 04:18:14 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00128a01.pphosted.com with ESMTP id 3btqxwba5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 04:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lA0df8034a16ynX7xrMwS7+8AVoigXUndIplgZ78nGswm5vvAi3XaPsq6pBUbHKhfVfZSLdSXN8ka58HiH0b9+6/7/vNPbJYxJKvw05y88zmF0hAItSIUCycRMeHis6fY5C/GWnM4CR1xQy0JnI61Uv0eDxusF8oNrZWzOn81NFfkTwRFwv9E7jzBNSWOhsCuhgkJvAQnsOiF7Pe5Uy/gknwKAxJEtkeRpRcdthETbBedeKfbeGDipCsPpCFR52hifNhzEgQpOKYNc+kqqXcmGym0Nmi0g7U1jvKrUDIaTV+dWBnzOjYD6qibc1ATG77NzUdqmY5YUeCo6S+uTZRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGwpKwZ0uqCN1atNyGtrY1DQmwlt7VHA8DaHTjHSSJ4=;
 b=VbBVm4LZ0g7WJSz61iLpIrqFwin5BhHsX9vwJotYYYYDh6RWxdQBLBi7TZJhZ0jDfDsRNDU2JewWhgXPVitgqHScTeUIQvT8zFEh7EbG6FOFsRTYH4woqEoG0VSiYD2U4/4QzFSHC1J1zh5WU/K+TduV0keL6p123VG2m3KOCuDDaUSiY/b0Y41lQ5/iNcw9X7HB+KFbRsqt4UCwl5KQFLALNMG4q5yI/9BD7EFQ0tO82gfm/JAWTEBr+pSe04XYOSwysum2hnAOQiVUru77TZFGxQBt8+e/OX/wiwm8/1CvRsUxbzeqAwu8qw9i5k6PS0ERVV+4s5MxQuQUtybnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGwpKwZ0uqCN1atNyGtrY1DQmwlt7VHA8DaHTjHSSJ4=;
 b=x16vwpwiewqyUyg8uGKBYN3WTb1dKbNGb57nwMzUJp48EAkCkkVDme1vEhZvIwShLwf6kloe3dtKUk8kuwnnn4MjpveZdXiks+veHASELz8m171RNCT+YbZDh59X44hP+WUIaqLvlrGMdIjGsViIMjk2ogJ0M02B5yVoRYqOwyc=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY1PR03MB2236.namprd03.prod.outlook.com (2a01:111:e400:c637::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 08:18:11 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 08:18:11 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v8 1/2] iio: frequency: adrf6780: add support for ADRF6780
Thread-Topic: [PATCH v8 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Thread-Index: AQHXxBDZ00yHObmfUUyxBy9wyxMAO6vcWKQAgADG2IA=
Date:   Thu, 21 Oct 2021 08:18:11 +0000
Message-ID: <CY4PR03MB33999A76B9A7FE15CBEA01699BBF9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211018110931.82225-1-antoniu.miclaus@analog.com>
 <20211020212348.3a110ebc@jic23-huawei>
In-Reply-To: <20211020212348.3a110ebc@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy02Yjk0NmI1YS0zMjQ3LTExZWMtYWJkOC?=
 =?iso-8859-2?Q?0xNGFiYzVmM2QzMjhcYW1lLXRlc3RcNmI5NDZiNWMtMzI0Ny0xMWVjLWFi?=
 =?iso-8859-2?Q?ZDgtMTRhYmM1ZjNkMzI4Ym9keS50eHQiIHN6PSI4NDY5IiB0PSIxMzI3OT?=
 =?iso-8859-2?Q?I3Nzg4ODA4NTM5MzgiIGg9ImxBQURJbDF0UmhIelZmc25MRG8zNW05enpm?=
 =?iso-8859-2?Q?TT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQ3lKKzR0Vk1iWEFRRXVZZTMrSW9VYkFTNWg3ZjRpaFJz?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBWFEvampRQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e485d5b-ad31-4a50-373d-08d9946b5241
x-ms-traffictypediagnostic: CY1PR03MB2236:
x-microsoft-antispam-prvs: <CY1PR03MB2236815FC50D70AD599B98F39BBF9@CY1PR03MB2236.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14qFPhm6aomnXNIgmC16gOqhIY3nPurquS0gZ7Xg5W7qrKsztMc7IpX7KhhWzvPoOc98xc4firyHqtZVFtEg/p0/l/PuYiH/HnhsBZkELcBfSSQlW5BQWvV6ZaRUvxjAEWPlUtuxU0fVpriUu6YbauqFOsE5+idA4ci+0IcnQKspN0EGnvc+qkLHSvHX0ERtTmL6nN5Bt0VX7z47Z2YNJwScy0aq5sAsJoS+MPj3b0QYXRtA4mN0Pik3ht3r5Dd20pxB9NIaCBM7PRojmyE71gumA4bd1PBhoFbXJwPNcWmhpizCk0+hWZIqaBAxhHXPYfTJxg3VeP4pGF8QDGCtPZggxdvM8fzK0l5chh5Q+wJ4DpOE4EDNMFzI8zJ1pQHwqLNqFLoa/CurZmZCxu5uSTbeqDyaUX1ZmWjzoB54JwasHeU3Q+aTd3gAolpU82yQvTZtC1fdFDz9c2eUFnUzCwEt0p/DqhBvAKmTKeyG8g91T280HnZjLeG0fyRiDrZoLCOOQ64Hzat0pVZpR7PMJmBS1AJ8fQNH0X1tYjeEZqh/JTENxU5tuEFk4ID2mK2F2KKFp5F+LCHZvWA3WRqchrRBC6vBp9FXgJClVEADRw9ICqzjcLOEgbhExPId8cCrYrAXwM+WWetPl7sgMedJ3M7jm0HX2EumXz+W1kliLdB4DCr7NgDI21DS8JQyCfjqT8GyXBvLGDhi84D/O/lOG7cJpOsUHH4aAZrMeVvBxPAfQ2Uc3d32cXin0vO0iIWcNi5XdXEaeXpqiS/ihAI0l4ycB1QuH6n1kYUl4W5YdZ2lERoMmEWWLKH5qLWty4g8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(2906002)(53546011)(508600001)(86362001)(55016002)(122000001)(966005)(38100700002)(52536014)(33656002)(6506007)(8676002)(71200400001)(38070700005)(7696005)(54906003)(83380400001)(66574015)(186003)(66946007)(9686003)(4326008)(26005)(66446008)(66476007)(64756008)(6916009)(8936002)(66556008)(76116006)(316002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?tvYxnV5htPSIVKZQOkQx8HznaxHPug5gRGV7/ZCq+cakuLMeBZA6GrbEbL?=
 =?iso-8859-2?Q?qg8+Do1NzLuqpp1tke3zw7c8ArZD7kyUsnEvlWel/jQgMnJjJs/BIisjQt?=
 =?iso-8859-2?Q?nr5Z/Z54hFfHlAmrXg01hg9jXz4OrdZsG+Z4RDi/EBwgYljwHMrBTQ1Tjf?=
 =?iso-8859-2?Q?VQx1HdMHu3vK1oB1yXOKELS/E0I2TX6EJnt+ijxfydeDMHc+FwED1OHn7B?=
 =?iso-8859-2?Q?dUX+r/k3kj2K7ZzYB5tKF8C57+Y0a/PZAY0Nn+g9ySvlaS258sNl30PAI+?=
 =?iso-8859-2?Q?T4ZpFXgb5iOB5gN/JzuISRyKAlVUQwvCWVV22g5XbEVgZCLGNUQSz/ibYC?=
 =?iso-8859-2?Q?fe6RDGPaiTnTI8boWA1y8pHXEytOuvwVS5tar+q3epNOONcb6pd0eShHv6?=
 =?iso-8859-2?Q?A2C+1U2tvQ6JyBXwHnuFh26g7YPnlez4vJ8/fBt1l6BPIm74qyxA3GXX8N?=
 =?iso-8859-2?Q?uUgXDfhejTm+d4ypuguyWx0lnmF3zD4DmonMmJYixVH/r23Hev7oE+6zuX?=
 =?iso-8859-2?Q?GbGG4FOdWuKGFz5qnu/ZHJa+Xy4aFN+OmQ/DMSYidJ8rqcEftGGW7Tn8c6?=
 =?iso-8859-2?Q?CsGRoyiQ3QBuQESKoev78m08MeZ8wM2iZ4Ee2zupKEOBTME6QRthl0mKDb?=
 =?iso-8859-2?Q?j6RR/ff2mjtEtek4kvrmr660kB10h+z/kalcaYG6DbvC+XLe2QM4kyYjAO?=
 =?iso-8859-2?Q?tt712/beyRi4/OueHEzwDrCLgJlP+S+qIFlqlPayAh6j2o4zSv9YDxWBgR?=
 =?iso-8859-2?Q?oOEygbRT+tGhZrEuXiLT7X4qDuR5zmce7oePcASETEdas1kJViU6LxyJdw?=
 =?iso-8859-2?Q?5IZ7gzrLXOjUslnOylYp1+m4fYaLOOofhUVETgHRINGax/FbN/9RhU19pq?=
 =?iso-8859-2?Q?NiQmzAXIDX/yxz6uJNXJb4cGj3BD10PeKtlKqTtlvqIdsbo4ZYnzihBK5f?=
 =?iso-8859-2?Q?lT/SGizTHr6RH/fKJizNVtnXhcSxioqSqWCJH0kALNxPvASqFzMjVGu1Vw?=
 =?iso-8859-2?Q?FOdPd1nF5sRRAOfXuLgU5Wk/5aR8y71D9m84feWHp2khBVPZFgHjs3eB27?=
 =?iso-8859-2?Q?lEiIcAvHYe6N4fwVvm7xOfnT1RJqxdAcvcdx5Qg+47tqC1vv7grGsdkxmu?=
 =?iso-8859-2?Q?ODR57eSIyhNgdG8b+7bNbQrflWcmpCyu7C3KvhgOoTZvsghkKedpqtKx4l?=
 =?iso-8859-2?Q?MSG+SM6V96wiQXm8/cpfnBltxRuTtSy817kMW2ky/E13j+ey2KykbEWVd8?=
 =?iso-8859-2?Q?/ltF+3VQAzRpejWMpU8Or3dY+t2IDeu/xrjBUxSuS33z8SPL+6iukI+ZlQ?=
 =?iso-8859-2?Q?8QRx4Y8xKjyFN2Uw7YNPi2WL/ySLd3qKaht3hTRRdd6Mp8M67ZD3LuxGkR?=
 =?iso-8859-2?Q?C4fZiFfMnk1d+xm1VKovkL7xAzZp2FPVPEl7vb1CXwyoxoW+gCMmBrNoRo?=
 =?iso-8859-2?Q?c/N0fHBydHhJqXxZRwwM9XsQf8yISDy5tDRWcxbtxoxu9MqEaeaq1B26xq?=
 =?iso-8859-2?Q?dxlbD1A0juyKAzJFkQ4ewL?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e485d5b-ad31-4a50-373d-08d9946b5241
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 08:18:11.0513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Antoniu.Miclaus@analog.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2236
X-Proofpoint-ORIG-GUID: J3Je6mQydH2KQgaMi42v9CYz2Y6CaTQ1
X-Proofpoint-GUID: J3Je6mQydH2KQgaMi42v9CYz2Y6CaTQ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210040
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Would you like me to reintroduce the locked/unlocked version for the "adrf6=
780_spi_update_bits" function too?
This was present in the first version of the driver but removed afterwards =
based on the review.

Regards,
--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Wednesday, October 20, 2021 11:24 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org
> Subject: Re: [PATCH v8 1/2] iio: frequency: adrf6780: add support for
> ADRF6780
>=20
> [External]
>=20
> On Mon, 18 Oct 2021 14:09:30 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> > microwave upconverter optimized for point to point microwave
> > radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> > range.
> >
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADRF6780.pdf
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> The 'problem' with rereading drivers lots of times is sometimes
> you notice a new issue that you've missed before.  Unfortunately
> the locking in here is inconsistent and there is not protection against
> various functions using the dev->data[] array at the same time.
> Sorry I missed this in earlier reviews!
>=20
> It's a little bit too fiddly for me to simply make the changes
> whilst applying, so please add the missing mutex_lock/unlock
> and send out a v9.  I would suggest doing it by renaming the existing
> unlocked versions to
> __XXX_write() /read()
> and then adding functions which take the mutex called after their
> original names.
>=20
> I made a small additional comment on naming that would also be good to
> clear up.
>=20
> Plus please run scripts/checkpatch.pl over the file and fix the warnings.
> Preferably with --strict
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> > changes in v8:
> > 	- condense lines that are very long
> > 	- set ADC channel as input
> > 	- add `dev_err_probe`
> > 	- handle device powerdown via `devm_add_action_or_reset`
> >  drivers/iio/frequency/Kconfig    |  12 +
> >  drivers/iio/frequency/Makefile   |   1 +
> >  drivers/iio/frequency/adrf6780.c | 496
> +++++++++++++++++++++++++++++++
> >  3 files changed, 509 insertions(+)
> >  create mode 100644 drivers/iio/frequency/adrf6780.c
> >
> > diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kcon=
fig
> > index 240b81502512..2c9e0559e8a4 100644
> > --- a/drivers/iio/frequency/Kconfig
> > +++ b/drivers/iio/frequency/Kconfig
> > @@ -49,5 +49,17 @@ config ADF4371
> >
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called adf4371.
> > +
> > +config ADRF6780
> > +        tristate "Analog Devices ADRF6780 Microwave Upconverter"
> > +        depends on SPI
> > +        depends on COMMON_CLK
> > +        help
> > +          Say yes here to build support for Analog Devices ADRF6780
> > +          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
> > +
> > +          To compile this driver as a module, choose M here: the
> > +          module will be called adrf6780.
> > +
> >  endmenu
> >  endmenu
> > diff --git a/drivers/iio/frequency/Makefile
> b/drivers/iio/frequency/Makefile
> > index 518b1e50caef..ae3136c79202 100644
> > --- a/drivers/iio/frequency/Makefile
> > +++ b/drivers/iio/frequency/Makefile
> > @@ -7,3 +7,4 @@
> >  obj-$(CONFIG_AD9523) +=3D ad9523.o
> >  obj-$(CONFIG_ADF4350) +=3D adf4350.o
> >  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> > +obj-$(CONFIG_ADRF6780) +=3D adrf6780.o
> > diff --git a/drivers/iio/frequency/adrf6780.c
> b/drivers/iio/frequency/adrf6780.c
> > new file mode 100644
> > index 000000000000..4097b31bdf0b
> > --- /dev/null
> > +++ b/drivers/iio/frequency/adrf6780.c
>=20
> > +
> > +static int adrf6780_spi_read(struct adrf6780_dev *dev, unsigned int re=
g,
> > +			      unsigned int *val)
>=20
> I've highlighted a few paths inline where this isn't protected by a
> mutex.  As such we will be racing on the content of dev->data[]
> and results are going to be very unpredicatable.
>=20
> > +{
> > +	int ret;
> > +	struct spi_transfer t =3D {0};
> > +
> > +	dev->data[0] =3D 0x80 | (reg << 1);
> > +	dev->data[1] =3D 0x0;
> > +	dev->data[2] =3D 0x0;
> > +
> > +	t.rx_buf =3D &dev->data[0];
> > +	t.tx_buf =3D &dev->data[0];
> > +	t.len =3D 3;
> > +
> > +	ret =3D spi_sync_transfer(dev->spi, &t, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*val =3D (get_unaligned_be24(&dev->data[0]) >> 1) & GENMASK(15,
> 0);
> > +
> > +	return ret;
> > +}
> > +
> > +static int adrf6780_spi_write(struct adrf6780_dev *dev,
> > +				      unsigned int reg,
> > +				      unsigned int val)
> > +{
> > +	put_unaligned_be24((val << 1) | (reg << 17), &dev->data[0]);
> > +
> > +	return spi_write(dev->spi, &dev->data[0], 3);
> > +}
> > +
> ...
>=20
> > +static int adrf6780_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long info)
> > +{
> > +	struct adrf6780_dev *dev =3D iio_priv(indio_dev);
> > +	unsigned int data;
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D adrf6780_read_adc_raw(dev, &data);
>=20
> This takes the mutex inside the call which is good.
>=20
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val =3D data & ADRF6780_ADC_VALUE_MSK;
> > +
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
>=20
> But need locks here as well (see below)
>=20
> > +		ret =3D adrf6780_spi_read(dev, ADRF6780_REG_LINEARIZE,
> &data);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val =3D data & ADRF6780_RDAC_LINEARIZE_MSK;
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_PHASE:
>=20
> And here.
>=20
> > +		ret =3D adrf6780_spi_read(dev, ADRF6780_REG_LO_PATH,
> &data);
> > +		if (ret)
> > +			return ret;
> > +
> > +		switch (chan->channel2) {
> > +		case IIO_MOD_I:
> > +			*val =3D data &
> ADRF6780_I_PATH_PHASE_ACCURACY_MSK;
> > +
> > +			return IIO_VAL_INT;
> > +		case IIO_MOD_Q:
> > +			*val =3D
> FIELD_GET(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, data);
> > +
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int adrf6780_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long info)
> > +{
> > +	struct adrf6780_dev *dev =3D iio_priv(indio_dev);
>=20
> Minor point but there is a fairly strong expectation than anything
> called simply 'dev' is a struct device.  Consider renaming.
>=20
> > +	int ret;
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_SCALE:
>=20
> This needs to take the lock or you can have this using dev->data at the
> same time as other calls which have taken the mutex.
>=20
> > +		return adrf6780_spi_write(dev, ADRF6780_REG_LINEARIZE,
> val);
> > +	case IIO_CHAN_INFO_PHASE:
> > +		switch (chan->channel2) {
> > +		case IIO_MOD_I:
> > +			mutex_lock(&dev->lock);
> > +			ret =3D adrf6780_spi_update_bits(dev,
> ADRF6780_REG_LO_PATH,
> > +
> 	ADRF6780_I_PATH_PHASE_ACCURACY_MSK,
> > +
> 	FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, val));
> > +			mutex_unlock(&dev->lock);
> > +
> > +			return ret;
> > +		case IIO_MOD_Q:
> > +			mutex_lock(&dev->lock);
> > +			ret =3D adrf6780_spi_update_bits(dev,
> ADRF6780_REG_LO_PATH,
> > +
> 	ADRF6780_Q_PATH_PHASE_ACCURACY_MSK,
> > +
> 	FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, val));
> > +			mutex_unlock(&dev->lock);
> > +
> > +			return ret;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int adrf6780_reg_access(struct iio_dev *indio_dev,
> > +				unsigned int reg,
> > +				unsigned int write_val,
> > +				unsigned int *read_val)
> > +{
> > +	struct adrf6780_dev *dev =3D iio_priv(indio_dev);
> > +
> > +	if (read_val)
>=20
> Nothing prevents these being concurrent with other accesses
> using the st->buf either.
>=20
> > +		return adrf6780_spi_read(dev, reg, read_val);
> > +	else
> > +		return adrf6780_spi_write(dev, reg, write_val);
> > +}
> > +
> ...

