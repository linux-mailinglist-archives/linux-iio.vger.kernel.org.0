Return-Path: <linux-iio+bounces-13106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B099E4980
	for <lists+linux-iio@lfdr.de>; Thu,  5 Dec 2024 00:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9867E2863A6
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 23:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213DD218AB2;
	Wed,  4 Dec 2024 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu8Fz/Bj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD4218AA8;
	Wed,  4 Dec 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355023; cv=none; b=Qg7uokoIuuSzyZ9VWPT7ILyJ45TCesHhBdyG7Z5HXI1tWgREDJt5u8OTZyzt5T/tfW5GbkJ4L2oiyuGQ5pO0snvCPdb22c7lZmDcwxATCGXCidspGYA8TCs0DnMSHOf/SiMUXI/6uCiYHvDEZtT9Xv319teRqNA2HWiO/eyGLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355023; c=relaxed/simple;
	bh=68fuuBcGvzm2xqyr9ivZhnAkGZ1ISqwo0hhdrc1bzjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSFI/CK9VS7ysa7lz2mn0F2/dolXcc26EIJk3kmZd3AySxKnAqbuXoNNWiMkCB9yIvMe3fumcx+JPJdpwhcFExZclrscHvztpBiZepwslxv8vfT7OBHjPcJ9r/wcsSw65Q67q4+jsEbS7yt2Qt1lEVdcOJOmx5qWNjY2Dr7L0pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu8Fz/Bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE54C4CECD;
	Wed,  4 Dec 2024 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355023;
	bh=68fuuBcGvzm2xqyr9ivZhnAkGZ1ISqwo0hhdrc1bzjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eu8Fz/BjOIlRp1ZrAPvhjCe6t3znINvDNqhYf79ZhjT7HcG7GTYNJ+3UxsAEfGYEa
	 lCkDJphtnA6jtruG/h/anlVddaWvQc5BdLIQsEBSK0ryWTxiEXelGkSfjrLZWt4a3B
	 qHFTUJmfyVg/Vb5UyGw4EPibBGfMEHiohhFLLlw2rdU+o+L3lTX2S4V9YXvmeYJ5fX
	 vjLh9j9d9zxQAj1RSIfC3Hm9zx6JkVEvAcdiUUg5XbHS+gk5pmJjt+BRSAv2e0YgCS
	 lc/VSeK5+L8M/c95GuN2dk1FDFaq9mInp4zR47PI7LDqucrfSKPCfU9f6tIloSmmJl
	 HgKa6R8qzTjSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/8] iio: light: ltr501: Add LTER0303 to the supported devices
Date: Wed,  4 Dec 2024 17:18:45 -0500
Message-ID: <20241204221859.2248634-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221859.2248634-1-sashal@kernel.org>
References: <20241204221859.2248634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c26acb09ccbef47d1fddaf0783c1392d0462122c ]

It has been found that the (non-vendor issued) ACPI ID for Lite-On
LTR303 is present in Microsoft catalog. Add it to the list of the
supported devices.

Link: https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303
Closes: https://lore.kernel.org/r/9cdda3e0-d56e-466f-911f-96ffd6f602c8@redhat.com
Reported-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20241024191200.229894-24-andriy.shevchenko@linux.intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/ltr501.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 74a1ccda8b9c4..49f293232a709 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1631,6 +1631,8 @@ static const struct acpi_device_id ltr_acpi_match[] = {
 	{ "LTER0501", ltr501 },
 	{ "LTER0559", ltr559 },
 	{ "LTER0301", ltr301 },
+	/* https://www.catalog.update.microsoft.com/Search.aspx?q=lter0303 */
+	{ "LTER0303", ltr303 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
-- 
2.43.0


