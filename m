Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DC3BC991
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jul 2021 12:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhGFKZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jul 2021 06:25:29 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6432 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231397AbhGFKZ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 06:25:28 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166AAis4011312;
        Tue, 6 Jul 2021 06:22:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 39mehks89j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 06:22:48 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 166AHSLT029654;
        Tue, 6 Jul 2021 06:22:48 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00128a01.pphosted.com with ESMTP id 39mehks89h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 06:22:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLEIc2RxOvSb/HA7W6DzogG/5ghi9Lf8vaoXadjfdsmaT4o0C5x1MUxbptJhwnV16pzIjhZBe2oh1iysJRw80DvpFj2+EdZmMgC04OmjViweGrDQhituWhu8Va3Q1zcY80uoGxkJlfRp4kn+sNFvyb3QNrP72Q4VrBnTcDQhl7B6T5dkziBCp+llVymVY/tWyDM7b3uDfeY0xqJF3A9Je8Es/2KUCgy161HS2KpTJn1rhcwrgFL1osRm5zAHT3SGhvNgdqtkqckT65i/n4s2estcEBGHhCMwsx2bEVOLPILo4IRq9QJSaw2PHNJjBQFGQgtXRiQcX47BC7QU32dP+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbVZF9ka6hDVteor7o9b8eysBdJnYe0l4RQdWLSHPJ4=;
 b=h7k4jkOPp8F68DqkRyfuLfwgsK3DC9Dh8brmna0V+ai+/mapZJG9SLX4HlieD0g4OPN0p34Py2PX5Tb0+34CAAaLcPrXGBCav5k8orD1tJVBnJh2HNd23r65XVm7vF5Lq9CyjuuA/vedOKVLboQsgRD5MDEE3lX8v80hzyQqmxV9W156jvl321GLH85pZVVSoQha01XAZ9r50vJz8JArOPMNjK8MTZxZodV/6kDLzo/lqjTINHBD+cAKykEKzZOfEj/V+4QQLsH+A/RKaOYm0p+auUcYv6baP9v4XQ/IgH3e51nRnSijau5fwg4V3nmdeLvX00Z+4TwEwQX8+a6eYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbVZF9ka6hDVteor7o9b8eysBdJnYe0l4RQdWLSHPJ4=;
 b=ljRXyAQHUddLBS/FECwp+G0Cp18AVTkVyny457W9j3OuaaeX5ZJPXjdxUR++tmqOGExpqOHOSvy2NkfvJON3vMzOrU0m8Eq097aimu5BT1ahknLWQsCy3BIV9LjH+jxhzPLa8VsHdi9DYYk59fL26lEeNbinhRwEj5X7sGiwkvA=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5845.namprd03.prod.outlook.com (2603:10b6:510:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.33; Tue, 6 Jul
 2021 10:22:45 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Tue, 6 Jul 2021
 10:22:45 +0000
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
Thread-Index: AQHXbzN7IY9R84leFkqsPFMOIAAoUasxeo0AgAKyeUCAAYBQgIAAFNGg
Date:   Tue, 6 Jul 2021 10:22:45 +0000
Message-ID: <PH0PR03MB6366190FBDC12B1AD1CCBC43991B9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210702111239.174189-1-antoniu.miclaus@analog.com>
        <20210703175716.7864358a@jic23-huawei>
        <PH0PR03MB63667CCA2691D4A43F28041E991C9@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210706100405.00001507@Huawei.com>
In-Reply-To: <20210706100405.00001507@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMTg2Nzc3MjEtZGU0NC0xMWViLThiNmUtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDE4Njc3NzIzLWRlNDQtMTFlYi04YjZlLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTM1MTUiIHQ9IjEzMjcwMDQwNT?=
 =?iso-8859-1?Q?YyMzY3NDg4NSIgaD0ia0RDQ1ZBU1o4d3poQ3REeE90dnRtKy9FNnJRPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBSVlEQUFBRjJML2FVSExYQWVDa2hheUZISVVQNEtTRnJJVWNoUThGQUFB?=
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
x-ms-office365-filtering-correlation-id: df837598-d439-46fb-b6e0-08d94067fefb
x-ms-traffictypediagnostic: PH0PR03MB5845:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB5845A6211F39ABB94D9FD35A991B9@PH0PR03MB5845.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2MZmkvON3pBAEEbj2BvtVx9uLvlOhxdeCjXMEff+OxjYNcNqp7L+NUrHjwxktNNVccL0270Mu2zAr6fX+GJTEQJF7UD4psyNgB7U4AJxurEIoJvUZFNudvFAWX3muGIl0w95EcOJOdnBF9AkkakL+Ixw0cUPFGjhhhCBCVB/9h/6VH7SFs2pQQ0QjuT0Oan2ju9v6tQDYU8j9OLYy//tpdR7ZXuXd8gHHjsbhuNFuF3ShJae+ezVf6V7/yF14uKtpEI/7JmCqrWCvdWTLoyT5888HrVJzEUxy6S8UILEivZp/0/KnCQNjnsWr3cdQA2xhkHP1ks39ZkQl31+lxUM6nAhrODrpbqtwKPfo/MnSVtUFO4QAxsf0rvUZ4ml3WVse4jFqXPdFAZ8RfAo0SaUW61mQlW+4LR7dwy/0bbTE83YQJ9SqPXdPiPU52Rr47NN4KYGLsK4O1DW5YWMTNHrGCHkGa/twkQW8NcSTyqTZJm1RcpFROV+8hRamolL15VyU/Ru9SWThm3XaVgXpCO6aNeHcv11XOX88ZvnOi4Eau/Eov7S5dtiUkT8veWDdBL46QuW3abasWBpMP225WZrkuADpGHfSIOQSC6egJRxwBsw8QsorFdk7MRKUIeE4ZD39QHfFGIgvcatKrrRcmaHgJ7bJiaboYTMmHVscTbLYI0uVhbPDk4KfuK32xzHsUnuXNKQ6plpC85U4So90FGHKj2GDlG2VSWrrsX35W6hb8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(64756008)(8676002)(83380400001)(7696005)(66946007)(33656002)(55016002)(38100700002)(66556008)(66476007)(122000001)(54906003)(66446008)(316002)(76116006)(5660300002)(6916009)(30864003)(26005)(4326008)(186003)(86362001)(2906002)(9686003)(71200400001)(966005)(53546011)(52536014)(6506007)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DUSA5bNUMQhikFDkTwthef4iKOBV4VJEccCbakuLd250WYNc7BOur4IoNn?=
 =?iso-8859-1?Q?EFVRrwfc5Y75XJJ2b5Rg0x4SQfIX4h2eF9N4iyha/+9L9uUUw7r2ESaucf?=
 =?iso-8859-1?Q?5AC2DN7N8riL0EtRTbXCB9ZNW8zpj5GRvMXoDFj2SBq0HK0XlV2SqzptEN?=
 =?iso-8859-1?Q?lRLpSN/dK2WFBgHwG+b8i3dtXEo2R3X/Hp/hMYGr/zMUKafT9YjnsZMI6g?=
 =?iso-8859-1?Q?0+c2AsncTEnVEDCn5senF9f3bUWlpR6xZGDTdn80aa81Z0GdU/G5ZsM4+c?=
 =?iso-8859-1?Q?Z1j1OYiYoC+RbfIKiNiPRWj/RVhxMUvzo+OacJ3b5vdD4a2oH1TlBSaB9V?=
 =?iso-8859-1?Q?Z0kBNRSammfYXPyHJ71+HOVo5tYtennemu/ASCthPew2J26ySATes2dYPA?=
 =?iso-8859-1?Q?1n+oCcwYvsh6oMCsoyKM9nyU20/bCqejJC6RSKApAW+u8ynWdpF9/7hCWI?=
 =?iso-8859-1?Q?I6UqEU6KkHiby2AmfQ+6EXLHyLKIOABigpfspYbwhu2Xehdrc8vnhxbXML?=
 =?iso-8859-1?Q?0KKp4l4zsds7RrhoxyJRojkk9wden1no3swh4gYdZadpsoCk0HonzPHVN/?=
 =?iso-8859-1?Q?Icgexh8rUA50/YEVt6KrBS2b9lQSY32iDuEmRAdJhK201S9qmhAEokWSAv?=
 =?iso-8859-1?Q?zFZQe5NEuX9hwatZYgQwA/EDKHA5NS6F7U2ySMCm+KggfQMrkEXrt5d28d?=
 =?iso-8859-1?Q?crb5Cy2vvVsbQYTLfJfm8iHNMCt0HTqXTqr+EgRFjf6/SyDZ0vK/BUVfJN?=
 =?iso-8859-1?Q?CQHF6hRezv9lO1MO6MSveLJ2vBFITmBI7rFZQ1hfIYQry/0DJ19PNYfn3F?=
 =?iso-8859-1?Q?/bqGGzdt45rl2Y0yjDfYlBIPpXB/ZZApUkCu/y/KqGWjUjDTMqCwscHgoF?=
 =?iso-8859-1?Q?td1BeM+a1Kb59tHen1bVpOeoerHY65a3jl2ZnkQ76dYU/MgqJCPAcYLzrR?=
 =?iso-8859-1?Q?7yPoWW+ZUQJmjmHtZMQqMHWPLUY9L1MhyVV0ej5jS9O0+JvARp9X69LDze?=
 =?iso-8859-1?Q?MV0XVDv6Y7DYIw0f0NiwEAeik6BADf3EB6mhCFN4AoTkxc7QECa9q+jG2b?=
 =?iso-8859-1?Q?syLe4fxizvY+Xc7wwQhShS9UG9tZp9rzWd7V+7zQ5ATQ4OWSc7xoIANDPJ?=
 =?iso-8859-1?Q?QFO2SJiFWll8tr9GD4pYZ0Ow7dOy9Ah9d2XWB0zyOq+kwf9hmMWrvuV7EQ?=
 =?iso-8859-1?Q?AaZKNG+vhbCb4YCh/KAGvCmiv+XwtNWs9hjiCcg5wPD+DzbpwTte9wsU61?=
 =?iso-8859-1?Q?gdwGoYTzuJK6Qm23uUCmKhKYGdvRrhWZZtoeegWZXv5VNPypDlTLjMSGTq?=
 =?iso-8859-1?Q?XcmhzZwmdOi1+9Rm/aYhEsI5wSr3/xmEMGkAYpHl3CuuWU0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df837598-d439-46fb-b6e0-08d94067fefb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 10:22:45.2667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmoKKp7MpTsx3jNX7WabvVCKelkdpg6f2ViG1fBwjDvl9P5Kz7T7KR/lZCM5UM9BHrnNhZQo6bi32zkPYzJEow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5845
X-Proofpoint-ORIG-GUID: SOZ0n7lgyIEORx_ba0iY7WW3IvTvtG6S
X-Proofpoint-GUID: Tw3TNosP5y0yqtaymwQaEMeK00II_bmp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_05:2021-07-02,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060050
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Tuesday, July 6, 2021 11:04 AM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org;
> robh+dt@kernel.org
> Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support for
> ADRF6780
>=20
> On Mon, 5 Jul 2021 10:18:51 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Saturday, July 3, 2021 6:57 PM
> > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > devicetree@vger.kernel.org; robh+dt@kernel.org
> > > Subject: Re: [PATCH v4 1/2] iio: frequency: adrf6780: add support
> for
> > > ADRF6780
> > >
> > > On Fri, 2 Jul 2021 14:12:38 +0300
> > > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> > >
> > > > The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> > > > microwave upconverter optimized for point to point microwave
> > > > radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> > > > range.
> > > >
> > > > Datasheet:
> > > > https://www.analog.com/media/en/technical-
> documentation/data-
> > > sheets/ADRF6780.pdf
> > > >
> > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > >
> > > Hi Antoniu,
> > >
> > > Frequency drivers are fairly unusual so if you could add a listing of
> > > the attributes in sysfs that would be great (it's nice practice anywa=
y
> but
> > > I don't insist on it!)
> > >
> > > Various fairly minor comments inline.
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > >
> > > > ---
> > > >  changes in v4:
> > > >   - change license to: GPL-2.0-only
> > > >  drivers/iio/frequency/Kconfig    |  13 +
> > > >  drivers/iio/frequency/Makefile   |   1 +
> > > >  drivers/iio/frequency/adrf6780.c | 498
> > > +++++++++++++++++++++++++++++++
> > > >  3 files changed, 512 insertions(+)
> > > >  create mode 100644 drivers/iio/frequency/adrf6780.c
> > > >
> > > > diff --git a/drivers/iio/frequency/Kconfig
> > > b/drivers/iio/frequency/Kconfig
> > > > index 240b81502512..fc9751c48f59 100644
> > > > --- a/drivers/iio/frequency/Kconfig
> > > > +++ b/drivers/iio/frequency/Kconfig
> > > > @@ -49,5 +49,18 @@ config ADF4371
> > > >
> > > >  	  To compile this driver as a module, choose M here: the
> > > >  	  module will be called adf4371.
> > > > +
> > > > +config ADRF6780
> > > > +        tristate "Analog Devices ADRF6780 Microwave Upconverter"
> > > > +        depends on SPI
> > > > +        depends on COMMON_CLK
> > > > +        depends on OF
> > >
> > > Why?  Pretty much everything seems to have defaults if not
> provided
> > > via OF.
> > > I've asked for the generic firmware functions anyway, so you can
> drop
> > > this
> > > for that reason if nothing else!
> > >
> > > > +        help
> > > > +          Say yes here to build support for Analog Devices ADRF678=
0
> > > > +          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
> > > > +
> > > > +          To compile this driver as a module, choose M here: the
> > > > +          module will be called adrf6780.
> > > > +
> > > >  endmenu
> > > >  endmenu
> > > > diff --git a/drivers/iio/frequency/Makefile
> > > b/drivers/iio/frequency/Makefile
> > > > index 518b1e50caef..ae3136c79202 100644
> > > > --- a/drivers/iio/frequency/Makefile
> > > > +++ b/drivers/iio/frequency/Makefile
> > > > @@ -7,3 +7,4 @@
> > > >  obj-$(CONFIG_AD9523) +=3D ad9523.o
> > > >  obj-$(CONFIG_ADF4350) +=3D adf4350.o
> > > >  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> > > > +obj-$(CONFIG_ADRF6780) +=3D adrf6780.o
> > > > diff --git a/drivers/iio/frequency/adrf6780.c
> > > b/drivers/iio/frequency/adrf6780.c
> > > > new file mode 100644
> > > > index 000000000000..472a66f90c7f
> > > > --- /dev/null
> > > > +++ b/drivers/iio/frequency/adrf6780.c
> > > > @@ -0,0 +1,498 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * ADRF6780 driver
> > > > + *
> > > > + * Copyright 2021 Analog Devices Inc.
> > > > + */
> > > > +
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/bits.h>
> > > > +#include <linux/clk.h>
> > > > +#include <linux/clkdev.h>
> > > > +#include <linux/clk-provider.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/iio/iio.h>
> > > > +#include <linux/module.h>
> > >
> > > #include <linux/mod_devicetable.h>
> > >
> > > > +#include <linux/spi/spi.h>
> > > > +
> > > > +/* ADRF6780 Register Map */
> > > > +#define ADRF6780_REG_CONTROL			0x00
> > > > +#define ADRF6780_REG_ALARM_READBACK		0x01
> > > > +#define ADRF6780_REG_ALARM_MASKS		0x02
> > > > +#define ADRF6780_REG_ENABLE			0x03
> > > > +#define ADRF6780_REG_LINEARIZE			0x04
> > > > +#define ADRF6780_REG_LO_PATH			0x05
> > > > +#define ADRF6780_REG_ADC_CONTROL		0x06
> > > > +#define ADRF6780_REG_ADC_OUTPUT			0x0C
> > > > +
> > > > +/* ADRF6780_REG_CONTROL Map */
> > > > +#define ADRF6780_PARITY_EN_MSK			BIT(15)
> > > > +#define ADRF6780_PARITY_EN(x)
> > > 	FIELD_PREP(ADRF6780_PARITY_EN_MSK, x)
> > > > +#define ADRF6780_SOFT_RESET_MSK			BIT(14)
> > > > +#define ADRF6780_SOFT_RESET(x)
> > > 	FIELD_PREP(ADRF6780_SOFT_RESET_MSK, x)
> > > > +#define ADRF6780_CHIP_ID_MSK
> 	GENMASK(11, 4)
> > > > +#define ADRF6780_CHIP_ID			0xA
> > > > +#define ADRF6780_CHIP_REVISION_MSK
> 	GENMASK(3, 0)
> > > > +#define ADRF6780_CHIP_REVISION(x)
> > > 	FIELD_PREP(ADRF6780_CHIP_REVISION_MSK, x)
> > > > +
> > > > +/* ADRF6780_REG_ALARM_READBACK Map */
> > > > +#define ADRF6780_PARITY_ERROR_MSK		BIT(15)
> > > > +#define ADRF6780_PARITY_ERROR(x)
> > > 	FIELD_PREP(ADRF6780_PARITY_ERROR_MSK, x)
> > > > +#define ADRF6780_TOO_FEW_ERRORS_MSK		BIT(14)
> > > > +#define ADRF6780_TOO_FEW_ERRORS(x)
> > > 	FIELD_PREP(ADRF6780_TOO_FEW_ERRORS_MSK, x)
> > > > +#define ADRF6780_TOO_MANY_ERRORS_MSK		BIT(13)
> > > > +#define ADRF6780_TOO_MANY_ERRORS(x)
> > > 	FIELD_PREP(ADRF6780_TOO_MANY_ERRORS_MSK, x)
> > > > +#define ADRF6780_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> > > > +#define ADRF6780_ADDRESS_RANGE_ERROR(x)
> > > 	FIELD_PREP(ADRF6780_ADDRESS_RANGE_ERROR_MSK, x)
> > > > +
> > > > +/* ADRF6780_REG_ENABLE Map */
> > > > +#define ADRF6780_VGA_BUFFER_EN_MSK		BIT(8)
> > > > +#define ADRF6780_VGA_BUFFER_EN(x)
> > > 	FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, x)
> > > > +#define ADRF6780_DETECTOR_EN_MSK		BIT(7)
> > > > +#define ADRF6780_DETECTOR_EN(x)
> > > 	FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, x)
> > > > +#define ADRF6780_LO_BUFFER_EN_MSK		BIT(6)
> > > > +#define ADRF6780_LO_BUFFER_EN(x)
> > > 	FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, x)
> > > > +#define ADRF6780_IF_MODE_EN_MSK			BIT(5)
> > > > +#define ADRF6780_IF_MODE_EN(x)
> > > 	FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, x)
> > > > +#define ADRF6780_IQ_MODE_EN_MSK
> 	BIT(4)
> > > > +#define ADRF6780_IQ_MODE_EN(x)
> > > 	FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, x)
> > > > +#define ADRF6780_LO_X2_EN_MSK			BIT(3)
> > > > +#define ADRF6780_LO_X2_EN(x)
> > > 	FIELD_PREP(ADRF6780_LO_X2_EN_MSK, x)
> > > > +#define ADRF6780_LO_PPF_EN_MSK			BIT(2)
> > > > +#define ADRF6780_LO_PPF_EN(x)
> > > 	FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, x)
> > > > +#define ADRF6780_LO_EN_MSK			BIT(1)
> > > > +#define ADRF6780_LO_EN(x)
> > > 	FIELD_PREP(ADRF6780_LO_EN_MSK, x)
> > > > +#define ADRF6780_UC_BIAS_EN_MSK			BIT(0)
> > > > +#define ADRF6780_UC_BIAS_EN(x)
> > > 	FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, x)
> > > > +
> > > > +/* ADRF6780_REG_LINEARIZE Map */
> > > > +#define ADRF6780_RDAC_LINEARIZE_MSK
> 	GENMASK(7, 0)
> > > > +#define ADRF6780_RDAC_LINEARIZE(x)
> > > 	FIELD_PREP(ADRF6780_RDAC_LINEARIZE_MSK, x)
> > > > +
> > > > +/* ADRF6780_REG_LO_PATH Map */
> > > > +#define ADRF6780_LO_SIDEBAND_MSK		BIT(10)
> > > > +#define ADRF6780_LO_SIDEBAND(x)
> > > 	FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, x)
> > > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY_MSK
> > > 	GENMASK(7, 4)
> > > > +#define ADRF6780_Q_PATH_PHASE_ACCURACY(x)
> > > 	FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, x)
> > > > +#define ADRF6780_I_PATH_PHASE_ACCURACY_MSK
> > > 	GENMASK(3, 0)
> > > > +#define ADRF6780_I_PATH_PHASE_ACCURACY(x)
> > > 	FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, x)
> > > > +
> > > > +/* ADRF6780_REG_ADC_CONTROL Map */
> > > > +#define ADRF6780_VDET_OUTPUT_SELECT_MSK
> 	BIT(3)
> > > > +#define ADRF6780_VDET_OUTPUT_SELECT(x)
> > > 	FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, x)
> > > > +#define ADRF6780_ADC_START_MSK			BIT(2)
> > > > +#define ADRF6780_ADC_START(x)
> > > 	FIELD_PREP(ADRF6780_ADC_START_MSK, x)
> > > > +#define ADRF6780_ADC_EN_MSK			BIT(1)
> > > > +#define ADRF6780_ADC_EN(x)
> > > 	FIELD_PREP(ADRF6780_ADC_EN_MSK, x)
> > > > +#define ADRF6780_ADC_CLOCK_EN_MSK		BIT(0)
> > > > +#define ADRF6780_ADC_CLOCK_EN(x)
> > > 	FIELD_PREP(ADRF6780_ADC_CLOCK_EN_MSK, x)
> > > > +
> > > > +/* ADRF6780_REG_ADC_OUTPUT Map */
> > > > +#define ADRF6780_ADC_STATUS_MSK			BIT(8)
> > > > +#define ADRF6780_ADC_STATUS(x)
> > > 	FIELD_PREP(ADRF6780_ADC_STATUS_MSK, x)
> > > > +#define ADRF6780_ADC_VALUE_MSK
> > > 	GENMASK(7, 0)
> > > > +#define ADRF6780_ADC_VALUE(x)
> > > 	FIELD_PREP(ADRF6780_ADC_VALUE_MSK, x)
> > >
> > > Not used.  In general, just use FIELD_PREP / FIELD_GET inline
> rather
> > > than having extra
> > > macros like these. That approach is simpler for reviewers to follow.
> > >
> > > > +
> > > > +struct adrf6780_dev {
> > > > +	struct spi_device	*spi;
> > > > +	struct clk		*clkin;
> > > > +	/* Protect against concurrent accesses to the device */
> > > > +	struct mutex		lock;
> > > > +	bool			vga_buff_en;
> > > > +	bool			lo_buff_en;
> > > > +	bool			if_mode_en;
> > > > +	bool			iq_mode_en;
> > > > +	bool			lo_x2_en;
> > > > +	bool			lo_ppf_en;
> > > > +	bool			lo_en;
> > > > +	bool			uc_bias_en;
> > > > +	bool			lo_sideband;
> > > > +	bool			vdet_out_en;
> > > > +};
> > > > +
> > > > +static int adrf6780_spi_read(struct adrf6780_dev *dev,
> unsigned int
> > > reg,
> > > > +			      unsigned int *val)
> > > > +{
> > > > +	int ret;
> > > > +	unsigned int temp;
> > > > +	struct spi_transfer t =3D {0};
> > > > +	u8 data[3];
> > > > +
> > > > +	data[0] =3D 0x80 | (reg << 1);
> > > > +	data[1] =3D 0x0;
> > > > +	data[2] =3D 0x0;
> > > > +
> > > > +	t.rx_buf =3D &data[0];
> > > > +	t.tx_buf =3D &data[0];
> > > > +	t.len =3D 3;
> > > > +
> > > > +	ret =3D spi_sync_transfer(dev->spi, &t, 1);
> > >
> > > data needs to be dma safe.
> > >
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	temp =3D ((data[0] | 0x80 | (reg << 1)) << 16) |
> > > > +		(data[1] << 8) | data[2];
> > >
> > > Ouch. That's a bit nasty, but why are you writing the reg into
> > > it?  Looks like a get_unaligned_be24() >> 1 and a 16bit mask.
> > > (use GENMASK(15, 0) for that to make it apparent what is
> happening.
> > >
> > > > +
> > > > +	*val =3D (temp >> 1) & 0xFFFF;
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int adrf6780_spi_write(struct adrf6780_dev *dev,
> > > > +				      unsigned int reg,
> > > > +				      unsigned int val)
> > > > +{
> > > > +	u8 data[3];
> > > > +
> > > > +	val =3D (val << 1);
> > > > +
> > > > +	data[0] =3D (reg << 1) | (val >> 16);
> > > > +	data[1] =3D val >> 8;
> > > > +	data[2] =3D val;
> > >
> > > An opportunity for
> > > put_unaligned_be24() with a value of (I think)
> > >
> > > (val << 1) | (reg << 17)
> > >
> > >
> > > > +
> > > > +	return spi_write(dev->spi, &data[0], 3);
> > >
> > > Needs a dma safe buffer, which basically means it can't be on the
> > > stack.
> > > Lots of ways of handling that, but look for __cacheline_aligned in
> IIO
> > > drivers
> > > to see the one we probably use mostly commonly in IIO drivers.
> >
> > Hi Jonathan,
> >
> > This is something I wanted to ask for some time so I will take the
> opportunity here :).
> > Is this something you prefer just not to risk at all and make it an har=
d
> requirement
> > (which is fair)? ...
>=20
> Yes, I think we need to keep this as a hard requirement.
> There are drivers out there which we missed this on in the past, and
> I'm not necessarily
> going to take the time to go through them all as this can be hard to
> spot, but lets not
> introduce any more potential problems.
>=20

I see. That makes sense and it's fair :). The only annoying (but not too an=
noying :)) is that
making the data/buffer global forces you to use a lock in cases you potenti=
ally would
not have too (just using local buffers). But that's life, better play safe =
:)
=20
> >
> > I'm asking this because, tbh, I would be very surprised if any spi/i2c
> controller out there
> > is using dma for a 3byte transfer. I guess the overhead of setting it u=
p
> is probably not
> > worth it...
>=20
> There are (I believe) a few i2c and spi controllers out there that don't
> do anything other
> than DMA.  Wolfram mentioned one of those in his talk on adding
> DMA support to i2c.

Hmm, I see...

> Also, the reference in the file below to the wonderful case of USB to
> i2c bridges that always
> require DMA safe buffers.

Indeed it does.

- Nuno S=E1

