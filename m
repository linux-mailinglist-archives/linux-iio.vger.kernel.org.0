Return-Path: <linux-iio+bounces-5997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BCC90026F
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 13:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7763F1C2253C
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A614618735F;
	Fri,  7 Jun 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XQQSrQpr"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2059.outbound.protection.outlook.com [40.92.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811F170830;
	Fri,  7 Jun 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760523; cv=fail; b=T1F6lbeKeZKoZhfv6mQCrd29Al/MWP02bHP5K/Z9zTW6zuLNtU6qnI+OeQIeKRmoS3bYLzuaq2uii5cANJpDbSQsWYxOwfz1xmYzy6r40D0qT7q/GmvkiIjdF3BhexFMNjar+tqMIJNAhU2DhGknbzpvKxqGq2SbQ1ygZTpptn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760523; c=relaxed/simple;
	bh=PdC3D22jORJ3L5xWH2J3IfuUrt69cgf+Hb7ihp0xs5U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j9cqqiJTfIHBybCln67DdchlLTnHtq32/3V9xfm4VkhWLXfkDJ1el0UANcuhoARokh9heugXr3ZqJfSrGCrJqL7gafRK8erqR3zfy5XfFeAsJh0qwNsCxzjBqvhioYy1ZDXfZCD5JNcOnrcnHiqZqfw83B8gJ2kRW/JmtFKRbSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XQQSrQpr; arc=fail smtp.client-ip=40.92.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD9lr4mLmFwulBLMsmv+ZGFyiznqgnb5zsdz8QZkpwmpodDWb59KHYe6KlHxJX2m8A5qsmkYhzllJR3e2tt1nKRdz9BqyzI6BWS1HXmcCjpo7W0NjkSeDq15ZP2mX9FbUCkQSMMgqTWw2epmpRg9z4fE7j9QNtsIrW0YR3YDpj/JCxa7E8A9NI+CzDS6JADS9c3CsjlELBEWlVOtGP3SvpqcZJyOREPujlenvRvc3Z0JFa7hVDtWzoU2KmMYtHoLjnBeGP98gNU6JAHXbn7ElPkNLTy8AK6jkWA2mxsWEBCwx/hM4DQu4Tb1CuXBze9POmwjvyRaDczsCvkTlPuZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02xwAbFbaeb3QuFhxOIGvHTmvnhfH9bKR6Lhn0ulgRk=;
 b=GJ/7jCrYDsN7fDLi09fhVOe08cSKyZpzj5rNsxh65HLngfnZ37Lp/93NaCXHnVpzUJ/w6jHniPo86090kId4yEV4/7C67fn2AdlfzvC7CFLaelxmyH48R8dPOAmVYSeN14HVN3bjl77KNs6ptV5R6jBqTlw2GmHxUR9eQUHzlVEZEyaG67MD3KArpyB0mjX4n3HEpoLyiIrC1ZjgLC1PosERyrE+aYx8WcdqdV951icoOHSXuuQz9paIN+PmITcpLAUMZz3V4hgqAnwLiPqBcgrIqgeIBJJ33ZZa09HfVSDMRwkwlXUTEASd86LfgD/qHouR6yx/NYh4z83+DVeXLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02xwAbFbaeb3QuFhxOIGvHTmvnhfH9bKR6Lhn0ulgRk=;
 b=XQQSrQpruF8DwVobkWozn3GZdsf9oXVDbpmczBWSss83+u3gS3IGc7Se6QXOq6z7InCoJsD60q8pFqL0lNx/QLO47ACepi9hPYUQMnWuB7amgIen/++T5ZdLY1iBmCuHyt3Lc99fCenzkKJ9xLiWE86m5sB+q/viwrqR0+sW+RGKgVUDvKKXg/mt1uCCqhYWmHG3DkGTntRlp6fnWRLT6320agev+Dx0rLAdN12XCVJr6fTRihEHoGRiNiLcKKPTGyCQGnryY/Dsqk+JxNVhYSXl8aJX7R/RXySQBSdje13QArlLVGYvOGD2af80r3kPXTZ0hqB6duwpKfTf66L7RQ==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 11:41:59 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7611.016; Fri, 7 Jun 2024
 11:41:59 +0000
From: Yasin Lee <yasin.lee.x@outlook.com>
To: jic23@kernel.org
Cc: andy.shevchenko@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.a@analog.com,
	swboyd@chromium.org,
	u.kleine-koenig@pengutronix.de,
	yasin.lee.x@gmail.com,
	yasin.lee.x@outlook.com
Subject: [PATCH v4 0/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
Date: Fri,  7 Jun 2024 19:41:36 +0800
Message-ID:
 <SN7PR12MB8101204CE811B8E88A2464CCA4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [obcYyx83dirNGFa/FlDLZzdq5ssN8gQ6hWfbCd+xQRyq+NJ2L+8bEScUJ8QVNWe4]
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <20240607114138.390272-1-yasin.lee.x@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b27c581-fdad-438e-8c1c-08dc86e6d71d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	cGUHdiQnTHuEdK5NphTuBS2FUJrgaiu4vUQBUzgou8Xw2VVSaor5rDLIh75KIfUek/FQKPiXe06OnL+6oZ5aVMjtohS4y8TfFfM5s6BCj6y1yrAk3da/3sRvgwk70kDgpjQV9DyfRh71hDTJZrqhP2cD4Epz8eu1HGjJMgBIMwRn9pZMHBVPVrtsJK/cAhGEjoAgxqHuhhBN7Q+Nl2XKsl/ZrRD7eOjNQAAfuVLioH2mCnC0ZAjJCClqlj3DXziC1Yn32eigl5mgLPX7VmLkhppHyfXYCyLEZRlB5E97KuIaFks+6sr3yeTl4XftIQ/ii00nzT8fbyUI9fUgjQA17ufYdxgNDRqgJB4fyz6OLFA+9kw5ZFUnUmgpXleXfkXghc0gItzLxt4w3bI3N5l8nJmWcufjKWzau+yYFI2UEOV/cN+nlrwMDeiNK1YOPe66OKlkAKaz3Em/+TWHoZEEBU8hMzqsMp+TsH8sOhpTpDySiqVhHCtndnZJCO/ml7Bq1xV23S1E7JPuFsLO8rF+mGjnnvDzw37gdn2oDmjD5R7y0R5hVFjTSQvOp4bfniq1nfefgMAIroiJH/j9nEuaGjQEDEeMarS/RC5duIe6Eqndkk+uhqFrfGSCbdAAczRW780YejF75i/bYZ+X4mowtqAO/kTzkOMjybePtSz8E3v1oZ2cMGJJunCN1tHCwiq5A/WfDAQz1J0cCymYQFCXtCyWu0XRtuhu7OSwIxHNIAp4B9udFrdDlQ1ytlTMGM/8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?27CAP1DP7yEbjfpF7qniqrD4hyWuPArlqxwe4pOEePC+eURbBII/IPbDJxCt?=
 =?us-ascii?Q?t1hgrHE+06of06O7/KRjYNRS+iGBAoFYxA1HbjBI56ky0CVG+hAINohXVAeL?=
 =?us-ascii?Q?16fp2IGhWKGqUBDWCZDFoKdePlnjudCBH+55g2p3v0l67Y0FE7GDg/SItSmI?=
 =?us-ascii?Q?hdh8PxS9MBWyyJj8VVmAQGA1eg7kY+SivxLzzjgLsIgGi3zxCGWIkfVCQg5p?=
 =?us-ascii?Q?ydwX+cn0iNmeuL0MwbIVKV/VL2taLKH4yBvakgqPWqaPqElT1xZwBPY5C7qw?=
 =?us-ascii?Q?kmdsM4Bd0bfMdBOj5pARCbTnNfblzybP2OytpHh3k8HeyWU2AOa56/maH+hB?=
 =?us-ascii?Q?3dotgi2NbrfE4yo1BRPDX1EMguGNNlE/giXNClwcOWg7zlR4lm28EQOEdB7R?=
 =?us-ascii?Q?N+JhdE/tOtKxNonTru37OzuuvUgn//2Hkgk+xR/znWJhyppGGYd5/Y4eslJL?=
 =?us-ascii?Q?BGbV+dmBG5pol60JbKMyplU7PqJaIt4xlv5l2RZVKzpIZaUhKgpY8GiJWpRk?=
 =?us-ascii?Q?2B5timS9qgj5TtePIXUFJqPzndz+iP3xDsZdYnVafbL6nNPacUBbvlzi+lrg?=
 =?us-ascii?Q?6Xi9+wq0bVG3UiJ8nm/tPEMDw0F42dPYsVlHJ7rRcd3tCMvinx80EQESIPDi?=
 =?us-ascii?Q?O01Q9NsucQjlmTwHYCNHV5DNibrVJk8H8nVnpJ1WWW3q57WUk6PFXUI2+63o?=
 =?us-ascii?Q?KFb0zSRQR6NtoZEwpVp8j9uKCZkGwQKYY/Nq97VzIRf/KWK5rZU5CweQ7akJ?=
 =?us-ascii?Q?HBifCH5lrqb3i0KGEcqP4t/bV6lk7H/dQ2cjYzlX5Ol3Vnxf4/wjwrT4Z5ZI?=
 =?us-ascii?Q?ON1gDk9gf394f1kUqmKp4PbHpakA/tT+vHxDt5mZ6NpvkQqBA40iliiROPQ8?=
 =?us-ascii?Q?sTXOYJPoymjPIE98mp3LaxHhgtycSsHaRyFDgQRBFxA4WRwAHWagC6DwKhN2?=
 =?us-ascii?Q?7XA8+7Jh1I43Wh113z7J8fh6EpM/x7pOaG0RuGcerrfWA2GqMsOe/xYHdthD?=
 =?us-ascii?Q?P02ggq9+qNr6fw9SwetfcEzUbuGqu6V6JyzgYzXKY+63rzB/yXLSYp1HOF/V?=
 =?us-ascii?Q?Ryg29KzUbzrEpqN5GWgcHvdsaEgS9faKA7iOtZaOzUJL00LHH8GuoVLXWOjh?=
 =?us-ascii?Q?tbfyW2RQ0QIe9bYe2IvtkhbWUH/vmIiVLNgJdw04MG5KvTZ3fM57VHOyeh67?=
 =?us-ascii?Q?RWmXjqpty+viaAT8FfvJf28F1Tm/br+ZMajyNEWhwwHo6bsAwMnjf9dH31JD?=
 =?us-ascii?Q?2czA2L0nsHLKVtGFG58SGMf03UoeIb3A8F3RDRvwMeJdOqQib0cFsFw6b4yC?=
 =?us-ascii?Q?rkigC7OB0usmtPwE0SNXdz8k?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b27c581-fdad-438e-8c1c-08dc86e6d71d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:41:59.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

From: Yasin Lee <yasin.lee.x@gmail.com>

v4:
- Removed hardware-irrelevant properties from dt-bindings, retaining only channel configuration
  related `channel-positive` and `channel-negative`. Grouped by channel. 
  Retained `channel-in-use` as it is hardware-related.
- Removed redundant register definitions.
- Reorganized `struct hx9023s_data`, extracting channel-related attributes 
  into a new `struct hx9023s_ch_data`.
- Optimized bit operation related code.
- Replaced `of_` versions with generic firmware parsing functions.
- Fixed other issues mentioned in the email feedback.

Link: https://lore.kernel.org/linux-iio/20240602152638.2c674930@jic23-huawei/

Yasin Lee (2):
  dt-bindings:iio:proximity: Add hx9023s binding
  iio:proximity:hx9023s: Add TYHX HX9023S sensor driver

 .../bindings/iio/proximity/tyhx,hx9023s.yaml  |  103 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/iio/proximity/Kconfig                 |   14 +
 drivers/iio/proximity/Makefile                |    1 +
 drivers/iio/proximity/hx9023s.c               | 1162 +++++++++++++++++
 5 files changed, 1282 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
 create mode 100644 drivers/iio/proximity/hx9023s.c

-- 
2.25.1


