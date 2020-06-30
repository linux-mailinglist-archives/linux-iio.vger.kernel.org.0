Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4D20ECB4
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jun 2020 06:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgF3EiJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jun 2020 00:38:09 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:3004 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgF3EiI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jun 2020 00:38:08 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05U4aijE016870;
        Tue, 30 Jun 2020 00:37:55 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-00128a01.pphosted.com with ESMTP id 31x2r6xyf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 00:37:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ysr6W1YNj9CD1ugDgOeHxLRJptz++dvm/7WVjL5tJIerEINcUNKLNETUMNDPU8qLDSe9iM5RvNTrtzB0CJXdXkg1HjwZa67aQOcZ5eyG5jEPZ71IdP2OH2T63ZsmFgqZmnkf8Ux+dHKDBjYC3qriDzn1MTkpVo/fbWuPrAxKZQ0XVKIDuhc07hLhJa8ywFHz1qPBij9VCN792x1TzAuizS46tniGYjMPHjLjh3jYyjELWsr+ILAknVE2ONrrWvcqGdut7pNnHblkSdgz3h30i3suGFbt5ZZlfod8kynSwX89m2gGuOaoRPq+JggHzONbDhDA1L30XJy9gKLEjOJbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlWdUtU4bV0P7XNWQjGt8cz/TCY79OKsNyDMh7xtMkM=;
 b=WOGRCHgYvfJaCNJZPompvLQJy7QuT0CT9mpcsTiMUfL+z2pQba8NPu9uPaHhlggKnpb4zmMZTxhepmglR2QDfhys+QC/Bw3Fu5xM3bNOd5kFtVK1uDEExEAF9kGznzBjJv+bTTB2mhbRZDXarVa3KmWj01styhC54kRZ4sdBHuREBbYdLuGMfyDFkMIzj8J7Fj/T489KuG7R/S9Ns47hAN7XdGRUceo3uj50ceZhM/hUeV3LDKaFskyusZcHNApBZv8iQEC0eFeL9kiS/tnTsDXWx4PLOcZ+ftbkekx7hEZdM7xfDItiJT/hyt7AxjgFd1BolKUPNKErS1n/wKY+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlWdUtU4bV0P7XNWQjGt8cz/TCY79OKsNyDMh7xtMkM=;
 b=Sxjlo7PdYBS0VCNkCYNg/Nop0tbw7BqyHEySup1ROqIGvGV2CZmmnbTtWfhKkC0M+rUY4TbvPjt/wXXyfrE4Q1Nme/dKV+8RETVgRh2AkArxmS2fJtVGZr08Yj6lDiLgvpCahwThj5swQTq+/WM8cZs0Dvfdj9LR1001xdCO/T4=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB4330.namprd03.prod.outlook.com (2603:10b6:5:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 04:37:54 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::e02f:b3c0:d1e9:5eaf%3]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 04:37:54 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Interest in a virtual IIO microconf?
Thread-Topic: Interest in a virtual IIO microconf?
Thread-Index: AQHWTUi5NeHTYGZI2kOCtldhjXH/vKjvnlKAgABX04CAAJ+3AA==
Date:   Tue, 30 Jun 2020 04:37:53 +0000
Message-ID: <788c121ebdef6ee3732b2ad5a3f7280e3c344638.camel@analog.com>
References: <20200628133607.61d31ed1@archlinux>
         <2fd40a0d341cbe7dded2fa9b2f53b4f87b1a2ab8.camel@analog.com>
         <d7124f0b-99cb-0213-329d-dbade7d5a56d@metafoo.de>
In-Reply-To: <d7124f0b-99cb-0213-329d-dbade7d5a56d@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e38fecb-3e41-4c21-0225-08d81caf5ac6
x-ms-traffictypediagnostic: DM6PR03MB4330:
x-microsoft-antispam-prvs: <DM6PR03MB433054CC5EE141C8E3B84CDEF96F0@DM6PR03MB4330.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8enmyFrt3H4CvUyYJNIuCUAXS0+7FnpShIooWCTuGPqmGwFsKpHzjlX/VTIv3HxWobx6m/7SdE3e28nKHYuUewadJ9pvSZkQb2vCqDZnehW1dIYp8ebPEhObeVBQz8t2nPJPA0n0Q3rSyAL6NRjofOIDW6e5JHi0rBCRFrDF9/3vghCrkLFpUmid/MZqcXzJqUWeBo5frb6Tz2eDjsnOV2PH5hgZKYlDz3E7IxM9x//PP+c8tnS5yQEq6XrP4gkGLGuECwD62u/vqTxHbVpWYB/XlAjCcEmnvAY+xREJN9M8ppsmJUztbaY1UkxuriaGNvNINQ3B7gxgoE3PbdgT2rfIpcbnQLN4jYAvTIR+D5o254l5Ul/T9A/KqAwJJE76Wd/3+oMOJX5Ksb5/33mvTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(4744005)(316002)(110136005)(71200400001)(86362001)(36756003)(5660300002)(6512007)(6506007)(53546011)(6486002)(26005)(76116006)(66556008)(64756008)(66446008)(91956017)(2906002)(186003)(2616005)(8676002)(966005)(66476007)(8936002)(66946007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LUtU6rnD9Qd5lE9UHHGl//FOmymhfPmeSObLvwERSqfECTqnGqpFOaNC126/cM70QC//fX2cFiyLmKk22OBm1TpyKTPll2zG2RnLbJIEBDxE4Jw2P5a0T2Htx2VJFHRUlyH6aV35hF3nxaWJjP0k4gPD5/Pg09rz6ZpoSYLkjpxMy+jjIot92jVeWUgkJc+vyp0yhxjCHNrBP+5n8fHc7Pq72HTuMmtNN96jt+s8EkpwnCSv92O9BDAtG0rPHRpYq4ZeiWTrEyyJdBYdqp0WLjwtMmnIW/Uhb2HU7Nd+vId91TKUh4xwykk5FkgwJpLOXdjx4RuPK3OGGnJs1uWlKmiNS+hNTQa36Q8y5P+WDxxeNaBhW8tL6+TvazY3gpdtVeBeAjFo3ANBcuwptwqxPhA4fG5riIBF4q7Nq4QMWfxdo/dBWjjl90p4gz2KcAzZzaXH18klFqrbADNh0JQQjBRrgGbOCJSDQJqaDFD/0X8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBBFA7A79ACF504390C055F188280BF0@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e38fecb-3e41-4c21-0225-08d81caf5ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 04:37:53.9566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qz3E9nnlhVFowLel5PKwMVEHFit6R0QahLJA5rT57iQ+N3AxZRoCKt3Gh+i8h6dsc8O3qD+H0SqQZl8CRRGe6ACWWpT7ZQ4mg2I3xV2JSvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4330
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=855
 cotscore=-2147483648 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300033
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDIxOjA2ICswMjAwLCBMYXJzLVBldGVyIENsYXVzZW4gd3Jv
dGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IE9uIDYvMjkvMjAgMzo1MSBQTSwgQXJkZWxlYW4sIEFs
ZXhhbmRydSB3cm90ZToNCj4gPiBUaGVyZSdzIGFsc28gYW4gaW50ZXJuYWwgaWRlYSB3ZSBoYWQs
IHdoZXJlIHdlIGNhbiBleHRlbmQgdGhlIElJTyBkdW1teQ0KPiA+IGRyaXZlciBbb3IgY3JlYXRl
IGEgbmV3IG9uZV0sIHRvIGxvYWQgZGF0YSBhbmQgcmVhZC1iYWNrIFthcyBhIHJlcGxheQ0KPiA+
IGZvcg0KPiA+IHVzZXJzcGFjZV0uDQo+ID4gV2UgbmV2ZXIgZ290IHRvIGRvIGl0LCBidXQgd291
bGQgYmUgY3VyaW9zIG9mIG90aGVyIGRpZC4NCj4gDQo+IExpa2UgdGhpcz8NCj4gDQo+IGh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1Yi5jb20vbGFyc2NsYXVzZW4vbGlu
dXgvYmxvYi9paW8taGlnaC1zcGVlZC00LjE5L2RyaXZlcnMvaWlvL2R1bW15L2lpb192aXJ0dWFs
X2RtYV9sb29wYmFjay5jX187ISFBM05pOENTMHkyWSFwZzlIWTVzRlJuc25yT2h5cE5aYXdxV1ot
dVhiOHNSVTlBZURzQk12Tmd0RkozVVgxVFJmMzRSaGlIRllsbWFXY3c1bGpRJCANCj4gDQoNCnll
cw0KbG9va3MgaW50ZXJlc3RpbmcNCmZvciBhIHNob3J0IHdoaWxlIGkgd29uZGVyIGlmIGkgbWlz
c2VkIGl0LCB0aGVuIGZvdW5kIGkgZGlkbid0DQppJ2xsIGFkbWl0IG15IGluaXRpYWwgdGhvdWdo
dCB3YXMgYSBiaXQgc2ltcGxlciwgYnV0IHRoaXMgbG9va3MgYmV0dGVyDQo=
