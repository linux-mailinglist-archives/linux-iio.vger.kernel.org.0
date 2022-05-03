Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312A2517DFC
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 08:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiECHCr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiECHCq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 03:02:46 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE5438BD0;
        Mon,  2 May 2022 23:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tf+HuHezGubxxIxY/hkVpKGgjVQAwq5gcyzXMKhCfw11uT90zKdsrAmhet1ikaZ/3oEOxy0WzkImiIg187WRPhG/3G7rEtqsNKWVAa6BdnkyDG9Kz+bcbz0MbWglImrCfA/Fv+7KAbzpuS9vKltt4GCs2hmcNveVFinNa46oHf7K8h8PtMwBsnzvuYLFLBb3MtTQeY580hTEvqJ0qtpkhAq5qmhA65ym0XeZyzMjYskEdqaQNeQ61xnzTn3UAmaVBQ3nfDqixMxJI2Rd56PctpZAd7QCeehFMZ9ut2iGQG5qQd1Nw8OwyR6t7CBxGet0HgvXwxc4sevnYdMGRiWxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LltZ0ontMaPzWUcJHZ66gHZOKvvh4+o+wBt+t5JzQpc=;
 b=egetA+KDunuInyw4/SExuFk/BntJsRemvhX9do3CuGcLn9PQ7cRyns01gLmOaN2r60SGhPP585mOVojFkriKOrkSka8Cic+dKQQW5Zp4RHUhsyieHfMcAwcokYsuYYSaYh2TjE4f+0H0QnsN7hMj1kWbicTygzxwyazRxTjk6kgJjFDPzvOC53FORWY6SwoNuQ+QH37PM2Coy/HT5U5mbksxusy20aThyCFNdeTs5dU9P4L93xC//3upRAnzoCNbBLj5+Kb/7kFt3KaxnkoaBMI9Dr6DxK3sXgxqQEtYDuSpu02Vq26y7qKgIzBPziryL+jq/QgHSlmYY/75kA3osg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LltZ0ontMaPzWUcJHZ66gHZOKvvh4+o+wBt+t5JzQpc=;
 b=tbUmfhjzlzBiv1dfv7bpLuuhRThkAPxekrfwi9M0GJxMcPL4/YJ7vs3tCeuG3+RyYcB7oN5LOq1yaebhcwreDReayPOBPcYvVBMwRRxtZM75sn++kesaNK9ROoTe2hWTlh+MtW7yzYGA+x9vY+G505ezkJKixLDwLpRrOc4GZio=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB4196.jpnprd01.prod.outlook.com (2603:1096:604:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 06:59:12 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%7]) with mapi id 15.20.5206.014; Tue, 3 May 2022
 06:59:12 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: RE: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Topic: [PATCH] iio: adc: rzg2l_adc: Add support for RZ/G2UL ADC
Thread-Index: AQHYXTOfwzcIy4H/ukmJ0Fyg702b460K+rcAgAAijpCAAIpCgIABDTkAgAAEuoCAAAIJ8A==
Date:   Tue, 3 May 2022 06:59:11 +0000
Message-ID: <OS0PR01MB592219C54636270A24F1F0C386C09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220501081523.22479-1-biju.das.jz@bp.renesas.com>
 <OSZPR01MB7019299D00A457C964CC403DAAC19@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922CCDFA8C3648F49A10EB186C19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHemJn2KUBzYA8oVYgtG4sX2H=4-AdRuF0uZ2EgQEk6w@mail.gmail.com>
 <OSZPR01MB701947B40187981ACE6A271DAAC09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <CAMuHMdWuA806Hbcw1Yw972ApKB+Jp8M5DYu-zdLenB564H4zFA@mail.gmail.com>
In-Reply-To: <CAMuHMdWuA806Hbcw1Yw972ApKB+Jp8M5DYu-zdLenB564H4zFA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e19a9d31-6a96-40f2-c3e6-08da2cd26dae
x-ms-traffictypediagnostic: OSAPR01MB4196:EE_
x-microsoft-antispam-prvs: <OSAPR01MB4196FBF8ED48DCFA5D27620A86C09@OSAPR01MB4196.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrNGD4Ru6d/cHMVRN2qy84AJF9wr02rPTgd6ZnmvbylDVj2KNedkbL9qfNc0fOAc3Gbz6KG2NYC/sa5doah7y6fzls6bXDnl4kdqU1hwit9gg6vbUl3geUszjTdbCjTOrWAmH9vZwo5wY5D4WhBifC4WaJIAxa7lCocP5VOvNrLeQX1vJQYqYlJ5YR6fgS7Jr4xDwAUSpd0mzH3eNgubJt6x3qyKbAph0df3SlW1TG+En6WVXFLq3a/kbLCNMW4/iVlMMt7y/0US1X1shMMl9OBC9IVsxa67GuhpoAAh1sW0t6uDh0nA9rQFexdVFqRbyHErR36b2wLTEOHatptWEyYLhWkTk/WQ3WHb6NJeIGXp3c7UMj+2qvMiB3vC928LiHuyQw8fv4NH0rdNFQbj5wz4xsOZhIZMZqXqVuu5JhKhHWCcycnIFtcA/oV1a2Kjr/K+extUvpBc/lim6pbP1w1Q3SbqRTbc0rKQ+FXX8gF1rmNlgBOyHLFRQvFnLem6FAhHyOuP+LfRc8jYA/SaM5fauhvYf2Zx86V2i1xM7H2/RUiPGNPOtq5t4eRWQ1s6Kt7I4JTkxMv3sdMCSfT0hlBS5BhuRBGqtoyo2YUltqTB3P67PtwEYYSMnfU3LojvDLVITi3xPOeEnTtNmymuQpLKYlSWZ6GW1trCZofNEm8ylP7JB+hw67D1qSN8WndJOny004s6M3XdQ1cY+IkwAsNOBuSHS3s6vD5Ms3NaZ0Z3eKcMwwVhE8O1fvn9gLyt0RIN1pDjPB8TifN6ncAbGjP4IMaVvzv9rRxcLk0ucTms4xvlxuTgB2MkqYODc4VpBRH1BUbpjEr+9Kxdo3GU4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(52536014)(8936002)(53546011)(6506007)(26005)(9686003)(110136005)(71200400001)(316002)(966005)(5660300002)(6636002)(508600001)(66476007)(66556008)(86362001)(66946007)(122000001)(8676002)(7696005)(38070700005)(4326008)(66446008)(38100700002)(64756008)(107886003)(76116006)(186003)(83380400001)(55016003)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2dCSXk0SElQdnRoZ09aUUV0NFBmZ05VMml6YWhNcW9yRUhWaXk1R3VndFlH?=
 =?utf-8?B?TVRqSnJOSnFOZGNBSmJUZ2FnS0JNeC93T0lISUd2SUxlZ2FFU0k1dW5lZ3F4?=
 =?utf-8?B?NGRsLzNjSFJCSE1rY2NKTHh1dVVaUlFGc1ZZZzhSNVVNdFRWOXMyT1dLYXBR?=
 =?utf-8?B?QUJVVEphckI5K2hxN1RaSHFmL3UrRWlXMzZvNDY4OHRWUEVub3FzcjJvbnNk?=
 =?utf-8?B?cVdiWFFDbzUxeW5qRFk1M3NtanlOSGZWdWJuOURNNm5aOUUrQWZHNENOQU54?=
 =?utf-8?B?ZWdIVERFZm4vb1ROd1p2dDZzOU1iK2o5Ni9vSEYvN2J4YzZiTS9raWlhM2to?=
 =?utf-8?B?Wjl4SE1IY3NwVW9TN0oxVm1BLzdRV2JHMSszSU5tRkhnRStpYlpmWVdNdXc4?=
 =?utf-8?B?V1VqNjJ0Z2ZoKzZiWnJRdkw4Z3BPaEM1ZlFoL292NHJnRjBWRjh6U281SHRv?=
 =?utf-8?B?c1Vhdy8xdUZoSmlSZWNNVmpqMlphKzZZckZDajIvY0RBQUJxYjFYaG4yOWk5?=
 =?utf-8?B?dEtYbUdoOS9qa0pmc291b1pXSVpSL0VsZjVEZXZVVzlGakNPUzhhcGVETVVC?=
 =?utf-8?B?NC9vWXNLOExKcTRpWjlUUVZCaGJKcVVjTjEvTVBqenBMWjN4aVl3ZU10SmEr?=
 =?utf-8?B?TUJRbnRaWkRVR0h6dGIybXpUcjEzcDZySTRBY1pieXpZdU1kNmgxT3lHcUJi?=
 =?utf-8?B?dWhhYnN3aDRBZmdITW5BdmFEVGhsSTE1Nmg3cUIwb0VVclZZY1ZRVHNFSnVC?=
 =?utf-8?B?S3hDQTQrcHRoQitDR09yOEh6Nm1Ga0dETlVYNkNqK1ZOOWVLYXhDTHN6WkJl?=
 =?utf-8?B?RVIzRkYvU0Z1ZklXQXdoa3l1N3AxUWdTamIzbnNES1BsclRveE5vYXl5b3Ax?=
 =?utf-8?B?R0dVOU5hTUF5SEtMZWRLSmV5bm9aUU1lU3QyNmdoTGtHTU9FZ3ByVWhKSFR2?=
 =?utf-8?B?RWd0T2t3dXljMkt4Y2RyNnNqcW00MFQyZUhBd2IvRXhQOWVKNzBZYnowODR1?=
 =?utf-8?B?UGdOWGRKaG1NNkRXd3NuM0lObkZ1WFIvRGRoRXM4RTl3dUovb2hTVnk1NnFX?=
 =?utf-8?B?THdrNGh3cERiL3BqT3NGYjJGUE5RclUvQk0zdHNnWmRxSnNlWFJZRG1BaE5i?=
 =?utf-8?B?RGlsSHNRbGdaVVgyTVR2YU9oZkNSWERVU2YzaEpORkhOOFNVMFRMNXo2MGx5?=
 =?utf-8?B?WE9nSTNwTFNhU2hiYXJpNSt6ZFA1OGFmWU5jVEFpZVpwL1RCUzZkMlRjQlhW?=
 =?utf-8?B?eGdaNkRUWHlmM1p6dytKWXRMK1phaElUQkFsaUZmUnVSYUY0ZEtYa2RRNWs4?=
 =?utf-8?B?TjUxT1AyZUVaaDFEcnZZcWx1cnczUitORVJLcUdqdnA1VUF3Z1RMKzhlWTRw?=
 =?utf-8?B?YlJPK25qeFp0M05mVDl3K3oyTVBOeDNRSEJvMXJnZlJzMzhLK2RWaDI5M25E?=
 =?utf-8?B?MlNrY1RWdndjM1pzdElCaDAwS21YSjFwNXdpQ3pjVVErQUp0T0JUMnFMRzBN?=
 =?utf-8?B?b0hyRDR1ODM1aUx4NjhTZkRiNGtZbkpkWTVCM2VneXNvVEtTeTFkVk85b1Fa?=
 =?utf-8?B?MUJDaE1xaU9JVjhFU2o3RnJ3TmlBbW5uczBoUFRFZFVHWU9KYllsMDh4Y3ZN?=
 =?utf-8?B?K3ExNVZpTXZJeGFXcmR5ZGVERUJBd2NsV2RIQ1JyTEdzSHdndTVoSVkrbG52?=
 =?utf-8?B?QkxLQ29EaFBLMmFHeXhZbzVCdVNQaXhKVEp2em1Zem1ZUVR1RkwyZzFtOTFN?=
 =?utf-8?B?M3AwaGpvQWpEQTVqL1FzaXphbWhkYVF5U0VmQjRSakJ2WjhCOEsyZzZZWjZs?=
 =?utf-8?B?aVowTEUyamdOTWdQNzk1VnNLTWtlaFdXZUFYTmFCVkhpdm1NU3hxaThIRDZi?=
 =?utf-8?B?QlcwSjdLRzlGd3dmUUJxR0RBcFkyMmRkcXd4RzFyalpTL3RMRlVHMW5NTEZZ?=
 =?utf-8?B?TTh5QjdRaFBidVAzZGNVZXpVemRnRXhjZE5jSUM0RVpaVm1NY2hVa2YvZE9G?=
 =?utf-8?B?djZ3TlFFTVo2b3J2T2JCdXNuQ0VLUENrNzlVb3pJZ2hYVXBJaVdVdHZXOGdZ?=
 =?utf-8?B?V053OWdWMUlJT3hubm5LMkhvQUV5bEZuemg1OGpMY1RYZlFuQkxtdmI4VHdr?=
 =?utf-8?B?enRtUWY2ZWk5UnVydzhSQUIrekFlM2FzTU5KTS9maUcxTzZ3SFd0M0ZocnhF?=
 =?utf-8?B?WjZ0M3I2R2pzQnZFOXB0QlVNMGMrZ0tnRUdCMWx3T3pBRlhzb0JFY0hzY3Yr?=
 =?utf-8?B?THdjNUpyVE1ISVBIQ1Q0cFdManRnejdwR09DY1RDOEJLbnZnYW03L3BIYXg0?=
 =?utf-8?B?WjRjWnVVWVNIL2t4SmlVODRDa2I0LzdwUU4xMnJDQ0tHMUNrdmZYdUNSbE5M?=
 =?utf-8?Q?qXdMCdPUrt/dIyx0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19a9d31-6a96-40f2-c3e6-08da2cd26dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2022 06:59:11.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHdhve5OGOm2WlnPY/LV4bkM0kDmcsM3/5ZPpovVCTiwngxeM7Zzklztvw+XOUvwkH4mkYhZFxVfbdoG2DpCLRKm90kxeKRO/qHu+PzMW5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gPENocmlzLlBhdGVyc29uMkByZW5lc2FzLmNvbT47IEJpanUgRGFzIDxi
aWp1LmRhc0BicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaWlvOiBhZGM6
IHJ6ZzJsX2FkYzogQWRkIHN1cHBvcnQgZm9yIFJaL0cyVUwgQURDDQo+IA0KPiBIaSBQcmFiaGFr
YXIsDQo+IA0KPiBPbiBUdWUsIE1heSAzLCAyMDIyIGF0IDg6MzIgQU0gUHJhYmhha2FyIE1haGFk
ZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi0NCj4gbGFkLnJqQGJwLnJlbmVzYXMuY29tPiB3cm90
ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBHZWVydCBV
eXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiA+ID4gU2VudDogMDIgTWF5IDIw
MjIgMTU6MjkNCj4gPiA+IFRvOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+
DQo+ID4gPiBDYzogUHJhYmhha2FyIE1haGFkZXYgTGFkIDxwcmFiaGFrYXIubWFoYWRldi1sYWQu
cmpAYnAucmVuZXNhcy5jb20+Ow0KPiA+ID4gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVs
Lm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbg0KPiA+ID4gPGxhcnNAbWV0YWZvby5kZT47IGxpbnV4
LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1yZW5lc2FzLXNvY0B2Z2VyLmtlcm5l
bC5vcmc7IENocmlzIFBhdGVyc29uDQo+ID4gPiA8Q2hyaXMuUGF0ZXJzb24yQHJlbmVzYXMuY29t
PjsgQmlqdSBEYXMgPGJpanUuZGFzQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6
IFtQQVRDSF0gaWlvOiBhZGM6IHJ6ZzJsX2FkYzogQWRkIHN1cHBvcnQgZm9yIFJaL0cyVUwNCj4g
PiA+IEFEQw0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgTWF5IDIsIDIwMjIgYXQgODoxOCBBTSBCaWp1
IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4g
PiBTdWJqZWN0OiBSRTogW1BBVENIXSBpaW86IGFkYzogcnpnMmxfYWRjOiBBZGQgc3VwcG9ydCBm
b3INCj4gPiA+ID4gPiBSWi9HMlVMIEFEQw0KPiA+ID4gPiA+ID4gU3ViamVjdDogW1BBVENIXSBp
aW86IGFkYzogcnpnMmxfYWRjOiBBZGQgc3VwcG9ydCBmb3IgUlovRzJVTA0KPiA+ID4gPiA+ID4g
QURDDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQURDIGZvdW5kIG9uIFJaL0cyVUwgU29DIGlz
IGFsbW9zdCBpZGVudGljYWwgdG8gUlovRzJMIFNvQywNCj4gPiA+ID4gPiA+IGJ1dCBSWi9HMlVM
IGhhcyAyIGFuYWxvZyBpbnB1dCBjaGFubmVscyBjb21wYXJlZCB0byA4IGNoYW5uZWxzDQo+ID4g
PiA+ID4gPiBvbg0KPiA+ID4gUlovRzJMLg0KPiA+ID4gPiA+ID4gVGhlcmVmb3JlLCBhZGRlZCBh
IG5ldyBjb21wYXRpYmxlIHRvIGhhbmRsZSB0aGlzIGRpZmZlcmVuY2UuDQo+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9paW8vYWRjL3J6
ZzJsX2FkYy5jIHwgMTggKysrKysrKysrKysrKy0tLS0tDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+IEkgd29uZGVyIGlmIHRoaXMgY2hhbmdlcyBpcyByZWFsbHkgcmVxdWlyZWQuIFJaL0cy
VUwgY2FuIHN0aWxsDQo+ID4gPiA+ID4gdXNlIHRoZSAicmVuZXNhcyxyemcybC1hZGMiLiBBcyB0
aGUgZHJpdmVyIHBvcHVsYXRlcyB0aGUNCj4gPiA+ID4gPiBjaGFubmVscyBkZXBlbmRpbmcgdGhl
IG51bWJlciBvZiBlbGVtZW50cyBpbiB0aGUgYXJyYXkgcGFzc2VkIGluDQo+ID4gPiA+ID4gdGhl
IERUUyBhbmQgbm90IGFsd2F5cyA4IGNoYW5uZWxzLiBGb3IgZXhhbXBsZSBvbiBSZW5lc2FzIFNN
QVJDDQo+ID4gPiA+ID4gRVZLIG9ubHkgZm91ciBjaGFubmVscyBhcmUgcG9wdWxhdGVkLg0KPiA+
ID4gPg0KPiA+ID4gPiBGb3IgbWUgdGhhdCByZXN0cmljdGlvbiBpcyBjb21pbmcgZnJvbSBib2Fy
ZCBkZXNpZ24sIGFzIFNvQyBpcw0KPiA+ID4gPiBjYXBhYmxlIG9mIGhhbmRsaW5nIDggY2hhbm5l
bHMsIEJ1dCBib2FyZCBkZXNpZ24gYWxsb3dzIG9ubHkgNC4NCj4gPiA+ID4NCj4gPiA+ID4gQnV0
IG9uIFJaL0cyVUwgU29DLCBpdCBpcyBjYXBhYmxlIG9mIGhhbmRsaW5nIG9ubHkgMiBjaGFubmVs
cy4NCj4gPiA+ID4gT3RoZXINCj4gPiA+IGNoYW5uZWxzIGFyZSBpbnZhbGlkIGZvciBSWi9HMlVM
IFNvQy4NCj4gPiA+ID4NCj4gPiA+ID4gVGhhdCBpcyB0aGUgZGlmZmVyZW5jZS4NCj4gPiA+ID4N
Cj4gPiA+ID4gPiBXaXRoIHRoaXMgd2UgZG9uJ3QgaGF2ZSB0byBkaWZmZXJlbnRpYXRlIFJaL0cy
VUwgU29DIGlmIGp1c3QgYWRkDQo+ID4gPiA+ID4gdHdvIGNoYW5uZWwgZW50cmllcyBpbiB0aGUg
U29DIERUU0kgYW5kIHRoZSBkcml2ZXIgd2lsbCBqdXN0DQo+ID4gPiA+ID4gY3JlYXRlIHR3byBj
aGFubmVscy4NCj4gPiA+ID4NCj4gPiA+ID4gPiBAR2VlcnQgLSB5b3VyIHRob3VnaHRzIG9uIHRo
aXMuDQo+ID4gPg0KPiA+ID4gSXQgZGVwZW5kcyBvbiB0aGUgbWVhbmluZyBvZiB0aGUgY2hhbm5l
bCBzdWJub2RlczogZG8gdGhleSBpbmRpY2F0ZQ0KPiA+ID4gKGEpIHRoZSBudW1iZXIgb2YgY2hh
bm5lbHMgcHJlc2VudCBvbiB0aGUgU29DLCBvciAoYikgdGhlIG51bWJlciBvZg0KPiA+ID4gY2hh
bm5lbHMgdXNlZCBvbiB0aGUgYm9hcmQ/ICBUaGUgRFQgYmluZGluZ3MgYXJlIG5vdCBjbGVhciBh
Ym91dCB0aGF0Lg0KPiA+ID4NCj4gPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEw
N2cwNDQuZHRzaSBsaXN0cyBhbGwgY2hhbm5lbHMgYW5kDQo+ID4gPiBkb2Vzbid0IGtlZXAgYW55
IGRpc2FibGVkLCB3aGljaCBzdWdnZXN0cyAoYSkuDQo+ID4gPiBhcmNoL2FybTY0L2Jvb3QvZHRz
L3JlbmVzYXMvcnpnMmwtc21hcmMtc29tLmR0c2kgZG9lcyByZW1vdmUgdW51c2VkDQo+ID4gPiBj
aGFubmVscywgd2hpY2ggc3VnZ2VzdHMgKGIpLg0KPiA+ID4NCj4gPiBZZXAgaXRzIChiKSwgc2lu
Y2UgdGhlIFNvQyBjYW4gc3VwcG9ydCA4IGNoYW5uZWxzIHRoZSBSWi9HMkwgU29DIERUU0kNCj4g
aGFzIDggZW50cmllcywgSWYgdGhlcmUgY29tZXMgYSBuZXcgRVZLIGJhc2VkIG9uIFJaL1JaL0cy
TCBTT0Mgc3VwcG9ydGluZw0KPiBhbGwgdGhlIGNoYW5uZWxzIHNvIHRoaXMgaG9sZHMgZ29vZC4N
Cj4gPg0KPiA+ID4gSXMgdGhlcmUgYW55IChwZXJoYXBzIHBlcmZvcm1hbmNlPykgcmVhc29uIHdl
IGNhbid0IGp1c3QgdXNlIHRoZQ0KPiA+ID4gbnVtYmVyIG9mIGNoYW5uZWxzIHByZXNlbnQgaW4g
RFQ/ICJtYWtlIGR0YnNfY2hlY2siIGNhbiBzdGlsbA0KPiA+ID4gdmFsaWRhdGUgdGhpcyBhZ2Fp
bnN0IHRoZSBTb0Mtc3BlY2lmaWMgY29tcGF0aWJsZSB2YWx1ZS4NCj4gPiA+DQo+ID4gTm9wZSBw
ZXJmb3JtYW5jZSBpc3N1ZXMuIFRoYXQgaXMgd2hhdCB0aGUgY29kZSBkb2VzIFswXSwgSXQgY291
bnRzIHRoZQ0KPiBudW1iZXIgb2YgYXZhaWxhYmxlIGNoYW5uZWxzIGluIERUUyBhbmQgZGVwZW5k
aW5nIG9uIHRoZSBjb3VudCBpdA0KPiBwb3B1bGF0ZXMgdGhlIEFEQyBjaGFubmVscy4gU28gZm9y
IFJaL0cyVUwgaWYgd2UganVzdCBhZGQgdHdvIGNoYW5uZWxzIGluDQo+IHRoZSBTb0MgRFRTSSB0
aGlzIGhvbGRzIGdvb2QgYW5kIHRoZSBkcml2ZXIgc2hhbGwgcG9wdWxhdGUgb25seSB0d28NCj4g
Y2hhbm5lbHMuIEFuZCBhcyB5b3Ugc2FpZCB0aGUgdmFsaWRhdGlvbiBmb3IgdGhlIFJaL0cyVUwg
U29DIGZvciBqdXN0IHR3bw0KPiBjaGFubmVscyB3aWxsIGJlIGRvbmUgYnkgbWFrZSBkdGJzX2No
ZWNrIGFuZCBpbiB0aGUgZHJpdmVyIHRoZSBjb25kaXRpb24NCj4gc3RpbGwgaG9sZHMgZ29vZCAy
IDwgOC4NCj4gPg0KPiA+ID4gRG8gd2UgbmVlZCB0byBrbm93IGF0IHJ1bnRpbWUgYm90aCB0aGUg
bnVtYmVyIG9mIGNoYW5uZWxzIHBoeXNpY2FsbHkNCj4gPiA+IHByZXNlbnQgYW5kIHRoZSBudW1i
ZXIgb2YgY2hhbm5lbHMgdXNlZD8gIElmIHllcywgd2UgZWl0aGVyIG5lZWQgdG8NCj4gPiA+IHVz
ZSB0aGUgU29DLXNwZWNpZmljIGNvbXBhdGlibGUgdmFsdWUsIG9yIGFkZCBhIG51bS1jaGFubmVs
cyBwcm9wZXJ0eS4NCj4gPiA+DQo+ID4gQXQgcnVudGltZSB3ZSBqdXN0IG5lZWQgdG8ga25vdyB0
aGUgbnVtYmVyIG9mIGNoYW5uZWxzIHVzZWQgb24gdGhlDQo+IGJvYXJkLg0KPiANCj4gVGhlbiBJ
IHRoaW5rIHRoZSBkcml2ZXIgY2FuIGp1c3QgbWF0Y2ggYWdhaW5zdCB0aGUgZmFtaWx5LXNwZWNp
ZmljDQo+IGNvbXBhdGlibGUgdmFsdWUsIHdoaWxlICJtYWtlIGR0YnNfY2hlY2siIGNhbiB1c2Ug
dGhlIFNvQy1zcGVjaWZpYw0KPiBjb21wYXRpYmxlIHZhbHVlIHRvIHZhbGlkYXRlIHRoZSBudW1i
ZXIgb2YgY2hhbm5lbHMuDQoNCg0KSnVzdCB3YW50ZWQgdG8gY29uZmlybSwgY3VycmVudGx5IGRy
aXZlciB2YWxpZGF0aW9uIG9ubHkgaG9sZHMgZ29vZCBmb3IgUlovRzJMIFNvQy4gU28gd2Ugd2Fu
dCB0byBrZWVwIGFzIGl0IGlzLg0KQXMgUlovRzJVTCBpcyBhIHZhcmlhbnQgb2YgUlovRzJMIHdp
dGggbGVzc2VyIG51bWJlciBjaGFubmVscy4NCg0KU2VlIFsxXSwgWzJdLCBbM10gYW5kIFs0XQ0K
DQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmM/aD12NS4xOC1yYzUj
bjMyNA0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmM/aD12NS4x
OC1yYzUjbjM0MA0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2lpby9hZGMvcnpnMmxfYWRjLmM/
aD12NS4xOC1yYzUjbjI2Mw0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL2lpby9hZGMvcnpnMmxf
YWRjLmM/aD12NS4xOC1yYzUjbjI5Mw0KDQpSZWdhcmRzLA0KQmlqdQ0K
