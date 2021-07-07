Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6763BE451
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jul 2021 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGGI3p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Jul 2021 04:29:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6688 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbhGGI3p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Jul 2021 04:29:45 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678Qs22006038;
        Wed, 7 Jul 2021 04:27:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 39mehkwfeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 04:27:04 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1678R4Pi006111;
        Wed, 7 Jul 2021 04:27:04 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-00128a01.pphosted.com with ESMTP id 39mehkwfef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 04:27:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhoyEdw8d2/JfcCSf6uorcV4slCb3mwYjX9WyaaG/Vt8dJKVDf2QT74LEcjf+fAFIWur5Z2vi/bvVfei7RzO6q9pycl4gr2zS9r6phCVAkxJGAXp5xunSV/YjywmSDMR42ojZuh01CuBYIuRhUBzmUMuqTr0JsAj7kmMragd+fOrVzqRVZjn6wxvNFSRAI6A1qcBHj8QZB4oa7clx8gR3wvtMpj9s5CPR0OmsL/ij0Bs5t71CKVTI/nu4knJNeVjoEQCZRU/xkpUPADExZSSK9d/doG7jJAMd+uPs2pr7R8xhodGGVzLPaBygqLd9g3Fr7gtCLM2N6hnOHPquIKPoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAzraVx2KIw/OpokrjTAtxuqQ5uMSt0P+99p14GaCG0=;
 b=SF+Oifk5AqvAAoXc603YZ3JAeoAaZJCSoONewqT661tNuN/8mRlAi1ntcCZUktQBR/Gu5rXbv3r2Ai8PGWPYfy3HjK1DF+0mmlBP2KYkmcO/E2aP998Kv811VPUffOg222SwQ7JrgxP6SGfRPyZcCVPdCEZ2eOJVtdTwCXRVZVqC6bDJ9G4CnPKs/9mMCtsFWS8PZcw+5J1bOcZ49/pUaCUU0zXZq6CMVV0dMN6Je0qKLCccQ8w4SFtBdE/Bi8Ca7I1BlD7v43JeuoJUxcbBy/omV+6I72yBTOEN4MPIgL4/iV3ESMhWa6KYqfDQaktozXoJvtyQPAC8pvwovjIKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAzraVx2KIw/OpokrjTAtxuqQ5uMSt0P+99p14GaCG0=;
 b=FOH4+BoA+R16djemv2c/YXvJupA0rNXa919HX4S8U9XDq5UBulXaU9BWr/eG9W723Yl1udLDcA4C/EddOCG1zMDUtwliYig4RNJLi2s66gmyLEaRT/iByR0Rws/O8tGT2/lDMjvtKEhQWZIYyOZYLJvyVM2ptkA7/dZXcnX53Yw=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5798.namprd03.prod.outlook.com (2603:10b6:510:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 08:26:59 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Wed, 7 Jul 2021
 08:26:59 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v4 1/2] iio: frequency: adrf6780: add support for ADRF6780
Thread-Topic: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Thread-Index: AQHXbzN7IY9R84leFkqsPFMOIAAoUasxeo0AgAKyeUCAAYBQgIAAFNGggAFwxKA=
Date:   Wed, 7 Jul 2021 08:26:59 +0000
Message-ID: <PH0PR03MB6366BC5E806B18A8889EDDE9991A9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210702111239.174189-1-antoniu.miclaus@analog.com>
        <20210703175716.7864358a@jic23-huawei>
        <PH0PR03MB63667CCA2691D4A43F28041E991C9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210706100405.00001507@Huawei.com>
 <PH0PR03MB6366190FBDC12B1AD1CCBC43991B9@PH0PR03MB6366.namprd03.prod.outlook.com>
In-Reply-To: <PH0PR03MB6366190FBDC12B1AD1CCBC43991B9@PH0PR03MB6366.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMTZlOTEwNTMtZGVmZC0xMWViLThiNmYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDE2ZTkxMDU0LWRlZmQtMTFlYi04YjZmLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTUyNzQiIHQ9IjEzMjcwMTIwMD?=
 =?iso-8859-1?Q?E2ODg2NTIzOSIgaD0iTUIyNmxUSlNuakxncjRSQUdTVGpJd0xSMVpRPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBSVlEQUFEWFRWWFpDWFBYQVdrSlR2VHZCTExjYVFsTzlPOEVzdHdGQUFB?=
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
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f5d6b2d-83f6-43b8-c453-08d94120fd9a
x-ms-traffictypediagnostic: PH0PR03MB5798:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB5798F459E5E67C7A262F80C4991A9@PH0PR03MB5798.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MoKE2tOCikUaRZWj8zPY85xJO5dyVUew5m62cJy2y1T8kd8sg2hZAW48cxnrG5OGfOajq9QZpL+NbygajybOfHAxvTB2i97Io5qsSxCvCcBFVZ9oz2S6iC9htO38NPTNCVUIsBV3wikt6k05cmJuDlYL96gx2Ctp67FLdO/pDWgCoVzyEtTU7RetRAduujJ7iD7QJpFOeZ7dE9XEextSZMDjM+IYQnMKT0a/nQMNf0LuVw/Mr7R+CbuiJ1otYGxYfrRCwex7zW4K3eJm1q/GwGBsv8LZT8RBNPrDUiLf8zgwUdbNYFFmbn+GrTsjXtcFiqdRbejGJNODbbfMA9KGpBmioMQcVnyu9bP05iCcjh4IGRIkBOzeR4opUrA7mCIiiJsg5vhYcxyNbPpSbaqdOCNiB3WxAgkwOUEGoaY4CNC/QQhpIgACkM76GcM5px/lS6gEjhSkFoQGM3kjgpAFb7sed9pSJ8j7WOLcJAE6GSYjV6e905AUAQLhn8xZ4BD3yZP7WDYm+z7LFAV87WEm3wpvyd+52aN3z+xVKzhvkxjtFpU93p3m7qWiuk6ejH1HGNbvmAb3rPb9engTTYseJiNaF/T55PqFK6D1Kq0XnqBDdw6daLmEjDkTU8DhhV8d+1EAi+/S5Hcy+Wb2Iy2BGm9raRnjdy9kRgP18rDA9ifD2wAodNwLzXjGzqk2YRri8lWa4TOEC69ooQWNC0YFU6ERuBthjjejglGatrasJZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(4326008)(478600001)(83380400001)(55016002)(71200400001)(33656002)(110136005)(2906002)(6506007)(966005)(53546011)(54906003)(7696005)(52536014)(8936002)(8676002)(5660300002)(86362001)(38100700002)(122000001)(186003)(316002)(66946007)(66556008)(66446008)(64756008)(9686003)(66476007)(30864003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V4aNz9H5K5nr0quxFgNZ1C1PrSn1Ljr44HjqP/vfZxl4dqb9GdMbn5J/sc?=
 =?iso-8859-1?Q?Y/B3SGcH97iZqCin1veBoHjEhwfXXgy7dBPTKX3ghy/Bew1cuQnJf+c+K6?=
 =?iso-8859-1?Q?FfTSi3baZ62R87InpgHOOel6Q2aa3tSef7ldvWj9+tTtCA3VYOtPDAohdZ?=
 =?iso-8859-1?Q?E5qKjz4PZgMe45HjLgnKO9RgM41hoQCjGNU71j5nDaCpKDlWTc10LAJU7L?=
 =?iso-8859-1?Q?JGm3b07CfLbQjLCSJ1iDmOe5lE6v8b42YPtbzeNquaPfdbfT8QmJivDjaT?=
 =?iso-8859-1?Q?f1bboyleaujFjCzs1qxpdi9L5pXMb1MlJMI2ThnJ1au3fnuXMQc0pQxUJ2?=
 =?iso-8859-1?Q?B6Z9S2IF3Hx//JAPR0vpubRrX+3wh8loFkCWnGkIl2QDtfar06wCHUjqPD?=
 =?iso-8859-1?Q?Iwn7iysWhk91jq5hL9rxsmmAdt9VfIofIaQHDFGMW/EvosNayo9ZwDxfo+?=
 =?iso-8859-1?Q?25UHVIei+LkP1xSA2Ux+sbgfYRkRoUMXz18R+D0hEm2tGk++FvPWwFzWze?=
 =?iso-8859-1?Q?beNb9iWhcqoyK9/mgYW+jR4DITcKrV47CnItHZRrdz1GoKqSPPTuP1Vw9U?=
 =?iso-8859-1?Q?mdICs1PUIT2sPKCW+8fpm/+XWTpQDHXOKI+Q8ptOdTR7XepZBEnN6ANT5G?=
 =?iso-8859-1?Q?EF/JM7VSWIApGJ+klAnKjZ5GMF0DzF3jaYDGmsFb+KyXBBx1uH6T2nWybt?=
 =?iso-8859-1?Q?xqGWP3TF+aPJTankhwLVKvpQD2cxj4Pi8XJrH7+2Yal8Qw1cFvGf+lv3le?=
 =?iso-8859-1?Q?b9CNCU7yKEhqUdL1zHU00gSVJSUVXPJ1y4aSI7R789mmQ7Iz19Rhn7G0Mk?=
 =?iso-8859-1?Q?BIV2FN4xwlvTbB9DtrNqt3oNHhBcczVqujjBNUllhPfvYpp1Z86jPNiPgj?=
 =?iso-8859-1?Q?muvZnqwxZKwH8uswiIKuCIV41tDpgnIlW2mnXCwi1Ty9w+IQRy54Qk4dgF?=
 =?iso-8859-1?Q?XPDHA7cjvHqMfSocK8zfFGbf1SjEimz0I0jic3vmtV99iEJHAi+KIjmhF1?=
 =?iso-8859-1?Q?GVNj73uaOmnc4rUlYasKBgFONge5BuCQAB8Zu7XOCLHTlErHvcQUrIV8YE?=
 =?iso-8859-1?Q?gCS3gkkFlLyZdt3nz/vf5J+G+3lsfwYWdwBaqom+aEdc3jlV6Xbv8h0q15?=
 =?iso-8859-1?Q?KI1DB7WEp42ylpIZ81Ob4g2GSTyy+rVu/mdKtZbsq7h1heeOli4HxCTGLn?=
 =?iso-8859-1?Q?FuXb4nwhQTrVT7fRmhyOKBASKd2IEdoXPg4NIfK6BCL4WXVeMilK2SaIh0?=
 =?iso-8859-1?Q?kOo5QjJOWb4DUbpfz5Ky8eAqCZXWcJ1edVzRXA5/G9PM9khN8u0w0aH2gL?=
 =?iso-8859-1?Q?g5UiieYuKWRGxlO3A2Y05fT3QYrLkN6GRzGXZ0igac1mu4h1W5YR3dhCrQ?=
 =?iso-8859-1?Q?R7OCYp2sF5WYmlRxm0fmwr6Q10UrlgJJt284j5jgbmj/KtTvaZLyI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5d6b2d-83f6-43b8-c453-08d94120fd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 08:26:59.8008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3VpvvpD8VjRvO0YIlfobKjQ7w0aASw6wUyWTAW0P+pCVbdH2honBy//tBdmm8e3A4E/U8FxKcs0jfcHw4ILnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5798
X-Proofpoint-ORIG-GUID: NHho8Y243e4TMxGxgZBeWfra13Q3Q-LS
X-Proofpoint-GUID: nStr3gu91CFzF3pnu8Lg1lU1SE3sFOlo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070049
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Sa, Nuno <Nuno.Sa@analog.com>
> Sent: Tuesday, July 6, 2021 12:23 PM
> To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org
> Subject: RE: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
> ADRF6780
>=20
>=20
>=20
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Tuesday, July 6, 2021 11:04 AM
> > To: Sa, Nuno <Nuno.Sa@analog.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > robh+dt@kernel.org
> > Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
> > ADRF6780
> >
> > On Mon, 5 Jul 2021 10:18:51 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > Sent: Saturday, July 3, 2021 6:57 PM
> > > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > devicetree@vger.kernel.org; robh+dt@kernel.org
> > > > Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support
> > for
> > > > ADRF6780
> > > >
> > > > On Fri, 2 Jul 2021 14:12:38 +0300
> > > > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> > > >
> > > > > The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> > > > > microwave upconverter optimized for point to point microwave
> > > > > radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> > > > > range.
> > > > >
> > > > > Datasheet:
> > > > > https://www.analog.com/media/en/technical-
> > documentation/data-
> > > > sheets/ADRF6780.pdf
> > > > >
> > > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > >
> > > > Hi Antoniu,
> > > >
> > > > Frequency drivers are fairly unusual so if you could add a listing =
of
> > > > the attributes in sysfs that would be great (it's nice practice
> anyway
> > but
> > > > I don't insist on it!)
> > > >
> > > > Various fairly minor comments inline.
> > > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > >
> > > >
> > > > > ---
> > > > >  changes in v4:
> > > > >   - change license to: GPL-2.0-only
> > > > >  drivers/iio/frequency/Kconfig    |  13 +
> > > > >  drivers/iio/frequency/Makefile   |   1 +
> > > > >  drivers/iio/frequency/adrf6780.c | 498
> > > > +++++++++++++++++++++++++++++++
> > > > >  3 files changed, 512 insertions(+)
> > > > >  create mode 100644 drivers/iio/frequency/adrf6780.c
> > > > >
> > > > > diff --git a/drivers/iio/frequency/Kconfig
> > > > b/drivers/iio/frequency/Kconfig
> > > > > index 240b81502512..fc9751c48f59 100644
> > > > > --- a/drivers/iio/frequency/Kconfig
> > > > > +++ b/drivers/iio/frequency/Kconfig
> > > > > @@ -49,5 +49,18 @@ config ADF4371
> > > > >
> > > > >  	  To compile this driver as a module, choose M here:
> the
> > > > >  	  module will be called adf4371.
> > > > > +
> > > > > +config ADRF6780
> > > > > +        tristate "Analog Devices ADRF6780 Microwave
> Upconverter"
> > > > > +        depends on SPI
> > > > > +        depends on COMMON_CLK
> > > > > +        depends on OF
> > > >
> > > > Why?  Pretty much everything seems to have defaults if not
> > provided
> > > > via OF.
> > > > I've asked for the generic firmware functions anyway, so you can
> > drop
> > > > this
> > > > for that reason if nothing else!
> > > >
> > > > > +        help
> > > > > +          Say yes here to build support for Analog Devices
> ADRF6780
> > > > > +          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
> > > > > +
> > > > > +          To compile this driver as a module, choose M here: the
> > > > > +          module will be called adrf6780.
> > > > > +
> > > > >  endmenu
> > > > >  endmenu
> > > > > diff --git a/drivers/iio/frequency/Makefile
> > > > b/drivers/iio/frequency/Makefile
> > > > > index 518b1e50caef..ae3136c79202 100644
> > > > > --- a/drivers/iio/frequency/Makefile
> > > > > +++ b/drivers/iio/frequency/Makefile
> > > > > @@ -7,3 +7,4 @@
> > > > >  obj-$(CONFIG_AD9523) +=3D ad9523.o
> > > > >  obj-$(CONFIG_ADF4350) +=3D adf4350.o
> > > > >  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> > > > > +obj-$(CONFIG_ADRF6780) +=3D adrf6780.o
> > > > > diff --git a/drivers/iio/frequency/adrf6780.c
> > > > b/drivers/iio/frequency/adrf6780.c
> > > > > new file mode 100644
> > > > > index 000000000000..472a66f90c7f
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/frequency/adrf6780.c
> > > > > @@ -0,0 +1,498 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * ADRF6780 driver
> > > > > + *
> > > > > + * Copyright 2021 Analog Devices Inc.
> > > > > + */
> > > > > +
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/bits.h>
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/clkdev.h>
> > > > > +#include <linux/clk-provider.h>
> > > > > +#include <linux/delay.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/module.h>
> > > >
> > > > #include <linux/mod_devicetable.h>
> > > >
> > > > > +#include <linux/spi/spi.h>
> > > > > +
> > > > > +/* ADRF6780 Register Map */
> > > > > +#define ADRF6780_REG_CONTROL			0x00
> > > > > +#define ADRF6780_REG_ALARM_READBACK		0x01
> > > > > +#define ADRF6780_REG_ALARM_MASKS		0x02
> > > > > +#define ADRF6780_REG_ENABLE			0x03
> > > > > +#define ADRF6780_REG_LINEARIZE			0x04
> > > > > +#define ADRF6780_REG_LO_PATH			0x05
> > > > > +#define ADRF6780_REG_ADC_CONTROL		0x06
> > > > > +#define ADRF6780_REG_ADC_OUTPUT
> 	0x0C
> > > > > +
> > > > > +/* ADRF6780_REG_CONTROL Map */
> > > > > +#define ADRF6780_PARITY_EN_MSK			BIT(15)
> > > > > +#define ADRF6780_PARITY_EN(x)
> > > > 	FIELD_PREP(ADRF6780_PARITY_EN_MSK, x)
> > > > > +#define ADRF6780_SOFT_RESET_MSK
> 	BIT(14)
> > > > > +#define ADRF6780_SOFT_RESET(x)
> > > > 	FIELD_PREP(ADRF6780_SOFT_RESET_MSK, x)
> > > > > +#define ADRF6780_CHIP_ID_MSK
> > 	GENMASK(11, 4)
> > > > > +#define ADRF6780_CHIP_ID			0xA
> > > > > +#define ADRF6780_CHIP_REVISION_MSK
> > 	GENMASK(3, 0)
> > > > > +#define ADRF6780_CHIP_REVISION(x)
> > > > 	FIELD_PREP(ADRF6780_CHIP_REVISION_MSK, x)
> > > > > +
> > > > > +/* ADRF6780_REG_ALARM_READBACK Map */
> > > > > +#define ADRF6780_PARITY_ERROR_MSK		BIT(15)
> > > > > +#define ADRF6780_PARITY_ERROR(x)
> > > > 	FIELD_PREP(ADRF6780_PARITY_ERROR_MSK, x)
> > > > > +#define ADRF6780_TOO_FEW_ERRORS_MSK		BIT(14)
> > > > > +#define ADRF6780_TOO_FEW_ERRORS(x)
> > > > 	FIELD_PREP(ADRF6780_TOO_FEW_ERRORS_MSK, x)
> > > > > +#define ADRF6780_TOO_MANY_ERRORS_MSK
> 	BIT(13)
> > > > > +#define ADRF6780_TOO_MANY_ERRORS(x)
> > > > 	FIELD_PREP(ADRF6780_TOO_MANY_ERRORS_MSK, x)
> > > > > +#define ADRF6780_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> > > > > +#define ADRF6780_ADDRESS_RANGE_ERROR(x)
> > > > 	FIELD_PREP(ADRF6780_ADDRESS_RANGE_ERROR_MSK, x)
> > > > > +
> > > > > +/* ADRF6780_REG_ENABLE Map */
> > > > > +#define ADRF6780_VGA_BUFFER_EN_MSK		BIT(8)
> > > > > +#define ADRF6780_VGA_BUFFER_EN(x)
> > > > 	FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, x)
> > > > > +#define ADRF6780_DETECTOR_EN_MSK		BIT(7)
> > > > > +#define ADRF6780_DETECTOR_EN(x)
> > > > 	FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, x)
> > > > > +#define ADRF6780_LO_BUFFER_EN_MSK		BIT(6)
> > > > > +#define ADRF6780_LO_BUFFER_EN(x)
> > > > 	FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, x)
> > > > > +#define ADRF6780_IF_MODE_EN_MSK
> 	BIT(5)
> > > > > +#define ADRF6780_IF_MODE_EN(x)
> > > > 	FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, x)
> > > > > +#define ADRF6780_IQ_MODE_EN_MSK
> > 	BIT(4)
> > > > > +#define ADRF6780_IQ_MODE_EN(x)
> > > > 	FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, x)
> > > > > +#define ADRF6780_LO_X2_EN_MSK			BIT(3)
> > > > > +#define ADRF6780_LO_X2_EN(x)
> > > > 	FIELD_PREP(ADRF6780_LO_X2_EN_MSK, x)
> > > > > +#define ADRF6780_LO_PPF_EN_MSK			BIT(2)
> > > > > +#define ADRF6780_LO_PPF_EN(x)
> > > > 	FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, x)
> > > > > +#define ADRF6780_LO_EN_MSK			BIT(1)
> > > > > +#define ADRF6780_LO_EN(x)
> > > > 	FIELD_PREP(ADRF6780_LO_EN_MSK, x)
> > > > > +#define ADRF6780_UC_BIAS_EN_MSK
> 	BIT(0)
> > > > > +#define ADRF6780_UC_BIAS_EN(x)
> > > > 	FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, x)
> > > > > +
> > > > > +/* ADRF6780_REG_LINEARIZE Map */
> > > > > +#define ADRF6780_RDAC_LINEARIZE_MSK
> > 	GENMASK(7, 0)
> > > > > +#define ADRF6780_RDAC_LINEARIZE(x)
> > > > 	FIELD_PREP(ADRF6780_RDAC_LINEARIZE_MSK, x)
> > > > > +
> > > > > +/* ADRF6780_REG_LO_PATH Map */
> > > > > +#define ADRF6780_LO_SIDEBAND_MSK		BIT(10)
> > > > > +#define ADRF6780_LO_SIDEBAND(x)
> > > > 	FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, x)
> > > > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY_MSK
> > > > 	GENMASK(7, 4)
> > > > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY(x)
> > > > 	FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, x)
> > > > > +#define ADRF6780_I_PATH_PHASE_ACCURACY_MSK
> > > > 	GENMASK(3, 0)
> > > > > +#define ADRF6780_I_PATH_PHASE_ACCURACY(x)
> > > > 	FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, x)
> > > > > +
> > > > > +/* ADRF6780_REG_ADC_CONTROL Map */
> > > > > +#define ADRF6780_VDET_OUTPUT_SELECT_MSK
> > 	BIT(3)
> > > > > +#define ADRF6780_VDET_OUTPUT_SELECT(x)
> > > > 	FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, x)
> > > > > +#define ADRF6780_ADC_START_MSK			BIT(2)
> > > > > +#define ADRF6780_ADC_START(x)
> > > > 	FIELD_PREP(ADRF6780_ADC_START_MSK, x)
> > > > > +#define ADRF6780_ADC_EN_MSK			BIT(1)
> > > > > +#define ADRF6780_ADC_EN(x)
> > > > 	FIELD_PREP(ADRF6780_ADC_EN_MSK, x)
> > > > > +#define ADRF6780_ADC_CLOCK_EN_MSK		BIT(0)
> > > > > +#define ADRF6780_ADC_CLOCK_EN(x)
> > > > 	FIELD_PREP(ADRF6780_ADC_CLOCK_EN_MSK, x)
> > > > > +
> > > > > +/* ADRF6780_REG_ADC_OUTPUT Map */
> > > > > +#define ADRF6780_ADC_STATUS_MSK
> 	BIT(8)
> > > > > +#define ADRF6780_ADC_STATUS(x)
> > > > 	FIELD_PREP(ADRF6780_ADC_STATUS_MSK, x)
> > > > > +#define ADRF6780_ADC_VALUE_MSK
> > > > 	GENMASK(7, 0)
> > > > > +#define ADRF6780_ADC_VALUE(x)
> > > > 	FIELD_PREP(ADRF6780_ADC_VALUE_MSK, x)
> > > >
> > > > Not used.  In general, just use FIELD_PREP / FIELD_GET inline
> > rather
> > > > than having extra
> > > > macros like these. That approach is simpler for reviewers to
> follow.
> > > >
> > > > > +
> > > > > +struct adrf6780_dev {
> > > > > +	struct spi_device	*spi;
> > > > > +	struct clk		*clkin;
> > > > > +	/* Protect against concurrent accesses to the device */
> > > > > +	struct mutex		lock;
> > > > > +	bool			vga_buff_en;
> > > > > +	bool			lo_buff_en;
> > > > > +	bool			if_mode_en;
> > > > > +	bool			iq_mode_en;
> > > > > +	bool			lo_x2_en;
> > > > > +	bool			lo_ppf_en;
> > > > > +	bool			lo_en;
> > > > > +	bool			uc_bias_en;
> > > > > +	bool			lo_sideband;
> > > > > +	bool			vdet_out_en;
> > > > > +};
> > > > > +
> > > > > +static int adrf6780_spi_read(struct adrf6780_dev *dev,
> > unsigned int
> > > > reg,
> > > > > +			      unsigned int *val)
> > > > > +{
> > > > > +	int ret;
> > > > > +	unsigned int temp;
> > > > > +	struct spi_transfer t =3D {0};
> > > > > +	u8 data[3];
> > > > > +
> > > > > +	data[0] =3D 0x80 | (reg << 1);
> > > > > +	data[1] =3D 0x0;
> > > > > +	data[2] =3D 0x0;
> > > > > +
> > > > > +	t.rx_buf =3D &data[0];
> > > > > +	t.tx_buf =3D &data[0];
> > > > > +	t.len =3D 3;
> > > > > +
> > > > > +	ret =3D spi_sync_transfer(dev->spi, &t, 1);
> > > >
> > > > data needs to be dma safe.
> > > >
> > > > > +	if (ret < 0)
> > > > > +		return ret;
> > > > > +
> > > > > +	temp =3D ((data[0] | 0x80 | (reg << 1)) << 16) |
> > > > > +		(data[1] << 8) | data[2];
> > > >
> > > > Ouch. That's a bit nasty, but why are you writing the reg into
> > > > it?  Looks like a get_unaligned_be24() >> 1 and a 16bit mask.
> > > > (use GENMASK(15, 0) for that to make it apparent what is
> > happening.
> > > >
> > > > > +
> > > > > +	*val =3D (temp >> 1) & 0xFFFF;
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static int adrf6780_spi_write(struct adrf6780_dev *dev,
> > > > > +				      unsigned int reg,
> > > > > +				      unsigned int val)
> > > > > +{
> > > > > +	u8 data[3];
> > > > > +
> > > > > +	val =3D (val << 1);
> > > > > +
> > > > > +	data[0] =3D (reg << 1) | (val >> 16);
> > > > > +	data[1] =3D val >> 8;
> > > > > +	data[2] =3D val;
> > > >
> > > > An opportunity for
> > > > put_unaligned_be24() with a value of (I think)
> > > >
> > > > (val << 1) | (reg << 17)
> > > >
> > > >
> > > > > +
> > > > > +	return spi_write(dev->spi, &data[0], 3);
> > > >
> > > > Needs a dma safe buffer, which basically means it can't be on the
> > > > stack.
> > > > Lots of ways of handling that, but look for __cacheline_aligned in
> > IIO
> > > > drivers
> > > > to see the one we probably use mostly commonly in IIO drivers.
> > >
> > > Hi Jonathan,
> > >
> > > This is something I wanted to ask for some time so I will take the
> > opportunity here :).
> > > Is this something you prefer just not to risk at all and make it an
> hard
> > requirement
> > > (which is fair)? ...
> >
> > Yes, I think we need to keep this as a hard requirement.
> > There are drivers out there which we missed this on in the past, and
> > I'm not necessarily
> > going to take the time to go through them all as this can be hard to
> > spot, but lets not
> > introduce any more potential problems.
> >
>=20
> I see. That makes sense and it's fair :). The only annoying (but not too
> annoying :)) is that
> making the data/buffer global forces you to use a lock in cases you
> potentially would
> not have too (just using local buffers). But that's life, better play saf=
e :)
>=20
> > >
> > > I'm asking this because, tbh, I would be very surprised if any spi/i2=
c
> > controller out there
> > > is using dma for a 3byte transfer. I guess the overhead of setting it
> up
> > is probably not
> > > worth it...
> >
> > There are (I believe) a few i2c and spi controllers out there that don'=
t
> > do anything other
> > than DMA.  Wolfram mentioned one of those in his talk on adding
> > DMA support to i2c.
>=20
> Hmm, I see...
>=20
> > Also, the reference in the file below to the wonderful case of USB to
> > i2c bridges that always
> > require DMA safe buffers.
>=20
> Indeed it does.
>=20

Hi Jonathan,

Just for closure, I also realized that the pattern in IIO looks to be to us=
e
DMA safe buffers only on the tx side. For instance in the IMU lib [1],
only the tx buffer is safe (well, I think there's problem with this as
I believe all spi transfers buffers should be properly aligned which won't
be the case in the IMU lib). Is there any reason for this? AFAICT, we shoul=
d
also take care with rx buffers or am I missing something?

[1]: https://elixir.bootlin.com/linux/latest/source/include/linux/iio/imu/a=
dis.h#L129

- Nuno S=E1
