Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD73C1FE8
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhGIHS6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 03:18:58 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:21444 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230121AbhGIHS5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 03:18:57 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16976q6Y030563;
        Fri, 9 Jul 2021 03:15:57 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-00128a01.pphosted.com with ESMTP id 39nywam72x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 03:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbLh8blrnJJQN/Yf1gYJN70xVfHUnaUhlA17shQLKzu7t7bx1RqfCl+DbrBTZp4J2y5o4majpc1/MXW3UKILHLFO+2Z+/SCt3waster1VHaG8MC4JEc6Cyn20Cca/6puibhIh2Z+cp3LUgxdZSgCAFppfFkxupuo/ns6PtstIgUFj4Nyl7ETL78h6Wgvf1BEjTdqkW7A7w9TmCE6ezXu9g+2xBIbHtFcceQd6NZBG4rTm8Ify/ffQKT99Y5YLS2W5ZQAhWJBq93riC60YgJ180IWF0im+/UEGyqnbzUHEAbl0EU7vM8QTEt90URmOZNzBeobbL3CKXRTmh6K0UuiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJNfergDaAORVPuCE3CJ2QSXfJ7vcH+NJFYIhO5ns8w=;
 b=VMkO4hJrftZ82WEENCFi/5Urs2C7OC9Nqg1dao7wNh6qvqE4rcRW7kHItmPWZxSkIR23s8CbRy1Rt997CJZkqmHYQ/FLCxotFBKmro8VO3NFyXS72w1r9TE4taQCj7qtOcG7QRr/WqzagGA6SgR51wGDiCSD3dxJcxL25gKtVx6JKtK4lQmI9oHyLnc3cj04GmkkG7g9Obug4xF/HynbhWg0UYQ0/ojAmzPchPFdasuwmBBMHKL46uQkURaVmwIm4bHmn82Tfu9bKPGa6VDRAjyWSx1u4I3dmHd8znGqpsFmyL5pIvAYjtoWuQPjLlq3HTzoqmZViBSnNhZH4VeBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJNfergDaAORVPuCE3CJ2QSXfJ7vcH+NJFYIhO5ns8w=;
 b=pZzMZtr1uWYR52EntSvqN9izL4jrfsyS3cWkh2KvSNA/hZL5Ram3L57WHTEEZ3ubYRCTU+Apbd4QGgRL5PZIh7kOIVtTCZmZw7dSqcPfPXVvDr5IahFQ47UsHrx0pxuQWqiH9o/49RG5vdViK6g4qF0xcYTO8MgCfHP6YKCd9EU=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5894.namprd03.prod.outlook.com (2603:10b6:510:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 07:15:55 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Fri, 9 Jul 2021
 07:15:55 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v3 1/1] iio: proximity: vcnl3020: add periodic mode
Thread-Topic: [PATCH v3 1/1] iio: proximity: vcnl3020: add periodic mode
Thread-Index: AQHXc/U/Q114uXpUm0OlNRJ4Z2t99Ks6OFFA
Date:   Fri, 9 Jul 2021 07:15:55 +0000
Message-ID: <PH0PR03MB6366A1F0B5AB2963081A8CDB99189@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210708124115.558186-1-i.mikhaylov@yadro.com>
 <20210708124115.558186-2-i.mikhaylov@yadro.com>
In-Reply-To: <20210708124115.558186-2-i.mikhaylov@yadro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctN2RkOGVlZWUtZTA4NS0xMWViLThiNzEtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDdkZDhlZWVmLWUwODUtMTFlYi04YjcxLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTIzNjciIHQ9IjEzMjcwMjg4NT?=
 =?iso-8859-1?Q?UyNTU4MDczOSIgaD0iTHBQb2d4YkoxTjl6M0xFWVNqRGR4QlNzWWNjPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBSVlEQUFERDYydEFrblRYQVpYak9uRnFuazlHbGVNNmNXcWVUMFlGQUFB?=
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
authentication-results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6368a8a1-0ec9-4f2d-10d0-08d942a96474
x-ms-traffictypediagnostic: PH0PR03MB5894:
x-microsoft-antispam-prvs: <PH0PR03MB589478B5809503497F1C9FEF99189@PH0PR03MB5894.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KXnP4AJSsBdMVdugSVjGNEGwIKaQ3JXK4QIOFs8F/cVVwqpfigdiAWVcl/XGZmDbJhtsDjVkl1U0TP5mkG/eDjJvRVGmDuDGxtZTIGssDNTh2t7xcSa6jywiVrBsz9sGqv8zBc/J05r8oyqu4sdoIw7a7zH6fUidwoGynx81Wp+utVKFx/3EbHq9fC2UDNS0m3g1ojzlNbTwk9qtJG0HBqkDZ2ZpAAaq0cBqLRiyoiVU5dRuFlKRAuc56UsLbS5UIb8ZbVoRhSBOuCzZrPa97vX3akCjlFVbgFJBLOWA5ehAiyou4wxpEOjyaOk2vCcF2Np/aOGdboASX+R3dDnG6bGcnV6oHQI4K60mlr3dTcG74XwchjjM1YVZ6bPOi8kmMF+ZZXelGUd80yeYgMqxEhGxrEi6/CmMbNvhsp4Zi//AVdLEoBdLzg1uzSAt62+k/T6LQKY6SdToVQ0K8qN54dYOcKI0yelZjmbXQpYUYGXYhXFQp3BZa/QX+/w9lBfbvoSNl/JTvsMX+WcQORlqU7yWCL49ZHB9T5yyNOLx+WT83n3h+nHUdiAlhfYOiqiINewEnWjKVGaCJSpGHig4FvW1RY+Gi9UFhPakgnxu9z4JL9Ex0g3/5OPNLf5iG1QuAihvBQoZfRIaOM/3HpGuPJx+mmEJgWejNAhTSERdopfxgzQojb4MCk/BUNwJYYuPR0j1w9s7UkcMz2pQuK71KyqQnA+ChSo3Nyz5unCSi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(110136005)(64756008)(66946007)(9686003)(55016002)(5660300002)(122000001)(4326008)(52536014)(66476007)(966005)(6506007)(86362001)(54906003)(66556008)(66446008)(38100700002)(2906002)(53546011)(186003)(33656002)(478600001)(71200400001)(8936002)(76116006)(83380400001)(7696005)(30864003)(8676002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iMd4sa/qvG9KRhDrtOyMO9Zh53IMDl0UVyPQUsFWQSbVZfpEk2jfNAjyx/?=
 =?iso-8859-1?Q?J4UNtcQMhfEianguPRMdasxvz/tdAqEiZzA/gOES/2ZC1kUMOsQFHkxDtC?=
 =?iso-8859-1?Q?raSvWvETinTb2n9/IWD2EGMMAhQ1NxD+0H56RQF8MqMlX4actjORPAmYFq?=
 =?iso-8859-1?Q?wlWeUiIZO3WPuR0OyawnUqHwV9G10iWFbipjJs/Qeg0Jn8yOW+ezhDmLRh?=
 =?iso-8859-1?Q?onaJMdeoNAHqZmjgJYfPV1kyshVGcpRUeGq4Wbgd5fRVq3xQk3QosmONkq?=
 =?iso-8859-1?Q?Q/cbtyo+zhC1JtOgRbLMtNQ/bg5rIVz1GerKOcNSiMFJNWoMhlnCKecrj3?=
 =?iso-8859-1?Q?U55M7afgjM8kcRUn2XgdtDuSzw55TGXQS5p8UKqJV3TraRAdDKk985V373?=
 =?iso-8859-1?Q?BZ/mMeQW8Onqi+cH9nuR3XsH/BnsIlwbBstomoDEoLoNvwxe8UB/MuBRH+?=
 =?iso-8859-1?Q?rVaFtWibt1X1L4gMSKy/Sw/hwsyFXY7+P6XnXLr/t/RC8GYwsIHMi82Jeh?=
 =?iso-8859-1?Q?6HiaoIPWmPBOaBpaBbQxST1/G5O3mh/WLsKqHumPUeNX7rSa+I3HGR6J/v?=
 =?iso-8859-1?Q?z8wlelnpOydPzeWYuuZooL705yPxzi+dwll7/YWo+cH357QVaD/IC/HYA0?=
 =?iso-8859-1?Q?MxXMHjKEXksNBEmfRRe9UWDpRNEOxPXNr0/SlPpDnInIymwmt5OVWZs6CU?=
 =?iso-8859-1?Q?FXS4OjhbelX8G9WVy2SM9VTr3oC/5kHmRwz/2l3Sz3J8RzfYRkAhgV4rQh?=
 =?iso-8859-1?Q?lLM+bK7TyeEt5o2GkIQ1UqSytXW6QWxuzhGifvZLKpXWy/VcfFXX2Uiv8n?=
 =?iso-8859-1?Q?flMWvu1pq7GsbfcGmDJVPTu6D4Lni0gpMR3uHEjR1nxu34R6ydFkjEhQSp?=
 =?iso-8859-1?Q?xkfZpJjHsFE3AGLQuNYNbvTZjgjcW3JsiW2B3mkVDh7b1lJ0accLcGDTfh?=
 =?iso-8859-1?Q?w2yYpVseDu0p42jhpXgJCLVVlnYk19SsQiaErxc/Bpw2caYTq3lBwqoe06?=
 =?iso-8859-1?Q?BYekj5QX+Di7DlZA2laf6ZURpfsNdK9E/vnpQSS8nYK9AGnRlaichqbFK5?=
 =?iso-8859-1?Q?BeCZ0q3zF2gQNEoo1nFoZsjRW/UpJ6khAIeJ+piTiiiuNlR1w3VFDxlxkg?=
 =?iso-8859-1?Q?APVKTb6ntL4iPmtOzfaDTEkYl5j2I8T+NiPGOCgG2zyWRq5VEG7heiiX9t?=
 =?iso-8859-1?Q?I3wiAHGbZ+nVDtLyvvgo4JZxzm5r1HyqGQskWXblcUC5evY8I3Ov+egy7q?=
 =?iso-8859-1?Q?6q+cuvCRlodCBrVOfWNlnvmAUlhA7T8VtQUvI3movWSgsNLWNGr71hG7A+?=
 =?iso-8859-1?Q?GG2W8azWsqbcXlK9xPV55/mXC4v8qjjd9synZv8nM+bZaK3RCvrUKsvFWx?=
 =?iso-8859-1?Q?oqUk8fLJmjOQ8B9rrH2QutHufdNXz75BnTRs0oaRCwez09FSUO6czbxves?=
 =?iso-8859-1?Q?OMY6tevPeveoNCaa?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6368a8a1-0ec9-4f2d-10d0-08d942a96474
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 07:15:55.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUp1MsbPz8wJHZKJt0Q0+sGLj6GwY6W9UnBHnWzLc7AJow39GbScjF82saH9E+oQvxIUtEfFYjuvbmppyR3/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5894
X-Proofpoint-ORIG-GUID: DxTJsp85IAYy01fZmYKluMY_nl2I1u4W
X-Proofpoint-GUID: DxTJsp85IAYy01fZmYKluMY_nl2I1u4W
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_03:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090035
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Ivan,

This looks good. Some comments inline...

> From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> Sent: Thursday, July 8, 2021 2:41 PM
> To: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Peter Meerwald-Stadler
> <pmeerw@pmeerw.net>
> Cc: Ivan Mikhaylov <i.mikhaylov@yadro.com>; linux-
> kernel@vger.kernel.org; linux-iio@vger.kernel.org; kernel test robot
> <lkp@intel.com>
> Subject: [PATCH v3 1/1] iio: proximity: vcnl3020: add periodic mode
>=20
> [External]
>=20
> Add the possibility to run proximity sensor in periodic measurement
> mode with thresholds.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  drivers/iio/proximity/vcnl3020.c | 297
> ++++++++++++++++++++++++++++++-
>  1 file changed, 295 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/vcnl3020.c
> b/drivers/iio/proximity/vcnl3020.c
> index 43817f6b3086..cd5e9a34b93c 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -3,7 +3,6 @@
>   * Support for Vishay VCNL3020 proximity sensor on i2c bus.
>   * Based on Vishay VCNL4000 driver code.
>   *
> - * TODO: interrupts.
>   */
>=20
>  #include <linux/module.h>
> @@ -11,9 +10,10 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> +#include <linux/interrupt.h>
>=20
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
>=20
>  #define VCNL3020_PROD_ID	0x21
>=20
> @@ -37,6 +37,21 @@
>  					* measurement
>  					*/
>=20
> +/* Enables periodic proximity measurement */
> +#define VCNL_PS_EN		BIT(1)
> +
> +/* Enables state machine and LP oscillator for self timed
> measurements */
> +#define VCNL_PS_SELFTIMED_EN	BIT(0)
> +
> +/* Bit masks for ICR */
> +
> +/* Enable interrupts on low or high thresholds */
> +#define  VCNL_ICR_THRES_EN	BIT(1)
> +
> +/* Bit masks for ISR */
> +#define VCNL_INT_TH_HI		BIT(0)	/* High threshold hit */
> +#define VCNL_INT_TH_LOW		BIT(1)	/* Low threshold hit */
> +
>  #define VCNL_ON_DEMAND_TIMEOUT_US	100000
>  #define VCNL_POLL_US			20000
>=20
> @@ -215,12 +230,230 @@ static int
> vcnl3020_write_proxy_samp_freq(struct vcnl3020_data *data, int val,
>  	return regmap_write(data->regmap, VCNL_PROXIMITY_RATE,
> index);
>  }
>=20
> +static bool vcnl3020_is_in_periodic_mode(struct vcnl3020_data
> *data)
> +{
> +	int rc;
> +	unsigned int cmd;
> +
> +	rc =3D regmap_read(data->regmap, VCNL_COMMAND, &cmd);
> +	if (rc)
> +		return false;
> +
> +	return !!(cmd & VCNL_PS_SELFTIMED_EN);
> +}
> +
> +static bool vcnl3020_is_thr_enabled(struct vcnl3020_data *data)
> +{
> +	int rc;
> +	unsigned int icr;
> +
> +	rc =3D regmap_read(data->regmap, VCNL_PS_ICR, &icr);
> +	if (rc)
> +		return false;
> +
> +	return !!(icr & VCNL_ICR_THRES_EN);
> +}
> +
> +static int vcnl3020_read_event(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       enum iio_event_type type,
> +			       enum iio_event_direction dir,
> +			       enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	int rc;
> +	struct vcnl3020_data *data =3D iio_priv(indio_dev);
> +	__be16 res;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			rc =3D regmap_bulk_read(data->regmap,
> VCNL_PS_HI_THR_HI,
> +					      &res, sizeof(res));

Me and Jonathan actually spoke about this in the beginning of
the week [1]. For IIO we enforce that this has to be DMA safe
even though it's a 2 byte transfer... Check on IIO driver's using
' ____cacheline_aligned'. Note, that it actually matters for the
buffer/data to be the last member of the structure...

> +			if (rc < 0)
> +				return rc;
> +			*val =3D be16_to_cpu(res);
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			rc =3D regmap_bulk_read(data->regmap,
> VCNL_PS_LO_THR_HI,
> +					      &res, sizeof(res));
> +			if (rc < 0)
> +				return rc;
> +			*val =3D be16_to_cpu(res);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl3020_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	int rc;
> +	__be16 buf;
> +	struct vcnl3020_data *data =3D iio_priv(indio_dev);
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			/* 16 bit word/ low * high */
> +			buf =3D cpu_to_be16(val);
> +			rc =3D regmap_bulk_write(data->regmap,
> VCNL_PS_HI_THR_HI,
> +					       &buf, sizeof(buf));

Typically, AFAIK, ' regmap_bulk_write()' creates a DMA safe bounce
buffer for you. However I don't thinks that's done with that in mind
and I don't see anywhere on docs that this is something we can rely
on. Thus, I would also use the DMA safe buffer here and not rely on
regmap implementation details...

> +			if (rc < 0)
> +				goto out_mutex;
> +			rc =3D IIO_VAL_INT;
> +			goto out_mutex;
> +		case IIO_EV_DIR_FALLING:
> +			buf =3D cpu_to_be16(val);
> +			rc =3D regmap_bulk_write(data->regmap,
> VCNL_PS_LO_THR_HI,
> +					       &buf, sizeof(buf));
> +			if (rc < 0)
> +				goto out_mutex;
> +			rc =3D IIO_VAL_INT;
> +			goto out_mutex;
> +		default:
> +			rc =3D -EINVAL;
> +			goto out_mutex;
> +		}
> +	default:
> +		rc =3D -EINVAL;
> +		goto out_mutex;
> +	}
> +out_mutex:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_enable_periodic(struct iio_dev *indio_dev,
> +				    struct vcnl3020_data *data)
> +{
> +	int rc;
> +	int cmd;
> +
> +	mutex_lock(&data->lock);
> +
> +	/* Enable periodic measurement of proximity data. */
> +	cmd =3D VCNL_PS_EN | VCNL_PS_SELFTIMED_EN;
> +
> +	rc =3D regmap_write(data->regmap, VCNL_COMMAND, cmd);
> +	if (rc)
> +		goto out_mutex;
> +
> +	/*
> +	 * Enable interrupts on threshold, for proximity data by
> +	 * default.
> +	 */
> +	rc =3D regmap_write(data->regmap, VCNL_PS_ICR,
> VCNL_ICR_THRES_EN);
> +
> +out_mutex:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_disable_periodic(struct iio_dev *indio_dev,
> +				     struct vcnl3020_data *data)
> +{
> +	int rc;
> +
> +	mutex_lock(&data->lock);
> +
> +	rc =3D regmap_write(data->regmap, VCNL_COMMAND, 0);
> +	if (rc)
> +		goto out_mutex;
> +
> +	rc =3D regmap_write(data->regmap, VCNL_PS_ICR, 0);
> +	if (rc)
> +		goto out_mutex;
> +
> +	/* Clear interrupt flag bit */
> +	rc =3D regmap_write(data->regmap, VCNL_ISR, 0);
> +
> +out_mutex:
> +	mutex_unlock(&data->lock);
> +
> +	return rc;
> +}
> +
> +static int vcnl3020_config_threshold(struct iio_dev *indio_dev, bool
> state)
> +{
> +	struct vcnl3020_data *data =3D iio_priv(indio_dev);
> +
> +	if (state) {
> +		return vcnl3020_enable_periodic(indio_dev, data);
> +	} else {
> +		if (!vcnl3020_is_thr_enabled(data))
> +			return 0;
> +		return vcnl3020_disable_periodic(indio_dev, data);
> +	}
> +}
> +
> +static int vcnl3020_write_event_config(struct iio_dev *indio_dev,
> +				       const struct iio_chan_spec *chan,
> +				       enum iio_event_type type,
> +				       enum iio_event_direction dir,
> +				       int state)
> +{
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return vcnl3020_config_threshold(indio_dev, state);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int vcnl3020_read_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir)
> +{
> +	struct vcnl3020_data *data =3D iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_PROXIMITY:
> +		return vcnl3020_is_thr_enabled(data);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_event_spec vcnl3020_event_spec[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_RISING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_FALLING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE),
> +	}, {
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>  static const struct iio_chan_spec vcnl3020_channels[] =3D {
>  	{
>  		.type =3D IIO_PROXIMITY,
>  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.info_mask_separate_available =3D
> BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.event_spec =3D vcnl3020_event_spec,
> +		.num_event_specs =3D
> ARRAY_SIZE(vcnl3020_event_spec),
>  	},
>  };
>=20
> @@ -233,6 +466,11 @@ static int vcnl3020_read_raw(struct iio_dev
> *indio_dev,
>=20
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +
> +		/* Protect against event capture. */
> +		if (vcnl3020_is_in_periodic_mode(data))
> +			return -EBUSY;

This does not give you any guarantee that you won't end up calling
'vcnl3020_measure_proximity()' with periodic mode enabled... The
'if()' should be done under the same data lock that you use for
enabling/disabling this mode. Just push the check inside
'vcnl3020_measure_proximity()'.

>  		rc =3D vcnl3020_measure_proximity(data, val);
>  		if (rc)
>  			return rc;
> @@ -254,6 +492,10 @@ static int vcnl3020_write_raw(struct iio_dev
> *indio_dev,
>  	int rc;
>  	struct vcnl3020_data *data =3D iio_priv(indio_dev);
>=20
> +	/* Protect against event capture. */
> +	if (vcnl3020_is_in_periodic_mode(data))
> +		return -EBUSY;

ditto...

[1]: https://marc.info/?l=3Dlinux-kernel&m=3D162556231125061&w=3D2
- Nuno S=E1

>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		rc =3D iio_device_claim_direct_mode(indio_dev);
> @@ -287,6 +529,10 @@ static const struct iio_info vcnl3020_info =3D {
>  	.read_raw =3D vcnl3020_read_raw,
>  	.write_raw =3D vcnl3020_write_raw,
>  	.read_avail =3D vcnl3020_read_avail,
> +	.read_event_value =3D vcnl3020_read_event,
> +	.write_event_value =3D vcnl3020_write_event,
> +	.read_event_config =3D vcnl3020_read_event_config,
> +	.write_event_config =3D vcnl3020_write_event_config,
>  };
>=20
>  static const struct regmap_config vcnl3020_regmap_config =3D {
> @@ -295,6 +541,40 @@ static const struct regmap_config
> vcnl3020_regmap_config =3D {
>  	.max_register	=3D VCNL_PS_MOD_ADJ,
>  };
>=20
> +static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev =3D p;
> +	struct vcnl3020_data *data =3D iio_priv(indio_dev);
> +	unsigned int isr;
> +	int rc;
> +
> +	rc =3D regmap_read(data->regmap, VCNL_ISR, &isr);
> +	if (rc) {
> +		dev_err(data->dev, "Error (%d) reading reg (0x%x)\n",
> +			rc, VCNL_ISR);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (isr & VCNL_ICR_THRES_EN) {
> +		iio_push_event(indio_dev,
> +
> IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> +						    1,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +
> +		rc =3D regmap_write(data->regmap, VCNL_ISR,
> +				  isr & VCNL_ICR_THRES_EN);
> +		if (rc)
> +			dev_err(data->dev, "Error (%d) writing in reg
> (0x%x)\n",
> +				rc, VCNL_ISR);
> +	} else {
> +		return IRQ_NONE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int vcnl3020_probe(struct i2c_client *client)
>  {
>  	struct vcnl3020_data *data;
> @@ -327,6 +607,19 @@ static int vcnl3020_probe(struct i2c_client
> *client)
>  	indio_dev->name =3D "vcnl3020";
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>=20
> +	if (client->irq) {
> +		rc =3D devm_request_threaded_irq(&client->dev, client-
> >irq,
> +					       NULL,
> vcnl3020_handle_irq_thread,
> +					       IRQF_ONESHOT, indio_dev-
> >name,
> +					       indio_dev);
> +		if (rc) {
> +			dev_err(&client->dev,
> +				"Error (%d) irq request failed (%u)\n",
> rc,
> +				client->irq);
> +			return rc;
> +		}
> +	}
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>=20
> --
> 2.31.1

