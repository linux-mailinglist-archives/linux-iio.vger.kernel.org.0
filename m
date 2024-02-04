Return-Path: <linux-iio+bounces-2123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0A1848BD9
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 08:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB30B1F217F5
	for <lists+linux-iio@lfdr.de>; Sun,  4 Feb 2024 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC338813;
	Sun,  4 Feb 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CWFJuZKT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA5B657;
	Sun,  4 Feb 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707031843; cv=fail; b=Qz1JgEGbG/2OqqCnd7lWb1ayAUjC1y+ISZ4CJNHh1sLgGBHxVKoPfBiZ2hPazRjh2YprO7pJweuRrXTU8+3xnv9IxS+QPwqXohmKnZoOqdYwE93Eek0COxXT/VGooghiemIlwVbdseZRIDFXBk5KyJAlp61otLu1tJeD13rUTwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707031843; c=relaxed/simple;
	bh=GTwAZNNrIuwbRJ2uLSMTeVGVysRcOo+NmhoPNP/7EWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqvykHElfgEaBEcqaphR6scUEpXXu0xMFUFubd3omjz1I18kt0sLnFy9BPznLRYf+FThVoXyUE4BhuD4MQiJWIyS+1V0Xd8MsIhije8YvoqJ+wDCZbbuJtSw58unLa+cCIZiXie/WXVDVY/Y4GqIEgC9eMbOzj1JAOoxCR0cqOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CWFJuZKT; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41441fFJ032641;
	Sun, 4 Feb 2024 02:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=DKIM;
	 bh=GTwAZNNrIuwbRJ2uLSMTeVGVysRcOo+NmhoPNP/7EWU=; b=CWFJuZKTKIRl
	Z48XEu+jpiz6ikfyZVDaSGZuxYL71y+pOiF2mCpWGBWu3h2Dz3z2EdC+cI/YpAbK
	MKcaEQNYg1DfYjrhBtrVFsLT0AquvL9sQc17/0xYeObhXubidhb6fRX+FZDVd7VI
	8PT6G/u9W2Wa8G/pMtgwZpA2EHTBBVKok++of94GTL5JmrkgeMVs3CaqlcImZIgH
	dh7/FGe9Bx2Qxt9y9O7fuz60Pf4+eq7iT1nrxlEkWubIJniLyuQgASj8T7Dqc3r1
	dYKGk5XW9oXqPoxOKD/uGA1qMSynIh7AsP/fR+j5B2GY3UBZwfKTb4Uh3FRINb5X
	x+AAYVb6rA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17011008.outbound.protection.outlook.com [40.93.1.8])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w236rga94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Feb 2024 02:30:10 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MarcOVmOE6SVYyQw+Xj8ZxxEH0SGwG9MHPusgUsove4HrYJj4TP/xB7zhETaz87alC6oZK6wkEFykb5N5VerLl1VaRcDSj8Bnz0BsT5AXExqyTVkX/ZPwkzN1Cz6WkvqMMM9ngkiDkPJml7UzxTaGxHMDhx+vfUH6oNERI35ur3AN3l2OtfRq3QiA+NmdKf9PQ3oIlMvCMvsffZgzwcTDj3cYuEIsV+A9bkRIjfijV+7bi4MU2l1BaHWEIghY9Tm6/eH1Ru5vhsT4R00hhb8A1V/WGX3tjt+WrmdID6KaUBHVlPu1EKVdjrecqmoJr5PPqYD7fMFrQ6ffDo8+asNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTwAZNNrIuwbRJ2uLSMTeVGVysRcOo+NmhoPNP/7EWU=;
 b=Hpay7BsWtbGzGhQLa4Mg1JOO1HmjWYqY7GlSwvvLvzJwLeWSM59WsZDvn0OKcE0cCkDS8Rc9DDRge3/X2ambkD19HChwsIFVKIbOjkHEOzHTZHH96D5Joxt3lzb9Kp/7dD2uzCYdGFFX6oilcGQW9gIL7o+aJDLzqUXn+b4XbOnf3yz4UKrH9nBfwqWe2LHqdCrKVYk9D9p6WFkQKBcldCyDmtXdIY7UZ6iTWoUaPh767sBVun+XiNCJnG1A/CkZOyAXY+qZeZCY9OyKHm4QGDSNxhuFpMhde1xI4gOSDarWhndmWFDytli2Bosggntm0bXmWQlSJUPpKfq1RooecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by DS0PR03MB7203.namprd03.prod.outlook.com (2603:10b6:8:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 07:30:06 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::1238:63d5:647e:4838]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::1238:63d5:647e:4838%3]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 07:30:06 +0000
From: "Sa, Nuno" <Nuno.Sa@analog.com>
To: David Lechner <dlechner@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v8 2/7] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Thread-Topic: [PATCH v8 2/7] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Thread-Index: AQHaVenpC6l/M54N0kqbjvrCJdDLILD3lGGAgAI2kRA=
Date: Sun, 4 Feb 2024 07:30:05 +0000
Message-ID: 
 <SJ0PR03MB677855546629FA8352AC2D4E99402@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
 <20240202-iio-backend-v8-2-f65ee8c8203d@analog.com>
 <CAMknhBHx7U7goWMgygwOA0cpJoPfmCD=8gKZNoBvqcb0ptK0yw@mail.gmail.com>
In-Reply-To: 
 <CAMknhBHx7U7goWMgygwOA0cpJoPfmCD=8gKZNoBvqcb0ptK0yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE16WTFaRGMxTTJVdFl6TXlaaTB4TVdWbExXSTNPRGN0WW1ObU1UY3hZelEx?=
 =?utf-8?B?T0RneVhHRnRaUzEwWlhOMFhETTJOV1EzTlRRd0xXTXpNbVl0TVRGbFpTMWlO?=
 =?utf-8?B?emczTFdKalpqRTNNV00wTlRnNE1tSnZaSGt1ZEhoMElpQnplajBpTlRreE1D?=
 =?utf-8?B?SWdkRDBpTVRNek5URTFNRFUwTURRNE1qUXdNRFUxSWlCb1BTSTVlVTh6T0Vw?=
 =?utf-8?B?MWMzbFhPVWR6V1RWRGNsbEhTbTAxVmtKU2FrVTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVTXpXV0ppTkU4eFptRkJZelUwU2tOcVRsUk5NMVY2Ym1kclMw?=
 =?utf-8?B?MHhUWHBrVVVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRV3hIVkVkV1owRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|DS0PR03MB7203:EE_
x-ms-office365-filtering-correlation-id: e4577c9c-6b5c-46e9-bc83-08dc25531bd8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rSIB9cS7VdipWVIoRv4yDsGA5HCBKCbvdyYBhVzMCzWOT1MUMdnzDzk16GLP6tZwiwa2o9lYUYCf8igzpzP2rSsDdCOfYhfj7YF2KYI1GOPnNGzX+DGQGIInvZfL9ENj44J/87ImRkkCr/WckYRubzB/gsTo4SD03OGy0BCs0E/AGt0T/V2srEzmMXSAolYG2b+PPscVQO7lfGDIqCRJHx+XRNZPkjgd5pUUPKBXZpkOzYVEx472WkD6r7dqkrD04wCIDhp/GaCj2/CHVIGYIGJlqiqodCDUtn2mI9mfX2ilBVEw/IzzIMhnWapJAaGMb9h6qA74p8mZByVAgP7dqOqUbr4YfriE8AOFzD7QiurwrZSevwJZMkOt62KxIqisGthnV4TB9nVsyTFy2qWNhfFRUFLz5W2/Ujwhtbyp1smvQMzsEH9MW6FCFm7uVHApg9LQXlpsMIBUxOGuVDQ3UDRUBWGOjLYQNMhJ2W3BM5p4+rXYPQtLyA5W4IpK4r5WQl2TwscIHVnhHiH/cdh4UMbbAS2tDcs5Dg0onk2R1uLNwVst2BuN7cZrSUcn86Hr/E4LaZP/YyOwhUAADZyIQ6E7G+//CDTh0UZtAw6nighD4ZVZwIxTOgr3f1vyacl2
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(33656002)(52536014)(5660300002)(7416002)(15650500001)(2906002)(41300700001)(38070700009)(9686003)(26005)(83380400001)(478600001)(55016003)(86362001)(53546011)(7696005)(6506007)(71200400001)(38100700002)(122000001)(66476007)(66946007)(76116006)(66556008)(66446008)(6916009)(316002)(54906003)(8676002)(8936002)(4326008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Tk5qaWsxeEM5eEVRNHNpa2pQSWpIamI3dDNEb0tqdWNOTTJkREkycGhqdGc3?=
 =?utf-8?B?V25BbzEvQ2NCaHBkNE5NMEhTMjZ6SHBBeXVTWWhBVTFxVkFQQmk1V005ako5?=
 =?utf-8?B?T1RSdUpNMnJZOFRwQmJVdHFTQjVUMXBDL0ZjZEhFSzJ4L0dFUGFEQVVhc3lS?=
 =?utf-8?B?WExMZTVQNUFQZDFvbVRQRUd4OVN2MHAwUGw0VHc0dWpVeUxyY3RQMG0rMEdl?=
 =?utf-8?B?TFlMMXh4K09vdHRvYWZSS2o3YVhtUjNsU01SSVhOeUtnc1Z5UnNVSVVsUlBV?=
 =?utf-8?B?MnZ2OW5LY0NORkRoSUJnN05WZWhITmMwR2RwRzNOM1NwbjhoL2h6cXVwY0hu?=
 =?utf-8?B?TE4rY1lqd1dEOE5yZTBnMGRJaXNwY3gybUxxRFdlM09WbGtVL3h4cHNQSSs3?=
 =?utf-8?B?dm9XL2xXZEhBUjZXY0VjclRHSkk5OFk4RHIySVZiUWwvNGZNSms2d3pzTWI4?=
 =?utf-8?B?VXJVOGxnbUhoSU5SYklDSmV6L2J3andob3JnbDZqWDJFZjVqcG9KSm9LeU5p?=
 =?utf-8?B?ODBQNWZnRTVrN2NaV050ZUtTdnVma0RZek5LU0ZHRjBuQ3ZpSldHb3dmb3c2?=
 =?utf-8?B?a2VlWDRBd05nNStPNks5WDdkTVN2azZkYzdRcnJLQlNFbVBhN1pLbGdCejBx?=
 =?utf-8?B?ZEFyZFBHK21WdmJwaHBOaVlKb3ppWHNvN0RzWEtBVHpXYWgwN2ZOMzFwV1pk?=
 =?utf-8?B?MHBFMEp0YVhrYVI2VG9GWGRmcjVoZFRiU28vTmJISC9lTVYyaExGM2VBSFd3?=
 =?utf-8?B?Y2NnZkFUV3hweWFlSjBxcVpsbW9BWTMyV2x5M2xMc2lsSkFmcFZnc0RJeUh5?=
 =?utf-8?B?MUd0RFhTYkdYRE1QbXVMaGd1MUdIZHFNSXU2Zys5S3ZJZkhZY1hja0VubFZw?=
 =?utf-8?B?eS9wY282dDhuY2tEMUJlaE13WTdTNlE2bWxpUU5JbW80c1hDazIzaVI4YUt0?=
 =?utf-8?B?Y3VvQ25naG5ZYjNSZFdBUFJTanNSdDd5b1ZkVVJWTzB5dlREM1c4TEJ3LzZy?=
 =?utf-8?B?MXNKWEplNmFEdEVIUG9QM0JkcG9IdGRpcC9haDF4VVFBT0pqZDVhRncxMlpQ?=
 =?utf-8?B?R3NqQTkzWGc1bjZXaExsS3FOR2pkZkRMRHVBejAwSWRCeUp5L294N21rODNu?=
 =?utf-8?B?YVU3ZFdsZkNQbUlmNEZWRmRscjN6NkVFRzJnWmxjVWs3blJxOXRIR0hMcCsz?=
 =?utf-8?B?WWliemNRSFp6N2FJMVNlRjRJU2lTMlpFSkVTNFJDWCt4V2VNMjJqTzZ3aU8r?=
 =?utf-8?B?d1JuUlhOZ3ZaY1VtQ2VyY0cwTUVNVUNvLzh5OWh1cFI3RTRoSXBIaCtmVGlM?=
 =?utf-8?B?ekNDUS9ORjdweTdrUG05SThvWGVnWjhzTmFOa3RVS25TNy9qbk5iQ1Q4WEJs?=
 =?utf-8?B?VDNjYjdHang2RjNMdWxZMVNXck9Qc0dqbXpBUTVjNmdiT0x4bHhRTVc4aFU0?=
 =?utf-8?B?N1Ivc05rM01tamp6MCtEbUc2bll0NW9ONTJBVlA0WDNSaVhRTjdIb1RyYkwr?=
 =?utf-8?B?RDlFVHJYU0Z6LzlRa1ZBd1BTT0lXWEdpeTlQTVhHRzVBbnBhbzd2dlIvQ2ZG?=
 =?utf-8?B?elJ2eDF5c3h4VlR6YTNRSDZ6NytDZWFXUXA3c0NLek1xMXc5RmF5RE51dWd3?=
 =?utf-8?B?UGV6Zi9DN2lrMG1tWnYyc1RIbUJDQjNwNnJrTUNLaXhwdkpnanRMTTY4cFJR?=
 =?utf-8?B?THhMQ2gyclcvMnIycnZOYVZXZE5udTJVZ21WV3Q5RFZLQ0duamIybDlJT1l2?=
 =?utf-8?B?eTVWUC83TUVsaXU1a0hYT0RXb2twZTVLaGV5cEl0ZDBZQkFlMFFSSi9GaVNI?=
 =?utf-8?B?eThzdHI3RElVV0UxeHJUUDAvZkM4RmlWSHp4ZCtTQS9CazA3eE40WnE1S0p4?=
 =?utf-8?B?ZFppdGsyMVorV3VxeUY2bWtPcGt1Z2ZhTkhwSVhWcFFiM3VjT3Bsdjh0aS8z?=
 =?utf-8?B?OURnQUNKRkt6bGs1Z1lucEhyRytBTHVhK093d0NoaUs3eEVPZlUybG1SNnBK?=
 =?utf-8?B?NmcvalBTa0txUjM0cFh3VG5wUDRaWmhGNGNTWHpFZlNpUHJaRkUrSGhhNHpC?=
 =?utf-8?B?YTFDdENvcHUrWlorQUs1eXljeUJWTmZJMFlqc1FVaUxqdDRFZVZNYkRnM0ly?=
 =?utf-8?Q?s5r4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4577c9c-6b5c-46e9-bc83-08dc25531bd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 07:30:05.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5I+mZOB7z0Nr/YbXTAsZ5ZjGQO4wqVR7rTVp+84w063mLXMAvsznQ5afd++zrc/Mmq0/oe/H4XrlL2p56s08hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7203
X-Proofpoint-GUID: ndQZTPQJaRK9d-wFJVWtm1bPLt207gx_
X-Proofpoint-ORIG-GUID: ndQZTPQJaRK9d-wFJVWtm1bPLt207gx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-04_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402040055

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhdmlkIExlY2huZXIgPGRs
ZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAyLCAyMDI0IDEw
OjM4IFBNDQo+IFRvOiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPg0KPiBDYzogbGludXgt
aWlvQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IExhcnMtUGV0
ZXIgQ2xhdXNlbg0KPiA8bGFyc0BtZXRhZm9vLmRlPjsgSGVubmVyaWNoLCBNaWNoYWVsIDxNaWNo
YWVsLkhlbm5lcmljaEBhbmFsb2cuY29tPjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2Vy
bmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+Ow0KPiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBDb25vciBEb29s
ZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBGcmFuayBSb3dhbmQgPGZyb3dhbmQubGlzdEBn
bWFpbC5jb20+OyBPbGl2aWVyDQo+IE1veXNhbiA8b2xpdmllci5tb3lzYW5AZm9zcy5zdC5jb20+
OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4
IDIvN10gZHQtYmluZGluZ3M6IGFkYzogYXhpLWFkYzogdXBkYXRlIGJpbmRpbmdzIGZvciBiYWNr
ZW5kDQo+IGZyYW1ld29yaw0KPiANCj4gDQo+IE9uIEZyaSwgRmViIDIsIDIwMjQgYXQgOToxMOKA
r0FNIE51bm8gU2EgdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK251bm8uc2EuYW5hbG9nLmNvbUBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IE51bm8gU2EgPG51bm8uc2FAYW5hbG9n
LmNvbT4NCj4gPg0KPiA+ICdhZGksYWRjLWRldicgaXMgbm93IGRlcHJlY2F0ZWQgYW5kIG11c3Qg
bm90IGJlIHVzZWQgYW55bW9yZS4gSGVuY2UsDQo+ID4gYWxzbyByZW1vdmUgaXQgZnJvbSBiZWlu
ZyByZXF1aXJlZC4NCj4gPg0KPiA+IFRoZSByZWFzb24gd2h5IGl0J3MgYmVpbmcgZGVwcmVjYXRl
ZCBpcyBiZWNhdXNlIHRoZSBheGktYWRjIENPUkUgaXMgbm93DQo+ID4gYW4gSUlPIHNlcnZpY2Ug
cHJvdmlkZXIgaGFyZHdhcmUgKElJTyBiYWNrZW5kcykgZm9yIGNvbnN1bWVycyB0byBtYWtlIHVz
ZQ0KPiA+IG9mLiBCZWZvcmUsIHRoZSBsb2dpYyB3aXRoICdhZGksYWRjLWRldicgd2FzIHRoZSBv
cHBvc2l0ZSAoaXQgd2FzIGtpbmQNCj4gPiBvZiBjb25zdW1lciByZWZlcmVuY2luZyBvdGhlciBu
b2Rlcy9kZXZpY2VzKSBhbmQgdGhhdCBwcm92ZWQgdG8gYmUgd3JvbmcNCj4gPiBhbmQgdG8gbm90
IHNjYWxlLg0KPiA+DQo+ID4gTm93LCBJSU8gY29uc3VtZXJzIG9mIHRoaXMgaGFyZHdhcmUgYXJl
IGV4cGVjdGVkIHRvIHJlZmVyZW5jZSBpdCB1c2luZyB0aGUNCj4gPiBpby1iYWNrZW5kcyBwcm9w
ZXJ0eS4gSGVuY2UsIHRoZSBuZXcgJyNpby1iYWNrZW5kLWNlbGxzJyBpcyBiZWluZyBhZGRlZA0K
PiA+IHNvIHRoZSBkZXZpY2UgaXMgZWFzaWx5IGlkZW50aWZpZWQgYXMgYSBwcm92aWRlci4NCj4g
Pg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGF4aS1hZGMueWFt
bCB8IDggKysrKystLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYXhpLWFkYy55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvYWRpLGF4aS1hZGMueWFtbA0KPiA+IGluZGV4IDk5
OTZkZDkzZjg0Yi4uYWRkMTBiMjJkY2FjIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FkaSxheGktYWRjLnlhbWwNCj4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9hZGksYXhpLWFkYy55YW1s
DQo+ID4gQEAgLTM5LDEyICszOSwxNSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgJHJlZjogL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICAgICAgZGVzY3JpcHRp
b246DQo+ID4gICAgICAgIEEgcmVmZXJlbmNlIHRvIGEgdGhlIGFjdHVhbCBBREMgdG8gd2hpY2gg
dGhpcyBGUEdBIEFEQyBpbnRlcmZhY2VzIHRvLg0KPiA+ICsgICAgZGVwcmVjYXRlZDogdHJ1ZQ0K
PiA+ICsNCj4gPiArICAnI2lvLWJhY2tlbmRzLWNlbGxzJw0KPiANCj4gU3RpbGwgbWlzc2luZyB0
aGUgOiBoZXJlLg0KDQpBaGggY3JhcCEhIEkgd2FzIHNvIGJsaW5kbHkgYXNzdW1pbmcgdGhlIGVy
cm9yIHJlcG9ydCB3YXMgYmVjYXVzZSB0aGUgcHJvcGVydHkgY291bGQNCnN0aWxsIGJlIG1pc3Np
bmcgaW4gdGhlIGNvcmUgc2NoZW1hcyB0aGF0IEkgZGlkIG5vdCBldmVuIHBhaWQgYXR0ZW50aW9u
LiBUaGFua3MgZm9yIHRoaXMhDQoNCkJ1dCB3b3JzdCwgdGhlIHByb3BlcnR5IGlzIG5vdCBldmVu
IGNvcnJlY3QuICNpby1iYWNrZW5kcy1jZWxscyAtPiAjaW8tYmFja2VuZC1jZWxscw0KQm90aCBo
ZXJlIGFuZCBpbiB0aGUgZXhhbXBsZS4NCg0KSm9uYXRoYW4sIHNvcnJ5IGFib3V0IHRoaXMuLi4g
TGV0IG1lIGtub3cgaWYgdGhpcyBpcyBzb21ldGhpbmcgeW91IGNhbiBmaXggb3IgaWYgeW91DQp3
YW50IG1lIHRvIHNwaW4gYW5vdGhlciB2ZXJzaW9uLg0KDQotIE51bm8gU8OhDQoNCg==

