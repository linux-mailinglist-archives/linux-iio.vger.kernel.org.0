Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA86A7BE8
	for <lists+linux-iio@lfdr.de>; Thu,  2 Mar 2023 08:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCBHf3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Mar 2023 02:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCBHf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Mar 2023 02:35:28 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2109.outbound.protection.outlook.com [40.107.135.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDB166D0;
        Wed,  1 Mar 2023 23:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdvI6jxl06e8QldAKyf/mcytGn/hkhDLQ3dNULEFivWr6tRHEPtA3nVzuQx8HUHu+gZgl9m+eCK7H2DR0Gt5g47NLtrbzIYhBSe/8PzKH8n4HNM+ymcdN4R4af7LbqRklXF/dG8rC24l57nUva93CGyhd9yvfvh1+g/zGPEPQ1Ilu616ibcRhRBS733YIdnSIt4FAu+3qDflzmNualUhfNTVtn75I5rzEQcma+YC3xvz6EVPOgnHtrm2c7wu38SGfmnoaRV0EiqmZCCUySMFHj4Ac1VazMrJbKtZKbSnGk5iCZ/V1bu54WyZNR8tl5ZI7LymAfR4JfN828HH5DsLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHM07Ia9kNgnR44Rp/k4/tqMVZIVlJJHGkJIRPI9Jw0=;
 b=hIxhTlfW7wGE0A5+GoyWwoDZMGRNw91a4UdW5/FKTNBh0QUbzDLyRI2FNLLYan9Z2TXZw/+k5QLjW8fvf1ZKt7uvaco68DF4CJKpG0Ksao1XgJR2lRIeBhD3mqDsnHDG11VwX/fcrKLBj47+jnOzwzRQ8ZtKOrRt9JAx1Da6GOhe5CTJQVo9KCBCHe7pjh+cXt+43ml8eOdXJdoq1TCoT3vtkMzZp/PXP4sxtOkW/WPHGT+P341NrkX0SxdZrOssZAXhVzWDcooneOe9uUz/biVTV1K0FmvpSa0tEELEXb5+ulOSAAdxV+3F3Q+FDeUNEAfl88XU26dFfSGOcGEYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHM07Ia9kNgnR44Rp/k4/tqMVZIVlJJHGkJIRPI9Jw0=;
 b=Toaj3g1iZBO7rA1sbFjzKWNOTF+J5dlgZxEb7Y2jhCKtZNaQ226TbY28VyS8nCh6WUghIS8qwYuN0UbkrhGlTdgOmB/fMRowStl+Frglc0xAN73l7qVffpuR0oOUZWXfoLiTkVBiRJKU1vQXznntx2ZPOiCHOvKWhaJEN78ZIEk=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BEZP281MB2978.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 07:35:22 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8%5]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 07:35:22 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Thread-Topic: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Thread-Index: AQHZRtj7z7K/u6iCTU+V9BreEYjFrq7hfZiAgAWnzIA=
Date:   Thu, 2 Mar 2023 07:35:21 +0000
Message-ID: <103531fc-e7c1-090f-a172-073a399f6380@fi.rohmeurope.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
 <20230226171329.4ff6ac8b@jic23-huawei>
In-Reply-To: <20230226171329.4ff6ac8b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BEZP281MB2978:EE_
x-ms-office365-filtering-correlation-id: aff2a9ae-376a-4721-97fa-08db1af0ae24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: re/Zh9NwYzqgHjTBRzvLzLwT/ZOy+CPKeZUBf38IdBE5o/jvHNsT4I0k/ErTjyXbaWUf8nxNyv2FeXsr89IyzQv05TKdUbDHMXGtNdBCHZ6/G6+04W8LibMyIjeE0PHQPdSqturLdbMvnmEg3BSqXaQAfpnr4YTEn2CRRbu4jh0NBCMccfL0Zl40D81WJ3JhsC2juoEhB8xsON1FDd2I9lmwRHPPqdlZnNjbMvoA3emFGK0ZHcPOk7DjCbPx7ISOJQI/bqv6MLNOPtonRtIJB2fthta9Rt6g/AWZWXTzUdM/CqhhAhp22G10Vo9EAGfFNjtwHETaDdGL9ZgHrdEBbjQsEfXMiZVVPZFh3PrngumpM30N7X+fjxcutFMjS+9eZviPVTEWKoliPuRtPBQSEcMeV77gSYrjm6rdyonm6G1TJXUIjp4VyhG2l+uR0ci4W+WeZZ/oyUBCYxf/jSZ7ZgBkAyumvSxkoxutEHdGA/Q77ykNLTWRw0eu5zubbzbzqXDkNm6Avuznwoi0x7cIHXCjg9dcysktj+qeXh+K3o/itgsiNegkXGtiOP9Qv9jmSLeTjA6wucTKoasLzzLqDM8eTSvNKEdIIza9PY4wHAQrFBpVfDxDjVKG0KkdEQyjNa0XohMyrHuAuIsPcLgHHe73TqBiVSP/oSyHqba8B0Ya61l0m4zF04LV8t8QBPm0oacdemUalWtuI7oHvm8fuSLvY+NE943M6ysF2S+gDcN4d0q3V/yFWFbyi65ir4FF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(39850400004)(396003)(376002)(451199018)(83380400001)(66556008)(31686004)(122000001)(5660300002)(8936002)(478600001)(7416002)(66476007)(71200400001)(31696002)(86362001)(38070700005)(38100700002)(2616005)(186003)(6512007)(6486002)(966005)(53546011)(6506007)(8676002)(66446008)(76116006)(30864003)(2906002)(64756008)(4326008)(66946007)(316002)(91956017)(41300700001)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGJsNFZIS3hmSmlsRUZmd3I5eTFvb0toUS9OSktVRjBia2haT2dlczlpSWpu?=
 =?utf-8?B?MTQ2U3ZCcVJTMW1mN1k2bStRZ3pWS3BxdWdRZjVqN1pUUGpBVGFDeE1TM0Vo?=
 =?utf-8?B?cU12WXAwTXRpeUpDQjZTWXBHR1MrcVJWcjhmQlM2V2hIa2hkY1NjTFVWbnNO?=
 =?utf-8?B?aHNjMzBWQVcxWHoreDFvbjlRN0tvemc4ZUdNNjFtMUJiU3l6ajRML1daT3Js?=
 =?utf-8?B?T2RLSnEwaXd3V0dYZmRONEVzanltVXFKb3dkWUFrQjl3MDJjck1mamVTTjVa?=
 =?utf-8?B?UVlOdmRHUkhqc3RCb3RTbDNGYU1rMFBhd0hxZWNmUnpxeXRLTTByZ2ZTUFFs?=
 =?utf-8?B?T245NDJFWEwrZlR0bll1aU1DN0JQbm52ZVU0VEpGTG1nU29ZdnZtQml6NGgr?=
 =?utf-8?B?cmpRMURMeENQNC9aZ2NEZ3lxVmoyc1Y2Z1I2dTJObjZheFJ0a0hhYXA0SFRP?=
 =?utf-8?B?czM1SkIrUEI5UE1ZMjVrT2ZmcU5scVZIY1hPUFpFMmdpNDBvWUlpdUtyVVNt?=
 =?utf-8?B?VlFXeGtxYWRkcmRyM1o0UHE4QWQ5Wlg5d0hhMFhmQjJTZHVIayt1dE9aMGtH?=
 =?utf-8?B?TTk2bjdNZ2ZORG1JSXg1K3Yxd1UxaGR2UE1ROEZxVjk2dy9XUzcwVHZMdlYx?=
 =?utf-8?B?NmNIOTRXaVZsZXcyenRIZ05Zb2M5N21tSGlVRVFGM2liZ3ovQjFQT1gzcHp2?=
 =?utf-8?B?N3FxZURMSEtNa1RWeGljUlpEM0FIRTFHTVdKay9mRm9kZWp0SXNJUytxc0lu?=
 =?utf-8?B?TEljaXVEd3VRQVJTYnFoWWlRSXBOcSt4L1lLKzhFVnVVUXk0RHRyUXJnYzA4?=
 =?utf-8?B?U3JpdnMyRzN2ejNOTGlsRlJ5RkMxaGM5UDFWVmhPQlRLMzlRdXFuYUJ1Tnh4?=
 =?utf-8?B?M2hUdGQ2MGhVMC9LWTBuak9nN2hpWVBGUTJ6VWN3MWlCR0R1SzU4YlFwMFNy?=
 =?utf-8?B?d2daWEhIOEt2U3d1ZVl5cGZYZHFseGRLZkpIV0Nqd0hMWGNHcTZleVgzQTJs?=
 =?utf-8?B?cFZKTXRCR0FPa2dOM1FjK0w5anRIT0I5dEF3UUVJZk1SU041Tkd0YkVjcUdC?=
 =?utf-8?B?QTlmTFpOOTZxUGhZbGh5dVRqcjlzTjI1Q1RaYmVWa1d1MkY1L3hoTlNhaHpO?=
 =?utf-8?B?MTFZdVlNcDJRRkE3ZUJFaEcyOGVBdUNHUmdnZkpsM2UxOWdwZm1DVHJ6WHlG?=
 =?utf-8?B?KzdsTStuZWd1a0xTNm5TOXFjYVdkMWVtZW44RVhVanJTSFB3dm05RlpLYWlj?=
 =?utf-8?B?MUpiWVpxcmVJdUNQUDVhNGk1emZUd3p0SU5Ma3JvNEpwSklPQlY0VXZwdG1a?=
 =?utf-8?B?bTB6SGIzdGNmSzNDZkNXa0kvQkIvbmI4NFl5NVMvc1VtR212NUdLQ2V5Vjdu?=
 =?utf-8?B?UjJnZlBmM2VlSEJFSFRaSXovNnBoZjMzV2dTRjd0cll0Zmo4OFZGUGhpZVE4?=
 =?utf-8?B?MCt4L1Vxcm9PaTAyYk02aFh0MXlTaWNuckQ4QWxBMGM3MVIzdDE2c25GeG5R?=
 =?utf-8?B?cHV5ZFFHOUlvZVVzczY5Nms2MktRTWZkQ2o2d3MyUklvYkhXQ2ZUQU1ISTRV?=
 =?utf-8?B?Uy9IUC91Uzh5b3BSREtESUZrVW93akVmUC9XbE1uYndEOUk3NVdDNCtQQjlP?=
 =?utf-8?B?dkRhcU1JTWF4dW9yS2hGL05DMHQ3MDBtaHgrY0RhZFQyc0NOL1FLN0NwWk9T?=
 =?utf-8?B?dXhpZDF4K1VpdlBWV0VKSCt2RnJyUTEvMGt2cGp6YmVTTUhMb3hhd2VmQkRZ?=
 =?utf-8?B?eEZKbjh2S3d6dEV4VTJ6b081aVA0WFNtNXRnVklrWU53amRyM0MrOXBvK3Ur?=
 =?utf-8?B?TFc5UVJ5TURtdTRMK3lyeW1hTHg2TW1CQzJEWVRBNExmMUJvV3JNRnJWbjNs?=
 =?utf-8?B?ZXBLZ2FiY3RHeHpobjZSdXJVQktzdVJSdVZSS0pVWE9YNk5kYWVadmMxb3JE?=
 =?utf-8?B?YjRPVlBvbEdwNDFzanFVeWpDTEFTWEhTc0ZrRHdaOHFvY1hoSkVIeExHNFdh?=
 =?utf-8?B?RHlQd3RweWhiYTZDaXJ4UWU2TDZWR0ZMTTZ5MUpZN0tkKytLY3lNTnBReGRR?=
 =?utf-8?B?d29OMWZUUnB5bFZJMW5TYlNNS1ZocG9xeCs3bVdvWU14MFh0MWErZ3hQeGU0?=
 =?utf-8?B?QVdIZmtaNDhscUIyYkJHODRlNVJmVUkvV29tMDNPdGlUK2NZbi81bXlhT2FS?=
 =?utf-8?Q?D8uLHVBYT1EuIY5k/KQJk10=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1627E61E283EDE4F86E8AE1E85A2EE0D@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aff2a9ae-376a-4721-97fa-08db1af0ae24
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 07:35:21.8695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0V5/Z+DtOKyW7qx2wWpjTBtp5DkA/IAy2LvMEjGMYneVQ4yxG3A09Jc0Vz8kveEET34zt9r9Ap6MiKun6+M4U9baq4G0sb+O6xz9/UJ29cok8cZRca0warxhFrlWafBi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2978
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3IGFnYWluIQ0KDQpJIHJld29ya2VkIHRoZSBjb2RlIGZvciB2
MiBJIGFtIGFib3V0IHRvIHNlbmQgb3V0LiBJIHRoaW5rIEkgZW5kZWQgdXAgDQpoYXZpbmcgcXVp
dGUgYSBiaXQgY2hhbmdlcyBidXQgSSBoYXZlIHRyaWVkIHRvIGFkZHJlc3MgbW9zdCBvZiB3aGF0
IHlvdSANCnBvaW50ZWQgb3V0LiBUaGFua3MgZm9yIGFsbCB0aGUgaW1wcm92ZW1lbnRzIGFuZCB0
aGUgdGltZSB5b3UgaGF2ZSANCmludmVzdGVkIHRvIHRoaXMgYWxyZWFkeSENCg0KT24gMi8yNi8y
MyAxOToxMywgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gV2VkLCAyMiBGZWIgMjAyMyAx
ODoxNTo1OCArMDIwMA0KPiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50QGdtYWlsLmNv
bT4gd3JvdGU6DQo+IA0KPj4gKwkuc2Nhbl90eXBlID0gewkJCQkJCQlcDQo+PiArCQkuc2lnbiA9
ICd1JywJCQkJCQlcDQo+PiArCQkucmVhbGJpdHMgPSAxNiwJCQkJCQlcDQo+PiArCQkuc3RvcmFn
ZWJpdHMgPSAxNiwJCQkJCVwNCj4+ICsJCS5lbmRpYW5uZXNzID0gSUlPX0xFLAkJCQkJXA0KPiAN
Cj4gVW5sZXNzIHlvdSBoYXZlIGJ1ZmZlcmVkIHN1cHBvcnQsIGFueXRoaW5nIHNjYW5fKiBpcyB1
bnVzZWQgYW5kIHNob3VsZG4ndCBiZQ0KPiBzZXQuDQoNCkJ1ZmZlciBpbXBsZW1lbnRlZCBmb3Ig
djIgOikNCg0KPiANCj4+ICsJfSwJCQkJCQkJCVwNCj4+ICsJLmluZGV4ZWQgPSAxCQkJCQkJCVwN
Cj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9fY2hhbl9zcGVjIGJ1Mjcw
MzRfY2hhbm5lbHNbXSA9IHsNCj4+ICsJew0KPj4gKwkJLnR5cGUgPSBJSU9fTElHSFQsDQo+PiAr
CQkuaW5mb19tYXNrX3NlcGFyYXRlID0gQklUKElJT19DSEFOX0lORk9fUFJPQ0VTU0VEKSwNCj4+
ICsJCS5jaGFubmVsID0gQlUyNzAzNF9DSEFOX0FMUywNCj4+ICsJfSwNCj4+ICsJQlUyNzAzNF9D
SEFOX0RBVEEoREFUQTAsIElJT19NT0RfTElHSFRfQ0xFQVIpLA0KPj4gKwlCVTI3MDM0X0NIQU5f
REFUQShEQVRBMSwgSUlPX01PRF9MSUdIVF9DTEVBUiksDQo+IA0KPiBUaGF0J3MgdW51c3VhbC4g
V2h5IGRvZXMgaXQgaGF2ZSB0d28gY2xlYXIgY2hhbm5lbHM/DQo+IFBlcmhhcHMgYWRkIGEgY29t
bWVudCBvbiBob3cgdGhleSBkaWZmZXIuICBGcm9tIGEgcXVpY2sgZ2xhbmNlIGF0IHRoZQ0KPiBk
YXRhc2hlZXQgdGhleSBoYXZlIGRpZmZlcmVudCBzZW5zaXRpdml0aWVzLCBidXQgaW5kZWVkIGJv
dGggaW4gdGhlIHZpc2libGUNCj4gbGlnaHQgcmFuZ2UgKG1vc3RseSkNCj4gDQo+IFlvdSBjb3Vs
ZCBhcmd1ZSBvbmUgaXMgYmx1ZSBhbmQgb25lIGlzIHJlZCBiYXNlZCBvbiBwZWFrcyBvZiB0aGUg
Y3VydmVzIGJ1dA0KPiB0aGV5IGFyZSB2ZXJ5IGJyb2FkIHNvIHBlcmhhcHMgY2xlYXIgaXMgdGhl
IGJlc3QgbmFtaW5nLg0KDQpZZXAuIEkgd2FzIG5vdCB0aHJpbGxlZCBhYm91dCB0aGlzIG15c2Vs
Zi4gVGhlIHNlbnNpdGl2aXR5IHBlYWtzIGFyZSBhdCANCjUwMCBubSBhbmQgNjAwIG5tIC0gd2hp
Y2ggKGFjY29yZGluZyB0byBzb21lIHF1aWNrbHkgY2hlY2tlZCBzcGVjdHJ1bSANCnBpY3R1cmVz
IGluIHRoZSB3ZWJzIC0gbm8gcHJvcGVyIGZhY3QgY2hlY2sgZG9uZSAtIA0KaHR0cHM6Ly9jaGVt
LmxpYnJldGV4dHMub3JnL0Jvb2tzaGVsdmVzL1BoeXNpY2FsX2FuZF9UaGVvcmV0aWNhbF9DaGVt
aXN0cnlfVGV4dGJvb2tfTWFwcy9QaHlzaWNhbF9DaGVtaXN0cnlfKExpYnJlVGV4dHMpLzEzJTNB
X01vbGVjdWxhcl9TcGVjdHJvc2NvcHkvMTMuMDElM0FfVGhlX0VsZWN0cm9tYWduZXRpY19TcGVj
dHJ1bSANCikgYXJlIGxhbmRpbmcgc29tZXdoZXJlIGJldHdlZW4gdGhlIGJsdWUgYW5kIGdyZWVu
IGFuZCBuZWFyIHRoZSBvcmFuZ2UgDQphcmVhcy4gWWV0LCBlc3BlY2lhbGx5IHRoZSBkYXRhMCBo
YXMgYSB2ZXJ5IHdpZGUgc2Vuc2l0aXZpdHkgYXJlYSBhcyB5b3UgDQpwb2ludGVkIG91dC4gQnV0
IHllcywgdGhpcyB3YXJyYW50cyBhdCBsZWFzdCBhIGNvbW1lbnQuDQoNClRoaXMgaXMgYWN0dWFs
bHkgYWxzbyBhIHRvcGljIEkgc2VudCBhIHZlcnkgbG93IHByaW9yaXR5IGVtYWlsIGVhcmxpZXIg
DQo6KSBJIHdhcyB3b25kZXJpbmcgaWYgZXhwb3J0aW5nIHNldCBvZiBkYXRhLXBvaW50cyByZXBy
ZXNlbnRpbmcgdGhlc2UgDQpjdXJ2ZXMgdmlhIHN5c2ZzIGVudHJ5IHdvdWxkIGJlIHNvbWV0aGlu
ZyB1c2VyLXNwYWNlIGFwcGxpY2F0aW9ucyBjb3VsZCANCnVzZS4uLiBEZXNjcmliaW5nL2NhdGVn
b3JpemluZyB0aGUgYXJiaXRyYXJpbHkgc2hhcGVkIGN1cnZlcyBtYXkgYmUgDQpvdGhlcnZpY2Ug
aGFyZC4gVXNlcmxhbmQgY291bGQgdGhlbiBiZSBydW5uaW5nIGRpZmZlcmVudCBmaXR0aW5nIA0K
YWxnb3JpdGhtcyBkZXBlbmRpbmcgb24gdGhlaXIgbmVlZHMgLSBhbmQgc2VlIHRoZSBlcnJvciBs
ZXZlbHMgb24gdGhlIA0KYXJlYSB0aGV5IGFyZSBpbnRlcmVzdGVkIGluLiBCdXQgYXMgSSBzYWlk
IGluIHRoYXQgbWFpbCB0aHJlYWQgLSBJIGRvbid0IA0KaGF2ZSB1c2UtY2FzZSBmb3IgdGhpcyBz
byB0aGlzIHdhcyBqdXN0IHNvbWUgbG93IHByaW9yaXR5IHBvbmRlcmluZy4gDQpOb3RoaW5nIHRo
YXQgc2hvdWxkIGJlIG1peGVkIHdpdGggdGhpcyBwYXRjaCBtYWlsIDspDQoNCj4gLi4uDQo+PiAr
DQo+PiArCQlmb3IgKGkgPSAwOyBpIDwgMjsgaSsrKSB7DQo+IA0KPiBXaHkgdHdpY2U/DQoNClRv
IHRlc3QgdGhlIHNoYXJwbmVzcyBvZiByZXZpZXdlcnM/IEJUVywgWW91IHBhc3NlZCB3aXRoIGV4
Y2VsbGVudCBncmFkZSENCg0KKE5vLCByZWFsbHkgYmVjYXVzZSBJIHdhcyBpbnRlcnJ1cHRlZCBp
biB0aGUgbWlkZGxlIG9mIHdyaXRpbmcgdGhlIGNvZGUgDQpeX147IFdhcyBvcmlnaW5hbGx5IHdy
aXRpbmcgYSBsb29wIHRvIHJlYWQgdGhlIGNoYW5uZWxzIC0gYnV0IGZvcmdvdCBpdCANCndoZW4g
Y29udGludWVkLiBJIGZpbmQgaXQgaW1wcmVzc2l2ZSB5b3Ugc3BvdHRlZCB0aGlzIC0gdGhhbmtz
IGEgbG90ISkNCg0KDQo+PiArc3RhdGljIGludCBfYnUyNzAzNF9nZXRfcmVzdWx0KHN0cnVjdCBi
dTI3MDM0X2RhdGEgKmRhdGEsIHUxNiAqcmVzLCBib29sIGxvY2spDQo+PiArew0KPj4gKwlpbnQg
cmV0ID0gMDsNCj4+ICsNCj4+ICtyZXRyeToNCj4+ICsJaWYgKGxvY2spDQo+PiArCQltdXRleF9s
b2NrKCZkYXRhLT5tdXRleCk7DQo+PiArCS8qIEdldCBuZXcgdmFsdWUgZnJvbSBzZW5zb3IgaWYg
ZGF0YSBpcyByZWFkeSAtIG9yIHVzZSBjYWNoZWQgdmFsdWUgKi8NCj4+ICsJaWYgKGJ1MjcwMzRf
aGFzX3ZhbGlkX3NhbXBsZShkYXRhKSkgew0KPj4gKwkJcmV0ID0gcmVnbWFwX2J1bGtfcmVhZChk
YXRhLT5yZWdtYXAsIEJVMjcwMzRfUkVHX0RBVEEwX0xPLA0KPj4gKwkJCQkgICAgICAgJmRhdGEt
PnJhd1swXSwgc2l6ZW9mKGRhdGEtPnJhdykpOw0KPj4gKwkJaWYgKHJldCkNCj4+ICsJCQlnb3Rv
IHVubG9ja19vdXQ7DQo+PiArDQo+PiArCQlkYXRhLT5jYWNoZWQgPSB0cnVlOw0KPj4gKwkJYnUy
NzAzNF9pbnZhbGlkYXRlX3JlYWRfZGF0YShkYXRhKTsNCj4+ICsJfSBlbHNlIGlmICh1bmxpa2Vs
eSghZGF0YS0+Y2FjaGVkKSkgew0KPj4gKwkJLyogTm8gbmV3IGRhdGEgaW4gc2Vuc29yIGFuZCBu
byB2YWx1ZSBjYWNoZWQuIFdhaXQgYW5kIHJldHJ5ICovDQo+PiArCQlpZiAobG9jaykNCj4+ICsJ
CQltdXRleF91bmxvY2soJmRhdGEtPm11dGV4KTsNCj4gDQo+IEhtbS4gV2UgZG9uJ3QgcmVhbGx5
IG5lZWQgdG8gZml4IHRoaXMgaW4gZHJpdmVyLiBDb3VsZCBqdXN0IHJldHVybiAtRUFHQUlOIGFu
ZCBsZXQNCj4gdXNlcnNwYWNlIHdvcmsgb3V0IHRoYXQgaXQgbmVlZHMgdG8gdHJ5IGFnYWluIGFm
dGVyIGEgd2hpbGU/DQo+IEkgZ3Vlc3Mgbm90IGFsbCB1c2Vyc3BhY2UgaXMgZ29pbmcgdG8gYmUg
c21hcnQgZW5vdWdoIHRvIGhhbmRsZSB0aGF0IHRob3VnaCBhbmQNCj4geW91IG5lZWQgdGhpcyB0
byBlbnN1cmUgd2UgZ2V0IGEgbmV3IHZhbHVlIGFmdGVyIGEgcGFyYW1ldGVyIGNoYW5nZS4NCj4g
ID4NCj4gSWYgeW91IGRvIHRoYXQgdGhlbiB0aGUgbG9ja2luZyBkYW5jZSBnZXRzIG11Y2ggc2lt
cGxlci4NCg0KSSBjaGFuZ2VkIHRoZSBhcHByb2FjaCBmb3IgdGhlIHYyICh0byBiZSBzZW50IHNv
b24oaXNoKSkuIEkgZGlkIA0KaW1wbGVtZW50IHRoZSBidWZmZXJpbmcgLSBhbmQgZ2F2ZSB1cCBh
bnkgYXR0ZW1wdCBvZiBjYWNoaW5nIHZhbHVlcyBmb3IgDQpyYXdfcmVhZHMuIEluc3RlYWQsIEkg
d2lsbCBhbHdheXMgc3RhcnQgdGhlIG1lYXN1cmVtZW50IC0gd2FpdCAtIHJlYWQgDQpyZXN1bHQg
LSBzdG9wIHRoZSBtZWFzdXJlbWVudCBmb3IgZWFjaCByZWFkX3Jhdy4NCg0KSXQgbWVhbnMgdGhh
dDoNCg0KYSkgVGhlICh0eXBpY2FsIG9jY2FzaW9uYWw/KSB1c2VyIGNhbiBzdGlsbCByZWFkIHRo
ZSBwcm9jZXNzZWQgY2hhbm5lbCANCndpdGggcmVhZF9yYXcgZXZlcnkgbm93IGFuZCB0aGVuLiBJ
dCB3aWxsIGJlIHNsb3csIGJ1dCBpdCB3aWxsIG9ubHkgYmUgDQoxeCBtZWFzLXRpbWUgc2xvdy4N
Cg0KYikgUmVhZGluZyBhbGwgdGhlIGNoYW5uZWxzIHdpdGggcmVhZF9yYXcgdXNpbmcgbG9uZyBp
bnRlZ3JhdGlvbiB0aW1lcyANCndpbGwgYmUgcmVhbGx5IHNsb3cgLSBhbmQgaWYgbGlnaHQgbGV2
ZWxzIGFyZSBjaGFuZ2luZyBiZXR3ZWVuIHRoZSANCnJlYWRzLCB0aGUgY2hhbm5lbCB2YWx1ZXMg
YXJlIG5vdCByZWZsZWN0aW5nIHRoZSBzYW1lIGxpZ2h0IGxldmVscy4NCg0KYykgV2UgZ2V0IHRo
ZSBwb3dlci1zYXZpbmcgYXMgbWVhc3VyZW1lbnQgaXMgbm90IHJ1bm5pbmcgYWxsIHRoZSB0aW1l
Lg0KDQpkKSBBbnkgdXNlciB3aG8gbmVlZHMgc29tZSBwZXJmb3JtYW5jZSAtIG9yIGlzIGludGVy
ZXN0ZWQgaW4gZ2V0dGluZyANCmRhdGEgZm9yIGFsbCB0aGUgY2hhbm5lbHMgLSBjYW4gdXNlIHRo
ZSBidWZmZXJlZCBtb2RlLg0KDQpTbywgYSkgYW5kIGIpIG1lYW4gdGhhdCByZWFkX3JhdyBpcyBw
cmV0dHkgbXVjaCBvbmx5IHVzYWJsZSBmb3IgdXNlcnMgDQppbnRlcmVzdGVkIGluIHJlYWRpbmcg
b25lIGNoYW5uZWwgYXQgYSB0aW1lIC0gb3IgZG9pbmcgc29tZSBkZWJ1Z2dpbmcuIEkgDQp3YXMg
YWN0dWFsbHkgY29uc2lkZXJpbmcgZHJvcHBpbmcgdGhlIHJlYWRfcmF3IHN1cHBvcnQgZm9yIA0K
aW50ZW5zaXR5LWNoYW5uZWxzLCBidXQgZGlkbid0IGRvIGl0IGJlY2F1c2UgdGhvc2Ugd2hvIHVz
ZSB0aGVzZSANCnJhdy12YWx1ZXMgc2hvdWxkIHJlYWxseSBrbm93IHdoYXQgdGhleSByZXByZXNl
bnQgKHRoZXkgcHJvYmFibHkga25vdyANCnRoZSBzZW5zb3IgYW5kIGl0J3MgbGltaXRhdGlvbnMp
LiBBbHNvLCByZWFkaW5nIGZvciBleGFtcGxlIG9ubHkgdGhlIA0KZGF0YTIgY2hhbm5lbCAod2hp
Y2ggSSB0aGluayBpcyBub3QgcHJvcGVybHkgZGVzY3JpYmVkIGluIHRoZSANCmRhdGEtc2hlZXQp
IGNhbiBiZSBhIHZhbGlkIHVzZS1jYXNlIGZvciBzb21lb25lIGludGVyZXN0aW5nIGluIHRoZSBJ
Ui1hcmVhLg0KDQpJbiBhbnkgY2FzZSwgdGhlIGRhdGEtcmVhZGluZyBjb2RlIGdvdCBzb21lIGNo
YW5nZXMgZm9yIHYyLi4uDQoNCj4+ICsgKiBUaGVuOg0KPj4gKyAqIGlmIChEMS9EMCA8IDAuODcp
DQo+PiArICoJbHggPSAoMC4wMDEzMzEgKiBEMCArIDAuMDAwMDM1NCAqIEQxKSAqICgoRDEgLyBE
MCAtIDAuODcpICogMy40NSArIDEpDQo+PiArICogZWxzZSBpZiAoRDEvRDAgPCAxKQ0KPj4gKyAq
CWx4ID0gKDAuMDAxMzMxICogRDAgKyAwLjAwMDAzNTQgKiBEMSkgKiAoKEQxIC8gRDAgLSAwLjg3
KSAqIDAuMzg1ICsgMSkNCj4+ICsgKiBlbHNlDQo+PiArICoJbHggPSAoMC4wMDEzMzEgKiBEMCAr
IDAuMDAwMDM1NCAqIEQxKSAqICgoRDEgLyBEMCAtIDIpICogLTAuMDUgKyAxKQ0KPj4gKyAqDQo+
PiArICogd2UgdHJ5IGltcGxlbWVudGluZyBpdCBoZXJlLiBVc2VycyB3aG8gaGF2ZSBmb3IgZXhh
bXBsZSBzb21lIGNvbG9yZWQgbGVucw0KPiANCj4gVGhlcmUgaXMgbm8gdHJ5LCB0aGVyZSBpcyBq
dXN0IGRvIDopDQoNCkl0IGRpZG4ndCBmZWVsIGxpa2UgdGhhdCB3aGVuIEkgd2FzIGltcGxlbWVu
dGluZyB0aGUgY29kZSA6cm9sbGV5ZXM6DQoNCj4gDQo+PiArICogbmVlZCB0byBtb2RpZnkgdGhl
IGNhbGN1bGF0aW9uIGJ1dCBJIGhvcGUgdGhpcyBnaXZlcyBhIHN0YXJ0aW5nIHBvaW50IGZvcg0K
Pj4gKyAqIHRob3NlIHdvcmtpbmcgd2l0aCBzdWNoIGRldmljZXMuDQo+IA0KPiBUaGF0IHdpbGwg
bmVlZCBzb21lIGR0IGJpbmRpbmdzIC0gdGhvdWdoIGZvciBub3cgSSBndWVzcyB3ZSBoYXZlIG5v
IGlkZWENCj4gd2hhdCB0aGV5IHdvdWxkIGJlIHVubGVzcyB0aGVyZSBhcmUgc29tZSBoaW50cyBv
biB0aGUgZGF0YXNoZWV0Pw0KPiANCg0KWWVzLiBUaGF0IGlzIHRoZSBwcm9ibGVtLiBBbmQgZXZl
biB0aG91Z2ggd2Ugd291bGQgaG9wZSB3ZSBnZXQgdGhlIA0KY29tcGxldGUgYmluZGluZ3MgZnJv
bSBkYXkgMSAtIEkgZG9uJ3Qgc2VlIGl0IHJlYWxseSBhIHByb2JsZW0gdG8gYWRkIA0KdGhpbmdz
IGxpa2UgdGhlICdsZW5zLXdoYXRldmVyaXR3aWxsYmUnIHdoZW4gbmVlZGVkLiBXaGF0IHNob3Vs
ZCBiZSANCmVuc3VyZWQgdGhlbiBpcyB0aGUgInByb3BlcnR5IG5vdCBmb3VuZCIgY2FzZSB3aWxs
IGRlZmF1bHQgdG8gdGhlIG9wZW4tYWlyLg0KDQpUaGUgb25lIHRoaW5nIHdlIGNvdWxkIGFkZCBp
cyBzeXNmcyBhdHRyaWJ1dGUgc3RhdGluZyB0aGUgJ29wZW4tYWlyJyBmb3IgDQp0aG9zZSB3aG8g
dXNlIHRoZSByYXctdmFsdWVzIGFzIHRoZXkgd2lsbCBiZSBpbXBhY3RlZCBieSBsZW5zIGFuZCB3
b24ndCANCmJlIGNvbXBlbnNhdGVkIGJ5IHRoZSBkcml2ZXIgbGlrZSBwcmVwcm9jZXNzZWQgdmFs
dWVzIHNob3VsZCBiZS4gTm90IA0Kc3VyZSBpZiB3ZSB3YW50IHRvIGRvIGl0IHlldCB0aG91Z2gg
YXMgSSBkb24ndCBrbm93IGlmIHRoZXJlIHdpbGwgYmUgYW55IA0KdXNlIGZvciBpdCBpbiB1cHN0
cmVhbS4NCg0KPj4gKyAqDQo+PiArICogVGhlIGZpcnN0IGNhc2UgKEQxL0QwIDwgMC44NykgY2Fu
IGJlIGNvbXB1dGVkIHRvIGEgZm9ybToNCj4+ICsgKiBseCA9IDAuMDA0NTIxMDk3ICogRDEgLSAw
LjAwMjY2Mzk5NiAqIEQwICsgMC4wMDAxMjIxMyAqIEQxICogRDEgLyBEMA0KPj4gKyAqLw0KPj4g
K3N0YXRpYyBpbnQgYnUyNzAzNF9nZXRfbHV4KHN0cnVjdCBidTI3MDM0X2RhdGEgKmRhdGEsIGlu
dCAqdmFsKQ0KPj4gK3sNCj4+ICsJdW5zaWduZWQgaW50IGdhaW4wLCBnYWluMSwgbWVhc3RpbWU7
DQo+PiArCXVuc2lnbmVkIGludCBkMV9kMF9yYXRpb19zY2FsZWQ7DQo+PiArCXUxNiByZXNbM10s
IGNoMCwgY2gxOw0KPj4gKwl1NjQgaGVscGVyNjQ7DQo+PiArCWludCByZXQ7DQo+PiArDQo+PiAr
CW11dGV4X2xvY2soJmRhdGEtPm11dGV4KTsNCj4+ICsJcmV0ID0gYnUyNzAzNF9nZXRfcmVzdWx0
X3VubG9ja2VkKGRhdGEsICZyZXNbMF0pOw0KPiANCj4gcmVzDQo+IGFzIGl0IGlzIGV4cGVjdGlu
ZyBhIHBvaW50IHRvIGFuIGFycmF5IHNvIHRoYXQgaXMgbW9yZSBuYXR1cmFsIHRoYW4gcG9pbnRp
bmcNCj4gdG8gdGhlIGZpcnN0IGVsZW1lbnQgZXZlbiBpZiB0aGF0J3MgdGhlIHNhbWUgcmVzdWx0
Lg0KDQpUaGlzIGlzIHByZXR0eSBtdWNoIHRoZSBvbmx5IHRoaW5nIEkgZGlzYWdyZWUgd2l0aCB5
b3UgOikgRm9yIG1lIGl0IGhhcyANCmFsd2F5cyBiZWVuIG11Y2ggY2xlYXJlciB0byB1c2UgcG9p
bnRlciB0byBmaXJzdCBlbGVtZW50IC0gYXMgdGhlIHR5cGUgDQpvZiBmaXJzdCBlbGVtZW50IGlz
IHdoYXQgd2UgYXJlIHVzaW5nLiBUeXBlIG9mIGFuIGFycmF5IChpbiBteSBoZWFkKSBpcyANCnNv
bWV0aGluZyBsZXNzIHdlbGwgZGVmaW5lZC4gSSB0aGluayB0aGlzIGRpZmZlcmVuY2UgaXMgYmVz
dCB2aXNpYmxlIA0Kd2l0aCB0aGUgc2l6ZW9mKGFycikgVnMuIHNpemVvZigmYXJyWzBdKS4NCg0K
SSB0aGluayBJIGRpZG4ndCBjaGFuZ2UgdGhpcyBmb3IgdjIuIEkgaW4gYW55IGNhc2UgZXhwZWN0
IHRvIHNlZSB2MyBhbmQgDQpwcm9iYWJseSBhIGZldyBvdGhlcnMgYXMgd2VsbCAtIHNvIEkgd2ls
bCBjaGFuZ2UgdGhpcyB0byBzb21lIG9mIHRoZSANCmxhdGVyIHZlcnNpb25zIGlmIEkgZGlkbid0
IGdldCB5b3UgY29udmluY2VkIHRoYXQgdGhlICZyZXNbMF0gaXMgT2suDQoNCj4gDQo+PiArCWlm
IChyZXQpDQo+PiArCQlnb3RvIHVubG9ja19vdXQ7DQo+PiArDQo+PiArCS8qIEF2b2lkIGRpdiBi
eSB6ZXJvICovDQo+PiArCWlmICghcmVzWzBdKQ0KPiANCj4gcmVzWzBdID0gbWF4KDEsIHJlc1sw
XSk7IHBlcmhhcHM/DQoNClRoaXMgd291bGQgaGF2ZSBiZWVuIGJldHRlciwgeWVzLiBIb3dldmVy
LCBJIGRpZCBjaGFuZ2UgdGhlIGRhdGEgDQpjb2xsZWN0aW9uIHF1aXRlIGEgYml0IGZvciB2MiAt
IGFuZCB0aGVyZSB0aGVzZSB2YWx1ZXMgbWF5IG5vdCBiZSBpbiANCm5hdGl2ZSBieXRlIG9yZGVy
IC0gc28gY2hlY2sgZm9yICFyZXNbMF0gZmVlbHMgbW9yZSBjb3JyZWN0IGZvciB2MiB0aGFuIA0K
Y29tcGFyaW5nIHRvIHZhbHVlIHdoZW4gdGhlIHZhbHVlIGZvcm1hdCBpcyBub3QgImNvcnJlY3Qi
Lg0KDQo+PiArCWNhc2UgSUlPX0NIQU5fSU5GT19SQVc6DQo+PiArCXsNCj4+ICsJCXUxNiByZXNb
M107DQo+PiArDQo+PiArCQlpZiAoY2hhbi0+dHlwZSAhPSBJSU9fSU5URU5TSVRZKQ0KPj4gKwkJ
CXJldHVybiAtRUlOVkFMOw0KPj4gKw0KPj4gKwkJaWYgKGNoYW4tPmNoYW5uZWwgPCBCVTI3MDM0
X0NIQU5fREFUQTAgfHwNCj4+ICsJCSAgICBjaGFuLT5jaGFubmVsID4gQlUyNzAzNF9DSEFOX0RB
VEEyKQ0KPj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPj4gKwkJLyoNCj4+ICsJCSAqIFJlYWRpbmcg
b25lIGNoYW5uZWwgYXQgYSB0aW1lIGlzIGluZWZmaWNpZW50Lg0KPj4gKwkJICoNCj4+ICsJCSAq
IEhlbmNlIHdlIHJ1biB0aGUgbWVhc3VyZW1lbnQgb24gdGhlIGJhY2tncm91bmQgYW5kIGFsd2F5
cw0KPj4gKwkJICogcmVhZCBhbGwgdGhlIGNoYW5uZWxzLiBUaGVyZSBhcmUgZm9sbG93aW5nIGNh
dmVhdHM6DQo+PiArCQkgKiAxKSBUaGUgVkFMSUQgYml0IGhhbmRsaW5nIGlzIHJhY3kuIFZhbGlk
IGJpdCBjbGVhcmluZyBpcyBub3QNCj4+ICsJCSAqIHRpZWQgdG8gcmVhZGluZyB0aGUgZGF0YSBp
biB0aGUgaGFyZHdhcmUuIFdlIGNsZWFyIHRoZQ0KPj4gKwkJICogdmFsaWQtYml0IG1hbnVhbGx5
IF9hZnRlcl8gd2UgaGF2ZSByZWFkIHRoZSBkYXRhIC0gYnV0IHRoaXMNCj4+ICsJCSAqIG1lYW5z
IHRoZXJlIGlzIGEgc21hbGwgdGltZS13aW5kb3cgd2hlcmUgbmV3IHJlc3VsdCBtYXkNCj4+ICsJ
CSAqIGFycml2ZSBiZXR3ZWVuIHJlYWQgYW5kIGNsZWFyLiBUaGlzIG1lYW5zIHdlIGNhbiBtaXNz
IGENCj4+ICsJCSAqIHNhbXBsZS4gRm9yIG5vcm1hbCB1c2UgdGhpcyBzaG91bGQgbm90IGJlIGZh
dGFsIGJlY2F1c2UNCj4+ICsJCSAqIHVzdWFsbHkgdGhlIGxpZ2h0IGlzIGNoYW5naW5nIHNsb3ds
eS4gVGhlcmUgbWlnaHQgYmUNCj4+ICsJCSAqIHVzZS1jYXNlcyBmb3IgbWVhc3VyaW5nIG1vcmUg
cmFwaWRseSBjaGFuZ2luZyBsaWdodCBidXQgdGhpcw0KPj4gKwkJICogZHJpdmVyIGlzIHVuc3Vp
dGFibGUgZm9yIHRob3NlIGNhc2VzIGFueXdheXMuIChTbWFsbGVzdA0KPj4gKwkJICogbWVhc3Vy
ZW1lbnQgdGltZSB3ZSBzdXBwb3J0IGlzIDU1IG1TLikNCj4gDQo+IEdpdmVuIHRoZXJlIGlzIG5v
IGdlbmVyYWwgZml4IGZvciB0aGF0LCBub3QgbXVjaCB5b3UgY2FuIGRvIGV2ZW4gaWYgeW91IGRv
bid0IHdhbnQgdG8NCj4gbWlzcyB0aGUgZGF0YS4NCj4gDQo+PiArCQkgKiAyKSBEYXRhIHJlYWRp
bmdzIG1vcmUgZnJlcXVlbnQgdGhhbiB0aGUgbWVhc190aW1lIHdpbGwgcmV0dXJuDQo+PiArCQkg
KiB0aGUgc2FtZSBjYWNoZWQgdmFsdWVzLiBUaGlzIHNob3VsZCBub3QgYmUgYSBwcm9ibGVtIGZv
ciB0aGUNCj4+ICsJCSAqIHZlcnkgc2FtZSByZWFzb24gMSkgaXMgbm90IGEgcHJvYmxlbS4NCj4g
DQo+IEhtbS4gSSdtIG5ldmVyIHRoYXQga2VlbiBvbiBkcml2ZXJzIGRvaW5nIHRoYXQgaWYgd2Ug
Y2FuIGF2b2lkIGl0IGJ1dCBwZXJoYXBzIHdlDQo+IGNhbid0IGhlcmUuDQoNCldlbGwsIEkgZHJv
cHBlZCB0aGUgY2FjaGluZyBvZiB2YWx1ZXMgZm9yIHJlYWRfcmF3LiBJIHRoaW5rIGl0IGdvdCBy
aWQgDQpvZiB0aGVzZSBwYXJ0aWN1bGFyIHByb2JsZW1zLiBUaGUgaXNzdWUgMSkgaXMgc3RpbGwg
dGhlcmUgZm9yIGJ1ZmZlcmVkIA0KbW9kZSBidXQgSSBndWVzcyB3ZSBqdXN0IG5lZWQgdG8gbGl2
ZSB3aXRoIGl0LiBPbiB0aGUgYnJpZ2h0IHNpZGUsIA0KbWlzc2luZyBhIHNhbXBsZSBvbmNlIGlu
IGEgYmx1ZSBtb29uIGlzIG5vdCBmYXRhbCBmb3IgbW9zdCBvZiB0aGUgDQp1c2UtY2FzZXMgSSBj
YW4gdGhpbmsgb2YgcmlnaHQgbm93LiAoQmVzaWRlcywgdGhlcmUgaXMgbm8gZ2VuZXJhbCBmaXgg
YXMgDQp5b3Ugc2FpZCBzbyB3b3JyeWluZyBhYm91dCB0aGUgdW5rbm93biB1c2UtY2FzZXMgcmln
aHQgbm93IGRvZXMgbm90IGZlZWwgDQpsaWtlIHRoZSBzYW5lc3QgdGhpbmcuIEkgaGF2ZSBlbm91
Z2ggb2Ygd29ycnlpbmcgd2l0aCB0aGUgdGhpbmdzIHRoYXQgDQpyZWFsbHkgYXJlIGEgcHJvYmxl
bS4uLikNCg0KPj4gKwkvKg0KPj4gKwkgKiBEZWxheSB0byBhbGxvdyBJQyB0byBpbml0aWFsaXpl
LiBXZSBkb24ndCBjYXJlIGlmIHdlIGRlbGF5DQo+PiArCSAqIGZvciBtb3JlIHRoYW4gMSBtcyBz
byBtc2xlZXAoKSBpcyBPay4gV2UganVzdCBkb24ndCB3YW50IHRvDQo+PiArCSAqIGJsb2NrDQo+
IA0KPiBUaGUgbXNsZWVwIGJpdCBpcyBraW5kIG9mIG9idmlvdXMgZm9yIGEgcmVzZXQuIEknZCBu
b3QgYm90aGVyIGRvY3VtZW50aW5nIHRoYXQNCj4gZGV0YWlsLg0KDQpXZWxsLCB0aGUgZG9jdW1l
bnRhdGlvbiBpcyB0byBzdXBwcmVzcyByZXZpZXcgY29tbWVudHMgcmVnYXJkaW5nIDFtUyANCm1z
bGVlcCA6KSBBbmQsIEkgY2FuJ3QgYmxhbWUgcmV2aWV3ZXJzIGFzIHRoZSBjaGVja3BhdGNoIGlz
IHBpY2tpbmcgdGhpcyANCnVwIHRvby4gSGVuY2UgSSB0aGluayBpdCdzIE9rIHRvIHRlbGwgdGhh
dDogIlllcywgSSBrbm93IHRoZSBzbGVlcCBpcyANCmxpa2VseSB0byBsYXN0IGxvbmdlciB0aGFu
IHRoZSByZXF1ZXN0ZWQgMSBtUyBidXQgaXQgZG9lcyBub3QgbWF0dGVyIGZvciANCm91ciB1c2Ut
Y2FzZSBzbyB3ZSBzdGlsbCBjb25zY2lvdXNseSBjaG9zZSB0byB1c2UgbXNsZWVwKCkuIg0KDQo+
IA0KPj4gKwkgKi8NCj4+ICsJbXNsZWVwKDEpOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBDb25z
aWRlciBkaXNhYmxpbmcgdGhlIG1lYXN1cmVtZW50IChhbmQgcG93ZXJpbmcgb2ZmIHRoZSBzZW5z
b3IpIGZvcg0KPj4gKwkgKiBydW50aW1lIHBtDQo+IA0KPiBOb3RlcyBsaWtlIHRoaXMgcHJvYmFi
bHkgd2FudCB0byBnbyBhd2F5IG9uY2UgdGhlIGRyaXZlciBpcyAnZmluaXNoZWQnLg0KDQpJIGhv
cGUgSSBraWxsZWQgdGhlIHdvcnN0IHBvd2VyIGNvbnN1bXB0aW9uIGF0IHYyIGJ5IG5vdCBydW5u
aW5nIHRoZSANCm1lYXN1cmVtZW50IGFsbCB0aGUgdGltZSBhdCB0aGUgYmFja2dyb3VuZC4gSSBk
b24ndCBhdCB0aGUgbW9tZW50IGhhdmUgYSANCnVzZS1jYXNlIGZvciBydW50aW1lIHBtIC0gYW5k
IGFzIHJ1bnRpbWUgcG0gdGVuZHMgdG8gYmUgIm5vdCB0cml2aWFsIiAtIA0KSSB3aWxsIGxlYXZl
IHRob3NlIGJ1Z3MgdG8gYmUgbWFkZSBvbmx5IHdoZW4gbmVlZGVkLi4uIEJ1dCB5ZXMsIHRoaXMg
DQpjb21tZW50IGNhbiBnbyBhcyBpdCBhZGRzIHByZXR0eSBtdWNoIG5vIHZhbHVlLg0KDQo+IA0K
Pj4gKwkgKi8NCj4+ICsJcmV0ID0gYnUyNzAzNF9tZWFzX2VuKGRhdGEpOw0KPj4gKwlpZiAocmV0
KQ0KPj4gKwkJcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsJcmV0dXJuIGRldm1fYWRkX2FjdGlvbl9v
cl9yZXNldChkYXRhLT5kZXYsIGJ1MjcwMzRfbWVhc19zdG9wLCBkYXRhKTsNCj4+ICt9DQo+PiAr
DQo+PiArc3RhdGljIGludCBidTI3MDM0X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICppMmMpDQo+
PiArew0KPj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmaTJjLT5kZXY7DQo+PiArCXN0cnVjdCBm
d25vZGVfaGFuZGxlICpmd25vZGU7DQo+PiArCXN0cnVjdCBidTI3MDM0X2RhdGEgKmRhdGE7DQo+
PiArCXN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4+ICsJc3RydWN0IGlpb19kZXYgKmlkZXY7DQo+
PiArCXVuc2lnbmVkIGludCBwYXJ0X2lkOw0KPj4gKwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwlyZWdt
YXAgPSBkZXZtX3JlZ21hcF9pbml0X2kyYyhpMmMsICZidTI3MDM0X3JlZ21hcCk7DQo+PiArCWlm
IChJU19FUlIocmVnbWFwKSkNCj4+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VS
UihyZWdtYXApLA0KPj4gKwkJCQkgICAgICJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBSZWdtYXBcbiIp
Ow0KPj4gKw0KPj4gKwlmd25vZGUgPSBkZXZfZndub2RlKGRldik7DQo+IA0KPiB3aHkgZG8gd2Ug
Y2FyZT8gIFNvIGZhciB0aGlzIHNob3VsZCB3b3JrIGZpbmUgd2l0aCB0aGUgb3RoZXIgdHlwZXMg
b2YgaTJjDQo+IHByb2JlLg0KDQpUcnVlISBJIGRpZG4ndCBldmVuIHRoaW5rIG9mIHN1Y2ggYSBj
YXNlLg0KDQo+PiArCWlkZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoZGV2LCBzaXplb2YoKmRh
dGEpKTsNCj4+ICsJaWYgKCFpZGV2KQ0KPj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+PiAr
CXJldCA9IGRldm1fcmVndWxhdG9yX2dldF9lbmFibGVfb3B0aW9uYWwoZGV2LCAidmRkIik7DQo+
IHZkZCBpc24ndCBvcHRpb25hbCAtIG9yIGF0IGxlYXN0IGl0IHdvdWxkIGJlIGFuIHVudXN1YWwg
ZGV2aWNlIHRoYXQgZG9lc24ndA0KPiBuZWVkIHRoYXQgc3VwcGx5IGxpbmUuDQo+IA0KPiBLZXkg
aGVyZSBpcyB0aGF0IG9wdGlvbmFsIGluIERUIGlzIGRpZmZlcmVudCBmcm9tIHRoaXMgY2FsbC4N
Cj4gSWYgbm90IHByZXNlbnQgaW4gRFQgYW5kIGRldm1fcmVndWxhdG9yX2dldF9lbmFibGUoKSBj
YWxsZWQgdGhlbiB3ZSdsbCBub3JtYWxseQ0KPiBnZXQgYSBzdHViIHJlZ3VsYXRvci4NCg0KWWVz
LiBJIHRoaW5rIHdlIHdpbGwgYWxzbyBoYXZlIGEgd2FybmluZyBpbiBhIGxvZyAtIHdoaWNoIEkg
d2FzIG5vdCANCmxpa2luZy4gT1RPSCwgYXMgdGhlIGNvbXBvbmVudCBjbGVhcmx5IG5lZWRzIHRo
ZSBWREQsIG1heWJlIHRoZSB3YXJuaW5nIA0KYWJvdXQgbWlzc2luZyBvbmUgaW4gRFQgaXMgYWxz
byBPay4NCg0KPj4gKwlpZiAocmV0ICE9IC1FTk9ERVYpDQo+PiArCQlyZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBnZXQgcmVndWxhdG9yXG4iKTsNCj4+ICsNCj4+ICsJ
ZGF0YSA9IGlpb19wcml2KGlkZXYpOw0KPj4gKw0KPj4gKwlyZXQgPSByZWdtYXBfcmVhZChyZWdt
YXAsIEJVMjcwMzRfUkVHX1NZU1RFTV9DT05UUk9MLCAmcGFydF9pZCk7DQo+PiArCWlmIChyZXQp
DQo+PiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBhY2Nlc3Mg
c2Vuc29yXG4iKTsNCj4+ICsNCj4+ICsJcGFydF9pZCAmPSBCVTI3MDM0X01BU0tfUEFSVF9JRDsN
Cj4+ICsNCj4+ICsJaWYgKHBhcnRfaWQgIT0gQlUyNzAzNF9JRCkgew0KPj4gKwkJZGV2X2Vycihk
ZXYsICJ1bnN1cHBvcnRlZCBkZXZpY2UgMHgleFxuIiwgcGFydF9pZCk7DQo+IA0KPiBGYWxsYmFj
ayBjb21wYXRpYmxlcyByZXF1aXJlIHRoYXQgb24gYSBmYWlsdXJlIHRvIG1hdGNoIElEIHdlIHN0
aWxsIGxldCB0aGUgZHJpdmVyDQo+IGNhcnJ5IG9uLiAgSG93ZXZlciB3ZSBjYW4gcHJpbnQgc29t
ZXRoaW5nIGluIHRoZSBsb2cgdG8gc2F5IHdlIGRvbid0IHJlY29nbmlzZQ0KPiB0aGUgZGV2aWNl
LiAgVGhlIGludGVudCBpcyB0aGF0IGF0IGZ1dHVyZSBwYXJ0IGNhbiBiZSBzdXBwb3J0ZWQgYnkg
b2xkIGtlcm5lbHMganVzdA0KPiBiZSBoYXZpbmcgdGhlIGR0IGxpc3QgbXVsdGlwbGUgY29tcGF0
aWJsZXMgaWYgdGhlIGRldmljZSByZWFsbHkgYXJlIGJhY2t3YXJkcw0KPiBjb21wYXRpYmxlIHdp
dGggcGFydHMgYWxyZWFkeSBzdXBwb3J0ZWQuDQoNCk1ha2VzIHNlbnNlLiBCZXNpZGVzLCB3ZSBz
aG91bGQgYmUgYWJsZSB0byB0cnVzdCB0aGUgZHQgaGFzIGNvcnJlY3QgDQpjb21wYXRpYmxlcyAt
IEknbSBub3Qgc3VyZSB3ZSBzaG91bGQgZG8gdGhlc2UgcnVudGltZSBjaGVja3MgZm9yIHBhcnQg
DQpJRHMgYXQgYWxsLiBJIGRyb3BwZWQgdGhlIGVycm9yIC0gcmV0dXJuIGFuZCBjaGFuZ2VkIHRo
ZSBwcmludCB0byB3YXJuLg0KDQo+PiArDQo+PiArCWlkZXYtPmNoYW5uZWxzID0gYnUyNzAzNF9j
aGFubmVsczsNCj4+ICsJaWRldi0+bnVtX2NoYW5uZWxzID0gQVJSQVlfU0laRShidTI3MDM0X2No
YW5uZWxzKTsNCj4+ICsJaWRldi0+bmFtZSA9ICJidTI3MDM0LWFscyI7DQo+IA0KPiBJZiB0aGUg
Y2hpcCBkb2Vzbid0IGhhdmUgYSBtdWx0aXBsZSBmdW5jdGlvbnMgKGFuZCBtdWx0aXBsZSBpaW9f
ZGV2cyksIHdlJ2Qgbm9ybWFsbHkNCj4gbm90IGJvdGhlciB3aXRoIHRoZSBhbHMgcGFydCBpbiB0
aGUgbmFtZS4gIEFkZCBhIGNvbW1lbnQgaWYgdGhlcmUgaXMgYSByZWFzb24gZm9yDQo+IGl0IGhl
cmUuDQoNCk9rLCB0aGFua3MhDQoNCllvdXJzLA0KCS0tIE1hdHRpDQoNCi0tIA0KTWF0dGkgVmFp
dHRpbmVuDQpMaW51eCBrZXJuZWwgZGV2ZWxvcGVyIGF0IFJPSE0gU2VtaWNvbmR1Y3RvcnMNCk91
bHUgRmlubGFuZA0KDQp+fiBXaGVuIHRoaW5ncyBnbyB1dHRlcmx5IHdyb25nIHZpbSB1c2VycyBj
YW4gYWx3YXlzIHR5cGUgOmhlbHAhIH5+DQoNCg==
