Return-Path: <linux-iio+bounces-17583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC3A79CA8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 09:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3035188C60E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B193623F271;
	Thu,  3 Apr 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BQRi6hZp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6C18732B;
	Thu,  3 Apr 2025 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743664319; cv=fail; b=dRVyKGIGDquZKE6owU9WC9XpwHZf6tOL0X8mYyY3zi49BfvTF9/AfiVMzTupkkjeZbJf2X70913dB0Nd9GTpSy2oZ0Uk1+XxfRMnE58vEG13XYmkhDWOIx7csnQxgT0K/B1TtusEXIIq8Wl3zf08UFc6bB4r7Q1uEIcSYZf7/9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743664319; c=relaxed/simple;
	bh=W9g3Q1GD2/gRHFfdY88WCUX53oHpQAUHftMISCs9x4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agSlQEEFF1WwhDP1QUcKD+agFanib9a2lJ2sqJE4QtDa/ghguiA4Mt8K/zQdP3sYvz99KZrZLCGc6Vz1VtTxnXH1hpMnsKdc/vWG7DgPX6FPAe94mDXOrGo1cMluuo6uvDGVHfpCIfRAlPvo/X1w+i9I6m6JZ9a5oS8hihP5cTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BQRi6hZp; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5335jwNv005937;
	Thu, 3 Apr 2025 03:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j0kDm
	E4QVbVagAdMAIK7YM1XO5/Uoo3y27OLeZNNk2E=; b=BQRi6hZpLoJU/2hszVWIX
	afoYOsVZQdO1DTbM+a9uhlnQ+hB4zOLt3ifLZZPlVbpsY1fewiEPT2yA4ZyakgrZ
	vC5ac1yJV4dxh6c5/ihEnWeqxMeE1uvhcN6dt16KumjNmBpgrMNApRXH4duimeVE
	45PtPcGIy5mPzAvruRmW0T9fDLtpiPWEjUUnB4L3ZO+XfXW/5hn4rHQyiMMc8Dqc
	cC76i21tucz4PPFunkvuFleyuLZFkLxyUFUbBGjnquOgtjmBsYNNbTEX7tYwx1A0
	fbZQNpjQeuv81jRu13VZ4FVn4Wc3l92NdLHKIJtDzD0nNTzClHCqhXQp9jBCDV2T
	g==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 45smfjr9rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 03:11:41 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/vQv3efTf1pVOpv9Qcb1TyahSLyEYQjlER//7qLpm0S7ZE9m2T46XxBamXjXvDPWBJyi2whHK8tuX0CpEeh742z5X3OXeteHRnO38uptI5fgCWjM1XjLrmu6p8qnsArvPDjhf1PDsQ23CBDFC1kdDcNBPtQ9nVwfS8O6IhHuzE/xPZ5n+edWJL+z1xZvsFLBSd+iO7lCsLDz/ooktsK7CYHpsgQwaRhYW8sFMCEzGKLEcuzU1tffm3mtmjpt4kPQe1c50aHKWMuTzH1Srpd2MDXEXfbQumkaOrlS/9zPaneGheiL/Qknep/8eU2Qsh0xOXopxgtdshEas5ZR3nkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0kDmE4QVbVagAdMAIK7YM1XO5/Uoo3y27OLeZNNk2E=;
 b=l0wfbYTD128Sy6hOUXFVIuikzIh0QF/kYk407FqRtKos5XeTf1fEGN4tya0UQUxkA9AMLEJsfhbWNuVtuFvNOIEhTtGFUsvogiCMSCVrKj8Kv/sQd8TWOlIATY+p0RDYXfwN6hHM/MNWUaZKio7bXvEUcQ10DTq9pdJ1BctkZvl2vuJuju5KVtBmImRCYZLl3lPFkqEu8qErUitI+RaxIUOnogk9Vqzy+CMYjDB1lQlo8mlCSpfcxRYs0zawYKDBcKrdxTJ+f1hdqi0S9Uz460Doji4+vH3SSPHr4cKRSzYnJVZnk0QR6O/Oa1vlpShwG8nKjtXJ3yCBIMTAhw+r9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB7141.namprd03.prod.outlook.com (2603:10b6:510:296::20)
 by PH0PR03MB6462.namprd03.prod.outlook.com (2603:10b6:510:a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 07:11:39 +0000
Received: from PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01]) by PH0PR03MB7141.namprd03.prod.outlook.com
 ([fe80::c559:3d31:1af3:b01%4]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 07:11:39 +0000
From: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Topic: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
Thread-Index: AQHbpFob7Hc6S0T3qEa/cXOHdHkI6bORfuaAgAAEA3CAAAEVgIAAANPQ
Date: Thu, 3 Apr 2025 07:11:39 +0000
Message-ID:
 <PH0PR03MB71412F4BD377ED5E1D6729D5F9AE2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-togreg-v3-2-d4b06a4af5a9@analog.com>
 <20250403-ebony-coua-of-tornado-71d4ad@krzk-bin>
 <PH0PR03MB7141FEBAD45D612440B85698F9AE2@PH0PR03MB7141.namprd03.prod.outlook.com>
 <6d6e85e2-a339-4904-a596-f2866d37739b@kernel.org>
In-Reply-To: <6d6e85e2-a339-4904-a596-f2866d37739b@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB7141:EE_|PH0PR03MB6462:EE_
x-ms-office365-filtering-correlation-id: acbbeedb-02d7-4346-53ce-08dd727ec77b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?woCAp19+Az11FVsLOJTw/huBucZWOz+WN7JKm3DUsVePBTaL6/PFqy3C8r?=
 =?iso-8859-1?Q?/Ol52weJ5Z6EB2m6saIdFTdryCHbMKWcoLAgNRc0NHqUN2wwyp8Mmg4iBv?=
 =?iso-8859-1?Q?o8LRrLqy7PmRQRetOP0jlgESdGLXQpfcOT7kgtRRmkymj9wF7tHqKkgSse?=
 =?iso-8859-1?Q?qcaYuBe+KMVdiPgfHTjcqUfvHbwe48KhX/vcYCNkbL5I2/K/90viJbZJ21?=
 =?iso-8859-1?Q?sP/waw7EhNTr3krMQCTaaLbZm8H4H+aGenmIjrlS/Fbuc94smBB/Ce9j8o?=
 =?iso-8859-1?Q?W0VpQrumJAHk3hgERJtXI6/yOVLMQmR2agR2jXY+ja/0q2bJ5TVHQWv+YL?=
 =?iso-8859-1?Q?6m5PYuepMvz3mfIFECzZ6zzOpxaRz/BX6MBT3zdCu0vfqJVYCcLVA8mzn/?=
 =?iso-8859-1?Q?zb3cNsnf9l4w2U8qfaan8nKJqln3ymIkJu1hK5nBKSdgAYmad1NrdExhyp?=
 =?iso-8859-1?Q?3jmKD312KLlnYYIxxOqJhX4dJekTWU3BvlV+d2W1CDwapKY0aOa0eqy3kX?=
 =?iso-8859-1?Q?JQ7TYJZzh1l29E7NZqND3/oFZ2M6Fc+1otUXoxczYTumXqYh8ANYMlPRXc?=
 =?iso-8859-1?Q?AUh5uHM4rZakKqH3On8qFrVSZ+M8eS2geKXbY59ntcc0e4JBBtXn6T+vuE?=
 =?iso-8859-1?Q?YjIyMsKspWscULHl3G73pSWusdSdHj2Lmgcm7zyKbA1HbHfyJlTBUxIuE1?=
 =?iso-8859-1?Q?bAhHnqdgNoYHdmfSDxajtb9se4ji8dtRpWPnZ4SKkEW1TgbVd6IRFUIpZf?=
 =?iso-8859-1?Q?nzF+MMjBBbNnIWjtU0qqC4hWxpy8+5NSTj3ur6W19vUzgcugsWSkPEdwpN?=
 =?iso-8859-1?Q?JnVWnDHU7Mnsj13odd4OYQaAsuKmuvC6WSPuq5IurCe7TkwKCmgVqSbizJ?=
 =?iso-8859-1?Q?q3XkgMJD03ldVIk/4qW40Pi9mwpAes16h0K7ahC0n7ZBn+vVtyfk8O5qqU?=
 =?iso-8859-1?Q?la5Z7+b+zQ0rMiAKMuqpWCAgpxTWA8ZLxOT6TDqPwPnMiEJ4rTqqRUyTKw?=
 =?iso-8859-1?Q?9JD1lsUYVr0tEYLMn8luVWx1+/U5EqluS98QpX/VIxio/O0c9Irn5z2yV0?=
 =?iso-8859-1?Q?xoznK1CeoaHOy1vLs9vgkWTif67kd5xdBwGjTtktpoovLOwoZvEu9p75U/?=
 =?iso-8859-1?Q?MiEWToVf67NMoER7t5sJw1Axu/3kGYZ5wotwFhRjlhXh7xdIars6h5rt/S?=
 =?iso-8859-1?Q?gRtCLZyeSbwEum/r+bdE2qcB0Zrz4RZOkERhag0so+BonGsog1/w+Ejf7z?=
 =?iso-8859-1?Q?JPNyaqmH3EXTMXI+48NbvzjVxrLgi/TNfibbjR+s1QpNNdNz3qN5j/B80w?=
 =?iso-8859-1?Q?0GA4gRW8tptJFd6VUgo57pX1bcbQrjB8br1DCiKyFLk7brR+jHCGdIrwOM?=
 =?iso-8859-1?Q?hGpkNQeUJaKPbt9DkUeB0JtiVMOHXW9F31VedR+cgp01lBxQaw9fKH86Wy?=
 =?iso-8859-1?Q?tITsUtcjOxukLTB9t3p2375zrIF+qc+ZRRHqsysrP5E9BnI0qLVXuJ30pb?=
 =?iso-8859-1?Q?ddRTmwX6OKQhje5Nu+67jdA3PokEfznx0BjwiNyOZcFQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB7141.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cATEzwWs3Pr9DffkcfZtfrf9vL5tVCeWZeP60EuCdlZOaa6ArkgV4VKoj2?=
 =?iso-8859-1?Q?aPfIu0SAdBSIA8v4UoqRAQFWXJC4jAnS0OSHE81u0G7pdj+EJCJSr0ikZ1?=
 =?iso-8859-1?Q?T+68qgYt1qfriLBmENwyOVgKIlz8ZcBIcUrw3WgZMN70KlwYiF3QfMTwvi?=
 =?iso-8859-1?Q?wokDGQ7NJmWaVCKfrv3cn7KW4ixCESejYTvycTd9b1IWCK/dCYp4pwiCGB?=
 =?iso-8859-1?Q?/tD5DL0aKqcaKWlfTEf/iufo3awgqerXnqcR/RjKLG7kad4SLO+BEPCEx5?=
 =?iso-8859-1?Q?WYKJRCiIHneZDijYitdfYpNMG/1UUp5XIS2QKFdgD8/uD5eQl90pAPInp7?=
 =?iso-8859-1?Q?tf7x/AaG0hvfJgNHKBGcVLvnHNxr4AWJC0dXFSVdUawO8+ydEmCX0PoLGN?=
 =?iso-8859-1?Q?WsMW/4ZJCtA1LP7sLulSStGWfa1lMqLzNTG+/euGWBlxJRt5s9Vq+d2gvj?=
 =?iso-8859-1?Q?I1d9l2H125tJWVA93Qs9DfxVuqKu9bvHaAbqfKz26U+CdnGnC59pEFgAZJ?=
 =?iso-8859-1?Q?EWDS9D8uD/kYHLTsLCrbdkceL4oO7SnKbiG0uxGPE08VcMD5NjtKGPprrc?=
 =?iso-8859-1?Q?808B/kF7bW7+G45t0j38NGXbLRgd4gK+lIo8mUN+pWUSUCUaCbzv8IlurK?=
 =?iso-8859-1?Q?jIvkBv3M/FL2CDPGh/uK53mhBj0nyBx+DCtnG0t8Q//vP2gKaKNzcK7mEz?=
 =?iso-8859-1?Q?yISwUxQL/ZVrgevEw1lOdYK2hfCiYuzUjx80por+7EeyYmNUudveEHR5M6?=
 =?iso-8859-1?Q?Jc3qLmZePFsXSYuDIC0GLZxxH+XvRT+ZZR/7PXnUMQfdaZj6uedFpJD+Hr?=
 =?iso-8859-1?Q?2GyfucgL2wJ9oMbddWadU1TlV3ofyTUkl+8BbMSTlYYjxwk2WUm6lkHMw1?=
 =?iso-8859-1?Q?i2BNPFfBPTOjOOhfZ4xe9BtiE1VE2nj1+ejrJtK32xyf34Fp4gc3ZlVTO9?=
 =?iso-8859-1?Q?qgFDZG4rOf+9H/UMI70gQIfywTzNw3U8AUKogRdeyJZhgclvf6Pt1YLv1U?=
 =?iso-8859-1?Q?ivAVc012ILXM6zp7IYEL7krBetUUr6DRs6352Lvoo0aScIfHjVAktkWo6d?=
 =?iso-8859-1?Q?U4act6QFc7cUFdMBJTgRIId1z7bZSFVjRCcKiV+YLe87/8HHVGg6Qa6HJc?=
 =?iso-8859-1?Q?zmUFlxBAqqOakCv5vbBZEupPDuTnRIDLqdpsfyMDj/LssZ5neq5PSlXl8V?=
 =?iso-8859-1?Q?29GzcBOiPIKl3njOyS2xx6d792/8k10wtdFCKAIngwMK4iKDWs9SpKBqEe?=
 =?iso-8859-1?Q?9BfLh2NnUDR6a3f13OiNWm8WamfXmHWc0hMQ3gTDNDjInxe62SaSLJgeMA?=
 =?iso-8859-1?Q?A/2lfVBPbPH1+6C4hLq6cfXsgmZP9UZxjrXAsDYuviLLQ4pCcu/uRWdR2W?=
 =?iso-8859-1?Q?gmoFZnT8OirAo+d7FC8IbMtsB1k+nRykN9w4JfRILwxIeIMbVtML1GK/ip?=
 =?iso-8859-1?Q?i5ckidDU/JGOWvptHXA8cLAAstkkvMwSIKS7ikrcDbWaCCLtWpGvyE3+m/?=
 =?iso-8859-1?Q?G4ATTD0nv4ITWirl4S7qA7vuyZLpJckgD/zdqrEg5ub8PV6Tc14Yg8dpy5?=
 =?iso-8859-1?Q?E+MXOKJz7fkxHeQXgdvUxcwpdoNSp52Kr0Z3cShkSSdfSxf9oCbWStCzGV?=
 =?iso-8859-1?Q?j7r1bQ43eohb17iwJ8ICR+dulZQJb+t5QO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: acbbeedb-02d7-4346-53ce-08dd727ec77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 07:11:39.4603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6/Ef9ev2vBc3LbRIbv6X8FgBGTg0yt2KdINw24yryEsHjIhDBjlVRdj2Pq8g0dIcnOhJ1D6x9QUQB0fKe/NQZr78pXXSM49j2ZtkTAgu7Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6462
X-Proofpoint-GUID: KqODGErRqBKqymr8TZvzbSNbqdJlVEHW
X-Authority-Analysis: v=2.4 cv=TpXmhCXh c=1 sm=1 tr=0 ts=67ee34ae cx=c_pps a=IwUfk5KXFkOzJxXNjnChew==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=RaD67vL0a-XrJVhsGtkA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: KqODGErRqBKqymr8TZvzbSNbqdJlVEHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504030033



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, April 3, 2025 3:02 PM
> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> Conor Dooley <conor+dt@kernel.org>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml
>=20
> [External]
>=20
> On 03/04/2025 08:59, Paller, Kim Seer wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk@kernel.org>
> >> Sent: Thursday, April 3, 2025 2:44 PM
> >> To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> >> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> >> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> >> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org=
>;
> >> Conor Dooley <conor+dt@kernel.org>; linux-iio@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; devicetree@vger.kernel.org
> >> Subject: Re: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yam=
l
> >>
> >> [External]
> >>
> >> On Thu, Apr 03, 2025 at 01:33:56PM +0800, Kim Seer Paller wrote:
> >>> Document the AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-
> >> channel)
> >>> low-power, 16-bit, buffered voltage output DACs with software-
> >>> programmable gain controls. They provide full-scale output spans of
> >>> 2.5V or 5V for reference voltages of 2.5V. These devices operate on a
> >>> single 2.7V to 5.5V supply and are guaranteed to be monotonic by desi=
gn.
> >>> The "R" variants include a 2.5V, 5ppm/=B0C internal reference, which =
is
> >>> disabled by default.
> >>>
> >>> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> >>> ---
> >>>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 99
> >> ++++++++++++++++++++++
> >>>  MAINTAINERS                                        |  7 ++
> >>>  2 files changed, 106 insertions(+)
> >>
> >> You got report about error in v2, which you did not respond to.
> >>
> >> You send v3... with same error. I don't understand this.
> >
> > I'm not sure, but based on the information provided, the errors might b=
e
> > unrelated to the driver, or I might have missed something.
>=20
> It's your job to respond to errors one way or another (unless there are
> obviously false positives). Ignoring them means this is marked as
> "changes requested".

My bad, I'll take note of that. I think the bindings error reported in v3 i=
s
still unrelated to the current changes.

>=20
> Best regards,
> Krzysztof

