Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7884257E1
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhJGQ1C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 12:27:02 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56188 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241846AbhJGQ1B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2021 12:27:01 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197EWboJ004647;
        Thu, 7 Oct 2021 12:24:54 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bhq19uhk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 12:24:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMOoBPlNkWX6+OabEu0ihG1KIT4Yx3MOnOhMcmnJbopdB1KuA4570Qn0vHCMUmt7OBTZVmo8YwyoAj2bn5UJ9AivZmc2c/d8PNWQjEIZxRMCmNN0J40yN6a8iOZYP84qGQnVMbA981JTG8hRe2+ZCHFOJjNiRa3J1u+7Dm7TAeOL8PZwPFeJVb2u/r7pwf0YQl0WqVKmKOaPmu86KmSUJvAdTEy0VzyYjDjIgKlE8EGadeHwzkDfTXXz2F6qcs9r+iRihy+mkMHekWwD3p3V5cJ+dfnvWzsZjSksru1Nr4neoqbDPDi4GMOypWFF0fQ0JbJlR7zIZg1DCMlr8y02Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUrI++pM4m0awI/PEIMyWxMXraLtqI7wZyZ1evnfqzs=;
 b=jiyjyDe8BQ87d2p9OQGwdFt4AkJV0NLTDtoMJh2NtYPc9lYguV/xuAR43WtSCMDr2+/A3r4xrQkIgrRj1gTRA4X6q4r2qHDuYeqOh8ycVerp8UP5WSctHQ3geBeGdJrf3ihRUYNDMgWnHNw88y46hTJn487KVpTfA5Y2Wsjdfyp8Yvgs9b2PfcC7QiYMAT8rvJ7iYJJyqgB0VYnfOIFJ1UuCjzQ/R5/xO0/fNHny/9vDGD72q+cX433aH++Pb7CbEc8vg4sZT9ROQcvGpOBUGSojqTWKp7walQkPCIQFvVevpan8d5xAP/q3iTDIAuop7eQQbA9iC/vtEDdW8P1dyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUrI++pM4m0awI/PEIMyWxMXraLtqI7wZyZ1evnfqzs=;
 b=yfKZ2PjKClxPbj0y7sCuXL/A7lYEX//JIkMMGMqhmtrgITJy0IU7jfdLsGV4ixAD7s1UUQtVG5nEypqQGO+nN0hffrLfUXELd7u7TbL8/Hj7PTTI2P78DY0wGGYI+7ty+q25iGM/Itgo/Pd8WTYm+lMZjxvnFyppp8OfbzpCdoc=
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com (2603:10b6:a03:2d4::23)
 by BYAPR03MB4437.namprd03.prod.outlook.com (2603:10b6:a03:c4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 7 Oct
 2021 16:24:52 +0000
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4]) by SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4%5]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 16:24:52 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: RE: [PATCH v6 1/6] iio: Add output buffer support
Thread-Topic: [PATCH v6 1/6] iio: Add output buffer support
Thread-Index: AQHXu1GAuXtaMoqEMkGpFIvXr5kPIKvHs62AgAAC7lA=
Date:   Thu, 7 Oct 2021 16:24:52 +0000
Message-ID: <SJ0PR03MB579191849B3BD15610A721AE99B19@SJ0PR03MB5791.namprd03.prod.outlook.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
        <20211007080035.2531-2-mihail.chindris@analog.com>
 <20211007170533.5e314199@jic23-huawei>
In-Reply-To: <20211007170533.5e314199@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0xNzIyMjIzNy0yNzhiLTExZWMtODQwMS05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcMTcyMjIyMzktMjc4Yi0xMWVjLTg0MDEtOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSIxNDczNSIgdD0iMTMyNzgwOTc0ODk0?=
 =?us-ascii?Q?MDM0NjMzIiBoPSIwTEg3UUhPN0g4c0hGL05Oc2NrV3BJSHV5UzA9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NB?=
 =?us-ascii?Q?QURKTG4zWmw3dlhBV2dObC9sSnRvRU1hQTJYK1VtMmdRd0RBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?YVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpB?=
 =?us-ascii?Q?RjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFk?=
 =?us-ascii?Q?UUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFE?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9t?=
 =?us-ascii?Q?ZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2037cae0-18bc-473a-82bf-08d989aefdd4
x-ms-traffictypediagnostic: BYAPR03MB4437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR03MB4437B92247FF9D8EF221A6BB99B19@BYAPR03MB4437.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMNjSYcYa66UQCmZwD9eFGQVfl6hbEHweU2Xlt1RhDB2vidffC9ptTL9WdHIi+PDqS9rt+CxzCRqrdKNSJ11/sFSm9ftoh7HCk3AApL7Ul8YPsRhehw8d6dYQj0i5NQpG9kkQ2pCH9tuQ5DqVGYd5E1GyOA0OVcyyhI6X7cRCJLJ2Tym/85TnpXZXo8AtFIxhm2bPBtjO7a6qlIiuowaPtTvn8FZ4cfSbHfZ8GXzjjh1Xlqv9DGYFXf/HfJTdcYogURQoyk//sb39KKyVoUuyoxWG+fYegqse7BUgnz9tzWbLv4ELgmgOmAqEmva3pGXOFk4CTsXUJ4VptELzdrehoxWmAuReOrfY8DzhJQh2p5ecma1lQXOGuArsaubYmPg6DxiisUeWWKYEwdQP81GPiE5iwzBcCb9YbaVG++bNGF2aeKUZHVccv10bE9xpW5iXs26v4tMzLfmxqocShxlKymxwF3WwrjYEs0JU8CL/E2wVa/n0ojxReALje/SIf3wwbKi2GvQoPpNufoW441ijMb77URBpiDvg1pfbTA9kMVkfXWNEwlU3IQPgltSWwSE2eh//toIdKvnbFV/rD1rMaSlBXYlsRoDMbyqDeWEEc1OkCICmtPPgbUv5PcDzhq7Mr3fBehBXRtdDpagF2cSHFKS9wH+rNGZdVzdpINsLzwD5dRqqIMXiBPHSnJ9whayNQdyJd9GAsmXcQUaYxptgEA84A5sACeLDC0PJYGdk3e4iMxbKy+lStv66YpROoNFV2BGc3xXSBNiofCjM4uUqANwjXUKOK3Q4Ey9dXuZ4gI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5791.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(6506007)(7696005)(86362001)(316002)(55016002)(508600001)(8936002)(9686003)(38070700005)(30864003)(66556008)(64756008)(66446008)(54906003)(66476007)(76116006)(107886003)(8676002)(966005)(66946007)(33656002)(83380400001)(186003)(52536014)(38100700002)(6916009)(4326008)(122000001)(71200400001)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9VfoQJOfJCHr4QPehLO9UMoVaKtrYegvvR3jJb5DZApW+aoJq7uyWKMv80dU?=
 =?us-ascii?Q?08C52FNlg54+JObAalx2A/PahF8QANbXguAuVnURlS4AntThSW/7vC1/fB9A?=
 =?us-ascii?Q?sU+o6zpj88BHTwvaNz9oZw3Z8Ss0KExZol83TFgBq0jhG0/tg+g89gohivHX?=
 =?us-ascii?Q?/k6BavuqeToEiEr/E78uKlzU4JSLBM8bR2IhZuJmU095SHVg8cjkQM+avLa0?=
 =?us-ascii?Q?UCickP/yT946+ILf8R/KFc6J8GgVSTn3EkWiBs3PaNHztKDJ/b5nlBsg6opc?=
 =?us-ascii?Q?7hxP9LtVi1BbJZ+KA998GXV9Ai2SXqZXx/e18ys/VmylJKmIJap3lCHhBv5R?=
 =?us-ascii?Q?EH55ZsKCCMhbzU8dSFrxbEglc4N0jFNY94rUVoH0TDw+v2nwoCQIf2rC9TUn?=
 =?us-ascii?Q?SlCVoP3t7z2x5eF04aLwHDaKnTREZobhKPSV34oXTySbRcG7cBb5R5ueE/JZ?=
 =?us-ascii?Q?2DZsvtTbBQwHj0o02HsP8rDeLvIJKdV3Y/Hb51D/pcUpYNEbJiv4HHjBNypK?=
 =?us-ascii?Q?qbpxCOG17pkK3BjZX9fBpsF9j0wt8oUZ+GKUFWwYJC53xJKNAGuSiT1xUWyW?=
 =?us-ascii?Q?TveUQwy0QIrfYYwBDNK1x4Q2Px1PHo1QmH7JiZAjx6WpqIMckMBLxTX/llc5?=
 =?us-ascii?Q?eZY+ZDFTmsMi95Qec0iP4sZpF2GO5vkH530c1ub27fifq3s25TQEbO0UREqW?=
 =?us-ascii?Q?Oo8C+FDHvMc5v9N2QXgV93i/o1lAprNXuq75itJoHgikMFJ4qFud3iiXO37f?=
 =?us-ascii?Q?JlsvDyp7S3sI2i0DPtQ+jHGjPURYnssFw4N2iM1+ubFLrE8qMetk4NkbnCxx?=
 =?us-ascii?Q?v38dUaJbuWzONcO/QdrXufP0rh+VP0yILPGxQ5pTSXNSL+YdWtNPWy1qJIps?=
 =?us-ascii?Q?BdvXgm6MAbxdL7lLerKXGryNa/Q+oEtU/AU5lFPkCF3YaZIIcOZXJtOsUrLg?=
 =?us-ascii?Q?02TZb8//dfWr+fKznsCmvNzSwxBpFW4lRRMNnWIt7HYfyFZSNsMV7a+3bn3x?=
 =?us-ascii?Q?/Lwi5DQB0A8tefZJ2Wm6M6Glf1lU4bgZzKdneZynT7QFSa7rBv183GkoGyT6?=
 =?us-ascii?Q?gJZFxbpmyBaIkavr4XKbYmQ7Fgs5KlLZkaR775Uz38RQsciI2O5haBMY/qq5?=
 =?us-ascii?Q?EyiWJ0l/2caud7UIKDMaB0vw7RIXbeQHqoQfOFly5AmTpFKagqEJm1LRWMTw?=
 =?us-ascii?Q?5znH2OvCPecH15ldQvmQxvnL6JnDmhpprGpnUYnNamFSfVrtkScmkCcn9kQI?=
 =?us-ascii?Q?NmieH92aNLinUTyxYJiu1MJixVUnLT7xgzSG8XwdN8b7/Cfwy/PO8PWDovJJ?=
 =?us-ascii?Q?X4/RULJgCuFhT2xlj4GwmNmj+cMW8LqbQ520pNShCY2+lvur87QcHwnl/Wrp?=
 =?us-ascii?Q?P8C8JEJT5e8Y1p/ZbeNR2Luz27sp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5791.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2037cae0-18bc-473a-82bf-08d989aefdd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 16:24:52.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2/fRJV4FZd+09rtCidWRH4NuuJO3EE/wijSLNLv5WTF2wGaZq9YO/gi23qi3NnUqDHBxnyctKP7LtXrgvc3EfqUPnw0GFcb+I8zWQkvFXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4437
X-Proofpoint-GUID: tPTeHeWaH8e1SQTGDothlVax6E3I6cw_
X-Proofpoint-ORIG-GUID: tPTeHeWaH8e1SQTGDothlVax6E3I6cw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110070106
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, 7 October 2021 19:06
> To: Chindris, Mihail <Mihail.Chindris@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> lars@metafoo.de; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Sa, Nuno <Nuno.Sa@analog.com>; Bogdan, Dragos
> <Dragos.Bogdan@analog.com>; alexandru.ardelean@analog.com
> Subject: Re: [PATCH v6 1/6] iio: Add output buffer support
>=20
> On Thu, 7 Oct 2021 08:00:30 +0000
> Mihail Chindris <mihail.chindris@analog.com> wrote:
>=20
> > Currently IIO only supports buffer mode for capture devices like ADCs.
> > Add support for buffered mode for output devices like DACs.
> >
> > The output buffer implementation is analogous to the input buffer
> > implementation. Instead of using read() to get data from the buffer
> > write() is used to copy data into the buffer.
> >
> > poll() with POLLOUT will wakeup if there is space available.
> >
> > Drivers can remove data from a buffer using iio_pop_from_buffer(), the
> > function can e.g. called from a trigger handler to write the data to
> > hardware.
> >
> > A buffer can only be either a output buffer or an input, but not both.
> > So, for a device that has an ADC and DAC path, this will mean 2 IIO
> > buffers (one for each direction).
> >
> > The direction of the buffer is decided by the new direction field of
> > the iio_buffer struct and should be set after allocating and before
> > registering it.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
>=20
> Hi Mihail,
>=20
> I'm fine with this series now, but one question for this patch on whether=
 we
> can clarify the author chain.
>=20
> The above might mean one of two things.
> 1) Lars wrote the code and Alex and yourself just 'handled' the patch on =
its
>    way to posting.  If that were the case it should have a From: for Lars
> 2) All 3 were involved in changes to this patch.  In that case we should =
have
> Co-developed-by: lines for lars and Alex as described:
> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/sourc=
e/
> Documentation/process/submitting-
> patches.rst*L475__;Iw!!A3Ni8CS0y2Y!t1IaOEZX3w2pZXl-
> RyAlXgPPvxFtCON74ppfGuMgV_pKZcNjsLs-dKSk_mA34IsmlOU$
>=20
> This patch has a history well predating the Co-developed-tag but I'm happ=
y
> to add that if you can confirm that matches with the intent.
>=20
> Good to leave on the list for a few days anyway in case anyone else wants=
 to
> take a quick look.
>=20
> I'm looking forwards to merging this and thinking back to when Lars origi=
nally
> discussed this feature with me rather a lot of years back!
>=20
> Jonathan
>=20
>=20

Hi Jonathan,

What I have done with the patch was to take the V3 that Alex has left and i=
mplement the feedback. So I think this is considered as 'handled' from my s=
ide.
What happened before V3 I think is better if Alex spokes for himself becaus=
e I don't really know :)

Mihail

>=20
> > ---
> >  drivers/iio/iio_core.h            |   4 +
> >  drivers/iio/industrialio-buffer.c | 127
> +++++++++++++++++++++++++++++-
> >  drivers/iio/industrialio-core.c   |   1 +
> >  include/linux/iio/buffer.h        |   7 ++
> >  include/linux/iio/buffer_impl.h   |  11 +++
> >  5 files changed, 148 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h index
> > 8f4a9b264962..61e318431de9 100644
> > --- a/drivers/iio/iio_core.h
> > +++ b/drivers/iio/iio_core.h
> > @@ -68,12 +68,15 @@ __poll_t iio_buffer_poll_wrapper(struct file *filp,
> >  				 struct poll_table_struct *wait);  ssize_t
> > iio_buffer_read_wrapper(struct file *filp, char __user *buf,
> >  				size_t n, loff_t *f_ps);
> > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user =
*buf,
> > +				 size_t n, loff_t *f_ps);
> >
> >  int iio_buffers_alloc_sysfs_and_mask(struct iio_dev *indio_dev);
> > void iio_buffers_free_sysfs_and_mask(struct iio_dev *indio_dev);
> >
> >  #define iio_buffer_poll_addr (&iio_buffer_poll_wrapper)  #define
> > iio_buffer_read_outer_addr (&iio_buffer_read_wrapper)
> > +#define iio_buffer_write_outer_addr (&iio_buffer_write_wrapper)
> >
> >  void iio_disable_all_buffers(struct iio_dev *indio_dev);  void
> > iio_buffer_wakeup_poll(struct iio_dev *indio_dev); @@ -83,6 +86,7 @@
> > void iio_device_detach_buffers(struct iio_dev *indio_dev);
> >
> >  #define iio_buffer_poll_addr NULL
> >  #define iio_buffer_read_outer_addr NULL
> > +#define iio_buffer_write_outer_addr NULL
> >
> >  static inline int iio_buffers_alloc_sysfs_and_mask(struct iio_dev
> > *indio_dev)  { diff --git a/drivers/iio/industrialio-buffer.c
> > b/drivers/iio/industrialio-buffer.c
> > index a95cc2da56be..7286563e6234 100644
> > --- a/drivers/iio/industrialio-buffer.c
> > +++ b/drivers/iio/industrialio-buffer.c
> > @@ -120,6 +120,9 @@ static ssize_t iio_buffer_read(struct file *filp, c=
har
> __user *buf,
> >  	if (!rb || !rb->access->read)
> >  		return -EINVAL;
> >
> > +	if (rb->direction !=3D IIO_BUFFER_DIRECTION_IN)
> > +		return -EPERM;
> > +
> >  	datum_size =3D rb->bytes_per_datum;
> >
> >  	/*
> > @@ -161,6 +164,65 @@ static ssize_t iio_buffer_read(struct file *filp, =
char
> __user *buf,
> >  	return ret;
> >  }
> >
> > +static size_t iio_buffer_space_available(struct iio_buffer *buf) {
> > +	if (buf->access->space_available)
> > +		return buf->access->space_available(buf);
> > +
> > +	return SIZE_MAX;
> > +}
> > +
> > +static ssize_t iio_buffer_write(struct file *filp, const char __user *=
buf,
> > +				size_t n, loff_t *f_ps)
> > +{
> > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > +	struct iio_buffer *rb =3D ib->buffer;
> > +	struct iio_dev *indio_dev =3D ib->indio_dev;
> > +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
> > +	int ret;
> > +	size_t written;
> > +
> > +	if (!indio_dev->info)
> > +		return -ENODEV;
> > +
> > +	if (!rb || !rb->access->write)
> > +		return -EINVAL;
> > +
> > +	if (rb->direction !=3D IIO_BUFFER_DIRECTION_OUT)
> > +		return -EPERM;
> > +
> > +	written =3D 0;
> > +	add_wait_queue(&rb->pollq, &wait);
> > +	do {
> > +		if (indio_dev->info =3D=3D NULL)
> > +			return -ENODEV;
> > +
> > +		if (!iio_buffer_space_available(rb)) {
> > +			if (signal_pending(current)) {
> > +				ret =3D -ERESTARTSYS;
> > +				break;
> > +			}
> > +
> > +			wait_woken(&wait, TASK_INTERRUPTIBLE,
> > +					MAX_SCHEDULE_TIMEOUT);
> > +			continue;
> > +		}
> > +
> > +		ret =3D rb->access->write(rb, n - written, buf + written);
> > +		if (ret =3D=3D 0 && (filp->f_flags & O_NONBLOCK))
> > +			ret =3D -EAGAIN;
> > +
> > +		if (ret > 0) {
> > +			written +=3D ret;
> > +			if (written !=3D n && !(filp->f_flags & O_NONBLOCK))
> > +				continue;
> > +		}
> > +	} while (ret =3D=3D 0);
> > +	remove_wait_queue(&rb->pollq, &wait);
> > +
> > +	return ret < 0 ? ret : n;
> > +}
> > +
> >  /**
> >   * iio_buffer_poll() - poll the buffer to find out if it has data
> >   * @filp:	File structure pointer for device access
> > @@ -181,8 +243,18 @@ static __poll_t iio_buffer_poll(struct file *filp,
> >  		return 0;
> >
> >  	poll_wait(filp, &rb->pollq, wait);
> > -	if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > -		return EPOLLIN | EPOLLRDNORM;
> > +
> > +	switch (rb->direction) {
> > +	case IIO_BUFFER_DIRECTION_IN:
> > +		if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> > +			return EPOLLIN | EPOLLRDNORM;
> > +		break;
> > +	case IIO_BUFFER_DIRECTION_OUT:
> > +		if (iio_buffer_space_available(rb))
> > +			return EPOLLOUT | EPOLLWRNORM;
> > +		break;
> > +	}
> > +
> >  	return 0;
> >  }
> >
> > @@ -199,6 +271,19 @@ ssize_t iio_buffer_read_wrapper(struct file *filp,
> char __user *buf,
> >  	return iio_buffer_read(filp, buf, n, f_ps);  }
> >
> > +ssize_t iio_buffer_write_wrapper(struct file *filp, const char __user =
*buf,
> > +				 size_t n, loff_t *f_ps)
> > +{
> > +	struct iio_dev_buffer_pair *ib =3D filp->private_data;
> > +	struct iio_buffer *rb =3D ib->buffer;
> > +
> > +	/* check if buffer was opened through new API */
> > +	if (test_bit(IIO_BUSY_BIT_POS, &rb->flags))
> > +		return -EBUSY;
> > +
> > +	return iio_buffer_write(filp, buf, n, f_ps); }
> > +
> >  __poll_t iio_buffer_poll_wrapper(struct file *filp,
> >  				 struct poll_table_struct *wait)
> >  {
> > @@ -231,6 +316,15 @@ void iio_buffer_wakeup_poll(struct iio_dev
> *indio_dev)
> >  	}
> >  }
> >
> > +int iio_pop_from_buffer(struct iio_buffer *buffer, void *data) {
> > +	if (!buffer || !buffer->access || !buffer->access->remove_from)
> > +		return -EINVAL;
> > +
> > +	return buffer->access->remove_from(buffer, data); }
> > +EXPORT_SYMBOL_GPL(iio_pop_from_buffer);
> > +
> >  void iio_buffer_init(struct iio_buffer *buffer)  {
> >  	INIT_LIST_HEAD(&buffer->demux_list);
> > @@ -1156,6 +1250,10 @@ int iio_update_buffers(struct iio_dev
> *indio_dev,
> >  	if (insert_buffer =3D=3D remove_buffer)
> >  		return 0;
> >
> > +	if (insert_buffer &&
> > +	    (insert_buffer->direction =3D=3D IIO_BUFFER_DIRECTION_OUT))
> > +		return -EINVAL;
> > +
> >  	mutex_lock(&iio_dev_opaque->info_exist_lock);
> >  	mutex_lock(&indio_dev->mlock);
> >
> > @@ -1277,6 +1375,22 @@ static ssize_t
> iio_dma_show_data_available(struct device *dev,
> >  	return sysfs_emit(buf, "%zu\n", iio_buffer_data_available(buffer));
> >  }
> >
> > +static ssize_t direction_show(struct device *dev,
> > +			      struct device_attribute *attr,
> > +			      char *buf)
> > +{
> > +	struct iio_buffer *buffer =3D to_iio_dev_attr(attr)->buffer;
> > +
> > +	switch (buffer->direction) {
> > +	case IIO_BUFFER_DIRECTION_IN:
> > +		return sprintf(buf, "in\n");
> > +	case IIO_BUFFER_DIRECTION_OUT:
> > +		return sprintf(buf, "out\n");
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static DEVICE_ATTR(length, S_IRUGO | S_IWUSR, iio_buffer_read_length,
> >  		   iio_buffer_write_length);
> >  static struct device_attribute dev_attr_length_ro =3D __ATTR(length, @=
@
> > -1289,12 +1403,20 @@ static struct device_attribute
> dev_attr_watermark_ro =3D __ATTR(watermark,
> >  	S_IRUGO, iio_buffer_show_watermark, NULL);  static
> > DEVICE_ATTR(data_available, S_IRUGO,
> >  		iio_dma_show_data_available, NULL);
> > +static DEVICE_ATTR_RO(direction);
> >
> > +/*
> > + * When adding new attributes here, put the at the end, at least
> > +until
> > + * the code that handles the length/length_ro &
> > +watermark/watermark_ro
> > + * assignments gets cleaned up. Otherwise these can create some weird
> > + * duplicate attributes errors under some setups.
> > + */
> >  static struct attribute *iio_buffer_attrs[] =3D {
> >  	&dev_attr_length.attr,
> >  	&dev_attr_enable.attr,
> >  	&dev_attr_watermark.attr,
> >  	&dev_attr_data_available.attr,
> > +	&dev_attr_direction.attr,
> >  };
> >
> >  #define to_dev_attr(_attr) container_of(_attr, struct
> > device_attribute, attr) @@ -1397,6 +1519,7 @@ static const struct
> file_operations iio_buffer_chrdev_fileops =3D {
> >  	.owner =3D THIS_MODULE,
> >  	.llseek =3D noop_llseek,
> >  	.read =3D iio_buffer_read,
> > +	.write =3D iio_buffer_write,
> >  	.poll =3D iio_buffer_poll,
> >  	.release =3D iio_buffer_chrdev_release,  }; diff --git
> > a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 2dbb37e09b8c..537a08549a69 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1822,6 +1822,7 @@ static const struct file_operations
> iio_buffer_fileops =3D {
> >  	.owner =3D THIS_MODULE,
> >  	.llseek =3D noop_llseek,
> >  	.read =3D iio_buffer_read_outer_addr,
> > +	.write =3D iio_buffer_write_outer_addr,
> >  	.poll =3D iio_buffer_poll_addr,
> >  	.unlocked_ioctl =3D iio_ioctl,
> >  	.compat_ioctl =3D compat_ptr_ioctl,
> > diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> > index b6928ac5c63d..fe2e680d9b5e 100644
> > --- a/include/linux/iio/buffer.h
> > +++ b/include/linux/iio/buffer.h
> > @@ -11,8 +11,15 @@
> >
> >  struct iio_buffer;
> >
> > +enum iio_buffer_direction {
> > +	IIO_BUFFER_DIRECTION_IN,
> > +	IIO_BUFFER_DIRECTION_OUT,
> > +};
> > +
> >  int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
> >
> > +int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
> > +
> >  /**
> >   * iio_push_to_buffers_with_timestamp() - push data and timestamp to
> buffers
> >   * @indio_dev:		iio_dev structure for device.
> > diff --git a/include/linux/iio/buffer_impl.h
> > b/include/linux/iio/buffer_impl.h index 245b32918ae1..e2ca8ea23e19
> > 100644
> > --- a/include/linux/iio/buffer_impl.h
> > +++ b/include/linux/iio/buffer_impl.h
> > @@ -7,6 +7,7 @@
> >  #ifdef CONFIG_IIO_BUFFER
> >
> >  #include <uapi/linux/iio/buffer.h>
> > +#include <linux/iio/buffer.h>
> >
> >  struct iio_dev;
> >  struct iio_buffer;
> > @@ -23,6 +24,10 @@ struct iio_buffer;
> >   * @read:		try to get a specified number of bytes (must exist)
> >   * @data_available:	indicates how much data is available for reading f=
rom
> >   *			the buffer.
> > + * @remove_from:	remove scan from buffer. Drivers should calls this to
> > + *			remove a scan from a buffer.
> > + * @write:		try to write a number of bytes
> > + * @space_available:	returns the amount of bytes available in a
> buffer
> >   * @request_update:	if a parameter change has been marked,
> update underlying
> >   *			storage.
> >   * @set_bytes_per_datum:set number of bytes per datum @@ -49,6
> +54,9
> > @@ struct iio_buffer_access_funcs {
> >  	int (*store_to)(struct iio_buffer *buffer, const void *data);
> >  	int (*read)(struct iio_buffer *buffer, size_t n, char __user *buf);
> >  	size_t (*data_available)(struct iio_buffer *buffer);
> > +	int (*remove_from)(struct iio_buffer *buffer, void *data);
> > +	int (*write)(struct iio_buffer *buffer, size_t n, const char __user
> *buf);
> > +	size_t (*space_available)(struct iio_buffer *buffer);
> >
> >  	int (*request_update)(struct iio_buffer *buffer);
> >
> > @@ -80,6 +88,9 @@ struct iio_buffer {
> >  	/**  @bytes_per_datum: Size of individual datum including
> timestamp. */
> >  	size_t bytes_per_datum;
> >
> > +	/* @direction: Direction of the data stream (in/out). */
> > +	enum iio_buffer_direction direction;
> > +
> >  	/**
> >  	 * @access: Buffer access functions associated with the
> >  	 * implementation.

