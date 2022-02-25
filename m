Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D52E4C416A
	for <lists+linux-iio@lfdr.de>; Fri, 25 Feb 2022 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiBYJ1X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Feb 2022 04:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiBYJ1W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Feb 2022 04:27:22 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590CB369FB
        for <linux-iio@vger.kernel.org>; Fri, 25 Feb 2022 01:26:49 -0800 (PST)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ONrRbu010237;
        Fri, 25 Feb 2022 04:26:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3edu7m8a5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 04:26:38 -0500
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 21P9Dteo016722;
        Fri, 25 Feb 2022 04:26:38 -0500
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3edu7m8a5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 04:26:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFasyYVtP37HvquCbe3R+JsXiMnOFLuZi9wOJg+FD6pDZd1JCcbqc8aqzzm7gQFXNZ32Fj5/r9PSRMt3wZdsoTm2ZPSNV875K40Wyurmjc3PsS9s/Kw+xWvXHOL9Ws+oRYHgZlailTvZqabyspmY9Zjum6b/fzyvS8qKtnIv6DElwMUmzavm+JZi6Isghqs+fiv2b3AEKjQiSkrjByXXc5gm3DmfevxVKMtVFudscxm+FojZivac34FejkGOP4e0+7/YB3jhTMUf/3PklKQ5/8DDrW7y7vWB1iupQDtWDb22IpKYOQOaDGulLGwNWIcKfeWLCBxnsriEc3Wq6y2ePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RFqfWvQoCjVHKMmbmf7W+cEOevq5HOie0bpSlO+MiU=;
 b=HD9Ywwo8Lv9NdZpfZ/hnfl5huWOHbROANLvVm5V5ED/Zf06HoF7YxWPyXCka2IPVkdF4NSU7ExPsixC8bw5XsaxhTwdK7pTARv31IjtPjoLqRAbTbkRv+faBXtKRnkZIRycGggUwbzhz3m7ATGwmKe7/jhZCz4quKFDbHiJya/NpUO4SPlMOfMza8JPEQR74BzxtBJYqXJwA3V0/u/h0ifC8xJAEvAA2kDd4PI7Z/MpldePTIhy4y8nGFtLagW9acOIyc4/JKahBpu+mrJMraT2EOlIb7uzr1mMJY3YzM4Oqnl4uUbiqtNNtVOu7fYJJhoK11FYRGdXIuyaaJg9VPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RFqfWvQoCjVHKMmbmf7W+cEOevq5HOie0bpSlO+MiU=;
 b=zjepRpTvqKLrhNwveTf1TmRr7BBrYzntoAmTRvokTKi6U/pnxVREL+t1zTkakAuhLrFtFg3W9bspeU2BBlpItpS943scKiCwcLT488LVWX9hHCYhrND+/9YhyjYAZ3NjpYpQic7x5VIrjk1fgqZgrG3SvaVxSp9pcHPOFqYqJ/4=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DS7PR03MB5606.namprd03.prod.outlook.com (2603:10b6:5:2c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 09:26:36 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 09:26:36 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 4/5] iio: adc: adi-axi: Move exported symbols into
 IIO_ADI_AXI namespace.
Thread-Topic: [PATCH 4/5] iio: adc: adi-axi: Move exported symbols into
 IIO_ADI_AXI namespace.
Thread-Index: AQHYJn+R7cACStrJRka9ZtZ8SJaLxKykBexw
Date:   Fri, 25 Feb 2022 09:26:36 +0000
Message-ID: <PH0PR03MB6786A1AE7B59F663C9F263A9993E9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220220173701.502331-1-jic23@kernel.org>
 <20220220173701.502331-5-jic23@kernel.org>
In-Reply-To: <20220220173701.502331-5-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1EWmhZVFEzT0RFdE9UWXhaQzB4TVdWakxUaGlZelF0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEQTJZV0UwTnpnekxUazJNV1F0TVRGbFl5MDRZ?=
 =?utf-8?B?bU0wTFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTVRBeU5D?=
 =?utf-8?B?SWdkRDBpTVRNeU9UQXlOVFEzT1RZeE9ETTRPRFUwSWlCb1BTSm5RVVY0Y1Zo?=
 =?utf-8?B?dlNXdG9NamxxY1hSWlYzUjFTREZpUm5WQlNYYzlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVRkhabEZNU2t0VGNsbEJZVVJoUmtsaWFrTlRWVUp2VG05VmFI?=
 =?utf-8?B?Vk5Ta3BSUlVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
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
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9591b36-fe14-4bb1-6600-08d9f840eb72
x-ms-traffictypediagnostic: DS7PR03MB5606:EE_
x-microsoft-antispam-prvs: <DS7PR03MB560625411A953E9F040944D0993E9@DS7PR03MB5606.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F104LB1LGvTGbuuEhyoJacpYMXFkOkKs+CpQ4zqErcV0B5Xczh6NZ2hdRyGFDr/Zuq4yzXPi09x3KeTiLMJX3r6i6viP4hWEFvKCEgktTmNAFvb2cEwsncf9P2p21gqJBw8HdIk2xyKjvDfNi+PF+wfQHvrMTNPH4nWdBwuIi9n1bwI/8ubOyuisORiQsdsK0mjreuz+LpNJykX4pZNmU0QpnTOpfUlPNtUBMnUjfZ3Atpl4PSrgSwQpF3jN8UEiX+9jUG+8LaC2BFit6Ez4t3BElEryDkhCMfqyPY1kq2PqhpJy6j+KD1Hxmu6gUDrqTS780f9f5QzTPN4pkRiRPZfFha9S/MWefSQTJHYR1wttjOTgd50S7c/SXMtBkDumD0IFVrXvtPrBRacIF+jqumqSRlDB0B3zyzZdfqGb9Kn0zP3rX0rioM3wtS+R3liTey3z3Y0xuzFoIUlp+HPmZvKDlk9RIgjdsg5sptAmA4FHHGP/Zu2fGEaQH32awUAjrUdlz3MGN1lqSwjXcWkzv3zxjrJTFL4PeiP5s74wPPrVrjZRfdifZTOTwdiKDhx2DxIu9DgvTem4Uc6FPbpLTXt90hY12DlPJpniM6oWKhBJWEtb8+Uiqz/MsRrlrJc4cj/njIyX2nTyRr+09XXZSrDk+SRFMjY5rUFrrtBcaaKfOQvCWiDwMTc3A9MFIbmdUKI1a4jmvqJ0k/z5tbRsb1/6x/bBufbaAwKwTDFTxfC94yOiCi/bKfTfV+ji7lwPZBfnkJo2q8BH+kQCOiqhOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(55016003)(52536014)(966005)(508600001)(316002)(4744005)(71200400001)(8936002)(122000001)(76116006)(8676002)(9686003)(66476007)(66446008)(64756008)(66556008)(66946007)(53546011)(86362001)(4326008)(7696005)(2906002)(5660300002)(38070700005)(6506007)(186003)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzExSmJFbVZ4blhKY0RLZHBWNmdtSkZhSmFzMDFzZ0srZ2g5anByWXBIdlB2?=
 =?utf-8?B?U1k4bzVFdndydG1HYk1EWTIvbkJaanh0OVVzV1ZNZjZNTE1QV0FnZ3RkUmI4?=
 =?utf-8?B?WktHdnpzU1g0WWhhSU1iZmVnUFRBSTFaQTh0MSt2Rzhidlh3cWZYMFBEaG9D?=
 =?utf-8?B?cmxPMm1DaWZkNzFNOWg2VGw3WUVFaW5YcGxlNFBSTWJaNE96NEpQOWZ6WUpi?=
 =?utf-8?B?RDFtNERQT2tBVHcxL1ZSRkY1MTR3Mk9pbjk0NEQrWVpVbEQ0aEtoZG15YzY4?=
 =?utf-8?B?U21OZ25uRm9hUStieWw0QXI3L0xCYzZEUTZDSzV3NE0ySHhUaFEwN1hDKy9z?=
 =?utf-8?B?elpMWklnZVdPQmJraENHMXVhUW5kMy9oS3BJK0VBRnlHR0tSUTd6STc1Lytm?=
 =?utf-8?B?b0M0OFpvSGpOaVZwVUpPS2E0aHhOUnFDUnRUY0R0T1M0MGhpV1ZFYzNDRjZu?=
 =?utf-8?B?RG04Z1dsQjN1Rmp0RVdydDFqcVE1dHVxamNMNkpWMWZ0KzZlbG43MXBJMmhL?=
 =?utf-8?B?VEh0VVRvako1S3lNd1pLM0ltVDFQcHpRWUs5L3FRVzUvcmgyNFJ2TFFQR0tZ?=
 =?utf-8?B?eTFWVkEzOW1NZHpZN254V2RKTSsyc3RGaEpDK3RvQ0paNndVQ0hNRFBCNHlJ?=
 =?utf-8?B?T3hMNXZiZmFGSGU1WUxlSFYxdCtGenpWV1djUGpsU1ZsNG1XTHlleDNHM0Qx?=
 =?utf-8?B?N2R6NlpNaWcvWUlTOCtYc0NzbnlQWEM1TjdnaUF0cVhYR2NLOGxVbFNxNTFi?=
 =?utf-8?B?U1JTd21EWnpOR0k4eWNMd2gwcytsK2ovUFVYZEJQRHU1enhuUVRONkpkcmd5?=
 =?utf-8?B?ZmhPdVFlN2xXM3BlaG96MmF0QTBxb3FMOUMvQ0pMMGpzYlJXZnZ1TXNvb1Qy?=
 =?utf-8?B?VmtUSGJzaEVtNHNwZWNDYi9CbzQ2T2tGbnJ4ZjhjTnhrQitjNVkvbDJscVdI?=
 =?utf-8?B?ZlVHakxIMFNxSU1hNFh5K3JTVUZTWlBTWGc5dWtiNFZrUVNGMzZ1ZDVuN1ZZ?=
 =?utf-8?B?Z3dkUTg1cnZpWEd0NXR0L2V1TXVlWDdmL0JBZnpabmE1OFIxUHpWa0piMlY5?=
 =?utf-8?B?NG4wTDVDTWIxZDd1eHNQOXhFYitiaktlN2hoWSs2ODJIL2xwT1NlWXdCejgv?=
 =?utf-8?B?VkIrTmRQTTRvMkUrdzI4MzdrTlVOeUQvc29PbkN1ajcxWlpIMURRaXdvU3gw?=
 =?utf-8?B?R2pXNFJCMnppRUE2YThzMzFoSlp2eHI5TFN0elFGYWhBcTdQSW9OR081SXIw?=
 =?utf-8?B?QlRXdG5LMFNlWVgxQ0hwYXo1Q3dOcjBsTzJGVFIxRnlGUmlNYytOQmZwOWpB?=
 =?utf-8?B?dDJEemtFRDF3NnVIZjd0bjRmdE1jdmpiNkVsOEZ4TmhVM01rZ3Q4Yk44Nk5t?=
 =?utf-8?B?WUVJbTM4V214cXZCQ0EzWHUyVnJlZmxXdDFiczVGV0JNVE5pM29FMnlMd2FX?=
 =?utf-8?B?QnpHdk5ITWJacmQ1M01Rdy9FT1drM2ZPT2U3SldMZGtIaS84eTdVbUtxRFRN?=
 =?utf-8?B?bUlBbnNYaWdMYm01M1lpTmlTOE9pd2RrUmNrMGxubjJmWHhJYk95THZhUW5j?=
 =?utf-8?B?VTdlaXRzMy8rUUJDR0pscmZyb0wzaXhCa3d2N0RnckVQSlRla3dnd1hacXhy?=
 =?utf-8?B?aFdoNHFkd2d4SmhsU2c0TzFGbkVOOFFRdDNQSmNaN2Nvd3J3ODdhL1dLYXl1?=
 =?utf-8?B?R25xVmZ0ckJNMGFLRzY5c3k3VXlEYXNMS2FiWkJNeGFGcHp3cTBtSzI3R0RI?=
 =?utf-8?B?emsyWE5ZVGdCTlc0Y1JxbVIvNlppRFFPTXV0U1F3SjZTbE03TG9ZVEZFb3o0?=
 =?utf-8?B?eEY2bmNoQWU0MS9wTkI1aWRpU3JHNllVWmpURWRYL0dwVlpzN3RaL1crT29C?=
 =?utf-8?B?ek4yRkNEc0czMmZ4R1F3N29yU1h5MWppRE85ZjVFQklqc251anJvTldXSmY3?=
 =?utf-8?B?OTNMWUlZbWo0NnpiS1diZG5DM3NyTk5NZkFZRzIrL2U5bnErTktnYmZOQmFq?=
 =?utf-8?B?NFpoN0gvUmVZVE4vcDlGOFcxSUN3aElFOVFzOEczL05udWRoRTYrbXkzRCtL?=
 =?utf-8?B?STFkb2dxU0F2SG9rUnRyOVgwb3VkczNjYkdEQ1Zqc0NmRnlYT3Izc2pQRkVF?=
 =?utf-8?B?ZWt1ZzJjUk1jbkVqOURvakt5K1NpUStlUXhqZVdIMlhsRllHUjBFbnpQNlJD?=
 =?utf-8?B?bUFnc0p4eHJlaTRjQzZEMXIxWW1HeDdNcllUWEsyRTZxVENQa3hQME1EcHdH?=
 =?utf-8?B?eFk5NHI0cUtXekVhVi9xUGFNUHpBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9591b36-fe14-4bb1-6600-08d9f840eb72
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 09:26:36.0749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFDvSRc862t8TM8n8b9T9YMcSPzG+gQkez9MPc97N/h+Iv8ZUgSMLQmiE1ubbFroYcIHzxEA6d62xDLlPyFUDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5606
X-Proofpoint-GUID: OmW_8tz3-gQWTmdeWMlCpLZ-t2V23iUx
X-Proofpoint-ORIG-GUID: ASYjnwAMtvP26SvoqlLXMm47FZaaebMA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_06,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 mlxlogscore=857 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250048
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQo+IEZyb206IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1
bmRheSwgRmVicnVhcnkgMjAsIDIwMjIgNjozNyBQTQ0KPiBUbzogbGludXgtaWlvQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWku
Y29tPjsgU2EsIE51bm8NCj4gPE51bm8uU2FAYW5hbG9nLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IDQvNV0gaWlvOiBhZGM6IGFkaS1heGk6IE1vdmUgZXhwb3J0ZWQgc3ltYm9scyBpbnRvDQo+IElJ
T19BRElfQVhJIG5hbWVzcGFjZS4NCj4gDQo+IFtFeHRlcm5hbF0NCj4gDQo+IEZyb206IEpvbmF0
aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gDQo+IEF2b2lkIHVu
bmVjZXNzYXJ5IHBvbGx1dGlvbiBvZiB0aGUgZ2xvYmFsIHN5bWJvbCBuYW1lc3BhY2UgYnkNCj4g
bW92aW5nIGxpYnJhcnkgZnVuY3Rpb25zIGluIHRvIGEgc3BlY2lmaWMgbmFtZXNwYWNlIGFuZCBp
bXBvcnQNCj4gdGhhdCBpbnRvIHRoZSBkcml2ZXJzIHRoYXQgbWFrZSB1c2Ugb2YgdGhlIGZ1bmN0
aW9ucy4NCj4gDQo+IEZvciBtb3JlIGluZm86DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNzYwMDQ1L19fOyEhQQ0KPiAzTmk4Q1MweTJZIXFq
N2xhTTBxS0Roc0ViMXNZalRhY1RHLQ0KPiBtbzdrZUNselhhb1hweW1aSHFoOUxWM2hmWElnUjAx
b25TVDg4dyQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFu
LkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gQ2M6IE51bm8gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+
DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0K
