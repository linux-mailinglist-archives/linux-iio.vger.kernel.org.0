Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7DE6E5889
	for <lists+linux-iio@lfdr.de>; Tue, 18 Apr 2023 07:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjDRF3B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Apr 2023 01:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjDRF3A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Apr 2023 01:29:00 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2104.outbound.protection.outlook.com [40.107.127.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0744692
        for <linux-iio@vger.kernel.org>; Mon, 17 Apr 2023 22:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqjmp5oOdnUGtxdGsWqCD9hkia5PhzntnlGbJeKbF6i7rFbmkoUXwx2Cw2wTAIYq4pnRhpOh9l6/RZ68M4aVmu35r+bRRl28y2XviIaWWs2F2ONXtgxY/i7+RnGnk3xNpdQN9/Q06BMohGkTaSa5j7kZE4c/XxJqTykvlKdYiG6Gh76NQVbOqwsdSKSYbas+RHR0fqNxcxqvm50tWb03HElb/pn2D2nFG0l+36YYfDrZ0Bh+trvpXxIZTgiuF1I+zMQ5CiY20Frmy5PiGY3SPXwSpAgq0iWFHjSAZhgl+KJ6FWBUAmq278+3qj+0HKgTKTOu3v2e8oGhTzemtrmaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDGQ03MULBBBPwOvzCiyES8sZuc60J4JkANfGQWoQOI=;
 b=WuRjV4JGLNZcjmrR9OPaOUb4l9yc+S7rjNyX4Gy98Eup2E3KgkZwF3gGlgFjT1bIpHLeNCLnt8CN9s9Uo9LbhxuLjzG8qPRE7ROyHGafZ8rZwZcUzWJzRtBm5t7Uaw0GO+5lUK2nVSUT44TBcPUIQnHhF+PQz36UF5d70buGY3kYc0Mx6w2UdI7hihw/FXLKJf1rVKpEWwqBqoCpa9lGpZp3h4NpYRZr1cC0R6c2YhpEroeZAoBOr3SdZ3Qhj4/MFbGrcvhRJa9BGTPLSLwZmaBe5hhDYWaX3XuvzwD05Zk57lA77ELDqOn97ungCWV9JGx71bKu8/yGvL0cIOvXdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDGQ03MULBBBPwOvzCiyES8sZuc60J4JkANfGQWoQOI=;
 b=gazzqj4PhDJVyOd0bK1siKX5KLew7TDGfy4uthA51MMQqwKiTopRokT64D9YJbzUjhG12rFDQe6h8ivRAm7kT/ND4FAvlfwY53WsbCXNQxVONa5jhqu/UjZOytzIGl2QBwjAZGJcIFol7SuomHVC6K0zRMuso0yTyqMhDGiBBBA=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by FR3P281MB2585.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 05:28:53 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3657:656:f6f6:dc8f%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 05:28:53 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM BU27008 RGB sensor
Thread-Topic: ROHM BU27008 RGB sensor
Thread-Index: AQHZZu2pPMu43ReP9kutQyfvEEIMCa8kwd8AgADaWICACGtjgIACl96A
Date:   Tue, 18 Apr 2023 05:28:53 +0000
Message-ID: <fb7d6c05-bb83-8185-f636-5db68ffe5fcc@fi.rohmeurope.com>
References: <5942c0c2-3997-e10f-0872-30d201bc52ae@gmail.com>
 <20230410171654.66605efe@jic23-huawei>
 <8e61fb87-2533-9a81-1682-2e5ee376389d@gmail.com>
 <20230416145249.05d2d9c0@jic23-huawei>
In-Reply-To: <20230416145249.05d2d9c0@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|FR3P281MB2585:EE_
x-ms-office365-filtering-correlation-id: 1ff04be5-4b3a-41a4-ba73-08db3fcdcc93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwY80jDF036uFTNbUv0RE5LyrMOdqm2D7tSnmwRqm+Dj0TI4LhkbUEchav4ot/xH9/B62XB/KIj/LuhhlJuzKLH4ZEbl85nTKzyzwhIWeuRo9Gs6gnxmLKf0f2VRYpFR8KHj/phzuQjZuQC6c4Gyd+XI847c3GLUW3f+T7LaW+MJn5Qt5z1Y5Uvrm0OHLSsZUkpZDB7qgsNiliP8sD/pfHAb0udZHfWKyGQpiyKZkfZO8gcEVP8N13jKskkZ6cMPw8J5hAmf4cryhFrrdu4fVyDJfMSWGAU9+kFDfE0lCP3w5cCgSHFUGjH8hGYkxSeCdf1VcNFsqVrqnUN8ewdwUAf1veZbmVJ8Vcm12UtjLu/OHEAIQ/jqsI0ujG+s5BTeOFqKsLslMMdj+4ggZW1Sk46LpsSx0J5nHC4xbE4Hh7X6NiRX02Ye7SdzX5TL/B/Mk+L3iZCIvekyv93Y0wJcZo1JOnlQ9QkjUclGgAxPP0Z1oRtYNJErzvaSzfS7UQSD6IS5p2fV3FMwwEGaLdctC11by8Q1HCYP8Z23RELkM1YDTGxlxKxgA+qMWUTw3I8PuJGk34Wuz+v2c1B7YFJtJfUem1b2Bk8FkcomfB2Om1rj7kAMoNLBhFltP3kcELijwMgibXI218xwMgq8sueMl69qeXx+yfC7JdfJFEdvUrdQGCHj8xSQ8EbFiZbiKUVS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39850400004)(396003)(451199021)(66556008)(66899021)(2906002)(31686004)(66946007)(66446008)(4326008)(66476007)(2616005)(64756008)(5660300002)(8936002)(316002)(86362001)(76116006)(91956017)(478600001)(41300700001)(110136005)(71200400001)(6486002)(31696002)(122000001)(186003)(53546011)(26005)(6512007)(6506007)(8676002)(38070700005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG1ReWk3TXYwd3hJM24xS1NsaVE3VktnRUxHMFd4QndRbmRyanZqaTdoTVh1?=
 =?utf-8?B?TFU0a004VG5GbklnamhCUC92cjJyUUJIcjBaMXNvU2xMV2dCM2VkUnJDWEVx?=
 =?utf-8?B?aGRFWDRITmd5MUNtQTVqSkc3YStML1ZSWjhWY3JMbjlIbnc4U1dmdmJqWXdT?=
 =?utf-8?B?TW1CcEFJZUNOZm0rYmJ3VXU1VzdlV3RFVFFvM3RzOW5mTE92Wmc5OFZmdVpI?=
 =?utf-8?B?MnlnTWRreHRwWUppdzYwVXBOdjl0TndQNXV1MENoV0ZYM21xaDNaemhSTy9h?=
 =?utf-8?B?SUlPdlBsZkFKZjNrNUZDVEt6YzNxVDd6bVVERFZUNHlkTitBYkdNOXZzMVhF?=
 =?utf-8?B?TEdQMXEvZStrVWRpeUxVN0xxWmxidGtOOVlwSVUrT0JQT3Irb0NQbGN3RUNt?=
 =?utf-8?B?TlZpbENPeWMyeWZiS1V6bXd0YlM0cjNMY1dSUGtxRXBzZ1hwTFpMVzBkYVA5?=
 =?utf-8?B?Y2crMzR5bkRKdTQvL2xmUWRjcmEzOTY0NFNubWpUY2h5MGVlOXk3MUF3UU5m?=
 =?utf-8?B?SmJQRHNOMVFOT244L0FsS1VOWUU0SVRnNHdnbExTaVQ0MGJYZVlTbUQ1TzdK?=
 =?utf-8?B?QUlCN3l4OVB5M3RMTUJybEI0cVF4QkU3NFpRSDFESW9EQzQyTVFqcENPOE5E?=
 =?utf-8?B?dDlhdy9QTFZRTFZibjVPWElPdzFRUzFxL2tqK3FTMjBHbmtxdWplYW0ranVy?=
 =?utf-8?B?SzJCS25BVnd5NUEyWXJJMDlIZ2FhWXF3QllkVXd1YzhTYlV3bmQ0aTFSZjNx?=
 =?utf-8?B?bnV5aFhlUjdha0kwNzJXMTF0RHR3L1pQZFdmaTkzRXFKeTVqYWpRQXBSMllR?=
 =?utf-8?B?d1pRZ0dOQ1dUVThRV003bmNpb0xSckJvRGZGbFlRa2QySEJ6K3pralFpYkVO?=
 =?utf-8?B?L0ZOakcwUi9HYm1tWGhFMEVUWHRoZStaamNEY3NIS3hTYTFCQ1ZoWUFOUGx0?=
 =?utf-8?B?VE54QnNWWWFUVTlCcC9rV1huUElTZDFwZjQ4YktEZkpSRGQ4bXYyaG9uTHFu?=
 =?utf-8?B?em16aW5KRitrUE5xcVVKcUNQcUV3azFRdHdScVFGSGFkbzNkYUdJNmRRc09U?=
 =?utf-8?B?UExNOC9Jc1BDbS9YU0lTcFpZaXRYaXJPZFdXeTQrM0d2M0RweWljVVVxa0th?=
 =?utf-8?B?Q2lMenRZTXJDQ3IvdExreDVqR2Q2cHIwN0kwWGQvV1ZtSE1RV3hPblJHUDll?=
 =?utf-8?B?RWRvWjRUVGE0UWtnWExTMDk0SHp6SjQ2SVpINDFScVRkcGxrWDlHZDlnamg2?=
 =?utf-8?B?VW5xWkdRUDhuUE8wQWx2eG5rRzdYQit4QjJLVFZjOFhFaDBrcmNucXhxaW9G?=
 =?utf-8?B?cjM5dlBOWVlCNUZuVDlGcnZ6dWljZ3BqSTVLRnZsQnRwZ2RURTJyTHBQZHdL?=
 =?utf-8?B?ZjJMYWxiRWpkRFBMYk9wZk9BUU5Tb1BUWGpEeEQ5aWpBMS92WWp4Sm1PWE56?=
 =?utf-8?B?ajZRTnJVcmRWYnZlcXJvNVFrMVlDajRXVmV4Q0xhWUZjeDE0OTdxdTNPSlZH?=
 =?utf-8?B?M2Q5MVYwdG9nKy9Gc3FWSWZ6QXBqUmt3TTFZYzlZZHhFbm5iL245QlNxaTZU?=
 =?utf-8?B?SUhEeGpoY0tuTy9vZDBVRDdVZWs3eGJvdk9IcXR5eXRpZzJCYVRvUHJpSkpK?=
 =?utf-8?B?djRRcDFEUWpjY2lzaUFMdVA1R2t1WGd4OWNDcGtsSVFUbUlzMFpyL25teThI?=
 =?utf-8?B?VnpoV05hUnJraDlXMGRJNnl5SDBBZjJYTGxIcW8zMjJIM3FHUzVWOVVjOXBI?=
 =?utf-8?B?cW1TQkZjeFV6bWJMejk3eHhGR3kzQnZkK1BTU2JDbGZkSkM3THZzbFNPaTlW?=
 =?utf-8?B?ZjQ3aFdwcE5mSUppRWZQSFZjR3ZTcytJbnZUSUdZdFNuRUdRRzNhNGE0MXRh?=
 =?utf-8?B?VERNaHM1azg1R1pDWXMzRjQxaUIrUHkvQlNGdS9sVXhnTU9kY3c4ZW4xVTNs?=
 =?utf-8?B?SVU2bTh4Z1ozMEZiNjZNRzJwVmViWTlaVkoydjdhc28xc09JRXRpSXZZWE9E?=
 =?utf-8?B?eWR2UjhWWEluOUp2QUY0VWc5MWU2QTR6emZYL0tSZTdhUTAyVVZzd1V6WUJN?=
 =?utf-8?B?d09ZQkgrdm8vNVE5ODhUVThHaVJZbXcyUkZlTVFTUVlGSTJkeDltcDVaUEc3?=
 =?utf-8?B?Tmd1VUswWE14cU5DMEUzVXJQQ3NVZlRWcEFrNWxLZnJMd0NPVUtDK1drQkRY?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBFDE80C25DF8340A88D6D2C70C434C1@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff04be5-4b3a-41a4-ba73-08db3fcdcc93
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 05:28:53.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2mTu2o6VeDJmfQEMO2HwoYLqFIsdPJjmQuPeEu+pr/lrhS7TfBiKCtmLivKAckw+EyMFl4Ek3H5CvQrzaq9dD3MFibhSvlsLkzRAOFSYJVPe845q6fiw704ib/6/vFO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2585
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gNC8xNi8yMyAxNjo1MiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+IEFuZCB5ZXMsIEkg
aGF2ZSBiZWVuIGFuZCBjb250aW51ZSB0byBiZSBnaXZpbmcgZmVlZC1iYWNrIHRvIGhhcmR3YXJl
DQo+PiBjb2xsZWFndWVzLiBBbmQgZXZlbiB0aG91Z2ggSSBhbSB2ZXJ5IG11Y2ggdGVtcHRlZCBv
ZiB1c2luZyB5b3VyIHF1b3RlDQo+PiBhcyBteSBlbWFpbCBzaWduYXR1cmUsIEkgZ3Vlc3MgaXQg
aXMgbW9yZSBwcm9kdWN0aXZlIHRvIHRyeSBhIGJpdCBtb3JlDQo+PiBnZW50bGUgYXBwcm9hY2gg
d2l0aCB0aGUgZmVlZC1iYWNrLiBYRA0KPiANCj4gSSB3aXNoIHlvdSBsdWNrIC0gaW4gZGF5IGpv
YiBJIHRlbmQgdG8gZ2V0IGxlc3MgdGhhbiBoYWxmIG9mIHdoYXQgSSBhc2sNCj4gZm9yIGNoYW5n
ZWQgaW4gZnV0dXJlIGhhcmR3YXJlIC8gc3BlY3MuDQoNCkl0J3Mga2luZCBvZiBjb21mb3J0aW5n
IHRvIGhlYXIgdGhpcyBJIGFtIG5vdCBhbG9uZSBpbiB0aGlzIHRyYWluIDspDQoNCj4gQSBydW5u
aW5nIGpva2Ugd2hlbiB0YWxraW5nIHRvIG15IGhhcmR3YXJlIGNvbGxlYWd1ZXMgaXMgSSBtb2Fu
IGF0IHRoZW0NCj4gZm9yIGdpdmluZyBtZSB1bm5lY2Vzc2FyaWx5IGNvbXBsZXggKG9mdGVuIGNy
YXp5KSBpbnRlcmZhY2VzIGFuZCB0aGV5DQo+IHJlcGx5IHdpdGggJ2l0J3Mgb25seSBzb2Z0d2Fy
ZScuDQoNCkkndmUgaGVhcmQgdGhhdCBzZW50ZW5jZSBjb3VudGxlc3MgdGltZXMgZHVyaW5nIG15
IGNhcmVlci4gSXQnZCBtYWtlIGEgDQpncmVhdCBtb3ZpZSBzY2VuZSB3aGVyZSBhIHJvb20gZnVs
bCBvZiBoYXJkd2FyZSBlbmdpbmVlcnMgcmVwbGllZCB0byBhIA0KbG9uZSBjb21wbGFpbmluZyBz
b2Z0d2FyZSBlbmdpbmVlciAiSXQncyBvbmx5IHNvZnR3YXJlIiBpbiB1bmlzb24gWEQNCg0KDQo+
Pj4gQW5vdGhlciBvcHRpb24gY29tZXMgdG8gbWluZC4gIEp1c3QgaGF2ZSBvbmUgc2NhbGUgdmFs
dWUgYW5kIGRvbid0IGFsbG93IHRoZQ0KPj4+IGxvd2VzdCBnYWluIHZhbHVlLiAgVGhhdCB3YXkg
eW91IGNhbiBhbHdheXMgcHJvZ3JhbSB0aGUgc2NhbGVzIHRvIHRoZSBzYW1lIHZhbHVlDQo+Pj4g
Ynkgc2V0dGluZyBib3RoIHJlZ2lzdGVycy4gIFNvIGJhc2ljYWxseSBoaWQgdGhlIG9kZGl0eSBv
ZiB0aGF0IGRpZmZlcmVudA0KPj4+IDF4IHZzIDJ4IGluaXRpYWwgc2NhbGUgYnkgbm90IHN1cHBv
cnRpbmcgaXQuDQo+Pg0KPj4gWWVzLiBUaGF0IHdvdWxkIGJlIGFuIG9wdGlvbi4gTm90IHN1cHBv
cnRpbmcgMVggbWFrZXMgdGhlICdzYXR1cmF0aW9uDQo+PiBwb2ludCcgZm9yIFJHQkMgdG8ganVt
cCA0WCBsb3dlciB0aG91Z2guLi4gSSB3aWxsIHNlZSBob3cgdGhlIGNvZGUgbG9va3MNCj4+IGxp
a2Ugd2hlbiBpbXBsZW1lbnRpbmcgdGhlICdjaGVjayBpZiBoaWdoIGJpdHMgY2hhbmdlZCcgbG9n
aWMgeW91DQo+PiBzdWdnZXN0ZWQuIFdlbGwsIHRoYW5rcyBhIExPVCBmb3IgdGhlIGhlbHAhIFRo
aXMgbWVhbnMgSSB3aWxsIHNvb24oaXNoKQ0KPj4gcG91ciBzb21lIG1vcmUgcGF0Y2hlcyB0byB5
b3VyIHJldmlldyBxdWV1ZSA6KSAoTWlnaHQgYmUgSSBkbyBzb21lIFBNSUMNCj4+IHdvcmsgYmVm
b3JlIHRoYXQgdGhvdWdoKS4NCj4gDQo+IEFueSBpZGVhIHdoZXJlIHRoZXNlIHNlbnNvcnMgdGVu
ZCB0byBiZSB1c2VkPyAgSWYgaXRzIGluIGNvbnN1bWVyDQo+IGFwcGxpY2F0aW9ucyB3aGVyZSBt
YXggaXMgbGlrZWx5IGJyaWdodCBkYXlsaWdodCwgbWF5YmUgc2VlIGlmIGl0DQo+IHNhdHVyYXRl
cyBhdCB0aGF0IHBvaW50LiBJZiBpdCdzIGZvciBsaWdodGluZyBjb250cm9sICh0aGluayBvZg0K
PiBwdXR0aW5nIG9uZSBpbiBhIGxpZ2h0aW5nIHVuaXQgaXRzZWxmKSB0aGVuIG1heWJlIHRoYXQg
aW5pdGlhbCB2YWx1ZQ0KPiBtYXR0ZXJzIGFzIGxpZ2h0IGxldmVscyBtaWdodCBiZSB2ZXJ5IGhp
Z2guDQoNClRoZSBkYXRhLXNoZWV0IGRyYWZ0IGZvciBvbmUgb2YgdGhlc2Ugc2Vuc29ycyBzdGF0
ZXM6DQoiSXQgaXMgaWRlYWwgZm9yIGFkanVzdGluZyBMQ0QvT0xFRCBkaXNwbGF5IGJyaWdodG5l
c3Mgb2YgVFYsIG1vYmlsZSANCnBob25lIGFuZCB0YWJsZXQgUEMuIg0KDQpUaGlzIHNvdW5kcyBs
aWtlIGRheWxpZ2h0IHN0dWZmIGZvciBtZSAtIGJ1dCBJJ2QgaW1hZ2luZSBwZW9wbGUgdXNlZCBB
TFMgDQpmb3Igc3VjaCBwdXJwb3NlLg0KDQpUaGFua3MgZm9yIGFsbCB0aGUgaGVscCBKb25hdGhh
biwgdmVyeSBtdWNoIGFwcHJlY2lhdGVkIGFnYWluIQ0KDQpZb3VycywNCgktLSBNYXR0aQ0KDQot
LSANCk1hdHRpIFZhaXR0aW5lbg0KTGludXgga2VybmVsIGRldmVsb3BlciBhdCBST0hNIFNlbWlj
b25kdWN0b3JzDQpPdWx1IEZpbmxhbmQNCg0Kfn4gV2hlbiB0aGluZ3MgZ28gdXR0ZXJseSB3cm9u
ZyB2aW0gdXNlcnMgY2FuIGFsd2F5cyB0eXBlIDpoZWxwISB+fg0KDQo=
