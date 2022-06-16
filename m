Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89754D71D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jun 2022 03:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355228AbiFPBeI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 21:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350881AbiFPBeH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 21:34:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B76B37BCA
        for <linux-iio@vger.kernel.org>; Wed, 15 Jun 2022 18:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzdSuY6xdxKJwLTR7G0TeduY1UVQcASyDZU9BWGJ9v6S5wnQizF4wjhpRSkXORPmoxQDuN95/OxhvDavuV7/JyKeSvGdSHvyE+f1mb6qU+CHmgnceHUT755g0+D+RTYhx0gY1V/IkpuIgAoX9nr/vmTwkUM0lTOOqhufPVAxFXNJRSwfVlfV+QMFKP776wYwsPXcve0Z+tWHVUgLMbrQG5SbQjJRZMCjmiMqZrMloTVOoI7Y8gnYaRt9u6Qx5cpjY5tuNXzRhxUsLcnM5YBnyel4dyz80ed4t2gwzEFMnrDKJE5YPKzoLu6hNMSiFVXh1HolW50EIcuzRd0+cmpilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dI6d9Bq6Gg8Fo+W3DUa6rBILOufB5q1Uz46lcuD11A=;
 b=M6celIrGGVa/7NeR9FfAUIUh2hoH7b2bww2sAh3WPAyFcNPQiKxZJmGmptKmUv/KeNhAOzs9hQVbLaOAa5RHZaXMyVkK/j4ixe6DrlmtZe88Ec3pfNlFsqDi8yIjupZASOcS9lBDO55wpKp40wnsEPR323X2kDwhj/5Q7b0oKQQvDlp7DzYRG6jCMAbKiqt8cN7BSgDIY6e7br+g6Np0UExVGRMU2j6xuTk5FEgfw51vUVnbtcPLSrSvNHpUq+z5KqxpB0dOPaz+C3qvh/ySGWGgteIB8yW0J4lWlFW3AmZ+Fu2boiFTl41uxhMT8W1eYz5rwMvmJQU6x7mRJ5S27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dI6d9Bq6Gg8Fo+W3DUa6rBILOufB5q1Uz46lcuD11A=;
 b=mGR+qFvtiwu9KXjS2RTcLrOkmYEyG3YPDeu85QlQ4dEXSnX0xmNkvH8t5m9WZ8bk8XDU8eHeD62r7q727QVJNi+uQCSOGY0o2X+qL8Fqewurr6ILxTPh9wwS/2SjI2Jo0PIU7yom91dKPLeZmy99VhuWnsvR0iXLBXlgHmkCZVs=
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com (2603:10a6:208:5d::20)
 by AM6PR04MB4261.eurprd04.prod.outlook.com (2603:10a6:209:3f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 01:34:03 +0000
Received: from AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::f843:aee5:eb45:dfdf]) by AM0PR04MB4001.eurprd04.prod.outlook.com
 ([fe80::f843:aee5:eb45:dfdf%5]) with mapi id 15.20.5332.020; Thu, 16 Jun 2022
 01:34:03 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] iio: accel: mma8452: ignore the return value of reset
 operation
Thread-Topic: [PATCH v2] iio: accel: mma8452: ignore the return value of reset
 operation
Thread-Index: AQHYgK16geCb0Tacn0mJ881ojAj8ZK1Qo5eAgABVPQCAAEdgQA==
Date:   Thu, 16 Jun 2022 01:34:03 +0000
Message-ID: <AM0PR04MB400175936806774093E463F590AC9@AM0PR04MB4001.eurprd04.prod.outlook.com>
References: <1655292718-14287-1-git-send-email-haibo.chen@nxp.com>
        <8690f687-8f9d-b03f-226f-3a289e718ed5@redhat.com>
 <20220615221552.0d8afb3b@jic23-huawei>
In-Reply-To: <20220615221552.0d8afb3b@jic23-huawei>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c9063a-7406-4cee-4de2-08da4f384bbb
x-ms-traffictypediagnostic: AM6PR04MB4261:EE_
x-microsoft-antispam-prvs: <AM6PR04MB426124B1008779329B19BA9F90AC9@AM6PR04MB4261.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUCet5AJPiFfx4/KCqH78hKCg+Vms/Ghcjrw7FLewTqhetwfNgu2uN/hs+jtgAWRQgQEHIFk7lGJ0l0OH8sM8YW5yvigrMnCD+qVpSuppAEcCYapvszPiHc3p41CMNAUZ8OFFh1Kcx9eB6QlcakpcybWAynjQzTDs50xVmwI1CUyx61w52NLpa6I7EfKRr3xAY0kAmOxuWeYhGxQ0v0NRPB/Ii9GEMoJcZc9KEhevzoD4P3jf24ssTETxoW8u9m3sUaFxhIP25JG78cKciMZErAE6t0reJ6evbrpJWtyBEMNzzryctSkzDLGvQYZe87Zcslg4kad4SxhVrdj3ESKhkonxg3eABbDh4Rw74txFDr92/N2j3J3HrC5y3zesAOy/tS04b2KUn+E33/m3WY+nAoFjuBEuBz//4FlMSQ0kd62qQph3XHEzzfdauUHxmbmb0xnp6BX6U/6zc4VJrBokK4CMtg+jZEcbRzO801KvPv6gFPUUAtsC6V3bs6Ts80CfXgEODcMlx/ftqjxJFNS1xKcjqbEOzBwlw8SZKErVmUL+P95YzG646HysiZLbiD+kcVQ5wi26UFCa1Ex52eixPhUiBCerA9hZFWEUnQNetVF3GprX8TjBzy6s5kDqet4aKw3R8XbwvJ4oU6Ac0UYDrT5IGhZ9kQRSNvwPwfa0eaVt2sq8Z5Pw4TENnYOL5NfFKdPqGI7tk98ZLxia/EsyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4001.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8676002)(66446008)(4326008)(76116006)(66946007)(64756008)(66476007)(66556008)(7696005)(8936002)(52536014)(316002)(86362001)(508600001)(26005)(38100700002)(38070700005)(6506007)(53546011)(110136005)(122000001)(9686003)(5660300002)(83380400001)(55016003)(2906002)(186003)(71200400001)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bDNqeUl0aFVlaS9BbnY2aGIzUVN2ZUdVOVhqL3RmSXRpaGM4WWtuaFYyeERq?=
 =?gb2312?B?aFZVbEZtYm9XbXM0Qld2SUhUbDMrN1NwdGFkS2F1YVZDVGNwdlV5VE1DRW5T?=
 =?gb2312?B?cUdWbUtRQ2pqR1RLbXplR0QwUnBjdDd3ZmFzN2xieXk2MmlKdEhZeElNM0R3?=
 =?gb2312?B?K3ZXdnlPY3VTVER0R28vMytoVnFsNUdwRUMrdjFKbzNYeWlhQnBMbFV3YkNY?=
 =?gb2312?B?YTVNK2l2UWhTTTBsdUhiclUvaG9aaytEQjhpYUM2dDB1NHZGaFNlQXFoQitk?=
 =?gb2312?B?TEoxWGJuRzNFRSt3dWNhVmMrQ2duTkp6aEhONFV0ajdFblpibG1EWHVKdC9B?=
 =?gb2312?B?NGx4Q1l6cVBWdzRhQURDL1dWRjhYN3N5Z0p2N1dvNXdpU0FoZmw1Rk40aHU4?=
 =?gb2312?B?dS9wWS8xR2ZCUXJsTU4vVzhGVmV4TWp2S3NUdXRlcHg2ODFBZFoycmkzelRH?=
 =?gb2312?B?K0NnQklYcGJJS0dmSFltOFZIbzlJSHUvK1RRTG5VK0xSdXpNYzBOZ3JHZlJK?=
 =?gb2312?B?bC9NUkdIMkpVMkZaZmNFSTN6Q29uU3ZMa3gxWjdtTDBRd2RZcFNMVGE0bG1h?=
 =?gb2312?B?YXp5cHhiVlVxYVJFR24rTHY2OWpGSHlzODhTNFFtalVjaWlwVlNKb3M4UWpz?=
 =?gb2312?B?R2V1ckhLd1BBUVRKYkVWdFM2VVdST083MlJnOW81cmxEVUU1am1qUnYyL1JH?=
 =?gb2312?B?cUNmbmg3R1JreW04MmEvck42Mmp0Zmd6VU9FaHRJNmRYQllxdGtXcXZwVmJH?=
 =?gb2312?B?dUk2TGZ6cEp2czFINTVZNmFCNUNhRXk3UGJiYVgwenF2WHBnQjJ2a0p4UTla?=
 =?gb2312?B?S0NFYThGY3Y0UE9YT1F0aGRVSGVKS1VCenV0akhBWnFldlduOXBsNHJRU0hR?=
 =?gb2312?B?Q1JjQkhMQXlPS09mSEd0ekVweG1kNkFBK1Y2S0pmeWZVWW05eStJdWV0bmdT?=
 =?gb2312?B?aUU4cFlpd2YrN2VNZ0FrV0VOd3JGS0ZhNGx3eDk5RHFNeHg1NjhLZ2xvMnRC?=
 =?gb2312?B?NEZaUFpkSWpZNWZpWnlSTit4YWFGQ0xlbWNvVUxQcHVNYjB0T0JBU1k4Qmlj?=
 =?gb2312?B?NXcwR0pOUGNZR0NJb05HY3JUeVFLc1ZzY1RPYll5Z1lQWmk5RWtub2EySnN5?=
 =?gb2312?B?OUh3VFE3bEIrS2thdWZNZEY5NWNWZE1HcjNoUmI0U3lyWDdyUXJDOTRCQnpX?=
 =?gb2312?B?N1NEUXoyazZoUHplTXkzV3ZLUXdRWXhpZHRXbG1NcGJiZFA0Q042R0ZSdlZF?=
 =?gb2312?B?QWsySDFMcWREYmVrYTcvckRLS3NCUklXanNZc0E2RXhtL0huc2MyQjZKVlJL?=
 =?gb2312?B?aDlMUis5ZkNlSzJ2LzVVUmhaL2NkQWxVdjlBd1JnckR4cWtBelpMeVVrN2w2?=
 =?gb2312?B?N0pNZVFvQVdNbW9ZeVM3Q2pNWDNsbDhaMURaK2RaSWRMS3lmcU4yOEZoSnJT?=
 =?gb2312?B?K3NYaUQwd3BXMU5CUXFqc0xOd2F1Qko3MjBuTGUxSkYrNmtPTjVncDl0M0M0?=
 =?gb2312?B?dDdlMzFHaDVLbjlDZzFjR0N6Y2hKKzVpN2xRZWk4SmVmVnhNUHFmdDZXdEpF?=
 =?gb2312?B?Sm5ycUU3OXlYQnU4U3dkMTZ0b0VRQWpTVWZKV29PTzdUYWttaXREa1MvWkNx?=
 =?gb2312?B?U0w5VkQvblYvOG14a1ZON0N2RHB5L21lM3FxNjdCN3ZobUZ2bDB3TmY1YjJs?=
 =?gb2312?B?M1Q0bm5NS0xwRitEMkhKRVF2VDBHbzM3WWRDSUpEZEJkMU1zbUJlNUpEdmJG?=
 =?gb2312?B?T0dEQnJnV2dhZ0h2aGh0b0hvdytwSTBzQjJXeGVuZ0ZZVWRkaUtyZjhCT3hv?=
 =?gb2312?B?a1JVRjEzTUljaGprT2FjVVJFZXhOdXVYVjh6WHpsSTJkQVltYmNZM1JSZjBP?=
 =?gb2312?B?dEdsbGZKdGVxQVk5RUFHbHU4U0s1b1JUNWd3T3llL2RFcmh4cVdKMDBBQmZ3?=
 =?gb2312?B?QURhNWt5UnA2LzJTZzh1TSt3TGw3Y1VDWHB3UEJiNGJ1cVEvUUhvaUNDTERZ?=
 =?gb2312?B?cnprSm9zNGxZT2tIV1FhQmExYmdBM09LWGZwYi9URU83MFpDdmpZZWVGY1A5?=
 =?gb2312?B?T2hHZzdYVDFQaXNHa0E4UDg0Zjh3NXJMNnJ3eW1DV2VTcHhMRnUvRFE0Um1x?=
 =?gb2312?B?UERzSmE4ZW0zOFY2ajBWUi9Fb29PNWI1YzdqMVhna3dRQXVGMVI2bUZQSTh5?=
 =?gb2312?B?MHJMbXNnbXhIS2wzbXZnaXVkaHQwME1sRGFpSW80MXc1aG0vbFVNaCtGMm9j?=
 =?gb2312?B?Q2tKa3R1OWxPejgwbkNScDZmbWFacHRocms2Wnc0dURYTCsvQVV5Vm8vV0tj?=
 =?gb2312?B?dzE0ZjQ1Ty90SmNOZmtJTW1YcGNhcnYzQTZBbFZDS3NkQTJEK2dQQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4001.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c9063a-7406-4cee-4de2-08da4f384bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 01:34:03.3050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTBKEVN57GOtoCKYLrkoeRIwCm/I7N8JoMQAPnfq1JPI893e1Ev5xSzrHu1PejeRzdjWts6PDt9ZO9CQ/n1fUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4261
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo21MIxNsjVIDU6MTYNCj4gVG86IEhhbnMg
ZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+DQo+IENjOiBCb3VnaCBDaGVuIDxoYWliby5j
aGVuQG54cC5jb20+OyBsYXJzQG1ldGFmb28uZGU7DQo+IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5v
cmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjJdIGlpbzogYWNjZWw6IG1tYTg0NTI6IGlnbm9yZSB0aGUgcmV0dXJuIHZhbHVlIG9mIHJl
c2V0DQo+IG9wZXJhdGlvbg0KPiANCj4gT24gV2VkLCAxNSBKdW4gMjAyMiAxODoxMDo0NyArMDIw
MA0KPiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+ID4g
SGksDQo+ID4NCj4gPiBPbiA2LzE1LzIyIDEzOjMxLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6
DQo+ID4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gPg0KPiA+
ID4gT24gZnhsczg0NzEsIGFmdGVyIHNldCB0aGUgcmVzZXQgYml0LCB0aGUgZGV2aWNlIHdpbGwg
cmVzZXQNCj4gPiA+IGltbWVkaWF0ZWx5LCB3aWxsIG5vdCBnaXZlIEFDSy4gU28gaWdub3JlIHRo
ZSByZXR1cm4gdmFsdWUgb2YgdGhpcw0KPiA+ID4gcmVzZXQgb3BlcmF0aW9uLCBsZXQgdGhlIGZv
bGxvd2luZyBjb2RlIGxvZ2ljIHRvIGNoZWNrIHdoZXRoZXIgdGhlIHJlc2V0DQo+IG9wZXJhdGlv
biB3b3Jrcy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5j
aGVuQG54cC5jb20+DQo+ID4NCj4gPiBUaGFua3MsIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWU6DQo+
ID4NCj4gPiBSZXZpZXdlZC1ieTogSGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4N
Cj4gTG9va3MgdmVyeSBtdWNoIGxpa2UgYSBmaXggdG8gbWUsIHNvIGZpeGVzIHRhZyBwbGVhc2Uu
DQo+IEFzIGl0J3Mgb3RoZXJ3aXNlIGdvb2QsIGp1c3Qgc2VuZGluZyB0aGUgdGFnIGluIHJlcGx5
IHRvIHRoaXMgbWVzc2FnZSB3aWxsIGJlIGZpbmUuDQoNClRoYW5rcyBmb3IgeW91ciBxdWljayBy
ZXZpZXcuDQoNCkZpeGVzOiBlY2FiYWU3MTMxOTYgKCJpaW86IG1tYTg0NTI6IEluaXRpYWxpc2Ug
YmVmb3JlIGFjdGl2YXRpbmciKQ0KDQpCZXN0IFJlZ2FyZHMNCkJvdWdoIENoZW4NCj4gDQo+IFRo
YW5rcywNCj4gDQo+IEpvbmF0aGFuDQo+IA0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPg0KPiA+IEhh
bnMNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvaWlvL2FjY2VsL21t
YTg0NTIuYyB8IDEwICsrKysrKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2lpby9hY2NlbC9tbWE4NDUyLmMNCj4gPiA+IGIvZHJpdmVycy9paW8vYWNjZWwvbW1hODQ1Mi5j
IGluZGV4IGUwZjBjMGFiZWQyOC4uYzdkOWNhOTZkYmFhDQo+ID4gPiAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvaWlvL2FjY2VsL21tYTg0NTIuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9paW8v
YWNjZWwvbW1hODQ1Mi5jDQo+ID4gPiBAQCAtMTUxMSwxMCArMTUxMSwxNCBAQCBzdGF0aWMgaW50
IG1tYTg0NTJfcmVzZXQoc3RydWN0IGkyY19jbGllbnQNCj4gKmNsaWVudCkNCj4gPiA+ICAJaW50
IGk7DQo+ID4gPiAgCWludCByZXQ7DQo+ID4gPg0KPiA+ID4gLQlyZXQgPSBpMmNfc21idXNfd3Jp
dGVfYnl0ZV9kYXRhKGNsaWVudCwJTU1BODQ1Ml9DVFJMX1JFRzIsDQo+ID4gPiArCS8qDQo+ID4g
PiArCSAqIEZpbmQgb24gZnhsczg0NzEsIGFmdGVyIGNvbmZpZyByZXNldCBiaXQsIGl0IHJlc2V0
IGltbWVkaWF0ZWx5LA0KPiA+ID4gKwkgKiBhbmQgd2lsbCBub3QgZ2l2ZSBBQ0ssIHNvIGhlcmUg
ZG8gbm90IGNoZWNrIHRoZSByZXR1cm4gdmFsdWUuDQo+ID4gPiArCSAqIFRoZSBmb2xsb3dpbmcg
Y29kZSB3aWxsIHJlYWQgdGhlIHJlc2V0IHJlZ2lzdGVyLCBhbmQgY2hlY2sgd2hldGhlcg0KPiA+
ID4gKwkgKiB0aGlzIHJlc2V0IHdvcmtzLg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJaTJjX3NtYnVz
X3dyaXRlX2J5dGVfZGF0YShjbGllbnQsIE1NQTg0NTJfQ1RSTF9SRUcyLA0KPiA+ID4gIAkJCQkJ
TU1BODQ1Ml9DVFJMX1JFRzJfUlNUKTsNCj4gPiA+IC0JaWYgKHJldCA8IDApDQo+ID4gPiAtCQly
ZXR1cm4gcmV0Ow0KPiA+ID4NCj4gPiA+ICAJZm9yIChpID0gMDsgaSA8IDEwOyBpKyspIHsNCj4g
PiA+ICAJCXVzbGVlcF9yYW5nZSgxMDAsIDIwMCk7DQo+ID4NCg0K
