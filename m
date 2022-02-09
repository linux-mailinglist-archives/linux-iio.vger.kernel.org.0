Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7C4AF298
	for <lists+linux-iio@lfdr.de>; Wed,  9 Feb 2022 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiBINYe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Feb 2022 08:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiBINYd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Feb 2022 08:24:33 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA00C05CB9E
        for <linux-iio@vger.kernel.org>; Wed,  9 Feb 2022 05:24:36 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2195TceL023165;
        Wed, 9 Feb 2022 08:24:27 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3e47gusjdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 08:24:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZpHHZ/1X6TfhRyrXt70cS8YIah1s0SfNm5TrfGhjXAcDtVBhifT2vF5r8yMBrVUL7xQArZb9lFJ029e8U7SGuOBIJIV3XEqrvVhlZSIge2EATparewiCIEhybDavraYcN89rnl8AV+Dj+Wegbe0bcUzZnqkTCOSx5coVwXOlzBGGlTJdFidCzyBFBcIYMvJff/qkXt6G/4V6wj3AVhgI5yQXls5LwwKj3K7OIu22Z17s9ZJiyDoA8Rt253FDcFDo1t0S2FtcLVMIy/l/isZh375dFGWY77Quv75u2Av6WuLODws2Z1SOge16zo8/563wZiFbYXLuojcsO+qwqUCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX49G1YEfbNZr56sWrQI73kpL5zqZ6FyoXX0r0xPh/M=;
 b=g8C1sx3A65tgaq0PsTzrErcKnxAMpHok/FO2F1cNF42hxV2ejbn9I8rh8en7I9rtDaD7Sen3FyunpKLy8a24Qyk5F0cWEkJIOEQIfUmuwSLDI+E6eGvXPwVrDJgKkU0aUSmeDUiRNRsZfXof4BugxEm5Zb3LERqwOFhLzfGSdrJA6TNhdu4h2TUbQiYtSy1m1+KbCAfe3kXWaRLXh6U5cUxeR5WhlsIrfxArHKQecyKo+RskWRtFn+12ySJZN7CfQ1exNRSZnTO6VJWiEKp4WeTJw/aW/MWQ684IkyjBPMT0TWXm07WXFXz0yitIcOyDyzmpkMAEkCxuwptbXyTI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX49G1YEfbNZr56sWrQI73kpL5zqZ6FyoXX0r0xPh/M=;
 b=8sb+afHkwqBXTtOx5KiuZqjOkO0tZfXhwwe2VdDel+WlTw7Rxme1MANTZ9S7W0vo8YGMBhAoFGXhHRMXqicRWF3c1xAH9LFvMS2BCiE2o80ZN7gcE+xeg74fhqUcTeKl2NMFRfSm5vjH44GGpzDQAnjTV+0B2lQq/9RVjDtgFIo=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BYAPR03MB3640.namprd03.prod.outlook.com (2603:10b6:a02:aa::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 13:24:25 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c%6]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 13:24:25 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: IIO driver/datasheet question 
Thread-Topic: IIO driver/datasheet question 
Thread-Index: AdgduFjWn19PlfAMTkepfo/fpjw6Kg==
Date:   Wed, 9 Feb 2022 13:24:25 +0000
Message-ID: <CY4PR03MB33991EB004B66FE32A39F2F19B2E9@CY4PR03MB3399.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy05NjkxMmYwMC04OWFiLTExZWMtYWMzNC?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcOTY5MTJmMDEtODlhYi0xMWVjLWFj?=
 =?iso-8859-2?Q?MzQtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIzOTYiIHQ9IjEzMjg4OD?=
 =?iso-8859-2?Q?g2NjYxMzM4Mjk5OCIgaD0iS3A0S2VOandRSzN3OTR4cjRGRlN6TWpOZEVV?=
 =?iso-8859-2?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-2?Q?NnVUFBRW9DQUFCV1R4aFp1QjNZQWY3ck55bnF2amx3L3VzM0tlcStPWEFE?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFYUS9qalFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFKNEFBQUJoQUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRz?=
 =?iso-8859-2?Q?hBYWdCbEFHTUFkQUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFR?=
 =?iso-8859-2?Q?QjBBR2tBZGdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQU?=
 =?iso-8859-2?Q?FHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VB?=
 =?iso-8859-2?Q?WXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWVFCa0FH?=
 =?iso-8859-2?Q?a0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBY3?=
 =?iso-8859-2?Q?dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1139d2d2-6515-4322-b299-08d9ebcf7e22
x-ms-traffictypediagnostic: BYAPR03MB3640:EE_
x-microsoft-antispam-prvs: <BYAPR03MB3640D199C28B77B3CA59BF6C9B2E9@BYAPR03MB3640.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7qVjZ9OE67f0A8hJy+7NSBdhBoZtokTggw1ZMx0FAWvyDbisoJE4Fh3VnlV+1sbeMLDQtUWn+ZTzybaVcn34E40JFBzS+/GexUqCmvDjPI2SXBsTbUfZVzLuEwI/QtluSVkljmwmXqYwVtbHC1JHpqkH1nxwLH/UxsZkhvJkbTg6i/LhZcskjk14kqaFqFhfsKBdSbTe946YB6b614fyqg6yerViqgBVA2uy8jokA92jE/ib4D9D9ehpFxmg2fDFMrdfOhxMhp/j7Y4o8kIBIYdzfgMMD04dpxwHCNSjVemYQ4X7ipg3vkGQHkbLBjnisxpyGs9msDdCOKPMT9Qk2qGcF73wNRcFRLafy7jjkxG0io3lCeKVhp93MeLRjP7/qKfNmDvA7RWVnv/qbGKp0DA6V3qjBJTT1l7Yovc+2ZmK3tjoZ2ycayh+zu/8gqNkbqGwYtxdZkNCkRGQRdGdyMvRYVEbuwjO/SB264vucMSgqWa/3XndO2kt+SVwy4bzc+4kECiRZiD1Ys2rdxF5Y0bpKoiqox9uWkif8JlUU/aBX1TXNq4WuqnEKLHE4gV7cqZ2dX26cEyVfcwCugRD0de9WPhUF7Jtq0mf+bAgHJgGKxGWvRkzecnJQXcLt8aiudY3SQ6Q5e16PrPbn0zDqYnoSdS9dMHQs2isEVcbFXr4YgA6CqR+sujbtCxHReGW1zPkUzFXIFy16S7wMs4tA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(316002)(66946007)(8676002)(66446008)(64756008)(66556008)(4326008)(8936002)(5660300002)(66476007)(558084003)(38070700005)(33656002)(4743002)(26005)(52536014)(6916009)(186003)(55016003)(122000001)(86362001)(3480700007)(66574015)(508600001)(71200400001)(2906002)(6506007)(38100700002)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?85e34t4LyB1Rx4zbt1Ve3CCo02bXCCioHia+Pvq8vfLZ5gTO87iyeGugn0?=
 =?iso-8859-2?Q?skpr9aTSj54NHyz6oQ27qTY9arVWJe7NCjwt1Lz8U5GcHA/9FTYUhbNNpz?=
 =?iso-8859-2?Q?c9Q1ED6MFJEStSZ2+88fzfZonS+jsWQRXikpuQ9Di2Qzif2/m74Hgl2jr7?=
 =?iso-8859-2?Q?c063pONWhe8MgNlzG+b16VZg6V01wxHadtWedPO0LiuvmrtRjwTRM2wHWP?=
 =?iso-8859-2?Q?+Jm92YdpiANlHQSUhjUoWp44BSTs/hTm+/S9HOWfXtQBgTZB7NeWJ5UOyV?=
 =?iso-8859-2?Q?nD7dz6RGtzjV3ERllYL3sOrGtka8XLYNsqroanwZqIvyCytguYWNMSB0Si?=
 =?iso-8859-2?Q?3P2KvluYX0C588yHxjHS3TWaBc+ygEYuSxhl4PiE/79BypKS1QguQGS81o?=
 =?iso-8859-2?Q?ELyvwM4Xyx2/12F0cJ1eMpGjcF6NYl+BurxfJZ5Mbh9YpF+ZXgT0T3HWen?=
 =?iso-8859-2?Q?lD/g9kDLjSSFFx6/EjY6CFITKER7omt4Lou+VNpgXvRFVa99seFVECUHYF?=
 =?iso-8859-2?Q?8lQCuonN0AhYcdQgAifrmmPdjUCI6DV+vHs4B2I2a8GP81n4omIM0L8L7s?=
 =?iso-8859-2?Q?xbCa7rmBehIMr9xVVtrPJx5rgMqHwfhSmfPsNX03ZJBMvyWxAoraIAz2Um?=
 =?iso-8859-2?Q?1wcvQrGGyf4oihbyYkP9psG9KaX1AsObyVNuxlJNmhl7h0kLxs3YyH54Fm?=
 =?iso-8859-2?Q?yoUtawedhUhrqiFk7ezT0OdMf2k4vAkpn8H/RLAv7ukGCqQOpJtrsvc+Uj?=
 =?iso-8859-2?Q?S47tDuPPz8rXZAFWIQRaDuksja8AwJFbA0ddW6ndJByXibeJg2PQJSCM1z?=
 =?iso-8859-2?Q?FOsB7QdSmjSMGo3Mbtg1vzcaSZ8cYZpiqLFXqVJE694JSQnhAOVGg+mmXO?=
 =?iso-8859-2?Q?8k3x1lJAZ+V1qbwx3iWMX9hggsqSm8blBsv8Ps7k+b2Em0GrIhP/vmfxpM?=
 =?iso-8859-2?Q?0rrJZxnHriVmftoqFbaRKjKb0euVfE7FIxl1/TTQCpKhl01k0qs2uCC1Lr?=
 =?iso-8859-2?Q?cq5qBiI2avn3Q00AFE4cDKkNANdSg9ciP1dqPppbfGFy2YQh/mPFRRFC3P?=
 =?iso-8859-2?Q?mwFFKN+F8vIc+qlGcmxBl82j8C5/B6peoy8NiGecZRf5mLbrdDb/bhGppA?=
 =?iso-8859-2?Q?WyhksiydcKFQ89cHBHfg+RpKKI75he+ZmFDefvYhQXKj7OEUrGPP90hVac?=
 =?iso-8859-2?Q?74d7SIqzxbzJhmXju1gosQ3xH/fGAJEp4qU6Owuhymr732yDGCpXZFZDsI?=
 =?iso-8859-2?Q?Myh6iOaSiWv7jp2/U5y5FKp2m+ITPxArn+hi79Jjz5rje+aE8mtx0hyCLv?=
 =?iso-8859-2?Q?v7z7Dc8aNYBeSwwtKelE1s9PqO6/9vibKz1+WY006UXRWgkvdmN8Axn1Oa?=
 =?iso-8859-2?Q?nCl+NxlXp+ZwIPtv5w6JC5KhYUYT7YGFJK+U+C647ELlYBaZZsK8dHLxZm?=
 =?iso-8859-2?Q?noLyu2sNzCsJ5iyF72indE9F3oSq9C20SW4pjoKEbw59TILCjErm5wRVeZ?=
 =?iso-8859-2?Q?284G9kQOvUFMMhR7oRMKrqw9xKYdhbuGsnmbPfRpPZieZmiKljnKbr4erw?=
 =?iso-8859-2?Q?uHA4dRm7BcaTzyj44xKhbWsggy+pn6K8I9Zw4+xF1YUGzHu6XD8LAArZjX?=
 =?iso-8859-2?Q?jvwLa8TnBX5ZQ0jF142MAFHsA3lNAUY10OfTaCG4ywT5MbX5cGndZ54Rnq?=
 =?iso-8859-2?Q?MeRpRewsB+QefX957qwQDGBYLjdtOxFcgpvPJQ+Y/XjQTISDpon248BsZO?=
 =?iso-8859-2?Q?y08g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1139d2d2-6515-4322-b299-08d9ebcf7e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 13:24:25.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/8EIvSLoZFpiAU4zexdXOhWpaGwPYUaDnA/nsO+HfoMLYJkFlKysSsjnGXonC7h9TRV7/UXOGrALSmI2ge/lu9s+BC/SqffKnMiuL3QmsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3640
X-Proofpoint-GUID: IExM1QTRZXKwJbLxY7SVNanq9nsG8Iz_
X-Proofpoint-ORIG-GUID: IExM1QTRZXKwJbLxY7SVNanq9nsG8Iz_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_07,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=600 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090078
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

Is it acceptable to send an IIO driver (ADA4250 Programmable Instrumentatio=
n Amplifier) upstream without having the datasheet link available?

Regards,
--=A0
Antoniu Micl=E3u=BA
System Applications Engineer
Customer Solution Enablement

E-mail: antoniu.miclaus@analog.com
Mobile: +40 747 036533



=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0


