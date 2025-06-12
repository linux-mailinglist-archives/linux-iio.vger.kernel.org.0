Return-Path: <linux-iio+bounces-20527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A48AD6945
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 09:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2BB3A7653
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EE621324E;
	Thu, 12 Jun 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bCIBTLbx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AC1E51EB;
	Thu, 12 Jun 2025 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713930; cv=fail; b=kJTHMzjVjdflrP25zWbHqxeQPmAuwupm08M1VWkBUPFSDNCLLJrhORUb9K7VI8PSJBuhuRzUebD4nHdwb1cq4atEIhHXQ52Be2jqf/tv+KZxcESKqg725tabpTKGBHVelP9AjdDPrzRuWSb8EgBNQ+XWaXOqEKBYQYe8CZYaeuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713930; c=relaxed/simple;
	bh=+8T/AqOnXMEE7P5k+JUZh5/vz2KouOcFaZXTh3q34oE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LxHTpzZB6hplGZBhNdh1wTnHZK/KqW+gkCllnFcrlCUqK03D1zXfxHZ6EJ6/TQzZhMyB1aaDbwpcPvgAHsGmVSHIVaxWgjU0JfvGm2Fa/kswqzfs7rwIj+5yteYn6SkV33+Kx6KjhZrkIxA6JQvfWRkOIUFHqdJVWdZd/IoapZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bCIBTLbx; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C2av8d014807;
	Thu, 12 Jun 2025 03:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/kNJn
	hj8s994FS2vviQ4moM2PhJTga+5hADCCOGBOAo=; b=bCIBTLbxU9hZZxVqsDpPO
	LDdzFAp08iOuwZs1RJUEW2uQakm1elwOd49BJZjxFx8qyvfapYDoCMRFSL5NcUDb
	Tr9wQNWQBfAkWmMgDdFcijpoHpq7wb4IuvPD6u3LNMEmW76+3/4W3tT64aTBLQ+s
	Ms5B3FgR5Sv+wrz1zHlD2t5YFB2SyLjTE0MFP3dXZNuioCl+Mgjy3RRUqb4VVTL8
	Kg7ON60hwQpuEvYTQza39zmYTMXwn/zhhgjezfZyH+IyQnGAiMqLCBxIaH8HIYaM
	Q+JrcMo2R6LiS6VLxOZ7mQXcm5jfmcEHsKhXB1t0ZUGnRlns3PAKixUyTkuswn3z
	w==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4772mcef5y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 03:38:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6MFeOqQOBa2UbPBBzRKDEfOcteI9w5lgmcGb48qiFuBaYqI/es5wrkY6k/pdJnxXQcxuEes2E7HP1h72dk9+ubmCdNoPeLrQBcFHy3NNvOdRwKjUlSDnik/jp5b6V7FJVdiPZhMhEqgOGNisxFyp5Dmd5UgCv9FbqgmmspgwNk9M4tbZho8f0KKXnfJdwRLVgRi01TNn4Na0qwRnEwDd8dLveQ4At+R7ngwZFA0j6J3isjs5gW2YIDkI8guJ8ktolBdMblkwCTFrGdb3URqBXCisXIhFEcOLweBBAMcW9Kmycvnl/IDC2VG25hFNC9uDo9zdql+gD8p4DDGjwoVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kNJnhj8s994FS2vviQ4moM2PhJTga+5hADCCOGBOAo=;
 b=g+JWlBeTph7rBc1GWnyGywrNdRP7mcatjVmAeP3KnLCIhO75dLXSNygMUSHtq9O+KKnc8tJ1KELDwDPSx3bHu/H59Xbpk3MvKLmBjQSyCUpjt4+hxoCpffEdk8nOF9+vteQ44ofQAE2+oHLErCb/fX4XNrvMI13rUA5s/AO7oquj1AT6nhDMsIWF0ff3JUjAcQUf9VrJkAmZaLO1jZSKhzOVa9xBhNMDgpn+WmbB1Ch/2koM9+XnbFbiRUlMkb6eLht68Z3Qqac89i3hcQJSaHY6gzIMp7wVCfVqYdSB4tzF7sV0jpsn5Sxwy6KuaOBYUJeZSPzSJIQUWoPXQio2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6335.namprd03.prod.outlook.com (2603:10b6:510:aa::13)
 by SN7PR03MB7295.namprd03.prod.outlook.com (2603:10b6:806:2e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 12 Jun
 2025 07:38:08 +0000
Received: from PH0PR03MB6335.namprd03.prod.outlook.com
 ([fe80::6e6d:c16e:3cc5:93ad]) by PH0PR03MB6335.namprd03.prod.outlook.com
 ([fe80::6e6d:c16e:3cc5:93ad%4]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 07:38:08 +0000
From: "Ioan-daniel, Pop" <Pop.Ioan-daniel@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "Miclaus, Antoniu"
	<Antoniu.Miclaus@analog.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        adureghello <adureghello@baylibre.com>,
        Guillaume
 Stols <gstols@baylibre.com>,
        Tobias Sperling <tobias.sperling@softing.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        "Nechita, Ramona" <Ramona.Nechita@analog.com>,
        Herve Codina
	<herve.codina@bootlin.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Thomas Bonnefille
	<thomas.bonnefille@bootlin.com>,
        =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?=
	<joao.goncalves@toradex.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 5/5] iio: adc: ad7405: add ad7405 driver
Thread-Topic: [PATCH v7 5/5] iio: adc: ad7405: add ad7405 driver
Thread-Index: AQHb1iwW/mxdmKlf10i9kTZdlYz6rrP32cIAgAR04YCAAc8KgIABDJeQ
Date: Thu, 12 Jun 2025 07:38:08 +0000
Message-ID:
 <PH0PR03MB633588C429595BB9AB9827F1D174A@PH0PR03MB6335.namprd03.prod.outlook.com>
References: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
	<20250605150948.3091827-6-pop.ioan-daniel@analog.com>
	<20250607164428.7a245af5@jic23-huawei>
	<PH0PR03MB63351F2AA87604CC10BB6EC8D16AA@PH0PR03MB6335.namprd03.prod.outlook.com>
 <20250611162507.6868c8c6@jic23-huawei>
In-Reply-To: <20250611162507.6868c8c6@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6335:EE_|SN7PR03MB7295:EE_
x-ms-office365-filtering-correlation-id: 8ec7e969-4cf1-45ee-ab04-08dda984137f
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vv4uhpLjGYLBFYajjFtmeMKSYnNYVQCfo6KwzVu4yY/Wvp3V9ou2qBWJGt?=
 =?iso-8859-1?Q?bGXRSMO8gyz3xGllqrfXAUR4ceJ1GQlvwbWlXZQ46ngOJfbn2UwErLGPmH?=
 =?iso-8859-1?Q?HVO4Z2RFWbyuifCdAXfjfN18mPAWVodS5h9q5A3fxLcrJ2zqMioTI5U6L7?=
 =?iso-8859-1?Q?5BMSYqV9o+UBcaGs57pevdBD494TfapHZ6+bEIRxqYcJxT5DMrURqaxMaN?=
 =?iso-8859-1?Q?lVA/D1o9cca8O+onwijYGWm6vJXKka1fZxUZyeiU/2UNgPeSDyoqapv2s0?=
 =?iso-8859-1?Q?fIw3TGkvfyfkwkHhM/f0Ev+H6ibTpUuzgYnUhKzEYGwnb30Yn+ZvJI3qpL?=
 =?iso-8859-1?Q?aJyEZZ7k5z7Id9TdP1ETCYbRVs5Kmsbh+CAg2t3o7gG3b/EZUAO7QVUL/E?=
 =?iso-8859-1?Q?F59Unrz3SQeJamzzk7cmW6itMSH05oW3byNwwlBbz6xi0OJKkvlLtU79sI?=
 =?iso-8859-1?Q?1e+i0prnjzVjf4Ua3kcKnTZ83AVmEKcbjDDP3cS8qHEK8Xwv1CF67ZnI8B?=
 =?iso-8859-1?Q?YFJ1D5BCQ9hgWjHUHnnN49kGBQWpGEU639NZK585UV2EwnUJCsX9s3H7mS?=
 =?iso-8859-1?Q?6EDBwOgrcG0CxHuxifYult2U/RBadQUSPf879E8ppVuBHk8LmySIfrh0Zk?=
 =?iso-8859-1?Q?Gyr1imoNnfpIlOzr0RIfKU2bfzXhm6aUNt4fKOioJeX+o2FBmDgIoaXOcl?=
 =?iso-8859-1?Q?7sgh+HjjfrwLKqtYkxUqFX9R47TRDa84LbnPB0+eL88yfIC0BbX86aOp9G?=
 =?iso-8859-1?Q?1QoM46i6z2Him2b9w8zbf6Ee8BAGF5P4YoKjb3F/gA3gabLZIcN3KzJNcD?=
 =?iso-8859-1?Q?pmIK4d0Bx9zzu6GgW9oq6YG1K1hU2suLYxJOt25+c7rRPFBEIwZHf2VpZk?=
 =?iso-8859-1?Q?XrAV/UUKOtYdljXOtoyHlUaoQHX23t1viMxSnYAodOZSVAH70aYGVMsiLM?=
 =?iso-8859-1?Q?h4zY+1lp6UgrPAZL5jTjH/SSFb/6MacrnkW3lA/c2EvPtsx+9wgRKYGlOi?=
 =?iso-8859-1?Q?IyjTO6nMNd6gIfQe5tjyPPkYh9SY6h9ix8J6TWv3rHySR0jKcWfcv9U46V?=
 =?iso-8859-1?Q?9/Q9DIje41AO2x5AqKFCJUhfl5XSCnREsSWtrVP+Krgjmg9lgKnC8qf7Mp?=
 =?iso-8859-1?Q?lDkywbXeCKR4xT2leYsHdEzvGwwlGGU/ygfH7qKd38DEqfSOzzdzU2y3nD?=
 =?iso-8859-1?Q?Iny969qgFmDmnqVQJdVQNHBtneOlIgK5k1uK5KAl+3WECuPGIcvk0tlh8f?=
 =?iso-8859-1?Q?M0OgPW01OqlOj47UQ9o7zcyt+gbKFZPRlto0q5/zi0WUf3+GqueeWxF7Gn?=
 =?iso-8859-1?Q?LD/aBI/Hbsn3XwVAwLa8FsXQ8pffnvcJmJaj2inM4OHYFA9ytahBuapvtG?=
 =?iso-8859-1?Q?g5fg0zoIWcPjwwJ29qJrbi4+Fort5yqk0S3ixPZahi2xan+zW/QgHW0QmO?=
 =?iso-8859-1?Q?JCL/c+uQG4k7E0ajdfjzucEHwQdaO2BUU+EofdNAyPtlysLsOezWWhyBqA?=
 =?iso-8859-1?Q?4xVCP5r3IE5oDHwUSTa+q+7cSMjS8irEpgcz68LdPR+w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6335.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LE3sPna+LzO1cCsBlM4oPuRgjZjAs+8R+Z+Ac2bHHB3wM313dygELfr8k4?=
 =?iso-8859-1?Q?Pwtnzru9/3IT2JQ7Y9nun4GRJKr14LGs9ac9Pkez85osRZVumgDnM+kQ2g?=
 =?iso-8859-1?Q?LcIzTJ4Q8hfV1RwRddiypZsgpz5b5jY3GMcE7gSOWA837LojRvnF8VW6gS?=
 =?iso-8859-1?Q?ooLBOBVZ7VkhW2SiQS1/jqcn7uBRXXBK0E+fnKiip3/rDf5XISAWIlEqAS?=
 =?iso-8859-1?Q?5CB3vtFGIsfU59Se9MmCDSQaz/5iQi3sf1wDTiBPFvkZChe4vsbrg9D0BU?=
 =?iso-8859-1?Q?t+x/ciplcF4JfqS6IoEgU1ONQna+pQnyPGzMmVPgf31b68GkksUfG9i4em?=
 =?iso-8859-1?Q?l6D4OA+TGrqxRcIdYRaKe2rzxtMsjRudQmVN/sooqMbTVmDEK8a48hVd3i?=
 =?iso-8859-1?Q?VZvzOXJojy2RHyKON9WLvMCvewyi8whx5oXOs66KB9zrBQQjZJuTOcG/M1?=
 =?iso-8859-1?Q?IosZOQWOd5mTOGwFWGhCJKXupjABfHSBBS1VWyYqSXRLRPZd2qH/d2mrmP?=
 =?iso-8859-1?Q?hTBT9CuX4KLkR6z+h3liSAnypICw8t8l2GijyeCO+qpoF35YALz8KaNOTp?=
 =?iso-8859-1?Q?GqJZZclKwyI4c3vZOi2ujgGe4uuSx6EMFW1IiPND4zt3n76TaqGlVjQG0g?=
 =?iso-8859-1?Q?0A+oMkhCagE32JvNenLk4+LxSu4BvGayioLp0s/PjepsZzw8poa7a50Lbo?=
 =?iso-8859-1?Q?naMT/uHOT4sqgbh/SRdAHQlJshR74OEYJIOhKdmeUf49v01aEbf9eBjhZ2?=
 =?iso-8859-1?Q?HcqLoXXgvVlTcCKYQJuw6DNuHv7HttT5PEh6+fDMHC4UuLb6udooCIro8R?=
 =?iso-8859-1?Q?hQE4VgMeiTh2soFJdxchZ4qTN0+osDbU1fYv4iFaksAQB1o9DnR+auytW+?=
 =?iso-8859-1?Q?sdmhIaIzPc+ZrwrkDr2dRGEhmkhUTscduzFtdl0cp0toiNVA54qWqZciKH?=
 =?iso-8859-1?Q?cBy6FY+3uzGFYydGanfskmX98KMPaICTy/duSjBLyflTnBSTIAX7Jv0wPx?=
 =?iso-8859-1?Q?AA29g+WH7Ip6MCv4Nv6sg81KqBn6l85rI+mMQhmTEiuKpp+vPUsrP+3e7u?=
 =?iso-8859-1?Q?odLmPCY67vUzYq99OPBFDILi4Q+C1fhx3qQLscE9sx+JsfTf4bmf8IqDz/?=
 =?iso-8859-1?Q?w6HforZ8u5NryumcGQkZi5kf3kGRoRZLDqfd3kC/gSvjDYGMT5VBUBlNRg?=
 =?iso-8859-1?Q?HSHgWz01shA3Mgx9x18tB2pyo4KIcasSIQ2KxAfu6rwYU2nAqpsnGu6kwh?=
 =?iso-8859-1?Q?fZgU56p2z9VUTYRXlpshu2WBZfVO0xjVG5UNyS5uEK6jK0uQGwvL70lUzc?=
 =?iso-8859-1?Q?1G34kAR1Jjz16OSsalxUth5OI2n3c2Z8IXOcLjgfEV3Qg/eShJMVWWW/sY?=
 =?iso-8859-1?Q?wvLv7/voFccRQBa52VSPI8da86aBuK+j6pUwqsbfxSznsBkWzpcTnVVmt/?=
 =?iso-8859-1?Q?He0n6nGhrvV0W/X/FMvTwcSUd36RLXr6f2uAcmsjcEq7iCKnP7GthR+HKv?=
 =?iso-8859-1?Q?T3u1BzU3SEdpzMVXazLlNwCThaKdcCqE2F4OEVyZ+Z/1IBGTSbSLYaDykL?=
 =?iso-8859-1?Q?5vXjbXZeqfRDssbMLxXw0E4mRHHSwBg8ZNDVjrSqgJZb6V+X2VLasbEKHX?=
 =?iso-8859-1?Q?KoLXW1UX1crYctUIY8MqncNr9CLss8pyvK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6335.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec7e969-4cf1-45ee-ab04-08dda984137f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 07:38:08.4196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBzQBu1Zp1S4r6BK4p7nVy4xfkne3FsmSdbx3X2T4O4lzlAOy+Fgcx5R1HaDHUOoJik6Jq/FWjkbMD//3zWDmf1lCoCAqvplHxoHiIzjCMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7295
X-Authority-Analysis: v=2.4 cv=A7FsP7WG c=1 sm=1 tr=0 ts=684a83e3 cx=c_pps
 a=glwKbk3EqpzANxFx8SABCw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10
 a=kCna3pJBYh0JelS_eeMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: mMYEm8kksoXITcQkHvpSuC1bNESrvSf6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA1NyBTYWx0ZWRfXyfMQGHpU1Q9P
 0N+wroscgviRKruRRonTj2VTtztNRlHYUnp+re/mXOOGozAc7E6wo/Brg+0T9euVSyl+cyE1ANH
 GCGIAtDbt7GUbyfXFBymGO3RdC4xtzAuEEx2VKmEJ116ByQzpykTvXEJxiGhfyUO/JDiG7lLyMV
 R+7W8VVSxvZ9ooSO2BZLGOUlrrj8EqCOqp3Oi04AnYSOs9a5+8dFi5JO13NQ0kxi9lxfwnJslR3
 G63tC7+4CRvQuYYQQ6ZLbmTE1ERo/2Czt/cmaosWnAcr4PK7L0Nq4fwrLUyfGdBVu+I2eQO98NN
 eApPOAPG1TaYwEXSpppYUee7FGg9bK+N/k4/jbMZoNWtyTQSJd5+xAgM3pZd5JnByJ8FbR4LWZJ
 upLUx3j+Io+vrsYInHHOY9Pyw76rPL5KeCyW7A5hWzfXT7qUHhvHHyMJfjR2jll0PZdlDgX6
X-Proofpoint-ORIG-GUID: mMYEm8kksoXITcQkHvpSuC1bNESrvSf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=490 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120057

>=20
> Let me know if I messed it up.  Pushed out as testing for now.
>=20
> Thanks,
>=20
> Jonathan

Hi Jonathan,

I tested the project with the latest changes, and everything is working wel=
l.
Thanks again for all the help and patience!

Best regards,
Ioan-Daniel Pop

