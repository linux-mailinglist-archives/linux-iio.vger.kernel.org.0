Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991A638FF62
	for <lists+linux-iio@lfdr.de>; Tue, 25 May 2021 12:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhEYKjk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 May 2021 06:39:40 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:23230 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230314AbhEYKip (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 May 2021 06:38:45 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14PAYK9s016840;
        Tue, 25 May 2021 03:36:47 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-0064b401.pphosted.com with ESMTP id 38rmkbrbqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 03:36:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JewJ1QOeukD9LeEd5Mvqoryu7HbHCuY4ukcBbbdm4E+aE5+MzvgRL2BKREkwZkHo9D7kqzlAQ8PDuznlylS9FzMWdI9xsKY9vqhy46OKhEsbFnhFaFmZtSN22n1o2bcn7tFDxylxqtAuJ2zEsIWQVvCMEH4MOSViS5q84ozAf/0hfB1pm3Rc+Q7lRB06vNvF0V21csRrf9lqB+4Gund+NARSCwJqPPaoaRsuR3ldqYiMv6/waRfto9J1vxrGrpm9LyOUIF0DI1d3+ROFR1wtPjgJLcbgIy+u5JuLKi68C+Dl8XZqUJdc/M750X/8MBNlvtF1LLMpkKqFOrK2WG7dLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI+U4zPE/Yjd387YK8TuVvl9NfpLLEGk8I+61Si8MxM=;
 b=TuxFS+CWdqfa5+n7vcLikoR5YvQ0XP1MbjDH0XnAGsMFfYY/cBBsWpUYzkeqWSVxtrQI3iBHHlfITJtLiR0t4ur2lXCFZq9OY2rXVCnX3I1koifySHRgwZsWgBEbomCWUlyx3y/xh1GuyIw/ruxtEaP3T2xoPll7ycYQRKUMUwdMYFX/2yvGWpK1yT4airN6FhZq1mDZxyoZ5F79027JNUyIRpr7+7mf8L1j7F8btIQxNEgb8i1icFT4hKV4L0B4OLduriXqpZqCWEk1pkGEWIDqHQgbHUqXv7n3QUEw5t9qYz2boNkaxGF6fn383TfJrjaFwqlxfGR7lU3a0SrJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tI+U4zPE/Yjd387YK8TuVvl9NfpLLEGk8I+61Si8MxM=;
 b=K4jkVp6EcRKpPGycuBykYBYITo7035Q+Lg0MN5m7VhsJ3EbdsMkxkVwcCbCEbw7BWlJixLVJFKsHs2bWNx+62tmGhOFx4AhVsUQzCgiMUY84ScjEchfOXC1B5/AKtVVIhrKhmiRiI0evFY2UMm5vRW9cgv1Iex57UzHAnslQep8=
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 10:36:43 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::ac4d:5dd3:c365:cd49%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 10:36:43 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Felix Knopf <knopf@vh-s.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Topic: [PATCH] driver: adc: ltc2497: return directly after reading the
 adc conversion value
Thread-Index: AQHXRutZA2KT9UoVoUu9pd++4IrNe6rqkr4AgAdvZICAAe5DAIAADF8w
Date:   Tue, 25 May 2021 10:36:43 +0000
Message-ID: <PH0PR11MB51912636A22942C6F08DE117F1259@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20210512045725.23390-1-Meng.Li@windriver.com>
 <20210519092104.pntanimcjg6s6fca@pengutronix.de>
 <PH0PR11MB51913E1982E3208302CE29CCF1269@PH0PR11MB5191.namprd11.prod.outlook.com>
 <45829810-7921-3150-6df1-c19ffcb2ae6f@vh-s.de>
In-Reply-To: <45829810-7921-3150-6df1-c19ffcb2ae6f@vh-s.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vh-s.de; dkim=none (message not signed)
 header.d=none;vh-s.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [147.11.252.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dad6c8a-e954-476b-f13d-08d91f68fd23
x-ms-traffictypediagnostic: PH0PR11MB4839:
x-microsoft-antispam-prvs: <PH0PR11MB4839E1F34DBE887993B76533F1259@PH0PR11MB4839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4gHEyNzxJjXZxtspyXXb6PETCNFrJGQfVfgvjzaxf/LjAZCdOfvOy3FY3IiQ62b1kK2bokMnzAhte5AQKIQAIuGswrbQbGgSlVCZVzaUi4qGn0ZQrG0XPoyfMGsJYFJi+jx8ilzPanzJCXarX2ddjgEpv7DMggY//+tJ0GN7A6uTAoTFvGDrivJVg1H4R6G6X8TIckkBT3lGfkUucIsdBUZvXaF0Okt42U+xVufrsoxRI6CKWlFkRW1v7nD7uiSRqcr8Ryr/z2zykge6RhDyH+jj4/xG1FhHhVKQanACBsoJKAGqTdtRKbITUBKn524Np70fOX9MhcDEQgFVwnws9/zV0neeLDxJb2j2QDVHDxaH7XSLfoG6AguQZz3LGleEwRa4Qbc1r32rUOFn13Kmdwm1sKI3LWlMEn6IZIDFL3EbMd/7mbfo9bwjtWoRvmiPbQgqlmbZn0JvM+O+2Fifz1yYgUtAH9UlrtDVwDSH4zeDcf2WjH657Ysutk8dD1VXbEchJzB4PH+3Nm75gz25dbkV77rbGqct2JTnmz4J75vtqGO4bF/EvXTpvML14kB+GzN/7p5Hzuugk6VLPnrRLhwjP1GmhPkG3r2eLbNw/tEyfzybwx5Ai7LkeWDQQF47oE4VvT6yPZadzhp3x2tXuh16nFnUidnKA4WUPtBt339MNZNVQ4cDWi6L7AbtVBAXcRmRTxhoxZ9K8nZ4lKW5EXKFkfwhCeABUQvLTUTTQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39850400004)(396003)(52536014)(38100700002)(186003)(966005)(316002)(6506007)(2906002)(53546011)(26005)(9686003)(54906003)(110136005)(71200400001)(8676002)(8936002)(5660300002)(4326008)(66946007)(66574015)(83380400001)(64756008)(478600001)(122000001)(33656002)(55016002)(86362001)(66476007)(76116006)(66446008)(7696005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RVRIKzhvVWdTcUtkWGVyZGRUb3RaUnUzdDlyQnd3eWFZeDQ1eUI1M1hnTXVF?=
 =?utf-8?B?OFdPZzNDZ1NmeG92Z0VmVXlZSzU5QjZqMUJ0Y1JITDV6V3ZnbDU0UlZoUmJi?=
 =?utf-8?B?cHgrZFF4aXdaSTRCTGZVTWc5U1k2YWRXRlZWb08wQm5WOEZtVDduUXJPNHFj?=
 =?utf-8?B?d3RkOTdRK0NHbExkZ3ZHRDFCQnFUTjdVQ1lmR3VXVlFZKzRKME5aWFVjNEkr?=
 =?utf-8?B?ODdocXZnem1JOEZCYmVWeFVrQUJTdE50Zm1weFNIVEM1YklqOGZOUkoxZVN5?=
 =?utf-8?B?Ukdub1lhbjAxR2MrVkxsT3BscmloY1VLdTNOd1FRM3k1RUo1bE9RQXlKdE9u?=
 =?utf-8?B?eUpJYVI0UzZ5aUlmdDU4RDBPb0lCQzBBa3J6UHpqcmF2WW83Z0FXcDZLWVJE?=
 =?utf-8?B?dzVxSENJSWlyd0YxTS9iZU1ueFBWaHlhcWg4YmtzUHZoOXdNNUZyU0tId3Ns?=
 =?utf-8?B?VFFmSCtEV2lWSjNieVZyVExPRDJ5NE5XenAyd21WdWJIOEpCSXJiL1R4S0hy?=
 =?utf-8?B?V0FieDNBZllhVGNFQXVzeW9pcTVjNWpSOHQyUHVqbWtraGdiKzgzYUw5S2l4?=
 =?utf-8?B?UG4yNnVLRDNQOGVvc0JNcmt6Y2pjSENXbWdKeXpCM3pmdC94U05mZkhENFFC?=
 =?utf-8?B?eW5FakRkM0tQQXA0Sm9HZXpKaDIwU0pUYlZiSmMwTTRXMG1xNDNvR2VBRitr?=
 =?utf-8?B?bXYzUlZkNW1UVTlFS0xRTlk2Qm9KOUI1MXJzNWRYaFl0aGsrdFAzWjZhMm8x?=
 =?utf-8?B?VVFBQU1taTByQU5HZ0JEUWlOTGcrZlJjRWhwMkZEb1BXL1AyZTNwb0RMQjNa?=
 =?utf-8?B?WGovVnJ5eTZBWC93bU84QXllay9Ud3pXY29mZTV4Z1ZSUGEyK3pac3pLL0NF?=
 =?utf-8?B?V1pSeFk4L0Z1UDBrNzQ5WGQxUVJuSU9VbWFaRHVKektoUWp2aGJIMStwamVp?=
 =?utf-8?B?aXBCRUlnMllMdmZsUDlxaDVhSk02S3lMR09hak14RStpY2FQdFhJRkxVcDAw?=
 =?utf-8?B?YmNNdHhLT3R2UXluOXRxRk8wK2k3NzRreXhoRzdkY2RCRzBTS2FuN2t1cnJp?=
 =?utf-8?B?bW5Md1dnOXJHSzdzdkRzMFJmTVVEcUJsVmtKY1QvcllGakVWRy9BTlljNU9Q?=
 =?utf-8?B?c2dMajBrZFJOZTFjRDh2SW5xMlQzakZQYnI5cm0xYlUwTEcrSkR5WHgrVzVS?=
 =?utf-8?B?RHJtNjhqVTRPYzVhRXJuT1ljcHJDQW04MjFSYVNjdWcvZHZjMVpaNU9IdHlP?=
 =?utf-8?B?RmdId2I1dUpzNG9UcjVHQnBGVE5QWUxPSmxna0ExQW1rUy9ERGNneUIzL1Ey?=
 =?utf-8?B?bk5ISDJvaldsOTBoa2dSMXc4MGIrbzlmM3pKREJSMWdkQi95ZDdtVzZIZS9J?=
 =?utf-8?B?em5zWnJIWVpnbXJoSCtOdGlpUHB0aElMM25ndEJGYkxONENhR2dwZTd5V0lk?=
 =?utf-8?B?ZWpJMnBsU01nc0ZHQklvQ3RKZGJGT09zc0gvbE5UUGJPRUc0cThMRmdBWnVD?=
 =?utf-8?B?Zi9VSnNTdnIxcnlIU1I2SUtBOXRpdFJDaUFXTVMwbDN6KzdCNXRUek84dDEy?=
 =?utf-8?B?RW90ejZXczZOTjVQUjB1TW1UejhJSDlkek9md01wSkZhRnpiME00czB1b25t?=
 =?utf-8?B?U215WnUvWjZ3anROWjduWHNxaGpRb1Q3YTZZMkxNazJwTHd5MUtFQVltVWZG?=
 =?utf-8?B?ZWhsSEd3NDF1OWZuV3dBd0RYVXVFdGlBemViRU8xelNPZjk4RHhWOHIrblBr?=
 =?utf-8?Q?Ro/0mGHLuPQ3HYFDYEZbTFafTAZ1sbg7r0ZEc2c?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dad6c8a-e954-476b-f13d-08d91f68fd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 10:36:43.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zIJ24pyXTrRIiIirSsq/1PLP1zaPdi54qFHjLg+etYOPiy/VQL2cFVi10S334cnGLlHz9cBbR/+RtqvWccuuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-Proofpoint-ORIG-GUID: NQ0tO37SEFodoijD2iH69UCcsk9KjkdU
X-Proofpoint-GUID: NQ0tO37SEFodoijD2iH69UCcsk9KjkdU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_05:2021-05-25,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVsaXggS25vcGYgPGtu
b3BmQHZoLXMuZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyNSwgMjAyMSA0OjIzIFBNDQo+IFRv
OiBMaSwgTWVuZyA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPjsgVXdlIEtsZWluZS1Lw7ZuaWcgPHUu
a2xlaW5lLQ0KPiBrb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBsYXJzQG1ldGFmb28uZGU7
IE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb207IGppYzIzQGtlcm5lbC5vcmc7DQo+IHBtZWVy
d0BwbWVlcncubmV0OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gaWlv
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcml2ZXI6IGFkYzogbHRj
MjQ5NzogcmV0dXJuIGRpcmVjdGx5IGFmdGVyIHJlYWRpbmcgdGhlIGFkYw0KPiBjb252ZXJzaW9u
IHZhbHVlDQo+IA0KPiBbUGxlYXNlIG5vdGU6IFRoaXMgZS1tYWlsIGlzIGZyb20gYW4gRVhURVJO
QUwgZS1tYWlsIGFkZHJlc3NdDQo+IA0KPiA+PiBPbiBXZWQsIE1heSAxMiwgMjAyMSBhdCAxMjo1
NzoyNVBNICswODAwLCBNZW5nLkxpQHdpbmRyaXZlci5jb20NCj4gd3JvdGU6DQo+ID4+PiBXaGVu
IHJlYWQgYWRjIGNvbnZlcnNpb24gdmFsdWUgd2l0aCBiZWxvdyBjb21tYW5kOg0KPiA+Pj4gY2F0
IC9zeXMvLi4uL2lpbzpkZXZpY2UwL2luX3ZvbHRhZ2UwLXZvbHRhZ2UxX3Jhdw0KPiA+Pj4gVGhl
cmUgaXMgYW4gZXJyb3IgcmVwb3J0ZWQgYXMgYmVsb3c6DQo+ID4+PiBsdGMyNDk3IDAtMDAxNDog
aTJjIHRyYW5zZmVyIGZhaWxlZDogLUVSRU1PVEVJTyBUaGlzIGkyYyB0cmFuc2Zlcg0KPiA+Pj4g
aXNzdWUgaXMgaW50cm9kdWNlZCBieSBjb21taXQgNjk1NDhiN2MyYzRmICgiaWlvOg0KPiA+Pj4g
YWRjOiBsdGMyNDk3OiBzcGxpdCBwcm90b2NvbCBpbmRlcGVuZGVudCBwYXJ0IGluIGEgc2VwYXJh
dGUgbW9kdWxlIikuDQo+ID4+PiBXaGVuIGV4dHJhY3QgdGhlIGNvbW1vbiBjb2RlIGludG8gbHRj
MjQ5Ny1jb3JlLmMsIGl0IGNoYW5nZSB0aGUgY29kZQ0KPiA+Pj4gbG9naWMgb2YgZnVuY3Rpb24g
bHRjMjQ5N2NvcmVfcmVhZCgpLiBXaXRoIHdyb25nIHJlYWRpbmcgc2VxdWVuY2UsDQo+ID4+PiB0
aGUgYWN0aW9uIG9mIGVuYWJsZSBhZGMgY2hhbm5lbCBpcyBzZW50IHRvIGNoaXAgYWdhaW4gZHVy
aW5nIGFkYw0KPiA+Pj4gY2hhbm5lbCBpcyBpbiBjb252ZXJzaW9uIHN0YXR1cy4gSW4gdGhpcyB3
YXksIHRoZXJlIGlzIG5vIGFjayBmcm9tDQo+ID4+PiBjaGlwLCBhbmQgdGhlbiBjYXVzZSBpMmMg
dHJhbnNmZXIgZmFpbGVkLg0KPiANCj4gSGksDQo+IA0KPiBJIGNhbWUgYWNyb3NzIHRoZSBzYW1l
IG9yIGEgdmVyeSBzaW1pbGFyIGlzc3VlIHdpdGggdGhlIGx0YzI0OTcgYnV0IHRvb2sgYQ0KPiBk
aWZmZXJlbnQgYXBwcm9hY2ggdG8gc29sdmUgaXQuICBJIHN1c3BlY3QgdGhpcyBpc3N1ZSBpcyBj
YXVzZWQgYnkgYSBzdWJvcHRpbWFsDQo+IEkyQyBhY2Nlc3MgcGF0dGVybi4NCj4gDQo+IFRoZSBs
dGMyNDk3IHRyaWdnZXJzIGEgbmV3IGNvbnZlcnNpb24gb24gdGhlIHN0b3AgY29uZGl0aW9uIG9m
IHRyYW5zYWN0aW9ucw0KPiBhZGRyZXNzZWQgdG8gaXQuICBBcyB0aGUgY2hpcCBjYW5ub3QgY29t
bXVuaWNhdGUgZHVyaW5nIGEgY29udmVyc2lvbiwgaXQgd2lsbA0KPiBub3QgQUNLIHVudGlsIGl0
IGlzIGZpbmlzaGVkLiAgVGhlIGN1cnJlbnQgZHJpdmVyIHByb2R1Y2VzIHRoZSBmb2xsb3dpbmcN
Cj4gc2VxdWVuY2UgdG8gcmVhZCBmcm9tIGFuIGFyYml0cmFyeSBjaGFubmVsOg0KPiANCj4gbHRj
MjQ5N19yZXN1bHRfYW5kX21lYXN1cmUo4oCmLCBOVUxMKTsNCj4gMSkgUyA8QUREUj4gVyBBIHwg
PENPTkY+IEEgfCBQICAgIChzZWxlY3QgY2hhbm5lbCkNCj4gDQo+IDIpIFtzbGVlcCAxNTBtc10g
ICAgICAgICAgICAgICAgICAod2FpdCBmb3IgY29udmVyc2lvbikNCj4gDQo+IGx0YzI0OTdfcmVz
dWx0X2FuZF9tZWFzdXJlKOKApiwgdmFsKTsNCj4gMykgUyA8QUREUj4gUiBBIHwgPGRhdGE+IOKA
piB8IFAgICAgKHJlYWQgZGF0YSkNCj4gNCkgUyA8QUREUj4gVyBOIHwgUCAgICAgICAgICAgICAg
IChjaGlwIGlzIGJ1c3ksIGVycm9yKQ0KPiANCj4gVHJhbnNhY3Rpb24gMyB0cmlnZ2VycyBhIG5l
dyBjb252ZXJzaW9uIG9uIHRoZSBwcmV2aW91c2x5IHNlbGVjdGVkIGNoYW5uZWwNCj4gYW5kIGNh
dXNlcyB0aGUgZm9sbG93aW5nIGNoYW5uZWwgc2VsZWN0ICg0KSB0byBmYWlsLiAgVGhlIGV4YW1w
bGVzIGluIHRoZQ0KPiBkYXRhc2hlZXQgWzFdIG1ha2UgdXNlIG9mIHJlcGVhdGVkIHN0YXJ0IGNv
bmRpdGlvbnMgdG8gcHJldmVudCB1bmludGVuZGVkDQo+IHRyaWdnZXJzLiAgSW4gb3VyIGNhc2Us
IDMgYW5kIDQgc2hvdWxkIGJlIGNvbWJpbmVkIGludG8gb25lIHRyYW5zYWN0aW9uLg0KPiANCj4g
TGltZW5nJ3MgcGF0Y2ggc2lrcHMgNCB3aGljaCBzb2x2ZXMgdGhlIHByb2JsZW0gYnV0IGNhdXNl
cyBpc3N1ZXMgYXQgaGlnaA0KPiBzYW1wbGUgcmF0ZXMsIHdlcmUgMSBpcyBza2lwcGVkIGJ5IHRo
ZSBjb3JlLg0KPiANCj4gSSBhdHRhY2hlZCBteSBhZC1ob2Mgc29sdXRpb24gYmVsb3cuDQoNCkhp
IEZlbGl4LA0KDQpUaGFua3MgZm9yIHlvdXIgbmV3IGlkZWFsIGZpcnN0bHkuIEkgd2lsbCB0ZXN0
IHlvdXIgcGF0Y2ggaW4gbGF0ZXIuDQpJIGhhZCBhIGxvb2sgeW91ciBwYXRjaCwgYW5kIEkgZm91
bmQgb3V0IHRoZXJlIGlzIG5vIGVzc2VudGlhbCBkaWZmZXJlbmNlIGZyb20gbXkgcGF0Y2guDQpZ
b3UgcHV0IHRoZSBzdGVwIDQgaW4gdGhlIGVsc2UgYnJhbmNoLCBJIHRoaW5rIGl0IGlzIHRoZSBz
YW1lIGVmZmVjdGl2ZSB3aXRoIG15IHJldHVybiBzb2x1dGlvbi4NCg0KSW4gYWRkaXRpb25hbCwg
YWJvdXQgdGhlIGhpZ2ggc2FtcGxlIHJhdGVzLCB5b3UgcG9pbnRlZCBvdXQgdGhhdCBteSBwYXRj
aCB3aWxsIHNraXAgdGhlIHN0ZXAxDQpCdXQgSSBjaGVjayB0aGUgbHRjMjQ5NyBkYXRhc2hlZXQN
Cmh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLWRvY3VtZW50YXRpb24v
ZGF0YS1zaGVldHMvMjQ5N2ZiLnBkZg0KaW4gcGFnZSAxOCwgdGhlcmUgaXMgYSAiQ29uc2VjdXRp
dmUgUmVhZGluZyB3aXRoIHRoZSBTYW1lIElucHV0L0NvbmZpZ3VyYXRpb24iIG1vZGUsIEkgdGhp
bmsgaXQgaXMgYWJsZSB0byByZWFkIGRhdGEgY29udGludW91c2x5IHdpdGhvdXQgc2V0dGluZyBj
aGFubmVsIGFkZHJlc3MgZXZlcnkgdGltZS4NCg0KVGhhbmtzLA0KTGltZW5nDQoNCj4gQExpbWVu
ZzogQ291bGQgeW91IHRlc3QgdGhpcyB3aXRoIHlvdXIgaGFyZHdhcmU/DQo+IA0KPiBJZiB0aGVy
ZSBpcyBpbnRlcmVzdCwgSSB3aWxsIHByZXBhcmUgYSBwcm9wZXIgcGF0Y2guDQo+IChTaG91bGQg
dGhhdCBnbyBpbnRvIGEgbmV3IHRocmVhZCB0aGVuPykNCj4gDQo+IFJlZ2FyZHMsIEZlbGl4DQo+
IA0KPiBbMV0gaHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRpYS9lbi90ZWNobmljYWwtZG9jdW1l
bnRhdGlvbi9kYXRhLQ0KPiBzaGVldHMvMjQ5N2ZiLnBkZiNwYWdlPTE4DQo+IA0KPiAtLQ0KPiBG
ZWxpeCBLbm9wZg0KPiB2b24gSG9lcm5lciAmIFN1bGdlciBHbWJIDQo+IGh0dHBzOi8vdmgtcy5k
ZQ0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbHRjMjQ5Ny5jIGIvZHJp
dmVycy9paW8vYWRjL2x0YzI0OTcuYyBpbmRleA0KPiAxYWRkZGY1YTg4YTkuLjg5NjhiZjcwODU5
YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2x0YzI0OTcuYw0KPiArKysgYi9kcml2
ZXJzL2lpby9hZGMvbHRjMjQ5Ny5jDQo+IEBAIC0zNCwyMCArMzQsMjMgQEAgc3RhdGljIGludCBs
dGMyNDk3X3Jlc3VsdF9hbmRfbWVhc3VyZShzdHJ1Y3QNCj4gbHRjMjQ5N2NvcmVfZHJpdmVyZGF0
YSAqZGRhdGEsDQo+ICAgICAgICAgaW50IHJldDsNCj4gDQo+ICAgICAgICAgaWYgKHZhbCkgew0K
PiAtICAgICAgICAgICAgICAgcmV0ID0gaTJjX21hc3Rlcl9yZWN2KHN0LT5jbGllbnQsIChjaGFy
ICopJnN0LT5idWYsIDMpOw0KPiArICAgICAgICAgICAgICAgcmV0ID0gaTJjX3NtYnVzX3JlYWRf
aTJjX2Jsb2NrX2RhdGEoc3QtPmNsaWVudCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIExUQzI0OTdfRU5BQkxFIHwgYWRkcmVzcywgMywNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChjaGFy
ICopJnN0LT5idWYpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgZGV2X2Vycigmc3QtPmNsaWVudC0+ZGV2LCAiaTJjX21hc3Rlcl9y
ZWN2IGZhaWxlZFxuIik7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnN0LT5j
bGllbnQtPmRldiwgImkyYyB0cmFuc2Zlcg0KPiArIGZhaWxlZFxuIik7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAgICAgICAgICAgICB9DQo+IA0KPiAgICAg
ICAgICAgICAgICAgKnZhbCA9IChiZTMyX3RvX2NwdShzdC0+YnVmKSA+PiAxNCkgLSAoMSA8PCAx
Nyk7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IGkyY19zbWJ1
c193cml0ZV9ieXRlKHN0LT5jbGllbnQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBMVEMyNDk3X0VOQUJMRSB8IGFkZHJlc3MpOw0KPiArICAgICAgICAgICAg
ICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycigmc3QtPmNsaWVu
dC0+ZGV2LCAiaTJjIHdyaXRlIGZhaWxlZDogJXBlXG4iLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEVSUl9QVFIocmV0KSk7DQo+ICAgICAgICAgfQ0KPiANCj4gLSAgICAgICBy
ZXQgPSBpMmNfc21idXNfd3JpdGVfYnl0ZShzdC0+Y2xpZW50LA0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIExUQzI0OTdfRU5BQkxFIHwgYWRkcmVzcyk7DQo+IC0gICAgICAg
aWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgIGRldl9lcnIoJnN0LT5jbGllbnQtPmRldiwgImky
YyB0cmFuc2ZlciBmYWlsZWQ6ICVwZVxuIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgRVJS
X1BUUihyZXQpKTsNCj4gICAgICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0K
