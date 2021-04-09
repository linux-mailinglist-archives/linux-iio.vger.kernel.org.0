Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8783359657
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhDIH14 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 03:27:56 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:41392 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231782AbhDIH1z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 03:27:55 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1397Q3vV019322;
        Fri, 9 Apr 2021 03:27:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 37rvdu0u48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 03:27:26 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1397RQOL020860;
        Fri, 9 Apr 2021 03:27:26 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-00128a01.pphosted.com with ESMTP id 37rvdu0u46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 03:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYSbl0/kU6gL6mbH9b6upmYMn2SFLiaybdAwLcU1AKKkJ1s4/tu7fWYtGZmNdg2DU7u4Vo4TAoxGM3fx7zq1RcGJtQCKmUvUVIaOnDC87v0uZrK0H+g9n+rwISYdaSNxFwqBYK12HyqzidKtt19L58du25ndB64ho++liDO8l8iMXsAb6CnLMz555XkeVmAKpL50pxulEERr4gOgrzYHmxowHdQeU8wOFag8u7/XMKliC6lq71fbyPoD4aeBKy3KgB4ggWoMuy+JmIZfeqFOw7i3T0TqX4A/wGjUZ4JGkY+UF0mjOxdLcKSKgxmv3IJvEeXzb9hahj/DvTfrW08DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0BNk/OH71aYUpT/gRRWnm8n0/iuFk4LtZuYvfVlQ0Q=;
 b=na7A2zJWUm9IF0MSbuXc/J5od8gdR6rr0wXWuPeRiEbs3X7z+VDlgKFwbWEUgJvg/wHhGwJd235djuOBtwM2KkP4A3Uif5H2P6lt2Xf9Jkj0aM7pV69X1e1m8VCPTLD/noGCzswfmiaHOdvvnlKyuAqjUYdOH1uM+xgvCjOhfvJHAGOQl9cVg4zCmGhsM7dvQ+ZKyki6BhWjoZuezAPWl2mj0hHaVtm7wtlLIlMU3KsmZ+u8aG6rN5hRgabKx+wTc1nAVl1G/BoSIlC6qYppm0G7fOGls2czqWi6gi2+yOP0mJAQdJ4vfd0uodJZ2Kpa2AQYndxnXMTjcv1GR+t3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0BNk/OH71aYUpT/gRRWnm8n0/iuFk4LtZuYvfVlQ0Q=;
 b=y2WFwA+BVZYaqk+6pTGy0B+bJket5W14bStBk4lMUcnPMkBl/MflJ2pG/5J01f6u73CTL6tYOl5zcxNkEZfJBr6necc2GAU7BKyxqS+Ud8Fv2RhdmMkcGnEX7LS6Seehy54SCci24xuTYjOW4lByF/ZWdIz8JRHmt3xKSH2g/O8=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB3192.namprd03.prod.outlook.com (2603:10b6:910:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 07:27:22 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 07:27:22 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Yicong Yang <yangyicong@hisilicon.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "prime.zeng@huawei.com" <prime.zeng@huawei.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
Thread-Topic: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
Thread-Index: AQHXLGwOrL2LW1a+QUmhLbdoeMEeXKqrykBQ
Date:   Fri, 9 Apr 2021 07:27:22 +0000
Message-ID: <CY4PR03MB31124A5899641BFF090AE5BC99739@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
In-Reply-To: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMDM0NDNjOTEtOTkwNS0xMWViLThiMzYtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDAzNDQzYzkzLTk5MDUtMTFlYi04YjM2LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iODE3IiB0PSIxMzI2MjQyNjgzOD?=
 =?iso-8859-1?Q?M4MzU2MzUiIGg9InhuM0I5REdKeGlzTDRoODZySWFIbzdXL0MyTT0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?lZREFBRHpWWjNGRVMzWEFjZ1o0T2ZRYU9DNXlCbmc1OUJvNExrRkFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBYkpQU2RRQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJoQUhJQWFRQmhBRjhBWkFCcE?=
 =?iso-8859-1?Q?FHTUFkQUJwQUc4QWJnQmhBSElBZVFCZkFIUUFhUUJsQUhJQU1RQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFnQUFBQUFBbmdBQUFHRUFjZ0JwQUdFQVh3QmtBR2tBWXdCMEFH?=
 =?iso-8859-1?Q?a0Fid0J1QUdFQWNnQjVBRjhBZEFCcEFHVUFjZ0F5QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?iso-8859-1?Q?QUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:2576:3601:5ad:2d04:fa74:f119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4071d87a-3b09-4933-1404-08d8fb28ea71
x-ms-traffictypediagnostic: CY4PR03MB3192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB3192D22A1E72EB1FC4BDEF4599739@CY4PR03MB3192.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BHchH1lFpQJoN1VEy5Dbl+4R/Qky/mW0dLDaiNtWLxBzq1aEoLC+4qJIvB1maM3lDmJRvt3oI0jXCr4rECcSSdnef22n9C4Z4llztl9jeRA3LSxU52pEvuLWcMID5esOrGJBtjlD5M5Mhq9jPHvMa3flyokNvA+zRaPNDs47j8AEBh36AAQ/tps1RvcaMBi++3wVekK7uZdY3cNuey6Ppyel/ZcWSYoOLlsySYy0NxWem9vfDQhQJsLArwUG4GZsSamXc7S3MtRfP56bNJiGy5JoOj/u8+tH49xfkt0LdBOoIErAIpwuf3fReo94SxG5oKNrDSJXgVYsRs7s2bCIrPaCkswx+g1rEbLKFQgStkqXW8jRSt/2+/XV/TpEc+U6ChdoNDhl1ajVVLQ5C4ZxFZze0l2W6ri14Qk2BgkLbsAW6y1YuVWondJT9smFCbWGH2UhwgitozQHphhk0Xpr8EexIFv/nXRbDR9AAxEYDov+pJBNTGKr/jvVEdD/0A+aeiNIQFefPFue9L+ISVouXmSSnNScGSWNSIUS4iYeSv+8bVeL64FB0ldwHv3rN9Yx5iE39MkiF4OL9qlh48GtSsDok0Q5XXFtjEHJdA7B2quMOlCkoPwVAmU5E6vkDTkVQoSuIEYQZVVzRLoQNrN1UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(53546011)(66946007)(6506007)(186003)(66556008)(66446008)(64756008)(76116006)(55016002)(4326008)(66476007)(71200400001)(9686003)(478600001)(33656002)(110136005)(8676002)(83380400001)(5660300002)(54906003)(38100700001)(86362001)(316002)(4744005)(8936002)(2906002)(52536014)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?spRPxa19S+vbjZ3/x0UDZd+0AKgTA8Djnyv8oSBuwSE8nwEMbGfuazXxw9?=
 =?iso-8859-1?Q?/Dh8B9dJSFY8RGPCcV0ujjv7Be44B8E9aQz6j5NcjJxwJSQ1x89vmAz50y?=
 =?iso-8859-1?Q?yIZHu2Ptms6iKt/FIAtfZBsK/SUmhsOKbBeZI6fhcH/SRaQoUqNvfQ6he7?=
 =?iso-8859-1?Q?b+M9RpkPJntPpv4gWChIrSqEhmFyjf5LPw23dtYFUhE6B/+mE+W8a7w8Cn?=
 =?iso-8859-1?Q?jR4RS7UrfHxvUO9oWDBgtCzmeb4GYttkET28F0CN7tv27E6Rc7y1f0wknE?=
 =?iso-8859-1?Q?9N72unQ10rN4bgg2Zlx4AG6ltMYqThuFcZOVBl9VBgy+t5IOGimanuQsM5?=
 =?iso-8859-1?Q?WiOzyq0AMG7DbhQNk9JbeNtPZsjNK3jef7SenEXiJz9Y6PVAkZ9KX0kl4f?=
 =?iso-8859-1?Q?ZHVAOAI9tx9PVjsuAUrv13ZNEqN326o3HDirSA/RxyEBnVPyJ6nIPHclBe?=
 =?iso-8859-1?Q?K/q8ffLU2XYQ6x1nX+T0pmcE25BjE3JetjIvI2FCKuWP/AagYiokMGQDDF?=
 =?iso-8859-1?Q?XHQ27wGNt0qOQnR5v5fk/J8Hkz7/collvIc45WvXo4xYfZMEveUq6te++5?=
 =?iso-8859-1?Q?dlH8ViGLnxy52X6Kw03RougWzVoXOgn+C3sI5Y1OC231IP+5DFIIunGrth?=
 =?iso-8859-1?Q?CkihdUa36huiQoFhz2HtLMy9Z9F+1AbUzGt6HBTiNsY4khQlgxyyM+tO5F?=
 =?iso-8859-1?Q?2I/JiICUbwsvLVxjCN8w/hz1s8lalmFnJpdv3ROeACxR4Q8WE9SJHGibl7?=
 =?iso-8859-1?Q?wI+/12gJOrh/585ryWO5ycHot9F+SI9pDrZ7dnMo0i1QTFugzRz3+741fM?=
 =?iso-8859-1?Q?5hmg+5LIUT+tTO/V4F89KvpeEY1Dfp1xP51GEu5O74zUT3NEQ2XDkIqYfm?=
 =?iso-8859-1?Q?xeXv0d7mS99+I0D9nce8n3s7s+LIjUUlh94eAbh6dgJ5gnTXxv8skK/mk3?=
 =?iso-8859-1?Q?Dk1t8y5kdV6nj7/aXgRTLtAkFMqT0ZKyfZHFyeRAiF2kdTWjkIjns+Ow9Y?=
 =?iso-8859-1?Q?B+AghPoOxjuWRlx/SUmNFk5aBFhM5SGxyVzdNO7ISxoNAfkWB68zGgbgDg?=
 =?iso-8859-1?Q?w+ojSX+Y3na9x1HDo93pomtTIVFnubAa/nYNV6tUhH2dqj4tXvLvsroSv6?=
 =?iso-8859-1?Q?fZWH2TFqC3UbAd6If6r57OsXOgi3UAPLH+yhuqzWF9YLj5z04SC2p7Xf/z?=
 =?iso-8859-1?Q?c0Y5HLcyv2DpHR2T3vs5qa8hLf/L7QEtHw1c1aRSMn0qCMYkyEiP/t1yh+?=
 =?iso-8859-1?Q?ziVs2bgAHImO4uVQR823BnsN9HjjFf/OrqoGyx4UOIR4vHFQYTvmojAQxr?=
 =?iso-8859-1?Q?HHJl5o9KxvRCySYuA4VGA3LN10/FJn/JDhEAqvVLK1yJEXaGFkfR8vmiMK?=
 =?iso-8859-1?Q?snhGl6REF0Xp3q5E5NeoUedKUEanNeuZEyrfuH789XLgGo7M8iAWQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4071d87a-3b09-4933-1404-08d8fb28ea71
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 07:27:22.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQXK3448W6nYb7WCAdg8HMczq0lMw1cNZd2f6Daar1gFkVa/eC9Lqm0zQsl/i21uy8QEMeVP0rZzyj/Dgb2Qlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3192
X-Proofpoint-ORIG-GUID: I7xj5ItQbRZxZoiS363MYDiWHWL1EQrF
X-Proofpoint-GUID: kEMDw79FyHnM1IJMzxX_pwNQv-NG2MDE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_04:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090053
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Yicong Yang <yangyicong@hisilicon.com>
> Sent: Thursday, April 8, 2021 1:38 PM
> To: jic23@kernel.org; linux-iio@vger.kernel.org
> Cc: lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; pmeerw@pmeerw.net;
> prime.zeng@huawei.com; tiantao6@hisilicon.com;
> yangyicong@hisilicon.com
> Subject: [PATCH 0/7] Simplify codes with devm_add_action_or_reset
>=20
>=20
> Some devm variants are implemented with devres_alloc() and
> devres_add()
> manually to only manage a single pointer. This can be simplified with
> devm_add_action_or_reset() which works the same. Simplify these
> functions.
>=20

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

Nuno S=E1
