Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BA3C2095
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhGIIP1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 04:15:27 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:9982 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231361AbhGIIP0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 04:15:26 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1698BPgx007182;
        Fri, 9 Jul 2021 04:12:30 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 39nywamcuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 04:12:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P14peQoXihJpNCuG/LajInosmsPnl6ehle/GJb39rghQ5/8ha4hJdfM81kWQf6mlwty0KUKCevsUxxelpjek9+z1UPrRVmuBK/Q9qzhyAl9UYyA6mHiOnB0T8iRGgrsaJ4mmEnnOXn3SQH+8MisQecF7gQSDeIR9rPfwUK70+chwTXYKkIMUvOWzmstU2ucCeDsTnSYQTj3tcepi0nCFkXhtC5JaclDyME2CiDwpiNjLR0wFugFw87J5EHNJ+/x8FnywafMxCCpg57jNZ77F3LBdBxy9X0Yi5aUNwlgfYlVf+IQUr11CKU05BmVROMbXwmnaevS8+oN+c7c0bohcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h524ftqpdyiyHHxHMTfuFX5+a5ThodOaJAd2Hp0sUEU=;
 b=NanrSOGVe5/R2+PLp/YUT2VKP5MsLxzI+BHo5sgzvjLDEZ1u69Xg1bF2wzREd4kNQ56vwAk/DMXP+kfVydwRbC3IYI6LrKu8rYJDrEs/itnXOEEz3yFL+zw4cjbWm+NLNtSOKMzjnXkeFZKUeyNFe1Rg8JfWtpWRgYRCOtSO9L+PWu//AD5S2Y3un/SbIVFEqQHtbDMIgV5v2xYm3W8Dhp8DAmCFcjgbYpwZw+m56zv5t19SnRM3KHBHGnc3MK3j85Ks1o9WfhrwzAVZR2uMp7sGNQNBxXWufQ0kWLZHmdwqT/YLs7mMU3dSudOKZ1WYAonmll+T0YSyKCUyP9zATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h524ftqpdyiyHHxHMTfuFX5+a5ThodOaJAd2Hp0sUEU=;
 b=8xnGhF2tuJuEUUeb0iXL0h9B73vVUJFCeordUJ46H/E6QDFNjFc2YbsSg3Mldr7jnO6cf+nmrhGHtfNWb5146Lk6qMzLoExCsdDttWlJvP1oKaCX/EgJEBzKGlnZoEYUIgGbS/iVYkxAxVPh/xNZm1Oq6FWAR8jNIstmEQvsg/E=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5798.namprd03.prod.outlook.com (2603:10b6:510:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Fri, 9 Jul
 2021 08:12:28 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Fri, 9 Jul 2021
 08:12:28 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v1 0/4] AD7949 Fixes
Thread-Topic: [PATCH v1 0/4] AD7949 Fixes
Thread-Index: AQHXdFTlcRfBdRSKwUuzfOuE6CaMR6s6S3Sg
Date:   Fri, 9 Jul 2021 08:12:28 +0000
Message-ID: <PH0PR03MB6366DF122EE2B4499BF3088099189@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
In-Reply-To: <20210708235618.1541335-1-liambeguin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNjU4MjhiMmEtZTA4ZC0xMWViLThiNzEtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDY1ODI4YjJjLWUwOGQtMTFlYi04YjcxLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTk1OSIgdD0iMTMyNzAyOTE5ND?=
 =?iso-8859-1?Q?czMTg0MDg5IiBoPSJJMHJYZUdDclMvQ1EzNkpLRlRhUHYvaXhyR0U9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJaUGRzbm1uVFhBZmhpTXBqOWlBWlArR0l5bVAySUJrOEZBQUFB?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 038af0fc-ebf3-450d-d39f-08d942b14b25
x-ms-traffictypediagnostic: PH0PR03MB5798:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB579819F28F3173AFC9563F9599189@PH0PR03MB5798.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPJBhmbD3P3p9zxChdXEADeB4ElbeYZy4xjHy+m9tfgfvnSkGacoUuRWoFw743GqgD8HZb00r2p8MTn05B3WshMP4LVTKT3xlP48o6VJvKnzyT9QeXheGONwHfdPARt675Ufy6z/thUVwafPSeScR3+alZKKMUqQ/gyLOdYt9M/aj3vi/K9GZxKshurOGRUKHvT2BS3Z53xa4yghy1479gV2ernvDdR/Ass2uuT/O9jHaldG9Y/38Scgnj3v0OpLoBLvPj86d2g5Meo41U0YxS4Je+54I1Z19OleKDt+aB593G5Qfn4z6pEbQd9bBZuGMZMCsEX42o+PWuDxBeLrPYV95JLlbEoS/jJRMQtCLiTTs/KSa5MMscKpnsZpq5QtGdrxqqlxmOK0OpVQhnUuPMa3tBOrvaeXuMvU5mL8aWm0/SRvRbBmgQ7EwI/gyLkE0za6L9jtLA59VEKXdARdRFMNVgAmAmFJ21XfUOQpC3es3SHTIokMQaRHikvE0rIvQuJefGBCOHnrMvt4rwUYUTXWMN20fPvHiAL3wj4+HCjPc4c9LsKYwvy1+nrFW/ZyoBILXItKy+EfMtXlbk1daywt10C8acZxmJcrJMUXCBwr6Ewx9GUnp3VSuANIUGeHCUr7iWNjm40acDWdCX8WKWOUbgtxm7YDt2xTUhSSLGcnfl14y9fMZeaCIXqAKGb9++8ZyNjgzQZvIx73gIrcGdrSf6iwn4zPs9y3F+OqoFQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(66476007)(38100700002)(478600001)(316002)(86362001)(5660300002)(52536014)(8676002)(76116006)(8936002)(122000001)(66446008)(66946007)(9686003)(64756008)(66556008)(186003)(4326008)(53546011)(966005)(6506007)(83380400001)(33656002)(71200400001)(54906003)(110136005)(2906002)(55016002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uDyDVH/NQrt8UUsmf7RqcfMloPbltknW2D2M4um91o5ns7r9+OfJMrk0U7?=
 =?iso-8859-1?Q?m+/6L7/2gpwcEvi6KSBnTEf+OeIcVaUDfWbx5VB59nd2yIxt7ykHy2go48?=
 =?iso-8859-1?Q?2c2sVbLoizg6GxwrDJVMW6A5JMj1KOT/GH/fLYoguZKJJvE74hMo0SjIGB?=
 =?iso-8859-1?Q?QaXS9+R4lPiyHM0RK1vmgOpZl3lqL/yYKw6L872fJP2vVSajPDyWXOaD/M?=
 =?iso-8859-1?Q?e/w3aKYIDccVwFYQrAiB+id5aMqyw5wUehADqaV4q3GU17BqtQpt/9WpTM?=
 =?iso-8859-1?Q?BvllaW7hhL4T2w3BjhWapkh3S0zfnhN3M+DoSMkyTOSfCFrrqOVA6hzcyT?=
 =?iso-8859-1?Q?d5mAUuoBH2aoTbaM48lJXvF4RyV5BzayYvrsIsd2fblbiTzBq7PQdQAcDh?=
 =?iso-8859-1?Q?ilpXHSoCs3rdtaaJim8VeWBKzbeE/uzOA8te59+7fwXQG4xKhtBTvx8eKT?=
 =?iso-8859-1?Q?RVRXQBex/7GuS8z44W2Q8zPnY5Kq4jwMDNMwdsiZmUMLL0mmnJtaI60UJq?=
 =?iso-8859-1?Q?e0zgr0fMNYmTrFZkvgF9VIjbSZom04TBoQzV7+T9tZNfUdCCgknzw2MXoH?=
 =?iso-8859-1?Q?TMV7K2Ff0vPH+K1cC+8zQe1+KfTdQTU39L3DP6XpWWJoIhN+QlAWJdG6ze?=
 =?iso-8859-1?Q?9aInIxChLq5+AoDD5TYsTRrRhbdwqhvsQEMyW6BVVckUDIRU8037puzI26?=
 =?iso-8859-1?Q?GVabx1yu/b8flkfNrv6Nd+tIV2iwevrUPdagC8sZI9ZP6B0aWJeNVE8i+I?=
 =?iso-8859-1?Q?m1DjA+U7XFqmkgpqz9qR8VGDz4cCCBk7CZJevEZn+6y+GMVBGCUwsp91r1?=
 =?iso-8859-1?Q?f19cPfgwLxEr8fvnEwWS/yfAY3GsLNFd1PxEZlEhQBvf3y15kJdLZaEsNj?=
 =?iso-8859-1?Q?8VCngViHS2jDDQoTGg8WVfk0BeXz1wW1+isWpDI1tqUaPJ//raHbMtYU2U?=
 =?iso-8859-1?Q?i2DHBRwF6F3iGFQZuOWR2kGATedxkm44Kc7tBG+svlKEZNkRFrbuTqN5mY?=
 =?iso-8859-1?Q?WxQU8TfOL1nnnBFIVbUYyR4io0+edw6ivDnncuFToIMAL5nvyg4bHydZrH?=
 =?iso-8859-1?Q?veEvgfupo0dtH8Skbdxj5ezdRVYaTEj7SneIWdIroPuwncZoYgewlIQVXx?=
 =?iso-8859-1?Q?FL17JBJtChoh5CAH6Mlom5dwJX5LQCTu8LcuTARg8eomx/6z0z+xeFBOf2?=
 =?iso-8859-1?Q?BspWFaoCKwv13KKAo3XaDesVJCKFuXWvhO2ugmHLbfoFjCU0RQ8XfUu92F?=
 =?iso-8859-1?Q?MC9G7tdMaqkYNu8lntHSyGXg6q/SyQoicE5R+WGY/DPTJqQmmB5oPyf+Tc?=
 =?iso-8859-1?Q?9CKIagHt3iDZbsGXXh5QWcPNFHQOVM2vjUH9QaKR1vG+YfCIwrJLzBrSx0?=
 =?iso-8859-1?Q?2NHnNBd+hyJMDnfBgJlGA0qyxzhdib1sJtSHxFj6+/xgn4e7hC0mScmdkT?=
 =?iso-8859-1?Q?+rRp0CskiVCL0srA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038af0fc-ebf3-450d-d39f-08d942b14b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:12:28.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y40Ehd5IKTmrALBexRUsJl6JZtSM3P2oObqeNf6NJLFpZkvMgfVwS6W/vaSqMqw/n3QeyjzOiQ01rCvsdVNg4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5798
X-Proofpoint-ORIG-GUID: gryva2ymgy8IhkorXnHcyuBwiTqFfoLs
X-Proofpoint-GUID: gryva2ymgy8IhkorXnHcyuBwiTqFfoLs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_04:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090041
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Liam,

The series looks good. Just some minor comments from my side...

Thanks!
- Nuno S=E1

> From: Liam Beguin <liambeguin@gmail.com>
> Sent: Friday, July 9, 2021 1:56 AM
> To: liambeguin@gmail.com; lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; jic23@kernel.org; charles-
> antoine.couret@essensium.com
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: [PATCH v1 0/4] AD7949 Fixes
>=20
> [External]
>=20
> While working on another series[1] I ran into issues where my SPI
> controller would fail to handle 14-bit and 16-bit SPI messages. This
> addresses that issue and adds support for selecting a different voltage
> reference source from the devicetree.
>=20
> This is base on a series[2] that seems to not have made it all the way,
> and was tested on an ad7689.
>=20
> [1]
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/li
> nux-iio/list/?series=3D511545__;!!A3Ni8CS0y2Y!rF7O-WxC7HZM4hv_o-
> zYPtVCmZlDoASzPvamwwQkH9llVS8J-GpfQltvDBz7gQ$
> [2]
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/li
> nux-
> iio/list/?series=3D116971&state=3D*2A&archive=3Dboth__;JQ!!A3Ni8CS0y2Y!
> rF7O-WxC7HZM4hv_o-zYPtVCmZlDoASzPvamwwQkH9llVS8J-GpfQluZ-
> w3LYA$
>=20
> Thanks for your time,
> Liam
>=20
> Liam Beguin (4):
>   iio: adc: ad7949: define and use bitfield names
>   iio: adc: ad7949: fix spi messages on non 14-bit controllers
>   iio: adc: ad7949: add support for internal vref
>   dt-bindings: iio: adc: ad7949: add adi,reference-source
>=20
>  .../bindings/iio/adc/adi,ad7949.yaml          |  22 ++
>  drivers/iio/adc/ad7949.c                      | 191 +++++++++++++++---
>  2 files changed, 181 insertions(+), 32 deletions(-)
>=20
>=20
> base-commit: 6cbb3aa0f9d5d23221df787cf36f74d3866fdb78
> --
> 2.30.1.489.g328c10930387

