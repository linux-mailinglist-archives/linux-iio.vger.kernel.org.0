Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30F13E8B3F
	for <lists+linux-iio@lfdr.de>; Wed, 11 Aug 2021 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhHKHxK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 03:53:10 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:45316 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233850AbhHKHxJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 03:53:09 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B7oh4w030525;
        Wed, 11 Aug 2021 03:52:33 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 3ab64xwbxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 03:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ/HHrTUfxZUFi9+MyUggCWtnQBVlmh2wrc22dxz4v44jMN0S2TekQlvPsOSRO20jJNCYGZhLwge34F+tFpIlCMyndomt+YZRe4ygfW5g2dgKLFxOAKotvd4g9b4zyLVlnVcYj2sOPyFXFYLtBOOwvRffKkgztHbhBj0JpqiwzdJnQKrNPZKUnSygE5n/P6CWvgzaWNMRSBkoAMGHz/zfAmsZXBhsiKRh6ZPBlBDGw+CAFppOUYweZwiUm3cGT+Ir0i+vyvBd3kN5gpBNLyUsnlKa0aHhil562rxWbMLdZixREAHnIi2RajNss3zE0SMsXsggqhsM/IWE0JihSVEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR9TGm53iq5AJUz9e/IcWEcZ4r9eb2spb9lZpEK4zEg=;
 b=B+3qCsETslgoFAXdmf1ERBVVs606IexLsTcqQgvX0QqRACXKdPl9jUoH8IfLb1EsG6dMxHbhhl9brCvaMrUZIV7YZYTSyYGrd3YO37Ls78vB7m1wo8R3Q7VO/uRD1FBET5ExffKeWf6+FxfFtb6PjeCM5jWDyCA4T3YHNy7ChqTn7DjPCvgOD4CZqwtILZmHTMm0WSU6XxVYxP1RiVQsl46uZV2B8uw8nEHo2M7gkLoYcHzO3EdYeKopp+98rUFuiy2abrEGH4mI3C/4vMdWsM8jNMaTo5BfCW1KKuLulyRAU9EmlWO2JXyyhkFYjqFw+KQeAp8aCfUt2hwkPckE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR9TGm53iq5AJUz9e/IcWEcZ4r9eb2spb9lZpEK4zEg=;
 b=RhdlYsMfEwX5tu6ap1DcQ7fDZAr0t8rW26HyMwDoAc88VkWduoKX63mum1DNqS010d9zIqDEvSq44TxPmkvO8NAPv/9qCrzOmV9HWbLDxvyxXLiHbS/fM+U4nw+mkzi8bMX35xihPpeYCWA2fWxj4IB7UiCThql687rU4DytpwI=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5927.namprd03.prod.outlook.com (2603:10b6:510:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 07:52:31 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 07:52:31 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Drew Fustini <drew@pdp7.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        =Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH 1/1] iio: ltc2983: fix device probe
Thread-Topic: [PATCH 1/1] iio: ltc2983: fix device probe
Thread-Index: AQHXjfemPNxIy2g6a06Ig/hxF4Z+gattSvAAgACi+KA=
Date:   Wed, 11 Aug 2021 07:52:31 +0000
Message-ID: <PH0PR03MB6366A98EBCC93CBC5E1B16D999F89@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210810145653.295397-1-nuno.sa@analog.com>
 <20210810145653.295397-2-nuno.sa@analog.com> <20210810220240.GA2813710@x1>
In-Reply-To: <20210810220240.GA2813710@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMTMyN2E5MzEtZmE3OS0xMWViLThiODUtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDEzMjdhOTMyLWZhNzktMTFlYi04Yjg1LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iNDc3NSIgdD0iMTMyNzMxNDE5ND?=
 =?iso-8859-1?Q?k1NDY4NjA3IiBoPSIzejU1QjJybko5V3A5c3RMblVvTmRMWk1wWUE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUEvam8vVmhZN1hBVlVVbUVQenhLdlZWUlNZUS9QRXE5VUZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUJPWUdjZ0FBQUFBQUFBQUFBQUFBQUo0?=
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
authentication-results: pdp7.com; dkim=none (message not signed)
 header.d=none;pdp7.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11779616-b34d-48c0-b536-08d95c9cf967
x-ms-traffictypediagnostic: PH0PR03MB5927:
x-microsoft-antispam-prvs: <PH0PR03MB5927AEA1FD4792A745A36A0299F89@PH0PR03MB5927.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U16tGRz96C/2GrmYv0+d2dfJotO/+x8Eqh6pporsiNiSmW4HsP3I5ANblphmRPfe1TEoqJQXUOxiQTWzsA5XpQvJufLLYZ1QhxYGB97MLeuBdxFwG7O6DmQpKt+6vtDbcPipyPecqaeohoku3GANCkRaBm/YWbj+7/E2a3tBoHNN2+L50tHqAiMj+Tk9yhT7LEjiw+DFE6mbC/W/qCqEdrqTbkIxUr0LPf0wOFAchOAtvwRXzaZKdF7bRP+9iFyu7Jjn1Enm5d+Tt98JXYNmAq18lh7asS3NxxY2liZfXOPithfle35Aj7D2B7FTz/78dquftU5sKzEA8euP0Q1m3rpPHHiBUJH0BkUQjqN9i8kK80sGHFuYvaly5NoZyDlc7b3THuFTpVcfYAP00AkKNJdwKeX7U5ICSzG5DWFQKtQnJLdskgf9oEN+5ceIviDQBDnuF8IDj/MJ1vHULOce8rhIa9Be8hHCDkfwLlhATa+3LKgLo4rJxloOMjg0wtcYJFUdwVD0XeGCx6JGRN3EMBhfN1I2ZaUzspE+pbKYCBernaEnd7zNDwFLmhfTFrjDNhWaJ0easZ9loeS5ad9jb0atcVmXINJFSczUmhHkC6xkkLP3MqBM0ekNQ2GgZoU4bgrH/zWohggwBRJdzhW7qFJY78kaCBGR3OlziSaedVHga96VZhoSoOdo11hDqFuMlz/YgRar8lWwFa0bXDdrfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(76116006)(122000001)(9686003)(66946007)(4326008)(55016002)(2906002)(64756008)(52536014)(66556008)(66446008)(54906003)(316002)(6916009)(38100700002)(66476007)(26005)(186003)(86362001)(478600001)(8676002)(6506007)(71200400001)(7696005)(83380400001)(33656002)(5660300002)(38070700005)(8936002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rvPlSey6OzbsecMPr0QpLdmP1Fo47M1RarHkzd8etENpztMmpFW/aJVwLF?=
 =?iso-8859-1?Q?LUxBY4ZQbaaMYD2fHrNf6ewiHbRZZ7WBg4asDmvHmppua0X0FINRg6TlEN?=
 =?iso-8859-1?Q?ah7xYDacwSJ6VzFZUvgWouSJoxFR+1HYu8TzIPF5hIaHclDBnJvyE8Qqn/?=
 =?iso-8859-1?Q?OD5+8sNrWTLq5kypX5HLUuJxF4FfVkzprLYg/TrlrxSAzxAnI9fpcvTQnM?=
 =?iso-8859-1?Q?/NpQj+xBeCzKXoEMIL2HGbP0nlFeB+OJp6B/8gQ0VF4NRdWuVFs6A4pB4S?=
 =?iso-8859-1?Q?t/pbMOe8u4WYD0R8qNDDiZsKexK+nQ5izK1tyrC/oG818hpViW1drdwBYX?=
 =?iso-8859-1?Q?i42dw5dWLvklrjGZh4cFNKognmWOYotgg1alcVj1ZnjsZtyxE7KINDcErJ?=
 =?iso-8859-1?Q?b9FlBIslX7DJDTbj/wmUeQHHoUiF1fOY0tZbP/RfyFeDetliPELTMWY9/r?=
 =?iso-8859-1?Q?fXrBLFihmpvNGY7wgbBUZ20dGCQw/jsMkJexAqNaRMGbK1agUG8KfdJF3L?=
 =?iso-8859-1?Q?QSCnPw4U+oIhsp4Mj27bmbio7syvRUfOHlMBTzRk5oibiNt6fgEn/9nNN7?=
 =?iso-8859-1?Q?1SqmzRG7G6h5YB5byx6wczQdzdlmEucegLvDAq/FF8I7xm8cl1GXDIF4Wz?=
 =?iso-8859-1?Q?FbXjdQprzc079tlV9enJsnzd7yrAhNq3+JeIheyj00JxvCN8YSJgBwpW2b?=
 =?iso-8859-1?Q?/hsMG8/Gs5HODlcM4TZFANZWcJgJwlJLgasrbb0mRltT4SDBuXIqvthCQ2?=
 =?iso-8859-1?Q?AfPRfDyWDtNfqKZ/FoS+7iu1WTOsJ4Iagx1ZfyhbDW21Bb6RcEpYyR9sBg?=
 =?iso-8859-1?Q?bF/YwB43UgC4JvkZs9tdrOqfDMBMC/jgpZ7gbzBdS4YKMpwoBzbv/bfobw?=
 =?iso-8859-1?Q?JyPViulp2MsVE4Lbz+A9IvsGIBBcPkJBBMFygwOK/XEfTsPpxoa3mTJdP9?=
 =?iso-8859-1?Q?Dnnc83dHvR94u9gmE1VtpefiEAhsi1nUPHVTbP3pgX9cVys8JOXXESIgsV?=
 =?iso-8859-1?Q?fcnAss1skCcBmGOZd0xaYhN+xcvBj4MDxUD1Vf/u4o+AHtgEKzH9M7rqc9?=
 =?iso-8859-1?Q?rbnIIuMRup+1cd69yFTRWh6fpY7u0T7/ZdNzrs1msn5nDqQmIigXRhkuMO?=
 =?iso-8859-1?Q?qEzSKSTe2EM3Bbs7qK2AsiXJHFQoSV3P0AzQnVsJvR/7/wnda34ELITPdk?=
 =?iso-8859-1?Q?9xsCD0m3tq1YFhibYzNzXdLFqx8oU+uWZlW4NIKXJeEzyukzpQIKuOnElm?=
 =?iso-8859-1?Q?ohFypav1u5sugYxqgIQ5yd3U7vruavshBnU8E5XO4oy9tL4s+uiuCPc6pk?=
 =?iso-8859-1?Q?O2KAZ0UQJipdwMY4kPN3HgdFxXLscV9bO61b4AMlwZJENDouzHMXVCGC/U?=
 =?iso-8859-1?Q?OlkkmvxqpK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11779616-b34d-48c0-b536-08d95c9cf967
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 07:52:31.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPspnCw8A7getJc2zxt3gh5YdpVV0X3MllVWWCkqx3EgsvEsfuhLEbaOVignccorvCxcPPTnPMvxm8C0db8B3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5927
X-Proofpoint-GUID: ZrdsLo6JG0_Pw9E9MqKC9ic8Owi6LDLM
X-Proofpoint-ORIG-GUID: ZrdsLo6JG0_Pw9E9MqKC9ic8Owi6LDLM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_02:2021-08-10,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110051
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Drew Fustini <drew@pdp7.com>
> Sent: Wednesday, August 11, 2021 12:03 AM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; =3DJonathan Cameron <jic23@kernel.org>;
> Lars-Peter Clausen <lars@metafoo.de>
> Subject: Re: [PATCH 1/1] iio: ltc2983: fix device probe
> =20
> On Tue, Aug 10, 2021 at 04:56:53PM +0200, Nuno S=E1 wrote:
> > There is no reason to assume that the irq rising edge (indicating that
> > the device start up phase is done) will happen after we request the
> irq.
> > If the device is already up by the time we request it, the call to
> > 'wait_for_completion_timeout()' will timeout and we will fail the
> device
> > probe even though there's nothing wrong.
> >
> > This patch fixes it by just polling the status register until we get th=
e
> > indication that the device is up and running. As a side effect of this
> > fix, requesting the irq is also moved to after the setup function.
> >
> > Fixes: f110f3188e563 ("iio: temperature: Add support for LTC2983")
> > Reported-by: Drew Fustini <drew@pdp7.com>
> > Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> > ---
> >  drivers/iio/temperature/ltc2983.c | 31 +++++++++++++++++++------
> ------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/temperature/ltc2983.c
> b/drivers/iio/temperature/ltc2983.c
> > index 3b5ba26d7d86..c6c4877bdcff 100644
> > --- a/drivers/iio/temperature/ltc2983.c
> > +++ b/drivers/iio/temperature/ltc2983.c
> > @@ -89,6 +89,8 @@
> >
> >  #define	LTC2983_STATUS_START_MASK	BIT(7)
> >  #define	LTC2983_STATUS_START(x)
> 	FIELD_PREP(LTC2983_STATUS_START_MASK, x)
> > +#define        LTC2983_STATUS_UP_MASK	GENMASK(7, 6)
> > +#define        LTC2983_STATUS_UP(reg)
> 	FIELD_GET(LTC2983_STATUS_UP_MASK, reg)
> >
> >  #define	LTC2983_STATUS_CHAN_SEL_MASK	GENMASK(4, 0)
> >  #define	LTC2983_STATUS_CHAN_SEL(x) \
> > @@ -1362,13 +1364,21 @@ static int ltc2983_parse_dt(struct
> ltc2983_data *st)
> >
> >  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> >  {
> > -	u32 iio_chan_t =3D 0, iio_chan_v =3D 0, chan, iio_idx =3D 0;
> > +	u32 iio_chan_t =3D 0, iio_chan_v =3D 0, chan, iio_idx =3D 0, status =
=3D 0;
> >  	int ret;
> > -	unsigned long time;
> > +	unsigned long time =3D 10;
> >
> >  	/* make sure the device is up */
> > -	time =3D wait_for_completion_timeout(&st->completion,
> > -					    msecs_to_jiffies(250));
> > +	do {
> > +		ret =3D regmap_read(st->regmap,
> LTC2983_STATUS_REG, &status);
> > +		if (ret)
> > +			return ret;
> > +		/* start bit (7) is 0 and done bit (6) is 1 */
> > +		if (LTC2983_STATUS_UP(status) =3D=3D 1)
> > +			break;
> > +
> > +		msleep(25);
> > +	} while (--time);
> >
> >  	if (!time) {
> >  		dev_err(&st->spi->dev, "Device startup timed out\n");
> > @@ -1492,10 +1502,11 @@ static int ltc2983_probe(struct spi_device
> *spi)
> >  	ret =3D ltc2983_parse_dt(st);
> >  	if (ret)
> >  		return ret;
> > -	/*
> > -	 * let's request the irq now so it is used to sync the device
> > -	 * startup in ltc2983_setup()
> > -	 */
> > +
> > +	ret =3D ltc2983_setup(st, true);
> > +	if (ret)
> > +		return ret;
> > +
> >  	ret =3D devm_request_irq(&spi->dev, spi->irq,
> ltc2983_irq_handler,
> >  			       IRQF_TRIGGER_RISING, name, st);
> >  	if (ret) {
> > @@ -1503,10 +1514,6 @@ static int ltc2983_probe(struct spi_device
> *spi)
> >  		return ret;
> >  	}
> >
> > -	ret =3D ltc2983_setup(st, true);
> > -	if (ret)
> > -		return ret;
> > -
> >  	indio_dev->name =3D name;
> >  	indio_dev->num_channels =3D st->iio_channels;
> >  	indio_dev->channels =3D st->iio_chan;
> > --
> > 2.32.0
> >
>=20
> I have tested this on my custom Zynq-7000 board and the probe
> completes
> okay. The read of LTC2983_STATUS_REG returns 0x40 on the first
> attempt
> which is good. I am also able to read channels through sysfs. I have not
> tried suspend and resume as that is not configured on this system.

Hi,

Thanks for testing. During my tests I kind of emulated this by adding
a devm_action which would put the device to sleep on the unbind path.
Hence, unbinding + binding the device will cause a sleep + wake up on it.
In this case I saw  ~75 ms for it to come up. I read some 0's, 0x80=20
(as specified in the datasheet) and lastly 0x40.


Jonathan, I noticed some odd indentation in the new defines. If there's
no other reason for a v2, it would be nice if you could fix this when apply=
ing :)

As a side note, I'm also aware that you prefer to see FIELD_{PREP|GET} appl=
ied
inline in the code but in this case I made it like this to be consistent wi=
th the=20
rest of the driver.

- Nuno S=E1
