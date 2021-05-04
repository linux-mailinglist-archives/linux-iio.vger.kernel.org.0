Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8657837266B
	for <lists+linux-iio@lfdr.de>; Tue,  4 May 2021 09:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhEDHRz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 May 2021 03:17:55 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37508 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229825AbhEDHRz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 May 2021 03:17:55 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1447GnxD025750;
        Tue, 4 May 2021 03:16:49 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-00128a01.pphosted.com with ESMTP id 38amtctcbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 May 2021 03:16:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMq74AYM3YNeG1eO2cMHuFzo6z5yaybuArBFi0sEjaCZ6zGYWUODvcLzH0yrT5k3Nc4VsOmkVah2Igx4G/oycKukKkrxp5j7hV0h0uJdeo/L5G+kXEan7njNtixl/j0RlzETREbyhbZqkYu9MVwWEH/odet2RsB/QGmTXObai16oQ2oGa8pK984vTRRnHHCbvStsH6Xyntbx2NA9wTA6DIsZVKnPtHN0EcWPCU8BCB0RAYTp492XrfVS90L7SjDMfu7MOtZwmbe5ssWelSNCLgMNUgmeh/TgoU6LHEB2BA5pKJmyoEQcJNkMiUkxxS9HcnbymD1cvBqfwL/6rTI3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVHidmRP+1mFCfqT++WE9jrHOkf4JMSW3+NKNltuvxQ=;
 b=X+kkMMoLVOSZMZGhGXAD/0EOewWxtTmIsBgeqJbIxKjXbF390nufThbwBNg0GoGM2Sx6i+1V0B5adWCPaj5LUt78kREcVBCHPwNSG65V//AF6kx4ILrHaW87UHGx9p+iVmzvbB+5PE/vyaVBeYE4pFINRHtdgkFRhgf8retUinyW4KFI1nNmFA7YDjMKYBhTd1QzLiXWNmnIhGqdiIBvPGLlSFI/A6KgfLDUmKiEx/rOFP9XaCNg4OHtn9HfPArt68ffEtqdVfTQFcNmS0tg+zfuLP2wFPYlhFpwC/PYi8tfaMziwaUk86Z2oAQ+VZd+EK6PM74TmgvD+dr+5Jeo4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVHidmRP+1mFCfqT++WE9jrHOkf4JMSW3+NKNltuvxQ=;
 b=41ueKd0gFOUE+4Scyt2tR2NOd5wwhFTjkLbc88oIcGkif7uh5NMkA6+32z1IAMXBpty6We8vS8XILAJQfszPF6tPMaTdxVVdiG8YNZjuXVEyjkfWYRqVePOsSdzT/H2MDMJdSP7CLzhAtf47c7Qe6QEKVF5EupRZ+AZ6Ks0m2X0=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5669.namprd03.prod.outlook.com (2603:10b6:510:33::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Tue, 4 May
 2021 07:16:47 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::811f:3542:ef73:92ef]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::811f:3542:ef73:92ef%6]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 07:16:47 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v4] iio: adis16480: support burst read function
Thread-Topic: [PATCH v4] iio: adis16480: support burst read function
Thread-Index: AQHXN2M4NSNqRiEaEE6KRMvBqtrdh6rDjC4AgA9vwHA=
Date:   Tue, 4 May 2021 07:16:46 +0000
Message-ID: <PH0PR03MB6366E7F728971DAF5B867898995A9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210422103735.136367-1-nuno.sa@analog.com>
 <20210424123216.317e9b34@jic23-huawei>
In-Reply-To: <20210424123216.317e9b34@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYWQ0ZGQ3M2QtYWNhOC0xMWViLThiNDktZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGFkNGRkNzNmLWFjYTgtMTFlYi04YjQ5LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTI5MCIgdD0iMTMyNjQ1ODYyMD?=
 =?iso-8859-1?Q?M3MTMxMjUxIiBoPSJrcXJIM241WWhVc2JwTFFNSHJ0MjdUbWNsVFk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUR6RDZadnRVRFhBZFRocG1PWThzcDMxT0dtWTVqeXluY0ZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWJKUFNkUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJoQUY4QVpBQn?=
 =?iso-8859-1?Q?BBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFNUUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?iso-8859-1?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?iso-8859-1?Q?Q0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 697c99fb-c41a-4782-cad4-08d90ecc941b
x-ms-traffictypediagnostic: PH0PR03MB5669:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB566916B2377045576C5F242E995A9@PH0PR03MB5669.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8CFU2TWIrVpN2XBM49qhBKsicPNkikrgYtV8YrGPkcdFo49+TqzyZNjKjGnf0Pemga0MLX5cmzwkF2/0w/BlJNWqEeGMGAqDYzMAMFJRRKId5qBWJJ5AbdrZvAcUUBVt6vWw6we2xo8Q5cWnvnSmICzHWzltYQp+VfP/YiWhNTJdibeEoMbT0SW6KOK6wmqtHZ7crCgFEiAAIyuaxZGLMt0yw2/aH0PUcxewkWE1cljBx7pxlUpTaJqB869sD5rI6u1Aw3w73LZjfG3QuLrmCgRCxynilxJD2NCX5Jz4oC0/k3YDXEgBv0Ea7h+Ekg7Z01yVF65brhbuzS+zQUxttPpFHyr8gdEKG/UvLCXgj5Bdd9X4BnNgcdJM7RgEDAiY4cGK1C/mNB1V1Vb0w97mT5VdKm/mP4qn3cFLBW3/ZQYP7BVy/4NcxamhrLUNGyez2Em8/5R0s+iNxh/sTajHZc99ZuyO+31jCeLchPPHlNY/zs0qCj27GGP0OtnrobFP9PNwwcPAT8vanvqJaozFmCmBjAPfe7WYlnQFP30zEgTeaRq/bk0pbmytmNQc9qaRABFdB0LGJVoiXzrD+kRSWFX+znmpFL1d7VB10rjuX1E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(8676002)(86362001)(54906003)(33656002)(9686003)(76116006)(53546011)(316002)(6506007)(55016002)(71200400001)(6916009)(5660300002)(66556008)(66446008)(66476007)(64756008)(478600001)(122000001)(38100700002)(4326008)(66946007)(4744005)(8936002)(83380400001)(52536014)(186003)(7696005)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5KqRr9GeOTRN9QXDPjBX+1GHPfwS3i5ilVBFZy4u5oaLuO0pjOgnvpiTlA?=
 =?iso-8859-1?Q?n3DVrJJibM33t2HOVt47Brdz4tQ+vMaF7xpxf/JBln2I1OU7IXJjKQ1p/z?=
 =?iso-8859-1?Q?OAtl347Tpu+v/dtODxfFSZI7SyoLSxpB7tVIuFKE6RMEibZhWwV8ldseOg?=
 =?iso-8859-1?Q?CKkZZzZ3lA3FN1ed9vuIKJIEBs8d/GrsgrpbhG62wZW6PmaQbZp1XDYfIs?=
 =?iso-8859-1?Q?StOH6susEWR+PV5NWu/oYAk+ajTt24YPm4VrGr2iXZZMin+RKQpOaZr4lN?=
 =?iso-8859-1?Q?4uPv3Hv9JSm941YN5zkQqmvkLqwmH1vviFSgBkZr/PbHtLCfCF/TMIHDhd?=
 =?iso-8859-1?Q?z8NHXQA76JUv0RGseXg4LIsDA0MVZHTKe0cVddD93qOlnZmrv7qC/5zFp6?=
 =?iso-8859-1?Q?NwxHpgXScNdA0j2K4ffMZN28eXYyN0yikTyJKja3sdc7zbXGWm3h+G0lAp?=
 =?iso-8859-1?Q?NQDjFQP928ejMlcp7D3VYZhMfQsQ6899o24ttftL1MkmKyXmklHLv4zET0?=
 =?iso-8859-1?Q?pCXjC4fsRdkCTJvmCmkDnfFp6MdBgho9pfzCGmfI5bDj7Jtp/Nzfjt0zgk?=
 =?iso-8859-1?Q?ScGJeyHue5drJ7/PGzTm3np2Babp475AnoM/lBA2GISTkDH1LYiLecnq7+?=
 =?iso-8859-1?Q?nz1paEHqnKAwybkmantMoKRrGXseWvazij2kVYRAgxTES9tRnR3M5P8h7V?=
 =?iso-8859-1?Q?QKBP/Vrm+4uz7CznNWtt4VrEeLj0F26At8GpGzwL8NhN2MrJ7+xxl0YsKf?=
 =?iso-8859-1?Q?n10G8s3gOQVGq1rPDonw6Myq88Ynoi4br/zK7VHsMgiXTGfrPnlt//mMC2?=
 =?iso-8859-1?Q?aGIvNfAyJfOoQd12gOHfk2jJ+o4qbrDSKwX2fgYWoD2cIybdiK+trMrbIU?=
 =?iso-8859-1?Q?de9jGsffxaIpdjrVlezmnJPigES4xjZQOxIzWJp/S1z4JUBJtiurZawfmX?=
 =?iso-8859-1?Q?ELfY/j8wyx9iusgx/ML5xu9VbywoyqrfCSsEv1VSlJwHK6G0UwxXAUoSph?=
 =?iso-8859-1?Q?isL7/gjIccMLDWrxLV74bGxmeqdH6MUlvtVUS9VX1uVdnNwKTOKKGSFI5K?=
 =?iso-8859-1?Q?PmYLdtLypHlqpHgIezUakorz2LkDKIlKlV+i+BFkG9Diu/TyBhdaf6DGO1?=
 =?iso-8859-1?Q?MlmINWnsD1fTPLOjx7uFf8vm4PjNzsM7S2hyb+4d52UajDyREBgj/ao10q?=
 =?iso-8859-1?Q?wIsQxQgsC0cMwI8emq8A6d455LyfkBN6bi7HdGDvllWpNEDXkKSK05xN35?=
 =?iso-8859-1?Q?roRB9ZiCqwitbiJ4zji2S9xyvdaJ+MtHCfZ4EIldtKkmT9vn1WHqgidvjL?=
 =?iso-8859-1?Q?fl2sDNYb2sCLn+QAcsFqFDA1h6T++sd7vchF4JZTEEEG15FzpFar8v6jl/?=
 =?iso-8859-1?Q?E/Trr8NEoq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697c99fb-c41a-4782-cad4-08d90ecc941b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 07:16:46.9387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1sqYY0ohQ6tGVKa1/0LQ7efUuRapZ0+hHSVoXF8DDgeqCYJHnAlzlGRtzxws73SXWhQgAy6LLUeZKNXCqtLAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5669
X-Proofpoint-ORIG-GUID: 612kKlLYpmEWqruRReytoHMpgH-KU2hA
X-Proofpoint-GUID: 612kKlLYpmEWqruRReytoHMpgH-KU2hA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-04_02:2021-05-04,2021-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=939 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, April 24, 2021 1:32 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: Re: [PATCH v4] iio: adis16480: support burst read function
>=20
> On Thu, 22 Apr 2021 12:37:35 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Some supported devices support burst read function. This provides a
> method
> > for reading a batch of data (status, temperature, gyroscopes,
> > accelerometers, time stamp/data counter, and CRC code), which
> does not
> > require a stall time between each 16-bit segment and only requires
> one
> > command on the DIN line to initiate. Devices supporting this mode
> > are:
> >
> >  * adis16495-1
> >  * adis16495-2
> >  * adis16495-3
> >  * adis16497-1
> >  * adis16497-2
> >  * adis16497-3
> >
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Looks good to me.  Give me a poke if I seem to have lost it when
> the dependency is in place.
>=20

poking :) ...

- Nuno S=E1
