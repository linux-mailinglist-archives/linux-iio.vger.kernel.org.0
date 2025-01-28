Return-Path: <linux-iio+bounces-14647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1ECA20235
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 01:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7C3165B8E
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 00:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371F14D6F9;
	Tue, 28 Jan 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6QdLOBG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA962E62B;
	Tue, 28 Jan 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022797; cv=none; b=uZXgMN4P3zsFvk8PmuDi0Yu76XvVkJsvFCjiuwUuTWqgV50r5Tw/aOwS/JoNmXvQV6MoEeONdJsPHGtxgJfq2FYp7qlC766J+wu6bB5VPXJSXccZAXf16WzIRbV/vtmV+q/F0SwjN7tVFvTJfYHpulOCK5r2uGcZmggsRsbMxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022797; c=relaxed/simple;
	bh=aJ8SN/KmweREPu+e3BrG68E3yExC74uiWb70lROkL7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e23IdOE+7O6L3I/ihk6ZqdIsOcrpWNNVEzlxOueBaXfhMiFsbS+6kMBGKM37ECNgmGd4ZgVSk9qv8YTuTYo+sQNoMC5Eoan6qeLZ3yN+5IR0nm19np1X0Iize4w2r6bpvWkJ0/QZpGc47LJYMKB31F7e9kwq0kP6AnQEzvqXqnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6QdLOBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36367C2BCAF;
	Tue, 28 Jan 2025 00:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738022796;
	bh=aJ8SN/KmweREPu+e3BrG68E3yExC74uiWb70lROkL7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6QdLOBGGkLHrxzXL7xRWh8sA571ucTDZ13JHOz81/gCmvSBA/K+cG6iGGzB+P32e
	 ezTwKuU7l+Hu1Ob8YZKIaPTZy2ltOtHdEQKosTNlh+Hc9uuKJ0v2gJCkPP57sK41Bo
	 jleDMqW6uyNIR59ZzzhA13UzeMTRyBMig+GYofvNJ6ge+CEPqTVbSvGOpAE6TB/MMG
	 Xkd/1P9pn9yf4qMrHQf60K7pfgDjfaJxIpCeIt51B1LUAsxA1SnkOaxWpobqY4MGmy
	 rzLogHiF2rpRKV/+zPYCYUFj/Vj3ERsDfJ5EZQ0EzAEcOjVcqyZgChcbF3Dt62HJ/D
	 5GHdv4pY5UfFA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tcZ7i-0000000DRMR-1nNr;
	Tue, 28 Jan 2025 01:06:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Jonathan Cameron <mchehab+huawei@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Thorsten Scherer <t.scherer@eckelmann.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 32/38] docs: iio: Allow creating cross-references ABI
Date: Tue, 28 Jan 2025 01:06:21 +0100
Message-ID: <71e13fab5e63de2f16d6953cc6ebf3b51f1f9f6e.1738020236.git.mchehab+huawei@kernel.org>
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
 Documentation/driver-api/iio/core.rst | 2 +-
 Documentation/iio/iio_devbuf.rst      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/iio/core.rst b/Documentation/driver-api/iio/core.rst
index dfe438dc91a7..42b580fb2989 100644
--- a/Documentation/driver-api/iio/core.rst
+++ b/Documentation/driver-api/iio/core.rst
@@ -60,7 +60,7 @@ directory.  Common attributes are:
 * :file:`sampling_frequency_available`, available discrete set of sampling
   frequency values for device.
 * Available standard attributes for IIO devices are described in the
-  :file:`Documentation/ABI/testing/sysfs-bus-iio` file in the Linux kernel
+  :file:Documentation/ABI/testing/sysfs-bus-iio file in the Linux kernel
   sources.
 
 IIO device channels
diff --git a/Documentation/iio/iio_devbuf.rst b/Documentation/iio/iio_devbuf.rst
index 9919e4792d0e..dca1f0200b0d 100644
--- a/Documentation/iio/iio_devbuf.rst
+++ b/Documentation/iio/iio_devbuf.rst
@@ -148,5 +148,5 @@ applied), however there are corner cases in which the buffered data may be found
 in a processed form. Please note that these corner cases are not addressed by
 this documentation.
 
-Please see ``Documentation/ABI/testing/sysfs-bus-iio`` for a complete
+Please see Documentation/ABI/testing/sysfs-bus-iio for a complete
 description of the attributes.
-- 
2.48.1


