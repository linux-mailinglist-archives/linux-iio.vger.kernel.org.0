Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5140D43F823
	for <lists+linux-iio@lfdr.de>; Fri, 29 Oct 2021 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhJ2Hw0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Oct 2021 03:52:26 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:27240 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232344AbhJ2HwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Oct 2021 03:52:24 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SKReBe029265;
        Fri, 29 Oct 2021 03:49:43 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0b-00128a01.pphosted.com with ESMTP id 3byeneg6en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 03:49:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9P2wo8eJE4rHPoI+vheJ1C4tZ+My7U9xZSsdh/BTdfqvJCpWgQNfP/Ciaso0OuEGXEIFQC+L60eZNmF87HqVhFMYzYH+vlmHWUVcnIM7AlsdVtd/E8Zwx6IaltkIsv2ZcCvXuDj8AKb2x/edBBL+WDW9kYEShdBUZhF5zWm/kXnaTLtCOjG4aZTCN5LV8cpHppNvel8CQfxEIWmLp2+gazw0jKiZmv98TAoRcZ8VpSiDpKWy8Vp36d5Ok/uFwTlxmjnRGgW8x2kaEKw7M3j6UGaiwJE4Ed7KTQBhZ5qvRP32oCBtAKzjY9dI2cqykJ91E5TsDkH/uRi6j/7r+Gu7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPc15TbMxZIWt7WviM4LmY/7Z633LE2uRbogY4T2X24=;
 b=TsiQKnARLBgWESsxtVA6rPK4anwS046RO0hilewSX3KQ0d/6jxv/yFHvwB4SDwLB7DFMw6QEvom+q5QNo05trwoiBBWsOKPcSfvhEE9dViu/IXy/w7EBr9YdlhmiWLlTCdaP3RnuYNlgoGXM83ClmWbeOkbfu28d7JmwQaXP3SYVr8123LsqXySJE4jLaTmG2g4mwS6tq+EVCC3lCMFgrpBKIuDsCsN+uIL7lPqDY/aePOeKIjTQeSpX8az9er4cIhbG+hv6CCK0twPANFS2Jn2UHORKgSjFGN6jSXHliT3mBtEtm0DY5E5ZMMdjXLQnwjerqLmoaMuY4YjPsI7eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPc15TbMxZIWt7WviM4LmY/7Z633LE2uRbogY4T2X24=;
 b=jnmk/UbJBf5CIdQNAb3NLfTHeG8DxSkC9QGKTRoMfvo8tFS90kmwg5KcM9JvXJaftke7lbhAleJAY7B+7yrp5Qddg7lBXFhyUlHARoMZWmeepyPYMGwsE3ExDwy6qQtLD1XbMCjtZIxYh6U0o4tG70tF2TyiZHnFBPnwJtrFPiM=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5701.namprd03.prod.outlook.com (2603:10b6:510:42::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 07:49:41 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%8]) with mapi id 15.20.4628.022; Fri, 29 Oct 2021
 07:49:41 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v2 1/2] iio: frequency: admv1013: add support for ADMV1013
Thread-Topic: [PATCH v2 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Thread-Index: AQHXyxRXK3TV7pBLp0i0yNGLdNrftavnHh8AgAETIQCAAAZlgIABX4Lw
Date:   Fri, 29 Oct 2021 07:49:41 +0000
Message-ID: <PH0PR03MB636669F27992B59B8A7B603D99879@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211027092333.5270-1-antoniu.miclaus@analog.com>
        <20211027184324.51811ef1@jic23-huawei>
        <CY4PR03MB3399339315289769615E4DCD9B869@CY4PR03MB3399.namprd03.prod.outlook.com>
 <20211028113101.0587a658@jic23-huawei>
In-Reply-To: <20211028113101.0587a658@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFl6TmxNMkUzWkRndE16ZzRZeTB4TVdWakxUaGlPVFV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHTXpaVE5oTjJRNUxUTTRPR010TVRGbFl5MDRZ?=
 =?utf-8?B?amsxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTWpZek5p?=
 =?utf-8?B?SWdkRDBpTVRNeU56azVOamN6TnpnNU1UZzVNalF3SWlCb1BTSmtObXhIUjBJ?=
 =?utf-8?B?NFFtRkVibWd6Y3pkeWNVVnZibWh5ZGt4MWFHODlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVSTBSRWcyUjIxamVsaEJaRTF2VFhsT1R6QTNlV0l3ZVdkNlNU?=
 =?utf-8?B?QTNWSFpLYzBSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03811ae5-8ae1-4493-9dc8-08d99ab0aa69
x-ms-traffictypediagnostic: PH0PR03MB5701:
x-microsoft-antispam-prvs: <PH0PR03MB5701A10F8C5E1D3CCABB4FA099879@PH0PR03MB5701.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FI/R6H1bmlpnBXM6CoNUtCJA/WcA1qmh2Cc9PSxkNh96HsfxnneSLPwA4y094Rg0gznplQs0FpZHfUDj4Bt4IgDlO5sDnUnLPdEKmSk/i26Q0wn94Znz0JE+wQMRsrd1gwcuFwzR7X3yuDm8oV2E7dNshMWQUcRVVaYHVCIMFY75t1ncGSPwfePKFct8nqNIPiHx7+tXVLoVC/u9weNAE3uivIhlEnXPq9lsy9xx2CKEqGIuq+SZqczJkDNvh5mD+fQCXDWDp8BsZ9gTm2tbQ2iz6JVnP7qK1TqIuSX5WxNnFX5CYlz7LQ/m46TJwoRHN1BHmEdUrqthfvJnQQLuzmJpVNSoNMBKI2aoCoCf/+jYqpBx45QIJ7kMsyRxfqXQt/pXLOkpLCIt16rrNnXG+1+gd4TEmTpnSpNG93KB5WzYltI2TraByX6FDcWBVbD5Yu0qp9AL81WbitJGZeterDDOU9NMPwPwNb2jPfPRvL+qqtT2L85f2ZNM8ypcpJ2BrrBwQzkRIWhrMEIlivD6LqKVAcerzbjDOonv80MOkbN1d2CGpDp94dIaVigos6YfmvSTbLqdqqsJf5tgFMOW/ZOtA+41nkJfX3c6B+x9NAcxC17kzZKWnSzkCkV3jUGZClcZZFQ+FwHSLuBT5vgfxwtp9T2cH3FMc/vFC+JL6zHGoaBY/d7G7nsZWCajnNbm3FXU9LfYS2UMvVuff4QY2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(186003)(83380400001)(54906003)(6636002)(64756008)(38100700002)(33656002)(26005)(55016002)(66556008)(76116006)(66476007)(316002)(66446008)(8936002)(8676002)(66946007)(122000001)(7696005)(71200400001)(508600001)(9686003)(38070700005)(53546011)(2906002)(110136005)(4326008)(52536014)(5660300002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rkh6bSt1c0d6OS9QV0tCb1VlN1FaN0JuYWUrR2RtMU5SakczM3NCeExEVnNp?=
 =?utf-8?B?S21nYjQ1YkhnczBtM2x4MTNyL3NPTEFjbHRUY3o4YW8zWW9ZSVkvblFnSkVK?=
 =?utf-8?B?OHM2M2dRSG9YcTVkcXpiM1VReDgvc0dkLzhaQnZMN2V1Q2ZwcnFOVmdCc3RD?=
 =?utf-8?B?cWxIeTFsVmxHc1YwdnZ0cmpobGcyQ1lvV0R0dHQ1ckVLYm1KKzlkbnRqL0pG?=
 =?utf-8?B?MWNRRWs3TzhBc3BjakhGVDNheFlxMUZmdjduMlNvWFNzMHdRZXBiS2U1Vkto?=
 =?utf-8?B?bzRlNjFqeG5oOU5uUFE4b1NadVBheEg4Tmt6TWlVSzdwcVJnOGl1T1JsUU1H?=
 =?utf-8?B?bWZaVDhCdnpKaU5YNnRVSTVUa280MjJPa1Npa0ptZ0ZTdi9xYkJ0OXd0aW1m?=
 =?utf-8?B?NDFkcG0xOGYzUXRHdTNlNTA1NzR2SElRMkdsQ0JzSktPaTk1VW9STnVmcHBt?=
 =?utf-8?B?K0o4WjJPNGlpd2xjNXNDSEdFQWI5T1dzYmNjVDFyaUsreVVnbmlDNmFIdzNG?=
 =?utf-8?B?YWxqNnpWTmdVYnJvYWRyU2tQeUkxOXNaN2RDOFdnTC9KMnVHVm5rbHBhYXR2?=
 =?utf-8?B?UHRZRVNHK1d1eUFPcGp2NGppYWtYYSt3by9tRHZoNWhBUmF3LzVSckRjZytT?=
 =?utf-8?B?eGJURE5XdXduTG5vU0RNSm11b3FXTmJKNFBFL3M3OWdtZ1VMODBHeTBYVHdk?=
 =?utf-8?B?c2pXVW1ibCtKRHppNUxxbEk0UlBpb3dZQ0J3RmhpcFBKM2w2VEkwTC83dFB5?=
 =?utf-8?B?SEZ3eEVqQkJxQmcvWEQyd0VpbGwrNWhNckZKV3BscCszWmFIS1g5cmQrWXhU?=
 =?utf-8?B?c2kxL0QxZ3llamYvUGFtQmNFaTQ2blJRdEFEdWs5cmlDajRmMzV1L3Faamgw?=
 =?utf-8?B?TFBmaEI0UVZvV1J2b082U3hqWGdSVm1sVWZldDlzSm5BZis2R0ptWW9nZzFz?=
 =?utf-8?B?bHhIeDVWTHdsS1puVkxnc252UURhTCtmNThGM09rUS9sdDlkUzNSVk11Nnc0?=
 =?utf-8?B?eXI3SVAxNmk1dXRJOW5vZmZOSXN4dnlwaFEvOFVoMG5FRnVhN2MwODF4c2ZP?=
 =?utf-8?B?RjQyK3p3WG5oVlVjU3Rod1l1UkpqZ2g2UkRQRGtnYjRJZlpUSCt3Uk92MDcw?=
 =?utf-8?B?VEhnQ0VEcFpPajJzWnhHaDNWN2tqWXkvM0lTMXpFOEpsaUdTZDF1ZEdRa2ZV?=
 =?utf-8?B?anJFNWtIc2YyTFVnZ0ZGbjVCWlROZ2JPVVI2MmJ5YWpndVFhTUdVQTBZNGJ0?=
 =?utf-8?B?NGpKMmNIR1d4MHBLYzlrOTM4V1VlTFdNVWwvRCsrT05kSlp4TE1ubnNoa2p5?=
 =?utf-8?B?clVyUnpKWUZKcjcvZWZUcGpILy84UjlKWm43dVJKMlJpZVlZQTlvMnF5RzQw?=
 =?utf-8?B?N1MyMXVVVjNJTEtGMVJCbU9KZGhJUWcwZUgydnJ6R3l6amFGLzBYbFhIYTF1?=
 =?utf-8?B?M0pVNGxMMnc5VVVleVE5WDBTUExKRGY4NmJuSTFqR1hESmFzWVFWUHQ3aDJz?=
 =?utf-8?B?MjhkZWFReVJuLzF0RGRDbkVWQktlYXlldmlxZUtHSHcvcnRTbnBIUWlNLzhS?=
 =?utf-8?B?L055TXlnSjJYNWtkK1dEa0ExSm0yMTh4MStJT0plSGFWaE5NTnRxT2ZFcE9W?=
 =?utf-8?B?VFhWR2h2T2ZhZUJiUEFpR0dIbVBzZ0ptYXJaQlZtalFNTHFiTWcyekRPWHB0?=
 =?utf-8?B?TFBIL1VUTDBybVhNd0ZtWTJ1WkwvUWJWcWl0Qys4THZweWQ2dCtDNnRaMm9x?=
 =?utf-8?B?ZFRmZEVxdmwzY1hBSjRRMlE0WmV5Z3hnOXp3Mkt6clU4Q2F0M0VlSWJReitD?=
 =?utf-8?B?dVU5SDl5Mk82bXd6K3Roc0ZrYkFSc2RRV0dPdTB0Tks0anl2V3JsRGhQNnJi?=
 =?utf-8?B?VHRYcVAwOGlmcDRBSHpPTG1hYUk4OXhCOXhxbnpYdnMvSmdFcFNiL3JGS0t5?=
 =?utf-8?B?aWVwVm5VczNCeGgyamxUK0JUbzVpb3g5OEVrQlF3Q1VtNnhmNW1mWlRZRUlx?=
 =?utf-8?B?RjFzVUJPdU1VUTJ1ZHRPM21Uemtnb1FkQXNGVFNtdXczUWZKdFZBYWgvMEZY?=
 =?utf-8?B?bVVJbGlnb1p0RVhrL0ZINTFtNHZOdXkzTjcvTVRhd3hTMmdEQ3RHdkJEL25o?=
 =?utf-8?B?MEljRTVWejExOFJYclRORFoxNHpPMFFxMWpUcEgzN1RaQ0VEUThhRXNXWUNI?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03811ae5-8ae1-4493-9dc8-08d99ab0aa69
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 07:49:41.1803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0oiKNjmbiy+7lG2qEtgtwl3WNi2FaE1S9CE3SOXeVePw5LReM6yL4F//81eWardGqYwhAiWFd6N+XAPoBhLCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5701
X-Proofpoint-GUID: ZrJHNRPUrPRGpyBQhwSU5UlPX19bvwwj
X-Proofpoint-ORIG-GUID: ZrJHNRPUrPRGpyBQhwSU5UlPX19bvwwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110290043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9u
YXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9i
ZXIgMjgsIDIwMjEgMTI6MzEgUE0NCj4gVG86IE1pY2xhdXMsIEFudG9uaXUgPEFudG9uaXUuTWlj
bGF1c0BhbmFsb2cuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBsaW51eC1paW9Admdl
ci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgU2EsIE51bm8NCj4gPE51bm8uU2FAYW5hbG9nLmNvbT47IExhcnMt
UGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDEvMl0gaWlvOiBmcmVxdWVuY3k6IGFkbXYxMDEzOiBhZGQgc3VwcG9ydCBmb3INCj4gQURNVjEw
MTMNCj4gDQo+IE9uIFRodSwgMjggT2N0IDIwMjEgMTA6MDg6MDggKzAwMDANCj4gIk1pY2xhdXMs
IEFudG9uaXUiIDxBbnRvbml1Lk1pY2xhdXNAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhl
bGxvIEpvbmF0aGFuLA0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KPiA+DQo+ID4g
UmVnYXJkaW5nIHRoZSBpbnRlcmZhY2UgZm9yIHRoZSBNaXhlciBPZmZzZXQgYWRqdXN0bWVudHM6
DQo+ID4gQURNVjEwMTNfTUlYRVJfT0ZGX0FESl9QDQo+ID4gQURNVjEwMTNfTUlYRVJfT0ZGX0FE
Sl9ODQo+ID4NCj4gPiBUaGVzZSBwYXJhbWV0ZXJzIGFyZSByZWxhdGVkIHRvIHRoZSBMTyBmZWVk
dGhyb3VnaCBvZmZzZXQNCj4gY2FsaWJyYXRpb24uDQo+ID4gKExPIGFuZCBzaWRlYmFuZCBzdXBw
cmVzc2lvbikNCj4gPg0KPiA+IE9uIHRoaXMgbWF0dGVyLCBteSBzdWdnZXN0aW9uIHdvdWxkIGJl
IHRvIGFkZCBJSU8gY2FsaWJyYXRpb24gdHlwZXMsDQo+IHNvbWV0aGluZyBsaWtlOg0KPiA+IElJ
T19DSEFOX0lORk9fQ0FMSUJGRUVEVFJPVUdIX1BPUw0KPiA+IElJT19DSEFOX0lORk9fQ0FMSUJG
RUVEVFJPVUdIX05FRw0KPiANCj4gVGhlc2Ugc291bmQgdG9vIHNwZWNpZmljIHRvIG1lIC0gd2Ug
d2FudCBhbiBpbnRlcmZhY2UgdGhhdCBpcw0KPiBwb3RlbnRpYWxseSB1c2VmdWwNCj4gaW4gb3Ro
ZXIgcGxhY2VzLiAgVGhleSBhcmUgYWZmZWN0aW5nIHRoZSAnY2hhbm5lbCcgd2hpY2ggaGVyZSBp
cw0KPiBzaW1wbHkgYW4gYWx0IHZvbHRhZ2UgY2hhbm5lbCwgYnV0IEknbSBhc3N1bWluZyBpdCdz
IHNvbWV0aGluZyBsaWtlDQo+IHNlcGFyYXRlIGFuYWxvZyB0d2Vha3MgdG8gdGhlIHBvc2l0aXZl
IGFuZCBuZWdhdGl2ZSBvZiB0aGUgZGlmZmVyZW50aWFsDQo+IHBhaXI/DQoNClRoYXQncyBhbHNv
IG15IHVuZGVyc3RhbmRpbmcuIFRoaXMga2luZCBvZiBjYWxpYnJhdGlvbiBzZWVtcyB0byBiZSB2
ZXJ5DQpzcGVjaWZpYyBmb3IgVFggbG9jYWwgb3NjaWxsYXRvcnMuLi4NCg0KPiBDdXJyZW50IGNo
YW5uZWwgaXMgcmVwcmVzZW50ZWQgYXMgYSBzaW5nbGUgaW5kZXgsIGJ1dCBvbmUgcm91dGUgdG8g
dGhpcw0KPiB3b3VsZCBiZQ0KPiB0byBoYXZlIGl0IGFzIGEgZGlmZmVyZW50aWFsIHBhaXIuDQo+
IA0KPiBvdXRfYWx0dm9sdGFnZTAtMV9waGFzZQ0KPiBmb3IgdGhlIGF0dHJpYnV0ZSB0aGF0IGFw
cGxpZXMgYXQgdGhlIGxldmVsIG9mIHRoZSBkaWZmZXJlbnRpYWwgcGFpciBhbmQNCj4gDQo+IG91
dF9hbHR2b2x0YWdlMF9jYWxpYmJpYXMNCj4gb3V0X2FsdHZvbHRhZ2UxX2NhbGliYmlhcw0KPiBG
b3IgdGhlIFAgYW5kIE4gc2lnbmFsIHNwZWNpZmljIGF0dHJpYnV0ZXMuDQoNCkhvbmVzdGx5LCBJ
J20gbm90IHZlcnkgZW50aHVzaWFzdGljIHdpdGggaGF2aW5nIG91dF9hbHR2b2x0YWdlezB8MX0g
YXMgdGhlDQp0aGlzIGFwcGxpZXMgdG8gYSBzaW5nbGUgY2hhbm5lbC4uLiBIYXZpbmcgdGhpcyB3
aXRoIHNlcGFyYXRlIGluZGV4ZXMgZmVlbHMNCm9kZCB0byBtZS4gRXZlbiB0aG91Z2ggd2UgaGF2
ZSB0aGUgcGhhc2Ugd2l0aCAiMC0xIiwgdGhpcyBjYW4gYmUgYSBwbGFjZQ0KZm9yIG1pc3VzZSBh
bmQgY29uZnVzaW9uLi4uDQoNCkkgd2FzIHRoaW5raW5nIGFib3V0IG1vZGlmaWVycyAodG8ga2lu
ZCBvZiByZXByZXNlbnQgZGlmZmVyZW50aWFsIGNoYW5uZWxzKQ0KYnV0IEkgZG9uJ3QgdGhpbmsg
aXQgd291bGQgd29yayBvdXQgaGVyZS4uLiBXaGF0IGFib3V0IElJT19DSEFOX0lORk9fQ0FMSUJC
SUFTX1ANCmFuZCAgSUlPX0NIQU5fSU5GT19DQUxJQkJJQVNfTj8gT3IgbWF5YmUganVzdCBzb21l
dGhpbmcgbGlrZQ0KSUlPX0NIQU5fSU5GT19DQUxJQkJJQVNfRElGRiBhbmQgaW50ZXJuYWxseSBp
biBJSU8gd2Ugd291bGQgYXV0b21hdGljYWxseQ0KY3JlYXRlIGJvdGggUCBhbmQgTiBzeXNmcyBm
aWxlcyBzaW5jZSBJIGRvbid0IHRoaW5rIGl0IG1ha2VzIHNlbnNlcyBpbiBhbnkgY2FzZSB0bw0K
anVzdCBkZWZpbmUgb25lIG9mIHRoZSBjYWxpYnJhdGlvbnMuLi4gQW55d2F5cywgdGhlc2UgYXJl
IG15IDUgY2VudHMgOikNCg0KLSBOdW5vIFPDoQ0K
