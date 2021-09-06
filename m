Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7130C401950
	for <lists+linux-iio@lfdr.de>; Mon,  6 Sep 2021 11:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbhIFJyg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 05:54:36 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40628 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241394AbhIFJyf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Sep 2021 05:54:35 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 186151jw010850;
        Mon, 6 Sep 2021 05:53:17 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0a-00128a01.pphosted.com with ESMTP id 3aw90ta98r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Sep 2021 05:53:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZxuFlgjen9PVTTPbWoYGdhfkSpIwy3pGmY/yS0RsGsQu1h6iXFOjBf/yI/+uWXG/UhdtxChzga1GNCvxNazqvVQy8LbT82jBhwUzrV+rvj9447g8Ej1HXNr27qSF1VF8cMBM+hvYK/ePR9rXX/Vn1fHug4fXWO4zsIDD+Y9jlbOIDZalwX+G3170rcbqj3fQFpDDHk3vsne39/0x8843pHFEGqSgm+XJoUTM8uejX8eWNqoIfjFDLbLYZF7r4aAJVDKTyLKPctTwDFoovdiwLiFvFP0h2FtOrFN4sr3hZYRhAqsGlSw+G1ZGj1/USp5vEhv063coQaOOOPTlYgndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6nEPLXd+mMR0mGQwgpFyqv4H1jUcv0tdxf/kjSnT15I=;
 b=b8nSxWP/RYWxYA4VqdawrhD3qz2RnqYzyoAElOa4p19UjDQyQxQZo6rDFHPNNCid6Tc2QcLFGh/9tZXT1EgX9U7u6GFPOyS4NMyexbytkldB2xBknWbznvp71XsW4fd2zFRJwXWUQC5MQ+CP2KXtaeXKcP10njU5nXKqC4XYpG06yu6ev4SNhKBKBiz+B2zojb4CCNYwAiQpJ8Eq8cg1e308Om8wEoRgB/BHlDNvE1kb9nQaOTCi/L2rdNpBsunZHM0BnCIdK0V/pthekLZRsH3oo8Ot+XOBQFaYTJqm2Rz+dNRhG41lO89kytcla5EaXScOe4XEEmV7y4BjSe44Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nEPLXd+mMR0mGQwgpFyqv4H1jUcv0tdxf/kjSnT15I=;
 b=0KEkwHe23nB/I5CnXRJI58NlW6qZKP7oZcQ+r4VdK9z+qBh0WreCKRjOrqip/ArMB5zsxj2aUf7QR92QcwY15Mu+2PUX0ffDypiLul5jsPd2QroSjHH/VSSdv5AvRsBPpdxV4LwD+XkTyYB2kJLGhXvrw/YHy5DWvzzyTFHRXe4=
Received: from SA1PR03MB6355.namprd03.prod.outlook.com (2603:10b6:806:1b6::10)
 by SA2PR03MB5740.namprd03.prod.outlook.com (2603:10b6:806:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Mon, 6 Sep
 2021 09:53:15 +0000
Received: from SA1PR03MB6355.namprd03.prod.outlook.com
 ([fe80::f0f4:64cb:bc0b:95d9]) by SA1PR03MB6355.namprd03.prod.outlook.com
 ([fe80::f0f4:64cb:bc0b:95d9%9]) with mapi id 15.20.4415.024; Mon, 6 Sep 2021
 09:53:15 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v2 15/16] iio: adc: max1027: Add support for external
 triggers
Thread-Topic: [PATCH v2 15/16] iio: adc: max1027: Add support for external
 triggers
Thread-Index: AQHXoD+VwudYE4ERnEq6/GLTGzMNpauVoKsAgAEnY2A=
Date:   Mon, 6 Sep 2021 09:53:15 +0000
Message-ID: <SA1PR03MB6355E88079A1B425FC236F3399D29@SA1PR03MB6355.namprd03.prod.outlook.com>
References: <20210902211437.503623-1-miquel.raynal@bootlin.com>
        <20210902211437.503623-16-miquel.raynal@bootlin.com>
 <20210905171046.1681482d@jic23-huawei>
In-Reply-To: <20210905171046.1681482d@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctM2Y4YzY2NGItMGVmOC0xMWVjLThiOGQtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDNmOGM2NjRjLTBlZjgtMTFlYy04YjhkLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iODExMSIgdD0iMTMyNzUzOTU1OT?=
 =?iso-8859-1?Q?MzODg4Nzg3IiBoPSJZeHE5REV3TldGbmQ0R0UzSFV2SlRLWEtCRFk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUFUb2ZjQkJhUFhBZk9MZ0QwejlINDI4NHVBUFRQMGZqWUZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVhtWmdqd0FBQUFBQUFBQUFBQUFBQUo0?=
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
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2271a9f2-18f5-4808-9c8e-08d9711c2588
x-ms-traffictypediagnostic: SA2PR03MB5740:
x-microsoft-antispam-prvs: <SA2PR03MB57400B08CEB7D7201B2423C399D29@SA2PR03MB5740.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H4QaEPXLgHl+W6cbfWoCUarAgrJVxrfzOdMi0BkhwG8cIZ+LvHjzxQnQwlgFMjecFIbpKc97npA1j0Bz0kZD4RGVqrcM/6rgNl1mUSptgKToYoDRgrtMjlJ3i7qt2oTs5UrRM3j1e64zAHMELcjlhKzywjq5ewWWtl+A9aLXlGcS3MguMH18ozus7x/FpUsyc+Pfzgt9u9WlWI+/YxlbInGD+yzPQKhkBuyTW0BChsIJYlGHZ4KljZMcgFiTHs3TSGnYroiJc82O84qdffkqtbLcyROhCKVxjTiZ+pPxWSNaCqsV3S7NOwBY6EpR756po0pGbe5FzfBZuKB3ihUiLh5mpruUBNTlP6E+VeBgos5lYdzth4LJLAN3HstgU5WFzs3qjwD1BKaTCquVkSJUxiU8o0/7/uJnhTMBDji5LhNX1xujN9KC+YBAAOkbmdiVIbT9zTcliiU2EzEgy1pS7Q1bGqkkdU57S6bCLzsBkxuJwYOSJqZg07Psvr1tsdPygquPZ8poEejD2v6KZ4YZ0xNL7OPF/5bURPC+6ZbJ8W8xbjlTH7kIU2Z8zEU9Thts2efJA6nK44Nl0pHM9k493H+Rh3g4Og4Wn71ACdOPylAsk5+HLvfjrGkMTd2xGJsop1MrLxtepuKm9OOznrO8Z63p6xW193hiDJSG323jDbnTB2kExaprWqyC6g1AdTK7rMWLZ90GqeW8AMq68iE8KA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6355.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(83380400001)(71200400001)(9686003)(54906003)(110136005)(33656002)(5660300002)(8676002)(122000001)(316002)(55016002)(38100700002)(4326008)(86362001)(478600001)(6506007)(2906002)(53546011)(38070700005)(64756008)(66446008)(66556008)(66946007)(66476007)(76116006)(7696005)(186003)(26005)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zFJfkiwpVzNEl9TM6uNCYxChp26CwoxV9xnISUw2DMj7MJ/EGnZiWrGYvB?=
 =?iso-8859-1?Q?u4a/l4E1MqiJSaWEEOfQGywAkm3yNy/d0SIZSlZzdzue82RUc9KWcyAaRf?=
 =?iso-8859-1?Q?uptDMEZv1HFEiDERzECG7eBBWMaMSpUUsauYgX925rRyyhQ/u+hyXrqNoY?=
 =?iso-8859-1?Q?m7XPHtXu0exJUqwTNi9SBYxTSPSlE7vAugsIps8OkyWcO0bXLpvkwaTk4Z?=
 =?iso-8859-1?Q?tUwK1N9QP+ZUuvP9qmWUpBRDyncVpSA6/KHDCEnRUqYNJao8acif6TRftI?=
 =?iso-8859-1?Q?6Kzw58+InyMX5B+5QvWQ8ombZidWoOlxNNdfq5AoixdGwmYrY0O6wlQPPm?=
 =?iso-8859-1?Q?MBK2giuAHiz+o6c2Hxq+jYEeR3tId6znyYl1snMawW15jRprgr5DWIn4CP?=
 =?iso-8859-1?Q?IIF79k2kGlOrzEoU94tl/GzKY7qrK6GOjI0yFLIJF+j7MovQamnTKt21rv?=
 =?iso-8859-1?Q?MDjR+/Q/Pxf8mr0RSOfRi+mmLEZsUtZ+JIL0Qx+Oeo5t1AgK7n2jpQMY2L?=
 =?iso-8859-1?Q?N3w7pS3hR0thFaGRY5daW39F6oSZcoxTgRb0cZWjMF4IsvJ3yPrH98xrU6?=
 =?iso-8859-1?Q?0WiAMXpdPzVRO0C2N7HiPMDbZMBXXUnltf0Rt0/aT9BHXBULMkth9uZPIE?=
 =?iso-8859-1?Q?dGvZLbVnxf3VI6GlRExDVGrK1LUhDz0qZLcojY/P1ZpeRwobvxlY5Za5OV?=
 =?iso-8859-1?Q?v/h7zqEkXST5UcRpKOja5k0sHNADxyVgxfXa9aeMe2/wrZFZtUfx2rIbhg?=
 =?iso-8859-1?Q?lOJn0K0O/FiJ9bl1b+9kRcenY8tu3nOEMOk4M9pTZbLDMvx7uwuwq2viOa?=
 =?iso-8859-1?Q?PO3bGAWGp2Vgk+ghf5My73wGuP5jWs03dFmEITEcMWob8SGdfNn1GRWj2U?=
 =?iso-8859-1?Q?DRh9GK6XwqKy95mbuumI3Eakb/dHUmYqy1KgXN4PjLep1K88oNu0NZ/TRG?=
 =?iso-8859-1?Q?GZr+zqAL4qOBh8vunkb6rcee3aPf1ye9JjD5EzlVXWyRim0J7zbFi+3GTj?=
 =?iso-8859-1?Q?y6F+K+5uJhtVw+vxgO+4Xi44dYE5eyWZsQtuBER1mf/nMEe+NFqSLwGVFh?=
 =?iso-8859-1?Q?fNzCD+3pq/vpL6e78rIvBSIZlZcRJ/5ug+4zaX3jh+A+UVFY1P80qRVK1p?=
 =?iso-8859-1?Q?IXSZkvbp2hzoZ9RanHRWcx6SEM342KyKyX/v5yk7kS6N1//u9KzdLGDx+d?=
 =?iso-8859-1?Q?2HWuqYa1WKmbhiMps/QGDekdVOOdVoZh1jlZ3orXPk8b0ZIRvTwLOMziJ6?=
 =?iso-8859-1?Q?tVyr7utwnbkew1X6mYwfO57Uh7yjhWwf/gn6q+PvRXLMOcmA/hNBE8sL++?=
 =?iso-8859-1?Q?UoRn+K2Uw9+F8/zuz5uQPjZAKi+GGeYCH/4YZD/cRGlsghDJ2fI6Yb1OCh?=
 =?iso-8859-1?Q?PhC8xP3VLZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6355.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2271a9f2-18f5-4808-9c8e-08d9711c2588
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2021 09:53:15.0337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aflkJtW39zXgxVA8YOdqwYOsG4Me5mY9+8tRomikYi3C51SBZLpCQPMfQF9MXHJLpBu/SvpxB8XmYWEh6JPwRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5740
X-Proofpoint-GUID: ZbNrIDuXi5dsXE3RK2COmFXR4s8tm3Wz
X-Proofpoint-ORIG-GUID: ZbNrIDuXi5dsXE3RK2COmFXR4s8tm3Wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-06_05,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 adultscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109060062
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, September 5, 2021 6:11 PM
> To: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; linux-iio@vger.kernel.org;
> linux-kernel@vger.kernel.org; Thomas Petazzoni
> <thomas.petazzoni@bootlin.com>; Sa, Nuno <Nuno.Sa@analog.com>
> Subject: Re: [PATCH v2 15/16] iio: adc: max1027: Add support for
> external triggers
>=20
> [External]
>=20
> On Thu,  2 Sep 2021 23:14:36 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > So far the driver only supported to use the hardware cnvst trigger.
> This
> > was purely a software limitation.
> >
> > The IRQ handler is already registered as being a poll function and
> thus
> > can be called upon external triggering. In this case, a new conversion
> > must be started, and one must wait for the data to be ready before
> > reading the samples.
> >
> > As the same handler can be called from different places, we check
> the
> > value of the current IRQ with the value of the registered device
> > IRQ. Indeed, the first step is to get called with a different IRQ
> number
> > than ours, this is the "pullfunc" version which requests a new
>=20
> pullfunc?
>=20
> > conversion. During the execution of the handler, we will wait for the
> > EOC interrupt to happen. This interrupt is handled by the same
> > helper. This time the IRQ number is the one we registered, we can in
> > this case call complete() to unlock the primary handler and return.
> The
> > primary handler continues executing by retrieving the data normally
> and
> > finally returns.
>=20
> Interesting to use the irq number..
>=20
> I'm a little nervous about how this has ended up structured.
> I'm not 100% sure my understanding of how you've done it is correct.
>=20
> We should have the following situation:
>=20
> IRQ IN
>   |
>   v
> Trigger IRQ / EOC IRQ  (this is the spi->irq)  (currently
> iio_trigger_generic_data_poll_ready)
>   |              |
>   ---------      v
>   |        |   complete
>   v        v
> TrigH1    (TrigH2)   (these are the IRQs below the irq_chip IIO uses to
> demux triggers)
>=20
>=20
> So when using it's own trigger we are using an internal interrupt
> tree burried inside the IIO core.  When using it only as an EOC interrupt
> we shouldn't
> be anywhere near that internal interrupt chip.
>=20
> So I'm surprised the IRQ matches with the spi->irq as
> those trigH1 and trigH2 will have their own IRQ numbers.
>=20
> For reference I think your architecture is currently
>=20
> IRQ IN
>   |
>   v
>   Trigger IRQ
>   |
>   v
>  TRIG H1
>  Either fills the buffer or does the completion.
>=20
> I am a little confused how this works with an external trigger because
> the Trig H1 interrupt
> should be disabled unless we are using the trigger.  That control isn't
> exposed to the
> driver at all.
>=20
> Is my understanding right or have I gotten confused somewhere?
> I also can't see a path in which the eoc interrupt will get fired for
> raw_reads.
>=20
> Could you talk me through how that works currently?
>=20
> I suspect part of the confusion here is that this driver happens to be
> using the
> standard core handler iio_trigger_generic_data_rdy_poll which hides
> away that
> there are two interrupt handlers in a normal IIO driver for a device with
> a
> trigger and buffered mode.
> 1 for the trigger and 1 for the buffer.  Whether the buffer one is a
> result
> of the trigger one (via iio_poll_trigger) is down to whether the device
> is
> using it's own trigger or not.
>=20
> Jonathan
>=20
>=20
>=20
> >
> > In order to authorize external triggers, we need to drop the
> > ->validate_trigger() verification.
> >
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/iio/adc/max1027.c | 59
> +++++++++++++++++++++++++++++++--------
> >  1 file changed, 47 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index e734d32a5507..b9b7b9245509 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -414,17 +414,6 @@ static int
> max1027_debugfs_reg_access(struct iio_dev *indio_dev,
> >  	return spi_write(st->spi, val, 1);
> >  }
> >
> > -static int max1027_validate_trigger(struct iio_dev *indio_dev,
> > -				    struct iio_trigger *trig)
> > -{
> > -	struct max1027_state *st =3D iio_priv(indio_dev);
> > -
> > -	if (st->trig !=3D trig)
> > -		return -EINVAL;
> > -
> > -	return 0;
> > -}
> > -
> >  static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig,
> bool state)
> >  {
> >  	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> > @@ -469,6 +458,13 @@ static int max1027_read_scan(struct iio_dev
> *indio_dev)
> >  	return 0;
> >  }
> >
> > +static bool max1027_own_trigger_enabled(struct iio_dev
> *indio_dev)
> > +{
> > +	int ret =3D iio_trigger_validate_own_device(indio_dev->trig,
> indio_dev);
> > +
> > +	return ret ? false : true;
> > +}
> > +
> >  static irqreturn_t max1027_threaded_handler(int irq, void *private)
> >  {
> >  	struct iio_poll_func *pf =3D private;
> > @@ -487,7 +483,47 @@ static irqreturn_t
> max1027_threaded_handler(int irq, void *private)
> >  		return IRQ_HANDLED;
> >  	}
> >
> > +	/* From that point on, buffers are enabled */
> > +
> > +	/*
> > +	 * The cnvst HW trigger is not in use:
> > +	 * we need to handle an external trigger request.
> > +	 */
> > +	if (!max1027_own_trigger_enabled(indio_dev)) {
> > +		if (irq !=3D st->spi->irq) {
> > +			/*
> > +			 * First, the IRQ number will be the one
> allocated for
> > +			 * this poll function by the IIO core, it means
> that
> > +			 * this is an external trigger request, we need to
> start
> > +			 * a conversion.
> > +			 */
> > +			ret =3D
> max1027_configure_chans_and_start(indio_dev);
> > +			if (ret)
> > +				goto out;
> > +
> > +			ret =3D max1027_wait_eoc(indio_dev);
> > +			if (ret)
> > +				goto out;
> > +		} else {
> > +			/*
> > +			 * The pollfunc that has been called "manually"
> by the
> > +			 * IIO core now expects the EOC signaling (this
> is the
> > +			 * device IRQ firing), we need to call
> complete().
> > +			 */
> > +			complete(&st->complete);
>=20
> Completion shouldn't be down here in the trigger handler, it should be
> in the top
> level interrupt handler.  So you need to replace the
> iio_trigger_generic_data_poll with a specific handler for this device.
>=20
> > +			return IRQ_HANDLED;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * We end here under two situations:
> > +	 * - an external trigger is in use and the *_wait_eoc() call
> succeeded,
> > +	 *   the data is ready and may be retrieved.
> > +	 * - the cnvst HW trigger is in use (the handler actually starts
> here),
> > +	 *   the data is also ready.
> > +	 */
> >  	ret =3D max1027_read_scan(indio_dev);
> > +out:
> >  	if (ret)
> >  		dev_err(&indio_dev->dev,
> >  			"Cannot read scanned values (%d)\n", ret);
> > @@ -504,7 +540,6 @@ static const struct iio_trigger_ops
> max1027_trigger_ops =3D {
> >
> >  static const struct iio_info max1027_info =3D {
> >  	.read_raw =3D &max1027_read_raw,
> > -	.validate_trigger =3D &max1027_validate_trigger,
> >  	.debugfs_reg_access =3D &max1027_debugfs_reg_access,
> >  };
> >

I'm also confused by this. Going through the series, I was actually
thinking that raw_reads were in fact using the EOC IRQ until I realized
that 'complete()' was being called from the trigger handler... So,
I'm also not sure how is this supposed to work? But I'm probably
missing something as I guess you tested this and how I'm understanding
things, you should have gotten timeouts for raw_reads.

Anyways, as Jonathan said, I was also expecting to see the 'complete()' cal=
l
from the device IRQ handler. Other thing than that is just asking for troub=
le
:).=20

- Nuno S=E1
