Return-Path: <linux-iio+bounces-15319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB77A30386
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 07:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB9C188B931
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 06:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA191EB9F7;
	Tue, 11 Feb 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjh52V0E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7E1E9B3A;
	Tue, 11 Feb 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254995; cv=none; b=Y9dRkwE/8UkAgsQmoA3K1L2AZq13u2FERpJKmOp74pO5+NgIhIoAwhYScVzGElbGiRsYjAfWLnGGvfXYmfT6ZszU2+pVVnVBB0XmTN7b+ol1IEKQKp+GIfQdN6ZS/uKjTFrs1AYafATjTb3pwhRRX5ud/GCiOmBUJGTvrbbHNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254995; c=relaxed/simple;
	bh=VP+0OZbabFM/0FL6qHMMCJ1i/0p2nHkpJ06PdIuFtZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tb7BwY7i5jw/X/xDrnZ/R9dBg8Nn17A+oP69gbwbPN90gN4USp0uw3+VrdGnbZfi5XH5Cr+pIQrjn3d7cwabzW1dkdW+tVcsbOpo+lBiYeEvb34XxlQy7eV9NsGH20Hx8j9vIv+N6BOWewzMARkon3H0y0xv0XExRFE2VhwRU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjh52V0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EDEC4CEE7;
	Tue, 11 Feb 2025 06:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739254994;
	bh=VP+0OZbabFM/0FL6qHMMCJ1i/0p2nHkpJ06PdIuFtZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pjh52V0E77oHC1Y+5uIoCFbvR2qJk9UAgxY7OMKVVUeI5FfHVkpd/4BhFbF7EqqvU
	 xu6aKV9ks6DCL7yixJT0aN2KSMgiy3zPWIWQpO2+VKbkm1M+LZXfdyTudYhndTZ49k
	 QWqh58vAh2gfHxmMs1BGp8S5xVg6kpg7OjkKzuwUP4BienTkkUs95CUMX1GIqOucy5
	 EpLrwSsdqpkYneK5xsBOFw3tbFZQmoiUch9979fRNnFjYezaM9pUPVAzShz+36s7ch
	 pkbdUv21DCoPwZb7diXrNLxfcud/MwOWbgZCS8K+cQAH/SPQ6wUeA8YxB4OP8SKo5V
	 Ay4VCA1gX0Oiw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1thjfs-00000008YBb-3eUT;
	Tue, 11 Feb 2025 07:23:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Jonathan Cameron <mchehab+huawei@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Thorsten Scherer <t.scherer@eckelmann.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/9] docs: iio: Allow creating cross-references ABI
Date: Tue, 11 Feb 2025 07:23:00 +0100
Message-ID: <10e7d46360b5e5782d5c09e2706ba47c2315df4f.1739254867.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739254867.git.mchehab+huawei@kernel.org>
References: <cover.1739254867.git.mchehab+huawei@kernel.org>
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


