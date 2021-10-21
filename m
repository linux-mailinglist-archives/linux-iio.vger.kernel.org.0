Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFDE435BC9
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhJUHfa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 03:35:30 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39140 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231315AbhJUHfa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 03:35:30 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KL1JKq028076;
        Thu, 21 Oct 2021 03:32:40 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 3btk71mgq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 03:32:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuFsgzXlvH6QL5vrEnDReaqDZUlRcHkyqH40irL7x08mAXGyU/czaGI9WY88Qh4C95BFUdNRURhGNa5tNNTMGm/xM4HbIFZ4i0Z8/ajGF1CKfRSnJ6EVVbYNQqdXSRQSKYX+3DuxiFSlY30mpRhoJjSfBaN3SIfOwnxsblO9AA4ViiArE5z4e5tK19+q9FpdDx7AhkBiMEVLDGGttxhWUuPsUulKw32kP5LZC5zS4o1LoGHYHlcz3wHIZ5wWLpBNUy4yDTUH43p4vfjSigZeSUYUriZqoux44m9Po4X6kZaxAkjT+16NYXt6zF5Eu5VtatXctSZNIQ+3Eg1Oa2DtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldnT9o0d/zfNPYdX4In/w8iKgjRYFYD6e3zEMLNn7mM=;
 b=Dxo1sscKEXAoVJls2j9K+Z1zyCxuYai2QV53z8ZVzi+cNpOWKJLGkteTeuGMfWnSZKfovlmLwt2jbacesS/cv4U8WZ19H3GLCTXdyFu9yUBNSxDTTZ+3URd9YGe/xSmupb5zP9mc02PLAi0nIbEmVZpHDO84YrAYTN/a/lojK71JPUfueloNJHKv0EAzxHSFv95kjc99jRQm2QqfqBiQOzOaa8kEd4maxhle2zxNQlwmIgbZ5zQB9zTw/9D3kVao/IuR1/oMQ2xin+wajRtH83yob5+bh0bZg5QuhDOkJSChlFitVpSegCbRSUNi2gW1th9/Drn6GHlbCK8UreG7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldnT9o0d/zfNPYdX4In/w8iKgjRYFYD6e3zEMLNn7mM=;
 b=hbruZzAaC4kYXORpZknlKAZ+a69Hw/ou102RB1/4VbrEkRF3cODOaqqqIhArElWR2bOsEJ6OQ1TazdVEeo1Rjfqxvsb+DjlgICLPmvBZXDLr/AdcdSg7Gu0kld+NRpJ9OfdR/mG0QJtiEicBx1xwGWEGye3+ngCZ9j1o9uS5mNg=
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com (2603:10b6:a03:2d4::23)
 by BY5PR03MB5297.namprd03.prod.outlook.com (2603:10b6:a03:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Thu, 21 Oct
 2021 07:32:37 +0000
Received: from SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4]) by SJ0PR03MB5791.namprd03.prod.outlook.com
 ([fe80::1495:c03:5f94:efe4%4]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 07:32:37 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     "Chindris, Mihail" <Mihail.Chindris@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Thread-Index: AQHXxkscWWjkgf+0fkG8niEaQQVpq6vdDdhw
Date:   Thu, 21 Oct 2021 07:32:37 +0000
Message-ID: <SJ0PR03MB579156733039B349E92FF05999BF9@SJ0PR03MB5791.namprd03.prod.outlook.com>
References: <20211021070924.18626-1-mihail.chindris@analog.com>
 <20211021070924.18626-2-mihail.chindris@analog.com>
In-Reply-To: <20211021070924.18626-2-mihail.chindris@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0wZDQ3NGZiMi0zMjQxLTExZWMtODQwMi05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcMGQ0NzRmYjQtMzI0MS0xMWVjLTg0MDItOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSI3MzgiIHQ9IjEzMjc5Mjc1MTUyOTA2?=
 =?us-ascii?Q?Mzg1OSIgaD0iWnVDTnNuSU5MRmZQWFNUbWgxdDhDd0hmaVhNPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9DQUFD?=
 =?us-ascii?Q?ejlhTFBUY2JYQVVEalZkcWZVWkxRUU9OVjJwOVJrdEFEQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFWSUV2b1FBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFR?=
 =?us-ascii?Q?QmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6QUY4?=
 =?us-ascii?Q?QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFC?=
 =?us-ascii?Q?eUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2?=
 =?us-ascii?Q?QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0?=
 =?us-ascii?Q?YT4=3D?=
x-dg-rorf: true
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f1b610f-c32d-4989-645f-08d99464f4d9
x-ms-traffictypediagnostic: BY5PR03MB5297:
x-microsoft-antispam-prvs: <BY5PR03MB5297BF7463FD386335A5197299BF9@BY5PR03MB5297.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I9rUfI4PvnnU6axdNrCtT30megYubntnlCMUYahzAzNTRKtBivHMvJFOmWgevxbvoFWxtkNjSHLrDzwUs5xwKN2xmunJm5neMftdbIxTBOBs14c4fMynLu+WEH3BKslvJzCalY8xOmSGwViUMCO4SumVGlT6lyv86zXRXsktop3KUfxT0YDFoS7Tccgfx+nSaDwT1+NNAglCNDBa2uaR5u0sQR4C7xldSh0dhCSR4cQrwOfy172eYBk2qylYW9iFFDbjzbNzc9fqlLWL7dOiHzJLEBmdtopWbqvYMJ1I2rti/61UhCN6W5fzh2R6e2vBJZgfEEfTwwf3D2oQ7stHkYqBh5CKEHGfdZwu/rrJZYFvSdvjvpFJG7sHcqQ7K4xePgeB6glv0V8DFwjzeRDA/ijd8aY7SBesWLgwBqxC9L1auzvky282cpWOGYhLLRvdaG1O/ZVg9KRF2D7EsU84qn1PhHvhRGKTHM0C/ePeKeWyaBYWAy7swp9M91bSq7Trsv+6926ZrRacPq4fH1co2yGQg9UiT1JNc/KdhbDXm5P+GhTVp73vCxw77GWNyoK05eB5DsAXqpnjAartHNI5rlbHOTiTK+dAauXbGTFiUkepcgY92JAgCfZvggn5Ijy6a7zyb5xRmoQWzurNMtr/hf1Gwv+X/ZbF6jTRKEQ+pOcIGqUbR4zIsP9LUGOrkIjQZ3VBeGDD45KLVhq2b8tXKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5791.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(33656002)(4326008)(38070700005)(7696005)(4744005)(316002)(9686003)(86362001)(8936002)(5660300002)(55016002)(8676002)(52536014)(76116006)(66446008)(64756008)(66476007)(83380400001)(186003)(122000001)(110136005)(38100700002)(71200400001)(66556008)(66946007)(508600001)(54906003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KVDB94gw4RdZti7awQQa+swq+lK+IJzzoYyeo/cW5IFFJ0gdJeiE6PYWZiWS?=
 =?us-ascii?Q?jFWFBe296N3ynMDWxIXnIKNIiHwdS9qVrhMoJ2yhX9QBNJr143cBcuI5purv?=
 =?us-ascii?Q?dkM4+0u8UPEwWPgT3yS+WmSUkq1joFv9PplBQdNazXAmt4sBpBwyr6+iSDaU?=
 =?us-ascii?Q?11pmz4s7wAm5Zi9j3+jQgwhEh7OnSF2/O8dT8bH66BdkBiLHeJgsgsosszUM?=
 =?us-ascii?Q?M/iM+jv32z0divw/9LVmgIq8/PAkDHQhN++MaM30935GQdsi+nAzzBTTLODm?=
 =?us-ascii?Q?IbRoWoFmQuPIsY+NwRhTOMnqB3qXoGukng9uEYQiTcOR6sJzhty3QqMCVlwz?=
 =?us-ascii?Q?ApON9n9zcg1XVvCLMhr4rHu8+ngL1Do28uBg8rXhTLTwt2RBlEgm06tX/WS8?=
 =?us-ascii?Q?mAj+wYP1cgC3RthWOhKhP+HViQPrZ9IRUj8ENvK35tUVupVIpl6aPNhrt4nB?=
 =?us-ascii?Q?AyKeTPt1C8CMatQa6xYrd11pyu6KARXbvfMQP/5isjDU67DVIJ/sY+E8HjWa?=
 =?us-ascii?Q?4NGlL213p11F/IU/CSWsYTLuDXHFcdhjxrv20n4000PJRB63WMxFRQjmRR34?=
 =?us-ascii?Q?SxJ9/+l3AhvZ5j5946YzTnJYOrunQXTX6FcmwLaYlIshMMm+QLi2QmZxLsOe?=
 =?us-ascii?Q?z23ABbDip3f4BaZ8GruUeAgmLPPw71WAhGvtNzPjqwm5yc3P7mqvucmkt9Eo?=
 =?us-ascii?Q?sqX+wMzeHf4+Js41Kewbo23wZgyhpsRsOs3KCICC1HDypL819xqBYp3Y/wMM?=
 =?us-ascii?Q?8MAqO/Aef4I0P+MyUvsYzuyhegj2NJOIOOfPCE94aLcrwiHoKSORaEUPtd6N?=
 =?us-ascii?Q?7JRH6iyd5aw6X0x5b9BukPcCzHLz3iBT1bAslcwDnaXkaHEbY5kvH6pFdIiH?=
 =?us-ascii?Q?bw1EGGyDQ8NTyA1dAlCVXZlGFw+hQf9MbuiqGhVQUlnHFYijgiW9mLOGcv2n?=
 =?us-ascii?Q?LIYpjDuIwH1yrENMAt3gWeEUgLZaJusaGPwoUYPAQ1G32gHMbz+XqNUQEE5l?=
 =?us-ascii?Q?vkqrOkt1Lc9mh7r7pIeNjDN3wvv0Ui3/hMNH2w6ZgU1DPFhX9ARCmCRD6Xbz?=
 =?us-ascii?Q?MxY08yrHwXKj6eiZsE3YqExfaJT8aIr2ckxHKvEIIxFKjfi9iNrNtr5BWA3q?=
 =?us-ascii?Q?GN7YOEBaviIinNyVYjKKBEqthGGatZ562Dg6XfQnEKqDMiQrzzmLogaz2060?=
 =?us-ascii?Q?LCN20U8aG3zyJlGnV9tvXF06Ucfl2BW0gMcmXeoNNmfkJ/Ebe34qzr4Y3Qyq?=
 =?us-ascii?Q?P7+kxsC1EFfzEAEl5D3TFQX9XSWAqIfzg0970DmBYCxopuqD/U3y/fu8atqT?=
 =?us-ascii?Q?0qZxteBbdEGyDefOxAJf5MiuhjUxzfTE35+58cJ+6OceRBM0a92Yp4BdFZNs?=
 =?us-ascii?Q?OOEjnla4ygxHiYAXZnrRZLUO1fDD4CUhVpLmHO6w+M02x4KjkJ/zkKp+c26W?=
 =?us-ascii?Q?Ul1oYF8iu/KeGK/nfUaOP1NRt1QaGyp8SmP/pCqi2eYDL31N775UPjP4vyaJ?=
 =?us-ascii?Q?a3chRNUy7AN+kM80SyiQmNDXkWIVB+1Wjzez?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5791.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1b610f-c32d-4989-645f-08d99464f4d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2021 07:32:37.1291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mihail.Chindris@analog.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5297
X-Proofpoint-ORIG-GUID: zYwZCUJEuDmBVHqHRsR6XtbtbnOEunZQ
X-Proofpoint-GUID: zYwZCUJEuDmBVHqHRsR6XtbtbnOEunZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_02,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210035
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Copy unresolved comment from previous version

Mihail

> +patternProperties:
> +  "^channel@([0-1])$":
> +    type: object
> +    description: Configurations of the DAC Channels
> +    properties:
> +      reg:
> +          description: Channel number
> +          enum: [0, 1]
> +
> +      custom-output-range-config:
> > >=20
> > > Not a generic property so I think this needs an adi prefix. =20
> > > Jonathan
> >
> > I tried with adi prefix but I get weird errors while running dt_binding=
_check for properties with adi prefix and with type:object
> > Do you have any suggestion for this issues?
> >=20
> > Mihail
> >
@Rob

