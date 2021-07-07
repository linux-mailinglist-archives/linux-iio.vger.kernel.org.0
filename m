Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020983BE6EB
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 13:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhGGLOH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 07:14:07 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:27458 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbhGGLOH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 07:14:07 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167B6hSl008758;
        Wed, 7 Jul 2021 07:11:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 39masxdu4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 07:11:25 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 167B8ajv012010;
        Wed, 7 Jul 2021 07:11:24 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 39masxdu4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 07:11:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxkzYwFdr71RkM+roIEg8qvwPM6QieDLyGw7hwhjTufZfOrpXTKOs7TgzzDBKcUNZB93sz2r4wFDq2/wygCqmjN5R14b/9PvE0v543A26CWNbotyK7Xxx8rok72SRR0xzLFU5HTmk77CvscB08q2mqdydvNPoqmDs6Tz9CTOKJnKiz0mHVFt+BNtqB5RDTQCAkDyFXCbw/QK/mnG8pTYKAkSITXHAJpLq897dJ8f8j90mMzzQjwGmIvJSpNMvpSgP1tN6emES5G1+31y4gvWxSVqgnJYkg3PjJqW8y/rzFDkmUg34RFx2ag0vzVqbaQ2JQc/zFo4PdR7mMtkWC4L8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zkWWYAxDb4B2So6Ljf8HqU7S160hQCtHPEt7CHtT8E=;
 b=AeBfiyLA/3bOnBU/azleoBS4QSAfuuGaZZUq2rRWLz2JleHV7OYABEFxwEy+WF+r7iPcW1IXXyjK3xOCgrUyNYO5QFq2K+21q5/S9ZRzaLngiIRJOzm62l6al/nhGVzg+1knK6tGcHanwF27rOOs8Gu4XjrSrocZvI577mGgZkankfnfBcLFH643UZlCM9fCvelzxxTdFGvEJKO35x2rL2YDmTou39u6wg2QBbKilTUj8o7XT/Ht8Qc0CZWvUCkn4NNSD/8hQFEUj7tose8MP1fjusORJQ+BTz8nlZuQdE4B/GGrQHru3OhfQrJUKnMfuQk5W2tWJPk7voJAU7t28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zkWWYAxDb4B2So6Ljf8HqU7S160hQCtHPEt7CHtT8E=;
 b=OjOQLXF1NXRF45mzvNfPk5HYz92dVnRRfhobSS7eVMsXzv2uk1cfhRRvv+pKRRkrRmi/4+n8Wlq2xpZ31aGm0zhB5HEzLUQTamxO75h2435Uu07DLs20/o1456x6OrNR+DJ1iHtT4fsIRjoxRo4KVBc/YmzimXJWRHsOK6zAv/w=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5912.namprd03.prod.outlook.com (2603:10b6:510:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 11:11:21 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Wed, 7 Jul 2021
 11:11:21 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v4 1/2] iio: frequency: adrf6780: add support for ADRF6780
Thread-Topic: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Thread-Index: AQHXbzN7IY9R84leFkqsPFMOIAAoUasxeo0AgAKyeUCAAYBQgIAAFNGggAFwxKCAAAqhgIAAH07A
Date:   Wed, 7 Jul 2021 11:11:20 +0000
Message-ID: <PH0PR03MB63667F415CDC1003CC3BFC77991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210702111239.174189-1-antoniu.miclaus@analog.com>
        <20210703175716.7864358a@jic23-huawei>
        <PH0PR03MB63667CCA2691D4A43F28041E991C9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20210706100405.00001507@Huawei.com>
        <PH0PR03MB6366190FBDC12B1AD1CCBC43991B9@PH0PR03MB6366.namprd03.prod.outlook.com>
        <PH0PR03MB6366BC5E806B18A8889EDDE9991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210707095629.00004bb8@Huawei.com>
In-Reply-To: <20210707095629.00004bb8@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMGNkZTViYzktZGYxNC0xMWViLThiNmYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDBjZGU1YmNhLWRmMTQtMTFlYi04YjZmLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjA3MTEiIHQ9IjEzMjcwMTI5OD?=
 =?iso-8859-1?Q?c4NzgwMTg0MyIgaD0idGNucFlYN0lhbm8xSGxQd2xMUmFrZG9SN3ZJPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBSVlEQUFEejJuclBJSFBYQWFxTGszUElyalpEcW91VGM4aXVOa01GQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQVdBd0FBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUVBQVFBQkFBQUFCT1lHY2dBQUFBQUFBQUFBQUFBQUFK?=
 =?iso-8859-1?Q?NEFBQUJoQUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYW?=
 =?iso-8859-1?Q?dCbEFHTUFkQUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBB?=
 =?iso-8859-1?Q?R2tBZGdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRU?=
 =?iso-8859-1?Q?FaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdC?=
 =?iso-8859-1?Q?MEFITUFYd0IwQUdrQVpRQnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FY?=
 =?iso-8859-1?Q?d0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBY3dCZk?=
 =?iso-8859-1?Q?FIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmhBSElBYVFCaEFGOEFaQU?=
 =?iso-8859-1?Q?JwQUdNQWRBQnBBRzhBYmdCaEFISUFlUUJmQUhRQWFRQmxBSElBTVFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQWNnQnBBR0VBWHdCa0FHa0FZd0Iw?=
 =?iso-8859-1?Q?QUdrQWJ3QnVBR0VBY2dCNUFGOEFkQUJwQUdVQWNnQXlBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7bd1d6f-ed66-46d1-9d33-08d94137f345
x-ms-traffictypediagnostic: PH0PR03MB5912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB5912A6F9C5647D3B6AD3161C991A9@PH0PR03MB5912.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ekEqkS0/3DHwj1kAotWesaixrYa8FSftC7ZALa8sys0XodZQLM9DNsT/Rzpkk4BstIlAAPRLkJIFNdCQ5Lplb4rQdSiiIS6/85xq4Jk9v3UtdIe5mR8FcD/WKYhjyfWC+zi7H+ZbDU+QFc2/tqvAj1e6hND+hEIBUfoGmAKfX0Ps2t4mT+iKg6Ydc7cVBajqXf0Y923XduY5HENvPjbiLosspcFiLe4ysioTnFx4+b2eIKcdrLpkeGdDYh8VKiGyTrAIhdk/XhWKThs8hpYVwbWIbcokHIvA3OoNV73cpIKjeCxU8FcLDYJ4yUEyxFwki+2sfkMG2VZ/DDsLpvshDjV8Z8tC5hfbRnHsQBML1ji1NGMldeWKcKJBUlzEvylj1XtAh0qvDLUY/1snm0R29AJ5SBDzPlh4nhcI+HVKEZY/qWCE+aLSKNv2slKXTRyHZltxae0MG7rD3tzJqZtNKyZ4McXAk+5y9YG6vjwy/4Gi0b4qONvPdYuz0fNSnf/S4dchMMeOA8SaZSRUnLUj/DHNE3Vhgyb1dNdCmfy3WOM6FXiEl7MFltXcIC+eVj5bvx7Mh5BQfmS1fVAfxSEp5v0Bys78wxM3rJUFOwWWknfyQpn86qhbYsxb3wmRK/pc5cKtQa0gg4XfjjHnV21Y2/qsSkKXnbAinooM/xl1/owsrv+4kagdMw/f6bDpsS/EzTkQ8n0R5EStaBNsX70g1pDwyyEv2yEUE+Q2vFSyPs4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(83380400001)(478600001)(54906003)(38100700002)(2906002)(9686003)(64756008)(8936002)(86362001)(66556008)(966005)(55016002)(66446008)(76116006)(316002)(122000001)(4326008)(66946007)(33656002)(66476007)(53546011)(8676002)(5660300002)(186003)(71200400001)(6916009)(30864003)(7696005)(52536014)(6506007)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Uwshei2xIGaKHdiLvvtJIyBt6SbFaEjkE1Yu9MeJ3bsm1ZSPODylL6maaB?=
 =?iso-8859-1?Q?k6uKy9jM/sL4YxZGR1VMqSbuwfY9HL0N99mAewZouMSUp+j0kxiDPCgoQP?=
 =?iso-8859-1?Q?hobd/JgsPwHCdtl7LtPnBYhc/bsq+FJEUpUxjWoQ0BbrRXPU7nKMQ1wyKB?=
 =?iso-8859-1?Q?3PPNAkYnDSaXks4z5tsSDOSxyMRuO4hMxKdXWVV2y0f5hw8LCmItFEnWTv?=
 =?iso-8859-1?Q?6F18j03ayDTY0QLqc6C3T6oMShAnryAldAWeM4lalACB75T2rFRWZv4Cmz?=
 =?iso-8859-1?Q?vwbAEEhw/qmv+wUhcw4Xv51QgGcHT3Jsr7lhMBS0XvTGDQ1tD1SqJeGO9o?=
 =?iso-8859-1?Q?lKjTbaQwZwFOJCSncTcqrO6iYIGleRs26nEOwtIBbevt9vMy8WQMs8gxBQ?=
 =?iso-8859-1?Q?mYdxrocoHFmuXWYOZe6C5YgrswTa+I77+W/WdL5I/Ycso4xsOY2fCE6cHE?=
 =?iso-8859-1?Q?Ab3cV5KSV2rkiR8uR2eSm4A1A2G7RpGH4LKgyPVgmcELPVb+ASKXzhAHjZ?=
 =?iso-8859-1?Q?YKZyfxBYgnM5/T50hBDlslieSpJOtM2wgBRf8ktjDfQOka5xeQapAKtqEJ?=
 =?iso-8859-1?Q?izyK6DrHy+H5bMnUnvF6nUJtY9p57BUP41iXfsvqF9bY6Kh5KnVal5y2FS?=
 =?iso-8859-1?Q?XHAakDboEyR2KEqo8S972x6TqfLBDYrFKOOp7z1GfiUJzc8zoOw0K6Bqif?=
 =?iso-8859-1?Q?PtEkd4DUvrkCJGBuofjRPwy8XC1F41Jc5yXEGapIwUk2Zf8LTBSWD9PnPx?=
 =?iso-8859-1?Q?RaK8TGaQk6EkViOLgYG4cbewceZFZpxss5Swc+IY7RZJtVatDUktYksqDC?=
 =?iso-8859-1?Q?n2qmsyqO8wgJ05fRBQIRF8K6KgW0NxPlJkv1kPRECBsZ8KeCu4Ss2+WJdu?=
 =?iso-8859-1?Q?dG3NwUK8y3oaTv6kI8LyBltINOBwF1Ut+vHiNg5G9mJIV7SafbkcFNuxTd?=
 =?iso-8859-1?Q?JDQ9At4YsFMOQXoU7sOIfhaXRxYZra0Tjpz2j2PxpdwI4SZZMDozMsw11K?=
 =?iso-8859-1?Q?F0J0pRV9meeeRG6zwE+DlVzXvh4rXLg9y9rYc819RZcQf0mdgkPFlqWKRk?=
 =?iso-8859-1?Q?SE9RUlwC9b3o0cziVodW0oW4XmKohbdDRVsF2cDCD4janLQoXvNv1chaQ7?=
 =?iso-8859-1?Q?4Na3OKrt/AHnZTjNEHjfI/auptGe5TI1+wnvzHUdKmqSDyF0akVRqOaGhO?=
 =?iso-8859-1?Q?XLL7ZYEXdHLh5QnUTNeSwtjXrgO8R0Bn9njJp0XScsp5HshJcemPcKbQyf?=
 =?iso-8859-1?Q?4I06xBqPAJeWPCuW1OcUHBVeYZ1ke5msyMgB4CelaAAvP7YGT2n8SKMsQS?=
 =?iso-8859-1?Q?n60mFD2qNwdBfP6qfmdWDKVcAEbDVA9AB/qKOSicdfTmVcdAffOWqsXEG7?=
 =?iso-8859-1?Q?j4brti7e9qDy3ppV0hu/PpoNOMcLMXPG6dBHDp6VmAXywwmSPwJ6SaFinW?=
 =?iso-8859-1?Q?SR65be9zhS2uDccw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bd1d6f-ed66-46d1-9d33-08d94137f345
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 11:11:20.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aek0qZAvGvxMXrna+cmzjiYNuJCUOKttTrk/dJMPN6WEenM61WYlYCC5JfaGusjeR7bY6Cc62v7j4n2c8/760w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5912
X-Proofpoint-GUID: kO0LwyyzxmgxYh_RbiJsbvVXSATI8fyj
X-Proofpoint-ORIG-GUID: 2V1RJ6ftnCEWoJrGR-him3LADA7yu_oD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_06:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070067
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, July 7, 2021 10:56 AM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org
> Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
> ADRF6780
>=20
> On Wed, 7 Jul 2021 08:26:59 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > From: Sa, Nuno <Nuno.Sa@analog.com>
> > > Sent: Tuesday, July 6, 2021 12:23 PM
> > > To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Cc: Jonathan Cameron <jic23@kernel.org>; Miclaus, Antoniu
> > > <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > robh+dt@kernel.org
> > > Subject: RE: [PATCH v4 1/2] iio: frequency: adrf6780: add support
> for
> > > ADRF6780
> > >
> > >
> > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > > Sent: Tuesday, July 6, 2021 11:04 AM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: Jonathan Cameron <jic23@kernel.org>; Miclaus, Antoniu
> > > > <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org;
> linux-
> > > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > robh+dt@kernel.org
> > > > Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support
> for
> > > > ADRF6780
> > > >
> > > > On Mon, 5 Jul 2021 10:18:51 +0000
> > > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > > >
> > > > > > -----Original Message-----
> > > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > > Sent: Saturday, July 3, 2021 6:57 PM
> > > > > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > > > > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > > > devicetree@vger.kernel.org; robh+dt@kernel.org
> > > > > > Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add
> support
> > > > for
> > > > > > ADRF6780
> > > > > >
> > > > > > On Fri, 2 Jul 2021 14:12:38 +0300
> > > > > > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> > > > > >
> > > > > > > The ADRF6780 is a silicon germanium (SiGe) design,
> wideband,
> > > > > > > microwave upconverter optimized for point to point
> microwave
> > > > > > > radio designs operating in the 5.9 GHz to 23.6 GHz
> frequency
> > > > > > > range.
> > > > > > >
> > > > > > > Datasheet:
> > > > > > > https://www.analog.com/media/en/technical-
> > > > documentation/data-
> > > > > > sheets/ADRF6780.pdf
> > > > > > >
> > > > > > > Signed-off-by: Antoniu Miclaus
> <antoniu.miclaus@analog.com>
> > > > > >
> > > > > > Hi Antoniu,
> > > > > >
> > > > > > Frequency drivers are fairly unusual so if you could add a
> listing of
> > > > > > the attributes in sysfs that would be great (it's nice practice
> > > anyway
> > > > but
> > > > > > I don't insist on it!)
> > > > > >
> > > > > > Various fairly minor comments inline.
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > Jonathan
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  changes in v4:
> > > > > > >   - change license to: GPL-2.0-only
> > > > > > >  drivers/iio/frequency/Kconfig    |  13 +
> > > > > > >  drivers/iio/frequency/Makefile   |   1 +
> > > > > > >  drivers/iio/frequency/adrf6780.c | 498
> > > > > > +++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 512 insertions(+)
> > > > > > >  create mode 100644 drivers/iio/frequency/adrf6780.c
> > > > > > >
> > > > > > > diff --git a/drivers/iio/frequency/Kconfig
> > > > > > b/drivers/iio/frequency/Kconfig
> > > > > > > index 240b81502512..fc9751c48f59 100644
> > > > > > > --- a/drivers/iio/frequency/Kconfig
> > > > > > > +++ b/drivers/iio/frequency/Kconfig
> > > > > > > @@ -49,5 +49,18 @@ config ADF4371
> > > > > > >
> > > > > > >  	  To compile this driver as a module, choose M here:
> > > the
> > > > > > >  	  module will be called adf4371.
> > > > > > > +
> > > > > > > +config ADRF6780
> > > > > > > +        tristate "Analog Devices ADRF6780 Microwave
> > > Upconverter"
> > > > > > > +        depends on SPI
> > > > > > > +        depends on COMMON_CLK
> > > > > > > +        depends on OF
> > > > > >
> > > > > > Why?  Pretty much everything seems to have defaults if not
> > > > provided
> > > > > > via OF.
> > > > > > I've asked for the generic firmware functions anyway, so you
> can
> > > > drop
> > > > > > this
> > > > > > for that reason if nothing else!
> > > > > >
> > > > > > > +        help
> > > > > > > +          Say yes here to build support for Analog Devices
> > > ADRF6780
> > > > > > > +          5.9 GHz to 23.6 GHz, Wideband, Microwave
> Upconverter.
> > > > > > > +
> > > > > > > +          To compile this driver as a module, choose M here:
> the
> > > > > > > +          module will be called adrf6780.
> > > > > > > +
> > > > > > >  endmenu
> > > > > > >  endmenu
> > > > > > > diff --git a/drivers/iio/frequency/Makefile
> > > > > > b/drivers/iio/frequency/Makefile
> > > > > > > index 518b1e50caef..ae3136c79202 100644
> > > > > > > --- a/drivers/iio/frequency/Makefile
> > > > > > > +++ b/drivers/iio/frequency/Makefile
> > > > > > > @@ -7,3 +7,4 @@
> > > > > > >  obj-$(CONFIG_AD9523) +=3D ad9523.o
> > > > > > >  obj-$(CONFIG_ADF4350) +=3D adf4350.o
> > > > > > >  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> > > > > > > +obj-$(CONFIG_ADRF6780) +=3D adrf6780.o
> > > > > > > diff --git a/drivers/iio/frequency/adrf6780.c
> > > > > > b/drivers/iio/frequency/adrf6780.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..472a66f90c7f
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/iio/frequency/adrf6780.c
> > > > > > > @@ -0,0 +1,498 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > > +/*
> > > > > > > + * ADRF6780 driver
> > > > > > > + *
> > > > > > > + * Copyright 2021 Analog Devices Inc.
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include <linux/bitfield.h>
> > > > > > > +#include <linux/bits.h>
> > > > > > > +#include <linux/clk.h>
> > > > > > > +#include <linux/clkdev.h>
> > > > > > > +#include <linux/clk-provider.h>
> > > > > > > +#include <linux/delay.h>
> > > > > > > +#include <linux/device.h>
> > > > > > > +#include <linux/iio/iio.h>
> > > > > > > +#include <linux/module.h>
> > > > > >
> > > > > > #include <linux/mod_devicetable.h>
> > > > > >
> > > > > > > +#include <linux/spi/spi.h>
> > > > > > > +
> > > > > > > +/* ADRF6780 Register Map */
> > > > > > > +#define ADRF6780_REG_CONTROL
> 	0x00
> > > > > > > +#define ADRF6780_REG_ALARM_READBACK
> 	0x01
> > > > > > > +#define ADRF6780_REG_ALARM_MASKS		0x02
> > > > > > > +#define ADRF6780_REG_ENABLE			0x03
> > > > > > > +#define ADRF6780_REG_LINEARIZE
> 	0x04
> > > > > > > +#define ADRF6780_REG_LO_PATH
> 	0x05
> > > > > > > +#define ADRF6780_REG_ADC_CONTROL		0x06
> > > > > > > +#define ADRF6780_REG_ADC_OUTPUT
> > > 	0x0C
> > > > > > > +
> > > > > > > +/* ADRF6780_REG_CONTROL Map */
> > > > > > > +#define ADRF6780_PARITY_EN_MSK
> 	BIT(15)
> > > > > > > +#define ADRF6780_PARITY_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_PARITY_EN_MSK, x)
> > > > > > > +#define ADRF6780_SOFT_RESET_MSK
> > > 	BIT(14)
> > > > > > > +#define ADRF6780_SOFT_RESET(x)
> > > > > > 	FIELD_PREP(ADRF6780_SOFT_RESET_MSK, x)
> > > > > > > +#define ADRF6780_CHIP_ID_MSK
> > > > 	GENMASK(11, 4)
> > > > > > > +#define ADRF6780_CHIP_ID			0xA
> > > > > > > +#define ADRF6780_CHIP_REVISION_MSK
> > > > 	GENMASK(3, 0)
> > > > > > > +#define ADRF6780_CHIP_REVISION(x)
> > > > > > 	FIELD_PREP(ADRF6780_CHIP_REVISION_MSK, x)
> > > > > > > +
> > > > > > > +/* ADRF6780_REG_ALARM_READBACK Map */
> > > > > > > +#define ADRF6780_PARITY_ERROR_MSK		BIT(15)
> > > > > > > +#define ADRF6780_PARITY_ERROR(x)
> > > > > > 	FIELD_PREP(ADRF6780_PARITY_ERROR_MSK, x)
> > > > > > > +#define ADRF6780_TOO_FEW_ERRORS_MSK
> 	BIT(14)
> > > > > > > +#define ADRF6780_TOO_FEW_ERRORS(x)
> > > > > > 	FIELD_PREP(ADRF6780_TOO_FEW_ERRORS_MSK, x)
> > > > > > > +#define ADRF6780_TOO_MANY_ERRORS_MSK
> > > 	BIT(13)
> > > > > > > +#define ADRF6780_TOO_MANY_ERRORS(x)
> > > > > > 	FIELD_PREP(ADRF6780_TOO_MANY_ERRORS_MSK, x)
> > > > > > > +#define ADRF6780_ADDRESS_RANGE_ERROR_MSK
> 	BIT(12)
> > > > > > > +#define ADRF6780_ADDRESS_RANGE_ERROR(x)
> > > > > >
> 	FIELD_PREP(ADRF6780_ADDRESS_RANGE_ERROR_MSK, x)
> > > > > > > +
> > > > > > > +/* ADRF6780_REG_ENABLE Map */
> > > > > > > +#define ADRF6780_VGA_BUFFER_EN_MSK
> 	BIT(8)
> > > > > > > +#define ADRF6780_VGA_BUFFER_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, x)
> > > > > > > +#define ADRF6780_DETECTOR_EN_MSK		BIT(7)
> > > > > > > +#define ADRF6780_DETECTOR_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, x)
> > > > > > > +#define ADRF6780_LO_BUFFER_EN_MSK		BIT(6)
> > > > > > > +#define ADRF6780_LO_BUFFER_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, x)
> > > > > > > +#define ADRF6780_IF_MODE_EN_MSK
> > > 	BIT(5)
> > > > > > > +#define ADRF6780_IF_MODE_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, x)
> > > > > > > +#define ADRF6780_IQ_MODE_EN_MSK
> > > > 	BIT(4)
> > > > > > > +#define ADRF6780_IQ_MODE_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, x)
> > > > > > > +#define ADRF6780_LO_X2_EN_MSK
> 	BIT(3)
> > > > > > > +#define ADRF6780_LO_X2_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_LO_X2_EN_MSK, x)
> > > > > > > +#define ADRF6780_LO_PPF_EN_MSK
> 	BIT(2)
> > > > > > > +#define ADRF6780_LO_PPF_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, x)
> > > > > > > +#define ADRF6780_LO_EN_MSK			BIT(1)
> > > > > > > +#define ADRF6780_LO_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_LO_EN_MSK, x)
> > > > > > > +#define ADRF6780_UC_BIAS_EN_MSK
> > > 	BIT(0)
> > > > > > > +#define ADRF6780_UC_BIAS_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, x)
> > > > > > > +
> > > > > > > +/* ADRF6780_REG_LINEARIZE Map */
> > > > > > > +#define ADRF6780_RDAC_LINEARIZE_MSK
> > > > 	GENMASK(7, 0)
> > > > > > > +#define ADRF6780_RDAC_LINEARIZE(x)
> > > > > > 	FIELD_PREP(ADRF6780_RDAC_LINEARIZE_MSK, x)
> > > > > > > +
> > > > > > > +/* ADRF6780_REG_LO_PATH Map */
> > > > > > > +#define ADRF6780_LO_SIDEBAND_MSK		BIT(10)
> > > > > > > +#define ADRF6780_LO_SIDEBAND(x)
> > > > > > 	FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, x)
> > > > > > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY_MSK
> > > > > > 	GENMASK(7, 4)
> > > > > > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY(x)
> > > > > >
> 	FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, x)
> > > > > > > +#define ADRF6780_I_PATH_PHASE_ACCURACY_MSK
> > > > > > 	GENMASK(3, 0)
> > > > > > > +#define ADRF6780_I_PATH_PHASE_ACCURACY(x)
> > > > > >
> 	FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, x)
> > > > > > > +
> > > > > > > +/* ADRF6780_REG_ADC_CONTROL Map */
> > > > > > > +#define ADRF6780_VDET_OUTPUT_SELECT_MSK
> > > > 	BIT(3)
> > > > > > > +#define ADRF6780_VDET_OUTPUT_SELECT(x)
> > > > > > 	FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK,
> x)
> > > > > > > +#define ADRF6780_ADC_START_MSK
> 	BIT(2)
> > > > > > > +#define ADRF6780_ADC_START(x)
> > > > > > 	FIELD_PREP(ADRF6780_ADC_START_MSK, x)
> > > > > > > +#define ADRF6780_ADC_EN_MSK
> 	BIT(1)
> > > > > > > +#define ADRF6780_ADC_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_ADC_EN_MSK, x)
> > > > > > > +#define ADRF6780_ADC_CLOCK_EN_MSK
> 	BIT(0)
> > > > > > > +#define ADRF6780_ADC_CLOCK_EN(x)
> > > > > > 	FIELD_PREP(ADRF6780_ADC_CLOCK_EN_MSK, x)
> > > > > > > +
> > > > > > > +/* ADRF6780_REG_ADC_OUTPUT Map */
> > > > > > > +#define ADRF6780_ADC_STATUS_MSK
> > > 	BIT(8)
> > > > > > > +#define ADRF6780_ADC_STATUS(x)
> > > > > > 	FIELD_PREP(ADRF6780_ADC_STATUS_MSK, x)
> > > > > > > +#define ADRF6780_ADC_VALUE_MSK
> > > > > > 	GENMASK(7, 0)
> > > > > > > +#define ADRF6780_ADC_VALUE(x)
> > > > > > 	FIELD_PREP(ADRF6780_ADC_VALUE_MSK, x)
> > > > > >
> > > > > > Not used.  In general, just use FIELD_PREP / FIELD_GET inline
> > > > rather
> > > > > > than having extra
> > > > > > macros like these. That approach is simpler for reviewers to
> > > follow.
> > > > > >
> > > > > > > +
> > > > > > > +struct adrf6780_dev {
> > > > > > > +	struct spi_device	*spi;
> > > > > > > +	struct clk		*clkin;
> > > > > > > +	/* Protect against concurrent accesses to the device */
> > > > > > > +	struct mutex		lock;
> > > > > > > +	bool			vga_buff_en;
> > > > > > > +	bool			lo_buff_en;
> > > > > > > +	bool			if_mode_en;
> > > > > > > +	bool			iq_mode_en;
> > > > > > > +	bool			lo_x2_en;
> > > > > > > +	bool			lo_ppf_en;
> > > > > > > +	bool			lo_en;
> > > > > > > +	bool			uc_bias_en;
> > > > > > > +	bool			lo_sideband;
> > > > > > > +	bool			vdet_out_en;
> > > > > > > +};
> > > > > > > +
> > > > > > > +static int adrf6780_spi_read(struct adrf6780_dev *dev,
> > > > unsigned int
> > > > > > reg,
> > > > > > > +			      unsigned int *val)
> > > > > > > +{
> > > > > > > +	int ret;
> > > > > > > +	unsigned int temp;
> > > > > > > +	struct spi_transfer t =3D {0};
> > > > > > > +	u8 data[3];
> > > > > > > +
> > > > > > > +	data[0] =3D 0x80 | (reg << 1);
> > > > > > > +	data[1] =3D 0x0;
> > > > > > > +	data[2] =3D 0x0;
> > > > > > > +
> > > > > > > +	t.rx_buf =3D &data[0];
> > > > > > > +	t.tx_buf =3D &data[0];
> > > > > > > +	t.len =3D 3;
> > > > > > > +
> > > > > > > +	ret =3D spi_sync_transfer(dev->spi, &t, 1);
> > > > > >
> > > > > > data needs to be dma safe.
> > > > > >
> > > > > > > +	if (ret < 0)
> > > > > > > +		return ret;
> > > > > > > +
> > > > > > > +	temp =3D ((data[0] | 0x80 | (reg << 1)) << 16) |
> > > > > > > +		(data[1] << 8) | data[2];
> > > > > >
> > > > > > Ouch. That's a bit nasty, but why are you writing the reg into
> > > > > > it?  Looks like a get_unaligned_be24() >> 1 and a 16bit mask.
> > > > > > (use GENMASK(15, 0) for that to make it apparent what is
> > > > happening.
> > > > > >
> > > > > > > +
> > > > > > > +	*val =3D (temp >> 1) & 0xFFFF;
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int adrf6780_spi_write(struct adrf6780_dev *dev,
> > > > > > > +				      unsigned int reg,
> > > > > > > +				      unsigned int val)
> > > > > > > +{
> > > > > > > +	u8 data[3];
> > > > > > > +
> > > > > > > +	val =3D (val << 1);
> > > > > > > +
> > > > > > > +	data[0] =3D (reg << 1) | (val >> 16);
> > > > > > > +	data[1] =3D val >> 8;
> > > > > > > +	data[2] =3D val;
> > > > > >
> > > > > > An opportunity for
> > > > > > put_unaligned_be24() with a value of (I think)
> > > > > >
> > > > > > (val << 1) | (reg << 17)
> > > > > >
> > > > > >
> > > > > > > +
> > > > > > > +	return spi_write(dev->spi, &data[0], 3);
> > > > > >
> > > > > > Needs a dma safe buffer, which basically means it can't be on
> the
> > > > > > stack.
> > > > > > Lots of ways of handling that, but look for
> __cacheline_aligned in
> > > > IIO
> > > > > > drivers
> > > > > > to see the one we probably use mostly commonly in IIO
> drivers.
> > > > >
> > > > > Hi Jonathan,
> > > > >
> > > > > This is something I wanted to ask for some time so I will take
> the
> > > > opportunity here :).
> > > > > Is this something you prefer just not to risk at all and make it =
an
> > > hard
> > > > requirement
> > > > > (which is fair)? ...
> > > >
> > > > Yes, I think we need to keep this as a hard requirement.
> > > > There are drivers out there which we missed this on in the past,
> and
> > > > I'm not necessarily
> > > > going to take the time to go through them all as this can be hard
> to
> > > > spot, but lets not
> > > > introduce any more potential problems.
> > > >
> > >
> > > I see. That makes sense and it's fair :). The only annoying (but not
> too
> > > annoying :)) is that
> > > making the data/buffer global forces you to use a lock in cases you
> > > potentially would
> > > not have too (just using local buffers). But that's life, better play
> safe :)
> > >
> > > > >
> > > > > I'm asking this because, tbh, I would be very surprised if any
> spi/i2c
> > > > controller out there
> > > > > is using dma for a 3byte transfer. I guess the overhead of
> setting it
> > > up
> > > > is probably not
> > > > > worth it...
> > > >
> > > > There are (I believe) a few i2c and spi controllers out there that
> don't
> > > > do anything other
> > > > than DMA.  Wolfram mentioned one of those in his talk on adding
> > > > DMA support to i2c.
> > >
> > > Hmm, I see...
> > >
> > > > Also, the reference in the file below to the wonderful case of
> USB to
> > > > i2c bridges that always
> > > > require DMA safe buffers.
> > >
> > > Indeed it does.
> > >
> >
> > Hi Jonathan,
> >
> > Just for closure, I also realized that the pattern in IIO looks to be t=
o
> use
> > DMA safe buffers only on the tx side. For instance in the IMU lib [1],
> > only the tx buffer is safe (well, I think there's problem with this as
> > I believe all spi transfers buffers should be properly aligned which
> won't
> > be the case in the IMU lib). Is there any reason for this? AFAICT, we
> should
> > also take care with rx buffers or am I missing something?
> Ah.  So this is a fun corner :)
>=20
> The reason cache line corruption can occur is as follows.
> 1. DMA starts, typically involving some tx and rx usage by the device.
>    This flushes the CPU caches for the relevant lines.
> ... whilst DMA is not completed ...
> 2. The host software pulls the line into it's cache and updates
> something (say a flag
>    elsewhere in that cacheline).
> 3. Cacheline is evicted from the CPU cache causing a write back.
> 4. Device then writes back the stuff it had cached locally which is
> allowed to include data
>    it wasn't accessing in the same cache line.  Boom, it just overwrote
> the flag we updated
>    with an older value.  Basically this is a performance optimization /
> simplification
>    the DMA engine is allowed to make.  Note I believe they are
> 'technically' allowed to
>    write back to the RX buffers as well, though not sure what devices do
> this for i2c/spi.

Yes, got it...

> So, why do we only need to force one of the buffers to the start of a
> cacheline?
>=20
> What we are actually doing, is not keeping the buffer in it's own
> cacheline, but rather
> making sure nothing else is in the same cacheline (so there is no race
> as above).
> (it's easier to move the buffer, than to ensure everything else is
> moved out of the cache
> line it happens to be in!)
> There is a safe assumption here that the DMA device can't corrupt it's
> own data as that
> would be crazy :)

My confusion here was looking at this [1] and somehow thinking that
DMA mappings require that both 'tx_buf' and 'rx_buf' to be on their own
cache lines... But I guess that since both buffers are guaranteed to be alo=
ne
(in our case) in their cache line (or span across multiple lines) we are fi=
ne... Though
I didn't really looked into the details on the DMA subsystem... I'm just aw=
are that
for instance 'dma_map_single()' states that the addr to map must begin on a=
 cache
line boundary.

> Hence, pushing the first buffer to the start of a line, allows the second
> one to be
> after it in the same line (it's not a problem if it takes multiple lines)
>=20
> One more subtlety is why we can be sure nothing else ends up after
> the buffers.
> That's by construction.  The allocations IIO does for those iio_priv
> structures should
> always get padded out to at least the end of the cacheline.
> (IIRC, not looked at this code for many years!)
>=20

Looking at [2], I think that holds correct as long as private structures ha=
ve
their buffer properly aligned in the end of the struct. Hence, the natural =
padding
of the structure ensures us that nothing else gets into the same cache
line as our buffer.

Which means that, if I'm not missing nothing obvious, all the adis IMUS are=
 not
complying with this [3]... I think the 'struct adis adis' field has to be i=
n the end of the
adis16480 structure so that our tx and rx buffers in the adis struct are on=
 their own
line...

Thanks for your inputs!
- Nuno S=E1

[1]: https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L976
[2]: https://elixir.bootlin.com/linux/v5.13/source/drivers/iio/industrialio=
-core.c#L1605
[3]: https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/adis164=
80.c#L159
