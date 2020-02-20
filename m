Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0027166174
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2020 16:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBTPx0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Feb 2020 10:53:26 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:21302 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728380AbgBTPx0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Feb 2020 10:53:26 -0500
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KFnqFM013492;
        Thu, 20 Feb 2020 07:51:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=euoI3TTl0kukAKA2UE+wfWW63E8INXq/QQhp83Hl0iw=;
 b=L5p3buspNaeiYo7E4dHBQwJCV6dnTdv7LUXncDs1GS818DQS6jB13AVZZjJvbRPtlYvD
 SUYKUCuIm9BSnFgP5WX4rdaDSuqb4j2gvCmY+0ZNv19fwAXdcg9+dH93yqeYpzXL4WCN
 t1FJhxBk51iqx55ZoNIXhyiP/U+DQKbJIKWKVIRKW4IytG9uVM3ap1j9k167qMGOD756
 Q0Ncmpnhn+7WHvGJMVIVFeu1CWLqrBsbumPXqTRks6hGFwY7jRZv/Fhq2SaFFtSxRJFO
 IiZC+EQ3Wgxz723yYT4oLIhz+cm4De07cx7LATp+KbscZlK3YCMgpytSz8Fid2pYWKKK Wg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00328301.pphosted.com with ESMTP id 2y8uem8v0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 07:51:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0HLQVryMggkMt84k7UHxbBRDpWClHbWBktGZWobAZCpN97kOFUhi5gq1rHkl++pWYXQMqhKBtawYIe+WeSk8Zi2CEuMIK0ELNn/xng83GMmhaDpljJaDt/b863mKttvLIxUSSbdou9U3KNOOlstCIG38OOS64zSH9I6NC69R0lUpLxhzR8JSlng4fH86o8p9ZvJdmqJ3V/VTpsATSXnlrbJrLXSXeNtyU/BVd5nzBzb7C2h9MmnhQsJ4qdiHPy17/CLxkmOVVpPiZu5DkBgXyZni1qlS131I98Cj4f9oO9qLRcDOM1IixRKclco6mpRJj9C6k2aMYjcNz7sdYC+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoI3TTl0kukAKA2UE+wfWW63E8INXq/QQhp83Hl0iw=;
 b=m9tYp+S5sgoxsLfVDDzOtnJOaxrWMWaTzHwR232iOitbpxNX2ceVhCC34OaCHkV72pzO2C7XEggMCT7ArV7wafYSKYMbwAZvzN3HRyrPraJBmzzKiZSBszFOXzzZ2fs2XGW3UmjfsZDBl2rzQiHQTvI1aPhjKfBXUpnwRY72mhi8bWsSR5Fa0nBPOyp13RvTTV/h7lm3iumYYDO3MC+5FTEKxibgneZqCsOhSd65qw0DS1vPOuOiuk8D+Z85RKYD3EXDH9uR98j8ADJOH4JPexSwFh7YwyYTnE3mXhYkveizNGh5kVQ22xWnchWA66hB0SxqryHomoFPCwL8jsFNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoI3TTl0kukAKA2UE+wfWW63E8INXq/QQhp83Hl0iw=;
 b=B+Okm3HiUUOBGW2iN90L9ovq8z6b78XP38BQyi/VzrnW3nAckJ7d2JbU2pQ+21UdKue6x9neE2QmIR4ZExWKAkJhW1O8SxURyTuTEum3iZh+4O9jWuS4QigF1vKH7hOyAR6HIbIXS8GxXu/Y07MHZn2+kcOML0V7vUh4kLkhOgs=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4054.namprd12.prod.outlook.com (20.180.6.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 15:51:04 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 15:51:04 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Question about pressure sensor driver data processing
Thread-Topic: Question about pressure sensor driver data processing
Thread-Index: AQHV5nRAH9e9vCtKIkulKysIFzksHagi2q+AgAFixls=
Date:   Thu, 20 Feb 2020 15:51:04 +0000
Message-ID: <CH2PR12MB4181ACCA24A66E10A04236B4C4130@CH2PR12MB4181.namprd12.prod.outlook.com>
References: <CH2PR12MB4181730FBF2DAE98E17ADBA9C4110@CH2PR12MB4181.namprd12.prod.outlook.com>,<20200219183837.00002aac@Huawei.com>
In-Reply-To: <20200219183837.00002aac@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fb81163-7abe-4baa-79e4-08d7b61cb130
x-ms-traffictypediagnostic: CH2PR12MB4054:
x-microsoft-antispam-prvs: <CH2PR12MB4054A5A84F45A932AB9D36A6C4130@CH2PR12MB4054.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(316002)(52536014)(8676002)(55016002)(4326008)(5660300002)(86362001)(66446008)(81156014)(81166006)(33656002)(9686003)(76116006)(91956017)(64756008)(7696005)(66556008)(66476007)(66946007)(186003)(26005)(6916009)(2906002)(8936002)(53546011)(6506007)(478600001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4054;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PDNLDE2NcUTH/5+9kbkXJw3tIi3wHa4H1vWdah0oyWZfnLHSOBmztsCXsNLUPbCadTBfgLgb2p2WGXr3xgwZT95lFeur5c3GMzi2ZjJg4r0ADk6/qJamiVUxO9O8xBaxy0utU92pGOGMEc3dylpZdz25qimkEqZ9sI94sGuSvfu9V9p7d81zeN40gLuSDqW7hHLAdA93o8fKCZt7Pb74gIe5PyRb/dQQbLi8BLnL/h5RjIol4Xylx0XVvfuXsxq6Lk/brC6QQwLVAKJqtFBQURiSOjJC9UoAQ7zcPkO4+nku40FEw7OSbTUKcs6OFMv1CXqBhNeCvIXfSDqMDbK7i7n/+3eFFrf3JfstIRgq6jEsgrlnl7Su70DzFom6mhqK5XM5F65TABaBB3fo/uO5S5hAJw5/PNoYWwUf2uk4B0aWqdXg16GOjLz1nTwuh9cT
x-ms-exchange-antispam-messagedata: 7AsKw04dvYyhc93molS6EbJJnlgagcfUSLkZtXf3E1O4OC6gTIqpJ6PZSmEjCq6rqi5G/4GSGGntgqmcQE1PlfeanrkmejmXPqyyH871uoIACgO84M30olJ0XMEezlXAbgYLAxSX2pvxkyWADlPPqQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb81163-7abe-4baa-79e4-08d7b61cb130
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 15:51:04.3770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwCZ2GCgqamtiC3a32hDLgx02oCGk3X1T5fujDPYkad8qPltO+gDlAG4WrC9CaO8CecDRBDRGc3kQ+iyT+6PFMmmE/kHepVC2LHekKffn0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_04:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002200116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
I will send first a generic driver returning processed pressure data and ra=
w temperature data and without any buffer/trigger support.=0A=
I think this is the most valuable features for this driver.=0A=
=0A=
Afterward, I am interested to add buffer support using hrtimer trigger.=0A=
=0A=
Thanks for your feedback.=0A=
JB=0A=
=0A=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>=0A=
=0A=
Sent: Wednesday, February 19, 2020 19:38=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: Question about pressure sensor driver data processing=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
On Tue, 18 Feb 2020 15:59:26 +0000=0A=
=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Hello,=0A=
=0A=
> =0A=
=0A=
> I have a question concerning a pressure sensor driver I am currently=0A=
=0A=
> writing.=0A=
=0A=
> =0A=
=0A=
> The formula to get the real pressure in Pa for this sensor is quite=0A=
=0A=
> complex. It depends on the measured temperature and would be far=0A=
=0A=
> better done in floats rather than in integers.=0A=
=0A=
> =0A=
=0A=
> The formula is too complex to be expressed with only scale and offset=0A=
=0A=
> factors. And the factors are not fixed since it depends on the=0A=
=0A=
> temperature.=0A=
=0A=
> =0A=
=0A=
> Would it be acceptable to have a driver than returns the raw data=0A=
=0A=
> without processing? Meaning data that have no unit and require a=0A=
=0A=
> processing done in userspace? That would be much more efficient for=0A=
=0A=
> sure, but it would not output really useful data without the=0A=
=0A=
> processing.=0A=
=0A=
=0A=
=0A=
Whilst it isn't nice, we have examples where this is already the case.=0A=
=0A=
The heart rate sensors are similar in that they have very complex=0A=
=0A=
conversions.=0A=
=0A=
=0A=
=0A=
It is certainly better than being unable to support the driver at all,=0A=
=0A=
but it does mean you won't ever be able to use it with generic code.=0A=
=0A=
=0A=
=0A=
Generic code tends to assume the scale is constant as well, so probably=0A=
=0A=
wouldn't work anyway :)=0A=
=0A=
=0A=
=0A=
> =0A=
=0A=
> Or a driver that return an input processed data and a raw data that=0A=
=0A=
> have no unit and requires the processing? If we can return raw data,=0A=
=0A=
> we should be able also to add buffer/trigger support to the driver.=0A=
=0A=
> Otherwise that would be quite tricky to return the processed data in=0A=
=0A=
> the buffer.=0A=
=0A=
=0A=
=0A=
Hmm. It is messy so if you actually expect to add buffered support, then=0A=
=0A=
we will need special code in userspace for this device anyway.=0A=
=0A=
We do have devices that jump through a complex conversion then pack=0A=
=0A=
it into a buffer, but that is also somewhat of a hack.=0A=
=0A=
=0A=
=0A=
For now at least, go with the raw output only.=A0 It may be one of those=0A=
=0A=
exceptions where we do support both processed and raw outputs in the=0A=
=0A=
longer term if there is clear need for generic code with this device.=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
> =0A=
=0A=
> Thanks for your feedback.=0A=
=0A=
> JB=0A=
=0A=
=0A=
=0A=
