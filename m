Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90B19452A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Mar 2020 18:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCZRN1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Mar 2020 13:13:27 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:63138 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgCZRN1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Mar 2020 13:13:27 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QH4mPt007210;
        Thu, 26 Mar 2020 13:13:25 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-00128a01.pphosted.com with ESMTP id 2ywfj6ytcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 13:13:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8wa5OOwMK8cow2RJl/Bn5/L1hOPw5CkbOICMVPLTdXMIg7y3n0Q+/IVy/y7qpXqXwE8qp+sfOlHtyd9J/cVWAWOikD35ENgpNqRrgh4/FeLbnyWCJjoDpi6EJwTq1VCtEkTSxl+aVV6shkXV+1X2sERmPBBBDWoDyUijsuuwS0qjKqoDBYKLNpTydlcCMdjhgK4NUVb8xqlIb23+9oINDJGYTmNLoLPSykY/OmNzMHWaC3hEPF1bOLrxmQSIkjQj9ZGsfY+EMqmpEpktZa26cptqZlJ3Flde7pgr4qCQCsA6ncfFPRt9w3BgrCdBCA+RH1XR0MySbpit7/+XnG8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+0spLIPVdrxoEcDjczdnz9J3dv9S/wd10soY3JGYpc=;
 b=RiXzzDLjijK2uKpKfR78aLgOFfx/XX1Wibaa8c7dBLDUNTZe0bfZzp4Y+t3u2gRM7Ki+rQrdWjU2vFKqzONWFsfCSRQIXUWmPiokPmt6QFVxqaWdHaEqN3fA0xN0+Qwb2DPcy2m3JkW7eATVKm0fLZtbIf1+2mwxUdehsMX/VPsLrdBPBPAjS3R7pvtVo4vQtW/GxvfbyH5Rd1wp67NQhAD+sGWRheSxK5FbsJaQ1vwhxO9cXmzcEOddEA3zYOOm+5alGNzOPgb/md+SnluFGzGWlP+TBLgZLMpAg6xVIgdJrIMavSmwNV+2ReQ/fMEcsRII1TVfiID9L0tcyo0c4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+0spLIPVdrxoEcDjczdnz9J3dv9S/wd10soY3JGYpc=;
 b=TZppnBIzHyRULjNnlNXKe2cHpUkGEDy5J2odTZ+lT7CSWMrsAnHq8XqJiGL/zsmf8uU8rdkvc/0Fm4o2jr9iLU0cnTM3E1KWQcBTa/RjzCWLlYfynH3VnP5Lk7iWLogZ8OyxVoeuoEYF7MnfjNFLzNUOGQrxuWG1i3Yl40PHGEY=
Received: from DM5PR03MB3402.namprd03.prod.outlook.com (2603:10b6:4:3d::15) by
 DM5PR03MB2890.namprd03.prod.outlook.com (2603:10b6:3:122::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Thu, 26 Mar 2020 17:13:24 +0000
Received: from DM5PR03MB3402.namprd03.prod.outlook.com
 ([fe80::5129:7d63:e7b1:1230]) by DM5PR03MB3402.namprd03.prod.outlook.com
 ([fe80::5129:7d63:e7b1:1230%4]) with mapi id 15.20.2835.017; Thu, 26 Mar 2020
 17:13:24 +0000
From:   "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [GSOC] Choosing a component
Thread-Topic: [GSOC] Choosing a component
Thread-Index: AQHWA4XlwX0XL9ZyJUiMDwvhtXEjBahbCs0g
Date:   Thu, 26 Mar 2020 17:13:24 +0000
Message-ID: <DM5PR03MB3402EFA69C3644DA76FFB4C79CCF0@DM5PR03MB3402.namprd03.prod.outlook.com>
References: <5e7cce84.1c69fb81.433c4.751d@mx.google.com>
In-Reply-To: <5e7cce84.1c69fb81.433c4.751d@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWkdKdloyUmhibHhoY0hCa1lYUmhYSEp2WVcxcGJtZGNNRGxrT0RRNVlq?=
 =?utf-8?B?WXRNekprTXkwMFlUUXdMVGcxWldVdE5tSTROR0poTWpsbE16VmlYRzF6WjNO?=
 =?utf-8?B?Y2JYTm5MVEUzWldFMk4yTm1MVFptT0RVdE1URmxZUzFoWkdGaExUQXdNak14?=
 =?utf-8?B?TldZMU9HVm1NbHhoYldVdGRHVnpkRnd4TjJWaE5qZGtNQzAyWmpnMUxURXha?=
 =?utf-8?B?V0V0WVdSaFlTMHdNREl6TVRWbU5UaGxaakppYjJSNUxuUjRkQ0lnYzNvOUlq?=
 =?utf-8?B?RXhOalVpSUhROUlqRXpNakk1TnpFMk5EQXlNamt5TnpFME5DSWdhRDBpV1Zs?=
 =?utf-8?B?MVNtSXpSMXBJSzNKVFZ6SlRkWFpOTW1VeVMzUXlTVFZWUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZCYjNveVJHRnJVVkJYUVdKQk16ZDZiMVJzTUVwcWMw?=
 =?utf-8?B?Um1kazlvVDFoUmJVMUVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGamJGTXZWbEZCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf: true
x-originating-ip: [188.27.132.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a59f8486-09f0-4b85-86ab-08d7d1a8fe01
x-ms-traffictypediagnostic: DM5PR03MB2890:
x-microsoft-antispam-prvs: <DM5PR03MB2890929941EA1AD888760F1B9CCF0@DM5PR03MB2890.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(39860400002)(136003)(81166006)(66556008)(81156014)(71200400001)(66946007)(26005)(316002)(5660300002)(55016002)(76116006)(64756008)(8676002)(2906002)(186003)(66476007)(4326008)(8936002)(9686003)(33656002)(478600001)(7696005)(6506007)(6916009)(86362001)(53546011)(52536014)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2890;H:DM5PR03MB3402.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 91bTrtmzlk/ZdAb69+gnA1Hfx2o+Wy41tHB5JLnyiaeq9cQxQ1pjweoE3UqH7NF9XKYber2wO/GnLvOkmgb0RNv++W2NfS1HJ1K8I4pwfymVkhIKby9QnVsOPHgoaY043hsRG7rABDx4n3jcwe9ZIeBkFbKgu6V0kp/9pR51ivABGNnmGQVlfC1l6yDiDPP3kbJvIyuOnNkDfF7ZP7dmQ+Qtu6hDyZLwc4J+XJSMQ+s3aDnvTcD5LMHGS2fO3obeiPsSuKWJyNfrFujIt5XYMARRpkf09s6zLfCODRYm19ZQbxAgOgv9KcF0TGHJ3buXzON6bxYmQL5kUFVg99ufXfD6xkXD5KF1jK9KrRTF+EWiRTFMi8imccsRw9wurfrjwtx72tdH1yxoHPWYzQBSPoLzhB0Z9/QzLAdH30bSElztgMUWShj0HDutgecutvGB
x-ms-exchange-antispam-messagedata: 87ln1Urxdm+uzctHYUmG7+Ep2ZxcOyDkHA2Oxx8PPcc/p2BljqlS2hJXVzE2e0DlavZYFzNgpYSMM7dlPKxMcLKynb09DvXAHb3LYR6/08CwlSwH7FtKyBJEl/ju4Gfe4jgAQi2IyvKlSjLIIBIu9Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f8486-09f0-4b85-86ab-08d7d1a8fe01
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 17:13:24.1120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kz4Km9Gc6L4as/snKSRqyR8hqiaHsov51TtiQn84EBNJBX8lVug6DM8jvuJ4zu1WIwuRR9YVouU4/ueiLnC5ZNdh6faTTXeaC5GxRm9ISJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2890
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_08:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260132
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

VGhlIElJTyBjb21tdW5pdHkgY2FuIGFsc28gc3VnZ2VzdCBhbiBBbmFsb2cgRGV2aWNlcyBjb21w
b25lbnQuIPCfmIoNCg0KUm9oaXQsIGFueXdheSwgc2luY2UgdGhlIHN0dWRlbnQgYXBwbGljYXRp
b24gcGVyaW9kIGVuZHMgc29vbiwgeW91IGNhbiBqdXN0IHRoaW5rIG9mIG9uZSBjb21wb25lbnQg
dHlwZSAoZS5nLiwgQURDLCBEQUMsIGV0Yy4pLCBjcmVhdGUgeW91ciBwbGFuIGFjY29yZGluZ2x5
IGFuZCBzdWJtaXQgeW91ciBwcm9wb3NhbC4NCg0KVGhhbmtzLA0KRHJhZ29zDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBSb2hpdCBTYXJrYXIgPHJvaGl0c2Fya2FyNTM5OEBn
bWFpbC5jb20+IA0KU2VudDogVGh1cnNkYXksIE1hcmNoIDI2LCAyMDIwIDU6NDcgUE0NClRvOiBC
b2dkYW4sIERyYWdvcyA8RHJhZ29zLkJvZ2RhbkBhbmFsb2cuY29tPg0KQ2M6IGxpbnV4LWlpb0B2
Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFtHU09DXSBDaG9vc2luZyBhIGNvbXBvbmVudA0KDQpb
RXh0ZXJuYWxdDQoNCkhleSBEcmFnb3MsDQpJIG5vdGljZWQgdGhhdCB5b3UgaGF2ZSB1cGRhdGVk
IHRoZSBHU09DIElJTyBwYWdlIGFuZCBpdCBtZW50aW9uczoNCiINCkNyZWF0ZSBhIExpbnV4IElJ
TyBkcml2ZXIgZm9yIG9uZSBvZiB0aGUgQW5hbG9nIERldmljZXMsIEluYy4ncyBwYXJ0cy4NCldl
IGFyZSBvcGVuIGZvciBzdWdnZXN0aW9ucyBpbiBpZGVudGlmeWluZyB0aGUgZXhhY3QgY29tcG9u
ZW50Lg0KSWYgdGhlcmUgd29u4oCZdCBiZSBzdWdnZXN0aW9ucywgb3IgdGhleSBkb27igJl0IG1h
a2Ugc2Vuc2UsIHdlIHdpbGwgcHJvcG9zZSBvbmUgY29tcG9uZW50IHRvIHRoZSBjaG9zZW4gc3R1
ZGVudCAiDQoNCkkgd2FzIHdvbmRlcmluZyBob3cgdG8gZ28gYWJvdXQgY2hvb3NpbmcgYSBjb21w
b25lbnQuDQpBbHNvIGlmIGFueW9uZSBhbW9uZ3N0IHRoZSBJSU8gY29tbXVuaXR5IGhhcyBhbnkg
QW5hbG9nIERldmljZXMgY29tcG9uZW50cyBpbiBtaW5kIGZvciB3aGljaCB0aGV5IHdhbnQgYSBk
cml2ZXIgd3JpdHRlbiBJIHdvdWxkIGxvdmUgbG9vayBpbnRvIHRoYXQuDQpTdWdnZXN0aW9ucyB3
ZWxjb21lLA0KDQpUaGFua3MsDQpSb2hpdA0K
