Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1977B3CF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Aug 2023 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHNITQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Aug 2023 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjHNITG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Aug 2023 04:19:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2104.outbound.protection.outlook.com [40.107.114.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944B8E60;
        Mon, 14 Aug 2023 01:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW0zgjXX+Lf/h8IIlrcCpZL2X+ma6cts+ToVfrueR4aYUO/j/PFEMKqmPcUjpOCrHoPCob+Lfd9BwSnINFJ269Q6WXXOF7uEfSgPDFqJ05LS+oovZfQPmYBYbus92aJMneJdhPNeDsnSj0RJ+kZflC701SPEzXT33sQwjNZfIzYNlvXQZ+47eEDN1Y89kS4iLomG/02jonDnxVdkhqKEB/cw8ukTf/EFYMgRH8Ry/fIKZE/DnrR+ZN7+lraCs0cTVexNV59TV3K9j/ckufGEUlafsSkMKVbu2RfCDcLhjILmn8qeAowAz5rxNavNo+bdcWu6gK0xmNjVMoEZVFekTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Oh3c4+U/4OUctYVF1hs7h/0VRTn1VpsBPJZ5OEvHQM=;
 b=dtiP7Azp6RZi/zUy76tZ/VOF7DAH0r5oAaPw5E9qtKHe7u0WnPdTy0YvtOXiMoxoeIOaUzN4YCUq0bmDuXTSvApbVS16i7vzuO5v5X4ndvabI1bnEiwqw9izLvCclMJiVQEkKuTzUqjJRMk0Uh2lRQB4qKW0YsSNbCu/hDJjf3KZMdtn7mTeprnjFfr1L8ooGkl2jh2A+SzGdvunc0ZI90U6YKM5NLuTaHY+GaLdjenTSjLBcITHh+QxR+yr2+IGEx69+50mRJxG7ELxbJs0HuhVNB0QU/WI7w6JqrYDlwKQi/m6aU8AedUi7YhyDDJifq/Cd0cHCf9iCfEkNh3I8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Oh3c4+U/4OUctYVF1hs7h/0VRTn1VpsBPJZ5OEvHQM=;
 b=XTFtQ9eVaIQ3D5IAjraj5YHy7PIXgDJWJ9BPrQQdadg7dT5F0i4QmmsuEHzCfkSgdMhX8n6Zb7ZJk5A8mvEbs2NLZHEwsmFeedLscXNH64saKZ890f5iWyPILiz+UiZk2b346bLFkLJW8e3LJhoDVoalEsNEpqC2We0BfViztdY=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10176.jpnprd01.prod.outlook.com (2603:1096:400:1e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 08:18:53 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:18:53 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Marek Vasut <marex@denx.de>, Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Crt Mori <cmo@melexis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] iio: dac: mcp4725: Replace variable 'id' from struct
 mcp4725_data
Thread-Topic: [PATCH 1/2] iio: dac: mcp4725: Replace variable 'id' from struct
 mcp4725_data
Thread-Index: AQHZzRPSIuZHHgEaWUqKrVOeLZqEaa/m1yAAgAKd9VA=
Date:   Mon, 14 Aug 2023 08:18:53 +0000
Message-ID: <OS0PR01MB5922444B592EA596CFDE4BB08617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230812115449.89942-1-biju.das.jz@bp.renesas.com>
 <20230812115449.89942-2-biju.das.jz@bp.renesas.com>
 <9545092d-fd45-6122-d2d6-4d390031f85f@denx.de>
In-Reply-To: <9545092d-fd45-6122-d2d6-4d390031f85f@denx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10176:EE_
x-ms-office365-filtering-correlation-id: 8a7ff0c7-08e2-4430-6cc3-08db9c9f18bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q6saNq8K2/s8uVawzoR72uY4dZQ9V1uVkBNqfSHEGpAHCBnPL3HasKPjKwe6Qs3UhrzsxsSHz8Mc3quWPL6VHCLFRoAATy7sdHFVV93mSj+aTkRwNZ2CRccv+tGMAkjYxhf+ewj3f6DCfOtid6WQcNfyT90tkooRgFGHgLDdNkArlvZrHnf4puelFHA5BTHmWRw4JHBBiz/ZH2J2yTeoa4nNfwhbgE7PONoTit8WfgKMHJdR3B6Z8FiUoXzEnjR5a+U1RA8AAql67VT0di5/pnTxRe2g7xYRORtz0oBsKvkGaVCJq/p6kAqCsuxsbMBhw8ZeR/gryXEz9qWVcNtDE53P89hjaVHe5haipCxgZjRVQx6zVktNwf+4lvQow3ZeZ9eJhMaC0HvMVVdiLyjOxIKwDjBBYxFYfbhy8PkPfCr+24nLqxTCOVI9kAi2/1OV+knO2R1ZJhiD+G60vTE7h28oxcJajf8v9PK4QPPodddy+V+tGdliSrSFpaxi8Fq30l4aom99GR3UzLcZXl0uuqcqnZbtI7gT2Gmcg2iv8QI+gdlzjqi0CSWooADStW+bZhSKdy6jjHKdv2gAZSkPoSZ47SFyjEtPwbUlJeyNKjexX+synCBOM2tpPd97SO6g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(1800799006)(186006)(55016003)(38100700002)(54906003)(110136005)(7696005)(71200400001)(478600001)(122000001)(52536014)(38070700005)(5660300002)(2906002)(4744005)(33656002)(86362001)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(8936002)(316002)(8676002)(6506007)(53546011)(26005)(83380400001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0RobHhDbTVYK1VrSkthSWl5Y1ZyTTEwMzNLSEtZMVVCNlc0bm1ZVUFTT2d5?=
 =?utf-8?B?YWxIQUxEZU1oNFhSNVljd09QV05yMHk0ZVJjZTdtMGFSSWV6OGdjNWxSZ2gr?=
 =?utf-8?B?ekUyaHl3cEtpNlB1VCtOVCt3dDFpbDIyZVpiWXcxdEQ2cjB2TVJ5NnB2VkRT?=
 =?utf-8?B?clk3MmtyNHRpa0xxckdCRVhKQ2s2b3VmKytGWkxYSHlaU3ArNWZvVWNPRC9r?=
 =?utf-8?B?a1o3bjgzYk5BWGR1QWZIc2hEVEVyaG1mZ2pJS2N4YWUwaTlva2JiRE5URXUx?=
 =?utf-8?B?VWkvanphdm9WNEpHLzd3NkpySUZqRUNaQ200WVkzUEV2MDNTWURCOFVzbFky?=
 =?utf-8?B?a2Z6NTg1VTVSVVZ3WFNhMGJKOUFjamxhZjZSTTBHSnZWTjJuUnJuQzRzUVVO?=
 =?utf-8?B?RXBFbnJRblBucHVLWXZyakl5MnVUbm42cHZSbjAxYlByZWZIczZveE1XNThu?=
 =?utf-8?B?c1RDbVVuMGY1NmFxazJIbW1zT0VtcWhBTGp4cStIT3pnNUFCZ3NXVU9xOGxh?=
 =?utf-8?B?ajJSRlgvRHpQdlo5TU4xcHBjQXZ3N3lEQ2VMU0hGUnBRNzZkQVk2SGR3eURG?=
 =?utf-8?B?ckNmdFJ2cXg0bVBsTFd6eGY3VFhiYVRiL1NTbHJtV1lscmpoRmdxQ3VIRkpw?=
 =?utf-8?B?bTUyV0hERnZhMjBrYUoyRkZieFZ5VHU0WXRpbk9raG43K1ppL3VLOEVNRUpZ?=
 =?utf-8?B?RmFiUVMwTHFKLzViUnNRLzl1QkdyYmNzL0lXdmtXdGRsSmZ4SzdsYStoSE9K?=
 =?utf-8?B?cmZkTzRmSHNJdDN2cVJiK0lOZUlIb05DUytMcm5LU05ObDVmT1BnY1QzNEJF?=
 =?utf-8?B?Y2ZZTWtCNWRXdENibzB5SytyTm1ONDFhWk5Pa3NET201ckxlNjI4VSt0S2NH?=
 =?utf-8?B?UE1WR0liT0N6OGxLRkVXak94aEg4Yk0wazdhSDdWVENQcS9QcHUwR0dXSkRt?=
 =?utf-8?B?d3RJYmUzN3grWXBWYnc3aU9kT2VQbk10K0x4elBSelBQenZjTDlRcTlmTisy?=
 =?utf-8?B?SFBMSWJkVFVHL0lBQzNQNld0VW5RaURoYlA2elpwMzFnSytYWlgvQm1rRERG?=
 =?utf-8?B?Q1lDaSt1TzFLWVVtcmFKQzRlNVZrUmdFaDdZQzNuWG1vVXQrNGRVNmQ5VU1J?=
 =?utf-8?B?ZkJXdnUvWGV2RmR5WGlSZEQvcmlMQ3VwVmhVVDUwQU4zWTFKNVNMV2VTMTlV?=
 =?utf-8?B?OEl6bmtvZEpTNU93eXFNSmdRK0wvYnI0N0NMMTFwRU85NjM5N2VYREtCT0lW?=
 =?utf-8?B?anN3Y0FaWGZGS1ZHZ0JJQ3Q0eFBhOGNNK1p1ZE5vbm5NK3c0V1NHVDhtOEVB?=
 =?utf-8?B?NHUxcHdHRnBxL3E1Wm9LSmVOeGlWaC81SEsxM0NIMTNhR3NPWWJ2QnJMcEwx?=
 =?utf-8?B?aEVYU0cvRC9ib2FOZWhYS3ZCQkRrWE1KTURxMnQ5SGtoMkRUbUtvMDZXQ0p5?=
 =?utf-8?B?d3N5NmhqMmJQT2FHYllpNDBYMjFRWDdaVTVFVUE5ZDlQVEN1NUY5TkJza0pv?=
 =?utf-8?B?ZjVaNUtuMzl5SGZJVDVWZ3MyTUtrd1gxNWxaTmxBbnZmVzEwLy9LUHNsdjd3?=
 =?utf-8?B?UEM0VmdGUnNwd1g0QjFFb2tyY3ZKbzd6VmJhWHFYZkk2VU11Qm5rSU9QUTQ2?=
 =?utf-8?B?ZzFDTE9pemVlZFV6SFNaUGpuY1NmWlZXa0diQXhvbW9vWGxmWlJVSlI4RGV1?=
 =?utf-8?B?YlVMMVQxeVl0dkFybFlRdHIzUnBtOUtsRjVFU0lqZDdnRFU5UWc5UDM3U0ZY?=
 =?utf-8?B?dUJDZDQ5QWhBaUZaWCtZWXEzQkorVDFGc2pFTTQveG9tbE5VNlhqQ0taNFNU?=
 =?utf-8?B?SW5EVVp4d3dwU2hCL2xxMDlqUUlzd01nQTZKZzViTXIrM3liR3lDd3JobXBa?=
 =?utf-8?B?UW4xL3VpR2tBSDY1L3ZEU3FIbG4vM1UrWXEwYkZyTUREQXVYYjFFOGlOU2FQ?=
 =?utf-8?B?bm8vKzBOTXZ1K09xMHpGQ3hHU3cwbUdqZk9GdTNvRkdYM0pFa1B1OGpBeVI3?=
 =?utf-8?B?RmtpTjNQUUd4RDM5WXZBbWJhRXJkUHY4c2toaGJjYlcvcXZiWkVuWWpJWjdE?=
 =?utf-8?B?WHY0dWxZYXF6OGxUMnNUdXByRDdNZW51RnlrS2lJbkFTQVBJSmdRdmN3cGFt?=
 =?utf-8?Q?w07Z/f4Mx1Zq04y3BHrwOnVeC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7ff0c7-08e2-4430-6cc3-08db9c9f18bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:18:53.1443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQg8sZ7wqWfxSAohDiRiaZ9eFDO6TmtUOv+9MFZm4IVWkW+9COzI+1PebL+HKZPFvHupHyj0k5Eo6iBDPRVWfKu2HDptT+V1EqiGjuDt+h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10176
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgTWFyZWsgVmFzdXQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8yXSBpaW86IGRhYzogbWNwNDcyNTogUmVwbGFjZSB2YXJpYWJsZSAnaWQn
IGZyb20NCj4gc3RydWN0IG1jcDQ3MjVfZGF0YQ0KPiANCj4gT24gOC8xMi8yMyAxMzo1NCwgQmlq
dSBEYXMgd3JvdGU6DQo+ID4gUmVwbGFjZSB0aGUgdmFyaWFibGUgJ2lkJyBmcm9tIHN0cnVjdCBt
Y3A0NzI1X2RhdGEgd2l0aCBsb2NhbCB2YXJpYWJsZQ0KPiA+IGNoaXBfaWQgaW4gcHJvYmUoKS4N
Cj4gDQo+IC4uLiBiZWNhdXNlIHRoZSBpZCB2YXJpYWJsZSBpcyBub3QgdXNlZCBlbHNld2hlcmUg
aW4gdGhlIGRyaXZlciA/DQo+IA0KPiBJdCBwcm9iYWJseSBtYWtlcyBzZW5zZSB0byBhZGQgdGhl
IHJlYXNvbmluZyBpbnRvIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KSSB0aG91Z2h0IGl0IGlzIHVu
ZGVyc3Rvb2QgZnJvbSBjb21taXQgbWVzc2FnZS4gSWUsIHlvdSBhcmUgbW92aW5nIGl0IGZyb20g
Z2xvYmFsIHRvIGxvY2FsLCANCg0KSm9uYXRoYW4sIGlzIGl0IHNvbWV0aGluZyB5b3UgY2FuIGRv
IHdoaWxlIGFwcGx5aW5nLCBpZiBpdCBtYWtlIHNlbnNlPw0KDQpDaGVlcnMsDQpCaWp1DQo=
