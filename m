Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49553A5E6F
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFNIft (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 04:35:49 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:25578 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232528AbhFNIfs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Jun 2021 04:35:48 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E8WVJD000524;
        Mon, 14 Jun 2021 04:33:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 394sj7p421-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 04:33:40 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15E8X8rG002066;
        Mon, 14 Jun 2021 04:33:40 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0b-00128a01.pphosted.com with ESMTP id 394sj7p41x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 04:33:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc9iwt0do8S0/azz1YrFRKeEv1AR506QBZUgbb9/GnJO3+Iq5ussjqhONU4RCND5HrwRHdqYPAPl/wM8PpWLE74VgO5mDatj3mW7LCtOn3FIuJqCQK7j7Wepb4rdh8uBhIMy7YCQ9blSn0gs3szWOGmbBqS2dwb5+fBLpMVoZaqx0iqU+FN4E5l4JengcDGHiFkiiB9TFnb1lQ3cJBWSZLwwhipmHmaR3e9eYNWFUA+dYBOEZJfJSUg908IIb5shmkGjWOQ3sYlBF2E862NUw1F85Hd9Pesfao069YUQoefxJ/kujSzIHX7+0PcpZjHjR36386NGrrhyY47HBcor2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxTMqR1lxLGrVvD9aqcofP3Fialy3RIrQq0LykbLv7k=;
 b=A0x5E37fa0crspjH/j1oNlZZdZS5LqsD5fPEb1ueDzemngdJAoldIc4AvNw7koTs15XSl0tt7Pu0XoABzyrZ9Gs1qzJ/Q05vXGe1V3RJOWfmvjZwVz/wI4eMjpAOZsYjZ/wnPoD3FGqky13d9b+35PVZAFpCtwZakWE9E+H2cAaHLvB9M5L9GYN0NcW7VSJHF9E64IblU7eM2eLP2keA7PZbKbzv7K9fcUx3KFXQkM28ld2FgNHQykIh2mUbcC79ShBVZWbi2YvQIRzldNAB0HJq0gQaFYzWs9OMlnfyJNI3Fr4zU2q6wPi+WT6U8iH0FD+Jc1FygDEQH8y70IBz9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxTMqR1lxLGrVvD9aqcofP3Fialy3RIrQq0LykbLv7k=;
 b=DZ5+OntCB75R2iCb7rz9wQzRCFKXEG7A1eLKhKpTVmndqyBc/HNl45Eo8Cn+ymMLjXpo7GZzz0U2983geyjmmqDiX+dM7AfMg9eyTbEzyqcUkncyWUzTbAbTKWIvwp3zYxuFZyxCR/OnxYVPxIPStqEXAcJMpTWMvFMKlwXSEns=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5767.namprd03.prod.outlook.com (2603:10b6:510:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Mon, 14 Jun
 2021 08:33:38 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4173.022; Mon, 14 Jun 2021
 08:33:38 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 1/4] iio: core: Introduce
 iio_push_to_buffers_with_ts_unaligned()
Thread-Topic: [PATCH v2 1/4] iio: core: Introduce
 iio_push_to_buffers_with_ts_unaligned()
Thread-Index: AQHXYGYF+3Wfe6ykCkCyTKr9zQmlN6sTLRJA
Date:   Mon, 14 Jun 2021 08:33:38 +0000
Message-ID: <PH0PR03MB6366316685FFF56C4EDC660C99319@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210613151039.569883-1-jic23@kernel.org>
 <20210613151039.569883-2-jic23@kernel.org>
In-Reply-To: <20210613151039.569883-2-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMzY3YjcwZTYtY2NlYi0xMWViLThiNWUtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDM2N2I3MGU3LWNjZWItMTFlYi04YjVlLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMzY3OSIgdD0iMTMyNjgxMzMyMT?=
 =?iso-8859-1?Q?gyNzk4MzE1IiBoPSJXaWVFNkdJamgwUm5kbVNVcnRRUXM4M0tFbzQ9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQURyenhUNTkyRFhBVlBNM3lONThmNUJVOHpmSTNueC9rRUZBQUFB?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:255b:f101:f55e:b075:2abb:d2f5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f166d156-96f7-48be-98d9-08d92f0f1b95
x-ms-traffictypediagnostic: PH0PR03MB5767:
x-microsoft-antispam-prvs: <PH0PR03MB5767106EDC7CDA8254142C8A99319@PH0PR03MB5767.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXZlcfZ1i6DnZqS3BZ5qZOzc506to/1centznNXuqTuDZ7BTJvGeiceFdxOm+PyALobnMdKCCC7dXupDKSt2MgUYFUv8MAWmT6AuSZ/ofD4DFvPOm7m92U6tkAYUF1zm2o7kEF/moSSfrdUNq6ztlDGL3mtGWR7Uq2dUXrtrTsa0Se7WtjcCbke3Pw3nhyzMa0fbojLDQqXSuMpn/r4RlUf21VDDm6D9UgprNfmDRmqCargRykUy08HNKrDggK1QwSjMG/+1FobLHw/Ou5szsoOOtpefAU1VnlNzHpP+buScOSvhhtQNb4tpp4lVIuLOOf39dnSxwyJYDFbsny29VWnjI7jXwq2aQH79iuV0ZQ1XOajaikF0rYyyS46HRPBhGyfwXWR3AwInbQE//13u7jZYToFIRDHc+/PfbZM1p57e7wMvgNFuX164c2SvJHAlYPs8HAe01tvfvhaLUB6y9cHLq4mmhB4rxhTRijkBq5gQpxBGeyAeGt/cH/BOMA/V50UsrD+qa4w9nBqtmzmSeHnUuHKcqjcZGC5eDZAM5wpdc9ylsgLBO9jQ/6E9WEBHV5ko8gg838otaJa3sEmuBojKuVU47I5q5P5H/35ZGis=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(6506007)(8676002)(55016002)(53546011)(4326008)(86362001)(66446008)(66476007)(66556008)(64756008)(5660300002)(66946007)(8936002)(122000001)(38100700002)(76116006)(33656002)(54906003)(7696005)(110136005)(2906002)(9686003)(52536014)(316002)(83380400001)(478600001)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pgdMpys0xEXW3e4XA3ZJbRkyYYn3/CuTXL7Dibdf49N1zdJoD5fXEBcD4q?=
 =?iso-8859-1?Q?JN/P/aeKovKF0NDgte20DwAl/bHDS922yocp7fxRmZualR7cjaBsbSQYxJ?=
 =?iso-8859-1?Q?Q+QulpOsPUhsWVVFWI6uJvEIRu4W+GH9kyS0+IpxvySwJO02EEd41JgmdK?=
 =?iso-8859-1?Q?ic5ciiSO42yYNc8K5lpX4wgaSMn4pxFeXUDoM++IFLgyRrLN1xxPyhHjCA?=
 =?iso-8859-1?Q?nuKi16O9rt1bbs7B2B11GczqgKKqlg9+etsQTqiE720UELrFkWmNO1twhK?=
 =?iso-8859-1?Q?J39AP9Xq7FNGNfCCE8c0Ta1Ya+1hDTY5MREGYr4Ob7sJhaeCPZu3evzEPm?=
 =?iso-8859-1?Q?0zxxD3MLa53Zsm91WaoKnwGcWGEHHUR0ZYGinEKBYN/wYMt/1hCQK5inFZ?=
 =?iso-8859-1?Q?6NXR6EffmjzHBXB06AmoIYA9Hc6NqzF2cgNI34IkepRoWsrK5hoYRU1GmR?=
 =?iso-8859-1?Q?qqkZh/OTWbzZ9baxCidi4ONAifu6ESP58TvMwkStey7bKNIxk72d1vEd51?=
 =?iso-8859-1?Q?iyUL/UiI7ZLjcUCInMi0mUM6ddI6sMDoa8QUJg3+bwyQVOGXx6e1sszOgb?=
 =?iso-8859-1?Q?9mxeeiq8aoEEgd+sfgke69o74R2Hw13POENvGIqrZIiJjhsZBG3vjb6ws/?=
 =?iso-8859-1?Q?56Pq1aaErbk438t5StyyMTsyueZnlUD33QxImXdicx63jB6epQwM4eXX8c?=
 =?iso-8859-1?Q?AKD7i3O0cz44ikZ0Fc8DRvpeVIHgVrPWPRHh0+doZLqMdjLi5m/w9oWh3e?=
 =?iso-8859-1?Q?TATU4QgYb/ZGofH4yzgTOClM8Clpe7XCMFmPdcxMOaeLccRoUP2PHLLq3b?=
 =?iso-8859-1?Q?PsEP8yL/RbSddXoRsQ+UKdzkw0R6KqxQBzeXGtfX1x5Ghki/88CDJ4dQKY?=
 =?iso-8859-1?Q?Gl0ZKN0WzNd6kgpM13tts+gqzM96Vd1DuQAZXo2ZkzaP/eudzGER55ivuw?=
 =?iso-8859-1?Q?iilbiqjjZEZ7kJzNwNpZ7IHID289g9FFKCDtCK4jv7FBPni798VrIu48e9?=
 =?iso-8859-1?Q?2EMTK+UOZa3NKOFCCsbVKgxnbmsBjHugLmpZA0LXxpU+Pj7k52Bos/rmBr?=
 =?iso-8859-1?Q?ho8+jNaliwKpAAbO2QZK1q9xNIJl0u6zUf3W4rXCNU9FsJoFYbE4chDnXR?=
 =?iso-8859-1?Q?xpG1s5cin0HRC7ps/DSeZnGMx5VzJrdwForhDRgdzrEHsVyxYntjzn11tE?=
 =?iso-8859-1?Q?xobv93WWKT+XN8qaz6j4YJo72W+uhEVWDWG97EPaiXKkwAcFBtFHNCmeqh?=
 =?iso-8859-1?Q?DPeQu2/psJrwY0nU+8II+Kywo7Hd0Wig0ex0dMuKMOWHX1FHBM3KT+CAY7?=
 =?iso-8859-1?Q?YpM8qoZVOpoe63751SDlW7ISUdPgLj5XDXlkMvbE/FJXNMxr/fQ/L+R1VQ?=
 =?iso-8859-1?Q?blfcLmnrJombrY01Ho30vQDfhNH1LT9Bzi8yJxUHS0XbKHBABIT4kAfbx3?=
 =?iso-8859-1?Q?8aeocom8ugjejcRK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f166d156-96f7-48be-98d9-08d92f0f1b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 08:33:38.2045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptA9oL2tkPgGBwOQx5mGgPsV7iAFQSXdO7BkcZgQ1mgCab/jPCdrIExT+3hMmUhEj1exQ7IOP0fLd/icXQg1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5767
X-Proofpoint-ORIG-GUID: MbuRdVmFbjuMUtOHqcBLH7oO02zOrc6M
X-Proofpoint-GUID: hpHxK7IpzGpgtY1csnHmP0rHWEJ9FSTr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-14_01:2021-06-11,2021-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140061
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, June 13, 2021 5:11 PM
> To: linux-iio@vger.kernel.org; Andy Shevchenko
> <andy.shevchenko@gmail.com>; Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>; Jan Kiszka
> <jan.kiszka@siemens.com>; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>
> Subject: [PATCH v2 1/4] iio: core: Introduce
> iio_push_to_buffers_with_ts_unaligned()
>=20
> [External]
>=20
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Whilst it is almost always possible to arrange for scan data to be
> read directly into a buffer that is suitable for passing to
> iio_push_to_buffers_with_timestamp(), there are a few places where
> leading data needs to be skipped over.
>=20
> For these cases introduce a function that will allocate an appropriate
> sized and aligned bounce buffer (if not already allocated) and copy
> the unaligned data into that before calling
> iio_push_to_buffers_with_timestamp() on the bounce buffer.
> We tie the lifespace of this buffer to that of the iio_dev.dev
> which should ensure no memory leaks occur.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-buffer.c | 46
> +++++++++++++++++++++++++++++++
>  include/linux/iio/buffer.h        |  4 +++
>  include/linux/iio/iio-opaque.h    |  4 +++
>  3 files changed, 54 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-
> buffer.c
> index fdd623407b96..5241b5a5c6c0 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1730,6 +1730,52 @@ int iio_push_to_buffers(struct iio_dev
> *indio_dev, const void *data)
>  }
>  EXPORT_SYMBOL_GPL(iio_push_to_buffers);
>=20
> +/**
> + * iio_push_to_buffers_with_ts_unaligned() - push to registered
> buffer,
> + *    no alignment or space requirements.
> + * @indio_dev:		iio_dev structure for device.
> + * @data:		channel data excluding the timestamp.
> + * @data_sz:		size of data.
> + * @timestamp:		timestamp for the sample data.
> + *
> + * This special variant of iio_push_to_buffers_with_timestamp() does
> + * not require space for the timestamp, or 8 byte alignment of data.
> + * It does however require an allocation on first call and additional
> + * copies on all calls, so should be avoided if possible.
> + */
> +int iio_push_to_buffers_with_ts_unaligned(struct iio_dev
> *indio_dev,
> +					  const void *data,
> +					  size_t data_sz,
> +					  int64_t timestamp)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque =3D
> to_iio_dev_opaque(indio_dev);
> +
> +	/*
> +	 * Conservative estimate - we can always safely copy the
> minimum
> +	 * of either the data provided or the length of the destination
> buffer.
> +	 * This relaxed limit allows the calling drivers to be lax about
> +	 * tracking the size of the data they are pushing, at the cost of
> +	 * unnecessary copying of padding.
> +	 */
> +	data_sz =3D min_t(size_t, indio_dev->scan_bytes, data_sz);

Well, As I said in the RFC: "I still feel that if we are taking the data_sz=
 parameter on
the API, we should handle it more strictly. But I do not feel too strong ab=
out this (as
you said, It's not expected to exist too much users of this)..." :). And we=
 can always
become more "strict" if we start to see people doing really bad things... S=
o, as you
said, most likely we won't have much benefit from the added complexity.

Being this said:

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

- Nuno S=E1
