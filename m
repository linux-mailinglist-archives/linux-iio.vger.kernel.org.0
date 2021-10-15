Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088F042EE85
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhJOKOx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 06:14:53 -0400
Received: from mail-eopbgr1310117.outbound.protection.outlook.com ([40.107.131.117]:14464
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232991AbhJOKOw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 15 Oct 2021 06:14:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLxSq4Gfk++V+ulvpBKF9Mq6hIfEeD/tyrwEgu/41MBiCCZTQU7xqFWp3s16xEMeVMyS/0WMRuPPoD0ZhUHuec5c0J2C79bcq2ncX8FYVoLmv/XQN85S/WC4ctoIYejuT4cDFb3+fgjNXi0AnDSToOLVzTA4l5rZO3psT+duRhgS/tEZ5osDx11VHOvSjhmYjNlXqnMI3b/48YK6XK0S24RMfwL18PsjOELZLPzjwb5Pzes3i4M0mdf4AfQ7IEYQA6w/nhE8YN0lA8dufUKfPNpo30Ee2urz4Fq9CBm5A5v6Fp8UQgk72p5hUJCfUj2N0rD3EvDkU8gDuOy4cHzM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+obPW6500LFAB0jKz0a+Py2jirNcHCop+Qwl0RmEsM=;
 b=VziQTQL8jaQJgSf5sS296IHsulKcN6mEqlK5peWDCtDIzFhm8TY9h8YkVlWpspCgR+trhhnBoGQgeCqffjDtjHHafLNmlbTQGyQMlVwiC5xDNm0+GUaDqHdZbAVh7e7RJywIYhpNC3X0rqZKfyHRq+1kBhHWYsjPHitueplKhPLrcHzzaZEGjOOlT82sFKiWDrcNeNwX1qpBW1BThYSOhhHNUhN3E5F6jpLZ37jqB0VgwimaoLlZ3QCb73vN06QoxWFixmx88BwmARI6YW4hgW0jhBCW8oTlUNodnFVqk/4IYDOsfOwl+OaONedg4eztbCgfRY9ijLR9X6+d1Xgu9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+obPW6500LFAB0jKz0a+Py2jirNcHCop+Qwl0RmEsM=;
 b=JeKkulIKOun0q0E/Rq0rLBNj3E2Tvp7wvJEMrKlEi3ToNt1/0jZiE7CiWPUlxsU0N0j+Bk3L0WZM3q72hyJy+6gz+M+KD/zN36GtqTc/i7fuAMvVT1ua9oHGrZ/2aBqILzaltbxE1wZqk1lA8Jcu01O4eoJhzf/CP0JnE+iQwts=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3241.apcprd06.prod.outlook.com (2603:1096:100:3d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 15 Oct
 2021 10:12:42 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 10:12:42 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     =?utf-8?B?QnJ1bm8gUHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGhpZDogcmVwbGFjZSBzbnByaW50ZiBpbiBzaG93?=
 =?utf-8?Q?_functions_with_sysfs=5Femit?=
Thread-Topic: [PATCH] hid: replace snprintf in show functions with sysfs_emit
Thread-Index: AQHXwZCtE2ZGkte470CH11zfSOYLe6vTteMAgAABo/M=
Date:   Fri, 15 Oct 2021 10:12:42 +0000
Message-ID: <SL2PR06MB308276FBCF5F54C435E85F53BDB99@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1634280506-4477-1-git-send-email-wangqing@vivo.com>
 <AMgA7gCyEvPU77AozESAHarT.9.1634285608120.Hmail.wangqing@vivo.com>
In-Reply-To: <AMgA7gCyEvPU77AozESAHarT.9.1634285608120.Hmail.wangqing@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: c70318ea-56be-0a0f-21c0-a6915f0cf0c2
authentication-results: linux-vserver.org; dkim=none (message not signed)
 header.d=none;linux-vserver.org; dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b45f63f7-4b4e-4b56-8afb-08d98fc45346
x-ms-traffictypediagnostic: SL2PR06MB3241:
x-microsoft-antispam-prvs: <SL2PR06MB324134978BC32E8BEBCE8092BDB99@SL2PR06MB3241.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cePegQl8bzb25fyAhZ5vSHIsMRMvX4/N+JlrNCweHavWENcOyJkabswhns+E/nfkjfbLUfcsDpkErqZQ/S2lxh0IjLkvdZib8IDetJKQu3hcmCEwUeHtq8QOIG/2xTV2ATG69+2CbEgXUQeXbCSDb7L6W9MwnbC1h2X4fFhE0ufAWKrcLe7r9OKKISKdjjmZ7lq0FjPQml+Vb4Q3v0DlE70CcEoF+IbyE5iQMdjrYFo8GPZzTwKRwwtXusJCK17Gqz8VHO8AVtFjsb1nOZM7wnd36pYl0Ij2Jnqtgk5vAH7lOexDW2BGl1yF2S5PTRPtdSkYW/O4V0jKLbC8jkQb1fVFxFVT111BhBwYtcXuc1+6XN6Xgd04pWdf2S+Q82FX061u3V5yTtEUI/sJ2GgiWVcKyr/dSDoJ/RiCJvSGTWh6lYXaJty+1zJKhSy2Hva9eMSOQJQx4KPZvuJyP/+K5muc4aDuHVcis9XHKIO6aFUU6H2Xbp21JtgWHCYYI2ZEk/PC2E6oo/S2fD6bJDYJfYyui7g+hQwZOMnEO3yUctUcMq7fzFIAB9LF/ngH/BqEpLYfjhij8gYz6LyxVKLDkPxp3S/c6BYxcKFDsnJzbx8Zr0syi5UjfxHBww0RW9bYlay5gkhtFECZ2G29Wzi1YXXQvv/om9z5+A7V7gdJooTn+bS76MnqkXSiWzW+FSulrIRTzYqVDQnChKOV3wqUrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2906002)(316002)(86362001)(9686003)(85182001)(38100700002)(6506007)(71200400001)(26005)(76116006)(91956017)(7696005)(186003)(52536014)(64756008)(66556008)(66476007)(55016002)(66946007)(66446008)(5660300002)(122000001)(38070700005)(4326008)(508600001)(6916009)(83380400001)(66574015)(224303003)(54906003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTV5cjd5ZTN4VS9ZeCtYK0JyL2J5Y1pFekQzUW5QTDBHRXNKRklTaVdPQmE2?=
 =?utf-8?B?Q0RDdnFZU1ZtT0dxd1JQSWhseGp2VFhGZFlYTnBzaUtqbS8zNXpqaCs1RlJo?=
 =?utf-8?B?V0d0dEFpOGcyeUlFMnNWVWJMMDJLRlJ6VDRuTjJmVDdPMTZxZWJjVjc3RVhD?=
 =?utf-8?B?eU51K0R5cm5xOG01T1dGMk1pamJPK3ZlZWprK043L3JBM2d6Tk52K0duMVZ5?=
 =?utf-8?B?VHNkUmFNdnFxUzAvZWp6QmJDNW5aVjRNZW5pRU5JdEJMM1FSUGJHVk10QXhQ?=
 =?utf-8?B?b1VUbHdKTnBCNHlVNms1SktiVEM4ckJvbnUvOVJPbGhBMjU5a084K0xmZTVF?=
 =?utf-8?B?VzR3OTNxWGZ1TzRQZW55bFhMU0JRdHY4Y0gvbW41bXN6ZnNEZEcrK0d3aytR?=
 =?utf-8?B?a2p4WXpsNGdtTEo4ei9IdG9ZWUp3TnRpMjROam95ODd4SFFWMlNFbktxTXps?=
 =?utf-8?B?bzV5ZWRFd21vRVhoc2VWQlZPTlYzSGh6QjJTVUNrdU0wL3RYL1l3c2doQ3g4?=
 =?utf-8?B?Ry95TExMVUJXcVVpWFZkMEdRaUIyMUNraGRBU2ppeWxCQnJKWFNjelBLbFJH?=
 =?utf-8?B?WEM0OEhEZ0MveVNHdGNwVnBrN3Y1T1FlTTN0amVGblE1LzE0bmZzbjF2anFI?=
 =?utf-8?B?YktZRzZjNmU0VXJ3Zk5FcTFSVUZkZC9ScEpmYkl3YXBTeS93TU5vY25uUnZ4?=
 =?utf-8?B?aG9wbEFINHBOaHBqMnZmUXVlZjVpQjZQc094OXFWOGlFWERCMW5aMW5hY0VY?=
 =?utf-8?B?S1J4SFdqcFE3WVl2MWExc2F3a3Zhb2w4Q1JaTFQrbUZEWEp5Q2k5M2xXNmhh?=
 =?utf-8?B?Q29EY2QrUWU0bXRYajlZY3NQZllrMlpNbitPK2NFRnlvODBTb3VIQS9lcVg1?=
 =?utf-8?B?M3JGY2NIZisxYmpneXQxSUtXQUFYTDkxWGZsMzlLNW5rR1Rpa2VoWVF4akQ4?=
 =?utf-8?B?UWFoS1VxeEdGS2lpZXV1S0xJb2pQWFVEcTJ5VzNLMHFNOTJpbElzc0tDdUVS?=
 =?utf-8?B?TDdONTNnajVueWNzMHAwWWVNZjE4Z1EvUm9pYnNDT1ZBKzNPVXhVVTlHc0px?=
 =?utf-8?B?OUJmRUdqQUh3aEliTnNBZ0pJQUlaUCsxWGsyakw2VjVFT3lVRmVYMHI4aStG?=
 =?utf-8?B?bytEL0JnanQ2TWwzU1NJOWt4NmxQNWRGaFhaTDVHc2lYd0lWMllKN1ZLQ1Jh?=
 =?utf-8?B?ekt4MCt2TGQrUVYzYytYZFpxRVA1T00ycy9PeGRGNUwxZVo2RzM1SWxZRUlW?=
 =?utf-8?B?Q2xudnNGbmdybUJqUFJ5SXcyNTk2OFZVbWU3TG1jaW1LVHhaNlBOWDRXYXhJ?=
 =?utf-8?B?MUV6TzBVNUtvUUxKZW1xNm81NVJqaTBkdWFXWFh6WkpRWCtxOUE1TU5WZVc5?=
 =?utf-8?B?b003T0VYTVhZZ0srZmtUWDZhNXpGYXA3VTRCeFBLdzVpOEVvbi9ZWWQ1WkVP?=
 =?utf-8?B?KzZtVVpkZVZCenp6eVRSdmN3aXFScDh6aktpaTNOYkV0RWM0SUExSlh0YUtD?=
 =?utf-8?B?MTdBZE51dXdrN0VldjVBeTJvK2x2ZE9sblpxRkQyZWUxVW40cUxteXBQcEh5?=
 =?utf-8?B?YlR4Y2NibHVwK1dPbFpwdEwvcVBQT3VWTUs0eGZQdjVrREVoVVcyNjBUV1Vw?=
 =?utf-8?B?ZEZPcGZFdVB2djVoYzVSaW9iMXZWSm5aNko4SlBSWGYxZ2J2VmlBdDVPOXZT?=
 =?utf-8?B?R1JoNERjQzRnK0kvUjBOUVN3MGFidWNEbSs2MFdham5mTWlpRllONTVQS3Ry?=
 =?utf-8?Q?s9/5d4NeDKEIV5WodaCkL3GPf5XwcGdHWPZXJfB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b45f63f7-4b4e-4b56-8afb-08d98fc45346
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 10:12:42.0701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EE95m3LHnRlIixnqFFe6ikld/bRVfSUs6fIuaVufB2+1xNrkpjIuy9p6vI8M6aU28pwmUNjHrwLEoYqAsRkW9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3241
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Cj4+IHNob3coKSBtdXN0IG5vdCB1c2Ugc25wcmludGYoKSB3aGVuIGZvcm1hdHRpbmcgdGhlIHZh
bHVlIHRvIGJlCj4+IHJldHVybmVkIHRvIHVzZXIgc3BhY2UuCj4+IAo+PiBGaXggdGhlIGNvY2Np
Y2hlY2sgd2FybmluZ3M6Cj4+IFdBUk5JTkc6IHVzZSBzY25wcmludGYgb3Igc3ByaW50Zi4KPj4g
Cj4+IFVzZSBzeXNmc19lbWl0IGluc3RlYWQgb2Ygc2NucHJpbnRmIG9yIHNwcmludGYgbWFrZXMg
bW9yZSBzZW5zZS4KPgo+TG9va3MgZ29vZCB0byBtZSwgYnV0IEkgaGF2ZSBhIGZldyByZW1hcmtz
Ogo+Cj4tIE5vIG5lZWQgdG8gdGFsayBhYm91dCAibXVzdCBub3QgdXNlIiBpbiBkZXRhaWxsZWQg
Y29tbWl0IG1lc3NhZ2UuCj7CoCBNZW50aW9uaW5nIGludHJvZHVjdGlvbiBvZiB0aGUgbmV3aXNo
IHN5c2ZzX2VtaXQoKSBmdW5jdGlvbnMgKGluCj7CoCBjb21taXQgMmVmYzQ1OWQwNmYxNjMwMDAx
ZTM5ODQ4NTQ4NDhhNTY0NzA4NjIzMiBhIFllYXIgYWdvKSBhbmQgdGh1cwo+wqAgc3dpdGNoaW5n
IG92ZXIgdG8gdGhvc2Ugd291bGQgYmUgc3VmZmljaWVudCBmb3IgY29kZSBwcmVkYXRpbmcgdGhl
aXIKPsKgIGludHJvZHVjdGlvbi4KPgo+LSBJJ20gd29uZGVyaW5nIHdoeSBwaWNvbGNkX2ZiX3Vw
ZGF0ZV9yYXRlX3Nob3coKSBpbgo+wqDCoMKgIGRyaXZlcnMvaGlkL2hpZC1waWNvbGNkX2ZiLmM6
NDQ2Cj7CoCBpcyBub3QgdXBkYXRlZCBhcyB3ZWxsIGluIHRoaXMgc2FtZSBwYXRjaC4KPsKgIFRo
ZXJlIHNjbnByaW50ZigpIGNhbGxzIHNob3VsZCBiZSByZXBsYWNlZCB3aXRoIHN5c2ZzX2VtaXRf
YXQoKSBjYWxscwo+wqAgYWNjb3JkaW5nIHRvIHRoZSBpbnRlbnQgb2YgdGhpcyBwYXRjaCEKCnNj
bnByaW50ZiBpcyBmaW5lLCBidXQgc25wcmludGYgaXMgV1JPTkcgdXNlZC4Kc2NucHJpbnRmKCkg
cmV0dXJuIHRoZSBudW1iZXIgb2YgYnl0ZXMgcHJpbnRlZCBpbnRvIHRoZSBidWZmZXIuIApzbnBy
aW50ZigpIHJldHVybnMgdGhlIGxlbmd0aCB0aGUgcmVzdWx0aW5nIHN0cmluZy4KCj4KPi0gTm90
IHN1cmUgaWYgdGhlIHBhdGNoIHNob3VsZCBiZSBzcGxpdCBpbnRvIGEgNS1wYXRjaCBzZXJpZXMg
d2l0aCBvbmUKPsKgIHBhdGNoIHBlciBISUQgZHJpdmVyIChlYWNoIGRyaXZlciBjYW4gYmUgdXBk
YXRlZCBpbmRlcGVuZGVudGx5KS4KPgoKSSB3aWxsIGRvIHRoaXMgaW4gVjIuCgpUaGFua3MsCgpR
aW5nCgo+Cj5BY2tlZC1ieTogQnJ1bm8gUHLDqW1vbnQgPGJvbmJvbnNAbGludXgtdnNlcnZlci5v
cmc+Cj7CoCAoZm9yIHBpY29sY2QgY29kZSk=
