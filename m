Return-Path: <linux-iio+bounces-2625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72322857EEC
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E09F281B2E
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDBB12E1FB;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx7XXuFE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7512D766
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092689; cv=none; b=J6HmTDWf5Y5xxYeFYtcuoS6Z73ab867930qbMslZY2EmyZbDOO5ujXQz7NpvYSkGzbflnSBZrnaJxI1bAJfsaWrwqWBckwS8v25II93dYLbJAthABH6o7UncQF/FUvroJE+O5LQXN+QDvXoF0I/AcauOVnZYQXQKld0imf+7UHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092689; c=relaxed/simple;
	bh=Tuo7/PzJzLX1SAtU3H5a7iHPPv2xWVJsxIzSubTHDc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbHa/b+NHL7/+6RQ6olAaOYkQPbIJrNBOO9eh6K5LrGb1oPPYifyAX8MCSi8NtBq31qfWXgLw+wNDEU6z2uiUclBJsFi5tHmFZXu24X2Zra5P24KhVBpwn3JOwo7+YiBhqCb09/ZBDEEwRfmzS0wRsVC0+h66KlbchiBkMzX604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx7XXuFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40C51C433C7;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092689;
	bh=Tuo7/PzJzLX1SAtU3H5a7iHPPv2xWVJsxIzSubTHDc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rx7XXuFE04kDAZ8vvEuAUz7eZL+oEnchZBZ4lPpYwhttmQV4IcTnjcUPmpIW4IC5d
	 zrjWjYXBvFP3S8Xw+Uz/RhpGFLp5RrVsw+jPMiohRiaUyobUBPIY8Jqa1ATOsaxD94
	 TH4ZNDGWNhxPDoUnf8hm3LOyRzWLGkDzl0r2lD8/TVMzxCdoMqNxV+Sfu5Hf/Aot7N
	 u2HsTjMRJyfVoP/hnCHvV0nPsqVQ3QfZF93bWsKQ3fyw7YX7+g1YkzZVDNVv0DcR6Y
	 SJW+Q7t5bsJbSaAKzuvWMDxwqBEB5z5cJZp0dn1hKxCKZqmPPbfdW4li1fsT28ipCY
	 jOtW8ZqrX+JGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259FEC48BEF;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 16 Feb 2024 15:10:50 +0100
Subject: [PATCH RFC 1/8] iio: buffer: add function to set the buffer
 direction
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-iio-backend-axi-dds-v1-1-22aed9fb07a1@analog.com>
References: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
In-Reply-To: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708092664; l=1611;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=d5nwu7cwhkLNuXvBJXa201xpcbfgCUn83k0KuJDTwTA=;
 b=dH8M5t6AQdheCgW+ZjeT64oYXmXSOk26zy2dis9MriSL43KUs8exshkx4Hv8SqTJj5GKS9q1R
 TD6ZvxI9EdEAj53s/1coK2NEEg7opqVp+VcbghvzeUauHMSOk7OxsO9
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Add an helper function to set the direction. This is preliminary change
and will be useful for IIO backends that provide output buffers.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 12 ++++++++++++
 include/linux/iio/buffer.h        |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index b581a7e80566..504e5a96bd90 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1982,6 +1982,18 @@ void iio_buffer_put(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(iio_buffer_put);
 
+/**
+ * iio_buffer_set_dir() - Set the buffer direction
+ * @buffer: The buffer to set the direction
+ * @direction: The direction
+ */
+void iio_buffer_set_dir(struct iio_buffer *buffer,
+			enum iio_buffer_direction direction)
+{
+	buffer->direction = direction;
+}
+EXPORT_SYMBOL(iio_buffer_set_dir);
+
 /**
  * iio_device_attach_buffer - Attach a buffer to a IIO device
  * @indio_dev: The device the buffer should be attached to
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 418b1307d3f2..aee52b834443 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -55,4 +55,7 @@ bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 int iio_device_attach_buffer(struct iio_dev *indio_dev,
 			     struct iio_buffer *buffer);
 
+void iio_buffer_set_dir(struct iio_buffer *buffer,
+			enum iio_buffer_direction direction);
+
 #endif /* _IIO_BUFFER_GENERIC_H_ */

-- 
2.43.0


