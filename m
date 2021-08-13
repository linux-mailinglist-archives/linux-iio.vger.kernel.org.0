Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C0A3EB1EC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 09:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhHMHsI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 03:48:08 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:3922 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239522AbhHMHsH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 03:48:07 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D7jaNn006587;
        Fri, 13 Aug 2021 03:47:27 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0b-00128a01.pphosted.com with ESMTP id 3adfpdgvs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 03:47:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzjeDf489k4oUIwD1L3ZNkdOqDQoegjnnpNWxq2brZC0WC/wI3tkXYqYBJr2QsaN8yLmr44pCz4C9bIjd/Ob0O2ijC4BIKjYTEmod3uCp+75xuRAi+ea34mZshJiL/VNBT0vw/n53ZPCEHaFQqDr3Gy9u4f9P38AUTzGb6FkRVwZf3ghfvaFs/QfsZcIUYJEzmY2gG+cOMHZnNP6NT6yFYij0/ZMW45JLGZh1aDFJlvuDA4ouEIs0ZrGKWkbU5UG4c3PV6geVUWRzeLeLWxvnnDePLrC/gXn53lbmh2wH3r0gBuIo33nWBgctBu/7tbBFL1g+AjaJZz3o8sdE1/CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmUrGSnYns9/lOiC6pEDgS3vq4yt9JrIQXc194yJor4=;
 b=HV88ZDN+0FhqRHrxuBp0B5qcrV1CHh+v3q1OkP6Kh+v68dnyuR1BFgtNntluD3WonsQnClIqmW9oFFkwruqoRczp5vvXhjG3Thyw9WBq8kGulJrftPYI1somf1dJmAw96K85WVtghTie1WVK9NKnWxVGsCqhWOdz8kNz0qDRHeVxFM2AXBGFmuavL34UuAUfXicztXDOTuGvzIIRyTn2WeSBQyfBy0oiuvoSzl15Z9Z8I9tuv5GvIBd/onNUrLML5J4lmt6drWbGGF45TckBzrcJTyO8T2LaWsoju4fQ4XKQLBVhvEjFULA8AyY7Bx3aP8qaD66Ah0RerN7WsSLT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmUrGSnYns9/lOiC6pEDgS3vq4yt9JrIQXc194yJor4=;
 b=uKIXZQwvsbyy3XNzF5IyL6s5LNp1/107z/7Q6olQ5XTF5nuSTxOQSbi7WvTw9WbuKI0LSrWtEqL1PaTuw9Ccfd+EhUJ7a+K2Vj6scmcMue1VMYdNSTpS+pYnziIw00fj42ldcSGdqiJ06sV63DwYykXxnCKzCsDu4QNv5MONCvg=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5784.namprd03.prod.outlook.com (2603:10b6:510:31::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 07:47:25 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 07:47:25 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH] iio: ad5770r: make devicetree property reading consistent
Thread-Topic: [PATCH] iio: ad5770r: make devicetree property reading
 consistent
Thread-Index: AQHXjoTpWS49/XePMUytpStcxW5zfKtud/2AgAD4urCAAANBAIAAEoswgAB044CAAQ8qwA==
Date:   Fri, 13 Aug 2021 07:47:25 +0000
Message-ID: <PH0PR03MB63662507607DD7E06995B7EE99FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811074827.21889-1-nuno.sa@analog.com>
 <CAHp75VeLfxyLG-zTdVVnwB+PR2v=LW-PcvM4ZkEoLq+Ht0-iCg@mail.gmail.com>
 <PH0PR03MB6366283246B9D4925BFA444C99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAHp75VeZLKN0C_+PopKfYtPMqEzGLd4paSKYnrHr1B2Y1Nk9=w@mail.gmail.com>
 <PH0PR03MB636647F75955CF0C5E6D5A3D99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+V0++aO8cTcd3A-nBiG_X4wzJ+ZXWnXeRMPb=2QYOUhw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFlqQm1NbVZqT0RRdFptTXdZUzB4TVdWaUxUaGlPRFV0WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHSXdaakpsWXpnMUxXWmpNR0V0TVRGbFlpMDRZ?=
 =?utf-8?B?amcxTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTkRBeE9T?=
 =?utf-8?B?SWdkRDBpTVRNeU56TXpNVFEwTkRJMU1ETTVOek0xSWlCb1BTSjBNRVV4U1VO?=
 =?utf-8?B?c2MycHJaWGhhUVRseWRHTXJNV2wxVHpsNmNXTTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVSXpRakpDZWtZMVJGaEJZMlU0VXpoMk0wOUdiVE40TjNoTWVT?=
 =?utf-8?B?OWpORmRpWTBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVUpQV1VkalowRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDYUVGSVNVRmhVVUpv?=
 =?utf-8?B?UVVZNFFWcEJRbkJCUjAxQlpFRkNjRUZIT0VGaVowSm9RVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RkZCWVZGQ2JFRklTVUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIw?=
 =?utf-8?B?VkJZMmRDY0VGSFJVRllkMEpyUVVkclFWbDNRakJCUjJ0QlluZENkVUZIUlVG?=
 =?utf-8?B?alowSTFRVVk0UVdSQlFuQkJSMVZCWTJkQmVVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZC?=
 =?utf-8?B?UVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e45a37dd-8a50-4e35-e26f-08d95e2e9787
x-ms-traffictypediagnostic: PH0PR03MB5784:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB57840993EF7191B38003FD6B99FA9@PH0PR03MB5784.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8+r/bzOvt7EWqrKNQ7VIF3rDk6EYy6VNF9kYgx0m2lPLNh6/na8St44Mm7UDkMEQL3547pLsdVqXM9BL0Cm9oRKQiFMO2DF0mCW+pJHRFiQrGs2Mi6Wm69WYjx5idIGKiCzffhywFQOOnrjE4YxxJF17qH0sfTxbhatccSENkZSvIsfvv85eQxZJXV7VG+EJfW+vh0HpcI0B2FeWMudzOTax5HWvBGjkH6ubPqTWe1G+r43S4Wq8MxROtSOd4BP9r+p3TZZ72bo/bI1FJk4elIu4J6C8hM/h5cDCHKP3rhwzoiaUcJD6GgSLFQSvDNhhFijPj1nrBqu9ioc7Blxjbfdzvx54XQZNiCJqfaaAr6ixZ15JWhzsQCOdC138mFktN6dZt1eI0a3Yvql35U4B0v0b0n2LArf3yzQoea1sQi+uo2TUTbQ9vSZK7vm596omDsRcSyM6mFIUb2ASw7cmdqUBxsRy2hO214jZyyZEQ5tnHD9Gwz3xnJiHaM/6uey8pf9TZ4lGVHK2dkP2dimq+0LSsG7WsyIYHJS13hKYsKCWRSUEQlcBLJac0TU0shEN2tXmpa+ffedK/0yqgTfJL7ALJBfhOcwxBCrE08T/I9kUk7hqY+N5iJaISR4YFzUhXVDBU7e2/fD3Xglt9kMtiCNvhYKLEeX9KvJaAnMCVytUA0gGOEKQ6y2odIcwHCaB3p5w8ckUxVgPQqTdOmZUjq/x/MhERxJziKZCEMxRCMhcBl8tuUz7JpILQaL+gv0NR1Grv66IMUDP1lLtCqjs1MktfaiUNTwfV6aVhOHS+OxdRgk+ZvcXy24ojRQoYho2wBBv25BficzbTkdCm7/DQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(52536014)(122000001)(33656002)(38100700002)(8676002)(26005)(54906003)(83380400001)(2906002)(316002)(66446008)(186003)(5660300002)(71200400001)(64756008)(4326008)(55016002)(9686003)(66556008)(86362001)(6506007)(7696005)(53546011)(966005)(76116006)(66946007)(38070700005)(478600001)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGVCZm9Bc2lyOG1hZkhQNU9yZi9mbzhTVmx2THIzS2wzb05Db2orOS9hNHJQ?=
 =?utf-8?B?ZmlERHVvMUNGZTV6MFNERGJZMGwxRE1KMXlTNE9wTnhETlJUdmxTU0d0U3Z1?=
 =?utf-8?B?VTBZVjRFUEE1eHpVOWc3b0dIYjgvN2ZYZVJUcWNwL2FyM1lZckRucWhteGV1?=
 =?utf-8?B?Wi9CcDRKV002VTRNRHg0SURWUWZyemVxWkJ6MjliZHpvRmQvSHByaU9kd0s5?=
 =?utf-8?B?ZElia1pYRVdwM0ZKcDlJazhaUTd6UlpLMSt4akd6eEprV1JsSUhFTWs0dHIz?=
 =?utf-8?B?RjNrK1AwVktPNURJc0Y3RmFNVmNzTFYwYjRoRTM5Y0wvVGMrZzFYUWFqbWxR?=
 =?utf-8?B?QWxGbEo2MUNYVmN1U1RydzRFdlIvMWZZRUpLZGNMaGVFN2pCbGFKVVNBSEhw?=
 =?utf-8?B?ZmRxdzJTbkVWTHE5TjZydFRoY1RBNkVSd1d5QjFDamw2dEtQNHZVQmZ2K09r?=
 =?utf-8?B?cUpJaGlJeWpydXk5MWNXUHpGRU8wZyttdE1zUjE0QWRXZjU1NStsNXFQazlN?=
 =?utf-8?B?TURZR1VXRk1yRHNqRFRRTkJLWmZjeHB3c0ZwWHRtODhYVk5QQjlXLzlNb1Qy?=
 =?utf-8?B?eGlhQWl4cDl2R3lNbkxRVThzWUQwUHdQTkhvc0hZaE1nQTVSK25NMEo3cDRk?=
 =?utf-8?B?dGdKc241eEdxMWdPbzVxWGxSQmordERxeGhhWVozamozdTkzalB5RnFjTWli?=
 =?utf-8?B?VzFjeVJHNzFLUnRkTmQ2RDJZMWNMVmgwUVZMaXB2YWR5a1BzazFuWVFnNjFW?=
 =?utf-8?B?QmRkUmhjeWkxV2VSVGszNFJDRVUyZGhsb3pITEdiaXozN3Via3Y4dDlqdjZV?=
 =?utf-8?B?OW5FbnFRamUwTVE3RTVuOFVRb3hFT3IwbjlxOVdMdWhYRW1OQzZITFJxcWVi?=
 =?utf-8?B?aXo4eWdnbzVIRXpJQXlZVE5iY014eVJxRCtvNGtjVkdMYXZSWkRBUyswMzFO?=
 =?utf-8?B?Sy9IV1BHTW5BUy9xOXhuUml2MFVyUnZ5N3Y1R3pHT3gyckkvZlNnaHMrYmdZ?=
 =?utf-8?B?ZmFXSEptMUNYWEg0YWJrQnppYktYM084eXpFTzNNTjZkMGQxV2NZYnRwcmdr?=
 =?utf-8?B?ek1VcUpjQlpkWVZ5OXRGdEFwRmVxdmprdFFyZ3JvckZLOS9WZVBDK1M4bCt1?=
 =?utf-8?B?L084Z1NrbTYrRUd3S3RjNmpscXZocmh0TE9kNlJEdVp3Tmt4L2ZsaFVRcWxN?=
 =?utf-8?B?V3dmVFg0ZHc0UFUwNGJmMVVqVXcwZHlyNzRISXFVemNQL0N2eXpXUmJlZDUv?=
 =?utf-8?B?Z1g2eWFWT3MxTmVSYTVPVXMydXJKTUNBRHZVY244eWw2a0Jvd1hJU2JSanZx?=
 =?utf-8?B?Tkd0ZlV4UlpsZHFzSmljQTYxblVGL2J4ZEpMKzVxTnphRHNJUW1EblRvVGRK?=
 =?utf-8?B?ajJPSHNkY3ppSkpMU2toNXZNaEUzOFRJNUtUZm9CcTRZSnQvN3pUb1lKUk15?=
 =?utf-8?B?dkxHRnRqY2dNTUFXZGhzUGxXODRqM0x4Q0JWQk9KYXYwVEdUNzloV0JQNXpl?=
 =?utf-8?B?Z3krMUtKbEFPTXJ1SVdGT1VXbzJDTEpHQmFOUUJhZlF3eGM1Z0F2UlpocU1J?=
 =?utf-8?B?R01EL0FnckdOMkU3UjJPZTZKVzNsU3ZPNkJUY1NtcExlNGFYWnFQNlFWWU5R?=
 =?utf-8?B?N2N4cGlxR3k3MnNoVjVSU1lLcVdVSVdENCsxdkxUWXVHblMvYlNPU3MyOXVX?=
 =?utf-8?B?b3FJY3dFSlpzU2ZXNFB6OC9NY0Z4Y2NDT05SdWkvVkNFekd4cDlEeWl5dWdV?=
 =?utf-8?Q?UhgFPODBbE1kbVkzxZnxtyidmp5LrluQXuZCrHQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45a37dd-8a50-4e35-e26f-08d95e2e9787
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 07:47:25.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfaCxm+89Iwz1esO2MOr3oTxa/jHcWPJu/vZAGjGWC59IMCBg+lgTDexoEcTpYdOubBruk1ahDQIbehHTJyRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5784
X-Proofpoint-GUID: z-07gG7PQjvRhDBM1fuuGK5iZ6N3TFFX
X-Proofpoint-ORIG-GUID: z-07gG7PQjvRhDBM1fuuGK5iZ6N3TFFX
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_01:2021-08-12,2021-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130045
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxMiwgMjAyMSA1OjEx
IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzogQW5keSBTaGV2
Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgbGludXgtaWlvDQo+IDxsaW51eC1p
aW9Admdlci5rZXJuZWwub3JnPjsgSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz47
DQo+IEhlbm5lcmljaCwgTWljaGFlbCA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IExh
cnMtUGV0ZXINCj4gQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBpaW86IGFkNTc3MHI6IG1ha2UgZGV2aWNldHJlZSBwcm9wZXJ0eSByZWFkaW5nDQo+IGNv
bnNpc3RlbnQNCj4gDQo+IE9uIFRodSwgQXVnIDEyLCAyMDIxIGF0IDM6MTQgQU0gU2EsIE51bm8g
PE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxMiwg
MjAyMSA5OjA2IEFNDQo+ID4gPiBUbzogU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4g
PiA+IENjOiBsaW51eC1paW8gPGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc+OyBKb25hdGhhbiBD
YW1lcm9uDQo+ID4gPiA8amljMjNAa2VybmVsLm9yZz47IEhlbm5lcmljaCwgTWljaGFlbA0KPiA+
ID4gPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4g
PiA+IDxsYXJzQG1ldGFmb28uZGU+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpaW86IGFk
NTc3MHI6IG1ha2UgZGV2aWNldHJlZSBwcm9wZXJ0eQ0KPiByZWFkaW5nDQo+ID4gPiBjb25zaXN0
ZW50DQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBPbiBUaHVyc2RheSwgQXVndXN0IDEyLCAy
MDIxLCBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tDQo+ID4gPiA8bWFpbHRvOk51bm8uU2FA
YW5hbG9nLmNvbT4gPiB3cm90ZToNCj4gPiA+DQo+ID4gPg0KPiA+ID4gICAgICAgPiBGcm9tOiBB
bmR5IFNoZXZjaGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20NCj4gPiA+IDxtYWlsdG86
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4gPg0KPiA+ID4gICAgICAgPiBTZW50OiBXZWRuZXNk
YXksIEF1Z3VzdCAxMSwgMjAyMSA2OjA0IFBNDQo+ID4gPiAgICAgICA+IFRvOiBTYSwgTnVubyA8
TnVuby5TYUBhbmFsb2cuY29tDQo+ID4gPiA8bWFpbHRvOk51bm8uU2FAYW5hbG9nLmNvbT4gPg0K
PiA+ID4gICAgICAgPiBDYzogbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnIDxt
YWlsdG86bGludXgtDQo+ID4gPiBpaW9Admdlci5rZXJuZWwub3JnPiA+OyBKb25hdGhhbiBDYW1l
cm9uDQo+ID4gPiAgICAgICA+IDxqaWMyM0BrZXJuZWwub3JnIDxtYWlsdG86amljMjNAa2VybmVs
Lm9yZz4gPjsgSGVubmVyaWNoLA0KPiA+ID4gTWljaGFlbA0KPiA+ID4gICAgICAgPiA8TWljaGFl
bC5IZW5uZXJpY2hAYW5hbG9nLmNvbQ0KPiA+ID4gPG1haWx0bzpNaWNoYWVsLkhlbm5lcmljaEBh
bmFsb2cuY29tPiA+OyBMYXJzLVBldGVyIENsYXVzZW4NCj4gPiA+ICAgICAgID4gPGxhcnNAbWV0
YWZvby5kZSA8bWFpbHRvOmxhcnNAbWV0YWZvby5kZT4gPg0KPiA+ID4gICAgICAgPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBpaW86IGFkNTc3MHI6IG1ha2UgZGV2aWNldHJlZSBwcm9wZXJ0eQ0KPiA+
ID4gcmVhZGluZw0KPiA+ID4gICAgICAgPiBjb25zaXN0ZW50DQo+ID4gPiAgICAgICA+DQo+ID4g
PiAgICAgICA+IE9uIFdlZCwgQXVnIDExLCAyMDIxIGF0IDEwOjQ2IEFNIE51bm8gU8OhDQo+ID4g
PiA8bnVuby5zYUBhbmFsb2cuY29tIDxtYWlsdG86bnVuby5zYUBhbmFsb2cuY29tPiA+DQo+ID4g
PiAgICAgICA+IHdyb3RlOg0KPiA+ID4gICAgICAgPiA+DQo+ID4gPiAgICAgICA+ID4gVGhlIGJp
bmRpbmdzIGZpbGUgZm9yIHRoaXMgZHJpdmVyIGlzIGRlZmluaW5nIHRoZSBwcm9wZXJ0eSBhcw0K
PiA+ID4gJ3JlZycgYnV0DQo+ID4gPiAgICAgICA+ID4gdGhlIGRyaXZlciB3YXMgcmVhZGluZyBp
dCB3aXRoIHRoZSAnbnVtJyBuYW1lLiBUaGlzIHBhdGNoZXMNCj4gPiA+IG1ha2VzDQo+ID4gPiAg
ICAgICA+IHRoZQ0KPiA+ID4gICAgICAgPg0KPiA+ID4gICAgICAgPiAiVGhpcyBwYXRjaGVzIG1h
a2VzIHRoZS4uLiIgLS0+ICJNYWtlIHRoZS4uLiINCj4gPiA+ICAgICAgID4NCj4gPiA+ICAgICAg
ID4gPiBkcml2ZXIgY29uc2lzdGVudCB3aXRoIHdoYXQgaXMgZGVmaW5lZCBpbiB0aGUgYmluZGlu
Z3MuDQo+ID4gPiAgICAgICA+DQo+ID4gPiAgICAgICA+IFdoaWxlIGl0IHNlZW1zIG9rYXksIGl0
IG1heSBiZSBub3cgYSBjaGlja2VuLWVnZyBpc3N1ZQ0KPiA+ID4gKHNvbWVib2R5DQo+ID4gPiAg
ICAgICA+IGNyZWF0ZWQgYSBEVCB3aXRoICJudW0iIHByb3BlcnR5KS4NCj4gPiA+ICAgICAgID4N
Cj4gPiA+DQo+ID4gPiAgICAgICBBcmdoaCwgSSBzZWUuIFdlbGwsIG1heWJlIGxldCdzIGdvIHRo
ZSBvdGhlciB3YXkgYXJvdW5kIGFuZA0KPiA+ID4gY2hhbmdlIHRoZQ0KPiA+ID4gICAgICAgYmlu
ZGluZ3MgZG9jIHRvICdudW0nPw0KPiA+ID4NCj4gPiA+DQo+ID4gPiBOb3Qgc3VyZSwgbGlrZSBJ
IHNhaWQgaXTigJlzIGEgY2hpY2tlbi1lZ2cgaXNzdWUuIENvbnN1bHQgd2l0aCBSb2INCj4gcGVy
aGFwcz8NCj4gPg0KPiA+IEhpIFJvYiwNCj4gPg0KPiA+IENvdWxkIHlvdSBnaXZlIHlvdXIgaW5w
dXQgb24gdGhpcyBvbmU/DQo+IA0KPiBUaGVyZSdzIG5vIGNvbnRleHQsIGJ1dCBJJ20gYXNzdW1p
bmcgdGhpcyBpcyBpbiBjaGFubmVsIG5vZGVzLiBLZWVwDQoNClNvcnJ5IGFib3V0IHRoYXQuIFlv
dXIgYXNzdW1wdGlvbiBpcyBjb3JyZWN0LCB0aGUgYmluZGluZyBpcyBmb3IgYSBjaGFubmVsDQpu
b2RlIFsxXS4gVGhlIGRyaXZlciBqdXN0IGdldCdzIGl0IGFzICdudW0nIFsyXSB3aGljaCBpcyBu
b3QgY29uc2lzdGVudC4NCk5haXZlbHksIEkganVzdCB0aG91Z2ggY2hhbmdpbmcgdGhlIGRyaXZl
ciB0byB1c2UgcmVnIHdvdWxkIGJlIGVub3VnaA0KYnV0IEFuZHkgbmljZWx5IHJhaXNlZCB0aGUg
cXVlc3Rpb24gb2Ygc29tZW9uZSBiZWluZyBhbHJlYWR5IHJlbHlpbmcNCm9uICdudW0nLi4uDQoN
Cj4gdGhlIGJpbmRpbmcgJ3JlZycgYW5kIG1ha2UgdGhlIGRyaXZlciBzdXBwb3J0IGJvdGggaWYg
bmVlZGVkLg0KPiBDb25zaWRlcmluZyB0aGUgYXV0aG9yIG9mIHRoZSBiaW5kaW5nIGFsc28gY2hh
bmdlZCB0aGUgYmluZGluZyBmcm9tDQo+IG51bSB0byByZWcgc2hvcnRseSBhZnRlciBhZGRpbmcg
dGhlIGJpbmRpbmcsIEkgZG9uJ3QgdGhpbmsgJ251bScNCj4gc3VwcG9ydCBpcyBuZWVkZWQuIElm
IHNvbWVvbmUgdXNlZCAnbnVtJyBhbmQgZGlkbid0IHJ1biB2YWxpZGF0aW9uLA0KPiB3ZWxsLCB0
aGF0J3MgdGhlaXIgcHJvYmxlbS4NCj4gDQoNClNvIEkgZ3Vlc3MgdGhlIHNvbHV0aW9uIGhlcmUg
aXMganVzdCB0byBjaGFuZ2UgdGhlIGRyaXZlciB0byBzdXBwb3J0IGJvdGgNCnJlZyBhbmQgbnVt
Lg0KDQpbMV06IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2Uv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9kYWMvYWRpLGFkNTc3MHIueWFt
bCNMNjcNClsyXTogaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJj
ZS9kcml2ZXJzL2lpby9kYWMvYWQ1Nzcwci5jI0w1MjUNCg0KLSBOdW5vIFPDoQ0K
