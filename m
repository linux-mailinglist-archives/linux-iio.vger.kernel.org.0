Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3029135BADF
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhDLHeB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 03:34:01 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:22990 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236903AbhDLHd7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 03:33:59 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13C7UUDV010382;
        Mon, 12 Apr 2021 03:33:07 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 37u5sbmcy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 03:33:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh929LkiqwxwsbapJLKHtW63Ru2UnkrhLqVTi4CPBfRazYNmEfH3qgT3qzenQZp3QOXvZQQPKKABebBvZgmRh/XeWgIAhWPmuyR9Dz97n2liLWkeeMbwrbN2t6Wr7e+QdFE67sxNWiPJu5RZkPYw3JJtzHETvsXJtVCBLyuHFNnuRustZno+XM2TncBsko9A+watmJF5+nnXTvtnnciXpFE+Om5O/n1dzCuNnREZZ135assg/xZP6ZP/icBB5+vLladBut4C6nI+yr+gJzKjC+/uh1wXPqHXnabBGqkMolML25DCK8ILhbIitTMBrJfV89+mrPYPNv7pjDztZjzrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOBEm9snXh0UcRv+DIqijGXsDCH79FgTQA4dAKdraVI=;
 b=BQjy5VOaFDgHzt4s6xtQ6AB4o6yO4x5eZRkRuQZ1/62E9TeCU7rDmGzcR9woJa2DwJtrOLcMxszLy7nlaYDsYQWvJ93TabNa8O4Sewl70n1POpNG1M9CLFLy15AQbVf8MwMSC4zpFXktDmrPzfd2psQqzn5yyTNo+aThEeQ0HQ+iy4RdOsWMg82PiVh9UzfboEVQ52xNSYJF96VK2pWhvlFuSB8C+G3uBfMEiCuIffzXi7p606ZmgO9n7yBpzDryvUhhlzrvwfec5m/9p5p5Pnf8nC6vwT0v/FwOtsZ97XJ8w3TIjV45UgD/pewkh72mh/KkakPIeoWRuUZtrvDsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOBEm9snXh0UcRv+DIqijGXsDCH79FgTQA4dAKdraVI=;
 b=h2U/DBhkS2Mb5OqN5bb89rH5NVYNPAAzmXLA6NHJcGcb6CgcGNBvJIjoDCLSKUTw5vcFQPjMGdeAWAJg/n+bA2dmruJv5dM8erNb/RIrIVBnXBnHCNdWkEa7lra2mPEFFQlYjCLiy1fiJ6BXSadpdCPDKPqMzgnBkzJYcHRhCNo=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB2421.namprd03.prod.outlook.com (2603:10b6:903:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Mon, 12 Apr
 2021 07:33:03 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 07:33:03 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v2] iio: adis16480: support burst read function
Thread-Topic: [PATCH v2] iio: adis16480: support burst read function
Thread-Index: AQHXLExt4RkTB8RpdkmyntLgj7Js16qvaIMAgAEYTNA=
Date:   Mon, 12 Apr 2021 07:33:03 +0000
Message-ID: <CY4PR03MB3112C03AD3DDF60A10F0018699709@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210408075643.70183-1-nuno.sa@analog.com>
 <20210411154002.159c4018@jic23-huawei>
In-Reply-To: <20210411154002.159c4018@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNGU3MTdmNGEtOWI2MS0xMWViLThiMzctZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDRlNzE3ZjRiLTliNjEtMTFlYi04YjM3LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTE3OTIiIHQ9IjEzMjYyNjg2Mz?=
 =?iso-8859-1?Q?gwNjIwMDg1MiIgaD0icDIyR2lpd0dYSkI2YkxUdlhiRE1QeGdYREdZPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBSVlEQUFBVXZOY1FiaS9YQWJXaXJFb1JmbUd3dGFLc1NoRitZYkFGQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQVdBd0FBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUVBQVFBQkFBQUFiSlBTZFFBQUFBQUFBQUFBQUFBQUFK?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [62.216.206.139]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dd84ec0-428a-4f55-f556-08d8fd853501
x-ms-traffictypediagnostic: CY4PR03MB2421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB242150D0D896A33AF5C35CF899709@CY4PR03MB2421.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uf8as15apYEPFiKBAporX9cazW48ScAGv/2YPsoPFrqhbUo9ZkxoXhwKjk7BSymiq8Sq6ItQ9IzmJJYKvyOOeQDopYolENM742Z/M9dWEwe+/EJdZtyzVYsx3AoqgHySfKeflcfK2K4qcb4t5zwJAFWGgPi0kkRPOwajLu001cCw7mDYZyFpPK02uFmbZ2M0FUgLC+k06YkZlLiABiI1yTbVylkKsvL3c6/nkBoyODCfQT3ZKLmayBKzJ6VsJYaMeb99L/D/GGfXd8WFoNrfp9imRQvgyGWodErsgr6SokRMKXvv5TBrgrzu0pcwPrV3XZ3h/pnJfVwwpTYZ+b5NBYLbny3PkpTh1tb8JXfzUWNAMuqPlQOTQxNfP1VLvkS/WFw0Slh4UB5m4DxwxnOxU1AGx2jHf98l5fLNC0lEwI3d5SXwBLpajNfD4wmAUHSbRSjRuKGyIDHojdeD2zISvYkK/XnReopWFJuV66jN6HChp0LuM0/Ek5vKwF6qGvjbzo2Oi9frprqCgXjGMvydc+ZjdVHEsM3KqHblSSL3QXGdt1WIbagMZMjq4VBh7r4CeDapsf8+mduz576XbWsuK1saKAOYF9ehUMtwuqkTHutSewNDCkqp4i3LbLsQluMDD7ZtLh1vbNqyAuyEYdx3QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(64756008)(66556008)(52536014)(26005)(33656002)(66446008)(186003)(38100700002)(66476007)(5660300002)(2906002)(53546011)(316002)(83380400001)(66946007)(4326008)(71200400001)(8936002)(54906003)(6916009)(6506007)(76116006)(478600001)(7696005)(55016002)(30864003)(86362001)(9686003)(8676002)(87944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?MFlJFvZz+GzR77n943ZFKWJd5W0gyQAjLDT0YsWoIv5ADsYK+94F4AJypP?=
 =?iso-8859-1?Q?+BJJu1tyXjcsTPRfsRQXNoXQYszSsDCpv3xb7S50zEeRPLjH4+XlpwjjZx?=
 =?iso-8859-1?Q?1IB9EEV0NPRFQnL60erUe2itO2wGPr1JxzoUJVrqidK5shJr/sc94vRBFF?=
 =?iso-8859-1?Q?qPb+yCIKh8DMFcIceYG0/OpnOIoYN154eAHIt35FPCmUr0C2PndVCC2MPZ?=
 =?iso-8859-1?Q?qqMYKYNeOPjzCAtOvm87JDJaDlkvCTbPHJhuF/MMw0l84Byy48SKPV3Kdr?=
 =?iso-8859-1?Q?lFqGTx8OARBEn9F6QuX2OQlYy4Jb11na8VXFmV8W1Cd0vHA8QeQVa2EfWU?=
 =?iso-8859-1?Q?qKqmN5omP3h3K0NnhpOYeebbO1/9Hc/mmmIkEzqDKim/4tbkVJU41t2a15?=
 =?iso-8859-1?Q?o2NaPqnpeY3wjj32V48IFyc5qmlKcPQUazAqVTrElh/KG2SsxSl/6xwZIi?=
 =?iso-8859-1?Q?9HKDddeI/TyV7kcGP2MVw8+kBrq3gITlsrbh4rhkUg1tEcNpOl0PWuSz2y?=
 =?iso-8859-1?Q?AYkCxNZEYyxeTMUp9d5nqmFkX06tSm+C6neK7wUiCHo4epZfPqDb6gO675?=
 =?iso-8859-1?Q?x636YOmNBkQ9mqGUC0tBEKlo0ZbqDRU+zqEgpvhvFouxC1pic/vr5245lL?=
 =?iso-8859-1?Q?54hm6qP7kkWk5YANewe7KrK81Aj/0dFchuaj7UvH1Apn5uleWEzNtZHIKC?=
 =?iso-8859-1?Q?pGU9ffNT2ZdzfO7+vVJm1YwhpldVMicYBynfjesb2i8NzOlOd2G2q+HJZJ?=
 =?iso-8859-1?Q?ayKgqNVHATosGUIwnShLhXi+NWL8LaNvSk6xtARKMaxjNHVwT/oWnAzfXG?=
 =?iso-8859-1?Q?lpCCf0H6E/vSGQBSvGMNLZTa0KmMIc+KSWqOPLJ2QRs4jbEvQJINwPb8/D?=
 =?iso-8859-1?Q?lSUPdRbRNVgST6gfL7RP4UyinoJ+VyXPaFVQIABMm8xv6mZT4PGiStdPn8?=
 =?iso-8859-1?Q?fwvKu32yQvsIwtsFldzrA2zRjbhFO/u3BZ1gXZlDE+xK8hZ3mxqS0FcO/k?=
 =?iso-8859-1?Q?NQ5z80NshKtPDS7zqdfjECIgKVFOenwbZmvujXAsXM50nSgrTbFVMh7Kiw?=
 =?iso-8859-1?Q?RKK8VZCqfYkOxRm8cSNCFsR04+7FxhqYlo3xuMtAMv69jMImq3jyu8Uw3K?=
 =?iso-8859-1?Q?stxk1pqYvo6rGY+NQlJpoDG1UEpwCbdVp0XQnTHbk9VaMMvEqlSDezRThq?=
 =?iso-8859-1?Q?pVh6TJELaDSv4NMDC+2bO0gzgyG/MyVv72ulomGc9v1njiEiM/3iAQ/Q+w?=
 =?iso-8859-1?Q?LE7R1XEAPFpNiAKrMRrs8Ac7yoBC3PLooPnaX3W4onUhJeaxhwWUmaG3Zm?=
 =?iso-8859-1?Q?7mFtJOpJl6NhpPjlaly8n4sXPZe2/M+PoIIHkSI6baeNeXE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd84ec0-428a-4f55-f556-08d8fd853501
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 07:33:03.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ty9gYEElkf3+LXdQRd9BQZ7r71uogg6/R6RKBylCLDllC+wFNHE4C5LWQQBVmGLCcjzU1dHTpykKOlmbPtbhLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2421
X-Proofpoint-GUID: VeLXP939tG_cZ6exzt1uCcq9uC0SgqTG
X-Proofpoint-ORIG-GUID: VeLXP939tG_cZ6exzt1uCcq9uC0SgqTG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_04:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120048
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, April 11, 2021 4:40 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: Re: [PATCH v2] iio: adis16480: support burst read function
>=20
>=20
> On Thu, 8 Apr 2021 09:56:43 +0200
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
> >   * adis16495-1
> >   * adis16495-2
> >   * adis16495-3
> >   * adis16497-1
> >   * adis16497-2
> >   * adis16497-3
> >
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Small issue with return values in the trigger handler and
> some stylistic comments.
>=20
> Otherwise, looks good to me.
>=20
> > ---
> > Changes in v2:
> >  * Return right away if offset =3D=3D 4 (no valid transition found from
> > brurst_id to sys_flags)
> >
> >  drivers/iio/imu/adis16480.c | 161
> +++++++++++++++++++++++++++++++++---
> >  1 file changed, 148 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> > index f81b86690b76..b782070a27f5 100644
> > --- a/drivers/iio/imu/adis16480.c
> > +++ b/drivers/iio/imu/adis16480.c
> > @@ -5,6 +5,7 @@
> >   * Copyright 2012 Analog Devices Inc.
> >   */
> >
> > +#include <linux/crc32.h>
>=20
> Hmm. The ordering here is a bit odd so I guess this doesn't
> really matter, but seems strange to have something so specific as
> crc32.h as the first header included when it's not the first one
> alphabetically.

Yeah, it was not ordered already, so I didn't cared much. I will move more
to the middle...

> >  #include <linux/clk.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/of_irq.h>
> > @@ -19,11 +20,14 @@
> >  #include <linux/sysfs.h>
> >  #include <linux/module.h>
> >  #include <linux/lcm.h>
> > +#include <linux/swab.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/imu/adis.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >
> >  #include <linux/debugfs.h>
> >
> > @@ -103,6 +107,12 @@
> >   * Available only for ADIS1649x devices
> >   */
> >  #define ADIS16495_REG_SYNC_SCALE
> 	ADIS16480_REG(0x03, 0x10)
> > +#define ADIS16495_REG_BURST_CMD
> 	ADIS16480_REG(0x00, 0x7C)
> > +#define ADIS16495_BURST_ID			0xA5A5
> > +/* total number of segments in burst */
> > +#define ADIS16495_BURST_MAX_DATA		20
> > +/* spi max speed in burst mode */
> > +#define ADIS16495_BURST_MAX_SPEED              6000000
> >
> >  #define ADIS16480_REG_SERIAL_NUM
> 	ADIS16480_REG(0x04, 0x20)
> >
> > @@ -163,6 +173,8 @@ struct adis16480 {
> >  	struct clk *ext_clk;
> >  	enum adis16480_clock_mode clk_mode;
> >  	unsigned int clk_freq;
> > +	/* Alignment needed for the timestamp */
> > +	__be16 data[ADIS16495_BURST_MAX_DATA] __aligned(8);
> >  };
> >
> >  static const char * const adis16480_int_pin_names[4] =3D {
> > @@ -863,7 +875,7 @@ static const char * const
> adis16480_status_error_msgs[] =3D {
> >
> >  static int adis16480_enable_irq(struct adis *adis, bool enable);
> >
> > -#define ADIS16480_DATA(_prod_id, _timeouts)
> 	\
> > +#define ADIS16480_DATA(_prod_id, _timeouts, _burst_len)
> 		\
> >  {									\
> >  	.diag_stat_reg =3D ADIS16480_REG_DIAG_STS,			\
> >  	.glob_cmd_reg =3D ADIS16480_REG_GLOB_CMD,
> 		\
> > @@ -887,6 +899,8 @@ static int adis16480_enable_irq(struct adis
> *adis, bool enable);
> >  		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),
> 	\
> >  	.enable_irq =3D adis16480_enable_irq,				\
> >  	.timeouts =3D (_timeouts),					\
> > +	.burst_reg_cmd =3D ADIS16495_REG_BURST_CMD,
> 	\
> > +	.burst_len =3D (_burst_len),					\
> >  }
> >
> >  static const struct adis_timeout adis16485_timeouts =3D {
> > @@ -931,7 +945,7 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.int_clk =3D 2460000,
> >  		.max_dec_rate =3D 2048,
> >  		.filter_freqs =3D adis16480_def_filter_freqs,
> > -		.adis_data =3D ADIS16480_DATA(16375,
> &adis16485_timeouts),
> > +		.adis_data =3D ADIS16480_DATA(16375,
> &adis16485_timeouts, 0),
> >  	},
> >  	[ADIS16480] =3D {
> >  		.channels =3D adis16480_channels,
> > @@ -944,7 +958,7 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.int_clk =3D 2460000,
> >  		.max_dec_rate =3D 2048,
> >  		.filter_freqs =3D adis16480_def_filter_freqs,
> > -		.adis_data =3D ADIS16480_DATA(16480,
> &adis16480_timeouts),
> > +		.adis_data =3D ADIS16480_DATA(16480,
> &adis16480_timeouts, 0),
> >  	},
> >  	[ADIS16485] =3D {
> >  		.channels =3D adis16485_channels,
> > @@ -957,7 +971,7 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.int_clk =3D 2460000,
> >  		.max_dec_rate =3D 2048,
> >  		.filter_freqs =3D adis16480_def_filter_freqs,
> > -		.adis_data =3D ADIS16480_DATA(16485,
> &adis16485_timeouts),
> > +		.adis_data =3D ADIS16480_DATA(16485,
> &adis16485_timeouts, 0),
> >  	},
> >  	[ADIS16488] =3D {
> >  		.channels =3D adis16480_channels,
> > @@ -970,7 +984,7 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.int_clk =3D 2460000,
> >  		.max_dec_rate =3D 2048,
> >  		.filter_freqs =3D adis16480_def_filter_freqs,
> > -		.adis_data =3D ADIS16480_DATA(16488,
> &adis16485_timeouts),
> > +		.adis_data =3D ADIS16480_DATA(16488,
> &adis16485_timeouts, 0),
> >  	},
> >  	[ADIS16490] =3D {
> >  		.channels =3D adis16485_channels,
> > @@ -984,7 +998,7 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.max_dec_rate =3D 4250,
> >  		.filter_freqs =3D adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode =3D true,
> > -		.adis_data =3D ADIS16480_DATA(16490,
> &adis16495_timeouts),
> > +		.adis_data =3D ADIS16480_DATA(16490,
> &adis16495_timeouts, 0),
> >  	},
> >  	[ADIS16495_1] =3D {
> >  		.channels =3D adis16485_channels,
> > @@ -998,7 +1012,9 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.max_dec_rate =3D 4250,
> >  		.filter_freqs =3D adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode =3D true,
> > -		.adis_data =3D ADIS16480_DATA(16495,
> &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data =3D ADIS16480_DATA(16495,
> &adis16495_1_timeouts,
> > +
> ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16495_2] =3D {
> >  		.channels =3D adis16485_channels,
> > @@ -1012,7 +1028,9 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.max_dec_rate =3D 4250,
> >  		.filter_freqs =3D adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode =3D true,
> > -		.adis_data =3D ADIS16480_DATA(16495,
> &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data =3D ADIS16480_DATA(16495,
> &adis16495_1_timeouts,
> > +
> ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16495_3] =3D {
> >  		.channels =3D adis16485_channels,
> > @@ -1026,7 +1044,9 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.max_dec_rate =3D 4250,
> >  		.filter_freqs =3D adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode =3D true,
> > -		.adis_data =3D ADIS16480_DATA(16495,
> &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data =3D ADIS16480_DATA(16495,
> &adis16495_1_timeouts,
> > +
> ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16497_1] =3D {
> >  		.channels =3D adis16485_channels,
> > @@ -1040,7 +1060,9 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.max_dec_rate =3D 4250,
> >  		.filter_freqs =3D adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode =3D true,
> > -		.adis_data =3D ADIS16480_DATA(16497,
> &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data =3D ADIS16480_DATA(16497,
> &adis16495_1_timeouts,
> > +
> ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16497_2] =3D {
> >  		.channels =3D adis16485_channels,
> > @@ -1054,7 +1076,9 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.max_dec_rate =3D 4250,
> >  		.filter_freqs =3D adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode =3D true,
> > -		.adis_data =3D ADIS16480_DATA(16497,
> &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data =3D ADIS16480_DATA(16497,
> &adis16495_1_timeouts,
> > +
> ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  	[ADIS16497_3] =3D {
> >  		.channels =3D adis16485_channels,
> > @@ -1068,10 +1092,121 @@ static const struct adis16480_chip_info
> adis16480_chip_info[] =3D {
> >  		.max_dec_rate =3D 4250,
> >  		.filter_freqs =3D adis16495_def_filter_freqs,
> >  		.has_pps_clk_mode =3D true,
> > -		.adis_data =3D ADIS16480_DATA(16497,
> &adis16495_1_timeouts),
> > +		/* 20 elements of 16bits */
> > +		.adis_data =3D ADIS16480_DATA(16497,
> &adis16495_1_timeouts,
> > +
> ADIS16495_BURST_MAX_DATA * 2),
> >  	},
> >  };
> >
> > +static bool adis16480_validate_crc(const u16 *buf, const u8 n_elem,
> const u32 crc)
> > +{
> > +	u32 crc_calc;
> > +	u16 crc_buf[15];
> > +	int j;
> > +
> > +	for (j =3D 0; j < n_elem; j++)
> > +		crc_buf[j] =3D swab16(buf[j]);
> > +
> > +	crc_calc =3D crc32(~0, crc_buf, n_elem * 2);
> > +	crc_calc ^=3D ~0;
> > +
> > +	return (crc =3D=3D crc_calc);
> > +}
> > +
> > +static irqreturn_t adis16480_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct adis16480 *st =3D iio_priv(indio_dev);
> > +	struct adis *adis =3D &st->adis;
> > +	int ret, bit, offset, i =3D 0;
> > +	__be16 *buffer;
> > +	u32 crc;
> > +	bool valid;
> > +	const u32 cached_spi_speed_hz =3D adis->spi->max_speed_hz;
> > +
> > +	adis_dev_lock(adis);
> > +	if (adis->current_page !=3D 0) {
> > +		adis->tx[0] =3D ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
> > +		adis->tx[1] =3D 0;
> > +		ret =3D spi_write(adis->spi, adis->tx, 2);
> > +		if (ret) {
> > +			dev_err(&adis->spi->dev, "Failed to change
> device page: %d\n", ret);
> > +			adis_dev_unlock(adis);
> > +			return ret;
>=20
> This is an interrupt handler, you should be careful what you return
> as they will be treated as irqreturn_t not ints.
>=20
> return IRQ_HANDLED even in error paths.

Hmm, yeah, this is definitely not ok. Also imposes the question if we shoul=
d
call ' iio_trigger_notify_done()' in these error paths? I'm pending to do i=
t as
it might be a big assumption to say the device is 'broken' if some spi tran=
sfer
fails...

Not doing it means we will never receive another irq (I think this is also =
true if
we do not return IRQ_HANDLED)...

Also need to check other places as I'm fairly sure we have this problem (at=
 least)
in the adis16475 driver...
> > +		}
> > +	}
> > +
> > +	adis->spi->max_speed_hz =3D ADIS16495_BURST_MAX_SPEED;
> > +
> > +	ret =3D spi_sync(adis->spi, &adis->msg);
> > +	if (ret) {
> > +		dev_err(&adis->spi->dev, "Failed to read data: %d\n",
> ret);
> > +		adis_dev_unlock(adis);
> > +		return ret;
> > +	}
> > +
> > +	adis->spi->max_speed_hz =3D cached_spi_speed_hz;
> > +	adis->current_page =3D 0;
>=20
> Does it make more sense to move this to just after we changed the
> page?

Yes, it does. If the second spi transfer fails, we already moved to page 0
but did not updated this variable...

- Nuno S=E1
