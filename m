Return-Path: <linux-iio+bounces-25408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB84C04C87
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 09:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A330402DF6
	for <lists+linux-iio@lfdr.de>; Fri, 24 Oct 2025 07:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522A2E8B86;
	Fri, 24 Oct 2025 07:40:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFF2E7F1E;
	Fri, 24 Oct 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291629; cv=none; b=d3KSV8/QLxuDNj6rfjFsEVZuxwrYTaM270dBzcI0E+T2SWcFgeCp/fVwSzWw4p5fZXXuyZ6hoom4pVJJRD7K8oq8dirmBgFyiGi2hkhBO4QWuYKWtROVtlYIEhJIoy91S21HALK2oS4XJQeVltU3vudrLA70hRQMoKOcqVQxasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291629; c=relaxed/simple;
	bh=B9t+WbFDPExHpKqXcAryhKApAVFNU65xTWDlW86VmwQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mXtBBwiJAZAtrzntYKRNd1vc80Tg3DiDlJsGLII1B9aUlNPUPAYFi7psHS3QIG24KZv+48OUB4tfPKhgybf1rEiom94cCfXOBQLpP9xQxCj2jvKNMzK0bCzr3ujEvk/OQvmlqehiAWSgcE2ugvNolkz9GBVLEEj+HPhXfRncdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201616.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202510241539114872;
        Fri, 24 Oct 2025 15:39:11 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201616.home.langchao.com (10.100.2.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 24 Oct 2025 15:39:11 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 15:39:11 +0800
Received: from localhost.localdomain.com (unknown [10.94.15.147])
	by app4 (Coremail) with SMTP id bAJkCsDwVbUeLftodiUPAA--.3167S4;
	Fri, 24 Oct 2025 15:39:10 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
	<subhajit.ghosh@tweaklogic.com>, <javier.carrasco.cruz@gmail.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH 0/4] iio: convert to use maple tree register cache
Date: Fri, 24 Oct 2025 15:38:19 +0800
Message-ID: <20251024073823.35122-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwVbUeLftodiUPAA--.3167S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1fGw1xuw1kur4fKFyfWFg_yoWxtFbE9a
	1Igay7Jws8Crs7Gr9rAF4UZ398uay8ur97tw15t3WDAry7ZFZxAF13ZrsFv3WjyF4rGF1U
	Jw429r18ur1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?RDLXJJRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KW9TpcXVrVhr4PSn2h1PUQpaG6idhgP4zi5jnB0usMjc1al7oa9VVacecULWQWASRKCU
	Tw2v/+aJSyUemtOHV68=
Content-Type: text/plain
tUid: 20251024153911eccda1dd526aa682cf3d1657bb63dbe8
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The maple tree register cache is based on a much more modern data structure
than the rbtree cache and makes optimisation choices which are probably
more appropriate for modern systems than those made by the rbtree cache.

Chu Guangqing (4):
  iio: adc: ade9000: convert to use maple tree register cache
  iio: light: veml3235: convert to use maple tree register cache
  iio: light: apds9306: convert to use maple tree register cache
  iio: light: apds9960: convert to use maple tree register cache

 drivers/iio/adc/ade9000.c    | 2 +-
 drivers/iio/light/apds9306.c | 2 +-
 drivers/iio/light/apds9960.c | 2 +-
 drivers/iio/light/veml3235.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.7


