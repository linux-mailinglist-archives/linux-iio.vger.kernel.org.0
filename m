Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC7A4AFEA5
	for <lists+linux-iio@lfdr.de>; Wed,  9 Feb 2022 21:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiBIUnn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Feb 2022 15:43:43 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiBIUnl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Feb 2022 15:43:41 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 12:43:42 PST
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3DAC1036AE;
        Wed,  9 Feb 2022 12:43:42 -0800 (PST)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 219AvtQa002226;
        Wed, 9 Feb 2022 14:49:35 -0500
Received: from can01-qb1-obe.outbound.protection.outlook.com (mail-qb1can01lp2057.outbound.protection.outlook.com [104.47.60.57])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3e38nx166y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 14:49:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBtu24peyiXnd/9auQCX1fSdOlMZGGVSImIPRfFmeaOZRjRBhu6EZ1djVzDUZ1tzLqhOI3k5D5uOTo8U32CvItFQZowpqi9GPEvtpefYU5O9xCRNLfU1ENJJjtxCmBtmar1ASqg4TTU/OjgsAXud7GjYqKCYuNVTRqwhBuHSDzF6MSTk0D2rpUhzu+74xrM13MloYdu1kHcXk28bcgGqMYw5VQvKDwUmF3Gv3ROYuTndP9OpxNO6ggj1uKynJCPjhHgNkEwbPu1HysQtBR2dIo+GBcfBehyN89wLsBOmmCj8d6D0BTpKycMhvd1mj0khrFdgnSD3fytBoAUZ+q4MoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llPFqcRzs3chetcCt4rNutsfX5wj1YbELP4uC5k7ZFY=;
 b=fV1HIPLpDbZGrP7BpUcYl0bovvs1lP5cv5xfheHB0hjQi5avf8iLVy52JcqnDeHzbUhuG/p3CGHXEzJp2af6ZnZNp1S22OGD9K8CoYxLJtknhhYVWfCNY5cI4tL8GoMeSdXclyKyaUpgX61Fl4oSXvrW0k54gJBzR/OmFlIWhdR1XFiMBTVY7uJv+88tR+T5lcP7skSUMLZi9yKgAhbxq4xcSXvHBJmfJVVY98lvOB6wWYjeKmFy5YyJ36pIgyc04kSDvWydxHzb6vy8RfJ0d0RCIxWoMsE7kRmziticMSD5Gy6EXsAAitmSraoVjXTMDV8OChys2ot4A825G/skMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llPFqcRzs3chetcCt4rNutsfX5wj1YbELP4uC5k7ZFY=;
 b=FOgKmmR3kPFkyuS8eikDNeYDT4H6yOn3QKuyZny0sY2f/gE010bcLInDhXXWu3yeljZD8GVuAld11ZKyBTQxrwKMy/wqzgmsqfIcje/quE8SCejK07Je6uPwMSS5JBLh96J5EapX5TIxz3gqi8Nbn9int1O8UgVHMAxEaez4AV4=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YQBPR0101MB9390.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:61::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:49:27 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e8a8:1158:905f:8230]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::e8a8:1158:905f:8230%7]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 19:49:27 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Xilinx AMS fixes
Thread-Topic: [PATCH v2 0/4] Xilinx AMS fixes
Thread-Index: AQHYE6RRUmTD4WhLX024f100og4Dx6x7h2eAgBAtmoA=
Date:   Wed, 9 Feb 2022 19:49:27 +0000
Message-ID: <9aeda9dd153f470ae630cff79c374e66ffbeade8.camel@calian.com>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
         <20220130124605.6268bfc5@jic23-huawei>
In-Reply-To: <20220130124605.6268bfc5@jic23-huawei>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-18.el8) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 469fcb87-e94f-45fa-9776-08d9ec05480e
x-ms-traffictypediagnostic: YQBPR0101MB9390:EE_
x-microsoft-antispam-prvs: <YQBPR0101MB93900A4CB1C6181FD6BCED08EC2E9@YQBPR0101MB9390.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QY8mXEShhzummHug/jCfXclGdTUT/OalQ4CMjvlPMzj8w/a9L1rU4Hsvtp2Mb2N0F3ntTeARHp2eQGhnsF08Wn0tn0HTgEfC+/z9UuAdtaaD75fXeWQaemP3oU3jHHONZPSioADyT8wCXzNFjVj2GhEUYHBvzAXhDyWKbla3CAcVTnUjXUuWIU7NnGsvyJEi74JIWn2DLaWwAQdSL4OcJds0evBN1cGhsjymsLAC1xwKI2FBa7Xd2vXY8En2nmdb9Uu4JWfpPMfH6+biHZPON/ieiJQyel7q/2AiEKcPzJFJUS9KD7kFyBQB0BTd+mG3JzY46NwxJsCGryXOIVFLKykYNu3PLBMnlyiJUu84MvXkI7ewbVOtz+91UrAcYfKbtpwtNeVgOldqmZttxIeytyhs/rrHWSAGYroo58u5/ZGliE1TJMAq2Dra0fN1nifUcwjaZRhOKjOly1crcyilPHTKwkHnbTgJYP50mjURKTEgeLmIIfiT1TC0mZ3oxtCDedsp5OpmSiH+J5UNnROSMmNBdTyHDUQq5dFiSNJaTtSpCxNsnIXMsk1uza/7IjpB+GtKPRyRaMPQd4bnI0XVCS2iVwW4/4LFM7on0U7YRs7/zSmQ6iQQXI1w/RUDEKGGDoE1up+m3hW2Fx5fZJCzNm+tBRzljlVb0BMk+Jd2uMTTvSTea8p7+Zc/HGJdP/NQDcVvg7U+EFmNfojbGyspBFOxybDIrY97tXo4JKwDw9uN55/Nuo3vjaWFKR/6zTsCZJB3jmeSqd8+oihQ98PhXEpp3Qv41cxq+CCqQuUBadzZGBbHzB/GeG11Zg2oGZH2uDad7nAWz5YmBLCqikQAtXvO3njEaR9J9H1eJQ1WWdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6486002)(316002)(508600001)(6916009)(122000001)(83380400001)(15974865002)(6506007)(86362001)(6512007)(8936002)(186003)(4326008)(66556008)(38070700005)(8676002)(66946007)(91956017)(5660300002)(44832011)(26005)(76116006)(38100700002)(36756003)(71200400001)(2616005)(64756008)(2906002)(66476007)(66446008)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnQxaVllTUlpYjloN0VTaVJLRVR2SUFjS2RZK2R3VzhPZmF4ZXovdnJ6NEhu?=
 =?utf-8?B?a0c4SnVQL3FGQ1JnR1c4dnNGRXljUU1Nb0JpdWRnWm1KdGxsak4xMlhoMWVv?=
 =?utf-8?B?UDNiait6NmxHYmxJVWhMdHh4MTRJNmxWQTVybkIvYlVwenptbzh5R1cxTDgz?=
 =?utf-8?B?SzViSnlFYmpjMmJsUWpoSmRUV0d6OE9YRFZVYlhUTU1YVjNiMG1tT1pjZ0Jp?=
 =?utf-8?B?RVI2VGhZaEhoSk9oNVBocnIyRWVGOGhDeUxLTnVoY1EzT0Z6RVN2MVFuZEJU?=
 =?utf-8?B?b0JkZm8rN3QrS3p6RjVtdWozaVpzRzZ2dHQxVFF0dGdLaUptRlNTdWVZSHhS?=
 =?utf-8?B?dFM5b1R2bXhtR0xWS1dLS3NpeGtlOVhQR2NHNjdxRS84YkdQY1JUTUdtTHY4?=
 =?utf-8?B?MGJlUjNQcGZoeElEOVk4dWx0ZDdkaGFuME5sSDN2YitTRUFPSjQ2RjlTOTJF?=
 =?utf-8?B?MW5OMFY4cmdvYlRjbkVkMU5wVGVFUmNpR0xPV0hLZW5lUzBEV1NNaWkvS2dE?=
 =?utf-8?B?aG4rZmgyM0dwN1FYZGx0U0c3N1RIZndGbHNrb3pZQ2ZpYkNtMnBELy9VTk5p?=
 =?utf-8?B?Nlo1c2l2aVJoVS8vaDBGNlFYZTF2SnBpem92UnJIekw5QXFURG1zS3hDOWJO?=
 =?utf-8?B?RERpQ0tTd2NueTdhdVpkRDAwN3E4Vjk3MlQ3ekVpdUxQTWpGcGlGME51Qmsy?=
 =?utf-8?B?M1p2UkNTNjFCRmN6eEVYMnpwTUFQWWo4alVVaFEyRmNjVmJORGNCaUY0amFC?=
 =?utf-8?B?ZWdEalRjSFVvZDByZndKUVNENlVMbnFMUkJFWm9seUJQUmVhR1ZVVTlia1NZ?=
 =?utf-8?B?OXZwVUt4QWREcDlpNit2NUxocjRweENheDdBc2Rac2lBSXkxejNKK01WVm1n?=
 =?utf-8?B?OXJPaDV6Y3J3NWhGVm4xT0lGLzBGaytKQ2c1Y2VOb0ZoT2k0Um1WRmFocGR4?=
 =?utf-8?B?OTZGQ1J1cGtVT0xnK3JxdFYxai9mMU8ybXFFREQ0d3pZNWdFWlZNbnp3U1hQ?=
 =?utf-8?B?NzU1cjh3ZmFNd2x0VVU1RFRsQ2p3TmEyaDBaam1wOVlKNWRJTUZLNnJYeWNx?=
 =?utf-8?B?YWRTYTQ1VDNmSWk1dDg5Uks2ZXZZdW40RWlJT1JLaS9hNVpZNnkzcEhReDZT?=
 =?utf-8?B?Nkhoc3hqU2JyaUJ4YVNTZXNWbFR0MUFvTXdIS3lNUnBwZWVibUVjL3dwOTBK?=
 =?utf-8?B?anhtNDkyOVBWUm5Xb0ovQS9YeE5oN2M1MFhnUjFJM3lMN3l6ekwyVEdaMS8v?=
 =?utf-8?B?SzdNMGF4NFNHZ0o4U3IyV25SRVNiOEpNOXQ5ektrcDVYckdDb0hkLzFORERH?=
 =?utf-8?B?RWdnTHpXL2xqZTVnRThCUHp3K3FtWVZNaGQwUnd0MldtckRHUmRMZlJSdGJr?=
 =?utf-8?B?cDQwMDF6RHk4cTJQcFNRUmFvVkNVYWJmdjYvcjdxWEREcUp3SE92TEFqU3M2?=
 =?utf-8?B?RHJXZFNYODArUWdSakNzbTNaVnM2bG0zckRYMUVKazUzcUdveFVIWWlBdmdv?=
 =?utf-8?B?Z2h2eHVQUEpuaHhRV1ZXUDRlSXpvNmpoYTQ5bzljdWJLUGxtaG1TZzVFSTFM?=
 =?utf-8?B?VU43S1laam1sNzRJa0xDMFluamR2Q2g3Y2dlY0NGUnVnODh3dm9PYTRNY0xq?=
 =?utf-8?B?Yk4wbFlxWEo0NFJwaWdPTGJjeGg2OXhvS0ptRWVyU3RJb2JiZzh6c09mVXU4?=
 =?utf-8?B?R1FobTZINGJvdXN4czF1R3FYMjc0QW55M1lpV3lhZGlxK2hwdmx0M0N3MTJr?=
 =?utf-8?B?aEFsdjJIbGpyODhiYmdsV3NHSzBOYnNiV0M3R0RxMGE0N0JGeFd0K3hUcjJ2?=
 =?utf-8?B?VjYyWEh4Z1p6ZnJlaGpkRUZBMkcyTFQ5QlViMC9wVXB4Uzh6T0tCOUxGNXpz?=
 =?utf-8?B?ZGl0Tys5eHpaVjRrZjkyTlF0Y1E3QXpBR1I2WDIvSlZUK1pJaEduY0dSN0pm?=
 =?utf-8?B?b0oyM2tJd3E4NkdneUVWODd1R0RjbWZTcXplRVpOcnhtVlRNbnl3dzY4Qllw?=
 =?utf-8?B?aEJiUmw5Qngyd0dVdk5ja0FabC9OcWFjQXh0TysrQWRzM1JYNld6T212TUI3?=
 =?utf-8?B?REcrcUJyUkpnSzlRKzIraUNaQzAvd2tIWjNaN1hhTElVYmg2bk1od3Y1a3Rt?=
 =?utf-8?B?Nzd1c3JveFJQVFc5ZXpvMGYzN01vVEFuK3pwZi9hZkFnVFZIM0luV01jRnFy?=
 =?utf-8?B?UVZ2d3hLUDNBOC8wWit3WmhlbWg2R0hreXh3bCtOWmFXNDFJL1BzcmphOTQ3?=
 =?utf-8?Q?/XLop3Gd0tONW6hdIOUa4FDkoObGjoWKyqZUYP4Xz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB392184717E5E4E97E4AB4784B8A085@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 469fcb87-e94f-45fa-9776-08d9ec05480e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 19:49:27.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xus6AqofLeuDY4Ifndq1cAl8UOokVrrSzf7/uPrYL3ryZBkVIv0aMDZXYoC5EW5mXDj6bgJnDXCuh1sY+gbsnvOjETqF5h3EsxtHlToFUDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9390
X-Proofpoint-GUID: 3X1mEp2Q6AvWj3ZmVtHntbeZG_Yuskey
X-Proofpoint-ORIG-GUID: 3X1mEp2Q6AvWj3ZmVtHntbeZG_Yuskey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_10,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=871 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090105
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gU3VuLCAyMDIyLTAxLTMwIGF0IDEyOjQ2ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUaHUsIDI3IEphbiAyMDIyIDExOjM0OjQ2IC0wNjAwDQo+IFJvYmVydCBIYW5jb2Nr
IDxyb2JlcnQuaGFuY29ja0BjYWxpYW4uY29tPiB3cm90ZToNCj4gDQo+ID4gVmFyaW91cyBmaXhl
cyBmb3IgdGhlIFhpbGlueCBBTVMgZHJpdmVyLg0KPiA+IA0KPiA+IENoYW5nZXMgc2luY2UgdjE6
DQo+ID4gLWRyb3AgYWRkaXRpb24gdG8gWnlucU1QIGRldmljZSB0cmVlLCB3aWxsIGJlIHN1Ym1p
dHRlZCBlbHNld2hlcmUNCj4gPiAtYWRkIHBhdGNoIHRvIGZpeCBEVCBiaW5kaW5nIHRvIGFkZCBt
aXNzaW5nIGNsb2NrIGVudHJ5DQo+IA0KPiBJJ20gZmluZSB3aXRoIHRoZXNlIGJ1dCB3b3VsZCBs
aWtlIHRvIGxlYXZlIHRoZW0gYWxsIG9uIGxpc3QgYSB0aW55DQo+IGJpdCBsb25nZXIgc28gd2Ug
Y2FuIGhvcGVmdWxseSBnZXQgc29tZSByZXZpZXcsIHBhcnRpY3VsYXJseSBvbiBwYXRjaGVzDQo+
IDEgYW5kIDQuDQo+IA0KPiBKb25hdGhhbg0KDQpIaSBhbGwsDQoNCkkgZG9uJ3QgdGhpbmsgSSd2
ZSBnb3R0ZW4gYW55IGZlZWRiYWNrLiBJcyBhbnlvbmUgYWJsZSB0byByZXZpZXcvdGVzdD8NCg0K
PiANCj4gPiBSb2JlcnQgSGFuY29jayAoNCk6DQo+ID4gICBkdC1iaW5kaW5nczogaWlvOiBhZGM6
IHp5bnFtcF9hbXM6IEFkZCBjbG9jayBlbnRyeQ0KPiA+ICAgaWlvOiBhZGM6IHhpbGlueC1hbXM6
IEZpeGVkIG1pc3NpbmcgUFMgY2hhbm5lbHMNCj4gPiAgIGlpbzogYWRjOiB4aWxpbngtYW1zOiBG
aXhlZCB3cm9uZyBzZXF1ZW5jZXIgcmVnaXN0ZXIgc2V0dGluZ3MNCj4gPiAgIGlpbzogYWRjOiB4
aWxpbngtYW1zOiBGaXggc2luZ2xlIGNoYW5uZWwgc3dpdGNoaW5nIHNlcXVlbmNlDQo+ID4gDQo+
ID4gIC4uLi9iaW5kaW5ncy9paW8vYWRjL3hsbngsenlucW1wLWFtcy55YW1sICAgICAgICAgfCAg
OCArKysrKysrKw0KPiA+ICBkcml2ZXJzL2lpby9hZGMveGlsaW54LWFtcy5jICAgICAgICAgICAg
ICAgICAgICAgIHwgMTUgKysrKysrKysrKystLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCi0tIA0KUm9iZXJ0IEhhbmNvY2sN
ClNlbmlvciBIYXJkd2FyZSBEZXNpZ25lciwgQ2FsaWFuIEFkdmFuY2VkIFRlY2hub2xvZ2llcw0K
d3d3LmNhbGlhbi5jb20NCg==
