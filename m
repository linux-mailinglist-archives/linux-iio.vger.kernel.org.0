Return-Path: <linux-iio+bounces-7527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2792F871
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70F2B23C98
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561814E2E9;
	Fri, 12 Jul 2024 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gW7eA7qc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AB61422DE;
	Fri, 12 Jul 2024 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778052; cv=fail; b=dSSNftw3VMiFdt9jK9q5oVYPJLHa54HLq65hIhvIP1kGK/sqWaR9Fm93UYIusjWBWFBEGs7lCl7XcryXR7xDqFFGQw4IUbEK4tkbHc25wO5pxbWrEYn9El9V/Rk/GmoSNVdmEOd+z8XOfAUwdbhjUD/VD8DI73T7KSFedE8LpoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778052; c=relaxed/simple;
	bh=jkg8bkJ9B8AkoRm2xz+eWvhxgIhzug9uTtNWRgiX3jQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pAyzsQ9ZdHYTkgDkPnzWU8DrQScoJbp3lK7bxPcvv2UIsyVpdS/AId3Rm9K1pyudFKOrhhuiA9CHZPxJkpbs8Qe7gKCt8bqozY70AffJAl839bOn/WsoS3giUHmujql4YXNEKrZFngd6qoIFVNeynZqLJQU+hD0nrnU7H6j8VMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gW7eA7qc; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C9PTWg029863;
	Fri, 12 Jul 2024 05:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=GDjic
	Zj7Yb4U7SNWU4NjFV2KREtjGfoToeoGKIgCIOg=; b=gW7eA7qck83iCoAJbk8B+
	IhBaKfKXUWk9Lv/Qof70ov3CfIdz9G31uVQ84DR4hCDZnZA9vwrDN6rPV4L5vHPc
	gxH7tAYbnyONQLKqxnxO1oYbLIjpD0NPTWIHFgdkePUoN3JYBMPfnBfP/G/fXxDH
	kk7rUnXzlqS0f7ycAXylC42Fu9tMAfDr/IH9Tw0IcFMDmo28vtXB9l6F/aa+8UD3
	zr3RG7/eqApxsNnScmyvw6q9mejzQgLExSaYyr7BOUVr8BBpKLeAV7yPWyKTe0/c
	yWdA40Sz62W82L8p6JB9EwXF4s4Mw/5/1Wa2OLhG8DfZTzC5hafQye0Axe5+fw1U
	A==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 408fy4gn2y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 05:53:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWnonWyvP8hTeb7SvBM9kuadyNY9fVMH5KYwfM8RPy8DLQoe/G6MeStCEnPmZuxrdfBSHWR67SFKx5hpVZNjue0QPIxYJVKpSxqAH4Y6faB6EhYfT/RTNgAuwRMtDf3NzTdYMhfsLtxk79g5P/RYMkXWpvgl8Y2VDQBREmJQkxprf/R9sGgMp5WDa4tVa4zm4CUL+Rv5KE/0pTEotpaJKfOAg9fmPsijXJpPAadfuuNspzjaheec4L5r4W99mLmIKodF/7Rq89BUwmARZrFV/gC5/c4mYFAD3C7981swrYZrEsm4kGDfBh085kIH+Rsgb9itpaf2lqI9YVRk3KyOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDjicZj7Yb4U7SNWU4NjFV2KREtjGfoToeoGKIgCIOg=;
 b=W1/UzqaQE0TgElDtw5MOkp80w8pucWmeO7YLcWn1WeN1cI86FxKLnKJ0fmsSh8JndXduSnijkaj7OdzxBZYqcIKGr/7Z93C60K/1yZNRnNJ0v8VkGu5KTd1zZ4wB+mcxKoee4ypDyaScr1OhpWiIj9rhs3LYYrzh3/MXIHTAbo8sXC6ou2oHas1ko1EbJ0giN1Ji5R+bEHeSunM5o1rLSI97nBGmHzqf2ZhGHCJEHKpuawsbnxUkCrMB3Up2wVdwBBIYsm/ldtnPOyZOE3QJZmYGwjwD5ohBDUa+Z6OABI2FFBtsLs0PEEBTPFnPaCXHPG7v9EjEIaj0/nwJ68XDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by SJ0PR03MB6222.namprd03.prod.outlook.com (2603:10b6:a03:3aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 09:53:51 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:53:50 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Rob Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        =?iso-8859-1?Q?Nuno_S=E1?= <noname.nuno@gmail.com>
Subject: RE: [PATCH v6 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties
Thread-Topic: [PATCH v6 3/6] dt-bindings: iio: dac: Generalize DAC common
 properties
Thread-Index: AQHa04d8+WHyEhvYUkuL5GxJuHjjF7HyIvcAgAC1WSA=
Date: Fri, 12 Jul 2024 09:53:50 +0000
Message-ID: 
 <PH0PR03MB714190FE95B8E9FEBA847C6CF9A62@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20240711114221.62386-1-kimseer.paller@analog.com>
 <20240711114221.62386-4-kimseer.paller@analog.com>
 <20240711225232.GA3248170-robh@kernel.org>
In-Reply-To: <20240711225232.GA3248170-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNca3BhbGxlcj?=
 =?iso-8859-1?Q?JcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1hMTFjYjRlNS00MDM0LTExZWYtYWFmNy?=
 =?iso-8859-1?Q?1mOGU0M2IzM2Q2NmVcYW1lLXRlc3RcYTExY2I0ZTctNDAzNC0xMWVmLWFh?=
 =?iso-8859-1?Q?ZjctZjhlNDNiMzNkNjZlYm9keS50eHQiIHN6PSI2MTE0IiB0PSIxMzM2NT?=
 =?iso-8859-1?Q?I1MTYyNzM0MDI1NjUiIGg9ImJpOFZNaTM5N05KSUdPODZqazJGM25jTFgv?=
 =?iso-8859-1?Q?dz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBREZNdEJqUWRUYUFmbWp3d00zTlNvMithUERBemMxS2pZ?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|SJ0PR03MB6222:EE_
x-ms-office365-filtering-correlation-id: 6c399fb8-8c07-48ed-0930-08dca2588851
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?KkWglWPqsIIiTFNug8g+QEy7jKbNgYagLI2JQGsJkwMheP7LiBzqP69vj/?=
 =?iso-8859-1?Q?ExNEpO1ovhlD6hnkHqElCldHrkoC7SGOXi4FeKR0rXdFXUEw8hmHFDv1Is?=
 =?iso-8859-1?Q?6hSGb93Ca0GhqunAnUPVuuC6U83uYmFOIbtPnUAQhgENZdd40RLRQBh7NM?=
 =?iso-8859-1?Q?+L1pGddLfcGQdhaes6vuhdB6qZTapJ0AYccJFRyizScgZdcoZXTTXI0YAR?=
 =?iso-8859-1?Q?/LdPAs33HxQLpFtI9WHEZLY8TCs2E8lxFvYPZ9xWicYbeIDlx6DcCWFAuH?=
 =?iso-8859-1?Q?3t12gyyEv5efSPRqj5uTPxBMwyuWc2xCs4U33wv8ljCDkZtURVtGQGqZJv?=
 =?iso-8859-1?Q?Z488O8J/wIbUV1rEETjjIfDOULEvbiMDWJfDxfiArS4IcuerAntMLU2TEd?=
 =?iso-8859-1?Q?d4gUWiqNERs+nKHRIL7mWifA5JG1Bh4ALOoBQSqfsNAALCyXGQckKU4H4G?=
 =?iso-8859-1?Q?aS4aJXdqJrW0d83luTcGcQKdQL9Q+ks29Ur8PHqOvHWDw3BQ7A6kWNW3bo?=
 =?iso-8859-1?Q?quMVhjxvQoEyb+wMuhbQPCy2ttHcxFrrQOXmXIqBa5H4++EsdYmb/T4o2i?=
 =?iso-8859-1?Q?+cvafoAIPc6yYT5dHCaiR/Ep8bzLbx/V2jCcXlP+AjBsMzX6wb+iwq9lrd?=
 =?iso-8859-1?Q?T679pW8PhjBtys0diufNaPSa3GZesI0AbhoTmvTRVMsTf/RER3DpEG8qk2?=
 =?iso-8859-1?Q?Zt22DvYFzXpz+qNgD5jXhAOlCU8jEVQ1ybC4P95JF+Rr9GJAPvBp928adA?=
 =?iso-8859-1?Q?A4sq1rtw9sfC2dXM0Me5UK3ZtZ7vVQcundmIsUxkiJH3jhMh3bT9x+fF1j?=
 =?iso-8859-1?Q?q6KH1CpcT7557zfWBJalUDFpSGnYmKyXsIOO+YViwTnTGRUVCJk+3OnOsg?=
 =?iso-8859-1?Q?ZZ5Je4Z5NCXxgld9eUl+50alYSg+7BP59goTV7vmTTn6Jt+vDL8SGLshaY?=
 =?iso-8859-1?Q?ADEZfCtBllZYC15or3Zaf7vSy70gW3Xys63hX5wP1GRttPxAOV4ptzIKGi?=
 =?iso-8859-1?Q?U5I92WSA5IQWKWX58cSwVeYZVQhdS87tOKwyAx8fgC6IxzqkzkYbVhLTMh?=
 =?iso-8859-1?Q?vxsrXIeD5RcN+80hIJFoR+SY0N40qYqX/OHk9X47Y/UH1yC/mbxUQJJn5Z?=
 =?iso-8859-1?Q?ZdnndszhJ5gqQe2GVH0Rt/4l6XYPexU2jTXnEghD3cZugxp0qMCiCeFZLR?=
 =?iso-8859-1?Q?Ky+1RpmDGS93GMf6x5hFSGYH1Xba9VL1I1SHxuKqKAP4TuP5GY6PpGLgx4?=
 =?iso-8859-1?Q?0O0goePOtDL8/Cr8poH+2+cuB5IR7yThfxfM+7yw67aDuA/E4I8uBKlpch?=
 =?iso-8859-1?Q?mCUDCUxN8ZvBxfoOt/5+vWLJRUSvxi+aNH2csHWYNCFYZy5JwUwc6t4yeI?=
 =?iso-8859-1?Q?/8/iqb+QOY6w0XCvuMyLdjbsSCy/G+OfkPSIoKZBmD8GDdyq2QMlw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ZiHbISavF9AfKQjGiDDIo7pDUeLTdJTg/T3WobPfNEUbgIqL4lF0usIlMc?=
 =?iso-8859-1?Q?NMEZjN6LU/BeL0wTJsw85x1DJI6XVU0haNZ27ahjzIWx4OTCNN6fpk3scq?=
 =?iso-8859-1?Q?X1CUKiyLSmXBrrWOTEU2ePOEblKuZh2GpIpVM1NYTjSsgXC6gxpAoNQrl0?=
 =?iso-8859-1?Q?d2kVm/TNGDfkNWRzjgBuuHN7qAg7BUNNCzTsTnJrDg4YRngFBr9Duvj90S?=
 =?iso-8859-1?Q?Q9RZkBIVDyp7n61EJKf3bgbv57c2dOLroGeQfezO26kPqos1/mYnetXE4V?=
 =?iso-8859-1?Q?fh4SDqcoyFuLoI3uGs1rPDecmrk9FHzURwBjynSQHCe+nEg3svl6PCd+Wu?=
 =?iso-8859-1?Q?1PrFC7Yw5WJTGCvCWFnUidcsXR70nsXMRvRghPL3xI/6B+ZVlnJhrwOsrr?=
 =?iso-8859-1?Q?MIOmtkz5abBI714tsV3hIlZ1U6Oz5FR2NBU/EHi8p/SaEsPUXyirCDHRta?=
 =?iso-8859-1?Q?dmJGcoHrAIHeh4pU4wEwi9RxIuggo0fC3huWQV9fjjpxCn42AJoa2Aeqj9?=
 =?iso-8859-1?Q?FIcxo2fCGtvr8u3E/44h+Ar5mi0sysf05Zr4950/T/gj/GXA1TUY9ZL5Qp?=
 =?iso-8859-1?Q?fp/69LT5vWjuyuAPtFQ6nbXuVe8sJK2sMpNagMd0fRH+yZAfv5lK8jBVZQ?=
 =?iso-8859-1?Q?DHJHraUeKWSTRjD6qCZYEzGTcKwBg3yTlvEX8oHpl1RkG2Q/YtIhrh3VUw?=
 =?iso-8859-1?Q?HlVOuAHlw6smj06QCvNWECZGDDGGQMOAU7O8dCEZaNCDQiq9is3/jOQqnB?=
 =?iso-8859-1?Q?Hg3xanhy0wHX2fTWAC7o0Bz0kVjWA+99Jin+fgLMY7ltUPfq0BqgellAlA?=
 =?iso-8859-1?Q?rQHcPcxtyclWCvU//rU0urOGCXCMPm0P/ZnNnW2HORbzLcAJI1tjMbtu+k?=
 =?iso-8859-1?Q?sxcFzyKbR9d9fXk7+4CvAfGMVE82lagIfyNzx+ePQuyk00bhRiPiFd3e0N?=
 =?iso-8859-1?Q?VBIk25JEjlQDGee3WxcNFLdC4xvJnjiUCAa6/8SF0ZFhNZEtMLu7E6WpEW?=
 =?iso-8859-1?Q?2HYt6SxrNtlWRNxTeXQk7fnbVniji+18JobxOhWcOaZRJOolsHKIRLx4/b?=
 =?iso-8859-1?Q?zA+kirN9mLa00DmYMDp6obawYa7URzwO86WKDIbWtFTZd2j+p9IyTZkTrD?=
 =?iso-8859-1?Q?EpQUagJ49oDGSCbQryO9Qea161LTUS1Kwz7wFo50GGTAz9L+HmRXrEpKoA?=
 =?iso-8859-1?Q?IVhnmRE+B8ecsnffzb1OiE/va+IyBRwY27ys6HkCB6vqMm1EuyHiCZvJsA?=
 =?iso-8859-1?Q?7RiuuNXLdChTFgiQrR5ED/YGiXjbKzqFH/1UUS/5f/pjetaJU8tR2lmrNB?=
 =?iso-8859-1?Q?mdXuJoow+nUmFwzCuHgdtSyrey1mjVjKgOFtSsOmo7sLM+paoKjzyl712c?=
 =?iso-8859-1?Q?IuIn2TArud3kSYEA1yfWDvNutyQMW+B3qBSsDG1bPpBFplIVZxJK4jy8c3?=
 =?iso-8859-1?Q?Pt6RZwxuWJH1vhBW0fKRdSRtmmev/0NZA7jH9FCmfHKIAVYAFm8eQNdFJL?=
 =?iso-8859-1?Q?74FINlRqBuKfhsna+ZZ/qAULxOp33T+nIZevvA/veU9WD/flpsd2vfSZ1a?=
 =?iso-8859-1?Q?4x7JoJrFXzY6mz5JmdTZ+ycGfo67k4IPwYWIcwncYLUkmDLRZCOmYr6Z/7?=
 =?iso-8859-1?Q?kASyzrPCnkKOcpz581xCutWwFFj/QAtexo?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB7141.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c399fb8-8c07-48ed-0930-08dca2588851
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 09:53:50.7354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slR8cAuhmfQfNXWq2nVbIjfHAlkNQkOvC53/AUZjvTo1pHxrFyNDm00gJQB2tTFZVQbAICs+b/K3eQSGRF0GtVEPwGr5ZrGps6UJGfXbXys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6222
X-Proofpoint-GUID: AlcHCdiLpCPr0Tg_Dgf3BMKxw7kI5VC-
X-Proofpoint-ORIG-GUID: AlcHCdiLpCPr0Tg_Dgf3BMKxw7kI5VC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_07,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120070



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, July 12, 2024 6:53 AM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; Jonathan Cameron <jic23@kernel.org>; David
> Lechner <dlechner@baylibre.com>; Lars-Peter Clausen <lars@metafoo.de>;
> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
> Dimitri Fedrau <dima.fedrau@gmail.com>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Hennerich,
> Michael <Michael.Hennerich@analog.com>; Nuno S=E1
> <noname.nuno@gmail.com>
> Subject: Re: [PATCH v6 3/6] dt-bindings: iio: dac: Generalize DAC common
> properties
>=20
> [External]
>=20
> On Thu, Jul 11, 2024 at 07:42:18PM +0800, Kim Seer Paller wrote:
> > Introduce a generalized DAC binding that can be used by DACs that have
> > similar properties adding output-range-microamp and output-range-
> microvolt.
> >
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > ---
> >  .../devicetree/bindings/iio/dac/dac.yaml      | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dac/dac.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/dac.yaml
> > b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> > new file mode 100644
> > index 000000000000..a9787bbcd22b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/dac.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/iio/dac/dac
> >
> +.yaml*__;Iw!!A3Ni8CS0y2Y!7zJ7L3dzud_vULjCirbZeBLxRAdVf8uNPLanf1xKhpv
> u
> > +3c3nbMGr57cvS4-EZ4vbO8qbilWaaSXNAT_z$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> >
> +aml*__;Iw!!A3Ni8CS0y2Y!7zJ7L3dzud_vULjCirbZeBLxRAdVf8uNPLanf1xKhpvu3
> c
> > +3nbMGr57cvS4-EZ4vbO8qbilWaadHw-qDn$
> > +
> > +title: IIO Common Properties for DAC Channels
> > +
> > +maintainers:
> > +  - Jonathan Cameron <jic23@kernel.org>
> > +
> > +description:
> > +  A few properties are defined in a common way for DAC channels.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^channel(@[0-9a-f]+)?$"
> > +    description:
> > +      A channel index should match reg.
>=20
> Drop $nodename. That causes this to apply to every matching node and henc=
e
> the failures.
>=20
> It is also redundant because you define the node name where you reference
> dac.yaml.

I've tried to drop $nodename, but it seems it is still facing errors.
Errors were also encountered with the suggestion from David. I think I will
revert the changes to the original version, as Conor suggested, since it wa=
s
also following the same pattern as the adc.yaml.





