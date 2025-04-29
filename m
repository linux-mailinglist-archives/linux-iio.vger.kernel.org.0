Return-Path: <linux-iio+bounces-18869-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92147AA1A92
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 20:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2275F1883148
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D183A2517BE;
	Tue, 29 Apr 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ZTpnxNjO"
X-Original-To: linux-iio@vger.kernel.org
Received: from outbound.qs.icloud.com (p-east3-cluster3-host3-snip4-2.eps.apple.com [57.103.86.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAD21767D
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745951176; cv=none; b=lmbvOJcIWi8YrRENiMAySqB0hVBXToeV74LG1fwGxxHOrJKcEhw/+BOcIdAuS8VKt6NTEiRrpcUCby1DcPy++h+7ItlKj1vc9v/vdvsLq8KsagtImR+S2upAQOisKs6ty4BarqF0POViAkPY2nET0MeleSIoWWRwrnlvNT5TDP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745951176; c=relaxed/simple;
	bh=czsvM9cTYYsPqwbR0ln7gTK9CAFoZNcxt+UltoZtzUA=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=s+AGv21X67wJw1FS47T1qE8CHg5jOni4Li6iOBuXSQAlwCTHULeUT4stp1jmnM8+q+ucB/R601C/wqV6+kiv9asC3hHApF2lrC86GPq+ngo/RARWjv9f8dIU3pCuyRnRfews0KYWpI8/C2V6UUtBN4XmheB7aZFBYWslrAybjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ZTpnxNjO; arc=none smtp.client-ip=57.103.86.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=czsvM9cTYYsPqwbR0ln7gTK9CAFoZNcxt+UltoZtzUA=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
	b=ZTpnxNjOyyVD3K6ztaKT2UHVNNDcQl/63AdHcH6wTM/fKCwbkxfgQdENXve606Xi2
	 uaDEvQ4S6KwN8/G9WCpFmpaDQxYWRlQ8HVRd6z+eumRKyEHVvoGH10qd6Wxe/AWjsK
	 oMEh7bZ0dVY8/oW++46NsyOpWKG8Lt1Rs2HURNinu9pKUl1iTPkGsbEtkjdMBEZ8X8
	 jNQxNb+GU69EcC4C/0OoR0hN7H6K+au0T1V/89xAtFZfcJXB6fflowzZm92yRypldW
	 RPbhtQnVHDsHs0Yf37+xqgyD5ZrgIF42dSy9SAlepmS8jJdjZNkOje3ykL2pTZas65
	 UELI9pAZGlSIg==
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by outbound.qs.icloud.com (Postfix) with ESMTPSA id 4A26C1800208;
	Tue, 29 Apr 2025 18:26:12 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: oryakerbay@icloud.com
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 04/11] iio: accel: adxl345: set the tap suppress bit permanently
Message-Id: <0A3666D8-BCB2-4F1B-B63E-CFAAD3863D61@icloud.com>
Date: Tue, 29 Apr 2025 14:26:00 -0400
Cc: Michael.Hennerich@analog.com, eraretuya@gmail.com, l.rubusch@gmail.com,
 lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To: jic23@kernel.org
X-Mailer: iPhone Mail (22E5216h)
X-Proofpoint-GUID: oltOoqMdYLgqpnG19l0bopPpBr5Znd85
X-Proofpoint-ORIG-GUID: oltOoqMdYLgqpnG19l0bopPpBr5Znd85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1011 mlxlogscore=535 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504290136

=EF=BB=BF
Sent from my iPhone=

