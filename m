Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49BF443E0A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 09:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhKCIMC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 04:12:02 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:44066 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229504AbhKCIMB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Nov 2021 04:12:01 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A2Lq2p6003834;
        Wed, 3 Nov 2021 04:09:23 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3c3dmg9sfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Nov 2021 04:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lyiaii2l4SeqDQ7OlT5/2VTeEiFPDqvG7UMT+qFDLsTsN+WozFoXDA6fbA/zpuKUeJwL6rYL4KHj+PI8zlZtpg/TjJCvYgTU0evk53NKuP7HUZTmOpGu5ERnILDUgS9HRiYfoQJd1VfPGaqARXZ3Abi4KgKnNozodNq0szt6rRTfLu9FrTwXXU7u8rny4nradpATmpP4kY6M6AQxnWQOWMKYHjMcMfHvC80qtWnOUxreacec68Zn6As0dy2vr+8jb51mw2/dOpfyasdU5N/EB5EDAlPLJMOalPO+7AktfaLbx0di8YmF0CzC0ckaQ2SfuHDxI6T4aX5Nrt+7KddZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghnJkLPueUY5c69urIIuuobZQFW31ez9lt+LQrYnA00=;
 b=fIhIl2pgvD+Tugb1bUg0z5o2rpiolQ+9qk+mbs02PsbEZDfhntQCj1oQD6mlpDzccUqj213knbmOo59qov0j+AMkr+MZH62julO6VEXqO//jCj1PXqkxY9E3cVeL9IzcTX0BkManSKR5Wt5vkEHb0lH3cfZQwykss2zHjMrltCCjnupPhBZ6EAOtKiqW++ELc76WZBUDU4iGQdUCif5f1CVhEt1WZzXBt365vhGriMJdupr5FcszLZqF6zIohGtdPBIFCQhil+vLles9sztl9Q6kntoYcBX4OxTIeq6QvtxbdNfbNMiVnJ+4gR4yhTBS814zlm4WFQcPh+E8h1nxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghnJkLPueUY5c69urIIuuobZQFW31ez9lt+LQrYnA00=;
 b=5M+NtvXsdFJxBCzddpEabsfsj5GT15F8c2F8joDSkmCpg22QNWrbnQNcfd2qiAXxj+Vc7TJiviHFiCNM6Od49eu/FUtxYA8FzQL1x0nYALqIRt8jrRYhiAZucELGMKHHiTJLR2fekNA0HuYJcVFd2zHc/B292snzDKkTB7eg/Fw=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY4PR03MB2885.namprd03.prod.outlook.com (2603:10b6:903:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Wed, 3 Nov
 2021 08:09:21 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::b5b1:cee4:fcd:5ea0%3]) with mapi id 15.20.4649.019; Wed, 3 Nov 2021
 08:09:20 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: RE: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
Thread-Topic: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
Thread-Index: AQHXzwfj21y5Dnr/k0eZeDeswgk2M6vwhjwAgADvSCA=
Date:   Wed, 3 Nov 2021 08:09:20 +0000
Message-ID: <CY4PR03MB3399E5DC1D8A966C7CFC8C049B8C9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
 <20211101100420.70304-2-antoniu.miclaus@analog.com>
 <YYF6cPSDroPz/wun@robh.at.kernel.org>
In-Reply-To: <YYF6cPSDroPz/wun@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy01NmM5ZmI0ZS0zYzdkLTExZWMtYWJlNC?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcNTZjOWZiNTAtM2M3ZC0xMWVjLWFi?=
 =?iso-8859-2?Q?ZTQtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSI0NjIyIiB0PSIxMzI4MD?=
 =?iso-8859-2?Q?QwMDU1NzY3MTk0MjYiIGg9InlHOTNiQ0dNNWY4UXF5bWl5MC9TdDZRZUpz?=
 =?iso-8859-2?Q?OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQkNQQ1laaXREWEFiV09kVmx6UjhhUHRZNTFXWE5IeG84?=
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
x-ms-office365-filtering-correlation-id: f85b67e4-2e0f-41c7-6ddf-08d99ea13d7b
x-ms-traffictypediagnostic: CY4PR03MB2885:
x-microsoft-antispam-prvs: <CY4PR03MB2885B06B5842ED55C0CB42119B8C9@CY4PR03MB2885.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zS1J6Op2JA02sDx/M7DGnVVKfZXgXxHE0MhpIWGKsf32QNxJMhOj52s1qGjaxsrlRHWxJCmq2kqsowaZgL5UzHOpAbzKE1Vv1yaysH7cKjiTT1qhk3gcuWQpFCkWjXwDtpsm6VmFEPuVymflGV4vbP4Qk9Zyc/4fyiOo1yVlMDbnm29FcCqKqjlck2ijJZUgvy8E5fxmtLnNhbWH0aF4BF8JarAFWfbucbByul8BXSZIU2hzs9gijcPt0UC4CiA1Q9j6sRY6PbrMktJuvbLRW28PFSDt6jKwTiZvvE5VS0EzmjfR3vuwQQy1OsIdZQE9tqiI0uW4i2FF7OiNW8QrSw5EU592EuXJhSBmZabk5InwGLDdCaWAodViY0i7ivLCwHtXzxSCe0KAL0VgH5O05zWdQ6E8vqGhvNalXj35z5BkFSuNeE5rszbz/yN/t0R8Apb3Zte/PrtPWmnKBArPz+xoB3ndmqbHzvuDHUIzB5SO9xMfn4M45y0I0v+STdUyDhgTilu9WWM3McZAu2acVl7M+lv7j/NbK2MpRApZY19Y/aweYdSWPF/hGlSSY5Iv0Vbg0RTFtfSgZnwJojxu/dgLWvLnPqVDhucKlvzKxMC5Wrjbo/C1Xji45wUZ3yRk0TfyrDi9aFF2E0utkp1IA2NLSKHoZ5XpQBXr3fRmutMVPLd9NZFMdai03bg0HdX6x3MBinUOnj1dLoQNkuvj3T+5GF1udeRZbHb7jJ9pevuHeZFVJD5gUL8YBf4Tr3qrCB9s2ZQUyfglPIzLh1QSw9wyEQquxRyULkIe0Fq6K0/d4gGl5z2UYGrOXT+uzPFsIV33dNXmKCt2O3YRfIWKsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66574015)(38070700005)(26005)(966005)(107886003)(52536014)(6916009)(8676002)(2906002)(508600001)(316002)(186003)(33656002)(71200400001)(8936002)(38100700002)(66476007)(66446008)(66556008)(86362001)(76116006)(5660300002)(122000001)(66946007)(64756008)(6506007)(4326008)(55016002)(9686003)(7696005)(83380400001)(53546011)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?bE3cdQgsZSM4GIDt+uEEJ8uG+tuiTHKDbZ/QUiUH5AZ3lVfwx44TvtGEX3?=
 =?iso-8859-2?Q?d5u4A/gz3quxu0DPBYASSyxZQ4JpbKkwjmeA+aaWdejEA6tTXh4gXsdoc9?=
 =?iso-8859-2?Q?HIzGEWUNg0gER6KvCZxzi/IrZ55uAOXjJLf3w8m3RTOQOqi+o0BtA8fr2j?=
 =?iso-8859-2?Q?mo3tvLAiTbzbVBw+L/K/PRgYRZRWqiVGZJm+6SXTmDKrmOx9tThIPd5sjQ?=
 =?iso-8859-2?Q?S+0k1/7CM9Rlp9yd/FOx3lR7sDafTdifMQBPfLgfW/jnPia0j8PWh+qGj5?=
 =?iso-8859-2?Q?ez/gyV6GvjbpcoLiAUUnfMbHJExsu/q/f0gg6LL6P0Gjc3gr/p0fk/TWAU?=
 =?iso-8859-2?Q?eqkUYkyog40NTMmHUgIwMcA3d4bE67cun5g+KYLMtHQVp5Sk5uJMA3VRQx?=
 =?iso-8859-2?Q?bS4fe3bq1pT1kdyJC5Jo0qR5UIjDf+itdA0cFskTCg4SxQ7AiiCZhwwPX9?=
 =?iso-8859-2?Q?Gx6YVJHgwIjTFktHq22VqWBVyWgBvG9Hew5yQq8BTjDRZHq6ZNjIsx/JX3?=
 =?iso-8859-2?Q?3d747Y/WE/EWwd8FcEKxyaDh07pMbRfKhlUwvXXodl9fZJqra6m8ii+Axu?=
 =?iso-8859-2?Q?yPGQ8kEblapY3cOx2bnLENFrhn7Qd1uuXE5q4T02aq6LEQ0hSE8GhTnBII?=
 =?iso-8859-2?Q?OFk3nsCxEB4xGx+eS6UJfvhuSZtgaMGQDqZQuMn1oCNyopZ8j8XQdt3QRt?=
 =?iso-8859-2?Q?jxWDfLIANDG65nvlczV16OWKHF726k1TZ+Wb3IUSt1SDxsNW1DgU++3ckG?=
 =?iso-8859-2?Q?wybyfQTeig+kZDi3zGfwme9e/aDO1u/SewInZ0gjO0HTcVWumBkTlPWB32?=
 =?iso-8859-2?Q?k+/Ka2gV1S8Kq/AoFIjDhHRVpK2nKOr41tJEvS5Z/9zMSP2Hohrbn1zIHG?=
 =?iso-8859-2?Q?Vggk2tEbEekebKN//RWNQ23a4+q8Cc9+rWmvKTMYLKsdMSXTKE9VTw7cd4?=
 =?iso-8859-2?Q?huMBByuiR0iO9uaT+P7Jatdh4hjV5JlfG9ZbG0Cm5ERS5GSsWFl4B5wDaX?=
 =?iso-8859-2?Q?qdQTO6vXvKAYY22IsvXc+LozeJXbxGWJGysBCXYOhEYrBjuDy9k0DASAfy?=
 =?iso-8859-2?Q?hFwQXPxH12HjPeQ7zxjZvQnbiE5Wb+mbL3nU3I0sX6nIQ0H08UyNtDuxTN?=
 =?iso-8859-2?Q?FKnfItkEh0i/hFTE2wVP4IM8R7/wMNEy6aiAGNUo6WJRD+idO1NPkuaUAB?=
 =?iso-8859-2?Q?+zAawnnht28Q2+6Kf0zo2pY+K+OlzOgEOw8Oge9MTbSJhe2w8DYe+gp3Zj?=
 =?iso-8859-2?Q?auP+eVB3JCgI3IUGsdBbJi3sQNdsdF+ypDMraKkPp3MDnqCQZzFaaE1bBU?=
 =?iso-8859-2?Q?FEWCFT1qKbp3Rt6llv1iH/RcS9Q/GdANh5aNxfzAmudpQeTQMqIzGFBZFr?=
 =?iso-8859-2?Q?HcAc4P4NSRrQRdlXjNW17rn9P+4PwvO/qwHu81Wd6IjiP4/lInH+T2Z6/0?=
 =?iso-8859-2?Q?EH6njOSd78t+b0vrrIW7iWnFzA3NB3TeFYTFrIVBTRk3Ae8T5Z63pGkCrt?=
 =?iso-8859-2?Q?6FwoqqVFnwPa+aN2WEH4rIZUOD+jTV6nahc5eOatV2uUC4OJZ+Zdu3YD4i?=
 =?iso-8859-2?Q?W38nfhXG/0yoUHHJ5SvnJtmE8l7GYPhBvRCyWDtxPaP48SJB1cDuumD+9v?=
 =?iso-8859-2?Q?59kdyc7bCjNkYiVfnZu1y0P0s3GIo5r2sZWqEKuqG5Y8eVeEfAyn0Kc8Jf?=
 =?iso-8859-2?Q?MpokjMN+8l0Sic74/Xb4LpToWj8ynxvKXk2chmLIDg1Zq3KX/Guhsp+bz6?=
 =?iso-8859-2?Q?WsNw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85b67e4-2e0f-41c7-6ddf-08d99ea13d7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 08:09:20.6009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EPikJnTgBLYVCTTPSWwtKwCBz7W95K6T2g8XXpUf0xI+AUbG2UzqghBGp9bSSZXCLEa1QBMTDMZ7V9rXNuU0+9pKc3Rp2Og45imTgCXzEJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2885
X-Proofpoint-GUID: GvlCdTMym0HxP5GdqzuitKLDDGaPGitI
X-Proofpoint-ORIG-GUID: GvlCdTMym0HxP5GdqzuitKLDDGaPGitI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_02,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030049
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Rob,

These properties are fixed and available in the datasheet (binary format):
https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV101=
3.pdf

Please see Page 37 of 39, Table 15, QUAD_SE_MODE.

Regards,
--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, November 2, 2021 7:51 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: jic23@kernel.org; linux-iio@vger.kernel.org; devicetree@vger.kernel.o=
rg;
> linux-kernel@vger.kernel.org; Sa, Nuno <Nuno.Sa@analog.com>
> Subject: Re: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
>=20
> [External]
>=20
> On Mon, Nov 01, 2021 at 12:04:20PM +0200, Antoniu Miclaus wrote:
> > Add device tree bindings for the ADMV1013 Upconverter.
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> >  .../bindings/iio/frequency/adi,admv1013.yaml  | 119
> ++++++++++++++++++
> >  1 file changed, 119 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> >
> > diff --git
> a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > new file mode 100644
> > index 000000000000..47993253a586
> > --- /dev/null
> > +++
> b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
> > @@ -0,0 +1,119 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> https://urldefense.com/v3/__http://devicetree.org/schemas/iio/frequency
> /adi,admv1013.yaml*__;Iw!!A3Ni8CS0y2Y!uTDPalOgj6YS_vZ6bsDSbA_Qna6Q
> OwMpoRxzo6nn06i5TNuGWZEk9PvtbC6SKQGXrugy$
> > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!uTDPalOgj6YS_vZ6bsDSbA_Qna6Q
> OwMpoRxzo6nn06i5TNuGWZEk9PvtbC6SKYugV1fM$
> > +
> > +title: ADMV1013 Microwave Upconverter
> > +
> > +maintainers:
> > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +description: |
> > +   Wideband, microwave upconverter optimized for point to point
> microwave
> > +   radio designs operating in the 24 GHz to 44 GHz frequency range.
> > +
> > +   https://www.analog.com/en/products/admv1013.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,admv1013
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 1000000
> > +
> > +  clocks:
> > +    description:
> > +      Definition of the external clock.
> > +    minItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: lo_in
> > +
> > +  clock-output-names:
> > +    maxItems: 1
> > +
> > +  vcm-supply:
> > +    description:
> > +      Analog voltage regulator.
> > +
> > +  adi,vga-powerdown:
> > +    description:
> > +      Power Down the Voltage Gain Amplifier Circuit available at
> > +      BG_RBIAS2 pin.
> > +    type: boolean
> > +
> > +  adi,mixer-powerdown:
> > +    description:
> > +      Power Down the Mixer Circuit. Enable to put the block in
> > +      a power down state.
> > +    type: boolean
> > +
> > +  adi,quad-powerdown:
> > +    description:
> > +      Power Down the Quadrupler. Enable to put the block in
> > +      a power down state.
> > +    type: boolean
> > +
> > +  adi,bg-powerdown:
> > +    description:
> > +      Power Down the Transmitter Band Gap. Enable to put the part in
> > +      a power down state.
> > +    type: boolean
> > +
> > +  adi,mixer-if-enable:
> > +    description:
> > +      Enable the Intermediate Frequency Mode. Either IF Mode or I/Q Mo=
de
> > +      can be enabled at a time.
> > +    type: boolean
> > +
> > +  adi,detector-enable:
> > +    description:
> > +      Enable the Envelope Detector available at output pins VENV_P and
> > +      VENV_N. Disable to reduce power consumption.
> > +    type: boolean
> > +
> > +  adi,quad-se-mode:
> > +    description:
> > +      Switch the LO path from differential to single-ended operation.
> > +      Set value 6 for Single-Ended Mode, Negative Side Disabled.
> > +      Set value 9 for Single-Ended Mode, Positive Side Disabled.
> > +      Set value 12 for Differential Mode.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [6, 9, 12]
>=20
> All these vendor properties are fixed based on the board design or
> something a user may want to change? The latter does not belong in DT.
>=20
> Rob
