Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758EF109E63
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2019 13:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfKZM4R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Nov 2019 07:56:17 -0500
Received: from mail-eopbgr1400139.outbound.protection.outlook.com ([40.107.140.139]:53634
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727629AbfKZM4R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Nov 2019 07:56:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0BAq2o4SJBeaMHgbBUIGfbKTUBPfUl5av+Nv+e4vMLgFSQH+VLzbFncuz6f0MXfBKNM19PI89iVdDN/uuBwntAHqlo7ldMTGfVURVI2oXUxpx2vznV0HMxN6ABrRWOXy+Hzx+W2yuNVamlU3hdbr65QuzuusIgsELCAk2ObbI8MD6ticjurMxNR//zQ2iB3YCj2Kthx+EIYEK/xD5q4QExi8gPtehMncca5iN8gqe3GwyB9qU3lz5iPGAPL3YTmCUjSKtXNP4V8D5TuBJbEYlK+D4yILgg3z/ZR8wJwjfGLJzRS8itx1NW43n9P6P9oEFwfmkqodj35R5CUUdIt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDYk+1pVTg84/81vTn2+v9CxRFy/ztH48GwzkV0uMvs=;
 b=btWETmklAQGIKxDRE6h90Fa9lAEwF5OSXUX+rBASfFgvNr7q6+vaKRGFwrd/ig0j2Feo/ykbZ2e1oVkoh2Dmt1DzGX3928grO8B8GoaYsex1J2+sNI7FFOMVP8+OFBWQoEJzKQUKXm25HOxdjO5l84bWL8Vvqw2hO+Xt5ySg+yMxvo50j1+xAxqYslevhdOFAY3RYAndwMXv4czJrBItqXxMvhDo56DUBWSSyx4PHcFcCh22x59sHbXeUjk4Q0qCKCtUwwD74+OmqvYbspwNbUpCsOx8GfWmb7tbLPS7UMKPUb5z+9UPcsZB7hqsJAqnfpZeZrUtwUJvmXgUHryUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDYk+1pVTg84/81vTn2+v9CxRFy/ztH48GwzkV0uMvs=;
 b=I8pGViO+FXtAoFmXikv4vwSUBv3MNK1IoYg4cQlZvmT/ZaMYjVmBdq9PmySZuCtIFcgKZkKwGbC9d3UrY4g8k4M0jS84xGDQ73QFdmcyF0Nf0CHeq7yBNyV1BIGY0ldWdScTSz/R1ceFge0HkrOc7NT3hhmnqXu/3D74NFwWGQs=
Received: from OSBPR01MB2326.jpnprd01.prod.outlook.com (52.134.253.79) by
 OSBPR01MB2981.jpnprd01.prod.outlook.com (52.134.252.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Tue, 26 Nov 2019 12:56:13 +0000
Received: from OSBPR01MB2326.jpnprd01.prod.outlook.com
 ([fe80::606c:7874:9df1:a3e]) by OSBPR01MB2326.jpnprd01.prod.outlook.com
 ([fe80::606c:7874:9df1:a3e%6]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 12:56:13 +0000
From:   Oezguen Guenyeli <oezguen.guenyeli.wg@renesas.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Problem about Read Multiple Raw Function
Thread-Topic: Problem about Read Multiple Raw Function
Thread-Index: AdWkWN/hMMX694G7T4ONkDzkjhDhTw==
Date:   Tue, 26 Nov 2019 12:56:11 +0000
Message-ID: <OSBPR01MB2326981343F90B11AB6CA23DB1450@OSBPR01MB2326.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oezguen.guenyeli.wg@renesas.com; 
x-originating-ip: [194.15.148.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a12d4e74-bf1b-4728-0641-08d77270048c
x-ms-traffictypediagnostic: OSBPR01MB2981:
x-microsoft-antispam-prvs: <OSBPR01MB2981ACA703715D7A43212BE8B1450@OSBPR01MB2981.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0233768B38
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(189003)(199004)(8936002)(186003)(478600001)(26005)(2351001)(102836004)(33656002)(6506007)(86362001)(3846002)(6116002)(66066001)(99286004)(81156014)(81166006)(2906002)(8676002)(7696005)(316002)(74316002)(5660300002)(52536014)(256004)(14454004)(4744005)(305945005)(7736002)(2501003)(66946007)(71200400001)(71190400001)(66476007)(66556008)(64756008)(66446008)(76116006)(6916009)(55016002)(9686003)(5640700003)(6436002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB2981;H:OSBPR01MB2326.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e59Vt1nmwjcSsFFxLMOTfWIBja43NPYXRDjor3uKKfLCfMhmddMvRaYOsKhrzdV9rJlCKhtDJslJ1y0NA1Ru/R/RHTTl+JO9ppkkFbJ2NfYH6CLLJNcHWPg1qX3OsQMamLgl71YG61uXK289czfkNMxV8R5ECZezFozR4B2n+OxAOIbYHR7PgUpGfI01gYRj9LT02e24kax+R1URsrenr3AxYxFXypBJA0Og0tXDtey5ogyH8Vm9aiRMfaustyIrArluAhmpqhgU54/ZcgkY2dNA/m7tF02/UnWBLhj1lxNld+KP6D8xZyYOKnfgxGKmk2UTrinL8gTxyaHq2nOtq+oIFX1+XKNRs4MOyQ3azu7j65wsXl373MbsVRp1Jshm1woYwfirYmKpdcsBmmU2cqGmuZev7W/vWCrHp8fihQUgqFiqIZHe8ZcHk2RBejzg
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12d4e74-bf1b-4728-0641-08d77270048c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2019 12:56:13.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xu4SqMSPArtat6AonbCkYdn9g9MfT2TkS2cal6e3DDH4tUHmJJvheaBdXq9H4akaQKUmZbyzIOm5TByW2ZaQcmrBJwTuXKyDNbRduufv8Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2981
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,=20
I am developing Linux iio driver for one sensor and sensor provides 15 meas=
urement samples that have to been sent the user-space for high level algori=
thm.=20
I can read data from dev/iio:device and I can apply high-level algorithm. H=
owever, I have problem about read_raw_multi function. Max_len pass value as=
 INDIO_MAX_RAW_ELEMENTS in iio_read_channel_info function that locates in i=
ndustrialio-core.c file and INDIO_MAX_RAW_ELEMENTS is defined 4 in iio.h fi=
le.
Is there any specific reason to define 4 ? Because in that way I cannot pas=
s 15 values to user space with read_raw_multi function.=20

Thanks,=20

=D6zg=FCn Kemal G=FCnyeli

