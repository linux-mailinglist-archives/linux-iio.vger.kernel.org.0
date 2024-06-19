Return-Path: <linux-iio+bounces-6583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B452E90EB3C
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94561C23F40
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7C3142E7C;
	Wed, 19 Jun 2024 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LoKgcvlc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB51422DF;
	Wed, 19 Jun 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800621; cv=fail; b=KY3G7cedRPC46S3Qa3Ue3Fh7EY7whCRaXD7ZWFP+YRQ9l2TG/X/pDqRFyqWoblwZrBoCxVF9yA8CTNWWGM5D8L/rxq3KWM7K7qf4k3NwpI6S0aGOS+ZuSY0NbDIEsSgwWcD8DGuf2VZyEC64uhG+6LuZJ5dkcHIjrdUB2l7nCLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800621; c=relaxed/simple;
	bh=Bq58SRDPReAfv/SCzMoQphrNUk58Zrvra40FvTy2tfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikwehAHTPJxLfhpHKZXidiBnQ5fBxrYvMYpV/T9Zijmk+YqeAslFdLWwJLXutBFtNL3meWsYgNceWe2WvJc9SzFuNblyjWPA2/bQmZ7+6VzayoYlo9NkY+KYCkfjOyyl/8jcmtD7Zv1oMNm5wCHy6njYkFB1SFc5C/FtRe/PKWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LoKgcvlc; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JBZVn6001226;
	Wed, 19 Jun 2024 08:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=enMbL
	YMc4b0wCm4olmEMSW+Lyi0tTS2KAU81Bop0JZM=; b=LoKgcvlcdjaH7GyULEO1j
	SyxUZ4E3eAxzETDli+i/DB1QPpFn1KrUDoIVV+Zvc/MPgoWBsdr9d2Ob7VhkYxfh
	krvd1CG3mu2xmoyAouNFh+p6bn2J7xR0OhqTxkRZbmvD8SqXqNj31PGjFqlOg6Ii
	zjLTz1se+l2N6kfDjsMPXxmlo7qT1XTICdEJtmVvcJ7inlExa+xBWz1HnEctSk+O
	b3YA6bvmrHLk47yqGzkjMP44R0ANOsidxujDBCKCBegNpovza7py+4mqH4YeCCXN
	BJhJ8UdIqgmnLKCPzIKs/WMRgwVkFLJlHIoKQ3Wmm4dcE6qH6ePyZHzvyoIEXQ8R
	g==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yut9298m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 08:36:39 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfVsBSOnUoJ94jAOeKILqRqnql72/sQ1HUojw/W6Ek8y28lqoKcWDuSovPQmil+XOb2GxqgNiwk34FRDqjLbjONZI8T7i2kb66ztOqM/X8OknKUCnk9mAUHuXvk5xbKj9vjtiCl/6KU3YyhuY5drW/4tCofZwSt3rVUsjYvnoeQyYtGZUtaL7E/g2pn2pRUOFk2zefjxnQwTxLt15X85HeKAPuMGYLvNkEjeB/KAlo2QxSPrVHel3jP9dTLx4UHyMV3aROMWd7OVvb2+WmxIBssXaBgiCQGo/rBATY6FyW+3TQOQbLqj0cnUarcRBoAbpfb9WvNlMpxKxG4oP9SBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enMbLYMc4b0wCm4olmEMSW+Lyi0tTS2KAU81Bop0JZM=;
 b=G6dUcANmBYw0yQBRSMVC08op9cKE9eeJ5SjmvqUu/1HjrR7X6JHa29AVQRVoimlZzz+c/OvKGYxM/jXlomVyiWmUUvNDrfV1QAZuQfqpicYbN/HADcM6bd9hfqJKSc1gZCEx8H3kJmLj2zlB7IkHNp4ffw/LqdKp5aQmBQdPsMsIgS+mByT2trN8dANRAqO9SbDM9xIxW2O5i8OvlQkN5TTgayCH+mCy82FS7xQpHlFVknJJ5z4jrVHX2LEtZ5oO6zz/azMsMomFJQRMuXi7nqPGeZPJc3m9pKtZK+Xni6ZnJ2g+wAF865/yqGz7BNb+gMBzE0pOJJOkzdmwQex1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SN6PR03MB4320.namprd03.prod.outlook.com (2603:10b6:805:fd::16)
 by CH3PR03MB7436.namprd03.prod.outlook.com (2603:10b6:610:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.28; Wed, 19 Jun
 2024 12:36:37 +0000
Received: from SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f]) by SN6PR03MB4320.namprd03.prod.outlook.com
 ([fe80::90b:c25c:720f:7b7f%4]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 12:36:36 +0000
From: "Nechita, Ramona" <Ramona.Nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Sahin, Okan"
	<Okan.Sahin@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Liam
 Beguin <liambeguin@gmail.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drivers: iio: adc: add support for ad777x family
Thread-Topic: [PATCH v2] drivers: iio: adc: add support for ad777x family
Thread-Index: AQHasdl0njKMnW13Ik20bQMDc8f+zbG0UnWAgBrRkjA=
Date: Wed, 19 Jun 2024 12:36:36 +0000
Message-ID: 
 <SN6PR03MB432075B9AADF1082F87EBD62F3CF2@SN6PR03MB4320.namprd03.prod.outlook.com>
References: <20240529150322.28018-1-ramona.nechita@analog.com>
 <20240602115319.686a2a80@jic23-huawei>
In-Reply-To: <20240602115319.686a2a80@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccm5lY2hpdGFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy04ZjgzZGU0MC0yZTM4LTExZWYtYmIxYy0wMGUw?=
 =?us-ascii?Q?MjIzZWY3NGRcYW1lLXRlc3RcOGY4M2RlNDItMmUzOC0xMWVmLWJiMWMtMDBl?=
 =?us-ascii?Q?MDIyM2VmNzRkYm9keS50eHQiIHN6PSI5MjU2IiB0PSIxMzM2MzI3NDE5NDM0?=
 =?us-ascii?Q?OTc3MDUiIGg9IjZyRTlYclRNTEpERGQyYnJ6KzlsVDVVVDJOYz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?RHBVK2RSUmNMYUFmdzZ0Zjd2RVZkNC9EcTEvdThSVjNnREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBM0xoU2ZnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB4320:EE_|CH3PR03MB7436:EE_
x-ms-office365-filtering-correlation-id: 826a187d-9303-4348-bf47-08dc905c75b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?ya5INmskd9yoLFwB74731Lda17DmLFXhfhAfEC2UtlCLkfZHCZLaMrbC3ilw?=
 =?us-ascii?Q?U8lXwfuohP8tC4ggGwtmIJ2CysSox5NBlk0jynQVHkLxjCrRzvdjphQXZBed?=
 =?us-ascii?Q?vqSTVJnT+vpzCF/XGSeVtuDCv/VWKI3xHg+GjxRgnLg5RER2e4pCOaDHinN8?=
 =?us-ascii?Q?NCiBhK48Vui5B57JG01D2fBL/rNfWpO+zAGqyTQpXdXZ5js9TI89nYTwkjyq?=
 =?us-ascii?Q?P1j3MrmdfWtZQL7pG0ZvNG0jltgl7nRRjnsdEhMy5pLIPn2qo1hSQGjlOnzt?=
 =?us-ascii?Q?HpeccZixXKO7ayftfNM9T2hHXxPTYrOW5W5r+KfyR+ygiEUIj2tgRMFsidha?=
 =?us-ascii?Q?cJehplYRo3txvJH5DXv0Uq7y+YDl46Dz5dhyRP20LfZPo+4f4SJHOYkTxGY0?=
 =?us-ascii?Q?bAwnbywBAlbEFX+XLIlFx7ZNoyA0tlHgrglmCsP77L9FzROfyGFNiJNz5B7/?=
 =?us-ascii?Q?K9m1StsBegyGR3LDfwbT6YcMgt/su0FswnzbIE3zaJbRcNN3gvV17V2eshGH?=
 =?us-ascii?Q?3EZhuJkmc0V+hmzXKw6u7FvOJHTIEKeshKve7s+mNHV90HdpTj9IWowKHzr3?=
 =?us-ascii?Q?FzBL2ZypOCdIRkY2VQwU7q/ftxAcJbs6HLpDRwnqhBo633mSIWEWbG5pYJGf?=
 =?us-ascii?Q?EIqQc9qWnc2zknBQ1wlzJMnxwkjXUT5zukmStNrolBl/DlnCeTc87IZ9isY5?=
 =?us-ascii?Q?E0rqQ5mSUzkRJ4P1zNoc+Yg7WzYhY5xhFms5JGYV8XgcUT+N53As8N3b9Pak?=
 =?us-ascii?Q?MbxlTUZm4L76k96ZwUQ9+TgsG21RRXk2iXst/lG6dJU+XlBN//TglOzbloHz?=
 =?us-ascii?Q?L543Em0ccfwaxW3ISr73MU/TLn3/IAetjaXsYzj/S8ed32t9BLBOggf3u1We?=
 =?us-ascii?Q?5yGlTPj5OBFc4NXIXujHAjUTLArboC0MhPf6ltUremHncWAZYUYvAEFThDYe?=
 =?us-ascii?Q?xQl3aLS4JvKv5L5y+voO/EclzCtt5hI8ET557tn53XnMorx34noHW1S+Q2Zd?=
 =?us-ascii?Q?ujBQ0iEDgaWvX7rbvSFXu17KsazwpPXxPGF5QWuIY+C18JCm9Ktq+Ru4Tw8I?=
 =?us-ascii?Q?XMbcBQ8/iTfJaXT7h7C9Uu+zdH8IqJ0gYv9Ulp7IFSM5ZF9E13XtrkY8gcGH?=
 =?us-ascii?Q?239sdkCRp9PJQQ0dyEUVIxNYV/FXbO0GvecEOp7FeR89wtlkcBarqu0r7HM6?=
 =?us-ascii?Q?NH9XOCYJ/iboC8bI72zV5XKGDxaTpwqRafd4+ueTu+Xaw9YWhdgdIVm7faqg?=
 =?us-ascii?Q?Hk08lazP5gxFrvb1CDx1AJ07ACOlF2vMlS1T5h1Qe7qYVXvXcUu3TJBfesDn?=
 =?us-ascii?Q?aO0W6PnvxTanbcKL1QtXeupsZ61QkFGUyWDmoCyQlg67/i53qEqhR/78cP4N?=
 =?us-ascii?Q?hbJv7ko=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB4320.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WswVeWUGCPSg+YC9Ax0IxUUN9GDX2RshPsB7QTlBghU3P4JZNVG32KqBF4Mb?=
 =?us-ascii?Q?tC5HxbfEjOXaERX64x8xBl0yMfeoFQFtUFk6O0J4wWsq+zuadEDUwyjSGWuj?=
 =?us-ascii?Q?FPA/6HwLhyQpL7VLDUzW7gutZLX7M4RnwEfMrSTr7zWtrn6yzLvNKguSpLxn?=
 =?us-ascii?Q?5Pj3NjEdQZIGvPl1UwOBD1/k5zGLh1dKGX+U8XoCoR9n1VQVG/3eerUtQwEb?=
 =?us-ascii?Q?LqEkJIZpTye5rFawPCdIlCOBHvp+DbcBO+RMgM1mQChErnsgDs5Xgi51daGU?=
 =?us-ascii?Q?vkaItJLQvUtpUA7gyd1FF5dFwrSeHBKBjZ3ThbqOYx+hFImZwAb3Npzrwofm?=
 =?us-ascii?Q?Th29zdLpuhd0KLlAbeTENrY4xDAhzTEGMZ5oWXVhsOqn15751QCdGSq09vB+?=
 =?us-ascii?Q?vjjsDLFYBhJHdH6302BiERGeQZfk/TIFBzv00DkuIAVHAFoDvbagmkVFnpN7?=
 =?us-ascii?Q?eSzuaxaucjdLKUz5/LAhXehx9EiY0nSg9MZwIHTFaK6dHZxQvTSPIOOWPgsZ?=
 =?us-ascii?Q?k2eG4TPmlHZ3jH71hiR6vqFWYFLgBHj+m67a9QG/p24Z5RnRUF1fqn1K/oe1?=
 =?us-ascii?Q?ZpO0bmvQj3xt9SkgYX61ULi6G2hALIUfnNgPkF0t7p8ku+DIhmQ5fCCz3ve1?=
 =?us-ascii?Q?8SNkxlS9PlxrnOFMEWHNcEYyeT1qv3NEZQxmXw09hL9W9woQJr348KxJNdYN?=
 =?us-ascii?Q?giTySs4Xq8NkhPEf3LqmwYhUp/OuFiFZur62eIcoxXSPl76dlkyEtFItIeaG?=
 =?us-ascii?Q?YlgwfONGFvbjnKn1M3jhUeQ4OC6djzIHkCFfkjliQyke7IiDm/CN2ZCetG1v?=
 =?us-ascii?Q?s6JN4+TXpVYBqXMDGXSstOMnNPqTn4lI0RV16if0pxm7x/UudqXRV9uwperD?=
 =?us-ascii?Q?x7G9/R8TgxHkjGz96XdxLBaMnI6I+q0GIOex5ugOv0VC8BWbdseKJ6n77DuY?=
 =?us-ascii?Q?7KCtfm20wSarVm6vedhy6VqGJ1dfqKQzF5c/wRA9EctGKJvyyZR+U0gkmn65?=
 =?us-ascii?Q?7tTp5DVSNHcObcL/Jh/S1Lfh+Q5GD35CZjeEAedC84SLOsyXh/FdlQXJ6CBV?=
 =?us-ascii?Q?VNtgYeN9OOUMZWBJbJtp7SbKShua/8DCRuTgoF7PiJySSYVKQ2FZ9NZCnStr?=
 =?us-ascii?Q?Lc+ZURUpJbVP8mb+G9HhXKFLmnVanQmceOUobvfUXz6J4dcCcUsv7Z5yvuzd?=
 =?us-ascii?Q?WAGjc6O0kuKC64pDMsIFy9VD6rjp2cDLenIxflteOIXTcs9UBeCsCmYwPy0e?=
 =?us-ascii?Q?aoJtZjQkEHZAxV4aYq9LwhXMHTF931e1hQQ4vd9zqHrUv9v6CEa3IbRZBBB6?=
 =?us-ascii?Q?tK8owdS9hjkgyUqqpLF4OBj0J6NTs2vuBUMuoMtVXeQjStNfY/7otrBindos?=
 =?us-ascii?Q?G8rTnVl9Mf8lmaLcXemD9iQ2bCbw23btwTqDnFafajJWRhZOmfA8ovqGLtWU?=
 =?us-ascii?Q?n/sEPQy0F49k5Ybl6gpD1Xu3Tq6RAvP30mkKGZFR3vbkEjBZTzLxTnw4UaX3?=
 =?us-ascii?Q?mvgLZLc/batfzMBs9bhXWHFtZ7iQmuIVOZjDDnXqDrLkuWrRtuayy9ikMFzl?=
 =?us-ascii?Q?NR24vQmeCJ6VtqR8dLBBAvbhDNDu/6VkOAmecTAM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826a187d-9303-4348-bf47-08dc905c75b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 12:36:36.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVAmrywI50mPfMPQpugFgu4DXrHMon4n+LzZfcs9hLLz6wViTlCjjfWvuSCm745fca6CpE4tOq4Zx/8JyUO01ksBcMsjowz5nw8RPM+YO+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7436
X-Proofpoint-GUID: IlNfx4bBPkpn85-lS8DwymwUmurvd-hn
X-Proofpoint-ORIG-GUID: IlNfx4bBPkpn85-lS8DwymwUmurvd-hn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190094

Hello,

Thank you for the feedback! I implemented most of what was mentioned, excep=
t for a few things aspects which were not exactly clear, therefore I ask so=
me questions inline.

Best Regards,
Ramona


>
>> ---
>>  drivers/iio/adc/Kconfig  |  11 +
>>  drivers/iio/adc/Makefile |   1 +
>>  drivers/iio/adc/ad7779.c | 951=20
>> +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 963 insertions(+)
>>  create mode 100644 drivers/iio/adc/ad7779.c
>>=20
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig index=20
>> 0d9282fa67f5..3e42cbc365d7 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -206,6 +206,17 @@ config AD7768_1
>>  	  To compile this driver as a module, choose M here: the module will b=
e
>>  	  called ad7768-1.
>> =20
>> +config AD7779
>> +	tristate "Analog Devices AD7779 ADC driver"
>> +	depends on SPI
>> +	select IIO_BUFFER
>> +	help
>> +	  Say yes here to build support for Analog Devices AD7779 SPI
>In help text list all supported parts so that people can grep for them.
>
>> +	  analog to digital converter (ADC)
>It's not just an SPI converter. Seems to have a 4 wide serial interface fo=
r directly clocking out the data as >well. Might be worth mentioning that e=
ven if the driver doesn't yet support it.
>
>> +
>> +	  To compile this driver as a module, choose M here: the module will b=
e
>> +	  called ad7779.
>> +
>
>> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c new=20
>> file mode 100644 index 000000000000..089e352e2d40
>> --- /dev/null
>> +++ b/drivers/iio/adc/ad7779.c
>> @@ -0,0 +1,951 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * AD777X ADC
>> + *
>> + * Copyright 2023 Analog Devices Inc.
>
>Probably worth updating given how much this is changing!
>

---------

>
>> +static int ad777x_set_calibscale(struct ad777x_state *st, int=20
>> +channel, int val) {
>> +	int ret;
>> +	u8 msb, mid, lsb;
>> +	unsigned int gain;
>> +	unsigned long long tmp;
>> +
>> +	tmp =3D val * 5592405LL;
>> +	gain =3D DIV_ROUND_CLOSEST_ULL(tmp, MEGA);
>> +	msb =3D FIELD_GET(AD777X_UPPER, gain);
>> +	mid =3D FIELD_GET(AD777X_MID, gain);
>> +	lsb =3D FIELD_GET(AD777X_LOWER, gain);
>> +	ret =3D ad777x_spi_write(st,
>> +			       AD777X_REG_CH_GAIN_UPPER_BYTE(channel),
>> +			       msb);
>> +	if (ret)
>> +		return ret;
>> +	ret =3D ad777x_spi_write(st,
>> +			       AD777X_REG_CH_GAIN_MID_BYTE(channel),
>> +			       mid);
>> +	if (ret)
>> +		return ret;
>> +	return ad777x_spi_write(st,
>> +				AD777X_REG_CH_GAIN_LOWER_BYTE(channel),
>> +				lsb);
>I assume these regisers are next to each other. If so I think Andy suggest=
ed creating your own bulk read />write.  That would be a good cleanup.
There is no mention anywhere in the chip datasheet of autoincrement for spi=
 read/writes. Therefore, implementing bulk would require constructing
 Arrays of ADDR+DATA+CRC combinations, which I think would complicate the c=
ode more than simplify it.

-----

>> +	ret =3D ad777x_spi_write(st,
>> +			       AD777X_REG_CH_OFFSET_MID_BYTE(channel),
>> +			       mid);
>> +	if (ret)
>> +		return ret;
>> +	return ad777x_spi_write(st,
>> +				AD777X_REG_CH_OFFSET_LOWER_BYTE(channel),
>> +				lsb);
>> +}
>> +
>> +static int ad777x_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val,
>> +			   int *val2,
>> +			   long mask)
>> +{
>> +	struct ad777x_state *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret =3D iio_device_claim_direct_mode(indio_dev);
>
>Use the scoped version to simplify this quite a bit.
Apologies, I am not sure what is the scoped version, could you please provi=
de more details?

---

>> +static int __maybe_unused ad777x_suspend(struct device *dev) {
>> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
>> +	struct ad777x_state *st =3D iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret =3D ad777x_spi_write_mask(st, AD777X_REG_GENERAL_USER_CONFIG_1,
>> +				    AD777X_MOD_POWERMODE_MSK,
>> +				    FIELD_PREP(AD777X_MOD_POWERMODE_MSK,
>> +					       AD777X_LOW_POWER));
>> +	if (ret)
>> +		return ret;
>> +
>> +	st->power_mode =3D AD777X_LOW_POWER;
>
>This is never queried - so don't store this info until you add code that n=
eeds to know the current state and >for some reason can't just read it from=
 the register.

Wouldn't it be more efficient to have the value stored (it is queried for s=
etting sampling frequency), instead of performing a read each time?=20


