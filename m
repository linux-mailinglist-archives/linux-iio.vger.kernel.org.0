Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993574F14F6
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 14:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbiDDMgm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 08:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbiDDMgj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 08:36:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E7275E1;
        Mon,  4 Apr 2022 05:34:43 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234AZ8Cw002566;
        Mon, 4 Apr 2022 08:34:28 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3f6gb6w0kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 08:34:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7sOtMr4YX9u3QCPvQk2fzP7BTnBQ0r378AUxvy7zcSZr6kRBIV68VxIw1+iSKudHSD4vaz41MsZGhNFY6z+P+oP7UXCauIil9ulf/3dQgtsXVUAATygoH9Vwyqp3Rn7f6SPIk3IAkuuJ7EW/yQ0wAq1kjrTbM35DWsAxUmbalPt+7ODZKK67888k+CTTpbA7LZqtokwnydkshzVEaPL802Fz23f8oiT6st9kFCBErTEoFhlZEBzv3Mekw4EQKS3UUvMPbbsEjQ43eAVgh8O0EIPDtVJG3sqX+owjJSzSk99hHQaNCwP5nMPvAygvVxlAqqLnfOdlHKx9NjmF2OFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QVD3WR0AAXH0ZwpiHYcgIaymH4m6JFPRgtq1GLeuo8=;
 b=mCB5FiAsHkydwyLOOjHRXC95NRRncyG1Ht+1cCE544YzH8ePEUqP/auRIO3SbGPUHkMagpo8vWlJvCo2sofaPXT4fUCDU4WmFaMDP4CSpQ1/m+nkgbPq0mAGFV4IxFRd7bsY+++DIR+LkE/uZEKJqPEJly9rip7Hvmmbxhu8EOOgP08XCYTAPVbEWaZN6AsG5NCyF/9xfhgkGj/YRC74kMBIjeanzuTh4RQjSlZaLmtTxpEd1v651Wty98Q0SASS5Man3cFPkv4eWW5MKvHLYs3bb0XbBYnvX/OwEhVhEJWSBxY8/C+HyVFJlCULx3QK/qNOscAtY/WWIKr/3mFMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QVD3WR0AAXH0ZwpiHYcgIaymH4m6JFPRgtq1GLeuo8=;
 b=kUmmsDOGdLKbcCLvatzqurnUcFus1NeBxQ8YjHt8TJTK9Fwl0XnujET//NQfrf15ufceSzDSl10VINUYRuvrLimFwaqoLYMGBcgZWlPcpEE8X/eV+dehXqCKtqEW284E8/QqY4t9H64NYQ8VngPoqXVzXMDXUDX/BdbKrQ52EHw=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DM6PR03MB5020.namprd03.prod.outlook.com (2603:10b6:5:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 12:34:25 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%7]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 12:34:25 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] iio:dac:ad3552r: Fix an IS_ERR() vs NULL check
Thread-Topic: [PATCH] iio:dac:ad3552r: Fix an IS_ERR() vs NULL check
Thread-Index: AQHYSBkkwO0kSbaT3EuQzQvFR+4VS6zfsEYQ
Date:   Mon, 4 Apr 2022 12:34:25 +0000
Message-ID: <PH0PR03MB6786CFA5554F79CCC3BA6FAF99E59@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220404114244.GA19201@kili>
In-Reply-To: <20220404114244.GA19201@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOGRmMmU1OTQtYjQxMy0xMWVjLThiZDYtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDhkZjJlNTk2LWI0MTMtMTFlYy04YmQ2LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTU2NiIgdD0iMTMyOTM1NDkyNj?=
 =?iso-8859-1?Q?MwOTYzMTY1IiBoPSJQNTJkdFZhd09hOWxCMGN3bVJjM3Q1OXpEZU09IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURkWTA5UUlFallBZWhvaFdLVlBBQko2R2lGWXBVOEFFa0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e939003-98fb-4951-92ad-08da1637744c
x-ms-traffictypediagnostic: DM6PR03MB5020:EE_
x-microsoft-antispam-prvs: <DM6PR03MB5020968E7BE92ADB47C8781F99E59@DM6PR03MB5020.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0WoHb1PrxMyI+iGJq1uCLro6oMnJt+CLsxiJBqy2CZyM6Zkg8k73X+n8Y6LLJxMsVXOpfwFYvzRAyxP6ks3uC8E9on7OmmTEh5Zu2P7017cwiYhn8UjyJir0xIu08DMNylf/KZViK2ijFu1URKcJ4OMB+WtGUAJfnI+mEWRXnvET26rJEtJr/goHpHkG2XrlYzpo0dcGGwTm25Zag2pdPFvzhuWs020dtRPU3f18Cs9u8DBPbpJDIrVA2mkGJi9Twlo82qD8Eoo5Ycu7HHP/Bwr1AYZhnTBxvqHVFQknU6sYk7/4YFAcOBokA7AFUnrQPjeKLh6Fsfb/jYAk7r9FwpaEks/81ogXa5XRXXZ1WHbP22YoD+hhXrDQ1acJxzZikVMChN5luW2KXT/S6AR0E2+ln9vxxhXK4jjLMOMzXXY/+SAFj0m2EhaE+eqdy63bQgJW0rcChCbXFbdtDY07leToYYd2DyxAMvj5Rn57KoWE6D3DFiXrFpWl8r12p4LMpEpLu/pRPXI0SvtAZUqYsqMpQXj7ePpTj2S1iseUrD/IYWedvzykWT8GqBhREoVU4+kL92zmuaROTq46j0VpH/uQ2a4m+I4NsmHcJ250BosVqe20DamoqChRk2EKK1nmgeLkHQ4y9xJ+dQnozdkS6Hoi1Cf/2++Ve1UeiFnBqWZPCWT39Ed49ikK3gntvzIH5yudBYMvE3hGp2D2YXg7hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(316002)(5660300002)(26005)(38100700002)(54906003)(8936002)(71200400001)(38070700005)(76116006)(83380400001)(110136005)(55016003)(66946007)(66446008)(33656002)(66556008)(6506007)(52536014)(86362001)(9686003)(66476007)(122000001)(64756008)(8676002)(508600001)(4326008)(2906002)(53546011)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Stp0QStDdlcOxC5sRVMiwbG3Xs4HrLBN4dhFGwAtHwLy8B9gklGCUFTKfq?=
 =?iso-8859-1?Q?E7lptLX9E1r0K/sWZ38YACiYRUdf+k41MSG5HA0sDK27S5ZokFPKDSnKyu?=
 =?iso-8859-1?Q?8WAHCv9iB3DQ7hCo/p+eqAPdqtz2KBLPMqB8bZ351tqUHOvpfVN3qrhw9R?=
 =?iso-8859-1?Q?tKpRfVCihjXUvGTl7pvtVkFN15bHAEft/a8YaKSMTItAavRp5Xx6NMVoRJ?=
 =?iso-8859-1?Q?7PVc2Y4MgiT61Bc9f8IPvrJUIvgrT7BALOYpI5cN3ormUc6Lv+ztZsRutq?=
 =?iso-8859-1?Q?TjUp23obgkSogns5hYt7/pLN0L/q869qkhRcU2KYSkK1IUDONw47GN4AW9?=
 =?iso-8859-1?Q?PBzqJS61/n7HoK4zJRrdauR1ObdL7233wGgc/15FYFKsSiVqn3rKCzVcN1?=
 =?iso-8859-1?Q?eYFTl5OQ369R3jdpQzq2nww9WVO9a+V0IHrIQPE3Ongzkbe1CmzubB94u3?=
 =?iso-8859-1?Q?QwkiG/fFurh4k/VBAfXqiSTwWj/Bert0eKnC50DC/MGdlkAI/nU5aOQI39?=
 =?iso-8859-1?Q?PS5aO02dLYrRvqjGgvdd8oDqqfXfuiwAekKHhni7FUV0Ejk0gj0qTHaT/8?=
 =?iso-8859-1?Q?eEZhtTVNdII/c11wIPQ8BerHKX9LTTgFSSY6LRGL4ZrncLNtdOWExzE58X?=
 =?iso-8859-1?Q?jrXrCh68q4Sqcea6Mhbuc8wMy2AUjmjVedc+qBzd3OblnhqS1gsa7sQpin?=
 =?iso-8859-1?Q?Fmo3WV1xht1f7QwvSE7/SL/GnXm1VH0CU2UC1SCTMzftAlSE+dBDGPWuah?=
 =?iso-8859-1?Q?Rcrx+yHfgHj17brqSnvNTGJVH3MLpnKKb5TSVuw7cys28YXvXRPMFJqJMp?=
 =?iso-8859-1?Q?ZpJHFuKpGwDt4dxRRN9sqbHmxNY5wNGa0NNBFubRitXDw+WTeYNk0/z0kI?=
 =?iso-8859-1?Q?KKaYcOPRmkm3EIdsEb6AfQz6Uz7sB+Fe/d7rXPXniQLDn45y26Oc9g4/o1?=
 =?iso-8859-1?Q?j1RBczEBMbczYFNZOEEJPoSBv37D4yVbuNnkxnx1pMHDlmjJWck8ZA2qVK?=
 =?iso-8859-1?Q?EBS2vQYGsE1uye+P5UiD3uZXz2gLc/boL3i+5bWIyosOv+VJ6rWhcJ6CxO?=
 =?iso-8859-1?Q?60sCC363gbOfEUM8B0nCmIg/v4lK4erbJrQICx1PAHNJIx7Dho2uxESkH5?=
 =?iso-8859-1?Q?YpcgPGMtxZzgwf1zXC9Yu0IZfmKT2BvD0mfSxjwm+Lzo99bNgv1WtHGkn4?=
 =?iso-8859-1?Q?0yvcpfe8KfuaKlwJF0/MC4MMCpWB9xxyPOCR6btAYbu9/Q74uE8bGHz6Bv?=
 =?iso-8859-1?Q?gP4W2volFmp0DgRgsfyyv9tonRl+7UpsO5OByIoEOCOOtwP3bceJpcYkwT?=
 =?iso-8859-1?Q?pPjPBlFqp4Tn27gjTr+FryBNwKSaf5s19soH9uBGNouCoESwjzvMflFpTf?=
 =?iso-8859-1?Q?qD06AHy3MogVWEYlR4heWOtxD9eMAawtlGL46pEEKueeMl0QGCZaeM/M02?=
 =?iso-8859-1?Q?wqsDcvEFdia1/WTsFwEl+IzLb4q29il3BCJfBaojHq697KPgfzbS4k7MMI?=
 =?iso-8859-1?Q?oVl3V0nE49ArVV1Ad6CLeP6CwPoMokwK8wBYq7qngGGv3tazUnFp+Kd1me?=
 =?iso-8859-1?Q?O6HWDfQQT2gMT+NhV9cfJEXNFNAZuKkgHwwpp8cuam6PoBU/T0ansckvwx?=
 =?iso-8859-1?Q?g7Q1Ne1q9GLN3FAYlTbCMdXAvV3BlS9MrOlZiDGcZDmOf1oKB/rSUINc7Q?=
 =?iso-8859-1?Q?NfX8tTg6SSz1T3UhyURxru+uv3+uI/ptuz1ybcOFwado6dA04uQr4EeJWY?=
 =?iso-8859-1?Q?9yCf0dew12c9yC9X4PW2GPE6rCM9XuK/cp2+DkaWowrB+3rv72m+Da3iid?=
 =?iso-8859-1?Q?toh4c6sEcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e939003-98fb-4951-92ad-08da1637744c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 12:34:25.5753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqRCDEvbNV2OTPQ7e6y5hC8tfL3JRwD4l77atu1QjVONlNixM7pg2Nczi6qrUy/NpLdnS+1JlVcvvnjdf7v8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5020
X-Proofpoint-GUID: wNsUvfYprONMQMufFlm3ptyE5896IkL0
X-Proofpoint-ORIG-GUID: wNsUvfYprONMQMufFlm3ptyE5896IkL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040071
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Monday, April 4, 2022 1:43 PM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan
> Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org; Sa, Nuno
> <Nuno.Sa@analog.com>; kernel-janitors@vger.kernel.org
> Subject: [PATCH] iio:dac:ad3552r: Fix an IS_ERR() vs NULL check
>=20
> [External]
>=20
> The fwnode_get_named_child_node() function does not return error
> pointers.  It returns NULL.  Update the check accordingly.
>=20
> Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

>  drivers/iio/dac/ad3552r.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index 97f13c0b9631..59f49b7564b2 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -809,10 +809,10 @@ static int
> ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
>=20
>  	gain_child =3D fwnode_get_named_child_node(child,
>  						 "custom-output-range-
> config");
> -	if (IS_ERR(gain_child)) {
> +	if (!gain_child) {
>  		dev_err(dev,
>  			"mandatory custom-output-range-config
> property missing\n");
> -		return PTR_ERR(gain_child);
> +		return -EINVAL;
>  	}
>=20
>  	dac->ch_data[ch].range_override =3D 1;
> --
> 2.20.1

