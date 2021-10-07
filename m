Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225C8424EC6
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 10:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbhJGIMe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 04:12:34 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:11178 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240554AbhJGIMd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2021 04:12:33 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1972gVYo029112;
        Thu, 7 Oct 2021 04:10:27 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 3bhracha1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Oct 2021 04:10:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebpxrJknkYin0cG5lqq2i89xZZBWO9VvfzdtdYnJdvO/dHVHjysXt65AYOareuWyWNNfr+VunxAN0CudAcTgvmgtxS2Cfu6/TSC+AbFJRMJHhorPM4WJoYS5zemh1yMPP90BoeXaLkXtysNwNdGi9Y4l+Mnz90xjw8ngsEc0NlSZooIYTC5VjJiCUGbRCq3KIfS2gL2AnSEYF22JRZcobpS6bkWsa/X58jopK6we5NLZyoF/sdTz8U6+gzUK/DsVTLC5Q+oINOB/PE1uZd4AIPGiiszzlp6vMenqZ+2shgWwQKs0PBuIct5+lalmKrAyZzGQ0nhJDN9fbG2jsl25sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxjDsa5+UsQLBDtkC44gF9E5deapW/OG5TOduaxXob0=;
 b=aiPa+67zYY/Z67j7H0KLXFbYcQJZP46t8nNM8r666Q3zrOrDbGRTv/EHaUnAfuSWvWhP+WSLOdesWR4ZNMNF4QLRva9Qb+u3G1ytsjMxWeZx2gajKxeL/Y7T6qwouQXguU04UjYeLwKNCseGnT0tsZvTIF/bBT+YBnfNXVZdNe4F5+BBf/0dR7LhE5SZfPBV2iYQG3d2nweya7PCYyW918BjuMInbQl9ASrrnn2gxmaqXyDeNntKQXZO4Xx/HUWgPcDv1XHLOINK0POXICy+8GKKTJ7tRhUUJiRuFcekiGAcebe7Hziq06oRe8AbVDLD8TcBQFr6rDFG+ln83HWm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxjDsa5+UsQLBDtkC44gF9E5deapW/OG5TOduaxXob0=;
 b=ae0ExZQUE5NrYu4PwYrGPJ3HZ6dW4QTNdZDO8lOOvKSffgNoveRwuAfyceliOgWqQutOPWMcvPWWqO9I0/F2lcPPXY+sfOLqdYMLIb/0gG8O92YVaEudS7FbDoHqR/y+kRQQX8RYTDtrr3yqLcoPR2EoOSUycVj9ic9eIOJWb+4=
Received: from CO1PR03MB5778.namprd03.prod.outlook.com (2603:10b6:303:6e::22)
 by CO2PR03MB2230.namprd03.prod.outlook.com (2603:10b6:102:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20; Thu, 7 Oct
 2021 08:10:25 +0000
Received: from CO1PR03MB5778.namprd03.prod.outlook.com
 ([fe80::7c15:674c:c819:627a]) by CO1PR03MB5778.namprd03.prod.outlook.com
 ([fe80::7c15:674c:c819:627a%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 08:10:25 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     "Chindris, Mihail" <Mihail.Chindris@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: RE: [PATCH v6 0/6] iio: Add output buffer support
Thread-Topic: [PATCH v6 0/6] iio: Add output buffer support
Thread-Index: AQHXu1F2G7PSGTbIwUe0ibTfwUhjw6vHLq5w
Date:   Thu, 7 Oct 2021 08:10:25 +0000
Message-ID: <CO1PR03MB5778A5BDB7D02A69429C48B299B19@CO1PR03MB5778.namprd03.prod.outlook.com>
References: <20211007080035.2531-1-mihail.chindris@analog.com>
In-Reply-To: <20211007080035.2531-1-mihail.chindris@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0wNDhlZWJjOC0yNzQ2LTExZWMtODQwMS05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcMDQ4ZWViY2EtMjc0Ni0xMWVjLTg0MDEtOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSIzNjExIiB0PSIxMzI3ODA2NzgyMjk3?=
 =?us-ascii?Q?MTAzMDYiIGg9IjBWT1pyNk1FRHBmcml3ZzRsM3grSTlKNFJKMD0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RGkxZXJHVXJ2WEFWdFlSbTdQMWxENFcxaEdicy9XVVBnREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc95a5b5-8c46-4c90-fbec-08d98969eaea
x-ms-traffictypediagnostic: CO2PR03MB2230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR03MB2230EE54942DC14622AC3AE499B19@CO2PR03MB2230.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7QD66kPen0E2PlzeoAWPb0JTKroR0GsIXzYAeubhxVFWyEiYsnpkxXV0/WiADGXV6FuUvGA+uqcRGv1UrEeEckIm0R6zk87Rkkv5YSAh7UpOy4PU79R4HV/iitvANMfIqRe2xWZmEH7eRQfj5eMmoVh5fQpmcb7c6uJOv9d5aflT14cpY7bEM909t3wa8H9iuyQ2O5uBzmi0BFY8uROt9UdsJg2WU2zEI/tvBU2EV/FeeOUdHza/w7ZAmbHt3P50cXYfEW+F4XLiL2+DYYQlyqK4ICZjW4a+MI4GzNwQOf+tiiRagcSWeRGNunUsRFPLsOl47PSjSG69iYG/A8ia+rp19b7w1oLL+V25znaDplk2GxnHMt4p0FCRJaQgdssrYdSTCuxTQQjHbLDV1y1vJad9Tjj//UN1BtcSKqJoCDdqpKFoexOoRNbtKtYDEgwTIlj4n6Ii1EsKwG4plhTqNt2XIYVBADWMI0WIfMGCmFua3+yc4xxziwRIEj8VmDbtuvR0gBID3WSvEMQeh2qrSVU78wE8Hi8wX9eH2VnSo4gFq7ieYC3ooFjXlJtEJ/C6oS6Qtq8EMdk1ItkX+z2Sad9t68RYPtVsceNbjmA5GzbVGdHWDzkUmanX9V9nxAc2bBZZfrwL27xKzF3FJfxQNzzs8WH+C0WU7dRyQz55b/OrPnPlYdBhYNHKOymi6Rtg9jp2HnIW4Pi1C7Io7DL0Gl3B8uHddUHnqXHcKrnebYjVj/Aiy4biNj4HJWLfcxgXAiSx8A1h1HOVVqQjypotxVUIlk9waVludAxb1DhexWA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR03MB5778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(83380400001)(7696005)(2906002)(38100700002)(86362001)(6506007)(508600001)(38070700005)(186003)(53546011)(71200400001)(966005)(8676002)(64756008)(4326008)(66446008)(110136005)(55016002)(66556008)(52536014)(66476007)(107886003)(54906003)(316002)(122000001)(76116006)(5660300002)(66946007)(9686003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?il45+TdCcDyjdfwVR6PFzxrWnu3peCUajTIruk9PneXGbeoCGk0lqgbJlzCL?=
 =?us-ascii?Q?A6X3sJ4bdl2UsU+54LUnpdIiUxdVrvKy9MsHT6BHLh3fU/ynnwawSYxe/sl2?=
 =?us-ascii?Q?//Hb748mUvKuJN+LkjNCByjN8AOhiYUM7rlx54Ofxsel0jz4YYamevoKR9ne?=
 =?us-ascii?Q?mb/doe3M0wrfFVPh/lfZuozg6JPSPHuPT4dv4qQz8IjUAHBl5Ye9cRXZ869o?=
 =?us-ascii?Q?Uquc2oqN8Drax4B9Qnpi2zAS1OocTGyFxJN1moWfWS2T8u7CJ3MWXsGxxiYG?=
 =?us-ascii?Q?0lm/XQcl5jafSWG0DUScaFrqLQllh51x1rvRq+k1DInmlz27sFWnUxPfdftV?=
 =?us-ascii?Q?sOvpHdShx4iCnmwKIl+WtlHCNQAUSp7Bg2bYy0i2d+02VlM7kkQ4xvgSmxn3?=
 =?us-ascii?Q?bb0WRMrfifkg9mkdFr4sBeK+fNtDo9tE0OZRCqWfegx0YmrgrXiuiURlvTBW?=
 =?us-ascii?Q?d2sTJ8MBdD5Hpf+eY363IDtUX7pKMk7rdfwAl83jEs7ioSPyjR50ApmhODIg?=
 =?us-ascii?Q?jz0Qaq8aV24CeEZ8UmQSWHf+FRyu732Kf4ZE/lDM2FmV3ZSPE0kJnu9zsMBZ?=
 =?us-ascii?Q?ztOfa4HSjmv06viqjJw+Xot4L+osRCgX6Iu7oeU6hMr4OhqEwCUNbCf8RrjK?=
 =?us-ascii?Q?MqQVa1pjrc6OzTy43FzcRM1DjTnnvYg6XirVP5jv4uFEa83gfYca9HmLkcUg?=
 =?us-ascii?Q?e40yV2tFIbFg5MWJRxYVoeXGCsGvnXY44+8dnlRo3hSuVLzTjK/yr5J7Y4Ib?=
 =?us-ascii?Q?oIapY6YyT5AygsAPgKskfa4Qv/jjX97dk73DRrguGRUZscg8vvaf0c3GP3eb?=
 =?us-ascii?Q?CVvGVVFX2MDmXdfNFkqD/kJa5ieJqzgEF2ARatCapUlO/tsGtTJyjZfyuaek?=
 =?us-ascii?Q?T/wWPrq4YvONz7Ctkm1XJ7vqISW1cEMDCTUH0/aNu1jDoQoTnlC0AT8ROfKe?=
 =?us-ascii?Q?tfQnnJQnrY0RykgtKNbwZ3KxOrZQZDOlQWsRISrm6v2iaVUgSfmYWRIY7J6d?=
 =?us-ascii?Q?KoTrcfFdDd2eWUQqoJQRcwFcdj3Q0DxAv7BVgcsCg/Lq5zA3RMLP7mQpJzhx?=
 =?us-ascii?Q?heSWWZDS/nzAETIS+lWCZ8pxrisxLcJujfb0+AVBFQKMZ1YwLl1UOvFMSt12?=
 =?us-ascii?Q?X4vVfi2xDmJs6PXqkg2jriCEmfFypp9kMdeP44GZr6w8Z/85+3n3SsgbX9Gz?=
 =?us-ascii?Q?8dGWngDxmZayJOq81uFW/VyzATU7OIFDe0PLI2Hc66oB+TS0Wq9Nzw6RoRXv?=
 =?us-ascii?Q?xH2O5Kb3fmoYO4IpXRWYHM+3FyJhbVaPlzMeCnk30iY6GDOYQUhbds1r5LVW?=
 =?us-ascii?Q?SQ+pPjXmcMZWrS7E46z2amrcla8NNBD1fE/cq6tIZ7fGNOI2HvoKtAYq5G++?=
 =?us-ascii?Q?RfmW+JKyzlw+UF2wib6wuHGxRkxf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR03MB5778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc95a5b5-8c46-4c90-fbec-08d98969eaea
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 08:10:25.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUXcglej4iZDvFRF8bNOulvTBQz+9/MQfsdfp8W6tOBHij6j8RpnpZncvEFo21zvHj6064z3v1Nj0sDVytdmZtDXY0VAEEBJw5dn6cYRXkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2230
X-Proofpoint-GUID: 55D0bzyGuuh_TkFmmC8ejCAyIUzinniO
X-Proofpoint-ORIG-GUID: 55D0bzyGuuh_TkFmmC8ejCAyIUzinniO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-07_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110070055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Mihail Chindris <mihail.chindris@analog.com>
> Sent: Thursday, 7 October 2021 11:00
> To: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org
> Cc: lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; jic23@kernel.org; Sa, Nuno
> <Nuno.Sa@analog.com>; Bogdan, Dragos <Dragos.Bogdan@analog.com>;
> alexandru.ardelean@analog.com; Chindris, Mihail
> <Mihail.Chindris@analog.com>
> Subject: [PATCH v6 0/6] iio: Add output buffer support
>=20
> Changelog v5 -> v6:
>   * https://lore.kernel.org/all/20210916182914.1810-1-
> mihail.chindris@analog.com
>   * Fix check in  iio_update_buffers adding test on insert_buffer
>   * Return if check in iio_update_buffers fails.
>   * Fix length typo
>   * Add rb->direction check in both read and write functions.
>   * Add fixes tags
>   * Add  Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com> line
>   * Remove unnecessary (u8 *) cast
>   * Remove unnecessary AD5766_NUM_CH define
* Write to input register in ad5766_trigger_handler for simultaneous update
>=20
> Changelog v4 -> v5:
>   * https://lore.kernel.org/all/20210820165927.4524-1-
> mihail.chindris@analog.com
>   * Remove ad3552r example from series and replace with the update of an
>     existing driver: ad5662. Will add ad3552r in other another series.
>   * Make normal comment from kernel-doc comment. (A bot was
> complaining about that)
>   * Add indio_dev->info check
>   * Rename iio_buffer_remove_sample -> iio_pop_from_buffer
>   * Fix comment of remove_from: sample -> scan
>   * Change iio_pop_from_buffer data type to void * to be consistent with
>     iio_push_to_buffers
>   * Remove use watermark, in our kernel is not used and I can't think of =
an
>     usecase for it.
>   * Reimplement write to increment buffer index and handle blocking and
>     noblocking calls
>   * Move `if (insert_buffer->direction =3D=3D IIO_BUFFER_DIRECTION_OUT)`
> outside lock
>   * Remove redundant checks of `if (insert_buffer->direction =3D=3D
>     IIO_BUFFER_DIRECTION_OUT)`
>=20
> Alexandru Ardelean (1):
>   iio: triggered-buffer: extend support to configure output buffers
>=20
> Lars-Peter Clausen (1):
>   iio: kfifo-buffer: Add output buffer support
>=20
> Mihail Chindris (4):
>   iio: Add output buffer support
>   drivers: iio: dac: ad5766: Fix dt property name
>   Documentation:devicetree:bindings:iio:dac: Fix val
>   drivers:iio:dac:ad5766.c: Add trigger buffer
>=20
>  .../bindings/iio/dac/adi,ad5766.yaml          |   2 +-
>  drivers/iio/accel/adxl372.c                   |   1 +
>  drivers/iio/accel/bmc150-accel-core.c         |   1 +
>  drivers/iio/adc/at91-sama5d2_adc.c            |   4 +-
>  .../buffer/industrialio-triggered-buffer.c    |   8 +-
>  drivers/iio/buffer/kfifo_buf.c                |  50 +++++++
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   5 +-
>  .../common/hid-sensors/hid-sensor-trigger.c   |   5 +-
>  drivers/iio/dac/ad5766.c                      |  48 ++++++-
>  drivers/iio/iio_core.h                        |   4 +
>  drivers/iio/industrialio-buffer.c             | 127 +++++++++++++++++-
>  drivers/iio/industrialio-core.c               |   1 +
>  include/linux/iio/buffer.h                    |   7 +
>  include/linux/iio/buffer_impl.h               |  11 ++
>  include/linux/iio/triggered_buffer.h          |  11 +-
>  15 files changed, 269 insertions(+), 16 deletions(-)
>=20
>=20
> base-commit: 94a853eca720ac9e385e59f27e859b4a01123f58
> --
> 2.27.0

