Return-Path: <linux-iio+bounces-14648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF664A2023B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 01:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9E918843D1
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 00:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF637157A46;
	Tue, 28 Jan 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIXLnxTN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC26383A5;
	Tue, 28 Jan 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022797; cv=none; b=n42gnjl4HKJ6PjdgWUYsVcdyrMPM8k0iWgd6QX0RU47VK3wgn7DAU16alMqHDUOotbYiPQtGlmDAXfH2t6+pAOk5/wjEbV8lRBjTAu+Ga9LE3Mq/IpOTM5S9kz3wO4EDIwgjGYfMOQPuen3RmDDXfXiG6/n6CpXttblW1EWu5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022797; c=relaxed/simple;
	bh=QXk/JHBxUK/Ths9qSQMqY9AnKVsl6SgMJq6d9H2BT/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLB+FBoamkiHw9teOm5NDe8beyv2QnYpp3XxThuhU9iUCUerYIRaNCGT/BX/zeVzebvjdhWL4aK00r/uxqDeW8okOtSuQQ0hdZV1LmAqAee+R19Db3Xw8rJAj6k+4yHbMvyThAfl9xLhQIEQFoWcQBpDw4JtKOM3oJMbvR1Mwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIXLnxTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465ADC2BC9E;
	Tue, 28 Jan 2025 00:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738022796;
	bh=QXk/JHBxUK/Ths9qSQMqY9AnKVsl6SgMJq6d9H2BT/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIXLnxTNG7OUcOH0i7SRQ5lOz+0+nOzGxMUrgCJ/obzhVCbDHTnqhtjfeZwzFSWqN
	 MOId/APnwOc3reFr+2IyuAD5B8y67Mr8zv/G/Ug8gccKFfBvQ2QodHKQ5TmTn03lMp
	 9OmuoVBdIBfn7Mie9wFU59bLFlBCUNeSEXzU1Xwro0iXzgpeaDDJ9T2ntHC6/2m9kC
	 aUg/MFKUxbM+3owqFkhUtuSzAp44Ok2GhKgq6QshyWtlGCNDe0yBmd8IGfDUMCv+IH
	 7dty8Z5hpkaU3Pv3Mvxj9FDI91MlXz8GGlrSYCIRZ4hWN6TpgFM78Juwvi0JpflufJ
	 G3+/dPhStHOjQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tcZ7i-0000000DRMN-1gC4;
	Tue, 28 Jan 2025 01:06:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	William Breathitt Gray <mchehab+huawei@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 31/38] docs: arm: generic-counter: Allow creating cross-references for ABI
Date: Tue, 28 Jan 2025 01:06:20 +0100
Message-ID: <f948077fda09f7db7f13f5e1802e9c42926228ad.1738020236.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738020236.git.mchehab+huawei@kernel.org>
References: <cover.1738020236.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that Documentation/ABI is processed by automarkup, let it
generate cross-references for the corresponding ABI file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/generic-counter.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 71ccc30e586b..e826f16ea43d 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -467,7 +467,7 @@ Counter sysfs
 Translates counter data to the standard Counter sysfs interface format
 and vice versa.
 
-Please refer to the ``Documentation/ABI/testing/sysfs-bus-counter`` file
+Please refer to the Documentation/ABI/testing/sysfs-bus-counter file
 for a detailed breakdown of the available Generic Counter interface
 sysfs attributes.
 
@@ -483,7 +483,7 @@ Sysfs Interface
 Several sysfs attributes are generated by the Generic Counter interface,
 and reside under the ``/sys/bus/counter/devices/counterX`` directory,
 where ``X`` is to the respective counter device id. Please see
-``Documentation/ABI/testing/sysfs-bus-counter`` for detailed information
+Documentation/ABI/testing/sysfs-bus-counter for detailed information
 on each Generic Counter interface sysfs attribute.
 
 Through these sysfs attributes, programs and scripts may interact with
-- 
2.48.1


