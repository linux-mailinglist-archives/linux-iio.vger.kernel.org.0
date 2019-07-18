Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133AE6CEF7
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 15:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfGRNhE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 09:37:04 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:59962 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726715AbfGRNhE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 09:37:04 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IDXmv2023524;
        Thu, 18 Jul 2019 09:36:58 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2054.outbound.protection.outlook.com [104.47.41.54])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ttgs2h8e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jul 2019 09:36:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ1Rn4EpEYdm+Q9PM1t0Bm4YwZ+oaZXlw2dgmgTNt4/UACaFRvW28uLd400F1qxnkVWXsHD4NYSlgmBPiVwVGpi2sofc/3cDmg32f0wp2NBBV7pkmHVyJ/lTLVTmWCO0B5cup41A+vI3XiA615/ce+oaAAkJ1eJk9u4GKum41SF0PSQ29qRPlEvHenabrsJ/MLnOprcDren0ktMK+d9gDzMg6hTFdJNocZTWGitJkalR0zFKsDFkpHmrnwJHvsjiruN8oLSd4/hLfPwd+nqpVgy0RdaQn0WB02m199g1kppI7FgFE8AVgkOrFZGUpTNkEeXK+jikq6tFTZtEMbCShA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIwAbjE9pCZdzFz/Og6Bs69sYvcPJuGByWXXgONqwsw=;
 b=SvmCu6HBZ7AkJBpK+l/NGxSmECzk6BL4Qt1nojTyO2APnrZ62DDWSg/dZmrtkZaVDsbIve8enddG3EGQWX5ypuK1o9F9iUQQb9Npjo17GZDJa+kGutSTZfE/9u2DWI5gufmzhxGnj/m8rkoA8XeBEJgnv3ASe+CJutgA2hMw6ezHT1uFBOUXQcfC+3YyETuWySUenPS+2I7c2+7XTcRTouGeNNxrr40zD7g0Xc/59qaUqs2ax5zHbz7HVi7NxPxDW1mheSNDm52l4qtuGVPjIGL6SgoG4Ab3W12KPy8MBUyrcpVC0yaHT2cEpt3hKMu3r5FIfu7tMVMbu0vK9sGc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=analog.com;dmarc=bestguesspass action=none
 header.from=analog.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIwAbjE9pCZdzFz/Og6Bs69sYvcPJuGByWXXgONqwsw=;
 b=9p5tbX5L3/QuJfW7nvtvORW14IN4ps209/eULVKCqI1e7MFwitBhzsoXCcd44ZDnHUiOZYvrrcnar09R0L64I4vMoBLVH13dIlAnjn2PEozJqM/11U/F/mGE1v2oeMjRZxfdJhuuz4JEum5cfP4+QXn3MR++j4fVyY4ienA2+7g=
Received: from BYAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:a02:a8::25)
 by DM6PR03MB4713.namprd03.prod.outlook.com (2603:10b6:5:181::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2094.11; Thu, 18 Jul
 2019 13:36:57 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BYAPR03CA0012.outlook.office365.com
 (2603:10b6:a02:a8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2073.10 via Frontend
 Transport; Thu, 18 Jul 2019 13:36:56 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2052.25
 via Frontend Transport; Thu, 18 Jul 2019 13:36:56 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x6IDatg0026379
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 18 Jul 2019 06:36:55 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0415.000; Thu, 18 Jul 2019 09:36:55 -0400
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/4][V2] drivers: spi: core: Add optional delay between
 cs_change transfers
Thread-Topic: [PATCH 1/4][V2] drivers: spi: core: Add optional delay between
 cs_change transfers
Thread-Index: AQHVPJX6hcJnW8CkuUS3oJZR8ATms6bQmIoAgAANDYA=
Date:   Thu, 18 Jul 2019 13:36:54 +0000
Message-ID: <3b5c33bb4f3ed4bb73304f1034184a683107ea55.camel@analog.com>
References: <20190717115109.15168-1-alexandru.ardelean@analog.com>
         <20190717115109.15168-2-alexandru.ardelean@analog.com>
         <20190718125008.GD5761@sirena.org.uk>
In-Reply-To: <20190718125008.GD5761@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.65.145]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A96C2C30BB4DB49BA8C6F2B476A331A@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(199004)(189003)(1730700003)(6116002)(8936002)(3846002)(2906002)(118296001)(8676002)(2351001)(316002)(106002)(14454004)(102836004)(54906003)(2501003)(486006)(76176011)(7696005)(229853002)(4326008)(356004)(23676004)(2486003)(47776003)(246002)(26005)(36756003)(186003)(70586007)(70206006)(11346002)(446003)(436003)(426003)(2616005)(86362001)(126002)(336012)(476003)(478600001)(6916009)(7736002)(305945005)(7636002)(50466002)(6246003)(5640700003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4713;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f3668b1-8cbe-43fd-024c-08d70b85009a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DM6PR03MB4713;
X-MS-TrafficTypeDiagnostic: DM6PR03MB4713:
X-Microsoft-Antispam-PRVS: <DM6PR03MB471325D6E552C6996FB5501EF9C80@DM6PR03MB4713.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 01026E1310
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XJT53k3e4KRN0SLwUz7ei5D/wv1Ctbf44fxIM68duQJ31ktutkdKtNFDrDJRuZea5AoaeJeESpSlKYrLv/cwO5Oc04/4ES97VNBNKY0wIh6wf/HYDGaqMCECLq/XSUjJ25ezrGUDQ8Vc3swu/zzJK9m9sdOfhznyh6CZv9zCJJyhiBFSl1thoCSBxv7rteZb+uGPLpFk71BfxtBugjoN6iMjf1TAKtdvbXDWQLnG9fLIKzlJ51ytPNkPD6tZKnF+1o2iWhwgIsWjQlyVtMrDiywpbcTB/mwtK7TCnsVj6hrxuCoekAOos9FXygVMpNw9d6xCM8RBdEy6BT35XP7ivGhsY3EeNpSVczkjEovmXCK1/G+43re7gPChhWC5Q/we8heDdQVymyFcuZV97edhrNu1pHRt2zC9K0KD5mduXVw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2019 13:36:56.0538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3668b1-8cbe-43fd-024c-08d70b85009a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4713
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180142
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE5LTA3LTE4IGF0IDEzOjUwICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIEp1bCAxNywgMjAxOSBhdCAwMjo1MTowNlBNICswMzAwLCBBbGV4YW5kcnUgQXJkZWxl
YW4gd3JvdGU6DQo+ID4gU29tZSBkZXZpY2VzIGxpa2UgdGhlIEFESVMxNjQ2MCBJTVUgcmVxdWly
ZSBhIHN0YWxsIHBlcmlvZCBiZXR3ZWVuDQo+ID4gdHJhbnNmZXJzLCBpLmUuIGJldHdlZW4gd2hl
biB0aGUgQ1MgaXMgZGUtYXNzZXJ0ZWQgYW5kIHJlLWFzc2VydGVkLiBUaGUNCj4gPiBkZWZhdWx0
IHZhbHVlIG9mIDEwdXMgaXMgbm90IGVub3VnaC4gVGhpcyBjaGFuZ2UgbWFrZXMgdGhlIGRlbGF5
DQo+ID4gY29uZmlndXJhYmxlIGZvciB3aGVuIHRoZSBuZXh0IENTIGNoYW5nZSBnb2VzIGFjdGl2
ZS4NCj4gDQo+IFRvIHJlcGVhdCBteSBwcmV2aW91cyBmZWVkYmFjazoNCj4gDQo+ID4gVGhpcyBs
b29rcyBsaWtlIGNzX2NoYW5nZV9kZWxheS4NCg0KQWNrLg0KV2lsbCB1c2UgYGNzX2NoYW5nZV9k
ZWxheWAuDQpJIGhhdmUgbm8gc3Ryb25nIHByZWZlcmVuY2UgcmVnYXJkaW5nIHRoZSBuYW1lLg0K
DQo+IA0KPiBQbGVhc2UgdXNlIHN1YmplY3QgbGluZXMgbWF0Y2hpbmcgdGhlIHN0eWxlIGZvciB0
aGUgc3Vic3lzdGVtLiAgVGhpcw0KPiBtYWtlcyBpdCBlYXNpZXIgZm9yIHBlb3BsZSB0byBpZGVu
dGlmeSByZWxldmFudCBwYXRjaGVzLg0KDQpBY2suDQpXaWxsIGxvb2sgZm9yIFNQSSBzdWJzeXN0
ZW0gc3BlY2lmaWMgc3ViamVjdCBsaW5lcyBhbmQgdXNlIHRoZW0uDQoNCj4gDQo+IFBsZWFzZSBk
b24ndCBpZ25vcmUgcmV2aWV3IGNvbW1lbnRzLCBwZW9wbGUgYXJlIGdlbmVyYWxseSBtYWtpbmcg
dGhlbQ0KPiBmb3IgYSByZWFzb24gYW5kIGFyZSBsaWtlbHkgdG8gaGF2ZSB0aGUgc2FtZSBjb25j
ZXJucyBpZiBpc3N1ZXMgcmVtYWluDQo+IHVuYWRkcmVzc2VkLiAgSGF2aW5nIHRvIHJlcGVhdCB0
aGUgc2FtZSBjb21tZW50cyBjYW4gZ2V0IHJlcGV0aXRpdmUgYW5kDQo+IG1ha2UgcGVvcGxlIHF1
ZXN0aW9uIHRoZSB2YWx1ZSBvZiB0aW1lIHNwZW50IHJldmlld2luZy4gIElmIHlvdSBkaXNhZ3Jl
ZQ0KPiB3aXRoIHRoZSByZXZpZXcgY29tbWVudHMgdGhhdCdzIGZpbmUgYnV0IHlvdSBuZWVkIHRv
IHJlcGx5IGFuZCBkaXNjdXNzDQo+IHlvdXIgY29uY2VybnMgc28gdGhhdCB0aGUgcmV2aWV3ZXIg
Y2FuIHVuZGVyc3RhbmQgeW91ciBkZWNpc2lvbnMuDQoNClsgdGhlIGZvbGxvd2luZyBwYXJ0IHNo
b3VsZCBub3QgYmUgY29uc2lkZXJlZCBpbiBhIGRpc3Jlc3BlY3RmdWwgdG9uZSA7IHRoZSBpbnRl
bnQgaXMgbm93aGVyZSBuZWFyIHRoYXQsIGJ1dCB0ZXh0LQ0KY29tbXVuaWNhdGlvbiBoYXMgYSBk
ZXNpZ24tZmxhdyB3aGVyZSBhIGRpc3Jlc3BlY3RmdWwgdG9uZSBtYXkgYmUgaW50ZXJwcmV0ZWQg
W3doZXJlIHRoZXJlIGlzbid0IG9uZV0gXQ0KDQpNeSBpbnRlbnQgd2Fzbid0IHRvIGlnbm9yZSB0
aGUgcmV2aWV3IGNvbW1lbnQuDQpTb3JyeSBpZiBpdCBjYW1lIG91dCBsaWtlIHRoYXQuDQoNCkkg
YXNzdW1lZCBhIHBhdGNoIHJlLXNwaW4gd2FzIHByZWZlcnJlZCB2cyBhIHZlcmJhbCBkaXNjdXNz
aW9uLg0KU29tZSBwZW9wbGUgcHJlZmVyIHBhdGNoIHJlLXNwaW5zIGFzIGEgYmFzaXMgZm9yIGRp
c2N1c3Npb24uDQpWYXJpb3VzIHBlb3BsZSBoYXZlIHZhcmlvdXMgcHJlZmVyZW5jZXMuDQoNCkFs
c28sIEkgd2Fzbid0IHN1cmUgaG93IHNvb24gSSdkIGdldCBhIHJlcGx5IGJhY2sgb24gdGhpcywg
c2luY2UgdmFyaW91cyBwZW9wbGUvbWFpbnRhaW5lcnMgaGF2ZSB2YXJpb3VzIHJlcGx5LXRpbWVz
Lg0KQW5kIEkgYWxzbyBbc29tZXRpbWVzXSBoYXZlIGxvbmdlciByZXBseS1iYWNrLXRpbWVzIFt3
aGljaCBkb2Vzbid0IGhlbHAgZWl0aGVyXS4NCkFuZCBJIHdhc24ndCBzdXJlIGlmIGBjc19jaGFu
Z2VfZGVsYXlgIHdhcyBmdWxseSBpbnRlbnRpb25hbC9hZC1saXRlcmFtLCBvciB3aGV0aGVyIGl0
IHdhcyBhIGZlZWRiYWNrIG9mIHRoZSBzb3J0cw0KImFsb25nLXRoZS1saW5lcyBvZiBgY3NfY2hh
bmdlX2RlbGF5YCIuDQoNCldoaWxlIGxvb2tpbmcgYXQgYHN0cnVjdCBzcGlfdHJhbnNmZXJgIHRo
ZSBvdGhlciAiZGVsYXkiIGZpZWxkcyBzZWVtIHRvIGJlOiBgd29yZF9kZWxheV91c2Vjc2AgJiBg
ZGVsYXlfdXNlY3NgLCB3aGljaCBpcw0Kd2h5IEkgYXNzdW1lZCBgY3NfY2hhbmdlX2RlbGF5X3Vz
ZWNzYCB3YXMgcHJlZmVycmVkIFt0aG91Z2ggSSB3aWxsIGFkbWl0LCBpdCBpcyBhIGxvbmcgdmFy
LW5hbWVdLg0KDQpBbmQgdGhlIGNvbmNsdXNpb24gW2Zyb20gbXkgc2lkZV0gaXM6IG1heWJlIEkg
cnVzaGVkIHRoaXMgYSBiaXQgYW5kIG1heWJlIGl0IGFubm95ZWQgeW91Lg0KTm90IG15IGludGVu
dGlvbiwgYW5kIGl0J2xsIHRha2UgbWUgYSBiaXQgdG8gYWRqdXN0IHRvIHlvdXIgc3R5bGUuDQoN
Ck1vdmluZyBmb3J3YXJkLg0KDQoxLiBJIHdpbGwgdXNlIGBjc19jaGFuZ2VfZGVsYXlgIGFzIGZp
ZWxkIG5hbWUgDQoyLiBJIHdpbGwgdXNlIFNQSSBzdWJzeXN0ZW0gc3ViamVjdCBsaW5lOyBJIHdp
bGwgYWRtaXQgSSBmb3JnZXQgdGhpcyBzdHVmZiBwZXJpb2RpY2FsbHkNCg0KSXMgdGhlcmUgYW55
dGhpbmcgZWxzZSBJIHNob3VsZCBjb25zaWRlcj8NCk9yIGFueXRoaW5nIGVsc2UgdG8gZGlzY3Vz
cz8NCg0KSSdtIG9wZW4gdG8gZWxlbWVudHMgSSBtYXkgaGF2ZSBmb3Jnb3R0ZW4vb21pdHRlZCB1
bmludGVudGlvbmFsbHkuDQoNClRoYW5rcw0KQWxleA0K
