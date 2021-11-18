Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800B7455EE6
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 16:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhKRPGs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 10:06:48 -0500
Received: from mail-sn1anam02on2057.outbound.protection.outlook.com ([40.107.96.57]:26950
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229733AbhKRPGr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 Nov 2021 10:06:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDVHsl6hQXT4zStLLYoNMj33W8kBTuMxKhAIgEhZ8T+8pe7yijsS4oQDKE/FQv+PDQhQkIf26Gr3EH2HSLbQpVBMnEwh9kNLlYjdOs+jgpBb8+iP2LssYCL2N5u1DpQb3rYX4EFYBq1+j1FtLJe4cRKPgfQ/H6YZ3Yckh16MbHWQP8A0JNlOFqeowE+zwHVKdPSWTGevVP3hGwOYFuujE0we4iCf4XUf+6gCC2DkNQC+eIhDJATxqigRnwra1iclBRIWfoIBruyCaKGQc6i5vCdA2FRpsQdu61zbG/7CtIorqKNTRRS3RqfIxkPbYQeZiNbJLrqLLiiWhMiDRsypRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Az8WaSV0/fAiQvvF74lHs6EOMNVwO74+rAz/MxEkK0=;
 b=kYJVvHXukoJkHrfIYZwxoAUUYR65lcMlJC62JVV2gzMKOrflIa0d/o1h1nMWf0FImfhnB8ep5yArXMpmjljUZLSAlSjpZrk0ta8IWhodwaQyIVdqC3gk5tVaDxMZN7x0EGllOAnuplV82mnvEfmO5pANBNjNGm3XnkYP9MxNSfrctJVmvL5N1AVd8B62Qk5yU0LYKahJQAayxFFwz+2Zumj6QQJw2Fp1LygjJvpPlNVPd+D7FiMaJ4Q5y5u6MjDZXZAFaBDUccwYs/Eu0cwUjrnOuyZmg1tccPQzI9BIWOMPiXalUjCiYbbxqQapgRtjJ9vXRJnIFb5bQMVvMldv8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Az8WaSV0/fAiQvvF74lHs6EOMNVwO74+rAz/MxEkK0=;
 b=PVKxJWjkSuhhZZFB4hvVji8zWF2D47LU/p/Y0K3/WWxfEoRCJnF3MjfQu0/HlDDMv4hdnodcBjBlsxgzjMCFI1VCAcXn8lkj0KDoLPgteUwfLYkCirB9os26xNHAIW2aRdUOWuuhKQcR7jvoBzp+fV9CAWok91Zl2eRCawLj+SA=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7518.namprd02.prod.outlook.com (2603:10b6:a03:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 15:03:45 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::c8a:dfb7:e411:9ad%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 15:03:45 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, git <git@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v10 0/5] Add Xilinx AMS Driver
Thread-Topic: [PATCH v10 0/5] Add Xilinx AMS Driver
Thread-Index: AQHX282rJrLxcdsHb0Cl6VqY/qGiO6wH9WMAgAFtUfA=
Date:   Thu, 18 Nov 2021 15:03:44 +0000
Message-ID: <BY5PR02MB691686AFC8D0DC41DEE5B493A99B9@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211117161028.11775-1-anand.ashok.dumbre@xilinx.com>
 <CAHp75VdkGHvauZG7Nw4dDEb4+ZeVS4Pt2x05EiOiVCBVv8s10w@mail.gmail.com>
In-Reply-To: <CAHp75VdkGHvauZG7Nw4dDEb4+ZeVS4Pt2x05EiOiVCBVv8s10w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4488741-55c2-4d75-0e00-08d9aaa49de8
x-ms-traffictypediagnostic: SJ0PR02MB7518:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB75188C50A5A0C47218782536A99B9@SJ0PR02MB7518.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZCUCmVX3AcNG8bFJFuCv+vukKm4Q68dpgOZxMtKYwdDus/i/1gd5unwuAlLbJ4CwrDMHpKAvMzwJMWubRvO6KoZwxQnX5tKcDKyO7Uh5fAvZSv4NctSQMA7RWEKK65b62E84pDsjmjkO7qQzMP8ExKWL/zUMwzTCBC7fV4VMDHwA5cvwsQr5Mkl9bmcfnw/QMM/xrz99edhjdnxb9e93ssY9eO5y2tWwIKtCdO38bMm5mpxuYgZy+q4S2xCUX9v+cMwNkqCXJoHT9VKpFIp5uW9PvWPhmqFldAwitlUTklDn5SH527FJuNZfmbrqEVgG6xwAwy10Qp9bCOyuB0uhZbDLAm2LBHNgnJ7t9bwKK4BSZT6ESLaW/QxHubxwE3Jdo2FnitMpufo8vQkCPxX7Q3aqEWPvCGPjyRjHFStDTN/O0lxDxoLUk7q53lTE3paWayfePyo4MetMxct0+C7cuaSb3bPzTRiMCcWv6HiDwlm8vDKUtsPMoQ+rlsnxSVpsJ+bZfJkTqJR4RXjtJ9KHxm5RxZ+dziVVocXww/Pk0HnhXXQycS7Oo/pSQrNzBqLLc+yMF8oVRdVGADEtTykaXJHGW5CdR+fKRcI7iraSlQu6CWbm8bnVcx5ymsVzwLxl1TKO+YiiWriqyhE6FH5ic+NYkgKDeb7lEOVGaYoRyGo+G9FBop1JXXlRIZOafvFPAxgQWYgApCooJ/nWOzt0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(5660300002)(86362001)(4326008)(38100700002)(7416002)(83380400001)(76116006)(9686003)(316002)(55016002)(8676002)(66556008)(7696005)(66446008)(2906002)(53546011)(66476007)(66946007)(122000001)(6506007)(71200400001)(6916009)(38070700005)(508600001)(26005)(186003)(8936002)(54906003)(64756008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkVKOXZWRHlaR0MrUm80UHZTV3Y2L3N4QzN5Q3FFWUVTRnlTT2d1SmVNUTFJ?=
 =?utf-8?B?RjVsWk9pcUVFSnlsVXFLT2tCNmdUK1h2MjdCdXZBY1dZYTdEU0lkNVlSTWtr?=
 =?utf-8?B?SmR1Nnppb28xZUFhMm9IQXhuUkg5T3dUZXlSMTVUZVZqS01LczdDWkwwZUNI?=
 =?utf-8?B?aHA2UmMxS0VlS3hwUjYrWTNqb3ZjK0ZndWRsOGlNM1pNQVQ1emhPM0VsOS9r?=
 =?utf-8?B?T3hJSWdoNkd6MWZmTVZOTjM2N0Q2WUx3MGVEQ21SZmFROXVqaTgzVnFjUmF1?=
 =?utf-8?B?bzRFWWYybDhkMENTZmZBeGlnTjZxbHFOTVVrTmZQZ0RZMG1aM0JHVThYRUNr?=
 =?utf-8?B?Z2pzOFhlQXJxSFRmNkNTdmJkSDk0TWFIWHcxSWhhMG1KdVJhNjEzUWcxMk44?=
 =?utf-8?B?dTNRNWpleGZ3L1pveHQvUFpSRzF1d2FYTk9HUWZsVm1VLytHVitjakk3QUMw?=
 =?utf-8?B?S056cHlxSG5jbkNEb1FDdmpFM1kvL1U2VitSSm1RWGphWTE4VWYyWVU0WUVX?=
 =?utf-8?B?MkpHbWlJZWtRbG90cWViM0hpejFST2ZnMlROV1RHVnRZY3FJZVQyWnFwanAz?=
 =?utf-8?B?Nld4aG92RFBkU3VLc2UrZU0vT2FCWER2dVdJMXNScTk5SjdzNTVKOG5JZUNv?=
 =?utf-8?B?dmN2dWV2cTRFa3Fwb2xhUzlEVTU3eHM0enRqcm5xYWNPV081bzdQUVBMK21H?=
 =?utf-8?B?UjNabml3MnBKQmVhSjFJVnZWWGdyZmIvTHZ0MU1UNTFXWG5mK2lybk82bW5J?=
 =?utf-8?B?VnVmSmw1YkhGSnBqZTdsaHlVbUtqOHRRVVBZa2dzSWk5b0N3MnNEOFlwVVRT?=
 =?utf-8?B?S0JER1kzczZpY2h6cHU3L2VWeGlrSS8yNlIvemdQYzhZNU0wU3YxSis1R25E?=
 =?utf-8?B?Vi8rUElPTkYzZkQ2TTVvaDRrazUzdDJJeDFBZGFNeHJhYTNaalZ4WkVWcWFZ?=
 =?utf-8?B?eitiZ1NzNElsSks5R2MvaVA0alZQbTl6S1MrNE5CS0JkMWIzSm9kb0FXelRQ?=
 =?utf-8?B?clNRcC9FNFg2cUtyZUx3aUJDdmhkcDFkWVIwWXA3R2QySW5FR2s4aWM0U3h3?=
 =?utf-8?B?WVJYMXRpYm5jRW1sMSs5ZTZXOXMvT3dDcEFBU0dzM0JGYTQxOVA4SEtIaERT?=
 =?utf-8?B?RElXOUdBcEx3K0cyd0dzTmpsSXN5em1GSnpFaUtQNnpTNEFrNFJHMTk1SzBN?=
 =?utf-8?B?SXBnWWRyV3dBWmNkcTk2Z2xXRkVWZ0h2ei9oOHh5emRWaE1yNlRBdThLOFE2?=
 =?utf-8?B?cGl4YXlWaUFGMTRXemVaOFk2VEdzYkFVL2F2OENRYTRkVm51ZUtzSnhYTkRZ?=
 =?utf-8?B?VVlrTVBCQXk1M1Zxc0Q2NUtZQm0raWpmR2NzdVdzVUtIMTFHZFQ2cHo5ZnVU?=
 =?utf-8?B?OXZQMVpod1IxbTcxMWdKcHEzYk1mdjZOUEE0emE3ZUpqVjJuVG84Y1BoV1NT?=
 =?utf-8?B?NnowSmp3TEtzYW1vSTdiR0FCY2VWVTVGd0RjTCtqNVdrTGp4M1JZa0ZUQlBn?=
 =?utf-8?B?VmVna1h0dkFmaFJHdTRmYXRMWUJ0K1RzUldMdGI2a2RtSktQeC92amR5blQ2?=
 =?utf-8?B?Rjdibmg0NnU5ZWVmMXAxWG9EeXJSZVA2N2haSDdiMzZRRjdtNXRTR0xsTmZZ?=
 =?utf-8?B?eStSOEF1QkxqRnRSbUVqYXN6d0h1STcxa3lkU1dsWmpTUlEwQllPS05VMEVp?=
 =?utf-8?B?OHM2RW8zSHkzcy9HcTloeDRHTTBRMDRuM2tFWTNnWi8yRUtLL2ZmQmtoRlFk?=
 =?utf-8?B?MHJlbXBNZjl1K0xDY0c2UkZYaFV6OUVEalB4aVRESGgyZ1M5RHY2MFV4aHBS?=
 =?utf-8?B?TjM0MnNwWG1kNm15VVBWZkJiejl4REdyYWNtTG94YVJHRUtCL0pqZm9WWUZC?=
 =?utf-8?B?RmpRdFN5Z082T0w5NXZUcDNFZzQydlJiOFZMTGZaTFphZWxHeEZKczI2TXF0?=
 =?utf-8?B?NklGRmVReE9HdHVxRjZyZk9EZXdSMHZSMzdiWnRRKzZaSklYNjhSclIxSDVq?=
 =?utf-8?B?OFkvbDlpc1NWS3EydWdXK3ZqdzlKZHNpRzI5ZGpIbkVwRXZuTEgzY1hmVnpa?=
 =?utf-8?B?L1cycUZCcStpR1BDZkdOcWNlcG40WGZrdGFHZHpuOVlFdmEvZ2FPR1kyd0ZZ?=
 =?utf-8?B?YTArT2hFN2RwaDByaGpCNUVtdXlVSEtDejVDMmVXT3Y2bUhLbFFiSTFTeGJa?=
 =?utf-8?Q?0yPn31AIiSX25kJtRhfFWCg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4488741-55c2-4d75-0e00-08d9aaa49de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 15:03:44.8662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAzFduUziTk67WmAL0L7yONcwwxbWNvWpR2RGR1agrzZXP7N3QMc16jeSZ+tFOFTr9AkjZyI4A+IYnkHwX9nTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7518
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWls
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5IDE3IE5vdmVtYmVyIDIwMjEgNToxNCBQTQ0KPiBUbzog
QW5hbmQgQXNob2sgRHVtYnJlIDxBTkFOREFTSEB4aWxpbnguY29tPg0KPiBDYzogTGludXggS2Vy
bmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEpvbmF0aGFu
DQo+IENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+OyBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNA
bWV0YWZvby5kZT47IGxpbnV4LQ0KPiBpaW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBn
aXQgPGdpdEB4aWxpbnguY29tPjsgTWljaGFsIFNpbWVrDQo+IDxtaWNoYWxzQHhpbGlueC5jb20+
OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPjsNCj4gUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgQUNQSSBEZXZlbCBNYWxpbmcgTGlz
dCA8bGludXgtDQo+IGFjcGlAdmdlci5rZXJuZWwub3JnPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxh
bmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBLcm9nZXJ1cywgSGVpa2tpDQo+IDxo
ZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYx
MCAwLzVdIEFkZCBYaWxpbnggQU1TIERyaXZlcg0KPiANCj4gT24gV2VkLCBOb3YgMTcsIDIwMjEg
YXQgNjo0NiBQTSBBbmFuZCBBc2hvayBEdW1icmUNCj4gPGFuYW5kLmFzaG9rLmR1bWJyZUB4aWxp
bnguY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBYaWxpbnggQU1TIGRyaXZlciB3aGljaCBpcyB1
c2VkIGZvciBYaWxpbngncyBaeW5xTVAgQU1TIGNvbnRyb2xsZXIuDQo+ID4gVGhpcyBBTVMgZHJp
dmVyIGlzIHVzZWQgdG8gcmVwb3J0IHZhcmlvdXMgaW50ZXJmYWNlIHZvbHRhZ2VzIGFuZA0KPiA+
IHRlbXBlcmF0dXJlcyBhY3Jvc3MgdGhlIHN5c3RlbS4NCj4gPiBUaGlzIGRyaXZlciB3aWxsIGJl
IHVzZWQgYnkgaWlvLWh3bW9uIHRvIHJlcHBvcnQgdm9sdGFnZXMgYW5kDQo+ID4gdGVtcGVyYXR1
cmVzIGFjcm9zcyB0aGUgc3lzdGVtIGJ5IHVzaW5nIHZhcmlvdXMgY2hhbm5lbCBpbnRlcmZhY2Vz
Lg0KPiA+IFRoaXMgZHJpdmVyIGhhbmRsZXMgQU1TIG1vZHVsZSBpbmNsdWRpbmcgUFMtU3lzbW9u
ICYgUEwtU3lzbW9uLiBUaGUNCj4gPiBiaW5kaW5nIGRvY3VtZW50YXRpb24gaXMgYWRkZWQgZm9y
IHVuZGVyc3RhbmRpbmcgb2YgQU1TLCBQUywgUEwgU3lzbW9uDQo+IENoYW5uZWxzLg0KPiANCj4g
VGhhbmtzIGFuZCB3YWl0IGEgYml0LCBwbGVhc2UuIE5vIG5lZWQgdG8gc2VuZCBwYXRjaGVzIHNv
IG9mdGVuLiBXZSBoYXZlbid0DQo+IHNldHRsZWQgZG93biB5ZXQgb24gdjkuIEhlcmUgeW91IGVm
ZmVjdGl2ZWx5IGlnbm9yZWQgbXkgY29tbWVudCBnaXZlbg0KPiBhZ2FpbiBwYXRjaCA1LzUuIFdo
eT8NCj4gDQoNCkFwb2xvZ2llcyBmb3Igc2VuZGluZyBwYXRjaCB0b28gc29vbi4gSSBzZW50IHRo
ZSBwYXRjaCBiZWZvcmUgSSBzYXcgeW91ciByZXNwb25zZS4NCg0KPiAuLi4NCj4gDQo+ID4gQ2hh
bmdlcyBpbiB2MTA6DQo+ID4gICAgICAgICAtIEZpeGVkIGxpY2VuY2UgaW4genlucW1wLmR0c2ku
DQo+ID4gICAgICAgICAtIENoYW5nZWQgdGhlIG1hY3JvcyB0byB1c2UgQklUKCkuDQo+ID4gICAg
ICAgICAtIFJlYWxpZ24gc29tZSBjb2RlIHRvIGZpdCB3aXRoaW4gMTAwIGNoYXJzLg0KPiA+ICAg
ICAgICAgLSBNb2RpZmllZCByZWFkbF9wb2xsX3RpbWVvdXQgdXNhZ2UuDQo+IA0KPiA+ICAgICAg
ICAgLSBVc2FnZSBvZiBhcnJheV9zaXplKCkgaW5zdGVhZCBvZiBjaGVja19tdWxfb3ZlcmZsb3co
KS4NCj4gDQo+IFdoeT8gSSBoYXZlIGFza2VkIHlvdSB3aHkgeW91IGhhdmVuJ3QgdXNlZCBrY2Fs
bG9jIHRoZXJlIGFzIHdlbGwuDQoNClllcywgSSBzYXcgdGhlIGltcGxlbWVudGF0aW9uIG9mIGtj
YWxsb2MgYWZ0ZXIgcmVhZGluZyB5b3VyIGNvbW1lbnQgYW5kDQpJdCBkb2VzIGNoZWNrX211bF9v
dmVyZmxvdyBpbnRlcm5hbGx5IHNvIHRoaXMgaXMgbm90IG5lZWRlZC4NCg0KSSB3aWxsIHdhaXQg
YSBjb3VwbGUgb2YgZGF5cyBiZWZvcmUgc2VuZGluZyBuZXcgcGF0Y2hlcy4NCg0KPiANCj4gPiAg
ICAgICAgIC0gVXNhZ2Ugb2YgZGV2X2Vycl9wcm9iZSgpIGluc3RlYWQgb2YgZGV2X2VycigpLg0K
PiA+ICAgICAgICAgLSBVc2FnZSBvZiBrY2FsbG9jIGluc3RlYWQgb2Yga3phbGxvYygpDQo+IA0K
PiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQoNClRoYW5rcywN
CkFuYW5kDQo=
